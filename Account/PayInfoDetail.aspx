<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="PayInfoDetail.aspx.vb" Inherits="Account_PayInfoDetail" title="Payment Activity Info" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<%@ Register src="../UserControl/LoanDataFromParamAccID.ascx" tagname="LoanDataFromParamAccID" tagprefix="uc3" %>
<%@ Register src="../UserControl/DataAccountFromParamAccID.ascx" tagname="DataAccountFromParamAccID" tagprefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:ScriptManagerProxy ID="SMPPayment" runat="server">
	<Services>
	<asp:ServiceReference Path="GHWService.asmx" />
	</Services>
	</asp:ScriptManagerProxy>
    <asp:HiddenField ID="hidACTION" runat="server" />
    <asp:HiddenField ID="hidLOCIDPAY" runat="server" />
    <asp:HiddenField ID="hidPAYID" runat="server" />
    <asp:HiddenField ID="hidUID" runat="server" />
    <asp:Panel ID="pnlAccShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgAccData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblAccData" runat="server" CssClass="required">(Show Account Data...)</asp:Label>
        </div>
        <input id="Button1" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <asp:Panel ID="pnlAccData" runat="server" CssClass="FooterStyle" Width="100%">
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
    <asp:Panel ID="pnlLoanData" runat="server"  Width="100%">
        <uc3:LoanDataFromParamAccID ID="ctlLoanDataFromParamAccID" runat="server" />
    </asp:Panel>
    <asp:DataList ID="dlTxn" runat="server" Caption="PAYMENT TRANSACTION INFO" DataKeyField="LOCIDPAY"
        DataSourceID="sdsPayment" Width="100%">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td class="FooterStyle">
                        LOC ID PAY</td>
                    <td class="FooterStyle">
            <asp:Label ID="LOCIDPAYLabel" runat="server" Text='<%# Eval("LOCIDPAY") %>' Font-Bold="True" Font-Underline="True"></asp:Label></td>
                    <td class="FooterStyle">
                        PAY ID</td>
                    <td class="FooterStyle">
            <asp:Label ID="PAYIDLabel" runat="server" Text='<%# Eval("PAYID") %>' Font-Bold="True" Font-Underline="True"></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Payment Currency</td>
                    <td>
                        (<asp:Label ID="Label52" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("CURRENCYCODE") %>'></asp:Label>)
                        <asp:Label ID="Label53" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("CURRENCYNAME") %>'></asp:Label>
                    </td>
                    <td>
                        Invoice No</td>
                    <td>
                        <asp:Label ID="INVOICENOLabel" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("INVOICENO") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="ErrHighLight">
                        Payment Type</td>
                    <td class="ErrHighLight">
                        (<asp:Label ID="PAYMENTTYPELabel" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("PAYMENTTYPE") %>'></asp:Label>)
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("PAYMENTTYPENAME") %>'></asp:Label>
                    </td>
                    <td class="ErrHighLight">
                        Txn Type</td>
                    <td class="ErrHighLight">
                        (<asp:Label ID="TXNTYPELabel" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("TXNTYPE") %>'></asp:Label>)
                        <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("TXNTYPENAME") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        Paid Date</td>
                    <td>
            <asp:Label ID="PAIDDATELabel" runat="server" Text='<%# Eval("PAIDDATE", "{0:dd/MM/yyyy}") %>' Font-Bold="True" Font-Underline="True"></asp:Label></td>
                    <td>
                        Paid Txn Date</td>
                    <td>
            <asp:Label ID="PAIDTXNDATELabel" runat="server" Text='<%# Eval("PAIDTXNDATE", "{0:dd/MM/yyyy}") %>' Font-Bold="True" Font-Underline="True"></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Bank
                    </td>
                    <td>
                        (<asp:Label ID="BANKCODELabel" runat="server" Text='<%# Eval("BANKCODE") %>' Font-Bold="True" Font-Underline="True"></asp:Label>)
            <asp:Label ID="BANKNAMELabel" runat="server" Text='<%# Eval("BANKNAME") %>' Font-Bold="True" Font-Underline="True"></asp:Label></td>
                    <td>
                        Bank
                        Account No</td>
                    <td>
            <asp:Label ID="ACCOUNTNOLabel" runat="server" Text='<%# Eval("ACCOUNTNO") %>' Font-Bold="True" Font-Underline="True"></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Amount</td>
                    <td>
            <asp:Label ID="AMOUNTLabel" runat="server" Text='<%# Eval("AMOUNT", Eval("DECPOINT")) %>' 
                            Font-Bold="True" Font-Underline="True"></asp:Label></td>
                    <td>
                        Amount Original</td>
                    <td>
                        <asp:Label ID="AMOUNTLabel0" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("AMOUNTORI",Eval("DECPOINT")) %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        Additional Fee</td>
                    <td>
                        <asp:Label ID="Label54" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("ADDITIONALFEE", Eval("DECPOINT")) %>'></asp:Label>
                    </td>
                    <td>
                        Collection Fee</td>
                    <td>
                        <asp:Label ID="Label55" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("COLLECTIONFEE", Eval("DECPOINT")) %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        Deposit</td>
                    <td>
                        <asp:Label ID="DEPOSITLabel" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("DEPOSIT", Eval("DECPOINT")) %>'></asp:Label>
                    </td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="ShowDetail">
                        Reversal Info</td>
                    <td class="required" colspan="3">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Reversal Status</td>
                    <td>
                        <asp:Label ID="REVSTATUSLabel" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("REVSTATUSNAME") %>'></asp:Label>
                    </td>
                    <td>
                        Reversal Date</td>
                    <td>
                        <asp:Label ID="REVDATELabel" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("REVDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <hr />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList><asp:SqlDataSource ID="sdsPayment" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT PAYMENT.LOCIDPAY, PAYMENT.PAYID, PAYMENT.PAYMENTTYPE, PAYMENT.PAIDDATE, PAYMENT.PAIDTXNDATE, PAYMENT.TXNTYPE, BANKACCOUNT.ACCOUNTNO, BANK.BANKCODE, BANK.BANKNAME, PAYMENT.AMOUNT, PAYMENT.INVOICENO, CASE WHEN PAYMENT.REVSTATUS = 0 THEN 'NO' ELSE 'YES' END AS REVSTATUSNAME, PAYMENT.REVSTATUS, PAYMENT.REVDATE, PAYMENT.DEPOSIT, PAYMENT.INSTDIFF, dbo.f_getParamGlobalName('PAYMENTTYPE', PAYMENT.PAYMENTTYPE) AS PAYMENTTYPENAME, dbo.f_getParamGlobalName('TXNTYPE', PAYMENT.TXNTYPE) AS TXNTYPENAME, CURRENCY.CURRENCYCODE, CURRENCY.CURRENCYNAME, PAYMENT.AMOUNTORI, PAYMENT.ADDITIONALFEE, PAYMENT.COLLECTIONFEE, dbo.f_getCurrencyDecPointForNet(CURRENCY.CURRENCYID) AS DECPOINT FROM CURRENCY LEFT OUTER JOIN PAYMENT WITH (NOLOCK) ON CURRENCY.CURRENCYID = PAYMENT.CURRENCYID LEFT OUTER JOIN BANK WITH (NOLOCK) INNER JOIN BANKACCOUNT WITH (NOLOCK) ON BANK.BANKID = BANKACCOUNT.BANKID ON PAYMENT.ACCOUNTID = BANKACCOUNT.ACCOUNTID WHERE (PAYMENT.LOCIDPAY = @LOCIDPAY) AND (PAYMENT.PAYID = @PAYID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="hidLOCIDPAY" Name="LOCIDPAY" 
                PropertyName="Value" />
            <asp:ControlParameter ControlID="hidPAYID" Name="PAYID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="gvPayment" runat="server" AutoGenerateColumns="False" Caption="DETAIL TRANSACTION PAYMENT INSTALLMENT INFO"
        DataKeyNames="LOCIDPAY,PAYID,INSTID" DataSourceID="sdsPaymentDetail" Width="100%" RowHeaderColumn="INSTID">
        <Columns>
            <asp:BoundField DataField="INSTID" HeaderText="INST&lt;BR&gt;ID" ReadOnly="True" SortExpression="INSTID" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="PERIOD" HeaderText="Period" SortExpression="PERIOD">
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="DUEDATE" HeaderText="Due&lt;br&gt;Date" SortExpression="DUEDATE" DataFormatString="{0:dd/MM/yyyy}" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Principal&lt;br&gt;Paid" 
                SortExpression="PRINCIPALPAID">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" 
                        Text='<%# EVAL("PRINCIPALPAID", Eval("DECPOINT")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Interest&lt;br&gt;Paid" 
                SortExpression="INTERESTPAID">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" 
                        Text='<%# EVAL("INTERESTPAID", Eval("DECPOINT")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Penalty&lt;br&gt;Paid" 
                SortExpression="PENALTYPAID">
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" 
                        Text='<%# EVAL("PENALTYPAID", Eval("DECPOINT")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Deposit" SortExpression="DEPOSIT">
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# EVAL("DEPOSIT", Eval("DECPOINT")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Installment&lt;br&gt;Diff." 
                SortExpression="INSTDIFF">
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# EVAL("INSTDIFF", Eval("DECPOINT")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            <uc1:NoDataFound ID="NoDataFound1" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsPaymentDetail" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT LOCIDPAY, PAYID, INSTID, DUEDATE, PRINCIPALPAID, INTERESTPAID, PENALTYPAID, DEPOSIT, INSTDIFF, (SELECT PERIOD FROM INSTALLMENT WITH (NOLOCK) WHERE (LOCID = PAYINSTALL.LOCID) AND (ACCID = PAYINSTALL.ACCID) AND (DUEDATE = PAYINSTALL.DUEDATE)) AS PERIOD, dbo.f_getCurrencyDecPointForNet((SELECT CURRENCYID FROM ACCOUNT WITH (NOLOCK) WHERE (LOCID = PAYINSTALL.LOCID) AND (ACCID = PAYINSTALL.ACCID))) AS DECPOINT FROM PAYINSTALL WITH (NOLOCK) WHERE (LOCIDPAY = @LOCIDPAY) AND (PAYID = @PAYID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="hidLOCIDPAY" Name="LOCIDPAY" 
                PropertyName="Value" />
            <asp:ControlParameter ControlID="hidPAYID" Name="PAYID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:DataList ID="dlET" runat="server" Caption="EARLY TERMINATION PAYMENT INFO" DataSourceID="sdsET"
        Width="100%">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td class="FooterStyle">
                        ET ID</td>
                    <td class="FooterStyle">
                        <asp:Label ID="ETIDLabel" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("ETID") %>'></asp:Label></td>
                    <td class="FooterStyle">
                        ET Status</td>
                    <td class="FooterStyle">
                        (<asp:Label ID="ETSTATUSLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ETSTATUS") %>'></asp:Label>)
                        <asp:Label ID="ETSTATUSNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ETSTATUSNAME") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        ET DATE</td>
                    <td>
                        <asp:Label ID="ETDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ETDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                    <td>
                        ET Txn date</td>
                    <td>
                        <asp:Label ID="ETTXNDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ETTXNDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        OS <asp:Label ID="lblPrincipal" runat="server" Text='<%# Eval("CATPRINCIPAL") %>'></asp:Label></td>
                    <td>
                        <asp:Label ID="OSPRINCIPALLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("OSPRINCIPAL",Eval("DECPOINT")) %>'></asp:Label></td>
                    <td>
                        OS 
                        <asp:Label ID="lblPrincipal0" runat="server" Text='<%# Eval("CATPRINCIPAL") %>'></asp:Label>
                        &nbsp;Waive</td>
                    <td>
                        <asp:Label ID="Label43" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("OSPRINCIPALWAIVE", Eval("DECPOINT")) %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        ET
                        <asp:Label ID="lblInterest0" runat="server" Text='<%# Eval("CATINTEREST") %>'></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="Label44" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("ETINTEREST") %>'></asp:Label>
                    </td>
                    <td>
                        ET
                        <asp:Label ID="lblInterest1" runat="server" Text='<%# Eval("CATINTEREST") %>'></asp:Label>
                        &nbsp;Waive</td>
                    <td>
                        <asp:Label ID="Label45" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("ETINTERESTWAIVE",Eval("DECPOINT")) %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        OS
                        <asp:Label ID="lblInterest" runat="server" Text='<%# Eval("CATINTEREST") %>'></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="OSINTERESTLabel" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("OSINTEREST", Eval("DECPOINT")) %>'></asp:Label>
                    </td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        ET Penalty</td>
                    <td>
                        <asp:Label ID="ETPENALTYLabel" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("ETPENALTY", Eval("DECPOINT")) %>'></asp:Label>
                    </td>
                    <td>
                        ET Penalty Waive</td>
                    <td>
                        <asp:Label ID="ETPENALTYWAIVELabel" runat="server" Font-Bold="True" 
                            Font-Underline="True" 
                            Text='<%# Eval("ETPENALTYWAIVE", Eval("DECPOINT")) %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        ET Admin</td>
                    <td>
                        <asp:Label ID="ETADMINLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ETADMIN", Eval("DECPOINT")) %>'></asp:Label></td>
                    <td>
                        ET Admin Waive</td>
                    <td>
                        <asp:Label ID="ETADMINWAIVELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ETADMINWAIVE", Eval("DECPOINT")) %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        ET Other Fee</td>
                    <td>
                        <asp:Label ID="ETOTHERFEELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ETOTHERFEE", Eval("DECPOINT")) %>'></asp:Label></td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        Amount Due</td>
                    <td colspan="3">
                        <asp:Label ID="AMOUNTDUELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("AMOUNTDUE", Eval("DECPOINT")) %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Description&nbsp;
                    </td>
                    <td colspan="3">
                        <asp:Label ID="ETDESCLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ETDESC") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <hr />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList><asp:SqlDataSource ID="sdsET" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT ET.ETID, ET.ETDATE, ET.ETTXNDATE, ET.ETSTATUS, ET.ETPENALTY, ET.ETPENALTYWAIVE, ET.ETADMIN, ET.ETADMINWAIVE, ET.ETOTHERFEE, ET.OSPRINCIPAL, ET.OSINTEREST, ET.ETINTEREST, ET.AMOUNTDUE, ET.ETDESC, dbo.f_getParamGlobalName('ETSTATUS', ET.ETSTATUS) AS ETSTATUSNAME, dbo.f_getTermPrincipal(ACCOUNT.FINCATID) AS CATPRINCIPAL, dbo.f_getTermEffective(ACCOUNT.FINCATID) AS CATEFFRATE, dbo.f_getTermInterest(ACCOUNT.FINCATID) AS CATINTEREST, ET.ETINTERESTWAIVE, ET.OSPRINCIPALWAIVE, dbo.f_getCurrencyDecPointForNet(ACCOUNT.CURRENCYID) AS DECPOINT FROM ET WITH (NOLOCK) INNER JOIN ACCOUNT WITH (NOLOCK) ON ET.LOCID = ACCOUNT.LOCID AND ET.ACCID = ACCOUNT.ACCID WHERE (ET.LOCID = @LOCID) AND (ET.ACCID = @ACCID) AND (ET.ETSTATUS IN (1, 2))">
        <SelectParameters>
            <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
            <asp:QueryStringParameter Name="ACCID" QueryStringField="ACCID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEProcess" runat="server" TargetControlID="pnlProcess"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>


    <asp:Panel ID="pnlProcess" runat="server" Width="100%">
        <table cellpadding="0" cellspacing="0" width="100%">
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
                <td colspan="3" class="FooterStyle">
        <asp:Button ID="btnClose" runat="server" CausesValidation="False" Style="cursor: pointer; "
            Text="Close" OnClientClick="window.close();" /><asp:Button ID="btnReverse" runat="server"
                CausesValidation="False" Style="background-position: right; background-image: url(../Images/undo.png);
                cursor: pointer; background-repeat: no-repeat; text-align: left; " Text="Reverse"
                Visible="False" OnClientClick='return confirm("are you sure want to reverse this transaction..?")' /><asp:Button ID="btnBack" runat="server" CausesValidation="False"
                    Style="background-position: right; background-image: url(../Images/back.png);
                    cursor: pointer; background-repeat: no-repeat; text-align: left; " Text="Back"
                    Visible="False" Width="64px" OnClientClick="return WinBack();" />
                    <asp:Label ID="lblPrint" runat="server" Text="Invoice No: " Visible="False"></asp:Label>
                    <asp:TextBox ID="txtInvoiceNo" runat="server" Visible="False" 
                        CssClass="required" ValidationGroup="ValInvoice" autocomplete="Off" ></asp:TextBox>
                    <asp:Label ID="lblInvoice" runat="server" CssClass="ErrHighLight" 
                        Font-Bold="True" ForeColor="Red"></asp:Label>
                    <asp:RequiredFieldValidator ID="reqInvoiceNo" runat="server" 
                        ControlToValidate="txtInvoiceNo" Display="None" 
                        ErrorMessage="[INVOICE NO] must be entry...!" SetFocusOnError="True" 
                        ValidationGroup="ValInvoice"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCENewPrincipal" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqInvoiceNo">
                    </ajaxToolkit:ValidatorCalloutExtender>
                    <asp:Button ID="btnPrint" runat="server" 
                        Style="background-position: right; background-image: url(../Images/print.jpg); cursor: pointer; background-repeat: no-repeat; text-align: left; " 
                        Text="Print" Visible="False" Width="64px" ValidationGroup="ValInvoice" />
                    <asp:HiddenField ID="hidINVPAPERID" runat="server" />
                    <asp:HiddenField ID="hidINVOICECHECK" runat="server" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <br />
    <br />
    <br />
    <br />
    <br />

<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvPayment.ClientID%>");
    function getObjectbyClientID(ClientID) {
        var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        return (oObject)
    }

    function SetValueTxtByClientID(ClientID, sValue) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            oText.value = sValue;
    }

    function GetValueTxtByClientID(ClientID) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            return (oText.value);
    }

function WinBack(){
    window.history.back(-1);
    return false;
}
function ViewDetailAcc(LOCID, APPID){
    var winref=window.open("../Account/AccInqFrame.aspx?Action=AccInq&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
    winref.focus();
}

function CheckInvoice() {
    ButtonProcessNOK();
    var oINVOICENO = GetValueTxtByClientID("<%=txtInvoiceNo.ClientID%>");
    var oUID = GetValueTxtByClientID("<%=hidUID.ClientID%>");
    ret = GHWService.GETCheckInvoice(oINVOICENO, oUID, OnCompleteCheckInvoice, OnTimeCheckInvoice, OnErrorCheckInvoice);
}


function OnCompleteCheckInvoice(arg) {
    var arrArg = arg.split("|")
    var oINVOICENO = getObjectbyClientID("<%=txtInvoiceNo.ClientID%>");
    var oInvNotFound = getObjectbyClientID("<%=lblInvoice.ClientID%>");


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
    var oInvNotFound = getObjectbyClientID("<%=lblInvoice.ClientID%>");
    if (oInvNotFound){
        oInvNotFound.style.display = "";
        oInvNotFound.textContent  = "TIME OUT CHECKING INVOICE NUMBER IN DATABASE SERVER";
        oInvNotFound.innerHTML = "TIME OUT CHECKING INVOICE NUMBER IN DATABASE SERVER";
    }
    alert("TimeOut encountered when calling Check Invoice.");
    ButtonProcessOK();
}

function OnErrorCheckInvoice(arg) {
    SetInvPaperID("");
    SetInvoiceCheck("0");
    var oInvNotFound = getObjectbyClientID("<%=lblInvoice.ClientID%>");
    if (oInvNotFound){
        oInvNotFound.style.display = "";
        oInvNotFound.textContent  = "ERROR CHECKING INVOICE NUMBER IN DATABASE SERVER";
        oInvNotFound.innerHTML = "ERROR CHECKING INVOICE NUMBER IN DATABASE SERVER";
    }
    alert("Error encountered when calling Check Invoice.");
    ButtonProcessOK();
}

function ButtonProcessOK() {
    var obtnProcess = getObjectbyClientID("<%=btnPrint.ClientID%>");
    if (obtnProcess)
        obtnProcess.disabled = false;
}

function SetInvPaperID(sValue) {
    var oInvPaperID = getObjectbyClientID("<%=hidINVPAPERID.ClientID%>");
    if (oInvPaperID)
        oInvPaperID.value = sValue;
}

function ButtonProcessNOK() {
    var obtnProcess = getObjectbyClientID("<%=btnPrint.ClientID%>");
    if (obtnProcess)
        obtnProcess.disabled = true;
}
function SetInvoiceCheck(sValue){
    var oInvCheck = getObjectbyClientID("<%=hidINVOICECHECK.ClientID%>");
    if (oInvCheck)
        oInvCheck.value=sValue;
}

window.onload=function(){
    <%=strScript%>
}

</script>

</asp:Content>

