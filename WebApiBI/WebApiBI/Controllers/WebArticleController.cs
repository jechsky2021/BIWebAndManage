using DTO;
using DTO.Article;
using DTO.DTOMenu;
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
            List<DTO_Article> ls = (List<DTO_Article>)ds.data;
            ds.data = ls;

            if(ls.Count > 0)
            {
                ls.FirstOrDefault().pageViews++;
            }
            webArticleBaseService.updateWebArticle(ls.FirstOrDefault());

            return Json(ds);
        }

        [HttpPost]
        public ActionResult GetSearchArticles([FromBody] DTO_KeyWords model)
        {
            DataResult ds = webArticleBaseService.getSearchArticles(model);
            return Json(ds);
        }

    }
}
