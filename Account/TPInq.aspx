<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="TPInq.aspx.vb" Inherits="Account_LoanDataInq" title="Third Party Inquiry" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
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
        <asp:DataList ID="dlLoanData" runat="server"  
            Caption="LOAN DATA" DataSourceID="sdsLoanData" Width="100%">
            <ItemTemplate>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            Total Principal</td>
                        <td>
                            <asp:Label ID="Label11" runat="server" Font-Underline="True" Text='<%# Eval("PRINCIPALTOTAL", "{0:N}") %>'></asp:Label></td>
                        <td style="height: 19px">
                            Total Interest</td>
                        <td style="height: 19px">
                            <asp:Label ID="Label15" runat="server" Font-Underline="True" Text='<%# Eval("INTERESTTOTAL", "{0:N}") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Tenor</td>
                        <td>
                            <asp:Label ID="Label18" runat="server" Font-Underline="True" Text='<%# Eval("TENOR") %>'></asp:Label></td>
                        <td style="height: 19px">
                            Loan&nbsp; Type</td>
                        <td style="height: 19px">
                            (<asp:Label ID="Label21" runat="server" Font-Underline="True" Text='<%# Eval("LOANTYPE") %>'></asp:Label>)
                            <asp:Label ID="Label34" runat="server" Font-Underline="True" Text='<%# Eval("LOANTYPENAME") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Eff. Rate Account</td>
                        <td>
                            <asp:Label ID="Label22" runat="server" Font-Underline="True" Text='<%# Eval("EFFECTIVERATE") %>'></asp:Label>
                            %</td>
                        <td>
                            Installment Account</td>
                        <td>
                            <asp:Label ID="Label24" runat="server" Font-Underline="True" Text='<%# Eval("INSTALLMENT", "{0:N}") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Effective Rate Third Party</td>
                        <td>
                            <asp:Label ID="Label23" runat="server" Font-Underline="True" Text='<%# Eval("EFFECTIVERATETP") %>'></asp:Label>
                            %</td>
                        <td>
                            Flat RateThird Party</td>
                        <td>
                            <asp:Label ID="Label1" runat="server" Font-Underline="True" Text='<%# Eval("FLATRATETP") %>'></asp:Label>
                            %</td>
                    </tr>
                    <tr>
                        <td>
                            Installment Third Party</td>
                        <td>
                            <asp:Label ID="Label25" runat="server" Font-Underline="True" Text='<%# Eval("INSTALLMENTTP", "{0:N}") %>'></asp:Label></td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            Outstanding Account (Real)</td>
                        <td colspan="3" class="FooterStyle">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            OS
                            Principal</td>
                        <td>
                            <asp:Label ID="Label30" runat="server" Font-Underline="True" Text='<%# Eval("OSPRINCIPALREAL", "{0:N}") %>'></asp:Label></td>
                        <td style="height: 19px">
                            OS
                            Interest</td>
                        <td style="height: 19px">
                            <asp:Label ID="Label33" runat="server" Font-Underline="True" Text='<%# Eval("OSINTERESTREAL", "{0:N}") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            Outstanding Third Party</td>
                        <td colspan="3" class="FooterStyle">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            OS
                            Principal</td>
                        <td style="height: 19px">
                            <asp:Label ID="Label32" runat="server" Font-Underline="True" Text='<%# Eval("OSPRINCIPALTP", "{0:N}") %>'></asp:Label></td>
                        <td style="height: 19px">
                            OS
                            Interest</td>
                        <td style="height: 19px">
                            <asp:Label ID="Label31" runat="server" Font-Underline="True" Text='<%# Eval("OSINTERESTTP", "{0:N}") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            Company Info</td>
                        <td colspan="3" style="height: 19px" class="FooterStyle">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Company Code</td>
                        <td style="height: 19px">
                            <asp:Label ID="Label26" runat="server" Font-Underline="True" Text='<%# Eval("COMPCODE") %>'></asp:Label></td>
                        <td style="height: 19px">
                            Company Name</td>
                        <td style="height: 19px">
                            <asp:Label ID="Label28" runat="server" Font-Underline="True" Text='<%# Eval("COMPNAME") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Establish Since</td>
                        <td style="height: 19px">
                            <asp:Label ID="Label29" runat="server" Font-Underline="True" Text='<%# Eval("ESTABLISHSINCE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                        <td style="height: 19px">
                            Employee Number</td>
                        <td style="height: 19px">
                            <asp:Label ID="Label27" runat="server" Font-Underline="True" Text='<%# Eval("EMPLOYEENUMBER", "{0:N}") %>'></asp:Label></td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
        <asp:SqlDataSource ID="sdsLoanData" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            SelectCommand="SELECT APPLICATION.LOCID, APPLICATION.APPID, ACCOUNT.ACCID, ACCOUNT.PRINCIPALTOTAL, ACCOUNT.TENOR, ACCOUNT.LOANTYPE, ACCOUNT.EFFECTIVERATE, ACCOUNT.INSTALLMENT, ACCOUNT.INSTALLMENTDAY, ACCOUNT.DEPOSIT, ACCOUNT.NEXTDUEDATE, ACCOUNT.INSTALLMENT * ACCOUNT.TENOR - ACCOUNT.PRINCIPALTOTAL AS INTERESTTOTAL, ACCOUNT.PRINCIPALTOTAL - (SELECT ISNULL(SUM(PRINCIPALTP), 0) AS Expr1 FROM INSTALLMENTTP WHERE (ACCOUNT.LOCID = LOCID) AND (ACCOUNT.ACCID = ACCID)) AS OSPRINCIPALTP, ACCOUNT.PRINCIPALTOTAL - (SELECT ISNULL(SUM(PRINCIPALPAID), 0) AS Expr1 FROM INSTALLMENT AS INSTALLMENT_1 WHERE (ACCOUNT.LOCID = LOCID) AND (ACCOUNT.ACCID = ACCID)) AS OSPRINCIPALREAL, ACCOUNT.INSTALLMENT * ACCOUNT.TENOR - ACCOUNT.PRINCIPALTOTAL - (SELECT ISNULL(SUM(INTERESTTP), 0) AS Expr1 FROM INSTALLMENTTP AS INSTALLMENT_2 WHERE (ACCOUNT.LOCID = LOCID) AND (ACCOUNT.ACCID = ACCID)) AS OSINTERESTTP, ACCOUNT.INSTALLMENT * ACCOUNT.TENOR - ACCOUNT.PRINCIPALTOTAL - (SELECT ISNULL(SUM(INTERESTPAID), 0) AS Expr1 FROM INSTALLMENT AS INSTALLMENT_1 WHERE (ACCOUNT.LOCID = LOCID) AND (ACCOUNT.ACCID = ACCID)) AS OSINTERESTREAL, (SELECT NAME FROM PARAMGLOBAL WHERE (ACCOUNT.LOANTYPE = CODE) AND (TYPE = 'LOANTYPE')) AS LOANTYPENAME, ACCOUNTDTL.EFFECTIVERATETP, ACCOUNTDTL.INSTALLMENTTP, COMPANY.COMPCODE, COMPANY.COMPNAME, COMPANY.ESTABLISHSINCE, COMPANY.EMPLOYEENUMBER, COMPANY.PLAFOND, ACCOUNTDTL.FLATRATETP FROM ACCOUNT WITH (NOLOCK) INNER JOIN APPLICATION WITH (NOLOCK) ON ACCOUNT.LOCID = APPLICATION.LOCID AND ACCOUNT.APPID = APPLICATION.APPID INNER JOIN ACCOUNTDTL ON ACCOUNT.LOCID = ACCOUNTDTL.LOCID AND ACCOUNT.ACCID = ACCOUNTDTL.ACCID INNER JOIN COMPANY ON ACCOUNT.COMPID = COMPANY.COMPID WHERE (APPLICATION.LOCID = @LOCID) AND (APPLICATION.APPID = @APPID) AND (ACCOUNT.Deletests = 0)">
            <SelectParameters>
                <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
                <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel><asp:Panel ID="pnlInstShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgInstData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblInstData" runat="server" CssClass="required">(Show Installment Data...)</asp:Label>
        </div>
        <input id="Button2" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEInst" runat="server" CollapseControlID="pnlInstShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Installment Third Party Data...)" Enabled="True"
        ExpandControlID="pnlInstShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Installment Third Party Data...)"
        ImageControlID="imgInstData" TargetControlID="pnlInstData" TextLabelID="lblInstData">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlInstData" runat="server"  
        Font-Bold="True" Width="100%">
    <asp:GridView ID="gvInstallment" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        Caption="INSTALLMENT THIRD PARTY DATA" DataSourceID="sdsInstallment" Width="100%">
        <Columns>
            <asp:BoundField DataField="PERIODTP" HeaderText="PER" SortExpression="PERIODTP">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="DUEDATETP" DataFormatString="{0:dd/MM/yyyy}" HeaderText="DUE&lt;br&gt;DATE"
                HtmlEncode="False" SortExpression="DUEDATETP">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="PRINCIPAL" DataFormatString="{0:N}" HeaderText="PRINCIPAL&lt;br&gt;Account"
                HtmlEncode="False" SortExpression="PRINCIPAL">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="INTEREST" DataFormatString="{0:N}" HeaderText="INTEREST&lt;BR&gt;Account"
                HtmlEncode="False" SortExpression="INTEREST">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="PRINCIPALTP" DataFormatString="{0:N}" HeaderText="PRINCIPAL&lt;BR&gt;Thrid Party"
                HtmlEncode="False" SortExpression="PRINCIPALTP">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="INTERESTTP" DataFormatString="{0:N}" HeaderText="INTEREST&lt;br&gt;Third Party"
                HtmlEncode="False" SortExpression="INTERESTTP">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="DIFFINTEREST" DataFormatString="{0:N}" HeaderText="Interest&lt;br&gt;Difference"
                HtmlEncode="False" SortExpression="DIFFINTEREST">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:CheckBoxField DataField="PAIDSTSTP" HeaderText="Paid&lt;br&gt;Sts" SortExpression="PAIDSTSTP">
                <ItemStyle HorizontalAlign="Center" />
            </asp:CheckBoxField>
            <asp:BoundField DataField="PAIDDATETP" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Paid&lt;br&gt;Date"
                HtmlEncode="False" SortExpression="PAIDDATETP">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="PAIDTXNDATETP" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Paid&lt;br&gt;Txn Date"
                HtmlEncode="False" SortExpression="PAIDTXNDATETP">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsInstallment" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT LOCID, ACCID, ACCOUNTNO, ACCOUNTNOFORM, BRANCHID, COMPID, DUEDATETP, PERIODTP, PRINCIPAL, INTEREST, PRINCIPALTP, INTERESTTP, PAIDSTSTP, PAYIDTP, PAIDDATETP, PAIDTXNDATETP, INTEREST - INTERESTTP AS DIFFINTEREST FROM dbo.f_AccInstalmentTPList(@LOCID, @ACCID, DEFAULT) AS f_AccInstalmentTPList_1 ORDER BY PERIODTP">
        <SelectParameters>
            <asp:Parameter Name="LOCID" />
            <asp:Parameter Name="ACCID" />
        </SelectParameters>
    </asp:SqlDataSource>
    </asp:Panel>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvInstallment.ClientID%>")
</script>
</asp:Content>

