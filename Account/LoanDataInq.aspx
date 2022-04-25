<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="LoanDataInq.aspx.vb" Inherits="Account_LoanDataInq" title="Loan Data Inquiry" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<%@ Register src="../UserControl/InstallmentDataDue.ascx" tagname="InstallmentDataDue" tagprefix="uc3" %>
<%@ Register src="../UserControl/LoanDataFromParamAccID.ascx" tagname="LoanDataFromParamAccID" tagprefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:GridView ID="gvOtherAcc" runat="server" AutoGenerateColumns="False" 
        DataSourceID="sdsOtherAccount" Caption="OTHER ACCOUNT" Width="100%" 
        AllowPaging="True" AllowSorting="True">
        <Columns>
            <asp:BoundField DataField="LOCID" HeaderText="LOC&lt;BR&gt;ID" HtmlEncode="False"
                SortExpression="LOCID" />
            <asp:BoundField DataField="APPID" HeaderText="APP&lt;BR&gt;ID" HtmlEncode="False"
                SortExpression="APPID" />
            <asp:BoundField DataField="ACCID" HeaderText="ACC&lt;BR&gt;ID" HtmlEncode="False"
                SortExpression="ACCID" />
            <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" HtmlEncode="False"
                SortExpression="ACCOUNTNAME" />
            <asp:TemplateField HeaderText="Account No.&lt;br&gt;(formated)" SortExpression="ACCOUNTNOFORMATED">
                <ItemTemplate>
                    <input id="btnDetail" type="button" value="<%# Eval("ACCOUNTNOFORMATED") %>" onclick='ShowDetailAcc(<%# Eval("LOCID") %>, <%# Eval("APPID") %>)' style="cursor: pointer" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:BoundField DataField="BOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Book&lt;br&gt;Date"
                HtmlEncode="False" SortExpression="BOOKINGDATE">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="REQUESTDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Request&lt;br&gt;Date"
                HtmlEncode="False" SortExpression="REQUESTDATE">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="PRINCIPALTOTAL" DataFormatString="{0:N}" HeaderText="Principal"
                HtmlEncode="False" SortExpression="PRINCIPALTOTAL">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="OSPRINCIPAL" DataFormatString="{0:N}" 
                HeaderText="OS&lt;br&gt;Principal" HtmlEncode="False" 
                SortExpression="OSPRINCIPAL">
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="ACCSTATUSNAME" HeaderText="Acc&lt;br&gt;Status" SortExpression="ACCSTATUSNAME" HtmlEncode="False" />
            <asp:BoundField DataField="TENOR" HeaderText="Tenor" HtmlEncode="False" SortExpression="TENOR">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="EFFECTIVERATE" HeaderText="Eff.&lt;br&gt;Rate" HtmlEncode="False"
                SortExpression="EFFECTIVERATE">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            <uc1:NoDataFound ID="NoDataFound2" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsOtherAccount" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        
        SelectCommand="SELECT APPLICATION.LOCID, APPLICATION.APPID, ACCOUNT.ACCID, ACCOUNT.ACCOUNTNAME, ACCOUNT.BOOKINGDATE, dbo.f_FormatAccNoByID(ACCOUNT.BRANCHID, ACCOUNT.ACCOUNTNO) AS ACCOUNTNOFORMATED, APPLICATION.REQUESTDATE, ACCOUNT.PRINCIPALTOTAL, '(' + CAST(ACCOUNT.ACCSTATUS AS varchar(10)) + ') ' + dbo.f_getParamGlobalName('ACCSTATUS', ACCOUNT.ACCSTATUS) AS ACCSTATUSNAME, ACCOUNT.TENOR, ACCOUNT.EFFECTIVERATE, ACCOUNT.ACCSTATUS, ACCOUNT.OSPRINCIPALREAL AS OSPRINCIPAL FROM ACCOUNT WITH (NOLOCK) INNER JOIN APPLICATION WITH (NOLOCK) ON ACCOUNT.LOCID = APPLICATION.LOCID AND ACCOUNT.APPID = APPLICATION.APPID WHERE (ACCOUNT.ACCSTATUS &lt;&gt; 0) AND (NOT (APPLICATION.LOCID = @LOCID)) AND (ACCOUNT.LOCIDCUST = @LOCIDCUST) AND (ACCOUNT.CUSTID = @CUSTID) OR (ACCOUNT.ACCSTATUS &lt;&gt; 0) AND (ACCOUNT.LOCIDCUST = @LOCIDCUST) AND (ACCOUNT.CUSTID = @CUSTID) AND (NOT (APPLICATION.APPID = @APPID))">
        <SelectParameters>
            <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
            <asp:Parameter Name="LOCIDCUST" />
            <asp:Parameter Name="CUSTID" />
            <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
        </SelectParameters>
    </asp:SqlDataSource>
                <asp:Button ID="btnPrintLoan" runat="server" OnClientClick='return PrintLoan();'
            Style="background-position: right; background-image: url('../Images/print.jpg');
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Print Installment Data" Width="136px" />
                <asp:Button ID="btnJournal" runat="server" OnClientClick='return ShowJournal();'
            Style="background-position: right; background-image: url('../Images/Journal.gif');
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Show Booking Journal" Width="136px" />
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPELoanData" runat="server" CollapseControlID="pnlLoanShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Loan Data...)" Enabled="True"
        ExpandControlID="pnlLoanShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Loan Data...)"
        ImageControlID="imgLoanData" TargetControlID="pnlLoanData" TextLabelID="lblLoanData">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:HiddenField ID="hiLocID" runat="server" />
    <asp:HiddenField ID="hiACCID" runat="server" />
    <asp:HiddenField ID="hiTXNDATE" runat="server" />
    <asp:Panel ID="pnlLoanShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgLoanData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblLoanData" runat="server" CssClass="required">(Show Loan Data...)</asp:Label>
        </div>
        <input id="Button5" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <asp:Panel ID="pnlLoanData" runat="server"  Width="100%">
        <uc2:LoanDataFromParamAccID ID="ctlLoanDataFromParamAccID" runat="server" />
    </asp:Panel><asp:Panel ID="pnlAccStatusShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgAccStatus" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblAccStatus" runat="server" CssClass="required">(Show Account Status...)</asp:Label>
        </div>
        <input id="Button4" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEAccStatus" runat="server" CollapseControlID="pnlAccStatusShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Account Status...)"
        Enabled="True" ExpandControlID="pnlAccStatusShow" ExpandedImage="~/images/collapse.jpg"
        ExpandedText="(Hide D Account Status...)" ImageControlID="imgAccStatus" TargetControlID="pnlAccStatus"
        TextLabelID="lblAccStatus">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlAccStatus" runat="server" Width="100%">
        <asp:FormView ID="fvAccStatus" runat="server" Caption="ACCOUNT STATUS" DataKeyNames="LOCID,ACCID"
            DataSourceID="sdsAccStatus" Width="100%">
            <EditItemTemplate>
                LOCID:
                <asp:Label ID="LOCIDLabel1" runat="server" Text='<%# Eval("LOCID") %>'></asp:Label><br />
                ACCID:
                <asp:Label ID="ACCIDLabel1" runat="server" Text='<%# Eval("ACCID") %>'></asp:Label><br />
                ACCSTATUS:
                <asp:TextBox ID="ACCSTATUSTextBox" runat="server" Text='<%# Eval("ACCSTATUS") %>'>
                </asp:TextBox><br />
                CLOSEDATE:
                <asp:TextBox ID="CLOSEDATETextBox" runat="server" Text='<%# Eval("CLOSEDATE") %>'>
                </asp:TextBox><br />
                CLOSETXNDATE:
                <asp:TextBox ID="CLOSETXNDATETextBox" runat="server" Text='<%# Eval("CLOSETXNDATE") %>'>
                </asp:TextBox><br />
                RELEASEDATE:
                <asp:TextBox ID="RELEASEDATETextBox" runat="server" Text='<%# Eval("RELEASEDATE") %>'>
                </asp:TextBox><br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                    Text="Update">
                </asp:LinkButton>
                <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                    Text="Cancel">
                </asp:LinkButton>
            </EditItemTemplate>
            <InsertItemTemplate>
                LOCID:
                <asp:TextBox ID="LOCIDTextBox" runat="server" Text='<%# Eval("LOCID") %>'>
                </asp:TextBox><br />
                ACCID:
                <asp:TextBox ID="ACCIDTextBox" runat="server" Text='<%# Eval("ACCID") %>'>
                </asp:TextBox><br />
                ACCSTATUS:
                <asp:TextBox ID="ACCSTATUSTextBox" runat="server" Text='<%# Eval("ACCSTATUS") %>'>
                </asp:TextBox><br />
                CLOSEDATE:
                <asp:TextBox ID="CLOSEDATETextBox" runat="server" Text='<%# Eval("CLOSEDATE") %>'>
                </asp:TextBox><br />
                CLOSETXNDATE:
                <asp:TextBox ID="CLOSETXNDATETextBox" runat="server" Text='<%# Eval("CLOSETXNDATE") %>'>
                </asp:TextBox><br />
                RELEASEDATE:
                <asp:TextBox ID="RELEASEDATETextBox" runat="server" Text='<%# Eval("RELEASEDATE") %>'>
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
                            Account Status</td>
                        <td class="ErrHighLight" colspan="3">
                            (<asp:Label ID="ACCSTATUSLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("ACCSTATUS") %>'></asp:Label>)
                            <asp:Label ID="Label10" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("ACCSTATUSNAME") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Close Date</td>
                        <td>
                            <asp:Label ID="CLOSEDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("CLOSEDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                        <td>
                            Close Txn Date</td>
                        <td>
                            <asp:Label ID="CLOSETXNDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("CLOSETXNDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Release Status</td>
                        <td>
                            (<asp:Label ID="Label12" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("RELEASESTS") %>'></asp:Label>)
                            <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("RELEASESTSNAME") %>'></asp:Label></td>
                        <td>
                            Release Date</td>
                        <td>
                            <asp:Label ID="RELEASEDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("RELEASEDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource ID="sdsAccStatus" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            
            
            SelectCommand="SELECT LOCID, ACCID, ACCSTATUS, dbo.f_getParamGlobalName('ACCSTATUS', ACCSTATUS) AS ACCSTATUSNAME, CLOSEDATE, CLOSETXNDATE, RELEASEDATE, CAST(RELEASESTS AS INT) AS RELEASESTS, dbo.f_getParamGlobalName('RELEASESTS', RELEASESTS) AS RELEASESTSNAME FROM ACCOUNT WITH (NOLOCK) WHERE (LOCID = @LOCID) AND (APPID = @APPID)">
            <SelectParameters>
                <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
                <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>
    <asp:Panel ID="pnlDisbShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgDisburse" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblDisburse" runat="server" CssClass="required">(Show Disbursement Data...)</asp:Label>
        </div>
        <input id="Button1" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEDisburse" runat="server" CollapseControlID="pnlDisbShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Disbursement Data...)"
        Enabled="True" ExpandControlID="pnlDisbShow" ExpandedImage="~/images/collapse.jpg"
        ExpandedText="(Hide Disbursement Data...)" ImageControlID="imgDisburse" TargetControlID="pnlDisbData"
        TextLabelID="lblDisburse">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlDisbData" runat="server" Width="100%">
        <asp:DataList ID="dlDisburse" runat="server" Caption="DISBURSEMENT DATA" DataKeyField="LOCID"
            DataSourceID="sdsDisburment" Width="100%">
            <ItemTemplate>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td class="ErrHighLight">
                            Disburse Status</td>
                        <td class="ErrHighLight" colspan="3">
                            (<asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("DISBURSESTS") %>'></asp:Label>)<asp:Label
                                ID="Label5" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("DISBURSESTSNAME") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Plan Paid</td>
                        <td>
                            <asp:Label ID="PLANPAIDDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("PLANPAIDDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                        <td>
                            Paid Txn Date</td>
                        <td>
                            <asp:Label ID="PAIDTXNDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("PAIDTXNDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Txn Type</td>
                        <td colspan="3">
                            (<asp:Label ID="TXNTYPELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("TXNTYPE") %>'></asp:Label>)
                            <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("TXNTYPENAME") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Bank</td>
                        <td>
                            (<asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("BANKCODE") %>'></asp:Label>)
                            <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("BANKNAME") %>'></asp:Label></td>
                        <td>
                            Bank Acc. No</td>
                        <td>
                            <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("ACCOUNTNO") %>'></asp:Label></td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList><asp:SqlDataSource ID="sdsDisburment" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            
            SelectCommand="SELECT ACCOUNTDISBURSE.LOCID, ACCOUNTDISBURSE.ACCID, ACCOUNTDISBURSE.TXNTYPE, dbo.f_getParamGlobalName('TXNTYPE', ACCOUNTDISBURSE.TXNTYPE) AS TXNTYPENAME, ACCOUNTDISBURSE.ACCOUNTID, ACCOUNTDISBURSE.PAIDTXNDATE, ACCOUNTDISBURSE.PLANPAIDDATE, ACCOUNT.DISBURSESTS, dbo.f_getParamGlobalName('DISBURSESTS', ACCOUNT.DISBURSESTS) AS DISBURSESTSNAME, BANK.BANKCODE, BANK.BANKNAME, BANKACCOUNT.ACCOUNTNO FROM ACCOUNTDISBURSE WITH (NOLOCK) RIGHT OUTER JOIN ACCOUNT WITH (NOLOCK) INNER JOIN APPLICATION WITH (NOLOCK) ON ACCOUNT.LOCID = APPLICATION.LOCID AND ACCOUNT.APPID = APPLICATION.APPID ON ACCOUNTDISBURSE.LOCID = ACCOUNT.LOCID AND ACCOUNTDISBURSE.ACCID = ACCOUNT.ACCID LEFT OUTER JOIN BANK WITH (NOLOCK) INNER JOIN BANKACCOUNT WITH (NOLOCK) ON BANK.BANKID = BANKACCOUNT.BANKID ON ACCOUNTDISBURSE.ACCOUNTID = BANKACCOUNT.ACCOUNTID WHERE (APPLICATION.LOCID = @LOCID) AND (APPLICATION.APPID = @APPID)">
            <SelectParameters>
                <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
                <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>
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
    </ajaxToolkit:CollapsiblePanelExtender><asp:Panel ID="pnlCollectData" runat="server"  Width="100%">
        <asp:DataList ID="dlCollect" runat="server" Caption="COLLECTIBILITY STATUS" DataSourceID="sdsCollect"
            Width="100%">
            <ItemTemplate>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td >
                            Collectibility BI</td>
                        <td >
                            <asp:Label ID="COLLECTNAMEBILabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("COLLECTNAMEBI") %>'></asp:Label></td>
                        <td >
                            Remark</td>
                        <td >
                            <asp:Label ID="COLLECTREMARKBILabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("COLLECTREMARKBI") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="ErrHighLight">
                            Collectibility Internal</td>
                        <td class="ErrHighLight">
                            <asp:Label ID="COLLECTNAMEINTLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("COLLECTNAMEINT") %>'></asp:Label></td>
                        <td class="ErrHighLight">
                            Remark</td>
                        <td class="ErrHighLight">
                            <asp:Label ID="COLLECTREMARKINTLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("COLLECTREMARKINT") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            NPL</td>
                        <td class="FooterStyle" colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Reason</td>
                        <td colspan="3">
                            (<asp:Label ID="Label16" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("NPLREASONCODE") %>'></asp:Label>)
                            <asp:Label ID="Label17" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("NPLREASONNAME") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Reason Description</td>
                        <td colspan="3">
                            <asp:Label ID="Label19" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("NPLREASONDESC") %>'></asp:Label></td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList><asp:SqlDataSource ID="sdsCollect" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            SelectCommand="SELECT ACCOUNT.COLLECTIDBI, ACCOUNT.COLLECTIDINT, COLLECTSTS.COLLECTNAME AS COLLECTNAMEINT, COLLECTSTS.REMARK AS COLLECTREMARKINT, COLLECTSTS_1.COLLECTNAME AS COLLECTNAMEBI, COLLECTSTS_1.REMARK AS COLLECTREMARKBI, ACCOUNTDTL.NPLREASONDESC, NPLREASON.NPLREASONCODE, NPLREASON.NPLREASONNAME FROM NPLREASON RIGHT OUTER JOIN ACCOUNTDTL WITH (NOLOCK) ON NPLREASON.NPLREASONID = ACCOUNTDTL.NPLREASONID RIGHT OUTER JOIN APPLICATION WITH (NOLOCK) INNER JOIN ACCOUNT WITH (NOLOCK) ON APPLICATION.LOCID = ACCOUNT.LOCID AND APPLICATION.APPID = ACCOUNT.APPID INNER JOIN COLLECTSTS ON ACCOUNT.COLLECTIDINT = COLLECTSTS.COLLECTID INNER JOIN COLLECTSTS AS COLLECTSTS_1 ON ACCOUNT.COLLECTIDBI = COLLECTSTS_1.COLLECTID ON ACCOUNTDTL.LOCID = ACCOUNT.LOCID AND ACCOUNTDTL.ACCID = ACCOUNT.ACCID WHERE (APPLICATION.LOCID = @LOCID) AND (APPLICATION.APPID = @APPID)">
            <SelectParameters>
                <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
                <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
            </SelectParameters>
        </asp:SqlDataSource>
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
        <uc3:InstallmentDataDue ID="InstallmentDataDue" runat="server" />
    </asp:Panel>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">

    FormatTable("<%=gvOtherAcc.ClientID%>");
function ShowDetailAcc(LOCID, APPID){
    if (window.parent)
        window.parent.location="AccInqFrame.aspx?Action=INQ&LOCID=" + LOCID + "&APPID=" + APPID
    else
        window.location="AccInqFrame.aspx?Action=INQ&LOCID=" + LOCID + "&APPID=" + APPID    
    return false;
}

function PrintLoan() {
    var LOCID = GetValueTxtByClientID("<%=hiLoCID.ClientID%>");
    var ACCID = GetValueTxtByClientID("<%=hiACCID.ClientID%>");
    var TXNDATE = GetValueTxtByClientID("<%=hiTXNDATE.ClientID%>");
    var winref=window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/InstallmentAccount&LOCID=" + LOCID + "&ACCID=" + ACCID + "&TXNDATE=" + TXNDATE, "PrintInst", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
    winref.focus();
    return false;
}

function GetValueTxtByClientID(ClientID) {
    var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
    if (oText)
        return (oText.value);
}

function ShowJournal() {
    var RefNo = GetValueTxtByClientID("<%=hiLoCID.ClientID%>") + "-" + GetValueTxtByClientID("<%=hiACCID.ClientID%>");
    WinRef = window.open("../Core/JournalViewByRefNo.aspx?Action=View&RefNo=" + RefNo + "&BookCode=FP11", "BookJournal", "height=400,width=600,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
    WinRef.focus();
    return (false);
}

</script>

</asp:Content>

