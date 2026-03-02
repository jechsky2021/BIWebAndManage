using DataAccess;
using DTO;
using DTO.DTO_Questions;
using DTO.DTO_Tags;
using DTO.DTO_WebUserQuestionLike;
using DTO.DTOTopics;
using Microsoft.Extensions.Logging;
using System.Data;

namespace ProfessionalLogic.questions
{
    public class WebQuestionsBaseService : BaseService, IWebQuestionsBaseService
    {
        public WebQuestionsBaseService(ILogger<BaseService> logger) : base(logger)
        {
        }

        public DataResult addQuestons(DTO_Question model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_Question>(model, ProcName.proc_insertQuestion, OpBase.beautyindustry);

            List<long> ids = model.tagIds.Split(',').Select(t => long.Parse(t)).ToList();

            if (ids.Count > 0)
            {
                ids.ForEach(t =>
                {
                    DTO_QuestionTag dTO_QuestionTag = new DTO_QuestionTag()
                    {
                        question_id = long.Parse(ds.Tables[0].Rows[0]["id"].ToString()??"0"),
                        tag_id = t
                    };
                    int? result1 = DataHandler.OperateObject<DTO_QuestionTag>(dTO_QuestionTag, ProcName.proc_insertQuestionTag, OpBase.beautyindustry);
                });
            }
            return Operation(1);
        }

        public DataResult getQuestonsByPage(DTO_Question model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_Question>(model, ProcName.proc_selectQuestionsByPage, OpBase.beautyindustry);
            return SelectByPage<DTO_QuestionView>(ds);
        }

        public DataResult getQuestionById(DTO_Id model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_Id>(model, ProcName.proc_selectQuestionById, OpBase.beautyindustry);
            return Select<DTO_QuestionView>(ds);
        }

        public DataResult updateQuestionPageViews(DTO_Id model)
        {
            int? result = DataHandler.OperateObject<DTO_Id>(model, ProcName.proc_updateQuestionPageView, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult updateQuestionLikes(DTO_UidQid model)
        {
            int? result = DataHandler.OperateObject<DTO_UidQid>(model, ProcName.proc_updateQuestionLikes, OpBase.beautyindustry);

            int? result1 = DataHandler.OperateObject<DTO_UidQid>(model, ProcName.proc_insertWebUserQuestionLikes, OpBase.beautyindustry);

            return Operation(result + result1);
        }

        public DataResult updateQuestionStatus(DTO_Status model)
        {
            int? result = DataHandler.OperateObject<DTO_Status>(model, ProcName.proc_updateQuestionStatus, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult getUidQid(DTO_UidQid model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_UidQid>(model, ProcName.proc_selectUidQid, OpBase.beautyindustry);
            return Select<DTO_Count>(ds);
        }

        public DataResult cancelQuestionLikes(DTO_UidQid model)
        {
            int? result = DataHandler.OperateObject<DTO_UidQid>(model, ProcName.proc_cancelQuestionLike, OpBase.beautyindustry);

            int? result1 = DataHandler.OperateObject<DTO_UidQid>(model, ProcName.proc_deleteWebUserQuestionLikes, OpBase.beautyindustry);

            return Operation(result + result1);
        }

        public DataResult getMyQuestionsByPage(DTO_UidPage model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_UidPage>(model, ProcName.proc_selectMyQuestionsByPage, OpBase.beautyindustry);
            return SelectByPage<DTO_QuestionView>(ds);
        }

        public DataResult getMyQuestionLikesByPage(DTO_UidPage model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_UidPage>(model, ProcName.proc_selectMyQuestionLikesByPage, OpBase.beautyindustry);
            return SelectByPage<DTO_QuestionView>(ds);
        }


    }
}
