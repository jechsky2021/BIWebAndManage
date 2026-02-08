
using Microsoft.Extensions.Logging;

namespace ProfessionalLogic
{
    public class ModuleBaseService :BaseService 
    {
        public ModuleBaseService(ILogger<BaseService> logger) : base(logger)
        {
        }

        //public DataResult GetByparams(string nameparams)
        //{

        //    //Task<DataSet> result = DataHandler.QueryDataSetAsync<DTO_Names>(new DTO_Names() { nameparams = nameparams }, ProcName.proc_select, OpBase.beautyindustry);
        //    //return Select(result);
        //}
    }
}
