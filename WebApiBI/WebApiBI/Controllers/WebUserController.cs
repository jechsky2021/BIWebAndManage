using DTO;
using DTO.DTORole;
using DTO.DTOUser;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using ProfessionalLogic.users;

namespace WebApiBI.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class WebUserController : BaseController
    {
        [AllowAnonymous]
        [HttpPost]
        public IActionResult AddUser(DTO_User model)
        {
            DataResult ds = userBaseService.addUser(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public IActionResult UpdateWebUser(DTO_User model)
        {
            DataResult ds = webUserBaseService.updateWebUser(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public IActionResult UpdateWebUserAvatar(DTO_User model)
        {
            DataResult ds = webUserBaseService.updateWebUserAvatar(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public IActionResult UpdateWebUserPWD(DTO_User model)
        {
            DataResult ds = webUserBaseService.updateWebUserPWD(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public IActionResult GetUserById(DTO_Id model)
        {
            DataResult ds = webUserBaseService.getUserById(model);
            ds.data = JsonConvert.DeserializeObject<List<DTO_User>>(ds.data.ToString() ?? "") ?? new List<DTO_User>();
            return Json(ds);
        }

    }
}
