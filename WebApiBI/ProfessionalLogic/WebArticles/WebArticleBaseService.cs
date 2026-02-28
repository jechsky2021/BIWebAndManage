using DataAccess;
using DTO;
using DTO.Article;
using DTO.WebArticle;
using Microsoft.Extensions.Logging;
using System.Data;

namespace ProfessionalLogic.WebArticles
{
    public class WebArticleBaseService:BaseService, IWebArticleBaseService
    {
        public WebArticleBaseService(ILogger<BaseService> logger) : base(logger)
        {
        }

        public DataResult getWebArticleByPage(DTO_WebArticle model)
        {
            DataSet result = DataHandler.QueryDataSet<DTO_WebArticle>(model, ProcName.proc_selectWebArticleByPage, OpBase.beautyindustry);
            return SelectByPage<DTO_Article>(result);
        }

        public DataResult getWebDetailById(DTO_Id model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_Id>(model, ProcName.proc_selectPublishArticleById, OpBase.beautyindustry);
            return Select(ds);
        }

        public DataResult updateWebArticle(DTO_Article model)
        {
            int? result = DataHandler.OperateObject<DTO_Article>(model, ProcName.proc_updatePageViews, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult getSearchArticles(DTO_KeyWords model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_KeyWords>(model, ProcName.proc_searchArticle, OpBase.beautyindustry);
            return SelectByPage<DTO_Article>(ds);
        }

    }
}
