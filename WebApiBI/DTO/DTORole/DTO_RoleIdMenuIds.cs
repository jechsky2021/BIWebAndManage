using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.DTORole
{
    public class DTO_RoleIdMenuIds
    {
        public long roleId { get; set; }
        public List<long> menuIds { get; set; } = new List<long>();
    }
}
