<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SMS.aspx.vb" Inherits="SMS" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <table cellpadding="0" cellspacing="0" style="width:100%;">
            <tr>
                <td>
                    Comp Port</td>
                <td>
                    <asp:DropDownList ID="puertos" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    Mobile No.</td>
                <td>
                    <asp:TextBox ID="numero" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    Text SMS</td>
                <td>
                    <asp:TextBox ID="mensaje" runat="server" Height="87px" TextMode="MultiLine" 
                        Width="251px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="font-weight: 700">
                    <asp:Button ID="btnSend" runat="server" style="height: 26px" Text="Send SMS" 
                        Visible="False" />
                    <asp:Button ID="btnSendQueue" runat="server" style="height: 26px" 
                        Text="Send SMS Queue" />
                </td>
            </tr>
            <tr>
                <td colspan="2" style="font-weight: 700">
                    <asp:Label ID="lblMessage" runat="server" Visible="False"></asp:Label>
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
