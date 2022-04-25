<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UserLoginSPV.aspx.vb" Inherits="Home_UserLoginSPV" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>SUPERVISOR AUTHORIZE</title>
	<style type="text/css">
		#btnCancel
		{
			width: 58px;
		}


	</style>

</head>
<body class="modalBackground">
	<form id="form1" runat="server">
    <ajaxToolkit:ToolkitScriptManager ID="SMSPVAuthor" runat="server">
		<Services>
			<asp:ServiceReference Path="~/FrontEnd/GHWService.asmx" />
		</Services>
    </ajaxToolkit:ToolkitScriptManager>

<div class="title" style="font-weight: bolder">SUPERVISOR AUTHORIZE</div>
	<asp:Panel ID="pnlUserSPV" runat="server" CssClass="modalPopup">
		<table style="width:100%;" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					&nbsp;</td>
				<td>
					&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2">
					<hr />
				</td>
			</tr>
			<tr>
				<td class="RowStyle">
					User ID</td>
				<td class="RowStyle">
					<asp:TextBox ID="txtUser" runat="server" CssClass="required"></asp:TextBox>
					<asp:RequiredFieldValidator ID="ReqUserID" runat="server" 
						ControlToValidate="txtUser" Display="None" 
						ErrorMessage="User ID must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
					<ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCE" runat="server" 
						HighlightCssClass="ErrHighLight" TargetControlID="ReqUserID">
					</ajaxToolkit:ValidatorCalloutExtender>
				</td>
			</tr>
			<tr>
				<td class="AlternatingRowStyle">
					Password</td>
				<td class="AlternatingRowStyle">
					<asp:TextBox ID="txtPassword" runat="server" CssClass="required" 
						TextMode="Password"></asp:TextBox>
					<asp:RequiredFieldValidator ID="ReqPassword" runat="server" 
						ControlToValidate="txtPassword" Display="None" 
						ErrorMessage="Password must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
					<ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPassword" runat="server" 
						HighlightCssClass="ErrHighLight" TargetControlID="ReqPassword">
					</ajaxToolkit:ValidatorCalloutExtender>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<hr />
				</td>
			</tr>
			<tr>
				<td class="ShowDetail" colspan="2">
					<asp:Button ID="btnOK" runat="server" onclientclick="OK();return(false);" 
						Text="OK" style="cursor:pointer;" />
					<asp:Button ID="btnCancel" runat="server" CausesValidation="False" 
						onclientclick="Cancel();return(false);" Text="Cancel" style="cursor:pointer;"/>
				</td>
			</tr>
		</table>
	</asp:Panel>
	
	<ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEUserSPV" runat="server" 
			TargetControlID="pnlUserSPV" HorizontalSide="Center" VerticalSide="Middle">
	</ajaxToolkit:AlwaysVisibleControlExtender>
	</form>
	<script type="text/javascript">
		function GetValueTxtByClientID(ClientID) {
			var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
			if (oText)
				return (oText.value);
		}
		var RetVal = new Object();
		RetVal.Login = 0;
		window.returnValue = RetVal;
		function OK() {
			if (Page_ClientValidate("")) {
				var UserID = GetValueTxtByClientID("<%=txtUser.ClientID%>");
				var Password = GetValueTxtByClientID("<%=txtPassword.ClientID%>");
				CheckLogin(UserID, Password)
			}
		}
		function Cancel() {
			RetVal.Login = 0;
			window.returnValue = RetVal;
			window.close();
		}

	function CheckLogin(UserID, Password) {
		ret = GHWService.VerifyUserSPV(UserID, Password, OnCompleteUser, OnTimeOutUser, OnErrorUser);
	}
	function OnCompleteUser(arg) {
		if (arg == 1) {
			RetVal.Login = 1;
			window.returnValue = RetVal;
			window.close();
		} else {
			alert("Invalid User ID/Password Or User not supervisor...!")
		}
	}
	function OnTimeOutUser(arg) {
		alert("TimeOut encountered when verify User Supervisor");
	}
	function OnErrorUser(arg) {
		alert("Error encountered when verify User Supervisor");
	}

	</script>
</body>
</html>
