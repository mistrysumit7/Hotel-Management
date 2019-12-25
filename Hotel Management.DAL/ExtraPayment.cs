using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
namespace Hotel_Management.DAL
{
   public  class ExtraPayment
    {
        public string constring = "";
        public ExtraPayment()
        {
            //constring = "Data Source=DESKTOP-U75KJUG;Initial Catalog=HOTEL_P;User ID=HMSQL;Password=sa";
            constring = System.Configuration.ConfigurationSettings.AppSettings["constring"].ToString();
        }
        public void InsertExtraPayment(int CustomerId,string chargeType, decimal Amount)
        {
            try
            {
                SqlConnection sqlcon = new SqlConnection(constring);
                SqlCommand cmd = new SqlCommand("Misc_Charge_Insert", sqlcon);

                cmd.Parameters.AddWithValue("@CustomerId", CustomerId);
                cmd.Parameters.AddWithValue("@ChargeType", chargeType);
                cmd.Parameters.AddWithValue("@ChargeAmount", Amount);
                cmd.Parameters.AddWithValue("@Misc_Id", 0);
                cmd.Parameters.AddWithValue("@TranscationType", 'I');
               

                cmd.CommandType = CommandType.StoredProcedure;
                sqlcon.Open();
                cmd.ExecuteNonQuery();
                sqlcon = null;
                cmd = null;
                
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void UpdateExtraPayment(int CustomerId, string chargeType, decimal Amount , int ChargeId)
        {
            try
            {
                SqlConnection sqlcon = new SqlConnection(constring);
                SqlCommand cmd = new SqlCommand("Misc_Charge_Insert", sqlcon);

                cmd.Parameters.AddWithValue("@CustomerId", CustomerId);
                cmd.Parameters.AddWithValue("@ChargeType", chargeType);
                cmd.Parameters.AddWithValue("@ChargeAmount", Amount);
                cmd.Parameters.AddWithValue("@Misc_Id", ChargeId);
                cmd.Parameters.AddWithValue("@TranscationType", 'U');


                cmd.CommandType = CommandType.StoredProcedure;
                sqlcon.Open();
                cmd.ExecuteNonQuery();
                sqlcon = null;
                cmd = null;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void DeleteExtraPayment(int ChargeId)
        {
            try
            {
                SqlConnection sqlcon = new SqlConnection(constring);
                SqlCommand cmd = new SqlCommand("Misc_Charge_Insert", sqlcon);

                cmd.Parameters.AddWithValue("@CustomerId", 0);
                cmd.Parameters.AddWithValue("@ChargeType", "");
                cmd.Parameters.AddWithValue("@ChargeAmount", 0);
                cmd.Parameters.AddWithValue("@Misc_Id", ChargeId);
                cmd.Parameters.AddWithValue("@TranscationType", 'D');


                cmd.CommandType = CommandType.StoredProcedure;
                sqlcon.Open();
                cmd.ExecuteNonQuery();
                sqlcon = null;
                cmd = null;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataTable getExtraPaymentList(int customerId)
        {
            try
            {
                SqlConnection con = new SqlConnection(constring);
                SqlDataAdapter adp = new SqlDataAdapter("Misc_Charge_List_Get", con);
                adp.SelectCommand.Parameters.AddWithValue("@Customer", customerId);
                adp.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataTable dtPayment = new DataTable();
                adp.Fill(dtPayment);
                if (dtPayment.Rows.Count > 0)
                {
                    return dtPayment;
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

