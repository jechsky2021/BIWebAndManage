using MySql.Data.MySqlClient;
using Npgsql;
using System.Data;

namespace DataAccess
{
	public class DataOperate
	{
		public DataConnect? _dataConn = null;
		public DatabaseType DatabaseType { get; set; } = DatabaseType.MySQL;

		public DataOperate()
		{
			if (this._dataConn == null)
			{
				this._dataConn = new DataConnect(DatabaseType);
			}
		}

		public DataOperate(DatabaseType databaseType)
		{
			this.DatabaseType = databaseType;
			if (this._dataConn == null)
			{
				this._dataConn = new DataConnect(databaseType);
			}
		}

		// 获取 MySQL 连接
		public MySqlConnection? ChoiceMySqlConn(OpBase opBase)
		{
			MySqlConnection? conn = null;
			switch (opBase)
			{
				case OpBase.beautyindustry:
					conn = this._dataConn?.MySqlConn;
					break;
			}

			return conn;
		}

		// 获取 PostgreSQL 连接
		public NpgsqlConnection? ChoicePgSqlConn(OpBase opBase)
		{
			NpgsqlConnection? conn = null;
			switch (opBase)
			{
				case OpBase.beautyindustry:
					conn = this._dataConn?.PgSqlConn;
					break;
			}

			return conn;
		}

		// 执行 MySQL 非查询操作
		public int? ExecuteNonQuery(MySqlConnection conn, MySqlCommand comm, params MySqlParameter[] parms)
		{
			comm.Parameters.Clear();
			comm.Connection = conn;
			comm.Parameters.AddRange(parms);
			this._dataConn?.OpenConn(conn);
			try
			{
				var tk = comm.ExecuteNonQuery();
				return tk;
			}
			finally
			{
                this._dataConn?.CloseConn(conn);
			}
		}

		// 执行 PostgreSQL 非查询操作
		public int? ExecuteNonQuery(NpgsqlConnection conn, NpgsqlCommand comm, params NpgsqlParameter[] parms)
		{
			comm.Parameters.Clear();
			comm.Connection = conn;
			comm.Parameters.AddRange(parms);
			this._dataConn?.OpenConn(conn);
			try
			{
				var tk = comm.ExecuteNonQuery();
				return tk;
			}
			finally
			{
                this._dataConn?.CloseConn(conn);
			}
		}

		// 执行 MySQL 查询操作
		public DataSet ExecuteDataSet(MySqlConnection conn, MySqlCommand comm, params MySqlParameter[] parm)
		{
			comm.Parameters.Clear();
			comm.Connection = conn;
			if (parm.Count() > 0)
			{
				comm.Parameters.AddRange(parm);
			}
			try
			{
				MySqlDataAdapter adapter = new MySqlDataAdapter();
				adapter.SelectCommand = comm;
				DataSet ds = new DataSet();
				adapter.Fill(ds);
				return ds; ;
			}
			finally
			{
				this._dataConn?.CloseConn(conn);
			}
		}

		// 执行 PostgreSQL 查询操作
		public DataSet ExecuteDataSet(NpgsqlConnection conn, NpgsqlCommand comm, params NpgsqlParameter[] parm)
		{
			comm.Parameters.Clear();
			comm.Connection = conn;
			if (parm.Count() > 0)
			{
				comm.Parameters.AddRange(parm);
			}
			try
			{
				NpgsqlDataAdapter adapter = new NpgsqlDataAdapter();
				adapter.SelectCommand = comm;
				DataSet ds = new DataSet();
				adapter.Fill(ds);
				return ds; ;
			}
			finally
			{
				this._dataConn?.CloseConn(conn);
			}
		}

		// 执行 MySQL 标量查询
		public object ExecuteScalar(MySqlConnection conn, MySqlCommand comm, params MySqlParameter[] parm)
		{
			comm.Parameters.Clear();
			comm.Connection = conn;
			if (parm.Count() > 0)
			{
				comm.Parameters.AddRange(parm);
			}
			this._dataConn?.OpenConn(conn);
			try
			{
				return comm.ExecuteScalar();
			}
			catch(Exception ex)
			{
				return ex.Message;
			}
			finally
			{
				this._dataConn?.CloseConn(conn);
			}
		}

		// 执行 PostgreSQL 标量查询
		public object ExecuteScalar(NpgsqlConnection conn, NpgsqlCommand comm, params NpgsqlParameter[] parm)
		{
			comm.Parameters.Clear();
			comm.Connection = conn;
			if (parm.Count() > 0)
			{
				comm.Parameters.AddRange(parm);
			}
			this._dataConn?.OpenConn(conn);
			try
			{
				return comm.ExecuteScalar();
			}
			catch(Exception ex)
			{
				return ex.Message;
			}
			finally
			{
				this._dataConn?.CloseConn(conn);
			}
		}

		// 执行无参数的 MySQL 查询
		public DataSet ExecuteDataSerByNotParms(MySqlConnection? conn, MySqlCommand comm)
		{
			comm.Parameters.Clear();
			comm.Connection = conn;
			try
			{
				MySqlDataAdapter adapter = new MySqlDataAdapter();
				adapter.SelectCommand = comm;
				DataSet ds = new DataSet();
				adapter.Fill(ds);
				return ds; ;
			}
			finally
			{
				this._dataConn?.CloseConn(conn);
			}
		}

		// 执行无参数的 PostgreSQL 查询
		public DataSet ExecuteDataSerByNotParms(NpgsqlConnection? conn, NpgsqlCommand comm)
		{
			comm.Parameters.Clear();
			comm.Connection = conn;
			try
			{
				NpgsqlDataAdapter adapter = new NpgsqlDataAdapter();
				adapter.SelectCommand = comm;
				DataSet ds = new DataSet();
				adapter.Fill(ds);
				return ds; ;
			}
			finally
			{
				this._dataConn?.CloseConn(conn);
			}
		}
	}
}
