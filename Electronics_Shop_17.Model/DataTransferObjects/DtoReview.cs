using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.DataTransferObjects
{
    public class DtoReview
    {
        public int Id { get; set; }
        public int Rating { get; set; }
        public string Comment { get; set; }
        public virtual DtoCustomer Customer { get; set; }
        public int ProductId { get; set; }
        public virtual DtoImage Image { get; set; }

    }
}
