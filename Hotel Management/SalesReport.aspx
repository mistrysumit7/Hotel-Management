<%@ Page Title="Sales Report - Apple Residency" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="SalesReport.aspx.cs" Inherits="Hotel_Management.SalesReport" %>
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

        function ClearFilter() {
            for (var i = 3 ; i < 8 ; i++) {
                var chkbutton = document.getElementById('radio' + i);
                if (chkbutton != null) {
                    if (chkbutton.checked) {
                        chkbutton.checked = false;
                        document.getElementById('divStartDate').style.display = "none";
                        document.getElementById('divEndDate').style.display = "none";
                    }
                }
            }
        }

        function ChkFilterSelected() {
            var count = 0;
            for (var i = 3 ; i < 8 ; i++) {
                var chkbutton = document.getElementById('radio' + i);
                if (chkbutton != null) {
                    if (chkbutton.checked) {
                        count = count + 1;
                    }
                }
            }
            if (count == 0) {
                alert('Please select any option first.');
                return false;
            }
            else {
                return true;
            }
        }

        function SetFilterValue(rdbtn) {
            var filterbtn = rdbtn;
            if (rdbtn != null) {
                document.getElementById('divStartDate').style.display = "none";
                document.getElementById('divEndDate').style.display = "none";

                if (rdbtn.id.toString() == "radio3") {
                    document.getElementById('<%=hfFilter.ClientID %>').value = 'today';
                }
                else if (rdbtn.id.toString() == "radio4") {
                    document.getElementById('<%=hfFilter.ClientID %>').value = 'yesterday';
                }
                else if (rdbtn.id.toString() == "radio5") {
                    document.getElementById('<%=hfFilter.ClientID %>').value = 'week';
                }
                else if (rdbtn.id.toString() == "radio6") {
                    document.getElementById('<%=hfFilter.ClientID %>').value = 'month';
                }
}
else {
    document.getElementById('<%=hfFilter.ClientID %>').value = '';
            }
        }

        function EnableStartDateEndate(rdbtn) {
            if (rdbtn.checked) {
                document.getElementById('divStartDate').style.display = "";
                document.getElementById('divEndDate').style.display = "";
                document.getElementById('<%=hfFilter.ClientID %>').value = 'custom';
            }
        }
    </script>
    <div class="form-horizontal">
        <div class="col-lg-12" style="vertical-align: bottom;">
            <div class="col-lg-7" style="vertical-align: bottom; text-align: right;">
                <h1 >Sales Report
                </h1>
            </div>
            <div class="col-lg-5" style="margin-top: 25px; text-align: right;">
                <asp:Button runat="server" ID="btnExportExcel" Text="Export To Excel" CssClass="btn btn-primary" />
                <asp:Button runat="server" ID="btnExportPDF" Text="Export To PDF" CssClass="btn btn-primary" />
            </div>
        </div>
         <asp:HiddenField runat="server" ID="hfFilter" />
        <div class="col-lg-12 text-left" style="vertical-align: bottom;">

            <div class="col-sm-1">
                <div class="radio radio-danger">
                    <input type="radio" name="radio2" id="radio3" value="option1" onclick="Javascript: SetFilterValue(this);" />
                    <label for="radio3">
                        Today
                    </label>
                </div>
            </div>
            <div class="col-sm-1" style="text-align: right;">
                <div class="radio radio-danger">
                    <input type="radio" name="radio2" id="radio4" value="option2" onclick="Javascript: SetFilterValue(this);" />
                    <label for="radio4">
                        Yesterday
                    </label>
                </div>
            </div>
            <div class="col-sm-2" style="text-align: left;">
                <div class="radio radio-danger">
                    <input type="radio" name="radio2" id="radio5" value="option2" onclick="Javascript: SetFilterValue(this);" />
                    <label for="radio5">
                        This Week
                    </label>
                </div>
            </div>
            <div class="col-sm-2" style="text-align: left; padding-left: 0px!important; margin-left: -70px;">
                <div class="radio radio-danger">
                    <input type="radio" name="radio2" id="radio6" value="option2" onclick="Javascript: SetFilterValue(this);" />
                    <label for="radio6">
                        This Month
                    </label>
                </div>
            </div>
            <div class="col-sm-1" style="padding-left: 0px!important; margin-left: -75px;">
                <div class="radio radio-danger">
                    <input type="radio" name="radio2" id="radio7" value="option2" onclick="Javascript: EnableStartDateEndate(this);" />
                    <label for="radio7">
                        Custom
                    </label>
                </div>
            </div>
            <div class="col-lg-2" style="padding-left: 10px; padding-right: 10px; margin-left: -25px; display: none;" id="divStartDate">
                <asp:TextBox runat="server" CssClass="form-control" ID="txtStartDate"></asp:TextBox>
                <asp:TextBoxWatermarkExtender runat="server" ID="WatertxtFromDate" TargetControlID="txtStartDate" WatermarkText="Start Date"></asp:TextBoxWatermarkExtender>
                <asp:CalendarExtender ID="calExtFromDate"
                    PopupPosition="BottomRight" CssClass="Calendar" DefaultView="Days" PopupButtonID="popupButtonStart" Format="dd/MM/yyyy" TargetControlID="txtStartDate" runat="server">
                </asp:CalendarExtender>
            </div>
            <div class="col-lg-2" style="padding-left: 10px; padding-right: 10px; display: none;" id="divEndDate">
                <asp:TextBox runat="server" CssClass="form-control" ID="txtEndDate"></asp:TextBox>
                <asp:TextBoxWatermarkExtender runat="server" ID="WatertxtEndDate" TargetControlID="txtEndDate" WatermarkText="End Date"></asp:TextBoxWatermarkExtender>
                <asp:CalendarExtender PopupPosition="BottomRight" CssClass="Calendar" DefaultView="Days" PopupButtonID="popupButtonStart" ID="CalendarExtender2" Format="dd/MM/yyyy" TargetControlID="txtEndDate" runat="server"></asp:CalendarExtender>
            </div>
            <div class="col-sm-2">
                <asp:Button runat="server" ID="btnFilter" OnClick="btnFilter_Click" OnClientClick="return ChkFilterSelected();" Text="Search" CssClass="btn btn-primary" />
                &nbsp;
                <button class="btn btn-primary" id="btnClearFilter" onclick="ClearFilter(); return false;">Clear</button>

            </div>

        </div>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="row" style="width:100%; font-size:12.5px;">
                    <div class="col-lg-12">
                        <div class="panel-body">
                            <asp:GridView runat="server" ID="gvGeneralReport" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-hover">
                                <Columns>
                                    <asp:BoundField DataField="BillNumber" HeaderText="Bill Number" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="billingdate" HeaderText="Bill Date" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="CheckInDate" HeaderText="Check-In Date" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="CheckOutDate" HeaderText="Check-Out Date" HeaderStyle-HorizontalAlign="Left" />

                                    <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="CompanyName" HeaderText="Company Name" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="CompanyGST" HeaderText="Company GST" HeaderStyle-HorizontalAlign="Left" />

                                    <asp:BoundField DataField="Total_Amount" HeaderText="Tariff Amount" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="Discount_Amount" HeaderText="Discount Amount" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="Luxury_Tax" HeaderText="Luxury Tax" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="CGST" HeaderText="CGST" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="CGST" HeaderText="GGST" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" />
                                    <%--<asp:BoundField DataField="Service_Tax" HeaderText="Service Tax" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" />--%>
                                    <asp:BoundField DataField="Misc_Charge" HeaderText="Misc Charge" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="Cash" HeaderText="Cash" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="Card" HeaderText="Card" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="InvoiceAmount" HeaderText="Invoice Amount" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnFilter" EventName="Click" />
                <asp:PostBackTrigger ControlID="btnExportExcel" />
            <asp:PostBackTrigger ControlID="btnExportPDF" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>
