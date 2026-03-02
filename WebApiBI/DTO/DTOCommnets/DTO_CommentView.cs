using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.DTOCommnets
{
    public class DTO_CommentView:DTO_Comment
    {
        public string uName { get; set; } = string.Empty;
        public string uOccupation { get; set; } = string.Empty;
        public string uAvatar { get; set; } = string.Empty;
    }
}
