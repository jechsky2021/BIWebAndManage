using DTO;
using DTO.DTO_WebUserTopicLike;
using DTO.DTOTopics;
using Microsoft.AspNetCore.Mvc;

namespace WebApiBI.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class WebTopicController : BaseController
    {
        [HttpPost]
        public IActionResult AddTopic(DTO_Topic model)
        {
            DataResult ds = webTopicsBaseService.addTopics(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public IActionResult GetTopicsByPage(DTO_Page model)
        {
            DataResult ds = webTopicsBaseService.getTopicsByPage(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult GetTopicById(DTO_Id model)
        {
            DataResult ds = webTopicsBaseService.getTopicById(model);
            return Json(ds);
        }
        
        [HttpPost]
        public IActionResult UpdateTopicPageViews(DTO_Id model)
        {
            DataResult ds = webTopicsBaseService.updateTopicPageViews(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult UpdateTopicLikes(DTO_UidTid model)
        {
            DataResult ds = webTopicsBaseService.updateTopicLikes(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult GetUidTid(DTO_UidTid model)
        {
            DataResult ds = webTopicsBaseService.getUidTid(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult CancelTopicLikes(DTO_UidTid model)
        {
            DataResult ds = webTopicsBaseService.cancelTopicLikes(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult GetMyTopics(DTO_UidPage model)
        {
            DataResult ds = webTopicsBaseService.getMyTopics(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult GetMyLikes(DTO_UidPage model)
        {
            DataResult ds = webTopicsBaseService.getMyLikes(model);
            return Json(ds);
        }

    }
}
