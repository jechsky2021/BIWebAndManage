using DTO;
using DTO.Article;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace WebApiBI.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class ArticleController : BaseController
    {

        //[HttpGet("{id}")] // 路由将匹配 /api/articles/{id}
        //public IActionResult GetArticleById(int id) // 从路由参数获取文章ID
        //{
        //    return Ok();
        //}

        [HttpPost]
        public ActionResult GetByPage([FromBody]DTO_Article model)
        {
            DataResult ds = articleBaseService.getByPage(model);
            return Json(ds);
        }

        [HttpPost]
        public ActionResult GetDetailById([FromBody] DTO_Id dTO_Id)
        {
            DataResult ds = articleBaseService.getDetailById(dTO_Id);
            ds.data = JsonConvert.DeserializeObject<List<DTO_Article>>(ds.data?.ToString() ?? "0") ?? new List<DTO_Article>();
            return Json(ds);
        }

        [HttpPost]
        public ActionResult AddArt([FromBody] DTO_Article model)
        {
            DataResult ds = articleBaseService.addArt(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public ActionResult UpdateArt([FromBody] DTO_Article model)
        {
            DataResult ds = articleBaseService.updateArt(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public ActionResult UpdateStatus([FromBody] DTO_Article model)
        {
            DataResult ds = articleBaseService.updateStatus(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

    }
}
