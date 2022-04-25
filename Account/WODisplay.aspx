<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="WODisplay.aspx.vb" Inherits="Account_WODisplay" title="WO Account Diplay" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<%@ Register src="../UserControl/DataAccountFromParamAccID.ascx" tagname="DataAccountFromParamAccID" tagprefix="uc2" %>
<%@ Register src="../UserControl/LoanDataFromParamAccID.ascx" tagname="LoanDataFromParamAccID" tagprefix="uc3" %>
<%@ Register src="../UserControl/CollectibilityParamAccID.ascx" tagname="CollectibilityParamAccID" tagprefix="uc4" %>
<%@ Register src="../UserControl/InstallmentDataAll.ascx" tagname="InstallmentDataAll" tagprefix="uc5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
	<asp:Panel ID="pnlAccShow" runat="server" CssClass="ShowDetail" Width="99%">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgAccData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblAccData" runat="server" CssClass="required">(Show Account Data...)</asp:Label>
		</div>
		<input id="Button1" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
	<asp:HiddenField ID="txtLocID" runat="server" />
	<asp:HiddenField ID="txtAccID" runat="server" />
	<asp:HiddenField ID="txtWOID" runat="server" /><asp:HiddenField ID="txtAction" runat="server" />
	<asp:HiddenField ID="hidFincatID" runat="server" />
	<asp:Panel ID="pnlAccData" runat="server" Width="100%">
        <uc2:DataAccountFromParamAccID ID="ctlDataAccountFromParamAccID" 
            runat="server" />
	</asp:Panel>
	<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEAccData" runat="server" CollapseControlID="pnlAccShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Account Data...)" Enabled="True"
		ExpandControlID="pnlAccShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Account Data...)"
		ImageControlID="imgAccData" TargetControlID="pnlAccData" TextLabelID="lblAccData">
	</ajaxToolkit:CollapsiblePanelExtender>
	<asp:Panel ID="pnlLoanShow" runat="server" CssClass="ShowDetail" Width="99%">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgLoanData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblLoanData" runat="server" CssClass="required">(Show Loan Data...)</asp:Label>
		</div>
		<input id="Button5" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
	<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPELoanData" runat="server" CollapseControlID="pnlLoanShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Loan Data...)" Enabled="True"
		ExpandControlID="pnlLoanShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Loan Data...)"
		ImageControlID="imgLoanData" TargetControlID="pnlLoanData" TextLabelID="lblLoanData">
	</ajaxToolkit:CollapsiblePanelExtender>
	<asp:Panel ID="pnlLoanData" runat="server" Width="100%">
        <uc3:LoanDataFromParamAccID ID="ctlLoanDataFromParamAccID" runat="server" />
	    <uc4:CollectibilityParamAccID ID="ctlCollectibilityParamAccID" runat="server" />
	</asp:Panel>
	<asp:Panel ID="pnlInstShow" runat="server" CssClass="ShowDetail" Width="99%">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgInstData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblInstData" runat="server" CssClass="required">(Show Installment Data...)</asp:Label>
		</div>
		<input id="Button2" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
	<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEInst" runat="server" CollapseControlID="pnlInstShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Installment Data...)"
		Enabled="True" ExpandControlID="pnlInstShow" ExpandedImage="~/images/collapse.jpg"
		ExpandedText="(Hide Installment Data...)" ImageControlID="imgInstData" TargetControlID="pnlInstData"
		TextLabelID="lblInstData">
	</ajaxToolkit:CollapsiblePanelExtender>
	<asp:Panel ID="pnlInstData" runat="server"   Width="100%">
        <uc5:InstallmentDataAll ID="ctlInstallmentDataAll" runat="server" />
	</asp:Panel>
	<table cellpadding="0" cellspacing="0" width="100%" id="tbET">
		<tr>
			<td colspan="2" class="FooterStyle">
				<hr />
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" Font-Bold="True"
					Style="text-align: center" Visible="False" Width="100%"></asp:Label>
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
			<td class="ShowDetail" colspan="2" 
				style="font-weight: bold; text-align: center">
				WRITE OFF</td>
		</tr>
		<tr>
			<td class="RowStyle" colspan="2" style="font-weight: bold; text-align: left">
				WO Date:
				<asp:Label ID="lblWODate" runat="server" style="background-color: #FFFF00"></asp:Label>
			</td>
		</tr>
		<tr>
			<td class="RowStyle" colspan="2" style="font-weight: bold; text-align: left">
				WO Status: 
				<asp:Label ID="lblWOStatus" runat="server" style="background-color: #FFFF00"></asp:Label>
			</td>
		</tr>
		<tr>
			<td class="HeaderStyle" colspan="2">
				INSTALLMENT DUE</td>
		</tr>
		<tr>
			<td class="RowStyle">
				<asp:Label ID="lblPrincipalDue" runat="server"></asp:Label> Due (q)</td>
			<td class="AlternatingRowStyle">
				<asp:TextBox ID="txtPrincipalDue" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
		</tr>
		<tr>
			<td class="RowStyle">
				<asp:Label ID="lblInterestDue" runat="server"></asp:Label> Due (r)</td>
			<td class="AlternatingRowStyle">
				<asp:TextBox ID="txtInterestDue" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
		</tr>
		<tr>
			<td class="RowStyle">
				<asp:Label ID="lblPenaltyDue" runat="server"></asp:Label> Due (s)</td>
			<td class="AlternatingRowStyle">
				<asp:TextBox ID="txtPenaltyDue" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
		</tr>
		<tr>
			<td class="RowStyle">
				Total Installment Due (z) = (q + r + s)</td>
			<td class="AlternatingRowStyle">
				<asp:TextBox ID="txtInstallmentDue" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
		</tr>
		<tr>
			<td class="HeaderStyle" colspan="2">
				WRITE OFF VALUE</td>
		</tr>
		<tr>
			<td class="RowStyle">
				OS Principal</td>
			<td class="AlternatingRowStyle">
				<asp:TextBox ID="txtOSPrincipal" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
		</tr>
		<tr>
			<td class="RowStyle">
				OS Interest</td>
			<td class="AlternatingRowStyle">
				<asp:TextBox ID="txtOSInterest" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
		</tr>
		<tr>
			<td colspan="2" class="FooterStyle"><hr /></td>
		</tr>
		<tr>
			<td class="RowStyle">
				Remark</td>
			<td class="AlternatingRowStyle">
				<asp:TextBox ID="txtRemark" runat="server" Height="72px" MaxLength="150" TextMode="MultiLine"
					Width="224px"></asp:TextBox></td>
		</tr>
		<tr>
			<td colspan="2" class="FooterStyle">
				<hr />
			</td>
		</tr>
	</table>


	<asp:Panel ID="pnlProcess" runat="server" CssClass="HeaderStyle" Width="100%">
				<asp:Button ID="btnApprove" runat="server" OnClientClick="return ProcessWO();" Style="background-position: right;
					background-image: url(../Images/ok.png); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Approve" Width="88px" ValidationGroup="ViewAcc" Visible="False" /><asp:Button ID="btnReject" runat="server" Style="background-position: right;
					background-image: url(../Images/stop.png); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Reject" Width="88px" ValidationGroup="ViewAcc" Visible="False" CausesValidation="False" /><asp:Button ID="btnSave" runat="server" OnClientClick="return ProcessWO();" Style="background-position: right;
					background-image: url(../Images/Save.gif); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Save" Width="88px" ValidationGroup="ViewAcc" Visible="False" /><asp:Button ID="btnCancel" runat="server" CausesValidation="False" Style="background-position: right;
					background-image: url(../Images/back.png); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Back" Width="88px" OnClientClick="return BackWO();" />
				<asp:Button ID="btnPrint" runat="server" OnClientClick="return PrintData();" 
					Style="background-position: right; background-image: url(../Images/print.jpg); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
					Text="Print Data" Width="136px" />
	</asp:Panel>
	<ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEProcess" runat="server" TargetControlID="pnlProcess"
		VerticalSide="Bottom">
	</ajaxToolkit:AlwaysVisibleControlExtender>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript">
window.onload=function(){
	TabToEnter();
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
function GetValueTxtByClientID(ClientID){
	var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
	if (oText)
		return(oText.value);
}
function toNumeric(theValue){
	var ValX=parseFloat(FormatNumberClear(theValue));
	if (isNaN(ValX))
		ValX=0;
	return(ValX);
}
function CheckProcess(){

}

function ProcessWO(){
	if (Page_ClientValidate("")){
		if (!CheckProcess()) return false;
	}
	return true;
}
function BackWO(){
	window.history.back(-1);
	return false;
}
function ConvertToDate(dt){
	var arrDt=dt.split("/");
	if(arrDt.length==3){

		var sYear=arrDt[2];	
		var now = new Date();
		var year = now.getYear();
		var y=year.toString();
		y=y.substring(0,2);
		if (sYear.length<4){
			var nYear=parseFloat(sYear)
			if(nYear>=60){
				var dtDate=new Date(sYear, parseFloat(arrDt[1]) - 1, arrDt[0]);
			} else {
				sYear = y + sYear
				var dtDate=new Date(sYear, parseFloat(arrDt[1]) - 1, arrDt[0])
			}
		} else {
			var dtDate=new Date(sYear, parseFloat(arrDt[1]) - 1, arrDt[0])
		}

	}
	return dtDate;
}
function ViewDetailAcc(LOCID, APPID){
	var winref=window.open("../Account/AccInqFrame.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
	winref.focus();
}

function PrintData() {         
	var LOCID = GetValueTxtByClientID("<%=txtLocID.ClientID%>");
	var ACCID = GetValueTxtByClientID("<%=txtAccID.ClientID%>");
	var WOID = GetValueTxtByClientID("<%=txtWOID.ClientID%>");
	var winref = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/WO_Input&LOCID=" + LOCID + "&ACCID=" + ACCID + "&WOID=" + WOID, "WO_Input", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
	winref.focus();
	return false;
}

function ConvertDDMMYYYY(sDate) {
	var arrDate = sDate.split("/")
	return (arrDate[2] + "-" + arrDate[1] + "-" + arrDate[0]);

}


</script>


</asp:Content>

