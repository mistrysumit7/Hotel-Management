using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace Hotel_Management.DAL
{
    public class BookingDetail
    {
        public string constring = "";
        public BookingDetail()
        {
            //constring = "Data Source=DESKTOP-U75KJUG;Initial Catalog=HOTEL_P;User ID=sa;Password=sa";
            constring = System.Configuration.ConfigurationSettings.AppSettings["constring"].ToString();
        }
        public DataTable GetProofType()
        {
            try
            {
                SqlDataAdapter adp = new SqlDataAdapter("Proof_List_Get", constring);
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
        public DataTable GetRoomList(int RoomId)
        {
            try
            {
                SqlDataAdapter adp = new SqlDataAdapter("Room_List_Get", constring);
                SqlParameter param = new SqlParameter();
                param.ParameterName = "@RoomId";
                param.Value = RoomId;
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
        public DataTable GetBookingType(int bookingTypeId)
        {
            try
            {
                SqlDataAdapter adp = new SqlDataAdapter("BookingStatus_List_Get", constring);
                SqlParameter param = new SqlParameter();
                param.ParameterName = "@BookingTypeId";
                param.Value = bookingTypeId;
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
        public int New_Booking(BookingEntity bookinEntity)
        {
            try
            {
                int bookingId = 0;
                SqlConnection sqlcon = new SqlConnection(constring);
                SqlCommand cmd = new SqlCommand("Booking_Insert", sqlcon);

                cmd.Parameters.AddWithValue("@CustomerID", bookinEntity.CustomerID);
                cmd.Parameters.AddWithValue("@RoomID", bookinEntity.RoomID);
                cmd.Parameters.AddWithValue("@BookedFrom", bookinEntity.BookedFrom);
                cmd.Parameters.AddWithValue("@BookedTo", bookinEntity.BookedTo);
                cmd.Parameters.AddWithValue("@BookedBy", bookinEntity.BookedBy);
                cmd.Parameters.AddWithValue("@BookingTypeID", bookinEntity.BookingTypeID);
                cmd.Parameters.AddWithValue("@RoomPrice", bookinEntity.RoomPrice);
                cmd.Parameters.AddWithValue("@Notes", bookinEntity.BookingNotes);
                cmd.Parameters.AddWithValue("@IsSingle", bookinEntity.IsSingle);
                cmd.Parameters.AddWithValue("@GstTax", bookinEntity.GSTTax);
                cmd.Parameters.Add("@Booking_id", SqlDbType.Int);
                cmd.Parameters["@Booking_id"].Direction = ParameterDirection.Output;

                cmd.CommandType = CommandType.StoredProcedure;
                sqlcon.Open();

                cmd.ExecuteNonQuery();
                bookingId = Convert.ToInt32(cmd.Parameters["@Booking_id"].Value.ToString());
                sqlcon = null;
                cmd = null;
                bookinEntity = null;
                return bookingId;
            }
            catch (Exception ex)
            { throw ex; }
        }
        public int New_Customer(CustomerEntity CustomerEntity, char status)
        {
            try
            {
                int customerId = 0;
                SqlConnection sqlcon = new SqlConnection(constring);
                SqlCommand cmd = new SqlCommand();
                if (status == 'I')
                {
                    cmd = new SqlCommand("New_Customer_Insert", sqlcon);
                    cmd.Parameters.Add("@Customer_ID", SqlDbType.Int);
                    cmd.Parameters["@Customer_ID"].Direction = ParameterDirection.Output;
                }
                else
                {
                    cmd = new SqlCommand("Customer_Update", sqlcon);
                    cmd.Parameters.AddWithValue("@Customer_ID", CustomerEntity.CustomerID);
                    cmd.Parameters.AddWithValue("@BillNumber", CustomerEntity.BillNumber);
                    cmd.Parameters.AddWithValue("@BillingDate", CustomerEntity.BillingDate.ToString().Trim() == "" ? null : CustomerEntity.BillingDate);
                }

                cmd.Parameters.AddWithValue("@CustomerName", CustomerEntity.CustomerName);
                cmd.Parameters.AddWithValue("@CustomerAddress", CustomerEntity.CustomerAddress);
                cmd.Parameters.AddWithValue("@CustomerProfTypeId", CustomerEntity.CustomerProfTypeID);
                cmd.Parameters.AddWithValue("@NoOfAdultPerson", CustomerEntity.NoOfAdultPerson);
                cmd.Parameters.AddWithValue("@NoOfChild", CustomerEntity.NoOfChild);
                cmd.Parameters.AddWithValue("@CustomerProofNumer", CustomerEntity.CustomerProofNumer);
                cmd.Parameters.AddWithValue("@CustomerArrival", CustomerEntity.CustomerArrival);
                cmd.Parameters.AddWithValue("@CustomerDeparture", CustomerEntity.CustomerDeparture);
                cmd.Parameters.AddWithValue("@Nationality", CustomerEntity.Nationality);
                cmd.Parameters.AddWithValue("@Age", CustomerEntity.Age);
                cmd.Parameters.AddWithValue("@Email", CustomerEntity.Email);
                cmd.Parameters.AddWithValue("@Phone", CustomerEntity.Phone);
                cmd.Parameters.AddWithValue("@Company", CustomerEntity.CompanyName);
                cmd.Parameters.AddWithValue("@CompanyGST", CustomerEntity.CompanyGST);
                //cmd.Parameters.Add("@Customer_ID", SqlDbType.Int);
                //cmd.Parameters["@Customer_ID"].Direction = ParameterDirection.Output;

                cmd.CommandType = CommandType.StoredProcedure;
                sqlcon.Open();

                cmd.ExecuteNonQuery();
                if (status == 'I')
                {
                    customerId = Convert.ToInt32(cmd.Parameters["@Customer_ID"].Value.ToString());
                }
                sqlcon = null;
                cmd = null;
                CustomerEntity = null;
                return customerId;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public int Insert_CashHistory(CashEntity cashEntity)
        {
            try
            {
                SqlConnection sqlcon = new SqlConnection(constring);
                SqlCommand cmd = new SqlCommand();
                if (cashEntity.Cash_History_Id == 0)
                {
                    cmd = new SqlCommand("New_CashHistory_Insert", sqlcon);
                    cmd.Parameters.Add("@Cash_Booking_History_id", SqlDbType.Int);
                    cmd.Parameters["@Cash_Booking_History_id"].Direction = ParameterDirection.Output;
                }
                else
                {
                    cmd = new SqlCommand("CashHistory_Update", sqlcon);
                    cmd.Parameters.AddWithValue("@Cash_history_id", cashEntity.Cash_History_Id);
                }
                int cashHistoryId = 0;
                cmd.Parameters.AddWithValue("@Total_Amount", cashEntity.Total_Amount);
                cmd.Parameters.AddWithValue("@Discount_given", cashEntity.Discount_given);
                cmd.Parameters.AddWithValue("@Discount_Amount", cashEntity.Discount_Amount);
                cmd.Parameters.AddWithValue("@Luxury_Tax", cashEntity.Luxury_Tax);
                cmd.Parameters.AddWithValue("@Service_Tax", cashEntity.Service_Tax);
                //cmd.Parameters.AddWithValue("@Paid_Amount", cashEntity.Paid_Amount);
                ///cmd.Parameters.AddWithValue("@Due_Amount", cashEntity.Due_Amount);
                cmd.Parameters.AddWithValue("@FinalPrice", cashEntity.FinalPrice);
                //cmd.Parameters.AddWithValue("@BookingMaster_Id", cashEntity.BookingMaster_Id);
                cmd.Parameters.AddWithValue("@Customer_Id", cashEntity.Customer_Id);

                cmd.CommandType = CommandType.StoredProcedure;
                sqlcon.Open();

                cmd.ExecuteNonQuery();
                //cmd.Parameters["@Cash_Booking_History_id"].Direction = ParameterDirection.Output;
                if (cashEntity.Cash_History_Id == 0)
                {
                    cashHistoryId = Convert.ToInt32(cmd.Parameters["@Cash_Booking_History_id"].Value.ToString());
                }
                else
                {
                    cashHistoryId = cashEntity.Cash_History_Id;
                }
                sqlcon = null;
                cmd = null;
                return cashHistoryId;
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
        
        public DataSet GetPaymentListWithPaidDueAmount_By_CashHistoryId(int cashHistoryId)
        {
            try
            {
                SqlDataAdapter adp = new SqlDataAdapter("Get_Payment_Detail", constring);
                adp.SelectCommand.Parameters.AddWithValue("@Cash_Booking_History_Id", cashHistoryId);
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

        public DataSet GetCustomerBookingDetailByID(int CustomerBookingDetailId)
        {
            try
            {
                SqlDataAdapter adp = new SqlDataAdapter("Get_Customer_Booking_Detail_by_CustomerBookingDetailID", constring);
                adp.SelectCommand.Parameters.AddWithValue("@CustomerBookingDetailID", CustomerBookingDetailId);
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

        public void UpdateBookingStatus(int customerId, int bookingTypeId)
        {
            try
            {
                SqlConnection sqlcon = new SqlConnection(constring);
                SqlCommand cmd = new SqlCommand("Update_Booking_Status", sqlcon);

                cmd.Parameters.AddWithValue("@CustomerID", customerId);
                cmd.Parameters.AddWithValue("@BookingTypeId", bookingTypeId);

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

        public void DeleteCustomerBookingDetails(int CustomerBookingDetailID)
        {
            try
            {
                SqlConnection sqlcon = new SqlConnection(constring);
                SqlCommand cmd = new SqlCommand("DeleteBookedRoomDetail", sqlcon);
                cmd.Parameters.AddWithValue("@CustomerBookingDetailID", CustomerBookingDetailID);
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

        public int GetCashHistoryIdFromCustomerId(int customerId)
        {
            try
            {
                SqlDataAdapter adp = new SqlDataAdapter("GET_CashHistoryId_From_CustomerId", constring);
                adp.SelectCommand.Parameters.AddWithValue("@CustomerId", customerId);
                adp.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataTable dt = new DataTable();
                adp.Fill(dt);
                adp = null;
                if (dt.Rows.Count > 0)
                {
                    return Convert.ToInt32(dt.Rows[0]["cash history id"].ToString());
                }
                return 0;
            }
            catch (Exception ex)
            { throw ex; }
        }

        public int GetCustomerBookingDetailIdFromCustomerId(int customerId)
        {
            try
            {
                SqlDataAdapter adp = new SqlDataAdapter("Get_CustomerBookingDetailId_From_CustomerId", constring);
                adp.SelectCommand.Parameters.AddWithValue("@CustomerId", customerId);
                adp.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataTable dt = new DataTable();
                adp.Fill(dt);
                adp = null;
                if (dt.Rows.Count > 0)
                {
                    return Convert.ToInt32(dt.Rows[0]["CustomerBookingDetailID"].ToString());
                }
                return 0;
            }
            catch (Exception ex)
            { throw ex; }
        }

        public bool ChkIsPaymentComplete(int cashHistoryId)
        {
            try
            {
                SqlConnection sqlcon = new SqlConnection(constring);
                SqlCommand cmd = new SqlCommand("Chk_IsClearAmount", sqlcon);

                cmd.Parameters.AddWithValue("@CashHistoryId", cashHistoryId);
                
                cmd.CommandType = CommandType.StoredProcedure;
                sqlcon.Open();

                bool result = Convert.ToBoolean(cmd.ExecuteScalar());
                sqlcon = null;
                cmd = null;
                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int GetGSTTaxFromTarrif(int TarrifVAlue)
        {
            try
            {
                SqlDataAdapter adp = new SqlDataAdapter("GetGSTPercentage", constring);
                adp.SelectCommand.Parameters.AddWithValue("@Roomtarrif", TarrifVAlue);
                adp.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataTable dt = new DataTable();
                adp.Fill(dt);
                adp = null;
                if (dt.Rows.Count > 0)
                {
                    return Convert.ToInt32(dt.Rows[0]["TaxValue"].ToString());
                }
                return 0;
            }
            catch (Exception ex)
            { throw ex; }
        }
    }
}

namespace Hotel_Management.DAL
{
    public class BookingEntity
    {
        public int CustomerBookingDetailID { get; set; }
        public int CustomerID { get; set; }
        public int RoomID { get; set; }
        public DateTime? BookedFrom { get; set; }
        public DateTime? BookedTo { get; set; }
        public string BookedBy { get; set; }
        public int BookingTypeID { get; set; }
        public Int32 RoomPrice { get; set; }
        public string BookingNotes { get; set; }
        public bool IsSingle { get; set; }

        public DateTime? CheckInDate { get; set; }
        public DateTime? CheckOutDate { get; set; }
        public DateTime? BookingDate { get; set; }
        
        public int? GSTTax { get; set; }
    }
}

namespace Hotel_Management.DAL
{
    public class CustomerEntity
    {
        public int CustomerID { get; set; }
        public string CustomerName { get; set; }
        public string CustomerAddress { get; set; }
        public int CustomerProfTypeID { get; set; }
        public int NoOfAdultPerson { get; set; }
        public int NoOfChild { get; set; }
        public string CustomerProofNumer { get; set; }
        public string CustomerArrival { get; set; }
        public string CustomerDeparture { get; set; }
        public string Nationality { get; set; }
        public int Age { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string BillNumber { get; set; }
        public DateTime? BillingDate { get; set; }

        public string CompanyName { get; set; }
        public string CompanyGST { get; set; }
 
    }
}

namespace Hotel_Management.DAL
{
    public class CashEntity
    {
        public int Cash_History_Id { get; set; }
        public double Total_Amount { get; set; }
        public int Discount_given { get; set; }
        public double Discount_Amount { get; set; }
        //public int Paid_Amount { get; set; }
        //public int Due_Amount { get; set; }
        public double FinalPrice { get; set; }
        public int BookingMaster_Id { get; set; }
        public int Customer_Id { get; set; }

        public double Luxury_Tax { get; set; }
        public double Service_Tax { get; set; }
    }
}

namespace Hotel_Management.DAL
{
    public class CashHistoryDetailEntity
    {
        public int Cash_History_Id { get; set; }
        public double Paid_Amount { get; set; }
        public double Due_Amount { get; set; }
        public int Payment_Mode_id { get; set; }
        public int cash_history_detail_Id { get; set; }
    }
}
