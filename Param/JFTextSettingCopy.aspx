<%@ Page Title="JF Text Setting Copy" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="JFTextSettingCopy.aspx.vb" Inherits="Param_JFTextSettingCopy" %>

<%@ Register src="../UserControl/NoDataFound.ascx" tagname="nodatafound" tagprefix="uc6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="FooterStyle">
                <asp:DropDownList ID="ddlCriteria" runat="server">
                    <asp:ListItem Value="JFNAME">JF NAME</asp:ListItem>
                    <asp:ListItem Value="JFCODE">JF CODE</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="FooterStyle">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox>
                <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
                </ajaxToolkit:TextBoxWatermarkExtender>
                <asp:Button ID="btnFunctionSearch" runat="server" Text="Search" CausesValidation="False" CssClass="Search" />
            </td>
        </tr>
        <tr>
            <td class="AlternatingRowStyle">
                JF Group</td>
            <td class="AlternatingRowStyle">
                <asp:DropDownList ID="ddlJFGroupSearch" runat="server" DataSourceID="sdsJFGroupSearch"
        DataTextField="JFGROUPNAME" DataValueField="JFGROUPID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsJFGroupSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
                    SelectCommand="SELECT NULL AS JFGROUPID, NULL AS JFGROUPCODE, '[DISPLAY ALL]' AS JFGROUPNAME UNION ALL SELECT JFGROUPID, JFGROUPCODE, JFGROUPCODE + ' - ' + JFGROUPNAME AS JFGROUPNAME FROM JFGROUP WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY JFGROUPCODE">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="AlternatingRowStyle">
                    Bank</td>
            <td class="AlternatingRowStyle">
                <asp:DropDownList ID="ddlBankSearch" runat="server"  DataSourceID="sdsBankSearch"
                    DataTextField="BANKNAME" DataValueField="BANKID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsBankSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
                        
                        SelectCommand="SELECT NULL AS BANKID, NULL AS BANKCODE, '[DISPLAY ALL]' AS BANKNAME UNION ALL SELECT BANKID, BANKCODE, BANKCODE + ' -  ' + BANKNAME AS BANKNAME FROM BANK WITH (NOLOCK) ORDER BY BANKCODE">
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" 
        Caption="JF Copy Text Setting" DataKeyNames="JFID"
            DataSourceID="sdsGrid" RowHeaderColumn="JFID" Width="100%">
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <img src="../Images/edit.gif" style="cursor: pointer" alt='Text Setting : <%#eval("JFID")%>' onclick="return JFSetCopySetting(<%#eval("JFID")%>)" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:TemplateField>
                <asp:BoundField DataField="JFGROUPNAME" HeaderText="JF&lt;br&gt;Group" HtmlEncode="False"
                    ReadOnly="True" SortExpression="JFGROUPNAME" />
                <asp:BoundField DataField="JFCODE" HeaderText="JF&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="JFCODE" />
                <asp:BoundField DataField="JFNAME" HeaderText="JF&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="JFNAME" />
                <asp:BoundField DataField="JFPKSNO" HeaderText="PKS&lt;br&gt;No." HtmlEncode="False"
                    SortExpression="JFPKSNO" />
                <asp:BoundField DataField="JFPKSDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="PKS&lt;br&gt;Date"
                    HtmlEncode="False" SortExpression="JFPKSDATE">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="JFMIRRORSTATUSNAME" HeaderText="Mirror&lt;br&gt;Status"
                    HtmlEncode="False" ReadOnly="True" SortExpression="JFMIRRORSTATUSNAME" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT JF_1.JFID, JF_1.JFCODE, JF_1.JFNAME, JF_1.JFPKSNO, JF_1.JFPKSDATE, '(' + CAST(JF_1.JFMIRRORSTATUS AS VARCHAR(10)) + ') ' + dbo.f_getParamGlobalName('JFMIRRORSTATUS', JF_1.JFMIRRORSTATUS) AS JFMIRRORSTATUSNAME, '(' + JFGROUP.JFGROUPCODE + ') ' + JFGROUP.JFGROUPNAME AS JFGROUPNAME FROM JF AS JF_1 WITH (NOLOCK) INNER JOIN JFGROUP WITH (NOLOCK) ON JF_1.JFGROUPID = JFGROUP.JFGROUPID WHERE (JF_1.Deletests = 0) AND EXISTS (SELECT 'x' AS Expr1 FROM MOSTextSettingJF WHERE (JoinFinanceID = JF_1.JFID))">
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
    function JFSetCopySetting(JFID) {
        if (confirm("Are you sure want to copy Text setting..?")) {
            window.opener.JFSetCopySetting(JFID)
            window.close();
        }
    }
</script>
    </asp:Content>

