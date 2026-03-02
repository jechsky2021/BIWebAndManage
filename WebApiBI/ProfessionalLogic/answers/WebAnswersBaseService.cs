using DataAccess;
using DTO;
using DTO.DTO_Answers;
using DTO.DTO_Questions;
using Microsoft.Extensions.Logging;
using System.Data;

namespace ProfessionalLogic.answers
{
    public class WebAnswersBaseService : BaseService, IWebAnswersBaseService
    {
        public WebAnswersBaseService(ILogger<BaseService> logger) : base(logger)
        {
        }

        public DataResult addAnswer(DTO_Answer model)
        {
            int? result = DataHandler.OperateObject<DTO_Answer>(model, ProcName.proc_insertAnswer, OpBase.beautyindustry);
            DTO_Id id = new DTO_Id { id = model.questionId };
            int? result1 = DataHandler.OperateObject<DTO_Id>(id, ProcName.proc_updateAnsweredStatus, OpBase.beautyindustry);
            return Operation(result + result1);
        }

        public DataResult getAnswersByPage(DTO_SelectAnswer model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_SelectAnswer>(model, ProcName.proc_selectAnswerByPage, OpBase.beautyindustry);
            return SelectByPage<DTO_AnswerView>(ds);
        }

        public DataResult updateAnswerIsAccepted(DTO_Id model)
        {
            int? result = DataHandler.OperateObject<DTO_Id>(model, ProcName.proc_updateAnswerIsAccepted, OpBase.beautyindustry);
            DTO_Status dTO_Status = new DTO_Status { id = model.id, status = 2 };
            int? result1 = DataHandler.OperateObject<DTO_Status>(dTO_Status, ProcName.proc_updateQuestionStatus, OpBase.beautyindustry);
            return Operation(result);
        }

    }
}
