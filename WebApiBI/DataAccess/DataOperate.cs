using MySql.Data.MySqlClient;
using System.Data;

namespace DataAccess
{
	public class DataOperate
	{
		public DataConnect? _dataConn = null;
		public DataOperate()
		{
			if (this._dataConn == null)
			{
				this._dataConn = new DataConnect();
			}
		}

		public MySqlConnection? ChoiceConn(OpBase opBase)
		{
			MySqlConnection? conn = null;
			switch (opBase)
			{
				case OpBase.beautyindustry:
					conn = this._dataConn?.ConnPassWord;
					break;
			}

			return conn;
		}

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
	}
}
