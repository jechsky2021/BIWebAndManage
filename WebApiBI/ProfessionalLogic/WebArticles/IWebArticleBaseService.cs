using DTO;
using DTO.DTO_WebUserArticleLike;
using DTO.WebArticle;

namespace ProfessionalLogic.WebArticles
{
    public interface IWebArticleBaseService
    {
        DataResult getWebArticleByPage(DTO_WebArticle model);
        DataResult getWebDetailById(DTO_Id model);
        DataResult updateWebArticle(DTO_Id model);
        DataResult getSearchArticles(DTO_KeyWords model);
        DataResult updateArticleLikes(DTO_UidAid model);
        DataResult getUidAid(DTO_UidAid model);
        DataResult cancelArticleLikes(DTO_UidAid model);
        DataResult getMyArticleLikes(DTO_UidPage model);
    }
}
