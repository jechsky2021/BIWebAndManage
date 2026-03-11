using DTO;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;


namespace WebApiBI.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    [AllowAnonymous]
    public class TestController : BaseController
    {
        //http://localhost:5247/api/test/Getfunc?nameparams=c
        //FromQuery ?后的参数
        [HttpGet]
        public IActionResult Getfunc([FromQuery]string nameparams)
        {
            //string nameparams = "a";
           // DataResult ds = moduleBaseService.GetByparams(nameparams);
            return Ok("ddd");
        }

        //https://localhost:7081/api/test/Getfun/c
        [HttpGet("{nameparams}")]
        public IActionResult Getfun(string nameparams)
        {
            //string nameparams = "a";
           // DataResult ds = moduleBaseService.GetByparams(nameparams);
            return Ok();
        }


    }
}
