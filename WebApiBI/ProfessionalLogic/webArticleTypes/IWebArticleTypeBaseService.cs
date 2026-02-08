using DTO;
using DTO.WebArticleType;
using System;
using System.Collections.Generic;
using System.Text;

namespace ProfessionalLogic.webArticleTypes
{
    public interface IWebArticleTypeBaseService
    {
        DataResult getWebArticleTypeByPage(DTO_WebArticleType model);
    }
}
