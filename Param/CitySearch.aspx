<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="CitySearch.aspx.vb" Inherits="Param_CitySearch" title="City Search" EnableEventValidation="false" %>
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
        <asp:ListItem Value="CITYNAME">City Name</asp:ListItem>
        <asp:ListItem Value="CITYCODE">City Code</asp:ListItem>
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
            </tr>
        </table>
         </asp:Panel>
        <asp:UpdatePanel ID="UPGrid" runat="server">
        <ContentTemplate>
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
            Caption="City (BI - DatiII) List" DataKeyNames="CITYID" DataSourceID="sdsGrid" Width="100%" RowHeaderColumn="CITYID">
            <Columns>
                <asp:TemplateField HeaderText="Set" SortExpression="CITYID">
                    <ItemTemplate>
                        <img src="../images/edit.gif" style="cursor: pointer" onclick="SetCity(<%#eval("CityID")%>, '(<%#eval("CityCode")%>) <%#eval("CityName")%>')" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:TemplateField>
                <asp:BoundField DataField="CITYID" HeaderText="City&lt;br&gt;ID" HtmlEncode="False"
                    SortExpression="CITYID" >
                <ItemStyle HorizontalAlign="Center" Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="CITYCODE" HeaderText="City&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="CITYCODE" />
                <asp:BoundField DataField="CITYNAME" HeaderText="City&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="CITYNAME" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT TOP (700) CITYID, CITYCODE, CITYNAME FROM CITY WHERE (DELETESTS = 0) ">
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
function SetCity(CityID, City) {
    window.opener.SetCity(CityID, City);  
    window.close();
}

</script>

</asp:Content>

