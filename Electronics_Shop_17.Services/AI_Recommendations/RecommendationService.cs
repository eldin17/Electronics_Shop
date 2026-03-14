using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.AI_Recommendations
{
    using Microsoft.ML;
    using Microsoft.ML.Data;
    using Microsoft.EntityFrameworkCore;
    using AutoMapper;
    using Electronics_Shop_17.Model.DataTransferObjects;
    using Electronics_Shop_17.Services.Database;
    using Microsoft.ML.Trainers;    
    using Product = Database.Product;
    using Castle.Core.Resource;

    public class RecommendationService : IRecommendationService
    {
        private readonly DataContext _context;
        private readonly IMapper _mapper;
        private static ITransformer _model = null;
        private static MLContext _mlContext = new MLContext();
        private static readonly object _lock = new object();
        private readonly string _modelPath = Path.Combine(Environment.CurrentDirectory, "Data", "recommendation_model.zip");
        Checks _checks;
        public RecommendationService(DataContext context, IMapper mapper, Checks checks)
        {
            _context = context;
            _mapper = mapper;
            _checks = checks;
        }

        public async Task<List<DtoProduct>> GetRecommendations(int customerId, int productId, int take = 3)
        {
            var recommendations = new List<DtoProduct>();

            
            LazyLoadModel();

            if (_model != null)
            {
                recommendations = await GetAiResults(customerId, productId, take);                
            }

            
            if (recommendations.Count < take)
            {
                Console.WriteLine("FALLBACK FALLBACK FALLBACK");

                var existingIds = recommendations.Select(r => r.Id).ToList();
                existingIds.Add(productId);

                var product = _context.Products.Find(productId);
                if (product != null)
                {

                    var excludeIds = recommendations.Select(r => r.Id).ToList();
                    excludeIds.Add(productId);

                    var fallbacks = await _context.Products
                        .Where(p => p.ProductCategoryId == product.ProductCategoryId
                                 && !excludeIds.Contains(p.Id) 
                                 && p.StateMachine != "Deleted")     
                        .OrderBy(x => Guid.NewGuid())
                        .Take(take - recommendations.Count)
                        .ToListAsync();

                    var dtoFallbacks = _mapper.Map<List<DtoProduct>>(fallbacks);

                    var wishlistSet = (await _context.Customers
                        .Where(x => x.Id == customerId)
                        .SelectMany(x => x.Wishlist.WishlistItems)
                        .Select(x => x.ProductId)
                        .ToListAsync()).ToHashSet();

                    foreach (var item in dtoFallbacks)
                    {
                        var priceCheckedObj = await _checks.PriceCheck(item);
                        item.FinalPrice = priceCheckedObj.FinalPrice;
                        item.reviewScoreAvg = await _checks.ReviewCheck(item);
                        item.isFavourite = wishlistSet.Contains(item.Id);
                    }

                    recommendations.AddRange(dtoFallbacks);
                }
            }

            return recommendations;
        }

        private async Task<List<DtoProduct>> GetAiResults(int customerId, int productId, int take)
        {
            Console.WriteLine("AI AI AI");

            var predictionEngine = _mlContext.Model.CreatePredictionEngine<ProductEntry, ProductPrediction>(_model);

            var allProducts = await _context.Products
                .Where(p => p.Id != productId && p.StateMachine != "Deleted")
                .ToListAsync();

            var wishlistSet = (await _context.Customers
                .Where(x => x.Id == customerId)
                .SelectMany(x => x.Wishlist.WishlistItems)
                .Select(x => x.ProductId)
                .ToListAsync()).ToHashSet();

            var scores = new List<(DtoProduct Product, float Score)>();

            foreach (var p in allProducts)
            {
                if ((int)p.Id == (int)productId)
                {
                    Console.WriteLine($"SKIPPING SELF: {p.Id} matches {productId}");
                    continue;
                }

                var prediction = predictionEngine.Predict(new ProductEntry
                {
                    ProductID = (uint)productId,
                    CoPurchaseProductID = (uint)p.Id
                });


                if (prediction.Score > 0.4)
                {
                    Console.WriteLine($"AI MATCH: {p.Model} (ID: {p.Id}) Score: {prediction.Score}");
                    
                
                    var dtoP = _mapper.Map<DtoProduct>(p);
                    
                    var priceCheckedObj = await _checks.PriceCheck(dtoP);
                    dtoP.FinalPrice = priceCheckedObj.FinalPrice;

                    dtoP.reviewScoreAvg = await _checks.ReviewCheck(dtoP);

                    dtoP.isFavourite = wishlistSet.Any() && wishlistSet.Contains(dtoP.Id);

                    scores.Add((dtoP, prediction.Score));
                }
            }

            return scores.OrderByDescending(x => x.Score)
                         .Select(x => x.Product)
                         .Take(take)
                         .ToList();
        }

        private void LazyLoadModel()
        {
            if (_model != null) return;

            lock (_lock)
            {
                if (_model != null) return;
                if (File.Exists(_modelPath))
                {
                    _model = _mlContext.Model.Load(_modelPath, out _);
                }
            }
            Console.WriteLine("LAZY LAZY LAZY");
        }

        public void TrainModel()
        {
            lock (_lock)
            {                
                var orders = _context.Orders
                    .Include(o => o.OrderItems)
                    .Where(o => o.OrderItems.Count > 1 && o.StateMachine=="Completed" && !o.isDeleted)
                    .ToList();

                var data = new List<ProductEntry>();
                foreach (var order in orders)
                {
                    var itemIds = order.OrderItems.Select(x => (uint)x.ProductId).ToList();
                    foreach (var id1 in itemIds)
                    {
                        foreach (var id2 in itemIds)
                        {
                            if (id1 == id2) continue;
                            data.Add(new ProductEntry { ProductID = id1, CoPurchaseProductID = id2, Label = 1 });
                        }
                    }
                }

                if (data.Count == 0) return; 

                var trainData = _mlContext.Data.LoadFromEnumerable(data);

                var options = new MatrixFactorizationTrainer.Options
                {
                    MatrixColumnIndexColumnName = nameof(ProductEntry.ProductID),
                    MatrixRowIndexColumnName = nameof(ProductEntry.CoPurchaseProductID),
                    LabelColumnName = "Label",
                    LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass,
                    Alpha = 0.05,
                    Lambda = 0.01,
                    NumberOfIterations = 100,                    
                };

                var est = _mlContext.Recommendation().Trainers.MatrixFactorization(options);
                _model = est.Fit(trainData);

                
                Directory.CreateDirectory(Path.GetDirectoryName(_modelPath));
                _mlContext.Model.Save(_model, trainData.Schema, _modelPath);
            }
        }
    }
}