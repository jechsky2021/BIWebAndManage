using DTO;
using DTO.WebArticle;

namespace ProfessionalLogic.WebArticles
{
    public interface IWebArticleBaseService
    {
        DataResult getWebArticleByPage(DTO_WebArticle model);
        DataResult getWebDetailById(DTO_Id model);
        DataResult updateWebArticle(DTO_Id model);
        DataResult getSearchArticles(DTO_KeyWords model);
    }
}
