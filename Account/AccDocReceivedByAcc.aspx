<%@ Page Language="VB" MasterPageFile="~/MXPageNoBusy.master" AutoEventWireup="false" CodeFile="AccDocReceivedByAcc.aspx.vb" Inherits="Txn_ReceivedAcc" title="Collateral Received by Account" EnableEventValidation="FALSE"  MaintainScrollPositionOnPostback="true"%>
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
    <asp:HiddenField ID="hidBranch" runat="server" />
    <asp:HiddenField ID="hidAreaUser" runat="server" />
    <asp:HiddenField ID="hidBranchUser" runat="server" />
    <asp:HiddenField ID="txtAppDate" runat="server" />
    <asp:HiddenField ID="hidIsUserBranch" runat="server" />
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
        <asp:ListItem Value="ACCOUNT.ACCID">ACC ID</asp:ListItem>
        <asp:ListItem Value="APPLICATION.APPID">APP ID</asp:ListItem>
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
                    Request Date</td>
                <td colspan="3">
                    <asp:RadioButton ID="rbReqAll" runat="server" GroupName="rbReq" Text="All" /><asp:RadioButton
                        ID="rbReqDate" runat="server" GroupName="rbReq" Text="From" />
                    <asp:TextBox ID="txtRequestForm" runat="server" Width="72px"></asp:TextBox><asp:Image
                        ID="imgReqFrom" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />
                    To
                    <asp:TextBox ID="txtRequestTo" runat="server" Width="72px"></asp:TextBox><asp:Image ID="imgReqTo" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxReqFrom" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgReqFrom"
                        TargetControlID="txtRequestForm">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxReqTo" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgReqTo"
                        TargetControlID="txtRequestTo">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateFrom" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtRequestForm">
                    </ajaxToolkit:MaskedEditExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateTo" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtRequestTo">
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
            <tr>
                <td>
                    Account Status</td>
                <td>
                    <asp:DropDownList ID="ddlAccStatus" runat="server" DataSourceID="sdsAccStatus" DataTextField="NAME"
                        DataValueField="CODE">
                    </asp:DropDownList><asp:SqlDataSource ID="sdsAccStatus" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        
                        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, NAME FROM (SELECT CAST(CODE AS INT) AS CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'ACCSTATUS') AND (CODE &lt;&gt; '0')) AS derivedtbl_1 ORDER BY CODE">
                    </asp:SqlDataSource>
                </td>
                <td>
                    Collateral Status</td>
                <td>
                    <asp:DropDownList ID="ddlCollStatus" runat="server" DataSourceID="sdsCollStatus"
                        DataTextField="NAME" DataValueField="CODE">
                    </asp:DropDownList><asp:SqlDataSource ID="sdsCollStatus" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        
                        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, NAME FROM (SELECT CAST(CODE AS INT) AS CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'BPKBSTATUS')) AS derivedtbl_1 ORDER BY CODE">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>
                    Finance Category</td>
                <td>
                    <asp:DropDownList ID="ddlFinanceCategory" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCCDFincat" runat="server" 
                        BehaviorID="BehavFinCat" Category="FINCAT" 
                        LoadingText="[Loading Finance Category ...]" PromptText="[DISPLAY ALL]" 
                        ServiceMethod="GetDropDownFinCatbyAppUserBranch" 
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlFinanceCategory">
                    </ajaxToolkit:CascadingDropDown>
                </td>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
    </asp:Panel>
        <asp:UpdatePanel ID="UPGrid" runat="server">
            <ContentTemplate>
                <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" 
                    AutoGenerateColumns="False" Caption="Collateral - Account List" 
                    DataKeyNames="LOCID,OBJID" DataSourceID="sdsGrid" RowHeaderColumn="OBJID" 
                    Width="140%">
                    <Columns>
                        <asp:TemplateField HeaderText="ACT">
                            <ItemTemplate>
                                <asp:CheckBox ID="cbBorrow" runat="server" 
                                    Visible='<%# Eval("RECEIVECHECK") %>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="LOCID" HeaderText="Loc&lt;br&gt;ID" 
                            HtmlEncode="False" SortExpression="LOCID">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="OBJID" HeaderText="Obj&lt;br&gt;ID" 
                            HtmlEncode="False" SortExpression="OBJID">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Acc. No.&lt;br&gt;(Formated)" 
                            SortExpression="ACCNO">
                            <ItemTemplate>
                                <a href="#" onclick='ViewDetailAcc(<%# eval("LOCID") %>, <%# eval("APPID") %>)'>
                                <asp:Label ID="lblAccNo" runat="server" Font-Bold="True" 
                                    Text='<%# eval("ACCNO") %>'></asp:Label>
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="REQUESTDATE" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Request&lt;br&gt;Date" HtmlEncode="False" 
                            SortExpression="REQUESTDATE">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Booking&lt;br&gt;Date" HtmlEncode="False" 
                            SortExpression="BOOKINGDATE">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" 
                            HtmlEncode="False" SortExpression="ACCOUNTNAME" />
                        <asp:BoundField DataField="BPKBSTATUSNAME" 
                            HeaderText="Collateral&lt;br&gt;Status" HtmlEncode="False" 
                            SortExpression="BPKBSTATUSNAME" />
                        <asp:BoundField DataField="ACCSTATUSNAME" HeaderText="Acc.&lt;br&gt;Status" 
                            HtmlEncode="False" SortExpression="ACCSTATUSNAME" />
                        <asp:BoundField DataField="BPKBNO" HeaderText="BPKB&lt;BR&gt;No." 
                            HtmlEncode="False" SortExpression="BPKBNO" />
                        <asp:BoundField DataField="BPKBDATE" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="BPKB&lt;br&gt;Date" HtmlEncode="False" SortExpression="BPKBDATE">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BPKBNAME" HeaderText="BPKB&lt;br&gt;Name" 
                            HtmlEncode="False" SortExpression="BPKBNAME" />
                        <asp:BoundField DataField="BRANCH" HeaderText="Branch" ReadOnly="True" 
                            SortExpression="BRANCH" />
                    </Columns>
                    <EmptyDataTemplate>
                        <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsGrid" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    SelectCommand="SELECT TOP (500) APPLICATION.APPID, APPLICATION.REQUESTDATE, APPLICATION.ROWLOCK, ACCOUNT.ACCOUNTNAME, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCH, CUSTOMER.CUSTID, ACCOUNT.ACCID, ACCOUNT.BOOKINGDATE, ACCOUNT.REFNO, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCNO, '(' + CAST(ACCOUNT.ACCSTATUS AS varchar(20)) + ') ' + dbo.f_getParamGlobalName('ACCSTATUS ', ACCOUNT.ACCSTATUS) AS ACCSTATUSNAME, '(' + CAST(COLLATERAL.BPKBSTATUS AS VARCHAR(20)) + ') ' + dbo.f_getParamGlobalName('BPKBSTATUS', COLLATERAL.BPKBSTATUS) AS BPKBSTATUSNAME, CAST(CASE WHEN BPKBSTATUS IN (1 , 9) THEN CASE WHEN ACCSTATUS NOT IN (0 , 9) THEN 1 ELSE 0 END ELSE 0 END AS BIT) AS RECEIVECHECK, COLLATERAL.LOCID, COLLATERAL.OBJID, COLLATERAL.BPKBNO, COLLATERAL.BPKBDATE, COLLATERAL.BPKBNAME FROM APPLICATION WITH (NOLOCK) INNER JOIN ACCOUNT WITH (NOLOCK) ON APPLICATION.LOCID = ACCOUNT.LOCID AND APPLICATION.APPID = ACCOUNT.APPID INNER JOIN CUSTOMER WITH (NOLOCK) ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID INNER JOIN BRANCH WITH (NOLOCK) ON ACCOUNT.BRANCHID = BRANCH.BRANCHID INNER JOIN COLLATERAL WITH (NOLOCK) ON ACCOUNT.LOCID = COLLATERAL.LOCID AND ACCOUNT.ACCID = COLLATERAL.ACCID WHERE (ACCOUNT.ACCSTATUS &lt;&gt; 0) AND (ACCOUNT.RELEASESTS = 0)">
                </asp:SqlDataSource>
            </ContentTemplate>
    </asp:UpdatePanel>
        <br />
        <br />
        <asp:Panel ID="pnlInit" runat="server" 
        GroupingText="Receive Collateral Document by CheckList" Width="100%" 
        Font-Bold="True" CssClass="RowStyle">
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
                        <ajaxToolkit:CascadingDropDown ID="ajaxCCDAreaStore" runat="server" 
                            Category="AREA" LoadingText="[Loading Area...]" PromptText="[CHOOSE AREA]" 
                            ServiceMethod="GetDropDownArea" ServicePath="~\Param\WebService.asmx" 
                            TargetControlID="ddlAreaSafe" BehaviorID="BehavAreaStore">
                        </ajaxToolkit:CascadingDropDown>
                        <asp:RequiredFieldValidator ID="reqAreaSafe" runat="server" 
                            ControlToValidate="ddlAreaSafe" Display="None" 
                            ErrorMessage="STORE AREA must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="ValSave"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqAreaSafe_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAreaSafe">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td class="FooterStyle">
                        Branch</td>
                    <td class="FooterStyle">
                        <asp:DropDownList ID="ddlBranchSafe" runat="server" CssClass="required" 
                            ValidationGroup="ValSave">
                        </asp:DropDownList>
                        <ajaxToolkit:CascadingDropDown ID="ajaxCCDBranchStore" runat="server" 
                            Category="BRANCH" LoadingText="[Loading Branch...]" PromptText="[CHOOSE BRANCH]" 
                            ServiceMethod="GetDropDownBranchByArea" ServicePath="~\Param\WebService.asmx" 
                            TargetControlID="ddlBranchSafe" ParentControlID="ddlAreaSafe" BehaviorID="BehavBranchStore"></ajaxToolkit:CascadingDropDown>

                        <asp:RequiredFieldValidator ID="reqBranchSafe" runat="server" 
                            ControlToValidate="ddlBranchSafe" Display="None" 
                            ErrorMessage="STORE BRANCH must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="ValSave"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqBranchSafe_ValidatorCalloutExtender" 
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
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
        FormatTable("<%=gvData.ClientID%>");
    });

    function pageLoad(sender, args) {
        if($find("BehavAreaStore"))
            $find("BehavAreaStore").add_populated(onPopulatedAreaStore);
        if($find("BehavBranchStore"))
            $find("BehavBranchStore").add_populated(onPopulatedBranchStore);
    }
    function onPopulatedAreaStore() {
        if (GetValueTxtByClientID("<%=hidBranch.ClientID%>")=="1") {
            $get("<%=ddlAreaSafe.ClientID%>").disabled = true;
        }
    }

    function onPopulatedBranchStore() {
        if (GetValueTxtByClientID("<%=hidBranch.ClientID%>") == "1") {
            $get("<%=ddlBranchSafe.ClientID%>").disabled = true;
        }
    }
function getObjectbyClientID(ClientID){
    var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
    return(oObject)
}
function GetValueTxtByClientID(ClientID){
    var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
    if (oText)
        return(oText.value);
}

function EditApp(LOCID, APPID){
    window.location="AccInqFrame.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&APPID=" + APPID
}
function ViewDetailAcc(LOCID, APPID){
    var winref = window.open("../Account/AccInqFrame.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
    winref.focus();
}
function SelectRow(oCb) {
    if (oCb.checked)
        oCb.parentElement.parentElement.className = "SelectedRowStyle";
    else
        oCb.parentElement.parentElement.className = "";
}

</script>

</asp:Content>

