<%@ Page Language="VB" MasterPageFile="~/MXPageNoBusy.master" AutoEventWireup="false" CodeFile="AccForJFApp.aspx.vb" Inherits="Txn_JFApproval" title="Account for JF Approval" EnableEventValidation="FALSE" %>
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
        <asp:ListItem Value="REQUESTID">Request ID</asp:ListItem>
        <asp:ListItem Value="ACCOUNT.ACCID">ACC ID</asp:ListItem>
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
                    JF Request Date</td>
                <td colspan="3">
                    <asp:RadioButton ID="rbReqAll" runat="server" GroupName="rbReq" Text="All" /><asp:RadioButton
                        ID="rbReqFrom" runat="server" GroupName="rbReq" Text="From" />
                    <asp:TextBox ID="txtRequestForm" runat="server" Width="72px"></asp:TextBox><asp:Image
                        ID="imgReqFrom" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer"
                        ToolTip="Calendar" />
                    To
                    <asp:TextBox ID="txtRequestTo" runat="server" Width="72px"></asp:TextBox><asp:Image
                        ID="imgReqTo" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer"
                        ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxReqFrom" runat="server" Format="dd/MM/yyyy"
                            PopupButtonID="imgReqFrom" TargetControlID="txtRequestForm">
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
        </table>
    </asp:Panel>
        <asp:UpdatePanel ID="UPGrid" runat="server">
            <ContentTemplate>
                <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" 
                    AutoGenerateColumns="False" Caption="JF REQUEST LIST" DataKeyNames="REQUESTID" 
                    DataSourceID="sdsGrid" RowHeaderColumn="REQUESTID" Width="99%">
                    <Columns>
                        <asp:TemplateField HeaderText="EDT" SortExpression="REQUESTID">
                            <ItemTemplate>
                        <img alt='View : <%#eval("REQUESTID")%>' onclick="EditAcc('<%#eval("REQUESTID")%>')"
                            src="../images/edit.gif" style="cursor: pointer" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="TXT" SortExpression="REQUESTID">
                            <ItemTemplate>
                        <img alt="Text File : <%#eval("REQUESTID")%>" src="../Images/textfile.png" style="cursor: pointer" onclick="GenerateFile('<%#eval("REQUESTID")%>')" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="APP" SortExpression="REQUESTID">
                            <ItemTemplate>
                                <asp:CheckBox ID="cbChk" runat="server" Visible='<%# Eval("APPEXIST") %>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="REQUESTID" HeaderText="Request&lt;br&gt;ID" 
                            HtmlEncode="False" ReadOnly="True" SortExpression="REQUESTID" />
                        <asp:BoundField DataField="REQUESTDATE" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Request&lt;br&gt;Date" HtmlEncode="False" 
                            SortExpression="REQUESTDATE">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="JFGROUPNAME" HeaderText="JF Group&lt;br&gt;Name" 
                            HtmlEncode="False" ReadOnly="True" SortExpression="JFGROUPNAME" />
                        <asp:BoundField DataField="JFNAME" HeaderText="JF&lt;br&gt;Name" 
                            HtmlEncode="False" ReadOnly="True" SortExpression="JFNAME" />
                        <asp:BoundField DataField="NUMACC" HeaderText="#Acc" HtmlEncode="False" 
                            SortExpression="NUMACC">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NUMACCUNAPP" HeaderText="#Acc&lt;br&gt;UnApp" 
                            HtmlEncode="False" SortExpression="NUMACCUNAPP">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NUMACCAPP" HeaderText="#Acc&lt;br&gt;App" 
                            HtmlEncode="False" SortExpression="NUMACCAPP">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NUMACCRJC" HeaderText="#Acc&lt;BR&gt;Rjt" 
                            HtmlEncode="False" SortExpression="NUMACCRJC">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="JFPORTION" DataFormatString="{0:N2}" 
                            HeaderText="JF&lt;br&gt;Portion" HtmlEncode="False" SortExpression="JFPORTION">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>
                    <EmptyDataTemplate>
                        <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsGrid" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    SelectCommand="SELECT TOP (1000) JFREQUEST.REQUESTID, JFREQUEST.REQUESTDATE, JFREQUEST.JFID, '(' + JF.JFCODE + ') ' + JF.JFNAME AS JFNAME, '(' + JFGROUP.JFGROUPCODE + ') ' + JFGROUP.JFGROUPNAME AS JFGROUPNAME, JF.JFPORTION, CAST(CASE WHEN EXISTS (SELECT 'X' FROM JFREQUESTACC WHERE JFREQUEST.REQUESTID = JFREQUESTACC.REQUESTID AND JFREQUESTSTATUS = 0) THEN 1 ELSE 0 END AS BIT) AS APPEXIST, (SELECT COUNT(*) AS Expr1 FROM JFREQUESTACC WHERE (JFREQUEST.REQUESTID = REQUESTID)) AS NUMACC, (SELECT COUNT(*) AS Expr1 FROM JFREQUESTACC AS JFREQUESTACC_3 WHERE (JFREQUEST.REQUESTID = REQUESTID) AND (JFREQUESTSTATUS = 0)) AS NUMACCUNAPP, (SELECT COUNT(*) AS Expr1 FROM JFREQUESTACC AS JFREQUESTACC_2 WHERE (JFREQUEST.REQUESTID = REQUESTID) AND (JFREQUESTSTATUS = 1)) AS NUMACCAPP, (SELECT COUNT(*) AS Expr1 FROM JFREQUESTACC AS JFREQUESTACC_1 WHERE (JFREQUEST.REQUESTID = REQUESTID) AND (JFREQUESTSTATUS = 9)) AS NUMACCRJC FROM JFREQUEST INNER JOIN JF ON JFREQUEST.JFID = JF.JFID INNER JOIN JFGROUP ON JF.JFGROUPID = JFGROUP.JFGROUPID WHERE (1 = 1) ORDER BY JFREQUEST.REQUESTID DESC">
                </asp:SqlDataSource>
                <asp:CheckBox ID="chkAll" runat="server" CssClass="ShowDetail" 
                    Text="Check/UnCheck All" />
            </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <br />
    <br />
    <br />
    <br />
    <asp:Panel ID="pnlProcess" runat="server" Width="100%">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="FooterStyle" colspan="2">
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
                </td>
            </tr>
            <tr>
                <td class="FooterStyle">
                    JF/Bank Booked Date</td>
                <td class="FooterStyle">
                    <asp:TextBox ID="txtValueDate" runat="server" CssClass="required" Width="72px"></asp:TextBox>
                    <asp:Image ID="imgValueDate" runat="server" ImageUrl="~/images/grid.gif" 
                        Style="cursor: pointer" ToolTip="Calendar" />
                    <asp:RequiredFieldValidator ID="reqValuedAte" runat="server" 
                        ControlToValidate="txtValueDate" Display="None" 
                        ErrorMessage="VALUE DATE must be entry...!" SetFocusOnError="True" 
                        ValidationGroup="Approve"></asp:RequiredFieldValidator>
                    <asp:Label ID="lblVerifyDate" runat="server" CssClass="ErrHighLight" 
                        Text="Please CONFIRM and VERIFY booked date to the Join Finance (Bank)"></asp:Label>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEValueDate" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqValuedAte">
                    </ajaxToolkit:ValidatorCalloutExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxCEValueDate" runat="server" Format="dd/MM/yyyy" 
                        PopupButtonID="imgValueDate" TargetControlID="txtValueDate" 
                        PopupPosition="TopRight">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEValueDate" runat="server" Mask="99/99/9999" 
                        MaskType="Date" TargetControlID="txtValueDate">
                    </ajaxToolkit:MaskedEditExtender>
                </td>
            </tr>
            <tr>
                <td class="HeaderStyle" colspan="2">
        <asp:Button ID="btnApprove" runat="server" Style="background-position: right; background-image: url(../Images/ok.png);
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Approve" Width="72px" OnClientClick='return confirm("Are you sure want to Approve JF Request..?")' />
        <asp:Button ID="btnReject" runat="server" Style="background-position: right; background-image: url(../Images/stop.png);
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Reject" Width="72px" OnClientClick='return confirm("Are you sure want to Reject JF Request..?")' />Approve or Reject by checklist above</td>
            </tr>
        </table>
    </asp:Panel>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxVCEProcess" runat="server" TargetControlID="pnlProcess"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
        FormatTable("<%=gvData.ClientID%>");
    });

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

function EditAcc(REQUESTID){
    window.location="AccForJFAppDtl.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&REQUESTID=" + REQUESTID
}
function GenerateFile(REQUESTID){
    var winref = window.open("../Account/AccForJFText.aspx?Action=Generate&REQUESTID=" + REQUESTID + "&USEDFOR=1", "GenFile", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes");
    winref.focus();
}
window.onload=function(){
}
function SelectRow(oCb) {
    if (oCb.checked)
        oCb.parentElement.parentElement.className = "SelectedRowStyle";
    else
        oCb.parentElement.parentElement.className = "";
}
function CheckAll() {
    var chk = getObjectbyClientID("<%=chkAll.ClientID%>");
    var sCheck = "<%=strCheckBox%>";
    var arrCheck = sCheck.split(",");
    var oCheck;
    var nLen = arrCheck.length - 1;
    if (nLen > 0) {
        for (var i = 0; i < nLen; i++) {
            oCheck = getObjectbyClientID(arrCheck[i].toString());
            if (oCheck) {
                oCheck.checked = chk.checked;
                if (oCheck.checked)
                    oCheck.parentElement.parentElement.className = "SelectedRowStyle";
                else
                    oCheck.parentElement.parentElement.className = "";
            }
        }
    }
}

</script>

</asp:Content>

