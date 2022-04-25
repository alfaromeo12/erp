<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Logincauto.aspx.vb" Inherits="LoginX" %>
<%@ Register Assembly="BusyBoxDotNet" Namespace="BusyBoxDotNet" TagPrefix="busyboxdotnet" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<link rel="shortcut icon" href="images/app.ico">    
	<script  type="text/javascript" language="JavaScript" src="include/Login.js"></script>
<style>
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
</style>
</head>

<body  style="margin-left:0;margin-top:0;background-image: url(Images/activosp.png); background-repeat: repeat-y" >

	<form id="LoginForm" runat="server">
    <ajaxToolkit:ToolkitScriptManager ID="ajaxSMLogin" runat="server">
	<Services>
	<asp:ServiceReference Path="GHWService.asmx" />
	</Services>
    </ajaxToolkit:ToolkitScriptManager>

		<busyboxdotnet:BusyBox ID="BusyBoxLogin" runat="server" Image="GearsBig" 
		ShowBusyBox="OnLeavingPage" GZipCompression="true" />
		<asp:Panel ID="PanelBottom" runat="server" BorderStyle="Outset"
			Wrap="False" Width="98%" ForeColor="ActiveCaptionText" BackColor="DarkOrange" 
		style="font-weight: bold; border-top-style: outset; border-right-style: outset; border-left-style: outset; border-bottom-style: outset" 
		BorderWidth="0px">
			<%=strAppName%>&nbsp;</asp:Panel>
		<ajaxToolkit:AlwaysVisibleControlExtender ID="ajxAVCEPSAK" runat="server" HorizontalSide="Center" TargetControlID="PanelBottom" VerticalSide="Top">
		</ajaxToolkit:AlwaysVisibleControlExtender>
		<ajaxToolkit:DropShadowExtender ID="ajaxDSEPanelBottom" runat="server"  
        Enabled="True" TargetControlID="PanelBottom" Opacity="0.5" Rounded="True" 
        Width="7">
		</ajaxToolkit:DropShadowExtender>
		<ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCELogin" runat="server" HorizontalSide="Right"
			TargetControlID="pnlLogin" HorizontalOffset="20">
		</ajaxToolkit:AlwaysVisibleControlExtender>
		<br />
		<br />
		<asp:Panel ID="pnlLogin" runat="server" 
		style="border-top-style: ridge; border-right-style: ridge; border-left-style: ridge; border-bottom-style: ridge" 
		Width="500px" BackColor="#FF6600" BorderWidth="0px">
					<table cellspacing="0" style="width: 500px;" id="TABLE1" >
						<tr>
							<td bgcolor="#ff3333" colspan="2" style="border-left-color: fuchsia; border-bottom-color: fuchsia; border-top-style: outset; border-top-color: fuchsia; border-right-style: outset; border-left-style: outset; border-right-color: fuchsia; border-bottom-style: outset">
								<strong style="font-size: 15pt; font-family: 'Arial Black'">USER LOGIN</strong></td>
						</tr>
						<tr>
							<td bgcolor="#00cc00" style="text-align: right">
								 <asp:Label ID="lblUser" runat="server"  Text="User ID : " style="font-size: 10pt; font-family: 'Trebuchet MS'"></asp:Label></td>
							<td bgcolor="#00cc00">
								<asp:TextBox ID="txtUser" runat="server" Width="50%" CssClass="required" autocomplete="off"></asp:TextBox><asp:RequiredFieldValidator
									ID="ReqUserID" runat="server" ControlToValidate="txtUser" Display="None" ErrorMessage="User ID must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
								<ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCE" runat="server" TargetControlID="ReqUserID" HighlightCssClass="ErrHighLight">
								</ajaxToolkit:ValidatorCalloutExtender>
							</td>
						</tr>
						<tr>
							<td style="text-align: right;" bgcolor="#00cc00">
								<asp:Label ID="lblPass" runat="server" Text="Password : " style="font-size: 10pt; font-family: 'Trebuchet MS'"></asp:Label></td>
							<td bgcolor="#00cc00">
								<asp:TextBox ID="txtPass" runat="server" Font-Bold="False" TextMode="Password" Width="50%" CssClass="required"></asp:TextBox>
								<asp:RequiredFieldValidator ID="ReqPassword" runat="server" ControlToValidate="txtPass"
									Display="None" ErrorMessage="Password must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPassword" runat="server" TargetControlID="ReqPassword" HighlightCssClass="ErrHighLight">
									</ajaxToolkit:ValidatorCalloutExtender>
							</td>
						</tr>
						<tr>
							<td style="text-align: right;" bgcolor="#00cc00">
								<asp:Label ID="Label1" runat="server"  Text="Menu Style : " style="font-size: 10pt; font-family: 'Trebuchet MS'"></asp:Label></td>
							<td bgcolor="#00cc00">
								<asp:DropDownList ID="ddlMenu" runat="server">
									<asp:ListItem Value="0">Previous Menu Style</asp:ListItem>
									<asp:ListItem Value="1">Treeview Menu</asp:ListItem>
									<asp:ListItem Value="2">Slider Menu</asp:ListItem>
									<asp:ListItem Value="3">Dropdown Menu</asp:ListItem>
								</asp:DropDownList>
							</td>
						</tr>
						<tr>
							<td style="text-align: right;" bgcolor="#00cc00">
								<asp:Label ID="Label2" runat="server" Text="Available Theme : " style="font-size: 10pt; font-family: 'Trebuchet MS'"></asp:Label></td>
							<td bgcolor="#00cc00">
								<asp:DropDownList ID="ddlTheme" runat="server">
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
							<td bgcolor="#0066cc">
							</td>
							<td bgcolor="#0066cc">
								<asp:Button ID="btnLogin" runat="server" Text="Login" style="cursor: pointer; background-position: right; background-image: url(images/login.gif); background-repeat: no-repeat; text-align: left;" Width="30%" /></td>
						</tr>
						<tr>
							<td colspan="2" bgcolor="#0066cc"><asp:Label ID="lblError" runat="server" 
                                    Font-Bold="True" Font-Names="Book Antiqua" Font-Size="Small" ForeColor="Gold" 
                                    style="text-align: center; color: #FFFF00; background-color: #FF0000;" 
                                    Width="100%" Visible="False"></asp:Label>
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
							<td colspan="4" bgcolor="#0066cc">
								&nbsp;&nbsp;</tr>
						<tr>
							  <td colspan="2" style="height: 36px; text-align: center; border-left-color: maroon; border-bottom-color: maroon; border-top-style: inset; border-top-color: maroon; border-right-style: inset; border-left-style: inset; background-color: white; border-right-color: maroon; border-bottom-style: inset;">
									<a href="#" onclick="this.style.behavior='url(#default#homepage)';this.setHomePage('<%="http://" & Request.ServerVariables("SERVER_NAME") &  Request.ServerVariables("SCRIPT_NAME")%>');" style="font-size: 10pt; color: #cc0099">
										click here to make your default homepage</a>
									OR<br />
											<a href="#" onclick="bookmarksite('ACTIVOSPLUS==@<%="http://" & Request.ServerVariables("SERVER_NAME") &  Request.ServerVariables("SCRIPT_NAME")%>', '<%="http://" & Request.ServerVariables("SERVER_NAME") &  Request.ServerVariables("SCRIPT_NAME")%>')">
												
									click here to bookmark&nbsp;</a></td>
						</tr>
						<tr>
							<td colspan="2" style="height: 36px; text-align: right" bgcolor="#ffcc00">
								<strong>Disclaimer :<br />
									User ID and Password are Intended only for individual named. If you are not the
									name adressee you should not exchange or distributed your credential</strong></td>
						</tr>
					</table>
		</asp:Panel>
		<ajaxToolkit:RoundedCornersExtender ID="ajaxRCELogin" runat="server" Enabled="True" 
        TargetControlID="pnlLogin">
    </ajaxToolkit:RoundedCornersExtender>
		<ajaxToolkit:DropShadowExtender ID="ajaxDSELogin" runat="server" Enabled="True" 
		TargetControlID="pnlLogin" Opacity="0.5" Rounded="True" TrackPosition="True" 
        Width="7">
	</ajaxToolkit:DropShadowExtender>
		&nbsp;
<ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEGHW" runat="server" HorizontalSide="Center"
			TargetControlID="pnlGHW" VerticalSide=Bottom>
	</ajaxToolkit:AlwaysVisibleControlExtender>
		<asp:Panel ID="pnlLogo" runat="server" Height="162px" Style="background-repeat: no-repeat" Width="163px">
		</asp:Panel>
		<ajaxToolkit:RoundedCornersExtender ID="ajaxRCEGHW" runat="server" Enabled="True" TargetControlID="pnlGHW">
		</ajaxToolkit:RoundedCornersExtender>
		<ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCELogo" runat="server" HorizontalSide="Right" TargetControlID="pnlLogo" VerticalOffset="25">
		</ajaxToolkit:AlwaysVisibleControlExtender>
		<asp:Panel id="pnlGHW" runat="server" style="text-align: center; font-weight: bold; border-top-style: inset; border-right-style: inset; border-left-style: inset; border-bottom-style: inset;" 
		BackColor="GreenYellow" ForeColor="ActiveCaption" Width="98%" 
		Wrap="False" BorderWidth="0px">
			Copyright @GHWConsult - <%=strCompany%>
					</asp:Panel>
	</form>
</body>
<script type="text/javascript">
self.defaultStatus = "Welcome to <%=strAppName%> ===><%=strCompany%>";
function bookmarksite(title,url){
	if (window.sidebar) // firefox
		window.sidebar.addPanel(title, url, "");
	else if(window.opera && window.print){ // opera
		var elem = document.createElement('a');
		elem.setAttribute('href',url);
		elem.setAttribute('title',title);
		elem.setAttribute('rel','sidebar');
		elem.click();
	} 
	else if(document.all)// ie
		window.external.AddFavorite(url, title);
}
	
function getObjectbyClientID(ClientID){
	var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
	return(oObject)
}
function SetValueTxtByClientID(ClientID, sValue){
	var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
	if (oText)
		oText.value = sValue;
}
var blnProcess=false;
var blnLogin=false;
function UserCheck(){ 
	blnProcess=false;
	var oUser = getObjectbyClientID("<%=txtUser.ClientID%>");
	var strStatus="";
	ret = GHWService.UserCheck(oUser.value, OnCompleteUser, OnTimeOutUser, OnErrorUser);
	/*
	while(!blnProcess){
		//looping nunggu process complete
	}
	*/
	return(blnLogin);

}
function OnCompleteUser(arg) {
	blnProcess=true;
	blnLogin=true;
	var oUser = getObjectbyClientID("<%=txtUser.ClientID%>");
	var UserInfo=arg.split('|');
	var IP=UserInfo[0];
	var TimeOut=UserInfo[1];
	if (IP!=""){
		if(confirm("User ID " + oUser.value + " already login, IP : " + IP + ", Time Out : " + TimeOut + "\n" + "Do you want to continue login..?")==false){
			return(false);
			blnLogin=true;
		}
	}
	/*
	var oForm = document.getElementById ? document.getElementById("<%=LoginForm.ClientID%>") : document.forms["<%=LoginForm.ClientID%>"]; 
	oForm.method="POST";
	oForm.action="login.aspx?Action=Login";
	oForm.submit();
	*/
}
function OnTimeOutUser(arg) {
	alert("TimeOut encountered when calling Customer Info.");
}
function OnErrorUser(arg) {
	alert("Error encountered when calling Customer Info.");
}
</script>
</html>
