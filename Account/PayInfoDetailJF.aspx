<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="PayInfoDetailJF.aspx.vb" Inherits="Account_JFPayInfoDetail" title="JF Payment Activity Info" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Panel ID="pnlAccShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgAccData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblAccData" runat="server" CssClass="required">(Show Account Data...)</asp:Label>
        </div>
        <input id="Button1" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <asp:Panel ID="pnlAccData" runat="server" CssClass="FooterStyle" Font-Bold="True" Width="100%">
        <asp:DataList ID="dlAppData" runat="server"  
            Caption="ACCOUNT DATA" DataSourceID="sdsAccData" Width="100%">
            <ItemTemplate>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            Location ID</td>
                        <td>
                            <asp:Label ID="Label42" runat="server" Font-Underline="True" Text='<%# Eval("LOCID") %>'></asp:Label></td>
                        <td>
                            Account ID</td>
                        <td>
                            <asp:Label ID="Label43" runat="server" Font-Underline="True" Text='<%# Eval("ACCID") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Account No.</td>
                        <td>
                            <asp:Label ID="Label6" runat="server" Font-Underline="True" Text='<%# Eval("ACCOUNTNO") %>'></asp:Label></td>
                        <td>
                            Account No. (formated)</td>
                        <td>
                            <asp:Label ID="Label13" runat="server" Font-Underline="True" Text='<%# Eval("ACCOUNTNOFORMAT") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Account Status</td>
                        <td>
                            (<asp:Label ID="Label1" runat="server" Font-Underline="True" Text='<%# Eval("ACCSTATUS") %>'></asp:Label>)
                            <asp:Label ID="Label2" runat="server" Font-Underline="True" Text='<%# Eval("ACCSTATUSNAME") %>'></asp:Label></td>
                        <td>
                            Booking Date</td>
                        <td>
                            <asp:Label ID="Label10" runat="server" Font-Underline="True" Text='<%# Eval("BOOKINGDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Request Date</td>
                        <td>
                            <asp:Label ID="Label7" runat="server" Font-Underline="True" Text='<%# Eval("REQUESTDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                        <td>
                            Ref. No</td>
                        <td>
                            <asp:Label ID="Label14" runat="server" Font-Underline="True" Text='<%# Eval("REFNO") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Account Name</td>
                        <td colspan="3">
                            <asp:Label ID="Label3" runat="server" Font-Underline="True" Text='<%# Eval("ACCOUNTNAME") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Close Date</td>
                        <td>
                            <asp:Label ID="Label4" runat="server" Font-Underline="True" Text='<%# Eval("CLOSEDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                        <td>
                            Close Txn Date</td>
                        <td>
                            <asp:Label ID="Label5" runat="server" Font-Underline="True" Text='<%# Eval("CLOSETXNDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Area</td>
                        <td>
                            (<asp:Label ID="Label8" runat="server" Font-Underline="True" Text='<%# Eval("AREACODE") %>'></asp:Label>)
                            <asp:Label ID="Label9" runat="server" Font-Underline="True" Text='<%# Eval("AREANAME") %>'></asp:Label></td>
                        <td>
                            Branch</td>
                        <td>
                            (<asp:Label ID="Label16" runat="server" Font-Underline="True" Text='<%# Eval("BRANCHCODE") %>'></asp:Label>)
                            <asp:Label ID="Label17" runat="server" Font-Underline="True" Text='<%# Eval("BRANCHNAME") %>'></asp:Label></td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList><asp:SqlDataSource ID="sdsAccData" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            SelectCommand="SELECT APPLICATION.LOCID, APPLICATION.APPID, ACCOUNT.ACCID, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME, AREA.AREACODE, AREA.AREANAME, ACCOUNT.BOOKINGDATE, ACCOUNT.INSTALLMENTDAY, APPLICATION.APPSTATE, APPLICATION.REQUESTDATE, APPLICATION.STATUSDATE, ACCOUNT.CUSTID, ACCOUNT.CLOSEDATE, ACCOUNT.CLOSETXNDATE, ACCOUNT.ACCOUNTNAME, PARAMGLOBAL.NAME AS ACCSTATUSNAME, ACCOUNT.ACCSTATUS, ACCOUNT.REFNO, ACCOUNT.ACCOUNTNO, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCOUNTNOFORMAT FROM APPLICATION WITH (NOLOCK) RIGHT OUTER JOIN ACCOUNT WITH (NOLOCK) INNER JOIN PARAMGLOBAL ON ACCOUNT.ACCSTATUS = PARAMGLOBAL.CODE AND PARAMGLOBAL.TYPE = 'ACCSTATUS' LEFT OUTER JOIN AREA WITH (NOLOCK) INNER JOIN BRANCH WITH (NOLOCK) ON AREA.AREAID = BRANCH.AREAID ON ACCOUNT.BRANCHID = BRANCH.BRANCHID ON APPLICATION.LOCID = ACCOUNT.LOCID AND APPLICATION.APPID = ACCOUNT.APPID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.ACCID = @ACCID)">
            <SelectParameters>
                <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
                <asp:QueryStringParameter Name="ACCID" QueryStringField="ACCID" />
            </SelectParameters>
        </asp:SqlDataSource>
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
    <asp:Panel ID="pnlLoanData" runat="server"  
        Font-Bold="True" Width="100%">
        <asp:DataList ID="dlJF" runat="server" Caption="JOIN FINANCE (BANK)" DataKeyField="ACCIDJF"
            DataSourceID="sdsJF" Width="100%">
            <ItemTemplate>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td class="HeaderStyle">
                            JF INFO (<asp:Label ID="Label10" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFCODE") %>'></asp:Label>)</td>
                        <td class="FooterStyle" colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td class="required">
                            Acc ID JF</td>
                        <td class="required">
                            <asp:Label ID="ACCIDJFLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("ACCIDJF") %>'></asp:Label></td>
                        <td class="required">
                            JF ID&nbsp;</td>
                        <td class="required">
                            <asp:Label ID="JFIDLabel" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFID") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="required">
                            JF Group</td>
                        <td class="required">
                            (<asp:Label ID="JFGROUPCODELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFGROUPCODE") %>'></asp:Label>)
                            <asp:Label ID="JFGROUPNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFGROUPNAME") %>'></asp:Label>&nbsp;</td>
                        <td class="required">
                            JF (Bank)</td>
                        <td class="required">
                            (<asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFCODE") %>'></asp:Label>)
                            <asp:Label ID="JFNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFNAME") %>'></asp:Label>
                            <img alt="JF Detail Info" onclick='JFInfo(<%# Eval("JFID") %>)' src="../Images/detail.gif"
                                style="cursor: pointer" /></td>
                    </tr>
                    <tr>
                        <td>
                            JF Booking Date</td>
                        <td>
                            <asp:Label ID="JFBOOKINGDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFBOOKINGDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                        <td class="ErrHighLight">
                            JF Status</td>
                        <td class="ErrHighLight">
                            (<asp:Label ID="JFACCSTATUSLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFACCSTATUS") %>'></asp:Label>)
                            <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFACCSTATUSNAME") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            JF Closed Date</td>
                        <td>
                            <asp:Label ID="JFCLOSEDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFCLOSEDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                        <td>
                            JF Closed Txn Date</td>
                        <td>
                            <asp:Label ID="JFCLOSETXNDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFCLOSETXNDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            JF LOAN DATA (<asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFCODE") %>'></asp:Label>)</td>
                        <td class="FooterStyle" colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            JF Principal</td>
                        <td>
                            <asp:Label ID="JFPRINCIPALTOTALLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFPRINCIPALTOTAL", "{0:N}") %>'></asp:Label></td>
                        <td>
                            JF
                            Tenor</td>
                        <td>
                            <asp:Label ID="JFTENORLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFTENOR") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            JF Eff. Rate</td>
                        <td>
                            <asp:Label ID="JFEFFECTIVERATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFEFFECTIVERATE") %>'></asp:Label></td>
                        <td>
                            JF
                            Loan Type</td>
                        <td>
                            (<asp:Label ID="JFLOANTYPELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFLOANTYPE") %>'></asp:Label>)
                            <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFLOANTYPENAME") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            JF Installment</td>
                        <td>
                            <asp:Label ID="JFINSTALLMENTLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFINSTALLMENT", "{0:N}") %>'></asp:Label></td>
                        <td>
                            JF
                            Next Due Date</td>
                        <td>
                            <asp:Label ID="JFNEXTDUEDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFNEXTDUEDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            OUTSTANDING (<asp:Label ID="Label12" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFCODE") %>'></asp:Label>)</td>
                        <td class="FooterStyle" colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td class="AlternatingRowStyle">
                            OS Principal</td>
                        <td class="AlternatingRowStyle">
                            <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFOSPRINCIPAL", "{0:N}") %>'></asp:Label></td>
                        <td class="AlternatingRowStyle">
                            OS Interest</td>
                        <td class="AlternatingRowStyle">
                            <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFOSINTEREST", "{0:N}") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <input id="btnInst" class="ErrHighLight" onclick='ViewJFInst(<%# Eval("ACCIDJF") %>)'
                                style="background-position: right; background-image: url(../Images/view.png);
                                cursor: pointer; background-repeat: no-repeat; text-align: left" type="button" value='View JF Installment (<%# Eval("JFCODE") %>)' /></td>
                    </tr>
                    <tr>
                        <td>
                            JF Installment Start</td>
                        <td>
                            <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFINSTALLMENTSTART", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                        <td>
                            JF
                            Installment End</td>
                        <td>
                            <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFINSTALLMENTEND", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            JF
                            Installment Day</td>
                        <td>
                            <asp:Label ID="JFINSTALLMENTDAYLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFINSTALLMENTDAY") %>'></asp:Label></td>
                        <td>
                            JF Ref No</td>
                        <td>
                            <asp:Label ID="REFNOLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("REFNO") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            JF Start Period</td>
                        <td>
                            <asp:Label ID="JFSTARTPERIODLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFSTARTPERIOD") %>'></asp:Label></td>
                        <td>
                            JF Req. Acc ID.</td>
                        <td>
                            <asp:Label ID="REQUESTIDACCLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("REQUESTIDACC") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            JF FEE (<asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFCODE") %>'></asp:Label>)</td>
                        <td class="FooterStyle" colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            JF Admin Fee</td>
                        <td>
                            <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFADMIN", "{0:N}") %>'></asp:Label></td>
                        <td>
                            JF Provision</td>
                        <td>
                            <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFPROVISION", "{0:N}") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="FooterStyle" colspan="4">
                            <hr />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList><asp:SqlDataSource ID="sdsJF" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            SelectCommand="SELECT ACCOUNTJF.ACCIDJF, ACCOUNTJF.JFID, JF.JFCODE, JF.JFNAME, JFGROUP.JFGROUPCODE, JFGROUP.JFGROUPNAME, ACCOUNTJF.JFBOOKINGDATE, ACCOUNTJF.JFACCSTATUS, dbo.f_getParamGlobalName('JFACCSTATUS', ACCOUNTJF.JFACCSTATUS) AS JFACCSTATUSNAME, ACCOUNTJF.JFPRINCIPALTOTAL, ACCOUNTJF.JFTENOR, ACCOUNTJF.JFLOANTYPE, dbo.f_getParamGlobalName('LOANTYPE', ACCOUNTJF.JFLOANTYPE) AS JFLOANTYPENAME, ACCOUNTJF.JFEFFECTIVERATE, ACCOUNTJF.JFINSTALLMENT, ACCOUNTJF.JFCLOSEDATE, ACCOUNTJF.JFCLOSETXNDATE, ACCOUNTJF.JFNEXTDUEDATE, ACCOUNTJF.JFINSTALLMENTDAY, ACCOUNTJF.REFNO, ACCOUNTJF.REQUESTIDACC, ACCOUNTJF.JFSTARTPERIOD, ACCOUNTJFDTL.JFADMIN, ACCOUNTJFDTL.JFPROVISION, ACCOUNTJFDTL.JFINSTALLMENTSTART, ACCOUNTJFDTL.JFINSTALLMENTEND, ACCOUNTJF.JFOSPRINCIPALREAL AS JFOSPRINCIPAL, ACCOUNTJF.JFOSINTERESTREAL AS JFOSINTEREST FROM ACCOUNTJF WITH (NOLOCK) INNER JOIN JF WITH (NOLOCK) ON ACCOUNTJF.JFID = JF.JFID INNER JOIN JFGROUP WITH (NOLOCK) ON JF.JFGROUPID = JFGROUP.JFGROUPID LEFT OUTER JOIN ACCOUNTJFDTL WITH (NOLOCK) ON ACCOUNTJF.ACCIDJF = ACCOUNTJFDTL.ACCIDJF WHERE (ACCOUNTJF.ACCIDJF = @ACCIDJF)">
            <SelectParameters>
                <asp:QueryStringParameter Name="ACCIDJF" QueryStringField="ACCIDJF" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>
    <asp:DataList ID="dlTxn" runat="server" Caption="TRANSACTION INFO" DataKeyField="PAYIDJF"
        DataSourceID="sdsPayment" Width="100%">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td class="FooterStyle">
                        ACC ID JF</td>
                    <td class="FooterStyle">
            <asp:Label ID="LOCIDPAYLabel" runat="server" Text='<%# Eval("ACCIDJF") %>' Font-Bold="True" Font-Underline="True"></asp:Label></td>
                    <td class="FooterStyle">
                        PAY ID JF</td>
                    <td class="FooterStyle">
            <asp:Label ID="PAYIDLabel" runat="server" Text='<%# Eval("PAYIDJF") %>' Font-Bold="True" Font-Underline="True"></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Payment Type</td>
                    <td colspan="3">
                        (<asp:Label ID="PAYMENTTYPELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPAYMENTTYPE") %>'></asp:Label>)
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFPAYMENTTYPENAME") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Paid Date</td>
                    <td>
            <asp:Label ID="PAIDDATELabel" runat="server" Text='<%# Eval("JFPAIDDATE", "{0:dd/MM/yyyy}") %>' Font-Bold="True" Font-Underline="True"></asp:Label></td>
                    <td>
                        Paid Txn Date</td>
                    <td>
            <asp:Label ID="PAIDTXNDATELabel" runat="server" Text='<%# Eval("JFPAIDTXNDATE", "{0:dd/MM/yyyy}") %>' Font-Bold="True" Font-Underline="True"></asp:Label></td>
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
                    <td colspan="3">
            <asp:Label ID="AMOUNTLabel" runat="server" Text='<%# Eval("JFAMOUNT", "{0:N}") %>' Font-Bold="True" Font-Underline="True"></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Reversal Status</td>
                    <td>
            <asp:Label ID="REVSTATUSLabel" runat="server" Text='<%# Eval("JFREVSTATUS") %>' Font-Bold="True" Font-Underline="True"></asp:Label></td>
                    <td>
                        Reversal Date</td>
                    <td>
            <asp:Label ID="REVDATELabel" runat="server" Text='<%# Eval("JFREVDATE", "{0:dd/MM/yyyy}") %>' Font-Bold="True" Font-Underline="True"></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <hr />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList><asp:SqlDataSource ID="sdsPayment" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT PAYMENTJF.ACCIDJF, PAYMENTJF.PAYIDJF, BANKACCOUNT.ACCOUNTNO, BANK.BANKCODE, BANK.BANKNAME, dbo.f_getParamGlobalName('PAYMENTTYPE', PAYMENTJF.JFPAYMENTTYPE) AS JFPAYMENTTYPENAME, PAYMENTJF.JFPAIDDATE, PAYMENTJF.JFPAIDTXNDATE, PAYMENTJF.JFPAYMENTTYPE, PAYMENTJF.JFAMOUNT, PAYMENTJF.JFREVSTATUS, PAYMENTJF.JFREVDATE FROM BANK WITH (NOLOCK) RIGHT OUTER JOIN BANKACCOUNT ON BANK.BANKID = BANKACCOUNT.BANKID RIGHT OUTER JOIN PAYMENTJF WITH (NOLOCK) ON BANKACCOUNT.ACCOUNTID = PAYMENTJF.JFACCOUNTID WHERE (PAYMENTJF.PAYIDJF = @PAYIDJF)">
        <SelectParameters>
            <asp:QueryStringParameter Name="PAYIDJF" QueryStringField="PAYIDJF" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="gvPayment" runat="server" AutoGenerateColumns="False" Caption="DETAIL JF(BANK) TRANSACTION PAYMENT INSTALLMENT INFO"
        DataKeyNames="PAYIDJF,INSTIDJF" DataSourceID="sdsPaymentDetail" Width="100%" RowHeaderColumn="INSTID">
        <Columns>
            <asp:BoundField DataField="INSTIDJF" HeaderText="INST&lt;BR&gt;ID" ReadOnly="True" SortExpression="INSTIDJF" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="JFDUEDATE" HeaderText="Due&lt;br&gt;Date" SortExpression="JFDUEDATE" DataFormatString="{0:dd/MM/yyyy}" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="JFPRINCIPALPAID" HeaderText="Principal&lt;br&gt;Paid" SortExpression="JFPRINCIPALPAID" DataFormatString="{0:N}" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="JFINTERESTPAID" HeaderText="Interest&lt;br&gt;Paid" SortExpression="JFINTERESTPAID" DataFormatString="{0:N}" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="JFPENALTYPAID" HeaderText="Penalty&lt;br&gt;Paid" SortExpression="JFPENALTYPAID" DataFormatString="{0:N}" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="JFPENALTYSHAREPAID" DataFormatString="{0:N}" HeaderText="JF Penalty&lt;br&gt;Share Paid"
                HtmlEncode="False" SortExpression="JFPENALTYSHAREPAID">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            <uc1:NoDataFound ID="NoDataFound1" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsPaymentDetail" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT PAYIDJF, INSTIDJF, ACCIDJF, JFDUEDATE, JFPRINCIPALPAID, JFINTERESTPAID, JFPENALTYPAID, JFPENALTYSHAREPAID FROM PAYINSTALLJF WITH (NOLOCK) WHERE (PAYIDJF = @PAYIDJF)">
        <SelectParameters>
            <asp:QueryStringParameter Name="PAYIDJF" QueryStringField="PAYIDJF" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:DataList ID="dlET" runat="server" Caption="ET JF (BUY BACK) INFO" DataSourceID="sdsET"
        Width="100%">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td class="FooterStyle">
                        ET ID</td>
                    <td class="FooterStyle">
                        <asp:Label ID="ETIDLabel" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("JFETID") %>'></asp:Label></td>
                    <td class="FooterStyle">
                        ET Status</td>
                    <td class="FooterStyle">
                        (<asp:Label ID="ETSTATUSLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFETSTATUS") %>'></asp:Label>)
                        <asp:Label ID="ETSTATUSNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ETSTATUSNAME") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        ET DATE</td>
                    <td>
                        <asp:Label ID="ETDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFETDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                    <td>
                        ET Txn date</td>
                    <td>
                        <asp:Label ID="ETTXNDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFETTXNDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        OS Principal</td>
                    <td>
                        <asp:Label ID="OSPRINCIPALLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFOSPRINCIPAL", "{0:N}") %>'></asp:Label></td>
                    <td>
                        OS Interest</td>
                    <td>
                        <asp:Label ID="OSINTERESTLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFOSINTEREST", "{0:N}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        ET Penalty</td>
                    <td>
                        <asp:Label ID="ETPENALTYLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFETPENALTY", "{0:N}") %>'></asp:Label></td>
                    <td>
                        ET Penalty Waive</td>
                    <td>
                        <asp:Label ID="ETPENALTYWAIVELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFETPENALTYWAIVE", "{0:N}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        ET Admin</td>
                    <td>
                        <asp:Label ID="ETADMINLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFETADMIN", "{0:N}") %>'></asp:Label></td>
                    <td>
                        ET Admin Waive</td>
                    <td>
                        <asp:Label ID="ETADMINWAIVELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFETADMINWAIVE", "{0:N}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        ET Other Fee</td>
                    <td>
                        <asp:Label ID="ETOTHERFEELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFETOTHERFEE", "{0:N}") %>'></asp:Label></td>
                    <td>
                        ET Interest</td>
                    <td>
                        <asp:Label ID="ETINTERESTLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFETINTEREST", "{0:N}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Amount Due</td>
                    <td colspan="3">
                        <asp:Label ID="AMOUNTDUELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFAMOUNTDUE", "{0:N}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Description&nbsp;
                    </td>
                    <td colspan="3">
                        <asp:Label ID="ETDESCLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFETDESC") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <hr />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList><asp:SqlDataSource ID="sdsET" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT JFETID, JFETDATE, JFETTXNDATE, JFETSTATUS, JFETPENALTY, JFETPENALTYWAIVE, JFETADMIN, JFETADMINWAIVE, JFETOTHERFEE, JFOSPRINCIPAL, JFOSINTEREST, JFETINTEREST, JFAMOUNTDUE, JFETDESC, dbo.f_getParamGlobalName('JFETSTATUS', JFETSTATUS) AS ETSTATUSNAME FROM ETJF WHERE (ACCIDJF = @ACCIDJF) AND (JFETSTATUS IN (1, 2))">
        <SelectParameters>
            <asp:QueryStringParameter Name="ACCIDJF" QueryStringField="ACCIDJF" />
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
                    Visible="False" Width="64px" OnClientClick="return WinBack();" /></td>
            </tr>
        </table>
    </asp:Panel>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvPayment.ClientID%>");
function WinBack(){
    window.history.back(-1);
    return false;
}
function JFInfo(JFID){
    var winref=window.open("../Account/JFInfo.aspx?JFID=" + JFID,"JFInfo", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes");
    winref.focus();
}
function ViewJFInst(ACCIDJF){
    var winref=window.open("../Account/JFInstallment.aspx?ACCIDJF=" + ACCIDJF,"JFInst", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes");
    winref.focus();
}
    
</script>

    <br />
    <br />
    <br />
</asp:Content>

