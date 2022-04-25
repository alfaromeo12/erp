<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccDisbPendingList.aspx.vb" Inherits="Txn_AccDisbursePending" title="Account Pending Disbursement List" EnableEventValidation="FALSE" MaintainScrollPositionOnPostback="true"%>

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
    <asp:HiddenField ID="txtUID" runat="server" />
    <asp:HiddenField ID="txtAction" runat="server" />
	<asp:HiddenField ID="hidDisburseSts" runat="server" />
    <asp:HiddenField ID="hidIsUserBranch" runat="server" />

    
    <asp:HiddenField ID="txtAppDate" runat="server" />

    
    <asp:Panel ID="pnlData" runat="server" GroupingText="Search Criteria" Width="99%">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="ACCOUNT.ACCOUNTNO">Account No.</asp:ListItem>
        <asp:ListItem Value="ACCNOX">Account No. (Formated)</asp:ListItem>
        <asp:ListItem Value="ACCOUNT.ACCOUNTNAME">Account Name</asp:ListItem>
        <asp:ListItem Value="DEALER.DEALERNAME">Dealer Name</asp:ListItem>
        <asp:ListItem Value="CUSTOMER.CUSTNO">Cust No.</asp:ListItem>
        <asp:ListItem Value="CUSTNOX">Cust No. (Formated)</asp:ListItem>
        <asp:ListItem Value="CUSTOMER.IDNUMBER">ID Number</asp:ListItem>
        <asp:ListItem Value="ACCOUNT.REFNO">Reference No.</asp:ListItem>
        <asp:ListItem Value="CUSTOMER.CUSTID">CUST ID</asp:ListItem>
        <asp:ListItem Value="ACCOUNT.ACCID">ACC ID</asp:ListItem>
        <asp:ListItem Value="COLLATERAL.BPKBNO">Object/BPKB No</asp:ListItem>
        <asp:ListItem Value="COLLATERAL.POLICENO">Police No.</asp:ListItem>
        <asp:ListItem Value="COLLATERAL.ENGINENO">Engine No.</asp:ListItem>
        <asp:ListItem Value="COLLATERAL.CHASSISNO">Chassis No.</asp:ListItem>
    </asp:DropDownList></td>
                <td colspan="3">
                    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Text="Search" CssClass="Search" />
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
                </td>
            </tr>
            <tr id="trTxn">
                <td>
                    Paid Txn Date</td>
                <td colspan="3">
                    <asp:RadioButton ID="rbTxnAll" runat="server" GroupName="rbTxn" Text="All" /><asp:RadioButton
                        ID="rbTxnDate" runat="server" GroupName="rbTxn" Text="From" />
                    <asp:TextBox ID="txtTxnFrom" runat="server" Width="72px"></asp:TextBox><asp:Image
                        ID="imgTxnFrom" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />
                    To
                    <asp:TextBox ID="txtTxnTo" runat="server" Width="72px"></asp:TextBox><asp:Image ID="imgTxnTo" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxCETxnFrom" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgTxnFrom"
                        TargetControlID="txtTxnFrom">
                        </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxCETxnTo" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgTxnTo"
                        TargetControlID="txtTxnTo">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEETxnFrom" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtBookFrom">
                    </ajaxToolkit:MaskedEditExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEETxnTo" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtTxnTo" Enabled="True">
                    </ajaxToolkit:MaskedEditExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Booking Date</td>
                <td colspan="3">
                    <asp:RadioButton ID="rbBookAll" runat="server" GroupName="rbBook" Text="All" /><asp:RadioButton
                        ID="rbBookFrom" runat="server" GroupName="rbBook" Text="From" />
                    <asp:TextBox ID="txtBookFrom"
                            runat="server" Width="72px"></asp:TextBox><asp:Image
                        ID="imgBookFrom" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />&nbsp;
                    To
                    <asp:TextBox ID="txtBookTo" runat="server" Width="72px"></asp:TextBox><asp:Image ID="imgBookTo" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxCEBookFrom" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgBookFrom"
                        TargetControlID="txtBookFrom">
                        </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxCEBookTo" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgBookTo"
                        TargetControlID="txtBookTo">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEBookFrom" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtBookFrom">
                    </ajaxToolkit:MaskedEditExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEBookTo" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtBookTo">
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
            <tr id="trDealer">
                <td>
                    Dealer</td>
                <td colspan="3">
                    <asp:DropDownList ID="ddlDealer" runat="server" AutoPostBack="True">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCCDDealer" runat="server" 
                        BehaviorID="BehavDealer" Category="DEALER" Enabled="True" 
                        LoadingText="[Loading Dealer...]" PromptText="[DISPLAY ALL]" 
                        ServiceMethod="GetDropDownDealerDisbursePending" ServicePath="~\Param\WebService.asmx" 
                        TargetControlID="ddlDealer">
                    </ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
            <tr id="trCollSts">
                <td>
                    Collateral Status</td>
                <td>
                    <asp:RadioButton ID="rbReceive" runat="server" GroupName="rbCollSts" 
                        Text="Receive Only" />
                    &nbsp;<asp:RadioButton ID="rbAll" runat="server" GroupName="rbCollSts" 
                        Text="All Status" />
                </td>
                <td>
                    Collateral&nbsp; Condition</td>
                <td>
                    <asp:DropDownList ID="ddlCondition" runat="server" DataSourceID="sdsCondition" 
                        DataTextField="NAME" DataValueField="CODE">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsCondition" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        
                        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'CONDITION')">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>
                    Disburse Status</td>
                <td>
                    <asp:DropDownList ID="ddlDisbStatus" runat="server" 
                        DataSourceID="sdsDisbStatus" DataTextField="DISBURSESTS" DataValueField="CODE">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsDisbStatus" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        
                        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS DISBURSESTS UNION ALL SELECT CODE, CODE + ' - ' + NAME AS DISBURSESTS FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'DISBURSESTS')">
                    </asp:SqlDataSource>
                </td>
                <td>
                    <asp:Label ID="lblStatus" runat="server" Text="Pending Disb. Status" 
                        Visible="False"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlStatusSearch" runat="server" DataSourceID="sdsStatus" 
                        DataTextField="DISBURSESTS" DataValueField="CODE" Visible="False">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsStatus" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        
                        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS DISBURSESTS UNION ALL SELECT CODE, CODE + ' - ' + NAME AS DISBURSESTS FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'DISBURSESTS')">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>
                    Finance Category</td>
                <td colspan="3">
                    <asp:DropDownList ID="ddlFinanceCategory" runat="server" AutoPostBack="True">
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
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="LOCID,ACCID" 
        DataSourceID="sdsGrid" Width="99%" Caption="Account Pending Disbursement List">
            <Columns>
                <asp:TemplateField HeaderText="CHK">
                    <ItemTemplate>
                        <asp:CheckBox ID="chkBox" runat="server" 
                            Visible='<%# Eval("CHECKPENDINGSHOW") %>' />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <img src="../images/edit.gif" style="cursor: pointer" onclick="EditAcc('<%#eval("LOCID")%>', '<%#eval("ACCID")%>')" alt="Edit : <%#eval("LOCID")%> - <%#eval("ACCID")%>" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="JRN">
                    <ItemTemplate>
                        <img src="../Images/journal.gif" onclick='ShowJournal("<%#eval("JOURNALREFNO")%>")' alt='Show Journal' style='cursor: pointer; visibility:<%#eval("ShowJournal")%>;' />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Acc. No.&lt;br&gt;(Formated)" SortExpression="ACCNO">
                    <ItemTemplate><a href="#" onclick='ViewDetailAcc(<%# eval("LOCID") %>, <%# eval("APPID") %>)'>
                        <asp:Label ID="lblAccNo" runat="server" Font-Bold="True" Text='<%# eval("ACCNO") %>'></asp:Label></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="BOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Booking&lt;br&gt;Date"
                    HtmlEncode="False" SortExpression="BOOKINGDATE" />
                <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="ACCOUNTNAME" />
                <asp:BoundField DataField="BRANCH" HeaderText="Branch" ReadOnly="True" SortExpression="BRANCH" />
                <asp:BoundField DataField="DEALERNAME" HeaderText="Dealer" 
                    SortExpression="DEALERNAME" />
                <asp:BoundField DataField="DISBURSESTSNAME" HeaderText="Disburse&lt;br&gt;Status"
                    HtmlEncode="False" SortExpression="DISBURSESTSNAME" />
                <asp:BoundField DataField="PENDINGSTSNAME" HeaderText="Pending&lt;br&gt;Status" 
                    HtmlEncode="False" SortExpression="PENDINGSTSNAME" />
                <asp:BoundField DataField="PENDINGDISBURSE" DataFormatString="{0:N}" 
                    HeaderText="Pending&lt;br&gt;Disburse" HtmlEncode="False" 
                    SortExpression="PENDINGDISBURSE">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="BPKBNO" HeaderText="Collateral&lt;br&gt;No." 
                    HtmlEncode="False" SortExpression="BPKBNO" />
                <asp:BoundField DataField="POLICENO" HeaderText="Police&lt;br&gt;No." 
                    HtmlEncode="False" SortExpression="POLICENO" />
                <asp:BoundField DataField="BPKBSTATUSNAME" 
                    HeaderText="Collateral&lt;br&gt;Status" HtmlEncode="False" 
                    SortExpression="BPKBSTATUSNAME" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
                    <asp:CheckBox ID="chkAll" runat="server" Text="Check All" />
                    <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" 
                        Font-Bold="True" Style="text-align: center" Visible="False" Width="100%"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblMessage">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT TOP (500) ACCOUNT.LOCID, ACCOUNT.ACCID, ACCOUNT.APPID, ACCOUNT.ACCOUNTNAME, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCH, CUSTOMER.CUSTID, CUSTOMER.IDNUMBER, ACCOUNT.BOOKINGDATE, ACCOUNT.REFNO, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCNO, '(' + CAST(ACCOUNT.DISBURSESTS AS VARCHAR(10)) + ') ' + dbo.f_getParamGlobalName('DISBURSESTS', ACCOUNT.DISBURSESTS) AS DISBURSESTSNAME, ACCOUNT.DISBURSESTS, DEALER.DEALERNAME, COLLATERAL.POLICENO, COLLATERAL.BPKBNO, dbo.f_getParamGlobalName('BPKBSTATUS', COLLATERAL.BPKBSTATUS) AS BPKBSTATUSNAME, CAST(ACCOUNT.LOCID AS VARCHAR(20)) + '-' + CAST(ACCOUNT.ACCID AS VARCHAR(30)) AS JOURNALREFNO, CASE WHEN PENDINGSTS = 2 THEN 'visible' ELSE 'hidden' END AS ShowJournal, dbo.f_getCurrencyDecPointForNet(ACCOUNT.CURRENCYID) AS DECPOINT, ACCOUNTDTL.PENDINGDISBURSE, ACCOUNTDTL.PENDINGSTS, '(' + CAST(ACCOUNTDTL.PENDINGSTS AS VARCHAR(10)) + ') ' + dbo.f_getParamGlobalName('DISBURSESTS', ACCOUNTDTL.PENDINGSTS) AS PENDINGSTSNAME, CAST(CASE WHEN ACCOUNT.DISBURSESTS = 2 THEN 1 ELSE 0 END AS bit) AS CHECKPENDINGSHOW FROM ACCOUNT WITH (NOLOCK) INNER JOIN CUSTOMER WITH (NOLOCK) ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID INNER JOIN BRANCH WITH (NOLOCK) ON ACCOUNT.BRANCHID = BRANCH.BRANCHID INNER JOIN COLLATERAL WITH (NOLOCK) ON ACCOUNT.LOCID = COLLATERAL.LOCID AND ACCOUNT.ACCID = COLLATERAL.ACCID INNER JOIN DEALER ON COLLATERAL.DEALERID = DEALER.DEALERID LEFT OUTER JOIN ACCOUNTDTL WITH (NOLOCK) ON ACCOUNT.LOCID = ACCOUNTDTL.LOCID AND ACCOUNT.ACCID = ACCOUNTDTL.ACCID WHERE (ACCOUNT.ACCSTATUS = 1)"></asp:SqlDataSource>
    <asp:Panel ID="pnlProcess" runat="server" Width="100%">
        <table cellpadding="0" cellspacing="0" style="width:100%;">
            <tr>
                <td class="ShowDetail" width="100%">
                    <asp:Button ID="btnSave" runat="server" 
                        Style="background-position: right; background-image: url(../Images/Save.gif); cursor: pointer; background-repeat: no-repeat; text-align: left; " 
                        Text="Save" ValidationGroup="ValSave" Width="88px" />
                </td>
            </tr>
            <tr>
                <td class="HeaderStyle" colspan="2" width="30px" style="text-align: center">
                </td>
            </tr>
        </table>
    </asp:Panel>
		<asp:Panel ID="pnlDisbursment" runat="server" Width="100%" 
            GroupingText="Disbursement Pending" CssClass="RowStyle" 
        Visible="False">
			<table cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td class="FooterStyle">
						Txn Date (App Date)</td>
					<td class="FooterStyle">
						<asp:TextBox ID="txtPaidTxnDate" runat="server" CssClass="disabled" 
                            ReadOnly="True" Width="72px" ValidationGroup="ValApp"></asp:TextBox></td>
				</tr>
				<tr>
					<td class="FooterStyle">
						Txn Type</td>
					<td class="FooterStyle">
						<asp:DropDownList ID="ddlTxnType" runat="server" CssClass="required" DataSourceID="sdsTxnType"
							DataTextField="TXNTYPE" DataValueField="CODE" ValidationGroup="ValApp">
						</asp:DropDownList><asp:SqlDataSource ID="sdsTxnType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
							
                            
                            
                            
                            
                            SelectCommand="SELECT NULL AS CODE, '[TXN TYPE]' AS TXNTYPE UNION ALL SELECT CODE, CODE + ' - ' + NAME AS TXNTYPE FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'TXNTYPE') AND (CODE IN ('1', '2'))">
						</asp:SqlDataSource>
					    <asp:RequiredFieldValidator ID="reqPaymentType" runat="server" 
                            ControlToValidate="ddlTxnType" Display="None" 
                            ErrorMessage="PAYMENT TYPE must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="ValApp"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPaymentType" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqPaymentType">
                        </ajaxToolkit:ValidatorCalloutExtender>
					</td>
				</tr>
			    <tr ID="trBank">
                    <td class="FooterStyle">
                        Bank Account No.</td>
                    <td class="FooterStyle">
                        <asp:DropDownList ID="ddlAccountNo" runat="server">
                        </asp:DropDownList>
                        <ajaxToolkit:CascadingDropDown ID="ajaxCCDBankAcc" runat="server" 
                            BehaviorID="BehavBankAccNo" Category="BankAccNo" 
                            LoadingText="[Loading Bank Account ...]" PromptText="[BANK ACCOUNT NO.]" 
                            ServiceMethod="GetDropDownBankAccountByUIDAndFinCat" 
                            ServicePath="~\Param\WebService.asmx" TargetControlID="ddlAccountNo">
                        </ajaxToolkit:CascadingDropDown>
                    </td>
                </tr>
			    <tr>
                    <td class="FooterStyle">
                        Dealer Bank Account</td>
                    <td class="FooterStyle">
                        <asp:DropDownList ID="ddlDealerAccount" runat="server" CssClass="required">
                        </asp:DropDownList>
                        <ajaxToolkit:CascadingDropDown ID="ddlDealerAccount_CascadingDropDown" runat="server" 
                            BehaviorID="BehavDealerAccount" Category="DEALERACCOUNT" 
                            LoadingText="[Loading Dealer Account...]" ParentControlID="ddlDealer" 
                            PromptText="[CHOOSE DEALER ACCOUNT]" ServiceMethod="GetDropDownDealerAccount" 
                            ServicePath="~\Param\WebService.asmx" TargetControlID="ddlDealerAccount">
                        </ajaxToolkit:CascadingDropDown>
                        <asp:RequiredFieldValidator ID="reqDealerAccount" runat="server" 
                            ControlToValidate="ddlDealerAccount" Display="None" 
                            ErrorMessage="DEALER ACCOUNT must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="ValApp"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxCEDealerAccount" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqDealerAccount">
                        </ajaxToolkit:ValidatorCalloutExtender>
                        &nbsp;*)Filter by selected Dealer above.</td>
                </tr>
			    <tr>
                    <td class="HeaderStyle" colspan="2">
                        <asp:Button ID="btnApprove" runat="server" OnClientClick="return ProcessApp();" 
                            Style="background-position: right; background-image: url(../Images/ok.png); cursor: pointer; background-repeat: no-repeat; text-align: left;" 
                            Text="Approve" ValidationGroup="ValApp" Width="88px" />
                    </td>
                </tr>
			</table>
		</asp:Panel>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEDisb" runat="server" 
        Enabled="True" TargetControlID="pnlDisbursment" VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxVCEProcess" runat="server" 
        Enabled="True" TargetControlID="pnlProcess" VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
  /*  function pageLoad(sender, args) {
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
    function getObjectbyClientID(ClientID) {
    var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
    return(oObject)
}
function GetValueTxtByClientID(ClientID){
    var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
    if (oText)
        return(oText.value);
}
function EditAcc(LOCID, ACCID){
    window.location = "AccDisbPendingDisplay.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&ACCID=" + ACCID;
    return (false);

}
window.onload = function () {
    var Act = GetValueTxtByClientID("<%=txtAction.ClientID%>");
    if (Act == "INIT") {
        //SetTrNone("trPlan");
        SetTrNone("trTxn");
    } else if (Act == "APP") {
        SetTrNone("trTxn");
        SetTrNone("trCollSts");
    } else if (Act == "INQ") {
        SetTrNone("trCollSts");
        SetTrNone("trDealer");
    }
    TxnTypeChange();
}
function ViewDetailAcc(LOCID, APPID){
    var winref = window.open("../Account/AccInqFrame.aspx?Action=AccInq&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
    winref.focus();
}

function SetTrNone(TrID) {
    var oDiv = getObjectbyClientID(TrID);
    if (oDiv) oDiv.style.display = "none";
}

function CheckAll() {
    var chk = getObjectbyClientID("<%=chkAll.ClientID%>");
    var sCheck = "<%=strCheckBox%>";
    var arrCheck = sCheck.split(",");
    var nLen = arrCheck.length - 1;
    if (nLen > 0) {
        for (var i = 0; i < nLen; i++) {
            var oCheck = getObjectbyClientID(arrCheck[i].toString());
            if (oCheck) {
                oCheck.checked = chk.checked;
                SelectRow(oCheck)
            }
        }
    }
}

function ShowJournal(RefNo) {
    var WinRef = window.open("../Core/JournalViewByRefNo.aspx?Action=View&RefNo=" + RefNo + "&BookCode=DE11", "DisbJournal", "height=400,width=600,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
    WinRef.focus();
    return (false);
}
function SelectRow(oCb) {
    if (oCb.checked)
        oCb.parentElement.parentElement.className = "SelectedRowStyle";
    else
        oCb.parentElement.parentElement.className = "";
}

function TxnTypeChange() {
    var oTxn = getObjectbyClientID("<%=ddlTxnType.ClientID%>");
    if (oTxn) {
        var TxnType = GetValueTxtByClientID("<%=ddlTxnType.ClientID%>");
        var oDiv = getObjectbyClientID("trBank");
        if (TxnType == "1") {
            var oAcc = getObjectbyClientID("<%=ddlAccountNo.ClientID%>");
            oAcc.value = "";
            oDiv.style.display = "none";
        } else {
            oDiv.style.display = "";
        }
    }
}
function CheckTxnType() {
    var TxnType = GetValueTxtByClientID("<%=ddlTxnType.ClientID%>");
    if (TxnType == "2") {
        var oAcc = getObjectbyClientID("<%=ddlAccountNo.ClientID%>");
        if (oAcc.value == "") {
            alert("[BANK ACCOUNT NO.] must be entry...!");
            oAcc.className = "ErrHighLight";
            oAcc.focus();
            return false;
        }

    }
    return true;
}

function ProcessApp() {
    if (Page_ClientValidate("ValApp")) {
        if (!CheckTxnType()) return false;
    }
    return true;
}
</script>

</asp:Content>

