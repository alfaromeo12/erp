<%@ Page Title="" Language="VB" MasterPageFile="~/MXPageNoBusy.master" AutoEventWireup="false" CodeFile="AccRsJFList.aspx.vb" EnableEventValidation="false" Inherits="Account_AccRsJFList" %>
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
    <asp:HiddenField ID="hidRSType" runat="server" />
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
        <asp:ListItem Value="ACCOUNTJF.ACCIDJF">ACC ID JF</asp:ListItem>
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
                    JF
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
                    JF 
                    Account
                    Status</td>
                <td>
                    <asp:DropDownList ID="ddlAccStatus" runat="server" DataSourceID="sdsAccStatus" DataTextField="NAME"
                        DataValueField="CODE">
                </asp:DropDownList><asp:SqlDataSource ID="sdsAccStatus" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        
                        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, NAME FROM (SELECT CAST(CODE AS INT) AS CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JFACCSTATUS') AND (CODE &lt;&gt; '0')) AS derivedtbl_1 ORDER BY CODE">
                </asp:SqlDataSource>
                </td>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
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
        </table>
    </asp:Panel>
         <asp:UpdatePanel ID="UPGrid" runat="server">
             <ContentTemplate>
                 <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" 
                     AutoGenerateColumns="False" Caption="Account Join Finance Reschedule List" 
                     DataKeyNames="LOCID,APPID" DataSourceID="sdsGrid" RowHeaderColumn="ACCIDJF" 
                     Width="99%">
                     <Columns>
                         <asp:TemplateField>
                             <ItemTemplate>
                        <img src="../images/edit.gif" style="cursor: pointer" onclick="EditApp('<%#eval("ACCIDJF")%>')" alt="Edit : <%#eval("ACCIDJF")%> " />
                             </ItemTemplate>
                             <ItemStyle HorizontalAlign="Center" Width="20px" />
                         </asp:TemplateField>
                         <asp:BoundField DataField="ACCIDJF" HeaderText="ACCID&lt;br&gt;JF" 
                             HtmlEncode="False" SortExpression="ACCIDJF" />
                         <asp:BoundField DataField="ACCNO" HeaderText="Acc. No.&lt;br&gt;(Formated)" 
                             HtmlEncode="False" SortExpression="ACCNO" />
                         <asp:BoundField DataField="BOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" 
                             HeaderText="Booking&lt;br&gt;Date" HtmlEncode="False" 
                             SortExpression="BOOKINGDATE" />
                         <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" 
                             HtmlEncode="False" SortExpression="ACCOUNTNAME" />
                         <asp:BoundField DataField="BRANCH" HeaderText="Branch" ReadOnly="True" 
                             SortExpression="BRANCH" />
                         <asp:BoundField DataField="ACCSTATUSNAME" HeaderText="Acc.&lt;br&gt;Status" 
                             HtmlEncode="False" SortExpression="ACCSTATUSNAME" />
                         <asp:BoundField DataField="JFBOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" 
                             HeaderText="JF Book&lt;br&gt;Date" HtmlEncode="False" 
                             SortExpression="JFBOOKINGDATE">
                         <ItemStyle HorizontalAlign="Center" />
                         </asp:BoundField>
                         <asp:BoundField DataField="JFNAME" HeaderText="JF&lt;br&gt;Name" 
                             HtmlEncode="False" SortExpression="JFNAME" />
                         <asp:BoundField DataField="JFACCSTATUSNAME" HeaderText="JF&lt;br&gt;Status" 
                             HtmlEncode="False" SortExpression="JFACCSTATUSNAME" />
                         <asp:BoundField DataField="JFPRINCIPALTOTAL" DataFormatString="{0:N}" 
                             HeaderText="JF&lt;br&gt;Principal" HtmlEncode="False" 
                             SortExpression="JFPRINCIPALTOTAL">
                         <ItemStyle HorizontalAlign="Right" />
                         </asp:BoundField>
                         <asp:BoundField DataField="JFTENOR" HeaderText="JF&lt;br&gt;Tenor" 
                             HtmlEncode="False" SortExpression="JFTENOR">
                         <ItemStyle HorizontalAlign="Right" />
                         </asp:BoundField>
                     </Columns>
                     <EmptyDataTemplate>
                         <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                     </EmptyDataTemplate>
                 </asp:GridView>
                 <asp:SqlDataSource ID="sdsGrid" runat="server" 
                     ConnectionString="<%$ ConnectionStrings:connection %>" 
                     SelectCommand="SELECT TOP (500) ACCOUNT.ACCOUNTNAME, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCH, ACCOUNT.BOOKINGDATE, ACCOUNT.REFNO, dbo.f_FormatCustNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCNO, ACCOUNTJF.ACCIDJF, ACCOUNTJF.JFBOOKINGDATE, '(' + CAST(ACCOUNTJF.JFACCSTATUS AS VARCHAR(20)) + ')' + dbo.f_getParamGlobalName('JFACCSTATUS', ACCOUNTJF.JFACCSTATUS) AS JFACCSTATUSNAME, ACCOUNTJF.JFPRINCIPALTOTAL, ACCOUNTJF.JFTENOR, '(' + JF.JFCODE + ') ' + JF.JFNAME AS JFNAME, ACCOUNT.LOCID, ACCOUNT.ACCID, ACCOUNT.APPID, '(' + CAST(ACCOUNT.ACCSTATUS AS VARCHAR(20)) + ')' + dbo.f_getParamGlobalName('ACCSTATUS', ACCOUNT.ACCSTATUS) AS ACCSTATUSNAME FROM ACCOUNT WITH (NOLOCK) INNER JOIN CUSTOMER WITH (NOLOCK) ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID INNER JOIN AREA WITH (NOLOCK) INNER JOIN BRANCH WITH (NOLOCK) ON AREA.AREAID = BRANCH.AREAID ON ACCOUNT.BRANCHID = BRANCH.BRANCHID INNER JOIN ACCOUNTJF WITH (NOLOCK) ON ACCOUNT.LOCID = ACCOUNTJF.LOCID AND ACCOUNT.ACCID = ACCOUNTJF.ACCID INNER JOIN JF WITH (NOLOCK) ON ACCOUNTJF.JFID = JF.JFID INNER JOIN JFGROUP WITH (NOLOCK) ON JF.JFGROUPID = JFGROUP.JFGROUPID WHERE (ACCOUNTJF.JFACCSTATUS = 1)">
                 </asp:SqlDataSource>
             </ContentTemplate>
    </asp:UpdatePanel>


<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
        FormatTable("<%=gvData.ClientID%>");
    });

    function getObjectbyClientID(ClientID) {
        var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        return (oObject)
    }
    function GetValueTxtByClientID(ClientID) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            return (oText.value);
    }
  
    function EditApp(ACCIDJF) {
        var RSType = GetValueTxtByClientID("<%=hidRSType.ClientID%>");
        window.location = "AccRSJFEntry.aspx?ACCIDJF=" + ACCIDJF + "&RSType=" + RSType;
    }
    function ViewDetailAcc(LOCID, APPID) {
        var winref = window.open("AccInqFrame.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
        winref.focus();
    }

</script>

</asp:Content>

