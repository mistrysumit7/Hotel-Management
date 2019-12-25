<%@ Page Title="" Language="C#" Culture="en-GB" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="AdminMst.aspx.cs" Inherits="Hotel_Management.AdminMst" %>

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
        function ValidateCustomerName() {
            if (document.getElementById("<%= txtCustomerName.ClientID %>").value == "") {
                alert("Please Enter Customer Name");
                return false;
            }
            else {
                return true;
            }
        }

        function confirmDelete() {
            return confirm("Are you sure you want to delete this?");
        }

        
    </script>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">

                        <!-- .panel-heading -->
                        <div class="panel-body">
                            <div class="panel-group" id="accordion">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">Customer Information</a>
                                        </h4>
                                    </div>
                                    <div id="collapseOne" class="panel-collapse collapse in">
                                        <div class="panel-body">
                                            <asp:LinkButton runat="server" ID="btnCustomer" Font-Size="Large" Text="Edit Customer Information"></asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">Room and Booking Information</a>
                                        </h4>
                                    </div>
                                    <div id="collapseTwo" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <asp:GridView runat="server" ID="gvBookingInfo" OnRowCommand="gvBookingInfo_RowCommand" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="false" DataKeyNames="CustomerBookingDetailID">
                                                <Columns>

                                                    <asp:BoundField DataField="Room_No" ItemStyle-HorizontalAlign="Center" HeaderText="Room No" />
                                                    <asp:BoundField DataField="CheckInDate" ItemStyle-HorizontalAlign="Center" HeaderText="CheckInDate" />
                                                    <asp:BoundField DataField="CheckOutDate" ItemStyle-HorizontalAlign="Center" HeaderText="CheckOutDate" />
                                                    <asp:ButtonField Text="Edit" ItemStyle-Font-Size="Large" CommandName="editbooking" ButtonType="Link" ItemStyle-HorizontalAlign="Center" />
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree">Tariff Information</a>
                                            <%--<asp:LinkButton runat="server" ID="btnTarifInformation" Text="Tarif Information" OnClick="btnTarifInformation_Click"></asp:LinkButton>--%>
                                        </h4>
                                    </div>
                                    <div id="collapseThree" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <div class="form-horizontal">

                                                <div class="form-group">
                                                    <div class="col-lg-12">

                                                        <div class="col-lg-3 text-center">
                                                            <label class="control-label">Total Amount :</label>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <asp:TextBox ID="txtTotalAmount" CssClass="form-control" runat="server" Text='<%#Eval("Total_Amount") %>'></asp:TextBox>

                                                        </div>


                                                        <div class="col-lg-3 text-center">
                                                            <label class="control-label">Discount Given (%):</label>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <asp:TextBox ID="txtDiscountPercentage" CssClass="form-control" runat="server" Text='<%#Eval("Discount_given") %>'></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-lg-12">

                                                        <div class="col-lg-3 text-center">
                                                            <label class="control-label">Discount Amount:</label>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <asp:TextBox ID="txtDiscountAmount" CssClass="form-control" runat="server" Text='<%#Eval("Discount_Amount") %>'></asp:TextBox>
                                                        </div>

                                                        <div class="col-lg-3 text-center">
                                                            <label class="control-label">Final Price:</label>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <asp:TextBox ID="txtFinalPrice" CssClass="form-control" runat="server" Text='<%#Eval("FinalPrice") %>'></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-lg-12">

                                                        <div class="col-lg-3 text-center">
                                                            <label class="control-label">GST:</label>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <asp:TextBox ID="txtLuxuryTax" CssClass="form-control" runat="server" Text='<%#Eval("Luxury_Tax") %>'></asp:TextBox>
                                                        </div>

                                                        <div class="col-lg-3 text-center">
                                                        </div>
                                                        <div class="col-lg-3">
                                                        </div>

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <div class="col-lg-12">
                                                        <div class="col-lg-3"></div>
                                                        <div class="col-lg-3"></div>
                                                        <div class="col-lg-1">
                                                            <asp:Button ID="btn_Update_Tarif" runat="server" CssClass="btn btn-primary" Text="Update" OnClick="btn_Update_Tarif_Click" />
                                                        </div>
                                                        <div class="col-lg-1">
                                                            <asp:Button ID="btn_Cancel_tarif" runat="server" CssClass="btn btn-success" Text="Cancel" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapsefOUR">Payment History</a>
                                            <%--<asp:LinkButton runat="server" ID="btnTarifInformation" Text="Tarif Information" OnClick="btnTarifInformation_Click"></asp:LinkButton>--%>
                                        </h4>
                                    </div>
                                    <div id="collapsefOUR" class="panel-collapse collapse">
                                        <asp:LinkButton runat="server" ID="btnOpenPaymentHistory" Text="Add Payment" CssClass="alert-link btn-link pull-right" OnClick="btnOpenPaymentHistory_Click"></asp:LinkButton>
                                        <div class="panel-body">
                                            <asp:GridView runat="server" OnRowCommand="gvPaymentHistory_RowCommand" ID="gvPaymentHistory" DataKeyNames="Cash_Booking_History_Detail_Id,Payment_Mode_Id" AutoGenerateColumns="false" EmptyDataText="No Payment Hisotry" CssClass="table table-striped table-bordered table-hover">
                                                <Columns>
                                                    <asp:BoundField DataField="Payment_Date" ItemStyle-HorizontalAlign="Center" HeaderText="Payment Date" />
                                                    <asp:BoundField DataField="Paid_Amount" ItemStyle-HorizontalAlign="Right" HeaderText="Paid Amount" />
                                                    <asp:BoundField DataField="Due_Amount" ItemStyle-HorizontalAlign="Right" HeaderText="Due Amount" />
                                                    <asp:BoundField DataField="Payment_Mode" ItemStyle-HorizontalAlign="Center" HeaderText="Payment Mode" />
                                                    <asp:ButtonField Text="Edit" ItemStyle-Font-Size="Large" CommandName="editPaymentHistory" ButtonType="Link" ItemStyle-HorizontalAlign="Center" />
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- .panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>

            <%-- -----------------------------Add Customer--------------------- --%>
            <asp:ModalPopupExtender ID="mpCustomer" runat="server" PopupControlID="Panel2" TargetControlID="btnCustomer"
                BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:Button ID="Button1" runat="server" Style="display: none;" />
            <asp:Panel ID="Panel2" runat="server" CssClass="modalPopup" Height="89%" align="center" Style="display: none">
                <div class="form-horizontal" style="padding-top:0px;">
                    <div class="form-group" style="padding-top:0px;padding-bottom:0px;">
                        <div class="col-lg-12 text-center" style="padding-top:0px;padding-bottom:0px;">
                            <h2>Customer </h2>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12">

                            <div class="col-lg-3 text-center">
                                <label class="control-label">Bill Number :</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox runat="server" ID="txtBillNumber" CssClass="form-control"></asp:TextBox>
                            </div>


                            <div class="col-lg-3 text-center">
                                <label class="control-label">Billing Date :</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox runat="server" ID="txtBillingDate" CssClass="form-control"></asp:TextBox>
                                <asp:CalendarExtender ID="CalendarExtender2" PopupPosition="BottomRight" CssClass="Calendar" DefaultView="Days" PopupButtonID="popupButtonStart" Format="dd/MM/yyyy" TargetControlID="txtBillingDate" runat="server"></asp:CalendarExtender>
                            </div>
                        </div>
                    </div>
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
                                <asp:Button ID="btnSaveCustomer" runat="server" OnClick="btnSaveCustomer_Click" CommandName="RoomList" CssClass="btn btn-primary" Text="Save Customer" />
                            </div>
                            <div class="col-lg-2">
                                <asp:Button ID="btnCustomerClose" runat="server" CssClass="btn btn-primary" Text="Close" />
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <%-- Room Booking Details --%>
            <asp:ModalPopupExtender ID="mpBooking" runat="server" PopupControlID="pnlBooking" TargetControlID="Button2"
                CancelControlID="btnCloseBookingInfo" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:Button ID="Button2" runat="server" Style="display: none;" />
            <asp:Panel ID="pnlBooking" runat="server" ScrollBars="Vertical" CssClass="modalPopup" align="center" Style="display: none;">
                <div class="form-horizontal">
                    <div class="form-group">
                        <div class="col-lg-12 text-center">
                            <h2>Booking Details</h2>
                        </div>
                    </div>


                    <div class="form-group">
                        <div class="col-lg-12">

                            <div class="col-lg-3 text-center">
                                <label class="control-label">Booking Date :</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox runat="server" ID="txtBookingDate" CssClass="form-control"></asp:TextBox>
                                <asp:CalendarExtender ID="calExtBookingDt" PopupPosition="BottomRight" CssClass="Calendar" DefaultView="Days" PopupButtonID="popupButtonStart" Format="dd/MM/yyyy" TargetControlID="txtBookingDate" runat="server"></asp:CalendarExtender>
                            </div>


                            <div class="col-lg-3 text-center">
                                <label class="control-label">Room No:</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:DropDownList runat="server" ID="ddlRoomList" CssClass="form-control">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12">

                            <div class="col-lg-3 text-center">
                                <label class="control-label">CheckedIn Date:</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox runat="server" ID="txtCheckinDt" CssClass="form-control"></asp:TextBox>
                                <asp:CalendarExtender ID="clextCheckedIndt" PopupPosition="BottomRight" CssClass="Calendar" DefaultView="Days" PopupButtonID="popupButtonStart" Format="dd/MM/yyyy" TargetControlID="txtCheckinDt" runat="server"></asp:CalendarExtender>
                            </div>

                            <div class="col-lg-3 text-center">
                                <label class="control-label">CheckedOut Date:</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox runat="server" ID="txtChekedOUtdt" CssClass="form-control"></asp:TextBox>
                                <asp:CalendarExtender ID="clExtCheckedOutdt" PopupPosition="BottomRight" CssClass="Calendar" DefaultView="Days" PopupButtonID="popupButtonStart" Format="dd/MM/yyyy" TargetControlID="txtChekedOUtdt" runat="server"></asp:CalendarExtender>
                            </div>

                        </div>
                    </div>


                    <div class="form-group">
                        <div class="col-lg-12">

                            <div class="col-lg-3 text-center">
                                <label class="control-label">Booked From:</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox runat="server" ID="txtBookedFrom" CssClass="form-control"></asp:TextBox>
                                <asp:CalendarExtender ID="calextBookedFromDt" PopupPosition="BottomRight" CssClass="Calendar" DefaultView="Days" PopupButtonID="popupButtonStart" Format="dd/MM/yyyy" TargetControlID="txtBookedFrom" runat="server"></asp:CalendarExtender>
                            </div>

                            <div class="col-lg-3 text-center">
                                <label class="control-label">Booked To:</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox runat="server" ID="txtBookedTo" CssClass="form-control"></asp:TextBox>
                                <asp:CalendarExtender ID="calextBookedTo" PopupPosition="BottomRight" CssClass="Calendar" DefaultView="Days" PopupButtonID="popupButtonStart" Format="dd/MM/yyyy" TargetControlID="txtBookedTo" runat="server"></asp:CalendarExtender>
                            </div>

                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12">

                            <div class="col-lg-3 text-center">
                                <label class="control-label">Room Price:</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox runat="server" ID="txtRoomPrice" CssClass="form-control"></asp:TextBox>
                                <asp:RegularExpressionValidator runat="server" ID="rgExpRoomPrice" ValidationExpression="^[0-9]*$" ControlToValidate="txtRoomPrice" ErrorMessage="Please Enter only Numeric value" ForeColor="Red"></asp:RegularExpressionValidator>
                            </div>

                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12">
                            <div class="col-lg-3"></div>
                            <div class="col-lg-3">
                                <asp:Button ID="btnSaveBooking" OnClick="btnSaveBooking_Click" runat="server" CssClass="btn btn-primary" Text="Save Booking" />
                            </div>
                            <div class="col-lg-2">
                                <asp:Button ID="btnCloseBookingInfo" runat="server" CssClass="btn btn-primary" Text="Close" />
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <%-- ------------------------------Add Payment ------------------------- --%>
            <asp:ModalPopupExtender ID="mp1" runat="server" PopupControlID="pnlPaymentHisotry" TargetControlID="btntst"
                CancelControlID="btnClose" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:Button ID="btntst" runat="server" Style="display: none;" />
            <asp:Panel ID="pnlPaymentHisotry" runat="server" CssClass="modalPopup" align="center" Style="display: none">
                <table style="width: 85%;">
                     <tr>
                        <td colspan ="2" class="text-center">
                            <h3>Payment History</h3>
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
                            <asp:Button ID="btnSavePayment" runat="server" CommandName="RoomList" OnClick="btnSavePayment_Click" CssClass="btn btn-primary" Text="Update Payment" />
                            &nbsp;&nbsp;&nbsp;<asp:Button ID="btnClose" runat="server" CssClass="btn btn-primary" Text="Close" />
                        </td>
                    </tr>
                </table>

            </asp:Panel>

        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnSaveCustomer" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnCustomerClose" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnSaveBooking" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnCloseBookingInfo" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btn_Update_Tarif" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnSavePayment" EventName="Click" />
           
        </Triggers>

    </asp:UpdatePanel>
</asp:Content>
