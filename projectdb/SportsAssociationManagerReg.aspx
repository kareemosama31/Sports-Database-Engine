<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SportsAssociationManagerReg.aspx.cs" Inherits="ProjectDB.SportsAssociationManagerReg" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="color:white; background-color:black; font-size:25px; text-align:center">
    <form id="form1" runat="server">
        <div>
             Enter Your Information To Register!<br />
             <br />
             Name:<br />
             <asp:TextBox ID="SAMname" runat="server"></asp:TextBox>
            <br />
            Username:<br />
            <asp:TextBox ID="SAMusername" runat="server"></asp:TextBox>
            <br />
            Password:<br />
            <asp:TextBox ID="SAMpassword" runat="server" type="password"></asp:TextBox>
            <br />
            <br />
&nbsp;<asp:Button ID="loginbutton" runat="server" OnClick="loginclick" Text="Register"/>
        </div>
    </form>
</body>
</html>
