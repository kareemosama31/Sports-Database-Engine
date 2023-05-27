<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClubRepresentativePage.aspx.cs" Inherits="ProjectDB.ClubRepresentativePage" %>

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
            <asp:Button ID="AvailableStad" runat="server" Text="Available Stadiums" PostBackUrl="~/AvailableStads.aspx"/>
             <br />
        <asp:Button ID="Info" runat="server" Text="Information Of Represented Club" PostBackUrl="~/InfoClub.aspx" />
            <br />
        <asp:Button ID="Upcoming" runat="server" Text="Upcoming Matches Of Represented Club" PostBackUrl="~/UpcomingClub.aspx"/>
             <br />
             <br />
             Request<br />
             <asp:Button ID="req" runat="server" Text="Send To Stadium Manager" PostBackUrl="~/RequestStad.aspx"/>
        <br />
        </div>
    </form>
</body>
</html>
