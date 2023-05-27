<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewStadium.aspx.cs" Inherits="ProjectDB.NewStadium" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="color:white; background-color:black; font-size:25px; text-align:center">
    <form id="form1" runat="server">
        <div>
            Please Enter The Stadium&#39;s Name, Location And Capacity<br />
            <br />
            Name:<br />
            <asp:TextBox ID="StadName" runat="server"></asp:TextBox>

            <br />
            Location:<br />
            <asp:TextBox ID="StadLocation" runat="server"></asp:TextBox>
            <br />
            Capacity:<br />
            <asp:TextBox ID="StadCapacity" runat="server" type="number" min="0" value="0"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Add" runat="server" Text="Add" OnClick="AddStad" />
        </div>
    </form>
</body>
</html>
