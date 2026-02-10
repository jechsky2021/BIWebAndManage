using DTO;
using DTO.Article;
using DTO.WebArticle;
using System;
using System.Collections.Generic;
using System.Text;

namespace ProfessionalLogic.WebArticles
{
    public interface IWebArticleBaseService
    {
        DataResult getWebArticleByPage(DTO_WebArticle model);
        DataResult getWebDetailById(DTO_Id model);
        DataResult updateWebArticle(DTO_Article model);
    }
}
