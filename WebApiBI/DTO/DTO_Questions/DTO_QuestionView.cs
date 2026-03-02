using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.DTO_Questions
{
    public class DTO_QuestionView : DTO_Question
    {
        public string tagNames { get; set; } = string.Empty;
        public string uName { get; set; } = string.Empty;
        public string uOccupation { get; set; } = string.Empty;
        public string uAvatar { get; set; } = string.Empty;
        public long answers { get; set; }

        public DateTime createTime { get; set; }
    }
}
