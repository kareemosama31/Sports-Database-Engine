<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SystemAdminPage.aspx.cs" Inherits="ProjectDB.SystemAdminPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body  style="color:white; background-color:black; font-size:25px; text-align:center">
    <form id="form1" runat="server">
        Choose What You Want To Do From The List Below<br />
        <br />
        Club<br />
        <asp:Button ID="NewClub" runat="server" Text="Add" PostBackUrl="~/NewClub.aspx" />
        <asp:Button ID="DeleteClub" runat="server" Text="Delete" PostBackUrl="~/DeleteClub.aspx" />
        <br />
        <br />
        Stadium
        <br />
        <asp:Button ID="NewStadium" runat="server" Text="Add" PostBackUrl="~/NewStadium.aspx" />
        <asp:Button ID="DeleteStadium" runat="server" Text="Delete" PostBackUrl="~/DeleteStadium.aspx" />
        <br />
        <br />
        Fan<br />
        <asp:Button ID="BlockFan" runat="server" Text="Block" PostBackUrl="~/BlockFan.aspx"/>
        <asp:Button ID="DeleteStadium0" runat="server" Text="Unblock" PostBackUrl="~/UnblockFan.aspx" />
        <br />
    </form>
</body>
</html>
