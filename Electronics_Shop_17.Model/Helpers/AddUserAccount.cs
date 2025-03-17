using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;

namespace Electronics_Shop_17.Model.Helpers
{
    public class AddUserAccount
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Required field -Username-")]
        [MinLength(3, ErrorMessage = "Min lenght of username is 3 characters")]
        [MaxLength(20, ErrorMessage = "Max lenght of username is 20 characters")]
        public string Username { get; set; }
        [Required(AllowEmptyStrings = false, ErrorMessage = "Required field -Email-")]
        [EmailAddress(ErrorMessage = "Invalid field -Email-")]
        public string Email { get; set; }
        [Required(AllowEmptyStrings = false, ErrorMessage = "Required field -Password-")]
        [MinLength(3, ErrorMessage = "Min lenght of password is 3 characters")]
        [MaxLength(20, ErrorMessage = "Max lenght of password is 20 characters")]
        public string Password { get; set; }
        public DateTime RegistrationDate { get; set; } = DateTime.UtcNow;

        [Required(ErrorMessage = "Required field -UlogaId-")]
        public int RoleId { get; set; }

        public int? ImageId { get; set; }//postaviti neku defaultnu na id 1
        public bool isDeactivated { get; set; } = false;

    }
}
