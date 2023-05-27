<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FanLog.aspx.cs" Inherits="ProjectDB.FanLog" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="color:white; background-color:black; font-size:25px; text-align:center">
    <form id="form1" runat="server">
        <div>
               
            Enter Information To Login<br />
            <br />
            UserName:<br />
            <asp:TextBox ID="user" runat="server"></asp:TextBox>
            <br />
            Password:<br />
            <asp:TextBox ID="pass" runat="server" type="password"></asp:TextBox>
            <br />
            <br />
            &nbsp;<asp:Button ID="loginbutton" runat="server" OnClick="loginclick" Text="Login"/>
            <br />
            <asp:LinkButton ID="Register" runat="server" ForeColor="Red" Font-Size="15px" PostBackUrl="~/FanReg.aspx" >New User? Click To Register!</asp:LinkButton>
               
        </div>
    </form>
</body>
</html>
