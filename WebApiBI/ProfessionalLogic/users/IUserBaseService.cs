using DTO;
using DTO.DTOUser;

namespace ProfessionalLogic.users
{
    public interface IUserBaseService
    {
        DataResult login(DTO_User dTO_User);
        DataResult getByPage(DTO_User dTO_User);
        DataResult getRolesByUid(DTO_Id model);
        DataResult addUser(DTO_User model);
        DataResult updateUser(DTO_User model);
        DataResult updatePWD(DTO_User model);
        DataResult assignRoles(DTO_UidRoleIds dTO_UidRoleIds);

    }
}
