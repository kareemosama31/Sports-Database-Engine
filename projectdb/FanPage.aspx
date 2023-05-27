<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FanPage.aspx.cs" Inherits="ProjectDB.FanPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="color:white; background-color:black; font-size:25px; text-align:center">
    <form id="form1" runat="server">
        <div>
            Choose What You Want To Do From The List Below<br />
        <br />
            View<br />
        <asp:Button ID="avticket" runat="server" Text="Available Matches With Tickets" PostBackUrl="~/AvTickets.aspx" />
        <br />
        <br />
            Buy<br />
            <asp:Button ID="Buy" runat="server" Text="Ticket" PostBackUrl="~/Buy.aspx"/>
        <br />
        </div>
    </form>
</body>
</html>
