<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RequestStad.aspx.cs" Inherits="ProjectDB.RequestStad" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="color:white; background-color:black; font-size:25px; text-align:center">
    <form id="form1" runat="server">
        <div>
            Please Enter The Information Below<br />
            <br />
            Stadium Name:<br />
            <asp:TextBox ID="stadname" runat="server"></asp:TextBox>
            <br />
            Start Time:<br />
            <asp:TextBox ID="start" runat="server" type="datetime-local"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="request" runat="server" Text="Request" OnClick="Req"/>
            <br />
        </div>
    </form>
</body>
</html>
