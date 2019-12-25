using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace Hotel_Management.DAL
{
   public class CustomerFood
    {
        public string constring = "";
        public CustomerFood()
        {
            constring = System.Configuration.ConfigurationSettings.AppSettings["constring"].ToString();
        }

        public void InsertCustomerFoodItem(int customerId, int foodItemId, int quantity, string roomNo)
        {
            try
            {
                SqlConnection sqlcon = new SqlConnection(constring);
                SqlCommand cmd = new SqlCommand("Customer_Food_Item_INSERT_UPDATE_DELETE", sqlcon);

                cmd.Parameters.AddWithValue("@CustomerId", customerId);
                cmd.Parameters.AddWithValue("@FoodItemId", foodItemId);
                cmd.Parameters.AddWithValue("@Quantity", quantity);
                cmd.Parameters.AddWithValue("@RoomNo", roomNo);
                cmd.Parameters.AddWithValue("@CustomerFoodDetailId", 0);
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

        public void UpdateCustomerFoodItem(int customerFoodDetailId,int customerId, int foodItemId, int quantity, string roomNo)
        {
            try
            {
                SqlConnection sqlcon = new SqlConnection(constring);
                SqlCommand cmd = new SqlCommand("Customer_Food_Item_INSERT_UPDATE_DELETE", sqlcon);

                cmd.Parameters.AddWithValue("@CustomerId", customerId);
                cmd.Parameters.AddWithValue("@FoodItemId", foodItemId);
                cmd.Parameters.AddWithValue("@Quantity", quantity);
                cmd.Parameters.AddWithValue("@RoomNo", roomNo);
                cmd.Parameters.AddWithValue("@CustomerFoodDetailId", customerFoodDetailId);
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

        public void DeleteCustomerFoodItem(int customerFoodDetailId)
        {
            try
            {
                SqlConnection sqlcon = new SqlConnection(constring);
                SqlCommand cmd = new SqlCommand("Customer_Food_Item_INSERT_UPDATE_DELETE", sqlcon);

                cmd.Parameters.AddWithValue("@CustomerId", 0);
                cmd.Parameters.AddWithValue("@FoodItemId", 0);
                cmd.Parameters.AddWithValue("@Quantity", 0);
                cmd.Parameters.AddWithValue("@RoomNo", "");
                cmd.Parameters.AddWithValue("@CustomerFoodDetailId", customerFoodDetailId);
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

        public DataTable getCustomerFoodItemList(int CustomerfoodItemId)
        {
            try
            {
                SqlConnection con = new SqlConnection(constring);
                SqlDataAdapter adp = new SqlDataAdapter("Customer_Food_List_Get", con);
                adp.SelectCommand.Parameters.AddWithValue("@CustomerId", CustomerfoodItemId);
                adp.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataTable dtCustomerFood = new DataTable();
                adp.Fill(dtCustomerFood);
                if (dtCustomerFood.Rows.Count > 0)
                {
                    return dtCustomerFood;
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

        public DataTable getRoomListFromCustomer(int CustomerId)
        {
            try
            {
                SqlConnection con = new SqlConnection(constring);
                SqlDataAdapter adp = new SqlDataAdapter("Room_List_From_CustomerId", con);
                adp.SelectCommand.Parameters.AddWithValue("@CustomerId", CustomerId);
                adp.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataTable dtRoomList = new DataTable();
                adp.Fill(dtRoomList);
                if (dtRoomList.Rows.Count > 0)
                {
                    return dtRoomList;
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
