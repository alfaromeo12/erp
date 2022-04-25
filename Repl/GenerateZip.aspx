<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="GenerateZip.aspx.vb" Inherits="Repl_GenerateZip" title="Generate Zip File" aspcompat="true"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Panel ID="pnlReplicate" runat="server" CssClass="RowStyle">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="HeaderStyle" colspan="2">
                </td>
            </tr>
            <tr>
                <td class="HeaderStyle" colspan="2">
                    &nbsp;</td>
            </tr>
            <tr>
                <td style="width: 171px">
                    File to be replicated</td>
                <td>
                    <asp:DropDownList ID="ddlFile" runat="server" CssClass="required" DataSourceID="sdsFile"
                        DataTextField="FileDesc" DataValueField="FileID">
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqFile" runat="server" ControlToValidate="ddlFile"
                        Display="None" ErrorMessage="File to be Replicated must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCEFile" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqFile">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    <asp:SqlDataSource ID="sdsFile" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        SelectCommand="SELECT NULL AS FILEID, '-[CHOOSE FILE]-' AS FileDesc UNION ALL SELECT FileID, FileDesc FROM MOSTextFile WHERE (FileID NOT IN (31, 32)) ORDER BY FileDesc">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="width: 171px">
                    Replication type</td>
                <td>
                    <asp:DropDownList ID="ddlType" runat="server" CssClass="required" DataSourceID="sdsType"
                        DataTextField="NAME" DataValueField="CODE">
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqType" runat="server" ControlToValidate="ddlType"
                        Display="None" ErrorMessage="Replication Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCEType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqType">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    <asp:SqlDataSource ID="sdsType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        SelectCommand="SELECT NULL AS CODE, '[CHOOSE TYPE]' AS NAME UNION ALL SELECT CODE, NAME FROM PARAMGLOBAL WHERE (TYPE = 'REPLTYPE')">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="width: 171px">
                    Last Update</td>
                <td>
                    <asp:TextBox ID="txtFrom" runat="server" CssClass="required" Width="72px"></asp:TextBox><asp:Image
                        ID="imgFrom" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer"
                        ToolTip="Calendar" />
                    To
                    <asp:TextBox ID="txtTo" runat="server" CssClass="required" Width="72px"></asp:TextBox><asp:Image
                        ID="imgTo" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer" ToolTip="Calendar" /><ajaxToolkit:CalendarExtender
                            ID="ajaxCEFrom" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgFrom" TargetControlID="txtFrom">
                        </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxCETo" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgTo"
                        TargetControlID="txtTo">
                    </ajaxToolkit:CalendarExtender>
                </td>
            </tr>
            <tr>
                <td class="HeaderStyle" colspan="2">
                    <asp:HyperLink ID="HyperLinkFile" runat="server" ToolTip="right click here to download file..!"
                        Visible="False">[HyperLinkFile]</asp:HyperLink></td>
            </tr>
            <tr>
                <td class="HeaderStyle" colspan="2">
                    <asp:Button ID="btnProcess" runat="server" Style="cursor: pointer; background-position: left; background-image: url(../Images/Generate.gif); background-repeat: no-repeat; text-align: right;" Text="Process" /></td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>

