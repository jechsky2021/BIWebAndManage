using DTO;
using DTO.Article;
using System;
using System.Collections.Generic;
using System.Text;

namespace ProfessionalLogic.WebArticles
{
    public interface IWebArticleBaseService
    {
        DataResult getWebArticleByPage(DTO_Article model);
        DataResult getWebDetailById(DTO_Id model);
    }
}
