<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AvailableStads.aspx.cs" Inherits="ProjectDB.AvailableStads" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="color:white; background-color:black; font-size:25px; text-align:center">
    <form id="form1" runat="server">
        <div>
            
            Please Enter The Date To Get Stadiums<br />
            <br />
            Date:<br />
            <asp:TextBox ID="datet" runat="server" type="datetime-local"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="View" runat="server" Text="View" OnClick="ViewStad"  />
            <br />
            <br />
            <br />
            
            
            
            <table style="width: 100%;">
                <tr>
                   <td>Name</td>
                    <td>Location</td>
                    <td>Capacity</td>
                    
                </tr>

                <%=getAvailableStadiumsData()%>
                
            </table>
            
            
            
            <br />
            <br />
        </div>
    </form>
</body>
</html>
