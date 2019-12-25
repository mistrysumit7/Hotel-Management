using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hotel_Management
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                bindSummary();
            }
        }

        //protected void UpdateTimer_Tick(object sender, EventArgs e)
        //{
        //    bindSummary();
        //}

        void bindSummary()
        {
            DataTable dtActivity = DAL.Dashboard_Summary.GetTodaysActivity();
            dlTodaysSummary.DataSource = dtActivity;
            dlTodaysSummary.DataBind();
        }
    }
}