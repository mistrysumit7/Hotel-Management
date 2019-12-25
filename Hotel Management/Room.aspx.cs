using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAL = Hotel_Management.DAL;

namespace Hotel_Management
{
   
    public partial class Room : System.Web.UI.Page
    {
        public int roomId
        {
            get { return (int)(ViewState["roomId"] ?? 0); }
            set { ViewState["roomId"] = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Button btnRoomMaster = Master.FindControl("btnRoomMaster") as Button;
                btnRoomMaster.CssClass = "btn btn-outline btn-default active";
                RoomTypeBind();
                BindRoomGrid();
            }
            gvRoomMaster.RowCommand += GvRoomMaster_RowCommand;
        }

        private void RoomTypeBind()
        {
            try
            {
                DAL.RoomDetail objRoom = new DAL.RoomDetail();
                ddlRoomType.DataSource = objRoom.getRoomTypeList(0);
                ddlRoomType.DataValueField = "RoomType_Id";
                ddlRoomType.DataTextField = "RoomType_Name";
                ddlRoomType.DataBind();
                objRoom = null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        private void GvRoomMaster_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "Modify")
                {
                    int rowIndex = Convert.ToInt32(e.CommandArgument);
                    txtRoomNo.Text = gvRoomMaster.Rows[rowIndex].Cells[0].Text;
                    ddlRoomType.SelectedValue = gvRoomMaster.DataKeys[rowIndex]["RoomType_Id"].ToString();
                    txtSingleRoomRate.Text = gvRoomMaster.Rows[rowIndex].Cells[2].Text;
                    txtDoubleRoomRate.Text = gvRoomMaster.Rows[rowIndex].Cells[3].Text;
                    roomId = Convert.ToInt32(gvRoomMaster.DataKeys[rowIndex]["Room_id"].ToString());
                    btnSave.Text = "Update";
                }
            }
            catch(Exception ex)
            { throw ex; }
        }

        private void BindRoomGrid()
        {
            try
            {
                DAL.RoomDetail objRoom = new DAL.RoomDetail();
                gvRoomMaster.DataSource= objRoom.getRoomMasterList();
                gvRoomMaster.DataBind();
                objRoom = null;
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
                //System.Threading.Thread.Sleep(500000);
                DAL.RoomMasterEntity objRoomMasterEntity = new DAL.RoomMasterEntity();
                objRoomMasterEntity.Room_No = txtRoomNo.Text.Trim();
                objRoomMasterEntity.Room_TypeId = Convert.ToInt32(ddlRoomType.SelectedValue.Trim());
                objRoomMasterEntity.Room_Status = "";
                objRoomMasterEntity.Room_SingleRate = Convert.ToInt32(txtSingleRoomRate.Text.Trim());
                objRoomMasterEntity.Room_DoubleRate = Convert.ToInt32(txtDoubleRoomRate.Text.Trim());
                objRoomMasterEntity.Room_Active = chkRoomActive.Checked;
                DAL.RoomDetail objRoomDetail = new DAL.RoomDetail();
                if (btnSave.Text.ToUpper() == "UPDATE")
                {
                    objRoomMasterEntity.Room_id = roomId;
                    objRoomDetail.Update_RoomMaster(objRoomMasterEntity);
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "Clear", "alert('Updated successfully');", true);
                }
                else
                {
                    objRoomDetail.Insert_RoomMaster(objRoomMasterEntity);
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "Clear", "alert('Add successfully');", true);
                }
                objRoomDetail = null;
                objRoomMasterEntity = null;
                btnSave.Text = "Save";
                BindRoomGrid();
                txtDoubleRoomRate.Text = "";
                txtRoomNo.Text = "";
                txtSingleRoomRate.Text = "";
                ddlRoomType.SelectedIndex = 0;
            }
            catch (Exception ex)
            { throw ex; }
        }
    }
}