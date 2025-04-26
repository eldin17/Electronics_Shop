using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.Helpers;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Database;
using Electronics_Shop_17.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class BaseService<T, TDb, TSearch> : IBaseService<T, TSearch> where TSearch : BaseSearch where TDb : class, IHelperId
    {
        protected DataContext _context;
        protected IMapper _mapper;
        public BaseService(DataContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public virtual async Task<Pagination<T>> GetAll(TSearch? search = null)
        {
            var data = _context.Set<TDb>().AsQueryable();

            data = AddFilter(data, search);
            data = AddInclude(data);

            var totalItems = await data.CountAsync();

            if (search?.PageNumber.HasValue == true && search?.ItemsPerPage.HasValue == true)
            {
                data = data
                    .Skip((search.PageNumber.Value - 1) * search.ItemsPerPage.Value)
                    .Take(search.ItemsPerPage.Value);
            }

            var tolist = await data.ToListAsync();
            var list = _mapper.Map<List<T>>(tolist);

            list = ImageIncludeForReviews(list);

            return new Pagination<T>(list, totalItems);
        }

        public virtual List<T> ImageIncludeForReviews(List<T> list)
        {
            return list;
        }

        public virtual IQueryable<TDb> AddInclude(IQueryable<TDb> data)
        {
            return data;
        }

        public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> data, TSearch? search)
        {
            return data;
        }

        public virtual async Task<T> GetById(int id)
        {
            var data = _context.Set<TDb>().Where(x=>x.Id==id).AsQueryable();

            if (!data.Any())                
                throw new KeyNotFoundException($"No record found with Id: {id}");
            
            data = AddInclude(data);
    
            data = AddInclude2(data, id);
    
            var entity = await data.FirstOrDefaultAsync();
            return _mapper.Map<T>(entity);            
        }

        public virtual IQueryable<TDb> AddInclude2(IQueryable<TDb> data, int id)
        {
            return data;
        }
    }
}
