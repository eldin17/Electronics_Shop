using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
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

        public override IQueryable<Review> AddInclude(IQueryable<Review> data)
        {
            data = data.Include(x => x.Customer).ThenInclude(x => x.Person);
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
