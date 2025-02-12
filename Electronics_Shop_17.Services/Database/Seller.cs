using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class Seller : IHelperId, ISoftDelete
    {
        public int Id { get; set; }
        public string StoreName { get; set; }
        public int LicenseNumber { get; set; }
        public int AdressId { get; set; }
        public virtual Adress Adress { get; set; }
        public int UserAccountId { get; set; }
        public virtual UserAccount UserAccount { get; set; }
        public int PersonId { get; set; }
        public virtual Person Person { get; set; }
        public bool isDeleted { get; set; }

    }
}
