<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ETDisplay.aspx.vb" Inherits="Account_ETDisplay" title="ET Account Display" EnableEventValidation="false" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<%@ Register src="../UserControl/DataAccountFromParamAccID.ascx" tagname="DataAccountFromParamAccID" tagprefix="uc2" %>
<%@ Register src="../UserControl/LoanDataFromParamAccID.ascx" tagname="LoanDataFromParamAccID" tagprefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">

    <asp:Panel ID="pnlAccShow" runat="server" CssClass="ShowDetail" Width="99%">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgAccData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblAccData" runat="server" CssClass="required">(Show Account Data...)</asp:Label>
		</div>
		<input id="Button1" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <asp:ScriptManagerProxy ID="SMPET" runat="server">
	<Services>
	<asp:ServiceReference Path="GHWService.asmx" />
	</Services>
	</asp:ScriptManagerProxy>
	<asp:HiddenField ID="txtLocID" runat="server" />
	<asp:HiddenField ID="txtAccID" runat="server" />
	<asp:HiddenField ID="txtETID" runat="server" /><asp:HiddenField ID="txtAction" runat="server" /><asp:HiddenField ID="txtNextDueDateET" runat="server" />
	<asp:HiddenField ID="txtNextDueDateCust" runat="server" />
	<asp:HiddenField ID="hidFincatID" runat="server" />
        <asp:HiddenField ID="txtLocidUn" runat="server" />
        <asp:HiddenField ID="txtUnknownID" runat="server" />
        <asp:HiddenField ID="txtAllocateID" runat="server" />
		<asp:HiddenField ID="txtUID" runat="server" />
		<asp:HiddenField ID="hidBackCash" runat="server" />
        <asp:HiddenField ID="hidBackBank" runat="server" />
		<asp:HiddenField ID="hidSPV" runat="server" />
		<asp:HiddenField ID="hidAPPDATE" runat="server" />
		<asp:HiddenField ID="hidDecPoint" runat="server" />
		<asp:HiddenField ID="hidINVOICECHECK" runat="server" />
		<asp:HiddenField ID="hidETCALC" runat="server" />
	<asp:Panel ID="pnlAccData" runat="server" Width="100%">
        <uc2:DataAccountFromParamAccID ID="ctlDataAccountFromParamAccID" runat="server" />
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
	<asp:Panel ID="pnlLoanData" runat="server"  Width="100%">
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
	<asp:Panel ID="pnlInstData" runat="server" Width="100%">
        <asp:GridView ID="gvInstallment" runat="server" 
                AutoGenerateColumns="False" Caption="INSTALLMENT DUE DATA" 
                DataSourceID="sdsInstallment" Width="100%">
            <Columns>
                <asp:BoundField DataField="PERIOD" HeaderText="Per" SortExpression="PERIOD">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="DUEDATE" DataFormatString="{0:dd/MM/yyyy}" 
                        HeaderText="Due&lt;br&gt;Date" HtmlEncode="False" 
                    SortExpression="DUEDATE">
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
	<table cellpadding="0" cellspacing="0" width="100%" id="tbET" >
		<tr>
			<td colspan="3">
				<hr />
			</td>
		</tr>
		<tr>
			<td colspan="3">
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
			<td class="ShowDetail" colspan="3" style="text-align: center">
				ET INFO</td>
		</tr>
		<tr>
			<td class="FooterStyle" colspan="3">
				ET Date :
				<asp:Label ID="lblETDate" runat="server" 
                    style="font-weight: 700; text-decoration: underline"></asp:Label>
			&nbsp;&nbsp;&nbsp;
				ET Txn Date :
				<asp:Label ID="lblETTxnDate" runat="server" 
                    style="font-weight: 700; text-decoration: underline"></asp:Label>
			</td>
		</tr>
		<tr>
			<td class="FooterStyle" colspan="3">
				ET Status :
				<asp:Label ID="lblETStatus" runat="server" CssClass="ErrHighLight" 
                    style="font-weight: 700; text-decoration: underline"></asp:Label>&nbsp;ET 
                Calculation Type:
				<asp:Label ID="lblETCalcType" runat="server" CssClass="ErrHighLight" 
                    style="font-weight: 700; text-decoration: underline"></asp:Label></td>
		</tr>
		<tr>
			<td class="FooterStyle" colspan="3">
				Entry Source :
				<asp:Label ID="lblEntrySource" runat="server" CssClass="ErrHighLight" 
                    style="font-weight: 700; text-decoration: underline"></asp:Label></td>
		</tr>
		<tr>
			<td colspan="3">
				<asp:FormView ID="fvETUpload" runat="server" Caption="ET Values Comparison" DataSourceID="sdsETUpload"
					Width="100%">
					<EditItemTemplate>
						ETPENALTY:
						<asp:TextBox ID="ETPENALTYTextBox" runat="server" Text='<%# Eval("ETPENALTY") %>'>
						</asp:TextBox><br />
						ETADMIN:
						<asp:TextBox ID="ETADMINTextBox" runat="server" Text='<%# Eval("ETADMIN") %>'>
						</asp:TextBox><br />
						ETOTHERFEE:
						<asp:TextBox ID="ETOTHERFEETextBox" runat="server" Text='<%# Eval("ETOTHERFEE") %>'>
						</asp:TextBox><br />
						OSPRINCIPAL:
						<asp:TextBox ID="OSPRINCIPALTextBox" runat="server" Text='<%# Eval("OSPRINCIPAL") %>'>
						</asp:TextBox><br />
						ETINTEREST:
						<asp:TextBox ID="ETINTERESTTextBox" runat="server" Text='<%# Eval("ETINTEREST") %>'>
						</asp:TextBox><br />
						AMOUNTDUE:
						<asp:TextBox ID="AMOUNTDUETextBox" runat="server" Text='<%# Eval("AMOUNTDUE") %>'>
						</asp:TextBox><br />
						JFETPENALTY:
						<asp:TextBox ID="JFETPENALTYTextBox" runat="server" Text='<%# Eval("JFETPENALTY") %>'>
						</asp:TextBox><br />
						JFETADMIN:
						<asp:TextBox ID="JFETADMINTextBox" runat="server" Text='<%# Eval("JFETADMIN") %>'>
						</asp:TextBox><br />
						JFETOTHERFEE:
						<asp:TextBox ID="JFETOTHERFEETextBox" runat="server" Text='<%# Eval("JFETOTHERFEE") %>'>
						</asp:TextBox><br />
						JFAMOUNTDUE:
						<asp:TextBox ID="JFAMOUNTDUETextBox" runat="server" Text='<%# Eval("JFAMOUNTDUE") %>'>
						</asp:TextBox><br />
						JFOSPRINCIPAL:
						<asp:TextBox ID="JFOSPRINCIPALTextBox" runat="server" Text='<%# Eval("JFOSPRINCIPAL") %>'>
						</asp:TextBox><br />
						JFETINTEREST:
						<asp:TextBox ID="JFETINTERESTTextBox" runat="server" Text='<%# Eval("JFETINTEREST") %>'>
						</asp:TextBox><br />
						<asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
							Text="Update">
						</asp:LinkButton>
						<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
							Text="Cancel">
						</asp:LinkButton>
					</EditItemTemplate>
					<InsertItemTemplate>
						ETPENALTY:
						<asp:TextBox ID="ETPENALTYTextBox" runat="server" Text='<%# Eval("ETPENALTY") %>'>
						</asp:TextBox><br />
						ETADMIN:
						<asp:TextBox ID="ETADMINTextBox" runat="server" Text='<%# Eval("ETADMIN") %>'>
						</asp:TextBox><br />
						ETOTHERFEE:
						<asp:TextBox ID="ETOTHERFEETextBox" runat="server" Text='<%# Eval("ETOTHERFEE") %>'>
						</asp:TextBox><br />
						OSPRINCIPAL:
						<asp:TextBox ID="OSPRINCIPALTextBox" runat="server" Text='<%# Eval("OSPRINCIPAL") %>'>
						</asp:TextBox><br />
						ETINTEREST:
						<asp:TextBox ID="ETINTERESTTextBox" runat="server" Text='<%# Eval("ETINTEREST") %>'>
						</asp:TextBox><br />
						AMOUNTDUE:
						<asp:TextBox ID="AMOUNTDUETextBox" runat="server" Text='<%# Eval("AMOUNTDUE") %>'>
						</asp:TextBox><br />
						JFETPENALTY:
						<asp:TextBox ID="JFETPENALTYTextBox" runat="server" Text='<%# Eval("JFETPENALTY") %>'>
						</asp:TextBox><br />
						JFETADMIN:
						<asp:TextBox ID="JFETADMINTextBox" runat="server" Text='<%# Eval("JFETADMIN") %>'>
						</asp:TextBox><br />
						JFETOTHERFEE:
						<asp:TextBox ID="JFETOTHERFEETextBox" runat="server" Text='<%# Eval("JFETOTHERFEE") %>'>
						</asp:TextBox><br />
						JFAMOUNTDUE:
						<asp:TextBox ID="JFAMOUNTDUETextBox" runat="server" Text='<%# Eval("JFAMOUNTDUE") %>'>
						</asp:TextBox><br />
						JFOSPRINCIPAL:
						<asp:TextBox ID="JFOSPRINCIPALTextBox" runat="server" Text='<%# Eval("JFOSPRINCIPAL") %>'>
						</asp:TextBox><br />
						JFETINTEREST:
						<asp:TextBox ID="JFETINTERESTTextBox" runat="server" Text='<%# Eval("JFETINTEREST") %>'>
						</asp:TextBox><br />
						<asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
							Text="Insert">
						</asp:LinkButton>
						<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
							Text="Cancel">
						</asp:LinkButton>
					</InsertItemTemplate>
					<ItemTemplate>
						<table cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td class="HeaderStyle">
									Item</td>
								<td class="HeaderStyle" style="text-align: right">
									Current Value</td>
								<td class="HeaderStyle" style="text-align: right">
									JF Value</td>
							</tr>
							<tr>
								<td class="FooterStyle">
									OS <asp:Label ID="lblPrincipalOS" runat="server" Text='<%# Eval("CATPRINCIPAL") %>'></asp:Label></td>
								<td style="text-align: right">
									<asp:Label ID="OSPRINCIPALLabel" runat="server" Text='<%# Eval("OSPRINCIPAL", "{0:N}") %>'></asp:Label></td>
								<td style="text-align: right">
									<asp:Label ID="JFOSPRINCIPALLabel" runat="server" Text='<%# Eval("JFOSPRINCIPAL", "{0:N}") %>'></asp:Label></td>
							</tr>
							<tr>
								<td class="FooterStyle">
									ET <asp:Label ID="lblInterestET" runat="server" Text='<%# Eval("CATINTEREST") %>'></asp:Label></td>
								<td style="text-align: right" class="AlternatingRowStyle">
									<asp:Label ID="ETINTERESTLabel" runat="server" Text='<%# Eval("ETINTEREST", "{0:N}") %>'></asp:Label></td>
								<td style="text-align: right" class="AlternatingRowStyle">
									<asp:Label ID="JFETINTERESTLabel" runat="server" Text='<%# Eval("JFETINTEREST", "{0:N}") %>'></asp:Label></td>
							</tr>
							<tr>
								<td class="FooterStyle">
									ET Penalty</td>
								<td style="text-align: right">
									<asp:Label ID="ETPENALTYLabel" runat="server" Text='<%# Eval("ETPENALTY", "{0:N}") %>'></asp:Label></td>
								<td style="text-align: right">
									<asp:Label ID="JFETPENALTYLabel" runat="server" Text='<%# Eval("JFETPENALTY", "{0:N}") %>'></asp:Label></td>
							</tr>
							<tr>
								<td class="FooterStyle">
									ET Admin</td>
								<td style="text-align: right" class="AlternatingRowStyle">
									<asp:Label ID="ETADMINLabel" runat="server" Text='<%# Eval("ETADMIN", "{0:N}") %>'></asp:Label></td>
								<td style="text-align: right" class="AlternatingRowStyle">
									<asp:Label ID="JFETADMINLabel" runat="server" Text='<%# Eval("JFETADMIN", "{0:N}") %>'></asp:Label></td>
							</tr>
							<tr>
								<td class="FooterStyle">
									ET Other Fee</td>
								<td style="text-align: right">
									<asp:Label ID="ETOTHERFEELabel" runat="server" Text='<%# Eval("ETOTHERFEE", "{0:N}") %>'></asp:Label></td>
								<td style="text-align: right">
									<asp:Label ID="JFETOTHERFEELabel" runat="server" Text='<%# Eval("JFETOTHERFEE", "{0:N}") %>'></asp:Label></td>
							</tr>
							<tr>
								<td class="FooterStyle">
									Amount Due</td>
								<td style="text-align: right" class="AlternatingRowStyle">
									<asp:Label ID="AMOUNTDUELabel" runat="server" Text='<%# Eval("AMOUNTDUE", "{0:N}") %>'></asp:Label></td>
								<td style="text-align: right" class="AlternatingRowStyle">
									<asp:Label ID="JFAMOUNTDUELabel" runat="server" Text='<%# Eval("JFAMOUNTDUE", "{0:N}") %>'></asp:Label></td>
							</tr>
						</table>
					</ItemTemplate>
				</asp:FormView>
				<asp:SqlDataSource ID="sdsETUpload" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
					
                    
                    SelectCommand="SELECT ET.ETPENALTY, ET.ETADMIN, ET.ETOTHERFEE, ET.OSPRINCIPAL, ET.ETINTEREST, ET.AMOUNTDUE, ET.JFETPENALTY, ET.JFETADMIN, ET.JFETOTHERFEE, ET.JFAMOUNTDUE, ET.JFOSPRINCIPAL, ET.JFETINTEREST, dbo.f_getTermPrincipal(ACCOUNT.FINCATID) AS CATPRINCIPAL, dbo.f_getTermInterest(ACCOUNT.FINCATID) AS CATINTEREST FROM ET INNER JOIN ACCOUNT WITH (NOLOCK) ON ACCOUNT.LOCID = ET.LOCID AND ACCOUNT.ACCID = ET.ACCID WHERE (ET.ENTRYSOURCE = 2) AND (ET.LOCID = @LOCID) AND (ET.ACCID = @ACCID) AND (ET.ETID = @ETID)">
					<SelectParameters>
						<asp:ControlParameter ControlID="txtLocID" Name="LOCID" PropertyName="Value" />
                        <asp:ControlParameter ControlID="txtAccID" Name="ACCID" PropertyName="Value" />
                        <asp:ControlParameter ControlID="txtETID" Name="ETID" PropertyName="Value" />
					</SelectParameters>
				</asp:SqlDataSource>
			</td>
		</tr>
		<tr>
			<td class="ShowDetail" colspan="3" style="text-align: center">
				ET CALCULATION</td>
		</tr>
		<tr>
			<td class="HeaderStyle">
				INSTALLMENT DUE until
				<asp:Label ID="lblDueUntil" runat="server"></asp:Label>
			</td>
			<td class="HeaderStyle">
				Overdue Values</td>
			<td class="HeaderStyle">
				<asp:Label ID="lblOverdueWaive" runat="server">Waive Overdue Values</asp:Label>
			</td>
		</tr>
		<tr>
			<td class="RowStyle">
				<asp:Label ID="lblPrincipalDue" runat="server"></asp:Label> Due (q)</td>
			<td class="RowStyle">
				<asp:TextBox ID="txtPrincipalDue" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
			<td class="RowStyle">
				<asp:TextBox ID="txtWaivePrincipalDue" runat="server" CssClass="required"
					Style="text-align: right" Width="120px" ValidationGroup="ViewAcc" 
                     autocomplete="off" ReadOnly="True"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqWaivePrincipalDue" runat="server"
						ControlToValidate="txtWaivePrincipalDue" Display="None" ErrorMessage="Principal Overdue Waive must be entry...!"
						SetFocusOnError="True" ValidationGroup="ViewAcc"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender
							ID="reqWaivePrincipalDue_ValidatorCalloutExtender" runat="server" 
                    HighlightCssClass="ErrHighLight" TargetControlID="reqWaivePrincipalDue">
						</ajaxToolkit:ValidatorCalloutExtender>
			</td>
		</tr>
		<tr>
			<td class="RowStyle">
				<asp:Label ID="lblInterestDue" runat="server"></asp:Label> Due (r)</td>
			<td class="RowStyle">
				<asp:TextBox ID="txtInterestDue" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
			<td class="RowStyle">
				<asp:TextBox ID="txtWaiveInterestDue" runat="server" CssClass="required"
					Style="text-align: right" Width="120px" ValidationGroup="ViewAcc" 
                    autocomplete="off" ReadOnly="True"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqWaiveInterestDue" runat="server"
						ControlToValidate="txtWaiveInterestDue" Display="None" ErrorMessage="Interest Overdue Waive must be entry...!"
						SetFocusOnError="True" ValidationGroup="ViewAcc"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender
							ID="reqWaiveInterestDue_ValidatorCalloutExtender" runat="server" 
                    HighlightCssClass="ErrHighLight" TargetControlID="reqWaiveInterestDue">
						</ajaxToolkit:ValidatorCalloutExtender>
			</td>
		</tr>
		<tr>
			<td class="RowStyle">
				Installment Difference (f)</td>
			<td class="RowStyle">
					<asp:TextBox ID="txtInstDiffDue" runat="server" CssClass="disabled" Style="text-align: right"
						Width="120px" ReadOnly="True"></asp:TextBox></td>
			<td class="RowStyle">
					<asp:TextBox ID="txtWaiveInstDiffDue" runat="server" CssClass="required" Style="text-align: right"
						Width="120px" ValidationGroup="ViewAcc" ReadOnly="True"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqWaiveInstDiffDue" runat="server"
						ControlToValidate="txtWaiveInstDiffDue" Display="None" ErrorMessage="Installment Difference Overdue Waive must be entry...!"
						SetFocusOnError="True" ValidationGroup="ViewAcc"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender
							ID="reqWaiveInstDiffDue_ValidatorCalloutExtender" runat="server" 
                    HighlightCssClass="ErrHighLight" TargetControlID="reqWaiveInstDiffDue">
						</ajaxToolkit:ValidatorCalloutExtender>
			</td>
		</tr>
		<tr>
			<td class="RowStyle">
				<asp:Label ID="lblPenalty" runat="server"></asp:Label> &nbsp;Due (s)</td>
			<td class="RowStyle">
				<asp:TextBox ID="txtPenaltyDue" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
			<td class="RowStyle">
				<asp:TextBox ID="txtWaivePenaltyDue" runat="server" CssClass="required"
					Style="text-align: right" Width="120px" ValidationGroup="ViewAcc" autocomplete="off" 
                    ReadOnly="True"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqWaivePenaltyDue" runat="server"
						ControlToValidate="txtWaivePenaltyDue" Display="None" ErrorMessage="Penalty Overdue Waive must be entry...!"
						SetFocusOnError="True" ValidationGroup="ViewAcc"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender
							ID="reqWaivePenaltyDue_ValidatorCalloutExtender" runat="server" 
                    HighlightCssClass="ErrHighLight" TargetControlID="reqWaivePenaltyDue">
						</ajaxToolkit:ValidatorCalloutExtender>
			</td>
		</tr>
		<tr>
			<td class="FooterStyle">
				Total Installment Due (z) = (q + r + f + s)</td>
			<td class="FooterStyle">
				<asp:TextBox ID="txtInstallmentDue" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
			<td class="FooterStyle">
				<asp:TextBox ID="txtWaiveInstallmentDue" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
		</tr>
		<tr>
			<td class="HeaderStyle">
				EARLY TERMINATION VALUE</td>
			<td class="HeaderStyle" colspan="1">
				ET Values</td>
			<td colspan="1" class="HeaderStyle">
				Waive Values</td>
		</tr>
		<tr>
			<td class="FooterStyle">
				OS 
                <asp:Label ID="lblOSPrincipal" runat="server" 
                    Text='<%# Eval("CATPRINCIPAL") %>'></asp:Label> until
				<asp:Label ID="lblOSPrincipalUntil" runat="server"></asp:Label>
			&nbsp;(a)</td>
			<td class="RowStyle">
				<asp:TextBox ID="txtOSPrincipal" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
			<td class="AlternatingRowStyle">
				<asp:TextBox ID="txtWaiveOSPrincipal" runat="server" CssClass="required"
					Style="text-align: right" Width="120px" ValidationGroup="ViewAcc" 
                    autocomplete="off" ReadOnly="True"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqWaiveOSPrincipal" runat="server"
						ControlToValidate="txtWaiveOSPrincipal" Display="None" ErrorMessage="OS Principal Waive must be entry...!"
						SetFocusOnError="True" ValidationGroup="ViewAcc"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender
							ID="reqWaiveOSPrincipal_ValidatorCalloutExtender" runat="server" 
                    HighlightCssClass="ErrHighLight" TargetControlID="reqWaiveOSPrincipal">
						</ajaxToolkit:ValidatorCalloutExtender>
			</td>
		</tr>
		<tr>
			<td class="FooterStyle">
				OS <asp:Label ID="lblOSInterest" runat="server" 
                    Text='<%# Eval("CATINTEREST") %>'></asp:Label> until
				<asp:Label ID="lblOSInterestUntil" runat="server"></asp:Label>
			&nbsp;<asp:Label ID="lblCalcType2" runat="server" Text="(i)" Visible="False"></asp:Label>
			</td>
			<td class="RowStyle">
				<asp:TextBox ID="txtOSInterest" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
			<td class="AlternatingRowStyle">
				<asp:TextBox ID="txtWaiveOSInterest" runat="server" CssClass="required"
					Style="text-align: right" Width="120px" ValidationGroup="ViewAcc" 
                    autocomplete="off" ReadOnly="True"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqWaiveOSInterest" runat="server"
						ControlToValidate="txtWaiveOSInterest" Display="None" ErrorMessage="OS Interest Waive must be entry...!"
						SetFocusOnError="True" ValidationGroup="ViewAcc"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender
							ID="reqWaiveOSInterest_ValidatorCalloutExtender" runat="server" 
                    HighlightCssClass="ErrHighLight" TargetControlID="reqWaiveOSInterest">
						</ajaxToolkit:ValidatorCalloutExtender>
			</td>
		</tr>
		<tr>
			<td class="FooterStyle">
				ET <asp:Label ID="lblETInterest" runat="server" 
                    Text='<%# Eval("CATINTEREST") %>'></asp:Label> &nbsp;<asp:Label 
                    ID="lblCalcType1" runat="server" Text="(i)" Visible="False"></asp:Label>
                </td>
			<td class="RowStyle">
				<asp:TextBox ID="txtETInterest" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
			<td class="AlternatingRowStyle">
				<asp:TextBox ID="txtETInterestWaive" runat="server" CssClass="required" Style="text-align: right"
					Width="120px" autocomplete="off" ValidationGroup="ViewAcc"> </asp:TextBox>
                <asp:RequiredFieldValidator ID="reqETInterestWaive" runat="server"
						ControlToValidate="txtETInterestWaive" Display="None" ErrorMessage="ET Interest Waive must be entry...!"
						SetFocusOnError="True" ValidationGroup="ViewAcc"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
							ID="reqETInterestWaive_ValidatorCalloutExtender" runat="server" 
                    HighlightCssClass="ErrHighLight" TargetControlID="reqETInterestWaive">
						</ajaxToolkit:ValidatorCalloutExtender>
			</td>
		</tr>
		<tr>
			<td class="FooterStyle">
				ET 
				<asp:Label ID="lblETPenalty" runat="server"></asp:Label> (p)</td>
			<td class="RowStyle">
				<asp:TextBox ID="txtETPenalty" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
			<td class="AlternatingRowStyle">
				<asp:TextBox ID="txtETPenaltyWaive" runat="server" CssClass="required" Style="text-align: right"
					Width="120px" autocomplete="off" ValidationGroup="ViewAcc" ></asp:TextBox><asp:RequiredFieldValidator ID="reqPenaltyWaive" runat="server"
						ControlToValidate="txtETPenaltyWaive" Display="None" ErrorMessage="Penalty Waive must be entry...!"
						SetFocusOnError="True" ValidationGroup="ViewAcc"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
							ID="ajaxVCEPenaltyWaive" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPenaltyWaive">
						</ajaxToolkit:ValidatorCalloutExtender>
			</td>
		</tr>
		<tr>
			<td class="FooterStyle">
				ET Admin (m)</td>
			<td class="RowStyle">
				<asp:TextBox ID="txtETAdmin" runat="server" CssClass="disabled" ReadOnly="True" Style="text-align: right"
					Width="120px"></asp:TextBox></td>
			<td class="AlternatingRowStyle">
				<asp:TextBox ID="txtETAdminWaive" runat="server" CssClass="required" Style="text-align: right"
					Width="120px" autocomplete="off" ValidationGroup="ViewAcc"></asp:TextBox><asp:RequiredFieldValidator ID="reqAdminWaive" runat="server"
						ControlToValidate="txtETAdminWaive" Display="None" ErrorMessage="Admin Waive must be entry...!"
						SetFocusOnError="True" ValidationGroup="ViewAcc"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
								ID="ajaxVCEAdminWaive" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAdminWaive">
							</ajaxToolkit:ValidatorCalloutExtender>
			</td>
		</tr>
		<tr>
			<td class="FooterStyle">
				Other Fee (o)</td>
			<td class="RowStyle">
				<asp:TextBox ID="txtOtherFee" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
			<td class="AlternatingRowStyle">
			</td>
		</tr>
		<tr>
			<td class="FooterStyle">
				Deposit Account (d)</td>
			<td class="RowStyle">
				<asp:TextBox ID="txtDeposit" runat="server" CssClass="disabled" ReadOnly="True" Style="text-align: right"
					Width="120px"></asp:TextBox></td>
			<td class="AlternatingRowStyle">
			</td>
		</tr>
		<tr>
			<td colspan="3" class="required">
				<hr />
			</td>
		</tr>
		<tr>
			<td class="ErrHighLight">
				ET Value&nbsp; &nbsp;(v) = &nbsp;z + (a +i + p + m + o - d)</td>
			<td class="ErrHighLight">
				<asp:TextBox ID="txtETAmount" runat="server" CssClass="disabled" ReadOnly="True"
					Style="text-align: right" Width="120px"></asp:TextBox></td>
			<td class="ErrHighLight">
				<asp:TextBox ID="txtETAmountWaive" runat="server" CssClass="disabled" ReadOnly="True" Style="text-align: right"
					Width="120px"></asp:TextBox>(ET Value - Waive)</td>
		</tr>
		<tr>
			<td>
				Description</td>
			<td colspan="2">
				<asp:TextBox ID="txtDescription" runat="server" CssClass="disabled" Height="65px"
					ReadOnly="True" TextMode="MultiLine" Width="351px"></asp:TextBox></td>
		</tr>
		<tr>
			<td colspan="3" class="required">
				<hr />
			</td>
		</tr>
	</table>
	<asp:Panel ID="pnlProcess" runat="server" CssClass="HeaderStyle" Width="100%">
				<asp:Button ID="btnWaive" runat="server" OnClientClick="return ProcessET();" Style="background-position: right;
					background-image: url('../Images/Save.gif'); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Waive" Width="100px" 
                    ValidationGroup="ViewAcc" Visible="False"  />
                <asp:Button ID="btnApprove" runat="server" OnClientClick="return ProcessET();" Style="background-position: right;
					background-image: url(../Images/ok.png); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Approve" Width="100px" 
                    ValidationGroup="ViewAcc" Visible="False" />
                <asp:Button ID="btnReject" runat="server" Style="background-position: right;
					background-image: url(../Images/stop.png); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Reject" Width="100px" 
                    ValidationGroup="ViewAcc" Visible="False" CausesValidation="False" />
                <asp:Button ID="btnCancel" runat="server" CausesValidation="False" Style="background-position: right;
					background-image: url(../Images/back.png); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Back" Width="100px" OnClientClick="return BackET();" />
				<asp:Button ID="btnPrint" runat="server" OnClientClick="return PrintData();" 
					Style="background-position: right; background-image: url(../Images/print.jpg); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
					Text="Print Data" Width="100px" />
	</asp:Panel>
	<ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEProcess" runat="server" TargetControlID="pnlProcess"
		VerticalSide="Bottom">
	</ajaxToolkit:AlwaysVisibleControlExtender>
	<asp:Panel ID="pnlPayment" runat="server" Visible="False" Width="100%" GroupingText="Payment Process" Font-Bold="True" CssClass="ShowDetail">
		<table cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td class="HeaderStyle" colspan="2">
					TRANSACTION</td>
			</tr>
			<tr>
				<td class="RowStyle">
					ET Date (Terminate Date)</td>
				<td class="RowStyle">
					<asp:TextBox ID="txtValueDate" runat="server" CssClass="disabled" 
                        ReadOnly="True" Width="72px"></asp:TextBox>
				</td>
			</tr>
			<tr>
                <td class="RowStyle">
                    Value Date</td>
                <td class="RowStyle">
                    <asp:TextBox ID="txtPaidDate" runat="server" CssClass="required" Width="72px"></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="txtPaidDate_CalendarExtender" runat="server" 
                        Format="dd/MM/yyyy" PopupButtonID="imgValueDate" TargetControlID="txtPaidDate">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="txtPaidDate_MaskedEditExtender" runat="server" 
                        Mask="99/99/9999" MaskType="Date" TargetControlID="txtPaidDate">
                    </ajaxToolkit:MaskedEditExtender>
                    <asp:Image ID="imgValueDate" runat="server" ImageUrl="~/images/grid.gif" 
                        Style="cursor: pointer" ToolTip="Calendar" />
                    <asp:RequiredFieldValidator ID="reqPaidDate" runat="server" 
                        ControlToValidate="txtPaidDate" Display="None" 
                        ErrorMessage="VALUE DATE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEValueDate" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqPaidDate">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
			<tr>
                <td class="RowStyle">
                    Txn Type</td>
                <td class="RowStyle">
                    <asp:DropDownList ID="ddlTxnType" runat="server" CssClass="required" 
                        DataSourceID="sdsTxnType" DataTextField="TXNTYPE" DataValueField="CODE">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsTxnType" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        SelectCommand="SELECT NULL AS CODE, '[TXN TYPE]' AS TXNTYPE UNION ALL SELECT CODE, CODE + ' - ' + NAME AS TXNTYPE FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'TXNTYPE')">
                    </asp:SqlDataSource>
                    <asp:RequiredFieldValidator ID="reqPaymentType" runat="server" 
                        ControlToValidate="ddlTxnType" Display="None" 
                        ErrorMessage="PAYMENT TYPE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPaymentType" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqPaymentType">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
			<tr id="trBank">
				<td class="RowStyle">
					Bank Account No.</td>
				<td class="RowStyle">
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
				<td class="RowStyle">
					Currency</td>
				<td class="RowStyle">
					<asp:DropDownList ID="ddlCurrency" runat="server" CssClass="required" 
                        DataSourceID="sdsCurrency" DataTextField="CURRENCYNAME" 
                        DataValueField="CURRENCYID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsCurrency" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        
                        SelectCommand="SELECT CURRENCYID, CURRENCYCODE, CURRENCYCODE + ' - ' + CURRENCYNAME AS CURRENCYNAME FROM CURRENCY WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY CURRENCYCODE">
                    </asp:SqlDataSource>
                    <asp:RequiredFieldValidator ID="reqCurrency" runat="server" 
                        ControlToValidate="ddlCurrency" Display="None" 
                        ErrorMessage="[CURRENCY] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqCurrency_ValidatorCalloutExtender" 
                        runat="server" Enabled="True" HighlightCssClass="ErrHighLight" 
                        TargetControlID="reqCurrency">
                    </ajaxToolkit:ValidatorCalloutExtender>
				</td>
			</tr>
			<tr>
                <td class="RowStyle">
                    Amount Paid</td>
                <td class="RowStyle">
                    <asp:TextBox ID="txtAmount" runat="server" CssClass="required" 
                        Style="text-align: right" Width="120px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqAmount" runat="server" 
                        ControlToValidate="txtAmount" Display="None" 
                        ErrorMessage="AMOUNT must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEAmount" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqAmount">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
			<tr>
				<td class="RowStyle">
					Invoice No.</td>
				<td class="RowStyle">
					<asp:TextBox ID="txtInvoiceNo" runat="server" CssClass="required" Width="120px"></asp:TextBox><asp:RequiredFieldValidator
						ID="reqInvoiceNo" runat="server" ControlToValidate="txtInvoiceNo" Display="None"
						ErrorMessage="INVOICE NO must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
							ID="ajaxVCEInvoiceNo" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqInvoiceNo">
						</ajaxToolkit:ValidatorCalloutExtender>
				    <asp:Label ID="lblInvoiceNotFound" runat="server" CssClass="ErrHighLight" 
                        Font-Bold="True" ForeColor="Red"></asp:Label>
                    <asp:HiddenField ID="hidInvPaperID" runat="server" />
				</td>
			</tr>
			<tr id="trCardBank" style="display:none;">
                <td>
                    Bank</td>
                <td>
                    <asp:DropDownList ID="ddlBank" runat="server" CssClass="required" 
                        DataSourceID="sdsbank" DataTextField="BANKNAME" DataValueField="BANKID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsbank" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        
                        SelectCommand="SELECT NULL AS BANKID, NULL AS BANKCODE, '[CHOOSE BANK] ' AS BANKNAME UNION ALL SELECT BANKID, BANKCODE, '(' + BANKCODE + ') ' + BANKNAME AS BANKNAME FROM BANK WITH (NOLOCK) ORDER BY BANKCODE">
                    </asp:SqlDataSource>
                    <asp:RequiredFieldValidator ID="reqBankAcc" runat="server" 
                        ControlToValidate="ddlAccountNo" Display="None" 
                        ErrorMessage="BANK ACCOUNT NO must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqBankAcc_ValidatorCalloutExtender" 
                        runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBankAcc">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr id="trCardHolder" style="display:none;">
                <td>
                    Card Holder</td>
                <td>
                    <asp:TextBox ID="txtCardHolder" runat="server" CssClass="required" 
                        Width="250px" MaxLength="70"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqCardHolder" runat="server" 
                        ControlToValidate="txtCardHolder" Display="None" 
                        ErrorMessage="CARD HOLDER must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqCardHolder_ValidatorCalloutExtender" 
                        runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCardHolder">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr id="trCardType" style="display:none;" >
                <td>
                    Card Type</td>
                <td>
                    <asp:DropDownList ID="ddlCardType" runat="server" CssClass="required" 
                        DataSourceID="sdsCardType" DataTextField="NAMECARD" DataValueField="CODE">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="reqCardType" runat="server" 
                        ControlToValidate="ddlCardType" Display="None" 
                        ErrorMessage="CARD TYPE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqCardType_ValidatorCalloutExtender" 
                        runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCardType">
                    </ajaxToolkit:ValidatorCalloutExtender>
                    <asp:SqlDataSource ID="sdsCardType" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        
                        
                        SelectCommand="SELECT NULL AS CODE, '[CHOOSE CARD TYPE]' AS NAMECARD UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAMECARD FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'CARDTYPE')">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr id="trCardNo" style="display:none;">
                <td>
                    Card No.</td>
                <td>
                    <asp:TextBox ID="txtCardNo" runat="server" CssClass="required" 
                        Width="150px" MaxLength="50"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqCardNO" runat="server" 
                        ControlToValidate="txtCardNo" Display="None" 
                        ErrorMessage="CARD NUMBER must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="VCE_CardNo" 
                        runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCardNO">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
			<tr id="trCardExp" style="display:none;">
                <td>
                    Card Expired Date</td>
                <td>
                    <asp:TextBox ID="txtCardExpiredDt" runat="server" CssClass="required" 
                        Width="72px"></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="txtCardExpiredDt_CalendarExtender" runat="server" 
                        Format="dd/MM/yyyy" PopupButtonID="imgCardExpDate" 
                        TargetControlID="txtCardExpiredDt">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="txtCardExpiredDt_MaskedEditExtender" runat="server" 
                        Mask="99/99/9999" MaskType="Date" TargetControlID="txtCardExpiredDt">
                    </ajaxToolkit:MaskedEditExtender>
                    <asp:Image ID="imgCardExpDate" runat="server" ImageUrl="~/images/grid.gif" 
                        Style="cursor: pointer" ToolTip="Calendar" />
                    <asp:RequiredFieldValidator ID="reqCardExpDt" runat="server" 
                        ControlToValidate="txtCardExpiredDt" Display="None" 
                        ErrorMessage="CARD EXPIRED DATE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqCardExpDt_ValidatorCalloutExtender" 
                        runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCardExpDt">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr id="trCardAddFee" style="display:none;">
                <td>
                    Additional Fee</td>
                <td>
                    <asp:TextBox ID="txtAddFee" runat="server" autocomplete="off" 
                        CssClass="required" Style="text-align: right" Width="120px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqAddFee" runat="server" 
                        ControlToValidate="txtAddFee" Display="None" 
                        ErrorMessage="ADDITIONAL FEE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqAddFee_ValidatorCalloutExtender" 
                        runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAddFee">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
			<tr>
                <td>
                    Collection Fee</td>
                <td>
                    <asp:TextBox ID="txtCollectFee" runat="server" autocomplete="off" 
                        CssClass="required" Style="text-align: right" Width="120px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqCollectFee" runat="server" 
                        ControlToValidate="txtCollectFee" Display="None" 
                        ErrorMessage="COLLECTION FEE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqCollectFee_ValidatorCalloutExtender" 
                        runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCollectFee">
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
					text-align: left; " Text="Paid" Width="88px" 
                        ValidationGroup="ViewAcc" />
                    <asp:Button ID="btnRejectPay" runat="server" Style="background-position: right;
					background-image: url(../Images/stop.png); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Reject" Width="88px" 
                        ValidationGroup="ViewAcc" CausesValidation="False"  />
                    <asp:Button ID="btnBackPay" runat="server" CausesValidation="False" Style="background-position: right;
					background-image: url(../Images/back.png); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Back" Width="88px" 
                        OnClientClick="return BackET();" /></td>
			</tr>
		</table>
	</asp:Panel>
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />

<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript" src="../include/datefromvb.js"></script>
<script type="text/javascript">
    window.onload = function () {
        TabToEnter();
        var sAction = GetValueTxtByClientID("<%=txtAction.ClientID%>");
        if (sAction == "PAY")
            TxnTypeChange();
    }
    function preventBack() { window.history.forward(); }
    setTimeout("preventBack()", 10);
    window.onunload = function () { null };
  
FormatTable("<%=gvInstallment.ClientID%>");
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


function CalcETWaive() {

    var OSPrincipalWaive = 0;
    var InstallmentDue = 0;
    var PrincipalWaive = 0;
    var InterestWaive = 0;
    var PenaltyWaive = 0;
    var InstDiffWaive = 0;
    
    var DecPoint = GetValueTxtByClientID("<%=hidDecPoint.ClientID%>");
    var sAction = GetValueTxtByClientID("<%=txtAction.ClientID%>");
	var ETAmount=toNumeric(GetValueTxtByClientID("<%=txtETAmount.ClientID%>"));
	var AdminWaive=toNumeric(GetValueTxtByClientID("<%=txtETAdminWaive.ClientID%>"));
	var ETPenaltyWaive=toNumeric(GetValueTxtByClientID("<%=txtETPenaltyWaive.ClientID%>"));
	var ETInterestWaive = toNumeric(GetValueTxtByClientID("<%=txtETInterestWaive.ClientID%>"));

	var OSInterestWaive = toNumeric(GetValueTxtByClientID("<%=txtWaiveOSInterest.ClientID%>"));
	
	var oETWaive = getObjectbyClientID("<%=txtETAmountWaive.ClientID%>");

	var ETCalcType = GetValueTxtByClientID("<%=hidETCALC.ClientID%>"); 

	if ((sAction == "WAIVESPV") || (sAction == "PAY") || (sAction == "INQ")) {
	    
	    OSPrincipalWaive = toNumeric(GetValueTxtByClientID("<%=txtWaiveOSPrincipal.ClientID%>"));

	    InstallmentDue = toNumeric(GetValueTxtByClientID("<%=txtInstallmentDue.ClientID%>"));
	    PrincipalWaive = toNumeric(GetValueTxtByClientID("<%=txtWaivePrincipalDue.ClientID%>"));
	    InterestWaive = toNumeric(GetValueTxtByClientID("<%=txtWaiveInterestDue.ClientID%>"));
	    PenaltyWaive = toNumeric(GetValueTxtByClientID("<%=txtWaivePenaltyDue.ClientID%>"));
	    InstDiffWaive = toNumeric(GetValueTxtByClientID("<%=txtWaiveInstDiffDue.ClientID%>"));

	    var oInstallmentWaive = getObjectbyClientID("<%=txtWaiveInstallmentDue.ClientID%>");
	    oInstallmentWaive.value = FormatNumber(InstallmentDue - PrincipalWaive - InterestWaive - PenaltyWaive - InstDiffWaive, 'True', DecPoint);

	}
	if (ETCalcType == "2")
	    oETWaive.value = FormatNumber(ETAmount - AdminWaive - ETPenaltyWaive - OSInterestWaive - OSPrincipalWaive - PrincipalWaive - InterestWaive - PenaltyWaive - InstDiffWaive, 'True', DecPoint);
	else
	    oETWaive.value = FormatNumber(ETAmount - AdminWaive - ETPenaltyWaive - ETInterestWaive - OSPrincipalWaive - PrincipalWaive - InterestWaive - PenaltyWaive - InstDiffWaive, 'True', DecPoint);
}

function CheckProcess() {
    var sAction = GetValueTxtByClientID("<%=txtAction.ClientID%>");

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

    var oETInterestWaive = getObjectbyClientID("<%=txtETInterestWaive.ClientID%>");
    var ETInterest = toNumeric(GetValueTxtByClientID("<%=txtETInterest.ClientID%>"));
    if (toNumeric(oETInterestWaive.value) > ETInterest) {
        alert("ET Interest Waive is greater than original ET Interest..!");
        oETInterestWaive.className = "ErrHighLight";
        oETInterestWaive.focus();
        return false;
    }

    if (sAction == "WAIVESPV") {

        var oOSPrincipal = getObjectbyClientID("<%=txtWaiveOSPrincipal.ClientID%>");
        var OSPrincipal = toNumeric(GetValueTxtByClientID("<%=txtOSPrincipal.ClientID%>"));
        if (toNumeric(oOSPrincipal.value) > OSPrincipal) {
            alert("OS Principal Waive is greater than original OS Principal..!");
            oOSPrincipal.className = "ErrHighLight";
            oOSPrincipal.focus();
            return false;
        }

        var oPrincipalDue = getObjectbyClientID("<%=txtWaivePrincipalDue.ClientID%>");
        var PrincipalDue = toNumeric(GetValueTxtByClientID("<%=txtPrincipalDue.ClientID%>"));
        if (toNumeric(oPrincipalDue.value) > PrincipalDue) {
            alert("Principal Due Waive is greater than original Principal Due..!");
            oPrincipalDue.className = "ErrHighLight";
            oPrincipalDue.focus();
            return false;
        }

        var oInterestDue = getObjectbyClientID("<%=txtWaiveInterestDue.ClientID%>");
        var InterestDue = toNumeric(GetValueTxtByClientID("<%=txtInterestDue.ClientID%>"));
        if (toNumeric(oInterestDue.value) > InterestDue) {
            alert("Interest Due Waive is greater than original Interest Due..!");
            oInterestDue.className = "ErrHighLight";
            oInterestDue.focus();
            return false;
        }

        var oPenaltyDue = getObjectbyClientID("<%=txtWaivePenaltyDue.ClientID%>");
        var PenaltyDue = toNumeric(GetValueTxtByClientID("<%=txtPenaltyDue.ClientID%>"));
        if (toNumeric(oPenaltyDue.value) > PenaltyDue) {
            alert("Penalty Due Waive is greater than original Penalty Due..!");
            oPenaltyDue.className = "ErrHighLight";
            oPenaltyDue.focus();
            return false;
        }

        var oInstDiffDue = getObjectbyClientID("<%=txtWaiveInstDiffDue.ClientID%>");
        var InstDiffDue = toNumeric(GetValueTxtByClientID("<%=txtInstDiffDue.ClientID%>"));
        if (toNumeric(oInstDiffDue.value) > InstDiffDue) {
            alert("Instalment Difference Due Waive is greater than original Instalment Difference Due..!");
            oInstDiffDue.className = "ErrHighLight";
            oInstDiffDue.focus();
            return false;
        }
    }
	return true;
}

function ProcessET() {
    if (Page_ClientValidate("")) {
        if (!CheckProcess()) return false;
    } else {
        return false;
    }
	return true;
}

function CheckTxnType() {
    var TxnType = GetValueTxtByClientID("<%=ddlTxnType.ClientID%>");
    if (TxnType == "2") {
        ValidatorEnable(getObjectbyClientID("<%=reqBankAcc.ClientID%>"), true);
        var oAcc = getObjectbyClientID("<%=ddlAccountNo.ClientID%>");
        if (oAcc.value == "") {
            alert("[BANK ACCOUNT NO.] must be entry...!");
            oAcc.className = "ErrHighLight";
            oAcc.focus();
            return false;
        }
    } else {
        ValidatorEnable(getObjectbyClientID("<%=reqBankAcc.ClientID%>"), false);
    }
    return true;
}


function ProcessETPay() {
    if (Page_ClientValidate("")) {
        if (!CheckValueDate()) return false;
        if (!CheckProcess()) return false;
        if (!CheckTxnType()) return false;
        if (!CheckDate()) return false;
        if (!AmountCheck()) return false;
        if (GetValueTxtByClientID("<%=hidINVOICECHECK.ClientID%>") == "1") {
            alert("INVOICE NUMBER MUST BE REGISTERED...!\nTRANSACTION CAN NOT BE PROCEED..!");
            return (false);
        }

    } else {
        return (false);
    }
	return (true);
}
function BackET(){
    if ((GetValueTxtByClientID("<%=txtAction.ClientID%>") == "INQ") || (GetValueTxtByClientID("<%=txtAction.ClientID%>") == "PAY")) {
       // window.location = "ETInqList.aspx?Flag=1&Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") 
		window.history.back(-1);
		return false;
	}
	return true;
}

function TxnTypeChange() {
    var TxnType = GetValueTxtByClientID("<%=ddlTxnType.ClientID%>");
    var oPlcHolder = getObjectbyClientID("trCardHolder");
    var oCardType = getObjectbyClientID("trCardType");
    var oCardNo = getObjectbyClientID("trCardNo");
    var oCardBank = getObjectbyClientID("trCardBank");
    var oCardExp = getObjectbyClientID("trCardExp");
    var oCardAddFee = getObjectbyClientID("trCardAddFee");



    if (TxnType) {
        EnabledValidator(false);
        //isian bank di disable dulu
        var oDiv = getObjectbyClientID("trBank");
        oDiv.style.display = "none";
        ValidatorEnable(getObjectbyClientID("<%=reqBankAcc.ClientID%>"), false);

        if (TxnType == "2") {
            oDiv.style.display = "";
            oCardNo.style.display = "none";
            oPlcHolder.style.display = "none";
            oCardType.style.display = "none";
            oCardBank.style.display = "none";
            oCardExp.style.display = "none";
            oCardAddFee.style.display = "none";
            ValidatorEnable(getObjectbyClientID("<%=reqBankAcc.ClientID%>"), true);
        } else if (TxnType == "3") {
            oPlcHolder.style.display = "";
            oCardType.style.display = "";
            oCardNo.style.display = "";
            oCardBank.style.display = "";
            oCardExp.style.display = "";
            oCardAddFee.style.display = "";
            EnabledValidator(true);
        } else if (TxnType == "4") {
            oPlcHolder.style.display = "";
            oCardNo.style.display = "";
            oCardBank.style.display = "";
            oCardExp.style.display = "";
            oCardAddFee.style.display = "";
            oCardType.style.display = "none";
            EnabledValidator(true);
            ValidatorEnable(getObjectbyClientID("<%=reqCardType.ClientID%>"), false);
        } else {
            var oAcc = getObjectbyClientID("<%=ddlAccountNo.ClientID%>");
            oAcc.value = "";
            oDiv.style.display = "none";
            oCardNo.style.display = "none";
            oPlcHolder.style.display = "none";
            oCardType.style.display = "none";
            oCardBank.style.display = "none";
            oCardExp.style.display = "none";
            oCardAddFee.style.display = "none";
        }
    }
}

function EnabledValidator(bvalid) {
    ValidatorEnable(getObjectbyClientID("<%=reqCardHolder.ClientID%>"), bvalid);
    ValidatorEnable(getObjectbyClientID("<%=reqCardType.ClientID%>"), bvalid);
    ValidatorEnable(getObjectbyClientID("<%=reqCardExpDt.ClientID%>"), bvalid);
    ValidatorEnable(getObjectbyClientID("<%=reqAddFee.ClientID%>"), bvalid);
    ValidatorEnable(getObjectbyClientID("<%=reqCardNO.ClientID%>"), bvalid);
    //ValidatorEnable(getObjectbyClientID("<%=reqBankAcc.ClientID%>"), bvalid);
}

function AmountCheck(){
	var AmountET=toNumeric(GetValueTxtByClientID("<%=txtETAmountWaive.ClientID%>"));
	var oAmount=getObjectbyClientID("<%=txtAmount.ClientID%>");
	if (toNumeric(oAmount.value)<toNumeric(AmountET)){
	    //alert("AMOUNT PAID Input must be equal or greate than ET VALUE...!");
	    if (confirm("AMOUNT PAID less than ET VALUE...!\nDo you want to continue and save into DEPOSIT..?")) {
	        return true;
	    } else {
	        oAmount.className = "ErrHighLight";
	        oAmount.focus();
	        return false;
	    }
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
function ViewDetailAcc(LOCID, APPID){
	var winref = window.open("../Account/AccInqFrame.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
	winref.focus();
}

function PrintData() {    
	var LOCID = GetValueTxtByClientID("<%=txtLocID.ClientID%>");
	var ACCID = GetValueTxtByClientID("<%=txtAccID.ClientID%>");
	var ETID = GetValueTxtByClientID("<%=txtETID.ClientID%>");
	//if (Page_ClientValidate("")) {
		var winref = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/ETAccountDisplay&LOCID=" + LOCID + "&ACCID=" + ACCID + "&ETID=" + ETID, "ETDisplay", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
		winref.focus();
	//}
	return false;
}

function ConvertDDMMYYYY(sDate) {
	var arrDate = sDate.split("/")
	return (arrDate[2] + "-" + arrDate[1] + "-" + arrDate[0]);

}

function IsTypeChange() {
    var TypeID = GetValueTxtByClientID("<%=ddlTxnType.ClientID%>");
    var oLOCID = GetValueTxtByClientID("<%=txtLocID.ClientID%>");
    var oACCID = GetValueTxtByClientID("<%=txtAccID.ClientID%>");
    var oAmount = getObjectbyClientID("<%=txtAmount.ClientID%>");
    if (TypeID == "7") {
        ButtonProcessNOK();
        ret = GHWService.GETACCUnposting(oLOCID, oACCID, 4, OnCompleteType, OnTimeOutType, OnErrorType);
    } else {
        ButtonProcessOK();
        oAmount.className = "required"
        oAmount.readOnly = false;
        oAmount.value = "0";
    }

    function OnTimeOutType(arg) {
        SetToCash();
        alert("TimeOut encountered when calling IsTxnType.");
    }
    function OnErrorType(arg) {
        SetToCash();
        alert("Error encountered when calling IsTxnType.");
    }
    function OnCompleteType(arg) {
        var arrArg = arg.split("|")
        var TypeID = getObjectbyClientID("<%=ddlTxnType.ClientID%>");
        var oAmount = getObjectbyClientID("<%=txtAmount.ClientID%>");
        var oLocidUN = getObjectbyClientID("<%=txtLocidUN.ClientID%>");
        var oUnknownId = getObjectbyClientID("<%=txtUnknownId.ClientID%>");
        var oAllocateID = getObjectbyClientID("<%=txtAllocateID.ClientID%>");

        ButtonProcessOK();

        if (arg != "0") {
            oAmount.className = "disabled";
            oLocidUN.value = arrArg[1];
            oUnknownId.value = arrArg[2];
            SetValueTxtByClientID("<%=txtAmount.ClientID%>", FormatNumber(arrArg[3], "True", 2));
            oAllocateID.value = arrArg[4];
            oAmount.readOnly = true;

        } else {
            oAmount.readOnly = false;
            TypeID.selectedIndex = 1;
            oAmount.className = "required";
            alert("Payment Unknown Allocated does not Or Payment Unknown Allocated Already Posted");
        }
    }


}



function SetToCash() {
    var TypeID = getObjectbyClientID("<%=ddlTxnType.ClientID%>");
    if (TypeID)
        TypeID.selectedIndex = 1;

    ButtonProcessOK();
    var oAmount = getObjectbyClientID("<%=txtAmount.ClientID%>");
    if (oAmount) {
        oAmount.readOnly = false;
        oAmount.className = "required";
    }

}

function CheckInvoice() {
    ButtonProcessNOK();
    var sINVOICENO = GetValueTxtByClientID("<%=txtInvoiceNo.ClientID%>");
    var sUID = GetValueTxtByClientID("<%=txtUID.ClientID%>");
    ret = GHWService.GETCheckInvoice(sINVOICENO, sUID, OnCompleteCheckInvoice, OnTimeCheckInvoice, OnErrorCheckInvoice);
}


function OnCompleteCheckInvoice(arg) {
    var arrArg = arg.split("|")
    var oINVOICENO = getObjectbyClientID("<%=txtInvoiceNo.ClientID%>");
    var oInvNotFound = getObjectbyClientID("<%=lblInvoiceNotFound.ClientID%>");


    if (arrArg[1] == "1") {
        ValidatorEnable(getObjectbyClientID("<%=reqInvoiceNo.ClientID%>"), true);
        oInvNotFound.style.display = "";
        oInvNotFound.innerHTML = arrArg[2];
    } else {
        ValidatorEnable(getObjectbyClientID("<%=reqInvoiceNo.ClientID%>"), false);
        oInvNotFound.style.display = "";
        oInvNotFound.innerHTML = arrArg[2];
    }
    SetInvPaperID(arrArg[0]);
    SetInvoiceCheck(arrArg[1]);
    ButtonProcessOK();
}

function OnTimeCheckInvoice(arg) {
    SetInvPaperID("");
    SetInvoiceCheck("0");
    var oInvNotFound = getObjectbyClientID("<%=lblInvoiceNotFound.ClientID%>");
    if (oInvNotFound) {
        oInvNotFound.style.display = "";
        oInvNotFound.textContent = "TIME OUT CHECKING INVOICE NUMBER IN DATABASE SERVER";
        oInvNotFound.innerHTML = "TIME OUT CHECKING INVOICE NUMBER IN DATABASE SERVER";
    }
    alert("TimeOut encountered when calling Check Invoice.");
    ButtonProcessOK();
}

function OnErrorCheckInvoice(arg) {
    SetInvPaperID("");
    SetInvoiceCheck("0");
    var oInvNotFound = getObjectbyClientID("<%=lblInvoiceNotFound.ClientID%>");
    if (oInvNotFound) {
        oInvNotFound.style.display = "";
        oInvNotFound.textContent = "ERROR CHECKING INVOICE NUMBER IN DATABASE SERVER";
        oInvNotFound.innerHTML = "ERROR CHECKING INVOICE NUMBER IN DATABASE SERVER";
    }
    alert("Error encountered when calling Check Invoice.");
    ButtonProcessOK();
}

function ButtonProcessOK() {
    var obtnProcess = getObjectbyClientID("<%=btnProcess.ClientID%>");
    if (obtnProcess)
        obtnProcess.disabled = false;
}

function SetInvPaperID(sValue) {
    var oInvPaperID = getObjectbyClientID("<%=hidInvPaperID.ClientID%>");
    if (oInvPaperID)
        oInvPaperID.value = sValue;
}

function SetInvoiceCheck(sValue) {
    var oInvCheck = getObjectbyClientID("<%=hidINVOICECHECK.ClientID%>");
    if (oInvCheck)
        oInvCheck.value = sValue;
}


function ButtonProcessNOK() {
    var obtnProcess = getObjectbyClientID("<%=btnProcess.ClientID%>");
    if (obtnProcess)
        obtnProcess.disabled = true;
}


function CheckValueDate() {
    var ApplDate = GetValueTxtByClientID("<%=hidAPPDATE.ClientID%>");
    var ddlTxnType = GetValueTxtByClientID("<%=ddlTxnType.ClientID%>");
    var hidSPV = GetValueTxtByClientID("<%=hidSPV.ClientID%>");
    if (ddlTxnType == "1")
        var BackDay = toNumeric(GetValueTxtByClientID("<%=hidBackCash.ClientID%>"));
    else if (ddlTxnType == "2") {
        var BackDay = toNumeric(GetValueTxtByClientID("<%=hidBackBank.ClientID%>"));
    }
    else
        var BackDay = toNumeric(GetValueTxtByClientID("<%=hidBackCash.ClientID%>"));

    if (ApplDate != "") {
        var oValueDate = getObjectbyClientID("<%=txtValueDate.ClientID%>");
        var oPaidDate = getObjectbyClientID("<%=txtPaidDate.ClientID%>");


        if (oPaidDate.value == "")
            return false;

        var ValueDate = ConvertToDate(oValueDate.value); //ET DATE
        var PaidDate = ConvertToDate(oPaidDate.value);      
        var Today = ConvertToDate(ApplDate);

        if (PaidDate > Today) {
            alert("Value Date cannot be future date...!");
            oPaidDate.className = "ErrHighLight";
            oPaidDate.focus();
            return false;
        } else {
            oPaidDate.className = "required";
        }

        if (PaidDate > ValueDate) {
            alert("Value Date cannot greater than ET Date (Terminate Date)...!");
            oPaidDate.className = "ErrHighLight";
            oPaidDate.focus();
            return false;
        } else {
            oPaidDate.className = "required";
        }


        if (hidSPV != "1") {
            
            if (ddlTxnType == "1") {
                var BackDate = DateAdd("d", BackDay * -1, Today);
                if (PaidDate < BackDate) {
                    alert("Value date cannot back dated more than " + BackDay.toString() + " day(s)...!");
                    oPaidDate.className = "ErrHighLight";
                    oPaidDate.focus();
                    return false;
                } else {
                    oPaidDate.className = "required";
                }
            }

            if (ddlTxnType == "2") {
                var BackDate = DateAdd("d", BackDay * -1, Today);
                if (PaidDate < BackDate) {
                    alert("Value date cannot back dated more than " + BackDay.toString() + " day(s)...!");
                    oPaidDate.className = "ErrHighLight";
                    oPaidDate.focus();
                    return false;
                } else {
                    oPaidDate.className = "required";
                }
            }
        }
    }
    return true;
}

</script>
</asp:Content>

