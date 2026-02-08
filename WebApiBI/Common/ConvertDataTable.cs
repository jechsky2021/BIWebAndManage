using System;
using System.Collections.Generic;
using System.Data;
using System.Reflection;
using System.Text;

namespace Common
{
    public class ConvertDataTable
    {
        public static List<T> DataTableToList<T>(DataTable table) where T : class, new()
        {
            List<T> list = new List<T>();

            foreach (DataRow row in table.Rows)
            {
                T obj = new T();
                foreach (PropertyInfo info in obj.GetType().GetProperties())
                {
                    if (table.Columns.Contains(info.Name))
                    {
                        if (row[info.Name] != DBNull.Value)
                        {
                            info.SetValue(obj, row[info.Name], null);
                        }
                    }
                }
                list.Add(obj);
            }
            return list;
        }
    }
}
