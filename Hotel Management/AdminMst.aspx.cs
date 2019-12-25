using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAL = Hotel_Management.DAL;

namespace Hotel_Management
{
    public partial class AdminMst : System.Web.UI.Page
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

        public int BookingId
        {
            get
            {
                if (ViewState["BookingId"] != null)
                    return Convert.ToInt32(ViewState["BookingId"]);
                else
                    return 0;
            }
            set
            {
                ViewState["BookingId"] = value;
            }
        }
        public int cash_history_id
        {
            get
            {
                if (ViewState["cash_history_id"] != null)
                    return Convert.ToInt32(ViewState["cash_history_id"]);
                else
                    return 0;
            }
            set
            {
                ViewState["cash_history_id"] = value;
            }
        }

        public int cash_history_detail_id
        {
            get
            {
                if (ViewState["cash_history_detail_id"] != null)
                    return Convert.ToInt32(ViewState["cash_history_detail_id"]);
                else
                    return 0;
            }
            set
            {
                ViewState["cash_history_detail_id"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Button btnAdmin = Master.FindControl("btnAdmin") as Button;
                btnAdmin.CssClass = "btn btn-outline btn-default active";

                if (Request.QueryString["cust"] != null)
                {
                    CustomerId = Convert.ToInt32(Request.QueryString["cust"]);
                    GetAllDetailFromCustomerId(CustomerId);
                }
            }
        }

        private void BindRoomDropDow()
        {
            try
            {
                DAL.RoomDetail objRoom = new DAL.RoomDetail();
                ddlRoomList.DataSource = objRoom.getRoomMasterList();
                ddlRoomList.DataValueField = "Room_id";
                ddlRoomList.DataTextField = "Room No";
                ddlRoomList.DataBind();
                objRoom = null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        private void GetAllDetailFromCustomerId(int customerId)
        {
            try
            {
                DAL.Admin objAdmin = new DAL.Admin();
                DataSet ds = objAdmin.GetAllDetailByCustomerId(customerId);
                if (ds.Tables[0] != null && ds.Tables[0].Rows.Count >0)
                    FillCustomerInfo(ds.Tables[0]);
                if (ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
                {
                    FillRoomList(ds.Tables[1]);
                    ViewState["dtBookingInfo"] = ds.Tables[1];
                }
                if (ds.Tables[2] != null && ds.Tables[2].Rows.Count > 0)
                {
                    BindTarifInfo(ds.Tables[2]);
                }
                if (ds.Tables[3] != null && ds.Tables[3].Rows.Count > 0)
                {
                    BindPaymentHistory(ds.Tables[3]);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void BindPaymentHistory(DataTable dtPaymentHisotory)
        {
            try
            {
                gvPaymentHistory.DataSource = dtPaymentHisotory;
                gvPaymentHistory.DataBind();
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }
        private void BindTarifInfo(DataTable dtTarif)
        {
            try
            {
                txtTotalAmount.Text = dtTarif.Rows[0]["Total_Amount"].ToString();
                txtDiscountPercentage.Text = dtTarif.Rows[0]["Discount_given"].ToString();
                txtDiscountAmount.Text = dtTarif.Rows[0]["Discount_Amount"].ToString();
                txtFinalPrice.Text = dtTarif.Rows[0]["FinalPrice"].ToString();
                txtLuxuryTax.Text = dtTarif.Rows[0]["Luxury_Tax"].ToString();
                cash_history_id = Convert.ToInt32(dtTarif.Rows[0]["Cash_History_Id"].ToString());
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void FillRoomList(DataTable dtRoomList)
        {
            try
            {
                gvBookingInfo.DataSource = dtRoomList;
                gvBookingInfo.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        private void FillCustomerInfo(DataTable dtCustDetails)
        {
            try
            {
                if (dtCustDetails.Rows.Count > 0)
                {

                    CustomerId = Convert.ToInt32(dtCustDetails.Rows[0]["CustomerId"]);
                    //txtCustomerNameMain.Text = dtCustDetails.Rows[0]["CustomerName"].ToString();
                    txtCustomerName.Text = dtCustDetails.Rows[0]["CustomerName"].ToString();
                    txtCustAddress.Text = dtCustDetails.Rows[0]["CustomerAddress"].ToString();
                    txtAgeOfCustomer.Text = dtCustDetails.Rows[0]["Age"].ToString();
                    txtArrivalFrom.Text = dtCustDetails.Rows[0]["CustomerArrival"].ToString();
                    txtDepartureTo.Text = dtCustDetails.Rows[0]["CustomerDeparture"].ToString();
                    txtNationality.Text = dtCustDetails.Rows[0]["Nationality"].ToString();
                    txtProofNumber.Text = dtCustDetails.Rows[0]["CustomerProofNumer"].ToString();

                    ddlAdult.SelectedValue = dtCustDetails.Rows[0]["NoOfAdultPerson"].ToString();
                    ddlChildren.SelectedValue = dtCustDetails.Rows[0]["NoOfChild"].ToString();
                    ddlProof.SelectedValue = dtCustDetails.Rows[0]["CustomerProfTypeID"].ToString();
                    txtPhoneNumber.Text = dtCustDetails.Rows[0]["Phone"].ToString();
                    txtEmail.Text = dtCustDetails.Rows[0]["Email"].ToString();
                    txtBillingDate.Text = string.IsNullOrEmpty(dtCustDetails.Rows[0]["BillingDate"].ToString()) == true ? "" : Convert.ToDateTime(dtCustDetails.Rows[0]["BillingDate"].ToString()).ToString("dd/MM/yyyy");  //     DateTime.Now.ToString("dd/MM/yyyy");
                    txtBillNumber.Text = dtCustDetails.Rows[0]["BillNumber"].ToString();
                    txtCompanyName.Text = dtCustDetails.Rows[0]["CompanyName"].ToString();
                    txtCompanyGST.Text = dtCustDetails.Rows[0]["CompanyGST"].ToString();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        protected void btnSaveCustomer_Click(object sender, EventArgs e)
        {
            try
            {
                DAL.BookingDetail objBookingDetail = new DAL.BookingDetail();

                //------------------------Customer Detail-----------------
                DAL.CustomerEntity objCustomer = new DAL.CustomerEntity();
                objCustomer.CustomerName = txtCustomerName.Text.ToString();
                objCustomer.CustomerAddress = txtCustAddress.Text.ToString();
                objCustomer.CustomerProfTypeID = ddlProof.SelectedValue.ToString() == "" ? 0 : Convert.ToInt32(ddlProof.SelectedValue.ToString());
                objCustomer.NoOfAdultPerson = Convert.ToInt32(ddlAdult.SelectedValue.ToString());
                objCustomer.NoOfChild = ddlChildren.SelectedValue.Trim() == "" ? 0 : Convert.ToInt32(ddlChildren.SelectedValue.ToString());
                objCustomer.CustomerProofNumer = txtProofNumber.Text.Trim();
                objCustomer.CustomerArrival = txtArrivalFrom.Text.Trim();
                objCustomer.CustomerDeparture = txtDepartureTo.Text.Trim();
                objCustomer.Age = txtAgeOfCustomer.Text.Trim() == "" ? 0 : Convert.ToInt32(txtAgeOfCustomer.Text.Trim());
                objCustomer.Nationality = txtNationality.Text.Trim();
                objCustomer.Email = txtEmail.Text.Trim();
                objCustomer.Phone = txtPhoneNumber.Text.Trim();
                objCustomer.BillNumber = txtBillNumber.Text.Trim();
                objCustomer.BillingDate = txtBillingDate.Text.Trim() == "" ? DateTime.Now  : DateTime.ParseExact(txtBillingDate.Text.Trim(), "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                objCustomer.CompanyName = txtCompanyName.Text.Trim();
                objCustomer.CompanyGST = txtCompanyGST.Text.Trim();
                objCustomer.CustomerID = CustomerId;
                objBookingDetail.New_Customer(objCustomer, 'U');
                CustomerId = CustomerId;
                //txtCustomerNameMain.Text = txtCustomerName.Text;
                GetAllDetailFromCustomerId(CustomerId);
                ScriptManager.RegisterStartupScript(this, typeof(Page), "UpdateMsg", "$(document).ready(function(){alert('successfully Updated.');});", true);
                mpCustomer.Hide();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void gvBookingInfo_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "editbooking")
            {
                try
                {
                    BindRoomDropDow();
                    DataTable dtBookingInfo = ViewState["dtBookingInfo"] as DataTable;
                    DataRow[] dr = dtBookingInfo.Select("CustomerBookingDetailID =" + gvBookingInfo.DataKeys[Convert.ToInt32(e.CommandArgument.ToString())]["CustomerBookingDetailID"]);
                    BookingId = Convert.ToInt32(gvBookingInfo.DataKeys[Convert.ToInt32(e.CommandArgument.ToString())]["CustomerBookingDetailID"]);
                    txtBookingDate.Text = dr[0]["BookingDate"].ToString();
                    ddlRoomList.SelectedValue = dr[0]["RoomID"].ToString();
                    txtCheckinDt.Text = dr[0]["CheckInDate"].ToString();
                    txtChekedOUtdt.Text = dr[0]["CheckOutDate"].ToString();
                    txtBookedFrom.Text = dr[0]["BookedFROM"].ToString();
                    txtBookedTo.Text = dr[0]["BookedTo"].ToString();
                    txtRoomPrice.Text = dr[0]["RoomPrice"].ToString();
                    mpBooking.Show();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        protected void btnSaveBooking_Click(object sender, EventArgs e)
        {
            try
            {
                DAL.BookingEntity objbookingEnttity = new DAL.BookingEntity();
                objbookingEnttity.BookedFrom = DateTime.ParseExact(txtBookedFrom.Text.Trim(), "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                objbookingEnttity.BookedTo = DateTime.ParseExact(txtBookedTo.Text.Trim(), "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                objbookingEnttity.BookingDate = DateTime.ParseExact(txtBookingDate.Text.Trim(), "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                objbookingEnttity.CheckInDate = DateTime.ParseExact(txtCheckinDt.Text.Trim(), "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                objbookingEnttity.CheckOutDate = DateTime.ParseExact(txtChekedOUtdt.Text.Trim(), "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                objbookingEnttity.RoomID = Convert.ToInt32(ddlRoomList.SelectedValue);
                objbookingEnttity.RoomPrice = Convert.ToInt32(txtRoomPrice.Text.Trim());
                objbookingEnttity.CustomerBookingDetailID = BookingId;
                DAL.Admin objAdmin = new DAL.Admin();
                objAdmin.Update_BookingInfo_byAdmin(objbookingEnttity);
                objbookingEnttity = null;
                objAdmin = null;
                GetAllDetailFromCustomerId(CustomerId);
                ScriptManager.RegisterStartupScript(this, typeof(Page), "UpdateMsg", "$(document).ready(function(){alert('successfully Updated.');});", true);
                mpBooking.Hide();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        protected void btn_Update_Tarif_Click(object sender, EventArgs e)
        {
            DAL.CashEntity objCashEntity = new DAL.CashEntity();
            objCashEntity.Total_Amount = Convert.ToDouble(txtTotalAmount.Text.Trim());
            objCashEntity.Discount_given = Convert.ToInt32(txtDiscountPercentage.Text.Trim());
            objCashEntity.Discount_Amount = Convert.ToDouble(txtDiscountAmount.Text.Trim());
            objCashEntity.FinalPrice = Convert.ToDouble(txtFinalPrice.Text.Trim());
            objCashEntity.Luxury_Tax = Convert.ToDouble(txtLuxuryTax.Text.Trim());
            objCashEntity.Cash_History_Id = cash_history_id;
            objCashEntity.Customer_Id = CustomerId;
            DAL.BookingDetail objBookingDetail = new DAL.BookingDetail();
            objBookingDetail.Insert_CashHistory(objCashEntity);
            GetAllDetailFromCustomerId(CustomerId);
            ScriptManager.RegisterStartupScript(this, typeof(Page), "UpdateMsg", "$(document).ready(function(){alert('successfully Updated.');});", true);
        }

        protected void gvPaymentHistory_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "editPaymentHistory")
            {
                try
                {
                    btnSavePayment.Text = "Update Payment";
                    cash_history_detail_id = Convert.ToInt32(gvPaymentHistory.DataKeys[Convert.ToInt32(e.CommandArgument.ToString())]["Cash_Booking_History_Detail_Id"].ToString());
                    txtPaidAmount.Text = gvPaymentHistory.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[1].Text.Trim();
                    txtDueAmount.Text = gvPaymentHistory.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[2].Text.Trim();
                    ddlPaymentType.SelectedValue = gvPaymentHistory.DataKeys[Convert.ToInt32(e.CommandArgument.ToString())]["Payment_Mode_Id"].ToString();
                    mp1.Show();
                }
                catch(Exception ex)
                {
                    throw ex;
                }
            }
        }

        protected void btnSavePayment_Click(object sender, EventArgs e)
        {
            try
            {
                DAL.CashHistoryDetailEntity objCashDetailEntity = new DAL.CashHistoryDetailEntity();
                objCashDetailEntity.Paid_Amount = Convert.ToDouble(txtPaidAmount.Text.Trim());
                objCashDetailEntity.Due_Amount = Convert.ToDouble(txtDueAmount.Text.Trim());
                objCashDetailEntity.Payment_Mode_id = Convert.ToInt32(ddlPaymentType.SelectedValue.ToString());
                DAL.Admin objAdmin = new DAL.Admin();
                if (btnSavePayment.Text.Trim() == "Update Payment")
                {
                    objCashDetailEntity.cash_history_detail_Id = cash_history_detail_id;
                    objAdmin.Update_CashHistoryDetail(objCashDetailEntity);
                }
                else if (btnSavePayment.Text.Trim() == "Add Payment")
                {
                    objCashDetailEntity.Cash_History_Id = cash_history_id;
                    objAdmin.Insert_CashHistoryDetail(objCashDetailEntity);
                }
                ScriptManager.RegisterStartupScript(this, typeof(Page), "UpdateMsg", "$(document).ready(function(){alert('successfully Updated.');});", true);
                GetAllDetailFromCustomerId(CustomerId);
                mp1.Hide();
            }
            catch (Exception ex)
            { throw ex; }
        }

        protected void btnOpenPaymentHistory_Click(object sender, EventArgs e)
        {
            txtPaidAmount.Text = "";
            txtDueAmount.Text = "";
            ddlPaymentType.SelectedIndex = 0;
            btnSavePayment.Text = "Add Payment";
            mp1.Show();
        }
    }
}