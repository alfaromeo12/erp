<%@ Page Title="General Transaction Input" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="TxnInput.aspx.vb" Inherits="Pay_TxnInput" MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>
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
    <asp:HiddenField ID="hidTXNJournalID" runat="server" />
    <asp:HiddenField ID="txtUID" runat="server" />
        <asp:HiddenField ID="hidAction" runat="server" />
        <asp:HiddenField ID="hidCURRENCYDEF" runat="server" />

    
    <asp:HiddenField ID="txtAppDate" runat="server" />

    
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
                            Book Code</td>
                        <td colspan="3">
                            <asp:DropDownList ID="ddlBookCodeSearch" runat="server" 
                                datasourceid="sdsBookCodeSearch" DataTextField="BCNAME" DataValueField="BCID">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsBookCodeSearch" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:connection %>" 
                                
                                SelectCommand="SELECT NULL AS BCID, NULL AS BCCODE, '[DISPLAY ALL]' AS BCNAME UNION ALL SELECT BCID, BCCODE, BCCODE + ' -  ' + BCNAME AS BCNAME FROM BOOKCODE WHERE (USEDTXN = 1) ORDER BY BCCODE">
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
            <asp:ImageButton ID="imgBtnNew" runat="server" CommandName="New" 
                ImageUrl="~/images/add.gif" style="cursor: pointer" ToolTip="New Data" />
            <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" 
                AutoGenerateColumns="False" Caption="General Transaction List" 
                DataKeyNames="LOCIDTXN,TXNID" DataSourceID="sdsData" Width="100%" 
                RowHeaderColumn="TXNID">
                <Columns>
                    <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                        <ItemStyle Width="20px" HorizontalAlign="Center" />
                    </asp:CommandField>
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
                        HeaderText="Txn&lt;br&gt;Date" HtmlEncode="False" SortExpression="TXNDATE">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="VALUEDATE" DataFormatString="{0:dd/MM/yyyy}" 
                        HeaderText="Value&lt;br&gt;Date" HtmlEncode="False" SortExpression="VALUEDATE">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="AMOUNT" DataFormatString="{0:N}" 
                        HeaderText="Amount&lt;br&gt;Txn" HtmlEncode="False" SortExpression="AMOUNT">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="BRANCHNAME" HeaderText="Branch" ReadOnly="True" 
                        SortExpression="BRANCHNAME" />
                    <asp:BoundField DataField="ACCNOFORMAT" HeaderText="Account&lt;br&gt;No" 
                        HtmlEncode="False" ReadOnly="True" SortExpression="ACCNOFORMAT" />
                    <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" 
                        HtmlEncode="False" SortExpression="ACCOUNTNAME" />
                </Columns>
                <EmptyDataTemplate>
                    <uc1:NoDataFound ID="NoDataFound1" runat="server" />
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsData" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                
                
                
                
                SelectCommand="SELECT TOP (500) TXN.LOCIDTXN, TXN.TXNID, TXN.TXNDATE, TXN.VALUEDATE, '(' + BRANCH.BRANCHCODE + ')' + BRANCH.BRANCHNAME AS BRANCHNAME, ACCOUNT.ACCOUNTNAME, dbo.f_FormatAccNoByID(ACCOUNT.BRANCHID, ACCOUNT.ACCOUNTNO) AS ACCNOFORMAT, '(' + BOOKCODE.BCCODE + ')' + BOOKCODE.BCNAME AS BCNAME, TXN.REFNO, (SELECT ISNULL(SUM(AMOUNT), 0) AS Expr1 FROM TXNJOURNAL WITH (NOLOCK) WHERE (TXN.LOCIDTXN = LOCIDTXN) AND (TXN.TXNID = TXNID) AND (DRCR = 'D')) AS AMOUNT FROM TXN INNER JOIN BRANCH WITH (NOLOCK) ON TXN.BRANCHID = BRANCH.BRANCHID INNER JOIN BOOKCODE WITH (NOLOCK) ON TXN.BCID = BOOKCODE.BCID LEFT OUTER JOIN ACCOUNT WITH (NOLOCK) ON TXN.LOCID = ACCOUNT.LOCID AND TXN.ACCID = ACCOUNT.ACCID WHERE (TXN.TXNID IS NOT NULL) AND (TXN.TXNSTATUS = 0)">
            </asp:SqlDataSource>
        </asp:View>
        <asp:View ID="vEntry" runat="server">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td class="ShowDetail" colspan="4">
                        <hr />
                    </td>
                </tr>
                <tr  class="RowStyle">
                    <td>
                        Value Date</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtValueDate" runat="server" CssClass="required" Width="72px"></asp:TextBox>
                        <ajaxToolkit:CalendarExtender ID="txtValueDate_CalendarExtender" runat="server" 
                            Format="dd/MM/yyyy" PopupButtonID="imgValueDate" TargetControlID="txtValueDate">
                        </ajaxToolkit:CalendarExtender>
                        <ajaxToolkit:MaskedEditExtender ID="txtValueDate_MaskedEditExtender" 
                            runat="server" Mask="99/99/9999" MaskType="Date" TargetControlID="txtValueDate">
                        </ajaxToolkit:MaskedEditExtender>
                        <asp:Image ID="imgValueDate" runat="server" ImageUrl="~/images/grid.gif" 
                            Style="cursor: pointer" ToolTip="Calendar" />
                        <asp:RequiredFieldValidator ID="reqValuedAte" runat="server" 
                            ControlToValidate="txtValueDate" Display="None" 
                            ErrorMessage="[VALUE DATE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEValueDate" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqValuedAte">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td class="ErrHighLight">
                        Txn Date</td>
                    <td class="ErrHighLight">
                        <asp:Label ID="lblAppDate" runat="server" 
                            style="font-weight: 700; text-decoration: underline"></asp:Label>
                    </td>
                </tr>
                <tr  class="AlternatingRowStyle">
                    <td>
                        Book Code</td>
                    <td colspan="3">
                       
                        <asp:DropDownList ID="ddlBookCode" runat="server" DataSourceID="sdsBookCode" 
                            DataTextField="BCNAME" DataValueField="BCID" CssClass="required"
                            AutoPostBack="True">
                        </asp:DropDownList>
                        <asp:Label ID="lblBookRemark" runat="server" CssClass="ErrHighLight"></asp:Label>
                        <asp:SqlDataSource ID="sdsBookCode" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            SelectCommand="SELECT NULL AS BCID, NULL AS BCCODE, '[SELECT BOOK CODE]' AS BCNAME UNION ALL SELECT BCID, BCCODE, '(' + BCCODE + ')' + BCNAME AS BCNAME FROM BOOKCODE WHERE (USEDTXN = 1) ORDER BY BCCODE">
                        </asp:SqlDataSource>
                        <asp:HiddenField ID="hidJOURNALTYPE" runat="server" />
                        <asp:HiddenField ID="hidTXNTYPE" runat="server" />
                        <asp:RequiredFieldValidator ID="reqBookCode" runat="server" 
                            ControlToValidate="ddlBookCodeSearch" Display="None" 
                            ErrorMessage="[BOOK CODE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqBookCode_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBookCode">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                 <tr  class="RowStyle">
                    <td>
                        Currency</td>
                    <td colspan="3">
                        <asp:DropDownList ID="ddlCurrency" runat="server" CssClass="required" 
                            DataSourceID="sdsCurrency" DataTextField="CURRENCYNAME" 
                            DataValueField="CURRENCYID">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsCurrency" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            SelectCommand="SELECT CURRENCYID, CURRENCYCODE, '(' + CURRENCYCODE + ') ' + CURRENCYNAME AS CURRENCYNAME FROM CURRENCY WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY CURRENCYCODE">
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
                <tr class="RowStyle">
                    <td>
                        Finance Category</td>
                    <td colspan="3">
                        <asp:DropDownList ID="ddlFinCatEntry" runat="server" CssClass="required">
                        </asp:DropDownList>
                        <ajaxToolkit:CascadingDropDown ID="ajaxCCDFinCatEntry" 
                            runat="server" BehaviorID="BehavFinCat" Category="FINCAT" 
                            LoadingText="[Loading Finance Category ...]" PromptText="[FINANCE CATEGORY]" 
                            ServiceMethod="GetDropDownFinCatbyAppUserBranch" 
                            ServicePath="~\Param\WebService.asmx" TargetControlID="ddlFinCatEntry">
                        </ajaxToolkit:CascadingDropDown>
                        <asp:RequiredFieldValidator ID="reqFinCat" runat="server" 
                            ControlToValidate="ddlFinCatEntry" Display="None" 
                            ErrorMessage="[FINANCE CATEGORY] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqFinCat_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqFinCat">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr  class="AlternatingRowStyle">
                    <td>
                        <asp:Label ID="lblAccountFrom" runat="server" Text="Bank Account From"></asp:Label>
                        </td>
                    <td colspan="3">
                        <asp:DropDownList ID="ddlAccountNo" runat="server">
                        </asp:DropDownList>
                       <%-- <asp:Label ID="lblBankRemark" runat="server" CssClass="ErrHighLight"></asp:Label>--%>

                        <ajaxToolkit:CascadingDropDown ID="ajaxCCDBankFrom" 
                            runat="server" BehaviorID="BehavBankAccNo" Category="BankAccNo" 
                            LoadingText="[Loading Bank Account ...]" PromptText="[BANK ACCOUNT NO.]" 
                            ServiceMethod="GetDropDownBankAccountByUIDAndFinCat" 
                            ServicePath="~\Param\WebService.asmx" TargetControlID="ddlAccountNo">
                        </ajaxToolkit:CascadingDropDown>

                        <asp:RequiredFieldValidator ID="reqBankAcc" runat="server" 
                            ControlToValidate="ddlAccountNo" Display="None" 
                            ErrorMessage="[BANK ACCOUNT NO] must be entry...!" SetFocusOnError="True" 
                            Enabled="False" EnableTheming="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqBankAcc_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBankAcc">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                
               
                
                <tr class="RowStyle">
                    <td>
                        <asp:Label ID="lblAccountTo" runat="server" Text="Bank Account To"></asp:Label>
                        </td>
                    <td colspan="3">
                        <asp:DropDownList ID="ddlAccountTo" runat="server">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqBankAccTo" runat="server" 
                            ControlToValidate="ddlAccountTo" Display="None" 
                            ErrorMessage="[BANK ACCOUNT NO TO] must be entry...!" 
                            SetFocusOnError="True" Enabled="False"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqBankAccTo_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBankAccTo">
                        </ajaxToolkit:ValidatorCalloutExtender>

                        <ajaxToolkit:CascadingDropDown ID="ajaxCCDBankTo" 
                            runat="server" BehaviorID="BehavBankAccNoTo" Category="BankAccNo" 
                            LoadingText="[Loading Bank Account ...]" PromptText="[BANK ACCOUNT NO.]" 
                            ServiceMethod="GetDropDownBankAccountByUIDAndFinCat" 
                            ServicePath="~\Param\WebService.asmx" TargetControlID="ddlAccountTo">
                        </ajaxToolkit:CascadingDropDown>

                    </td>
                </tr>
                <tr  class="AlternatingRowStyle">
                    <td>
                        Customer Account No</td>
                    <td colspan="3">
                        <asp:TextBox ID="txtAccNo_R_" runat="server" CssClass="disabled" 
                            ValidationGroup="ViewAcc"></asp:TextBox>
                        <asp:TextBox ID="txtAccName_R_" runat="server" CssClass="disabled" 
                            Width="250px"></asp:TextBox>
                        <asp:Button ID="btnSearch" runat="server" CausesValidation="False" noenter="" 
                            OnClientClick="return SearchAccount();" 
                            Style="background-position: right; background-image: url(../Images/search.gif); cursor: pointer; background-repeat: no-repeat; text-align: left" 
                            Text="Search Account" />
                        <asp:Button ID="btnClear" runat="server" CausesValidation="False" noenter="" 
                            OnClientClick="return clearAccount();" 
                            Style="background-position: right; background-image: url(../Images/Delete.gif); cursor: pointer; background-repeat: no-repeat; text-align: left" 
                            Text="Clear Account" />
                        <asp:HiddenField ID="hidLOCID" runat="server" />
                        <asp:HiddenField ID="hidACCID" runat="server" />
                    </td>
                </tr>
                <tr  class="RowStyle">
                    <td>
                        Ref. No</td>
                    <td colspan="3">
                        <asp:TextBox ID="txtRefNo" runat="server" MaxLength="70" Width="250px"></asp:TextBox>
                    </td>
                </tr>
                <tr  class="AlternatingRowStyle">
                    <td>
                        Remark</td>
                    <td colspan="3">
                        <asp:TextBox ID="txtRemark" runat="server" Height="76px" TextMode="MultiLine" 
                            Width="315px"></asp:TextBox>
                    </td>
                </tr>
                <tr >
                    <td class="FooterStyle" colspan="4">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Button ID="btnPrintTxn" runat="server" 
                            OnClientClick="return PrintData();" 
                            Style="background-position: right; background-image: url('../Images/print.jpg'); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
                            Text="Print General Transaction" Width="199px" />
                    </td>
                </tr>
                <tr>
                <td colspan="4"></td>
                </tr>
                <tr>
                    <td colspan="4">
                     
                        <asp:GridView ID="gvJournal" runat="server" AutoGenerateColumns="False" 
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
                                        <asp:TextBox ID="txtAmountDebet" style="text-align:right" runat="server"  
                                            DataFormatString="{0:n}" 
                                            CssClass='<%# IIF(Eval("DRCR")="D", "required", "disabled") %>'
                                            Text='<%# Eval("DEBET", "{0:n}") %>' 
                                            Enabled='<%# IIF(Eval("DRCR")="D", "1", "0") %>' Width="99%"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="reqDebetAmt" runat="server" 
                                            ControlToValidate="txtAmountDebet" 
                                            Display="None" ErrorMessage="[DEBET AMOUNT] must be entry...!" 
                                            SetFocusOnError="True">
                                        </asp:RequiredFieldValidator>
                                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEDebitAmt" runat="server" 
                                            HighlightCssClass="ErrHighLight" TargetControlID="reqDebetAmt">
                                        </ajaxToolkit:ValidatorCalloutExtender>
                                    </ItemTemplate>
                                    <FooterTemplate >
                                        <asp:TextBox ID="txtTotalAmountDebet" runat="server" Font-Bold="True"  CssClass="disabled" ReadOnly="true" style="text-align:right; width:99%;">
                                                </asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Kredit Amount" FooterStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtAmountKredit" style="text-align:right" runat="server"  
                                            DataFormatString="{0:n}"  
                                            CssClass='<%# IIF(Eval("DRCR")="C", "required", "disabled") %>'
                                            Text='<%# Eval("KREDIT", "{0:N}") %>'
                                            Enabled='<%# IIF(Eval("DRCR")="C", "1", "0") %>' Width="99%"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="reqKreditAmt" runat="server" 
                                            ControlToValidate="txtAmountKredit" 
                                            Display="None" ErrorMessage="[KREDIT AMOUNT] must be entry...!" 
                                            SetFocusOnError="True">
                                        </asp:RequiredFieldValidator>
                                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEKreditAmt" runat="server" 
                                            HighlightCssClass="ErrHighLight" TargetControlID="reqKreditAmt">
                                        </ajaxToolkit:ValidatorCalloutExtender>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtTotalAmountKredit" runat="server" Font-Bold="True"  CssClass="disabled" ReadOnly="true" style="text-align:right; width:99%;">
                                                </asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                            </Columns>
                             <FooterStyle BackColor="#990000"  Font-Bold="True" ForeColor="White" HorizontalAlign="Right" />
                            <EmptyDataTemplate>
                                <uc1:NoDataFound ID="NoDataFound2" runat="server" />
                            </EmptyDataTemplate>
                        </asp:GridView> 
                        
                    </td>
                   
                </tr>
                <tr>
                    <td class="FooterStyle" colspan="4">
                        <hr />
                    </td>
                </tr>
            </table>
                <asp:Panel ID="pnlControl" runat="server" CssClass="HeaderStyle" Style="border-right: thin inset;
		            border-top: thin inset; border-left: thin inset; border-bottom: thin inset" Width="100%">
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
		            <asp:Button ID="btnSave" runat="server" CommandName="Save" OnClientClick="return ValidationDRCR()"
                        Style="background-position: left; background-image: url(../images/Save.gif);
			            cursor: pointer; background-repeat: no-repeat; text-align: right; " 
                        Text="Save" ToolTip="Save Transaction"
			            Width="72px"  />
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
    function SetValueTxtByClientID(ClientID, sValue) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            oText.value = sValue;
    }
     var WinRef = null;
    function getObjectbyClientID(ClientID) {
        var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        return (oObject)
    }
    function GetValueTxtByClientID(ClientID) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            return (oText.value);
    }
    FormatTable("<%=gvData.ClientID%>");
    FormatTable("<%=gvJournal.ClientID%>")

    window.onload = function () {
        Load();
    }

    function FinCatChange() {
        if (getObjectbyClientID("<%=ddlFinCatEntry.ClientID%>")) {
            var sUID = GetValueTxtByClientID("<%=txtUID.ClientID%>");
            var sFinCat = GetValueTxtByClientID("<%=ddlFinCatEntry.ClientID%>");
            if ($find('BehavBankAccNo')) {
                $find('BehavBankAccNo').set_contextKey(sUID + ',' + sFinCat);
                $find('BehavBankAccNo')._onParentChange(null, false);

            }
            if ($find('BehavBankAccNoTo')) {
                $find('BehavBankAccNoTo').set_contextKey(sUID + ',' + sFinCat);
                $find('BehavBankAccNoTo')._onParentChange(null, false);
            }
        }
    }
    function Load() {
        var Action = GetValueTxtByClientID('<%=hidAction.ClientID%>');
        var oPrint = getObjectbyClientID('<%=btnPrintTxn.ClientID%>');
       /* if (Action == "LOAD") {
            LoadBranch();
        }*/
        if (oPrint) {
            if (Action == "NEW")
                oPrint.style.display = "none";
            else
                oPrint.style.display = "";
        }
        FinCatChange();
    }
 /*  function LoadBranch() {
        $find("BehavArea").add_populated(onPopulatedArea);
        $find("BehavBranch").add_populated(onPopulatedBranch);
    }

    function onPopulatedArea() {
        if (GetValueTxtByClientID("<%=hidIsUserBranch.ClientID%>") == "1") {
            $get("<%=ddlAreaSearch.ClientID%>").disabled = true;
        }
    }

    function onPopulatedBranch() {
        if (GetValueTxtByClientID("<%=hidIsUserBranch.ClientID%>") == "1") {
            $get("<%=ddlBranchSearch.ClientID%>").disabled = true;
        }
    }*/
 

    function ViewDetailAcc(LOCID, APPID) {
        WinRef = window.open("../Account/AccInqFrame.aspx?Action=View&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
        WinRef.focus();
    }

    function ShowJournal(RefNo, BCCode) {
        WinRef = window.open("../Core/JournalViewByRefNo.aspx?Action=View&RefNo=" + RefNo + "&BookCode=" + BCCode, "PayJournal", "height=400,width=600,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
        WinRef.focus();
        return (false);
    }

    function SearchAccount() {
        var winref = window.open("../Unknown/AccInqLookup.aspx?Edit=99", "TxnSearchAcc", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable");
        winref.focus();
        return (false);
    }

    function setAccount(LOCID, ACCID, ACCOUNTNO, ACCOUNTNAME) {
        SetValueTxtByClientID("<%=txtAccNo_R_.ClientID%>", ACCOUNTNO);
        SetValueTxtByClientID("<%=txtAccName_R_.ClientID%>", ACCOUNTNAME);
        SetValueTxtByClientID("<%=hidLOCID.ClientID %>", LOCID);
        SetValueTxtByClientID("<%=hidACCID.ClientID %>", ACCID);
    }

    function clearAccount() {
        SetValueTxtByClientID("<%=txtAccNo_R_.ClientID%>", "");
        SetValueTxtByClientID("<%=txtAccName_R_.ClientID%>", "");
        SetValueTxtByClientID("<%=hidLOCID.ClientID %>", "");
        SetValueTxtByClientID("<%=hidACCID.ClientID %>", "");
        return (false);
    }

    function toNumeric(theValue) {
        var ValX = parseFloat(FormatNumberClear(theValue));
        if (isNaN(ValX))
            ValX = 0;
        return (ValX);
    }

   function CalcTotalDebet() {
        var oDebit = "<%=oStrtxtDebet%>";
        var oTotalDebet = getObjectbyClientID("<%=oStrtxtTotalDebet%>");
        var arrDebit = oDebit.split(",");
        var nLen = arrDebit.length - 1;
        if (nLen > 0) {
            oTotalDebet.value = 0;
            for (var i = 0; i < nLen; i++) {
                var oDebit1 = toNumeric(GetValueTxtByClientID(arrDebit[i]));
                oTotalDebet.value = FormatNumber(oDebit1 + toNumeric(oTotalDebet.value), 'True', 2);
            }
        }
    }


    function CalcTotalKredit() {
        var oKredit = "<%=oStrtxtKredit%>";
        var oTotalKredit = getObjectbyClientID("<%=oStrtxtTotalKredit%>");
        var arrKredit = oKredit.split(",");
        var nLen = arrKredit.length - 1;
        if (nLen > 0) {
            oTotalKredit.value = 0;
            for (var i = 0; i < nLen; i++) {
                var oKredit1 = toNumeric(GetValueTxtByClientID(arrKredit[i]));
                oTotalKredit.value = FormatNumber(oKredit1 + toNumeric(oTotalKredit.value), 'True', 2);
            }
        }
    }

    function ValidationDRCR() {
        var oTotalDebet = getObjectbyClientID("<%=oStrtxtTotalDebet%>");
        var oTotalKredit = getObjectbyClientID("<%=oStrtxtTotalKredit%>");
        if (oTotalDebet.value != oTotalKredit.value) {
            alert("Journal Not Balance..! \n Transaction Cannot Proces !!");
            return false;
        } else {
            if (oTotalDebet.value == 0 || oTotalKredit.value == 0) {
                alert("You Haven't Input Debet or Credit Amount");
                return false;
            }
            return true;
        }
    }

    function PrintData() {
        var LOCIDTXN = GetValueTxtByClientID("<%=hidLOCIDTXN.ClientID%>");
        var TXNID = GetValueTxtByClientID("<%=hidTXNID.ClientID%>");
        var winref = window.open("../Reports/ReportViewerCrystal.aspx?Report=/Printing/GeneralTransaction.rpt&stsprn=1&Prompt1=" + LOCIDTXN + "&Prompt2=" + TXNID, "TxnPrint", "height=400,width=550,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes'");
        winref.focus();
        return false;
    }

    

</script>

</asp:Content>

