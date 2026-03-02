using DTO;
using DTO.DTO_Answers;
using Microsoft.AspNetCore.Mvc;

namespace WebApiBI.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class WebAnswerController : BaseController
    {
        [HttpPost]
        public IActionResult AddAnswer([FromBody] DTO_Answer model)
        {
            DataResult ds = webAnswersBaseService.addAnswer(model);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public IActionResult GetAnswersByPage([FromBody] DTO_SelectAnswer model)
        {
            DataResult ds = webAnswersBaseService.getAnswersByPage(model);
            return Json(ds);
        }

        [HttpPost]
        public IActionResult UpdateAnswerIsAccepted([FromBody]DTO_Id model)
        {
            DataResult ds = webAnswersBaseService.updateAnswerIsAccepted(model);
            return Json(ds);
        }

    }
}
