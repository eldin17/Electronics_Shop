using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.DataTransferObjects
{
    public class DtoSeller
    {
        public int Id { get; set; }
        public string StoreName { get; set; }
        public int LicenseNumber { get; set; }
        public virtual DtoAdress Adress { get; set; }
        public virtual DtoUserAccount UserAccount { get; set; }

        public virtual DtoPerson Person { get; set; }
        public bool isDeleted { get; set; }
    }
}
