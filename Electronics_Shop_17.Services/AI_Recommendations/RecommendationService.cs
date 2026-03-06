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

    public class RecommendationService : IRecommendationService
    {
        private readonly DataContext _context;
        private readonly IMapper _mapper;
        private static ITransformer _model = null;
        private static MLContext _mlContext = new MLContext();
        private static readonly object _lock = new object();
        private readonly string _modelPath = Path.Combine(Environment.CurrentDirectory, "Data", "recommendation_model.zip");

        public RecommendationService(DataContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public List<DtoProduct> GetRecommendations(int productId, int take = 3)
        {
            var recommendations = new List<Product>();

            
            LazyLoadModel();

            if (_model != null)
            {
                recommendations = GetAiResults(productId, take);
            }

            
            if (recommendations.Count < take)
            {
                var existingIds = recommendations.Select(r => r.Id).ToList();
                existingIds.Add(productId);

                var product = _context.Products.Find(productId);
                if (product != null)
                {
                    
                    var fallbacks = _context.Products
                        .Where(p => p.ProductCategoryId == product.ProductCategoryId
                                 && !existingIds.Contains(p.Id)
                                 && p.StateMachine != "Deleted")
                        .Select(p => new {
                            Product = p,                            
                            AverageRating = p.Reviews.Any() ? p.Reviews.Average(r => r.Rating) : 0,
                            ReviewCount = p.Reviews.Count()
                        })                        
                        .OrderByDescending(x => x.AverageRating)
                        .ThenByDescending(x => x.ReviewCount)
                        .Take(take - recommendations.Count)
                        .ToList();

                    recommendations.AddRange(fallbacks.Select(x => x.Product));
                }
            }

            return _mapper.Map<List<DtoProduct>>(recommendations);
        }

        private List<Product> GetAiResults(int productId, int take)
        {
            var predictionEngine = _mlContext.Model.CreatePredictionEngine<ProductEntry, ProductPrediction>(_model);

            var allProducts = _context.Products
                .Where(p => p.Id != productId && p.StateMachine != "Deleted")
                .ToList();

            var scores = new List<(Product Product, float Score)>();

            foreach (var p in allProducts)
            {
                var prediction = predictionEngine.Predict(new ProductEntry
                {
                    ProductID = (uint)productId,
                    CoPurchaseProductID = (uint)p.Id
                });
                
                if (prediction.Score > 0.1)
                {
                    scores.Add((p, prediction.Score));
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
        }

        public void TrainModel()
        {
            lock (_lock)
            {
                var orders = _context.Orders
                    .Include(o => o.OrderItems)
                    .Where(o => o.OrderItems.Count > 1)
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
                    Alpha = 0.01,
                    Lambda = 0.025,
                    NumberOfIterations = 50
                };

                var est = _mlContext.Recommendation().Trainers.MatrixFactorization(options);
                _model = est.Fit(trainData);

                
                Directory.CreateDirectory(Path.GetDirectoryName(_modelPath));
                _mlContext.Model.Save(_model, trainData.Schema, _modelPath);
            }
        }
    }
}