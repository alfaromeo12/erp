<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ValidDP.aspx.vb" Inherits="Param_ValidDP" title="Down Payment Scheme" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="DPVALIDNAME">DP Name</asp:ListItem>
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
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="100%" DataKeyNames="DPID" Caption="Down Payment Scheme List">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/edit.gif" ShowSelectButton="True">
                    <ItemStyle HorizontalAlign="Center" Width="30px" />
                </asp:CommandField>
                <asp:TemplateField HeaderText="EX">
                    <ItemTemplate>
                        <img alt="Exception : <%#eval("DPID")%>" src="../Images/except.gif" style="cursor: pointer" onclick="Exception(<%#eval("DPID")%>)" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="30px" />
                </asp:TemplateField>
                <asp:BoundField DataField="DPID" HeaderText="ID" ReadOnly="True" SortExpression="DPID">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="DPVALIDNAME" HeaderText="Name" SortExpression="DPVALIDNAME" />
                <asp:BoundField DataField="MINDPNEW" HeaderText="Min DP&lt;br&gt;New Object&lt;br&gt;(%)"
                    HtmlEncode="False" SortExpression="MINDPNEW">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="MINDPUSED" HeaderText="Min DPt&lt;br&gt;Used Object&lt;br&gt;(%)"
                    HtmlEncode="False" SortExpression="MINDPUSED">
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
        SelectCommand="SELECT DPID, DPVALIDNAME, DESCRIPTION, MINDPNEW, MINDPUSED FROM VALIDDP WHERE (Deletests = 0)"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>

    <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%" DataKeyNames="DPID">
        <EditItemTemplate><table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td style="height: 19px">
                    Name</td>
                <td style="height: 19px">
                    <asp:TextBox ID="DPNAMETextBox" runat="server" CssClass="required" MaxLength="50"
                        Text='<%# Bind("DPVALIDNAME") %>'></asp:TextBox><asp:RequiredFieldValidator ID="reqName"
                            runat="server" ControlToValidate="DPNAMETextBox" Display="None" ErrorMessage="[INTEREST NAME] must be entry...!"
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
                                Minimum Down Payment<br />
                            </td>
                        </tr>
                        <tr>
                            <td class="RowStyle">
                                New Object</td>
                            <td class="RowStyle">
                                <asp:TextBox ID="MINDPNEWTextBox" runat="server" CssClass="required" Style="text-align: right"
                                    Text='<%# Bind("MINDPNEW") %>' Width="72px"></asp:TextBox>%<asp:RequiredFieldValidator
                                        ID="reqMinDPNew" runat="server" ControlToValidate="MINDPNEWTextBox" Display="None"
                                        ErrorMessage="[MIN DOWN PAYMENT NEW] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                                ID="ajaxVCEMinDPNew" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinDPNew">
                                        </ajaxToolkit:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr>
                            <td class="AlternatingRowStyle">
                                Used Object</td>
                            <td class="AlternatingRowStyle">
                                <asp:TextBox ID="MINDPUSEDTextBox" runat="server" CssClass="required" Style="text-align: right"
                                    Text='<%# Bind("MINDPUSED") %>' Width="72px"></asp:TextBox>%<asp:RequiredFieldValidator
                                        ID="reqMinDPUsed" runat="server" ControlToValidate="MINDPUSEDTextBox" Display="None"
                                        ErrorMessage="[MIN DOWN PAYMENT USED] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                                ID="ajaxVCEMinDPUsed" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinDPUsed">
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
                        <asp:TextBox ID="DPNAMETextBox" runat="server" CssClass="required" MaxLength="50"
                            Text='<%# Bind("DPVALIDNAME") %>'></asp:TextBox><asp:RequiredFieldValidator ID="reqName"
                                runat="server" ControlToValidate="DPNAMETextBox" Display="None" ErrorMessage="[INTEREST NAME] must be entry...!"
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
                                    Minimum Down Payment<br />
                                </td>
                            </tr>
                            <tr>
                                <td class="RowStyle">
                                    New Object</td>
                                <td class="RowStyle">
                                    <asp:TextBox ID="MINDPNEWTextBox" runat="server" CssClass="required" Style="text-align: right"
                                        Text='<%# Bind("MINDPNEW") %>' Width="72px"></asp:TextBox>%<asp:RequiredFieldValidator
                                            ID="reqMinDPNew" runat="server" ControlToValidate="MINDPNEWTextBox" Display="None"
                                            ErrorMessage="[MIN DOWN PAYMENT NEW] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                                ID="ajaxVCEMinDPNew" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinDPNew">
                                            </ajaxToolkit:ValidatorCalloutExtender>
                                </td>
                            </tr>
                            <tr>
                                <td class="AlternatingRowStyle">
                                    Used Object</td>
                                <td class="AlternatingRowStyle">
                                    <asp:TextBox ID="MINDPUSEDTextBox" runat="server" CssClass="required" Style="text-align: right"
                                        Text='<%# Bind("MINDPUSED") %>' Width="72px"></asp:TextBox>%<asp:RequiredFieldValidator
                                            ID="reqMinDPUsed" runat="server" ControlToValidate="MINDPUSEDTextBox" Display="None"
                                            ErrorMessage="[MIN DOWN PAYMENT USED] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                                ID="ajaxVCEMinDPUsed" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinDPUsed">
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
        SelectCommand="SELECT DPID, DPVALIDNAME, DESCRIPTION, MINDPNEW, MINDPUSED FROM VALIDDP WHERE (DPID = @DPID)" DeleteCommand="VALIDDPDELETE" UpdateCommand="VALIDDPUPDATE" InsertCommand="VALIDDPADD" InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="DPID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="DPID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="DPID" Type="Int32" />
            <asp:Parameter Name="DPVALIDNAME" Type="String" />
            <asp:Parameter Name="DESCRIPTION" Type="String" />
            <asp:Parameter Name="MINDPNEW" Type="Double" />
            <asp:Parameter Name="MINDPUSED" Type="Double" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="DPVALIDNAME" Type="String" />
            <asp:Parameter Name="DESCRIPTION" Type="String" />
            <asp:Parameter Name="MINDPNEW" Type="Double" />
            <asp:Parameter Name="MINDPUSED" Type="Double" />
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
    var winref = window.open("../Param/ValidDPMerk.aspx?Action=Edit&ID=" + ID, "DPEXCEPT", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes");
    winref.focus();
}

</script>

</asp:Content>

