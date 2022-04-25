<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ReportParam.aspx.vb" Inherits="ReportSetup_ReportParam" title="Report Parameter(s)" %>

<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc3" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="100%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Details...)</asp:Label>
        </div>
        <asp:Button ID="btnBack" runat="server" CausesValidation="False" Text="Back To Report List" style="cursor: pointer; background-image: url(../images/back.gif); background-repeat: no-repeat;" /></asp:Panel>
    <ajaxToolkit:collapsiblepanelextender id="ajaxCPEData" runat="server" collapsecontrolid="pnlShow"
        collapsedimage="~/images/expand.jpg" collapsedtext="(Show Detail...)" enabled="True"
        expandcontrolid="pnlShow" expandedimage="~/images/collapse.jpg" expandedtext="(Hide Detail...)"
        imagecontrolid="imgButtonShow" targetcontrolid="pnlData" textlabelid="lblShow">
    </ajaxToolkit:collapsiblepanelextender>
    <asp:Panel ID="pnlData" runat="server" GroupingText="Detail Data">
    <asp:DataList ID="dlReport" runat="server" Caption="Report Info" DataKeyField="ReportId"
        DataSourceID="sdsReport" Width="100%">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        Report
                        ID</td>
                    <td>
                        <asp:Label ID="ReportIdLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ReportId") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Modul</td>
                    <td>
                        (<asp:Label ID="ModulCodeLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ModulCode") %>'></asp:Label>)
                        <asp:Label ID="ModulNameLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ModulName") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Report
                    </td>
                    <td>
                        <asp:Label ID="ReportNameLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ReportName") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        File</td>
                    <td>
                        <asp:Label ID="FileNameLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("FileName") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Description</td>
                    <td>
                        <asp:Label ID="DescriptionLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("Description") %>'></asp:Label></td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList></asp:Panel>
    <asp:SqlDataSource ID="sdsReport" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT rptModul.ModulCode, rptModul.ModulName, rptList.ReportName, rptList.FileName, rptList.Description, rptList.ReportId FROM rptList INNER JOIN rptModul ON rptList.ModulId = rptModul.ModulId WHERE (rptList.ReportId = @ReportID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ReportID" QueryStringField="ReportID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" ToolTip="New Parameter" CausesValidation="False" /><br />
    <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
        DataKeyNames="ParamId" DataSourceID="sdsGrid" Width="100%" Caption="Report Parameter(s)">
        <Columns>
            <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                <ItemStyle Width="20px" />
            </asp:CommandField>
            <asp:TemplateField HeaderText="Param&lt;br&gt;Detail" SortExpression="ParamID">
                <ItemTemplate>
                    <input id="btnEdit" type="button" value="Edit" onclick="ParamDtl('<%#eval("ReportID")%>', '<%#eval("ParamID")%>')" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="30px" />
            </asp:TemplateField>
            <asp:BoundField DataField="ParamName" HeaderText="ParamName" SortExpression="ParamName" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
        </Columns>
        <EmptyDataTemplate>
            <uc1:NoDataFound ID="NoDataFound1" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT ReportId, ParamId, ParamName, Description FROM rptParam WHERE (ReportId = @ReportID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ReportID" QueryStringField="ReportID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:FormView ID="fvData" runat="server" DataKeyNames="ParamId" DataSourceID="sdsForm" DefaultMode="Edit" Width="100%">
        <EditItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        Param ID</td>
                    <td>
                        <asp:Label ID="lblParamID" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ParamId") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Parameter Name</td>
                    <td>
                        <asp:TextBox ID="txtParamName" runat="server" MaxLength="50" Text='<%# Bind("ParamName") %>'
                            Width="248px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqParamName"
                                runat="server" ControlToValidate="txtParamName" CssClass="required" Display="None"
                                ErrorMessage="Parameter Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEParam" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqParamName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Description</td>
                    <td>
                        <asp:TextBox ID="txtDescription" runat="server" Text='<%# Bind("Description") %>'
                            Width="392px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <uc5:BtnUpdate ID="BtnUpdate1" runat="server" />
                        <uc3:BtnDelete ID="BtnDelete1" runat="server" />
                        <uc6:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        Parameter Name</td>
                    <td>
                        <asp:TextBox ID="txtParamName" runat="server" MaxLength="50" Text='<%# Bind("ParamName") %>'
                            Width="248px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqParamName"
                                runat="server" ControlToValidate="txtParamName" CssClass="required" Display="None"
                                ErrorMessage="Parameter Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEParam" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqParamName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Description</td>
                    <td>
                        <asp:TextBox ID="txtDescription" runat="server" Text='<%# Bind("Description") %>'
                            Width="392px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <uc2:BtnInsert ID="BtnInsert1" runat="server" />
                        <uc4:BtnCancelHTML ID="BtnCancelHTML1" runat="server" />
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT ReportId, ParamId, ParamName, Description FROM rptParam WHERE (ParamId = @ParamID)" DeleteCommand="DELETE FROM rptParamDetail WHERE ParamId=@ParamId &#13;&#10;DELETE FROM rptParam WHERE ParamId=@ParamId" InsertCommand="rptParamAdd" InsertCommandType="StoredProcedure" UpdateCommand="UPDATE rptParam SET ReportId = @ReportID, ParamName = @ParamName, Description = @Description, LastUpdate = GETDATE(), LastUserId = @UserID WHERE (ParamId = @ParamID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="ParamID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="ParamId" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:QueryStringParameter Name="ReportID" QueryStringField="ReportID" />
            <asp:Parameter Name="ParamName" />
            <asp:Parameter Name="Description" />
            <asp:CookieParameter CookieName="UID" Name="UserID" />
            <asp:Parameter Name="ParamID" />
        </UpdateParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="ReportID" QueryStringField="ReportID" Type="Int32" />
            <asp:Parameter Name="ParamName" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="ParamID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
function ParamDtl(ReportID, ParamID){
    window.location="ReportParamDtl.aspx?ReportID=" + ReportID + "&ParamID=" + ParamID
}
</script>

</asp:Content>

