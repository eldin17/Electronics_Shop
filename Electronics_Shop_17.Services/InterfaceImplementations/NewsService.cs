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

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class NewsService : BaseServiceCRUD<DtoNews, News, SearchNews, AddNews, UpdateNews>, INewsService
    {
        public NewsService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<News> AddFilter(IQueryable<News> data, SearchNews? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (!string.IsNullOrWhiteSpace(search.Title))
            {
                data = data.Where(x => x.Title.Contains(search.Title));
            }
            if (!string.IsNullOrWhiteSpace(search.Content))
            {
                data = data.Where(x => x.Content.Contains(search.Content));
            }
            if (search.DatePublished != null)
            {
                data = data.Where(x => x.DatePublished == search.DatePublished);
            }
            return base.AddFilter(data, search);
        }
    }
}
