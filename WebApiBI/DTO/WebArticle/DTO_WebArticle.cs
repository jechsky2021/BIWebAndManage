using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.WebArticle
{
    public class DTO_WebArticle:DTO_Page
    {
        public long id { get; set; }
        public long articleType { get; set; }
        public int statuss { get; set; } // 0：草稿 1：已发布 2：已下架

        public sbyte isRecommend { get; set; }
        public string? startTime { get; set; }
        public string? endTime { get; set; }
    }
}
