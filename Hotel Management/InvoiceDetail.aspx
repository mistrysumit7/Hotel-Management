<%@ Page Title="Generate Invoice" Language="C#" MasterPageFile="~/SiteMaster.Master" ValidateRequest="false" AutoEventWireup="true" CodeBehind="InvoiceDetail.aspx.cs" Inherits="Hotel_Management.InvoiceDetail" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

        function GeneratePdf() {
            debugger;
            var html = document.getElementById("divMainCSS").innerHTML;
            document.getElementById("<%=hfDivHtml.ClientID %>").value = html;
            return true;
        }

        function PrintPanel() {
            var panel = document.getElementById("<%=pnlContents.ClientID %>");
            var printWindow = window.open('', '', 'height=400,width=800');
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

        function calculatepaidamount() {
            var dueAmount = document.getElementById("<%=txtDueAmount.ClientID %>").value;
            var paidamount = document.getElementById("<%=txtPaidAmount.ClientID %>").value;
            document.getElementById("<%=txtDueAmount.ClientID %>").value = dueAmount - paidamount;
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
                    <div class="col-md-12 main" id="divMainCSS">

                        <table style="width: 105%; margin-top: 50px;">

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
   <br />
                                   www.appleresidency.co.in , Email - info@appleresidency.co.in
                                            <%--Email: <span id="company-email">sumitm@rocketmail.com</span><br>--%>
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
                                    <h1 style="font-weight: bold;">TAX INVOICE </h1>
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
                                    <td style="width: 10%; text-align: left;">
                                        &nbsp;
                                    </td>
                                    <td>
                                        <strong>Billed To : </strong><asp:Label runat="server" ID="lblCustomerName" Text="customer Name"></asp:Label>
                                    </td>
                                    <td style="text-align: right;">
                                        <strong>Invoice No : </strong>
                                        <asp:Label runat="server" Text="000000001" ID="lblBillNumber"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                   <td style="width: 10%; text-align: left;">
                                        &nbsp;
                                    </td>
                                    <td colspan="2">
                                        <strong>Address : </strong><asp:Label runat="server" ID="lblAddress" Text="Customer Address"></asp:Label>
                                    </td>

                                </tr>
                                 <tr runat="server" id="tdCompanyName">
                                    <td style="width: 10%; text-align: left;">
                                        &nbsp;
                                    </td>
                                    <td colspan="2">
                                      <strong>Company Name : </strong>  <asp:Label runat="server" ID="lblCompanyName" Text="Customer Address"></asp:Label>
                                    </td>

                                </tr>
                                 <tr runat="server" id="tdCompanyGSTName">
                                    <td style="width: 10%; text-align: left;">
                                        &nbsp;
                                    </td>
                                    <td colspan="2">
                                       <strong>Company GST : </strong> <asp:Label runat="server" ID="lblCompanyGST" Text="Customer Address"></asp:Label>
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
                                            AutoGenerateColumns="false" OnRowCommand="gvCharge_RowCommand">
                                            <HeaderStyle CssClass="thd" />

                                            <Columns>
                                                <asp:BoundField DataField="Room No" ItemStyle-HorizontalAlign="Center" HeaderText="Room No" ItemStyle-BorderColor="White" />
                                                <asp:BoundField DataField="Arrival Date" ItemStyle-HorizontalAlign="Center" HeaderText="Arrival Date" ItemStyle-BorderColor="White" />
                                                <asp:BoundField DataField="Departure Date" ItemStyle-HorizontalAlign="Center" HeaderText="Departure Date" ItemStyle-BorderColor="White" />
                                                <asp:BoundField DataField="Description" ItemStyle-HorizontalAlign="Center" HeaderText="Description" ItemStyle-BorderColor="White" />
                                                <asp:BoundField DataField="RoomPrice" ItemStyle-HorizontalAlign="Center" HeaderText="Tarrif" ItemStyle-BorderColor="White" />
                                                <asp:BoundField DataField="NoOfDays" ItemStyle-HorizontalAlign="Center" HeaderText="Days" ItemStyle-BorderColor="White" />
                                                <asp:BoundField DataField="finalAmount" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderText="Final Amount" ItemStyle-BorderColor="White" />
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
                                            <tr>
                                                <td></td>
                                                <td>
                                                    <strong>Total :</strong>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblRoomCharge" Text="Rm_charg"></asp:Label>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td></td>
                                                <td>
                                                    <strong>Discount : </strong>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblDiscount" Text="Discount"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>
                                                    <strong>
                                                        <asp:Label runat="server" ID="lblExtraChargesName"></asp:Label>
                                                    </strong>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblExtraChargesAmount"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>
                                                    <strong>CGST(<asp:Label runat="server" ID="lblCGSTPercentage"></asp:Label>%) :</strong>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblCGST" Text="Luxury Tax"></asp:Label>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td></td>
                                                <td>
                                                    <strong>SGST(<asp:Label runat="server" ID="lblSGSTPercentage"></asp:Label>%):</strong>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblSGST" Text="Luxury Tax"></asp:Label>
                                                </td>
                                            </tr>

                                            <tr style="display: none;">
                                                <td></td>
                                                <td>
                                                    <strong>Service Tax :</strong>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblServiceTax" Text="Service Tax"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>
                                                    <strong>Invoice Value :
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
    <asp:Button runat="server" ID="btnAddCharge" OnClick="btnAddCharge_Click" Text="Add Extra Payment" CssClass="btn btn-primary" />
                &nbsp;&nbsp;&nbsp;
                    <asp:Button runat="server" ID="btnPayment" Text="Add Payment" OnClick="btnPayment_Click" CssClass="btn btn-primary bottom-right" />
                &nbsp;&nbsp;&nbsp;
                    <asp:Button runat="server" ID="btnGenerateFoodInvoice" Text="Print Food bill" OnClick="btnGenerateFoodInvoice_Click" CssClass="btn btn-primary bottom-right" />
                &nbsp;&nbsp;&nbsp;
                    <asp:Button runat="server" ID="btnGeneratePdf" Text="Generate PDF" OnClientClick="return GeneratePdf();" OnClick="btnGeneratePdf_Click" CssClass="btn btn-primary bottom-right" />
                <asp:HiddenField runat="server" ID="hfDivHtml" />
                <asp:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panel1" TargetControlID="btntst"
                    BackgroundCssClass="modalBackground">
                </asp:ModalPopupExtender>
                <asp:Button ID="btntst" runat="server" Style="display: none;" />
                <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup" Height="550px" align="center" Style="display: none">
                    <table style="width: 85%;">
                        <tr>
                            <td colspan="2" class="text-center">
                                <h2>Extra Charges</h2>
                                <br />
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <label class="control-label">Charge Type:</label>
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="txtChargeType" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ForeColor="Red" ValidationGroup="Invoice" Display="Dynamic" runat="server" ID="rqvalChargeType" ControlToValidate="txtChargeType" ErrorMessage="Enter Charge Type"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">

                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label">Charge Amount:</label>
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="txtAmount" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ForeColor="Red" ValidationGroup="Invoice" Display="Dynamic" runat="server" ID="rqvalChargeAmount" ControlToValidate="txtAmount" ErrorMessage="Enter Charge Amount"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td></td>

                            <td>
                                <asp:Button ID="btnSavePayment" ValidationGroup="Invoice" runat="server" OnClick="btnSavePayment_Click" CssClass="btn btn-primary" Text="Save Payment" />
                                &nbsp;&nbsp;&nbsp;<asp:Button ID="btnClose" OnClick="btnClose_Click" runat="server" CssClass="btn btn-primary" Text="Close" />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:GridView runat="server" OnRowCommand="gvPaymentHistory_RowCommand" ID="gvPaymentHistory" AutoGenerateColumns="false" EmptyDataText="No Payment Hisotry" CssClass="table table-striped table-bordered table-hover" DataKeyNames="Cust_Misc_Charge_Id">
                        <Columns>
                            <asp:BoundField DataField="Misc_Charge_Name" HeaderText="Charge Name" />
                            <asp:BoundField DataField="Amount" HeaderText="Charge Amount" />
                            <%--  <asp:ButtonField ImageUrl="~/Image/pencil.png" ItemStyle-HorizontalAlign="Center" HeaderText="Edit" ItemStyle-VerticalAlign="Middle" ButtonType="Image" ControlStyle-Height="20" ControlStyle-Width="20" CommandName="Modify" />
                            <asp:ButtonField CommandName="RemovePayment" ImageUrl="~/Image/delete.png" HeaderText="Delete" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" ButtonType="Image" ControlStyle-Height="20" ControlStyle-Width="20" />--%>
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
                                        CommandName="RemovePayment" CommandArgument='<%# Container.DataItemIndex %>'
                                        OnClientClick="return confirmDelete();" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:Panel>

                <%-- ------------------------------Add Payment ------------------------- --%>
                <asp:ModalPopupExtender ID="mpAddPayment" runat="server" PopupControlID="Panel2" TargetControlID="Button1"
                    CancelControlID="btnHidePayment" BackgroundCssClass="modalBackground">
                </asp:ModalPopupExtender>
                <asp:Button ID="Button1" runat="server" Style="display: none;" />
                <asp:Panel ID="Panel2" runat="server" CssClass="modalPopup" align="center" Style="display: none">
                    <table style="width: 85%;">
                        <tr>
                            <td colspan="2">
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label">Paid Amount:</label>
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="txtPaidAmount" CssClass="form-control"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">

                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label">Due Amount:</label>
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="txtDueAmount" CssClass="form-control"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label">Payment Type:</label>
                            </td>
                            <td>
                                <asp:DropDownList runat="server" CssClass="form-control" ID="ddlPaymentType">
                                    <asp:ListItem Text="Cash" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Card" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td></td>

                            <td>
                                <asp:Button ID="btnAddPayment" runat="server" CommandName="RoomList" OnClick="btnAddPayment_Click" CssClass="btn btn-primary" Text="Save Payment" />
                                &nbsp;&nbsp;&nbsp;<asp:Button ID="btnHidePayment" runat="server" CssClass="btn btn-primary" Text="Close" />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:GridView runat="server" ID="gvPaymentDetail" AutoGenerateColumns="true" EmptyDataText="No Payment Hisotry" CssClass="table table-striped table-bordered table-hover">
                    </asp:GridView>
                </asp:Panel>
            </div>

        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnAddCharge" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnSavePayment" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="gvPaymentHistory" EventName="RowCommand" />
            <asp:AsyncPostBackTrigger ControlID="btnPayment" EventName="Click" />
            <asp:PostBackTrigger ControlID="btnPrint" />
            <asp:PostBackTrigger ControlID="btnGeneratePdf" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
