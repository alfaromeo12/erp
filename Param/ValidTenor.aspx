<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ValidTenor.aspx.vb" Inherits="Param_ValidTenor" title="Tenor Scheme" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="TENORNAME">Tenor Name</asp:ListItem>
        <asp:ListItem Value="DESCRIPTION">Description</asp:ListItem>
    </asp:DropDownList><asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /><br />

    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False" CssClass="New" /><br />
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
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="100%" DataKeyNames="TENORID" Caption="Tenor Scheme List">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/edit.gif" ShowSelectButton="True">
                    <ItemStyle HorizontalAlign="Center" Width="30px" />
                </asp:CommandField>
                <asp:TemplateField HeaderText="EX">
                    <ItemTemplate>
                        <img alt="Exception : <%#eval("TENORID")%>" src="../Images/except.gif" style="cursor: pointer" onclick="Exception(<%#eval("TENORID")%>)" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="30px" />
                </asp:TemplateField>
                <asp:BoundField DataField="TENORID" HeaderText="ID" ReadOnly="True" SortExpression="TENORID">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="TENORNAME" HeaderText="Name" SortExpression="TENORNAME" />
                <asp:BoundField DataField="MINTENORNEW" HeaderText="Min Tenor&lt;br&gt;New Object"
                    HtmlEncode="False" SortExpression="MINTENORNEW">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="MAXTENORNEW" HeaderText="Max Tenor&lt;br&gt;New Object"
                    HtmlEncode="False" SortExpression="MAXTENORNEW">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="MINTENORUSED" HeaderText="Min Tenor&lt;br&gt;Used Object"
                    HtmlEncode="False" SortExpression="MINTENORUSED">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="MAXTENORUSED" HeaderText="Max Tenor&lt;br&gt;Used Object"
                    HtmlEncode="False" SortExpression="MAXTENORUSED">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="DESCRIPTION" HeaderText="Description" SortExpression="DESCRIPTION" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT TENORID, TENORNAME, DESCRIPTION, MINTENORNEW, MAXTENORNEW, MINTENORUSED, MAXTENORUSED FROM VALIDTENOR WHERE (Deletests = 0)"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>

    <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%" DataKeyNames="TENORID">
        <EditItemTemplate><table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td style="height: 19px">
                    Name</td>
                <td style="height: 19px">
                    <asp:TextBox ID="TENORNAMETextBox" runat="server" CssClass="required" MaxLength="50"
                        Text='<%# Bind("TENORNAME") %>'></asp:TextBox><asp:RequiredFieldValidator ID="reqName"
                            runat="server" ControlToValidate="TENORNAMETextBox" Display="None" ErrorMessage="[TENOR NAME] must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Description</td>
                <td>
                    <asp:TextBox ID="DESCRIPTIONTextBox" runat="server" MaxLength="100" Text='<%# Bind("DESCRIPTION") %>'
                        Width="392px"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="ShowDetail" colspan="2">
                    <span>DEFAULT VALUES</span></td>
            </tr>
            <tr>
                <td colspan="2" class="FooterStyle">
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td class="HeaderStyle">
                                Condition</td>
                            <td class="HeaderStyle">
                                Minimum Tenor</td>
                            <td class="HeaderStyle">
                                Maximum Tenor</td>
                        </tr>
                        <tr>
                            <td class="RowStyle">
                                New Object</td>
                            <td class="RowStyle">
                                <asp:TextBox ID="MINTENORNEWTextBox" runat="server" CssClass="required" Style="text-align: right"
                                    Text='<%# Bind("MINTENORNEW") %>' Width="72px"></asp:TextBox><asp:RequiredFieldValidator
                                        ID="reqMinTenorNew" runat="server" ControlToValidate="MINTENORNEWTextBox" Display="None"
                                        ErrorMessage="[MIN TENOR NEW] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                                ID="ajaxVCEMinTenorNew" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinTenorNew">
                                        </ajaxToolkit:ValidatorCalloutExtender>
                            </td>
                            <td class="RowStyle">
                                <asp:TextBox ID="MAXTENORNEWTextBox" runat="server" CssClass="required" Style="text-align: right"
                                    Text='<%# Bind("MAXTENORNEW") %>' Width="72px"></asp:TextBox><asp:RequiredFieldValidator
                                        ID="reqMaxTenorNew" runat="server" ControlToValidate="MAXTENORNEWTextBox" Display="None"
                                        ErrorMessage="[MAX TENOR NEW] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                                ID="ajaxVCEMaxTenorNew" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxTenorNew">
                                        </ajaxToolkit:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr>
                            <td class="AlternatingRowStyle">
                                Used Object</td>
                            <td class="AlternatingRowStyle">
                                <asp:TextBox ID="MINTENORUSEDTextBox" runat="server" CssClass="required" Style="text-align: right"
                                    Text='<%# Bind("MINTENORUSED") %>' Width="72px"></asp:TextBox><asp:RequiredFieldValidator
                                        ID="reqMinTenorUsed" runat="server" ControlToValidate="MINTENORUSEDTextBox" Display="None"
                                        ErrorMessage="[MIN TENOR USED] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                                ID="ajaxVCEMinTenorUsed" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinTenorUsed">
                                        </ajaxToolkit:ValidatorCalloutExtender>
                            </td>
                            <td class="AlternatingRowStyle">
                                <asp:TextBox ID="MAXTENORUSEDTextBox" runat="server" CssClass="required" Style="text-align: right"
                                    Text='<%# Bind("MAXTENORUSED") %>' Width="72px"></asp:TextBox><asp:RequiredFieldValidator
                                        ID="reqMaxTenorUsed" runat="server" ControlToValidate="MAXTENORUSEDTextBox" Display="None"
                                        ErrorMessage="[MAX TENOR USED] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                                ID="ajaxVCEMaxTenorUsed" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxTenorUsed">
                                        </ajaxToolkit:ValidatorCalloutExtender>
                            </td>
                        </tr>
                    </table>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                </td>
            </tr>
        </table>
            <br />
            <uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
            <uc2:BtnDelete ID="BtnDelete1" runat="server" />
            <uc3:BtnCancel ID="BtnCancel2" runat="server" />
        </EditItemTemplate>
        <InsertItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td style="height: 19px">
                        Name</td>
                    <td style="height: 19px">
                        <asp:TextBox ID="TENORNAMETextBox" runat="server" CssClass="required" MaxLength="50"
                            Text='<%# Bind("TENORNAME") %>'></asp:TextBox><asp:RequiredFieldValidator ID="reqName"
                                runat="server" ControlToValidate="TENORNAMETextBox" Display="None" ErrorMessage="[TENOR NAME] must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Description</td>
                    <td>
                        <asp:TextBox ID="DESCRIPTIONTextBox" runat="server" MaxLength="100" Text='<%# Bind("DESCRIPTION") %>'
                            Width="392px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="ShowDetail" colspan="2">
                        <strong><span style="text-decoration: underline">DEFAULT VALUES</span></strong></td>
                </tr>
                <tr>
                    <td colspan="2" class="FooterStyle">
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td class="HeaderStyle">
                                    Condition</td>
                                <td class="HeaderStyle">
                                    Minimum Tenor</td>
                                <td class="HeaderStyle">
                                    Maximum Tenor</td>
                            </tr>
                            <tr>
                                <td class="RowStyle">
                                    New Object</td>
                                <td class="RowStyle">
                                    <asp:TextBox ID="MINTENORNEWTextBox" runat="server" CssClass="required" Style="text-align: right"
                                        Text='<%# Bind("MINTENORNEW") %>' Width="72px"></asp:TextBox><asp:RequiredFieldValidator
                                            ID="reqMinTenorNew" runat="server" ControlToValidate="MINTENORNEWTextBox" Display="None"
                                            ErrorMessage="[MIN TENOR NEW] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                                ID="ajaxVCEMinTenorNew" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinTenorNew">
                                            </ajaxToolkit:ValidatorCalloutExtender>
                                </td>
                                <td class="RowStyle">
                                    <asp:TextBox ID="MAXTENORNEWTextBox" runat="server" CssClass="required" Style="text-align: right"
                                        Text='<%# Bind("MAXTENORNEW") %>' Width="72px"></asp:TextBox>%<asp:RequiredFieldValidator
                                            ID="reqMaxTenorNew" runat="server" ControlToValidate="MAXTENORNEWTextBox" Display="None"
                                            ErrorMessage="[MAX TENOR NEW] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                                ID="ajaxVCEMaxTenorNew" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxTenorNew">
                                            </ajaxToolkit:ValidatorCalloutExtender>
                                </td>
                            </tr>
                            <tr>
                                <td class="AlternatingRowStyle">
                                    Used Object</td>
                                <td class="AlternatingRowStyle">
                                    <asp:TextBox ID="MINTENORUSEDTextBox" runat="server" CssClass="required" Style="text-align: right"
                                        Text='<%# Bind("MINTENORUSED") %>' Width="72px"></asp:TextBox><asp:RequiredFieldValidator
                                            ID="reqMinTenorUsed" runat="server" ControlToValidate="MINTENORUSEDTextBox" Display="None"
                                            ErrorMessage="[MIN TENOR USED] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                                ID="ajaxVCEMinTenorUsed" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinTenorUsed">
                                            </ajaxToolkit:ValidatorCalloutExtender>
                                </td>
                                <td class="AlternatingRowStyle">
                                    <asp:TextBox ID="MAXTENORUSEDTextBox" runat="server" CssClass="required" Style="text-align: right"
                                        Text='<%# Bind("MAXTENORUSED") %>' Width="72px"></asp:TextBox><asp:RequiredFieldValidator
                                            ID="reqMaxTenorUsed" runat="server" ControlToValidate="MAXTENORUSEDTextBox" Display="None"
                                            ErrorMessage="[MAX TENOR USED] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                                ID="ajaxVCEMaxTenorUsed" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxTenorUsed">
                                            </ajaxToolkit:ValidatorCalloutExtender>
                                </td>
                            </tr>
                        </table>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
            <br />
            <uc4:BtnInsert ID="BtnInsert1" runat="server" />
            <uc3:BtnCancel ID="BtnCancel1" runat="server" />
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT TENORID, TENORNAME, DESCRIPTION, MINTENORNEW, MAXTENORNEW, MINTENORUSED, MAXTENORUSED FROM VALIDTENOR WHERE (TENORID = @TENORID)" DeleteCommand="VALIDTENORDELETE" UpdateCommand="VALIDTENORUPDATE" InsertCommand="VALIDTENORADD" InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="TENORID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="TENORID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="TENORID" Type="Int32" />
            <asp:Parameter Name="TENORNAME" Type="String" />
            <asp:Parameter Name="DESCRIPTION" Type="String" />
            <asp:Parameter Name="MINTENORNEW" Type="Double" />
            <asp:Parameter Name="MAXTENORNEW" Type="Double" />
            <asp:Parameter Name="MINTENORUSED" Type="Double" />
            <asp:Parameter Name="MAXTENORUSED" Type="Double" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="TENORNAME" Type="String" />
            <asp:Parameter Name="DESCRIPTION" Type="String" />
            <asp:Parameter Name="MINTENORNEW" Type="Double" />
            <asp:Parameter Name="MAXTENORNEW" Type="Double" />
            <asp:Parameter Name="MINTENORUSED" Type="Double" />
            <asp:Parameter Name="MAXTENORUSED" Type="Double" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
window.onload=function(){
    TabToEnter();
}
function Exception(ID){
    var winref = window.open("../Param/ValidTenorAge.aspx?Action=Edit&ID=" + ID, "TENOREXCEPT", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes");
    winref.focus();
}

</script>

</asp:Content>

