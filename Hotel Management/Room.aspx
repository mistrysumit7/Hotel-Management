<%@ Page Title="Room Master" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="Room.aspx.cs" Inherits="Hotel_Management.Room" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cont1" runat="server">
    <script type="text/javascript">
        function ClearControl() {
            document.getElementById("<%= txtRoomNo.ClientID %>").value = "";
            document.getElementById("<%= txtDoubleRoomRate.ClientID %>").value = "";
            document.getElementById("<%= txtSingleRoomRate.ClientID %>").value = "";
            document.getElementById("<%= ddlRoomType.ClientID %>").value = "";
            return false;
        }
    </script>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="form-horizontal">
                <div class="col-lg-12">
                    <h1 class="text-center">Room Master
                    </h1>
                </div>
                <div class="form-group">
                    <div class="col-lg-12">
                        <div class="col-lg-3">
                            <label class="control-label">Room No. :</label>
                        </div>
                        <div class="col-lg-6">
                            <asp:TextBox runat="server" ID="txtRoomNo" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-12">
                        <div class="col-lg-3">
                            <label class="control-label">Room Type :</label>
                        </div>
                        <div class="col-lg-6">
                            <asp:DropDownList runat="server" CssClass="form-control" ID="ddlRoomType"></asp:DropDownList>
                        </div>
                    </div>
                </div>
                <%--<div class="form-group">
            <div class="col-lg-12">
                <div class="col-lg-3">
                    <label class="control-label">Room Status :</label>
                </div>
                <div class="col-lg-6">
                    <asp:TextBox runat="server" ID="txtRoomStatus" CssClass="form-control"></asp:TextBox>
                </div>
            </div>
        </div>--%>
                <div class="form-group">
                    <div class="col-lg-12">
                        <div class="col-lg-3">
                            <label class="control-label">Single Room Rate :</label>
                        </div>
                        <div class="col-lg-6">
                            <asp:TextBox runat="server" ID="txtSingleRoomRate" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-12">
                        <div class="col-lg-3">
                            <label class="control-label">Double Room Rate :</label>
                        </div>
                        <div class="col-lg-6">
                            <asp:TextBox runat="server" ID="txtDoubleRoomRate" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-12">
                        <div class="col-lg-3">
                            <label class="control-label">Room Active :</label>
                        </div>
                        <div class="col-lg-6">
                            <asp:CheckBox runat="server" ID="chkRoomActive" Checked="true" />
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-12">
                        <div class="col-lg-3">
                        </div>
                        <div class="col-lg-1">
                            <asp:Button runat="server" ID="btnSave" OnClick="btnSave_Click" Text="SAVE" CssClass="btn btn-primary" />
                        </div>
                        <div class="col-lg-2">
                            <asp:Button runat="server" ID="btnClear" CssClass="btn btn-primary" Text="CLEAR" OnClientClick="return ClearControl()" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="panel-body">
                        <asp:GridView runat="server" ID="gvRoomMaster" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-hover" DataKeyNames="Room_id,RoomType_Id">
                            <Columns>
                                <asp:BoundField DataField="Room No" HeaderText="Room No" />
                                <asp:BoundField DataField="Room Type" HeaderText="Room Type" />
                                <asp:BoundField DataField="Single Rate" HeaderText="Single Rate" />
                                <asp:BoundField DataField="Double Rate" HeaderText="Double Rate" />
                                <asp:ButtonField ImageUrl="~/Image/pencil.png" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" ButtonType="Image" ControlStyle-Height="20" ControlStyle-Width="20" CommandName="Modify" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSave" />
            <asp:AsyncPostBackTrigger EventName="RowCommand" ControlID="gvRoomMaster" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
