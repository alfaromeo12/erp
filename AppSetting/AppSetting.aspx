<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AppSetting.aspx.vb" Inherits="AppSetting_AppSetting" title="Application Setting" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>

<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="APPCode">Code</asp:ListItem>
        <asp:ListItem Value="APPDesc">Description</asp:ListItem>
        <asp:ListItem Value="APPValue">Value</asp:ListItem>
    </asp:DropDownList><asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /><br />
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajaxTBWESearch" runat="server" TargetControlID="txtSearch" WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajxCPEData" runat="server" CollapseControlID="pnlShow" ExpandControlID="pnlShow" TargetControlID="pnlData" CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Detail...)" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Detail...)" ImageControlID="imgButtonShow" TextLabelID="lblShow">
        </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="100%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)"
                ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Details...)</asp:Label>
        </div>
    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False" /></asp:Panel>
    <asp:Panel ID="pnlData" runat="server">
    <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
        DataKeyNames="APPCODE" DataSourceID="sdsGrid" Width="100%" 
            Caption="Application Setting" RowHeaderColumn="APPCODE">
        <Columns>
            <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True" >
                <ItemStyle Width="20px" HorizontalAlign="Center" />
            </asp:CommandField>
            <asp:BoundField DataField="APPCODE" HeaderText="Code" ReadOnly="True" SortExpression="APPCODE" />
            <asp:BoundField DataField="APPDESC" HeaderText="Description" SortExpression="APPDESC" />
            <asp:BoundField DataField="APPVALUE" HeaderText="Value" SortExpression="APPVALUE" />
        </Columns>
    </asp:GridView>
    </asp:Panel>
    <asp:Label ID="lblError" runat="server" Visible="False" 
        style="text-align: center" Font-Bold="False" Width="100%" CssClass="Error"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblError">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
        <br />
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT APPCODE, APPDESC, APPVALUE FROM APPSETTING WHERE (APPCODE IS NOT NULL)"></asp:SqlDataSource>

    <asp:FormView ID="fvData" runat="server" DataKeyNames="APPCODE" 
        DataSourceID="sdsForm" Width="100%" DefaultMode="Edit">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <th colspan="2" style="height: 35px">
                        <hr />
                        </th>
                </tr>
                <tr>
                    <td>
                        Code</td>
                    <td>
                        <asp:TextBox ID="txtCode" runat="server" MaxLength="20" Text='<%# Bind("APPCODE") %>'
                            Width="136px" ReadOnly="True" CssClass="disabled"></asp:TextBox><asp:RequiredFieldValidator ID="regCode"
                                runat="server" ControlToValidate="txtCode" Display="None" ErrorMessage="Code must be entry..!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCECode" runat="server" TargetControlID="regCode" HighlightCssClass="ErrHighLight">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Value</td>
                    <td>
                        <asp:TextBox ID="txtValue" runat="server" MaxLength="100" Text='<%# Bind("APPVALUE") %>'
                            Width="248px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqValue" runat="server"
                                ControlToValidate="txtValue" Display="None" ErrorMessage="Value must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEValue" runat="server" TargetControlID="reqValue" HighlightCssClass="ErrHighLight">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Description &nbsp; &nbsp;&nbsp;
                    </td>
                    <td>
            <asp:TextBox ID="txtDescription" runat="server" Text='<%# Bind("APPDESC") %>' MaxLength="50" Rows="3" TextMode="MultiLine" Width="200px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                ID="reqDescription" runat="server" ControlToValidate="txtDescription" Display="None"
                ErrorMessage="Description must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEDescription" runat="server" TargetControlID="reqDescription" HighlightCssClass="ErrHighLight">
                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" class="FooterStyle">
                        <uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
                        <uc2:BtnDelete ID="BtnDelete1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr />
                        </td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table cellpadding=0 cellspacing=0 width="600">
                <tr>
                    <th colspan="3">
                        <hr />
                        </th>
                </tr>
                <tr>
                    <td>
                        Code</td>
                    <td colspan="2">
                        <asp:TextBox ID="txtCode" runat="server" MaxLength="20" Text='<%# Bind("APPCODE") %>'
                            Width="136px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="regCode" runat="server"
                                ControlToValidate="txtCode" Display="None" ErrorMessage="Code must be entry..!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCECode" runat="server" TargetControlID="regCode" HighlightCssClass="ErrHighLight">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Value</td>
                    <td colspan="2">
                        <asp:TextBox ID="txtValue" runat="server" MaxLength="100" Text='<%# Bind("APPVALUE") %>'
                            Width="240px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqValue" runat="server"
                                ControlToValidate="txtValue" Display="None" ErrorMessage="Value must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEValue" runat="server" TargetControlID="reqValue" HighlightCssClass="ErrHighLight">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Description &nbsp; &nbsp;&nbsp;
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtDescription" runat="server" MaxLength="50" Rows="3" Text='<%# Bind("APPDESC") %>'
                            TextMode="MultiLine" Width="200px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqDescription"
                                runat="server" ControlToValidate="txtDescription" Display="None" ErrorMessage="Description must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEDescription" runat="server" TargetControlID="reqDescription" HighlightCssClass="ErrHighLight">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="3" class="FooterStyle">
                        <uc4:BtnInsert ID="BtnInsert1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel2" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 35px">
                        <hr />
                        </td>
                </tr>
            </table>
            <br />
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT APPCODE, APPDESC, APPVALUE FROM APPSETTING WHERE (APPCODE = @APPCode)"
         OldValuesParameterFormatString="original_{0}" DeleteCommand="DELETE FROM APPSETTING WHERE (APPCODE = @original_APPCode)" InsertCommand="APPSettingAdd" InsertCommandType="StoredProcedure" UpdateCommand="UPDATE APPSETTING SET APPCODE = @APPCode, APPDESC = @APPDesc, APPVALUE = @APPValue, LASTUSERID = @UserID, LASTUPDATE = GETDATE() WHERE (APPCODE = @original_APPCode)">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="APPCode" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="gvData" Name="original_APPCode" PropertyName="SelectedValue" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="APPCode" />
            <asp:Parameter Name="APPDesc" />
            <asp:Parameter Name="APPValue" />
            <asp:CookieParameter CookieName="UID" Name="UserID" />
            <asp:Parameter Name="original_APPCode" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="APPCode" Type="String" />
            <asp:Parameter Name="APPDesc" Type="String" />
            <asp:Parameter Name="APPValue" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>

<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
</script>

</asp:Content>

