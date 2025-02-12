using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MailKit.Search;

namespace Electronics_Shop_17.Services.Interfaces
{
    public interface IBaseServiceSoftDelete<T, TSearch, TAdd, TUpdate> : IBaseServiceCRUD<T, TSearch, TAdd, TUpdate> where TSearch : class
    {
        Task<T> SoftDelete(int id);

    }
}
