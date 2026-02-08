using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Reflection;

namespace DataAccess
{
	public class DynamicMethodHandler
	{
		public DynamicMethodHandler()
		{

		}

		/// <summary>
		/// 通过对象获取参数
		/// </summary>
		/// <typeparam name="T"></typeparam>
		/// <param name="t"></param>
		/// <returns></returns>
		public MySqlParameter[] GetParmsByObject<T>(T t)
		{
			MySqlParameter[] msp = getParms<T>(t);
			return msp;
		}

		private MySqlParameter[] getParms<T>(T t)
		{
			Type type = typeof(T);
			PropertyInfo[] properties = type.GetProperties(BindingFlags.Instance | BindingFlags.Public);

			List<MySqlParameter> list_pm = new List<MySqlParameter>();

			for (int i = 0; i < properties.Length; i++)
			{
				PropertyInfo pi = properties[i];
				if (!pi.IsDefined(typeof(NoMappingAttribute)))
				{
					object valu = pi.GetValue(t, null);
					MySqlParameter mp = new MySqlParameter("@" + properties[i].Name, SD_ChanageType(valu, pi.PropertyType));
					list_pm.Add(mp);
				}
			}

			return list_pm.ToArray();
		}
		public Tuple<List<MySqlParameter>, List<MySqlParameter>> GetParmsByObject<T, V>(T t, V v)
		{
			Tuple<List<MySqlParameter>, List<MySqlParameter>> msp = getParms<T, V>(t, v);
			return msp;
		}
		private Tuple<List<MySqlParameter>, List<MySqlParameter>> getParms<T, V>(T t, V v)
		{
			Type type = typeof(T);
			PropertyInfo[] properties = type.GetProperties(BindingFlags.Instance | BindingFlags.Public);

			List<MySqlParameter> list_pm = new List<MySqlParameter>();

			for (int i = 0; i < properties.Length; i++)
			{
				PropertyInfo pi = properties[i];
				object valu = pi.GetValue(t, null);
				MySqlParameter mp = new MySqlParameter("@" + properties[i].Name, SD_ChanageType(valu, pi.PropertyType));
				list_pm.Add(mp);

			}
			// 输出
			Type Vtype = typeof(V);
			PropertyInfo[] propertiesV = Vtype.GetProperties(BindingFlags.Instance | BindingFlags.Public);

			List<MySqlParameter> list_pmV = new List<MySqlParameter>();
			for (int i = 0; i < propertiesV.Length; i++)
			{
				PropertyInfo pi = propertiesV[i];
				object valu = pi.GetValue(v, null);
				MySqlParameter mp = new MySqlParameter("@" + propertiesV[i].Name, SD_ChanageType(valu, pi.PropertyType));
				mp.Direction = ParameterDirection.Output;
				list_pm.Add(mp);
				list_pmV.Add(mp);
			}
			Tuple<List<MySqlParameter>, List<MySqlParameter>> tuple = new Tuple<List<MySqlParameter>, List<MySqlParameter>>(list_pm, list_pmV);

			return tuple;
		}

		public object? SD_ChanageType(object value, Type convertsionType)
		{
			//判断convertsionType类型是否为泛型，因为nullable是泛型类,
			if (convertsionType.IsGenericType &&
				//判断convertsionType是否为nullable泛型类
				convertsionType.GetGenericTypeDefinition().Equals(typeof(Nullable<>)))
			{
				if (value == null || value.ToString().Length == 0)
				{
					return null;
				}

				//如果convertsionType为nullable类，声明一个NullableConverter类，该类提供从Nullable类到基础基元类型的转换
				NullableConverter nullableConverter = new NullableConverter(convertsionType);
				//将convertsionType转换为nullable对的基础基元类型
				convertsionType = nullableConverter.UnderlyingType;
			}
			return Convert.ChangeType(value, convertsionType);
		}


	}
}
