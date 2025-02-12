using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Helpers;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Database;
using Electronics_Shop_17.Services.InterfaceImplementations;
using Microsoft.AspNetCore.Mvc;

namespace Electronics_Shop_17.Services.Interfaces
{
    public interface IUserAccountService : IBaseService<DtoUserAccount, SearchUserAccount> 
    {
        Task<DtoUserAccount> Register(AddUserAccount obj);
        Task<DtoLogin> Login(LoginRequest obj);
        Task<DtoUserAccount> Deactivate(int id);
        Task<DtoUserAccount> Reactivate(int id);
    }
}
