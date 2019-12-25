<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="Deshboard.aspx.cs" Inherits="Hotel_Management.Deshboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cont1" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Dashboard</h1>
        </div>
        <div>
            <asp:DataList ID="dlAvailableRooms" runat="server" BorderColor="#666666"
                BorderStyle="None" GridLines="None" CssClass="table" CellPadding="10" CellSpacing="30" RepeatColumns="8" RepeatDirection="Horizontal">
                <HeaderStyle BackColor="#333333" Font-Bold="True" Font-Size="Large" ForeColor="White"
                    HorizontalAlign="Center" VerticalAlign="Middle" />
                <HeaderTemplate>
                    Available Rooms
                </HeaderTemplate>
                <ItemStyle BackColor="White" ForeColor="Black" BorderWidth="2px" Width="11%" />

                <ItemTemplate>
                    <asp:HiddenField ID="hdnRoomId" runat="server" Value='<%# Eval("RoomID") %>' />
                    <asp:Button ID="btnRoomNo" runat="server" Text='<%# Eval("Room_No") %>' CssClass="btn-success" Height="80px" Width="80px" />
                    <%--<b>Company Name:</b>
                <asp:Label ID="lblCName" runat="server" Text='<%# Eval("CompanyName") %>'></asp:Label>
                <br />
                <b>Contact Name:</b>
                <asp:Label ID="lblName" runat="server" Text='<%# Eval("ContactName") %>'></asp:Label>
                <br />
               <b> City:</b>
                <asp:Label ID="lblCity" runat="server" Text=' <%# Eval("City") %>'></asp:Label>
                <br />
                <b>Country:</b>
                <asp:Label ID="lblCountry" runat="server" Text='<%# Eval("Country") %>'></asp:Label>
                <br />--%>
                </ItemTemplate>

            </asp:DataList>

        </div>
        <br />
        <br />
        <br />
        <div>
            <asp:DataList ID="dlNonAvailableRooms" runat="server" BorderColor="#666666"
                BorderStyle="None" GridLines="None" CssClass="table" CellPadding="10" CellSpacing="30" RepeatColumns="4" RepeatDirection="Horizontal">
                <HeaderStyle BackColor="#333333" Font-Bold="True" Font-Size="Large" ForeColor="White"
                    HorizontalAlign="Center" VerticalAlign="Middle" />
                <HeaderTemplate>
                    Non Available Rooms
                </HeaderTemplate>
                <ItemStyle BackColor="White" ForeColor="Black" BorderWidth="2px" />
                <ItemTemplate>
                    <div class="form-horizontal">
                        <div class="col-lg-4" style="padding: 0px 0px 0px 0px;">
                            
                                <asp:HiddenField ID="hdnCustomerBookingDetailID" runat="server" Value='<%# Eval("CustomerBookingDetailID") %>' />
                                <asp:Button ID="btnRoomNo" runat="server" Text='<%# Eval("Room_No") %>' CssClass="btn-primary" Height="80px" Width="80px" />
                          </div>
                         <div class="col-lg-8" style="padding: 0px 0px 0px 0px;">
                                <b> Name:</b>
                                <asp:Label ID="lblCName" runat="server" Text='<%# Eval("CustomerName") %>'></asp:Label>
                                <br />
                                <b>From :</b>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("BookedFrom") %>'></asp:Label>
                                <br />
                                <b>To :</b>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("BookedTo") %>'></asp:Label>
                            
                        </div>
                    </div>


                    <%--<b>Company Name:</b>
                <asp:Label ID="lblCName" runat="server" Text='<%# Eval("CompanyName") %>'></asp:Label>
                <br />
                <b>Contact Name:</b>
                <asp:Label ID="lblName" runat="server" Text='<%# Eval("ContactName") %>'></asp:Label>
                <br />
               <b> City:</b>
                <asp:Label ID="lblCity" runat="server" Text=' <%# Eval("City") %>'></asp:Label>
                <br />
                <b>Country:</b>
                <asp:Label ID="lblCountry" runat="server" Text='<%# Eval("Country") %>'></asp:Label>
                <br />--%>
                </ItemTemplate>

            </asp:DataList>

        </div>
        <br />
        <br />
        <br />
        <div>

            <asp:DataList ID="dlBookedRooms" runat="server" BorderColor="#666666"
                BorderStyle="None" GridLines="None" CssClass="table" CellPadding="10" CellSpacing="30" RepeatColumns="1" RepeatDirection="Horizontal">
                <HeaderStyle BackColor="#333333" Font-Bold="True" Font-Size="Large" ForeColor="White"
                    HorizontalAlign="Center" VerticalAlign="Middle" />
                <HeaderTemplate>
                    Booked Rooms
                    <hr />
                    <div class="form-horizontal">
                        <div class="col-lg-12 text-left" style="padding: 0px 0px 0px 0px;">
                            <div class="col-lg-4">
                                Room No
                            </div>
                            <div class="col-lg-2">
                                <b>Customer Name</b>
                                
                                 </div>
                                
                               
                            <div class="col-lg-2">
                                 <b>From</b>
                                  </div>
                              
                                
                             <div class="col-lg-2">
                                 <b>To</b>
                                
                            </div>
                            <div class="col-lg-2">
                                Booking Date
                            </div>
                        </div>
                    </div>
                </HeaderTemplate>
                <ItemStyle BackColor="White" ForeColor="Black" BorderWidth="2px" />

                <ItemTemplate>
                    <div class="form-horizontal">
                        <div class="col-lg-12" style="padding: 0px 0px 0px 0px;">
                            <div class="col-lg-4">
                                <asp:HiddenField ID="hdnCustomerBookingDetailID" runat="server" Value='<%# Eval("CustomerID") %>' />
                                <asp:Button ID="btnRoomNo" runat="server" Text='<%# Eval("Room_No") %>' CssClass="btn-primary" Height="25px" Width="350px" />
                            </div>
                            <div class="col-lg-2">
                                <%--<b>Customer Name:</b>--%>
                                <asp:Label ID="lblCName" runat="server" Text='<%# Eval("CustomerName") %>'></asp:Label>
                                 </div>
                                <%--<br />
                                <b>From:</b>--%>
                            <div class="col-lg-2">
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("BookedFrom") %>'></asp:Label>
                                  </div>
                                <%--<br />
                                <b>To:</b>--%>
                             <div class="col-lg-2">
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("BookedTo") %>'></asp:Label>
                            </div>
                            <div class="col-lg-2">
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("BookingDate") %>'></asp:Label>
                            </div>
                        </div>
                    </div>


                    <%--<b>Company Name:</b>
                <asp:Label ID="lblCName" runat="server" Text='<%# Eval("CompanyName") %>'></asp:Label>
                <br />
                <b>Contact Name:</b>
                <asp:Label ID="lblName" runat="server" Text='<%# Eval("ContactName") %>'></asp:Label>
                <br />
               <b> City:</b>
                <asp:Label ID="lblCity" runat="server" Text=' <%# Eval("City") %>'></asp:Label>
                <br />
                <b>Country:</b>
                <asp:Label ID="lblCountry" runat="server" Text='<%# Eval("Country") %>'></asp:Label>
                <br />--%>
                </ItemTemplate>

            </asp:DataList>
        </div>
        <!-- /.col-lg-12 -->
    </div>
</asp:Content>
