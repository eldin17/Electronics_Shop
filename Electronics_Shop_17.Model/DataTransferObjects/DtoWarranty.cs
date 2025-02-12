using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.DataTransferObjects
{
    public class DtoWarranty
    {
        public int Id { get; set; }
        public int Period_mm { get; set; }
        public string CoverageDetails { get; set; }
        //public virtual DtoProduct Product { get; set; }
    }
}
