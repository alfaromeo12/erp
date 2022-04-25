<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ETJFPayBatch.aspx.vb" Inherits="ETJF_PayBatch" title="ET JF Payment Batch" EnableEventValidation="FALSE"  MaintainScrollPositionOnPostback="true"%>
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
    <asp:Panel ID="pnlData" runat="server" GroupingText="Search Criteria" Width="99%">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="ACCOUNT.ACCOUNTNO">Account No.</asp:ListItem>
        <asp:ListItem Value="ACCNOX">Account No. (Formated)</asp:ListItem>
        <asp:ListItem Value="ACCOUNT.ACCOUNTNAME">Account Name</asp:ListItem>
        <asp:ListItem Value="CUSTOMER.CUSTNO">Cust No.</asp:ListItem>
        <asp:ListItem Value="CUSTNOX">Cust No. (Formated)</asp:ListItem>
        <asp:ListItem Value="CUSTOMER.IDNUMBER">ID Number</asp:ListItem>
        <asp:ListItem Value="CUSTOMER.REFNO">Reference No.</asp:ListItem>
        <asp:ListItem Value="CUSTOMER.CUSTID">CUST ID</asp:ListItem>
        <asp:ListItem Value="ACCOUNT.ACCID">ACC ID</asp:ListItem>
        <asp:ListItem Value="APPLICATION.APPID">APP ID</asp:ListItem>
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
            <tr>
                <td>
                    ET JF Txn Date</td>
                <td colspan="3">
                    <asp:RadioButton ID="rbETAll" runat="server" GroupName="rbReq" Text="All" /><asp:RadioButton
                        ID="rbETFrom" runat="server" GroupName="rbReq" Text="From" />
                    <asp:TextBox ID="txtETFrom" runat="server" Width="72px"></asp:TextBox><asp:Image
                        ID="imgETFrom" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />
                    To
                    <asp:TextBox ID="txtETTo" runat="server" Width="72px"></asp:TextBox><asp:Image ID="imgETTo" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxCEETFrom" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgETFrom"
                        TargetControlID="txtETFrom">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxCEETTo" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgETTo"
                        TargetControlID="txtETTo">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateFrom" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtETFrom">
                    </ajaxToolkit:MaskedEditExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateTo" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtETTo">
                    </ajaxToolkit:MaskedEditExtender>
                </td>
            </tr>
            <tr>
                <td>
                    JF
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
                    </asp:DropDownList><ajaxToolkit:CascadingDropDown ID="ajaxCDDArea" runat="server" Category="AREA"
                        LoadingText="[Loading Area ...]" PromptText="[DISPLAY ALL]" ServiceMethod="GetDropDownArea"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlAreaSearch">
                    </ajaxToolkit:CascadingDropDown>
                </td>
                <td>
                    Branch</td>
                <td>
                    <asp:DropDownList ID="ddlBranchSearch" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDBranch" runat="server" Category="BRANCH"
                        LoadingText="[Loading Branch...]" PromptText="[DISPLAY ALL]" ServiceMethod="GetDropDownBranchByArea"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlBranchSearch" ParentControlID="ddlAreaSearch">
                    </ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
            <tr>
                <td>
                    JF Group</td>
                <td>
                    <asp:DropDownList ID="ddlJFGroup" runat="server">
                    </asp:DropDownList><ajaxToolkit:CascadingDropDown ID="ajaxCDDJFGroup" runat="server" Category="JFGROUP"
                        LoadingText="[Loading JF Group...]" PromptText="[DISPLAY ALL]" ServiceMethod="GetDropDownJFGroup"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlJFGroup">
                    </ajaxToolkit:CascadingDropDown>
                </td>
                <td>
                    JF/Bank</td>
                <td>
                    <asp:DropDownList ID="ddlJF" runat="server">
                    </asp:DropDownList><ajaxToolkit:CascadingDropDown ID="ajaxCDDJF" runat="server" Category="JF"
                        LoadingText="[Loading JF/Bank...]" ParentControlID="ddlJFGroup" PromptText="[DISPLAY ALL]"
                        ServiceMethod="GetDropDownJFByJFGroup" ServicePath="~\Param\WebService.asmx"
                        TargetControlID="ddlJF">
                    </ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
            <tr>
                <td>
                    Finance Category</td>
                <td>
                    <asp:DropDownList ID="ddlFinanceCategory" runat="server" 
                        DataSourceID="sdsFinanceCategory" DataTextField="FINCATNAME" 
                        DataValueField="FINCATID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsFinanceCategory" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        SelectCommand="SELECT NULL AS FINCATID, NULL AS FINCATCODE, '[DISPLAY ALL]' AS FINCATNAME UNION ALL SELECT FINCATID, FINCATCODE, FINCATCODE + ' - ' + FINCATNAME AS FINCATNAME FROM FINANCECATEGORY WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY FINCATCODE">
                    </asp:SqlDataSource>
                </td>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
    </asp:Panel>
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="ACCIDJF,JFETID" DataSourceID="sdsGrid" Width="99%" Caption="Early Termination List">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkPay" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Acc. No.&lt;br&gt;(Formated)" SortExpression="ACCNO">
                    <ItemTemplate><a href="#" onclick='ViewDetailAcc(<%# eval("LOCID") %>, <%# eval("APPID") %>)'>
                        <asp:Label ID="lblAccNo" runat="server" Font-Bold="True" Text='<%# eval("ACCNO") %>'></asp:Label></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="ACCOUNTNAME" />
                <asp:BoundField DataField="JFETTXNDATE" HeaderText="ET Txn&lt;br&gt;Date" HtmlEncode="False"
                    SortExpression="JFETTXNDATE" DataFormatString="{0:dd/MM/yyyy}" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="JFBOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="JF Booking&lt;br&gt;Date"
                    HtmlEncode="False" SortExpression="JFBOOKINGDATE" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="BRANCH" HeaderText="Branch" ReadOnly="True" SortExpression="BRANCH" />
                <asp:BoundField DataField="JFNAME" HeaderText="JF&lt;br&gt;(Bank)" HtmlEncode="False"
                    SortExpression="JFNAME" />
                <asp:BoundField DataField="JFOSPRINCIPAL" HeaderText="OS&lt;br&gt;Principal" SortExpression="JFOSPRINCIPAL" DataFormatString="{0:N}" HtmlEncode="False" >
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="JFETINTEREST" HeaderText="ET&lt;br&gt;Interest" SortExpression="JFETINTEREST" DataFormatString="{0:N}" HtmlEncode="False" >
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="JFETPENALTY" HeaderText="ET&lt;br&gt;Penalty" SortExpression="JFETPENALTY" DataFormatString="{0:N}" HtmlEncode="False" >
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="JFETADMIN" HeaderText="ET&lt;br&gt;Admin" SortExpression="JFETADMIN" DataFormatString="{0:N}" HtmlEncode="False" >
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="JFETSTATUSNAME" HeaderText="ET&lt;br&gt;Status" HtmlEncode="False"
                    SortExpression="JFETSTATUSNAME" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
        <br />
        <br />
        <br />
        <br />
        <br />
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT TOP (500) ACCOUNT.APPID, ACCOUNT.ACCOUNTNAME, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCH, ACCOUNT.BOOKINGDATE, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCNO, '(' + JF.JFCODE + ') ' + JF.JFNAME AS JFNAME, ACCOUNT.LOCID, ACCOUNT.ACCID, ETJF.ACCIDJF, ETJF.JFETID, ETJF.JFETTXNDATE, '(' + CAST(ETJF.JFETSTATUS AS VARCHAR(10)) + ') ' + dbo.f_getParamGlobalName('JFETSTATUS', ETJF.JFETSTATUS) AS JFETSTATUSNAME, ETJF.JFETPENALTY, ETJF.JFETADMIN, ETJF.JFOSPRINCIPAL, ETJF.JFETINTEREST, ACCOUNTJF.JFBOOKINGDATE, ETJF.JFETSTATUS, CAST(ETJF.ACCIDJF AS VARCHAR(20)) + '-' + CAST(ETJF.JFETID AS VARCHAR(50)) AS JOURNALREFNOET, ETJF.PAYIDJF AS JOURNALREFNOPAY, CASE WHEN JFETSTATUS IN (1 , 2) THEN 'visible' ELSE 'hidden' END AS ShowJournalET, CASE WHEN JFETSTATUS = 2 THEN 'visible' ELSE 'hidden' END AS ShowJournalPAY FROM APPLICATION WITH (NOLOCK) INNER JOIN ACCOUNT WITH (NOLOCK) ON APPLICATION.LOCID = ACCOUNT.LOCID AND APPLICATION.APPID = ACCOUNT.APPID INNER JOIN CUSTOMER WITH (NOLOCK) ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID INNER JOIN BRANCH WITH (NOLOCK) ON ACCOUNT.BRANCHID = BRANCH.BRANCHID INNER JOIN ACCOUNTJF WITH (NOLOCK) ON ACCOUNT.LOCID = ACCOUNTJF.LOCID AND ACCOUNT.ACCID = ACCOUNTJF.ACCID INNER JOIN ETJF WITH (NOLOCK) ON ACCOUNTJF.ACCIDJF = ETJF.ACCIDJF INNER JOIN JF WITH (NOLOCK) ON ACCOUNTJF.JFID = JF.JFID INNER JOIN JFGROUP WITH (NOLOCK) ON JF.JFGROUPID = JFGROUP.JFGROUPID WHERE (ACCOUNT.ACCSTATUS &lt;&gt; 0)"></asp:SqlDataSource>
	<asp:Panel ID="pnlPayment" runat="server" Visible="False" Width="100%" 
        GroupingText="Payment Process" Font-Bold="True" CssClass="RowStyle">
		<table cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td class="ShowDetail" colspan="2">
					TRANSACTION</td>
			</tr>
			<tr id="trBank">
				<td class="AlternatingRowStyle" colspan="2">
					<asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" 
                        Font-Bold="True" Style="text-align: center" Visible="False" Width="100%"></asp:Label>
                    <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" 
                        TargetControlID="lblMessage">
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
			<tr ID="trBank">
                <td class="AlternatingRowStyle">
                    Bank Account No.</td>
                <td class="AlternatingRowStyle">
                    <asp:DropDownList ID="ddlAccountNo" runat="server" CssClass="required" 
                        DataSourceID="sdsAccountNo" DataTextField="ACCOUNTNO" 
                        DataValueField="ACCOUNTID" ValidationGroup="ValPay">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="reqBankAccNo" runat="server" 
                        ControlToValidate="ddlAccountNo" Display="None" 
                        ErrorMessage="BANK ACCOUNT NO. must be entry...!" SetFocusOnError="True" 
                        ValidationGroup="ValPay"></asp:RequiredFieldValidator>
                    <asp:SqlDataSource ID="sdsAccountNo" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        SelectCommand="SELECT NULL AS ACCOUNTID, NULL AS BANKNAME, '[ACCOUNT NUMBER]' AS ACCOUNTNO UNION ALL SELECT BANKACCOUNT.ACCOUNTID, BANK.BANKNAME, BANK.BANKNAME + '-' + BANKACCOUNT.ACCOUNTNO AS ACCOUNTNO FROM BANKACCOUNT INNER JOIN BANK ON BANKACCOUNT.BANKID = BANK.BANKID WHERE (BANKACCOUNT.DELETESTS = 0) ORDER BY BANKNAME, ACCOUNTNO">
                    </asp:SqlDataSource>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEBankAccNo" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqBankAccNo">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
			<tr>
				<td colspan="2" class="AlternatingRowStyle">
					<hr />
				</td>
			</tr>
			<tr>
				<td class="HeaderStyle" colspan="2">
		<asp:Button ID="btnProcess" runat="server"  Style="background-position: right;
					background-image: url(../Images/Save.gif); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Process" Width="88px" ValidationGroup="ValPay" /><asp:Button ID="btnRejectPay" runat="server" Style="background-position: right;
					background-image: url(../Images/stop.png); cursor: pointer; background-repeat: no-repeat;
					text-align: left; " Text="Reject" Width="88px" ValidationGroup="ViewAcc" CausesValidation="False" /></td>
			</tr>
		</table>
	</asp:Panel>
	<ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEPayment" runat="server" TargetControlID="pnlPayment"
		VerticalSide="Bottom">
	</ajaxToolkit:AlwaysVisibleControlExtender>

<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
function getObjectbyClientID(ClientID){
    var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
    return (oObject);
}
function GetValueTxtByClientID(ClientID){
    var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
    if (oText)
        return(oText.value);
}
function ViewDetailAcc(LOCID, APPID){
   var winref=window.open("../Account/AccInqFrame.aspx?Action=AccInq&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
   winref.focus()
}


</script>

</asp:Content>

