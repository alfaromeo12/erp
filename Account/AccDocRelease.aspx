 <%@ Page Language="VB" MasterPageFile="~/MXPageNoBusy.master" AutoEventWireup="false" CodeFile="AccDocRelease.aspx.vb" Inherits="Txn_AccRelease" title="Collateral Document Release Process" EnableEventValidation="FALSE"  MaintainScrollPositionOnPostback="true"%>
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
            <tr>
                <td>
                    Close Txn Date</td>
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
                    AutoGenerateColumns="False" Caption="Account List for Release" 
                    DataKeyNames="LOCID,ACCID" DataSourceID="sdsGrid" RowHeaderColumn="ACCID" 
                    Width="140%">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="cbRelease" runat="server" 
                                    Visible='<%# Eval("RECEIVECHECK") %>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="LOCID" HeaderText="Loc&lt;br&gt;ID" 
                            HtmlEncode="False" SortExpression="LOCID">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ACCID" HeaderText="Acc&lt;br&gt;ID" 
                            HtmlEncode="False" SortExpression="ACCID" />
                        <asp:TemplateField HeaderText="Acc. No.&lt;br&gt;(Formated)" 
                            SortExpression="ACCNO">
                            <ItemTemplate>
                                <a href="#" onclick='ViewDetailAcc(<%# eval("LOCID") %>, <%# eval("APPID") %>)'>
                                <asp:Label ID="lblAccNo" runat="server" Font-Bold="True" 
                                    Text='<%# eval("ACCNO") %>'></asp:Label>
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>
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
                        <asp:BoundField DataField="CLOSETXNDATE" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Close&lt;br&gt;Txn Date" HtmlEncode="False" 
                            SortExpression="CLOSETXNDATE">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
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
                    SelectCommand="SELECT TOP (500) ACCOUNT.ACCOUNTNAME, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCH, CUSTOMER.CUSTID, ACCOUNT.BOOKINGDATE, ACCOUNT.REFNO, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCNO, '(' + CAST(ACCOUNT.ACCSTATUS AS varchar(20)) + ') ' + dbo.f_getParamGlobalName('ACCSTATUS ', ACCOUNT.ACCSTATUS) AS ACCSTATUSNAME, '(' + CAST(COLLATERAL.BPKBSTATUS AS VARCHAR(20)) + ') ' + dbo.f_getParamGlobalName('BPKBSTATUS', COLLATERAL.BPKBSTATUS) AS BPKBSTATUSNAME, CAST(CASE WHEN BPKBSTATUS = 2 THEN CASE WHEN ACCSTATUS IN (2 , 3 , 5) THEN 1 ELSE 0 END ELSE 0 END AS BIT) AS RECEIVECHECK, COLLATERAL.BPKBNO, COLLATERAL.BPKBDATE, COLLATERAL.BPKBNAME, ACCOUNT.APPID, ACCOUNT.CLOSETXNDATE, ACCOUNT.LOCID, ACCOUNT.ACCID, COLLATERAL.OBJID FROM ACCOUNT WITH (NOLOCK) INNER JOIN CUSTOMER WITH (NOLOCK) ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID INNER JOIN BRANCH WITH (NOLOCK) ON ACCOUNT.BRANCHID = BRANCH.BRANCHID INNER JOIN COLLATERAL WITH (NOLOCK) ON ACCOUNT.LOCID = COLLATERAL.LOCID AND ACCOUNT.ACCID = COLLATERAL.ACCID WHERE (ACCOUNT.ACCSTATUS &lt;&gt; 0) AND (ACCOUNT.RELEASESTS = 0)">
                </asp:SqlDataSource>
            </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />

    <br />
    <asp:Panel ID="pnlBorrow" runat="server" Width="100%" CssClass="FooterStyle">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                    <hr />
                </td>
            </tr>
            <tr>
                <td class="AlternatingRowStyle">
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
                <td class="AlternatingRowStyle">
                    Release Date&nbsp;
                    <asp:TextBox ID="txtReleaseDate" runat="server" CssClass="required" 
                        ValidationGroup="ValSave" Width="72px"></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="ajaxCERelease" runat="server" Animated="False" 
                        Format="dd/MM/yyyy" PopupButtonID="imgRelease" PopupPosition="TopLeft" 
                        TargetControlID="txtReleaseDate">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEERealease" runat="server" Mask="99/99/9999" 
                        MaskType="Date" TargetControlID="txtReleaseDate">
                    </ajaxToolkit:MaskedEditExtender>
                    <asp:Image ID="imgRelease" runat="server" ImageUrl="~/images/grid.gif" 
                        Style="cursor: pointer" ToolTip="Calendar" />
                    <asp:RequiredFieldValidator ID="reqReleaseDate" runat="server" 
                        ControlToValidate="txtReleaseDate" Display="None" 
                        ErrorMessage="RELEASE DATE must be entry...!" SetFocusOnError="True" 
                        ValidationGroup="ValSave"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxAVCEReleaseDate" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqReleaseDate">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="ShowDetail">
                    <asp:Button ID="btnSave" runat="server" Style="background-position: right; background-image: url(../Images/Save.gif);
                        cursor: pointer; background-repeat: no-repeat;  text-align: left"
                        Text="Save" ValidationGroup="ValSave" Width="64px" /></td>
            </tr>
        </table>
    </asp:Panel>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEBorrow" runat="server" TargetControlID="pnlBorrow"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
        FormatTable("<%=gvData.ClientID%>");
    });

function getObjectbyClientID(ClientID){
    var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
    return (oObject);
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

