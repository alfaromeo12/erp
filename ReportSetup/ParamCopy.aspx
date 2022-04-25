<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ParamCopy.aspx.vb" Inherits="ReportSetup_ParamCopy" title="Copy Parameter(s)" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <ajaxToolkit:textboxwatermarkextender id="ajxTBWESearch" runat="server" targetcontrolid="txtSearch"
        watermarktext="%%">
    </ajaxToolkit:textboxwatermarkextender>
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="100%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Details...)</asp:Label>
        </div>
        <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:collapsiblepanelextender id="ajaxCPEData" runat="server" collapsecontrolid="pnlShow"
        collapsedimage="~/images/expand.jpg" collapsedtext="(Show Detail...)" enabled="True"
        expandcontrolid="pnlShow" expandedimage="~/images/collapse.jpg" expandedtext="(Hide Detail...)"
        imagecontrolid="imgButtonShow" targetcontrolid="pnlData" textlabelid="lblShow">
    </ajaxToolkit:collapsiblepanelextender>
    <asp:Panel ID="pnlData" runat="server">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td style="width: 120px">
                    <asp:DropDownList ID="ddlCriteria" runat="server">
                        <asp:ListItem Value="rptList.ReportName">Report Name</asp:ListItem>
                        <asp:ListItem Value="rptList.FileName">File Name</asp:ListItem>
                        <asp:ListItem Value="rptList.Description">Description</asp:ListItem>
                        <asp:ListItem Value="rptModul.ModulName">Modul Name</asp:ListItem>
                        <asp:ListItem Value="rptModul.ModulCode">Modul Code</asp:ListItem>
                        <asp:ListItem></asp:ListItem>
                    </asp:DropDownList></td>
                <td>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
                        ID="btnFunctionSearch" runat="server" CausesValidation="False" CssClass="Search"
                        Style="font-size: 8pt; border-top-style: outset; border-right-style: outset;
                        border-left-style: outset; border-bottom-style: outset" Text="Search" /></td>
            </tr>
            <tr>
                <td style="width: 120px">
                    Report Modul</td>
                <td>
                    <asp:DropDownList ID="ddlRptModulSearch" runat="server" AutoPostBack="True" DataSourceID="sdsModulSearch"
                        DataTextField="Modul" DataValueField="ModulId">
                    </asp:DropDownList><asp:SqlDataSource ID="sdsModulSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        SelectCommand="SELECT NULL AS ModulId, NULL AS ModulName, '[DISPLAY ALL]' AS Modul UNION ALL SELECT ModulId, ModulName, ModulName + ' (' + ModulCode + ')' AS Modul FROM rptModul ORDER BY ModulName">
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT TOP (700) rptList.ReportId, rptModul.ModulCode, rptModul.ModulName, rptList.ReportName, rptList.FileName, rptList.ReportNo, rptParam.ParamId, rptParam.ParamName, rptParam.Description FROM rptModul INNER JOIN rptList ON rptModul.ModulId = rptList.ModulId INNER JOIN rptParam ON rptList.ReportId = rptParam.ReportId WHERE (rptList.LastUpdate <> - 1)">
    </asp:SqlDataSource>
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
            Caption="Report Parameter(s) List" DataKeyNames="ReportId" DataSourceID="sdsGrid" Width="100%">
            <Columns>
                <asp:TemplateField HeaderText="Copy" SortExpression="ParamId">
                    <ItemTemplate>
                        <img src="../images/edit.gif" onclick='CopyParam(<%#Eval("ParamID")%>)' style="cursor: pointer"  alt="Copy Parameter(s) : <%#Eval("ParamID")%>"/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:TemplateField>
                <asp:BoundField DataField="ModulCode" HeaderText="Modul&lt;BR&gt;Code" HtmlEncode="False"
                    SortExpression="ModulCode" />
                <asp:BoundField DataField="ModulName" HeaderText="Modul&lt;BR&gt;Name" HtmlEncode="False"
                    SortExpression="ModulName" />
                <asp:BoundField DataField="ReportName" HeaderText="Report&lt;BR&gt;Name" HtmlEncode="False"
                    SortExpression="ReportName" />
                <asp:BoundField DataField="ParamName" HeaderText="Param&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="ParamName" />
                <asp:BoundField DataField="Description" HeaderText="Param&lt;br&gt;Description" HtmlEncode="False"
                    SortExpression="Description" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:nodatafound id="NoDataFound1" runat="server">
                </uc6:nodatafound>
            </EmptyDataTemplate>
        </asp:GridView>

<script src="../include/TableHighLight.js" type="text/javascript"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
function CopyParam(ParamID){
    window.opener.CopyParam(ParamID)
    window.close();
}
</script>
</asp:Content>

