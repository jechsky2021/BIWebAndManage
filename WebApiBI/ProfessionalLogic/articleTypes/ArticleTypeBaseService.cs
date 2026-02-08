using DataAccess;
using Microsoft.Extensions.Logging;
using System.Data;
using DTO;
using DTO.ArticleType;

namespace ProfessionalLogic.articleTypes
{
    public class ArticleTypeBaseService:BaseService, IArticleTypeBaseService
    {
        public ArticleTypeBaseService(ILogger<BaseService> logger) : base(logger)
        {
        }

        public DataResult getByPage(DTO_ArticleType model)
        {
            DataSet result = DataHandler.QueryDataSet<DTO_ArticleType>(model, ProcName.proc_selectArticleTypeByPage, OpBase.beautyindustry);
            return SelectByPage<DTO_ArticleType>(result);
        }

        public DataResult addArT(DTO_ArticleType model)
        {
            int? result = DataHandler.OperateObject<DTO_ArticleType>(model, ProcName.proc_insertArticleType, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult updateArT(DTO_ArticleType model)
        {
            int? result = DataHandler.OperateObject<DTO_ArticleType>(model, ProcName.proc_updateArticleType, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult deleteArTById(DTO_Id model)
        {
            int? result = DataHandler.OperateObject<DTO_Id>(model, ProcName.proc_deleteArticleTypeById, OpBase.beautyindustry);
            return Operation(result);
        }

    }
}
