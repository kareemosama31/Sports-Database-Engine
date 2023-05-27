<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SystemAdminLog.aspx.cs" Inherits="ProjectDB.SystemAdminLog" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="color:white; background-color:black; font-size:25px; text-align:center">
    <form id="form1" runat="server">
        <div>
            Enter Your Information To Login!<br />
            <br />
            Username:<br />
            <asp:TextBox ID="username" runat="server"></asp:TextBox>
            <br />
            Password:<br />
            <asp:TextBox ID="password" runat="server" type="password"></asp:TextBox>
            <br />
            <br />
&nbsp;<asp:Button ID="loginbutton" runat="server" OnClick="loginclick" Text="Login"/>
        </div>
    </form>
</body>
</html>
