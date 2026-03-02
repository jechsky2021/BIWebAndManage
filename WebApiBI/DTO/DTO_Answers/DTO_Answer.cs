using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.DTO_Answers
{
    public class DTO_Answer
    {
        public long id { get; set; }
        public long questionId { get; set; }
        public long uId { get; set; }
        public string Content { get; set; } = string.Empty;
        public sbyte isAccepted { get; set; }
        public sbyte status { get; set; }

        public DateTime CreatedAt { get; set; }
    }
}
