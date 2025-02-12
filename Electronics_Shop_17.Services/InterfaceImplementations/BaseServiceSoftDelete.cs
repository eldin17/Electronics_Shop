using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Database;
using Electronics_Shop_17.Services.Interfaces;

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class BaseServiceSoftDelete<T, TDb, TSearch, TAdd, TUpdate> : BaseServiceCRUD<T, TDb, TSearch, TAdd, TUpdate>,IBaseServiceSoftDelete<T, TSearch, TAdd, TUpdate> where TSearch : BaseSearch where TDb : class, IHelperId
    {    
        public BaseServiceSoftDelete(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public virtual async Task<T> SoftDelete(int id)
        {
            var dbObj = await _context.Set<TDb>().FindAsync(id);

            if (dbObj == null)
            {
                throw new Exception("Entity not found.");
            }

            if (dbObj is ISoftDelete obj)
            {
                obj.isDeleted = true;
                await _context.SaveChangesAsync();
            }
            else throw new Exception("Soft delete not supported");

            return _mapper.Map<T>(dbObj);
        }
    }
}
