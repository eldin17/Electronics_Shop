using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Model.SearchObjects;

namespace Electronics_Shop_17.Services.Interfaces
{
    public interface IProductService : IBaseServiceSoftDelete<DtoProduct,SearchProduct,AddProduct,UpdateProduct>
    {
        Task<DtoProduct> Activate(int id);
        Task<DtoProduct> CheckStock(int id);
        Task<DtoProduct> Restock(int id);
        Task<DtoProduct> Restore(int id);
    }
}
