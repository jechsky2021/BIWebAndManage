using DataAccess;
using DTO;
using DTO.DTOMenu;
using DTO.DTORole;
using Microsoft.Extensions.Logging;
using System.Data;

namespace ProfessionalLogic.roles
{
    public class RoleBaseService : BaseService, IRoleBaseService
    {
        public RoleBaseService(ILogger<BaseService> logger) : base(logger)
        {
        }

        public DataResult addRole(DTO_Role dTO_Role)
        {
            int? result = DataHandler.OperateObject<DTO_Role>(dTO_Role, ProcName.proc_insertRole, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult updateRole(DTO_Role dTO_Role)
        {
            int? result = DataHandler.OperateObject<DTO_Role>(dTO_Role, ProcName.proc_updateRole, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult deleteRoleById(DTO_Id dTO_Id)
        {
            int? result = DataHandler.OperateObject<DTO_Id>(dTO_Id, ProcName.proc_deleteRoleById, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult getByPage(DTO_Role dTO_Role)
        {
            DataSet result = DataHandler.QueryDataSet<DTO_Role>(dTO_Role,ProcName.proc_selectRoleByPage, OpBase.beautyindustry);
            return SelectByPage<DTO_Role>(result);
        }

        public DataResult getMenuByRoleId(DTO_Id dTO_Id)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_Id>(dTO_Id, ProcName.proc_selectMenuByRoleId, OpBase.beautyindustry);
            return Select<DTO_Menu>(ds);
        }

        public DataResult assignMenus(DTO_RoleIdMenuIds dTO_RoleIdMenuIds)
        {
            int sum = 0;
            if (dTO_RoleIdMenuIds!=null)
            {
                DTO_Id dTO_Id = new DTO_Id() { id = dTO_RoleIdMenuIds.roleId };
                int? result1 = DataHandler.OperateObject<DTO_Id>(dTO_Id, ProcName.proc_deleteRoleMenu, OpBase.beautyindustry);
                foreach (var item in dTO_RoleIdMenuIds.menuIds)
                {
                    DTO_RoleIdMenuId dTO_RoleIdMenuId = new DTO_RoleIdMenuId() { roleId = dTO_RoleIdMenuIds.roleId, menuId = item };
                    int? result = DataHandler.OperateObject<DTO_RoleIdMenuId>(dTO_RoleIdMenuId, ProcName.proc_insertRoleMenu, OpBase.beautyindustry);
                    sum += result ?? 0;
                }
            }
            return Operation(sum);
        }


    }
}
