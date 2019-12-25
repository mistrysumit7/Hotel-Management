<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testFrom.aspx.cs" Inherits="Hotel_Management.testFrom" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function showProgress() {
            var updateProgress = $get("<%= UpdateProgress.ClientID %>");
    updateProgress.style.display = "block";
}
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            
            
            <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
            <asp:UpdateProgress ID="UpdateProgress" runat="server" AssociatedUpdatePanelID="upmain">
                <ProgressTemplate>
                    <div class="modalBackground modalPopup">
                        <asp:Image ID="Image1" ImageUrl="~/Image/ajax-loader.gif" Width="500" Height="500" AlternateText="Processing" runat="server" />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:UpdatePanel runat="server" ID="upmain" >
                <ContentTemplate>
                    <asp:Button runat="server" ID="btn" Text="Save" OnClick="btn_Click"  />
                    <%-- <rsweb:ReportViewer ID="ReportViewer1" runat="server"></rsweb:ReportViewer>--%>
                </ContentTemplate>
                
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
