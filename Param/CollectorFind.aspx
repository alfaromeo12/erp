<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="CollectorFind.aspx.vb" Inherits="Param_CollectorFind" title="Param : Collector Find" EnableEventValidation="false" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Panel ID="pnlData" runat="server">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td style="width: 144px">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="COLLECTORNAME">COLLECTOR NAME</asp:ListItem>
        <asp:ListItem Value="COLLECTORCODE">COLLECTOR CODE</asp:ListItem>
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
                    Collector Type</td>
                <td>
                    <strong>
                    <asp:DropDownList ID="ddlCollectorType" runat="server" 
                        DataSourceID="sdsCollectorType" DataTextField="NAME" DataValueField="CODE">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsCollectorType" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'COLLECTORTYPE') ORDER BY CODE">
                    </asp:SqlDataSource>
                    </strong>
                </td>
            </tr>
            <tr>
                <td style="width: 144px">
                    Collector Title</td>
                <td>
                    <strong>
                    <asp:DropDownList ID="ddlCollectorTitle" runat="server" 
                        DataSourceID="sdsCollectorTitle" DataTextField="NAME" DataValueField="CODE">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsCollectorTitle" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        
                        SelectCommand="SELECT NULL AS CODE, NULL AS COLLECTORTITLECODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT COLLECTORTITLEID, COLLECTORTITLECODE, '(' + COLLECTORTITLECODE + ') ' + COLLECTORTITLENAME AS NAME FROM COLLECTORTITLE ORDER BY COLLECTORTITLECODE">
                    </asp:SqlDataSource>
                    </strong>
                </td>
            </tr>
        </table>
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
            Caption="Collector List" DataKeyNames="COLLECTORID" DataSourceID="sdsGrid" 
            Width="100%" RowHeaderColumn="COLLECTORID">
            <Columns>
                <asp:TemplateField HeaderText="SET" SortExpression="COLLECTORID">
                    <ItemStyle Width="20px" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <img src="../images/edit.gif" style="cursor: pointer" onclick="SetCollector('<%#eval("COLLECTORID")%>', '(<%#eval("COLLECTORCODE")%>) <%#eval("COLLECTORNAME")%>')" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="COLLECTORID" HeaderText="ID" ReadOnly="True" 
                    SortExpression="COLLECTORID" />
                <asp:BoundField DataField="COLLECTORCODE" HeaderText="Collector&lt;br&gt;Code" 
                    SortExpression="COLLECTORCODE" HtmlEncode="False" />
                <asp:BoundField DataField="COLLECTORNAME" HeaderText="Collector&lt;br&gt;Name" 
                    SortExpression="COLLECTORNAME" HtmlEncode="False" />
                <asp:BoundField DataField="COLLECTORTYPENAME" 
                    HeaderText="Collector&lt;br&gt;Type" SortExpression="COLLECTORTYPENAME" 
                    HtmlEncode="False" />
                <asp:BoundField DataField="COLLECTORTITLENAME" 
                    HeaderText="Collector&lt;br&gt;Title" SortExpression="COLLECTORTITLENAME" 
                    HtmlEncode="False" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            
            
            SelectCommand="SELECT TOP (500) COLLECTOR.COLLECTORID, COLLECTOR.COLLECTORCODE, COLLECTOR.COLLECTORNAME, dbo.f_getParamGlobalName('COLLECTORTYPE', COLLECTOR.COLLECTORTYPE) AS COLLECTORTYPENAME, '(' + COLLECTORTITLE.COLLECTORTITLECODE + ') ' + COLLECTORTITLE.COLLECTORTITLENAME AS COLLECTORTITLENAME FROM COLLECTOR WITH (NOLOCK) LEFT OUTER JOIN COLLECTORTITLE WITH (NOLOCK) ON COLLECTOR.COLLECTORTITLEID = COLLECTORTITLE.COLLECTORTITLEID WHERE (COLLECTOR.Deletests = 0)">
        </asp:SqlDataSource>
    </asp:Panel>
    &nbsp;
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
function SetCollector(CollectorID, CollectorName){
    window.opener.SetCollector(CollectorID, CollectorName);
    window.close()
}
</script>

</asp:Content>

