using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.DTOTopics
{
    public class DTO_Topic
    {
        public long id { get; set; }

        public string title { get; set; } = string.Empty;
        public string content { get; set; } = string.Empty;
        public long uId { get; set; }
        public long likes { get; set; }

        public long pageViews { get; set; }
    }
}
