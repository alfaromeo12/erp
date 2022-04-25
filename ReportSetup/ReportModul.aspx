<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ReportModul.aspx.vb" Inherits="RptSetup_ReportModule" title="Report Module" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="ModulName">Modul Name</asp:ListItem>
        <asp:ListItem Value="ModulCode">Modul Code</asp:ListItem>
    </asp:DropDownList><asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /><br />

    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False" /><br />
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="600px">
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
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="ModulId" DataSourceID="sdsGrid" Width="600px" Caption="Report Modul">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="20px" />
                </asp:CommandField>
                <asp:TemplateField HeaderText="Report" SortExpression="ModulID">
                    <ItemTemplate>
                        <input id="btnReport" type="button" value="Edit" onclick="EditReport('<%#eval("ModulID")%>')" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="40px" />
                </asp:TemplateField>
                <asp:BoundField DataField="ModulCode" HeaderText="Modul&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="ModulCode" />
                <asp:BoundField DataField="ModulName" HeaderText="Modul&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="ModulName" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT ModulId, ModulCode, ModulName FROM rptModul WHERE (ModulId &lt;&gt; - 1)"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="600px" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblError">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>

    <asp:FormView ID="fvData" runat="server" DataKeyNames="ModulId" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="600px">
        <EditItemTemplate><table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                    ID</td>
                <td>
                    <asp:Label ID="lblModulID" runat="server" Font-Bold="True" Font-Underline="True"
                        Text='<%# Eval("ModulId") %>'></asp:Label></td>
            </tr>
            <tr>
                <td>
                    Code</td>
                <td>
                    <asp:TextBox ID="txtModulCode" runat="server" MaxLength="20" Text='<%# Bind("ModulCode") %>'
                        Width="104px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqCode"
                            runat="server" ControlToValidate="txtModulCode" Display="None" ErrorMessage="Modul Code must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Name</td>
                <td>
                    <asp:TextBox ID="txtModuleName" runat="server" MaxLength="100" Text='<%# Bind("ModulName") %>'
                        Width="296px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqName"
                            runat="server" ControlToValidate="txtModuleName" Display="None" ErrorMessage="Modul Name must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
                    <uc2:BtnDelete ID="BtnDelete1" runat="server" />
                    <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                </td>
            </tr>
        </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        Code</td>
                    <td>
                        <asp:TextBox ID="txtModulCode" runat="server" MaxLength="20" Text='<%# Bind("ModulCode") %>'
                            Width="104px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqCode"
                                runat="server" ControlToValidate="txtModulCode" Display="None" ErrorMessage="Modul Code must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Name</td>
                    <td>
                        <asp:TextBox ID="txtModuleName" runat="server" MaxLength="100" Text='<%# Bind("ModulName") %>'
                            Width="296px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqName"
                                runat="server" ControlToValidate="txtModuleName" Display="None" ErrorMessage="Modul Name must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <uc4:BtnInsert ID="BtnInsert1" runat="server" />
                        <uc5:BtnCancelHTML ID="BtnCancelHTML1" runat="server" />
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT ModulId, ModulCode, ModulName FROM rptModul&#13;&#10;WHERE ModulId=@ModulId" DeleteCommand="DELETE rptList WHERE ModulID=@ModulID&#13;&#10;DELETE rptModul WHERE ModulID=@ModulID" UpdateCommand="rptModulUpdate" InsertCommand="rptModulAdd" InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="ModulId" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="ModulID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ModulID" Type="Int32" />
            <asp:Parameter Name="ModulCode" Type="String" />
            <asp:Parameter Name="ModulName" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="ModulCode" Type="String" />
            <asp:Parameter Name="ModulName" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="ModulID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>

<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
function EditReport(ModulID){
    window.location="Report.aspx?ModulID=" + ModulID;
}
</script>
</asp:Content>

