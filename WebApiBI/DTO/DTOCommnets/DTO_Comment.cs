using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.DTOCommnets
{
    public class DTO_Comment:DTO_Page
    {
        public long id { get; set; }
        public long topicId { get; set; }
        public long uId { get; set; }
        public string content { get; set; } = string.Empty;
        public long parentId { get; set; }
        public string likes { get; set; } = string.Empty;
    }
}
