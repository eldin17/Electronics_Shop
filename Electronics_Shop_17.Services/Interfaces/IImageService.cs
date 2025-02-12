using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Helpers;
using Electronics_Shop_17.Model.SearchObjects;
using Microsoft.AspNetCore.Mvc;

namespace Electronics_Shop_17.Services.Interfaces
{
    public interface IImageService : IBaseService<DtoImage,SearchImage>
    {
        Task<DtoProduct> AddMultipleImages(int id, [FromForm] ImgMultipleVM obj);
        Task<DtoUserAccount> AddSingleImage(int id, [FromForm] ImgSingleVM obj);


    }
}
