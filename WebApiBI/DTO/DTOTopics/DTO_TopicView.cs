using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.DTOTopics
{
    public class DTO_TopicView : DTO_Topic
    {
        public string uName { get; set; } = string.Empty;
        public string uOccupation { get; set; } = string.Empty;
        public string uAvatar { get; set; } = string.Empty;
        public long comments { get; set; }
        
        public DateTime createTime { get; set; }
    }
}
