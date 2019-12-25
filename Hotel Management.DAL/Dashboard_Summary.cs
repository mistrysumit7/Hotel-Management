using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace Hotel_Management.DAL
{
    public static class Dashboard_Summary
    {
        public static string constring = string.Empty;
        

        public static DataTable GetTodaysActivity()
        {
            constring = System.Configuration.ConfigurationSettings.AppSettings["constring"].ToString();
            try
            {
                SqlDataAdapter adp = new SqlDataAdapter("Get_Todays_Activity", constring);
                adp.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataTable dt = new DataTable();
                adp.Fill(dt);
                adp = null;
                return dt;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
