using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Electronics_Shop_17.Model.Requests;
using Microsoft.AspNetCore.Http;

namespace Electronics_Shop_17.Model.Helpers
{
    public class ImgMultipleVM
    {
        public List<IFormFile> vmImages { set; get; }
        public AddProductColor ProductColor { get; set; }
    }
}
