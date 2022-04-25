<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ETJFDisplay.aspx.vb" Inherits="Account_ETJFDisplay" title="ET HJF Account Display" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<%@ Register src="../UserControl/DataAccountFromParamAccID.ascx" tagname="DataAccountFromParamAccID" tagprefix="uc2" %>
<%@ Register src="../UserControl/AccountJFbyACCIDJF.ascx" tagname="AccountJFbyACCIDJF" tagprefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
	<asp:Panel ID="pnlAccShow" runat="server" CssClass="ShowDetail" Width="99%">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgAccData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblAccData" runat="server" CssClass="required">(Show Account Data...)</asp:Label>
		</div>
		<input id="Button1" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
	<asp:HiddenField ID="txtLocID" runat="server" />
	<asp:HiddenField ID="txtAccID" runat="server" /><asp:HiddenField ID="txtAccIDJF" runat="server" />
	<asp:HiddenField ID="txtJFETID" runat="server" /><asp:HiddenField ID="txtAction" runat="server" /><asp:HiddenField ID="txtNextDueDateET" runat="server" />
	<asp:HiddenField ID="hidTxnDate" runat="server" />
	<asp:HiddenField ID="txtNextDueDateCust" runat="server" />
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
			<asp:Label ID="lblLoanData" runat="server" CssClass="required">(Show JF/Bank Loan Data...)</asp:Label>
		</div>
		<input id="Button5" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
	<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPELoanData" runat="server" CollapseControlID="pnlLoanShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show JF/Bank Loan Data...)" Enabled="True"
		ExpandControlID="pnlLoanShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide JF/Bank Loan Data...)"
		ImageControlID="imgLoanData" TargetControlID="pnlLoanData" 
        TextLabelID="lblLoanData">
	</ajaxToolkit:CollapsiblePanelExtender>
	<asp:Panel ID="pnlLoanData" runat="server"  Width="100%">
        <uc3:AccountJFbyACCIDJF ID="ctlAccountJFbyACCIDJF" runat="server" />
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
	<asp:Panel ID="pnlInstData" runat="server"  Width="100%">
        <asp:GridView ID="gvInstallment" runat="server" AutoGenerateColumns="False"
				Caption="JF(BANK) INSTALLMENT DUE DATA" DataSourceID="sdsInstallment" Width="100%">
            <Columns>
                <asp:BoundField DataField="JFPERIOD" HeaderText="Per" SortExpression="JFPERIOD">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="JFDUEDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="JF Due&lt;br&gt;Date"
						HtmlEncode="False" SortExpression="JFDUEDATE">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="JFPRINCIPAL" DataFormatString="{0:N}" HeaderText="JF&lt;BR&gt;Principal"
						HtmlEncode="False" SortExpression="JFPRINCIPAL">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="JFINTEREST" DataFormatString="{0:N}" HeaderText="JF&lt;BR&gt;Interest"
						HtmlEncode="False" SortExpression="JFINTEREST">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:CheckBoxField DataField="JFPAIDSTS" HeaderText="Paid&lt;br&gt;Sts" 
                        SortExpression="JFPAIDSTS">
                <ItemStyle HorizontalAlign="Center" />
                </asp:CheckBoxField>
                <asp:BoundField DataField="JFPRINCIPALPAID" DataFormatString="{0:N}" HeaderText="JF Principal&lt;BR&gt;Paid"
						HtmlEncode="False" SortExpression="JFPRINCIPALPAID">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="JFINTERESTPAID" DataFormatString="{0:N}" HeaderText="JF Interest&lt;BR&gt;Paid"
						HtmlEncode="False" SortExpression="JFINTERESTPAID">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="JFPAIDDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Paid&lt;br&gt;Date"
						HtmlEncode="False" SortExpression="JFPAIDDATE">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="JFPAIDTXNDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Paid&lt;br&gt;TxnDate"
						HtmlEncode="False" SortExpression="JFPAIDTXNDATE">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="JFPENALTY" DataFormatString="{0:N}" HeaderText="JF&lt;br&gt;Penalty"
						HtmlEncode="False" SortExpression="JFPENALTY">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="JFPENALTYPAID" DataFormatString="{0:N}" HeaderText="JF Penalty&lt;br&gt;Paid"
						HtmlEncode="False" SortExpression="JFPENALTYPAID">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="JFPENALTYWAIVE" DataFormatString="{0:N}" HeaderText="JF Penalty&lt;br&gt;Waive"
						HtmlEncode="False" SortExpression="JFPENALTYWAIVE">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
            </Columns>
            <EmptyDataTemplate>
                <uc1:nodatafound id="NoDataFound1" runat="server">
                </uc1:nodatafound>
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsInstallment" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
				
				
                
            SelectCommand="SELECT LOCID, ACCID, ACCIDJF, JFID, ACCOUNTNO, ACCOUNTNOFORM, BRANCHID, JFDUEDATE, JFPERIOD, JFPRINCIPAL, JFINTEREST, JFPAIDSTS, JFPRINCIPALPAID, JFINTERESTPAID, JFPAIDDATE, JFPAIDTXNDATE, JFPENALTYSTS, JFPENALTYREAL, JFPENALTY, JFPENALTYPAID, JFPENALTYWAIVE FROM dbo.f_AccInstalmentJFDueList(@ACCIDJF, @TXNDATE) AS f_AccInstalmentJFDueList_1 WHERE (JFDUEDATE &lt;= dbo.f_getAppDate()) ORDER BY JFPERIOD">
            <SelectParameters>
                <asp:Parameter Name="ACCIDJF" />
                <asp:Parameter Name="TXNDATE" />
            </SelectParameters>
        </asp:SqlDataSource>
	</asp:Panel>
	<table cellpadding="0" cellspacing="0" width="100%" id="tbET" style="font-weight: bold">
		<tr>
			<td colspan="4">
				<hr />
			</td>
		</tr>
		<tr>
			<td colspan="4">
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
			<td class="HeaderStyle" colspan="4">
				INSTALLMENT DUE <strong class="ErrHighLight" >*)JF Installment OverDue will be paid if Non 
                    Mirroring only</strong></td>
		</tr>
		<tr>
			<td colspan="2">
				Principal Due (q)</td>
			<td colspan="2">
				<asp:TextBox ID="txtPrincipalDue" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
		</tr>
		<tr>
			<td colspan="2">
				Interest Due (r)</td>
			<td colspan="2">
				<asp:TextBox ID="txtInterestDue" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
		</tr>
		<tr>
			<td colspan="2">
				Penalty Due (s)</td>
			<td colspan="2">
				<asp:TextBox ID="txtPenaltyDue" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
		</tr>
		<tr>
			<td colspan="2">
				Total Installment Due (z) = (q + r + s)</td>
			<td colspan="2">
				<asp:TextBox ID="txtInstallmentDue" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
		</tr>
		<tr>
			<td class="HeaderStyle" colspan="2">
				EARLY TERMINATION VALUE</td>
			<td class="HeaderStyle" colspan="1">
				ET Values</td>
			<td colspan="1" class="HeaderStyle">
				Waive Values</td>
		</tr>
		<tr>
			<td colspan="2">
				OS Principal (a)</td>
			<td>
				<asp:TextBox ID="txtOSPrincipal" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
			<td class="FooterStyle">
			</td>
		</tr>
		<tr>
			<td colspan="2">
				OS Interest</td>
			<td>
				<asp:TextBox ID="txtOSInterest" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
			<td class="FooterStyle">
			</td>
		</tr>
		<tr>
			<td colspan="2">
				ET Interest (i)</td>
			<td>
				<asp:TextBox ID="txtETInterest" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
			<td class="FooterStyle">
			</td>
		</tr>
		<tr>
			<td colspan="2">
				ET Penalty &nbsp;(p)</td>
			<td>
				<asp:TextBox ID="txtETPenalty" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
			<td class="FooterStyle">
				<asp:TextBox ID="txtETPenaltyWaive" runat="server" CssClass="required" Style="text-align: right"
					Width="120px" autocomplete="off"></asp:TextBox><asp:RequiredFieldValidator ID="reqPenaltyWaive" runat="server"
						ControlToValidate="txtETPenaltyWaive" Display="None" ErrorMessage="Penalty Waive must be entry...!"
						SetFocusOnError="True" ValidationGroup="ViewAcc"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender
							ID="ajaxVCEPenaltyWaive" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPenaltyWaive">
						</ajaxToolkit:ValidatorCalloutExtender>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				ET Admin (m)</td>
			<td>
				<asp:TextBox ID="txtETAdmin" runat="server" CssClass="disabled" ReadOnly="True" Style="text-align: right"
					Width="120px"></asp:TextBox></td>
			<td class="FooterStyle">
				<asp:TextBox ID="txtETAdminWaive" runat="server" CssClass="required" Style="text-align: right"
					Width="120px" autocomplete="off"></asp:TextBox><asp:RequiredFieldValidator ID="reqAdminWaive" runat="server"
						ControlToValidate="txtETAdminWaive" Display="None" ErrorMessage="Admin Waive must be entry...!"
						SetFocusOnError="True" ValidationGroup="ViewAcc"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
								ID="ajaxVCEAdminWaive" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAdminWaive">
							</ajaxToolkit:ValidatorCalloutExtender>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				Other Fee (o)</td>
			<td>
				<asp:TextBox ID="txtOtherFee" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
			<td class="FooterStyle">
			</td>
		</tr>
		<tr>
			<td colspan="4">
				<hr />
			</td>
		</tr>
		<tr>
			<td class="ErrHighLight" colspan="2">
				ET Value&nbsp; &nbsp;(v) = &nbsp;z + (a +i + p + m + o )</td>
			<td class="ErrHighLight">
				<asp:TextBox ID="txtETAmount" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
			<td class="ErrHighLight">
				<asp:TextBox ID="txtETAmountWaive" runat="server" CssClass="disabled" ReadOnly="True" Style="text-align: right"
					Width="120px"></asp:TextBox></td>
		</tr>
		<tr>
			<td colspan="4">
				<hr />
			</td>
		</tr>
	</table>
	<asp:Panel ID="pnlProcess" runat="server" CssClass="HeaderStyle" Width="100%">
				<asp:Button ID="btnWaive" runat="server" OnClientClick="return ProcessET();" Style="background-position: right;
					background-image: url(../Images/Save.gif); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Waive" Width="88px" ValidationGroup="ViewAcc" Visible="False" /><asp:Button ID="btnApprove" runat="server" OnClientClick="return ProcessET();" Style="background-position: right;
					background-image: url(../Images/ok.png); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Approve" Width="88px" ValidationGroup="ViewAcc" Visible="False" /><asp:Button ID="btnReject" runat="server" Style="background-position: right;
					background-image: url(../Images/stop.png); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Reject" Width="88px" ValidationGroup="ViewAcc" Visible="False" CausesValidation="False" /><asp:Button ID="btnCancel" runat="server" CausesValidation="False" Style="background-position: right;
					background-image: url(../Images/back.png); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Back" Width="88px" OnClientClick="return BackET();" /></asp:Panel>
	<ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEProcess" runat="server" TargetControlID="pnlProcess"
		VerticalSide="Bottom">
	</ajaxToolkit:AlwaysVisibleControlExtender>
	<asp:Panel ID="pnlPayment" runat="server" Visible="False" Width="100%" 
        GroupingText="Payment Process" Font-Bold="True" CssClass="RowStyle">
		<table cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td class="ShowDetail" colspan="2">
					TRANSACTION</td>
			</tr>
			<tr id="trBank">
				<td class="AlternatingRowStyle">
					Bank Account No.</td>
				<td class="AlternatingRowStyle">
					<asp:DropDownList ID="ddlAccountNo" runat="server" CssClass="required" DataSourceID="sdsAccountNo"
						DataTextField="ACCOUNTNO" DataValueField="ACCOUNTID">
					</asp:DropDownList><asp:RequiredFieldValidator ID="reqBankAccNo" runat="server" ControlToValidate="ddlAccountNo"
						Display="None" ErrorMessage="BANK ACCOUNT NO. must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><asp:SqlDataSource ID="sdsAccountNo" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
						SelectCommand="SELECT NULL AS ACCOUNTID, NULL AS BANKNAME, '[ACCOUNT NUMBER]' AS ACCOUNTNO UNION ALL SELECT BANKACCOUNT.ACCOUNTID, BANK.BANKNAME, BANK.BANKNAME + '-' + BANKACCOUNT.ACCOUNTNO AS ACCOUNTNO FROM BANKACCOUNT INNER JOIN BANK ON BANKACCOUNT.BANKID = BANK.BANKID WHERE (BANKACCOUNT.DELETESTS = 0) ORDER BY BANKNAME, ACCOUNTNO">
					</asp:SqlDataSource>
				<ajaxToolkit:ValidatorCalloutExtender
							ID="ajaxVCEBankAccNo" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBankAccNo">
						</ajaxToolkit:ValidatorCalloutExtender>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="AlternatingRowStyle">
					<hr />
				</td>
			</tr>
			<tr>
				<td class="HeaderStyle" colspan="2">
		<asp:Button ID="btnProcess" runat="server" OnClientClick="return ProcessETPay();" Style="background-position: right;
					background-image: url(../Images/Save.gif); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Process" Width="88px" ValidationGroup="ViewAcc" /><asp:Button ID="btnRejectPay" runat="server" Style="background-position: right;
					background-image: url(../Images/stop.png); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Reject" Width="88px" ValidationGroup="ViewAcc" CausesValidation="False" /><asp:Button ID="btnBackPay" runat="server" CausesValidation="False" Style="background-position: right;
					background-image: url(../Images/back.png); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Back" Width="88px" OnClientClick="return BackET();" /></td>
			</tr>
		</table>
	</asp:Panel>
	<ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEPayment" runat="server" TargetControlID="pnlPayment"
		VerticalSide="Bottom">
	</ajaxToolkit:AlwaysVisibleControlExtender>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript">
window.onload=function(){
	TabToEnter();
}
FormatTable("<%=gvInstallment.ClientID%>")
//FormatTable("tbET")
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
function CalcETWaive(){
	//FormatNumber(arg, 'True', 0);
	var ETAmount=toNumeric(GetValueTxtByClientID("<%=txtETAmount.ClientID%>"));
	var AdminWaive=toNumeric(GetValueTxtByClientID("<%=txtETAdminWaive.ClientID%>"));
	var PenaltyWaive=toNumeric(GetValueTxtByClientID("<%=txtETPenaltyWaive.ClientID%>"));
	var oETWaive=getObjectbyClientID("<%=txtETAmountWaive.ClientID%>");
	oETWaive.value=FormatNumber(ETAmount - AdminWaive - PenaltyWaive, 'True', 0);                
}
function CheckProcess(){
	var oPenaltyWaive=getObjectbyClientID("<%=txtETPenaltyWaive.ClientID%>");
	var Penalty=toNumeric(GetValueTxtByClientID("<%=txtETPenalty.ClientID%>"));
	if (toNumeric(oPenaltyWaive.value)>Penalty){
		alert("Penalty Waive is greater than original Admin Fee..!");
		oPenaltyWaive.className="ErrHighLight";
		oPenaltyWaive.focus();
		return false;
	}
	var oAdminWaive=getObjectbyClientID("<%=txtETAdminWaive.ClientID%>");
	var Admin=toNumeric(GetValueTxtByClientID("<%=txtETAdmin.ClientID%>"));
	if (toNumeric(oAdminWaive.value)>Admin){
		alert("Admin Fee Waive is greater than original Admin Fee..!");
		oAdminWaive.className="ErrHighLight";
		oAdminWaive.focus();
		return false;
	}
	return true;
}
function ProcessET(){
    if (Page_ClientValidate("")) {
        if (!CheckProcess()) return false;
    } else {return false;}
	return true;
}
function ProcessETPay(){
    if (Page_ClientValidate("")) {
        if (!CheckProcess()) return false;
        if (!CheckDate()) return false;
    } else {return false;}
	return true;
}
function BackET(){
	if ((GetValueTxtByClientID("<%=txtAction.ClientID%>")=="INQ") || (GetValueTxtByClientID("<%=txtAction.ClientID%>")=="PAY")){
		window.history.back(-1);
		return false;
	}
	return true;
}
function CheckDate(){
	var DateDateCust=GetValueTxtByClientID("<%=txtNextDueDateCust.ClientID%>");
	if (DateDateCust!=""){
		var DateET=GetValueTxtByClientID("<%=txtNextDueDateET.ClientID%>");
		if ((DateET==""))
			return false;
		if (ConvertToDate(DateDateCust)>ConvertToDate(DateET)){
			alert("Early termination values has changed..!\nPlease cancel this Early Termination and Input Again...!");
			return false;
		}
	}
	return true;
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
function JFInfo(JFID){
	var winref = window.open("../Account/JFInfo.aspx?JFID=" + JFID, "JFInfo", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable");
	winref.focus();
}
function ViewJFInst(ACCIDJF){
	var winref=window.open("../Account/JFInstallment.aspx?ACCIDJF=" + ACCIDJF,"JFInst", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable");
	winref.focus();
}
function ViewDetailAcc(LOCID, APPID){
   var winref=window.open("../Account/AccInqFrame.aspx?Action=AccInq&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
   winref.focus();
}


function PrintLoanJF(ACCIDJF) {
    var TXNDATE = GetValueTxtByClientID("<%=hidTxnDate.ClientID%>");
    var winref = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/InstallmentAccountJF&ACCIDJF=" + ACCIDJF + "&TXNDATE=" + TXNDATE, "PrintInstJF", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
    winref.focus();
    return false;
}
</script>
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
</asp:Content>

