using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Helpers;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Database;
using Electronics_Shop_17.Services.Interfaces;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class ImageService : BaseService<DtoImage, Image, SearchImage>, IImageService
    {
        DataContext _context;
        public ImageService(DataContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
        }


        public override IQueryable<Image> AddFilter(IQueryable<Image> data, SearchImage? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (!string.IsNullOrWhiteSpace(search.Name))
            {
                data = data.Where(x => x.Name.Contains(search.Name));
            }
            if (search.ProductImageId != null)
            {
                data = data.Where(x => x.ProductImageId.Contains((int)search.ProductImageId));
            }
            if (search.UserAccountId != null)
            {
                data = data.Where(x => x.UserAccountId.Contains((int)search.UserAccountId));
            }
            return base.AddFilter(data, search);
        }

        public async Task<DtoProduct> AddMultipleImages(int id, [FromForm] ImgMultipleVM obj)
        {
            var product = await _context.Products.Include(x=>x.ProductImages).ThenInclude(x=>x.Image).FirstOrDefaultAsync(x=>x.Id== id);

            if (obj == null || obj.ProductColor == null || (product.StateMachine != "Draft" && product.StateMachine != "Active"))
                throw new ArgumentException("Invalid input!");
            
            
            if (product == null)
                throw new KeyNotFoundException($"Product with ID {id} not found!");


            using var transaction = await _context.Database.BeginTransactionAsync();
            try
            {                
                var oldProductImages = await _context.ProductImages
                    .Include(x => x.ProductColor)
                    .Include(x=>x.Image)                     
                    .Where(x => x.ProductId == id
                        && x.ProductColor.Name == obj.ProductColor.Name
                        && x.ProductColor.HexCode == obj.ProductColor.HexCode)
                    .ToListAsync();

                var existingColor = oldProductImages.FirstOrDefault()?.ProductColor;

                var oldImages = oldProductImages.Select(x => x.Image);

                if (oldProductImages.Any() && existingColor != null)
                {
                    _context.ProductImages.RemoveRange(oldProductImages);
                    _context.Images.RemoveRange(oldImages);
                    _context.ProductColors.Remove(existingColor);
                    await _context.SaveChangesAsync();
                }

                var newProductColor = _mapper.Map<ProductColor>(obj.ProductColor);                
                _context.ProductColors.Add(newProductColor);
                product.ProductColors.Add(newProductColor);
                await _context.SaveChangesAsync();

                foreach (var item in obj.vmImages)
                {
                    if (item == null || item.FileName == null || item.Length == 0)
                    {
                        throw new Exception("Wrong input!");
                    }

                    var path = Path.Combine(Config.ImagesProductsFolder, item.FileName);
                    await using (var stream = new FileStream(path, FileMode.Create))
                    {
                        await item.CopyToAsync(stream);
                    }

                    var newImage = new Image
                    {
                        Name = item.FileName,
                        Path = Config.ImagesProductsUrl + item.FileName,
                    };
                    _context.Images.Add(newImage);
                    await _context.SaveChangesAsync();

                    var newProductImage = new ProductImage
                    {
                        ProductId = id,
                        ImageId = newImage.Id,
                        ProductColorId = newProductColor.Id,
                    };
                    _context.ProductImages.Add(newProductImage);
                    await _context.SaveChangesAsync();
                }

                await transaction.CommitAsync();

                var returnProduct = await _context.Products.Include(x => x.ProductImages).ThenInclude(x => x.Image).FirstOrDefaultAsync(x => x.Id == id);

                return _mapper.Map<DtoProduct>(returnProduct);
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();
                throw new ApplicationException("An error occurred while adding images.", ex);
            }
        }

        public async Task<DtoUserAccount> AddSingleImage(int id, [FromForm] ImgSingleVM obj)
        {
            if (obj == null || obj.vmImage == null || obj.vmImage.FileName == null || obj.vmImage.Length == 0)
                throw new ArgumentException("Invalid input!");

            var userAccount = await _context.UserAccounts.Include(x=>x.Image).FirstOrDefaultAsync(x => x.Id == id);

            if (userAccount == null)
                throw new KeyNotFoundException($"Account with ID {id} not found!");
            try
            {
                if (userAccount.Image != null)
                {
                    var oldImagePath = Path.Combine(Config.ImagesUsersFolder, Path.GetFileName(userAccount.Image.Name));
                    if (System.IO.File.Exists(oldImagePath))
                    {
                        System.IO.File.Delete(oldImagePath);
                    }
                }

                var path = Path.Combine(Config.ImagesUsersFolder, obj.vmImage.FileName);
                await using (var stream = new FileStream(path, FileMode.Create))
                {
                    await obj.vmImage.CopyToAsync(stream);
                }

                var newImage = new Image
                {
                    Name = obj.vmImage.FileName,
                    Path = Config.ImagesUsersUrl + obj.vmImage.FileName,
                    UserAccountId = new List<int>() { userAccount.Id },
                };
                _context.Images.Add(newImage);
                await _context.SaveChangesAsync();

                userAccount.ImageId = newImage.Id;
                await _context.SaveChangesAsync();

                var returnUserAccount = await _context.UserAccounts.Include(x => x.Image).FirstOrDefaultAsync(x => x.Id == id);
                return _mapper.Map<DtoUserAccount>(returnUserAccount);
            }
            catch (Exception ex)
            {
                throw new ApplicationException("An error occurred while adding the image.", ex);
            }
        }
    }
}
