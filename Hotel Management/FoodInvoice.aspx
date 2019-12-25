<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="FoodInvoice.aspx.cs" Inherits="Hotel_Management.FoodInvoice" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function PrintPanel() {
            var panel = document.getElementById("<%=pnlContents.ClientID %>");
            var printWindow = window.open('', '', 'height=200,width=800');
            printWindow.document.write('<html><head><title></title>');
            printWindow.document.write('</head><body >');
            printWindow.document.write(panel.innerHTML);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            setTimeout(function () {
                printWindow.print();
            }, 500);
            return false;
        }

        function confirmDelete() {
            return confirm("Are you sure you want to delete this?");
        }
    </script>
    <style>
        .th {
            text-align: center !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cont1" runat="server">
     <asp:UpdatePanel runat="server" ID="upmain" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Panel ID="pnlContents" runat="server">

                <div class="wrapper clearfix">
                    <div class="col-md-12 main">

                        <table style="width: 105%; margin-top: 5px;">

                            <%--<tr>
                                    <td>
                                            <strong style="font-size:large;">apple Residency</strong><br>
                                            ,1st Floor, Panchvati  Complex ,
                                            <br /> Nr.Railway Over bridge ,
                                            <br /> Chanasma Highway, 
                                        <br />Patan - 384 265.(NG)
                            <br>
                                            Phone: 02766 297033<br>
                                            <%--Email: <span id="company-email">sumitm@rocketmail.com</span><br>
                                            www.appleresidency.co.in
                                        
                                    </td>
                                    <td> <strong>Billed To : </strong> <asp:Label runat="server" ID="lblCustomerName"></asp:Label>
                                    </td>
                                    <td>
                                        <strong>Booking ID:</strong>
                                        <input type="text" class="text-right" id="booking_id" disabled="" value="8490709972" style="width: 80px; outline: none; border: none !important; -webkit-box-shadow: none !important; -moz-box-shadow: none !important; box-shadow: none !important;">
                                        <br>
                                        Room: <asp:Label runat="server" ID="lblRoomList" > </asp:Label> <br />
                                        Check In Date: <asp:Label runat="server" ID="lblCheckInDate"></asp:Label> <br>
                                        Check Out Date:<asp:Label runat="server" ID="lblCheckOutDate"></asp:Label><br>
                                    </td>
                                </tr>--%>
                            <tr>

                                <%-- <td> <strong>Billed To : </strong> <asp:Label runat="server" ID="lblCustomerName"></asp:Label>
                                    </td>--%>

                                <td style="text-align: center;" colspan="3">
                                    <img src="Image/logo.png" />
                                    <br />
                                    1st Floor, Panchvati  Complex ,
                                             Nr.Railway Over bridge ,
                                            Chanasma Highway, 
                                        Patan - 384 265.(NG)
                            <br />
                                    Phone: 02766 297033  ,  Mobile No.   081 53 98 88 51
   
                                            <%--Email: <span id="company-email">sumitm@rocketmail.com</span><br>--%>
                                    <br />
                                    www.appleresidency.co.in , Email - info@appleresidency.co.in
                                        <br />
                                  <b>   GSTIN :- 24ABAFA4714G2ZY</b>
                                </td>
                                <%--<td>
                                        <strong>Booking ID:</strong>
                                        <input type="text" class="text-right" id="booking_id" disabled="" value="8490709972" style="width: 80px; outline: none; border: none !important; -webkit-box-shadow: none !important; -moz-box-shadow: none !important; box-shadow: none !important;">
                                        <br>
                                        Room: <asp:Label runat="server" ID="lblRoomList" > </asp:Label> <br />
                                        Check In Date: <asp:Label runat="server" ID="lblCheckInDate"></asp:Label> <br>
                                        Check Out Date:<asp:Label runat="server" ID="lblCheckOutDate"></asp:Label><br>
                                    </td>--%>
                            </tr>
                            <tr>
                                <td colspan="3" style="text-align: center;">
                                    <br />
                                    <h1 style="font-weight: bold;">FOOD BILL </h1>
                                    <hr />
                                </td>
                            </tr>
                        </table>
                        <div style="border: 1px solid black; border-radius: 5px;">
                            <table style="width: 100%;">
                                <tr>
                                    <td colspan="3" style="text-align: right;">
                                        <strong>Date of Issue : </strong>
                                        <asp:Label runat="server" ID="lblDate" Text="lblDate"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 15%; text-align: right;">
                                        <strong>Billed To : </strong>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="lblCustomerName" Text="customer Name"></asp:Label>
                                    </td>
                                    <td style="text-align: right;">
                                        <strong>Invoice No : </strong>
                                        FD-<asp:Label runat="server" Text="000000001" ID="lblBillNumber"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;">
                                        <strong>Address : </strong>
                                    </td>
                                    <td colspan="2">
                                        <asp:Label runat="server" ID="lblAddress" Text="Customer Address"></asp:Label>
                                    </td>

                                </tr>
                                <tr runat="server" id="tdCompanyName">
                                    <td style="text-align: right;">
                                        <strong>Company Name : </strong> 
                                    </td>
                                    <td colspan="2">
                                       <asp:Label runat="server" ID="lblCompanyName" Text="Customer Address"></asp:Label>
                                    </td>

                                </tr>
                                 <tr runat="server" id="tdCompanyGSTName">
                                    <td style="width: 10%; text-align: right;">
                                       <strong>Company GST : </strong> 
                                    </td>
                                    <td colspan="2">
                                       <asp:Label runat="server" ID="lblCompanyGST" Text=""></asp:Label>
                                    </td>

                                </tr>
                                <tr>
                                    <td>
                                        <br />
                                    </td>
                                </tr>
                                <tr>

                                    <td colspan="3" style="border: 0;">
                                        <asp:GridView runat="server" ID="gvCharge" Style="width: 100%; border: 0 hidden!important;"
                                            AutoGenerateColumns="false" >
                                            <HeaderStyle CssClass="thd" />

                                            <Columns>
                                                <asp:BoundField DataField="ItemName" ItemStyle-HorizontalAlign="Center" HeaderText="Item Name" ItemStyle-BorderColor="White" />
                                                <asp:BoundField DataField="RoomNo" ItemStyle-HorizontalAlign="Center" HeaderText="Room No" ItemStyle-BorderColor="White" />
                                                <asp:BoundField DataField="Order Date" ItemStyle-HorizontalAlign="Center" HeaderText="Order Date" ItemStyle-BorderColor="White" />
                                                <asp:BoundField DataField="PricePerPc" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" HeaderText="Price" ItemStyle-BorderColor="White" />
                                                <asp:BoundField DataField="Quantity" ItemStyle-HorizontalAlign="Center" HeaderText="Quantity" ItemStyle-BorderColor="White" />
                                                <asp:BoundField DataField="FinalPrice" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderText="Final Amount" ItemStyle-BorderColor="White" />
                                            </Columns>

                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td style="text-align: right;">
                                        <table style="width: 100%; text-align: right;">
                                            <%--<tr>
                                                <td></td>
                                                <td>
                                                    <strong>Room Charge :</strong>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblRoomCharge" Text="Rm_charg"></asp:Label>
                                                </td>
                                            </tr>--%>

                                           <%-- <tr>
                                                <td></td>
                                                <td>
                                                    <strong>Discount : </strong>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblDiscount" Text="Discount"></asp:Label>
                                                </td>
                                            </tr>--%>
                                            <%--<tr>
                                                <td></td>
                                                <td>
                                                    <strong>
                                                        <asp:Label runat="server" ID="lblExtraChargesName"></asp:Label>
                                                    </strong>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblExtraChargesAmount"></asp:Label>
                                                </td>
                                            </tr>--%>
                                           <%-- <tr>
                                                <td></td>
                                                <td>
                                                    <strong>Luxury Tax :</strong>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblLuxaryTax" Text="Luxury Tax"></asp:Label>
                                                </td>
                                            </tr>--%>

                                           <%-- <tr>
                                                <td></td>
                                                <td>
                                                    <strong>Service Tax :</strong>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblServiceTax" Text="Service Tax"></asp:Label>
                                                </td>
                                            </tr>--%>
                                            <tr>
                                                <td></td>
                                                <td>
                                                    <strong>CGST(2.5 %) :</strong>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblCGSTFood" Text="Luxury Tax"></asp:Label>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td></td>
                                                <td>
                                                    <strong>SGST(2.5 %):</strong>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblSGSTFood" Text="Luxury Tax"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>
                                                    <strong>Invoice Value:
                                                    </strong>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblBillAmount" Font-Bold="true" Text="Bill Amount"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>

                                </tr>
                                <tr>
                                    <td>
                                         
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: left;" colspan="2">Subject to Patan Jurisdiction
                             
                                <br />
                                        THANKS FOR STAYING WITH US
                                    </td>

                                    <td style="text-align: right;">
                                        <strong>HOTEL APPLE RESIDENCY</strong>
                                        <br />
                                        <br />

                                        <br />
                                        Authorized Signature
                                    </td>
                                </tr>
                            </table>
                        </div>

                    </div>
                </div>
            </asp:Panel>
               <div class="text-center" style="margin-bottom: 20px; margin-top: 20px;">
                   <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn btn-primary" OnClientClick="return PrintPanel();" />
                     &nbsp;&nbsp;&nbsp;
                    <asp:Button runat="server" ID="btnAddFoodItem" Text="Add Food Item" OnClick="btnAddFoodItem_Click" CssClass="btn btn-primary bottom-right" />

                   </div>
            <asp:ModalPopupExtender ID="mpFood" runat="server" PopupControlID="panelFood" TargetControlID="Button2"
                 BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:Button ID="Button2" runat="server" Style="display: none;" />
            <asp:Panel ID="panelFood" runat="server" ScrollBars="Vertical" CssClass="modalPopup" align="center" Style="display: none;">
                <div class="form-horizontal">
                    <div class="form-group">
                        <div class="col-lg-12 text-center">
                            <h2>Food Service </h2>
                            <label id="lblFoodError" class="text-danger"></label>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="col-lg-12">
                            <div class="col-lg-3">
                                <label class="control-label">Food Item : <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-lg-7">
                                <asp:DropDownList runat="server" CssClass="form-control" ID="ddlFoodItem"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                  <%--  <div class="form-group">
                        <div class="col-lg-12">
                            <div class="col-lg-3">
                                <label class="control-label">Rate : <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-lg-7">
                                <asp:TextBox runat="server" ID="txtItemPrice" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>--%>
                    <div class="form-group">
                        <div class="col-lg-12 text-center">
                            <div class="col-lg-3 text-center">
                                <label class="control-label ">Quantity: <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-lg-7">
                                <asp:TextBox runat="server" ID="txtQuntity" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                     <div class="form-group">
                        <div class="col-lg-12 text-center">
                            <div class="col-lg-3 text-center">
                                <label class="control-label ">Room No: <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-lg-7">
                                <asp:DropDownList runat="server" CssClass="form-control" ID="ddlRoomListFromCustomer"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12">
                            <div class="col-lg-3"></div>
                            <div class="col-lg-3">
                                <asp:Button ID="btnSaveFood" runat="server" OnClick="btnSaveFood_Click" OnClientClick="return Validatefood();" CssClass="btn btn-primary" Text="Save" />
                            </div>
                            <div class="col-lg-2">
                                <asp:Button ID="btnCloseFood" runat="server" OnClick="btnCloseFood_Click" CssClass="btn btn-primary" Text="Close" />
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="col-lg-12">
                            <asp:GridView runat="server" EmptyDataText="No Food added this customer" OnRowCommand="gvFoodDetail_RowCommand" CssClass="table table-striped table-bordered table-hover" ID="gvFoodDetail" AutoGenerateColumns="false" DataKeyNames="CustomerFoodDetailId,FoodItemId">
                                <Columns>
                                    <asp:BoundField DataField="ItemName" HeaderText="Item Name" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"/>
                                    <asp:BoundField DataField="PricePerPc" HeaderText="Rate" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"/>
                                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="RoomNo" HeaderText="Room No" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="FinalPrice" HeaderText="Final Price" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                                    <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="EditButton" runat="server" Height="20" Width="20"
                                                ImageUrl="~/Image/pencil.png" AlternateText="Edit" ToolTip="Edit"
                                                CommandName="Modify" CommandArgument='<%# Container.DataItemIndex %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="DeleteButton" runat="server" Height="20" Width="20"
                                                ImageUrl="~/Image/delete.png" AlternateText="Delete" ToolTip="Delete"
                                                CommandName="RemoveFood" CommandArgument='<%# Container.DataItemIndex %>'
                                                OnClientClick="return confirmDelete();" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            </ContentTemplate>
        <Triggers>
              <asp:AsyncPostBackTrigger ControlID="gvFoodDetail" EventName="RowCommand" />
              <asp:AsyncPostBackTrigger ControlID="btnSaveFood" EventName="Click" />
              <asp:AsyncPostBackTrigger ControlID="btnCloseFood" EventName="Click" />
             <asp:AsyncPostBackTrigger ControlID="btnAddFoodItem" EventName="Click" />
        </Triggers>
        </asp:UpdatePanel>
</asp:Content>
