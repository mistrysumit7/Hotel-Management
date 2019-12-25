<%@ Page Title="Invoice List" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="Invoice.aspx.cs" Inherits="Hotel_Management.Invoice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .pagination-ys {
            /*display: inline-block;*/
            padding-left: 0;
            margin: 20px 0;
            border-radius: 4px;
        }

            .pagination-ys table > tbody > tr > td {
                display: inline;
            }

                .pagination-ys table > tbody > tr > td > a,
                .pagination-ys table > tbody > tr > td > span {
                    position: relative;
                    float: left;
                    padding: 8px 12px;
                    line-height: 1.42857143;
                    text-decoration: none;
                    color: #dd4814;
                    background-color: #ffffff;
                    border: 1px solid #dddddd;
                    margin-left: -1px;
                }

                .pagination-ys table > tbody > tr > td > span {
                    position: relative;
                    float: left;
                    padding: 8px 12px;
                    line-height: 1.42857143;
                    text-decoration: none;
                    margin-left: -1px;
                    z-index: 2;
                    color: #aea79f;
                    background-color: #f5f5f5;
                    border-color: #dddddd;
                    cursor: default;
                }

                .pagination-ys table > tbody > tr > td:first-child > a,
                .pagination-ys table > tbody > tr > td:first-child > span {
                    margin-left: 0;
                    border-bottom-left-radius: 4px;
                    border-top-left-radius: 4px;
                }

                .pagination-ys table > tbody > tr > td:last-child > a,
                .pagination-ys table > tbody > tr > td:last-child > span {
                    border-bottom-right-radius: 4px;
                    border-top-right-radius: 4px;
                }

                .pagination-ys table > tbody > tr > td > a:hover,
                .pagination-ys table > tbody > tr > td > span:hover,
                .pagination-ys table > tbody > tr > td > a:focus,
                .pagination-ys table > tbody > tr > td > span:focus {
                    color: #97310e;
                    background-color: #eeeeee;
                    border-color: #dddddd;
                }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cont1" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="col-lg-3">
                    </div>
                    <div class="col-lg-5">
                        <asp:RequiredFieldValidator runat="server" ForeColor="Red" ID="rqValSearch" ValidationGroup="Search" ErrorMessage="Please Enter Search Customer Name or Bill Number" ControlToValidate="txtSearch"></asp:RequiredFieldValidator><br />
                        <asp:TextBox runat="server" ID="txtSearch" CssClass="form-control"></asp:TextBox>

                    </div>
                    <div class="col-lg-2">
                        <br />
                        <asp:Button runat="server" ID="btnSearch" OnClick="btnSearch_Click" Text="Search" ValidationGroup="Search" CssClass="btn btn-primary" />
                    </div>
                     <div class="col-lg-2">
                        <br />
                        <asp:Button runat="server" ID="btnAllBill" OnClick="btnAllBill_Click" Text="All List" CssClass="btn btn-primary" />
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="panel-body">
                        <asp:GridView runat="server" EmptyDataText="No Record Found" EmptyDataRowStyle-HorizontalAlign="Center" ShowHeaderWhenEmpty="true" PageSize="30" Font-Size="Small" PagerStyle-HorizontalAlign="Center" AllowPaging="true" ID="gvInvoice"
                            OnPageIndexChanged="gvInvoice_PageIndexChanged" OnPageIndexChanging="gvInvoice_PageIndexChanging" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-hover" DataKeyNames="CustomerID">
                            <Columns>
                                <asp:TemplateField HeaderText="Bill Number" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <%# Eval("BillNumber") %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Billing Date" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <%# Eval("BillingDate") %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Customer Name" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <%# Eval("CustomerName") %>
                                    </ItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Room No" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <%# Eval("Room_No") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total Amount" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%# Eval("Total_Amount") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Discount Given" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <%# Eval("Discount_given") %> %
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Discounted Amount" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%# Eval("Discount_Amount") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Paid Amount" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%# Eval("Paid_Amount") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Due Amount" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%# Eval("Due_Amount") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Final Price" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%# Eval("FinalPrice") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CGST" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%# Eval("CGST") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SGST" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%# Eval("SGST") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Luxury Tax" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%# Eval("LuxuryTax") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bill Amount" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%# Eval("PaidAmount") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Generate Invoice" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkGenerateInvoice" Font-Size="Medium" runat="server" Text="Invoice"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerSettings Mode="Numeric" PageButtonCount="10"   Position="Bottom" />
                            <PagerStyle CssClass="pagination-ys" Font-Size="Large" />

                        </asp:GridView>
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvInvoice" EventName="PageIndexChanged" />
            <asp:AsyncPostBackTrigger ControlID="gvInvoice" EventName="PageIndexChanging" />
            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
