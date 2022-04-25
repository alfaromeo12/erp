<%@ Page Title="General Transaction Approval" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="TxnInputInquiry.aspx.vb" Inherits="Txn_TxnInputInquiry" EnableEventValidation="false" %>
<%@ Register src="../UserControl/NoDataFound.ascx" tagname="NoDataFound" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:ScriptManagerProxy ID="SMPTxn" runat="server">
		<Services>
			<asp:ServiceReference Path="GHWService.asmx" />
		</Services>
	</asp:ScriptManagerProxy>
    <asp:HiddenField ID="hidIsUserBranch" runat="server" />
    <asp:HiddenField ID="txtAction" runat="server" />
    <asp:HiddenField ID="hidLOCIDTXN" runat="server" />
    <asp:HiddenField ID="hidTXNID" runat="server" />
    <asp:HiddenField ID="hidRefNo" runat="server" />
    <asp:HiddenField ID="txtUID" runat="server" />

    
    <asp:HiddenField ID="txtAppDate" runat="server" />

    
        <asp:HiddenField ID="hidBookCode" runat="server" />
       <asp:CheckBox ID="chkAddNew" runat="server" Font-Names="Lucida Sans" 
                            Font-Size="7.5pt" Visible="False"/>
    <asp:MultiView ID="MVTxn" runat="server">
        <asp:View ID="vSearch" runat="server">
            <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="99%">
                <div style="float: right; vertical-align: middle">
                    <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" 
                        ImageUrl="~/images/expand.jpg" />
                    <asp:Label ID="lblShow" runat="server">(Show Search Criteria...)</asp:Label>
                </div>
                <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" />
            </asp:Panel>
            <asp:Panel ID="pnlData" runat="server" GroupingText="Search Criteria" 
                Width="99%">
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            <asp:DropDownList ID="ddlCriteria" runat="server">
                                <asp:ListItem Value="TXN.REFNO">Reference No.</asp:ListItem>
                                <asp:ListItem Value="ACCOUNT.ACCOUNTNO">Account No.</asp:ListItem>
                                <asp:ListItem Value="ACCNOX">Account No. (Formated)</asp:ListItem>
                                <asp:ListItem Value="ACCOUNT.ACCOUNTNAME">Account Name</asp:ListItem>
                                <asp:ListItem Value="TXN.TXNID">TXN ID</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
                            <asp:Button ID="btnFunctionSearch" runat="server" CssClass="Search" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset" 
                                Text="Search" />
                            <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" 
                                TargetControlID="txtSearch" WatermarkText="%%">
                            </ajaxToolkit:TextBoxWatermarkExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Txn Date</td>
                        <td colspan="3">
                            <asp:RadioButton ID="rbTxnAll" runat="server" GroupName="rbTxn" Text="All" />
                            <asp:RadioButton ID="rbTxnDate" runat="server" GroupName="rbTxn" Text="From" />
                            <asp:TextBox ID="txtTxnFrom" runat="server" Width="72px" CssClass="required"></asp:TextBox>
                            <asp:Image ID="imgTxnFrom" runat="server" ImageUrl="~/images/grid.gif" 
                                style="cursor: pointer" ToolTip="Calendar" />
                            To
                            <asp:TextBox ID="txtTxnTo" runat="server" Width="72px" CssClass="required"></asp:TextBox>
                            <asp:Image ID="imgTxnTo" runat="server" ImageUrl="~/images/grid.gif" 
                                style="cursor: pointer" ToolTip="Calendar" />
                            <ajaxToolkit:CalendarExtender ID="ajaxCETxnFrom" runat="server" 
                                Format="dd/MM/yyyy" PopupButtonID="imgTxnFrom" TargetControlID="txtTxnFrom">
                            </ajaxToolkit:CalendarExtender>
                            <ajaxToolkit:CalendarExtender ID="ajaxCETxnTo" runat="server" 
                                Format="dd/MM/yyyy" PopupButtonID="imgTxnTo" TargetControlID="txtTxnTo">
                            </ajaxToolkit:CalendarExtender>
                            <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateTxnFrom" runat="server" 
                                Mask="99/99/9999" MaskType="Date" TargetControlID="txtTxnFrom">
                            </ajaxToolkit:MaskedEditExtender>
                            <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateTxnTo" runat="server" 
                                Mask="99/99/9999" MaskType="Date" TargetControlID="txtTxnTo">
                            </ajaxToolkit:MaskedEditExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Reversal Date</td>
                        <td colspan="3">
                            <asp:RadioButton ID="rbRevAll" runat="server" GroupName="rbRev" Text="All" />
                            <asp:RadioButton ID="rbRevFrom" runat="server" GroupName="rbRev" Text="From" />
                            <asp:TextBox ID="txtRevFrom" runat="server" CssClass="required" Width="72px"></asp:TextBox>
                            <asp:Image ID="imgRevFrom" runat="server" ImageUrl="~/images/grid.gif" 
                                style="cursor: pointer" ToolTip="Calendar" />
                            To
                            <asp:TextBox ID="txtRevTo" runat="server" CssClass="required" Width="72px"></asp:TextBox>
                            <asp:Image ID="imgRevTo" runat="server" ImageUrl="~/images/grid.gif" 
                                style="cursor: pointer" ToolTip="Calendar" />
                            <ajaxToolkit:CalendarExtender ID="ajaxCERevFrom" runat="server" 
                                Format="dd/MM/yyyy" PopupButtonID="imgRevFrom" TargetControlID="txtRevFrom">
                            </ajaxToolkit:CalendarExtender>
                            <ajaxToolkit:CalendarExtender ID="ajaxCERevTo" runat="server" 
                                Format="dd/MM/yyyy" PopupButtonID="imgRevTo" TargetControlID="txtRevTo">
                            </ajaxToolkit:CalendarExtender>
                            <ajaxToolkit:MaskedEditExtender ID="ajaxMEERevFrom" runat="server" 
                                Mask="99/99/9999" MaskType="Date" TargetControlID="txtRevFrom">
                            </ajaxToolkit:MaskedEditExtender>
                            <ajaxToolkit:MaskedEditExtender ID="ajaxMEERevTo" runat="server" 
                                Mask="99/99/9999" MaskType="Date" TargetControlID="txtRevTo">
                            </ajaxToolkit:MaskedEditExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Area</td>
                        <td>
                            <asp:DropDownList ID="ddlAreaSearch" runat="server">
                            </asp:DropDownList>
                            <ajaxToolkit:CascadingDropDown ID="ajaxCDDArea" runat="server" BehaviorID="BehavArea" 
                                Category="AREA" LoadingText="[Loading Area ...]" PromptText="[DISPLAY ALL]" 
                                ServiceMethod="GetDropDownAreabyAppUserBranch" 
                                ServicePath="~\Param\WebService.asmx" TargetControlID="ddlAreaSearch">
                            </ajaxToolkit:CascadingDropDown>
                        </td>
                        <td>
                            Branch</td>
                        <td>
                            <asp:DropDownList ID="ddlBranchSearch" runat="server">
                            </asp:DropDownList>
                            <ajaxToolkit:CascadingDropDown ID="ajaxCDDBranch" runat="server" 
                                BehaviorID="BehavBranch" Category="BRANCH" LoadingText="[Loading Branch...]" 
                                ParentControlID="ddlAreaSearch" PromptText="[DISPLAY ALL]" 
                                ServiceMethod="GetDropDownBranchByAppUserBranch" 
                                ServicePath="~\Param\WebService.asmx" TargetControlID="ddlBranchSearch">
                            </ajaxToolkit:CascadingDropDown>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Reversal</td>
                        <td>
                            <asp:DropDownList ID="ddlRevStatusSearch" runat="server" 
                                DataSourceID="sdsRevStatus" DataTextField="YESNO" DataValueField="CODE">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsRevStatus" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:connection %>" 
                                
                                SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS YESNO UNION ALL SELECT CODE, CODE + ' - ' + NAME AS YESNO FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'YESNO')">
                            </asp:SqlDataSource>
                        </td>
                        <td>
                            Txn Status</td>
                        <td>
                            <asp:DropDownList ID="ddlStatusSearch" runat="server" 
                                datasourceid="sdsTxnStatus0" DataTextField="NAME" DataValueField="CODE">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsTxnStatus0" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:connection %>" 
                                SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL] ' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'TXNSTATUS')">
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Book Code</td>
                        <td colspan="3">
                            <asp:DropDownList ID="ddlBookCodeSearch" runat="server" 
                                datasourceid="sdsBookCodeSearch" DataTextField="BCNAME" DataValueField="BCID">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsBookCodeSearch" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:connection %>" 
                                
                                SelectCommand="SELECT NULL AS BCID, NULL AS BCCODE, '[DISPLAY ALL]' AS BCNAME UNION ALL SELECT BCID, BCCODE, BCCODE + ' - ' + BCNAME AS BCNAME FROM BOOKCODE WITH (NOLOCK) WHERE (USEDTXN = 1) ORDER BY BCCODE">
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Finance Category</td>
                        <td colspan="3">
                            <asp:DropDownList ID="ddlFinanceCategory" runat="server">
                            </asp:DropDownList>
                            <ajaxToolkit:CascadingDropDown ID="ajaxCCDFincat" runat="server" 
                                BehaviorID="BehavFinCat" Category="FINCAT" 
                                LoadingText="[Loading Finance Category ...]" PromptText="[DISPLAY ALL]" 
                                ServiceMethod="GetDropDownFinCatbyAppUserBranch" 
                                ServicePath="~\Param\WebService.asmx" TargetControlID="ddlFinanceCategory">
                            </ajaxToolkit:CascadingDropDown>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEData" runat="server" 
                CollapseControlID="pnlShow" CollapsedImage="~/images/expand.jpg" 
                CollapsedText="(Show Search Criteria...)" Enabled="True" 
                ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" 
                ExpandedText="(Hide Search Criteria...)" ImageControlID="imgButtonShow" 
                TargetControlID="pnlData" TextLabelID="lblShow">
            </ajaxToolkit:CollapsiblePanelExtender>
            <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" 
                AutoGenerateColumns="False" Caption="General Transaction List" 
                DataKeyNames="LOCIDTXN,TXNID,BCCODE" DataSourceID="sdsData" Width="100%" 
                RowHeaderColumn="TXNID">
                <Columns>
                    <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                        <ItemStyle Width="20px" />
                    </asp:CommandField>
                      <asp:TemplateField HeaderText="JRN&lt;BR&gt;TXN">
                            <ItemTemplate>
                                <img src="../Images/journal.gif" onclick='ShowJournalPay("<%#eval("JOURNALREFNO")%>", "<%#eval("BCCODE")%> ")' alt='Show Journal' style='cursor: pointer; height: 16px; visibility:<%#eval("ShowJournal")%>;' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="LOCIDTXN" HeaderText="Loc&lt;br&gt;ID" 
                        HtmlEncode="False" ReadOnly="True" SortExpression="LOCIDTXN">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TXNID" HeaderText="Txn&lt;br&gt;ID" 
                        HtmlEncode="False" ReadOnly="True" SortExpression="TXNID" />
                    <asp:BoundField DataField="REFNO" HeaderText="Ref.&lt;br&gt;No." 
                        HtmlEncode="False" SortExpression="REFNO" />
                    <asp:BoundField DataField="BCNAME" HeaderText="Book&lt;br&gt;Name" 
                        HtmlEncode="False" ReadOnly="True" SortExpression="BCNAME" />
                    <asp:BoundField DataField="TXNDATE" DataFormatString="{0:dd/MM/yyyy}" 
                        HeaderText="TXN&lt;br&gt;Date" HtmlEncode="False" SortExpression="TXNDATE">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="VALUEDATE" DataFormatString="{0:dd/MM/yyyy}" 
                        HeaderText="Value&lt;br&gt;Date" HtmlEncode="False" SortExpression="VALUEDATE">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="BRANCHNAME" HeaderText="Txn&lt;br&gt;Branch" ReadOnly="True" 
                        SortExpression="BRANCHNAME" HtmlEncode="False" />
                    <asp:BoundField DataField="ACCNOFORMAT" HeaderText="Account&lt;br&gt;No" 
                        HtmlEncode="False" ReadOnly="True" SortExpression="ACCNOFORMAT" />
                    <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" 
                        HtmlEncode="False" SortExpression="ACCOUNTNAME" />
                    <asp:BoundField DataField="AMOUNT" DataFormatString="{0:N}" 
                        HeaderText="Amount&lt;br&gt;Txn" HtmlEncode="False" SortExpression="AMOUNT">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:CheckBoxField DataField="REVERSESTS" HeaderText="Rev" 
                        SortExpression="REVERSESTS" />
                    <asp:BoundField DataField="REVERSALDATE" DataFormatString="{0:dd/MM/yyyy}" 
                        HeaderText="Rev&lt;br&gt;Date" HtmlEncode="False" SortExpression="REVERSALDATE">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TXNSTATUSNAME" HeaderText="Txn&lt;br&gt;Status" 
                        HtmlEncode="False" SortExpression="TXNSTATUSNAME" />
                </Columns>
                <EmptyDataTemplate>
                    <uc1:NoDataFound ID="NoDataFound1" runat="server" />
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsData" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                
                
                
                
                
                
                
                
                
                
                SelectCommand="SELECT TOP (500) TXN.LOCIDTXN, TXN.TXNID, TXN.TXNDATE, TXN.VALUEDATE, '(' + BRANCH.BRANCHCODE + ')' + BRANCH.BRANCHNAME AS BRANCHNAME, ACCOUNT.ACCOUNTNAME, dbo.f_FormatAccNoByID(ACCOUNT.BRANCHID, ACCOUNT.ACCOUNTNO) AS ACCNOFORMAT, '(' + BOOKCODE.BCCODE + ')' + BOOKCODE.BCNAME AS BCNAME, TXN.REFNO, TXN.REVERSESTS, TXN.REVERSALDATE, TXN.TXNSTATUS, dbo.f_getParamGlobalName('TXNSTATUS', TXN.TXNSTATUS) AS TXNSTATUSNAME, CAST(TXN.LOCIDTXN AS VARCHAR(20)) + '-' + CAST(TXN.TXNID AS VARCHAR(20)) AS JOURNALREFNO, CASE WHEN TXNSTATUS IN (1 , 3) THEN 'visible' ELSE 'hidden' END AS ShowJournal, BOOKCODE.BCCODE, (SELECT ISNULL(SUM(AMOUNT), 0) AS Expr1 FROM TXNJOURNAL WITH (NOLOCK) WHERE (TXN.LOCIDTXN = LOCIDTXN) AND (TXN.TXNID = TXNID) AND (DRCR = 'D')) AS AMOUNT FROM TXN WITH (NOLOCK) INNER JOIN BRANCH WITH (NOLOCK) ON TXN.BRANCHID = BRANCH.BRANCHID INNER JOIN BOOKCODE WITH (NOLOCK) ON TXN.BCID = BOOKCODE.BCID INNER JOIN AREA WITH (NOLOCK) ON BRANCH.AREAID = AREA.AREAID LEFT OUTER JOIN ACCOUNT WITH (NOLOCK) ON TXN.LOCID = ACCOUNT.LOCID AND TXN.ACCID = ACCOUNT.ACCID WHERE (TXN.TXNID IS NOT NULL)">
            </asp:SqlDataSource>
        </asp:View>
        <asp:View ID="vEntry" runat="server">
            <asp:DataList ID="dlGeneralTrans" runat="server" Caption="TRANSACTION INFO" 
                DataSourceID="sdsForm" Width="100%">
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td class="ShowDetail" colspan="4">
                                <hr />
                            </td>
                        </tr>
                        <tr class="RowStyle">
                            <td>
                                Value Date</td>
                            <td class="RowStyle">
                                <asp:Label ID="txtValueDate" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("VALUEDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                            </td>
                            <td class="ErrHighLight">
                                Txn Date</td>
                            <td class="ErrHighLight">
                                <asp:Label ID="lblAppDate" runat="server" 
                                    style="font-weight: 700; text-decoration: underline" 
                                    Text='<%# Eval("TXNDATE", "{0:dd-MM-yyyy}") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr class="AlternatingRowStyle">
                            <td>
                                Book Code</td>
                            <td colspan="3">
                                <asp:Label ID="lblBookRemark" runat="server" CssClass="ErrHighLight" 
                                    Font-Bold="True" Font-Underline="True" Text='<%# Eval("BCNAME") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr class="RowStyle">
                            <td>
                                Currency</td>
                            <td>
                                <asp:Label ID="lblCurrency" runat="server" CssClass="ErrHighLight" 
                                    Font-Bold="True" Font-Underline="True" Text='<%# Eval("CURRENCYNAME") %>'></asp:Label>
                            </td>
                            <td>
                                Finance Category</td>
                            <td>
                                (<asp:Label ID="Label1" runat="server" CssClass="ErrHighLight" 
                                    style="font-weight: 700; text-decoration: underline" 
                                    Text='<%# Eval("FINCATCODE") %>'></asp:Label>)
                                <asp:Label ID="Label2" runat="server" CssClass="ErrHighLight" 
                                    style="font-weight: 700; text-decoration: underline" 
                                    Text='<%# Eval("FINCATNAME") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr class="AlternatingRowStyle">
                            <td>
                                <asp:Label ID="lblAccountFrom" runat="server" Text="Bank Account From"></asp:Label>
                            </td>
                            <td colspan="3">
                                <asp:Label ID="ddlAccountNm" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("ACCOUNTIDNAME") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr class="RowStyle">
                            <td>
                                <asp:Label ID="lblAccountTo" runat="server" Text="Bank Account To"></asp:Label>
                            </td>
                            <td colspan="3">
                                <asp:Label ID="ddlAccountToNm" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("ACCOUNTIDTONAME") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr class="AlternatingRowStyle">
                            <td>
                                Customer Account No</td>
                            <td colspan="3">
                                (<asp:Label ID="txtAccNo_R_" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("ACCNOFORMAT") %>'></asp:Label>)
                                <asp:Label ID="txtAccName_R_" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("ACCOUNTNAME") %>'></asp:Label>
                                <asp:HiddenField ID="hidLOCID" runat="server" Value='<%# Eval("LOCID") %>' />
                                <asp:HiddenField ID="hidACCID" runat="server" Value='<%# Eval("ACCID") %>' />
                            </td>
                        </tr>
                        <tr class="RowStyle">
                            <td>
                                Ref. No</td>
                            <td colspan="3">
                                <asp:Label ID="txtRefNo" runat="server" Font-Bold="True" Font-Underline="True" 
                                    Text='<%# Eval("REFNO") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr class="AlternatingRowStyle">
                            <td>
                                Remark</td>
                            <td colspan="3">
                                <asp:Label ID="txtRemark" runat="server" Font-Bold="True" Font-Underline="True" 
                                    Text='<%# Eval("REMARK") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr class="RowStyle">
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="FooterStyle" colspan="4">
                                <hr />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <asp:Button ID="btnPrintTxn" runat="server" OnClientClick="return PrintData();" 
                                    Style="background-position: right; background-image: url('../Images/print.jpg'); cursor: pointer; background-repeat: no-repeat; text-align: left" 
                                    Text="Print General Transaction" Width="221px" />
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
               <asp:GridView ID="gvJournal" runat="server" AutoGenerateColumns="False" DataSourceID="sdsGridJournal"
                                    Caption="JOURNAL" AllowPaging="True" AllowSorting="True" ShowFooter="True" 
                                        DataKeyNames="LOCIDTXN,TXNID" Width="100%" >
                                    <Columns>
                                        <asp:TemplateField HeaderText="No">  
                                            <ItemTemplate>     
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                             <ItemStyle HorizontalAlign="Center" />
                                         </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Debet">
                                            <ItemTemplate>
                                              <asp:Label ID="lblTxnJournalID" runat="server" Visible="false"
                                                    Text='<%# Eval("TXNJOURNALID") %>'></asp:Label>
                                                  <asp:Label ID="lblCoaID" runat="server" Visible="false"
                                                    Text='<%# Eval("COAID") %>'></asp:Label>
                                                <asp:Label ID="lblCoaDebet" runat="server" 
                                                    Text='<%# iif(Eval("DRCR")="D",Eval("COANO"),"") %>'></asp:Label>
                                            </ItemTemplate>
                                 
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Kredit">
                                            <FooterTemplate>
                                                <asp:Label ID="label" runat="server"
                                                    Font-Bold="True" Font-Size="10pt" ForeColor="White">Total :</asp:Label>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblCoaKredit" runat="server" 
                                                    Text='<%# iif(Eval("DRCR")="C",Eval("COANO"),"") %>'></asp:Label>
                                            </ItemTemplate>
                                   
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Debet Amount" FooterStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="txtAmountDebet" style="text-align:right" runat="server"  
                                                    DataFormatString="{0:n}" 
                                                    Text='<%# Eval("DEBET", "{0:n}") %>' 
                                                    Width="99%"></asp:Label>
                                               
                                            </ItemTemplate>
                                            <FooterTemplate >
                                                <asp:Label ID="txtTotalAmountDebet" runat="server" Font-Bold="True"   ReadOnly="true" style="text-align:right; width:99%;">
                                                        </asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Kredit Amount" FooterStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="txtAmountKredit" style="text-align:right" runat="server"  
                                                    DataFormatString="{0:n}"  
                                                    Text='<%# Eval("KREDIT", "{0:N}") %>'
                                                   Width="99%"></asp:Label>
                                               
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="txtTotalAmountKredit" runat="server" Font-Bold="True"  ReadOnly="true" style="text-align:right; width:99%;">
                                                        </asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                     <FooterStyle BackColor="#990000"  Font-Bold="True" ForeColor="White" HorizontalAlign="Right" />
                                    <EmptyDataTemplate>
                                        <uc1:NoDataFound ID="NoDataFound2" runat="server" />
                                    </EmptyDataTemplate>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsGridJournal" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                                    SelectCommand="SELECT TXNJOURNAL.LOCIDTXN, TXNJOURNAL.TXNID, TXNJOURNAL.TXNJOURNALID, COA.COAID, TXNJOURNAL.DRCR, '(' + COA.COANO + ') ' + COA.COANAME AS COANO, CASE WHEN DRCR = 'C' THEN 0 ELSE AMOUNT END AS DEBET, CASE WHEN DRCR = 'D' THEN 0 ELSE AMOUNT END AS KREDIT FROM TXNJOURNAL WITH (NOLOCK) INNER JOIN COA WITH (NOLOCK) ON COA.COAID = TXNJOURNAL.COAID WHERE (TXNJOURNAL.LOCIDTXN = @LOCIDTXN) AND (TXNJOURNAL.TXNID = @TXNID) ORDER BY TXNJOURNAL.DRCR DESC">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hidLOCIDTXN" Name="LOCIDTXN" 
                                            PropertyName="Value" />
                                        <asp:ControlParameter ControlID="hidTXNID" Name="TXNID" PropertyName="Value" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsForm" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                SelectCommand="SELECT TXN.LOCIDTXN, TXN.TXNID, TXN.TXNDATE, TXN.VALUEDATE, TXN.BRANCHID, TXN.BCID, '(' + BOOKCODE.BCCODE + ') ' + BOOKCODE.BCNAME AS BCNAME, TXN.LOCID, TXN.ACCID, TXN.REFNO, (SELECT BANK.BANKNAME + '( ' + BANKACCOUNT.ACCOUNTNO + ' ) ' + ' a/n ' + BANKACCOUNT.ACCOUNTNAME AS ACCOUNTNO FROM BANKACCOUNT INNER JOIN BANK ON BANKACCOUNT.BANKID = BANK.BANKID WHERE (BANKACCOUNT.ACCOUNTID = TXN.ACCOUNTID) AND (BANKACCOUNT.DELETESTS = 0)) AS ACCOUNTIDNAME, TXN.ACCOUNTID, TXN.REVERSESTS, TXN.REVERSALDATE, TXN.REMARK, (SELECT BANK_1.BANKNAME + '( ' + BANKACCOUNT_1.ACCOUNTNO + ' ) ' + ' a/n ' + BANKACCOUNT_1.ACCOUNTNAME AS ACCOUNTNO FROM BANKACCOUNT AS BANKACCOUNT_1 INNER JOIN BANK AS BANK_1 ON BANKACCOUNT_1.BANKID = BANK_1.BANKID WHERE (BANKACCOUNT_1.ACCOUNTID = TXN.ACCOUNTIDTO) AND (BANKACCOUNT_1.DELETESTS = 0)) AS ACCOUNTIDTONAME, TXN.ACCOUNTIDTO, TXN.TXNSTATUS, dbo.f_FormatAccNoByID(ACCOUNT.BRANCHID, ACCOUNT.ACCOUNTNO) AS ACCNOFORMAT, ACCOUNT.ACCOUNTNAME, (SELECT '(' + CURRENCYCODE + ') ' + CURRENCYNAME AS Expr1 FROM CURRENCY WHERE (CURRENCYID = TXN.CURRENCYID) AND (Deletests = 0)) AS CURRENCYNAME, FINANCECATEGORY.FINCATCODE, FINANCECATEGORY.FINCATNAME FROM TXN WITH (NOLOCK) INNER JOIN BOOKCODE WITH (NOLOCK) ON TXN.BCID = BOOKCODE.BCID LEFT OUTER JOIN FINANCECATEGORY WITH (NOLOCK) ON TXN.FINCATID = FINANCECATEGORY.FINCATID LEFT OUTER JOIN ACCOUNT WITH (NOLOCK) ON TXN.LOCID = ACCOUNT.LOCID AND TXN.ACCID = ACCOUNT.ACCID WHERE (TXN.LOCIDTXN = @LOCIDTXN) AND (TXN.TXNID = @TXNID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hidLOCIDTXN" Name="LOCIDTXN" 
                            PropertyName="Value" />
                        <asp:ControlParameter ControlID="hidTXNID" Name="TXNID" PropertyName="Value" />
                    </SelectParameters>
            </asp:SqlDataSource>
                <asp:Panel ID="pnlControl" runat="server" CssClass="HeaderStyle" Style="border-right: thin inset;
		            border-top: thin inset; border-left: thin inset; border-bottom: thin inset" Width="99%">
                    <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight"
			            Font-Bold="True" Font-Underline="True" Style="text-align: center" 
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
		            <asp:Button ID="btnBack" runat="server" CausesValidation="False" CommandName="Cancel"
                        Style="background-position: left; background-image: url(../images/back.png);
			            cursor: pointer; background-repeat: no-repeat; text-align: right; " 
                        Text="Back" ToolTip="Back to List"
			            Width="72px"   />
		       </asp:Panel>
	        <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEControl" runat="server" 
                TargetControlID="pnlControl" VerticalSide="Bottom">
	        </ajaxToolkit:AlwaysVisibleControlExtender>
        </asp:View>
    </asp:MultiView>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvJournal.ClientID%>");
    FormatTable("<%=gvData.ClientID%>");
    function GetValueTxtByClientID(ClientID) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            return (oText.value);
    }
    function PrintData() {
        var LOCIDTXN = GetValueTxtByClientID("<%=hidLOCIDTXN.ClientID%>");
        var TXNID = GetValueTxtByClientID("<%=hidTXNID.ClientID%>");
        var winref = window.open("../Reports/ReportViewerCrystal.aspx?Report=/Printing/GeneralTransaction.rpt&stsprn=1&Prompt1=" + LOCIDTXN + "&Prompt2=" + TXNID, "TxnPrint", "height=400,width=550,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes'");
        winref.focus();
        return false;
    }

    function ShowJournalPay(RefNo,BookCode) {
        var WinRef = window.open("../Core/JournalViewByRefNo.aspx?Action=View&RefNo=" + RefNo + "&BookCode=" + BookCode, "Journal", "height=400,width=600,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
        WinRef.focus();
        return (false);
    }

    function ViewJournal() {

        var RefNo = GetValueTxtByClientID("<%=hidRefNo.ClientID%>");
        var BookCode = GetValueTxtByClientID("<%=hidBookCode.ClientID%>");
        var WinRef = window.open("../Core/JournalViewByRefNo.aspx?Action=View&RefNo=" + RefNo + "&BookCode=" + BookCode, "Journal", "height=400,width=600,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
        WinRef.focus();
        return (false);
      
    }
</script>

</asp:Content>

