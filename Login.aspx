<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Login.aspx.vb" Inherits="LoginX" Title="Login"  %>

<%@ Register Assembly="DevExpress.Web.v17.2, Version=17.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="BusyBoxDotNet" Namespace="BusyBoxDotNet" TagPrefix="busyboxdotnet" %>
<%@ Register assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI" tagprefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<title>PPI Portal</title>
	<link rel="shortcut icon" href="images/destarlogo.PNG" />
<style type="text/css">
.required
{
	background-position: right top;
	background-image: url(images/required.gif);
	background-repeat: no-repeat;
	background-color: #66ffff;
}
.ErrHighLight
{
	background-color: yellow;
}
.ImgLogin
{
	background-image: url();
	background-repeat:no-repeat;
	background-position: right top;
}
.ImgDleas
{
	background-image: url(images/destarlogo.PNG);
	background-repeat: no-repeat;
	background-position: center top;
}

.style4
{
    width: 120px;
}

</style>
</head>

<body  style="margin:0;margin-left:0;">

	<form id="LoginForm" runat="server">
    <ajaxToolkit:ToolkitScriptManager ID="ajaxToolKitSM" runat="server">
	<Services>
	<asp:ServiceReference Path="GHWService.asmx" />
	</Services>
    </ajaxToolkit:ToolkitScriptManager>
		<busyboxdotnet:BusyBox ID="BusyBoxLogin" runat="server" Image="GearsBig" 
        ShowBusyBox="OnLeavingPage" GZipCompression="true" />
		<asp:Panel ID="PanelBottom" runat="server" BorderStyle="Outset" 
        Width="98%" ForeColor="White" BackColor="#00008B" 
		style="font-weight: bold; color:white;  border-top-style: outset; font-family:'Franklin Gothic Book'; border-right-style: outset; border-left-style: outset; border-bottom-style: outset" 
		BorderWidth="0px" Wrap="False"><center><%=strAppName%>&nbsp;</center></asp:Panel>
        <ajaxToolkit:DropShadowExtender ID="ajaxDSEPanelBottom" runat="server" 
        Enabled="True" TargetControlID="PanelBottom" Opacity="0.5" Rounded="True" 
        Width="7">
        </ajaxToolkit:DropShadowExtender>
        <ajaxToolkit:AlwaysVisibleControlExtender ID="ajxAVCEPSAK" runat="server" HorizontalSide="Center" TargetControlID="PanelBottom" VerticalSide="Top">
        </ajaxToolkit:AlwaysVisibleControlExtender>
		<br />
		<br />
		<asp:Panel ID="pnlLogin" runat="server">
					<table cellspacing="0" style="width: 381px; height: 185px;" id="TABLE2" class="ImgDleas" >
                    <tr>
                    <td></td>
                    </tr>
					</table>
					<table cellspacing="0" style="width: 550px;" id="TABLE1" class="ImgLogin" >
						<tr>
							<td colspan="2" bgcolor="#f9f697" ></td>
						</tr>
						<tr>
							<td bgcolor="#ffffff" colspan="2" ></td>
						</tr>
						<tr style="vertical-align:middle;">
                            <td>
							<td colspan="2" >
								<img alt="login" src="Images/button-login.jpg" />
								<asp:Label ID="lblUserID" runat="server" 
									style="font-size: 18pt; font-family: Tahoma; color: #009933; " 
									Text="USER LOGIN"></asp:Label>
							</td>
                                </td>
						</tr>
						<tr>
							<td class="style4">
								 <dx:ASPxLabel ID="lblUser" runat="server"  Text="User ID" 
                                     style="font-size: 10pt;  color: #009900; font-weight: 700;"></dx:ASPxLabel>
								 </td>
							<td>
                                <asp:TextBox ID="txtUser" runat="server" autocomplete="off" CssClass="required" 
                                    Width="150px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ReqUserID" runat="server" 
                                    ControlToValidate="txtUser" Display="None" 
                                    ErrorMessage="User ID must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCE" runat="server" 
                                    HighlightCssClass="ErrHighLight" TargetControlID="ReqUserID">
                                </ajaxToolkit:ValidatorCalloutExtender>
                            </td>
						</tr>
						<tr>
							<td class="style4">
								<dx:ASPxLabel ID="lblPass" runat="server" Text="Password" 
                                    style="font-size: 10pt;  color: #009900; font-weight: 700;"></dx:ASPxLabel>
								</td>
							<td>
                                <asp:TextBox ID="txtPass" runat="server" CssClass="required" Font-Bold="False" 
                                    TextMode="Password" Width="150px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ReqPassword" runat="server" 
                                    ControlToValidate="txtPass" Display="None" 
                                    ErrorMessage="Password must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <ajaxToolkit:ValidatorCalloutExtender ID="ReqPassword_ValidatorCalloutExtender" 
                                    runat="server" HighlightCssClass="ErrHighLight" TargetControlID="ReqPassword">
                                </ajaxToolkit:ValidatorCalloutExtender>
                            </td>
						</tr>
						<tr>
							<td class="style4">
								<dx:ASPxLabel ID="Label1" runat="server"  Text="Menu Style" 
									style="font-size: 10pt; color: #009900; font-weight: 700;"></dx:ASPxLabel>
								</td>
							<td>
								<asp:DropDownList ID="ddlMenu" runat="server" Width="150px">
                                    <asp:ListItem Value="0">Previous Menu Style</asp:ListItem>
                                    <asp:ListItem Value="1">Treeview Menu</asp:ListItem>
                                    <asp:ListItem Value="2">Slider Menu</asp:ListItem>
                                    <asp:ListItem Value="3">Dropdown Menu</asp:ListItem>
                                </asp:DropDownList>
                            </td>
						</tr>
						<tr>
							<td class="style4">
								<dx:ASPxLabel ID="Label2" runat="server" Text="Available Theme" 
									style="font-size: 10pt; color: #009900; font-weight: 700;"></dx:ASPxLabel>
							</td>
							<td>
								<asp:DropDownList ID="ddlTheme" runat="server" Width="150px">
                                    <asp:ListItem Value="0">Previous Theme</asp:ListItem>
                                    <asp:ListItem>Default</asp:ListItem>
                                    <asp:ListItem>Moccha</asp:ListItem>
                                    <asp:ListItem>Rainy</asp:ListItem>
                                    <asp:ListItem>Sand</asp:ListItem>
                                    <asp:ListItem>Colorful</asp:ListItem>
                                    <asp:ListItem>Classic</asp:ListItem>
                                    <asp:ListItem>Simple</asp:ListItem>
                                    <asp:ListItem>Professional</asp:ListItem>
                                    <asp:ListItem>Slate</asp:ListItem>
                                </asp:DropDownList>
                            </td>
						</tr>
                       
						<tr>
                            <td class="style4">
								<asp:Label ID="Label4" runat="server" 
									style="font-size: 10pt; color: #009900; font-weight: 700;"></asp:Label>
							</td>
							<td colspan="2">
								<dx:ASPxButton ID="btnLogin" runat="server" 
									style="cursor: pointer; background-position: right; background-image: url(images/login.gif); background-repeat: no-repeat; text-align: left;" 
									Text="Login" CssClass="style4"  />
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<hr />
							</td>
						</tr>
						<tr>
							<td style="text-align: left; font-weight: bold; font-style: normal;" colspan="2">
								<a href="#" onclick='this.style.behavior=&#039;url(#default#homepage)&#039;;this.setHomePage(&#039;<%="http://" & Request.ServerVariables("SERVER_NAME") &  Request.ServerVariables("SCRIPT_NAME")%>&#039;);' style="font-size: 10pt;font-family:'Franklin Gothic Book'; color: #cc0099">click here to make your default homepage</a><br />OR <a href="#" onclick='bookmarksite(&#039;DLEAS==@<%="http://" & Request.ServerVariables("SERVER_NAME") &  Request.ServerVariables("SCRIPT_NAME")%>&#039;, &#039;<%="http://" & Request.ServerVariables("SERVER_NAME") &  Request.ServerVariables("SCRIPT_NAME")%>&#039;)' style="text-align: center ;font-family:'Franklin Gothic Book';color:#cc0099">click here to bookmark&nbsp;</a></td>
						</tr>
						<tr>
							<td colspan="2">
								&nbsp;&nbsp;</td>
						</tr>
						<tr>
							<td colspan="2">
								<hr />
                            </td>
						</tr>
						<tr>
                            <td colspan="2" bgcolor="#f9f697">
                                <strong style="font-size: small; font-family:'Franklin Gothic Book';color: #000066;">Disclaimer :<br /> User ID and 
                                Password are Intended only for individual named. If you are not the name 
                                adresses you should not exchange or distributed your credential</strong></td>
                        </tr>
						<tr>
							<td colspan="2" bgcolor="#0066cc" style="margin-left: 80px">
                                <dx:ASPxLabel ID="lblError" runat="server" Font-Bold="True" 
                                    Font-Names="Book Antiqua" Font-Size="Small" ForeColor="Gold" 
                                    style="text-align: center; color: #FFFF00; background-color: #FF0000;" 
                                    Width="100%" Visible="False"></dx:ASPxLabel>
                            <ajaxToolkit:AnimationExtender ID="ajaxAEError" runat="server" TargetControlID="lblError">
                            <Animations>
                            <OnLoad>
                            <Sequence>
                            <Pulse Duration="0.2" Iterations="0" />
                            </Sequence>
                            </OnLoad>
                            </Animations>
                            </ajaxToolkit:AnimationExtender>
                            </td>
						</tr>
						<tr>
						<td colspan="2" bgcolor="#f9f697" ></td>
						</tr>
					</table>

		</asp:Panel>
		<ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCELogin" runat="server" TargetControlID="pnlLogin" VerticalOffset="1" VerticalSide="Middle" HorizontalSide="Center">
		</ajaxToolkit:AlwaysVisibleControlExtender>
		<asp:Panel id="pnlGHW" runat="server" 
		style="text-align: center; color:white; font-family:'Franklin Gothic Book'; font-weight: bold; border-top-style: inset; border-right-style: inset; border-left-style: inset; border-bottom-style: inset;" 
		BackColor="#00008B" Width="98%" BorderWidth="0px"><%=strCompany%></asp:Panel>
        <ajaxToolkit:RoundedCornersExtender ID="ajaxRCEGHW" runat="server" Enabled="False" 
        TargetControlID="pnlGHW">
        </ajaxToolkit:RoundedCornersExtender>
        <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEGHW" runat="server" HorizontalSide="Center" TargetControlID="pnlGHW" VerticalSide='Bottom'>
        </ajaxToolkit:AlwaysVisibleControlExtender>
	</form>
	<script  type="text/javascript" language="JavaScript" src="include/Login.js"></script>
<script type="text/javascript">
    self.defaultStatus = "Welcome to <%=strAppName%> ===><%=strCompany%>";
    function bookmarksite(title, url) {
        if (window.sidebar) // firefox
            window.sidebar.addPanel(title, url, "");
        else if (window.opera && window.print) { // opera
            var elem = document.createElement('a');
            elem.setAttribute('href', url);
            elem.setAttribute('title', title);
            elem.setAttribute('rel', 'sidebar');
            elem.click();
        }
        else if (document.all)// ie
            window.external.AddFavorite(url, title);
    }

    function getObjectbyClientID(ClientID) {
        var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        return (oObject)
    }
    function SetValueTxtByClientID(ClientID, sValue) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            oText.value = sValue;
    }
    var blnProcess = false;
    var blnLogin = false;
    function UserCheck() {
        blnProcess = false;
        var oUser = getObjectbyClientID("<%=txtUser.ClientID%>");
        var strStatus = "";
        ret = GHWService.UserCheck(oUser.value, OnCompleteUser, OnTimeOutUser, OnErrorUser);
        /*
        while(!blnProcess){
        //looping nunggu process complete
        }
        */
        return (blnLogin);

    }
    function OnCompleteUser(arg) {
        blnProcess = true;
        blnLogin = true;
        var oUser = getObjectbyClientID("<%=txtUser.ClientID%>");
        var UserInfo = arg.split('|');
        var IP = UserInfo[0];
        var TimeOut = UserInfo[1];
        if (IP != "") {
            if (confirm("User ID " + oUser.value + " already login, IP : " + IP + ", Time Out : " + TimeOut + "\n" + "Do you want to continue login..?") == false) {
                return (false);
                blnLogin = true;
            }
        }
        /*
        var oForm = document.getElementById ? document.getElementById("<%=LoginForm.ClientID%>") : document.forms["<%=LoginForm.ClientID%>"]; 
        oForm.method="POST";
        oForm.action="login.aspx?Action=Login";
        oForm.submit();
        
    }
    function OnTimeOutUser(arg) {
        alert("TimeOut encountered when calling Customer Info.");
    }
    function OnErrorUser(arg) {
        alert("Error encountered when calling Customer Info.");
    }
</script>

</body>
</html>
