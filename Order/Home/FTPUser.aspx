<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FTPUser.aspx.vb" Inherits="FTPUser" %>
<%@ Register Assembly="BusyBoxDotNet" Namespace="BusyBoxDotNet" TagPrefix="busyboxdotnet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <link rel="Stylesheet" type="text/css" href="../StyleSheet.css" />
    <title>FTP User and Password</title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="title">Change Password</div>
        <busyboxdotnet:BusyBox ID="BusyBoxPwd" runat="server" Image="FadingCircles" ShowBusyBox="OnLeavingPage" />
    <ajaxToolkit:ToolkitScriptManager ID="ajaxSMTPUser" runat="server">
    </ajaxToolkit:ToolkitScriptManager>
        <br />
        <asp:SqlDataSource ID="sdsUser" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            SelectCommand="SELECT APPSessions.TimeOut, APPSessions.IP, APPUser.UserID, APPUser.UserName, APPUser.LastLogin FROM APPSessions INNER JOIN APPUser ON APPSessions.UID = APPUser.UID WHERE (APPSessions.UID = @UID)">
            <SelectParameters>
                <asp:CookieParameter CookieName="UID" Name="UID" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:DataList ID="dlUser" runat="server" DataSourceID="sdsUser" 
        Caption="User and Session Info" Width="600px">
            <ItemTemplate>
                <table cellpadding="0" cellspacing="0" width="600">
                    <tr>
                        <th class="HeaderStyle" colspan="2">
                            User Info</th>
                    </tr>
                    <tr>
                        <td>
                            User ID</td>
                        <td>
                            <asp:Label ID="UserIDLabel" runat="server" Text='<%# Eval("UserID") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            User Name</td>
                        <td>
                            <asp:Label ID="UserNameLabel" runat="server" Text='<%# Eval("UserName") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <th class="HeaderStyle"  colspan="2">
                            Session Info</th>
                    </tr>
                    <tr>
                        <td>
                            TimeOut</td>
                        <td>
                            <asp:Label ID="TimeOutLabel" runat="server" Text='<%# Eval("TimeOut", "{0:dd/MM/yyyy hh:mm:sss}") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            IP</td>
                        <td>
                            <asp:Label ID="IPLabel" runat="server" Text='<%# Eval("IP") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Last Login</td>
                        <td>
                            <asp:Label ID="LastLoginLabel" runat="server" Text='<%# Eval("LastLogin", "{0:dd/MM/yyyy hh:mm:sss}") %>'></asp:Label></td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
    <asp:DataList ID="dlPSAKSERVER" runat="server" Caption="PSAK SERVER SETTING" 
        DataSourceID="sdsPSAKServer" Width="600px">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" style="width:100%;">
                <tr>
                    <td class="ShowDetail">
                        PSAK SERVER</td>
                    <td class="ShowDetail">
                        <asp:Label ID="PSAKSERVERLabel" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("PSAKSERVER") %>' />
                    </td>
                    <td class="ShowDetail">
                        PSAK Direktory
                    </td>
                    <td class="ShowDetail">
                        <asp:Label ID="PSAKSERVERDIRLabel" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("PSAKSERVERDIR") %>' />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="sdsPSAKServer" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        SelectCommand="SELECT dbo.f_getAppSetting('PSAKSERVER') AS PSAKSERVER, dbo.f_getAppSetting('PSAKSERVERDIR') AS PSAKSERVERDIR">
    </asp:SqlDataSource>
    <asp:HiddenField ID="hidPSAKSERVER" runat="server" />
    <asp:HiddenField ID="hidPSAKDIR" runat="server" />
    <br />
        <table width="600" cellpadding="0" cellspacing="0">
            <tr>
                <th colspan="2" class="HeaderStyle">
                    FTP User and Password</th>
            </tr>
            <tr>
                <td style="width: 160px" class="AlternatingRowStyle">FTP User Name</td>
                <td class="AlternatingRowStyle">
        <asp:TextBox ID="txtUser" runat="server" CssClass="required"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqUser" runat="server" 
                        ControlToValidate="txtUser" Display="None" 
                        ErrorMessage="[FTP USER NAME] must be entry..." ForeColor="Red" 
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqUser_ValidatorCalloutExtender" 
                        runat="server" Enabled="True" TargetControlID="reqUser" 
                        HighlightCssClass="ErrHighLight" BehaviorID="ajaxVCEUser" 
                        CssClass="ErrHighLight">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td style="width: 160px" class="FooterStyle">FTP User Password</td>
                <td class="FooterStyle">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" 
                        CssClass="required"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqPassword" runat="server" 
                        ControlToValidate="txtPassword" Display="None" 
                        ErrorMessage="[FTP USER PASSWORD] must be entry..." ForeColor="Red" 
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqPassword_ValidatorCalloutExtender" 
                        runat="server" Enabled="True" TargetControlID="reqPassword" 
                        BehaviorID="ajaxVCEPassword" HighlightCssClass="ErrHighLight">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblMessage" runat="server" style="text-align: center" CssClass="ErrHighLight" Font-Bold="True" Width="100%" Visible="False"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblMessage">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
                    </td>
            </tr>
            <tr>
                <td colspan="2" class="HeaderStyle">
        <asp:Button ID="btnSave" runat="server" Text="Save" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <hr />
                </td>
            </tr>
        </table>
        <br />
        <br />
    </form>
    <script type="text/javascript" language="JavaScript" src="../include/validation.js"></script>
    <script type="text/javascript">
        function ReLogin() {
            window.parent.location="../login.aspx"
            return (false);
        }
    </script>
</body>
</html>
