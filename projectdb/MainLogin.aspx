<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainLogin.aspx.cs" Inherits="ProjectDB.MainLogin" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="color:white; font-size:25px; text-align:center; background-color:black">
    <form id="form1" runat="server">
        <div>
            What Kind Of User Are You?<br />
            <br />
        </div>
        <asp:Button ID="SA" runat="server" Text="System Admin" PostBackUrl="~/SystemAdminLog.aspx" BackColor="black" ForeColor="white" BorderColor="White" Font-Size="20px" Height="70" Width="270"/>
        <br />
        <br />
        <asp:Button ID="SAM" runat="server" Text="Sports Association Manager" PostBackUrl="~/SportsAssociationManagerLog.aspx" BackColor="Black" ForeColor="White" BorderColor="White" Font-Size="20px" Height="70" Width="270"/>
        <br />
        <br />
        <asp:Button ID="CR" runat="server" Text="Club Representative" PostBackUrl="~/ClubRepresentativeLog.aspx" BackColor="Black" ForeColor="White" BorderColor="White" Font-Size="20px" Height="70" Width="270"/>
        <br />
        <br />
        <asp:Button ID="SM" runat="server" Text="Stadium Manager" PostBackUrl="~/StadiumManagerLog.aspx" BackColor="Black" ForeColor="White" BorderColor="White" Font-Size="20px" Height="70" Width="270"/>
        <br />
        <br />
        <asp:Button ID="F" runat="server" Text="Fan" PostBackUrl="~/FanLog.aspx" BackColor="Black" ForeColor="White" BorderColor="White" Font-Size="20px" Height="70" Width="270"/>
     </form>
</body>
</html>
