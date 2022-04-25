<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccDisbDisplay.aspx.vb" Inherits="Account_DisbInfo" title="Account Disbursement Info" %><%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<%@ Register src="../UserControl/DataAccountFromParamAccID.ascx" tagname="DataAccountFromParamAccID" tagprefix="uc2" %>
<%@ Register src="../UserControl/CollateralDataFromAccID.ascx" tagname="CollateralDataFromAccID" tagprefix="uc5" %>
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
	<asp:HiddenField ID="txtAction" runat="server" /><asp:HiddenField ID="txtAppDate" runat="server" />
	<asp:HiddenField ID="hidDealerID" runat="server" />
	<asp:HiddenField ID="hidDisburseSts" runat="server" />
	<asp:Panel ID="pnlAccData" runat="server" Width="100%">
		<uc2:DataAccountFromParamAccID ID="ctlDataAccountFromParamAccID" 
            runat="server" />
	</asp:Panel>
	<cc1:CollapsiblePanelExtender ID="ajaxCPEAccData" runat="server" CollapseControlID="pnlAccShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Account Data...)" Enabled="True"
		ExpandControlID="pnlAccShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Account Data...)"
		ImageControlID="imgAccData" TargetControlID="pnlAccData" TextLabelID="lblAccData">
	</cc1:CollapsiblePanelExtender>
	<asp:Panel ID="pnlCollateralShow" runat="server" CssClass="ShowDetail" 
        Width="99%">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgCollateral" runat="server" AlternateText="(Show Details...)" 
                ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblCollateral" runat="server" CssClass="required">(Show Collateral Data...)</asp:Label>
		</div>
		<input id="Button6" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
	<asp:Panel ID="pnlCollateral" runat="server"  Width="100%">
        <uc5:CollateralDataFromAccID ID="ctlCollateralDataFromAccID" runat="server" 
            Visible="True" />
	</asp:Panel>
	<cc1:CollapsiblePanelExtender ID="pnlCollateral_CollapsiblePanelExtender" 
        runat="server" CollapseControlID="pnlCollateralShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Collateral Data...)" Enabled="True"
		ExpandControlID="pnlCollateralShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Collateral Data...)"
		ImageControlID="imgCollateral" TargetControlID="pnlCollateral" 
        TextLabelID="lblLoanData">
	</cc1:CollapsiblePanelExtender>
	<asp:Panel ID="pnlDealerShow" runat="server" CssClass="ShowDetail" Width="99%">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgDealer" runat="server" AlternateText="(Show Details...)" 
                ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblDealer" runat="server" CssClass="required">(Show Dealer Info...)</asp:Label>
		</div>
		<input id="Button7" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
	<asp:Panel ID="pnlDealer" runat="server"  Width="100%">
        <asp:DataList ID="dlDealerInfo" runat="server" Caption="DEALER INFO" 
            DataKeyField="DEALERID" DataSourceID="sdsDealerInfo" Width="100%">
            <ItemTemplate>
                <table cellpadding="0" cellspacing="0" style="width:100%;">
                    <tr>
                        <td>
                            Dealer ID</td>
                        <td>
                            <asp:Label ID="DEALERIDLabel" runat="server" style="text-decoration: underline; font-weight: 700;" 
                                Text='<%# Eval("DEALERID") %>' />
                        </td>
                        <td>
                            Dealer Code</td>
                        <td>
                            <asp:Label ID="DEALERCODELabel" runat="server" 
                                style="text-decoration: underline; font-weight: 700;" 
                                Text='<%# Eval("DEALERCODE") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Dealer Name</td>
                        <td colspan="3">
                            <asp:Label ID="DEALERNAMELabel" runat="server" 
                                style="text-decoration: underline; font-weight: bold;" 
                                Text='<%# Eval("DEALERNAME") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Main Dealer</td>
                        <td colspan="3">
                            (<asp:Label ID="DEALERMAINCODELabel" runat="server" 
                                style="text-decoration: underline; font-weight: bold;" 
                                Text='<%# Eval("DEALERMAINCODE") %>' />)
                            <asp:Label ID="DEALERMAINNAMELabel" runat="server" 
                                style="text-decoration: underline; font-weight: bold;" 
                                Text='<%# Eval("DEALERMAINNAME") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Address</td>
                        <td colspan="3">
                            <asp:Label ID="ADDRESSLabel" runat="server" style="text-decoration: underline; font-weight: bold;" 
                                Text='<%# Eval("ADDRESS") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            City</td>
                        <td>
                            <asp:Label ID="CITYNAMELabel" runat="server" style="text-decoration: underline; font-weight: 700;" 
                                Text='<%# Eval("CITYNAME") %>' />
                        </td>
                        <td>
                            Zip</td>
                        <td>
                            <asp:Label ID="ZIPLabel" runat="server" style="text-decoration: underline; font-weight: bold;" 
                                Text='<%# Eval("ZIP") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Phone</td>
                        <td>
                            <asp:Label ID="PHONEAREALabel" runat="server" 
                                style="text-decoration: underline; font-weight: bold;" 
                                Text='<%# Eval("PHONEAREA") %>' />
                            &nbsp;<asp:Label ID="PHONELabel" runat="server" style="text-decoration: underline; font-weight: bold;" 
                                Text='<%# Eval("PHONE") %>' />
                        </td>
                        <td>
                            Fax</td>
                        <td>
                            <asp:Label ID="FAXAREALabel" runat="server" style="text-decoration: underline; font-weight: bold;" 
                                Text='<%# Eval("FAXAREA") %>' />
                            &nbsp;<asp:Label ID="FAXLabel" runat="server" style="text-decoration: underline; font-weight: bold;" 
                                Text='<%# Eval("FAX") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Email</td>
                        <td colspan="3">
                            <asp:Label ID="EMAILLabel" runat="server" style="text-decoration: underline; font-weight: bold;" 
                                Text='<%# Eval("EMAIL") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Day to Disburse</td>
                        <td colspan="3">
                            <asp:Label ID="Label50" runat="server" 
                                style="font-weight: 700; text-decoration: underline" 
                                Text='<%# Eval("DAYSTODISBURSE") %>'></asp:Label>
                            &nbsp;day(s) after booking</td>
                    </tr>
                </table>
                <asp:GridView ID="gvDealerAccount" runat="server" AutoGenerateColumns="False" 
                    Caption="DEALER ACCOUNT INFO" DataSourceID="sdsDealerAccount" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="BANKNAME" HeaderText="Bank" 
                            SortExpression="BANKNAME" />
                        <asp:BoundField DataField="ACCBANKBRANCH" HeaderText="Bank&lt;br&gt;Branch" 
                            HtmlEncode="False" SortExpression="ACCBANKBRANCH" />
                        <asp:BoundField DataField="ACCNO" HeaderText="Account&lt;br&gt;No." 
                            HtmlEncode="False" SortExpression="ACCNO" />
                        <asp:BoundField DataField="ACCNAME" HeaderText="Account&lt;br&gt;Name" 
                            HtmlEncode="False" SortExpression="ACCNAME" />
                        <asp:BoundField DataField="BANKACCSTATUS" HeaderText="Account&lt;br&gt;Status" 
                            HtmlEncode="False" ReadOnly="True" SortExpression="BANKACCSTATUS" />
                    </Columns>
                    <EmptyDataTemplate>
                        <uc1:NoDataFound ID="NoDataFound1" runat="server" />
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsDealerAccount" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    SelectCommand="SELECT BANK.BANKNAME, DEALERACCOUNT.ACCBANKBRANCH, DEALERACCOUNT.ACCNO, DEALERACCOUNT.ACCNAME, dbo.f_getParamGlobalName('BANKACCSTATUS', DEALERACCOUNT.BANKACCSTATUS) AS BANKACCSTATUS FROM DEALERACCOUNT WITH (nolock) INNER JOIN BANK WITH (nolock) ON DEALERACCOUNT.ACCBANKID = BANK.BANKID WHERE (DEALERACCOUNT.Deletests = 0) AND (DEALERACCOUNT.DEALERID = @DEALERID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hidDealerID" Name="DEALERID" 
                            PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
            </ItemTemplate>
        </asp:DataList>
        <asp:SqlDataSource ID="sdsDealerInfo" runat="server" 
            ConnectionString="<%$ ConnectionStrings:connection %>" 
            
            SelectCommand="SELECT DEALER.DEALERID, DEALER.DEALERCODE, DEALER.DEALERNAME, DEALERMAIN.DEALERMAINCODE, DEALERMAIN.DEALERMAINNAME, DEALER.ADDRESS, CITY.CITYCODE, CITY.CITYNAME, DEALER.ZIP, DEALER.PHONEAREA, DEALER.PHONE, DEALER.FAXAREA, DEALER.FAX, DEALER.EMAIL, DEALER.DAYSTODISBURSE FROM DEALER WITH (NOLOCK) INNER JOIN DEALERMAIN WITH (NOLOCK) ON DEALER.DEALERMAINID = DEALERMAIN.DEALERMAINID LEFT OUTER JOIN CITY WITH (NOLOCK) ON DEALER.CITYID = CITY.CITYID WHERE (DEALER.DEALERID = @DEALERID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="hidDealerID" Name="DEALERID" 
                    PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
	</asp:Panel>
	<cc1:CollapsiblePanelExtender ID="pnlDealer_CollapsiblePanelExtender" 
        runat="server" CollapseControlID="pnlDealerShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Dealer Info...)" Enabled="True"
		ExpandControlID="pnlDealerShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Dealer Info...)"
		ImageControlID="imgDealer" TargetControlID="pnlDealer" TextLabelID="lblDealer">
	</cc1:CollapsiblePanelExtender>
	<asp:Panel ID="pnlLoanShow" runat="server" CssClass="ShowDetail" Width="99%">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgLoanData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblLoanData" runat="server" CssClass="required">(Show Loan Data...)</asp:Label>
		</div>
		<input id="Button5" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
	<cc1:CollapsiblePanelExtender ID="ajaxCPELoanData" runat="server" CollapseControlID="pnlLoanShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Disbursement Data...)" Enabled="True"
		ExpandControlID="pnlLoanShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Disbursement Data...)"
		ImageControlID="imgLoanData" TargetControlID="pnlLoanData" 
        TextLabelID="lblLoanData">
	</cc1:CollapsiblePanelExtender>
	<asp:Panel ID="pnlLoanData" runat="server" Width="100%">
		<asp:DataList ID="dlLoanData" runat="server"  
			Caption="DISBURSEMENT INFO" DataSourceID="sdsLoanData" Width="100%">
			<ItemTemplate>
				<table cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td class="HeaderStyle">
							Disburse Status</td>
						<td colspan="3" class="HeaderStyle">
							(<asp:Label ID="Label35" runat="server" Font-Underline="True" 
                                Text='<%# Eval("DISBURSESTS") %>' style="font-weight: bold"></asp:Label>)
							<asp:Label ID="Label36" runat="server" Font-Underline="True" 
                                Text='<%# Eval("DISBURSESTSNAME") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td class="ErrHighLight">
							Object&nbsp; Value (OTR)</td>
						<td class="ErrHighLight">
							<asp:Label ID="Label37" runat="server" Font-Underline="True" 
                                Text='<%# Eval("OBJECTVALUE", Eval("DECPOINT")) %>' 
                                style="font-weight: bold; text-align: right;" Width="90%"></asp:Label>
                        </td>
						<td>
							&nbsp;</td>
						<td>
							&nbsp;</td>
					</tr>
					<tr>
                        <td class="ErrHighLight">
                            Refund Value</td>
                        <td class="ErrHighLight">
                            <asp:Label ID="Label46" runat="server" Font-Underline="True" 
                                Text='<%# Eval("REFUND", Eval("DECPOINT")) %>' 
                                style="font-weight: bold; text-align: right;" Width="90%"></asp:Label>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            Total
                            <asp:Label ID="Label47" runat="server" Font-Underline="False" 
                                Text='<%# Eval("CATPRINCIPAL") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="Label11" runat="server" Font-Underline="True" 
                                Text='<%# Eval("PRINCIPALTOTAL", Eval("DECPOINT")) %>' 
                                style="font-weight: bold; text-align: right;" Width="90%"></asp:Label>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
					<tr>
						<td>
							Tenor</td>
						<td>
							<asp:Label ID="Label18" runat="server" Font-Underline="True" 
                                Text='<%# Eval("TENOR") %>' style="font-weight: bold"></asp:Label></td>
						<td>
							Loan&nbsp; Type</td>
						<td>
							(<asp:Label ID="Label21" runat="server" Font-Underline="True" 
                                Text='<%# Eval("LOANTYPE") %>' style="font-weight: bold"></asp:Label>)
							<asp:Label ID="Label34" runat="server" Font-Underline="True" 
                                Text='<%# Eval("LOANTYPENAME") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							<asp:Label ID="Label48" runat="server" Font-Underline="False" 
                                Text='<%# Eval("CATEFFECTIVE") %>'></asp:Label>
                        </td>
						<td>
							<asp:Label ID="Label22" runat="server" Font-Underline="True" 
                                Text='<%# Eval("EFFECTIVERATE") %>' style="font-weight: bold"></asp:Label>%</td>
						<td>
							Installment</td>
						<td>
							<asp:Label ID="Label24" runat="server" Font-Underline="True" 
                                Text='<%# Eval("INSTALLMENT", Eval("DECPOINT")) %>' 
                                style="font-weight: bold; text-align: right;" Width="90%"></asp:Label></td>
					</tr>
					<tr>
						<td>
							Installment Start</td>
						<td>
							<asp:Label ID="Label23" runat="server" Font-Underline="True" 
                                Text='<%# Eval("INSTALLMENTSTART", "{0:dd/MM/yyyy}") %>' 
                                style="font-weight: bold"></asp:Label></td>
						<td>
							Installment End</td>
						<td>
							<asp:Label ID="Label25" runat="server" Font-Underline="True" 
                                Text='<%# Eval("INSTALLMENTEND", "{0:dd/MM/yyyy}") %>' 
                                style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							Installment Day</td>
						<td>
							<asp:Label ID="Label28" runat="server" Font-Underline="True" 
                                Text='<%# Eval("INSTALLMENTDAY") %>' style="font-weight: bold"></asp:Label></td>
						<td>
							Next Due Date</td>
						<td>
							<asp:Label ID="Label26" runat="server" Font-Underline="True" 
                                Text='<%# Eval("NEXTDUEDATE", "{0:dd/MM/yyyy}") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td class="ShowDetail">
							FIRST PAYMENT</td>
						<td class="HeaderStyle" colspan="3">
							<hr />
                        </td>
					</tr>
					<tr>
                        <td class="ErrHighLight">
                            Down Payment (a)</td>
                        <td class="ErrHighLight"  style="text-align: right">
                            <asp:Label ID="Label38" runat="server" Font-Underline="True" 
                                Text='<%# Eval("DOWNPAYMENT", Eval("DECPOINT")) %>' 
                                style="font-weight: bold; text-align: right;" Width="90%"></asp:Label>
                        </td>
                        <td class="ErrHighLight">
                            </td>
                        <td class="ErrHighLight" >
                            </td>
                    </tr>
                    <tr>
                        <td class="RowStyle">
                            Admin Fee (b)</td>
                        <td class="RowStyle" style="text-align: right">
                            <asp:Label ID="Label29" runat="server" Font-Underline="True" 
                                Text='<%# Eval("ADMFEE", Eval("DECPOINT")) %>' style="font-weight: bold" 
                                Width="90%"></asp:Label>
                        </td>
                        <td class="AlternatingRowStyle">
                            &nbsp; Fiducia Fee (c)</td>
                        <td class="AlternatingRowStyle" style="text-align: right">
                            <asp:Label ID="Label40" runat="server" Font-Underline="True" 
                                Text='<%# Eval("FIDUCIAFEE", Eval("DECPOINT")) %>' 
                                style="font-weight: bold" Width="90%"></asp:Label>
                        </td>
                    </tr>
					<tr>
						<td class="AlternatingRowStyle">
							Check Doc Fee (e)</td>
						<td class="AlternatingRowStyle" style="text-align: right">
							<asp:Label ID="Label39" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CHECKDOCFEE", Eval("DECPOINT")) %>' 
                                style="font-weight: bold" Width="90%"></asp:Label>
                        </td>
						<td class="RowStyle">
						    &nbsp; Survey Fee (d)</td>
						<td class="RowStyle" style="text-align: right">
						    <asp:Label ID="Label41" runat="server" Font-Underline="True" 
                                Text='<%# Eval("SURVEYFEE", Eval("DECPOINT")) %>' 
                                style="font-weight: bold" Width="90%"></asp:Label>
						</td>
					</tr>
					<tr>
                        <td class="RowStyle">
                            Installment Advance (f)</td>
                        <td class="RowStyle" style="text-align: right">
                            <asp:Label ID="Label27" runat="server" Font-Underline="True" 
                                Text='<%# Eval("INSTADVANCE", Eval("DECPOINT")) %>' 
                                style="font-weight: bold" Width="90%"></asp:Label>
                        </td>
                        <td class="AlternatingRowStyle">
                            &nbsp; Insurance Pre Paid (g)</td>
                        <td class="AlternatingRowStyle" style="text-align: right">
                            <asp:Label ID="Label42" runat="server" Font-Underline="True" 
                                Text='<%# Eval("INSPREPAID", Eval("DECPOINT")) %>' 
                                style="font-weight: bold" Width="90%"></asp:Label>
                        </td>
                    </tr>
					<tr>
						<td class="AlternatingRowStyle">
							Set off Value (h)</td>
						<td class="AlternatingRowStyle" style="text-align: right">
							<asp:Label ID="Label43" runat="server" Font-Underline="True" 
                                Text='<%# Eval("SETOFFVALUE", Eval("DECPOINT")) %>' 
                                style="font-weight: bold" Width="90%"></asp:Label>
                        </td>
					    <td class="RowStyle">
                            &nbsp;</td>
                        <td class="RowStyle" >
                            </td>
					</tr>
				    <tr>
                        <td class="RowStyle">
                            Dealer Subsidies (i)</td>
                        <td class="RowStyle" style="text-align: right">
                            <asp:Label ID="Label44" runat="server" Font-Underline="True" 
                                Text='<%# Eval("DEALERSUBSIDIES", Eval("DECPOINT")) %>' 
                                style="font-weight: bold" Width="90%"></asp:Label>
                        </td>
                        <td class="AlternatingRowStyle">
                            &nbsp;</td>
                        <td class="AlternatingRowStyle">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td class="FooterStyle" colspan="4">
                            <hr />
                            </td>
                    </tr>
                    <tr>
                        <td class="ShowDetail">
                            First Payment
                        </td>
                        <td class="ShowDetail" style="text-align: right">
                            <asp:Label ID="Label45" runat="server" Font-Underline="True" 
                                style="font-weight: bold" Text='<%# Eval("FIRSTPAYMENT", Eval("DECPOINT")) %>' 
                                Width="90%"></asp:Label>
                        </td>
                        <td class="HeaderStyle" colspan="2">
                            &nbsp; (a+b+c+d+e+f+g+h+i)</td>
                    </tr>
                    <tr>
                        <td class="ShowDetail">
                            Disbursement</td>
                        <td class="ShowDetail" style="text-align: right">
                            <asp:Label ID="Label5" runat="server" Font-Underline="True" 
                                Text='<%# Eval("DISBURSEMENT", Eval("DECPOINT")) %>' 
                                style="font-weight: 700" Width="90%"></asp:Label>
                        </td>
                        <td class="HeaderStyle" colspan="2">
                            &nbsp; (OTR + Refund - First Payment)</td>
                    </tr>
                    <tr>
                        <td class="FooterStyle" colspan="4">
                            <hr />
                        </td>
                    </tr>
				    <tr>
                        <td class="ShowDetail">
                            PENDING DISBURSE</td>
                        <td class="HeaderStyle" style="text-align: right" colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Amount</td>
                        <td colspan="3">
                            <asp:Label ID="Label49" runat="server" Font-Underline="True" 
                                style="font-weight: 700" 
                                Text='<%# Eval("PENDINGDISBURSE", Eval("DECPOINT")) %>' Width="90%"></asp:Label>
                        </td>
                    </tr>
				    <tr>
                        <td>
                            Pending Disb. Status</td>
                        <td colspan="3">
                            (<asp:Label ID="Label50" runat="server" Font-Underline="True" 
                                style="font-weight: bold" Text='<%# Eval("PENDINGSTS") %>'></asp:Label>)
                                <asp:Label ID="Label51" runat="server" Font-Underline="True" 
                                style="font-weight: bold" Text='<%# Eval("PENDINGSTSNAME") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Paid Txn Date</td>
                        <td colspan="3">
                            <asp:Label ID="Label52" runat="server" Font-Underline="True" 
                                style="font-weight: bold" 
                                Text='<%# Eval("PENDINGPAIDDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </td>
                    </tr>
				    <tr>
                        <td class="HeaderStyle" colspan="4">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td class="ErrHighLight">
                            Real Disburse Value</td>
                        <td class="ErrHighLight" colspan="3">
                            <asp:Label ID="Label53" runat="server" Font-Underline="True" 
                                style="font-weight: bold" Text='<%# Eval("DISBURSEREAL", Eval("DECPOINT")) %>'></asp:Label>
                            &nbsp; (Disbursement - Pending Disburse)</td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle" colspan="4">
                            <hr />
                        </td>
                    </tr>
				</table>
			</ItemTemplate>
		</asp:DataList>
		<asp:SqlDataSource ID="sdsLoanData" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            
            
            
            SelectCommand="SELECT LOCID, APPID, ACCID, PRINCIPALTOTAL, TENOR, LOANTYPE, EFFECTIVERATE, INSTALLMENT, INSTALLMENTDAY, ADMFEE, INSTALLMENTSTART, INSTALLMENTEND, NEXTDUEDATE, INTERESTTOTAL, LOANTYPENAME, INSTADVANCE, DISBURSESTS, DISBURSESTSNAME, FIDUCIAFEE, CHECKDOCFEE, SURVEYFEE, SETOFFVALUE, DEALERSUBSIDIES, DOWNPAYMENT, OBJECTVALUE, INSPREPAID, FIRSTINSTALLMENT, ADMFEE + FIDUCIAFEE + CHECKDOCFEE + SURVEYFEE + SETOFFVALUE + DEALERSUBSIDIES + DOWNPAYMENT + FIRSTINSTALLMENT + INSPREPAID AS FIRSTPAYMENT, REFUND, (OBJECTVALUE + REFUND) - (ADMFEE + FIDUCIAFEE + CHECKDOCFEE + SURVEYFEE + SETOFFVALUE + DEALERSUBSIDIES + DOWNPAYMENT + FIRSTINSTALLMENT + INSPREPAID) AS DISBURSEMENT, CATPRINCIPAL, CATEFFECTIVE, DECPOINT, PENDINGDISBURSE, PENDINGSTS, PENDINGSTSNAME, PENDINGPAIDDATE, (OBJECTVALUE + REFUND) - (ADMFEE + FIDUCIAFEE + CHECKDOCFEE + SURVEYFEE + SETOFFVALUE + DEALERSUBSIDIES + DOWNPAYMENT + FIRSTINSTALLMENT + INSPREPAID) - PENDINGDISBURSE AS DISBURSEREAL FROM (SELECT APPLICATION.LOCID, APPLICATION.APPID, ACCOUNT.ACCID, ACCOUNT.PRINCIPALTOTAL, ACCOUNT.TENOR, ACCOUNT.LOANTYPE, ACCOUNT.EFFECTIVERATE, ACCOUNT.INSTALLMENT, ACCOUNT.INSTALLMENTDAY, ACCOUNTDTL.ADMFEE, ACCOUNTDTL.INSTALLMENTSTART, ACCOUNTDTL.INSTALLMENTEND, ACCOUNT.NEXTDUEDATE, ACCOUNT.INTERESTTOTAL, (SELECT NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (ACCOUNT.LOANTYPE = CODE) AND (TYPE = 'LOANTYPE')) AS LOANTYPENAME, CASE WHEN LOANTYPE = 1 THEN INSTALLMENT ELSE 0 END AS INSTADVANCE, ACCOUNT.DISBURSESTS, dbo.f_getParamGlobalName('DISBURSESTS', ACCOUNT.DISBURSESTS) AS DISBURSESTSNAME, ACCOUNTDTL.FIDUCIAFEE, ACCOUNTDTL.CHECKDOCFEE, ACCOUNTDTL.SURVEYFEE, ACCOUNTDTL.SETOFFVALUE, ACCOUNTDTL.DEALERSUBSIDIES, ACCOUNT.DOWNPAYMENT, ACCOUNT.OBJECTVALUE, ACCOUNT.INSPREMI - ACCOUNT.INSONLOAN AS INSPREPAID, CASE WHEN LOANTYPE = 1 THEN INSTALLMENT ELSE 0 END AS FIRSTINSTALLMENT, (SELECT ISNULL(SUM(AMOUNT), 0) AS Expr1 FROM REFUNDTRX WHERE (INCLUDEDISBURSE = 1) AND (Deletests = 0) AND (LOCID = ACCOUNT.LOCID) AND (ACCID = ACCOUNT.ACCID)) AS REFUND, dbo.f_getTermPrincipal(ACCOUNT.FINCATID) AS CATPRINCIPAL, dbo.f_getTermEffective(ACCOUNT.FINCATID) AS CATEFFECTIVE, dbo.f_getCurrencyDecPointForNet(ACCOUNT.CURRENCYID) AS DECPOINT, ACCOUNTDTL.PENDINGDISBURSE, ACCOUNTDTL.PENDINGSTS, dbo.f_getParamGlobalName('DISBURSESTS', ACCOUNTDTL.PENDINGSTS) AS PENDINGSTSNAME, ACCOUNTDTL.PENDINGPAIDDATE FROM ACCOUNT WITH (NOLOCK) INNER JOIN APPLICATION WITH (NOLOCK) ON ACCOUNT.LOCID = APPLICATION.LOCID AND ACCOUNT.APPID = APPLICATION.APPID INNER JOIN ACCOUNTDTL WITH (NOLOCK) ON ACCOUNT.LOCID = ACCOUNTDTL.LOCID AND ACCOUNT.ACCID = ACCOUNTDTL.ACCID WHERE (ACCOUNT.Deletests = 0) AND (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.ACCID = @ACCID)) AS A">
			<SelectParameters>
				<asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
				<asp:QueryStringParameter Name="ACCID" QueryStringField="ACCID" />
			</SelectParameters>
		</asp:SqlDataSource>
	    <asp:GridView ID="gvRefund" runat="server" AutoGenerateColumns="False" 
            Caption="DETAIL REFUND INFO" DataSourceID="sdsRefund" Width="100%">
            <Columns>
                <asp:BoundField DataField="PERSONNAME" HeaderText="Person" 
                    SortExpression="PERSONNAME" />
                <asp:BoundField DataField="PERSONTITLENAME" HeaderText="Title" ReadOnly="True" 
                    SortExpression="PERSONTITLENAME" />
                <asp:BoundField DataField="REFUNDCATEGORYNAME" 
                    HeaderText="Refund&lt;br&gt;Category" HtmlEncode="False" ReadOnly="True" 
                    SortExpression="REFUNDCATEGORYNAME" />
                <asp:BoundField DataField="AMOUNT" DataFormatString="{0:N}" HeaderText="Amount" 
                    SortExpression="AMOUNT">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
            </Columns>
            <EmptyDataTemplate>
                <uc1:NoDataFound ID="NoDataFound2" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsRefund" runat="server" 
            ConnectionString="<%$ ConnectionStrings:connection %>" 
            SelectCommand="SELECT REFUNDTRX.PERSONID, REFUNDTRX.AMOUNT, DEALERPERSON.PERSONNAME, dbo.f_getParamGlobalName('REFUNDCATEGORY', REFUNDTRX.REFUNDCATEGORY) AS REFUNDCATEGORYNAME, dbo.f_getParamGlobalName('PERSONTITLE', DEALERPERSON.PERSONTITLE) AS PERSONTITLENAME FROM REFUNDTRX WITH (nolock) INNER JOIN DEALERPERSON WITH (nolock) ON REFUNDTRX.PERSONID = DEALERPERSON.PERSONID WHERE (REFUNDTRX.LOCID = @LOCID) AND (REFUNDTRX.ACCID = @ACCID) AND (REFUNDTRX.Deletests = 0) AND (REFUNDTRX.INCLUDEDISBURSE = 1)">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtLocID" Name="LOCID" PropertyName="Value" />
                <asp:ControlParameter ControlID="txtAccID" Name="ACCID" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
	</asp:Panel>
    <br />
    <br />
    <br />
    <br />
    <br />

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
	<asp:Panel ID="pnlProcess" runat="server" Width="100%"><table Width="100%" cellpadding="0" cellspacing="0">
		<tr>
			<td style="font-weight: bold; text-align: center" class="ShowDetail" colspan="2">
				D I S B U R S E M E N T&nbsp;&nbsp;&nbsp; P R O C E S S</td>
		</tr>
	</table>
		<asp:Panel ID="pnlInit" runat="server" Visible="False" Width="100%" CssClass="RowStyle" GroupingText="Plan Paid">
			<table cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td class="FooterStyle">
						Plan Paid Date</td>
					<td class="FooterStyle">
						<asp:TextBox ID="txtPlanPaid" runat="server" CssClass="required" ValidationGroup="ValSave"
							Width="72px"></asp:TextBox><asp:Image ID="imgPlanPaid" runat="server" ImageUrl="~/images/grid.gif"
								Style="cursor: pointer" ToolTip="Calendar" />
                        <asp:RequiredFieldValidator ID="reqPlanPaid"
									runat="server" ControlToValidate="txtPlanPaid" Display="None" ErrorMessage="PLAN PAID DATE must be entry...!"
									SetFocusOnError="True" ValidationGroup="ValSave"></asp:RequiredFieldValidator><cc1:ValidatorCalloutExtender
										ID="ajaxVCEPlanPaid" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPlanPaid">
									</cc1:ValidatorCalloutExtender>
						<cc1:CalendarExtender ID="ajaxCEPlanPaid" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgPlanPaid"
							TargetControlID="txtPlanPaid" Animated="False">
						</cc1:CalendarExtender>
						<cc1:MaskedEditExtender ID="ajaxMEEPlanPaid" runat="server" Mask="99/99/9999" MaskType="Date"
							TargetControlID="txtPlanPaid">
						</cc1:MaskedEditExtender>
					    <asp:Button ID="btnSave" runat="server" OnClientClick="return ProcessSave();" 
                            Style="background-position: right; background-image: url(../Images/Save.gif); cursor: pointer; background-repeat: no-repeat; text-align: left;" 
                            Text="Save" ValidationGroup="ValSave" Visible="False" Width="88px" />
                        <asp:Button ID="btnCancelSave" runat="server" CausesValidation="False" 
                            OnClientClick="return BackDisburse();" 
                            Style="background-position: right; background-image: url(../Images/back.png); cursor: pointer; background-repeat: no-repeat; text-align: left;" 
                            Text="Back" Width="88px" />
					</td>
				</tr>
			</table>
		</asp:Panel>
		<cc1:AlwaysVisibleControlExtender ID="ajaxAVCEDisbInit" runat="server" 
            Enabled="True" TargetControlID="pnlInit" VerticalSide="Bottom">
        </cc1:AlwaysVisibleControlExtender>
		<asp:Panel ID="pnlDisbursment" runat="server" Width="100%" GroupingText="Disbursement" CssClass="RowStyle" Visible="False">
			<table cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td class="FooterStyle">
						Txn Date (App Date)</td>
					<td class="FooterStyle">
						<asp:TextBox ID="txtPaidTxnDate" runat="server" CssClass="disabled" 
                            ReadOnly="True" Width="72px" ValidationGroup="ValApp"></asp:TextBox></td>
				</tr>
				<tr>
					<td class="FooterStyle">
						Paid Date</td>
					<td class="FooterStyle">
						<asp:TextBox ID="txtPaidDate" runat="server" CssClass="required" 
                            ValidationGroup="ValApp" Width="72px"></asp:TextBox>
                        <cc1:CalendarExtender ID="ajaxCEPaiddate" runat="server" 
                            Animated="False" Format="dd/MM/yyyy" PopupButtonID="imgPaidDate" 
                            TargetControlID="txtPaidDate">
                        </cc1:CalendarExtender>
                        <cc1:MaskedEditExtender ID="ajaxMEEPaidDate" runat="server" 
                            Mask="99/99/9999" MaskType="Date" TargetControlID="txtPaidDate">
                        </cc1:MaskedEditExtender>
                        <asp:Image ID="imgPaidDate" runat="server" ImageUrl="~/images/grid.gif" 
                            Style="cursor: pointer" ToolTip="Calendar" />
                        <asp:RequiredFieldValidator ID="reqPaidDate" runat="server" 
                            ControlToValidate="txtPaidDate" Display="None" 
                            ErrorMessage="PLAN PAID DATE must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="ValApp"></asp:RequiredFieldValidator>
                        <cc1:ValidatorCalloutExtender ID="reqPaidDate_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPaidDate">
                        </cc1:ValidatorCalloutExtender>
                    </td>
				</tr>
				<tr>
					<td class="FooterStyle">
						Txn Type</td>
					<td class="FooterStyle">
						<asp:DropDownList ID="ddlTxnType" runat="server" CssClass="required" DataSourceID="sdsTxnType"
							DataTextField="TXNTYPE" DataValueField="CODE" ValidationGroup="ValApp">
						</asp:DropDownList><asp:SqlDataSource ID="sdsTxnType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
							
                            
                            
                            SelectCommand="SELECT NULL AS CODE, '[TXN TYPE]' AS TXNTYPE UNION ALL SELECT CODE, CODE + ' - ' + NAME AS TXNTYPE FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'TXNTYPE') AND (CODE IN ('1', '2'))">
						</asp:SqlDataSource>
					    <asp:RequiredFieldValidator ID="reqPaymentType" runat="server" 
                            ControlToValidate="ddlTxnType" Display="None" 
                            ErrorMessage="PAYMENT TYPE must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="ValApp"></asp:RequiredFieldValidator>
                        <cc1:ValidatorCalloutExtender ID="ajaxVCEPaymentType" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqPaymentType">
                        </cc1:ValidatorCalloutExtender>
					</td>
				</tr>
			    <tr ID="trBank">
                    <td class="FooterStyle">
                        Bank Account No.</td>
                    <td class="FooterStyle">
                        <asp:DropDownList ID="ddlAccountNo" runat="server">
                        </asp:DropDownList>
                        <cc1:CascadingDropDown ID="ajaxCCDBankAcc" runat="server" 
                            BehaviorID="BehavBankAccNo" Category="BankAccNo" 
                            LoadingText="[Loading Bank Account ...]" PromptText="[BANK ACCOUNT NO.]" 
                            ServiceMethod="GetDropDownBankAccountByUIDAndFinCat" 
                            ServicePath="~\Param\WebService.asmx" TargetControlID="ddlAccountNo">
                        </cc1:CascadingDropDown>
                    </td>
                </tr>
			    <tr>
                    <td class="FooterStyle">
                        Dealer Bank Account</td>
                    <td class="FooterStyle">
                        <asp:DropDownList ID="ddlDealerAccount" runat="server" CssClass="required" 
                            DataSourceID="sdsDealerAccount" DataTextField="DEALERACCOUNTNO" 
                            DataValueField="DEALERACCOUNTID" ValidationGroup="ValApp">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsDealerAccount" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            SelectCommand="SELECT DEALERACCOUNT.DEALERACCOUNTID, BANK.BANKNAME + '- ' + DEALERACCOUNT.ACCNO + ' - ' + DEALERACCOUNT.ACCNAME AS DEALERACCOUNTNO FROM DEALERACCOUNT WITH (NOLOCK) INNER JOIN BANK WITH (NOLOCK) ON DEALERACCOUNT.ACCBANKID = BANK.BANKID WHERE (DEALERACCOUNT.DEALERID = @DEALERID) AND (DEALERACCOUNT.Deletests = 0) ORDER BY DEALERACCOUNT.BANKACCSTATUS DESC">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hidDealerID" Name="DEALERID" 
                                    PropertyName="Value" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:RequiredFieldValidator ID="reqDealerBank" runat="server" 
                            ControlToValidate="ddlDealerAccount" Display="None" 
                            ErrorMessage="DEALER BANK ACCOUNT must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="ValApp"></asp:RequiredFieldValidator>
                        <cc1:ValidatorCalloutExtender ID="reqDealerBank_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDealerBank">
                        </cc1:ValidatorCalloutExtender>
                    </td>
                </tr>
			</table>
		</asp:Panel>
		<cc1:AlwaysVisibleControlExtender ID="ajaxAVCEDisbApp" runat="server" 
            Enabled="True" TargetControlID="pnlDisbursment" VerticalSide="Bottom">
        </cc1:AlwaysVisibleControlExtender>
		<table cellpadding="0" cellspacing="0" class="FooterStyle" width="100%">
			<tr>
				<td colspan="3" class="HeaderStyle">
				<asp:Button ID="btnApprove" runat="server" OnClientClick="return ProcessApp();" Style="background-position: right;
					background-image: url(../Images/ok.png); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Approve" Width="88px" Visible="False" 
                        ValidationGroup="ValApp" /><asp:Button ID="btnReject" runat="server" Style="background-position: right;
					background-image: url(../Images/stop.png); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Reject" Width="88px" Visible="False" CausesValidation="False" /><asp:Button ID="btnCancel" runat="server" CausesValidation="False" Style="background-position: right;
					background-image: url(../Images/back.png); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Back" Width="88px" OnClientClick="return BackDisburse();" />
					<asp:Button ID="btnJournal" runat="server" OnClientClick="return(ShowJournal());"
						Style="background-position: right; background-image: url(../Images/journal.gif);
						cursor: pointer; background-repeat: no-repeat;" Text="Show Disbursment Journal" Visible="False" /></td>
			</tr>
		</table>
	</asp:Panel>
	<cc1:AlwaysVisibleControlExtender ID="ajaxAVCEProcess" runat="server" TargetControlID="pnlProcess"
		VerticalSide="Bottom">
	</cc1:AlwaysVisibleControlExtender>
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />

<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvRefund.ClientID%>");
window.onload = function () {
	TabToEnter();
	TxnTypeChange();
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


function CheckProcess(){
	var oPlanPaid=getObjectbyClientID("<%=txtPlanPaid.ClientID%>");
	var AppDate=GetValueTxtByClientID("<%=txtAppDate.ClientID%>");
	if (oPlanPaid.value!=""){
		if (ConvertToDate(oPlanPaid.value)<ConvertToDate(AppDate)){
			alert("Plan Plaid Date must be greater than application date..!")
			oPlanPaid.className="ErrHighLight";
			oPlanPaid.focus();
			return false;
		}
	}
	return true;
}

function ProcessSave(){
    if (Page_ClientValidate("ValSave")) {
		if (!CheckProcess()) return false;
	}
	return true;
}

function ProcessApp(){
	if (Page_ClientValidate("ValApp")){
		if (!CheckTxnType()) return false;
	}
	return true;
}
function BackDisburse(){
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
function TxnTypeChange(){
	var oTxn=getObjectbyClientID("<%=ddlTxnType.ClientID%>");
	if (oTxn){
		var TxnType=GetValueTxtByClientID("<%=ddlTxnType.ClientID%>");
		var oDiv=getObjectbyClientID("trBank");
		if (TxnType=="1"){
			var oAcc=getObjectbyClientID("<%=ddlAccountNo.ClientID%>");
			oAcc.value="";
			oDiv.style.display = "none";
		}else{
			oDiv.style.display = "";
		}
	}
}
function CheckTxnType(){
	var TxnType=GetValueTxtByClientID("<%=ddlTxnType.ClientID%>");
	if (TxnType=="2"){
		var oAcc=getObjectbyClientID("<%=ddlAccountNo.ClientID%>");
		if (oAcc.value==""){
			alert("[BANK ACCOUNT NO.] must be entry...!");
			oAcc.className="ErrHighLight";
			oAcc.focus();
			return false;
		}
		
	}
	return true;
}
function ViewDetailAcc(LOCID, APPID){
	var winref = window.open("../Account/AccInqFrame.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
	winref.focus();
}

function ShowJournal(){
	var RefNo=GetValueTxtByClientID("<%=txtLocID.ClientID%>") + '-' + GetValueTxtByClientID("<%=txtAccID.ClientID%>");
	var winref = window.open("../Core/JournalViewByRefNo.aspx?Action=View&RefNo=" + RefNo + "&BookCode=DE11", "DisbJournal", "height=400,width=600,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
	winref.focus();
	return (false);
}

</script>


</asp:Content>

