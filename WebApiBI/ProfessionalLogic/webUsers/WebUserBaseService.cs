using DataAccess;
using DTO;
using DTO.DTOWebUser;
using Microsoft.Extensions.Logging;
using System.Data;

namespace ProfessionalLogic.webUsers
{
    public class WebUserBaseService : BaseService, IWebUserBaseService
    {
        public WebUserBaseService(ILogger<BaseService> logger) : base(logger)
        {
        }

        public DataResult addWebUser(DTO_WebUser model)
        {
            int? result = DataHandler.OperateObject<DTO_WebUser>(model, ProcName.proc_insertWebUser, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult webLogin(DTO_WebUser model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_WebUser>(model, ProcName.proc_loginWeb, OpBase.beautyindustry);
            return Select<DTO_WebUser>(ds);
        }

        public DataResult updateWebUser(DTO_WebUser model)
        {
            int? result = DataHandler.OperateObject<DTO_WebUser>(model, ProcName.proc_updateWebUser, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult updateWebUserAvatar(DTO_WebUser model)
        {
            int? result = DataHandler.OperateObject<DTO_WebUser>(model, ProcName.proc_updateWebUserAvatar, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult updateWebUserPWD(DTO_WebUser model)
        {
            DTO_Id dTO_Id = new DTO_Id() { id = model.id };
            DataSet ds = DataHandler.QueryDataSet<DTO_Id>(dTO_Id, ProcName.proc_selectWebUserById, OpBase.beautyindustry);
            if(model.oldUPasswords == ds.Tables[0].Rows[0]["uPasswords"].ToString())
            {
                int? result = DataHandler.OperateObject<DTO_WebUser>(model, ProcName.proc_updateWebUserPWD, OpBase.beautyindustry);
                return Operation(result);
            }
            else
            {
                return DataResult.GetDataResult(ResultSign.Error,"原密码不存在或不正确！", "");
            }
        }

        public DataResult getUserById(DTO_Id model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_Id>(model, ProcName.proc_selectWebUserById, OpBase.beautyindustry);
            return Select<DTO_WebUser>(ds);
        }

    }
}
