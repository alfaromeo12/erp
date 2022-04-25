<%@ Page Title="Teller Balance User Log" Language="VB" MasterPageFile="~/MXPageNoBusy.master" AutoEventWireup="false" CodeFile="TellerBalanceUserLog.aspx.vb" Inherits="Teller_TellerBalanceUserLog" %>
<%@ Register src="../UserControl/NoDataFound.ascx" tagname="NoDataFound" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">

    <asp:HiddenField ID="hidTellerID" runat="server" />
    <asp:HiddenField ID="hidAppDate" runat="server" />
    <asp:DataList ID="dlUserInfo" runat="server" Caption="TELLER USER INFO" 
        DataKeyField="UID" DataSourceID="sdsUserInfo" Width="100%">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" style="width:100%;">
                <tr>
                    <td>
                        UID</td>
                    <td>
                        <asp:Label ID="UIDLabel" runat="server" 
                            style="text-decoration: underline; font-weight: bold" 
                            Text='<%# Eval("UID") %>' />
                    </td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        User ID</td>
                    <td>
                        <asp:Label ID="UserIDLabel" runat="server" 
                            style="text-decoration: underline; font-weight: bold" 
                            Text='<%# Eval("UserID") %>' />
                    </td>
                    <td>
                        User Name</td>
                    <td>
                        <asp:Label ID="UserNameLabel" runat="server" 
                            style="text-decoration: underline; font-weight: bold" 
                            Text='<%# Eval("UserName") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        COA No.</td>
                    <td>
                        <asp:Label ID="COANOLabel" runat="server" 
                            style="text-decoration: underline; font-weight: bold" 
                            Text='<%# Eval("COANO") %>' />
                    </td>
                    <td>
                        COA Name</td>
                    <td>
                        <asp:Label ID="COANAMELabel" runat="server" 
                            style="text-decoration: underline; font-weight: bold" 
                            Text='<%# Eval("COANAME") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        Branch Code</td>
                    <td>
                        <asp:Label ID="BRANCHCODELabel" runat="server" 
                            style="text-decoration: underline; font-weight: bold" 
                            Text='<%# Eval("BRANCHCODE") %>' />
                    </td>
                    <td>
                        Branch Name</td>
                    <td>
                        <asp:Label ID="BRANCHNAMELabel" runat="server" 
                            style="text-decoration: underline; font-weight: bold" 
                            Text='<%# Eval("BRANCHNAME") %>' />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="sdsUserInfo" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        
        SelectCommand="SELECT APPUSER.UID, APPUSER.UserID, APPUSER.UserName, COA.COANO, COA.COANAME, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME FROM APPUSER WITH (NOLOCK) LEFT OUTER JOIN BRANCH WITH (NOLOCK) ON APPUSER.BRANCHID = BRANCH.BRANCHID LEFT OUTER JOIN COA WITH (NOLOCK) ON APPUSER.COAID = COA.COAID WHERE (APPUSER.UID = @TELLERID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="hidTellerID" Name="TELLERID" 
                PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
        <table cellpadding="0" cellspacing="0" width="100%" >
            <tr >
                <td >
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="ACCOUNT.ACCOUNTNO">Account No.</asp:ListItem>
        <asp:ListItem Value="ACCNOX">Account No. (Formated)</asp:ListItem>
        <asp:ListItem Value="ACCOUNT.ACCOUNTNAME">Account Name</asp:ListItem>
    </asp:DropDownList>
                </td>
                <td >
    <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox>
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajaxTBWESearch" runat="server" 
        TargetControlID="txtSearch" WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
                    <asp:Button ID="btnFunctionSearch" runat="server" Text="Search" CssClass="Search" />
                </td>
            </tr>
            <tr >
                <td >
                    Txn Date</td>
                <td >
                    <asp:RadioButton ID="rbTxnAll" runat="server" GroupName="rbTxn" Text="All" />
                    <asp:RadioButton
                        ID="rbTxnDate" runat="server" GroupName="rbTxn" Text="From" />
                    <asp:TextBox ID="txtTxnFrom" runat="server" Width="72px"></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="ajaxCETxnFrom" runat="server" 
                        Format="dd/MM/yyyy" PopupButtonID="imgTxnFrom"
                        TargetControlID="txtTxnFrom">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateTxnFrom" runat="server" 
                        Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtTxnFrom">
                    </ajaxToolkit:MaskedEditExtender>
                    <asp:Image
                        ID="imgTxnFrom" runat="server" ImageUrl="~/images/grid.gif" 
                        style="cursor: pointer" ToolTip="Calendar" />
                    To
                    <asp:TextBox ID="txtTxnTo" runat="server" Width="72px"></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="ajaxCETxnTo" runat="server" 
                        Format="dd/MM/yyyy" PopupButtonID="imgTxnTo"
                        TargetControlID="txtTxnTo">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateTxnTo" runat="server" 
                        Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtTxnTo">
                    </ajaxToolkit:MaskedEditExtender>
                    <asp:Image ID="imgTxnTo" runat="server" ImageUrl="~/images/grid.gif" 
                        style="cursor: pointer" ToolTip="Calendar" />
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    Book Type</td>
                <td >
                    <asp:DropDownList ID="ddlBTSearch" runat="server" AutoPostBack="True" DataSourceID="sdsBookTypeSearch"
                        DataTextField="BOOKTYPE" DataValueField="BTID">
                    </asp:DropDownList><asp:SqlDataSource ID="sdsBookTypeSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        
                        
                        
                        
                        SelectCommand="SELECT NULL AS BTID, NULL AS BTCODE, '[DISPLAY ALL]' AS BOOKTYPE UNION ALL SELECT BTID, BTCODE, + BTCODE + ' - ' + BTNAME AS BOOKTYPE FROM BOOKTYPE ORDER BY BTCODE">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr >
                <td >
                    Currency</td>
                <td >
                    <asp:DropDownList ID="ddlCurrency" runat="server" DataSourceID="sdsCurrency" 
                        DataTextField="CURRENCY" DataValueField="CURRENCYID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsCurrency" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        
                        
                        SelectCommand="SELECT NULL AS CURRENCYID, NULL AS CURRENCYCODE, '[DISPLAY ALL]' AS CURRENCY UNION ALL SELECT CURRENCYID, CURRENCYCODE, + CURRENCYCODE + ' - ' + CURRENCYNAME AS CURRENCY FROM CURRENCY ORDER BY CURRENCYCODE">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr >
                <td >
                    Txn Type</td>
                <td >
                    <asp:DropDownList ID="ddlTxnTypeSearch" runat="server" AutoPostBack="True" 
                        DataSourceID="sdsTxnTypeSearch" DataTextField="TXNTYPE" 
                        DataValueField="CODE">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsTxnTypeSearch" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        
                        
                        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS TXNTYPE UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS TXNTYPE FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'TXNTYPE')">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr >
                <td >
                    In/Out</td>
                <td >
                    <asp:DropDownList ID="ddlInOut" runat="server" DataSourceID="sdsInOut" 
                        DataTextField="INOUT" DataValueField="CODE">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsInOut" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        
                        
                        
                        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS INOUT UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS INOUT FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'INOUT')">
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    <asp:UpdatePanel ID="UPGrid" runat="server">
        <ContentTemplate>
            <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" 
                AutoGenerateColumns="False" Caption="Teller Balance Log" DataSourceID="sdsData" 
                Width="100%">
                <Columns>
                    <asp:BoundField DataField="REFNO" HeaderText="Ref.&lt;br&gt;No." 
                        HtmlEncode="False" SortExpression="REFNO" />
                    <asp:BoundField DataField="ACCNO" HeaderText="Account&lt;br&gt;No." 
                        HtmlEncode="False" ReadOnly="True" SortExpression="ACCNO" />
                    <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" 
                        HtmlEncode="False" SortExpression="ACCOUNTNAME" />
                    <asp:BoundField DataField="TXNTYPENAME" HeaderText="Txn&lt;br&gt;Type" 
                        HtmlEncode="False" ReadOnly="True" SortExpression="TXNTYPENAME" />
                    <asp:BoundField DataField="INOUTNAME" HeaderText="In/&lt;br&gt;Out" 
                        HtmlEncode="False" ReadOnly="True" SortExpression="INOUTNAME">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CASH" DataFormatString="{0:N}" HeaderText="Cash" 
                        SortExpression="CASH">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="NONCASH" DataFormatString="{0:N}" 
                        HeaderText="Non&lt;br&gt;Cash" HtmlEncode="False" SortExpression="NONCASH">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="APPDATE" DataFormatString="{0:dd/MM/yyyy}" 
                        HeaderText="Txn&lt;br&gt;Date" HtmlEncode="False" SortExpression="APPDATE">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="BTNAME" HeaderText="Book&lt;br&gt;Type" 
                        HtmlEncode="False" ReadOnly="True" SortExpression="BTNAME" />
                    <asp:BoundField DataField="CURRENCYNAME" HeaderText="Currency" 
                        SortExpression="CURRENCYNAME" />
                </Columns>
                <EmptyDataTemplate>
                    <uc1:NoDataFound ID="NoDataFound1" runat="server" />
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsData" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                SelectCommand="SELECT TOP (500) TELLERBALANCELOG.REFNO, '(' + CAST(TELLERBALANCELOG.TXNTYPE AS VARCHAR(20)) + ')' + dbo.f_getParamGlobalName('TXNTYPE', TELLERBALANCELOG.TXNTYPE) AS TXNTYPENAME, CASE WHEN TELLERBALANCELOG.INOUT = 0 THEN 'OUT' ELSE 'IN' END AS INOUTNAME, TELLERBALANCELOG.CASH, TELLERBALANCELOG.NONCASH, TELLERBALANCELOG.APPDATE, '(' + BOOKTYPE.BTCODE + ')' + BOOKTYPE.BTNAME AS BTNAME, ACCOUNT.ACCOUNTNAME, dbo.f_FormatAccNoByID(ACCOUNT.BRANCHID, ACCOUNT.ACCOUNTNO) AS ACCNO, '(' + CURRENCY.CURRENCYCODE + ') ' + CURRENCY.CURRENCYNAME AS CURRENCYNAME FROM TELLERBALANCELOG WITH (NOLOCK) LEFT OUTER JOIN CURRENCY ON TELLERBALANCELOG.CURRENCYID = CURRENCY.CURRENCYID LEFT OUTER JOIN ACCOUNT WITH (NOLOCK) ON CURRENCY.CURRENCYID = ACCOUNT.CURRENCYID AND TELLERBALANCELOG.LOCID = ACCOUNT.LOCID AND TELLERBALANCELOG.ACCID = ACCOUNT.ACCID LEFT OUTER JOIN BOOKTYPE WITH (NOLOCK) ON TELLERBALANCELOG.BTID = BOOKTYPE.BTID WHERE (TELLERBALANCELOG.UID = @TELLERID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hidTellerID" Name="TELLERID" 
                        PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
        FormatTable("<%=gvData.ClientID%>");
    });
</script>
</asp:Content>

