using DTO;
using DTO.DTORole;

namespace ProfessionalLogic.roles
{
    public interface IRoleBaseService
    {
        DataResult addRole(DTO_Role dTO_Role);
        DataResult updateRole(DTO_Role dTO_Role);
        DataResult deleteRoleById(DTO_Id dTO_Id);
        DataResult getByPage(DTO_Role dTO_Role);
        DataResult getMenuByRoleId(DTO_Id dTO_Id);
        DataResult assignMenus(DTO_RoleIdMenuIds dTO_RoleIdMenuIds);
    }
}
