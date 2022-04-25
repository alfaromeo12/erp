<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UserInfo.aspx.vb" Inherits="UserInfo" %>
<%@ Register Assembly="BusyBoxDotNet" Namespace="BusyBoxDotNet" TagPrefix="busyboxdotnet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <link rel="Stylesheet" type="text/css" href="../StyleSheet.css" />
    <title>User Info</title>
</head>
<body>
    <form id="UserInfoForm" runat="server">
    <div style="font-weight:bolder" class="title">User Info</div>
        <busyboxdotnet:BusyBox ID="BusyBoxUserrInfo" runat="server" Image="GreyBar" ShowBusyBox="OnLeavingPage" />
        <br />
        <asp:SqlDataSource ID="sdsUser" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            SelectCommand="SELECT APPSESSIONS.TimeOut, APPSESSIONS.IP, APPUSER.UserID, APPUSER.UserName, APPUSER.LastLogin, APPUSER.THEME, CASE WHEN APPUSER.MenuStyle = 1 THEN 'TREEVIEW MENU' WHEN APPUSER.MenuStyle = 2 THEN 'SLIDERMENU' ELSE 'DROPDOWN MENU' END AS MenuStyle FROM APPSESSIONS INNER JOIN APPUSER ON APPSESSIONS.UID = APPUSER.UID WHERE (APPSESSIONS.UID = @UID)">
            <SelectParameters>
                <asp:CookieParameter CookieName="UID" Name="UID" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:DataList ID="dlUser" runat="server" DataSourceID="sdsUser" Caption="User and Session Info" Width="100%"  >
            <ItemTemplate>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <th colspan="2" class="HeaderStyle">
                            User Info</th>
                    </tr>
                    <tr>
                        <td style="width: 92px">
                            User ID</td>
                        <td>
                            <asp:Label ID="UserIDLabel" runat="server" Text='<%# Eval("UserID") %>' Font-Bold="True" Font-Underline="True"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 92px">
                            User Name</td>
                        <td>
                            <asp:Label ID="UserNameLabel" runat="server" Text='<%# Eval("UserName") %>' Font-Bold="True" Font-Underline="True"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 92px">
                            Theme</td>
                        <td>
                            <asp:Label ID="lblTheme" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("THEME") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 92px">
                            Menu Style</td>
                        <td>
                            <asp:Label ID="lblMenu" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("MenuStyle") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 92px">
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <th colspan="2" class="HeaderStyle" >
                            Session Info</th>
                    </tr>
                    <tr>
                        <td style="width: 92px">
                            TimeOut</td>
                        <td>
                            <asp:Label ID="TimeOutLabel" runat="server" Text='<%# Eval("TimeOut", "{0:dd/MM/yyyy hh:mm:sss}") %>' Font-Bold="True" Font-Underline="True"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 92px">
                            IP</td>
                        <td>
                            <asp:Label ID="IPLabel" runat="server" Text='<%# Eval("IP") %>' Font-Bold="True" Font-Underline="True"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 92px">
                            Last Login</td>
                        <td>
                            <asp:Label ID="LastLoginLabel" runat="server" Text='<%# Eval("LastLogin", "{0:dd/MM/yyyy hh:mm:sss}") %>' Font-Bold="True" Font-Underline="True"></asp:Label></td>
                    </tr>
                    <asp:Panel ID="pnlImage" runat="server" GroupingText="IMAGE" Width="100%">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
               <td>Image</td>
                <td>
                 <asp:Image ID="imgUser" style="width:300px;height:auto" Runat="server" Visible="true" />
                    </td>
            </tr>
                </table>
        </asp:Panel>
                </table>
            </ItemTemplate>
        </asp:DataList><br />
        <asp:Button ID="btnPwd" runat="server" Text="Change Password" style="cursor: pointer" />
        <asp:Button ID="btnLogout" runat="server" OnClick="btnLogout_Click" Text="Logout" style="cursor: pointer" />
    </form>
</body>
</html>
