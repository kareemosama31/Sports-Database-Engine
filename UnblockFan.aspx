<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UnblockFan.aspx.cs" Inherits="ProjectDB.UnblockFan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="color:white; background-color:black; font-size:25px; text-align:center">
    <form id="form1" runat="server">
        <div>
            Please Enter The Fan's National ID<br />
            <br />
            National ID:<br />
            <asp:TextBox ID="FanID" runat="server"></asp:TextBox>

            <br />
            <br />
            <asp:Button ID="Block" runat="server" Text="Unblock" OnClick="Blockf" />
        </div>
    </form>
</body>
</html>
