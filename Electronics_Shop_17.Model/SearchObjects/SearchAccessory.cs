using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Electronics_Shop_17.Model.Helpers;

namespace Electronics_Shop_17.Model.SearchObjects
{
    public class SearchAccessory : BaseSearch
    {
        public int? Id { get; set; }
        public string? Name { get; set; }
        public string? Description { get; set; }        

        public int? AccessoryCategoryId { get; set; }       

    }
}
