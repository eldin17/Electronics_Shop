using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class UserAccount : IHelperId
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }
        public byte[] PasswordHash { get; set; }
        public byte[] PasswordSalt { get; set; }
        public DateTime RegistrationDate { get; set; }

        public virtual Customer? Customer { get; set; }
        public virtual Seller? Seller { get; set; }


        public int RoleId { get; set; }
        public virtual Role Role { get; set; }

        public int? ImageId { get; set; }
        public virtual Image? Image { get; set; }

        public bool isDeactivated { get; set; }
    }
}
