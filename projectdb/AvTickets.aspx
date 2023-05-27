<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AvTickets.aspx.cs" Inherits="ProjectDB.AvTickets" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="color:white; background-color:black; font-size:25px; text-align:center">
    <form id="form1" runat="server">
        <div>
            Please Enter The Date To Get Available Matches<br />
            <br />
            Date:<br />
            <br />
            <asp:TextBox ID="TextBox1" runat="server" type="datetime-local"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="View" runat="server" Text="View"  />
            <br />
            <br />
            <br />
            
            
            
            <table style="width: 100%;">
                <tr>
                   <td>Host</td>
                    <td>Guest</td>
                    <td>Start Time</td>
                                        <td>Stadium</td>

                    
                </tr>

                <%=getAvMatch()%>
                
            </table>
            
            
            
            <br />
            <br />
        </div>
    </form>
</body>
</html>
