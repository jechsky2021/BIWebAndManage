using DTO;
using DTO.DTO_Answers;

namespace ProfessionalLogic.answers
{
    public interface IWebAnswersBaseService
    {
        DataResult addAnswer(DTO_Answer model);
        DataResult getAnswersByPage(DTO_SelectAnswer model);
        DataResult updateAnswerIsAccepted(DTO_Id model);
    }
}
