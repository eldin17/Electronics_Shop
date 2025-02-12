using System.Threading.Tasks;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Helpers;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Electronics_Shop_17.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserAccountController : BaseController<DtoUserAccount, SearchUserAccount>
    {
        public UserAccountController(IUserAccountService service) : base(service)
        {
        }

        [HttpPost("register"),AllowAnonymous]
        public async Task<DtoUserAccount> Register(AddUserAccount obj) 
        {
            return await (_service as IUserAccountService).Register(obj);
        }

        [HttpPost("login"), AllowAnonymous]
        public async Task<ActionResult<DtoLogin>> Login(LoginRequest obj)
        {

            try
            {
                var result = await (_service as IUserAccountService).Login(obj);
                return Ok(result);
            }
            catch (ArgumentException ex)
            {
                return BadRequest($"{ex.Message}"); 
            }
            catch (UnauthorizedAccessException ex)
            {
                return Unauthorized($"{ex.Message}"); 
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }

        [HttpPut("deactivate/{id}")]
        public async Task<ActionResult<DtoUserAccount>> Deactivate(int id)
        {
            try
            {
                var result = await (_service as IUserAccountService).Deactivate(id);
                return Ok(result); 
            }
            catch (KeyNotFoundException)
            {
                return NotFound($"User with ID {id} not found.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }

        [HttpPut("reactivate/{id}")]
        public async Task<ActionResult<DtoUserAccount>> Reactivate(int id)
        {
            try
            {
                var result = await (_service as IUserAccountService).Reactivate(id);
                return Ok(result);
            }
            catch (KeyNotFoundException)
            {
                return NotFound($"User with ID {id} not found.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }

    }
}
