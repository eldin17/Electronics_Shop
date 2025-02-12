using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.DataTransferObjects
{
    public class DtoRole
    {
        public int Id { get; set; }
        public string RoleName { get; set; }
        public virtual List<DtoUserAccount> UserAccounts { get; set; }
        public bool isDeleted { get; set; }

    }
}
