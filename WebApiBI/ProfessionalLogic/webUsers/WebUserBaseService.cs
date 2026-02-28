using DataAccess;
using DTO;
using DTO.DTORole;
using DTO.DTOUser;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using ProfessionalLogic.users;
using System.Data;

namespace ProfessionalLogic.webUsers
{
    public class WebUserBaseService : BaseService, IWebUserBaseService
    {
        public WebUserBaseService(ILogger<BaseService> logger) : base(logger)
        {
        }

        public DataResult addWebUser(DTO_User model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_User>(model, ProcName.proc_insertUser, OpBase.beautyindustry);
            
            return Select(ds);
        }

        public DataResult updateWebUser(DTO_User model)
        {
            int? result = DataHandler.OperateObject<DTO_User>(model, ProcName.proc_updateWebUser, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult updateWebUserAvatar(DTO_User model)
        {
            int? result = DataHandler.OperateObject<DTO_User>(model, ProcName.proc_updateWebUserAvatar, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult updateWebUserPWD(DTO_User model)
        {
            DTO_Id dTO_Id = new DTO_Id() { id = model.id };
            DataSet ds = DataHandler.QueryDataSet<DTO_Id>(dTO_Id, ProcName.proc_selectUserById, OpBase.beautyindustry);
            if(model.oldUPasswords == ds.Tables[0].Rows[0]["uPasswords"].ToString())
            {
                int? result = DataHandler.OperateObject<DTO_User>(model, ProcName.proc_updateUserPWD, OpBase.beautyindustry);
                return Operation(result);
            }
            else
            {
                return DataResult.GetDataResult(ResultSign.Error,"原密码不存在或不正确！", "");
            }
        }

        public DataResult getUserById(DTO_Id model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_Id>(model, ProcName.proc_selectUserById, OpBase.beautyindustry);
            return Select(ds);
        }


    }
}
