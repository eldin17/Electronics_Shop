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
    public class RoleService : BaseServiceSoftDelete<DtoRole, Role, SearchRole, AddRole, UpdateRole>, IRoleService
    {
        public RoleService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Role> AddFilter(IQueryable<Role> data, SearchRole? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (!string.IsNullOrWhiteSpace(search.RoleName))
            {
                data = data.Where(x => x.RoleName.Contains(search.RoleName));
            }
            return base.AddFilter(data, search);
        }
    }
}
