<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccRSDisplay.aspx.vb" Inherits="Account_AccRSEntry" title="Account PPAP Reschedul Entry" MaintainScrollPositionOnPostback="true" EnableEventValidation="false"%>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<%@ Register src="../UserControl/DataAccountFromParamAccIDOS.ascx" tagname="DataAccountFromParamAccIDOS" tagprefix="uc2" %>
<%@ Register src="../UserControl/CollectibilityParamAccID.ascx" tagname="CollectibilityParamAccID" tagprefix="uc3" %>
<%@ Register src="../UserControl/LoanDataFromParamAccID.ascx" tagname="loandatafromparamaccid" tagprefix="uc1" %>
<%@ Register src="../UserControl/InstallmentDataAll.ascx" tagname="InstallmentDataAll" tagprefix="uc4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:HiddenField ID="txtAction" runat="server" />
    <asp:HiddenField ID="hidLocID" runat="server" />
    <asp:HiddenField ID="hidAccID" runat="server" /><asp:HiddenField ID="hidRSID" runat="server" />
    <asp:HiddenField ID="hidTxnDate" runat="server" />
    <asp:HiddenField ID="hidRSTYPE" runat="server" />
    <uc2:DataAccountFromParamAccIDOS ID="ctlDataAccountFromParamAccIDOS" 
        runat="server" />
    <asp:Panel ID="pnlLoanShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgLoanData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblLoanData" runat="server" CssClass="required">(Show Loan Data...)</asp:Label>
        </div>
        <input id="Button5" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <asp:Panel ID="pnlLoanData" runat="server"  Width="100%">
        <uc1:LoanDataFromParamAccID ID="ctlLoanDataFromParamAccID" runat="server" />
    </asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPELoanData" runat="server" CollapseControlID="pnlLoanShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Loan Data...)" Enabled="True"
        ExpandControlID="pnlLoanShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Loan Data...)"
        ImageControlID="imgLoanData" TargetControlID="pnlLoanData" TextLabelID="lblLoanData">
    </ajaxToolkit:CollapsiblePanelExtender>
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
    <asp:Panel ID="pnlCollectData" runat="server"  Width="100%">
        <uc3:CollectibilityParamAccID ID="ctlCollectibilityParamAccID" runat="server" />
    </asp:Panel>
    <asp:Panel ID="pnlInstShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgInstData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblInstData" runat="server" CssClass="required">(Show Installment Data...)</asp:Label>
        </div>
        <input id="Button2" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" language="javascript" /></asp:Panel>
    <asp:Panel ID="pnlInstData" runat="server"  Width="100%">
        <asp:Button ID="btnPrintLoan" runat="server" 
            OnClientClick="return PrintLoan();" 
            Style="background-position: right; background-image: url('../Images/print.jpg'); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
            Text="Print Installment Data" Width="150px" />
        <asp:Button ID="btnPrintInst" runat="server" 
            OnClientClick="return PrintInst();" 
            Style="background-position: right; background-image: url('../Images/print.jpg'); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
            Text="Print Installment History" Width="150px" />
        <uc4:InstallmentDataAll ID="ctlInstallmentDataAll" runat="server" />
    </asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEInst" runat="server" CollapseControlID="pnlInstShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Installment Data...)" Enabled="True"
        ExpandControlID="pnlInstShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Installment Data...)"
        ImageControlID="imgInstData" TargetControlID="pnlInstData" TextLabelID="lblInstData">
    </ajaxToolkit:CollapsiblePanelExtender>
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="RowStyle">
                <asp:FormView ID="fvRSInfo" runat="server" Caption="RESCHEDULE INFO" DataSourceID="sdsRSInfo"
                    Width="100%">
                    <EditItemTemplate>
                        RSTXNDATE:
                        <asp:TextBox ID="RSTXNDATETextBox" runat="server" Text='<%# Eval("RSTXNDATE") %>'>
                        </asp:TextBox><br />
                        OSPRINCIPALCURRENT:
                        <asp:TextBox ID="OSPRINCIPALCURRENTTextBox" runat="server" Text='<%# Eval("OSPRINCIPALCURRENT") %>'>
                        </asp:TextBox><br />
                        OSTENORCURRENT:
                        <asp:TextBox ID="OSTENORCURRENTTextBox" runat="server" Text='<%# Eval("OSTENORCURRENT") %>'>
                        </asp:TextBox><br />
                        OLDEFFRATE:
                        <asp:TextBox ID="OLDEFFRATETextBox" runat="server" Text='<%# Eval("OLDEFFRATE") %>'>
                        </asp:TextBox><br />
                        NEWEFFRATE:
                        <asp:TextBox ID="NEWEFFRATETextBox" runat="server" Text='<%# Eval("NEWEFFRATE") %>'>
                        </asp:TextBox><br />
                        OLDFLATRATE:
                        <asp:TextBox ID="OLDFLATRATETextBox" runat="server" Text='<%# Eval("OLDFLATRATE") %>'>
                        </asp:TextBox><br />
                        NEWFLATRATE:
                        <asp:TextBox ID="NEWFLATRATETextBox" runat="server" Text='<%# Eval("NEWFLATRATE") %>'>
                        </asp:TextBox><br />
                        OLDINSTALLMENT:
                        <asp:TextBox ID="OLDINSTALLMENTTextBox" runat="server" Text='<%# Eval("OLDINSTALLMENT") %>'>
                        </asp:TextBox><br />
                        NEWINSTALLMENT:
                        <asp:TextBox ID="NEWINSTALLMENTTextBox" runat="server" Text='<%# Eval("NEWINSTALLMENT") %>'>
                        </asp:TextBox><br />
                        OLDINTERESTTOTAL:
                        <asp:TextBox ID="OLDINTERESTTOTALTextBox" runat="server" Text='<%# Eval("OLDINTERESTTOTAL") %>'>
                        </asp:TextBox><br />
                        NEWINTERESTTOTAL:
                        <asp:TextBox ID="NEWINTERESTTOTALTextBox" runat="server" Text='<%# Eval("NEWINTERESTTOTAL") %>'>
                        </asp:TextBox><br />
                        RSSTATUS:
                        <asp:TextBox ID="RSSTATUSTextBox" runat="server" Text='<%# Eval("RSSTATUS") %>'>
                        </asp:TextBox><br />
                        RSSTATUSDATE:
                        <asp:TextBox ID="RSSTATUSDATETextBox" runat="server" Text='<%# Eval("RSSTATUSDATE") %>'>
                        </asp:TextBox><br />
                        RSSTATUSNAME:
                        <asp:TextBox ID="RSSTATUSNAMETextBox" runat="server" Text='<%# Eval("RSSTATUSNAME") %>'>
                        </asp:TextBox><br />
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                            Text="Update">
                        </asp:LinkButton>
                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                            Text="Cancel">
                        </asp:LinkButton>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        RSTXNDATE:
                        <asp:TextBox ID="RSTXNDATETextBox" runat="server" Text='<%# Eval("RSTXNDATE") %>'>
                        </asp:TextBox><br />
                        OSPRINCIPALCURRENT:
                        <asp:TextBox ID="OSPRINCIPALCURRENTTextBox" runat="server" Text='<%# Eval("OSPRINCIPALCURRENT") %>'>
                        </asp:TextBox><br />
                        OSTENORCURRENT:
                        <asp:TextBox ID="OSTENORCURRENTTextBox" runat="server" Text='<%# Eval("OSTENORCURRENT") %>'>
                        </asp:TextBox><br />
                        OLDEFFRATE:
                        <asp:TextBox ID="OLDEFFRATETextBox" runat="server" Text='<%# Eval("OLDEFFRATE") %>'>
                        </asp:TextBox><br />
                        NEWEFFRATE:
                        <asp:TextBox ID="NEWEFFRATETextBox" runat="server" Text='<%# Eval("NEWEFFRATE") %>'>
                        </asp:TextBox><br />
                        OLDFLATRATE:
                        <asp:TextBox ID="OLDFLATRATETextBox" runat="server" Text='<%# Eval("OLDFLATRATE") %>'>
                        </asp:TextBox><br />
                        NEWFLATRATE:
                        <asp:TextBox ID="NEWFLATRATETextBox" runat="server" Text='<%# Eval("NEWFLATRATE") %>'>
                        </asp:TextBox><br />
                        OLDINSTALLMENT:
                        <asp:TextBox ID="OLDINSTALLMENTTextBox" runat="server" Text='<%# Eval("OLDINSTALLMENT") %>'>
                        </asp:TextBox><br />
                        NEWINSTALLMENT:
                        <asp:TextBox ID="NEWINSTALLMENTTextBox" runat="server" Text='<%# Eval("NEWINSTALLMENT") %>'>
                        </asp:TextBox><br />
                        OLDINTERESTTOTAL:
                        <asp:TextBox ID="OLDINTERESTTOTALTextBox" runat="server" Text='<%# Eval("OLDINTERESTTOTAL") %>'>
                        </asp:TextBox><br />
                        NEWINTERESTTOTAL:
                        <asp:TextBox ID="NEWINTERESTTOTALTextBox" runat="server" Text='<%# Eval("NEWINTERESTTOTAL") %>'>
                        </asp:TextBox><br />
                        RSSTATUS:
                        <asp:TextBox ID="RSSTATUSTextBox" runat="server" Text='<%# Eval("RSSTATUS") %>'>
                        </asp:TextBox><br />
                        RSSTATUSDATE:
                        <asp:TextBox ID="RSSTATUSDATETextBox" runat="server" Text='<%# Eval("RSSTATUSDATE") %>'>
                        </asp:TextBox><br />
                        RSSTATUSNAME:
                        <asp:TextBox ID="RSSTATUSNAMETextBox" runat="server" Text='<%# Eval("RSSTATUSNAME") %>'>
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
                                <td class="ErrHighLight">
                                    Reschedule Type</td>
                                <td class="ErrHighLight">
                                    (<asp:Label ID="Label23" runat="server" 
                                        style="font-weight: 700; text-decoration: underline" 
                                        Text='<%# Eval("RSTYPE") %>'></asp:Label>)
                                    <asp:Label ID="Label18" runat="server" 
                                        style="font-weight: 700; text-decoration: underline" 
                                        Text='<%# Eval("RSTYPENAME") %>'></asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="required">
                                    RS Txn Date</td>
                                <td class="required">
                                    <asp:Label ID="RSTXNDATELabel" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("RSTXNDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Status</td>
                                <td>
                                    (<asp:Label ID="RSSTATUSLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Eval("RSSTATUS") %>'></asp:Label>)
                                    <asp:Label ID="RSSTATUSNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Eval("RSSTATUSNAME") %>'></asp:Label></td>
                                <td>
                                    Status Date</td>
                                <td>
                                    <asp:Label ID="RSSTATUSDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Eval("RSSTATUSDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                    OS
                                    <asp:Label ID="lblOSPrincipalCurrent" runat="server" 
                                        Text='<%# Eval("CATPRINCIPAL") %>'></asp:Label>
                                    &nbsp;Current</td>
                                <td>
                                    <asp:Label ID="OSPRINCIPALCURRENTLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Eval("OSPRINCIPALCURRENT", "{0:N}") %>'></asp:Label></td>
                                <td>
                                    OS Tenor Current</td>
                                <td>
                                    <asp:Label ID="OSTENORCURRENTLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Eval("OSTENORCURRENT") %>'></asp:Label></td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td class="ShowDetail">
                                    ITEM</td>
                                <td class="ShowDetail" style="text-align: right">
                                    OLD VALUE</td>
                                <td class="ShowDetail" style="text-align: right">
                                    NEW VALUE</td>
                            </tr>
                            <tr>
                                <td class="HeaderStyle">
                                    Installment Day</td>
                                <td style="text-align: right">
                                    <asp:Label ID="Label24" runat="server" 
                                        style="font-weight: 700; text-decoration: underline" 
                                        Text='<%# Eval("OLDINSTALLMENTDAY") %>'></asp:Label>
                                </td>
                                <td class="FooterStyle" style="text-align: right">
                                    <asp:Label ID="Label25" runat="server" 
                                        style="font-weight: 700; text-decoration: underline" 
                                        Text='<%# Eval("NEWINSTALLMENTDAY") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="HeaderStyle">
                                    <asp:Label ID="lblEffectiveRate" runat="server" 
                                        Text='<%# Eval("CATEFFECTIVE") %>'></asp:Label>
                                </td>
                                <td style="text-align: right">
                                    <asp:Label ID="OLDEFFRATELabel" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("OLDEFFRATE") %>'></asp:Label>
                                    %</td>
                                <td class="FooterStyle" style="text-align: right">
                                    <asp:Label ID="NEWEFFRATELabel" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("NEWEFFRATE") %>'></asp:Label>
                                    %</td>
                            </tr>
                            <tr>
                                <td class="HeaderStyle">
                                    Flat Rate</td>
                                <td style="text-align: right">
                                    <asp:Label ID="OLDFLATRATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Eval("OLDFLATRATE") %>'></asp:Label>
                                    %</td>
                                <td class="FooterStyle" style="text-align: right">
                                    <asp:Label ID="NEWFLATRATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Eval("NEWFLATRATE") %>'></asp:Label>
                                    %</td>
                            </tr>
                            <tr>
                                <td class="HeaderStyle">
                                    Tenor</td>
                                <td style="text-align: right">
                                    <asp:Label ID="Label19" runat="server" 
                                        style="font-weight: 700; text-decoration: underline" 
                                        Text='<%# Eval("OLDTENOR") %>'></asp:Label>
                                </td>
                                <td class="FooterStyle" style="text-align: right">
                                    <asp:Label ID="Label20" runat="server" 
                                        style="font-weight: 700; text-decoration: underline" 
                                        Text='<%# Eval("NEWTENOR") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="HeaderStyle">
                                    <asp:Label ID="lblPrincipal" runat="server" Text='<%# Eval("CATPRINCIPAL") %>'></asp:Label>
                                </td>
                                <td style="text-align: right">
                                    <asp:Label ID="Label21" runat="server" 
                                        style="font-weight: 700; text-decoration: underline" 
                                        Text='<%# Eval("OLDPRINCIPAL", "{0:N}") %>'></asp:Label>
                                </td>
                                <td class="FooterStyle" style="text-align: right">
                                    <asp:Label ID="Label22" runat="server" 
                                        style="font-weight: 700; text-decoration: underline" 
                                        Text='<%# Eval("NEWPRINCIPAL", "{0:N}") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="HeaderStyle">
                                    Installment</td>
                                <td style="text-align: right">
                                    <asp:Label ID="OLDINSTALLMENTLabel" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("OLDINSTALLMENT", "{0:N}") %>'></asp:Label>
                                </td>
                                <td class="FooterStyle" style="text-align: right">
                                    <asp:Label ID="NEWINSTALLMENTLabel" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("NEWINSTALLMENT", "{0:N}") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr style='visibility:<%# IIF(Eval("RSSTATUS")=1, "visible", "hidden") %>'>
                                <td class="HeaderStyle">
                                    <asp:Label ID="lblInterestTotal" runat="server" 
                                        Text='<%# Eval("CATINTEREST") %>'></asp:Label>
                                    &nbsp;Total</td>
                                <td style="text-align: right">
                                    <asp:Label ID="OLDINTERESTTOTALLabel" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("OLDINTERESTTOTAL", "{0:N}") %>'></asp:Label>
                                </td>
                                <td class="FooterStyle" style="text-align: right">
                                    <asp:Label ID="NEWINTERESTTOTALLabel" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("NEWINTERESTTOTAL", "{0:N}") %>'></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="sdsRSInfo" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    
                    
                    
                    
                    
                    SelectCommand="SELECT RESCHEDULE.RSTXNDATE, RESCHEDULE.OSPRINCIPALCURRENT, RESCHEDULE.OSTENORCURRENT, RESCHEDULE.OLDEFFRATE, RESCHEDULE.NEWEFFRATE, RESCHEDULE.OLDFLATRATE, RESCHEDULE.NEWFLATRATE, RESCHEDULE.OLDINSTALLMENT, RESCHEDULE.NEWINSTALLMENT, RESCHEDULE.OLDINTERESTTOTAL, RESCHEDULE.NEWINTERESTTOTAL, RESCHEDULE.RSSTATUS, RESCHEDULE.RSSTATUSDATE, dbo.f_getParamGlobalName('WOSTATUS', RESCHEDULE.RSSTATUS) AS RSSTATUSNAME, RESCHEDULE.OLDTENOR, RESCHEDULE.NEWTENOR, RESCHEDULE.OLDPRINCIPAL, RESCHEDULE.NEWPRINCIPAL, RESCHEDULE.RSTYPE, dbo.f_getParamGlobalName('RSTYPE', RESCHEDULE.RSTYPE) AS RSTYPENAME, dbo.f_getTermPrincipal(ACCOUNT.FINCATID) AS CATPRINCIPAL, dbo.f_getTermInterest(ACCOUNT.FINCATID) AS CATINTEREST, dbo.f_getTermEffective(ACCOUNT.FINCATID) AS CATEFFECTIVE, RESCHEDULE.OLDINSTALLMENTDAY, RESCHEDULE.NEWINSTALLMENTDAY, RESCHEDULE.INTERESTACCRUE, RESCHEDULE.INTERESTACCRUEPAIDSTS, RESCHEDULE.INTERESTPAIDTXNDATE, CASE WHEN RESCHEDULE.INTERESTACCRUEPAIDSTS = 0 THEN 'NO' ELSE 'YES' END AS INTERESTACCRUEPAIDSTSNAME FROM RESCHEDULE INNER JOIN ACCOUNT WITH (NOLOCK) ON RESCHEDULE.LOCID = ACCOUNT.LOCID AND RESCHEDULE.ACCID = ACCOUNT.ACCID WHERE (RESCHEDULE.LOCID = @LOCID) AND (RESCHEDULE.ACCID = @ACCID) AND (RESCHEDULE.RSID = @RSID)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
                        <asp:QueryStringParameter Name="ACCID" QueryStringField="ACCID" />
                        <asp:QueryStringParameter Name="RSID" QueryStringField="RSID" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                <asp:DataList ID="dlRSPayment" runat="server" Caption="RESCHEDULE PAYMENT" 
                    DataSourceID="sdsRSInfo" Visible="False" Width="100%">
                    <ItemTemplate>
                        <table cellpadding="0" cellspacing="0" style="width: 100%;">
                            <tr>
                                <td>
                                    Interest Accrue Amount</td>
                                <td>
                                    <asp:Label ID="INTERESTACCRUELabel" runat="server" 
                                        Text='<%# Eval("INTERESTACCRUE", "{0:N}") %>' />
                                </td>
                                <td>
                                    Paid Status</td>
                                <td>
                                    <asp:Label ID="INTERESTACCRUEPAIDSTSLabel" runat="server" 
                                        Text='<%# Eval("INTERESTACCRUEPAIDSTSNAME") %>' />
                                </td>
                                <td>
                                    Paid Txn Date</td>
                                <td>
                                    <asp:Label ID="INTERESTPAIDTXNDATELabel" runat="server" 
                                        Text='<%# Eval("INTERESTPAIDTXNDATE", "{0:dd/MM/yyyy}") %>' />
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
            </td>
        </tr>
        <tr>
            <td>
		<asp:Panel ID="pnlPayment" runat="server" Width="100%" 
            GroupingText="Reschedule Payment" CssClass="RowStyle" Visible="False">
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
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPaymentType" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqPaymentType">
                        </ajaxToolkit:ValidatorCalloutExtender>
					</td>
				</tr>
			    <tr ID="trBank">
                    <td class="FooterStyle">
                        Bank Account No.</td>
                    <td class="FooterStyle">
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
			    <tr ID="trBank">
                    <td class="FooterStyle">
                        <asp:Button ID="btnPaid" runat="server" OnClientClick="return ProcessApp();" 
                            Style="background-position: right; background-image: url(../Images/ok.png); cursor: pointer; background-repeat: no-repeat; text-align: left;" 
                            Text="Paid" ValidationGroup="ValApp" Visible="False" Width="88px" />
                    </td>
                    <td class="FooterStyle">
                        &nbsp;</td>
                </tr>
			</table>
		</asp:Panel>
		    </td>
        </tr>
        <tr>
            <td class="RowStyle" style="height: 19px">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="RowStyle" style="height: 19px">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="RowStyle" style="height: 19px">
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
        <asp:Button ID="btnApprove" runat="server" OnClientClick='return(confirm("Are you sure want to APPROVE Reschedule Account..?"));' Style="background-position: right;
            background-image: url(../Images/ok.png); cursor: pointer; background-repeat: no-repeat;
             text-align: left" Text="Approve" ValidationGroup="ViewAcc"
            Visible="False" Width="88px" />&nbsp;<asp:Button ID="btnReject" runat="server" CausesValidation="False"
                Style="background-position: right; background-image: url(../Images/stop.png);
                cursor: pointer; background-repeat: no-repeat;  text-align: left"
                Text="Reject" ValidationGroup="ViewAcc" Visible="False" Width="88px" OnClientClick='return(confirm("Are you sure want to REJECT Reschedule Account..?"));' />
        <asp:Button ID="btnCancel" runat="server" CausesValidation="False" OnClientClick="return BackEdit();"
            Style="background-position: right; background-image: url(../Images/back.png);
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Back" Width="88px" />
        <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" Font-Bold="True"
            Visible="False"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblMessage">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
            </asp:Panel>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEBorrow" runat="server" TargetControlID="pnlSave"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
    <script type="text/javascript">
    function getObjectbyClientID(ClientID) {
        var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        return (oObject);
    }
    function GetValueTxtByClientID(ClientID){
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
        if (oText)
            return(oText.value);
    }
    
    function ViewDetailAcc(LOCID, APPID){
        var winref = window.open("AccInqFrame.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable");
        winref.focus();
    }
    function BackEdit(){
    //if ((GetValueTxtByClientID("<%=txtAction.ClientID%>")=="INQ") || (GetValueTxtByClientID("<%=txtAction.ClientID%>")=="PAY")){
        //window.history.back(-1);
        window.location="AccRSInqList.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>")
        return false;
    //}
    return true;
}

function PrintLoan() {
    var LOCID = GetValueTxtByClientID("<%=hidLocID.ClientID%>");
    var ACCID = GetValueTxtByClientID("<%=hidAccID.ClientID%>");
    var TXNDATE = GetValueTxtByClientID("<%=hidTxnDate.ClientID%>");
    var winref = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/InstallmentAccount&LOCID=" + LOCID + "&ACCID=" + ACCID + "&TXNDATE=" + TXNDATE, "PrintInstData", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
    winref.focus();
    return false;
}
function PrintInst() {
    var LOCID = GetValueTxtByClientID("<%=hidLocID.ClientID%>");
    var ACCID = GetValueTxtByClientID("<%=hidAccID.ClientID%>");
    var winref = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/Installment_History&LOCID=" + LOCID + "&ACCID=" + ACCID, "PrintInstHist", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
    winref.focus();
    return false;
}

function TxnTypeChange() {
    var oTxn = getObjectbyClientID("<%=ddlTxnType.ClientID%>");
    if (oTxn) {
        var TxnType = GetValueTxtByClientID("<%=ddlTxnType.ClientID%>");
        var oDiv = getObjectbyClientID("trBank");
        if (TxnType == "1") {
            var oAcc = getObjectbyClientID("<%=ddlAccountNo.ClientID%>");
            oAcc.value = "";
            oDiv.style.display = "none";
        } else {
            oDiv.style.display = "";
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

function ProcessApp() {
    if (Page_ClientValidate("ValApp")) {
        if (!CheckTxnType()) return false;
    }
    return true;
}

    </script>
    
</asp:Content>

