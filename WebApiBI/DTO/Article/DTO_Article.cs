using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.Article
{
    public class DTO_Article:DTO_Page
    {
        public long id { get; set; }
        public string title { get; set; } = string.Empty;
        public string author { get; set; } = string.Empty;
        public string introduce { get; set; } = string.Empty;
        public long articleType { get; set; }
        public string atName { get; set; } = string.Empty;
        public string content { get; set; } = string.Empty;
        public int statuss { get; set; } // 0：草稿 1：已发布 2：已下架
        public sbyte isRecommend { get; set; }
        public long pageViews{ get; set; }
        public DateTime? startTime { get; set; }
        public DateTime? endTime { get; set; }
    }
}
