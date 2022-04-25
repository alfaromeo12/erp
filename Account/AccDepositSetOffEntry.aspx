<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccDepositSetOffEntry.aspx.vb" Inherits="Account_AccDepositSetOffEntry" title="Account Deposit Set Off Entry" MaintainScrollPositionOnPostback="true" EnableEventValidation="false"%>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<%@ Register src="../UserControl/DataAccountFromParamAccID.ascx" tagname="DataAccountFromParamAccID" tagprefix="uc2" %>
<%@ Register src="../UserControl/CollectibilityParamAccID.ascx" tagname="CollectibilityParamAccID" tagprefix="uc3" %>
<%@ Register src="../UserControl/InstallmentDataDue.ascx" tagname="InstallmentDataDue" tagprefix="uc4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
	<asp:HiddenField ID="txtAction" runat="server" />
	<asp:HiddenField ID="hidLocID" runat="server" />
	<asp:HiddenField ID="hidAccID" runat="server" />
	<uc2:DataAccountFromParamAccID ID="ctlDataAccountFromParamAccID" 
        runat="server" />
	<asp:Panel ID="pnlCollectShow" runat="server" CssClass="ShowDetail" Width="99%">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgCollect" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblCollect" runat="server" CssClass="required">(Show Collectibility Data...)</asp:Label>
		</div>
		<input id="Button3" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
	<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPECollect" runat="server" CollapseControlID="pnlCollectShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Collectibility Data...)"
		Enabled="True" ExpandControlID="pnlCollectShow" ExpandedImage="~/images/collapse.jpg"
		ExpandedText="(Hide Collectibility Data...)" ImageControlID="imgCollect" TargetControlID="pnlCollectData"
		TextLabelID="lblCollect">
	</ajaxToolkit:CollapsiblePanelExtender>
	<asp:Panel ID="pnlCollectData" runat="server" Width="100%">
		<uc3:CollectibilityParamAccID ID="ctlCollectibilityParamAccID" runat="server" />
	</asp:Panel>
	<asp:Panel ID="pnlInstShow" runat="server" CssClass="ShowDetail" Width="99%">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgInstData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblInstData" runat="server" CssClass="required">(Show Installment Due Data...)</asp:Label>
		</div>
		<input id="Button2" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
	<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEInst" runat="server" CollapseControlID="pnlInstShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Installment Due Data...)"
		Enabled="True" ExpandControlID="pnlInstShow" ExpandedImage="~/images/collapse.jpg"
		ExpandedText="(Hide Installment Due Data...)" ImageControlID="imgInstData" TargetControlID="pnlInstData"
		TextLabelID="lblInstData">
	</ajaxToolkit:CollapsiblePanelExtender>
	<asp:Panel ID="pnlInstData" runat="server" Width="100%">
        <uc4:InstallmentDataDue ID="ctlInstallmentDataDue" runat="server" />
	</asp:Panel>
	<table cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td class="HeaderStyle" colspan="4" style="text-align: center">
				ACCOUNT Deposit Set Off Value Entry</td>
		</tr>
		<tr>
			<td class="RowStyle" style="width: 203px">
				Deposit Value</td>
			<td class="AlternatingRowStyle" colspan="3">
				<asp:TextBox ID="txtDeposit" runat="server" CssClass="disabled" 
					Style="text-align: right" ReadOnly="True"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td class="RowStyle" style="width: 203px">
				Deposit Set Off</td>
			<td class="AlternatingRowStyle" colspan="3">
				<asp:TextBox ID="txtDepositSetOff" runat="server" CssClass="required" 
					Style="text-align: right"></asp:TextBox><asp:RequiredFieldValidator
					ID="reqDepositSetOff" runat="server" ControlToValidate="txtDepositSetOff" 
					Display="None" ErrorMessage="DEPOSIT SET OFF VALUE must be entry...!"
					SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
						ID="ajaxVCEPPAP" runat="server" HighlightCssClass="ErrHighLight" 
					TargetControlID="reqDepositSetOff">
					</ajaxToolkit:ValidatorCalloutExtender>
			</td>
		</tr>
		<tr>
			<td class="RowStyle" style="width: 203px">
				Deposit Remain</td>
			<td class="AlternatingRowStyle" colspan="3">
				<asp:TextBox ID="txtDepositRemain" runat="server" CssClass="disabled" 
					Style="text-align: right" ReadOnly="True"></asp:TextBox>
			</td>
		</tr>
		<tr>
				<td >
					Txn Type</td>
				<td colspan="3" >
					<asp:DropDownList ID="ddlTxnType" runat="server" CssClass="required" 
						DataSourceID="sdsTxnType" DataTextField="TXNTYPE" DataValueField="CODE">
					</asp:DropDownList><asp:SqlDataSource ID="sdsTxnType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
						
						
						
                        SelectCommand="SELECT NULL AS CODE, '[TXN TYPE]' AS TXNTYPE UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS TXNTYPE FROM PARAMGLOBAL WHERE (TYPE = 'TXNTYPE') AND (CODE IN (1, 2))">
					</asp:SqlDataSource>
					<asp:RequiredFieldValidator ID="reqPaymentType" runat="server"
						ControlToValidate="ddlTxnType" Display="None" ErrorMessage="PAYMENT TYPE must be entry...!"
						SetFocusOnError="True"></asp:RequiredFieldValidator>
					<ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPaymentType" runat="server" HighlightCssClass="ErrHighLight"
			TargetControlID="reqPaymentType">
						</ajaxToolkit:ValidatorCalloutExtender>
				</td>
			</tr>
		<tr id="trBank">
				<td >
					Bank Account No.</td>
				<td colspan="3" >
                        <asp:DropDownList ID="ddlAccountNo" runat="server">
                        </asp:DropDownList>
                        <ajaxToolkit:CascadingDropDown ID="ajaxCCDBankAcc" runat="server" 
                            BehaviorID="BehavBankAccNo" Category="BankAccNo" 
                            LoadingText="[Loading Bank Account ...]" PromptText="[BANK ACCOUNT NO.]" 
                            ServiceMethod="GetDropDownBankAccountByUIDAndFinCat" 
                            ServicePath="~\Param\WebService.asmx" TargetControlID="ddlAccountNo">
                        </ajaxToolkit:CascadingDropDown>
				</td>
			</tr>
		<tr>
			<td class="RowStyle" style="width: 203px">
				Remark</td>
			<td class="AlternatingRowStyle" colspan="3">
				<asp:TextBox ID="txtRemark" runat="server"  MaxLength="150" TextMode="MultiLine"
					Width="224px"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td style="width: 203px">
				&nbsp;&nbsp;</td>
			<td>
			</td>
			<td>
			</td>
			<td>
			</td>
		</tr>
		<tr>
			<td style="width: 203px">
				&nbsp;&nbsp;</td>
			<td>
			</td>
			<td>
			</td>
			<td>
			</td>
		</tr>
		<tr>
			<td style="width: 203px">
				&nbsp;&nbsp;</td>
			<td>
				&nbsp;</td>
			<td>
				&nbsp;</td>
			<td>
				&nbsp;</td>
		</tr>
		<tr>
			<td style="width: 203px">
				&nbsp;&nbsp;</td>
			<td>
				&nbsp;</td>
			<td>
				&nbsp;</td>
			<td>
				&nbsp;</td>
		</tr>
	</table>

	<asp:Panel ID="pnlSave" runat="server" CssClass="FooterStyle" Width="100%">
		<table cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td colspan="2">
					<hr />
				</td>
			</tr>
		</table>
		<asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" 
			Font-Bold="True" Font-Underline="True" Style="text-align: center" 
			Visible="False" Width="100%"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblMessage">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
		<asp:Button ID="btnSave" runat="server" Style="background-position: right; background-image: url(../Images/Save.gif);
			cursor: pointer; background-repeat: no-repeat;  text-align: left"
			Text="Save" Width="64px" onclientclick="return ProcessSave();" />
		<asp:Button ID="btnCancel" runat="server" CausesValidation="False" OnClientClick="return BackEdit();"
			Style="background-position: right; background-image: url(../Images/back.png);
			cursor: pointer; background-repeat: no-repeat;  text-align: left"
			Text="Back" Width="88px" /></asp:Panel>
	<ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEBorrow" runat="server" TargetControlID="pnlSave"
		VerticalSide="Bottom">
	</ajaxToolkit:AlwaysVisibleControlExtender>
	<script type="text/javascript">
		window.onload = function () { CalcRemain(); }
	function getObjectbyClientID(ClientID){
		var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
		return(oObject)
	}
	function GetValueTxtByClientID(ClientID){
		var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
		if (oText)
			return(oText.value);
	}
	
	function ViewDetailAcc(LOCID, APPID){
		var winref=window.open("AccInqFrame.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable")
		winref.focus();
	}
	function BackEdit(){
		window.location = "AccDepositSetOffInputList.aspx";
		return false;
	}
	function toNumeric(theValue) {
		var ValX = parseFloat(FormatNumberClear(theValue));
		if (isNaN(ValX))
			ValX = 0;
		return (ValX);
	}

	function CalcRemain() {
		var Deposit = toNumeric(GetValueTxtByClientID("<%=txtDeposit.ClientID%>"));
		var DepositSetOff = toNumeric(GetValueTxtByClientID("<%=txtDepositSetOff.ClientID%>"));
		var oRemain = getObjectbyClientID("<%=txtDepositREmain.ClientID%>");
		oRemain.value = FormatNumber(Deposit - DepositSetOff, 'True', 0);
}
	function ProcessSave() {
		if (Page_ClientValidate("")) {
			var oDepositSetOff = getObjectbyClientID("<%=txtDepositSetOff.ClientID%>");
			var DepositSetOff = toNumeric(GetValueTxtByClientID("<%=txtDepositSetOff.ClientID%>"));
			var Deposit = toNumeric(GetValueTxtByClientID("<%=txtDeposit.ClientID%>"));
			if (DepositSetOff == 0) {
				oDepositSetOff.className = "ErrHighLight";
				oDepositSetOff.focus();
				alert("Please Input non zero value...!");
				return (false);
			}
			if (DepositSetOff > Deposit) {
				oDepositSetOff.className = "ErrHighLight";
				oDepositSetOff.focus();
				alert("Deposit Set Off value must be less than or equal deposit existing value...!");
				return (false);
			}
			if (!CheckTxnType()) return false;
		}
		return true;
}

	function TxnTypeChange() {
		var TxnType = GetValueTxtByClientID("<%=ddlTxnType.ClientID%>");
		if (TxnType) {
			var oDiv = getObjectbyClientID("trBank");
			if (TxnType == "2") {
				oDiv.style.display = "";
			} else {
				var oAcc = getObjectbyClientID("<%=ddlAccountNo.ClientID%>");
				oAcc.value = "";
				oDiv.style.display = "none";
			}
		}
	}
	function CheckTxnType() {
		var TxnType = GetValueTxtByClientID("<%=ddlTxnType.ClientID%>");
		if (TxnType == "2") {
			var oAcc = getObjectbyClientID("<%=ddlAccountNo.ClientID%>");
			if (oAcc.value == "") {
				alert("[BANK ACCOUNT NO.] must be entry...!");
				oAcc.className = "ErrHighLight";
				oAcc.focus();
				return false;
			}

		}
		return true;
	}

	</script>
	
</asp:Content>

