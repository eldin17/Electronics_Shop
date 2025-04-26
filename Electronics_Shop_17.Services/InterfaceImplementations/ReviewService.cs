using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Helpers;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Database;
using Electronics_Shop_17.Services.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class ReviewService : BaseServiceCRUD<DtoReview, Review, SearchReview, AddReview, UpdateReview>, IReviewService
    {
        public ReviewService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override List<DtoReview> ImageIncludeForReviews(List<DtoReview> list)
        {
            var userAccounts = _context.UserAccounts.Include(x=>x.Image).ToList();
            foreach (var item in list) {
                var obj = userAccounts.FirstOrDefault(x => x.Id == item.Customer.UserAccountId);
                if (obj != null) { 
                    item.Image = obj.Image == null ? null: _mapper.Map<DtoImage>(obj.Image);
                }
            }
            list.OrderByDescending(x => x.Id);
            return base.ImageIncludeForReviews(list);
        }

        public override IQueryable<Review> AddInclude(IQueryable<Review> data)
        {
            //data = data.Include(x => x.Customer).ThenInclude(x => x.Person);
            data = data.Include(x => x.Customer)
               .ThenInclude(x => x.Person)
               .Select(x => new Review
               {
                   Id = x.Id,
                   Rating = x.Rating,
                   Comment = x.Comment,
                   CustomerId = x.CustomerId,
                   ProductId = x.ProductId,
                   Customer = new Customer
                   {
                       Id = x.Customer.Id,
                       Person = x.Customer.Person,
                       UserAccountId = x.Customer.UserAccountId                       
                   }
                   
               });
            return base.AddInclude(data);
        }

        public override IQueryable<Review> AddFilter(IQueryable<Review> data, SearchReview? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (search.Rating != null)
            {
                data = data.Where(x => x.Rating == search.Rating);
            }
            if (!string.IsNullOrWhiteSpace(search.Comment))
            {
                data = data.Where(x => x.Comment.Contains(search.Comment));
            }
            if (search.CustomerId != null)
            {
                data = data.Where(x => x.CustomerId == search.CustomerId);
            }
            if (search.ProductId != null)
            {
                data = data.Where(x => x.ProductId == search.ProductId);
            }
            return base.AddFilter(data, search);
        }
    }
}
