using DTO;
using DTO.DTOMenu;
using DTO.DTOUser;

namespace ProfessionalLogic.menus
{
    public interface IMenuBaseService
    {
        DataResult getMenuByUid(DTO_Id dTO_Id);
        DataResult getAll();
        DataResult addMenu(DTO_Menu dTO_Menu);      
        DataResult updateMenu(DTO_Menu dTO_Menu);
        DataResult deleteMenuById(DTO_Id dTO_Id);
    }
}
