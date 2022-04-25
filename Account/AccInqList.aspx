<%@ Page Language="VB" MasterPageFile="~/MXPageNoBusy.master" AutoEventWireup="false" CodeFile="AccInqList.aspx.vb" Inherits="Txn_AccInq" title="Account Inquiry List" EnableEventValidation="false" MaintainScrollPositionOnPostback="true"%>
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
        <asp:ListItem Value="COLLATERAL.BPKBNO">Object/BPKB No</asp:ListItem>
        <asp:ListItem Value="COLLATERAL.POLICENO">Police No.</asp:ListItem>
        <asp:ListItem Value="COLLATERAL.ENGINENO">Engine No.</asp:ListItem>
        <asp:ListItem Value="COLLATERAL.CHASSISNO">Chassis No.</asp:ListItem>
    </asp:DropDownList></td>
                <td colspan="3">
                    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
                    <asp:Button ID="btnFunctionSearch" runat="server" Text="Search" CssClass="Search" />
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
                        ID="imgReqFrom" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />&nbsp;
                    To
                    <asp:TextBox ID="txtRequestTo" runat="server" Width="72px"></asp:TextBox><asp:Image ID="imgReqTo" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />
                    <ajaxToolkit:CalendarExtender ID="ajaxReqFrom" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgReqFrom"
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
                    Close Txn Date</td>
                <td colspan="3">
                    <asp:RadioButton ID="rbCloseAll" runat="server" GroupName="rbClose" Text="All" /><asp:RadioButton
                        ID="rbCloseFrom" runat="server" GroupName="rbClose" Text="From" />
                    <asp:TextBox ID="txtCloseFrom"
                            runat="server" Width="72px"></asp:TextBox><asp:Image
                        ID="imgCloseFrom" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />&nbsp;
                    To
                    <asp:TextBox ID="txtCloseTo" runat="server" Width="72px"></asp:TextBox><asp:Image ID="imgCloseTo" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxCECloseFrom" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgCloseFrom"
                        TargetControlID="txtCloseFrom">
                        </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxCECloseTo" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgCloseTo"
                        TargetControlID="txtCloseTo">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEECloseFrom" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtCloseFrom">
                    </ajaxToolkit:MaskedEditExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEECloseTo" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtCloseTo">
                    </ajaxToolkit:MaskedEditExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Account
                    Status</td>
                <td>
                    <asp:DropDownList ID="ddlAccStatus" runat="server" DataSourceID="sdsAccStatus" DataTextField="NAME"
                        DataValueField="CODE">
                </asp:DropDownList><asp:SqlDataSource ID="sdsAccStatus" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        
                        
                        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, NAME FROM (SELECT CAST(CODE AS INT) AS CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'ACCSTATUS') AND (CODE &lt;&gt; '0')) AS derivedtbl_1 ORDER BY CODE">
                </asp:SqlDataSource>
                </td>
                <td>
                    Finance Category</td>
                <td>
                    <asp:DropDownList ID="ddlFinanceCategory" runat="server" >
                    </asp:DropDownList><ajaxToolkit:CascadingDropDown ID="ajaxCCDFincat" runat="server" Category="FINCAT"
                        LoadingText="[Loading Finance Category ...]" PromptText="[DISPLAY ALL]" ServiceMethod="GetDropDownFinCatbyAppUserBranch"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlFinanceCategory" 
                        BehaviorID="BehavFinCat">
                    </ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
            <tr>
                <td>
                    Area</td>
                <td>
                    <asp:DropDownList ID="ddlAreaSearch" runat="server">
                    </asp:DropDownList><ajaxToolkit:CascadingDropDown ID="ajaxCDDArea" runat="server" Category="AREA"
                        LoadingText="[Loading Area ...]" PromptText="[DISPLAY ALL]" ServiceMethod="GetDropDownAreabyAppUserBranch"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlAreaSearch" 
                        BehaviorID="BehavArea">
                    </ajaxToolkit:CascadingDropDown>
                </td>
                <td>
                    Branch</td>
                <td>
                    <asp:DropDownList ID="ddlBranchSearch" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDBranch" runat="server" Category="BRANCH"
                        LoadingText="[Loading Branch...]" PromptText="[DISPLAY ALL]" ServiceMethod="GetDropDownBranchByAppUserBranch"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlBranchSearch" 
                        ParentControlID="ddlAreaSearch" BehaviorID="BehavBranch">
                    </ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:UpdatePanel ID="UPGrid" runat="server">
        <ContentTemplate>
            <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" 
                AutoGenerateColumns="False" Caption="Account List" DataKeyNames="LOCID,APPID" 
                DataSourceID="sdsGrid" RowHeaderColumn="ACCID" Width="99%">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                        <img src="../images/edit.gif" style="cursor: pointer" onclick="EditApp('<%#eval("LOCID")%>', '<%#eval("APPID")%>')" alt="Edit : <%#eval("LOCID")%> - <%#eval("APPID")%>" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="LOCID" HeaderText="Loc&lt;br&gt;ID" 
                        HtmlEncode="False" SortExpression="LOCID">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ACCID" HeaderText="Acc&lt;br&gt;ID" 
                        HtmlEncode="False" SortExpression="ACCID" />
                    <asp:BoundField DataField="ACCNO" HeaderText="Acc. No.&lt;br&gt;(Formated)" 
                        HtmlEncode="False" SortExpression="ACCNO" />
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
                    <asp:BoundField DataField="AREANAME" HeaderText="Area" 
                        SortExpression="AREANAME" />
                    <asp:BoundField DataField="BRANCH" HeaderText="Branch" ReadOnly="True" 
                        SortExpression="BRANCH" />
                    <asp:BoundField DataField="CUSTNO" HeaderText="Cust. No.&lt;BR&gt;(Formated)" 
                        HtmlEncode="False" SortExpression="CUSTNO" />
                    <asp:BoundField DataField="ACCSTATUSNAME" HeaderText="Acc.&lt;br&gt;Status" 
                        HtmlEncode="False" SortExpression="ACCSTATUSNAME" />
                </Columns>
                <EmptyDataTemplate>
                    <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsGrid" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                SelectCommand="SELECT TOP (500) APPLICATION.LOCID, APPLICATION.APPID, APPLICATION.REQUESTDATE, APPLICATION.ROWLOCK, ACCOUNT.ACCOUNTNAME, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCH, CUSTOMER.CUSTID, ACCOUNT.ACCID, CUSTOMER.IDNUMBER, ACCOUNT.BOOKINGDATE, ACCOUNT.REFNO, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCNO, dbo.f_FormatCustNoByID(CUSTOMER.BRANCHID, CUSTOMER.CUSTNO) AS CUSTNO, '(' + PARAMGLOBAL.CODE + ') ' + PARAMGLOBAL.NAME AS ACCSTATUSNAME, ACCOUNT.ACCSTATUS, '(' + AREA.AREACODE + ') ' + AREA.AREANAME AS AREANAME FROM APPLICATION WITH (NOLOCK) INNER JOIN ACCOUNT WITH (NOLOCK) ON APPLICATION.LOCID = ACCOUNT.LOCID AND APPLICATION.APPID = ACCOUNT.APPID INNER JOIN CUSTOMER WITH (NOLOCK) ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID INNER JOIN AREA WITH (NOLOCK) INNER JOIN BRANCH WITH (NOLOCK) ON AREA.AREAID = BRANCH.AREAID ON ACCOUNT.BRANCHID = BRANCH.BRANCHID INNER JOIN PARAMGLOBAL ON ACCOUNT.ACCSTATUS = PARAMGLOBAL.CODE AND PARAMGLOBAL.TYPE = 'ACCSTATUS' WHERE (APPLICATION.Deletests = 0) AND (ACCOUNT.Deletests = 0) AND (ACCOUNT.ACCSTATUS &lt;&gt; 0) AND (APPLICATION.APPSTATUS = 100)">
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>


<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
        FormatTable("<%=gvData.ClientID%>");
    });

    function HideBusyBox() {
        if (Hide_BusyMX) 
                    Hide_BusyMX();
    }
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
</script>

</asp:Content>

