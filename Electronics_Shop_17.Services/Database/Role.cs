using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class Role : IHelperId, ISoftDelete
    {
        public int Id { get; set; }
        public string RoleName { get; set; }
        public virtual List<UserAccount> UserAccounts { get; set; }
        public bool isDeleted { get; set; }

    }
}
