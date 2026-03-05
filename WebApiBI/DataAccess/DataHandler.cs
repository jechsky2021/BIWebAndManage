using MySql.Data.MySqlClient;
using Npgsql;
using System;
using System.Collections.Generic;
using System.Data;
using System.Reflection;

namespace DataAccess
{
	public class DataHandler
	{
		// 数据库类型配置
		public static DatabaseType CurrentDatabaseType { get; set; } = DatabaseType.MySQL;

		//执行增、删、改存储过程
		public static int? OperateObject<T>(T t, string procName, OpBase opBase)
		{
			if (CurrentDatabaseType == DatabaseType.MySQL)
			{
				var _dynmHandler = new DynamicMethodHandler();
				var _dataOper = new DataOperate(DatabaseType.MySQL);

				MySqlParameter[] msp = _dynmHandler.GetMySqlParmsByObject<T>(t);
				MySqlConnection? conn = _dataOper.ChoiceMySqlConn(opBase);
				int? e = ExecuteNonQuery(conn, CommandType.StoredProcedure, procName, msp);
				return e;
			}
			else
			{
				var _dynmHandler = new DynamicMethodHandler();
				var _dataOper = new DataOperate(DatabaseType.PostgreSQL);

				NpgsqlParameter[] msp = _dynmHandler.GetPgSqlParmsByObject<T>(t);
				NpgsqlConnection? conn = _dataOper.ChoicePgSqlConn(opBase);
				int? e = ExecuteNonQuery(conn, CommandType.StoredProcedure, procName, msp);
				return e;
			}
		}

		public static Tuple<int?, V> OperateObject<T, V>(T t, V v, string procName, OpBase opBase)
		{
			if (CurrentDatabaseType == DatabaseType.MySQL)
			{
				var _dynmHandler = new DynamicMethodHandler();
				var _dataOper = new DataOperate(DatabaseType.MySQL);

				Tuple<List<MySqlParameter>, List<MySqlParameter>> msp = _dynmHandler.GetMySqlParmsByObject<T, V>(t, v);
				MySqlConnection? conn = _dataOper.ChoiceMySqlConn(opBase);
				int? e = ExecuteNonQuery(conn, CommandType.StoredProcedure, procName, msp.Item1.ToArray());

				// 输出
				Type Vtype = typeof(V);
				PropertyInfo[] propertiesV = Vtype.GetProperties(BindingFlags.Instance | BindingFlags.Public);
				for (int i = 0; i < propertiesV.Length; i++)
				{
					PropertyInfo pi = propertiesV[i];
					foreach (MySqlParameter item in msp.Item2)
					{
						if (item.ParameterName == "@" + pi.Name)
						{
							pi.SetValue(v, item.Value);
						}
					}
				}
				Tuple<int?, V> tuple = new Tuple<int?, V>(e, v);
				return tuple;
			}
			else
			{
				var _dynmHandler = new DynamicMethodHandler();
				var _dataOper = new DataOperate(DatabaseType.PostgreSQL);

				Tuple<List<NpgsqlParameter>, List<NpgsqlParameter>> msp = _dynmHandler.GetPgSqlParmsByObject<T, V>(t, v);
				NpgsqlConnection? conn = _dataOper.ChoicePgSqlConn(opBase);
				int? e = ExecuteNonQuery(conn, CommandType.StoredProcedure, procName, msp.Item1.ToArray());

				// 输出
				Type Vtype = typeof(V);
				PropertyInfo[] propertiesV = Vtype.GetProperties(BindingFlags.Instance | BindingFlags.Public);
				for (int i = 0; i < propertiesV.Length; i++)
				{
					PropertyInfo pi = propertiesV[i];
					foreach (NpgsqlParameter item in msp.Item2)
					{
						if (item.ParameterName == "@" + pi.Name)
						{
							pi.SetValue(v, item.Value);
						}
					}
				}
				Tuple<int?, V> tuple = new Tuple<int?, V>(e, v);
				return tuple;
			}
		}

		// 执行 MySQL 非查询操作
		public static int? ExecuteNonQuery(MySqlConnection? conn, CommandType commType, string commandText, params MySqlParameter[] parms)
		{
			MySqlCommand? comm = null;
			try
			{
				var _dynmHandler = new DynamicMethodHandler();
				var _dataOper = new DataOperate(DatabaseType.MySQL);

				comm = new MySqlCommand();
				comm.CommandType = commType;
				comm.CommandText = commandText;
				int? i = _dataOper.ExecuteNonQuery(conn, comm, parms);
				return i;
			}
			finally
			{
				if (comm != null)
				{
					comm.Dispose();
				}
			}
		}

		// 执行 PostgreSQL 非查询操作
		public static int? ExecuteNonQuery(NpgsqlConnection? conn, CommandType commType, string commandText, params NpgsqlParameter[] parms)
		{
			NpgsqlCommand? comm = null;
			try
			{
				var _dynmHandler = new DynamicMethodHandler();
				var _dataOper = new DataOperate(DatabaseType.PostgreSQL);

				comm = new NpgsqlCommand();
				comm.CommandType = commType;
				comm.CommandText = commandText;
				int? i = _dataOper.ExecuteNonQuery(conn, comm, parms);
				return i;
			}
			finally
			{
				if (comm != null)
				{
					comm.Dispose();
				}
			}
		}

		//执行查询存储过程
		public static DataSet QueryDataSet<T>(T t, string procName, OpBase opBase)
		{
			if (CurrentDatabaseType == DatabaseType.MySQL)
			{
				var _dynmHandler = new DynamicMethodHandler();
				var _dataOper = new DataOperate(DatabaseType.MySQL);
				MySqlConnection? conn = _dataOper.ChoiceMySqlConn(opBase);
				MySqlParameter[] parms = _dynmHandler.GetMySqlParmsByObject<T>(t);
				return ExecuteQueryDataSet(conn, CommandType.StoredProcedure, procName, parms);
			}
			else
			{
				var _dynmHandler = new DynamicMethodHandler();
				var _dataOper = new DataOperate(DatabaseType.PostgreSQL);
				NpgsqlConnection? conn = _dataOper.ChoicePgSqlConn(opBase);
				NpgsqlParameter[] parms = _dynmHandler.GetPgSqlParmsByObject<T>(t);
				return ExecuteQueryDataSet(conn, CommandType.StoredProcedure, procName, parms);
			}
		}

		public static DataTable QueryDataTable<T>(T t, string procName, OpBase opBase)
		{
			DataSet ds = QueryDataSet(t, procName, opBase);
			if (ds != null && ds.Tables.Count > 0)
			{
				return ds.Tables[0];
			}
			else
			{
				return new DataTable();
			}
		}

		public static object ExecuteScalar<T>(T t, string procName, OpBase opBase)
		{
			if (CurrentDatabaseType == DatabaseType.MySQL)
			{
				var _dynmHandler = new DynamicMethodHandler();
				var _dataOper = new DataOperate(DatabaseType.MySQL);

				MySqlParameter[]? parms = null;
				MySqlConnection? conn = _dataOper.ChoiceMySqlConn(opBase);

				parms = _dynmHandler.GetMySqlParmsByObject<T>(t);

#pragma warning disable CS8604 // 引用类型参数可能为 null。
                return ExecuteScalar(conn, CommandType.StoredProcedure, procName, parms);
#pragma warning restore CS8604 // 引用类型参数可能为 null。
            }
			else
			{
				var _dynmHandler = new DynamicMethodHandler();
				var _dataOper = new DataOperate(DatabaseType.PostgreSQL);

				NpgsqlParameter[]? parms = null;
				NpgsqlConnection? conn = _dataOper.ChoicePgSqlConn(opBase);

				parms = _dynmHandler.GetPgSqlParmsByObject<T>(t);

#pragma warning disable CS8604 // 引用类型参数可能为 null。
                return ExecuteScalar(conn, CommandType.StoredProcedure, procName, parms);
#pragma warning restore CS8604 // 引用类型参数可能为 null。
            }
        }

		/// <summary>
		/// 没有参数的存储过程执行方法
		/// </summary>
		/// <param name="procName"></param>
		/// <param name="opBase"></param>
		/// <returns></returns>
		public static DataSet QueryDataSet(string procName, OpBase opBase)
		{
			if (CurrentDatabaseType == DatabaseType.MySQL)
			{
				var _dataOper = new DataOperate(DatabaseType.MySQL);
				MySqlConnection? conn = _dataOper.ChoiceMySqlConn(opBase);
				return ExecuteQueryDataSetByNoParm(conn, CommandType.StoredProcedure, procName);
			}
			else
			{
				var _dataOper = new DataOperate(DatabaseType.PostgreSQL);
				NpgsqlConnection? conn = _dataOper.ChoicePgSqlConn(opBase);
				return ExecuteQueryDataSetByNoParm(conn, CommandType.StoredProcedure, procName);
			}
		}

		public static DataTable QueryDataTable(string procName, OpBase opBase)
		{
			DataSet ds = QueryDataSet(procName, opBase);
			if (ds != null && ds.Tables.Count > 0)
			{
				return ds.Tables[0];
			}
			else
			{
				return new DataTable();
			}
		}

		/// <summary>
		/// 执行SQL语句,返回所有符合条件数据
		/// </summary>
		/// <param name="commandType">命令类型(存储过程,命令文本, 其它.)</param>
		/// <param name="commandText">SQL语句或存储过程名称</param>
		/// <param name="parms">查询参数</param>
		/// <returns>返回影响的行数</returns>
		public static DataSet ExecuteQueryDataSet(MySqlConnection conn, CommandType commandType, string commandText, params MySqlParameter[] parms)
		{
			MySqlCommand? comm = null;
			try
			{
				var _dynmHandler = new DynamicMethodHandler();
				var _dataOper = new DataOperate(DatabaseType.MySQL);

				comm = new MySqlCommand();
				comm.CommandType = commandType;
				comm.CommandText = commandText;
				DataSet o = _dataOper.ExecuteDataSet(conn, comm, parms);
				return o;
			}
			finally
			{
				if (comm != null)
				{
					comm.Dispose();
				}
			}
		}

		public static DataSet ExecuteQueryDataSet(NpgsqlConnection conn, CommandType commandType, string commandText, params NpgsqlParameter[] parms)
		{
			NpgsqlCommand? comm = null;
			try
			{
				var _dynmHandler = new DynamicMethodHandler();
				var _dataOper = new DataOperate(DatabaseType.PostgreSQL);

				comm = new NpgsqlCommand();
				comm.CommandType = commandType;
				comm.CommandText = commandText;
				DataSet o = _dataOper.ExecuteDataSet(conn, comm, parms);
				return o;
			}
			finally
			{
				if (comm != null)
				{
					comm.Dispose();
				}
			}
		}

		public static object ExecuteScalar(MySqlConnection conn, CommandType commandType, string commandText, params MySqlParameter[] parms)
		{
			MySqlCommand? comm = null;
			try
			{
				var _dynmHandler = new DynamicMethodHandler();
				var _dataOper = new DataOperate(DatabaseType.MySQL);

				comm = new MySqlCommand();
				comm.CommandType = commandType;
				comm.CommandText = commandText;
				object o = _dataOper.ExecuteScalar(conn, comm, parms);
				return o;
			}
			finally
			{
				if (comm != null)
				{
					comm.Dispose();
				}
			}
		}

		public static object ExecuteScalar(NpgsqlConnection conn, CommandType commandType, string commandText, params NpgsqlParameter[] parms)
		{
			NpgsqlCommand? comm = null;
			try
			{
				var _dynmHandler = new DynamicMethodHandler();
				var _dataOper = new DataOperate(DatabaseType.PostgreSQL);

				comm = new NpgsqlCommand();
				comm.CommandType = commandType;
				comm.CommandText = commandText;
				object o = _dataOper.ExecuteScalar(conn, comm, parms);
				return o;
			}
			finally
			{
				if (comm != null)
				{
					comm.Dispose();
				}
			}
		}

		/// <summary>
		/// 执行没有参数的存储过程
		/// </summary>
		/// <param name="conn"></param>
		/// <param name="commandType"></param>
		/// <param name="commandText"></param>
		/// <returns></returns>
		public static DataSet ExecuteQueryDataSetByNoParm(MySqlConnection? conn, CommandType commandType, string commandText)
		{
			MySqlCommand? comm = null;
			try
			{
				var _dynmHandler = new DynamicMethodHandler();
				var _dataOper = new DataOperate(DatabaseType.MySQL);
				comm = new MySqlCommand();
				comm.CommandType = commandType;
				comm.CommandText = commandText;
				DataSet o = _dataOper.ExecuteDataSerByNotParms(conn, comm);
				return o;
			}
			finally
			{
				if (comm != null)
				{
					comm.Dispose();
				}
			}
		}

		public static DataSet ExecuteQueryDataSetByNoParm(NpgsqlConnection? conn, CommandType commandType, string commandText)
		{
			NpgsqlCommand? comm = null;
			try
			{
				var _dynmHandler = new DynamicMethodHandler();
				var _dataOper = new DataOperate(DatabaseType.PostgreSQL);
				comm = new NpgsqlCommand();
				comm.CommandType = commandType;
				comm.CommandText = commandText;
				DataSet o = _dataOper.ExecuteDataSerByNotParms(conn, comm);
				return o;
			}
			finally
			{
				if (comm != null)
				{
					comm.Dispose();
				}
			}
		}
	}
}
