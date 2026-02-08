using DTO;
using DTO.Article;
using DTO.WebArticle;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace WebApiBI.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    [AllowAnonymous]
    public class WebArticleController : BaseController
    {
        [HttpPost]
        public ActionResult GetLastByPage([FromBody] DTO_WebArticle model)
        {
            DataResult ds = webArticleBaseService.getWebArticleByPage(model);
            return Json(ds);
        }

        [HttpPost]
        public ActionResult GetDetailById([FromBody] DTO_Id dTO_Id)
        {
            DataResult ds = webArticleBaseService.getWebDetailById(dTO_Id);
            ds.data = JsonConvert.DeserializeObject<List<DTO_Article>>(ds.data?.ToString() ?? "0") ?? new List<DTO_Article>();
            return Json(ds);
        }

    }
}
