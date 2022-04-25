<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ToolsUpdFee.aspx.vb" Inherits="Tools_ToolsUpdFee" EnableEventValidation="false" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>

<%@ Register src="../UserControl/DataAccountFromParamAccID.ascx" tagname="DataAccountFromParamAccID" tagprefix="uc1" %>
<%@ Register src="../UserControl/CollateralDataFromAccID.ascx" tagname="CollateralDataFromAccID" tagprefix="uc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
  <asp:MultiView ID="MultiView_Utama" runat="server"> 
   <asp:View ID="View_View" runat="server"> 
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Search Criteria...)</asp:Label>
        </div>
        <input id="btnX" style="background-position: left top; width: 24px; cursor: hand;
            background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Search Criteria...)" Enabled="True"
        ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Search Criteria...)"
        ImageControlID="imgButtonShow" TargetControlID="pnlData" TextLabelID="lblShow"></ajaxToolkit:CollapsiblePanelExtender>
    <asp:HiddenField ID="txtUID" runat="server" />
    <asp:HiddenField ID="txtAction" runat="server" />
    <asp:HiddenField ID="hidIsUserBranch" runat="server" />
       <asp:HiddenField ID="hidLocid" runat="server" />
       <asp:HiddenField ID="hidAccID" runat="server" />
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
        <asp:ListItem Value="ACCOUNT.REFNO">Reference No.</asp:ListItem>
        <asp:ListItem Value="CUSTOMER.CUSTID">CUST ID</asp:ListItem>
        <asp:ListItem Value="ACCOUNTJF.ACCIDJF">ACC ID JF</asp:ListItem>
        <asp:ListItem Value="ACCOUNT.ACCID">ACC ID</asp:ListItem>
        <asp:ListItem Value="APPLICATION.APPID">APP ID</asp:ListItem>
    </asp:DropDownList></td>
                <td colspan="3">
                    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset"
        Text="Search" CssClass="Search" />
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%"></ajaxToolkit:TextBoxWatermarkExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Request Date</td>
                <td colspan="3">
                    <asp:RadioButton ID="rbReqAll" runat="server" GroupName="rbReq" Text="All" /><asp:RadioButton
                        ID="rbReqDate" runat="server" GroupName="rbReq" Text="From" />
                    <asp:TextBox ID="txtRequestForm" runat="server" Width="72px"></asp:TextBox><asp:Image
                        ID="imgReqFrom" runat="server" ImageUrl="~/images/grid.gif" style="cursor: hand" ToolTip="Calendar" />
                    To
                    <asp:TextBox ID="txtRequestTo" runat="server" Width="72px"></asp:TextBox><asp:Image ID="imgReqTo" runat="server" ImageUrl="~/images/grid.gif" style="cursor: hand" ToolTip="Calendar" />
                    <ajaxToolkit:CalendarExtender ID="ajaxReqFrom" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgReqFrom"
                        TargetControlID="txtRequestForm"></ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxReqTo" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgReqTo"
                        TargetControlID="txtRequestTo"></ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateFrom" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtRequestForm"></ajaxToolkit:MaskedEditExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateTo" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtRequestTo"></ajaxToolkit:MaskedEditExtender>
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
                        ID="imgBookFrom" runat="server" ImageUrl="~/images/grid.gif" style="cursor: hand" ToolTip="Calendar" />&nbsp;
                    To
                    <asp:TextBox ID="txtBookTo" runat="server" Width="72px"></asp:TextBox><asp:Image ID="imgBookTo" runat="server" ImageUrl="~/images/grid.gif" style="cursor: hand" ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxCEBookFrom" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgBookFrom"
                        TargetControlID="txtBookFrom"></ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxCEBookTo" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgBookTo"
                        TargetControlID="txtBookTo"></ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEBookFrom" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtBookFrom"></ajaxToolkit:MaskedEditExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEBookTo" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtBookTo"></ajaxToolkit:MaskedEditExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Area</td>
                <td>
                    <asp:DropDownList ID="ddlAreaSearch" runat="server">
                    </asp:DropDownList><ajaxToolkit:CascadingDropDown ID="ajaxCDDArea" runat="server" Category="AREA"
                        LoadingText="[Loading Area ...]" PromptText="[DISPLAY ALL]" ServiceMethod="GetDropDownArea"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlAreaSearch" BehaviorID="BehavArea"></ajaxToolkit:CascadingDropDown>
                </td>
                <td>
                    Branch</td>
                <td>
                    <asp:DropDownList ID="ddlBranchSearch" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDBranch" runat="server" Category="BRANCH"
                        LoadingText="[Loading Branch...]" PromptText="[DISPLAY ALL]" ServiceMethod="GetDropDownBranchByArea"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlBranchSearch" ParentControlID="ddlAreaSearch" BehaviorID="BehavBranch"></ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
            <tr>
                <td>
                    Finance Category</td>
                <td colspan="3">
                    <asp:DropDownList ID="ddlFinanceCategory" runat="server" 
                        DataSourceID="sdsFinanceCategory" DataTextField="FINCATNAME" 
                        DataValueField="FINCATID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsFinanceCategory" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        SelectCommand="SELECT NULL AS FINCATID, NULL AS FINCATCODE, '[DISPLAY ALL]' AS FINCATNAME UNION ALL SELECT FINCATID, FINCATCODE, FINCATCODE + ' - ' + FINCATNAME AS FINCATNAME FROM FINANCECATEGORY WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY FINCATCODE">
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </asp:Panel>
     <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="LOCID,APPID,ACCID" DataSourceID="sdsGrid" Width="99%" Caption="Account List" RowHeaderColumn="ACCID">
            <Columns>
         
                 <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/edit.gif" 
                        ShowSelectButton="True">
                    <HeaderStyle CssClass="FooterStyle" />
                    <ItemStyle HorizontalAlign="Center" Width="20px" /></asp:CommandField>
                <asp:BoundField DataField="LOCID" HeaderText="Loc&lt;br&gt;ID" HtmlEncode="False"
                    SortExpression="LOCID" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="ACCID" HeaderText="Acc&lt;br&gt;ID" HtmlEncode="False"
                    SortExpression="ACCID" />
                <asp:BoundField DataField="ACCNO" HeaderText="Acc. No.&lt;br&gt;(Formated)" SortExpression="ACCNO" HtmlEncode="False" />
                <asp:BoundField DataField="REQUESTDATE" HeaderText="Request&lt;br&gt;Date" HtmlEncode="False"
                    SortExpression="REQUESTDATE" DataFormatString="{0:dd/MM/yyyy}" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="BOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Booking&lt;br&gt;Date"
                    HtmlEncode="False" SortExpression="BOOKINGDATE" />
                <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="ACCOUNTNAME" />
                <asp:BoundField DataField="BRANCH" HeaderText="Branch" ReadOnly="True" SortExpression="BRANCH" />
                <asp:BoundField DataField="CUSTNO" HeaderText="Cust. No.&lt;BR&gt;(Formated)" SortExpression="CUSTNO" HtmlEncode="False" />
                <asp:BoundField DataField="PRINCIPALTOTAL" HeaderText="Principal" HtmlEncode="False"
                    SortExpression="PRINCIPALTOTAL" DataFormatString="{0:n}" >
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
           
           
           SelectCommand="SELECT TOP (500) APPLICATION.LOCID, APPLICATION.APPID, APPLICATION.REQUESTDATE, APPLICATION.ROWLOCK, ACCOUNT.ACCOUNTNAME, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCH, CUSTOMER.CUSTID, ACCOUNT.ACCID, CUSTOMER.IDNUMBER, ACCOUNT.BOOKINGDATE, ACCOUNT.REFNO, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCNO, dbo.f_FormatCustNo(BRANCH.BRANCHCODE, CUSTOMER.CUSTNO) AS CUSTNO, ACCOUNT.ACCSTATUS, ACCOUNT.PRINCIPALTOTAL, CUSTOMER.LOCIDCUST FROM APPLICATION WITH (NOLOCK) INNER JOIN ACCOUNT WITH (NOLOCK) ON APPLICATION.LOCID = ACCOUNT.LOCID AND APPLICATION.APPID = ACCOUNT.APPID INNER JOIN CUSTOMER WITH (NOLOCK) ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID INNER JOIN AREA WITH (NOLOCK) INNER JOIN BRANCH WITH (NOLOCK) ON AREA.AREAID = BRANCH.AREAID ON ACCOUNT.BRANCHID = BRANCH.BRANCHID WHERE (ACCOUNT.ACCSTATUS = 1)"></asp:SqlDataSource>

   </asp:View>
     
    
   <asp:View ID="View_Form" runat="server"> 
   <asp:Panel ID="pnlAccShow" runat="server" CssClass="ShowDetail" Width="99%">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgAccData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblAccData" runat="server" CssClass="required">(Show Account Data...)</asp:Label>
		</div>
		<input id="Button1" noenter="" style="background-position: left top; width: 24px;
			cursor: hand; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <asp:Panel ID="pnlAccData" runat="server" CssClass="FooterStyle" Width="100%">
	    <uc1:DataAccountFromParamAccID ID="ctlDataAccountFromParamAccID" 
            runat="server" />
	</asp:Panel>
	<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEAccData" runat="server" CollapseControlID="pnlAccShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Account Data...)" Enabled="True"
		ExpandControlID="pnlAccShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Account Data...)"
		ImageControlID="imgAccData" TargetControlID="pnlAccData" TextLabelID="lblAccData"></ajaxToolkit:CollapsiblePanelExtender>

        <asp:Panel ID="pnlCollateralShow" runat="server" CssClass="ShowDetail" 
        Width="99%">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgCollateral" runat="server" AlternateText="(Show Details...)" 
                ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblCollateral" runat="server" CssClass="required">(Show Collateral Data...)</asp:Label>
		</div>
		<input id="Button6" noenter="" style="background-position: left top; width: 24px;
			cursor: hand; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
	<asp:Panel ID="pnlCollateral" runat="server"  
		Font-Bold="True" Width="100%">
        <uc2:CollateralDataFromAccID ID="ctlCollateralDataFromAccID" runat="server" />
	</asp:Panel>
	<ajaxToolkit:CollapsiblePanelExtender ID="pnlCollateral_CollapsiblePanelExtender" 
        runat="server" CollapseControlID="pnlCollateralShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Collateral Data...)" Enabled="True"
		ExpandControlID="pnlCollateralShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Collateral Data...)"
		ImageControlID="imgCollateral" TargetControlID="pnlCollateral" 
        TextLabelID="lblLoanData"></ajaxToolkit:CollapsiblePanelExtender>
        <asp:Panel ID="pnlAccountFeeCor" runat="server">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="2"  class="HeaderStyle" style="text-align:center">
                        Account Fee Correction</td>
                </tr>
                <tr>
                    <td>
                        Original Fee</td>
                    <td>
                        <asp:TextBox ID="txtOriFee" runat="server" CssClass="disabled" ReadOnly="True" style="text-align:right"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        Correction</td>
                    <td>
                        <asp:TextBox ID="txtCorrection" runat="server" CssClass="required" 
                            AutoComplete="off" style="text-align:right" CausesValidation="True" 
                            EnableViewState="False"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqCorrection" runat="server" 
                            ControlToValidate="txtCorrection" Display="None"
                            ErrorMessage="Correction must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqCorrection">
                        </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                </tr>
                <tr>
                    <td>
                        New Fee</td>
                    <td>
                        <asp:TextBox ID="txtNewFee" runat="server" CssClass="disabled" ReadOnly="True" style="text-align:right"></asp:TextBox></td>
                </tr>
                <tr>
                    
                    <td colspan = "2">
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
                    <td colspan="2">
                        <asp:Button ID="btnUpdate" runat="server" CausesValidation="true" 
                            CommandName="Update" Style="background-image: url(../images/save.gif); cursor: hand; background-repeat: no-repeat; text-align: center;" 
                            Text="Update" ToolTip="Update Admin Fee" Width="72px" Height="22px" />
                        <asp:Button ID="btnBack" runat="server" CausesValidation="False" 
                            CommandName="Cancel" Style="background-image: url(../images/back.png); cursor: hand; background-repeat: no-repeat; text-align: center;" 
                            Text="Back" ToolTip="Back to List" Width="72px" Height="22px" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
   </asp:View>
 </asp:MultiView>
     <script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");

    window.onload = function () {
        TabToEnter();
        Load();
    }
    function Load() {
        var Action = GetValueTxtByClientID('<%=txtAction.ClientID%>');
        if (Action == "LOAD") {
            LoadBranch();
        }
    }
    function LoadBranch() {
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
    }
    function SetValueTxtByClientID(ClientID, sValue) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            oText.value = sValue;
    }

    function getObjectbyClientID(ClientID) {
        var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        return (oObject)
    }
    function GetValueTxtByClientID(ClientID) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            return (oText.value);
    }

    function Edit(LOCID, ACCID) {
        SetValueTxtByClientID("<%=txtAction.ClientID%>", "UPDATE");
        document.forms[0].action = "ToolsUpdFee.aspx?LOCID=" + LOCID + "&ACCID=" + ACCID;
        document.forms[0].submit();
    }
    function toNumeric(theValue) {
        var ValX = parseFloat(FormatNumberClear(theValue));
        if (isNaN(ValX))
            ValX = 0;
        return (ValX);
    }
    function CalcTotal() {
        var Correction = toNumeric(GetValueTxtByClientID("<%=strCorrection%>"));
        var OriFee = toNumeric(GetValueTxtByClientID("<%=strOriFee%>"));
        var NewFee = getObjectbyClientID("<%=strNewFee%>");
        NewFee.value = FormatNumber(Correction + OriFee, 'True', 2);

    }
    function ViewDetailAcc(LOCID, APPID) {
        var winref = window.open("../Account/AccInqFrame.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
        winref.focus();
    }
    </script>
    </asp:Content>