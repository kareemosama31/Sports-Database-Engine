<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SportsAssociationManagerLog.aspx.cs" Inherits="ProjectDB.SportsAssociationManagerLog" %>

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
                 <br />
                 <asp:LinkButton ID="Register" runat="server" ForeColor="Red" Font-Size="15px" PostBackUrl="~/SportsAssociationManagerReg.aspx" OnClick="loginclick">New User? Click To Register!</asp:LinkButton>
                 <br />
        </div>
    </form>
</body>
</html>
