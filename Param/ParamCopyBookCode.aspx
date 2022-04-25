<%@ Page Title="Copy - Param Code" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ParamCopyBookCode.aspx.vb" Inherits="Param_ParamCopyBookCode" EnableEventValidation="false" MaintainScrollPositionOnPostback="true" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
<ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="100%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Details...)</asp:Label>
        </div>
        <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Detail...)" Enabled="True"
        ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Detail...)"
        ImageControlID="imgButtonShow" TargetControlID="pnlData" TextLabelID="lblShow">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlData" runat="server">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="FooterStyle">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="BCName">Name</asp:ListItem>
        <asp:ListItem Value="BCCode">Code</asp:ListItem>
    </asp:DropDownList></td>
                <td class="FooterStyle">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /></td>
            </tr>
            <tr>
                <td class="RowStyle">
                    Book Type</td>
                <td class="RowStyle">
                    <asp:DropDownList ID="ddlBTSearch" runat="server" AutoPostBack="True" DataSourceID="sdsBookTypeSearch"
                        DataTextField="BOOKTYPE" DataValueField="BTID">
                    </asp:DropDownList><asp:SqlDataSource ID="sdsBookTypeSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        
                        
                        SelectCommand="SELECT NULL AS BTID, NULL AS BTCODE, '[DISPLAY ALL]' AS BOOKTYPE UNION ALL SELECT BTID, BTCODE, + BTCODE + ' - ' + BTNAME AS BOOKTYPE FROM BOOKTYPE ORDER BY BTCODE">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="AlternatingRowStyle">
                    Used by General Txn</td>
                <td class="AlternatingRowStyle">
                    <asp:DropDownList ID="ddlUsedTxnSearch" runat="server" 
                        DataSourceID="sdsUsedTxnSearch" DataTextField="NAME" DataValueField="CODE">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsUsedTxnSearch" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'YESNO')">
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>

        <br />
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="BCID" DataSourceID="sdsGrid" Width="100%" Caption="Book Code List">
            <Columns>
                <asp:TemplateField HeaderText="Copy" SortExpression="BCID">
                    <ItemTemplate>
                        <img src="../images/edit.gif" onclick='CopyParam(<%#Eval("BCID")%>)' style="cursor: pointer"  alt="Copy Parameter(s) : <%#Eval("BCID")%>"/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:TemplateField>
                <asp:BoundField DataField="BCCODE" HeaderText="Code" SortExpression="BCCODE" />
                <asp:BoundField DataField="BCNAME" HeaderText="Name" SortExpression="BCNAME" />
                <asp:BoundField DataField="BOOKTYPE" HeaderText="Book&lt;br&gt;Type" HtmlEncode="False"
                    ReadOnly="True" SortExpression="BOOKTYPE" />
                <asp:BoundField DataField="JOURNALTYPE" HeaderText="Journal&lt;br&gt;Type" HtmlEncode="False"
                    ReadOnly="True" SortExpression="JOURNALTYPE" />
                <asp:BoundField DataField="TXNTYPE" HeaderText="Txn&lt;br&gt;Type" HtmlEncode="False"
                    ReadOnly="True" SortExpression="TXNTYPE" />
                <asp:BoundField DataField="USEDTXN" HeaderText="General&lt;br&gt;Txn?" 
                    HtmlEncode="False" SortExpression="USEDTXN" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT BOOKCODE.BTID, BOOKCODE.BCCODE, BOOKCODE.BCNAME, '(' + BOOKTYPE.BTCODE + ') ' + BOOKTYPE.BTNAME AS BOOKTYPE, '(' + PARAMGLOBAL.CODE + ') ' + PARAMGLOBAL.NAME AS JOURNALTYPE, '(' + PARAMGLOBAL_1.CODE + ') ' + PARAMGLOBAL_1.NAME AS TXNTYPE, BOOKCODE.BCID, dbo.f_getParamGlobalName('YESNO', CAST(BOOKCODE.USEDTXN AS INT)) AS USEDTXN FROM BOOKTYPE WITH (NOLOCK) INNER JOIN BOOKCODE WITH (NOLOCK) ON BOOKTYPE.BTID = BOOKCODE.BTID INNER JOIN PARAMGLOBAL ON BOOKCODE.JOURNALTYPE = PARAMGLOBAL.CODE AND PARAMGLOBAL.TYPE = 'JOURNALTYPE' INNER JOIN PARAMGLOBAL AS PARAMGLOBAL_1 ON BOOKCODE.TXNTYPE = PARAMGLOBAL_1.CODE AND PARAMGLOBAL_1.TYPE = 'JOURNALTXNTYPE' WHERE (BOOKTYPE.BTID IS NOT NULL)"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
<script src="../include/TableHighLight.js" type="text/javascript"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>")
    function CopyParam(BCID) {
        window.opener.CopyParam(BCID)
        window.close();
    }
</script>
</asp:Content>

