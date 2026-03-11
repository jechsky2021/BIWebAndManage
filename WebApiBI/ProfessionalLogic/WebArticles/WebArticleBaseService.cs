using DataAccess;
using DTO;
using DTO.Article;
using DTO.DTO_WebUserArticleLike;
using DTO.DTO_WebUserTopicLike;
using DTO.DTOTopics;
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
            return Select<DTO_Article>(ds);
        }

        public DataResult updateWebArticle(DTO_Id model)
        {
            int? result = DataHandler.OperateObject<DTO_Id>(model, ProcName.proc_updatePageViews, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult getSearchArticles(DTO_KeyWords model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_KeyWords>(model, ProcName.proc_searchArticle, OpBase.beautyindustry);
            return SelectByPage<DTO_Article>(ds);
        }

        public DataResult updateArticleLikes(DTO_UidAid model)
        {
            int? result = DataHandler.OperateObject<DTO_UidAid>(model, ProcName.proc_updateArticleLikes, OpBase.beautyindustry);

            int? result1 = DataHandler.OperateObject<DTO_UidAid>(model, ProcName.proc_insertWebUserArticleLikes, OpBase.beautyindustry);

            return Operation(result + result1);
        }

        public DataResult getUidAid(DTO_UidAid model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_UidAid>(model, ProcName.proc_selectUidAid, OpBase.beautyindustry);
            return Select<DTO_Count>(ds);
        }

        public DataResult cancelArticleLikes(DTO_UidAid model)
        {
            int? result = DataHandler.OperateObject<DTO_UidAid>(model, ProcName.proc_cancelArticleLike, OpBase.beautyindustry);

            int? result1 = DataHandler.OperateObject<DTO_UidAid>(model, ProcName.proc_deleteWebUserArticleLikes, OpBase.beautyindustry);

            return Operation(result + result1);
        }

        public DataResult getMyArticleLikes(DTO_UidPage model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_UidPage>(model, ProcName.proc_selectMyArticleLikesByPage, OpBase.beautyindustry);
            return SelectByPage<DTO_TopicView>(ds);
        }


    }
}
