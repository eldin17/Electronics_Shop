using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Helpers;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Database;
using Electronics_Shop_17.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class UserAccountService : BaseService<DtoUserAccount,UserAccount,SearchUserAccount>, IUserAccountService
    {
        DataContext _context;
        IMapper _mapper;
        IConfiguration _configuration;

        public UserAccountService(DataContext context, IMapper mapper, IConfiguration configuration) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
            _configuration = configuration;
        }

        public override IQueryable<UserAccount> AddInclude(IQueryable<UserAccount> data)
        {
            data = data.Include(x => x.Customer).ThenInclude(x => x.Person).Include(x => x.Seller).ThenInclude(x => x.Person).Include(x => x.Role).Include(x => x.Image);
            return base.AddInclude(data);
        }


        public override IQueryable<UserAccount> AddFilter(IQueryable<UserAccount> data, SearchUserAccount? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (!string.IsNullOrWhiteSpace(search.Username))
            {
                data = data.Where(x => x.Username.Contains(search.Username));
            }
            if (!string.IsNullOrWhiteSpace(search.Email))
            {
                data = data.Where(x => x.Email.Contains(search.Email));
            }
            if (search.RegistrationDate != null)
            {
                data = data.Where(x => x.RegistrationDate == search.RegistrationDate);
            }
            if (search.isDeactivated != null)
            {
                data = data.Where(x => x.isDeactivated == search.isDeactivated);
            }
            return base.AddFilter(data, search);
        }
        public async Task<DtoUserAccount> Register(AddUserAccount obj)
        {
            CreatePasswordHash(obj.Password, out byte[] pwHash, out byte[] pwSalt);

            var novi = new UserAccount()
            {
                Username = obj.Username,
                Email = obj.Email,
                PasswordHash = pwHash,
                PasswordSalt = pwSalt,
                RegistrationDate = obj.RegistrationDate,
                RoleId = obj.RoleId,
                ImageId = obj.ImageId,
                isDeactivated = false,
            };

            _context.UserAccounts.Add(novi);
            await _context.SaveChangesAsync();

            var newDto = _mapper.Map<DtoUserAccount>(novi);

            return newDto;
        }

        private void CreatePasswordHash(string pw, out byte[] pwHash, out byte[] pwSalt)
        {
            using (var hmac = new HMACSHA512())
            {
                pwSalt = hmac.Key;
                pwHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(pw));
            }
        }
        public async Task<DtoLogin> Login(LoginRequest obj)
        {
            if (obj == null || string.IsNullOrWhiteSpace(obj.Username) || string.IsNullOrWhiteSpace(obj.Password))
            {
                throw new ArgumentException();
            }

            var dbObj = _context.UserAccounts.Include(x => x.Role).Include(x=>x.Customer).Include(x => x.Seller).SingleOrDefault(x => x.Username == obj.Username);            
            

            if (dbObj == null || !VerifyPasswordHash(obj.Password, dbObj.PasswordHash, dbObj.PasswordSalt) || dbObj.isDeactivated)
            {
                throw new UnauthorizedAccessException();
            }

            if (dbObj.Customer != null)            
                if(dbObj.Customer.isDeleted)
                    throw new UnauthorizedAccessException();

            if (dbObj.Seller != null)
                if (dbObj.Seller.isDeleted)
                    throw new UnauthorizedAccessException();

            string token = CreateToken(dbObj);

            return new DtoLogin
            {
                Token = token,
                UserId = dbObj.Id,
                RoleName = dbObj.Role.RoleName,
                isCustomer = dbObj.Customer != null,
                isSeller = dbObj.Seller != null,                
            }; 
        }

        private bool VerifyPasswordHash(string pw, byte[] pwHash, byte[] pwSalt)
        {
            using (var hmac = new HMACSHA512(pwSalt))
            {
                var computedHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(pw));
                return computedHash.SequenceEqual(pwHash);
            }
        }

        private string CreateToken(UserAccount user)
        {
            List<Claim> claims = new List<Claim>
            {
                new Claim(ClaimTypes.Name, user.Username),
                new Claim(ClaimTypes.Role, user.Role.RoleName)
            };

            var key = new SymmetricSecurityKey(System.Text.Encoding.UTF8.GetBytes(
                _configuration.GetSection("AppSettings:Token").Value));

            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha512Signature);

            var token = new JwtSecurityToken(
                claims: claims,
                expires: DateTime.Now.AddDays(1),
                signingCredentials: creds);

            var jwt = new JwtSecurityTokenHandler().WriteToken(token);

            return jwt;
        }

        public async Task<DtoUserAccount> Deactivate(int id)
        {
            var obj = await _context.UserAccounts.FindAsync(id);

            if (obj == null)            
                throw new KeyNotFoundException($"User with ID {id} not found.");
            

            if (obj.isDeactivated)            
                return _mapper.Map<DtoUserAccount>(obj); 
            

            obj.isDeactivated= true;

            await _context.SaveChangesAsync();

            return  _mapper.Map<DtoUserAccount>(obj);
        }

        public async Task<DtoUserAccount> Reactivate(int id)
        {
            var obj = await _context.UserAccounts.FindAsync(id);

            if (obj == null)
                throw new KeyNotFoundException($"User with ID {id} not found.");

            if (obj.isDeactivated)
                return _mapper.Map<DtoUserAccount>(obj);

            obj.isDeactivated = false;

            await _context.SaveChangesAsync();

            return _mapper.Map<DtoUserAccount>(obj);
        }
    }
}
