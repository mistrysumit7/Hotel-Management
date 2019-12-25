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
    public partial class Deshboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindAllRoomsAvailability();
            }
            Button btnDeshboard = Master.FindControl("btnDashboard") as Button;
            btnDeshboard.CssClass = "btn btn-outline btn-default active";
            dlAvailableRooms.ItemCommand += DlAvailableRooms_ItemCommand;
            dlNonAvailableRooms.ItemCommand += DlNonAvailableRooms_ItemCommand;
            dlBookedRooms.ItemCommand += DlBookedRooms_ItemCommand;
        }

        private void DlBookedRooms_ItemCommand(object source, DataListCommandEventArgs e)
        {
            HiddenField hdn = (HiddenField)e.Item.FindControl("hdnCustomerBookingDetailID");
            //Response.Redirect("~/BookingDetail.aspx/?roomid=" + hdn.Value);
            Response.Redirect("~/BookingDetail.aspx?CustId=" + hdn.Value + "&bbbtttt=B", false);
        }

        private void DlNonAvailableRooms_ItemCommand(object source, DataListCommandEventArgs e)
        {
            HiddenField hdn = (HiddenField)e.Item.FindControl("hdnCustomerBookingDetailID");
            //Response.Redirect("~/BookingDetail.aspx/?roomid=" + hdn.Value);
            Response.Redirect("~/BookingDetail.aspx?CustBookingDetailId=" + hdn.Value + "&bbbtttt=I", false);
        }

        private void DlAvailableRooms_ItemCommand(object source, DataListCommandEventArgs e)
        {
            HiddenField hdn = (HiddenField)e.Item.FindControl("hdnRoomId");
            Response.Redirect("~/BookingDetail.aspx?roomid=" + hdn.Value);
            //Response.Redirect("~/BookingDetail.aspx",false);
        }

        private void BindAllRoomsAvailability()
        {
            try
            {
                DAL.RoomDetail objRoomAvailability = new DAL.RoomDetail();
                DataSet ds = objRoomAvailability.GetAllRoomsAvailability();

                dlAvailableRooms.DataSource = ds.Tables[0];
                dlAvailableRooms.DataBind();

                dlBookedRooms.DataSource = ds.Tables[1];
                dlBookedRooms.DataBind();

                dlNonAvailableRooms.DataSource = ds.Tables[2];
                dlNonAvailableRooms.DataBind();

                objRoomAvailability = null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}