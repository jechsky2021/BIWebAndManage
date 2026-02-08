using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.DTOMenu
{
    public class DTO_Menu
    {
        public long id { get; set; }
        public string mName { get; set; } = string.Empty;
        public string mIcon { get; set; } = string.Empty;
        public string mRoute { get; set; } = string.Empty;
        public long mParentId { get; set; }
        public long mSort { get; set; }
        public bool isChecked { get; set; }
    }
}
