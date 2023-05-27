<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeleteClub.aspx.cs" Inherits="ProjectDB.DeleteClub" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="color:white; background-color:black; font-size:25px; text-align:center">
    <form id="form1" runat="server">
        <div>
            Please Enter The Club&#39;s Name<br />
            <br />
            Name:<br />
            <asp:TextBox ID="ClubName" runat="server"></asp:TextBox>

            <br />
            <br />
            <asp:Button ID="Delete" runat="server" Text="Delete" OnClick="Deletec" />
        </div>
    </form>
</body>
</html>
