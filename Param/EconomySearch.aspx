<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="EconomySearch.aspx.vb" Inherits="Param_EconomySearch" title="Economy Sector Search" EnableEventValidation="false" %>
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
    <br />
    <asp:Panel ID="pnlData" runat="server">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="ECONAME">Name</asp:ListItem>
        <asp:ListItem Value="ECOCODE">Code</asp:ListItem>
        <asp:ListItem Value="EcoCodeBI">Code BI</asp:ListItem>
    </asp:DropDownList></td>
                <td>
    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset"
        Text="Search" CssClass="Search" />
    <ajaxToolkit:textboxwatermarkextender id="ajxTBWESearch" runat="server" targetcontrolid="txtSearch"
        watermarktext="%%">
    </ajaxToolkit:textboxwatermarkextender>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
        </table>
        </asp:Panel>
        <asp:UpdatePanel ID="UPGrid" runat="server">
        <ContentTemplate>
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
            Caption="Economy Sector List" DataKeyNames="ECOID" DataSourceID="sdsGrid" Width="100%" RowHeaderColumn="ECOID">
            <Columns>
                <asp:TemplateField HeaderText="Set" SortExpression="MEDIATORID">
                    <ItemTemplate>
                        <img src="../images/edit.gif" style="cursor: pointer" onclick="SetEco(<%#eval("ECOID")%>, '(<%#eval("ECOCode")%>) <%#eval("ECOName")%>')" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:TemplateField>
                <asp:BoundField DataField="ECOID" HeaderText="Economy&lt;br&gt;ID" HtmlEncode="False"
                    SortExpression="ECOID" />
                <asp:BoundField DataField="ECOCODE" HeaderText="Economy&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="ECOCODE" />
                <asp:BoundField DataField="ECOCODEBI" HeaderText="Economy&lt;br&gt;Code (BI)" HtmlEncode="False"
                    SortExpression="ECOCODEBI" />
                <asp:BoundField DataField="ECONAME" HeaderText="Economy&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="ECONAME" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>

        <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            SelectCommand="SELECT TOP (700) ECOID, ECOCODE, ECONAME, ECOCODEBI FROM ECONOMYCODE WHERE (DELETESTS = 0)">
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
function SetEco(ECOID, ECO){
    window.opener.SetEco(ECOID, ECO);
    window.close()
}
</script>

</asp:Content>

