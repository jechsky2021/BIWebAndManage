using DTO;
using DTO.ArticleType;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace WebApiBI.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class ArticleTypeController : BaseController
    {
        [HttpPost]
        public ActionResult GetByPage([FromBody] DTO_ArticleType model)
        {
            DataResult ds = articleTypeBaseService.getByPage(model);
            return Json(ds);
        }

        [HttpPost]
        public ActionResult AddArT([FromBody] DTO_ArticleType model)
        {
            DataResult ds = articleTypeBaseService.addArT(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public ActionResult UpdateArT([FromBody] DTO_ArticleType model)
        {
            DataResult ds = articleTypeBaseService.updateArT(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public ActionResult DeleteARTById([FromBody] DTO_Id model)
        {
            DataResult ds = articleTypeBaseService.deleteArTById(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

    }
}
