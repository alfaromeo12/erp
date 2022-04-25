<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ChangePassword.aspx.vb" Inherits="ChangePassword" %>
<%@ Register Assembly="BusyBoxDotNet" Namespace="BusyBoxDotNet" TagPrefix="busyboxdotnet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <link rel="Stylesheet" type="text/css" href="../StyleSheet.css" />
    <title>Change User Password</title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="title">Change Password</div>
        <busyboxdotnet:BusyBox ID="BusyBoxPwd" runat="server" Image="FadingCircles" ShowBusyBox="OnLeavingPage" />
    <ajaxToolkit:ToolkitScriptManager ID="ajaxSMChangePassword" runat="server">
    </ajaxToolkit:ToolkitScriptManager>
        <br />
        <asp:SqlDataSource ID="sdsUser" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            SelectCommand="SELECT APPSessions.TimeOut, APPSessions.IP, APPUser.UserID, APPUser.UserName, APPUser.LastLogin FROM APPSessions INNER JOIN APPUser ON APPSessions.UID = APPUser.UID WHERE (APPSessions.UID = @UID)">
            <SelectParameters>
                <asp:CookieParameter CookieName="UID" Name="UID" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:DataList ID="dlUser" runat="server" DataSourceID="sdsUser" Caption="User and Session Info">
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
        </asp:DataList><br />
        <table width="600" cellpadding="0" cellspacing="0">
            <tr>
                <th colspan="2" class="HeaderStyle">
                    Change Password</th>
            </tr>
            <tr>
                <td style="width: 160px" class="AlternatingRowStyle">Old Password</td>
                <td class="AlternatingRowStyle">
        <asp:TextBox ID="txtOldPassword" runat="server" TextMode="Password" CssClass="required"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqOld_password" runat="server" 
                        ControlToValidate="txtOldPassword" Display="None" 
                        ErrorMessage="Old Password must be entry..." ForeColor="Red" 
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqOld_password_ValidatorCalloutExtender" 
                        runat="server" Enabled="True" TargetControlID="reqOld_password" 
                        HighlightCssClass="ErrHighLight">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td style="width: 160px" class="FooterStyle">New Password</td>
                <td class="FooterStyle">
                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" 
                        CssClass="required"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqNew_password" runat="server" 
                        ControlToValidate="txtNewPassword" Display="None" 
                        ErrorMessage="New Password must be entry..." ForeColor="Red" 
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqNew_password_ValidatorCalloutExtender" 
                        runat="server" Enabled="True" TargetControlID="reqNew_password">
                    </ajaxToolkit:ValidatorCalloutExtender>
                    <asp:RegularExpressionValidator ID="reqEXPnew_password" runat="server" 
                        ControlToValidate="txtNewPassword" Display="None" 
                        ErrorMessage="Invalid password strenght please use min 6 for lenght, and use min 1 Lower Case Letter and 1 Upper Case Letter and 1 numerik and 1 Special character" 
                        ForeColor="Red" 
                        ValidationExpression="^.*(?=.{6,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!`~@#$%^&amp;+=]).*$" 
                        SetFocusOnError="True"></asp:RegularExpressionValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqEXPnew_password_ValidatorCalloutExtender" 
                        runat="server" Enabled="True" TargetControlID="reqEXPnew_password">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td style="width: 160px" class="FooterStyle">Retype New Password</td>
                <td class="FooterStyle">
        <asp:TextBox ID="txtRetype" runat="server" TextMode="Password" CssClass="required"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqRetype_password" runat="server" 
                        ControlToValidate="txtRetype" Display="None" 
                        ErrorMessage="Retype New Password must be entry..." ForeColor="Red" 
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqRetype_password_ValidatorCalloutExtender" 
                        runat="server" Enabled="True" TargetControlID="reqRetype_password" 
                        HighlightCssClass="ErrHighLight">
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
                    <asp:Button ID="btnLogin" runat="server" Text="Re-login" 
                        CausesValidation="False" Visible="False" 
                        onclientclick="return ReLogin();" />
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
