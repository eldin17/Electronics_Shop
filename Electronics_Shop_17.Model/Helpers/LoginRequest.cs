using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Helpers
{
    public class LoginRequest
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Required field -Username-")]
        [MinLength(3, ErrorMessage = "Min lenght of username is 3 characters")]
        [MaxLength(20, ErrorMessage = "Max lenght of username is 20 characters")]
        public string Username { get; set; } = string.Empty;
        [Required(AllowEmptyStrings = false, ErrorMessage = "Required field -Password-")]
        [MinLength(3, ErrorMessage = "Min lenght of password is 3 characters")]
        [MaxLength(20, ErrorMessage = "Max lenght of password is 20 characters")]
        public string Password { get; set; } = string.Empty;
    }
}

