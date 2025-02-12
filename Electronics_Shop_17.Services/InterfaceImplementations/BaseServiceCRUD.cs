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
    public class BaseServiceCRUD<T, TDb, TSearch, TAdd, TUpdate> : BaseService<T, TDb, TSearch>, IBaseServiceCRUD<T, TSearch, TAdd, TUpdate> where TSearch : BaseSearch where TDb : class, IHelperId
    {
        public BaseServiceCRUD(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public virtual async Task<T> Add(TAdd addRequest)
        {
            var obj = _mapper.Map<TDb>(addRequest);

            _context.Set<TDb>().Add(obj);

            await _context.SaveChangesAsync();

            SendMail();

            return _mapper.Map<T>(obj);
        }

        public virtual async Task<T> Delete(int id)
        {
            var dbObj = await _context.Set<TDb>().FindAsync(id);

            _context.Set<TDb>().Remove(dbObj);

            await _context.SaveChangesAsync();
            return _mapper.Map<T>(dbObj);
        }

        public virtual void SendMail()
        {
            return;
        }

        public virtual async Task<T> Update(int id, TUpdate updateRequest)
        {
            var dbObj = await _context.Set<TDb>().FindAsync(id);

            _mapper.Map(updateRequest, dbObj);

            await _context.SaveChangesAsync();
            return _mapper.Map<T>(dbObj);
        }
    }
}
