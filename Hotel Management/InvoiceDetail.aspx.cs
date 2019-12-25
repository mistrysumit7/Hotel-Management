using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using org.zefer.pd4ml;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAL = Hotel_Management.DAL;
namespace Hotel_Management
{
    public partial class InvoiceDetail : System.Web.UI.Page
    {
        public Decimal roomCharge
        {
            get
            {
                if (ViewState["roomCharge"] != null)
                    return Convert.ToDecimal(ViewState["roomCharge"]);
                else
                    return 0;
            }
            set
            {
                ViewState["roomCharge"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GenerateInvoice();
            }
        }

        private void GenerateInvoice()
        {
            try
            {
                if (Request.QueryString["CId"] != null)
                {
                    txtPaidAmount.Attributes["onblur"] = "return calculatepaidamount();";
                    int customerId = Convert.ToInt32(Request.QueryString["CId"]);
                    DAL.InvoiceDetail objIvoiceDetail = new DAL.InvoiceDetail();
                    DataSet ds = objIvoiceDetail.GenerateInvoiceFromCustomerId(customerId);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        FillCustomerInfo(ds.Tables[0]);
                    }
                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        FillHeaderRoomInfo(ds.Tables[1]);
                    }
                    if (ds.Tables[2].Rows.Count > 0)
                    {
                        FillRoomCharges(ds.Tables[2]);
                    }
                    if (ds.Tables[3].Rows.Count > 0)
                    {
                        FillPaymentHistory(ds.Tables[3]);
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void FillCustomerInfo(DataTable dtCustomerInfo)
        {
            try
            {
                lblCustomerName.Text = dtCustomerInfo.Rows[0]["CustomerName"].ToString();
                lblBillNumber.Text = dtCustomerInfo.Rows[0]["BillNumber"].ToString();
                if (string.IsNullOrWhiteSpace(dtCustomerInfo.Rows[0]["CompanyName"].ToString()))
                    tdCompanyName.Visible = false;
                if (string.IsNullOrWhiteSpace(dtCustomerInfo.Rows[0]["CompanyName"].ToString()))
                    tdCompanyGSTName.Visible = false;
                    lblCompanyName.Text = dtCustomerInfo.Rows[0]["CompanyName"].ToString();
                lblCompanyGST.Text = dtCustomerInfo.Rows[0]["CompanyGST"].ToString();
                ViewState["BillNumber"] = dtCustomerInfo.Rows[0]["BillNumber"].ToString();
                lblAddress.Text = dtCustomerInfo.Rows[0]["CustomerAddress"].ToString();
                lblDate.Text = string.IsNullOrEmpty(dtCustomerInfo.Rows[0]["BillingDate"].ToString()) == true ? "" : Convert.ToDateTime(dtCustomerInfo.Rows[0]["BillingDate"].ToString()).ToString("dd/MM/yyyy");  //     DateTime.Now.ToString("dd/MM/yyyy");
            }
            catch (Exception ex)
            { throw ex; }
        }

        private void FillHeaderRoomInfo(DataTable dtRoomInfo)
        {
            try
            {
                //lblRoomList.Text = dtRoomInfo.Rows[0]["RoomNameList"].ToString().Replace(",", "<br/>");
                //lblCheckInDate.Text = dtRoomInfo.Rows[0]["CheckInDate"].ToString();
                //lblCheckOutDate.Text = dtRoomInfo.Rows[0]["CheckoUTDate"].ToString();
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

        private void FillPaymentHistory(DataTable dtPaymentHistory)
        {
            try
            {
                lblRoomCharge.Text = dtPaymentHistory.Rows[0]["TotalAmount"].ToString();
                lblDiscount.Text = dtPaymentHistory.Rows[0]["Discount_Amount"].ToString();
                lblCGST.Text = dtPaymentHistory.Rows[0]["CGST"].ToString();
                lblSGST.Text = dtPaymentHistory.Rows[0]["SGST"].ToString();
                lblCGSTPercentage.Text = dtPaymentHistory.Rows[0]["CGSTPercentage"].ToString();
                lblSGSTPercentage.Text = dtPaymentHistory.Rows[0]["SGSTPercentage"].ToString();

                lblServiceTax.Text = dtPaymentHistory.Rows[0]["Service_Tax"].ToString();
                lblBillAmount.Text = dtPaymentHistory.Rows[0]["InvoiceAmount"].ToString();
                if (!string.IsNullOrEmpty(dtPaymentHistory.Rows[0]["Misc_Charge_Name"].ToString()))
                {
                    lblExtraChargesName.Text = dtPaymentHistory.Rows[0]["Misc_Charge_Name"].ToString() + ":";
                    lblExtraChargesAmount.Text = dtPaymentHistory.Rows[0]["MiscAmount"].ToString();
                    lblExtraChargesName.Visible = true;
                    lblExtraChargesAmount.Visible = true;
                }
                else
                {
                    lblExtraChargesName.Visible = false;
                    lblExtraChargesAmount.Visible = false;
                }
            }
            catch (Exception ex)
            { throw ex; }
        }

        protected void gvCharge_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                //if (!string.IsNullOrEmpty(gvCharge.Rows[Convert.ToInt32(e.CommandArgument)].Cells[5].Text.Trim()))
                //{
                //    roomCharge = roomCharge + Convert.ToDecimal(gvCharge.Rows[Convert.ToInt32(e.CommandArgument)].Cells[5].Text.Trim());
                //}
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnAddCharge_Click(object sender, EventArgs e)
        {
            BindPayment();
            mp1.Show();

        }

        private void BindPayment()
        {
            DAL.ExtraPayment objExtraPayment = new DAL.ExtraPayment();
            DataTable dtPayment = objExtraPayment.getExtraPaymentList(Convert.ToInt32(Request.QueryString["CId"]));
            gvPaymentHistory.DataSource = dtPayment;
            gvPaymentHistory.DataBind();
        }
        protected void btnSavePayment_Click(object sender, EventArgs e)
        {
            try
            {
                DAL.ExtraPayment objExtraPayment = new DAL.ExtraPayment();
                if (btnSavePayment.Text != "Update Payment")
                {
                    objExtraPayment.InsertExtraPayment(Convert.ToInt32(Request.QueryString["CId"]), txtChargeType.Text.Trim(), Convert.ToDecimal(txtAmount.Text.Trim()));
                }
                else
                {
                    objExtraPayment.UpdateExtraPayment(Convert.ToInt32(Request.QueryString["CId"]), txtChargeType.Text.Trim(), Convert.ToDecimal(txtAmount.Text.Trim()), Convert.ToInt32(ViewState["ChargeId"].ToString()));
                }
                txtAmount.Text = "";
                txtChargeType.Text = "";
                BindPayment();
                btnSavePayment.Text = "Save Payment";
                mp1.Show();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void gvPaymentHistory_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "Modify")
            {
                txtAmount.Text = gvPaymentHistory.Rows[rowIndex].Cells[1].Text.Trim();
                txtChargeType.Text = gvPaymentHistory.Rows[rowIndex].Cells[0].Text.Trim();
                btnSavePayment.Text = "Update Payment";
                ViewState["ChargeId"] = gvPaymentHistory.DataKeys[rowIndex]["Cust_Misc_Charge_Id"].ToString().Trim();
            }
            if (e.CommandName == "RemovePayment")
            {

                DAL.ExtraPayment objExtraPayment = new DAL.ExtraPayment();
                objExtraPayment.DeleteExtraPayment(Convert.ToInt32(gvPaymentHistory.DataKeys[rowIndex]["Cust_Misc_Charge_Id"].ToString().Trim()));
                BindPayment();
            }
            mp1.Show();
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            mp1.Hide();
            GenerateInvoice();
        }

        protected void btnPayment_Click(object sender, EventArgs e)
        {
            // System.Threading.Thread.Sleep(5000);
            DAL.BookingDetail objBookingDetail = new DAL.BookingDetail();
            DataSet ds = objBookingDetail.GetPaymentListWithPaidDueAmount_By_CashHistoryId(objBookingDetail.GetCashHistoryIdFromCustomerId(Convert.ToInt32(Request.QueryString["CId"])));
            if (ds.Tables[0].Rows.Count > 0)
            {
                gvPaymentDetail.DataSource = ds.Tables[0];
                gvPaymentDetail.DataBind();
            }
            else
            {
                gvPaymentDetail.DataSource = null;
                gvPaymentDetail.DataBind();
            }
            if (ds.Tables[1].Rows.Count > 0)
            {
                txtPaidAmount.Text = "";
                txtDueAmount.Text = ds.Tables[1].Rows[0]["Due_Amount"].ToString();
            }
            mpAddPayment.Show();
        }

        protected void btnGenerateFoodInvoice_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/FoodInvoice.aspx?CId=" + Request.QueryString["CId"].ToString(), false);
        }

        protected void btnAddPayment_Click(object sender, EventArgs e)
        {
            try
            {
                DAL.CashHistoryDetailEntity objCashDetailEntity = new DAL.CashHistoryDetailEntity();
                DAL.BookingDetail objBookingDetail = new DAL.BookingDetail();
                objCashDetailEntity.Cash_History_Id = objBookingDetail.GetCashHistoryIdFromCustomerId(Convert.ToInt32(Request.QueryString["CId"]));
                objCashDetailEntity.Paid_Amount = Convert.ToDouble(txtPaidAmount.Text.Trim());
                objCashDetailEntity.Due_Amount = Convert.ToDouble(txtDueAmount.Text.Trim());
                objCashDetailEntity.Payment_Mode_id = Convert.ToInt32(ddlPaymentType.SelectedValue.ToString());

                objBookingDetail.Insert_CashHistoryDetail(objCashDetailEntity);
                objBookingDetail = null;
                objCashDetailEntity = null;
                ScriptManager.RegisterStartupScript(this, typeof(Page), "UpdateMsg", "$(document).ready(function(){alert('successfully Updated.');});", true);
                mpAddPayment.Hide();
            }
            catch (Exception ex)
            { throw ex; }
        }
       
        protected void btnGeneratePdf_Click(object sender, EventArgs e)
        {
            try
            {
                //string html = "<html> < head > < title > Generate Invoice </ title > </ head > < body > < form > ";
                StringBuilder html = new StringBuilder();
                html.Append(hfDivHtml.Value.ToString());
                //html = html.Replace("</div>", "");
                //html = html.Replace("< div style = 'border: 1px solid black; border - radius: 5px; ' >", "");
                //html = html + "</form> </ body > </ html > ";
                //html = html.Replace("Image / logo.png>", "");

                StringReader sr;
                
                string htmlnw = System.IO.File.ReadAllText(@"C:\Users\sumit\Documents\Visual Studio 2015\Projects\new_hotel_mgmt\Hotel Management\OtherFiles\tbl.html");
                sr = new StringReader(htmlnw);
                iTextSharp.text.Document pdfDoc = new iTextSharp.text.Document();
                HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, memoryStream);
                    pdfDoc.Open();

                    htmlparser.Parse(sr);
                    pdfDoc.Close();

                    byte[] bytes = memoryStream.ToArray();

                    memoryStream.Close();
                    Response.Clear();
                    // Gets or sets the HTTP MIME type of the output stream.
                    Response.ContentType = "application/pdf";
                    // Adds an HTTP header to the output stream
                    Response.AddHeader("Content-Disposition", "attachment; filename=Invoice.pdf");

                    //Gets or sets a value indicating whether to buffer output and send it after
                    // the complete response is finished processing.
                    Response.Buffer = true;
                    // Sets the Cache-Control header to one of the values of System.Web.HttpCacheability.
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    // Writes a string of binary characters to the HTTP output stream. it write the generated bytes .
                    Response.BinaryWrite(bytes);
                    // Sends all currently buffered output to the client, stops execution of the
                    // page, and raises the System.Web.HttpApplication.EndRequest event.

                    Response.End();
                    // Closes the socket connection to a client. it is a necessary step as you must close the response after doing work.its best approach.
                    Response.Close();
                }
                
                // PD4ML pd4ml = new PD4ML();
                //pd4ml.enableTableBreaks(true);
                //pd4ml.addStyle("", true);
                //pd4ml.PageSize = PD4Constants.getSizeByName("LETTER");

                //Byte[] byteArray = Encoding.ASCII.GetBytes(html);
                //MemoryStream stream = new MemoryStream();

                //String DocumentDirectoryPath = @"C:\Users\sumit\Documents\Visual Studio 2015\Projects\new_hotel_mgmt\Hotel Management\GenerateBill\";
                //String FilePath = DocumentDirectoryPath + ViewState["BillNumber"].ToString();
                //Directory.CreateDirectory(FilePath);
                //FilePath = DocumentDirectoryPath + ViewState["BillNumber"].ToString() + ".pdf";
                //FileStream file = new FileStream(FilePath, FileMode.Create, FileAccess.Write);
                //stream.Position = 0;
                //stream.Read(byteArray, 0, byteArray.Length);
                //stream.WriteTo(file);
                //stream.Close();
                //stream.Flush();
                ////pd4ml.render(stream, new System.IO.FileStream(FilePath, System.IO.FileMode.Create));
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}