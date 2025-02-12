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
    public class PersonService : BaseServiceCRUD<DtoPerson, Person, SearchPerson, AddPerson, UpdatePerson>, IPersonService
    {
        public PersonService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<Person> AddFilter(IQueryable<Person> data, SearchPerson? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (!string.IsNullOrWhiteSpace(search.FirstName))
            {
                data = data.Where(x => x.FirstName.Contains(search.FirstName));
            }
            if (!string.IsNullOrWhiteSpace(search.LastName))
            {
                data = data.Where(x => x.LastName.Contains(search.LastName));
            }
            if (search.DateOfBirth != null)
            {
                data = data.Where(x => x.DateOfBirth == search.DateOfBirth);
            }
            return base.AddFilter(data, search);
        }
    }
}
