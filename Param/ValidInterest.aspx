<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ValidInterest.aspx.vb" Inherits="Param_ValidInterest" title="Interest Scheme" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="INTERESTNAME">Interest Name</asp:ListItem>
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
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="100%" DataKeyNames="INTERESTID" Caption="Interest Scheme List">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/edit.gif" ShowSelectButton="True">
                    <ItemStyle HorizontalAlign="Center" Width="30px" />
                </asp:CommandField>
                <asp:TemplateField HeaderText="EX">
                    <ItemTemplate>
                        <img alt="Exception : <%#eval("INTERESTID")%>" src="../Images/except.gif" style="cursor: pointer" onclick="Exception(<%#eval("INTERESTID")%>)" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="30px" />
                </asp:TemplateField>
                <asp:BoundField DataField="INTERESTID" HeaderText="ID" ReadOnly="True" SortExpression="INTERESTID">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="INTERESTNAME" HeaderText="Name" SortExpression="INTERESTNAME" />
                <asp:BoundField DataField="MININTERESTNEW" HeaderText="Min Interest&lt;br&gt;New Object&lt;br&gt;(%)"
                    HtmlEncode="False" SortExpression="MININTERESTNEW">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="MAXINTERESTNEW" HeaderText="Max Interest&lt;br&gt;New Object&lt;br&gt;(%)"
                    HtmlEncode="False" SortExpression="MAXINTERESTNEW">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="MININTERESTUSED" HeaderText="Min Interest&lt;br&gt;Used Object&lt;br&gt;(%)"
                    HtmlEncode="False" SortExpression="MININTERESTUSED">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="MAXINTERESTUSED" HeaderText="Max Interest&lt;br&gt;Used Object&lt;br&gt;(%)"
                    HtmlEncode="False" SortExpression="MAXINTERESTUSED">
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
        SelectCommand="SELECT INTERESTID, INTERESTNAME, DESCRIPTION, MININTERESTNEW, MAXINTERESTNEW, MININTERESTUSED, MAXINTERESTUSED FROM VALIDINTEREST WHERE (Deletests = 0)"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
    <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblError">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
    <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%" DataKeyNames="INTERESTID">
        <EditItemTemplate><table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td style="height: 19px">
                    INTEREST ID</td>
                <td style="height: 19px">
                    <asp:Label ID="lblInterestID" runat="server" Font-Bold="True" Font-Underline="True"
                        Text='<%# Eval("INTERESTID") %>'></asp:Label></td>
            </tr>
            <tr>
                <td style="height: 19px">
                    Name</td>
                <td style="height: 19px">
                    <asp:TextBox ID="INTERESTNAMETextBox" runat="server" CssClass="required" MaxLength="50"
                        Text='<%# Bind("INTERESTNAME") %>'></asp:TextBox><asp:RequiredFieldValidator ID="reqName"
                            runat="server" ControlToValidate="INTERESTNAMETextBox" Display="None" ErrorMessage="[INTEREST NAME] must be entry...!"
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
                    DEFAULT VALUES</td>
            </tr>
            <tr>
                <td colspan="2" class="FooterStyle">
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td class="HeaderStyle">
                                Condition</td>
                            <td class="HeaderStyle">
                                Minimum Interest</td>
                            <td class="HeaderStyle">
                                Maximum Interest</td>
                        </tr>
                        <tr>
                            <td class="RowStyle">
                                New Object</td>
                            <td class="RowStyle">
                                <asp:TextBox ID="MININTERESTNEWTextBox" runat="server" CssClass="required" Style="text-align: right"
                                    Text='<%# Bind("MININTERESTNEW") %>' Width="72px"></asp:TextBox>%<asp:RequiredFieldValidator
                                        ID="reqMinInterestNew" runat="server" ControlToValidate="MININTERESTNEWTextBox"
                                        Display="None" ErrorMessage="[MIN INTEREST NEW] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                            ID="ajaxVCEMinInterestNew" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinInterestNew">
                                        </ajaxToolkit:ValidatorCalloutExtender>
                            </td>
                            <td class="RowStyle">
                                <asp:TextBox ID="MAXINTERESTNEWTextBox" runat="server" CssClass="required" Style="text-align: right"
                                    Text='<%# Bind("MAXINTERESTNEW") %>' Width="72px"></asp:TextBox>%<asp:RequiredFieldValidator
                                        ID="reqMaxInterestNew" runat="server" ControlToValidate="MAXINTERESTNEWTextBox"
                                        Display="None" ErrorMessage="[MAX INTEREST NEW] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                            ID="ajaxVCEMaxInterestNew" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxInterestNew">
                                        </ajaxToolkit:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr>
                            <td class="AlternatingRowStyle">
                                Used Object</td>
                            <td class="AlternatingRowStyle">
                                <asp:TextBox ID="MININTERESTUSEDTextBox" runat="server" CssClass="required" Style="text-align: right"
                                    Text='<%# Bind("MININTERESTUSED") %>' Width="72px"></asp:TextBox>%<asp:RequiredFieldValidator
                                        ID="reqMinInterestUsed" runat="server" ControlToValidate="MININTERESTUSEDTextBox"
                                        Display="None" ErrorMessage="[MIN INTEREST USED] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                            ID="ajaxVCEMinInterestUsed" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinInterestUsed">
                                        </ajaxToolkit:ValidatorCalloutExtender>
                            </td>
                            <td class="AlternatingRowStyle">
                                <asp:TextBox ID="MAXINTERESTUSEDTextBox" runat="server" CssClass="required" Style="text-align: right"
                                    Text='<%# Bind("MAXINTERESTUSED") %>' Width="72px"></asp:TextBox>%<asp:RequiredFieldValidator
                                        ID="reqMaxInterestUsed" runat="server" ControlToValidate="MAXINTERESTUSEDTextBox"
                                        Display="None" ErrorMessage="[MAX INTEREST USED] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                            ID="ajaxVCEMaxInterestUsed" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxInterestUsed">
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
                        <asp:TextBox ID="INTERESTNAMETextBox" runat="server" CssClass="required" MaxLength="50"
                            Text='<%# Bind("INTERESTNAME") %>'></asp:TextBox><asp:RequiredFieldValidator ID="reqName"
                                runat="server" ControlToValidate="INTERESTNAMETextBox" Display="None" ErrorMessage="[INTEREST NAME] must be entry...!"
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
                                    Minimum Interest</td>
                                <td class="HeaderStyle">
                                    Maximum Interest</td>
                            </tr>
                            <tr>
                                <td class="RowStyle">
                                    New Object</td>
                                <td class="RowStyle">
                                    <asp:TextBox ID="MININTERESTNEWTextBox" runat="server" CssClass="required" Style="text-align: right"
                                        Text='<%# Bind("MININTERESTNEW") %>' Width="72px"></asp:TextBox>%<asp:RequiredFieldValidator
                                            ID="reqMinInterestNew" runat="server" ControlToValidate="MININTERESTNEWTextBox"
                                            Display="None" ErrorMessage="[MIN INTEREST NEW] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                                ID="ajaxVCEMinInterestNew" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinInterestNew">
                                            </ajaxToolkit:ValidatorCalloutExtender>
                                </td>
                                <td class="RowStyle">
                                    <asp:TextBox ID="MAXINTERESTNEWTextBox" runat="server" CssClass="required" Style="text-align: right"
                                        Text='<%# Bind("MAXINTERESTNEW") %>' Width="72px"></asp:TextBox>%<asp:RequiredFieldValidator
                                            ID="reqMaxInterestNew" runat="server" ControlToValidate="MAXINTERESTNEWTextBox"
                                            Display="None" ErrorMessage="[MAX INTEREST NEW] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                                ID="ajaxVCEMaxInterestNew" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxInterestNew">
                                            </ajaxToolkit:ValidatorCalloutExtender>
                                </td>
                            </tr>
                            <tr>
                                <td class="AlternatingRowStyle">
                                    Used Object</td>
                                <td class="AlternatingRowStyle">
                                    <asp:TextBox ID="MININTERESTUSEDTextBox" runat="server" CssClass="required" Style="text-align: right"
                                        Text='<%# Bind("MININTERESTUSED") %>' Width="72px"></asp:TextBox>%<asp:RequiredFieldValidator
                                            ID="reqMinInterestUsed" runat="server" ControlToValidate="MININTERESTUSEDTextBox"
                                            Display="None" ErrorMessage="[MIN INTEREST USED] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                                ID="ajaxVCEMinInterestUsed" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinInterestUsed">
                                            </ajaxToolkit:ValidatorCalloutExtender>
                                </td>
                                <td class="AlternatingRowStyle">
                                    <asp:TextBox ID="MAXINTERESTUSEDTextBox" runat="server" CssClass="required" Style="text-align: right"
                                        Text='<%# Bind("MAXINTERESTUSED") %>' Width="72px"></asp:TextBox>%<asp:RequiredFieldValidator
                                            ID="reqMaxInterestUsed" runat="server" ControlToValidate="MAXINTERESTUSEDTextBox"
                                            Display="None" ErrorMessage="[MAX INTEREST USED] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                                ID="ajaxVCEMaxInterestUsed" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxInterestUsed">
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
        SelectCommand="SELECT INTERESTID, INTERESTNAME, DESCRIPTION, MININTERESTNEW, MAXINTERESTNEW, MININTERESTUSED, MAXINTERESTUSED FROM VALIDINTEREST WHERE (INTERESTID = @INTERESTID)" DeleteCommand="VALIDINTERESTDELETE" UpdateCommand="VALIDINTERESTUPDATE" InsertCommand="VALIDINTERESTADD" InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="INTERESTID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="INTERESTID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="INTERESTID" Type="Int32" />
            <asp:Parameter Name="INTERESTNAME" Type="String" />
            <asp:Parameter Name="DESCRIPTION" Type="String" />
            <asp:Parameter Name="MININTERESTNEW" Type="Double" />
            <asp:Parameter Name="MAXINTERESTNEW" Type="Double" />
            <asp:Parameter Name="MININTERESTUSED" Type="Double" />
            <asp:Parameter Name="MAXINTERESTUSED" Type="Double" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="INTERESTNAME" Type="String" />
            <asp:Parameter Name="DESCRIPTION" Type="String" />
            <asp:Parameter Name="MININTERESTNEW" Type="Double" />
            <asp:Parameter Name="MAXINTERESTNEW" Type="Double" />
            <asp:Parameter Name="MININTERESTUSED" Type="Double" />
            <asp:Parameter Name="MAXINTERESTUSED" Type="Double" />
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
   var winref = window.open("../Param/ValidInterestTenor.aspx?Action=Edit&ID=" + ID, "INTEXCEPT", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes");
   winref.focus();
}

</script>

</asp:Content>

