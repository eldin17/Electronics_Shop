using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Requests
{
    public class AddSeller
    {
        public string StoreName { get; set; }
        public int LicenseNumber { get; set; }
        public int AdressId { get; set; }
        public int UserAccountId { get; set; }
        public int PersonId { get; set; }
        public bool isDeleted { get; set; } = false;

    }
}
