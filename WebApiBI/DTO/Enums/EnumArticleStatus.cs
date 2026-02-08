using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Text;

namespace DTO.Enums
{
    public enum EnumArticleStatus
    {
        [Description("草稿")]
        Draft = 0,
        [Description("已发布")]
        Published = 1,
        [Description("已下架")]
        Discontinued
    }
}
