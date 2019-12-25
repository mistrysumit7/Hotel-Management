using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace Hotel_Management.DAL
{
    public class InvoiceDetail
    {
        public string constring = "";
        public InvoiceDetail()
        {
            //constring = "Data Source=DESKTOP-U75KJUG;Initial Catalog=HOTEL_P;User ID=sa;Password=sa";
            constring = System.Configuration.ConfigurationSettings.AppSettings["constring"].ToString();
        }
        public DataTable GetCustomerListforInvoice(string seachCriteria)
        {
            try
            {
                SqlDataAdapter adp = new SqlDataAdapter("Get_Customer_List_for_Invoice", constring);
                adp.SelectCommand.Parameters.AddWithValue("@search_text", seachCriteria);
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
        public DataSet GenerateInvoiceFromCustomerId(int customerId)
        {
            try
            {
                SqlDataAdapter adp = new SqlDataAdapter("Generate_Invoice", constring);
                adp.SelectCommand.Parameters.AddWithValue("@CustomerId", customerId);
                adp.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataSet ds = new DataSet();
                adp.Fill(ds);
                adp = null;
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet GenerateFoodInvoiceFromCustomerId(int customerId)
        {
            try
            {
                SqlDataAdapter adp = new SqlDataAdapter("Generate_Food_Invoice", constring);
                adp.SelectCommand.Parameters.AddWithValue("@CustomerId", customerId);
                adp.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataSet ds = new DataSet();
                adp.Fill(ds);
                adp = null;
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
