using DTO;
using DTO.Article;
using DTO.DTOMenu;
using System;
using System.Collections.Generic;
using System.Text;

namespace ProfessionalLogic.articles
{
    public interface IArticleBaseService
    {
        DataResult getDetailById(DTO_Id dTO_Id);
        DataResult getByPage(DTO_Article model);
        DataResult addArt(DTO_Article model);
        DataResult updateArt(DTO_Article model);
        DataResult updateStatus(DTO_Article model);

    }
}
