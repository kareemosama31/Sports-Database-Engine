<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeleteStadium.aspx.cs" Inherits="ProjectDB.DeleteStadium" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="color:white; background-color:black; font-size:25px; text-align:center">
    <form id="form1" runat="server">
        <div>
            <div>
            Please Enter The Stadium&#39;s Name<br />
            <br />
            Name:<br />
            <asp:TextBox ID="StadName" runat="server"></asp:TextBox>

            <br />
            <br />
            <asp:Button ID="Delete" runat="server" Text="Delete" OnClick="Deletes" />
        </div>
    </form>
</body>
</html>
