using Common;
using DTO;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using System.Data;

namespace ProfessionalLogic
{
    public class BaseService
    {
        protected readonly ILogger<BaseService> _logger;

        public BaseService(ILogger<BaseService> logger)
        {
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        public DataResult Select<T>(DataSet result) where T : class, new()
        {
            _logger.LogDebug($"Select started. result:{JsonConvert.SerializeObject(result)}");

            try
            {
                var dataSet = result;
                if (dataSet != null && dataSet.Tables.Count > 0 && dataSet.Tables[0] != null)
                {
                    List<T> lists = ConvertDataTable.DataTableToList<T>(dataSet.Tables[0]);
                    DataResult ds = DataResult.GetDataResult(ResultSign.Success, "获取成功！", lists);
                    _logger.LogDebug($"Select result:{ds}");
                    return ds;
                }
                else
                {
                    _logger.LogWarning("Select returned empty or null tables.");
                    return DataResult.GetDataResult(ResultSign.Success, "获取失败！", dataSet ?? new DataSet());
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Select failed with exception");
                return DataResult.GetDataResult(ResultSign.Error, ex.Message, "");
            }
        }

        public DataResult SelectByPage<T>(DataSet result) where T : class, new()
        {
            try
            {
                // 先检查 result 是否为 null
                if (result == null)
                {
                    _logger.LogWarning("SelectByPageAsync received null DataSet");
                    return DataResult.GetDataResult(ResultSign.Success, "获取失败！", new DataSet());
                }
                
                _logger.LogDebug($"SelectByPageAsync started. DataSet has {result.Tables.Count} tables");
                
                // 检查 DataSet 结构
                if (result.Tables.Count > 0)
                {
                    _logger.LogDebug($"Table 0 has {result.Tables[0].Rows.Count} rows");
                }
                if (result.Tables.Count > 1)
                {
                    _logger.LogDebug($"Table 1 has {result.Tables[1].Rows.Count} rows");
                }

                var dataSet = result;
                if (dataSet?.Tables.Count > 0 && dataSet.Tables[0] != null && dataSet.Tables.Count > 1 && dataSet.Tables[1].Rows.Count != 0)
                {
                    // 尝试转换数据
                    List<T> lists = new List<T>();
                    try
                    {
                        lists = ConvertDataTable.DataTableToList<T>(dataSet.Tables[0]);
                        _logger.LogDebug($"Converted {lists.Count} items from DataTable");
                    }
                    catch (Exception ex)
                    {
                        _logger.LogError(ex, "Failed to convert DataTable to List");
                    }
                    
                    DTO_ModelPage<T> lastest = new DTO_ModelPage<T>()
                    {
                        lists = lists,
                        total = Convert.ToInt32(dataSet.Tables[1].Rows[0]["total"])
                    };
                    DataResult ds = DataResult.GetDataResult(ResultSign.Success, "获取成功！", lastest);
                    _logger.LogDebug($"Select result: {ds}");
                    return ds;
                }
                else
                {
                    _logger.LogWarning($"SelectByPageAsync returned empty or null tables. Tables count: {dataSet?.Tables.Count}, Table 0 rows: {dataSet?.Tables[0]?.Rows.Count}, Table 1 rows: {dataSet?.Tables[1]?.Rows.Count}");
                    return DataResult.GetDataResult(ResultSign.Success, "获取失败！", dataSet ?? new DataSet());
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "SelectByPageAsync failed with exception");
                return DataResult.GetDataResult(ResultSign.Error, ex.Message, "");
            }
        }

        /// <summary>
        /// 操作
        /// </summary>
        public DataResult Operation(int? result)
        {
            try
            {
                _logger.LogDebug($"Operation(int):{JsonConvert.SerializeObject(result)}");
                DataResult ds = DataResult.GetDataResult(ResultSign.Success, "执行成功！", result??0);
                _logger.LogDebug($"Operation result:{ds}");
                return ds;

            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Operation(int) failed with exception");
                return DataResult.GetDataResult(ResultSign.Error, ex.Message, "");
            }
        }
    }
}
