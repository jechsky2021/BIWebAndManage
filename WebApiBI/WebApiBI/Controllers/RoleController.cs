using DTO;
using DTO.DTOMenu;
using DTO.DTORole;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Threading.Tasks;

namespace WebApiBI.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class RoleController : BaseController
    {
        [HttpPost]
        public async Task<IActionResult> GetByPage(DTO_Role dTO_Role)
        {
            DataResult ds = roleBaseService.getByPage(dTO_Role);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult GetMenuByRoleId(DTO_Id dTO_Id)
        {
            DataResult ds = roleBaseService.getMenuByRoleId(dTO_Id);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult AddRole(DTO_Role dTO_Role)
        {
            DataResult ds = roleBaseService.addRole(dTO_Role);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public IActionResult UpdateRole(DTO_Role dTO_Role)
        {
            DataResult ds = roleBaseService.updateRole(dTO_Role);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public IActionResult DeleteRoleById(DTO_Id dTO_Id)
        {
            DataResult ds = roleBaseService.deleteRoleById(dTO_Id);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public IActionResult AssignMenus(DTO_RoleIdMenuIds dTO_RoleIdMenuIds)
        {
            DataResult ds = roleBaseService.assignMenus(dTO_RoleIdMenuIds);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

    }
}
