using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.SearchObjects
{
    public class SearchAccessoryProperty : BaseSearch
    {
        public int? Id { get; set; }
        public string? PropertyName { get; set; }   
        public int? AccessoryId { get; set; }

    }
}
