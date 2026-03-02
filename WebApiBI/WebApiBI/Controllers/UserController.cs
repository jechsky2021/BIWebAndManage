using DTO;
using DTO.DTORole;
using DTO.DTOUser;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace WebApiBI.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class UserController : BaseController
    {
        [HttpPost]
        public IActionResult GetByPage(DTO_User model)
        {
            DataResult ds = userBaseService.getByPage(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult GetRolesByUid(DTO_Id model)
        {
            DataResult ds = userBaseService.getRolesByUid(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult AddUser(DTO_User model)
        {
            DataResult ds = userBaseService.addUser(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public IActionResult UpdateUser(DTO_User model)
        {
            DataResult ds = userBaseService.updateUser(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public IActionResult UpdatePWD(DTO_User model)
        {
            DataResult ds = userBaseService.updatePWD(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public IActionResult AssignRoleIds(DTO_UidRoleIds model)
        {
            DataResult ds = userBaseService.assignRoles(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

    }
}
