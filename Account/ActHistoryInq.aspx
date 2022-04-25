<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ActHistoryInq.aspx.vb" Inherits="Account_ActHistoryInq" title="Untitled Page" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>

<%@ Register src="../UserControl/LoanDataFromParamAccID.ascx" tagname="LoanDataFromParamAccID" tagprefix="uc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Button ID="btnJournal" runat="server" OnClientClick="return(ShowJournalBook());"
        Style="background-position: right; background-image: url(../Images/journal.gif);
        cursor: pointer; background-repeat: no-repeat;" Text="Show Booking Journal" Width="150px"/>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPELoanData" runat="server" CollapseControlID="pnlLoanShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Loan Data...)" Enabled="True"
        ExpandControlID="pnlLoanShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Loan Data...)"
        ImageControlID="imgLoanData" TargetControlID="pnlLoanData" TextLabelID="lblLoanData">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:HiddenField ID="hidAccID" runat="server" />
    <asp:HiddenField ID="hidLocID" runat="server" />
    <asp:Panel ID="pnlLoanShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgLoanData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblLoanData" runat="server" CssClass="required">(Show Loan Data...)</asp:Label>
        </div>
        <input id="Button5" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <asp:Panel ID="pnlLoanData" runat="server"  Width="100%">
        <uc2:LoanDataFromParamAccID ID="ctlLoanDataFromParamAccID" runat="server" />
    </asp:Panel><ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEPayment" runat="server" CollapseControlID="pnlPaymentShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Payment Data...)" Enabled="True"
        ExpandControlID="pnlPaymentShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Payment Data...)"
        ImageControlID="imgPayment" TargetControlID="pnlPaymentData" TextLabelID="lblPayment">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlPaymentShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgPayment" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblPayment" runat="server" CssClass="required">(Show Payment ...)</asp:Label>
        </div>
        <input id="Button1" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <asp:Panel ID="pnlPaymentData" runat="server" Width="100%">
        <asp:Button ID="btnPrintInst" runat="server" 
            OnClientClick="return PrintInst();" 
            Style="background-position: right; background-image: url('../Images/print.jpg'); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
            Text="Print Installment History" Width="150px" />
    <asp:GridView ID="gvPayment" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" Caption="PAYMENT LIST" DataSourceID="sdsPayment" DataKeyNames="LOCIDPAY,PAYID" Width="100%">
        <Columns>
            <asp:TemplateField HeaderText="DTL" SortExpression="ACCID">
                <ItemTemplate>
                    <img src="../Images/detail.gif" onclick="ViewTxn('<%#eval("LOCID")%>', '<%#eval("ACCID")%>', '<%#eval("LOCIDPAY")%>', '<%#eval("PAYID")%>')" style="cursor: pointer" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:BoundField DataField="PAYMENTTYPENAME" HeaderText="Payment&lt;br&gt;Type" HtmlEncode="False"
                SortExpression="PAYMENTTYPENAME" />
            <asp:BoundField DataField="PAIDDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Value&lt;br&gt;Date"
                HtmlEncode="False" SortExpression="PAIDDATE" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="PAIDTXNDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Txn&lt;br&gt;Date"
                HtmlEncode="False" SortExpression="PAIDTXNDATE" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="TXNTYPENAME" HeaderText="Txn&lt;br&gt;Type" HtmlEncode="False"
                SortExpression="TXNTYPENAME" />
            <asp:BoundField DataField="BANKNAME" HeaderText="Bank" SortExpression="BANKNAME" />
            <asp:BoundField DataField="ACCOUNTNO" HeaderText="Bank&lt;br&gt;Acc No." HtmlEncode="False"
                SortExpression="ACCOUNTNO" />
            <asp:BoundField DataField="AMOUNT" DataFormatString="{0:N}" HeaderText="Amount"
                HtmlEncode="False" SortExpression="AMOUNT" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="INVOICENO" HeaderText="Invoice&lt;br&gt;No" HtmlEncode="False"
                SortExpression="INVOICENO" />
            <asp:CheckBoxField DataField="REVSTATUS" HeaderText="Rev.&lt;br&gt;Status" SortExpression="REVSTATUS" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:CheckBoxField>
            <asp:BoundField DataField="REVDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Rev.&lt;br&gt;Date"
                HtmlEncode="False" SortExpression="REVDATE" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="DEPOSIT" DataFormatString="{0:N}" HeaderText="Deposit"
                HtmlEncode="False" SortExpression="DEPOSIT" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            <uc1:NoDataFound ID="NoDataFound1" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsPayment" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
            
            
            SelectCommand="SELECT PAYMENT.LOCIDPAY, PAYMENT.PAYID, ACCOUNT.LOCID, ACCOUNT.ACCID, PAYMENT.PAIDDATE, PAYMENT.PAIDTXNDATE, '(' + CAST(PAYMENT.TXNTYPE AS VARCHAR(2)) + ')' + dbo.f_getParamGlobalName('TXNTYPE', PAYMENT.TXNTYPE) AS TXNTYPENAME, '(' + BANK.BANKCODE + ') ' + BANK.BANKNAME AS BANKNAME, PAYMENT.AMOUNT, PAYMENT.INVOICENO, PAYMENT.REVSTATUS, PAYMENT.REVDATE, PAYMENT.DEPOSIT, BANKACCOUNT.ACCOUNTNO, '(' + CAST(PAYMENT.PAYMENTTYPE AS VARCHAR(20)) + ') ' + + dbo.f_getParamGlobalName('PAYMENTTYPE', PAYMENT.PAYMENTTYPE) AS PAYMENTTYPENAME FROM BANKACCOUNT WITH (NOLOCK) INNER JOIN BANK WITH (NOLOCK) ON BANKACCOUNT.BANKID = BANK.BANKID RIGHT OUTER JOIN PAYMENT WITH (NOLOCK) INNER JOIN ACCOUNT WITH (NOLOCK) ON PAYMENT.LOCID = ACCOUNT.LOCID AND PAYMENT.ACCID = ACCOUNT.ACCID ON BANKACCOUNT.ACCOUNTID = PAYMENT.ACCOUNTID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.APPID = @APPID) ORDER BY PAYMENT.PAIDTXNDATE, PAYMENT.PAIDDATE, PAYMENT.PAYID">
        <SelectParameters>
            <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
            <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
        </SelectParameters>
    </asp:SqlDataSource>
    </asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEWaiveOD" runat="server" CollapseControlID="pnlWaiveShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Waive OverDue Data...)" Enabled="True"
        ExpandControlID="pnlWaiveODShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Waive OverDue Data...)"
        ImageControlID="imgWaiveOD" TargetControlID="pnlWaiveODData" TextLabelID="lblWaiveOD">
</ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlWaiveODShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgWaiveOD" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblWaiveOD" runat="server" CssClass="required">(Show Waive OverDue ...)</asp:Label>
        </div>
        <input id="Button9" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <asp:Panel ID="pnlWaiveODData" runat="server" Width="100%">
        <asp:GridView ID="gvWaiveOD" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" Caption="WAIVE OVERDUE LIST" DataSourceID="sdsWaiveOD" Width="100%">
            <Columns>
                <asp:BoundField DataField="WAIVEDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Waive&lt;br&gt;Date"
                    HtmlEncode="False" SortExpression="WAIVEDATE">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="STATUSDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Status&lt;br&gt;Date"
                    HtmlEncode="False" SortExpression="STATUSDATE">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="WAIVEPRINCIPAL" DataFormatString="{0:N}" HeaderText="Waive&lt;br&gt;Principal"
                    HtmlEncode="False" SortExpression="WAIVEPRINCIPAL">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="WAIVEINTEREST" HeaderText="Waive&lt;br&gt;Interest" HtmlEncode="False"
                    ReadOnly="True" SortExpression="WAIVEINTEREST" DataFormatString="{0:N}" >
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="WAIVEPENALTY" DataFormatString="{0:N}" 
                    HeaderText="Waive&lt;br&gt;Penalty" HtmlEncode="False" 
                    SortExpression="WAIVEPENALTY">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="WAIVESTATUSNAME" HeaderText="Waive&lt;br&gt;Status" 
                    HtmlEncode="False" SortExpression="WAIVESTATUSNAME" />
                <asp:BoundField DataField="REMARK" HeaderText="Remark" SortExpression="REMARK" />
            </Columns>
            <EmptyDataTemplate>
                <uc1:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsWaiveOD" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
            
            
            SelectCommand="SELECT ACCOUNT.LOCID, ACCOUNT.ACCID, WAIVEOD.WAIVEODID, WAIVEOD.WAIVEDATE, WAIVEOD.WAIVEPENALTY, WAIVEOD.WAIVESTATUS, WAIVEOD.REMARK, '(' + CAST(WAIVEOD.WAIVESTATUS AS VARCHAR(10)) + ') ' + dbo.f_getParamGlobalName('WAIVESTATUS', WAIVEOD.WAIVESTATUS) AS WAIVESTATUSNAME, WAIVEOD.WAIVEPRINCIPAL, WAIVEOD.WAIVEINTEREST, WAIVEOD.STATUSDATE FROM ACCOUNT WITH (NOLOCK) INNER JOIN WAIVEOD WITH (NOLOCK) ON ACCOUNT.LOCID = WAIVEOD.LOCID AND ACCOUNT.ACCID = WAIVEOD.ACCID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.APPID = @APPID) ORDER BY WAIVEOD.WAIVEDATE, WAIVEOD.WAIVEODID">
            <SelectParameters>
                <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
                <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>
<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEWaive" runat="server" CollapseControlID="pnlWaiveShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Waive Penalty Data...)" Enabled="True"
        ExpandControlID="pnlWaiveShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Waive Penalty Data...)"
        ImageControlID="imgWaive" TargetControlID="pnlWaiveData" TextLabelID="lblWaive">
</ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlWaiveShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgWaive" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblWaive" runat="server" CssClass="required">(Show Waive Penalty ...)</asp:Label>
        </div>
        <input id="Button2" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <asp:Panel ID="pnlWaiveData" runat="server" Width="100%">
        <asp:GridView ID="gvWaive" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" Caption="WAIVE PENALTY LIST" DataSourceID="sdsWaive" Width="100%">
            <Columns>
                <asp:BoundField DataField="WAIVEDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Waive&lt;br&gt;Date"
                    HtmlEncode="False" SortExpression="WAIVEDATE">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="DUEDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Due&lt;br&gt;Date"
                    HtmlEncode="False" SortExpression="DUEDATE">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="WAIVEAMOUNT" DataFormatString="{0:N}" HeaderText="Waive&lt;br&gt;Amount"
                    HtmlEncode="False" SortExpression="WAIVEAMOUNT">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="WAIVESTATUSNAME" HeaderText="Waive&lt;br&gt;Status" HtmlEncode="False"
                    ReadOnly="True" SortExpression="WAIVESTATUSNAME" />
                <asp:BoundField DataField="REMARK" HeaderText="Remark" SortExpression="REMARK" />
            </Columns>
            <EmptyDataTemplate>
                <uc1:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsWaive" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
            
            SelectCommand="SELECT ACCOUNT.LOCID, ACCOUNT.ACCID, WAIVE.WAIVEID, WAIVE.WAIVEDATE, WAIVE.DUEDATE, WAIVE.WAIVEAMOUNT, WAIVE.WAIVESTATUS, WAIVE.REMARK, '(' + CAST(WAIVE.WAIVESTATUS AS VARCHAR(10)) + ') ' + dbo.f_getParamGlobalName('WAIVESTATUS', WAIVE.WAIVESTATUS) AS WAIVESTATUSNAME FROM ACCOUNT WITH (NOLOCK) INNER JOIN WAIVE WITH (NOLOCK) ON ACCOUNT.LOCID = WAIVE.LOCID AND ACCOUNT.ACCID = WAIVE.ACCID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.APPID = @APPID) ORDER BY WAIVE.WAIVEDATE, WAIVE.WAIVEID">
            <SelectParameters>
                <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
                <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEET" runat="server" CollapseControlID="pnlETShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Early Termination Data...)" Enabled="True"
        ExpandControlID="pnlETShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Early Termination Data...)"
        ImageControlID="imgET" TargetControlID="pnlETData" TextLabelID="lblET">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlETShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgET" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblET" runat="server" CssClass="required">(Show Early Termination ...)</asp:Label>
        </div>
        <input id="Button3" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <asp:Panel ID="pnlETData" runat="server" Width="100%">
        <asp:GridView ID="gvET" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" Caption="EARLY TERMINATION LIST" DataSourceID="sdsET" DataKeyNames="LOCID,ACCID" Width="100%">
            <Columns>
                <asp:TemplateField HeaderText="INF" SortExpression="ETID">
                    <ItemTemplate>
                        <img src="../images/detail.gif" style="cursor: pointer" onclick="ShowET('<%#eval("LOCID")%>', '<%#eval("ACCID")%>', '<%#eval("ETID")%>')" alt="Show ET : <%#eval("ETID")%>" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:TemplateField>
                <asp:BoundField DataField="ETDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="ET&lt;BR&gt;Date"
                    HtmlEncode="False" SortExpression="ETDATE">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="ETTXNDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="ET Txn&lt;br&gt;Date"
                    HtmlEncode="False" SortExpression="ETTXNDATE">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="OSPRINCIPAL" DataFormatString="{0:N}" HeaderText="OS&lt;br&gt;Principal"
                    HtmlEncode="False" SortExpression="OSPRINCIPAL">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="ETPENALTY" DataFormatString="{0:N}" HeaderText="Penalty"
                    HtmlEncode="False" SortExpression="ETPENALTY">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="ETPENALTYWAIVE" DataFormatString="{0:N}" HeaderText="Penalty&lt;br&gt;Waive"
                    HtmlEncode="False" SortExpression="ETPENALTYWAIVE">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="ETADMIN" DataFormatString="{0:N}" HeaderText="Admin"
                    HtmlEncode="False" SortExpression="ETADMIN">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="ETADMINWAIVE" DataFormatString="{0:N}" HeaderText="Admin&lt;br&gt;Waive"
                    HtmlEncode="False" SortExpression="ETADMINWAIVE">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="ETOTHERFEE" DataFormatString="{0:N}" HeaderText="Other&lt;br&gt;Fee"
                    HtmlEncode="False" SortExpression="ETOTHERFEE">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="ETINTEREST" DataFormatString="{0:N}" HeaderText="Interest"
                    HtmlEncode="False" SortExpression="ETINTEREST">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="ETSTATUSNAME" HeaderText="Status" ReadOnly="True" SortExpression="ETSTATUSNAME" />
                <asp:BoundField DataField="ETDESC" HeaderText="Remark" SortExpression="ETDESC" />
            </Columns>
            <EmptyDataTemplate>
                <uc1:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsET" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
            
            
            SelectCommand="SELECT ET.LOCID, ET.ACCID, ET.ETID, ET.ETDATE, ET.ETTXNDATE, ET.ETSTATUS, ET.ETPENALTYWAIVE, ET.ETADMINWAIVE, ET.OSPRINCIPAL, ET.ETPENALTY, ET.ETADMIN, ET.ETOTHERFEE, ET.ETINTEREST, '(' + CAST(ET.ETSTATUS AS VARCHAR(10)) + ') ' + + dbo.f_getParamGlobalName('ETSTATUS', ET.ETSTATUS) AS ETSTATUSNAME, ET.ETDESC FROM ACCOUNT WITH (NOLOCK) INNER JOIN ET WITH (NOLOCK) ON ACCOUNT.LOCID = ET.LOCID AND ACCOUNT.ACCID = ET.ACCID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.APPID = @APPID) ORDER BY ET.ETTXNDATE, ET.ETID">
            <SelectParameters>
                <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
                <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>
<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEDeposit" runat="server" CollapseControlID="pnlDepositShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Deposit Log Data...)" Enabled="True"
        ExpandControlID="pnlDepositShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Deposit Log Data...)"
        ImageControlID="imgDeposit" TargetControlID="pnlDepositData" TextLabelID="lblDeposit">
</ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlDepositShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgDeposit" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblDeposit" runat="server" CssClass="required">(Show DEPOSIT LOG ...)</asp:Label>
        </div>
        <input id="Button4" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <asp:Panel ID="pnlDepositData" runat="server" Width="100%">
        <asp:GridView ID="gvDepositLog" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" Caption="DEPOSIT LOG LIST" DataSourceID="sdsDepositLog" Width="100%">
            <Columns>
                <asp:BoundField DataField="TXNDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Txn&lt;br&gt;Date"
                    HtmlEncode="False" SortExpression="TXNDATE">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="OLDDEPOSIT" DataFormatString="{0:N}" HeaderText="Old&lt;br&gt;Deposit(a)"
                    HtmlEncode="False" SortExpression="OLDDEPOSIT">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="NEWDEPOSIT" DataFormatString="{0:N}" HeaderText="New&lt;br&gt;Deposit(b)"
                    HtmlEncode="False" SortExpression="NEWDEPOSIT">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="TXNDEPOSIT" DataFormatString="{0:N}" 
                    HeaderText="Txn&lt;br&gt;Deposit (b-a)" HtmlEncode="False" 
                    SortExpression="TXNDEPOSIT">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="UserID" HeaderText="User&lt;br&gt;ID" HtmlEncode="False"
                    SortExpression="UserID" />
            </Columns>
            <EmptyDataTemplate>
                <uc1:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsDepositLog" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
            
            
            SelectCommand="SELECT ACCOUNT.LOCID, ACCOUNT.ACCID, DEPOSITLOG.DEPOSITID, DEPOSITLOG.TXNDATE, DEPOSITLOG.OLDDEPOSIT, DEPOSITLOG.NEWDEPOSIT, APPUSER.UserID, DEPOSITLOG.NEWDEPOSIT - DEPOSITLOG.OLDDEPOSIT AS TXNDEPOSIT FROM ACCOUNT WITH (NOLOCK) INNER JOIN DEPOSITLOG WITH (NOLOCK) ON ACCOUNT.LOCID = DEPOSITLOG.LOCID AND ACCOUNT.ACCID = DEPOSITLOG.ACCID LEFT OUTER JOIN APPUSER WITH (NOLOCK) ON DEPOSITLOG.LASTUSERID = APPUSER.UID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.APPID = @APPID) ORDER BY DEPOSITLOG.TXNDATE, DEPOSITLOG.DEPOSITID">
            <SelectParameters>
                <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
                <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>
    <asp:Panel ID="pnlDepositSetOffShow" runat="server" CssClass="ShowDetail" 
        Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgDepositSetOff" runat="server" AlternateText="(Show Details...)" 
                ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblDepositSetOff" runat="server" CssClass="required">(Show DEPOSIT SET OFF ...)</asp:Label>
        </div>
        <input id="Button8" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <asp:Panel ID="pnlDepositSetOffData" runat="server" Width="100%">
        <asp:GridView ID="gvDepositSetOff" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" Caption="DEPOSIT SET OFF LIST" 
            DataSourceID="sdsDepositSEtOff" Width="100%" DataKeyNames="LOCID,ACCID">
            <Columns>
                <asp:BoundField DataField="DEPOSIT" DataFormatString="{0:N}" HeaderText="DEPOSIT"
                    HtmlEncode="False" SortExpression="DEPOSIT">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="SETOFF" DataFormatString="{0:N}" HeaderText="SETOFF"
                    HtmlEncode="False" SortExpression="SETOFF">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="TXNDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="TXN&lt;br&gt;DATE"
                    HtmlEncode="False" SortExpression="TXNDATE">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="TXNTYPENAME" HeaderText="TXN&lt;BR&gt;TYPE" 
                    HtmlEncode="False" SortExpression="TXNTYPENAME" />
                <asp:BoundField DataField="STATUSNAME" HeaderText="STATUS" ReadOnly="True" 
                    SortExpression="STATUSNAME" />
                <asp:BoundField DataField="REMARK" HeaderText="REMARK" 
                    SortExpression="REMARK" />
            </Columns>
            <EmptyDataTemplate>
                <uc1:NoDataFound ID="NoDataFound3" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsDepositSEtOff" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
            
            
            
            
            
            SelectCommand="SELECT ACCOUNT.LOCID, ACCOUNT.ACCID, DEPOSITSETOFF.DEPOSIT, DEPOSITSETOFF.SETOFF, DEPOSITSETOFF.TXNDATE, dbo.f_getParamGlobalName('WOSTATUS', DEPOSITSETOFF.STATUS) AS STATUSNAME, dbo.f_getParamGlobalName('TXNTYPE', DEPOSITSETOFF.TXNTYPE) AS TXNTYPENAME, DEPOSITSETOFF.REMARK FROM ACCOUNT WITH (NOLOCK) INNER JOIN DEPOSITSETOFF ON ACCOUNT.LOCID = DEPOSITSETOFF.LOCID AND ACCOUNT.ACCID = DEPOSITSETOFF.ACCID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.APPID = @APPID) ORDER BY DEPOSITSETOFF.TXNDATE, DEPOSITSETOFF.DEPID">
            <SelectParameters>
                <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
                <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>
<ajaxToolkit:CollapsiblePanelExtender ID="pnlDepositData0_CollapsiblePanelExtender" 
        runat="server" CollapseControlID="pnlDepositSetOffShow"
        CollapsedImage="~/images/expand.jpg" 
        CollapsedText="(Show Deposit Set Off Data...)" Enabled="True"
        ExpandControlID="pnlDepositSetOffShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Deposit Set Off Data...)"
        ImageControlID="imgDepositSetOff" TargetControlID="pnlDepositSetOffData" 
        TextLabelID="lblDepositSetOff">
</ajaxToolkit:CollapsiblePanelExtender>
<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEWO" runat="server" CollapseControlID="pnlWOShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Write Off Data...)" Enabled="True"
        ExpandControlID="pnlWOShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Write Off Data...)"
        ImageControlID="imgWO" TargetControlID="pnlWOData" TextLabelID="lblWO">
</ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlWOShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgWO" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblWO" runat="server" CssClass="required">(Show WRITE OFF ...)</asp:Label>
        </div>
        <input id="Button6" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <asp:Panel ID="pnlWOData" runat="server" Width="100%">
        <asp:GridView ID="gvWO" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" Caption="WRITE OFF LIST" DataSourceID="sdsWO" Width="100%" DataKeyNames="LOCID,ACCID">
            <Columns>
                <asp:TemplateField HeaderText="INF" SortExpression="WOID">
                    <ItemTemplate>
                        <img src="../images/detail.gif" style="cursor: pointer" 
    onclick="ShowWO('<%#eval("LOCID")%>', '<%#eval("ACCID")%>', '<%#eval("WOID")%>')" 
    alt="SHOW WO: <%#eval("WOID")%>" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                </asp:TemplateField>
                <asp:BoundField DataField="WODATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="WO&lt;br&gt;Date"
                    HtmlEncode="False" SortExpression="WODATE">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="OSPRINCIPAL" DataFormatString="{0:N}" HeaderText="OS&lt;br&gt;Principal"
                    HtmlEncode="False" SortExpression="OSPRINCIPAL">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="OSINTEREST" DataFormatString="{0:N}" HeaderText="OS&lt;br&gt;Interest"
                    HtmlEncode="False" SortExpression="OSINTEREST">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="WOSTATUSNAME" HeaderText="WO&lt;br&gt;Status" HtmlEncode="False"
                    ReadOnly="True" SortExpression="WOSTATUSNAME" />
                <asp:BoundField DataField="WODESC" HeaderText="Description" SortExpression="WODESC" />
            </Columns>
            <EmptyDataTemplate>
                <uc1:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsWO" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
            
            
            SelectCommand="SELECT WO.LOCID, WO.ACCID, WO.WOID, WO.WODATE, '(' + CAST(WO.WOSTATUS AS VARCHAR(20)) + ') ' + dbo.f_getParamGlobalName('WOSTATUS', WO.WOSTATUS) AS WOSTATUSNAME, WO.WODESC, WO.OSPRINCIPAL, WO.OSINTEREST FROM ACCOUNT WITH (NOLOCK) INNER JOIN WO WITH (NOLOCK) ON ACCOUNT.LOCID = WO.LOCID AND ACCOUNT.ACCID = WO.ACCID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.APPID = @APPID) ORDER BY WO.WODATE, WO.WOID">
            <SelectParameters>
                <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
                <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>
<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPERS" runat="server" CollapseControlID="pnlRSShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Reschedule Data...)" Enabled="True"
        ExpandControlID="pnlRSShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Reschedule Data...)"
        ImageControlID="imgRS" TargetControlID="pnlRSData" TextLabelID="lblRS">
</ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlRSShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgRS" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblRS" runat="server" CssClass="required">(Show RESCHEDULE ...)</asp:Label>
        </div>
        <input id="Button7" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <asp:Panel ID="pnlRSData" runat="server" Width="100%">
        <asp:GridView ID="gvRS" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
            Caption="RESCHEDULE LIST" DataSourceID="sdsRS" Width="100%">
            <Columns>
                <asp:TemplateField HeaderText="INF" SortExpression="RSID">
                    <ItemTemplate>
                        <img src="../images/detail.gif" style="cursor: pointer" 
    onclick="ShowRS('<%#eval("LOCID")%>', '<%#eval("ACCID")%>', '<%#eval("RSID")%>')" 
    alt="SHOW RS: <%#eval("RSID")%>" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                </asp:TemplateField>
                <asp:BoundField DataField="RSID" HeaderText="RSID" SortExpression="RSID">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="RSTXNDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="TXN&lt;BR&gt;DATE"
                    HtmlEncode="False" SortExpression="RSTXNDATE">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="OSPRINCIPALCURRENT" DataFormatString="{0:N}" HeaderText="OS Principal&lt;br&gt;Current"
                    HtmlEncode="False" SortExpression="OSPRINCIPALCURRENT">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="OSTENORCURRENT" HeaderText="OS Tenor&lt;br&gt;Current"
                    HtmlEncode="False" SortExpression="OSTENORCURRENT">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="OLDEFFRATE" HeaderText="Old. Eff&lt;br&gt;Rate" HtmlEncode="False"
                    SortExpression="OLDEFFRATE">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="NEWEFFRATE" HeaderText="New Eff.&lt;br&gt;Rate" HtmlEncode="False"
                    SortExpression="NEWEFFRATE">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="OLDFLATRATE" HeaderText="Old Flat&lt;br&gt;Rate" HtmlEncode="False"
                    SortExpression="OLDFLATRATE">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="NEWFLATRATE" HeaderText="New Flat&lt;br&gt;Rate" HtmlEncode="False"
                    SortExpression="NEWFLATRATE">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="OLDINSTALLMENT" DataFormatString="{0:N}" HeaderText="Old&lt;br&gt;Installment"
                    HtmlEncode="False" SortExpression="OLDINSTALLMENT">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="NEWINSTALLMENT" DataFormatString="{0:N}" HeaderText="New&lt;br&gt;Installment"
                    HtmlEncode="False" SortExpression="NEWINSTALLMENT">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="OLDINTERESTTOTAL" DataFormatString="{0:N}" HeaderText="Old Interest&lt;br&gt;Total"
                    HtmlEncode="False" SortExpression="OLDINTERESTTOTAL">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="NEWINTERESTTOTAL" DataFormatString="{0:N}" HeaderText="New Interest&lt;br&gt;Total"
                    HtmlEncode="False" SortExpression="NEWINTERESTTOTAL">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="RSSTATUSDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Status&lt;br&gt;Date"
                    HtmlEncode="False" SortExpression="RSSTATUSDATE">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="RSSTATUSNAME" HeaderText="Status" ReadOnly="True" SortExpression="RSSTATUSNAME" />
                <asp:BoundField DataField="RSTYPENAME" HeaderText="Reschedule&lt;br&gt;Type" 
                    HtmlEncode="False" SortExpression="RSTYPENAME" />
            </Columns>
            <EmptyDataTemplate>
                <uc1:NoDataFound ID="NoDataFound2" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsRS" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            
            
            
            SelectCommand="SELECT RESCHEDULE.RSID, RESCHEDULE.RSTXNDATE, RESCHEDULE.OSPRINCIPALCURRENT, RESCHEDULE.OSTENORCURRENT, RESCHEDULE.OLDEFFRATE, RESCHEDULE.NEWEFFRATE, RESCHEDULE.OLDFLATRATE, RESCHEDULE.NEWFLATRATE, RESCHEDULE.OLDINSTALLMENT, RESCHEDULE.NEWINSTALLMENT, RESCHEDULE.OLDINTERESTTOTAL, RESCHEDULE.NEWINTERESTTOTAL, RESCHEDULE.RSSTATUS, RESCHEDULE.RSSTATUSDATE, dbo.f_getParamGlobalName('WOSTATUS', RESCHEDULE.RSSTATUS) AS RSSTATUSNAME, RESCHEDULE.LOCID, RESCHEDULE.ACCID, dbo.f_getParamGlobalName('RSTYPE', RESCHEDULE.RSTYPE) AS RSTYPENAME FROM ACCOUNT WITH (NOLOCK) INNER JOIN RESCHEDULE WITH (NOLOCK) ON ACCOUNT.LOCID = RESCHEDULE.LOCID AND ACCOUNT.ACCID = RESCHEDULE.ACCID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.APPID = @APPID) ORDER BY RESCHEDULE.RSTXNDATE, RESCHEDULE.RSID">
            <SelectParameters>
                <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
                <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvPayment.ClientID%>");
FormatTable("<%=gvET.ClientID%>");
FormatTable("<%=gvWaive.ClientID%>");
FormatTable("<%=gvDepositLog.ClientID%>");
FormatTable("<%=gvWO.ClientID%>");
FormatTable("<%=gvRS.ClientID%>");
function GetValueTxtByClientID(ClientID){
    var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
    if (oText)
        return(oText.value);
}

function ViewTxn(LOCID, ACCID, LOCIDPAY, PAYID){
    var winref = window.open("PayInfoDetail.aspx?Action=View&LOCID=" + LOCID + "&ACCID=" + ACCID + "&LOCIDPAY=" + LOCIDPAY + "&PAYID=" + PAYID, "PayDtlInfo", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
    winref.focus();
}
function ShowJournalBook(){
    var RefNo=GetValueTxtByClientID("<%=hidLocID.ClientID%>") + '-' + GetValueTxtByClientID("<%=hidAccID.ClientID%>");
    var winref = window.open("../Core/JournalViewByRefNo.aspx?Action=View&RefNo=" + RefNo + "&BookCode=FP11", "BookJournal", "height=400,width=600,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
    winref.focus();
    return(false);
}
function PrintInst() {
    var LOCID = GetValueTxtByClientID("<%=hidLocID.ClientID%>");
    var ACCID = GetValueTxtByClientID("<%=hidAccID.ClientID%>");
    var winref = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/Installment_History&LOCID=" + LOCID + "&ACCID=" + ACCID, "PrintInstHist", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
    winref.focus();
    return false;
}
function ShowET(LOCID, ACCID, ETID) {
    var winref = window.open("ETDisplay.aspx?Action=INQ&LOCID=" + LOCID + "&ACCID=" + ACCID + "&ETID=" + ETID, "ShowET", "height=500,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
    winref.focus();
}
function ShowWO(LOCID, ACCID, WOID) {
    var winref = window.open("WODisplay.aspx?Action=INQ&LOCID=" + LOCID + "&ACCID=" + ACCID + "&WOID=" + WOID, "ShowWO", "height=500,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
    winref.focus();
}
function ShowRS(LOCID, ACCID, RSID) {
    var winref = window.open("AccRSDisplay.aspx?Action=INQ&LOCID=" + LOCID + "&ACCID=" + ACCID + "&RSID=" + RSID, "ShowRS", "height=500,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
    winref.focus();
}

</script>
</asp:Content>

