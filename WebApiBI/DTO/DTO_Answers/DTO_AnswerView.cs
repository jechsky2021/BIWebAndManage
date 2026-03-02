using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.DTO_Answers
{
    public class DTO_AnswerView : DTO_Answer
    {
        public string uName { get; set; } = string.Empty;
        public string uOccupation { get; set; } = string.Empty;
        public string uAvatar { get; set; } = string.Empty;
    }
}
