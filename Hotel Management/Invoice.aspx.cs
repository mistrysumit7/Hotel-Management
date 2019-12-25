using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hotel_Management
{
    public partial class Invoice : System.Web.UI.Page
    {
       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["isMast"] == null)
            {
                Button btnInvoice = Master.FindControl("btnInvoice") as Button;
                btnInvoice.CssClass = "btn btn-outline btn-default active";
                Button btnAdmin = Master.FindControl("btnAdmin") as Button;
                btnAdmin.CssClass = "btn btn-outline btn-default";
            }
            else {
                Button btnAdmin = Master.FindControl("btnAdmin") as Button;
                btnAdmin.CssClass = "btn btn-outline btn-default active";
                Button btnInvoice = Master.FindControl("btnInvoice") as Button;
                btnInvoice.CssClass = "btn btn-outline btn-default";
            }
            gvInvoice.RowDataBound += GvInvoice_RowDataBound;
            if (!IsPostBack)
            {
                GetCustomerListforInvoice("");

                //gvInvoice.PageSize = Convert.ToInt32(System.Configuration.ConfigurationSettings.AppSettings["PageSize"].ToString());
            }
           
        }

        private void GvInvoice_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    LinkButton lnkbtn = e.Row.FindControl("lnkGenerateInvoice") as LinkButton;
                    int lsDataKeyValue = Convert.ToInt32(gvInvoice.DataKeys[e.Row.RowIndex].Values[0].ToString());
                    if (Request.QueryString["isMast"] != null)
                    {
                        lnkbtn.Text = "Update";
                        lnkbtn.PostBackUrl = "~/AdminMst.aspx?cust=" + lsDataKeyValue.ToString();
                    }
                    else
                    {
                        lnkbtn.PostBackUrl = "~/InvoiceDetail.aspx?CId=" + lsDataKeyValue.ToString();
                    }
                }
            }
            catch(Exception ex)
            { throw ex; }
        }

        private void GetCustomerListforInvoice(string seachCriteria)
        {
            try
            {
                DAL.InvoiceDetail objInvoiceDetail = new DAL.InvoiceDetail();
                DataTable dt = objInvoiceDetail.GetCustomerListforInvoice(seachCriteria);

                gvInvoice.DataSource = dt;
                gvInvoice.DataBind();

                objInvoiceDetail = null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void gvInvoice_PageIndexChanged(object sender, EventArgs e)
        {
            GetCustomerListforInvoice(txtSearch.Text.Trim());
        }

        protected void gvInvoice_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvInvoice.PageIndex = e.NewPageIndex;
            //GetCustomerListforInvoice();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            GetCustomerListforInvoice(txtSearch.Text.Trim());
        }

        protected void btnAllBill_Click(object sender, EventArgs e)
        {
            GetCustomerListforInvoice("");
        }
    }
}