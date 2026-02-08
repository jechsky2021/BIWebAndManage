using DTO;
using DTO.Article;
using DTO.ArticleType;
using System;
using System.Collections.Generic;
using System.Text;

namespace ProfessionalLogic.articleTypes
{
    public interface IArticleTypeBaseService
    {
        DataResult getByPage(DTO_ArticleType model);
        DataResult deleteArTById (DTO_Id model);
        DataResult addArT(DTO_ArticleType model);
        DataResult updateArT(DTO_ArticleType model);

    }
}
