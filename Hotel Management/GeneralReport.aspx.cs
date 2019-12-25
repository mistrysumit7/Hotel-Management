using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ReportDAL = Hotel_Management.DAL.Report;

namespace Hotel_Management
{
    public partial class GeneralReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Button btnGeneral = Master.FindControl("btnGeneral") as Button;
            btnGeneral.CssClass = "btn btn-outline btn-default active";
            if (!IsPostBack)
            {
                BindGrid();
            }

            btnExportExcel.Click += BtnExportExcel_Click;
            btnExportPDF.Click += BtnExportPDF_Click;
        }
        
        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }
        private void BindGrid()
        {
            try
            {
                ReportDAL objReportDal = new ReportDAL();
                gvGeneralReport.DataSource = objReportDal.GeneratReport("GENERAL");
                gvGeneralReport.DataBind();
                objReportDal = null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        

        protected void BtnExportExcel_Click(object sender, EventArgs e)
        {
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=General_Report.xls");
            Response.ContentType = "application/vnd.ms-excel";
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            gvGeneralReport.AllowPaging = false;
            //Change the Header Row back to white color
            gvGeneralReport.HeaderRow.Style.Add("background-color", "#FFFFFF");
            //Applying stlye to gridview header cells
            for (int i = 0; i < gvGeneralReport.HeaderRow.Cells.Count; i++)
            {
                gvGeneralReport.HeaderRow.Cells[i].Style.Add("background-color", "#507CD1");
            }
            int j = 1;
            //This loop is used to apply stlye to cells based on particular row
            foreach (GridViewRow gvrow in gvGeneralReport.Rows)
            {
                gvrow.BackColor = System.Drawing.Color.White;
                if (j <= gvGeneralReport.Rows.Count)
                {
                    if (j % 2 != 0)
                    {
                        for (int k = 0; k < gvrow.Cells.Count; k++)
                        {
                            gvrow.Cells[k].Style.Add("background-color", "#EFF3FB");
                        }
                    }
                }
                j++;
            }
            gvGeneralReport.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();



            //Response.Clear();
            //Response.Buffer = true;
            //Response.AddHeader("content-disposition", "attachment;filename=General_Report.xls");
            //Response.Charset = "";
            //Response.ContentType = "application/vnd.ms-excel";
            //using (StringWriter sw = new StringWriter())
            //{
            //    HtmlTextWriter hw = new HtmlTextWriter(sw);
            //    gvGeneralReport.AllowPaging = false;
            //    BindGrid();
            //    gvGeneralReport.HeaderRow.Style.Add("background-color", "#FFFFFF");
            //    //Applying stlye to gridview header cells
            //    for (int i = 0; i < gvGeneralReport.HeaderRow.Cells.Count; i++)
            //    {
            //        gvGeneralReport.HeaderRow.Cells[i].Style.Add("background-color", "#df5015");
            //    }
            //    gvGeneralReport.RenderControl(hw);

            //    //style to format numbers to string
            //    string style = @"<style> .textmode { } </style>";
            //    Response.Write(style);
            //    Response.Output.Write(sw.ToString());
            //    Response.Flush();
            //    Response.End();
            //}
        }

        protected void BtnExportPDF_Click(object sender, EventArgs e)
        {
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    gvGeneralReport.AllowPaging = false;
                    //Change the Header Row back to white color
                    gvGeneralReport.HeaderRow.Style.Add("background-color", "#FFFFFF");
                    //Applying stlye to gridview header cells
                    for (int i = 0; i < gvGeneralReport.HeaderRow.Cells.Count; i++)
                    {
                        gvGeneralReport.HeaderRow.Cells[i].Style.Add("background-color", "#507CD1");
                    }
                    int j = 1;
                    //This loop is used to apply stlye to cells based on particular row
                    foreach (GridViewRow gvrow in gvGeneralReport.Rows)
                    {
                        gvrow.BackColor = System.Drawing.Color.White;
                        if (j <= gvGeneralReport.Rows.Count)
                        {
                            if (j % 2 != 0)
                            {
                                for (int k = 0; k < gvrow.Cells.Count; k++)
                                {
                                    gvrow.Cells[k].Style.Add("background-color", "#EFF3FB");
                                }
                            }
                        }
                        j++;
                    }
                    gvGeneralReport.RenderControl(hw);
                    StringReader sr = new StringReader(sw.ToString());
                    Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
                    HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                    PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                    pdfDoc.Open();
                    htmlparser.Parse(sr);
                    pdfDoc.Close();

                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", "attachment;filename=General_Report.pdf");
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
                            gvGeneralReport.DataSource = objReportDal.GeneratReport("GENERAL", true);
                            gvGeneralReport.DataBind();
                            break;
                        case "yesterday":
                            gvGeneralReport.DataSource = objReportDal.GeneratReport("GENERAL", false, true);
                            gvGeneralReport.DataBind();
                            break;
                        case "week":
                            gvGeneralReport.DataSource = objReportDal.GeneratReport("GENERAL", false, false, true);
                            gvGeneralReport.DataBind();
                            break;
                        case "month":
                            gvGeneralReport.DataSource = objReportDal.GeneratReport("GENERAL", false, false, false, true);
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
                                
                                gvGeneralReport.DataSource = objReportDal.GeneratReport("GENERAL", false, false, false, false,startDate,endDate);
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


