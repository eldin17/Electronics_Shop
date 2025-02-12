using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class Adress : IHelperId, ISoftDelete
    {
        public int Id { get; set; }
        public string Street { get; set; }
        public string City { get; set; }
        public string Country { get; set; }
        public string PostalCode { get; set; }

        public int PersonId { get; set; }
        public virtual List<Order> Orders { get; set; }
        public bool isDeleted { get; set; }

    }
}
