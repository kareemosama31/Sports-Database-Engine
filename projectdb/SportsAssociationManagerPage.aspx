<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SportsAssociationManagerPage.aspx.cs" Inherits="ProjectDB.SportsAssociationManagerPage" %>

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
            Match<br />
        <asp:Button ID="addMatch" runat="server" Text="Add" PostBackUrl="~/NewMatch.aspx" />
        <asp:Button ID="deleteMatch" runat="server" Text="Delete" PostBackUrl="~/DeleteMatch.aspx" />
        <br />
            <br />
            View<br />
        <asp:Button ID="UpMatch" runat="server" Text="All Upcoming Matches" PostBackUrl="~/UpcomingMatches.aspx" />
            <br />
        <asp:Button ID="PlayMatch" runat="server" Text="Already Played Matches" PostBackUrl="~/PlayedMatches.aspx"/>
            <br />
            <asp:Button ID="TwoPlayed" runat="server" Text="Clubs Never Played Together" PostBackUrl="~/TwoNeverPlay.aspx" />
        <br />
        </div>
    </form>
</body>
</html>
