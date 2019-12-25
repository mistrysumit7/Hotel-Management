using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ReportDAL = Hotel_Management.DAL.Report;

namespace Hotel_Management
{
    public partial class FoodReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Button btnSales = Master.FindControl("btnFoodReport") as Button;
            btnSales.CssClass = "btn btn-outline btn-default active";
            if (!IsPostBack)
            {
                BindGrid();
            }

            btnExportExcel.Click += BtnExportExcel_Click;
            btnExportPDF.Click += BtnExportPDF_Click;
        }

        private void BindGrid()
        {
            try
            {
                ReportDAL objReportDal = new ReportDAL();
                gvGeneralReport.DataSource = objReportDal.GeneratFoodReport();
                gvGeneralReport.DataBind();
                objReportDal = null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }

        protected void BtnExportExcel_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=Food_Report.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                gvGeneralReport.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }

        protected void BtnExportPDF_Click(object sender, EventArgs e)
        {
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    gvGeneralReport.RenderControl(hw);
                    StringReader sr = new StringReader(sw.ToString());
                    Document pdfDoc = new Document(PageSize.A2, 10f, 10f, 10f, 0f);
                    HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                    PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                    pdfDoc.Open();
                    htmlparser.Parse(sr);
                    pdfDoc.Close();

                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", "attachment;filename=Food_Report.pdf");
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Write(pdfDoc);
                    Response.End();
                }
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            try
            {
                string strFilterValue = hfFilter.Value;
                ReportDAL objReportDal = new ReportDAL();
                if (!string.IsNullOrEmpty(strFilterValue))
                {
                    switch (strFilterValue)
                    {
                        case "today":
                            gvGeneralReport.DataSource = objReportDal.GeneratFoodReport( true);
                            gvGeneralReport.DataBind();
                            break;
                        case "yesterday":
                            gvGeneralReport.DataSource = objReportDal.GeneratFoodReport( false, true);
                            gvGeneralReport.DataBind();
                            break;
                        case "week":
                            gvGeneralReport.DataSource = objReportDal.GeneratFoodReport( false, false, true);
                            gvGeneralReport.DataBind();
                            break;
                        case "month":
                            gvGeneralReport.DataSource = objReportDal.GeneratFoodReport( false, false, false, true);
                            gvGeneralReport.DataBind();
                            break;
                        case "custom":
                            if (txtEndDate.Text.Trim() == "" || txtStartDate.Text.Trim() == "")
                            {
                                ScriptManager.RegisterStartupScript(this, typeof(Page), "UpdateMsg1", "$(document).ready(function(){alert('Please Enter Start date and End Date.');});", true);
                            }
                            else
                            {
                                DateTime? startDate = DateTime.ParseExact(txtStartDate.Text.Trim(), "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                                DateTime? endDate = DateTime.ParseExact(txtEndDate.Text.Trim(), "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);

                                gvGeneralReport.DataSource = objReportDal.GeneratFoodReport( false, false, false, false, startDate, endDate);
                                gvGeneralReport.DataBind();
                            }
                            break;
                    }
                }


            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}