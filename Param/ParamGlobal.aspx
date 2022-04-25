<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ParamGlobal.aspx.vb" Inherits="Param_ParamGlobal" title="Param Global" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="TYPE">TYPE</asp:ListItem>
        <asp:ListItem Value="CODE">CODE</asp:ListItem>
        <asp:ListItem>NAME</asp:ListItem>
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
        Type :
        <asp:DropDownList ID="ddlType" runat="server" AutoPostBack="True" DataSourceID="sdsType"
            DataTextField="TYPENAME" DataValueField="TYPE">
        </asp:DropDownList><br />
    <asp:SqlDataSource ID="sdsType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS TYPE, 'ALL TYPE' AS TYPENAME UNION ALL SELECT DISTINCT TYPE, TYPE AS TYPENAME FROM PARAMGLOBAL">
    </asp:SqlDataSource>
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="TYPE,CODE" 
            DataSourceID="sdsGrid" Width="600px" Caption="Global Parameter List" 
            RowHeaderColumn="TYPE">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="20px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="TYPE" HeaderText="TYPE" ReadOnly="True" SortExpression="TYPE" />
                <asp:BoundField DataField="CODE" HeaderText="CODE" ReadOnly="True" SortExpression="CODE" />
                <asp:BoundField DataField="NAME" HeaderText="NAME" SortExpression="NAME" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT TYPE, CODE, NAME FROM PARAMGLOBAL WHERE (TYPE IS NOT NULL)"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="600px" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>

    <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="600px" DataKeyNames="TYPE,CODE">
        <EditItemTemplate>
            <table cellpadding="0" cellspacing="0" width="600">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Type</td>
                    <td>
                        <asp:TextBox ID="txtType" runat="server" Text='<%# Bind("TYPE") %>' MaxLength="30" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="regType" runat="server" ControlToValidate="txtType" Display="None" ErrorMessage="Type must be entry..!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="regType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Code</td>
                    <td>
                        <asp:TextBox ID="txtCode" runat="server" Width="88px" Text='<%# Bind("CODE") %>' MaxLength="20" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtCode" Display="None" ErrorMessage="Code must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Name</td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("NAME") %>' Width="304px" MaxLength="80" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtName" Display="None" ErrorMessage="Name must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 19px">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" class="FooterStyle">
                        &nbsp;<uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
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
            <table cellpadding="0" cellspacing="0" width="600">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Type</td>
                    <td>
                        <asp:TextBox ID="txtType" runat="server" MaxLength="30" Text='<%# Bind("TYPE") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="regType" runat="server" ControlToValidate="txtType" Display="None" ErrorMessage="Type must be entry..!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="regType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Code</td>
                    <td>
                        <asp:TextBox ID="txtCode" runat="server" MaxLength="20" Text='<%# Bind("CODE") %>'
                            Width="88px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqCode"
                                runat="server" ControlToValidate="txtCode" Display="None" ErrorMessage="Code must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Name</td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" MaxLength="80" Text='<%# Bind("NAME") %>'
                            Width="304px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqName"
                                runat="server" ControlToValidate="txtName" Display="None" ErrorMessage="Name must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 19px">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" class="FooterStyle">
                        <uc4:BtnInsert ID="BtnInsert1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel2" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr />
                        </td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT TYPE, CODE, NAME FROM PARAMGLOBAL WHERE (TYPE = @Type) AND (CODE = @Code)" DeleteCommand="DELETE PARAMGLOBAL WHERE TYPE=@original_TYPE AND CODE=@original_CODE" UpdateCommand="UPDATE PARAMGLOBAL SET &#13;&#10;TYPE=@Type, CODE=@Code, NAME = @Name, LastUserId=@UserID, LastUpdate=getdate() WHERE TYPE=@original_TYPE AND CODE=@original_CODE" InsertCommand="ParamGlobalAdd" InsertCommandType="StoredProcedure" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="Type" PropertyName="SelectedDataKey.Values[0]" />
            <asp:ControlParameter ControlID="gvData" Name="Code" PropertyName="SelectedDataKey.Values[1]" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="original_TYPE" />
            <asp:Parameter Name="original_CODE" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Type" />
            <asp:Parameter Name="Code" />
            <asp:Parameter Name="Name" />
            <asp:CookieParameter CookieName="UID" Name="UserID" />
            <asp:Parameter Name="original_TYPE" />
            <asp:Parameter Name="original_CODE" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Type" Type="String" />
            <asp:Parameter Name="Code" Type="String" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
</script>

</asp:Content>

