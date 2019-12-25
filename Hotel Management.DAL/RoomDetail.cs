using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace Hotel_Management.DAL
{
    public class RoomDetail
    {
        public string constring = "";
        public RoomDetail()
        {
            //constring = "Data Source=DESKTOP-U75KJUG;Initial Catalog=HOTEL_P;User ID=HMSQL;Password=sa";
            constring = System.Configuration.ConfigurationSettings.AppSettings["constring"].ToString();
        }
        public DataSet GetAllRoomsAvailability()
        {
            try
            {
                SqlDataAdapter adp = new SqlDataAdapter("Get_All_NonAvailable_Rooms", constring);
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
        public RoomDetailEntity GetRoomDetailByRoomID(int roomID)
        {
            RoomDetailEntity roomDetilEntity;
            try
            {
                SqlConnection con = new SqlConnection(constring);
                con.Open();
                SqlCommand cmd = new SqlCommand("Get_Room_Detail_by_RoomID", con);
                cmd.Parameters.AddWithValue("@RoomID", roomID);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataReader reader = cmd.ExecuteReader();

                roomDetilEntity = new RoomDetailEntity();
                while (reader.Read())
                {
                    roomDetilEntity.Room_id = roomID;
                    roomDetilEntity.Room_No = reader["Room_No"].ToString();
                    roomDetilEntity.Room_Type = reader["RoomType_Name"].ToString();
                    roomDetilEntity.Room_Type = reader["Room_TypeId"].ToString();
                    //roomDetilEntity.Room_Base_Rate = Convert.ToDecimal(reader["Room_BaseRate"]);
                    //roomDetilEntity.Room_Avg_Rate = Convert.ToDecimal(reader["Room_AvgRate"]);
                }
                con.Close();
                return roomDetilEntity;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }
        public void Insert_RoomMaster(RoomMasterEntity roomMasterEntity)
        {
            try
            {
                SqlConnection sqlcon = new SqlConnection(constring);
                SqlCommand cmd = new SqlCommand("Room_Insert", sqlcon);

                cmd.Parameters.AddWithValue("@Room_No", roomMasterEntity.Room_No);
                cmd.Parameters.AddWithValue("@Room_TypeId", roomMasterEntity.Room_TypeId);
                cmd.Parameters.AddWithValue("@Room_Status", roomMasterEntity.Room_Status);
                cmd.Parameters.AddWithValue("@Room_SingleRate", roomMasterEntity.Room_SingleRate);
                cmd.Parameters.AddWithValue("@Room_DoubleRate", roomMasterEntity.Room_DoubleRate);
                cmd.Parameters.AddWithValue("@Room_Active", roomMasterEntity.Room_Active);

                cmd.CommandType = CommandType.StoredProcedure;
                sqlcon.Open();
                cmd.ExecuteNonQuery();
                sqlcon = null;
                cmd = null;
                roomMasterEntity = null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void Update_RoomMaster(RoomMasterEntity roomMasterEntity)
        {
            try
            {
                SqlConnection sqlcon = new SqlConnection(constring);
                SqlCommand cmd = new SqlCommand("Room_Update", sqlcon); 
                cmd.Parameters.AddWithValue("@Room_id", roomMasterEntity.Room_id);
                cmd.Parameters.AddWithValue("@Room_No", roomMasterEntity.Room_No);
                cmd.Parameters.AddWithValue("@Room_TypeId", roomMasterEntity.Room_TypeId);
                cmd.Parameters.AddWithValue("@Room_Status", roomMasterEntity.Room_Status);
                cmd.Parameters.AddWithValue("@Room_SingleRate", roomMasterEntity.Room_SingleRate);
                cmd.Parameters.AddWithValue("@Room_DoubleRate", roomMasterEntity.Room_DoubleRate);
                cmd.Parameters.AddWithValue("@Room_Active", roomMasterEntity.Room_Active);

                cmd.CommandType = CommandType.StoredProcedure;
                sqlcon.Open();
                cmd.ExecuteNonQuery();
                sqlcon = null;
                cmd = null;
                roomMasterEntity = null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataTable getRoomMasterList()
        {
            try
            {
                SqlConnection con = new SqlConnection(constring);
                SqlDataAdapter adp = new SqlDataAdapter("RoomMaster_List_Get", con);
                adp.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataTable dtRoom = new DataTable();
                adp.Fill(dtRoom);
                if (dtRoom.Rows.Count > 0)
                {
                    return dtRoom;
                }
                else
                {
                    return null;
                }
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        public DataTable getRoomTypeList(int roomType)
        {
            try
            {
                SqlConnection con = new SqlConnection(constring);
                SqlDataAdapter adp = new SqlDataAdapter("Room_Type_Get", con);
                adp.SelectCommand.CommandType = CommandType.StoredProcedure;
                adp.SelectCommand.Parameters.AddWithValue("@RoomTypeId", roomType);
                DataTable dtRoom = new DataTable();
                adp.Fill(dtRoom);
                if (dtRoom.Rows.Count > 0)
                {
                    return dtRoom;
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

namespace Hotel_Management.DAL
{
    public class RoomDetailEntity
    {
        public int Room_id { get; set; }
        public string Room_No { get; set; }
        public DateTime Booking_date { get; set; }
        public DateTime Booking_date_from { get; set; }
        public DateTime Booking_date_to { get; set; }
        public string Booked_for { get; set; }
        public string Booked_By { get; set; }
        public string Room_Type { get; set; }
        public decimal Room_Base_Rate { get; set; }
        public decimal Room_Avg_Rate { get; set; }
    }

    public class RoomMasterEntity
    {
        public int Room_id { get; set; }
        public string Room_No { get; set; }
        public int Room_TypeId { get; set; }
        public string Room_Status { get; set; }
        public int Room_SingleRate { get; set; }
        public int Room_DoubleRate { get; set; }
        public bool Room_Active { get; set; }
        public int Room_BookingStatus { get; set; }
    }
}

