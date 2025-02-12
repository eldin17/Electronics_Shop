using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.SearchObjects
{
    public class SearchSeller : BaseSearch
    {
        public int? Id { get; set; }
        public string? StoreName { get; set; }
        public int? LicenseNumber { get; set; }
        public int? AdressId { get; set; }
        public int? UserAccountId { get; set; }
        public int? PersonId { get; set; }
        public bool? isDeleted { get; set; }

    }
}
