using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;

namespace Electronics_Shop_17.Model.SearchObjects
{
    public class SearchUserAccount : BaseSearch
    {
        public int? Id { get; set; }
        public string? Username { get; set; }
        public string? Email { get; set; }
        
        public DateTime? RegistrationDate { get; set; }
        public bool? isDeactivated { get; set; }
    }
}
