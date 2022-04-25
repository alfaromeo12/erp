<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ETJFAccount.aspx.vb" Inherits="Acc_ETJF" title="ET JF Account (BuyBack)" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>

<%@ Register src="../UserControl/DataAccountFromParamAccID.ascx" tagname="DataAccountFromParamAccID" tagprefix="uc2" %>

<%@ Register src="../UserControl/AccountJFbyACCIDJF.ascx" tagname="AccountJFbyACCIDJF" tagprefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
	<asp:Panel ID="pnlAccountNo" runat="server" DefaultButton="btnView" Width="100%" style="border-bottom: thin solid"><table cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td colspan="4" class="ShowDetail">
				EARLY TERMINATION INPUT</td>
		</tr>
		<tr>
				<td class="RowStyle">
					Terminate Date</td>
				<td class="RowStyle">
					<asp:TextBox ID="txtValueDate" runat="server" CssClass="required" Width="72px"></asp:TextBox><asp:Image
						ID="imgValueDate" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer"
						ToolTip="Calendar" /><asp:RequiredFieldValidator ID="reqValuedAte" runat="server" ControlToValidate="txtValueDate"
						Display="None" ErrorMessage="VALUE DATE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEValueDate" runat="server" HighlightCssClass="ErrHighLight"
			TargetControlID="reqValuedAte">
						</ajaxToolkit:ValidatorCalloutExtender>
				<ajaxToolkit:CalendarExtender ID="ajaxCEValueDate" runat="server" Format="dd/MM/yyyy"
							PopupButtonID="imgValueDate" TargetControlID="txtValueDate">
						</ajaxToolkit:CalendarExtender>
					<ajaxToolkit:MaskedEditExtender ID="ajaxMEEValueDate" runat="server" Mask="99/99/9999" MaskType="Date"
						TargetControlID="txtValueDate">
					</ajaxToolkit:MaskedEditExtender>
					</td>
			<td class="RowStyle">
				Txn Date</td>
			<td class="RowStyle">
					<asp:TextBox ID="txtTxnDate" runat="server" Width="72px" CssClass="disabled" ReadOnly="True"></asp:TextBox></td>
		</tr>
		<tr>
			<td class="AlternatingRowStyle">
				Account No. (formated)</td>
			<td colspan="3" class="AlternatingRowStyle">
		<asp:TextBox ID="txtAccountNo" runat="server" CssClass="required" ValidationGroup="ViewAcc"></asp:TextBox><asp:Button ID="btnSearch" runat="server" CausesValidation="False" Style="background-position: right;
			background-image: url(../Images/search.gif); cursor: pointer; background-repeat: no-repeat;
			text-align: left" Text="Search JF Account" noenter OnClientClick="return SearchAccJF();" /><asp:RequiredFieldValidator ID="reqAccountNo" runat="server" ControlToValidate="txtAccountNo"
			Display="None" ErrorMessage="ACCOUNT NO must be entry...!" SetFocusOnError="True" ValidationGroup="ViewAcc"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEAccountNo" runat="server" HighlightCssClass="ErrHighLight"
			TargetControlID="reqAccountNo">
		</ajaxToolkit:ValidatorCalloutExtender>
			</td>
		</tr>
		<tr>
			<td colspan="4">
					<asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" Font-Bold="True" Style="text-align: center"
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
                        </td>
		</tr>
		<tr>
			<td class="FooterStyle" colspan="4">
		<asp:Button ID="btnView" runat="server" Style="background-position: right; background-image: url(../Images/view.png);
			cursor: pointer; background-repeat: no-repeat; text-align: left; " Text="View JF Account & JF Installment" noenter ValidationGroup="ViewAcc" />
				View Account Data, JF Loan Data and JF Installment base on Terminate Date</td>
		</tr>
	</table>
	</asp:Panel>
	<asp:Panel ID="pnlPayment" runat="server" Width="100%" Visible="False" >
		<asp:Panel ID="pnlAccShow" runat="server" CssClass="ShowDetail" Width="99%">
			<div style="float: right; vertical-align: middle">
				<asp:Image ID="imgAccData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
				<asp:Label ID="lblAccData" runat="server" CssClass="required">(Show Account Data...)</asp:Label>
			</div>
			<input id="Button1" noenter="" style="background-position: left top; width: 24px;
				cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
		<asp:HiddenField ID="txtLocID" runat="server" />
		<asp:HiddenField ID="txtAccID" runat="server" /><asp:HiddenField ID="txtAccIDJF" runat="server" />
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
		<asp:Panel ID="pnlInstData" runat="server" Width="100%">
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
		<table cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td colspan="2" class="required">
					<hr />
				</td>
			</tr>
			<tr>
				<td class="HeaderStyle" colspan="2">
					JF INSTALLMENT DUE&nbsp; <strong class="ErrHighLight">*)JF Installment OverDue 
                    will be paid if Non Mirroring only</strong></td>
			</tr>
			<tr>
				<td class="RowStyle">
					Principal Due (q)</td>
				<td class="AlternatingRowStyle">
					<asp:TextBox ID="txtPrincipalDue" runat="server" CssClass="disabled" Style="text-align: right"
						Width="120px" ReadOnly="True"></asp:TextBox></td>
			</tr>
			<tr>
				<td class="RowStyle">
					Interest Due (r)</td>
				<td class="AlternatingRowStyle">
					<asp:TextBox ID="txtInterestDue" runat="server" CssClass="disabled" Style="text-align: right"
						Width="120px" ReadOnly="True"></asp:TextBox></td>
			</tr>
			<tr>
				<td class="RowStyle">
					Penalty Due (s)</td>
				<td class="AlternatingRowStyle">
					<asp:TextBox ID="txtPenaltyDue" runat="server" CssClass="disabled" Style="text-align: right"
						Width="120px" ReadOnly="True"></asp:TextBox></td>
			</tr>
			<tr>
				<td class="ErrHighLight">
					Total Installment Due (z) = (q + r + s)</td>
				<td class="ErrHighLight">
					<asp:TextBox ID="txtInstallmentDue" runat="server" CssClass="disabled" Style="text-align: right"
						Width="120px" ReadOnly="True"></asp:TextBox></td>
			</tr>
			<tr>
				<td class="HeaderStyle" colspan="2">
					JF EARLY TERMINATION (BUY BACK) VALUE</td>
			</tr>
			<tr>
				<td class="RowStyle">
					OS Principal (a)</td>
				<td class="AlternatingRowStyle">
					<asp:TextBox ID="txtOSPrincipal" runat="server" CssClass="disabled" Style="text-align: right"
						Width="120px" ReadOnly="True"></asp:TextBox></td>
			</tr>
			<tr id="trBank">
				<td class="RowStyle">
					OS Interest</td>
				<td class="AlternatingRowStyle">
					<asp:TextBox ID="txtOSInterest" runat="server" CssClass="disabled" Style="text-align: right"
						Width="120px" ReadOnly="True"></asp:TextBox></td>
			</tr>
			<tr>
				<td class="RowStyle">
					ET Interest (i)</td>
				<td class="AlternatingRowStyle">
					<asp:TextBox ID="txtETInterest" runat="server" CssClass="disabled" Style="text-align: right"
						Width="120px" ReadOnly="True"></asp:TextBox></td>
			</tr>
			<tr>
				<td class="RowStyle">
					ET Penalty &nbsp;(p)</td>
				<td class="AlternatingRowStyle">
					<asp:TextBox ID="txtETPenalty" runat="server" CssClass="disabled" Style="text-align: right"
						Width="120px" ReadOnly="True"></asp:TextBox></td>
			</tr>
			<tr>
				<td class="RowStyle">
					ET Admin (m)</td>
				<td class="AlternatingRowStyle">
					<asp:TextBox ID="txtETAdmin" runat="server" CssClass="disabled" ReadOnly="True" Style="text-align: right"
						Width="120px"></asp:TextBox></td>
			</tr>
			<tr>
				<td class="RowStyle">
					Other Fee (o)</td>
				<td class="AlternatingRowStyle">
					<asp:TextBox ID="txtOtherFee" runat="server" CssClass="required" Style="text-align: right"
						Width="120px"></asp:TextBox><asp:RequiredFieldValidator ID="reqOtherFee" runat="server"
							ControlToValidate="txtOtherFee" Display="None" ErrorMessage="Other Fee must be entry...!"
							SetFocusOnError="True" ValidationGroup="ViewAcc"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
								ID="ajaxVCEOtherFee" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqOtherFee">
							</ajaxToolkit:ValidatorCalloutExtender>
				</td>
			</tr>
			<tr>
				<td class="ErrHighLight">
					ET Value&nbsp; &nbsp;(v) = &nbsp;z + (a + i + p + m + o )</td>
				<td class="ErrHighLight">
					<asp:TextBox ID="txtETAmount" runat="server" CssClass="disabled" Style="text-align: right"
						Width="120px" ReadOnly="True"></asp:TextBox>
					<asp:HiddenField ID="txtETAmountOri" runat="server" />
				</td>
			</tr>
			<tr>
				<td colspan="2" class="required">
					<hr />
				</td>
			</tr>
			<tr>
				<td class="RowStyle">
					Description</td>
				<td class="AlternatingRowStyle">
					<asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine"
						Width="240px" Height="72px"></asp:TextBox>
				</td>
			</tr>
			<tr>
				<td class="HeaderStyle" colspan="3">
					<asp:Button ID="btnProcess" runat="server" Style="background-position: right; background-image: url(../Images/Save.gif);
						cursor: pointer; background-repeat: no-repeat; text-align: left; " Text="Process"
						Width="88px" OnClientClick="return ProcessPay();" />
					<asp:Button ID="btnCancel" runat="server" CausesValidation="False" Style="background-position: right;
						background-image: url(../Images/cancel.gif); cursor: pointer; background-repeat: no-repeat;
						text-align: left; " Text="Cancel" Width="88px" />
                    <asp:Button ID="btnPrint" runat="server" OnClientClick="return PrintData();" 
						Style="background-position: right; background-image: url(../Images/print.jpg); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
						Text="Print Data" Width="136px" /></td>
			</tr>
		</table>
	</asp:Panel>
	
	
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvInstallment.ClientID%>");
window.onload = function () {
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
function SetAccJF(LOCID, ACCID, ACCIDJF, ACCNO){
	SetValueTxtByClientID("<%=txtLocID.ClientID%>", LOCID);
	SetValueTxtByClientID("<%=txtAccID.ClientID%>", ACCID);
	SetValueTxtByClientID("<%=txtAccIDJF.ClientID%>", ACCIDJF);
	SetValueTxtByClientID("<%=txtAccountNo.ClientID%>", ACCNO);
	var btn = getObjectbyClientID("<%=btnView.ClientID%>")
	if (btn) 
		btn.click();
}
function SearchAccJF(){
	var winref=window.open("../Pay/SearchAccJFPay.aspx?Action=Find","AccFind", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes")
	winref.focus();
	return false;
}
function toNumeric(theValue){
	var ValX=parseFloat(FormatNumberClear(theValue));
	if (isNaN(ValX))
		ValX=0;
	return(ValX);
}
function CheckValueDate(){
	var ApplDate="<%=strAppDate%>";
	if (ApplDate!=""){
		var oValueDate=getObjectbyClientID("<%=txtValueDate.ClientID%>");
		var ValueDate=GetValueTxtByClientID("<%=txtValueDate.ClientID%>");
		if (ValueDate=="")
			return false;
		if (!(ValueDate=="")){
			if (ConvertToDate(ValueDate)>ConvertToDate(ApplDate)){
				alert("Value Date cannot be future date...!");
				oValueDate.className="ErrHighLight";
				oValueDate.focus();
				return false;
			}
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

function ValueDateChange(){
    var oDiv = getObjectbyClientID("<%=pnlPayment.ClientID%>");
    if (oDiv)
	    oDiv.style.display = "none";
}
function ProcessPay(){
	if (Page_ClientValidate("")){
		if (!CheckValueDate()) return false;
	}
	return true;
}
function OtherFeeChange(){
	var ETAmountOri=toNumeric(GetValueTxtByClientID("<%=txtETAmountOri.ClientID%>"));
	var OtherFee=toNumeric(GetValueTxtByClientID("<%=txtOtherFee.ClientID%>"));
	var oETAmount=getObjectbyClientID("<%=txtETAmount.ClientID%>");
	oETAmount.value=FormatNumber(ETAmountOri + OtherFee, 'True', 0);
}
function JFInfo(JFID){
	var winref=window.open("../Account/JFInfo.aspx?JFID=" + JFID,"JFInfo", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable");
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

function ConvertDDMMYYYY(sDate) {
    var arrDate = sDate.split("/")
    return (arrDate[2] + "-" + arrDate[1] + "-" + arrDate[0]);
}


function PrintData() {
    var VALUEDATE = ConvertDDMMYYYY(GetValueTxtByClientID("<%=txtValueDate.ClientID%>"));
    var ACCIDJF = GetValueTxtByClientID("<%=txtAccIDJF.ClientID%>");
    var OTHERFEE = GetValueTxtByClientID("<%=txtOtherFee.ClientID%>");
    if (Page_ClientValidate("")) {
        var winref = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/ETJFAccountInquiry&VALUEDATE=" + VALUEDATE + "&ACCIDJF=" + ACCIDJF + "&OTHERFEE=" + OTHERFEE, "ETJFInquiry", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
        winref.focus();
    }
    return false;
}
function PrintLoanJF(ACCIDJF) {
    var TXNDATE = ConvertDDMMYYYY(GetValueTxtByClientID("<%=txtValueDate.ClientID%>"));
    var winref = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/InstallmentAccountJF&ACCIDJF=" + ACCIDJF + "&TXNDATE=" + TXNDATE, "PrintInstJF", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
    winref.focus();
    return false;
}
window.history.forward();
</script>

</asp:Content>

