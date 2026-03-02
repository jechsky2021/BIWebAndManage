using DTO;
using DTO.DTOCommnets;
using DTO.DTOWebUser;
using System;
using System.Collections.Generic;
using System.Text;

namespace ProfessionalLogic.comments
{
    public interface IWebCommentsBaseService
    {
        DataResult addComments(DTO_Comment model);
        DataResult getCommentsByPage(DTO_Comment model);
    }
}
