using DTO;
using DTO.DTOMenu;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace WebApiBI.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class MenuController : BaseController
    {
        [HttpPost]
        public ActionResult GetMenuByUid()
        {
            long uid = long.Parse(User.FindFirst("uid")?.Value??"0");
            DataResult ds = menuBaseService.getMenuByUid(new DTO_Id() { id = uid });
            ds.data = JsonConvert.DeserializeObject<List<DTO_Menu>>(ds.data?.ToString()??"")??new List<DTO_Menu>(); 
            return Json(ds);
        }

        [HttpPost]
        public ActionResult GetMenuAll()
        {
            DataResult ds = menuBaseService.getAll();
            ds.data = JsonConvert.DeserializeObject<List<DTO_Menu>>(ds.data?.ToString() ?? "") ?? new List<DTO_Menu>();
            return Json(ds);
        }

        [HttpPost]
        public ActionResult AddMenu([FromBody]DTO_Menu dTO_Menu)
        {
            DataResult ds = menuBaseService.addMenu(dTO_Menu);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public ActionResult UpdateMenu([FromBody] DTO_Menu dTO_Menu)
        {
            DataResult ds = menuBaseService.updateMenu(dTO_Menu);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

        [HttpPost]
        public ActionResult DeleteMenuById([FromBody] DTO_Id dTO_Id)
        {
            DataResult ds = menuBaseService.deleteMenuById(dTO_Id);
            ds.data = ds.data?.ToString() ?? "0";
            return Json(ds);
        }

    }
}
