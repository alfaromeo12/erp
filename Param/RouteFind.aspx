<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="RouteFind.aspx.vb" Inherits="Param_RouteFind" title="Param : Route Find" EnableEventValidation="false" %>
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
        <asp:ListItem Value="ROUTENAME">Route Name</asp:ListItem>
        <asp:ListItem Value="ROUTENO">Route No.</asp:ListItem>
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
                    Route Kind</td>
                <td>
                    <asp:DropDownList ID="ddlRouteKindSearch" runat="server" AutoPostBack="True" 
                        DataSourceID="sdsRouteKindSearch" DataTextField="NAME" DataValueField="CODE">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsRouteKindSearch" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL ROUTE KIND]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'ROUTEKIND')">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="width: 144px">
                    Route Group</td>
                <td>
                    <asp:DropDownList ID="ddlRouteGroupSearch" runat="server" AutoPostBack="True" 
                        DataSourceID="sdsRouteGroupSearch" DataTextField="NAME" DataValueField="CODE">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsRouteGroupSearch" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL ROUTE GROUP]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'ROUTEGROUP')">
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
        <asp:UpdatePanel ID="UPGrid" runat="server">
            <ContentTemplate>
                <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" 
                    AutoGenerateColumns="False" Caption="Route/Trayek List" DataKeyNames="ROUTEID" 
                    DataSourceID="sdsGrid" RowHeaderColumn="ROUTEID" Width="100%">
                    <Columns>
                        <asp:TemplateField HeaderText="SET" SortExpression="ROUTEID">
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                            <ItemTemplate>
                                <img src="../images/edit.gif" style="cursor: pointer" onclick="SetRoute('<%#eval("RouteID")%>', '(<%#eval("RouteNo")%>) <%#eval("RouteName")%>')" alt="SET Route: <%#eval("RouteNo")%>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ROUTEID" HeaderText="ID" ReadOnly="True" 
                            SortExpression="ROUTEID" />
                        <asp:BoundField DataField="ROUTENO" HeaderText="Route&lt;br&gt;No" 
                            HtmlEncode="False" SortExpression="ROUTENO" />
                        <asp:BoundField DataField="ROUTENAME" HeaderText="Route&lt;br&gt;Name" 
                            HtmlEncode="False" SortExpression="ROUTENAME" />
                        <asp:BoundField DataField="ROUTEGROUPNAME" HeaderText="Route&lt;br&gt;Group" 
                            HtmlEncode="False" ReadOnly="True" SortExpression="ROUTEGROUPNAME" />
                        <asp:BoundField DataField="ROUTEKINDNAME" HeaderText="Route&lt;br&gt;Kind" 
                            HtmlEncode="False" SortExpression="ROUTEKINDNAME" />
                        <asp:BoundField DataField="CITYNAME" HeaderText="City" 
                            SortExpression="CITYNAME" />
                    </Columns>
                    <EmptyDataTemplate>
                        <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsGrid" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    SelectCommand="SELECT TOP (500) ROUTE.ROUTEID, CITY.CITYNAME, ROUTE.ROUTENO, ROUTE.ROUTENAME, dbo.f_getParamGlobalName('ROUTEKIND', ROUTE.ROUTEKIND) AS ROUTEKINDNAME, dbo.f_getParamGlobalName('ROUTEGROUP', ROUTE.ROUTEGROUP) AS ROUTEGROUPNAME  FROM CITY WITH (NOLOCK) RIGHT OUTER JOIN ROUTE ON CITY.CITYID = ROUTE.CITYID WHERE (CITY.DELETESTS = 0)">
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
    function SetRoute(RouteID, RouteName) {
        window.opener.SetRoute(RouteID, RouteName);
        window.close()
    }
</script>

</asp:Content>

