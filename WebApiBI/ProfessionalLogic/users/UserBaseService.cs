using DataAccess;
using DTO;
using DTO.DTORole;
using DTO.DTOUser;
using Microsoft.Extensions.Logging;
using System.Data;

namespace ProfessionalLogic.users
{
    public class UserBaseService : BaseService, IUserBaseService
    {
        public UserBaseService(ILogger<BaseService> logger) : base(logger)
        {
        }

        public DataResult login(DTO_User dTO_User)
        {
            // string aespwd = AesHelper.Encrypt(dTO_User.uPasswords);

            DataSet result = DataHandler.QueryDataSet<DTO_User>(dTO_User, ProcName.proc_login, OpBase.beautyindustry);
            return Select<DTO_User>(result);
        }

        public DataResult getByPage(DTO_User dTO_User)
        {
            DataSet result = DataHandler.QueryDataSet<DTO_User>(dTO_User, ProcName.proc_selectUsersByPage, OpBase.beautyindustry);
            return SelectByPage<DTO_User>(result);
        }

        public DataResult getRolesByUid(DTO_Id model)
        {
            DataSet result = DataHandler.QueryDataSet<DTO_Id>(model, ProcName.proc_selectRolesByUid, OpBase.beautyindustry);
            return Select<DTO_Role>(result);
        }

        public DataResult addUser(DTO_User model)
        {
            int? result = DataHandler.OperateObject<DTO_User>(model, ProcName.proc_insertUser, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult updateUser(DTO_User model)
        {
            int? result = DataHandler.OperateObject<DTO_User>(model, ProcName.proc_updateUser, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult updatePWD(DTO_User model)
        {
            int? result = DataHandler.OperateObject<DTO_User>(model, ProcName.proc_updateUserPWD, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult assignRoles(DTO_UidRoleIds dTO_UidRoleIds)
        {
            int sum = 0; 
            if (dTO_UidRoleIds.roleIds.Count>0)
            {
                DTO_Id dTO_Id = new DTO_Id() { id = dTO_UidRoleIds.id };
                int? result1 = DataHandler.OperateObject<DTO_Id>(dTO_Id, ProcName.proc_deleteUserRole, OpBase.beautyindustry);

                foreach (var item in dTO_UidRoleIds.roleIds)
                {
                    DTO_UidRoleId dTO_UidRoleId = new DTO_UidRoleId
                    {
                        userId = dTO_UidRoleIds.id,
                        roleId = item
                    };
                    int? result = DataHandler.OperateObject<DTO_UidRoleId>(dTO_UidRoleId, ProcName.proc_insertUserRole, OpBase.beautyindustry);
                    sum += result ?? 0;
                }
            }
            return Operation(sum);
        }

    }
}
