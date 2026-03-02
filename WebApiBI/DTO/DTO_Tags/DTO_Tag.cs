using DTO.DTOUser;
using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.DTO_Tags
{
    public class DTO_Tag:DTO_Page
    {
        public long id { get; set; }
        public string name { get; set; } = string.Empty;
        public string description { get; set; } = string.Empty;

    }
}
