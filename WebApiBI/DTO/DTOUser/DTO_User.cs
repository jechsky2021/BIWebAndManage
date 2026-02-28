using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.DTOUser
{
    public class DTO_User:DTO_Page
    {
        public long id { get; set; }
        public string uName { get; set; } = string.Empty;
        public string oldUPasswords { get; set; } = string.Empty;
        public string uPasswords { get; set; } = string.Empty;
        public string uPhone { get; set; } = string.Empty;
        public string uAvatar { get; set; } = string.Empty;
        public string uOccupation { get; set; } = string.Empty;

    }
}
