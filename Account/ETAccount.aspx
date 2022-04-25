<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ETAccount.aspx.vb" Inherits="Acc_ET" title="ET Account" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>

<%@ Register src="../UserControl/DataAccountFromParamAccID.ascx" tagname="DataAccountFromParamAccID" tagprefix="uc2" %>
<%@ Register src="../UserControl/LoanDataFromParamAccID.ascx" tagname="LoanDataFromParamAccID" tagprefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Panel ID="pnlAccountNo" runat="server" DefaultButton="btnView" Width="100%" CssClass="AlternatingRowStyle"><table cellpadding="0" cellspacing="0" width="100%">
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
			<td class="RowStyle">
				Account No. (formated)</td>
			<td colspan="3" class="RowStyle">
		<asp:TextBox ID="txtAccountNo" runat="server" CssClass="required" ValidationGroup="ViewAcc"></asp:TextBox><asp:Button ID="btnSearch" runat="server" CausesValidation="False" Style="background-position: right;
			background-image: url(../Images/search.gif); cursor: pointer; background-repeat: no-repeat;
			text-align: left" Text="Search Account" noenter OnClientClick="return SearchAcc();" /><asp:RequiredFieldValidator ID="reqAccountNo" runat="server" ControlToValidate="txtAccountNo"
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
			cursor: pointer; background-repeat: no-repeat; text-align: left; " Text="View Account & Installment" noenter ValidationGroup="ViewAcc" />
				View Account Data, Loan Data and Installment base on Terminate Date</td>
		</tr>
	</table>
	</asp:Panel>
	<asp:Panel ID="pnlPayment" runat="server" Width="100%" Visible="False">
		<asp:Panel ID="pnlAccShow" runat="server" CssClass="ShowDetail" Width="99%">
			<div style="float: right; vertical-align: middle">
				<asp:Image ID="imgAccData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
				<asp:Label ID="lblAccData" runat="server" CssClass="required">(Show Account Data...)</asp:Label>
			</div>
			<input id="Button1" noenter="" style="background-position: left top; width: 24px;
				cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
		<asp:HiddenField ID="txtLocID" runat="server" />
		<asp:HiddenField ID="txtAccID" runat="server" />
		<asp:HiddenField ID="hidFINCATID" runat="server" />
		<asp:HiddenField ID="hidBookingDate" runat="server" />
		<asp:HiddenField ID="hidETCALC" runat="server" />
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
			<asp:GridView ID="gvInstallment" runat="server" 
                AutoGenerateColumns="False" Caption="INSTALLMENT DUE DATA" 
                DataSourceID="sdsInstallment" Width="100%">
                <Columns>
                    <asp:BoundField DataField="PERIOD" HeaderText="Per" SortExpression="PERIOD">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DUEDATE" DataFormatString="{0:dd/MM/yyyy}" 
                        HeaderText="Due&lt;br&gt;Date" HtmlEncode="False" SortExpression="DUEDATE">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Principal" SortExpression="PRINCIPAL">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" 
                                Text='<%# Eval("PRINCIPAL", Eval("DECPOINT")) %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Interest" SortExpression="INTEREST">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" 
                                Text='<%# eval("INTEREST", Eval("DECPOINT")) %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Principal&lt;BR&gt;Paid" 
                        SortExpression="PRINCIPALPAID">
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" 
                                Text='<%# eval("PRINCIPALPAID", Eval("DECPOINT")) %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Interest&lt;BR&gt;Paid" 
                        SortExpression="INTERESTPAID">
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" 
                                Text='<%# eval("INTERESTPAID", Eval("DECPOINT")) %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Principal&lt;br&gt;Waive" 
                        SortExpression="PRINCIPALWAIVE">
                        <ItemTemplate>
                            <asp:Label ID="Label9" runat="server" 
                                Text='<%# eval("PRINCIPALWAIVE", Eval("DECPOINT")) %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Interest&lt;br&gt;Waive" 
                        SortExpression="INTERESTWAIVE">
                        <ItemTemplate>
                            <asp:Label ID="Label10" runat="server" 
                                Text='<%# eval("INTERESTWAIVE", Eval("DECPOINT")) %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="PENALTYDAY" HeaderText="Due&lt;BR&gt;Days" 
                        HtmlEncode="False" SortExpression="PENALTYDAY">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Penalty" SortExpression="PENALTY">
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" 
                                Text='<%# eval("PENALTY", Eval("DECPOINT")) %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Penalty&lt;br&gt;Paid" 
                        SortExpression="PENALTYPAID">
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" 
                                Text='<%# eval("PENALTYPAID", Eval("DECPOINT")) %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Penalty&lt;br&gt;Waive" 
                        SortExpression="PENALTYWAIVE">
                        <ItemTemplate>
                            <asp:Label ID="Label7" runat="server" 
                                Text='<%# eval("PENALTYWAIVE", Eval("DECPOINT")) %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Inst&lt;br&gt;Diff" SortExpression="INSDIFF">
                        <ItemTemplate>
                            <asp:Label ID="Label8" runat="server" 
                                Text='<%# eval("INSDIFF", Eval("DECPOINT")) %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <uc1:NoDataFound ID="NoDataFound1" runat="server" />
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsInstallment" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                
                SelectCommand="SELECT LOCID, ACCID, ACCOUNTNO, ACCOUNTNOFORM, BRANCHID, DUEDATE, PERIOD, PRINCIPAL, INTEREST, PAIDSTS, PRINCIPALPAID, INTERESTPAID, PAIDDATE, PAIDTXNDATE, PENALTYDAY, PENALTYSTS, PENALTYREAL, PENALTY, PENALTYPAID, PENALTYWAIVE, FINCATID, BOOKINGDATE, PRINCIPALWAIVE, INTERESTWAIVE, dbo.f_getCurrencyDecPointForNet(CURRENCYID) AS DECPOINT, INSTDIFF - INSTDIFFPAID - INSTDIFFWAIVE AS INSDIFF FROM dbo.f_AccInstalmentDueList(@LOCID, @ACCID, @TXNDATE) AS f_AccInstalmentDueList_1 WHERE (DUEDATE &lt;= dbo.f_getAppDate()) ORDER BY PERIOD">
                <SelectParameters>
                    <asp:Parameter Name="LOCID" />
                    <asp:Parameter Name="ACCID" />
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
				<td class="ShowDetail" colspan="2" style="text-align: center">
					EARLY TERMINATION</td>
			</tr>
			<tr>
				<td class="HeaderStyle" colspan="2">
					INSTALLMENT DUE UNTIL
					<asp:Label ID="lblDueUntil" runat="server"></asp:Label>
				</td>
			</tr>
			<tr>
				<td class="RowStyle">
					<asp:Label ID="lblPrincipal" runat="server"></asp:Label>
                    &nbsp;Due (q)</td>
				<td class="AlternatingRowStyle">
					<asp:TextBox ID="txtPrincipalDue" runat="server" CssClass="disabled" Style="text-align: right"
						Width="120px" ReadOnly="True"></asp:TextBox></td>
			</tr>
			<tr>
				<td class="RowStyle">
					<asp:Label ID="lblInterest" runat="server"></asp:Label>
                    &nbsp;Due (r)</td>
				<td class="AlternatingRowStyle">
					<asp:TextBox ID="txtInterestDue" runat="server" CssClass="disabled" Style="text-align: right"
						Width="120px" ReadOnly="True"></asp:TextBox></td>
			</tr>
			<tr>
				<td class="RowStyle">
					Installment Difference (f)</td>
				<td class="AlternatingRowStyle">
					<asp:TextBox ID="txtInstDiff" runat="server" CssClass="disabled" 
                        ReadOnly="True" Style="text-align: right" Width="120px"></asp:TextBox>
                </td>
			</tr>
			<tr>
                <td class="RowStyle">
                    <asp:Label ID="lblPenalty" runat="server"></asp:Label>
                    &nbsp;Due (s)</td>
                <td class="AlternatingRowStyle">
                    <asp:TextBox ID="txtPenaltyDue" runat="server" CssClass="disabled" 
                        ReadOnly="True" Style="text-align: right" Width="120px"></asp:TextBox>
                </td>
            </tr>
			<tr>
				<td class="ErrHighLight">
					Total Installment Due (z) = (q + r + s + f)</td>
				<td class="ErrHighLight">
					<asp:TextBox ID="txtInstallmentDue" runat="server" CssClass="disabled" Style="text-align: right"
						Width="120px" ReadOnly="True"></asp:TextBox></td>
			</tr>
			<tr>
				<td class="HeaderStyle" colspan="2">
					EARLY TERMINATION VALUE</td>
			</tr>
			<tr>
				<td class="RowStyle">
					OS
                    <asp:Label ID="lblOSPrincipal" runat="server"></asp:Label>
                    &nbsp;Until
					<asp:Label ID="lblOSPrincipalUntil" runat="server"></asp:Label>
					(a)</td>
				<td class="AlternatingRowStyle">
					<asp:TextBox ID="txtOSPrincipal" runat="server" CssClass="disabled" Style="text-align: right"
						Width="120px" ReadOnly="True"></asp:TextBox></td>
			</tr>
			<tr id="trBank">
				<td class="RowStyle">
					OS
                    <asp:Label ID="lblOSInterest" runat="server"></asp:Label>
                    &nbsp;Until
					<asp:Label ID="lblOSInterestUntil" runat="server"></asp:Label>
				    &nbsp;<asp:Label ID="lblCalcType2" runat="server" Text="(i)" Visible="False"></asp:Label>
				</td>
				<td class="AlternatingRowStyle">
					<asp:TextBox ID="txtOSInterest" runat="server" CssClass="disabled" Style="text-align: right"
						Width="120px" ReadOnly="True"></asp:TextBox></td>
			</tr>
			<tr>
				<td class="RowStyle">
					ET
                    <asp:Label ID="lblETInterest" runat="server"></asp:Label>
                    &nbsp;<asp:Label ID="lblCalcType1" runat="server" Text="(i)" Visible="False"></asp:Label>
                </td>
				<td class="AlternatingRowStyle">
					<asp:TextBox ID="txtETInterest" runat="server" CssClass="disabled" Style="text-align: right"
						Width="120px" ReadOnly="True"></asp:TextBox></td>
			</tr>
			<tr>
				<td class="RowStyle">
					ET
                    <asp:Label ID="lblETPenalty" runat="server"></asp:Label>
                    &nbsp;(p)</td>
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
				<td class="RowStyle">
					Deposit Account (d)</td>
				<td class="AlternatingRowStyle">
					<asp:TextBox ID="txtDeposit" runat="server" CssClass="disabled" Style="text-align: right"
						Width="120px" ReadOnly="True"></asp:TextBox></td>
			</tr>
			<tr>
				<td class="ErrHighLight">
					ET Value&nbsp; &nbsp;(v) = &nbsp;z + (a + i + p + m + o - d)</td>
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
				<td style="height: 24px" class="AlternatingRowStyle">
					<asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine"
						Width="240px" Height="72px"></asp:TextBox>
				</td>
			</tr>
			<tr>
				<td class="HeaderStyle" colspan="2">
					<asp:Button ID="btnProcess" runat="server" Style="background-position: right; background-image: url(../Images/Save.gif);
						cursor: pointer; background-repeat: no-repeat; text-align: left; " Text="Process"
						Width="100px" OnClientClick="return ProcessPay();" />
					<asp:Button ID="btnCancel" runat="server" CausesValidation="False" Style="background-position: right;
						background-image: url(../Images/cancel.gif); cursor: pointer; background-repeat: no-repeat;
						text-align: left; " Text="Cancel" Width="100px" />
					<asp:Button ID="btnPrint" runat="server" 
						OnClientClick="return PrintData();" 
						Style="background-position: right; background-image: url(../Images/print.jpg); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
						Text="Print Data" Width="100px" />
				</td>
			</tr>
		</table>
	</asp:Panel>
	
	
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
window.onload=function(){
	TabToEnter();
}

FormatTable("<%=gvInstallment.ClientID%>");

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
function SetAcc(LOCID, ACCID, ACCNO){
	SetValueTxtByClientID("<%=txtLocID.ClientID%>", LOCID);
	SetValueTxtByClientID("<%=txtAccID.ClientID%>", ACCID);
	SetValueTxtByClientID("<%=txtAccountNo.ClientID%>", ACCNO);
	var btn = getObjectbyClientID("<%=btnView.ClientID%>");
	if (btn) 
		btn.click();
}
function SearchAcc(){
	var winref = window.open("../Pay/SearchAccET.aspx?Action=Find", "AccFindET", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes");
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
			    sYear = y + sYear;
			    var dtDate = new Date(sYear, parseFloat(arrDt[1]) - 1, arrDt[0]);
			}
		} else {
		    var dtDate = new Date(sYear, parseFloat(arrDt[1]) - 1, arrDt[0]);
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
	oETAmount.value=FormatNumber(ETAmountOri + OtherFee, 'True', 2);
}
function ViewDetailAcc(LOCID, APPID){
	var winref = window.open("../Account/AccInqFrame.aspx?Action=AccInq&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
	winref.focus();
}

function PrintData() {
	var VALUEDATE = ConvertDDMMYYYY(GetValueTxtByClientID("<%=txtValueDate.ClientID%>"));    
	var LOCID = GetValueTxtByClientID("<%=txtLocID.ClientID%>");
	var ACCID = GetValueTxtByClientID("<%=txtAccID.ClientID%>");
	var OTHERFEE = GetValueTxtByClientID("<%=txtOtherFee.ClientID%>");
	var ETCALC = GetValueTxtByClientID("<%=hidETCALC.ClientID%>"); 
	if (Page_ClientValidate("")) {
	    var winref = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/ETAccountInquiry&VALUEDATE=" + VALUEDATE + "&LOCID=" + LOCID + "&ACCID=" + ACCID + "&OTHERFEE=" + OTHERFEE + "&ETCALCTYPE=" + ETCALC, "ETInquiry", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
		winref.focus();
	}
	return false;
}

function ConvertDDMMYYYY(sDate) {
	var arrDate = sDate.split("/")
	return (arrDate[2] + "-" + arrDate[1] + "-" + arrDate[0]);

}

window.history.forward();

</script>

</asp:Content>

