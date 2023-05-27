<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RejectReq.aspx.cs" Inherits="ProjectDB.RejectReq" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="color:white; background-color:black; font-size:25px; text-align:center">
    <form id="form1" runat="server">
        <div>
            Please Enter The Request Information<br />
            <br />
            Host Club
            Name:<br />
            <asp:TextBox ID="Host" runat="server"></asp:TextBox>

            <br />
            Guest Club Name:<br />
            <asp:TextBox ID="Guest" runat="server"></asp:TextBox>
            <br />
            Start Time:<br />
            <asp:TextBox ID="Start" runat="server" type="datetime-local"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Accept" runat="server" Text="Reject" OnClick="AccReq" />

        </div>
    </form>
</body>
</html>
