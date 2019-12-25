using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace Hotel_Management.DAL
{
   public class Admin
    {
        public string constring = "";
        public Admin()
        {
            //constring = "Data Source=DESKTOP-U75KJUG;Initial Catalog=HOTEL_P;User ID=sa;Password=sa";
            constring = System.Configuration.ConfigurationSettings.AppSettings["constring"].ToString();
        }

        public DataSet GetAllDetailByCustomerId(int customerId)
        {
            try
            {
                SqlDataAdapter adp = new SqlDataAdapter("GetAllDetailsByCustomerID", constring);
                adp.SelectCommand.Parameters.AddWithValue("@customer_id", customerId);
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

        public void Update_BookingInfo_byAdmin(BookingEntity bookinEntity)
        {
            try
            {

                SqlConnection sqlcon = new SqlConnection(constring);
                SqlCommand cmd = new SqlCommand("Update_CustomerBookingInfr_By_Admin", sqlcon);

                cmd.Parameters.AddWithValue("@CustomerBookingDetailID", bookinEntity.CustomerBookingDetailID);
                cmd.Parameters.AddWithValue("@RoomID", bookinEntity.RoomID);
                cmd.Parameters.AddWithValue("@BookedFrom", bookinEntity.BookedFrom);
                cmd.Parameters.AddWithValue("@BookedTo", bookinEntity.BookedTo);
                cmd.Parameters.AddWithValue("@BookingDate", bookinEntity.BookingDate);
                cmd.Parameters.AddWithValue("@CheckInDate", bookinEntity.CheckInDate);
                cmd.Parameters.AddWithValue("@CheckOutDate", bookinEntity.CheckOutDate);
                cmd.Parameters.AddWithValue("@RoomPrice", bookinEntity.RoomPrice);


                cmd.CommandType = CommandType.StoredProcedure;
                sqlcon.Open();

                cmd.ExecuteNonQuery();
                sqlcon = null;
                cmd = null;
                bookinEntity = null;
            }
            catch (Exception ex)
            { throw ex; }
        }
        public void Update_CashHistoryDetail(CashHistoryDetailEntity cashEntity)
        {
            try
            {
                SqlConnection sqlcon = new SqlConnection(constring);
                SqlCommand cmd = new SqlCommand("Update_CustomerPaymentHisotry_By_Admin", sqlcon);

                cmd.Parameters.AddWithValue("@Cash_History_Detail_Id", cashEntity.cash_history_detail_Id);
                cmd.Parameters.AddWithValue("@Paid_Amount", cashEntity.Paid_Amount);
                cmd.Parameters.AddWithValue("@Due_Amount", cashEntity.Due_Amount);
                cmd.Parameters.AddWithValue("@Payment_Mode_Id", cashEntity.Payment_Mode_id);

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

        public void Insert_CashHistoryDetail(CashHistoryDetailEntity cashEntity)
        {
            try
            {
                SqlConnection sqlcon = new SqlConnection(constring);
                SqlCommand cmd = new SqlCommand("New_Cash_History_Detail_Insert", sqlcon);

                cmd.Parameters.AddWithValue("@Cash_Booking_History_id", cashEntity.Cash_History_Id);
                cmd.Parameters.AddWithValue("@Paid_Amount", cashEntity.Paid_Amount);
                cmd.Parameters.AddWithValue("@Due_Amount", cashEntity.Due_Amount);
                cmd.Parameters.AddWithValue("@Payment_Mode_Id", cashEntity.Payment_Mode_id);

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
    }
}
