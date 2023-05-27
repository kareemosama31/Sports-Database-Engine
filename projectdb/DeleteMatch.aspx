<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeleteMatch.aspx.cs" Inherits="ProjectDB.DeleteMatch" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="color:white; background-color:black; font-size:25px; text-align:center">
    <form id="form1" runat="server">
        <div>
            Please Enter The Match&#39;s Information<br />
            <br />
            Host Club
            Name:<br />
            <asp:TextBox ID="HostName" runat="server"></asp:TextBox>

            <br />
            Guest Club Name:<br />
            <asp:TextBox ID="GuestName" runat="server"></asp:TextBox>
            <br />
            Start Time:<br />
            <asp:TextBox ID="Start" runat="server" type="datetime-local"></asp:TextBox>
            <br />
            End Time:<br />
            <asp:TextBox ID="End" runat="server" type="datetime-local"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Delete" runat="server" Text="Delete" OnClick="DeleteMatchc"  />
        </div>
    </form>
</body>
</html>
