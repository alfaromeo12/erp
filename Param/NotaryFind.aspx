<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="NotaryFind.aspx.vb" Inherits="Param_NotaryFind" title="Param : Notary Find" EnableEventValidation="false" %>
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
        <asp:ListItem Value="NOTARYNAME">Notary Name</asp:ListItem>
        <asp:ListItem Value="NOTARYCODE">Notary Code</asp:ListItem>
    </asp:DropDownList></td>
                <td>
    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset"
        Text="Search" CssClass="Search" /><ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
                </td>
            </tr>
            <tr>
                <td style="width: 144px">
                    Area</td>
                <td>
                    <asp:DropDownList ID="ddlAreaSearch" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDArea" runat="server" BehaviorID="BehavArea" 
                        Category="AREA" LoadingText="[Loading Area ...]" PromptText="[DISPLAY ALL]" 
                        ServiceMethod="GetDropDownArea" 
                        ServicePath="WebService.asmx" TargetControlID="ddlAreaSearch">
                    </ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
            <tr>
                <td style="width: 144px">
                    Branch</td>
                <td>
                    <asp:DropDownList ID="ddlBranchSearch" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDBranch" runat="server" 
                        BehaviorID="BehavBranch" Category="BRANCH" LoadingText="[Loading Branch...]" 
                        ParentControlID="ddlAreaSearch" PromptText="[DISPLAY ALL]" 
                        ServiceMethod="GetDropDownBranchByArea" 
                        ServicePath="WebService.asmx" TargetControlID="ddlBranchSearch">
                    </ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
        </table>
        <asp:UpdatePanel ID="UPGrid" runat="server">
            <ContentTemplate>
                <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" 
                    AutoGenerateColumns="False" Caption="Notary List" DataKeyNames="NOTARYID" 
                    DataSourceID="sdsGrid" RowHeaderColumn="NOTARYID" Width="100%">
                    <Columns>
                        <asp:TemplateField HeaderText="SET" SortExpression="ROUTEID">
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                            <ItemTemplate>
                                <img src="../images/edit.gif" style="cursor: pointer" onclick="SetNotary('<%#eval("NOTARYID")%>', '<%#eval("NOTARYNAME")%>')" alt="SET NOTARY: <%#eval("NOTARYID")%>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="NOTARYID" HeaderText="ID" ReadOnly="True" 
                            SortExpression="NOTARYID" />
                        <asp:BoundField DataField="NOTARYNAME" HeaderText="Notary&lt;br&gt;Name" 
                            HtmlEncode="False" SortExpression="NOTARYNAME" />
                        <asp:BoundField DataField="NOTARYADDRESS" HeaderText="Address" 
                            HtmlEncode="False" ReadOnly="True" SortExpression="NOTARYADDRESS" />
                        <asp:BoundField DataField="NOTARYCITY" HeaderText="City" HtmlEncode="False" 
                            SortExpression="NOTARYCITY" />
                        <asp:BoundField DataField="NOTARYPHONE" HeaderText="Phone" 
                            SortExpression="NOTARYPHONE" />
                        <asp:BoundField DataField="BRANCHNAME" HeaderText="Branch" 
                            SortExpression="BRANCHNAME" />
                    </Columns>
                    <EmptyDataTemplate>
                        <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsGrid" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    SelectCommand="SELECT TOP (500) NOTARY.NOTARYID, '(' + NOTARY.NOTARYCODE + ') ' + NOTARY.NOTARYNAME AS NOTARYNAME, NOTARY.NOTARYADDRESS, NOTARY.NOTARYCITY, NOTARY.NOTARYPHONE, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCHNAME FROM AREA INNER JOIN BRANCH ON AREA.AREAID = BRANCH.AREAID RIGHT OUTER JOIN NOTARY ON BRANCH.BRANCHID = NOTARY.BRANCHID WHERE (NOTARY.Deletests = 0)">
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
    </asp:Panel>
    &nbsp;
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
        FormatTable("<%=gvData.ClientID%>");
    });
function SetNotary(NotaryID, NotaryName){
    window.opener.SetNotary(NotaryID, NotaryName);
    window.close()
}
</script>

</asp:Content>

