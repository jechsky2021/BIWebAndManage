using DTO;
using DTO.DTO_Tags;
using Microsoft.AspNetCore.Mvc;

namespace WebApiBI.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class WebTagController : BaseController
    {

        [HttpPost]
        public IActionResult AddTag([FromBody] DTO_Tag model)
        {
            DataResult ds = webTagsBaseService.addTag(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult GetAllTags()
        {
            DataResult ds = webTagsBaseService.getAllTags();
            return Json(ds);
        }

        [HttpPost]
        public IActionResult GetTagsByPage([FromBody] DTO_Tag model)
        {
            DataResult ds = webTagsBaseService.getTagsByPage(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult GetTagByName([FromBody] DTO_Name model)
        {
            DataResult ds = webTagsBaseService.getTagByName(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult GetTagById([FromBody] DTO_Id model)
        {
            DataResult ds = webTagsBaseService.getTagById(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult UpdateTag([FromBody] DTO_Tag model)
        {
            DataResult ds = webTagsBaseService.updateTag(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult DeleteTag([FromBody] DTO_Id model)
        {
            DataResult ds = webTagsBaseService.deleteTagById(model);
            return Json(ds);
        }

    }
}
