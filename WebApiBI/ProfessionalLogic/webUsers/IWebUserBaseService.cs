using DTO;
using DTO.DTOUser;

namespace ProfessionalLogic.webUsers
{
    public interface IWebUserBaseService
    {
        DataResult addWebUser(DTO_User model);
        DataResult updateWebUser(DTO_User model);
        DataResult updateWebUserAvatar(DTO_User model);
        DataResult updateWebUserPWD(DTO_User model);
        DataResult getUserById(DTO_Id model);
    }
}
