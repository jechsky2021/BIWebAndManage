using DataAccess;
using DTO;
using DTO.DTO_Tags;
using DTO.DTOTopics;
using Microsoft.Extensions.Logging;
using System.Data;

namespace ProfessionalLogic.tags
{
    public class WebTagsBaseService : BaseService, IWebTagsBaseService
    {
        public WebTagsBaseService(ILogger<BaseService> logger) : base(logger)
        {
        }

        public DataResult addTag(DTO_Tag model)
        {
            int? result = DataHandler.OperateObject<DTO_Tag>(model, ProcName.proc_insertTag, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult getAllTags()
        {
            DataSet ds = DataHandler.QueryDataSet(ProcName.proc_selectAllTags, OpBase.beautyindustry);
            return Select<DTO_Tag>(ds);
        }

        public DataResult getTagsByPage(DTO_Tag model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_Tag>(model,ProcName.proc_selectTagsByPage, OpBase.beautyindustry);
            return SelectByPage<DTO_Tag>(ds);
        }

        public DataResult getTagByName(DTO_Name model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_Name>(model,ProcName.proc_selectTagByName, OpBase.beautyindustry);
            return Select<DTO_Count>(ds);
        }

        public DataResult getTagById(DTO_Id model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_Id>(model, ProcName.proc_selectTagById, OpBase.beautyindustry);
            return Select<DTO_Tag>(ds);
        }

        public DataResult updateTag(DTO_Tag model)
        {
            int? result = DataHandler.OperateObject<DTO_Tag>(model, ProcName.proc_updateTagById, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult deleteTagById(DTO_Id model)
        {
            int? result = DataHandler.OperateObject<DTO_Id>(model, ProcName.proc_deleteTagById, OpBase.beautyindustry);
            return Operation(result);
        }


    }
}
