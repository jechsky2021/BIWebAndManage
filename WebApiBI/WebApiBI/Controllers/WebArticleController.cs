using DTO;
using DTO.DTO_WebUserArticleLike;
using DTO.WebArticle;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

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
            webArticleBaseService.updateWebArticle(dTO_Id);

            return Json(ds);
        }

        [HttpPost]
        public ActionResult GetSearchArticles([FromBody] DTO_KeyWords model)
        {
            DataResult ds = webArticleBaseService.getSearchArticles(model);
            return Json(ds);
        }

        [HttpPost]
        public ActionResult UpdateArticleLikes([FromBody] DTO_UidAid model)
        {
            DataResult ds = webArticleBaseService.updateArticleLikes(model);
            return Json(ds);
        }

        [HttpPost]
        public ActionResult GetUidAid([FromBody] DTO_UidAid model)
        {
            DataResult ds = webArticleBaseService.getUidAid(model);
            return Json(ds);
        }

        [HttpPost]
        public ActionResult CancelArticleLikes([FromBody] DTO_UidAid model)
        {
            DataResult ds = webArticleBaseService.cancelArticleLikes(model);
            return Json(ds);
        }

        [HttpPost]
        public ActionResult GetMyArticleLikes([FromBody] DTO_UidPage model)
        {
            DataResult ds = webArticleBaseService.getMyArticleLikes(model);
            return Json(ds);
        }

    }
}
