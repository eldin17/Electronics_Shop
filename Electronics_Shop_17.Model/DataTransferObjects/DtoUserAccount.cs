using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Castle.Core.Resource;

namespace Electronics_Shop_17.Model.DataTransferObjects
{
    public class DtoUserAccount
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }        
        public DateTime RegistrationDate { get; set; }
        public virtual DtoCustomer? Customer { get; set; }
        public virtual DtoSeller? Seller { get; set; }

        public virtual DtoRole Role { get; set; }

        public virtual DtoImage Image { get; set; }
        public bool isDeactivated { get; set; }

    }
}
