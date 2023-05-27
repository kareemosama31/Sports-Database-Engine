<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FanReg.aspx.cs" Inherits="ProjectDB.FanReg" %>

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
             <asp:TextBox ID="Fname" runat="server"></asp:TextBox>
            <br />
            Username:<br />
            <asp:TextBox ID="Fusername" runat="server"></asp:TextBox>
            <br />
            Password:<br />
            <asp:TextBox ID="Fpassword" runat="server" type="password"></asp:TextBox>
            <br />
            National ID:<br />
            <asp:TextBox ID="FID" runat="server"></asp:TextBox>
            <br />
            Phone Number:<br />
            <asp:TextBox ID="FPhone" runat="server" type="number"></asp:TextBox>
            <br />
            Birth Date:<br />
            <asp:TextBox ID="FBD" runat="server" type="date"></asp:TextBox>
            <br />
            Address:<br />
            <asp:TextBox ID="FAddress" runat="server"></asp:TextBox>
            <br />
            <br />
&nbsp;<asp:Button ID="loginbutton" runat="server" OnClick="loginclick" Text="Register"/>
        </div>
    </form>
</body>
</html>
