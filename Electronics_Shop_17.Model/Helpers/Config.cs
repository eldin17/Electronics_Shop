using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Helpers
{
    public class Config
    {
        public static string url = "http://localhost:5116/";

        public static string ImagesProducts => "ImagesProducts/";
        public static string ImagesProductsUrl => url + ImagesProducts;
        public static string ImagesProductsFolder => "wwwroot/" + ImagesProducts;
        //------------------------------------------------------------------------------
        public static string ImagesUsers => "ImagesUsers/";
        public static string ImagesUsersUrl => url + ImagesUsers;
        public static string ImagesUsersFolder => "wwwroot/" + ImagesUsers;
    }
}
