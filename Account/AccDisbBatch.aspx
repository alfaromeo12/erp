<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccDisbBatch.aspx.vb" Inherits="Txn_DisbBatch" title="Disbursement per Branch" EnableEventValidation="FALSE" MaintainScrollPositionOnPostback="true" %>

<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
<style type="text/css">
    .ajax__myTab .ajax__tab_header {
        font-family: verdana,tahoma,helvetica;
        font-size: 11px;
        border-bottom: solid 1px #999999;
        background-color: #C0C0C0;
     }    
    .ajax__myTab .ajax__tab_outer {
        padding-right: 4px;
        height: 21px;
        background-color: #C0C0C0;
        margin-right: 2px;
        border-right: solid 1px #666666;
        border-top: solid 1px #aaaaaa
     }
    .ajax__myTab .ajax__tab_inner {
        padding-left: 3px;
        background-color: #C0C0C0;
     }
    .ajax__myTab .ajax__tab_tab {
        height: 13px;
        padding: 4px;
        margin: 0;
        background-color: Gray;
     }
    .ajax__myTab .ajax__tab_hover .ajax__tab_outer {
        background-color: #cccccc
     }
    .ajax__myTab .ajax__tab_hover .ajax__tab_inner {
        background-color: #cccccc
     }
    .ajax__myTab .ajax__tab_hover .ajax__tab_tab {}
    .ajax__myTab .ajax__tab_active .ajax__tab_outer {
        background-color: #fff;
        border-left: solid 1px #999999;
     }
    .ajax__myTab .ajax__tab_active .ajax__tab_inner {
        background-color:#fff;
     }
    .ajax__myTab .ajax__tab_active .ajax__tab_tab 
    {
        background-color: white;
        color:Black
     }
    .ajax__myTab .ajax__tab_body {
        font-family: verdana,tahoma,helvetica;
        font-size: 7pt;
        border: 1px solid #999999;
        border-top: 0;
        padding: 8px;
        background-color: #ffffff;
      }
</style>

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
    <asp:HiddenField ID="txtSPV" runat="server" />
    <asp:HiddenField ID="txtAction" runat="server" />
    <asp:HiddenField ID="txtUID" runat="server" />

    
    <asp:HiddenField ID="txtAppDate" runat="server" />

    
    <asp:HiddenField ID="hidIsUserBranch" runat="server" />
    <asp:Panel ID="pnlData" runat="server" GroupingText="Search Criteria" Width="100%" CssClass="RowStyle">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                    Booking Date</td>
                <td>
                    <asp:TextBox ID="txtBookFrom" runat="server" CssClass="required" Width="72px"></asp:TextBox>
                    <asp:Image
                        ID="imgBookFrom" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer"
                        ToolTip="Calendar" />
                    <ajaxToolkit:CalendarExtender ID="ajaxCETxnDate" 
                        runat="server" Format="dd/MM/yyyy"
                            PopupButtonID="imgBookFrom" TargetControlID="txtBookFrom">
                        </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEETxnDate" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtBookFrom">
                    </ajaxToolkit:MaskedEditExtender>
                    <asp:RequiredFieldValidator ID="reqBookFrom" runat="server" ControlToValidate="txtBookFrom"
                        Display="None" ErrorMessage="[FROM Booking Date] must be entry...!" 
                        SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCETxnDate" runat="server" HighlightCssClass="ErrHighLight" 
                        TargetControlID="reqBookFrom">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    &nbsp;To
                    <asp:TextBox ID="txtBookTo" runat="server" CssClass="required" Width="72px"></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="txtBookTo_CalendarExtender" runat="server" 
                        Format="dd/MM/yyyy" PopupButtonID="imgBookTo" TargetControlID="txtBookTo">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="txtBookTo_MaskedEditExtender" runat="server" 
                        Mask="99/99/9999" MaskType="Date" TargetControlID="txtBookTo">
                    </ajaxToolkit:MaskedEditExtender>
                    <asp:Image ID="imgBookTo" runat="server" ImageUrl="~/images/grid.gif" 
                        Style="cursor: pointer" ToolTip="Calendar" />
                    <asp:RequiredFieldValidator ID="reqBookTo" runat="server" 
                        ControlToValidate="txtBookTo" Display="None" 
                        ErrorMessage="[TO Booking Date] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqBookTo_ValidatorCalloutExtender" 
                        runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBookTo">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="AlternatingRowStyle">
                    Area</td>
                <td class="AlternatingRowStyle">
                    <asp:DropDownList ID="ddlArea" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDArea" runat="server" BehaviorID="BehavArea" 
                        Category="AREA" LoadingText="[Loading Area ...]" PromptText="[DISPLAY ALL]" 
                        ServiceMethod="GetDropDownAreabyAppUserBranch" 
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlArea">
                    </ajaxToolkit:CascadingDropDown>
                    <asp:RequiredFieldValidator ID="reqARea" runat="server" 
                        ControlToValidate="ddlArea" Display="None" 
                        ErrorMessage="Area must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEArea" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqARea">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="RowStyle">
                    Branch</td>
                <td class="RowStyle">
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
                        ErrorMessage="Branch must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEBranch" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="ReqBranch">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="RowStyle">
                    Collateral Status</td>
                <td class="RowStyle">
                    <asp:RadioButton ID="rbReceive" runat="server" GroupName="rbCollSts" 
                        Text="Receive Only" />
                    &nbsp;<asp:RadioButton ID="rbAll" runat="server" GroupName="rbCollSts" 
                        Text="All Status" />
                </td>
            </tr>
            <tr>
                <td class="FooterStyle" colspan="2">
                    <asp:Button ID="btnView" runat="server" noenter="" 
                        Style="background-position: right; background-image: url(../Images/view.png); cursor: pointer; background-repeat: no-repeat; text-align: left; " 
                        Text="View Account" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <ajaxToolkit:TabContainer ID="TabContainerDisb" runat="server" ActiveTabIndex="0" 
        CssClass="ajax__myTab">
        <ajaxToolkit:TabPanel runat="server" HeaderText="Summary Info" ID="TabPanelSummary">
        <ContentTemplate>
                <asp:Panel runat="server" ID="pnlSummary" ScrollBars="Horizontal">
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
            <asp:BoundField DataField="OBJECTVALUE" DataFormatString="{0:N}" HeaderText="Object&lt;br&gt;Value&lt;br&gt;(OTR)"
                HtmlEncode="False" ReadOnly="True" SortExpression="OBJECTVALUE">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="REFUND" DataFormatString="{0:N}" 
                HeaderText="Refund&lt;br&gt;(R)" HtmlEncode="False" 
                SortExpression="REFUND">
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="TOTALFIRSTINST" DataFormatString="{0:N}" HeaderText="First Inst.&lt;br&gt;(a)"
                HtmlEncode="False" SortExpression="TOTALFIRSTINST">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="DOWNPAYMENT" DataFormatString="{0:N}" 
                HeaderText="Down&lt;br&gt;Payment&lt;br&gt;(b)" HtmlEncode="False" 
                SortExpression="DOWNPAYMENT">
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="ADMFEE" DataFormatString="{0:N}" HeaderText="Admin&lt;br&gt;Fee&lt;br&gt;(c)"
                HtmlEncode="False" SortExpression="ADMFEE">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="FIDUCIAFEE" DataFormatString="{0:N}" 
                HeaderText="Fiducia&lt;br&gt;(d)" HtmlEncode="False" 
                SortExpression="FIDUCIAFEE">
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="CHECKDOCFEE" DataFormatString="{0:N}" 
                HeaderText="Check&lt;br&gt;Doc&lt;br&gt;(e)" HtmlEncode="False" 
                SortExpression="CHECKDOCFEE">
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="SURVEYFEE" DataFormatString="{0:N}" 
                HeaderText="Survey&lt;br&gt;Fee&lt;br&gt;(f)" HtmlEncode="False" 
                SortExpression="SURVEYFEE">
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="INSPREPAID" DataFormatString="{0:N}" 
                HeaderText="Ins.&lt;br&gt;PrePaid&lt;br&gt;(g)" HtmlEncode="False" 
                SortExpression="INSPREPAID">
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="SETOFFVALUE" DataFormatString="{0:N}" 
                HeaderText="Set&lt;br&gt;Off&lt;br&gt;(h)" HtmlEncode="False" 
                SortExpression="SETOFFVALUE">
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="DEALERSUBSIDIES" DataFormatString="{0:N}" 
                HeaderText="Dealer&lt;br&gt;Subs&lt;br&gt;(i)" HtmlEncode="False" 
                SortExpression="DEALERSUBSIDIES">
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="TOTALDISBURSEMENT" DataFormatString="{0:N}" HeaderText="Disbursement&lt;br&gt;Total&lt;br&gt;(OTR+R)&lt;br&gt;-(a+b+c+d+e+f+g+h+i)"
                HtmlEncode="False" SortExpression="TOTALDISBURSEMENT">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="PENDINGDISBURSE" DataFormatString="{0:N}" 
                HeaderText="Pending&lt;br&gt;Disburse" HtmlEncode="False" 
                SortExpression="PENDINGDISBURSE">
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        </asp:GridView>
        </asp:Panel>

        </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel runat="server" HeaderText="Detail Info" ID="TabPanelDetail">
        <ContentTemplate>
                <asp:Panel runat="server" ID="pnlDtl" ScrollBars="Horizontal">
    <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
        Caption="Account Disbursement List" DataKeyNames="LOCID,ACCID" DataSourceID="sdsGrid" Width="100%">
        <Columns>
           <asp:TemplateField HeaderText="No." >
                <ItemTemplate >
                    <asp:Label ID="lblNo" runat="server" Font-Bold="True" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Acc. No.&lt;br&gt;(Formated)" SortExpression="ACCNO">
                <ItemTemplate><a href="#" onclick='ViewDetailAcc(<%# eval("LOCID") %>, <%# eval("APPID") %>)'>
                    <asp:Label ID="lblAccNo" runat="server" Font-Bold="True" Text='<%# eval("ACCNO") %>'></asp:Label></a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="REQUESTDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Request&lt;br&gt;Date"
                HtmlEncode="False" SortExpression="REQUESTDATE">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="BOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Booking&lt;br&gt;Date"
                HtmlEncode="False" SortExpression="BOOKINGDATE" />
            <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" HtmlEncode="False"
                SortExpression="ACCOUNTNAME" />
            <asp:BoundField DataField="BRANCH" HeaderText="Branch" ReadOnly="True" SortExpression="BRANCH" />
            <asp:TemplateField HeaderText="Object&lt;br&gt;Value&lt;br&gt;(OTR)" 
                SortExpression="OBJECTVALUE">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" 
                        Text='<%# Eval("OBJECTVALUE", Eval("DECPOINT")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Refund&lt;br&gt;(R)" SortExpression="REFUND">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("REFUND", Eval("DECPOINT")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="First&lt;br&gt;Inst&lt;br&gt;(a)" 
                SortExpression="FIRSTINSTALLMENT">
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" 
                        Text='<%# Eval("FIRSTINSTALLMENT", Eval("DECPOINT")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Down&lt;br&gt;Payment&lt;br&gt;(b)" 
                SortExpression="DOWNPAYMENT">
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" 
                        Text='<%# Eval("DOWNPAYMENT", Eval("DECPOINT")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Admin&lt;br&gt;Fee&lt;br&gt;(c)" 
                SortExpression="ADMFEE">
                <ItemTemplate>
                    <asp:Label ID="Label12" runat="server" Text='<%# Eval("ADMFEE", Eval("DECPOINT")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Fiducia&lt;br&gt;(d)" 
                SortExpression="FIDUCIAFEE">
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("FIDUCIAFEE", Eval("DECPOINT")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Check&lt;br&gt;Doc&lt;br&gt;(e)" 
                SortExpression="CHECKDOCFEE">
                <ItemTemplate>
                    <asp:Label ID="Label6" runat="server" 
                        Text='<%# Eval("CHECKDOCFEE", Eval("DECPOINT")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Survey&lt;br&gt;(f)" SortExpression="SURVEYFEE">
                <ItemTemplate>
                    <asp:Label ID="Label7" runat="server" Text='<%# Eval("SURVEYFEE", Eval("DECPOINT")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Ins&lt;br&gt;Pre.Paid&lt;br&gt;(g)" 
                SortExpression="INSPREPAID">
                <ItemTemplate>
                    <asp:Label ID="Label8" runat="server" Text='<%# Eval("INSPREPAID", Eval("DECPOINT")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Set&lt;br&gt;Off&lt;br&gt;(h)" 
                SortExpression="SETOFFVALUE">
                <ItemTemplate>
                    <asp:Label ID="Label9" runat="server" 
                        Text='<%# Eval("SETOFFVALUE", Eval("DECPOINT")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Dealer&lt;br&gt;Subs&lt;br&gt;(i)" 
                SortExpression="DEALERSUBSIDIES">
                <ItemTemplate>
                    <asp:Label ID="Label10" runat="server" 
                        Text='<%# Eval("DEALERSUBSIDIES", Eval("DECPOINT")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Disburse" SortExpression="TOTALDISBURSEMENT">
                <ItemTemplate>
                    <asp:Label ID="Label11" runat="server" 
                        Text='<%# Eval("TOTALDISBURSEMENT", Eval("DECPOINT")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Pending&lt;br&gt;Disburse" 
                SortExpression="PENDINGDISBURSE">
                <ItemTemplate>
                    <asp:Label ID="Label13" runat="server" Text='<%# Eval("PENDINGDISBURSE", Eval("DECPOINT")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            <uc6:NoDataFound ID="NoDataFound1" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
        </asp:Panel>

        </ContentTemplate>
        </ajaxToolkit:TabPanel>
    </ajaxToolkit:TabContainer>
    <br />
    <asp:SqlDataSource ID="sdsSummary" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT BOOKINGDATE, NUMOFACC, OBJECTVALUE, ADMFEE, TOTALFIRSTINST, FIDUCIAFEE, CHECKDOCFEE, SURVEYFEE, SETOFFVALUE, DEALERSUBSIDIES, DOWNPAYMENT, INSPREPAID, FIRSTINSTALLMENT, REFUND, (OBJECTVALUE + REFUND) - (ADMFEE + FIDUCIAFEE + CHECKDOCFEE + SURVEYFEE + SETOFFVALUE + DEALERSUBSIDIES + DOWNPAYMENT + INSPREPAID + FIRSTINSTALLMENT) AS TOTALDISBURSEMENT, PENDINGDISBURSE FROM (SELECT ACCOUNT.BOOKINGDATE, COUNT(*) AS NUMOFACC, SUM(ACCOUNT.OBJECTVALUE) AS OBJECTVALUE, SUM(ACCOUNTDTL.ADMFEE) AS ADMFEE, SUM(CASE WHEN LOANTYPE = 1 THEN INSTALLMENT ELSE 0 END) AS TOTALFIRSTINST, SUM(ACCOUNTDTL.FIDUCIAFEE) AS FIDUCIAFEE, SUM(ACCOUNTDTL.CHECKDOCFEE) AS CHECKDOCFEE, SUM(ACCOUNTDTL.SURVEYFEE) AS SURVEYFEE, SUM(ACCOUNTDTL.SETOFFVALUE) AS SETOFFVALUE, SUM(ACCOUNTDTL.DEALERSUBSIDIES) AS DEALERSUBSIDIES, SUM(ACCOUNT.DOWNPAYMENT) AS DOWNPAYMENT, SUM(ACCOUNT.INSPREMI - ACCOUNT.INSONLOAN) AS INSPREPAID, SUM(CASE WHEN LOANTYPE = 1 THEN INSTALLMENT ELSE 0 END) AS FIRSTINSTALLMENT, SUM(dbo.f_getREFUNDTRXByAccID(ACCOUNT.LOCID, ACCOUNT.ACCID, 1)) AS REFUND, SUM(ACCOUNTDTL.PENDINGDISBURSE) AS PENDINGDISBURSE FROM ACCOUNT WITH (NOLOCK) LEFT OUTER JOIN ACCOUNTDTL WITH (NOLOCK) ON ACCOUNT.LOCID = ACCOUNTDTL.LOCID AND ACCOUNT.ACCID = ACCOUNTDTL.ACCID WHERE (ACCOUNT.ACCSTATUS &lt;&gt; 0) AND (ACCOUNT.BOOKINGDATE BETWEEN CONVERT (DATETIME, @BOOKINGFROM, 103) AND CONVERT (DATETIME, @BOOKINGTO, 103)) AND (ACCOUNT.DISBURSESTS = 0) AND (ACCOUNT.BRANCHID = @BRANCHID) AND (1 = CASE WHEN @COLLSTS = 1 THEN ISNULL((SELECT MIN(0) FROM COLLATERAL WHERE ACCOUNT.LOCID = COLLATERAL.LOCID AND ACCOUNT.ACCID = COLLATERAL.ACCID AND COLLATERAL.BPKBSTATUS = 1) , 1) ELSE 1 END) GROUP BY ACCOUNT.BOOKINGDATE) AS A ORDER BY BOOKINGDATE">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtBookFrom" Name="BOOKINGFROM" 
                PropertyName="Text" />
            <asp:ControlParameter ControlID="txtBookTo" Name="BOOKINGTO" 
                PropertyName="Text" />
            <asp:ControlParameter ControlID="ddlBranch" Name="BRANCHID" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="rbReceive" Name="COLLSTS" 
                PropertyName="Checked" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT LOCID, ACCID, APPID, REQUESTDATE, BOOKINGDATE, ACCOUNTNAME, BRANCH, CUSTID, IDNUMBER, REFNO, ACCNO, OBJECTVALUE, ADMFEE, FIDUCIAFEE, CHECKDOCFEE, SURVEYFEE, SETOFFVALUE, DEALERSUBSIDIES, DOWNPAYMENT, INSPREPAID, FIRSTINSTALLMENT, REFUND, (OBJECTVALUE + REFUND) - (ADMFEE + FIDUCIAFEE + CHECKDOCFEE + SURVEYFEE + SETOFFVALUE + DEALERSUBSIDIES + DOWNPAYMENT + INSPREPAID + FIRSTINSTALLMENT) AS TOTALDISBURSEMENT, DECPOINT, PENDINGDISBURSE FROM (SELECT ACCOUNT.LOCID, ACCOUNT.ACCID, ACCOUNT.BRANCHID, ACCOUNT.ACCOUNTNO, APPLICATION.APPID, APPLICATION.REQUESTDATE, ACCOUNT.BOOKINGDATE, ACCOUNT.ACCOUNTNAME, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCH, CUSTOMER.CUSTID, CUSTOMER.IDNUMBER, ACCOUNT.REFNO, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCNO, ACCOUNT.OBJECTVALUE, ACCOUNTDTL.ADMFEE, ACCOUNTDTL.FIDUCIAFEE, ACCOUNTDTL.CHECKDOCFEE, ACCOUNTDTL.SURVEYFEE, ACCOUNTDTL.SETOFFVALUE, ACCOUNTDTL.DEALERSUBSIDIES, ACCOUNT.DOWNPAYMENT, ACCOUNT.INSPREMI - ACCOUNT.INSONLOAN AS INSPREPAID, CASE WHEN LOANTYPE = 1 THEN INSTALLMENT ELSE 0 END AS FIRSTINSTALLMENT, dbo.f_getREFUNDTRXByAccID(ACCOUNT.LOCID, ACCOUNT.ACCID, 1) AS REFUND, dbo.f_getCurrencyDecPointForNet(ACCOUNT.CURRENCYID) AS DECPOINT, ACCOUNTDTL.PENDINGDISBURSE FROM APPLICATION WITH (NOLOCK) INNER JOIN ACCOUNT WITH (NOLOCK) ON APPLICATION.LOCID = ACCOUNT.LOCID AND APPLICATION.APPID = ACCOUNT.APPID INNER JOIN CUSTOMER WITH (NOLOCK) ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID INNER JOIN AREA WITH (NOLOCK) INNER JOIN BRANCH WITH (NOLOCK) ON AREA.AREAID = BRANCH.AREAID ON ACCOUNT.BRANCHID = BRANCH.BRANCHID LEFT OUTER JOIN ACCOUNTDTL WITH (NOLOCK) ON ACCOUNT.LOCID = ACCOUNTDTL.LOCID AND ACCOUNT.ACCID = ACCOUNTDTL.ACCID WHERE (ACCOUNT.ACCSTATUS &lt;&gt; 0) AND (ACCOUNT.DISBURSESTS = 0) AND (ACCOUNT.BOOKINGDATE BETWEEN CONVERT (DATETIME, @BOOKINGFROM, 103) AND CONVERT (DATETIME, @BOOKINGTO, 103)) AND (ACCOUNT.BRANCHID = @BRANCHID) AND (1 = 1) AND (1 = CASE WHEN @COLLSTS = 1 THEN ISNULL((SELECT MIN(0) FROM COLLATERAL WITH (NOLOCK) WHERE ACCOUNT.LOCID = COLLATERAL.LOCID AND ACCOUNT.ACCID = COLLATERAL.ACCID AND COLLATERAL.BPKBSTATUS = 1) , 1) ELSE 1 END)) AS A ORDER BY BOOKINGDATE, BRANCHID, ACCOUNTNO">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtBookFrom" Name="BOOKINGFROM" 
                PropertyName="Text" />
            <asp:ControlParameter ControlID="txtBookTo" Name="BOOKINGTO" 
                PropertyName="Text" />
            <asp:ControlParameter ControlID="ddlBranch" Name="BRANCHID" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="rbReceive" Name="COLLSTS" 
                PropertyName="Checked" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
        <asp:Panel ID="pnlInit" runat="server" GroupingText="Plan Paid" Width="100%" Font-Bold="True" CssClass="RowStyle">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td class="FooterStyle" colspan="2">
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
                        Plan Paid Date</td>
                    <td class="FooterStyle">
                        <asp:TextBox ID="txtPlanPaid" runat="server" CssClass="required" 
                            ValidationGroup="ValSave" Width="72px"></asp:TextBox>
                        <asp:Image ID="imgPlanPaid" runat="server" ImageUrl="~/images/grid.gif" 
                            Style="cursor: pointer" ToolTip="Calendar" />
                        <asp:RequiredFieldValidator ID="reqPlanPaid" runat="server" 
                            ControlToValidate="txtPlanPaid" Display="None" 
                            ErrorMessage="PLAN PAID DATE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPlanPaid" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqPlanPaid">
                        </ajaxToolkit:ValidatorCalloutExtender>
                        <ajaxToolkit:CalendarExtender ID="ajaxCEPlanPaid" runat="server" Animated="False" 
                            Format="dd/MM/yyyy" PopupButtonID="imgPlanPaid" TargetControlID="txtPlanPaid">
                        </ajaxToolkit:CalendarExtender>
                        <ajaxToolkit:MaskedEditExtender ID="ajaxMEEPlanPaid" runat="server" Mask="99/99/9999" 
                            MaskType="Date" TargetControlID="txtPlanPaid">
                        </ajaxToolkit:MaskedEditExtender>
                    </td>
                </tr>
                <tr>
                    <td class="HeaderStyle" colspan="2">
                    <asp:Button ID="btnSave"
                                runat="server" Style="background-position: right;
                                background-image: url(../Images/Save.gif); cursor: pointer; background-repeat: no-repeat;
                                text-align: left; " Text="Save" ValidationGroup="ValSave" Width="88px" />
                        <asp:Button ID="btnPrint" runat="server" OnClientClick="return PrintData();" 
                            Style="background-position: right; background-image: url(../Images/print.jpg); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
                            Text="Print Data" Width="136px" Enabled="False" />
                    </td>
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
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>");
FormatTable("<%=gvSummary.ClientID%>");
function pageLoad(sender, args) {
    $find("BehavArea").add_populated(onPopulatedArea);
    $find("BehavBranch").add_populated(onPopulatedBranch);
}

function onPopulatedArea() {
    if (GetValueTxtByClientID("<%=hidIsUserBranch.ClientID%>") == "1") {
        $get("<%=ddlArea.ClientID%>").disabled = true;
    }
}

function onPopulatedBranch() {
    if (GetValueTxtByClientID("<%=hidIsUserBranch.ClientID%>") == "1") {
        $get("<%=ddlBranch.ClientID%>").disabled = true;
    }
}

function ViewDetailAcc(LOCID, APPID) {
    var winref = window.open("../Account/AccInqFrame.aspx?Action=AccInq&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
    winref.focus();
}
function GetValueTxtByClientID(ClientID){
    var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
    if (oText)
        return(oText.value);
}
function getObjectbyClientID(ClientID) {
    var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
    return (oObject)
}

function PrintData() {
    var BOOKFROM= ConvertDDMMYYYY(GetValueTxtByClientID("<%=txtBookFrom.ClientID%>"));
    var BOOKTO = ConvertDDMMYYYY(GetValueTxtByClientID("<%=txtBookTo.ClientID%>"));
    var BRANCHID = GetValueTxtByClientID("<%=ddlBranch.ClientID%>");
    var oReceived = getObjectbyClientID("<%=rbReceive.ClientID%>");
    var sReceive = "0";
    if (oReceived.checked)
        sReceive = "1";

    if (Page_ClientValidate("")) {
        var winref = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/Disbursement_InpurPerBranch&BOOKINGFROM=" + BOOKFROM + "&BRANCHID=" + BRANCHID + "&BOOKINGTO=" + BOOKTO  +"&COLLSTS=" + sReceive, "DisbursementPerBranch", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
        winref.focus();
    }
    return false;
}
function ConvertDDMMYYYY(sDate) {
    var arrDate = sDate.split("/")
    return (arrDate[2] + "-" + arrDate[1] + "-" + arrDate[0]);

}
</script>

</asp:Content>

