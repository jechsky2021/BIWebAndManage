﻿﻿﻿using MySql.Data.MySqlClient;
using Npgsql;
using System.Data;
using System.Diagnostics;

namespace DataAccess
{
	public class DataConnect
	{
        // MySQL 连接
        MySqlConnection _mySqlConn;
        readonly string mySqlConnBeautyIndustry = "Server=127.0.0.1;Port=3306;Database=beautyindustry;Uid=root;Pwd=root;Allow User Variables=True;Convert Zero Datetime=True;Charset=utf8mb4;";

        // PostgreSQL 连接
        NpgsqlConnection _pgSqlConn;
        readonly string pgSqlConnBeautyIndustry = "Host=pgm-uf6dq7f4ft960e5jxo.pg.rds.aliyuncs.com;Port=5432;Database=beautyindustry;Username=hairCareMall;Password=DekeQ6688;";

        private Stopwatch _mWatch;
        public DatabaseType DatabaseType { get; set; } = DatabaseType.MySQL;

        public DataConnect()
		{
			this.getConn();
			_mWatch = new Stopwatch();
		}

        public DataConnect(DatabaseType databaseType)
        {
            this.DatabaseType = databaseType;
            this.getConn();
            _mWatch = new Stopwatch();
        }

        // 获取 MySQL 连接
        public MySqlConnection MySqlConn
        {
            set { _mySqlConn = value; }
            get { return _mySqlConn; }
        }

        // 获取 PostgreSQL 连接
        public NpgsqlConnection PgSqlConn
        {
            set { _pgSqlConn = value; }
            get { return _pgSqlConn; }
        }
       
        private void getConn()
		{
			try
			{
                if (DatabaseType == DatabaseType.MySQL)
                {
                    if (this._mySqlConn == null)
                    {
                        this._mySqlConn = new MySqlConnection(mySqlConnBeautyIndustry);
                    }
                }
                else
                {
                    if (this._pgSqlConn == null)
                    {
                        this._pgSqlConn = new NpgsqlConnection(pgSqlConnBeautyIndustry);
                    }
                }

            }
            catch (Exception ex)
			{
				Console.Write(ex.Message);
				throw ex;
			}
		}

        // 打开 MySQL 连接
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

        // 打开 PostgreSQL 连接
        public bool OpenConn(NpgsqlConnection conn)
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

        // 关闭 MySQL 连接
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

        // 关闭 PostgreSQL 连接
        public bool CloseConn(NpgsqlConnection? conn)
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
