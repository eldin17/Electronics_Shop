using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.SearchObjects
{
    public class SearchCustomer : BaseSearch
    {
        public int? Id { get; set; }
        public int? LoyaltyPoints { get; set; }
        public int? MinLoyaltyPoints { get; set; }

        public int? UserAccountId { get; set; }
        public int? PersonId { get; set; }
    }
}
