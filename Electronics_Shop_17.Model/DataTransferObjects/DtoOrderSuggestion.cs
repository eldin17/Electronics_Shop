using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.DataTransferObjects
{
    public class DtoOrderSuggestion
    {
        public DtoOrder oldOrder { get; set; }
        public DtoOrder newOrder { get; set; }
    }
}
