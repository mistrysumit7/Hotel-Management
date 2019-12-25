using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FoodDAL = Hotel_Management.DAL.FoodMaster;

namespace Hotel_Management
{
    public partial class FoodMaster : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Button btnFood = Master.FindControl("btnFood") as Button;
            btnFood.CssClass = "btn btn-outline btn-default active";
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        protected void gvFoodMaster_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                if (e.CommandName == "Modify")
                {
                    txtFoodName.Text = gvFoodMaster.Rows[rowIndex].Cells[0].Text.Trim();
                    txtFoodType.Text = gvFoodMaster.Rows[rowIndex].Cells[1].Text.Trim();
                    txtPrice.Text = gvFoodMaster.Rows[rowIndex].Cells[2].Text.Trim();
                    txtItemCode.Text = gvFoodMaster.Rows[rowIndex].Cells[3].Text.Trim();
                    btnSave.Text = "Update";
                    ViewState["FoodItemId"] = gvFoodMaster.DataKeys[rowIndex]["FoodItemId"].ToString().Trim();
                    mp1.Show();
                }
                if (e.CommandName == "Remove")
                {
                    FoodDAL objFoodDAL = new FoodDAL();
                    objFoodDAL.DeleteFoodItem(Convert.ToInt32(gvFoodMaster.DataKeys[rowIndex]["FoodItemId"].ToString().Trim()));
                    BindGrid();
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void BindGrid()
        {
            try
            {
                FoodDAL objFoodDal = new FoodDAL();
                gvFoodMaster.DataSource = objFoodDal.getFoodItemList(0);
                gvFoodMaster.DataBind();
                objFoodDal = null;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                FoodDAL objFoodDal = new FoodDAL();
                if (btnSave.Text != "Update")
                {
                    objFoodDal.InsertFoodItem(txtFoodName.Text.Trim(), txtFoodType.Text.Trim(), Convert.ToDecimal(txtPrice.Text.Trim()), txtItemCode.Text.Trim());
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "UpdateMsg", "$(document).ready(function(){alert('successfully Inserted.');});", true);
                }
                else
                {
                    objFoodDal.UpdateFoodItem(txtFoodName.Text.Trim(), txtFoodType.Text.Trim(), Convert.ToDecimal(txtPrice.Text.Trim()), txtItemCode.Text.Trim(), Convert.ToInt32(ViewState["FoodItemId"].ToString()));
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "UpdateMsg", "$(document).ready(function(){alert('successfully Updated.');});", true);
                }
                txtFoodName.Text = "";
                txtFoodType.Text = "";
                txtItemCode.Text = "";
                txtPrice.Text = "";
                btnSave.Text = "Save";
                BindGrid();
                mp1.Hide();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}