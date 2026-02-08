using System;
using System.Collections.Generic;
using System.Text;

namespace DTO
{
    public class DTO_Page
    {
        int pageIndex = 0;
        public int pageNumber { get{ return (pageIndex - 1) * pageSize; } set { pageIndex = value; } }
        public int pageSize { get; set; }
        public DateTime createTime { get; set; }
    }
}
