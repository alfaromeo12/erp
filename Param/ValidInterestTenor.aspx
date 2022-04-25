<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ValidInterestTenor.aspx.vb" Inherits="Param_ValidInterestTenor" title="Valid Interest - Tenor" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc5" %>

<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">


    <asp:DataList ID="dlValidInterest" runat="server" Caption="INTEREST SCHEME - Default Values"
        DataKeyField="INTERESTID" DataSourceID="sdsValidInterest" Width="100%">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td style="width: 96px">
                        INTEREST ID</td>
                    <td>
                        <asp:Label ID="lblInterestID" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("INTERESTID") %>'></asp:Label></td>
                </tr>
                <tr >
                    <td style="width: 96px">
                        Name</td>
                    <td>
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("INTERESTNAME") %>'></asp:Label></td>
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
                                    Interest</td>
                                <td class="HeaderStyle">
                                    Maximum<br />
                                    Interest</td>
                            </tr>
                            <tr>
                                <td class="RowStyle">
                                    New Object/Vehicle</td>
                                <td class="RowStyle">
                                    <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("MININTERESTNEW") %>'></asp:Label>
                                    %</td>
                                <td class="RowStyle">
                                    <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("MAXINTERESTNEW") %>'></asp:Label>
                                    %</td>
                            </tr>
                            <tr>
                                <td class="AlternatingRowStyle">
                                    Used Object/Vehicle</td>
                                <td class="AlternatingRowStyle">
                                    <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("MININTERESTUSED") %>'></asp:Label>
                                    %</td>
                                <td class="AlternatingRowStyle">
                                    <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("MAXINTERESTUSED") %>'></asp:Label>
                                    %</td>
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
    </asp:DataList><asp:SqlDataSource ID="sdsValidInterest" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT INTERESTID, INTERESTNAME, DESCRIPTION, MININTERESTNEW, MAXINTERESTNEW, MININTERESTUSED, MAXINTERESTUSED FROM VALIDINTEREST WHERE (INTERESTID = @INTERESTID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="INTERESTID" QueryStringField="ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ImageButton ID="imgBtnNew" runat="server" CausesValidation="False" CssClass="New"
        ImageUrl="~/images/add.gif" />
    <asp:GridView ID="gvValidInterestTenor" runat="server" AutoGenerateColumns="False"
        Caption="INTEREST SCHEME - Exception" DataKeyNames="ID" DataSourceID="sdsValidInterestTenor"
        Width="100%" AllowPaging="True" AllowSorting="True">
        <Columns>
            <asp:CommandField ButtonType="Image" EditImageUrl="~/Images/delete.gif" SelectImageUrl="~/Images/edit.gif"
                ShowSelectButton="True">
                <ItemStyle HorizontalAlign="Center" Width="25px" />
            </asp:CommandField>
            <asp:TemplateField HeaderText="DEL" ShowHeader="False">
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandName="Delete"
                        ImageUrl="~/Images/delete.gif" Text="Delete" OnClientClick="return confirm('Are you sure want to delete data...?')" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="25px" />
            </asp:TemplateField>
            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="CONDITIONNAME" HeaderText="Condition" ReadOnly="True"
                SortExpression="CONDITIONNAME" />
            <asp:BoundField DataField="MININTEREST" HeaderText="Min&lt;br&gt;Interest&lt;br&gt;(%)"
                HtmlEncode="False" SortExpression="MININTEREST">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="MAXINTEREST" HeaderText="Max&lt;br&gt;Interest&lt;br&gt;(%)"
                HtmlEncode="False" SortExpression="MAXINTEREST">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="MINTENOR" HeaderText="Min&lt;br&gt;Tenor&lt;br&gt;(months)"
                HtmlEncode="False" SortExpression="MINTENOR">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="MAXTENOR" HeaderText="Max&lt;br&gt;Tenor&lt;br&gt;(months)"
                HtmlEncode="False" SortExpression="MAXTENOR">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            <uc1:NoDataFound ID="NoDataFound1" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsValidInterestTenor" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT ID, INTERESTID, MININTEREST, MAXINTEREST, MINTENOR, MAXTENOR, '(' + CAST(CONDITION AS VARCHAR(20)) + ') ' + dbo.f_getParamGlobalName('CONDITION', CONDITION) AS CONDITIONNAME FROM VALIDINTERESTTENOR WHERE (INTERESTID = @INTERESTID) AND (Deletests = 0)" DeleteCommand="VALIDINTERESTTENORDELETE" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="INTERESTID" QueryStringField="ID" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:FormView ID="fvInterestTenor" runat="server" DataKeyNames="ID" DataSourceID="sdsInterestTenorEdit" Caption="INTEREST SCHEME - TENOR" Width="100%" DefaultMode="Edit">
        <EditItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
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
                        INTEREST</td>
                </tr>
                <tr>
                    <td>
                        Min</td>
                    <td>
                        <asp:TextBox ID="MININTERESTTextBox" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("MININTEREST") %>' Width="96px"></asp:TextBox>
                        %<asp:RequiredFieldValidator ID="reqMinInterest" runat="server" ControlToValidate="MININTERESTTextBox"
                            Display="None" ErrorMessage="[MINIMUM INTEREST] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxMinInterest" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinInterest">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td>
                        Max</td>
                    <td>
                        <asp:TextBox ID="MAXINTERESTTextBox" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("MAXINTEREST") %>' Width="96px"></asp:TextBox>
                        %<asp:RequiredFieldValidator ID="reqMaxInterest" runat="server" ControlToValidate="MAXINTERESTTextBox"
                            Display="None" ErrorMessage="[MAXIMUM INTEREST] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEMaxInterest" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxInterest">
                            </ajaxToolkit:ValidatorCalloutExtender>
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
        <InsertItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
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
                        INTEREST</td>
                </tr>
                <tr>
                    <td>
                        Min</td>
                    <td>
                        <asp:TextBox ID="MININTERESTTextBox" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("MININTEREST") %>' Width="96px"></asp:TextBox>
                        %<asp:RequiredFieldValidator ID="reqMinInterest" runat="server" ControlToValidate="MININTERESTTextBox"
                            Display="None" ErrorMessage="[MINIMUM INTEREST] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxMinInterest" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinInterest">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td>
                        Max</td>
                    <td>
                        <asp:TextBox ID="MAXINTERESTTextBox" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("MAXINTEREST") %>' Width="96px"></asp:TextBox>
                        %<asp:RequiredFieldValidator ID="reqMaxInterest" runat="server" ControlToValidate="MAXINTERESTTextBox"
                            Display="None" ErrorMessage="[MAXIMUM INTEREST] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEMaxInterest" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxInterest">
                            </ajaxToolkit:ValidatorCalloutExtender>
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
    <asp:SqlDataSource ID="sdsInterestTenorEdit" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT ID, INTERESTID, MININTEREST, MAXINTEREST, MINTENOR, MAXTENOR, CONDITION FROM VALIDINTERESTTENOR WHERE (ID = @ID)" DeleteCommand="VALIDINTERESTTENORDELETE" DeleteCommandType="StoredProcedure" InsertCommand="VALIDINTERESTTENORADD" InsertCommandType="StoredProcedure" UpdateCommand="VALIDINTERESTTENORUPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvValidInterestTenor" Name="ID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="MININTEREST" Type="Double" />
            <asp:Parameter Name="MAXINTEREST" Type="Double" />
            <asp:Parameter Name="MINTENOR" Type="Int32" />
            <asp:Parameter Name="MAXTENOR" Type="Int32" />
            <asp:Parameter Name="CONDITION" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="USERID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="INTERESTID" QueryStringField="ID" Type="Int32" />
            <asp:Parameter Name="MININTEREST" Type="Double" />
            <asp:Parameter Name="MAXINTEREST" Type="Double" />
            <asp:Parameter Name="MINTENOR" Type="Int32" />
            <asp:Parameter Name="MAXTENOR" Type="Int32" />
            <asp:Parameter Name="CONDITION" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="USERID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript">
FormatTable("<%=gvValidInterestTenor.ClientID%>")
window.onload=function(){
    TabToEnter();
}

</script>
</asp:Content>

