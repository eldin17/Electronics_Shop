using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Requests
{
    public class UpdateSeller
    {
        public string? StoreName { get; set; }
        public int? LicenseNumber { get; set; }
        public virtual UpdateAdress? Adress { get; set; }
        public int? UserAccountId { get; set; }
        public int? PersonId { get; set; }
        public bool? isDeleted { get; set; }

    }
}
