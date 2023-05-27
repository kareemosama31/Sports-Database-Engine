<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StadiumManagerPage.aspx.cs" Inherits="ProjectDB.StadiumManagerPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body  style="color:white; background-color:black; font-size:25px; text-align:center">
    <form id="form1" runat="server">
        <div>
            Choose What You Want To Do From The List Below<br />
        <br />
            Request<br />
        <asp:Button ID="accreq" runat="server" Text="Accept" PostBackUrl="~/AcceptReq.aspx" />
        <asp:Button ID="rejreq" runat="server" Text="Reject" PostBackUrl="~/RejectReq.aspx" />
        <br />
            <br />
            View<br />
        <asp:Button ID="stadinfo" runat="server" Text="Stadium Information" PostBackUrl="~/StadInfo.aspx" />
            <br />
        <asp:Button ID="recreq" runat="server" Text="All Recieved Requests" PostBackUrl="~/RecievedReq.aspx"/>
            <br />
        <br />
        </div>
    </form>
</body>
</html>
