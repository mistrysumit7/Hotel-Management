<%@ Page Title="Booking Detail" Culture="en-GB" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="BookingDetail.aspx.cs" Inherits="Hotel_Management.BookingDetail" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cont1" runat="server">
    <style type="text/css">
        div.ajax__calendar_days table tr td {
            padding-right: 0px;
        }

        .Calendar .ajax__calendar_container {
            border: 1px solid #E0E0E0;
            background-color: #FAFAFA;
            width: 175px;
        }

        .Calendar .ajax__calendar_header {
            font-family: Tahoma, Calibri, sans-serif;
            font-size: 12px;
            text-align: center;
            color: black;
            font-weight: normal;
            text-shadow: 0px 0px 2px #D3D3D3;
            height: 20px;
        }

        .Calendar .ajax__calendar_title,
        .Calendar .ajax__calendar_next,
        .Calendar .ajax__calendar_prev {
            color: #004080;
        }

        .Calendar .ajax__calendar_body {
            width: 175px;
            height: 150px;
            position: relative;
        }

        .Calendar .ajax__calendar_dayname {
            font-family: Tahoma, Calibri, sans-serif;
            font-size: 10px;
            text-align: center;
            color: #FA9900;
            font-weight: bold;
            text-shadow: 0px 0px 2px #D3D3D3;
            text-align: center !important;
            background-color: #EDEDED;
            border: solid 1px #D3D3D3;
            text-transform: uppercase;
            margin: 1px;
        }

        .Calendar .ajax__calendar_day {
            font-family: Tahoma, Calibri, sans-serif;
            font-size: 10px;
            text-align: center;
            font-weight: bold;
            text-shadow: 0px 0px 2px #D3D3D3;
            text-align: center !important;
            border: solid 1px #E0E0E0;
            text-transform: uppercase;
            margin: 1px;
            width: 17px !important;
            color: black;
        }

        .Calendar .ajax__calendar_hover .ajax__calendar_day,
        .Calendar .ajax__calendar_hover .ajax__calendar_month,
        .Calendar .ajax__calendar_hover .ajax__calendar_year,
        .Calendar .ajax__calendar_active {
            color: red;
            font-weight: bold;
            background-color: #ffffff;
        }

        .Calendar .ajax__calendar_year {
            border: solid 1px #E0E0E0;
            font-family: Tahoma, Calibri, sans-serif;
            font-size: 10px;
            text-align: center;
            font-weight: bold;
            text-shadow: 0px 0px 2px #D3D3D3;
            text-align: center !important;
            vertical-align: middle;
            margin: 1px;
        }

        .Calendar .ajax__calendar_month {
            border: solid 1px #E0E0E0;
            font-family: Tahoma, Calibri, sans-serif;
            font-size: 10px;
            text-align: center;
            font-weight: bold;
            text-shadow: 0px 0px 2px #D3D3D3;
            text-align: center !important;
            vertical-align: middle;
            margin: 1px;
        }

        .Calendar .ajax__calendar_today {
            font-family: Tahoma, Calibri, sans-serif;
            font-size: 10px;
            text-align: center;
            font-weight: bold;
            text-shadow: 0px 0px 2px #D3D3D3;
            text-align: center !important;
            text-transform: uppercase;
            margin: 1px;
            color: #6B6B6B;
        }

        .Calendar .ajax__calendar_other {
            background-color: #E0E0E0;
            margin: 1px;
            width: 17px;
        }

        .Calendar .ajax__calendar_hover .ajax__calendar_today,
        .Calendar .ajax__calendar_hover .ajax__calendar_title {
        }

        .Calendar .ajax__calendar_footer {
            width: 175px;
            border: none;
            height: 20px;
            vertical-align: middle;
            color: #6B6B6B;
        }

        img.PopupImg {
            vertical-align: middle;
            padding: 0px;
            margin: 0px;
            border: none;
        }
    </style>
    <script type="text/javascript">

        function ValidateCustomer() {
            debugger;
            var result, error_txt;
            error_txt = "";
            if (document.getElementById('cont1_txtCustomerName').value.trim() == "") {
                error_txt = "Enter Customer Name";
                document.getElementById('cont1_txtCustomerName').focus();
            }

            if (document.getElementById('cont1_txtProofNumber').value.trim() == "") {
                if (error_txt == "") {
                    error_txt = "Enter Customer Proof Number";
                    document.getElementById('cont1_txtProofNumber').focus();
                }
                else
                    error_txt = error_txt + ',' + "Proof Number";
               
            }

            if (document.getElementById('cont1_txtAgeOfCustomer').value.trim() == "") {
                if (error_txt == "") {
                    error_txt = "Enter Customer Age";
                    document.getElementById('cont1_txtAgeOfCustomer').focus();
                }
                else
                    error_txt = error_txt + ',' + "Age";
            }

            if (document.getElementById('cont1_txtNationality').value.trim() == "" ) {
                if (error_txt == "") {
                    error_txt = "Enter Customer Nationality";
                    document.getElementById('cont1_txtNationality').focus();
                }
                else
                    error_txt = error_txt + ',' + "Nationality";
            }

            if (document.getElementById('cont1_txtArrivalFrom').value.trim() == "" ) {
                if (error_txt == "") {
                    error_txt = "Enter Customer Arrival From";
                    document.getElementById('cont1_txtArrivalFrom').focus();
                }
                else
                    error_txt = error_txt + ',' + "Arrival From";
            }
            if (document.getElementById('cont1_txtDepartureTo').value.trim() == "" ) {
                if (error_txt == "") {
                    error_txt = "Enter Customer Departure To";
                    document.getElementById('cont1_txtDepartureTo').focus();
                }
                else
                    error_txt = error_txt + ',' + "Departure To";
            }
            if (document.getElementById('cont1_txtPhoneNumber').value.trim() == "" ) {
                if (error_txt == "") {
                    error_txt = "Enter Customer Phone Number";
                    document.getElementById('cont1_txtPhoneNumber').focus();
                }
                else
                    error_txt = error_txt + ',' + "Phone Number";
            }
            if (document.getElementById('cont1_txtEmail').value.trim() == "" ) {
                if (error_txt == "") {
                    error_txt = "Enter Customer Email";
                    document.getElementById('cont1_txtEmail').focus();
                }
                else
                    error_txt = error_txt + ',' + "Email";
            }
            if (error_txt == "") {
                return true;
            }
            else {
                document.getElementById("<%=lblCusterInfo.ClientID %>").innerHTML = error_txt;
                return false;
            }
        }

        function ValidateCustomerName() {
            if (document.getElementById("<%= txtCustomerName.ClientID %>").value == "") {
                alert("Please Enter Customer Name");
                return false;
            }
            else {
                return true;
            }
        }

        function Validatefood() {
            debugger;
            if (document.getElementById("<%=ddlFoodItem.ClientID %>").value == "" || document.getElementById("<%= txtQuntity.ClientID %>").value == "" || document.getElementById("<%= ddlRoomListFromCustomer.ClientID %>").value == "") {
                document.getElementById("lblFoodError").innerHTML = "* Select Food Item & Quantity & Room No.";
                return false;
            }
            else {
                document.getElementById("lblFoodError").innerHTML = "";
                return true;
            }

        }

        function ConfirmationBooking() {
            return confirm("Please Check all detail before Booking. Are you sure you want to Book room?");
        }

        function ConfirmationCheckIn() {
            return confirm("Please Check all detail before Check-In. Are you sure you want to Check In ?");
        }

        function ConfirmationCheckOut() {
            return confirm("You can not edit Detail after Check-Out room. Please Check all detail before Check-out. Are you sure you want to Check out ?");
        }

        function confirmDelete() {
            return confirm("Are you sure you want to delete this?");
        }

        function ClearControlCust() {
            document.getElementById("<%= txtCustomerName.ClientID %>").value = "";
            document.getElementById("<%= txtCustAddress.ClientID %>").value = "";
            document.getElementById("<%= ddlAdult.ClientID %>").value = "";
            document.getElementById("<%= ddlChildren.ClientID %>").value = "";
            document.getElementById("<%= ddlProof.ClientID %>").value = "";
            document.getElementById("<%= txtProofNumber.ClientID %>").value = "";
            document.getElementById("<%= txtAgeOfCustomer.ClientID %>").value = "";
            document.getElementById("<%= txtNationality.ClientID %>").value = "";
            document.getElementById("<%= txtArrivalFrom.ClientID %>").value = "";
            document.getElementById("<%= txtDepartureTo.ClientID %>").value = "";
            document.getElementById("<%= txtPhoneNumber.ClientID %>").value = "";
            document.getElementById("<%= txtEmail.ClientID %>").value = "";
            document.getElementById("<%= txtCompanyName.ClientID %>").value = "";
            document.getElementById("<%= txtCompanyGST.ClientID %>").value = "";
            document.getElementById("<%= lblCusterInfo.ClientID%>").innerHTML = "";
            return false;
        }
        function ClearControl() {

            document.getElementById("<%= txtBookingNotes.ClientID %>").value = "";
            document.getElementById("<%= txtEndDate.ClientID %>").value = "";
            document.getElementById("<%= txtStartDate.ClientID %>").value = "";
            document.getElementById("<%= txtRoomPrice.ClientID %>").value = "";
            document.getElementById("<%= txtDiscountPercentage.ClientID %>").value = "";
            document.getElementById("<%= txtPriceAfterDiscount.ClientID %>").value = "";
           <%-- document.getElementById("<%= txtPaidAmount.ClientID %>").value = "";
            document.getElementById("<%= txtDueAmount.ClientID %>").value = "";--%>
            document.getElementById("<%= txtFinalAmount.ClientID %>").value = "";



           <%-- document.getElementById("<%= ddlBookingType.ClientID %>").value = "";--%>

            document.getElementById("<%= ddlRoomList.ClientID %>").value = "";

            return false;
        }
    </script>

    <script type="text/javascript">
        function CalculateDiscount() {
            debugger;
            var discountPercentage = document.getElementById("<%=txtDiscountPercentage.ClientID %>").value;
            var totallPrice = document.getElementById("<%=txtRoomPrice.ClientID %>").value;
            var discountvalue = parseFloat(discountPercentage / 100).toFixed(2);
            var priceAfterDiscount = parseFloat(totallPrice * discountvalue).toFixed(2);
            document.getElementById("<%= txtPriceAfterDiscount.ClientID %>").value = priceAfterDiscount;
            document.getElementById("<%=txtFinalAmount.ClientID %>").value = parseFloat(totallPrice - priceAfterDiscount).toFixed(2);
        }


        function calculatepaidamount() {
            debugger;
            var dueAmount = document.getElementById("<%=lblRequiredPayAmount.ClientID %>").innerHTML;
            var paidamount = document.getElementById("<%=txtPaidAmount.ClientID %>").value;
            document.getElementById("<%=txtDueAmount.ClientID %>").value = dueAmount - paidamount;
        }
    </script>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>

            <div class="form-horizontal">
                <div class="col-lg-12">
                    <h1 class="text-center">Booking
                    </h1>
                </div>

                <div class="form-group">
                    <div class="col-lg-12">
                        <div class="col-lg-2">
                            <label class="control-label">Customer Name :</label>
                        </div>
                        <div class="col-lg-9">
                            <asp:TextBox runat="server" ReadOnly="true" ID="txtCustomerNameMain" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-lg-1 text-center">
                            <asp:Button runat="server" ID="btnAddCustomer" CssClass="btn-danger" Font-Bold="true" Font-Size="Large" Text="+" />
                        </div>

                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-12 text-center">
                        <%--    <div class="col-sm-2">
                            
                        </div>--%>
                        <div class="col-lg-4">
                            <%--<select data-placeholder="Choose a State..." id="ddlState" runat="server" class="chzn-choices"
                            multiple style="width: 450px;">
                            <option value="1">Option 1</option>
                            <option value="2">Option 2</option>
                            <option value="3">Option 3</option>
                        </select>--%>
                            <label class="control-label">Room List :</label>
                            <asp:DropDownList runat="server" ID="ddlRoomList" CssClass="form-control">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Booking" ControlToValidate="ddlRoomList" ForeColor="Red" CssClass="has-error" ErrorMessage="Enter Room List">

                            </asp:RequiredFieldValidator>
                        </div>

                        <div class="col-lg-2">
                            <label class="control-label ">Start Date:</label>
                            <asp:TextBox runat="server" ID="txtStartDate" CssClass="form-control"></asp:TextBox>
                            <asp:CalendarExtender ID="CalendarExtender1"
                                PopupPosition="BottomRight" CssClass="Calendar" DefaultView="Days" PopupButtonID="popupButtonStart" Format="dd/MM/yyyy" TargetControlID="txtStartDate" runat="server">
                            </asp:CalendarExtender>
                            <asp:RequiredFieldValidator ID="reqvaltxtStartDate" ValidationGroup="Booking" runat="server" ControlToValidate="txtStartDate" ForeColor="Red" ErrorMessage="Enter StartDate">
                            </asp:RequiredFieldValidator>
                            <asp:FilteredTextBoxExtender runat="server" TargetControlID="txtStartDate" FilterType="Custom" ValidChars="0123456789/" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                        </div>

                        <div class="col-lg-2">
                            <label class="control-label ">End Date:</label>
                            <asp:TextBox runat="server" ID="txtEndDate" CssClass="form-control"></asp:TextBox>
                            <asp:CalendarExtender PopupPosition="BottomRight" CssClass="Calendar" DefaultView="Days" PopupButtonID="popupButtonStart" ID="CalendarExtender2" Format="dd/MM/yyyy" TargetControlID="txtEndDate" runat="server"></asp:CalendarExtender>
                            <asp:RequiredFieldValidator ID="reqvaltxtEndDate" Display="Dynamic" ValidationGroup="Booking" runat="server" ControlToValidate="txtEndDate" ForeColor="Red" ErrorMessage="Enter EndDate">
                            </asp:RequiredFieldValidator>
                            <asp:CompareValidator runat="server" ID="cmpValDAte" ErrorMessage="Select Proper Date"
                                ControlToValidate="txtEndDate" Display="Dynamic" ControlToCompare="txtStartDate" Type="Date" ForeColor="Red" Operator="GreaterThanEqual" ValidationGroup="Booking">
                            </asp:CompareValidator>
                            <asp:FilteredTextBoxExtender runat="server" TargetControlID="txtEndDate" FilterType="Custom" ValidChars="0123456789/" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                        </div>

                        <div class="radio-inline col-lg-2" style="vertical-align: bottom central; padding-left: 50px; padding-top: 15px;">
                            <table>
                                <tr>
                                    <td>
                                        <asp:RadioButton runat="server" Text="Single" ID="rdbtnSingle" Checked="true" GroupName="rdbtnroomType" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:RadioButton runat="server" ID="rdbtnDouble" Text="Double" CssClass="control-label" GroupName="rdbtnroomType" />
                                    </td>
                                </tr>
                            </table>



                        </div>
                        <div class="col-lg-2" style="margin-top: 25px;">
                            <asp:Button runat="server" ID="btnAddRoom" Text="Add Room" ValidationGroup="Booking" OnClick="btnAddRoom_Click" CssClass="btn btn-primary" />
                        </div>

                    </div>
                </div>


                <asp:GridView runat="server" ID="gvRoomDetail" AutoGenerateColumns="false" EmptyDataText="No Room Added" OnRowCommand="gvRoomDetail_RowCommand" OnRowDataBound="gvRoomDetail_RowDataBound" CssClass="table table-striped table-bordered table-hover" DataKeyNames="roomId,CustomerBookingDetailID">
                    <Columns>
                        <asp:BoundField HeaderText="Room info" DataField="roomInfo" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="From date" DataField="startdate" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd/M/yyyy}" />
                        <asp:BoundField HeaderText="To date" DataField="enddate" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd/M/yyyy}" />
                        <asp:BoundField HeaderText="Price" DataField="roomPrice" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="Days" DataField="Days" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="Single/Double" DataField="IsSingle" DataFormatString="{0:Single/Double}" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="FinalAmount" DataField="finalAmount" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="GST" DataField="GST" ItemStyle-HorizontalAlign="Center" />
                        <%--                        <asp:ButtonField ImageUrl="~/Image/delete.png" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" ButtonType="Image" ControlStyle-Height="20" ControlStyle-Width="20" CommandName="Remove" />--%>
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

                <%--<div class="form-group">
                    <div class="col-lg-12">
                        <div class="col-lg-3">
                            <label class="control-label">Room Type:</label>
                        </div>
                        <div class="col-lg-3">
                            <asp:Label ID="lblRoomType" runat="server" CssClass="control-label"></asp:Label>
                        </div>
                    </div>
                </div>--%>
                <%--<div class="form-group">
                    <div class="col-lg-12">
                        <div class="col-lg-2 text-center">
                        </div>
                        <div class="col-lg-2 text-center">
                            <label class="control-label ">Children </label>
                        </div>
                        <div class="col-lg-3 text-center">
                        </div>

                    </div>
                </div>--%>

                <div class="form-group">
                    <div class="col-lg-12">
                        <div class="col-lg-2 text-center">
                            <label class="control-label ">Total Price</label>
                            <asp:TextBox runat="server" ID="txtRoomPrice" CssClass="form-control"></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" TargetControlID="txtRoomPrice" FilterType="Custom" ValidChars="0123456789." FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                        </div>
                        <div class="col-lg-2 text-center">
                            <label class="control-label ">Discount (%)</label>
                            <asp:TextBox runat="server" ID="txtDiscountPercentage" CssClass="form-control"></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" TargetControlID="txtDiscountPercentage" FilterType="Custom" ValidChars="0123456789." FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                        </div>
                        <div class="col-lg-2 text-center">
                            <label class="control-label ">Discount Price</label>
                            <asp:TextBox runat="server" ID="txtPriceAfterDiscount" CssClass="form-control"></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" TargetControlID="txtPriceAfterDiscount" FilterType="Custom" ValidChars="0123456789." FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                        </div>
                        <%-- <div class="col-lg-2 text-center">
                            <label class="control-label">Paid Amount</label>
                            <asp:TextBox runat="server" ID="txtPaidAmount" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-lg-2 text-center">
                            <label class="control-label">Due Amount</label>
                            <asp:TextBox runat="server" ID="txtDueAmount" CssClass="form-control"></asp:TextBox>
                        </div>--%>
                        <div class="col-lg-2 text-center">
                            <label class="control-label">Final Amount</label>
                            <asp:TextBox runat="server" ID="txtFinalAmount" CssClass="form-control"></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" TargetControlID="txtFinalAmount" FilterType="Custom" ValidChars="0123456789." FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                        </div>
                        <%--<div class="col-lg-2 text-center">
                            <label class="control-label">Booking Status:</label>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="ddlBookingType">
                            </asp:DropDownList>
                        </div>--%>
                        <div class="col-lg-2 text-right bottom-right" style="margin-top: 25px;">
                            <asp:Button runat="server" ID="btnPayment" Text="Cash/Card" OnClick="btnPayment_Click" CssClass="btn btn-primary bottom-right" />
                        </div>
                        <div class="col-lg-2 text-center bottom-right" style="margin-top: 25px;">
                            <asp:Button runat="server" ID="btnAddFoodItem" Text="FOOD Bill" OnClick="btnAddFoodItem_Click" CssClass="btn btn-primary bottom-right" />
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-lg-12">


                        <%--<div class="col-lg-2 text-center">
                            <label class="control-label">Payment Type:</label>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="ddlPaymentType">
                                <asp:ListItem Text="Cash" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Card" Value="2"></asp:ListItem>
                            </asp:DropDownList>
                        </div>--%>
                        <div class="col-lg-12 text-center">
                            <label class="control-label">Booking Notes:</label>
                            <asp:TextBox runat="server" ID="txtBookingNotes" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-12">
                        <div class="col-lg-3">
                        </div>
                        <div class="col-lg-1">
                            <asp:Button runat="server" ID="btnSave" Text="Save Changes" OnClick="btnSave_Click" CssClass="btn btn-primary" />
                        </div>
                        <div class="col-lg-2" style="display: none;">
                            <asp:Button runat="server" ID="btnClear" CssClass="btn btn-primary" OnClientClick="return ClearControl()" Text="CLEAR" />
                        </div>
                        <div class="col-lg-1">
                        </div>
                        <div class="col-lg-5">
                            <asp:Button runat="server" ID="btnBooking" Text="New Booking" OnClick="btnBooking_Click" CssClass="btn btn-danger" OnClientClick="return ConfirmationBooking()" />
                            &nbsp;&nbsp;
                            <asp:Button runat="server" ID="btnCheckIn" Text="Check In" OnClick="btnCheckIn_Click" OnClientClick="return ConfirmationCheckIn()" CssClass="btn btn-danger" />
                            &nbsp;&nbsp;
                            <asp:Button runat="server" ID="btnCheckOut" Text="Check Out" OnClick="btnCheckOut_Click" OnClientClick="return ConfirmationCheckOut()" CssClass="btn btn-danger" />
                        </div>
                    </div>
                </div>
            </div>
            <%-- -----------------------------Add Customer--------------------- --%>
            <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" PopupControlID="Panel2" TargetControlID="btnAddCustomer"
                BackgroundCssClass="modalBackground" CancelControlID="btnCustomerClear">
            </asp:ModalPopupExtender>
            <asp:Button ID="Button1" runat="server" Style="display: none;" />
            <asp:Panel ID="Panel2" runat="server" CssClass="modalPopup" Width="65%" Height="85%" align="center" Style="display: none">
                <div class="form-horizontal">
                    <div class="form-group">
                        <div class="col-lg-12 text-center">
                            <h2>Customer </h2>
                        </div>
                    </div>
                    <asp:Label runat="server" ID="lblCusterInfo" ForeColor="Red"></asp:Label>
                    <br />
                    <div class="form-group">
                        <div class="col-lg-12">
                            <div class="col-lg-3">
                                <label class="control-label">Name :</label>
                            </div>
                            <div class="col-lg-9">
                                <asp:TextBox runat="server" ID="txtCustomerName" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12">
                            <div class="col-lg-3">
                                <label class="control-label">Address :</label>
                            </div>
                            <div class="col-lg-9">
                                <asp:TextBox runat="server" ID="txtCustAddress" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12 text-center">
                            <div class="col-lg-3 text-center">
                                <label class="control-label ">Children:</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:DropDownList runat="server" CssClass="form-control" ID="ddlChildren">
                                    <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                    <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                    <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                    <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                    <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-lg-3 text-center">
                                <label class="control-label ">Adult :</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:DropDownList runat="server" CssClass="form-control" ID="ddlAdult">
                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                    <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                    <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                    <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                    <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                </asp:DropDownList>

                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12">

                            <div class="col-lg-3 text-center">
                                <label class="control-label">Age :</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox runat="server" ID="txtAgeOfCustomer" CssClass="form-control"></asp:TextBox>
                                <asp:FilteredTextBoxExtender runat="server" TargetControlID="txtAgeOfCustomer" FilterType="Custom" ValidChars="0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                            </div>


                            <div class="col-lg-3 text-center">
                                <label class="control-label">Nationality :</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox runat="server" ID="txtNationality" Text="Indian" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12">
                            <div class="col-lg-3">
                                <label class="control-label">Proof Submited:</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:DropDownList runat="server" CssClass="form-control" ID="ddlProof">
                                </asp:DropDownList>
                            </div>
                            <div class="col-lg-3">
                                <label class="control-label">Proof Number:</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox runat="server" ID="txtProofNumber" CssClass="form-control"></asp:TextBox>
                                <asp:TextBoxWatermarkExtender TargetControlID="txtProofNumber" WatermarkText="Enter Proof Number" runat="server"></asp:TextBoxWatermarkExtender>
                            </div>

                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12">

                            <div class="col-lg-3 text-center">
                                <label class="control-label">Arrival From :</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox runat="server" ID="txtArrivalFrom" CssClass="form-control"></asp:TextBox>
                            </div>


                            <div class="col-lg-3 text-center">
                                <label class="control-label">Departure To :</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox runat="server" ID="txtDepartureTo" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12">

                            <div class="col-lg-3 text-center">
                                <label class="control-label">Phone Number :</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox runat="server" ID="txtPhoneNumber" CssClass="form-control"></asp:TextBox>
                                <asp:FilteredTextBoxExtender runat="server" TargetControlID="txtPhoneNumber" FilterType="Custom" ValidChars="0123456789-()" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
                            </div>


                            <div class="col-lg-3 text-center">
                                <label class="control-label">Email Id :</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12">

                            <div class="col-lg-3 text-center">
                                <label class="control-label">Company Name :</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox runat="server" ID="txtCompanyName" CssClass="form-control"></asp:TextBox>
                               
                            </div>


                            <div class="col-lg-3 text-center">
                                <label class="control-label">Company GST :</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox runat="server" ID="txtCompanyGST" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12">
                            <div class="col-lg-3"></div>
                            <div class="col-lg-3">
                                <asp:Button ID="btnSaveCustomer" runat="server" OnClick="btnSaveCustomer_Click" OnClientClick="return ValidateCustomer();" CommandName="RoomList" CssClass="btn btn-primary" Text="Save Customer" />
                            </div>
                            <div class="col-lg-2">
                                <asp:Button ID="btnCustomerClear" runat="server" CssClass="btn btn-primary" OnClientClick="return ClearControlCust()" Text="Cancel" />
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <%-- ------------------------------Add Payment ------------------------- --%>
            <asp:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panel1" TargetControlID="btntst"
                CancelControlID="btnClose" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:Button ID="btntst" runat="server" Style="display: none;" />
            <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup" align="center" Style="display: none; height:auto;">
                <table style="width: 85%;">
                    <tr>
                        <td colspan ="2" class="text-center">
                            <h3>Payment History</h3>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="text-left; fa-bold; text-success" >
                            Required Pay Amount : <asp:Label runat="server" ID="lblRequiredPayAmount"></asp:Label>
                        </td>
                    </tr>
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
                            <asp:FilteredTextBoxExtender runat="server" TargetControlID="txtPaidAmount" FilterType="Custom" ValidChars="0123456789." FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
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
                            <asp:FilteredTextBoxExtender runat="server" TargetControlID="txtDueAmount" FilterType="Custom" ValidChars="0123456789." FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
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
                            <asp:Button ID="btnSavePayment" runat="server" CommandName="RoomList" OnClick="btnSavePayment_Click" CssClass="btn btn-primary" Text="Save Payment" />
                            &nbsp;&nbsp;&nbsp;<asp:Button ID="btnClose" runat="server" CssClass="btn btn-primary" Text="Close" />
                        </td>
                    </tr>
                </table>
                <br />
                <asp:GridView runat="server" ID="gvPaymentHistory" AutoGenerateColumns="true" EmptyDataText="No Payment Hisotry" CssClass="table table-striped table-bordered table-hover">
                </asp:GridView>
            </asp:Panel>
            <%-- ------------------------------Food Service------------------------- --%>
            <asp:ModalPopupExtender ID="mpFood" runat="server" PopupControlID="panelFood" TargetControlID="Button2"
                CancelControlID="btnCloseFood" BackgroundCssClass="modalBackground">
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
                                <asp:FilteredTextBoxExtender runat="server" TargetControlID="txtQuntity" FilterType="Custom" ValidChars="0123456789" FilterMode="ValidChars"></asp:FilteredTextBoxExtender>
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
                                <asp:Button ID="btnCloseFood" runat="server" CssClass="btn btn-primary" Text="Close" />
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="col-lg-12">
                            <asp:GridView runat="server" EmptyDataText="No Food added this customer" OnRowCommand="gvFoodDetail_RowCommand" CssClass="table table-striped table-bordered table-hover" ID="gvFoodDetail" AutoGenerateColumns="false" DataKeyNames="CustomerFoodDetailId,FoodItemId">
                                <Columns>
                                    <asp:BoundField DataField="ItemName" HeaderText="Item Name" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="PricePerPc" HeaderText="Rate" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
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
            <asp:PostBackTrigger ControlID="btnSave" />
            <asp:AsyncPostBackTrigger ControlID="btnPayment" EventName="Click" />
            <asp:AsyncPostBackTrigger EventName="Click" ControlID="btnAddRoom" />
            <%-- <asp:AsyncPostBackTrigger EventName="Click" ControlID="btnAddCustomer" />--%>
            <asp:AsyncPostBackTrigger ControlID="btnAddCustomer" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnSaveCustomer" EventName="Click" />
            <asp:AsyncPostBackTrigger EventName="Click" ControlID="btnCustomerClear" />
            <asp:AsyncPostBackTrigger EventName="Click" ControlID="btnAddFoodItem" />
            <asp:AsyncPostBackTrigger EventName="RowCommand" ControlID="gvFoodDetail" />
            <asp:PostBackTrigger ControlID="btnBooking" />
            <asp:PostBackTrigger ControlID="btnCheckIn" />
            <asp:PostBackTrigger ControlID="btnCheckOut" />
            <asp:PostBackTrigger ControlID="btnSavePayment" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
