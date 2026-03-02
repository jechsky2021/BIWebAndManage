using DTO;
using DTO.DTO_Questions;
using DTO.DTO_WebUserQuestionLike;
using System;
using System.Collections.Generic;
using System.Text;

namespace ProfessionalLogic.questions
{
    public interface IWebQuestionsBaseService
    {
        DataResult addQuestons(DTO_Question model);
        DataResult getQuestonsByPage(DTO_Question model);
        DataResult getQuestionById(DTO_Id model);
        DataResult updateQuestionPageViews(DTO_Id model);
        DataResult updateQuestionLikes(DTO_UidQid model);
        DataResult updateQuestionStatus(DTO_Status model);
        DataResult getUidQid(DTO_UidQid model);
        DataResult cancelQuestionLikes(DTO_UidQid model);
        DataResult getMyQuestionsByPage(DTO_UidPage model);
        DataResult getMyQuestionLikesByPage(DTO_UidPage model);

    }
}
