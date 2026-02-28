using DTO;
using DTO.DTOUser;
using DTO.DTOWebUser;

namespace ProfessionalLogic.webUsers
{
    public interface IWebUserBaseService
    {
        DataResult addWebUser(DTO_WebUser model);
        DataResult webLogin(DTO_WebUser model);
        DataResult updateWebUser(DTO_WebUser model);
        DataResult updateWebUserAvatar(DTO_WebUser model);
        DataResult updateWebUserPWD(DTO_WebUser model);
        DataResult getUserById(DTO_Id model);
    }
}
