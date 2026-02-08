using System;
using System.Collections.Generic;
using System.Text;

namespace DTO
{
    public class DTO_ModelPage<T>
    {
        public List<T> lists { get; set; }
        public int total { get; set; }
    }
}
