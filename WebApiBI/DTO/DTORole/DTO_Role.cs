using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.DTORole
{
    public class DTO_Role:DTO_Page
    {
        public long id { get; set; }
        public string rName { get; set; } = string.Empty;
        public string rRemark { get; set; } = string.Empty;
        public bool isChecked { get; set; }
    }
}
