<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="FoodMaster.aspx.cs" Inherits="Hotel_Management.FoodMaster" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cont1" runat="server">
    <script type="text/javascript">
        function confirmDelete() {
            return confirm("Are you sure you want to delete this?");
        }
         function ClearControlCust() {
            document.getElementById("<%= txtFoodName.ClientID %>").value = "";
            document.getElementById("<%= txtFoodType.ClientID %>").value = "";
            document.getElementById("<%= txtItemCode.ClientID %>").value = "";
            document.getElementById("<%= txtPrice.ClientID %>").value = "";
            return false;
        }
    </script>
     <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="form-horizontal">
                <div class="col-lg-12">
                    <div class="col-lg-10" style="vertical-align:bottom;">
                        <h1 class="text-center">Food Master
                        </h1>
                    </div>
                    <div class="col-lg-2 text-right" style="vertical-align:bottom;margin-top: 35px;" >
                        <asp:Button runat="server" ID="btnAddFood" Text="+ Add New Item"  CssClass="btn btn-primary" />
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel-body">
                            <asp:GridView runat="server" ID="gvFoodMaster" AutoGenerateColumns="false" OnRowCommand="gvFoodMaster_RowCommand" CssClass="table table-striped table-bordered table-hover" DataKeyNames="FoodItemId">
                                <Columns>
                                    <asp:BoundField DataField="ItemName"  HeaderText="Item Name" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="FoodType"  HeaderText="Food Type" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="PricePerPc" ItemStyle-HorizontalAlign="Right" HeaderText="Price" HeaderStyle-HorizontalAlign="Right"/>
                                    <asp:BoundField DataField="FoodItemCode"  ItemStyle-HorizontalAlign="Center"  HeaderText="Item Code" />
                                    <asp:ButtonField ImageUrl="~/Image/pencil.png" HeaderText="Edit" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" ButtonType="Image" ControlStyle-Height="20" ControlStyle-Width="20" CommandName="Modify" />
                                    <asp:TemplateField HeaderText="Delete" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="DeleteButton" runat="server" Height="20" Width="20"
                                                ImageUrl="~/Image/delete.png" AlternateText="Delete" ToolTip="Delete"
                                                CommandName="Remove" CommandArgument='<%# Container.DataItemIndex %>'
                                                OnClientClick="return confirmDelete();" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
              <asp:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panel1" TargetControlID="btnAddFood"
                CancelControlID="btntst" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:Button ID="btntst" runat="server" Style="display: none;" />
            <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup" align="center" Style="display: none; height: auto;">
                <div class="form-horizontal">
                    <div class="col-lg-12">

                        <h1 class="text-center">Food Detail
                        </h1>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12">
                            <div class="col-lg-3">

                                <label class="control-label">Food Name : <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-lg-5">
                                <asp:TextBox runat="server"  ID="txtFoodName" CssClass="form-control">

                                </asp:TextBox>
                            </div>
                            <div class="col-lg-4">
                                <asp:RequiredFieldValidator runat="server" ID="rqValFoodName" ControlToValidate="txtFoodName"
                                    ForeColor="Red" ValidationGroup="food" ErrorMessage="Enter Food Name"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12">
                            <div class="col-lg-3">

                                <label class="control-label">Food type : <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-lg-5">
                                <asp:TextBox runat="server" ID="txtFoodType" CssClass="form-control">

                                </asp:TextBox>
                            </div>
                            <div class="col-lg-4">
                                <asp:RequiredFieldValidator ValidationGroup="food" runat="server" ID="rqValFoodType" ControlToValidate="txtFoodType"
                                    ForeColor="Red" ErrorMessage="Enter Food type"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12">
                            <div class="col-lg-3">

                                <label class="control-label">Food Price : <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-lg-5">
                                <asp:TextBox runat="server" ID="txtPrice" CssClass="form-control">
                                </asp:TextBox>
                            </div>
                            <div class="col-lg-4">
                                <asp:RequiredFieldValidator ValidationGroup="food" runat="server" ID="rqValPrice" ControlToValidate="txtPrice"
                                    ForeColor="Red" ErrorMessage="Enter Food Price"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12">
                            <div class="col-lg-3">

                                <label class="control-label">Item Code :</label>
                            </div>
                            <div class="col-lg-5">
                                <asp:TextBox runat="server" ID="txtItemCode" CssClass="form-control">
                                </asp:TextBox>
                            </div>
                            <div class="col-lg-4">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12">
                            <div class="col-lg-3">
                            </div>
                            <div class="col-lg-2">

                                <asp:Button runat="server" OnClick="btnSave_Click" ID="btnSave" ValidationGroup="food" CssClass="btn btn-primary" Text="Save" />
                            </div>
                            <div class="col-lg-1">
                                <asp:Button runat="server" ID="btnClear" CssClass="btn btn-primary" OnClientClick="return ClearControlCust()" Text="Clear All" />
                            </div>

                        </div>
                    </div>
                </div>
            </asp:Panel>
            </ContentTemplate>
         <Triggers>
             <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
             <asp:AsyncPostBackTrigger ControlID="gvFoodMaster" EventName ="RowCommand" />
             <asp:AsyncPostBackTrigger ControlID="btnAddFood" EventName="Click" />
         </Triggers>
         </asp:UpdatePanel>
</asp:Content>
