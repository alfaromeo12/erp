<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TestFTP.aspx.vb" Inherits="BI_TestFTP" Title="TESTING FTP" %>

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
                    Server</td>
                <td>
                    <asp:TextBox ID="txtServer" runat="server" CssClass="required"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    User</td>
                <td>
                    <asp:TextBox ID="txtUser" runat="server" CssClass="required"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Password</td>
                <td>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" 
                        CssClass="required"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    File to Upload via FTP</td>
                <td>
                    <asp:FileUpload ID="FileFTP" runat="server" CssClass="required" />
                </td>
            </tr>
            <tr>
                <td>
                    FTP Server Direktory</td>
                <td>
                    <asp:TextBox ID="txtFTPDirektory" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    FTP File Name</td>
                <td>
                    <asp:TextBox ID="txtFTPFile" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnFTP" runat="server" Text="Send FTP" />
                </td>
                <td>
                    <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" 
                        Visible="False"></asp:Label>
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
