using DTO;
using DTO.DTOWebUser;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace WebApiBI.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class WebUserController : BaseController
    {
        [AllowAnonymous]
        [HttpPost]
        public IActionResult AddWebUser(DTO_WebUser model)
        {
            DataResult ds = webUserBaseService.addWebUser(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public IActionResult UpdateWebUser(DTO_WebUser model)
        {
            DataResult ds = webUserBaseService.updateWebUser(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public IActionResult UpdateWebUserAvatar(DTO_WebUser model)
        {
            DataResult ds = webUserBaseService.updateWebUserAvatar(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public IActionResult UpdateWebUserPWD(DTO_WebUser model)
        {
            DataResult ds = webUserBaseService.updateWebUserPWD(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public IActionResult GetUserById(DTO_Id model)
        {
            DataResult ds = webUserBaseService.getUserById(model);
            return Json(ds);
        }

    }
}
