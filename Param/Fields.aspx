<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="Fields.aspx.vb" Inherits="Param_Fields" title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    Table Name :
    <asp:DropDownList ID="ddlTableName" runat="server" AutoPostBack="True" DataSourceID="sdsTable"
        DataTextField="TABLENAME" DataValueField="TABLES">
    </asp:DropDownList><asp:SqlDataSource ID="sdsTable" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS TABLES, '[ALL TABLES]' AS TABLENAME UNION ALL SELECT DISTINCT TABLENAME AS TABLES, TABLENAME FROM FIELDS ORDER BY TABLENAME">
    </asp:SqlDataSource>
    <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
        Caption="FIELDS LIST" DataKeyNames="TABLENAME,FIELDNAME" DataSourceID="sdsFields"
        Width="100%">
        <Columns>
            <asp:BoundField DataField="TABLENAME" HeaderText="Table&lt;br&gt;Name" HtmlEncode="False"
                ReadOnly="True" SortExpression="TABLENAME" />
            <asp:BoundField DataField="FIELDNAME" HeaderText="Field&lt;br&gt;Name" HtmlEncode="False"
                ReadOnly="True" SortExpression="FIELDNAME" />
            <asp:TemplateField HeaderText="Field&lt;br&gt;Alias" SortExpression="FIELDALIAS">
                <ItemTemplate>
                    <asp:RequiredFieldValidator ID="reqFieldAlias" runat="server" ControlToValidate="txtFieldAlias"
                        Display="None" ErrorMessage="FIELD ALIAS must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEFieldAlias" runat="server" TargetControlID="reqFieldAlias" HighlightCssClass="ErrHighLight">
                    </ajaxToolkit:ValidatorCalloutExtender>
                    <asp:TextBox ID="txtFieldAlias" runat="server" CssClass="required" Text='<%# Bind("FIELDALIAS") %>'
                        Width="328px"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Mandatory?" SortExpression="MANDATORY">
                <ItemTemplate>
                    <asp:CheckBox ID="cbMandatory" runat="server" Checked='<%# Bind("MANDATORY") %>' />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsFields" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT TABLENAME, FIELDNAME, FIELDALIAS, MANDATORY FROM FIELDS WHERE (FIELDNAME IS NOT NULL)"></asp:SqlDataSource>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEUpdate" runat="server" TargetControlID="pnlUpdate"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
    <asp:Panel ID="pnlUpdate" runat="server" CssClass="FooterStyle" Width="100%">
        <asp:Button ID="btnUpdate" runat="server" Style="background-position: right; background-image: url(../Images/Save.gif);
            cursor: pointer; background-repeat: no-repeat; text-align: left" Text="Update" Width="72px" OnClientClick="return CheckUserSPVFields();" /></asp:Panel>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>")
    function CheckUserSPVFields() {
        var RetVal = window.showModalDialog("../Home/UserLoginSPV.aspx", "SPVAuthor", "dialogWidth:300px;dialogHeight:200px;center:yes;edge:raised;help:no;status:no;");
        if (RetVal.Login == 1)
            return (true);
        else
            return (false);
    }
</script>

</asp:Content>

