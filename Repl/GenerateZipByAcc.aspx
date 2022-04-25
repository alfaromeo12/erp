<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="GenerateZipByAcc.aspx.vb" Inherits="Repl_GenerateZipbyAcc" title="Generate Zip File by Acc ID" aspcompat="true"%>
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
                        SelectCommand="SELECT FileID, FileDesc FROM MOSTextFile WHERE (FileID = 31) ORDER BY FileDesc">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="width: 171px">
                    Location ID (Loc ID)</td>
                <td>
                    <asp:TextBox ID="txtLocID" runat="server" CssClass="required" Width="40px"></asp:TextBox><asp:RequiredFieldValidator
                        ID="reqLocID" runat="server" ControlToValidate="txtLocID" Display="None" ErrorMessage="Location ID must be entry...!"
                        SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCELocID" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqLocID">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td style="width: 171px">
                    Account ID (Acc ID)</td>
                <td>
                    <asp:TextBox ID="txtAccID" runat="server" CssClass="required" Width="72px"></asp:TextBox><asp:RequiredFieldValidator
                        ID="reqAccID" runat="server" ControlToValidate="txtAccID" Display="None" ErrorMessage="Account ID mut be entry...!"
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCEAccID" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAccID">
                    </ajaxToolkit:ValidatorCalloutExtender>
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

