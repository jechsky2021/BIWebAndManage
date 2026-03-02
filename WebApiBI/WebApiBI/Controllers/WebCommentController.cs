using DTO;
using DTO.DTOCommnets;
using Microsoft.AspNetCore.Mvc;

namespace WebApiBI.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class WebCommentController : BaseController
    {
        [HttpPost]
        public IActionResult AddComment([FromBody] DTO_Comment model)
        {
            DataResult ds = webCommentsBaseService.addComments(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public IActionResult GetCommentsByPage([FromBody] DTO_Comment model)
        {
            DataResult ds = webCommentsBaseService.getCommentsByPage(model);
            return Json(ds);
        }

    }
}
