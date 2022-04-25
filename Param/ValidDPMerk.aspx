<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ValidDPMerk.aspx.vb" Inherits="Param_ValidDPMerk" title="Valid Down Payment - Merk" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc5" %>

<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">


    <asp:DataList ID="dlValidDP" runat="server" Caption="DOWN PAYMENT SCHEME - Default Values"
        DataKeyField="DPID" DataSourceID="sdsValidDP" Width="100%">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        DP ID</td>
                    <td>
                        <asp:Label ID="lblDPID" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("DPID") %>'></asp:Label></td>
                </tr>
                <tr >
                    <td style="width: 96px">
                        Name</td>
                    <td>
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("DPVALIDNAME") %>'></asp:Label></td>
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
                                <td class="HeaderStyle" colspan="2">
                                    Minimum<br />
                                    Down Payment</td>
                            </tr>
                            <tr>
                                <td class="RowStyle">
                                    New Object/Vehicle</td>
                                <td class="RowStyle" colspan="2">
                                    <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("MINDPNEW") %>'></asp:Label>
                                    %</td>
                            </tr>
                            <tr>
                                <td class="AlternatingRowStyle">
                                    Used Object/Vehicle</td>
                                <td class="AlternatingRowStyle" colspan="2">
                                    <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("MINDPUSED") %>'></asp:Label>
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
    </asp:DataList><asp:SqlDataSource ID="sdsValidDP" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT DPID, DPVALIDNAME, DESCRIPTION, MINDPNEW, MINDPUSED FROM VALIDDP WHERE (DPID = @DPID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="DPID" QueryStringField="ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ImageButton ID="imgBtnNew" runat="server" CausesValidation="False" CssClass="New"
        ImageUrl="~/images/add.gif" />
    <asp:GridView ID="gvValidDPMerk" runat="server" AutoGenerateColumns="False"
        Caption="DOWN PAYMENT SCHEME - Exception" DataKeyNames="ID" DataSourceID="sdsValidDPMerk"
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
            <asp:BoundField DataField="MERKNAME" HeaderText="Brand/&lt;br&gt;Merk" HtmlEncode="False"
                SortExpression="MERKNAME" />
            <asp:BoundField DataField="DPPERCENT" HeaderText="Minimum&lt;br&gt;Down Payment&lt;br&gt;(%)"
                HtmlEncode="False" SortExpression="DPPERCENT">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            <uc1:NoDataFound ID="NoDataFound1" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsValidDPMerk" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT VALIDDPMERK.ID, VALIDDPMERK.DPID, CAST(VALIDDPMERK.CONDITION AS VARCHAR(20)) + ') ' + dbo.f_getParamGlobalName('CONDITION', VALIDDPMERK.CONDITION) AS CONDITIONNAME, VALIDDPMERK.MERKID, VALIDDPMERK.DPPERCENT, '(' + MERK.MERKCODE + ') ' + MERK.MERKNAME AS MERKNAME FROM VALIDDPMERK LEFT OUTER JOIN MERK ON VALIDDPMERK.MERKID = MERK.MERKID WHERE (VALIDDPMERK.DPID = @DPID) AND (VALIDDPMERK.Deletests = 0)" DeleteCommand="VALIDDPMERKDELETE" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="DPID" QueryStringField="ID" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:FormView ID="fvDPMerk" runat="server" DataKeyNames="ID" DataSourceID="sdsDPMerkEdit" Caption="DOWN PAYMENT SCHEME - VEHICLE BRAND (MERK)" Width="100%" DefaultMode="Edit">
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
                <td>
                    Brand/Merk</td>
                <td colspan="3">
                    <asp:DropDownList ID="ddlMerk" runat="server" CssClass="required" DataSourceID="sdsMerk"
                        DataTextField="MERKNAME" DataValueField="MERKID" SelectedValue='<%# Bind("MERKID") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqMerk" runat="server" ControlToValidate="ddlMerk"
                        Display="None" ErrorMessage="[MERK/BRAND] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEMerk" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMerk">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    <asp:SqlDataSource ID="sdsMerk" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        SelectCommand="SELECT NULL AS MERKID, NULL AS merkcode, '[MERK/BRAND]' AS MERKNAME UNION ALL SELECT MERKID, MERKCODE, '(' + MERKCODE + ') ' + MERKNAME AS MERKNAME FROM MERK WHERE (Deletests = 0) ORDER BY merkcode">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>
                    Minimum Down Payment</td>
                <td colspan="3">
                    <asp:TextBox ID="MINDPTextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("DPPERCENT") %>' Width="64px"></asp:TextBox>
                    %
                    <asp:RequiredFieldValidator ID="reqMinDP" runat="server" ControlToValidate="MINDPTextBox"
                        Display="None" ErrorMessage="[MINIMUM DOWN PAYMENT] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEMinDP" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinDP">
                        </ajaxToolkit:ValidatorCalloutExtender>
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
                <td>
                    Brand/Merk</td>
                <td colspan="3">
                    <asp:DropDownList ID="ddlMerk" runat="server" CssClass="required" DataSourceID="sdsMerk"
                        DataTextField="MERKNAME" DataValueField="MERKID" SelectedValue='<%# Bind("MERKID") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqMerk" runat="server" ControlToValidate="ddlMerk"
                        Display="None" ErrorMessage="[MERK/BRAND] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEMerk" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMerk">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    <asp:SqlDataSource ID="sdsMerk" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        SelectCommand="SELECT NULL AS MERKID, NULL AS merkcode, '[MERK/BRAND]' AS MERKNAME UNION ALL SELECT MERKID, MERKCODE, '(' + MERKCODE + ') ' + MERKNAME AS MERKNAME FROM MERK WHERE (Deletests = 0) ORDER BY merkcode">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>
                    Minimum Down Payment</td>
                <td colspan="3">
                    <asp:TextBox ID="MINDPTextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("DPPERCENT") %>' Width="64px"></asp:TextBox>
                    %
                    <asp:RequiredFieldValidator ID="reqMinDP" runat="server" ControlToValidate="MINDPTextBox"
                        Display="None" ErrorMessage="[MINIMUM DOWN PAYMENT] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEMinDP" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinDP">
                        </ajaxToolkit:ValidatorCalloutExtender>
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
    <asp:SqlDataSource ID="sdsDPMerkEdit" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT ID, DPID, CONDITION, MERKID, DPPERCENT FROM VALIDDPMERK WHERE (ID = @ID)" DeleteCommand="VALIDDPMERKDELETE" DeleteCommandType="StoredProcedure" InsertCommand="VALIDDPMERKADD" InsertCommandType="StoredProcedure" UpdateCommand="VALIDDPMERKUPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvValidDPMerk" Name="ID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="DPPERCENT" Type="Double" />
            <asp:Parameter Name="MERKID" Type="Int32" />
            <asp:Parameter Name="CONDITION" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="USERID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="DPID" QueryStringField="ID" Type="Int32" />
            <asp:Parameter Name="DPPERCENT" Type="Double" />
            <asp:Parameter Name="MERKID" Type="Int32" />
            <asp:Parameter Name="CONDITION" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="USERID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript">
FormatTable("<%=gvValidDPMerk.ClientID%>")
window.onload=function(){
    TabToEnter();
}

</script>
</asp:Content>

