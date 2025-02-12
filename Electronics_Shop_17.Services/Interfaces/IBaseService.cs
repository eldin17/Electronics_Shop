using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Electronics_Shop_17.Model.Helpers;

namespace Electronics_Shop_17.Services.Interfaces
{
    public interface IBaseService<T, TSearch> where TSearch : class
    {
        Task<Pagination<T>> GetAll(TSearch search = null);
        Task<T> GetById(int id);
    }
}
