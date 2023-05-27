<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Buy.aspx.cs" Inherits="ProjectDB.Buy" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="color:white; background-color:black; font-size:25px; text-align:center">
    <form id="form1" runat="server">
        <div>

            Enter Information For Match You Want To Buy Ticket For<br />
            <br />
            Host Club Name:<br />
            <asp:TextBox ID="host" runat="server"></asp:TextBox>
            <br />
            Guest Club Name:<br />
            <asp:TextBox ID="guest" runat="server" ></asp:TextBox>
            <br />
            Start Time:<br />
            <asp:TextBox ID="start" runat="server" type="datetime-local"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="buybutton" runat="server" OnClick="buys" Text="Buy" />

        </div>
    </form>
</body>
</html>
