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
    public partial class BookingDetail : System.Web.UI.Page
    {
        public int RoomID
        {
            get
            {
                if (ViewState["RoomID"] != null)
                    return Convert.ToInt32(ViewState["RoomID"]);
                else
                    return 0;
            }
            set
            {
                ViewState["RoomID"] = value;
            }
        }

        public int CashHistoryID
        {
            get
            {
                if (ViewState["CashHistoryID"] != null)
                    return Convert.ToInt32(ViewState["CashHistoryID"]);
                else
                    return 0;
            }
            set
            {
                ViewState["CashHistoryID"] = value;
            }
        }

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

        public int BookingTypeId
        {
            get
            {
                if (ViewState["BookingTypeId"] != null)
                    return Convert.ToInt32(ViewState["BookingTypeId"]);
                else
                    return 0;
            }
            set
            {
                ViewState["BookingTypeId"] = value;
            }
        }
        
        //public static double roomDoubleRate = 0.65;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BookingTypeId = 3;
                btnSave.Visible = false;
                btnAddFoodItem.Visible = false;
                Button btnBookingMast = Master.FindControl("btnBooking") as Button;
                btnBookingMast.CssClass = "btn btn-outline btn-default active";
                if (Request.QueryString["bbbtttt"] != null)
                {
                    if (Request.QueryString["bbbtttt"].ToString() == "B")
                    {
                        btnCheckOut.Visible = false;
                        btnBooking.Visible = false;
                        BookingTypeId = 3;
                        btnSave.Visible = true;
                    }
                    if (Request.QueryString["bbbtttt"].ToString() == "I")
                    {
                        btnBooking.Visible = false;
                        btnCheckIn.Visible = false;
                        BookingTypeId = 1;
                        btnSave.Visible = true;
                        btnAddFoodItem.Visible = true;
                    }
                }
                else
                {
                    btnCheckOut.Visible = false;
                }
                FillProofTypes();
                FillRoomList();
                //FillBookingType();
                txtDiscountPercentage.Attributes["onblur"] = "return CalculateDiscount();";
                txtPaidAmount.Attributes["onblur"] = "return calculatepaidamount();";
                CustomerId = 0;
                if (Request.QueryString["roomid"] != null)
                {
                    RoomID = Convert.ToInt32(Request.QueryString["roomid"]);
                    GetRoomDetailByRoomID();
                }

                if (Request.QueryString["CustBookingDetailId"] != null)
                {
                    GetCustBookingDetail(Convert.ToInt32(Request.QueryString["CustBookingDetailId"]));
                }

                if (Request.QueryString["CustId"] != null)
                {
                    DAL.BookingDetail objBookingDetail = new DAL.BookingDetail();
                    int customerbookingid = objBookingDetail.GetCustomerBookingDetailIdFromCustomerId(Convert.ToInt32(Request.QueryString["CustId"]));
                    GetCustBookingDetail(customerbookingid);
                }
            }
        }

        private void GetCustBookingDetail(int CustomerBookingDetailId)
        {
            try
            {

                DAL.BookingDetail objBookingDetail = new DAL.BookingDetail();
                DataSet dsCustBookingDetail = objBookingDetail.GetCustomerBookingDetailByID(CustomerBookingDetailId);

                DataTable dtCustDetails = dsCustBookingDetail.Tables[0];
                DataTable dtBookingDetails = dsCustBookingDetail.Tables[1];
                DataTable dtPaymentDetails = dsCustBookingDetail.Tables[2];

                if (dtCustDetails.Rows.Count > 0)
                {

                    CustomerId = Convert.ToInt32(dtCustDetails.Rows[0]["CustomerId"]);
                    txtCustomerNameMain.Text = dtCustDetails.Rows[0]["CustomerName"].ToString();
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
                    txtCompanyName.Text = dtCustDetails.Rows[0]["CompanyName"].ToString();
                    txtCompanyGST.Text = dtCustDetails.Rows[0]["CompanyGST"].ToString();
                }

                if (dtBookingDetails.Rows.Count > 0)
                {
                    txtBookingNotes.Text = dtBookingDetails.Rows[0]["Notes"].ToString();
                    //ddlBookingType.SelectedValue = dtBookingDetails.Rows[0]["BookingTypeID"].ToString();

                    //gvRoomDetail.DataSource = dtBookingDetails;

                    List<roomEntity> listroom = new List<roomEntity>();

                    for (int roomCount = 0; roomCount < dtBookingDetails.Rows.Count; roomCount++)
                    {
                        roomEntity objRoomEntity = new roomEntity();
                        objRoomEntity.roomId = Convert.ToInt32(dtBookingDetails.Rows[roomCount]["RoomID"].ToString());
                        objRoomEntity.roomInfo = dtBookingDetails.Rows[roomCount]["roomInfo"].ToString() + " " + dtBookingDetails.Rows[roomCount]["RoomType_Name"].ToString();
                        objRoomEntity.roomPrice = Convert.ToInt32(dtBookingDetails.Rows[roomCount]["roomPrice"].ToString());
                        objRoomEntity.Days = Convert.ToInt32(dtBookingDetails.Rows[roomCount]["Days"].ToString());
                        objRoomEntity.finalAmount = Convert.ToDouble(dtBookingDetails.Rows[roomCount]["finalAmount"].ToString());
                        objRoomEntity.startdate = Convert.ToDateTime(dtBookingDetails.Rows[roomCount]["BookedFrom"].ToString());
                        objRoomEntity.enddate = Convert.ToDateTime(dtBookingDetails.Rows[roomCount]["BookedTo"].ToString());
                        objRoomEntity.GST = Convert.ToInt32(dtBookingDetails.Rows[roomCount]["GST"].ToString());
                        objRoomEntity.IsSingle = Convert.ToBoolean(dtBookingDetails.Rows[roomCount]["IsSingle"].ToString()) == true ? true : false;
                        objRoomEntity.CustomerBookingDetailID = Convert.ToInt32(dtBookingDetails.Rows[roomCount]["CustomerBookingDetailID"].ToString());
                        listroom.Add(objRoomEntity);
                    }
                    gvRoomDetail.DataSource = listroom;
                    gvRoomDetail.DataBind();
                    gvRoomDetail.Visible = true;
                    ViewState["listRoom"] = listroom;
                }

                if (dtPaymentDetails.Rows.Count > 0)
                {
                    txtRoomPrice.Text = dtPaymentDetails.Rows[0]["Total_Amount"].ToString();
                    txtFinalAmount.Text = dtPaymentDetails.Rows[0]["FinalPrice"].ToString();
                    txtPriceAfterDiscount.Text = dtPaymentDetails.Rows[0]["Discount_Amount"].ToString();
                    txtDiscountPercentage.Text = dtPaymentDetails.Rows[0]["Discount_given"].ToString();
                    CashHistoryID = Convert.ToInt32(dtPaymentDetails.Rows[0]["Cash_History_Id"]);
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void GetRoomDetailByRoomID()
        {
            try
            {
                DAL.RoomDetail roomDetail = new DAL.RoomDetail();
                DAL.RoomDetailEntity roomDetailEntity = roomDetail.GetRoomDetailByRoomID(RoomID);

                ddlRoomList.SelectedValue = roomDetailEntity.Room_id.ToString();
                //lblRoomType.Text = Convert.ToString(roomDetailEntity.Room_Type);
                txtRoomPrice.Text = Convert.ToString(roomDetailEntity.Room_Avg_Rate);
                //txtDueAmount.Text = Convert.ToString(roomDetailEntity.Room_Avg_Rate);
                txtFinalAmount.Text = Convert.ToString(roomDetailEntity.Room_Avg_Rate);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void FillProofTypes()
        {
            try
            {
                DAL.BookingDetail objBookingDetail = new DAL.BookingDetail();
                DataTable dtBooking = objBookingDetail.GetProofType();
                ddlProof.DataSource = dtBooking;
                ddlProof.DataTextField = "ProfName";
                ddlProof.DataValueField = "ProofId";
                ddlProof.DataBind();
                objBookingDetail = null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void FillRoomList()
        {
            try
            {
                DAL.BookingDetail objBookingDetail = new DAL.BookingDetail();
                DataTable dtRoomList = objBookingDetail.GetRoomList(0);
                if (dtRoomList != null)
                {
                    ViewState["dtRoomList"] = dtRoomList;
                    ddlRoomList.DataSource = dtRoomList;
                    ddlRoomList.DataTextField = "Room_No";
                    ddlRoomList.DataValueField = "Room_id";
                    ddlRoomList.DataBind();
                    objBookingDetail = null;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //private void FillBookingType()
        //{
        //    try
        //    {
        //        DAL.BookingDetail objBookingDetail = new DAL.BookingDetail();
        //        DataTable dtBookingType = objBookingDetail.GetBookingType(0);
        //        ddlBookingType.DataSource = dtBookingType;
        //        ddlBookingType.DataTextField = "BookingType";
        //        ddlBookingType.DataValueField = "BookingType_Id";
        //        ddlBookingType.DataBind();
        //        objBookingDetail = null;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        protected void btnAddRoom_Click(object sender, EventArgs e)
        {
            //System.Threading.Thread.Sleep(5005);
            if (CustomerId != 0)
            {
                DAL.BookingDetail objBookingDetail = new DAL.BookingDetail();
                double roomPrice = 0;
                double LaxuryTax = 0;
                double finalPrice = 0;
                //lblRoomList.Text = lblRoomList.Text.Trim() == "" ? ddlRoomList.SelectedItem.ToString() : lblRoomList.Text + " | " + ddlRoomList.SelectedItem.ToString();
                List<roomEntity> listroom = new List<roomEntity>();
                roomEntity objRoomEntity = new roomEntity();
                objRoomEntity.roomInfo = ddlRoomList.SelectedItem.ToString();
                objRoomEntity.roomId = Convert.ToInt32(ddlRoomList.SelectedValue.ToString().Trim());
                DateTime startdate = DateTime.ParseExact(txtStartDate.Text.Trim(), "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);

                DateTime enddate = DateTime.ParseExact(txtEndDate.Text.Trim(), "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                objRoomEntity.startdate = startdate;
                objRoomEntity.enddate = enddate;
                int totalday = Convert.ToInt32((enddate - startdate).TotalDays);
                totalday = totalday == 0 ? 1 : totalday;
                objRoomEntity.Days = totalday;
                objRoomEntity.IsSingle = rdbtnSingle.Checked == true ? true : false;
                if (ViewState["dtRoomList"] != null)
                {
                    DataTable dtRoomInfo = ViewState["dtRoomList"] as DataTable;
                    DataRow[] dr = dtRoomInfo.Select("Room_id = " + objRoomEntity.roomId);
                    roomPrice = rdbtnSingle.Checked == true ? Convert.ToInt32(dr[0]["Room_SingleRate"].ToString()) : Convert.ToInt32(dr[0]["Room_DoubleRate"].ToString());
                    objRoomEntity.roomPrice = roomPrice;
                    finalPrice = objRoomEntity.roomPrice * totalday;
                    objRoomEntity.finalAmount = finalPrice;
                    int GSTTax = objBookingDetail.GetGSTTaxFromTarrif( Convert.ToInt32( objRoomEntity.roomPrice));
                    //LaxuryTax = Convert.ToDouble(System.Configuration.ConfigurationSettings.AppSettings["LuxuryTax"].ToString());
                    objRoomEntity.GST = GSTTax;
                }
                if (ViewState["listRoom"] != null)
                {
                    listroom = ViewState["listRoom"] as List<roomEntity>;
                }

                int bookingId = 0;

                DAL.BookingEntity objbookingEntity = new DAL.BookingEntity();
                objbookingEntity.CustomerID = CustomerId;
                objbookingEntity.RoomID = Convert.ToInt32(ddlRoomList.SelectedValue.ToString().Trim());
                objbookingEntity.BookedFrom = DateTime.ParseExact(txtStartDate.Text.Trim(), "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                objbookingEntity.BookedTo = DateTime.ParseExact(txtEndDate.Text.Trim(), "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                objbookingEntity.BookedBy = "Sumit";
                objbookingEntity.RoomPrice = Convert.ToInt32(roomPrice);
                //LuxuryTax = LuxuryTax + Convert.ToDouble(gvRoomDetail.Rows[roomcount].Cells[7].Text.Trim());
                objbookingEntity.IsSingle = rdbtnSingle.Checked == true ? true : false;
                objbookingEntity.BookingNotes = txtBookingNotes.Text.ToString();
                objbookingEntity.BookingTypeID = BookingTypeId;
                objbookingEntity.GSTTax = objRoomEntity.GST;
                bookingId = objBookingDetail.New_Booking(objbookingEntity);
                objRoomEntity.CustomerBookingDetailID = bookingId;
                listroom.Add(objRoomEntity);
                gvRoomDetail.DataSource = listroom;
                gvRoomDetail.DataBind();
                ViewState["listRoom"] = listroom;
                int totalFinalPrice = 0;
                for (int i = 0; i < gvRoomDetail.Rows.Count; i++)
                {
                    totalFinalPrice = totalFinalPrice + Convert.ToInt32(gvRoomDetail.Rows[i].Cells[6].Text.Trim());
                }
                txtRoomPrice.Text = totalFinalPrice.ToString();
                txtFinalAmount.Text = totalFinalPrice.ToString();
                txtDiscountPercentage.Text = "0";
                txtPriceAfterDiscount.Text = "0";





                //    string roomIdComaSeprated = "";
                //    if (ViewState["roomId"] != null)
                //    {
                //        roomIdComaSeprated = ddlRoomList.SelectedValue.ToString() == "" ? ddlRoomList.SelectedValue.ToString() : ViewState["roomId"].ToString() + "," + ddlRoomList.SelectedValue.ToString();
                //    }
                //    else
                //    {
                //        roomIdComaSeprated = ddlRoomList.SelectedValue.ToString();
                //    }
                //    ViewState["roomId"] = roomIdComaSeprated;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, typeof(Page), "UpdateMsg1", "$(document).ready(function(){alert('Add Customer First.');});", true);
            }
        }

        private void AddBookingEntity()
        {
            try
            {
                //int customerId = 0;
                int bookingId = 0;

                DAL.BookingDetail objBookingDetail = new DAL.BookingDetail();

                //------------------------Customer Detail-----------------
                //DAL.CustomerEntity objCustomer = new DAL.CustomerEntity();
                //objCustomer.CustomerName = txtCustomerName.Text.ToString();
                //objCustomer.CustomerAddress = txtCustAddress.Text.ToString();
                //objCustomer.CustomerProfTypeID = Convert.ToInt32(ddlProof.SelectedValue.ToString());
                //objCustomer.NoOfAdultPerson = Convert.ToInt32(ddlAdult.SelectedValue.ToString());
                //objCustomer.NoOfChild = Convert.ToInt32(ddlChildren.SelectedValue.ToString());
                //objCustomer.CustomerProofNumer = txtProofNumber.Text.Trim();
                //objCustomer.CustomerArrival = txtArrivalFrom.Text.Trim();
                //objCustomer.CustomerDeparture = txtDepartureTo.Text.Trim();
                //objCustomer.Age = Convert.ToInt32(txtAgeOfCustomer.Text.Trim());
                //objCustomer.Nationality = txtNationality.Text.Trim();
                //if (CustomerId == 0)
                //    customerId = objBookingDetail.New_Customer(objCustomer, 'I');
                //else
                //{
                //    objCustomer.CustomerID = CustomerId;
                //    objBookingDetail.New_Customer(objCustomer, 'U');
                //    customerId = CustomerId;
                //}
                double LuxuryTax = 0;
                //-----------------Room Detail ---------------------
                for (int roomcount = 0; roomcount < gvRoomDetail.Rows.Count; roomcount++)
                {
                    //    DAL.BookingEntity objbookingEntity = new DAL.BookingEntity();
                    //    objbookingEntity.CustomerID = CustomerId;
                    //    objbookingEntity.RoomID = Convert.ToInt32(gvRoomDetail.DataKeys[roomcount].Value);
                    //    objbookingEntity.BookedFrom = DateTime.Parse(gvRoomDetail.Rows[roomcount].Cells[1].Text.Trim());
                    //    objbookingEntity.BookedTo = DateTime.Parse(gvRoomDetail.Rows[roomcount].Cells[2].Text.Trim());
                    //    objbookingEntity.BookedBy = txtCustomerNameMain.Text.Trim();
                    //    objbookingEntity.RoomPrice = Convert.ToInt32(gvRoomDetail.Rows[roomcount].Cells[3].Text.Trim());
                    LuxuryTax = LuxuryTax + Convert.ToDouble(gvRoomDetail.Rows[roomcount].Cells[7].Text.Trim());
                    //    objbookingEntity.IsSingle = gvRoomDetail.Rows[roomcount].Cells[5].Text.Trim() == "Single" ? true : false;
                    //    objbookingEntity.BookingNotes = txtBookingNotes.Text.ToString();
                    //    objbookingEntity.BookingTypeID = Convert.ToInt32(ddlBookingType.SelectedValue.ToString().Trim());
                    //    bookingId = objBookingDetail.New_Booking(objbookingEntity);
                }
                //-----------------------Cash history ------------------------
                DAL.CashEntity objCashEntity = new DAL.CashEntity();
                objCashEntity.Total_Amount = txtRoomPrice.Text.Trim() == "" ? 0 : Convert.ToDouble(txtRoomPrice.Text.Trim());
                objCashEntity.Discount_given = txtDiscountPercentage.Text.Trim() == "" ? 0 : Convert.ToInt32(txtDiscountPercentage.Text.Trim());
                objCashEntity.Discount_Amount = txtPriceAfterDiscount.Text.Trim() == "" ? 0 : Convert.ToDouble(txtPriceAfterDiscount.Text.Trim());
                //objCashEntity.Paid_Amount = txtPaidAmount.Text.Trim() == "" ? 0 : Convert.ToInt32(txtPaidAmount.Text.Trim());
                //objCashEntity.Due_Amount = txtDueAmount.Text.Trim() == "" ? 0 : Convert.ToInt32(txtDueAmount.Text.Trim());
                objCashEntity.FinalPrice = txtFinalAmount.Text.Trim() == "" ? 0 : Convert.ToDouble(txtFinalAmount.Text.Trim());
                //objCashEntity.BookingMaster_Id = bookingId;
                objCashEntity.Customer_Id = CustomerId;
                objCashEntity.Luxury_Tax = LuxuryTax;
                objCashEntity.Service_Tax = 0;
                if (CashHistoryID > 0)
                {
                    objCashEntity.Cash_History_Id = CashHistoryID;
                }
                CashHistoryID = objBookingDetail.Insert_CashHistory(objCashEntity);

                //Page.ClientScript.RegisterStartupScript(GetType(), "hello", "alert('succeesfully booking')");
                //Page.ClientScript.RegisterStartupScript(GetType(), "hello", "ClearControl();");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void BindRoomGrid()
        {
            try
            {
                if (ViewState["listRoom"] != null)
                {
                    gvRoomDetail.DataSource = ViewState["listRoom"] as List<roomEntity>;
                    gvRoomDetail.DataBind();
                }
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
                //System.Threading.Thread.Sleep(5000);
                //if (ddlBookingType.SelectedValue.ToString() == "2")
                //{
                //    DAL.BookingDetail objBookingDetail = new DAL.BookingDetail();
                //    objBookingDetail.UpdateBookingStatus(CustomerId);

                //    Response.Redirect("~/InvoiceDetail.aspx?CId=" + CustomerId, false);                    
                //}
                //else
                //{
                AddBookingEntity();
                string script = "alert('Saved All Successfully'); ";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
                //Response.Redirect("Deshboard.aspx", true);
                //}
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void gvRoomDetail_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName.ToString() == "Remove")
                {
                    if (ViewState["listRoom"] != null)
                    {
                        List<roomEntity> listroom = ViewState["listRoom"] as List<roomEntity>;
                        int roomId = Convert.ToInt32(gvRoomDetail.DataKeys[Convert.ToInt32(e.CommandArgument)]["roomId"].ToString());
                        for (int i = 0; i < listroom.Count(); i++)
                        {
                            if (listroom[i].roomId == roomId)
                            {
                                listroom.RemoveAt(i);
                            }
                        }
                        ViewState["listRoom"] = listroom;
                        DAL.BookingDetail objBookingDetails = new DAL.BookingDetail();
                        objBookingDetails.DeleteCustomerBookingDetails(Convert.ToInt32(gvRoomDetail.DataKeys[Convert.ToInt32(e.CommandArgument)]["CustomerBookingDetailID"].ToString()));
                        objBookingDetails = null;
                        BindRoomGrid();
                        FillRoomList();

                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnPayment_Click(object sender, EventArgs e)
        {
            // System.Threading.Thread.Sleep(5000);
            DAL.BookingDetail objBookingDetail = new DAL.BookingDetail();
            DataSet ds = objBookingDetail.GetPaymentListWithPaidDueAmount_By_CashHistoryId(CashHistoryID);
            if (ds.Tables[0].Rows.Count > 0)
            {
                gvPaymentHistory.DataSource = ds.Tables[0];
                gvPaymentHistory.DataBind();
            }
            else
            {
                gvPaymentHistory.DataSource = null;
                gvPaymentHistory.DataBind();
            }
            if (ds.Tables[1].Rows.Count > 0)
            {
                txtPaidAmount.Text = "";
                txtDueAmount.Text = ds.Tables[1].Rows[0]["Due_Amount"].ToString();
                lblRequiredPayAmount.Text = ds.Tables[1].Rows[0]["Due_Amount"].ToString();
            }
            mp1.Show();
        }

        protected void btnSavePayment_Click(object sender, EventArgs e)
        {
            try
            {
                DAL.CashHistoryDetailEntity objCashDetailEntity = new DAL.CashHistoryDetailEntity();
                objCashDetailEntity.Cash_History_Id = CashHistoryID;
                objCashDetailEntity.Paid_Amount = Convert.ToDouble(txtPaidAmount.Text.Trim());
                objCashDetailEntity.Due_Amount = Convert.ToDouble(txtDueAmount.Text.Trim());
                objCashDetailEntity.Payment_Mode_id = Convert.ToInt32(ddlPaymentType.SelectedValue.ToString());
                DAL.BookingDetail objBookingDetail = new DAL.BookingDetail();
                objBookingDetail.Insert_CashHistoryDetail(objCashDetailEntity);
                ScriptManager.RegisterStartupScript(this, typeof(Page), "UpdateMsg", "$(document).ready(function(){alert('successfully Updated.');});", true);
                mp1.Hide();
            }
            catch (Exception ex)
            { throw ex; }
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
                objCustomer.CompanyName = txtCompanyName.Text.Trim();
                objCustomer.CompanyGST = txtCompanyGST.Text.Trim();
                if (CustomerId == 0)
                    CustomerId = objBookingDetail.New_Customer(objCustomer, 'I');
                else
                {
                    objCustomer.CustomerID = CustomerId;
                    objBookingDetail.New_Customer(objCustomer, 'U');
                    CustomerId = CustomerId;
                }
                txtCustomerNameMain.Text = txtCustomerName.Text;
                ModalPopupExtender1.Hide();
            }
            catch (Exception ex)
            { throw ex; }
        }

        protected void gvRoomDetail_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                //DataRowView drv = (DataRowView)e.Row.DataItem;
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    if (e.Row.Cells[5].Text.Trim() == "True")
                        e.Row.Cells[5].Text = "Single";
                    else
                        e.Row.Cells[5].Text = "Double";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnBooking_Click(object sender, EventArgs e)
        {
            if (gvRoomDetail.Rows.Count > 0)
            {
                AddBookingEntity();
                DAL.BookingDetail objBookingDetail = new DAL.BookingDetail();
                objBookingDetail.UpdateBookingStatus(CustomerId, Convert.ToInt32(DAL.ConstEnum.BookingTypeId.BOOKING));
                string script = "alert('Booking Successfully'); window.location = 'Deshboard.aspx';";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
                //Response.Redirect("~/Deshboard.aspx", false);
                objBookingDetail = null;
            }
            else
            {
                string script = "alert('Please Add Room First.'); ";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
        }

        protected void btnCheckIn_Click(object sender, EventArgs e)
        {
            if (gvRoomDetail.Rows.Count > 0)
            {
                AddBookingEntity();
                DAL.BookingDetail objBookingDetail = new DAL.BookingDetail();
                objBookingDetail.UpdateBookingStatus(CustomerId, Convert.ToInt32(DAL.ConstEnum.BookingTypeId.CHECKIN));
                string script = "alert('Checked In Successfully'); window.location = 'Deshboard.aspx'; ";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
                objBookingDetail = null;
                //Response.Redirect("~/Deshboard.aspx", false);
            }
            else
            {
                string script = "alert('Please Add Room First.'); ";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
        }

        protected void btnCheckOut_Click(object sender, EventArgs e)
        {
            DAL.BookingDetail objBookingDetail = new DAL.BookingDetail();
            if (objBookingDetail.ChkIsPaymentComplete(CashHistoryID))
            {
                if (gvRoomDetail.Rows.Count > 0)
                {
                    objBookingDetail.UpdateBookingStatus(CustomerId, Convert.ToInt32(DAL.ConstEnum.BookingTypeId.CHECKOUT));
                    string script = "alert('Checked Out Successfully'); window.location = 'InvoiceDetail.aspx?CId=" + CustomerId + "'";
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
                    objBookingDetail = null;
                    //Response.Redirect("~/InvoiceDetail.aspx?CId="+CustomerId, true);
                }
                else
                {
                    string script = "alert('Please Add Room First.'); ";
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
                }
            }
            else
            {
                string script = "alert('Please Complete Payment first before CHECK-OUT. Click on Add Payment for Payment History.'); ";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
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

        [Serializable]
        public class roomEntity
        {
            public double roomId { get; set; }
            public string roomInfo { get; set; }
            public double roomPrice { get; set; }
            public int Days { get; set; }
            public double finalAmount { get; set; }
            public DateTime? startdate { get; set; }
            public DateTime? enddate { get; set; }
            public int GST { get; set; }
            public bool IsSingle { get; set; }
            public int CustomerBookingDetailID { get; set; }
        }
        
    }
}