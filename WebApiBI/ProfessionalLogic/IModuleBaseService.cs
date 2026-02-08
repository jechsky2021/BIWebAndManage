using DTO;
using System;
using System.Collections.Generic;
using System.Text;

namespace ProfessionalLogic
{
    public interface IModuleBaseService
    {
        DataResult GetByparams(string nameparams);
    }
}
