using DataAccess;
using DTO;
using DTO.DTO_WebUserTopicLike;
using DTO.DTOTopics;
using Microsoft.Extensions.Logging;
using System.Data;

namespace ProfessionalLogic.topics
{
    public class WebTopicsBaseService : BaseService, IWebTopicsBaseService
    {
        public WebTopicsBaseService(ILogger<BaseService> logger) : base(logger)
        {
        }

        public DataResult addTopics(DTO_Topic model)
        {
            int? result = DataHandler.OperateObject<DTO_Topic>(model, ProcName.proc_insertTopics, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult getTopicsByPage(DTO_Page model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_Page>(model, ProcName.proc_selectTopicsByPage, OpBase.beautyindustry);
            return SelectByPage<DTO_TopicView>(ds);
        }

        public DataResult getTopicById(DTO_Id model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_Id>(model, ProcName.proc_selectTopicById, OpBase.beautyindustry);
            return Select<DTO_TopicView>(ds);
        }

        public DataResult updateTopicPageViews(DTO_Id model)
        {
            int? result = DataHandler.OperateObject<DTO_Id>(model, ProcName.proc_updateTopicPageViews, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult updateTopicLikes(DTO_UidTid model)
        {
            int? result = DataHandler.OperateObject<DTO_UidTid>(model, ProcName.proc_updateTopicLikes, OpBase.beautyindustry);

            int? result1 = DataHandler.OperateObject<DTO_UidTid>(model, ProcName.proc_insertWebUserTopicLikes, OpBase.beautyindustry);

            return Operation(result + result1);
        }

        public DataResult getUidTid(DTO_UidTid model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_UidTid>(model, ProcName.proc_selectUidTid, OpBase.beautyindustry);
            return Select<DTO_Count>(ds);
        }

        public DataResult cancelTopicLikes(DTO_UidTid model)
        {
            int? result = DataHandler.OperateObject<DTO_UidTid>(model, ProcName.proc_cancelTopicLike, OpBase.beautyindustry);

            int? result1 = DataHandler.OperateObject<DTO_UidTid>(model, ProcName.proc_deleteWebUserTopicLikes, OpBase.beautyindustry);

            return Operation(result + result1);
        }

        public DataResult getMyTopics(DTO_UidPage model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_UidPage>(model, ProcName.proc_selectMyTopicsByPage, OpBase.beautyindustry);
            return SelectByPage<DTO_TopicView>(ds);
        }

        public DataResult getMyLikes(DTO_UidPage model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_UidPage>(model, ProcName.proc_selectMyLikesByPage, OpBase.beautyindustry);
            return SelectByPage<DTO_TopicView>(ds);
        }


    }
}
