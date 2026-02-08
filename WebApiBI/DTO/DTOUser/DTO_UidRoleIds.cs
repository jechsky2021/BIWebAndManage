using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.DTOUser
{
    public class DTO_UidRoleIds
    {
        public long id {  get; set; }
        public List<long> roleIds { get; set; } = new List<long>();
    }
}
