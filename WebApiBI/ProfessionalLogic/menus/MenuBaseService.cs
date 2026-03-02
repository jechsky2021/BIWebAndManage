using DataAccess;
using DTO;
using DTO.DTOMenu;
using Microsoft.Extensions.Logging;
using System.Data;

namespace ProfessionalLogic.menus
{
    public class MenuBaseService : BaseService, IMenuBaseService
    {
        public MenuBaseService(ILogger<BaseService> logger) : base(logger)
        {
        }

        public DataResult getMenuByUid(DTO_Id dTO_Id)
        {
            DataSet result = DataHandler.QueryDataSet<DTO_Id>(dTO_Id, ProcName.proc_getMenuByUid, OpBase.beautyindustry);
            return Select<DTO_Menu>(result);
        }

        public DataResult getAll()
        {
            DataSet result = DataHandler.QueryDataSet(ProcName.proc_selectMenuAll, OpBase.beautyindustry);
            return Select<DTO_Menu>(result);
        }

        public DataResult addMenu(DTO_Menu dTO_Menu)
        {
            int? result = DataHandler.OperateObject<DTO_Menu>(dTO_Menu, ProcName.proc_insertMenu, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult updateMenu(DTO_Menu dTO_Menu)
        {
            int? result = DataHandler.OperateObject<DTO_Menu>(dTO_Menu, ProcName.proc_updateMenu, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult deleteMenuById(DTO_Id dTO_Id)
        {
            int? result = DataHandler.OperateObject<DTO_Id>(dTO_Id, ProcName.proc_deleteMenuById, OpBase.beautyindustry);
            return Operation(result);
        }


    }
}
