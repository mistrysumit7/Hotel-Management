using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hotel_Management
{
    public partial class FoodInvoice : System.Web.UI.Page
    {
        public int CustomerId
        {
            get
            {
                if (ViewState["CustomerId"] != null)
                    return Convert.ToInt32(ViewState["CustomerId"]);
                else
                    return 0;
            }
            set
            {
                ViewState["CustomerId"] = value;
            }
        }

        public int CustomerFoodId
        {
            get
            {
                if (ViewState["CustomerFoodId"] != null)
                    return Convert.ToInt32(ViewState["CustomerFoodId"]);
                else
                    return 0;
            }
            set
            {
                ViewState["CustomerFoodId"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GenerateFoodInvoice();
            }
        }

        private void GenerateFoodInvoice()
        {
            if (Request.QueryString["CId"] != null)
            {
                CustomerId = Convert.ToInt32(Request.QueryString["CId"]);
                DAL.InvoiceDetail objIvoiceDetail = new DAL.InvoiceDetail();
                DataSet ds = objIvoiceDetail.GenerateFoodInvoiceFromCustomerId(CustomerId);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    FillCustomerInfo(ds.Tables[0]);
                }
                if (ds.Tables[1].Rows.Count > 0)
                {
                    FillRoomCharges(ds.Tables[1]);
                }
                if (ds.Tables[2].Rows.Count > 0)
                {
                    lblBillAmount.Text = ds.Tables[2].Rows[0]["Bill Amount"].ToString();
                }
                if (ds.Tables[3] != null && ds.Tables[3].Rows.Count > 0)
                {
                    lblCGSTFood.Text = ds.Tables[3].Rows[0]["CGST"].ToString().Trim();
                    lblSGSTFood.Text = ds.Tables[3].Rows[0]["SGST"].ToString().Trim();
                }
            }
        }

        private void FillCustomerInfo(DataTable dtCustomerInfo)
        {
            try
            {
                lblCustomerName.Text = dtCustomerInfo.Rows[0]["CustomerName"].ToString();
                lblBillNumber.Text = dtCustomerInfo.Rows[0]["BillNumber"].ToString();
                lblAddress.Text = dtCustomerInfo.Rows[0]["CustomerAddress"].ToString();
                lblDate.Text = Convert.ToDateTime(dtCustomerInfo.Rows[0]["BillingDate"].ToString()).ToString("dd/MM/yyyy");
                if (string.IsNullOrWhiteSpace(dtCustomerInfo.Rows[0]["CompanyName"].ToString()))
                    tdCompanyName.Visible = false;
                if (string.IsNullOrWhiteSpace(dtCustomerInfo.Rows[0]["CompanyGST"].ToString()))
                    tdCompanyGSTName.Visible = false;
                lblCompanyName.Text = dtCustomerInfo.Rows[0]["CompanyName"].ToString();
                lblCompanyGST.Text = dtCustomerInfo.Rows[0]["CompanyGST"].ToString().Trim();
            }
            catch (Exception ex)
            { throw ex; }
        }

        private void FillRoomCharges(DataTable dtChargeInfo)
        {
            try
            {
                gvCharge.DataSource = dtChargeInfo;
                gvCharge.DataBind();
            }
            catch (Exception ex)
            { throw ex; }
        }

        protected void btnSaveFood_Click(object sender, EventArgs e)
        {
            try
            {
                DAL.CustomerFood objcustfood = new DAL.CustomerFood();
                if (btnSaveFood.Text == "Update")
                    objcustfood.UpdateCustomerFoodItem(CustomerFoodId, CustomerId, Convert.ToInt32(ddlFoodItem.SelectedValue.Trim()), Convert.ToInt32(txtQuntity.Text.Trim()), ddlRoomListFromCustomer.SelectedItem.Text);
                else
                    objcustfood.InsertCustomerFoodItem(CustomerId, Convert.ToInt32(ddlFoodItem.SelectedValue.Trim()), Convert.ToInt32(txtQuntity.Text.Trim()), ddlRoomListFromCustomer.SelectedItem.Text);
                mpFood.Show();
                objcustfood = null;
                FillFoodItem();
                txtQuntity.Text = "";
                ddlFoodItem.SelectedIndex = 0;
                ddlRoomListFromCustomer.SelectedIndex = 0;
                btnSaveFood.Text = "Save";
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        protected void btnAddFoodItem_Click(object sender, EventArgs e)
        {
            try
            {
                FillRoomListFromCustomer();
                FillFoodItem();
                FillFoodItemDropdown();
                mpFood.Show();
            }
            catch (Exception ex)
            { throw ex; }
        }

        private void FillFoodItemDropdown()
        {
            try
            {
                DAL.FoodMaster objFoodMaster = new DAL.FoodMaster();
                ddlFoodItem.DataSource = objFoodMaster.getFoodItemList(0);
                ddlFoodItem.DataValueField = "FoodItemId";
                ddlFoodItem.DataTextField = "ItemName";
                ddlFoodItem.DataBind();
                objFoodMaster = null;
            }
            catch (Exception ex)
            { throw ex; }
        }

        private void FillFoodItem()
        {
            try
            {
                DAL.CustomerFood objCustFood = new DAL.CustomerFood();
                gvFoodDetail.DataSource = objCustFood.getCustomerFoodItemList(CustomerId);
                gvFoodDetail.DataBind();
                objCustFood = null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void FillRoomListFromCustomer()
        {
            try
            {
                DAL.CustomerFood objCustFood = new DAL.CustomerFood();
                ddlRoomListFromCustomer.DataSource = objCustFood.getRoomListFromCustomer(CustomerId);
                ddlRoomListFromCustomer.DataValueField = "Room_No";
                ddlRoomListFromCustomer.DataTextField = "Room_No";
                ddlRoomListFromCustomer.DataBind();
                objCustFood = null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void gvFoodDetail_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                if (e.CommandName.ToLower() == "modify")
                {
                    txtQuntity.Text = gvFoodDetail.Rows[rowIndex].Cells[2].Text;
                    ddlFoodItem.SelectedValue = gvFoodDetail.DataKeys[rowIndex]["FoodItemId"].ToString().Trim();
                    ddlRoomListFromCustomer.SelectedValue = gvFoodDetail.Rows[rowIndex].Cells[3].Text;
                    btnSaveFood.Text = "Update";
                    CustomerFoodId = Convert.ToInt32(gvFoodDetail.DataKeys[rowIndex]["CustomerFoodDetailId"].ToString().Trim());
                }
                if (e.CommandName.ToLower() == "removefood")
                {
                    CustomerFoodId = Convert.ToInt32(gvFoodDetail.DataKeys[rowIndex]["CustomerFoodDetailId"].ToString().Trim());
                    DAL.CustomerFood objCustFood = new DAL.CustomerFood();
                    objCustFood.DeleteCustomerFoodItem(CustomerFoodId);
                    objCustFood = null;
                    FillFoodItem();
                    btnSaveFood.Text = "Save";
                }
                mpFood.Show();
            }
            catch (Exception ex)
            { throw ex; }
        }

        protected void btnCloseFood_Click(object sender, EventArgs e)
        {
            mpFood.Hide();
            GenerateFoodInvoice();
        }
    }
}