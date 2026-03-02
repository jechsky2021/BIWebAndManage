using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.DTO_Questions
{
    public class DTO_Question : DTO_Page
    {
        public long id { get; set; }

        public string title { get; set; } = string.Empty;
        public string content { get; set; } = string.Empty;
        public long uId { get; set; }
        public long pageViews { get; set; }
        public long likes { get; set; }
        public sbyte status { get; set; } //0:待回答,1:已回答,2:已解决

        public string tagIds { get; set; } = string.Empty;

    }
}
