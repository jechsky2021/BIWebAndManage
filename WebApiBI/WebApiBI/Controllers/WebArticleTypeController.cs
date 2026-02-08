using DTO;
using DTO.WebArticle;
using DTO.WebArticleType;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace WebApiBI.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    [AllowAnonymous]
    public class WebArticleTypeController : BaseController
    {

        [HttpPost]
        public ActionResult GetWebArticleTypeByPage([FromBody] DTO_WebArticleType model)
        {
            DataResult ds = webArticleTypeBaseService.getWebArticleTypeByPage(model);
            return Json(ds);
        }

    }
}
