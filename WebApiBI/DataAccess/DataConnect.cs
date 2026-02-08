using MySql.Data.MySqlClient;
using System;
using System.Data;
using System.Diagnostics;

namespace DataAccess
{
	public class DataConnect
	{
        MySqlConnection _conn;

        readonly string connBeautyIndustry = "Server=127.0.0.1;Port=3306;Database=beautyindustry;Uid=root;Pwd=root;Allow User Variables=True;Convert Zero Datetime=True;";

        private Stopwatch _mWatch;

        public DataConnect()
		{
			this.getConn();
			_mWatch = new Stopwatch();
		}
        public MySqlConnection ConnPassWord
        {
            set { _conn = value; }
            get { return _conn; }
        }
       
        private void getConn()
		{
			try
			{
                if (this._conn == null)
                {
                    this._conn = new MySqlConnection(connBeautyIndustry);
                }

            }
            catch (Exception ex)
			{
				Console.Write(ex.Message);
				throw ex;
			}
		}
		public bool OpenConn(MySqlConnection conn)
		{
			try
			{
				if (conn.State == ConnectionState.Closed)
					conn.Open();

				return true;

			}
			catch (Exception ex)
			{
				Console.Write(ex.Message);
			}
			return false;
		}

		public bool CloseConn(MySqlConnection? conn)
		{
			try
			{
				if (conn?.State != ConnectionState.Closed)
					conn?.Close();

				return true;

			}
			catch (Exception ex)
			{
				Console.Write(ex.Message);
			}
			return false;
		}
	}
}
