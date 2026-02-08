using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.ArticleType
{
    public class DTO_ArticleType : DTO_Page
    {
        public long id { get; set; }
        public string atName { get; set; } = string.Empty;
        public long atSort { get; set; }
    }
}
