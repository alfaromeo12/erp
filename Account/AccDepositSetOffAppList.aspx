<%@ Page Language="VB" MasterPageFile="~/MXPageNoBusy.master" AutoEventWireup="false" CodeFile="AccDepositSetOffAppList.aspx.vb" Inherits="DEPSETOFF_INQ" title="DEPOSIT SET OFF Inquiry List" EnableEventValidation="FALSE"  MaintainScrollPositionOnPostback="true"%>
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
    <asp:HiddenField ID="hidIsUserBranch" runat="server" />
    <asp:HiddenField ID="txtUID" runat="server" />
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
                    Set Off Date</td>
                <td colspan="3">
                    <asp:RadioButton ID="rbWOAll" runat="server" GroupName="rbReq" Text="All" /><asp:RadioButton
                        ID="rbWOFrom" runat="server" GroupName="rbReq" Text="From" />
                    <asp:TextBox ID="txtSetOffFrom" runat="server" Width="72px"></asp:TextBox><asp:Image
                        ID="imgSetOffFrom" runat="server" ImageUrl="~/images/grid.gif" 
                        style="cursor: pointer" ToolTip="Calendar" />
                    To
                    <asp:TextBox ID="txtSetOffTo" runat="server" Width="72px"></asp:TextBox>
                    <asp:Image ID="imgSetOffTo" runat="server" ImageUrl="~/images/grid.gif" 
                        style="cursor: pointer" ToolTip="Calendar" />
                    <ajaxToolkit:CalendarExtender ID="ajaxCEWOFrom" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgSetOffFrom"
                        TargetControlID="txtSetOffFrom">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxCEWOTo" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgSetOffTo"
                        TargetControlID="txtSetOffTo">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateFrom" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtSetOffFrom">
                    </ajaxToolkit:MaskedEditExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateTo" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtSetOffTo">
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
                        ID="imgBookFrom" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />
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
                    <asp:Label ID="lblStatus" runat="server" Text="Set Off Status" Visible="False"></asp:Label>
                    </td>
                <td>
                    <asp:DropDownList ID="ddlSetOffStatusSearch" runat="server" 
                        DataSourceID="sdsSetOffStatus" DataTextField="NAME" DataValueField="CODE" 
                        Visible="False">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsSetOffStatus" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'WOSTATUS')">
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </asp:Panel>
        <asp:UpdatePanel ID="UPGrid" runat="server">
            <ContentTemplate>
                <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" 
                    AutoGenerateColumns="False" Caption="Deposit Set Off List" 
                    DataKeyNames="LOCID,ACCID,DEPID" DataSourceID="sdsGrid" Width="99%">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                        <img src="../images/edit.gif" style="cursor: pointer" onclick="ShowSetOff('<%#eval("LOCID")%>', '<%#eval("ACCID")%>', '<%#eval("DEPID")%>')" alt="Edit : <%#eval("LOCID")%> - <%#eval("ACCID")%>" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="JRN" SortExpression="ACCID">
                            <ItemTemplate>
                        <img src="../Images/Journal.gif" onclick='ViewJournal(<%# eval("LOCID") %>, <%# eval("ACCID") %>, <%# eval("DEPID") %>, <%# eval("TXNTYPE") %>)' alt="ACC ID : <%#eval("ACCID")%>" style='cursor: pointer; visibility:<%#eval("JOURNAL")%>;' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="BRANCHNAME" HeaderText="Branch" HtmlEncode="False" 
                            SortExpression="BRANCHNAME" />
                        <asp:TemplateField HeaderText="Acc. No.&lt;br&gt;(Formated)" 
                            SortExpression="ACCNO">
                            <ItemTemplate>
                                <a href="#" onclick='ViewDetailAcc(<%# eval("LOCID") %>, <%# eval("APPID") %>)'>
                                <asp:Label ID="lblAccNo" runat="server" Font-Bold="True" 
                                    Text='<%# eval("ACCNO") %>'></asp:Label>
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" 
                            HtmlEncode="False" SortExpression="ACCOUNTNAME" />
                        <asp:BoundField DataField="TXNDATE" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Set Off&lt;br&gt;Date" HtmlEncode="False" SortExpression="TXNDATE">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Booking&lt;br&gt;Date" HtmlEncode="False" 
                            SortExpression="BOOKINGDATE">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SETOFFSTATUSNAME" 
                            HeaderText="Set Off&lt;br&gt;Status" HtmlEncode="False" 
                            SortExpression="SETOFFSTATUSNAME" />
                        <asp:BoundField DataField="DEPOSIT" DataFormatString="{0:N}" 
                            HeaderText="DEPOSIT" HtmlEncode="False" SortExpression="DEPOSIT">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SETOFF" DataFormatString="{0:N}" HeaderText="SETOFF" 
                            HtmlEncode="False" SortExpression="SETOFF">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>
                    <EmptyDataTemplate>
                        <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsGrid" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    SelectCommand="SELECT TOP (500) DEPOSITSETOFF.LOCID, DEPOSITSETOFF.ACCID, DEPOSITSETOFF.DEPID, ACCOUNT.APPID, ACCOUNT.ACCOUNTNAME, ACCOUNT.BOOKINGDATE, ACCOUNT.REFNO, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCNO, DEPOSITSETOFF.TXNDATE, '(' + CAST(DEPOSITSETOFF.STATUS AS VARCHAR(10)) + ') ' + dbo.f_getParamGlobalName('WOSTATUS', DEPOSITSETOFF.STATUS) AS SETOFFSTATUSNAME, DEPOSITSETOFF.DEPOSIT, DEPOSITSETOFF.SETOFF, DEPOSITSETOFF.STATUS, CAST(CASE WHEN STATUS = 1 THEN 1 ELSE 0 END AS BIT) AS JOURNAL, DEPOSITSETOFF.TXNTYPE, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCHNAME FROM ACCOUNT WITH (NOLOCK) INNER JOIN CUSTOMER WITH (NOLOCK) ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID INNER JOIN AREA WITH (NOLOCK) INNER JOIN BRANCH WITH (NOLOCK) ON AREA.AREAID = BRANCH.AREAID ON ACCOUNT.BRANCHID = BRANCH.BRANCHID INNER JOIN DEPOSITSETOFF WITH (NOLOCK) ON ACCOUNT.LOCID = DEPOSITSETOFF.LOCID AND ACCOUNT.ACCID = DEPOSITSETOFF.ACCID WHERE (ACCOUNT.Deletests = 0) AND (ACCOUNT.ACCSTATUS &lt;&gt; 0)">
                </asp:SqlDataSource>
            </ContentTemplate>
    </asp:UpdatePanel>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
        FormatTable("<%=gvData.ClientID%>");
    });

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
function ShowSetOff(LOCID, ACCID, DEPID){
    window.location = "AccDepositSetOffApproval.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&ACCID=" + ACCID + "&DEPID=" + DEPID
}
function ViewJournal(LOCID, ACCID, DEPID, TXNTYPE) {
    var RefNo = LOCID + '-' + ACCID + '-' + DEPID;
    var winref;
    if (TXNTYPE == "1") {
        winref = window.open("../Core/JournalViewByRefNo.aspx?Action=View&RefNo=" + RefNo + "&BookCode=DS1", "BookJournal", "height=400,width=600,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
    } else {
        winref = window.open("../Core/JournalViewByRefNo.aspx?Action=View&RefNo=" + RefNo + "&BookCode=DS2", "BookJournal", "height=400,width=600,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
    }
    winref.focus();
    return (false);
}
function ViewDetailAcc(LOCID, APPID) {
    var winref = window.open("../Account/AccInqFrame.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
    winref.focus();
}
</script>
</asp:Content>

