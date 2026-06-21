using System.Security.Claims;
using System.Threading.Tasks;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Helpers;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.InterfaceImplementations;
using Electronics_Shop_17.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Electronics_Shop_17.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserAccountController : BaseCRUDController<DtoUserAccount, SearchUserAccount, AddUserAcc, UpdateUserAcc>
    {
        public UserAccountController(IUserAccountService service) : base(service)
        {
        }

        [HttpPost("register"), AllowAnonymous]
        public async Task<DtoUserAccount> Register(AddUserAccount obj)
        {
            return await (_service as IUserAccountService).Register(obj);
        }

        [HttpPost("login"), AllowAnonymous]
        public async Task<ActionResult<DtoLogin>> Login(LoginRequest obj)
        {
            var result = await (_service as IUserAccountService).Login(obj);
            return Ok(result);
        }

        [HttpPut("deactivate/{id}")]
        public async Task<ActionResult<DtoUserAccount>> Deactivate(int id)
        {
            var result = await (_service as IUserAccountService).Deactivate(id);
            return Ok(result);
        }

        [HttpPut("reactivate/{id}")]
        public async Task<ActionResult<DtoUserAccount>> Reactivate(int id)
        {
            var result = await (_service as IUserAccountService).Reactivate(id);
            return Ok(result);
        }

        [HttpPut("resetPW")]
        public async Task<ActionResult<DtoUserAccount>> ResetPW(ResetPW obj)
        {
            var result = await (_service as IUserAccountService).ResetPW(obj);
            return Ok(result);
        }

        [HttpPost("logout")]
        [Authorize]
        public async Task<IActionResult> Logout()
        {
            await (_service as IUserAccountService).Logout();
            return Ok(new { message = "Logged out successfully" });
        }

        [HttpPost("refresh")]
        [AllowAnonymous]
        public async Task<IActionResult> Refresh([FromBody] RefreshRequest? input)
        {
            var (accessToken, refreshToken) = await (_service as IUserAccountService).Refresh(input);
            return Ok(new { AccessToken = accessToken, RefreshToken = refreshToken });
        }
    }
}