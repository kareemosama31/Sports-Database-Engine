<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewClub.aspx.cs" Inherits="ProjectDB.NewClub" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="color:white; background-color:black; font-size:25px; text-align:center">
    <form id="form1" runat="server">
        <div>
            Please Enter The Club&#39;s Name And Location<br />
            <br />
            Name:<br />
            <asp:TextBox ID="ClubName" runat="server"></asp:TextBox>

            <br />
            Location:<br />
            <asp:TextBox ID="ClubLocation" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Add" runat="server" Text="Add" OnClick="AddClub" />

        </div>
    </form>
</body>
</html>
