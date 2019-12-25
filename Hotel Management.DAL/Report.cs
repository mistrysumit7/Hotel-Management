using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace Hotel_Management.DAL
{
    public class Report
    {
        public string constring = "";
        public Report()
        {
            constring = System.Configuration.ConfigurationSettings.AppSettings["constring"].ToString();
        }

        public DataTable GeneratReport(string reportType,bool today = false, bool yesterday = false, bool thisweek = false, bool thismonth =false, DateTime? startDate = null, DateTime? endDate = null)
        {
            try
            {
                SqlConnection con = new SqlConnection(constring);
                SqlDataAdapter adp = new SqlDataAdapter("Generate_Report", con);
                adp.SelectCommand.Parameters.AddWithValue("@REPORT_TYPE", reportType);
                adp.SelectCommand.Parameters.AddWithValue("@BY_TODAY", today);
                adp.SelectCommand.Parameters.AddWithValue("@BY_YESTERDAY", yesterday);
                adp.SelectCommand.Parameters.AddWithValue("@BY_WEEK", thisweek);
                adp.SelectCommand.Parameters.AddWithValue("@BY_MONTH", thismonth);
                adp.SelectCommand.Parameters.AddWithValue("@START_DATE", startDate);
                adp.SelectCommand.Parameters.AddWithValue("@END_DATE", endDate);
                adp.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataTable dtReport = new DataTable();
                adp.Fill(dtReport);
                if (dtReport.Rows.Count > 0)
                {
                    return dtReport;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataTable GeneratFoodReport(bool today = false, bool yesterday = false, bool thisweek = false, bool thismonth = false, DateTime? startDate = null, DateTime? endDate = null)
        {
            try
            {
                SqlConnection con = new SqlConnection(constring);
                SqlDataAdapter adp = new SqlDataAdapter("Generate_Food_Bill_Report", con);
                adp.SelectCommand.Parameters.AddWithValue("@BY_TODAY", today);
                adp.SelectCommand.Parameters.AddWithValue("@BY_YESTERDAY", yesterday);
                adp.SelectCommand.Parameters.AddWithValue("@BY_WEEK", thisweek);
                adp.SelectCommand.Parameters.AddWithValue("@BY_MONTH", thismonth);
                adp.SelectCommand.Parameters.AddWithValue("@START_DATE", startDate);
                adp.SelectCommand.Parameters.AddWithValue("@END_DATE", endDate);
                adp.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataTable dtReport = new DataTable();
                adp.Fill(dtReport);
                if (dtReport.Rows.Count > 0)
                {
                    return dtReport;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
