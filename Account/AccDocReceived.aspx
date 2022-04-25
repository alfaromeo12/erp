<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccDocReceived.aspx.vb" Inherits="Txn_DocReceived" title="Document Received" EnableEventValidation="FALSE"  MaintainScrollPositionOnPostback="true"%>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Search Criteria...)</asp:Label>
        </div>
        <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Search Criteria...)" Enabled="True"
        ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Search Criteria...)"
        ImageControlID="imgButtonShow" TargetControlID="pnlData" TextLabelID="lblShow">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:HiddenField ID="txtAction" runat="server" />
    <asp:HiddenField ID="txtAppDate" runat="server" />
    <asp:HiddenField ID="hidIsUserBranch" runat="server" />
    <asp:HiddenField ID="txtUID" runat="server" />
    <asp:Panel ID="pnlData" runat="server" GroupingText="Search Criteria" Width="100%" CssClass="RowStyle">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                    Booking Date</td>
                <td colspan="3">
                    <asp:TextBox ID="txtTxnDate" runat="server" CssClass="required" Width="72px" 
                        ValidationGroup="ValView"></asp:TextBox><asp:Image
                        ID="imgTxnDate" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer"
                        ToolTip="Calendar" />
                    To
                    <asp:TextBox ID="txtTxnDateTo" runat="server" CssClass="required" Width="72px" 
                        ValidationGroup="ValView"></asp:TextBox><asp:Image
                        ID="imgTxnDateTo" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer"
                        ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxCETxnDate" runat="server" Format="dd/MM/yyyy"
                            PopupButtonID="imgTxnDate" TargetControlID="txtTxnDate">
                        </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEETxnDate" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtTxnDate">
                    </ajaxToolkit:MaskedEditExtender>
                    <asp:RequiredFieldValidator ID="reqTxnDate" runat="server" ControlToValidate="txtTxnDate"
                        Display="None" ErrorMessage="From Booking Date must be entry...!" 
                        SetFocusOnError="True" ValidationGroup="ValView"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCETxnDate" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqTxnDate">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxCETxnDateTo" runat="server" Format="dd/MM/yyyy"
                            PopupButtonID="imgTxnDateTo" TargetControlID="txtTxnDateTo">
                        </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEETxnDateTo" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtTxnDateTo">
                    </ajaxToolkit:MaskedEditExtender>
                    <asp:RequiredFieldValidator ID="reqTxnDateTo" runat="server" ControlToValidate="txtTxnDateTo"
                        Display="None" ErrorMessage="Booking To Date must be entry...!" 
                        SetFocusOnError="True" ValidationGroup="ValView"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCETxnDateTo" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqTxnDateTo">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="AlternatingRowStyle">
                    Area</td>
                <td class="AlternatingRowStyle" colspan="2">
                    <asp:DropDownList ID="ddlArea" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDArea" runat="server" BehaviorID="BehavArea" 
                        Category="AREA" LoadingText="[Loading Area ...]" PromptText="[DISPLAY ALL]" 
                        ServiceMethod="GetDropDownAreabyAppUserBranch" 
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlArea">
                    </ajaxToolkit:CascadingDropDown>
                    <asp:RequiredFieldValidator ID="reqARea" runat="server" 
                        ControlToValidate="ddlArea" Display="None" 
                        ErrorMessage="Area must be entry...!" SetFocusOnError="True" 
                        ValidationGroup="ValView"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEArea" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqARea">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="RowStyle">
                    Branch</td>
                <td class="RowStyle" colspan="2">
                    <asp:DropDownList ID="ddlBranch" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDBranch" runat="server" 
                        BehaviorID="BehavBranch" Category="BRANCH" LoadingText="[Loading Branch...]" 
                        ParentControlID="ddlArea" PromptText="[DISPLAY ALL]" 
                        ServiceMethod="GetDropDownBranchByAppUserBranch" 
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlBranch">
                    </ajaxToolkit:CascadingDropDown>
                    <asp:RequiredFieldValidator ID="ReqBranch" runat="server" 
                        ControlToValidate="ddlBranch" Display="None" 
                        ErrorMessage="Branch must be entry...!" SetFocusOnError="True" 
                        ValidationGroup="ValView"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEBranch" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="ReqBranch">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="FooterStyle" colspan="4">
                    <asp:Button ID="btnView" runat="server" noenter="" Style="background-position: right;
                        background-image: url(../Images/view.png); cursor: pointer; background-repeat: no-repeat;
                        text-align: left; " Text="View Account" 
                        ValidationGroup="ValView" /></td>
            </tr>
        </table>
    </asp:Panel>
    <asp:GridView ID="gvSummary" runat="server" AutoGenerateColumns="False" Caption="SUMMARY INFO"
        DataSourceID="sdsSummary" Width="100%">
        <Columns>
            <asp:BoundField DataField="BOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Booking&lt;br&gt;Date"
                HtmlEncode="False" SortExpression="BOOKINGDATE">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="NUMOFACC" HeaderText="Number of&lt;br&gt;Account"
                HtmlEncode="False" ReadOnly="True" SortExpression="NUMOFACC">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="PRINCIPALTOTAL" DataFormatString="{0:N}" HeaderText="Principal&lt;br&gt;Total&lt;br&gt;(a)"
                HtmlEncode="False" ReadOnly="True" SortExpression="PRINCIPALTOTAL">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="TOTALADMFEE" DataFormatString="{0:N}" HeaderText="Admin Fee&lt;br&gt;Total&lt;br&gt;(b)"
                HtmlEncode="False" SortExpression="TOTALADMFEE">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="TOTALFIRSTINST" DataFormatString="{0:N}" HeaderText="First Inst.&lt;br&gt;Total&lt;br&gt;(d)"
                HtmlEncode="False" SortExpression="TOTALFIRSTINST">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="TOTALDISBURSEMENT" DataFormatString="{0:N}" HeaderText="Disbursement&lt;br&gt;Total&lt;br&gt;(a-b-c-d)"
                HtmlEncode="False" SortExpression="TOTALDISBURSEMENT">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsSummary" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT ACCOUNT.BOOKINGDATE, COUNT(*) AS NUMOFACC, SUM(ACCOUNT.PRINCIPALTOTAL) AS PRINCIPALTOTAL, SUM(ACCOUNTDTL.ADMFEE) AS TOTALADMFEE, SUM(CASE WHEN LOANTYPE = 1 THEN INSTALLMENT ELSE 0 END) AS TOTALFIRSTINST, SUM(ACCOUNT.PRINCIPALTOTAL - ACCOUNTDTL.ADMFEE - (CASE WHEN LOANTYPE = 1 THEN INSTALLMENT ELSE 0 END)) AS TOTALDISBURSEMENT FROM ACCOUNT WITH (NOLOCK) INNER JOIN COLLATERAL ON ACCOUNT.LOCID = COLLATERAL.LOCID AND ACCOUNT.ACCID = COLLATERAL.ACCID LEFT OUTER JOIN ACCOUNTDTL WITH (NOLOCK) ON ACCOUNT.LOCID = ACCOUNTDTL.LOCID AND ACCOUNT.ACCID = ACCOUNTDTL.ACCID WHERE (ACCOUNT.ACCSTATUS = 1) AND (ACCOUNT.Deletests = 0) AND (ACCOUNT.BOOKINGDATE BETWEEN CONVERT (DATETIME, @BOOKINGDATE, 103) AND CONVERT (DATETIME, @BOOKINGDATE2, 103)) AND (COLLATERAL.BPKBSTATUS = 1) AND (ACCOUNT.BRANCHID = @BRANCHID) GROUP BY ACCOUNT.BOOKINGDATE">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtTxnDate" Name="BOOKINGDATE" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtTxnDateTo" Name="BOOKINGDATE2" PropertyName="Text" />
            <asp:ControlParameter ControlID="ddlBranch" Name="BRANCHID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Panel ID="pnlSearchAccount" runat="server" Font-Bold="True" GroupingText="Search Account"
        Visible="False" Width="100%" CssClass="FooterStyle">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="RowStyle">
                    <asp:DropDownList ID="ddlCriteria" runat="server">
                        <asp:ListItem Value="ACCOUNT.ACCOUNTNO">Account No.</asp:ListItem>
                        <asp:ListItem Value="ACCNOX">Account No. (Formated)</asp:ListItem>
                        <asp:ListItem Value="ACCOUNT.ACCOUNTNAME">Account Name</asp:ListItem>
                        <asp:ListItem Value="ACCOUNT.REFNO">Reference No.</asp:ListItem>
                        <asp:ListItem Value="ACCOUNT.ACCID">ACC ID</asp:ListItem>
                    </asp:DropDownList></td>
                <td class="AlternatingRowStyle" colspan="3">
                    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox><asp:Button ID="btnFunctionSearch"
                        runat="server" CssClass="Search" Text="Search" />
                    <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
                        WatermarkText="%%">
                    </ajaxToolkit:TextBoxWatermarkExtender>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:UpdatePanel ID="UPGrid" runat="server">
        <ContentTemplate>
            <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" 
                AutoGenerateColumns="False" Caption="Collateral Document must be Receive List" 
                DataKeyNames="LOCID,OBJID" DataSourceID="sdsGrid" Width="150%">
                <Columns>
                    <asp:TemplateField HeaderText="R">
                        <ItemTemplate>
                            <asp:CheckBox ID="cbReceive" runat="server" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="25px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Acc. No.&lt;br&gt;(Formated)" 
                        SortExpression="ACCNO">
                        <ItemTemplate>
                            <a href="#" onclick='ViewDetailAcc(<%# eval("LOCID") %>, <%# eval("APPID") %>)'>
                            <asp:Label ID="lblAccNo" runat="server" Font-Bold="True" 
                                Text='<%# eval("ACCNO") %>'></asp:Label>
                            </a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="BRANCH" HeaderText="Branch" ReadOnly="True" 
                        SortExpression="BRANCH" />
                    <asp:BoundField DataField="BOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" 
                        HeaderText="Booking&lt;br&gt;Date" HtmlEncode="False" 
                        SortExpression="BOOKINGDATE" />
                    <asp:BoundField DataField="BPKBNO" HeaderText="BPKB&lt;BR&gt;No." 
                        HtmlEncode="False" SortExpression="BPKBNO" />
                    <asp:BoundField DataField="BPKBDATE" DataFormatString="{0:dd/MM/yyyy}" 
                        HeaderText="BPKB&lt;br&gt;Date" HtmlEncode="False" SortExpression="BPKBDATE" />
                    <asp:BoundField DataField="BPKBNAME" HeaderText="BPKB&lt;br&gt;Name" 
                        HtmlEncode="False" SortExpression="BPKBNAME" />
                    <asp:BoundField DataField="BPKBCARTYPE" 
                        HeaderText="BPKB&lt;br&gt;CAR&lt;br&gt;TYPE" HtmlEncode="False" 
                        SortExpression="BPKBCARTYPE" />
                    <asp:BoundField DataField="ENGINENO" HeaderText="Engine&lt;br&gt;No." 
                        HtmlEncode="False" SortExpression="ENGINENO" />
                    <asp:BoundField DataField="CHASSISNO" HeaderText="Chassis&lt;br&gt;No." 
                        HtmlEncode="False" SortExpression="CHASSISNO" />
                    <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" 
                        HtmlEncode="False" SortExpression="ACCOUNTNAME" />
                    <asp:BoundField DataField="PRINCIPALTOTAL" DataFormatString="{0:N}" 
                        HeaderText="Principal" HtmlEncode="False" SortExpression="PRINCIPALTOTAL">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ADMFEE" DataFormatString="{0:N}" 
                        HeaderText="Admin&lt;br&gt;Fee" HtmlEncode="False" SortExpression="ADMFEE">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="FIRSTINSTALLMENT" DataFormatString="{0:N}" 
                        HeaderText="First&lt;br&gt;Inst." HtmlEncode="False" 
                        SortExpression="FIRSTINSTALLMENT">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DISBURSEMENT" DataFormatString="{0:N}" 
                        HeaderText="Disburse" HtmlEncode="False" SortExpression="DISBURSEMENT">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                </Columns>
                <EmptyDataTemplate>
                    <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsGrid" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                SelectCommand="SELECT TOP (1000) ACCOUNT.ACCID, ACCOUNT.ACCOUNTNAME, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCH, CUSTOMER.CUSTID, CUSTOMER.IDNUMBER, ACCOUNT.BOOKINGDATE, ACCOUNT.REFNO, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCNO, ACCOUNT.PRINCIPALTOTAL, ACCOUNTDTL.ADMFEE, CASE WHEN LOANTYPE = 1 THEN INSTALLMENT ELSE 0 END AS FIRSTINSTALLMENT, ACCOUNT.PRINCIPALTOTAL - ACCOUNTDTL.ADMFEE - CASE WHEN LOANTYPE = 1 THEN INSTALLMENT ELSE 0 END AS DISBURSEMENT, COLLATERAL.BPKBNO, COLLATERAL.BPKBDATE, COLLATERAL.BPKBNAME, COLLATERAL.BPKBCARTYPE, COLLATERAL.ENGINENO, COLLATERAL.CHASSISNO, COLLATERAL.LOCID, COLLATERAL.OBJID, ACCOUNT.APPID FROM ACCOUNT WITH (NOLOCK) INNER JOIN CUSTOMER WITH (NOLOCK) ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID INNER JOIN AREA WITH (NOLOCK) INNER JOIN BRANCH WITH (NOLOCK) ON AREA.AREAID = BRANCH.AREAID ON ACCOUNT.BRANCHID = BRANCH.BRANCHID INNER JOIN COLLATERAL WITH (NOLOCK) ON ACCOUNT.LOCID = COLLATERAL.LOCID AND ACCOUNT.ACCID = COLLATERAL.ACCID LEFT OUTER JOIN ACCOUNTDTL WITH (NOLOCK) ON ACCOUNT.LOCID = ACCOUNTDTL.LOCID AND ACCOUNT.ACCID = ACCOUNTDTL.ACCID WHERE (ACCOUNT.Deletests = 0) AND (ACCOUNT.ACCSTATUS = 1) AND (ACCOUNT.BOOKINGDATE BETWEEN CONVERT (DATETIME, @BOOKINGDATE, 103) AND CONVERT (DATETIME, @BOOKINGDATE2, 103)) AND (COLLATERAL.BPKBSTATUS = 1) AND (ACCOUNT.BRANCHID = @BRANCHID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtTxnDate" Name="BOOKINGDATE" 
                        PropertyName="Text" />
                    <asp:ControlParameter ControlID="txtTxnDateTo" Name="BOOKINGDATE2" 
                        PropertyName="Text" />
                    <asp:ControlParameter ControlID="ddlBranch" Name="BRANCHID" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>

    <br />
        <asp:Panel ID="pnlInit" runat="server" GroupingText="Receive Collateral Document by Search Criteria Or CheckList" Width="100%" Font-Bold="True" CssClass="RowStyle">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td class="FooterStyle" colspan="4">
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
                    </td>
                </tr>
                <tr>
                    <td class="FooterStyle">
                        Receive Date</td>
                    <td class="FooterStyle" colspan="3">
                        <asp:TextBox ID="txtReceiveDate" runat="server" CssClass="required" 
                            ValidationGroup="ValSave" Width="72px"></asp:TextBox>
                        <asp:Image ID="imgReceive" runat="server" ImageUrl="~/images/grid.gif" 
                            Style="cursor: pointer" ToolTip="Calendar" />
                        <asp:RequiredFieldValidator ID="reqReceiveDate" runat="server" 
                            ControlToValidate="txtReceiveDate" Display="None" 
                            ErrorMessage="RECEIVE DATE must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="ValSave"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPReceiveDate" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqReceiveDate">
                        </ajaxToolkit:ValidatorCalloutExtender>
                        <ajaxToolkit:CalendarExtender ID="ajaxCEReceive" runat="server" Animated="False" 
                            Format="dd/MM/yyyy" PopupButtonID="imgReceive" 
                            TargetControlID="txtReceiveDate" PopupPosition="TopRight">
                        </ajaxToolkit:CalendarExtender>
                        <ajaxToolkit:MaskedEditExtender ID="ajaxMEEReceiveDate" runat="server" 
                            Mask="99/99/9999" MaskType="Date" TargetControlID="txtReceiveDate">
                        </ajaxToolkit:MaskedEditExtender>
                    </td>
                </tr>
                <tr>
                    <td class="ShowDetail" colspan="4">
                        Document Store Location</td>
                </tr>
                <tr>
                    <td class="FooterStyle">
                        Area</td>
                    <td class="FooterStyle">
                        <asp:DropDownList ID="ddlAreaSafe" runat="server" CssClass="required" 
                            ValidationGroup="ValSave">
                        </asp:DropDownList>
                        <ajaxToolkit:CascadingDropDown ID="ajaxCCDAreaSafe" runat="server" 
                            Category="AREA" LoadingText="[Loading Area...]" PromptText="[CHOOSE AREA]" 
                            ServiceMethod="GetDropDownArea" ServicePath="~\Param\WebService.asmx" 
                            TargetControlID="ddlAreaSafe" BehaviorID="BehavAreaSafe">
                        </ajaxToolkit:CascadingDropDown>
                        <asp:RequiredFieldValidator ID="reqAreaSafe" runat="server" 
                            ControlToValidate="ddlAreaSafe" Display="None" 
                            ErrorMessage="STORE AREA must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="ValSave"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEAreaSafe" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAreaSafe">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td class="FooterStyle">
                        Branch</td>
                    <td class="FooterStyle">
                        <asp:DropDownList ID="ddlBranchSafe" runat="server" CssClass="required" 
                            ValidationGroup="ValSave">
                        </asp:DropDownList>
                        <ajaxToolkit:CascadingDropDown ID="ajaxCCDBranchSafe" runat="server" 
                            Category="BRANCH" LoadingText="[Loading Branch...]" PromptText="[CHOOSE BRANCH]" 
                            ServiceMethod="GetDropDownBranchByArea" ServicePath="~\Param\WebService.asmx" 
                            TargetControlID="ddlBranchSafe" ParentControlID="ddlAreaSafe" BehaviorID="BehavBranchSafe"></ajaxToolkit:CascadingDropDown>

                        <asp:RequiredFieldValidator ID="reqBranchSafe" runat="server" 
                            ControlToValidate="ddlBranchSafe" Display="None" 
                            ErrorMessage="STORE BRANCH must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="ValSave"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEBranchSafe" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBranchSafe">
                        </ajaxToolkit:ValidatorCalloutExtender>

                    </td>
                </tr>
                <tr>
                    <td class="FooterStyle">
                        Safe (Deposit Box)</td>
                    <td class="FooterStyle">
                        <asp:DropDownList ID="ddlDocSafe" runat="server" CssClass="required" 
                            ValidationGroup="ValSave">
                        </asp:DropDownList>
                        <ajaxToolkit:CascadingDropDown ID="ddlDocSafe_CascadingDropDown" runat="server" 
                            Category="DOCSAFE" LoadingText="[Loading DOCUMENT SAFE...]" 
                            ParentControlID="ddlBranchSafe" PromptText="[CHOOSE DOCUMENT SAFE]" 
                            ServiceMethod="GetDropDownDocSafeByBranch" 
                            ServicePath="~\Param\WebService.asmx" TargetControlID="ddlDocSafe">
                        </ajaxToolkit:CascadingDropDown>
                        <asp:RequiredFieldValidator ID="reqDocSafe" runat="server" 
                            ControlToValidate="ddlDocSafe" Display="None" 
                            ErrorMessage="DOCUMENT SAFE DEPOSIT must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="ValSave"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqDocSafe_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDocSafe">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td class="FooterStyle">
                        Shelf</td>
                    <td class="FooterStyle">
                        <asp:DropDownList ID="ddlDocShelf" runat="server" CssClass="required" 
                            ValidationGroup="ValSave">
                        </asp:DropDownList>
                        <ajaxToolkit:CascadingDropDown ID="ddlDocShelf_CascadingDropDown" runat="server" 
                            Category="DOCSHELF" LoadingText="[Loading DOCUMENT SHELF...]" 
                            ParentControlID="ddlDocSafe" PromptText="[CHOOSE DOCUMENT SHELF]" 
                            ServiceMethod="GetDropDownDocShelfByDocSafe" 
                            ServicePath="~\Param\WebService.asmx" TargetControlID="ddlDocShelf">
                        </ajaxToolkit:CascadingDropDown>
                        <asp:RequiredFieldValidator ID="reqShelf" runat="server" 
                            ControlToValidate="ddlDocShelf" Display="None" 
                            ErrorMessage="DOCUMENT STORE SHELF must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="ValSave"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqShelf_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqShelf">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td class="HeaderStyle" colspan="4">
                    <asp:Button ID="btnSaveCheck"
                                runat="server" Style="background-position: right;
                                background-image: url(../Images/Save.gif); cursor: pointer; background-repeat: no-repeat;
                                text-align: left; " Text="Receive By Check List" ValidationGroup="ValSave" Width="168px" />
                        <asp:Button ID="btnSaveAll"
                                runat="server" Style="background-position: right;
                                background-image: url(../Images/Save.gif); cursor: pointer; background-repeat: no-repeat;
                                text-align: left; " Text="Receive All Document" 
                            ValidationGroup="ValSave" Width="168px" /></td>
                </tr>
            </table>
        </asp:Panel>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEProcess" runat="server" TargetControlID="pnlInit"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>");
FormatTable("<%=gvSummary.ClientID%>");
Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
    FormatTable("<%=gvData.ClientID%>");
});

function pageLoad(sender, args) {
    $find("BehavAreaSafe").add_populated(onPopulatedAreaSafe);
    $find("BehavBranchSafe").add_populated(onPopulatedBranchSafe);
}

function onPopulatedAreaSafe() {
    if (GetValueTxtByClientID("<%=hidIsUserBranch.ClientID%>") == "1") {
        $get("<%=ddlAreaSafe.ClientID%>").disabled = true;
    }
}

function onPopulatedBranchSafe() {
    if (GetValueTxtByClientID("<%=hidIsUserBranch.ClientID%>") == "1") {
        $get("<%=ddlBranchSafe.ClientID%>").disabled = true;
    }
}
function ViewDetailAcc(LOCID, APPID){
    var winref = window.open("../Account/AccInqFrame.aspx?Action=AccInq&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
    winref.focus();
}
function GetValueTxtByClientID(ClientID){
    var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
    if (oText)
        return(oText.value);
}
function SelectRow(oCb) {
    if (oCb.checked)
        oCb.parentElement.parentElement.className = "SelectedRowStyle";
    else
        oCb.parentElement.parentElement.className = "";
}

</script>

</asp:Content>

