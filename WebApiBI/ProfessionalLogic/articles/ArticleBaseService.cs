using DataAccess;
using DTO;
using DTO.Article;
using DTO.DTOMenu;
using DTO.DTORole;
using Microsoft.Extensions.Logging;
using System.Data;

namespace ProfessionalLogic.articles
{
    public class ArticleBaseService : BaseService, IArticleBaseService
    {
        public ArticleBaseService(ILogger<BaseService> logger) : base(logger)
        {
        }

        public DataResult getByPage(DTO_Article model)
        {
            DataSet result = DataHandler.QueryDataSet<DTO_Article>(model, ProcName.proc_selectArticleByPage, OpBase.beautyindustry);
            return SelectByPage<DTO_Article>(result);
        }

        public DataResult getDetailById(DTO_Id model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_Id>(model, ProcName.proc_selectArticleById, OpBase.beautyindustry);
            return Select<DTO_Article>(ds);
        }

        public DataResult updateStatus(DTO_Article model)
        {
            int? result = DataHandler.OperateObject<DTO_Article>(model, ProcName.proc_updateStatussById, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult addArt(DTO_Article model)
        {
            int? result = DataHandler.OperateObject<DTO_Article>(model, ProcName.proc_insertArticle, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult updateArt(DTO_Article model)
        {
            int? result = DataHandler.OperateObject<DTO_Article>(model, ProcName.proc_updateArticle, OpBase.beautyindustry);
            return Operation(result);
        }

    }
}
