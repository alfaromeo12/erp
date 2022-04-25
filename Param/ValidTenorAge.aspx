<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ValidTenorAge.aspx.vb" Inherits="Param_ValidTenorAge" title="Valid Tenor - Vehicle Age" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc5" %>

<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">


    <asp:DataList ID="dlValidTenor" runat="server" Caption="TENOR SCHEME - Default Values"
        DataKeyField="TENORID" DataSourceID="sdsValidTenor" Width="100%">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        TENOR ID</td>
                    <td>
                        <asp:Label ID="lblTenorID" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("TENORID") %>'></asp:Label></td>
                </tr>
                <tr >
                    <td style="width: 96px">
                        Name</td>
                    <td>
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("TENORNAME") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 96px">
                        Description</td>
                    <td>
                        <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("DESCRIPTION") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="ShowDetail" colspan="2">
                        DEFAULT VALUES</td>
                </tr>
                <tr>
                    <td class="FooterStyle" colspan="2">
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td class="HeaderStyle">
                                    Condition</td>
                                <td class="HeaderStyle">
                                    Minimum<br />
                                    Tenor</td>
                                <td class="HeaderStyle">
                                    Maximum<br />
                                    Tenor</td>
                            </tr>
                            <tr>
                                <td class="RowStyle">
                                    New Vehicle</td>
                                <td class="RowStyle">
                                    <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("MINTENORNEW") %>'></asp:Label>
                                    month(s)</td>
                                <td class="RowStyle">
                                    <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("MAXTENORNEW") %>'></asp:Label>
                                    month(s)</td>
                            </tr>
                            <tr>
                                <td class="AlternatingRowStyle">
                                    Used Vehicle</td>
                                <td class="AlternatingRowStyle">
                                    <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("MINTENORUSED") %>'></asp:Label>
                                    month(s)</td>
                                <td class="AlternatingRowStyle">
                                    <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("MAXTENORUSED") %>'></asp:Label>
                                    month(s)</td>
                            </tr>
                        </table>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td style="width: 96px">
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList><asp:SqlDataSource ID="sdsValidTenor" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT TENORID, TENORNAME, DESCRIPTION, MINTENORNEW, MAXTENORNEW, MINTENORUSED, MAXTENORUSED FROM VALIDTENOR WHERE (TENORID = @TENORID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="TENORID" QueryStringField="ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ImageButton ID="imgBtnNew" runat="server" CausesValidation="False" CssClass="New"
        ImageUrl="~/images/add.gif" />
    <asp:GridView ID="gvValidTenorAge" runat="server" AutoGenerateColumns="False"
        Caption="TENOR SCHEME - Exception" DataKeyNames="ID" DataSourceID="sdsValidTenorAge"
        Width="100%" AllowPaging="True" AllowSorting="True">
        <Columns>
            <asp:CommandField ButtonType="Image" EditImageUrl="~/Images/delete.gif" SelectImageUrl="~/Images/edit.gif"
                ShowSelectButton="True">
                <ItemStyle HorizontalAlign="Center" Width="25px" />
            </asp:CommandField>
            <asp:TemplateField HeaderText="DEL" ShowHeader="False">
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandName="Delete"
                        ImageUrl="~/Images/delete.gif" Text="Delete" OnClientClick="return confirm('Are you sure want to delete data..?')" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="25px" />
            </asp:TemplateField>
            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="CONDITIONNAME" HeaderText="Condition" ReadOnly="True"
                SortExpression="CONDITIONNAME" />
            <asp:BoundField DataField="MINTENOR" HeaderText="Min&lt;br&gt;Tenor&lt;br&gt;(months)"
                HtmlEncode="False" SortExpression="MINTENOR">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="MAXTENOR" HeaderText="Max&lt;br&gt;Tenor&lt;br&gt;(months)"
                HtmlEncode="False" SortExpression="MAXTENOR">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="MINCARAGE" HeaderText="Min&lt;br&gt;Car Age&lt;br&gt;(months)"
                HtmlEncode="False" SortExpression="MINCARAGE">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="MAXCARAGE" HeaderText="Max&lt;br&gt;Car Age&lt;br&gt;(months)"
                HtmlEncode="False" SortExpression="MAXCARAGE">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            <uc1:NoDataFound ID="NoDataFound1" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsValidTenorAge" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT ID, TENORID, MINTENOR, MAXTENOR, MINCARAGE, MAXCARAGE, '(' + CAST(CONDITION AS VARCHAR(20)) + ') ' + dbo.f_getParamGlobalName('CONDITION', CONDITION) AS CONDITIONNAME FROM VALIDTENORAGE WHERE (TENORID = @TENORID) AND (Deletests = 0)" DeleteCommand="VALIDTENORAGEDELETE" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="TENORID" QueryStringField="ID" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:FormView ID="fvTenorAge" runat="server" DataKeyNames="ID" DataSourceID="sdsTenorAgeEdit" Caption="TENOR SCHEME - VEHICLE AGE" Width="100%" DefaultMode="Edit">
        <EditItemTemplate><table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                    ID</td>
                <td colspan="3">
                    <asp:Label ID="lblID" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("ID") %>'></asp:Label></td>
            </tr>
            <tr>
                <td>
                    Condition</td>
                <td colspan="3">
                    <asp:DropDownList ID="ddlCondition" runat="server" CssClass="required" DataSourceID="sdsCondition"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("CONDITION") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqCondition" runat="server" ControlToValidate="ddlCondition"
                        Display="None" ErrorMessage="[CONDITION] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECondition" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCondition">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    <asp:SqlDataSource ID="sdsCondition" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                            SelectCommand="SELECT NULL AS CODE, '[CONDITION]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'CONDITION')">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="HeaderStyle" colspan="4">
                    TENOR</td>
            </tr>
            <tr>
                <td>
                    Min</td>
                <td>
                    <asp:TextBox ID="MINTENORTextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("MINTENOR") %>' Width="64px"></asp:TextBox>
                    month(s)<asp:RequiredFieldValidator ID="reqMinTenor" runat="server" ControlToValidate="MINTENORTextBox"
                        Display="None" ErrorMessage="[MINIMUM TENOR] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEMinTenor" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinTenor">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Max</td>
                <td>
                    <asp:TextBox ID="MAXTENORTextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("MAXTENOR") %>' Width="72px"></asp:TextBox>
                    month(s)<asp:RequiredFieldValidator ID="reqMaxTenor" runat="server" ControlToValidate="MAXTENORTextBox"
                        Display="None" ErrorMessage="[MAXIMUM TENOR] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEMaxTenor" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxTenor">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="HeaderStyle" colspan="4">
                    CAR (VEHICLE) AGE</td>
            </tr>
            <tr>
                <td>
                    Min</td>
                <td>
                    <asp:TextBox ID="MINAGETextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("MINCARAGE") %>' Width="64px"></asp:TextBox>
                    month(s)<asp:RequiredFieldValidator ID="reqMinAGe" runat="server" ControlToValidate="MINAGETextBox"
                        Display="None" ErrorMessage="[MINIMUM VEHICLE AGE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxMinAge" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinAGe">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Max</td>
                <td>
                    <asp:TextBox ID="MAXAGETextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("MAXCARAGE") %>' Width="72px"></asp:TextBox>
                    month(s)<asp:RequiredFieldValidator ID="reqMaxAge" runat="server" ControlToValidate="MAXAGETextBox"
                        Display="None" ErrorMessage="[MAXIMUM VEHICLE AGE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEMaxAge" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxAge">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td class="ShowDetail" colspan="4">
                    <uc4:BtnUpdate ID="BtnUpdate1" runat="server" />
                    <uc5:BtnDelete ID="BtnDelete1" runat="server" />
                    <uc3:BtnCancel ID="BtnCancel2" runat="server" />
                </td>
            </tr>
        </table>
        </EditItemTemplate>
        <InsertItemTemplate><table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                    Condition</td>
                <td colspan="3">
                    <asp:DropDownList ID="ddlCondition" runat="server" CssClass="required" DataSourceID="sdsCondition"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("CONDITION") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqCondition" runat="server" ControlToValidate="ddlCondition"
                        Display="None" ErrorMessage="[CONDITION] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECondition" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCondition">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    <asp:SqlDataSource ID="sdsCondition" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                            SelectCommand="SELECT NULL AS CODE, '[CONDITION]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'CONDITION')">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="HeaderStyle" colspan="4">
                    TENOR</td>
            </tr>
            <tr>
                <td>
                    Min</td>
                <td>
                    <asp:TextBox ID="MINTENORTextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("MINTENOR") %>' Width="64px"></asp:TextBox>
                    month(s)<asp:RequiredFieldValidator ID="reqMinTenor" runat="server" ControlToValidate="MINTENORTextBox"
                        Display="None" ErrorMessage="[MINIMUM TENOR] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEMinTenor" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinTenor">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Max</td>
                <td>
                    <asp:TextBox ID="MAXTENORTextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("MAXTENOR") %>' Width="72px"></asp:TextBox>
                    month(s)<asp:RequiredFieldValidator ID="reqMaxTenor" runat="server" ControlToValidate="MAXTENORTextBox"
                        Display="None" ErrorMessage="[MAXIMUM TENOR] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEMaxTenor" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxTenor">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="HeaderStyle" colspan="4">
                    CAR (VEHICLE) AGE</td>
            </tr>
            <tr>
                <td>
                    Min</td>
                <td>
                    <asp:TextBox ID="MINAGETextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("MINCARAGE") %>' Width="64px"></asp:TextBox>
                    month(s)<asp:RequiredFieldValidator ID="reqMinAGe" runat="server" ControlToValidate="MINAGETextBox"
                        Display="None" ErrorMessage="[MINIMUM VEHICLE AGE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxMinAge" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinAGe">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Max</td>
                <td>
                    <asp:TextBox ID="MAXAGETextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("MAXCARAGE") %>' Width="72px"></asp:TextBox>
                    month(s)<asp:RequiredFieldValidator ID="reqMaxAge" runat="server" ControlToValidate="MAXAGETextBox"
                        Display="None" ErrorMessage="[MAXIMUM VEHICLE AGE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEMaxAge" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxAge">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td class="ShowDetail" colspan="4">
                    <uc2:BtnInsert ID="BtnInsert1" runat="server" />
                    <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                </td>
            </tr>
        </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsTenorAgeEdit" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT ID, TENORID, MINTENOR, MAXTENOR, MINCARAGE, MAXCARAGE, CONDITION FROM VALIDTENORAGE WHERE (ID = @ID)" DeleteCommand="VALIDTENORAGEDELETE" DeleteCommandType="StoredProcedure" InsertCommand="VALIDTENORAGEADD" InsertCommandType="StoredProcedure" UpdateCommand="VALIDTENORAGEUPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvValidTenorAge" Name="ID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="MINTENOR" Type="Int32" />
            <asp:Parameter Name="MAXTENOR" Type="Int32" />
            <asp:Parameter Name="MINCARAGE" Type="Double" />
            <asp:Parameter Name="MAXCARAGE" Type="Double" />
            <asp:Parameter Name="CONDITION" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="USERID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="TENORID" QueryStringField="ID" Type="Int32" />
            <asp:Parameter Name="MINTENOR" Type="Int32" />
            <asp:Parameter Name="MAXTENOR" Type="Int32" />
            <asp:Parameter Name="MINCARAGE" Type="Int32" />
            <asp:Parameter Name="MAXCARAGE" Type="Int32" />
            <asp:Parameter Name="CONDITION" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="USERID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript">
FormatTable("<%=gvValidTenorAge.ClientID%>")
window.onload=function(){
    TabToEnter();
}

</script>
</asp:Content>

