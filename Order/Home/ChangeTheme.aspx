<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ChangeTheme.aspx.vb" Inherits="Home_ChangeTheme" title="Untitled Page" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <link rel="Stylesheet" type="text/css" href="../StyleSheet.css" />
    <title>Change User Theme</title>
</head>
<body>
    <form id="UserInfoForm" runat="server">

<div class="title" style="font-weight: bolder">Change Theme</div>
<br />
    <asp:SqlDataSource ID="sdsUser" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT APPSESSIONS.TimeOut, APPSESSIONS.IP, APPUSER.UserID, APPUSER.UserName, APPUSER.LastLogin, APPUSER.THEME, CASE WHEN APPUSER.MenuStyle = 1 THEN 'TREEVIEW MENU' WHEN APPUSER.MenuStyle = 2 THEN 'SLIDERMENU' ELSE 'DROPDOWN MENU' END AS MenuStyle FROM APPSESSIONS INNER JOIN APPUSER ON APPSESSIONS.UID = APPUSER.UID WHERE (APPSESSIONS.UID = @UID)">
        <SelectParameters>
            <asp:CookieParameter CookieName="UID" Name="UID" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:DataList ID="dlUser" runat="server" Caption="User Theme Info" DataSourceID="sdsUser"
        Width="100%">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <th class="HeaderStyle" colspan="2">
                        User Info</th>
                </tr>
                <tr>
                    <td style="width: 92px">
                        User ID</td>
                    <td>
                        <asp:Label ID="UserIDLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("UserID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 92px">
                        User Name</td>
                    <td>
                        <asp:Label ID="UserNameLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("UserName") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 92px">
                        Menu Style</td>
                    <td>
                        <asp:Label ID="lblMenu" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("MenuStyle") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 92px">
                        Current
                        Theme</td>
                    <td>
                        <asp:Label ID="lblTheme" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("THEME") %>'></asp:Label></td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
        <table cellpadding="1" cellspacing="1" width="100%">
            <tr>
                <td class="FooterStyle" colspan="2">
                    <hr />
                </td>
            </tr>
            <tr>
                <td class="RowStyle" style="width: 158px">
    New Menu Style&nbsp; :</td>
                <td class="RowStyle">
    <asp:DropDownList ID="ddlTheme" runat="server" AutoPostBack="True">
        <asp:ListItem Value="0">Choose Theme</asp:ListItem>
        <asp:ListItem>Default</asp:ListItem>
        <asp:ListItem>Moccha</asp:ListItem>
        <asp:ListItem>Rainy</asp:ListItem>
        <asp:ListItem>Sand</asp:ListItem>
        <asp:ListItem>Colorful</asp:ListItem>
        <asp:ListItem>Classic</asp:ListItem>
        <asp:ListItem>Simple</asp:ListItem>
        <asp:ListItem>Professional</asp:ListItem>
        <asp:ListItem>Slate</asp:ListItem>
    </asp:DropDownList></td>
            </tr>
            <tr>
                <td class="FooterStyle" colspan="2">
                    <hr />
                </td>
            </tr>
        </table>
        <br />
        &nbsp;&nbsp;
    </form>
</body>
</html>
