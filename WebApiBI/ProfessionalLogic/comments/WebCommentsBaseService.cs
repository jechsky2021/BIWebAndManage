using DataAccess;
using DTO;
using DTO.DTOCommnets;
using Microsoft.Extensions.Logging;
using System.Data;

namespace ProfessionalLogic.comments
{
    public class WebCommentsBaseService : BaseService, IWebCommentsBaseService
    {
        public WebCommentsBaseService(ILogger<BaseService> logger) : base(logger)
        {
        }

        public DataResult addComments(DTO_Comment model)
        {
            int? result = DataHandler.OperateObject<DTO_Comment>(model, ProcName.proc_insertComment, OpBase.beautyindustry);
            return Operation(result);
        }

        public DataResult getCommentsByPage(DTO_Comment model)
        {
            DataSet ds = DataHandler.QueryDataSet<DTO_Comment>(model, ProcName.proc_selectCommentByPage, OpBase.beautyindustry);
            return SelectByPage<DTO_CommentView>(ds);
        }

    }
}
