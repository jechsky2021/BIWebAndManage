using DTO;
using DTO.DTO_Tags;
using System;
using System.Collections.Generic;
using System.Text;

namespace ProfessionalLogic.tags
{
    public interface IWebTagsBaseService
    {
        DataResult addTag(DTO_Tag model);
        DataResult getAllTags();
        DataResult getTagsByPage(DTO_Tag model);
        DataResult getTagByName(DTO_Name model);
        DataResult getTagById(DTO_Id model);
        DataResult updateTag(DTO_Tag model);
        DataResult deleteTagById(DTO_Id model);
    }
}
