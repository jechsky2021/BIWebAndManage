using DTO;
using DTO.DTO_Questions;
using DTO.DTO_WebUserQuestionLike;
using Microsoft.AspNetCore.Mvc;

namespace WebApiBI.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class WebQuestionController : BaseController
    {
        [HttpPost]
        public IActionResult AddQuestion([FromBody] DTO_Question model)
        {
            DataResult ds = webQuestionsBaseService.addQuestons(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public IActionResult GetQuestionsByPage([FromBody] DTO_Question model)
        {
            DataResult ds = webQuestionsBaseService.getQuestonsByPage(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult GetQuestionById([FromBody] DTO_Id model)
        {
            DataResult ds = webQuestionsBaseService.getQuestionById(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult UpdateQuestionPageViews([FromBody] DTO_Id model)
        {
            DataResult ds = webQuestionsBaseService.updateQuestionPageViews(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult UpdateQuestionLikes([FromBody] DTO_UidQid model)
        {
            DataResult ds = webQuestionsBaseService.updateQuestionLikes(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult UpdateQuestionStatus([FromBody] DTO_Status model)
        {
            DataResult ds = webQuestionsBaseService.updateQuestionStatus(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult GetUidQid([FromBody] DTO_UidQid model)
        {
            DataResult ds = webQuestionsBaseService.getUidQid(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult CancelQuestionLikes([FromBody] DTO_UidQid model)
        {
            DataResult ds = webQuestionsBaseService.cancelQuestionLikes(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult GetMyQuestionsByPage([FromBody] DTO_UidPage model)
        {
            DataResult ds = webQuestionsBaseService.getMyQuestionsByPage(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult GetMyQuestionLikesByPage([FromBody] DTO_UidPage model)
        {
            DataResult ds = webQuestionsBaseService.getMyQuestionLikesByPage(model);
            return Json(ds);
        }

    }
}
