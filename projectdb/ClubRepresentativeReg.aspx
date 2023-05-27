<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClubRepresentativeReg.aspx.cs" Inherits="ProjectDB.ClubRepresentativeReg" %>

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
             <asp:TextBox ID="CRname" runat="server"></asp:TextBox>
            <br />
            Username:<br />
            <asp:TextBox ID="CRusername" runat="server"></asp:TextBox>
            <br />
            Password:<br />
            <asp:TextBox ID="CRpassword" runat="server" type="password"></asp:TextBox>
            <br />
             Name Of Club:<br />
             <asp:TextBox ID="CRclub" runat="server"></asp:TextBox>
             <br />
            <br />
&nbsp;<asp:Button ID="loginbutton" runat="server" OnClick="rclick" Text="Register"/>
        </div>
    </form>
</body>
</html>
