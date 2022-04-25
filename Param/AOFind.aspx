<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AOFind.aspx.vb" Inherits="Param_AOFind" title="Param : AO Find" EnableEventValidation="false" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
<style type="text/css">
.modalBackground
{
	background-color: Gray;
	filter: alpha(opacity=50);
	opacity: 0.50;
}

.updateProgress
{
	background-color: #cccccc;
	position: absolute;
	width: 180px;
	height: 65px;
	border-bottom: thin outset;
	border-left: thin outset;
	border-top: thin outset;
	border-right: thin outset;
	font-weight: bold;
}

</style>

<script type="text/javascript" language="javascript">
    var ModalProgress = '<%=ModalProgress.ClientID%>';
</script>
    <asp:Panel ID="pnlData" runat="server">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td style="width: 144px">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="AO.AOName">AO Name</asp:ListItem>
        <asp:ListItem Value="AO.AOCode">AO Code</asp:ListItem>
    </asp:DropDownList></td>
                <td style="width: 216px">
    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset"
        Text="Search" CssClass="Search" /><ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td style="width: 144px">
                    Area</td>
                <td style="width: 216px">
                    <asp:DropDownList ID="ddlAreaSearch" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDArea" runat="server" Category="AREA" LoadingText="[Loading Area...]"
                        PromptText="[DISPLAY ALL]" ServiceMethod="GetDropDownArea" ServicePath="~\Param\WebService.asmx"
                        TargetControlID="ddlAreaSearch">
                    </ajaxToolkit:CascadingDropDown>
                </td>
                <td>
        Branch</td>
                <td>
                    <asp:DropDownList ID="ddlBranchSearch" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDBranch" runat="server" Category="BRANCH" LoadingText="[Loading Branch...]"
                        ParentControlID="ddlAreaSearch" PromptText="[DISPLAY ALL]" ServiceMethod="GetDropDownBranchByArea"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlBranchSearch">
                    </ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
        </table>
        </asp:Panel>
        <asp:UpdatePanel ID="UPGrid" runat="server">
        <ContentTemplate>
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
            Caption="Account Officer List" DataKeyNames="AOID" DataSourceID="sdsGrid" Width="100%" RowHeaderColumn="AOCODE">
            <Columns>
                <asp:TemplateField HeaderText="SET" SortExpression="AOID">
                    <ItemStyle Width="20px" />
                    <ItemTemplate>
                        <img src="../images/edit.gif" style="cursor: pointer" onclick="SetAO('<%#eval("AOID")%>', '(<%#eval("AOCODE")%>) <%#eval("AONAME")%>')" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="AOCODE" HeaderText="Code" SortExpression="AOCODE" />
                <asp:BoundField DataField="BRANCH" HeaderText="Branch" ReadOnly="True" SortExpression="BRANCH" />
                <asp:BoundField DataField="AONAME" HeaderText="Name" SortExpression="AONAME" />
                <asp:BoundField DataField="AOADDRESS" HeaderText="Address" SortExpression="AOADDRESS" />
                <asp:BoundField DataField="AOCITY" HeaderText="City" SortExpression="AOCITY" />
                <asp:BoundField DataField="PHONE" HeaderText="Phone&lt;br&gt;No." HtmlEncode="False"
                    ReadOnly="True" SortExpression="PHONE" />
                <asp:BoundField DataField="AOMOBILE" HeaderText="Mobile&lt;br&gt;No." HtmlEncode="False"
                    SortExpression="AOMOBILE" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            SelectCommand="SELECT TOP (500) AO.AOID, AO.AOCODE, REPLACE(AO.AONAME, '''', '') AS AONAME, AO.AOADDRESS, AO.AOCITY, '(' + AO.AOPHONEAREA + ') ' + AO.AOPHONENO AS PHONE, AO.AOMOBILE, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCH FROM AREA WITH (nolock) INNER JOIN BRANCH WITH (nolock) ON AREA.AREAID = BRANCH.AREAID RIGHT OUTER JOIN AO WITH (nolock) ON BRANCH.BRANCHID = AO.BRANCHID WHERE (AO.DELETESTS = 0)">
        </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript" src="../include/jsUpdateProgress.js"></script>
   <ajaxToolkit:ModalPopupExtender ID="ModalProgress" runat="server" TargetControlID="panelUpdateProgress"
		BackgroundCssClass="modalBackground" PopupControlID="panelUpdateProgress"   />
<asp:Panel ID="panelUpdateProgress" runat="server" CssClass="updateProgress">
    <asp:UpdateProgress ID="UpdateProgMaster" DisplayAfter="0" runat="server" >
        <ProgressTemplate>
            <div style="position: relative; top: 30%; text-align: center;" >
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/wait.gif" 
                ToolTip="Processing" /><br />
                Processing ...
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Panel>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
        FormatTable("<%=gvData.ClientID%>");
    });
function SetAO(AOID, AO){
    window.opener.SetAO(AOID, AO);
    window.close()
}
</script>

</asp:Content>

