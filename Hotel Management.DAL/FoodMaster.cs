using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace Hotel_Management.DAL
{
   public class FoodMaster
    {
        public string constring = "";
        public FoodMaster()
        {
            constring = System.Configuration.ConfigurationSettings.AppSettings["constring"].ToString();
        }
        public void InsertFoodItem(string itemName, string foodType, decimal Amount, string itemCode)
        {
            try
            {
                SqlConnection sqlcon = new SqlConnection(constring);
                SqlCommand cmd = new SqlCommand("Food_Item_INSERT_UPDATE_DELETE", sqlcon);

                cmd.Parameters.AddWithValue("@ItemName", itemName);
                cmd.Parameters.AddWithValue("@FoodType", foodType);
                cmd.Parameters.AddWithValue("@PricePerPc", Amount);
                cmd.Parameters.AddWithValue("@FoodItemCode", itemCode);
                cmd.Parameters.AddWithValue("@FoodItemId", 0);
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

        public void UpdateFoodItem(string itemName, string foodType, decimal Amount, string itemCode, int foodItemId)
        {
            try
            {
                SqlConnection sqlcon = new SqlConnection(constring);
                SqlCommand cmd = new SqlCommand("Food_Item_INSERT_UPDATE_DELETE", sqlcon);

                cmd.Parameters.AddWithValue("@ItemName", itemName);
                cmd.Parameters.AddWithValue("@FoodType", foodType);
                cmd.Parameters.AddWithValue("@PricePerPc", Amount);
                cmd.Parameters.AddWithValue("@FoodItemCode", itemCode);
                cmd.Parameters.AddWithValue("@FoodItemId", foodItemId);
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

        public void DeleteFoodItem(int foodItemId)
        {
            try
            {
                SqlConnection sqlcon = new SqlConnection(constring);
                SqlCommand cmd = new SqlCommand("Food_Item_INSERT_UPDATE_DELETE", sqlcon);

                cmd.Parameters.AddWithValue("@ItemName", "");
                cmd.Parameters.AddWithValue("@FoodType", "");
                cmd.Parameters.AddWithValue("@PricePerPc", 0);
                cmd.Parameters.AddWithValue("@FoodItemCode", "");
                cmd.Parameters.AddWithValue("@FoodItemId", foodItemId);
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

        public DataTable getFoodItemList(int foodItemId)
        {
            try
            {
                SqlConnection con = new SqlConnection(constring);
                SqlDataAdapter adp = new SqlDataAdapter("Food_List_Get", con);
                adp.SelectCommand.Parameters.AddWithValue("@FoodItemId", foodItemId);
                adp.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataTable dtFood = new DataTable();
                adp.Fill(dtFood);
                if (dtFood.Rows.Count > 0)
                {
                    return dtFood;
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
