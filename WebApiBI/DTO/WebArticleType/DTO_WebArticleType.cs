using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.WebArticleType
{
    public class DTO_WebArticleType : DTO_Page
    {
        public long id { get; set; } = 0;
        public string atName { get; set; } = string.Empty;
    }
}
