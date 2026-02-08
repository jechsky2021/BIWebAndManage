namespace DTO
{
    public enum ResultSign
    {
        Error = 0,
        Success = 1,
        BeNull = 2   //执行成功，但数据为空
    }

    public class DataResult
    {
        public string sign { get; set; } = "";

        public string msg { get; set; } = "";

        public object data { get; set; } = "";

        public static DataResult GetDataResult(ResultSign sign, string msg, string jsonStr)
        {
            DataResult dataResult = new DataResult();
            dataResult.sign = ((int)sign).ToString();
            dataResult.msg = msg;
            dataResult.data = jsonStr;

            return dataResult;
        }

        public static DataResult GetDataResult(ResultSign sign, string msg, object jsonStr)
        {
            DataResult dataResult = new DataResult();
            dataResult.sign = ((int)sign).ToString();
            dataResult.msg = msg;
            dataResult.data = jsonStr;

            return dataResult;
        }
    }
}
