<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ETPenalty.aspx.vb" Inherits="Param_City" title="City" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="ETPENNAME">ET Penalty Name</asp:ListItem>
        <asp:ListItem Value="ETPENCODE">ET PENALTY Code</asp:ListItem>
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
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="100%" DataKeyNames="ETPENID" Caption="ET Penalty & Admin Fee List" RowHeaderColumn="ETPENID">
            <Columns>
                <asp:CommandField ButtonType="Image" ShowSelectButton="True" SelectImageUrl="~/Images/edit.gif" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="ETPENID" HeaderText="ID" ReadOnly="True" SortExpression="ETPENID" />
                <asp:BoundField DataField="ETPENCODE" HeaderText="Code" SortExpression="ETPENCODE" />
                <asp:BoundField DataField="ETPENNAME" HeaderText="Name" SortExpression="ETPENNAME" />
                <asp:BoundField DataField="ETADMIN" HeaderText="Admin&lt;br&gt;Fee" SortExpression="ETADMIN" DataFormatString="{0:N}" HtmlEncode="False" >
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="ETPENALTY" HeaderText="Penalty&lt;br&gt;(%)" SortExpression="ETPENALTY" HtmlEncode="False" >
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="ETUSEDNAME" HeaderText="ET Used&lt;br&gt;Fee" ReadOnly="True" SortExpression="ETUSEDNAME" HtmlEncode="False" />
                <asp:BoundField DataField="BOOKFROM" DataFormatString="{0:dd/MM/yyyy}" 
                    HeaderText="Valid&lt;br&gt;Booking&lt;br&gt;From" HtmlEncode="False" 
                    SortExpression="BOOKFROM">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="BOOKTO" DataFormatString="{0:dd/MM/yyyy}" 
                    HeaderText="Valid&lt;br&gt;Booking&lt;br&gt;To" HtmlEncode="False" 
                    SortExpression="BOOKTO">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="REMARK" HeaderText="Remark" SortExpression="REMARK" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT ETPENID, ETPENCODE, ETPENNAME, ETADMIN, ETPENALTY, ETUSED, dbo.f_getParamGlobalName('ETUSED', ETUSED) AS ETUSEDNAME, REMARK, BOOKFROM, BOOKTO FROM ETPENALTY WITH (NOLOCK) WHERE (DELETESTS = 0)"></asp:SqlDataSource>
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
        DefaultMode="Edit" Width="100%" DataKeyNames="ETPENID">
        <EditItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        ID</td>
                    <td colspan="3">
                        <asp:Label ID="lblID" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("ETPENID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Code</td>
                    <td colspan="3">
                        <asp:TextBox ID="ETPENCODETextBox" runat="server" CssClass="required" MaxLength="10"
                            Text='<%# Bind("ETPENCODE") %>' Width="64px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqCode" runat="server" ControlToValidate="ETPENCODETextBox" Display="None"
                                ErrorMessage="Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight"
                            TargetControlID="reqCode">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Name</td>
                    <td colspan="3">
                        <asp:TextBox ID="ETPENNAMETextBox" runat="server" CssClass="required" MaxLength="50"
                            Text='<%# Bind("ETPENNAME") %>' Width="224px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqName" runat="server" ControlToValidate="ETPENNAMETextBox" Display="None"
                                ErrorMessage="Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Admin Fee</td>
                    <td colspan="3">
                        <asp:TextBox ID="ETADMINTextBox" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("ETADMIN", " {0:N}") %>' Width="112px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqAdmin" runat="server" ControlToValidate="ETADMINTextBox" Display="None"
                                ErrorMessage="Admin Fee must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEAdmin" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAdmin">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Penalty</td>
                    <td colspan="3">
                        <asp:TextBox ID="ETPENALTYTextBox" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("ETPENALTY", "{0:N3}") %>' Width="56px"></asp:TextBox>%<asp:RequiredFieldValidator
                                ID="regPenalty" runat="server" ControlToValidate="ETPENALTYTextBox" Display="None"
                                ErrorMessage="Penalty must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEPenalty" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="regPenalty">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Used Fee</td>
                    <td colspan="3">
                        <asp:DropDownList ID="ddlUsedFee" runat="server" CssClass="required" DataSourceID="sdsETUsed"
                            DataTextField="ETUSED" DataValueField="CODE" SelectedValue='<%# Bind("ETUSED") %>'>
                        </asp:DropDownList><asp:RequiredFieldValidator ID="regUsedFee" runat="server" ControlToValidate="ddlUsedFee"
                            Display="None" ErrorMessage="Used Fee must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEUsedFee" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="regUsedFee">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td class="ShowDetail">
                        Valid For</td>
                    <td colspan="3">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Booking From</td>
                    <td>
                        <asp:TextBox ID="txtBookFrom" runat="server" CssClass="required" 
                            Text='<%# Bind("BOOKFROM", "{0:dd/MM/yyyy}") %>' Width="72px"></asp:TextBox>
                        <ajaxToolkit:CalendarExtender ID="ajaxCEstartdate" runat="server" Format="dd/MM/yyyy" 
                            PopupButtonID="imgBookFrom" PopupPosition="TopRight" 
                            TargetControlID="txtBookFrom">
                        </ajaxToolkit:CalendarExtender>
                        <ajaxToolkit:MaskedEditExtender ID="ajaxMEEstartdate" runat="server" Mask="99/99/9999" 
                            MaskType="Date" TargetControlID="txtBookFrom">
                        </ajaxToolkit:MaskedEditExtender>
                        <asp:Image ID="imgBookFrom" runat="server" ImageUrl="~/images/grid.gif" 
                            style="cursor: pointer" ToolTip="Calendar" />
                        <asp:RequiredFieldValidator ID="reqBookFrom" runat="server" 
                            ControlToValidate="txtBookFrom" Display="None" 
                            ErrorMessage="BOOKING FROM must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqBookFrom_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBookFrom">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td>
                        Booking To</td>
                    <td>
                        <asp:TextBox ID="txtBookTo" runat="server" CssClass="required" 
                            Text='<%# Bind("BOOKTO", "{0:dd/MM/yyyy}") %>' Width="72px"></asp:TextBox>
                        <ajaxToolkit:CalendarExtender ID="txtBookTo_CalendarExtender" runat="server" 
                            Format="dd/MM/yyyy" PopupButtonID="imgBookTo" PopupPosition="TopRight" 
                            TargetControlID="txtBookTo">
                        </ajaxToolkit:CalendarExtender>
                        <ajaxToolkit:MaskedEditExtender ID="txtBookTo_MaskedEditExtender" runat="server" 
                            Mask="99/99/9999" MaskType="Date" TargetControlID="txtBookTo">
                        </ajaxToolkit:MaskedEditExtender>
                        <asp:Image ID="imgBookTo" runat="server" ImageUrl="~/images/grid.gif" 
                            style="cursor: pointer" ToolTip="Calendar" />
                        <asp:RequiredFieldValidator ID="reqBookTo" runat="server" 
                            ControlToValidate="txtBookTo" Display="None" 
                            ErrorMessage="BOOKING TO must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqBookTo_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBookTo">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Remark</td>
                    <td colspan="3">
                        <asp:TextBox ID="REMARKTextBox" runat="server" Height="72px" 
                            Text='<%# Bind("REMARK") %>' TextMode="MultiLine" Width="232px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td class="FooterStyle" colspan="4">
                        <uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
                        <uc2:BtnDelete ID="BtnDelete1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel2" runat="server" />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        Code</td>
                    <td colspan="3">
                        <asp:TextBox ID="ETPENCODETextBox" runat="server" CssClass="required" MaxLength="10"
                            Text='<%# Bind("ETPENCODE") %>' Width="64px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqCode" runat="server" ControlToValidate="ETPENCODETextBox" Display="None"
                                ErrorMessage="Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight"
                            TargetControlID="reqCode">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Name</td>
                    <td colspan="3">
                        <asp:TextBox ID="ETPENNAMETextBox" runat="server" CssClass="required" MaxLength="50"
                            Text='<%# Bind("ETPENNAME") %>' Width="224px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqName" runat="server" ControlToValidate="ETPENNAMETextBox" Display="None"
                                ErrorMessage="Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Admin Fee</td>
                    <td colspan="3">
                        <asp:TextBox ID="ETADMINTextBox" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("ETADMIN", " {0:N}") %>' Width="112px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqAdmin" runat="server" ControlToValidate="ETADMINTextBox" Display="None"
                                ErrorMessage="Admin Fee must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEAdmin" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAdmin">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Penalty</td>
                    <td colspan="3">
                        <asp:TextBox ID="ETPENALTYTextBox" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("ETPENALTY", "{0:N3}") %>' Width="56px"></asp:TextBox>%<asp:RequiredFieldValidator
                                ID="regPenalty" runat="server" ControlToValidate="ETPENALTYTextBox" Display="None"
                                ErrorMessage="Penalty must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEPenalty" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="regPenalty">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Used Fee</td>
                    <td colspan="3">
                        <asp:DropDownList ID="ddlUsedFee" runat="server" CssClass="required" DataSourceID="sdsETUsed"
                            DataTextField="ETUSED" DataValueField="CODE" SelectedValue='<%# Bind("ETUSED") %>'>
                        </asp:DropDownList><asp:RequiredFieldValidator ID="regUsedFee" runat="server" ControlToValidate="ddlUsedFee"
                            Display="None" ErrorMessage="Used Fee must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEUsedFee" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="regUsedFee">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td class="ShowDetail">
                        Valid For</td>
                    <td colspan="3">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Booking From</td>
                    <td>
                        <asp:TextBox ID="txtBookFrom" runat="server" CssClass="required" 
                            Text='<%# Bind("BOOKFROM", "{0:dd/MM/yyyy}") %>' Width="72px"></asp:TextBox>
                        <ajaxToolkit:CalendarExtender ID="ajaxCEstartdate" runat="server" Format="dd/MM/yyyy" 
                            PopupButtonID="imgBookFrom" PopupPosition="TopRight" 
                            TargetControlID="txtBookFrom">
                        </ajaxToolkit:CalendarExtender>
                        <ajaxToolkit:MaskedEditExtender ID="ajaxMEEstartdate" runat="server" Mask="99/99/9999" 
                            MaskType="Date" TargetControlID="txtBookFrom">
                        </ajaxToolkit:MaskedEditExtender>
                        <asp:Image ID="imgBookFrom" runat="server" ImageUrl="~/images/grid.gif" 
                            style="cursor: pointer" ToolTip="Calendar" />
                        <asp:RequiredFieldValidator ID="reqBookFrom" runat="server" 
                            ControlToValidate="txtBookFrom" Display="None" 
                            ErrorMessage="BOOKING FROM must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqBookFrom_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBookFrom">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td>
                        Booking To</td>
                    <td>
                        <asp:TextBox ID="txtBookTo" runat="server" CssClass="required" 
                            Text='<%# Bind("BOOKTO", "{0:dd/MM/yyyy}") %>' Width="72px"></asp:TextBox>
                        <ajaxToolkit:CalendarExtender ID="txtBookTo_CalendarExtender" runat="server" 
                            Format="dd/MM/yyyy" PopupButtonID="imgBookTo" PopupPosition="TopRight" 
                            TargetControlID="txtBookTo">
                        </ajaxToolkit:CalendarExtender>
                        <ajaxToolkit:MaskedEditExtender ID="txtBookTo_MaskedEditExtender" runat="server" 
                            Mask="99/99/9999" MaskType="Date" TargetControlID="txtBookTo">
                        </ajaxToolkit:MaskedEditExtender>
                        <asp:Image ID="imgBookTo" runat="server" ImageUrl="~/images/grid.gif" 
                            style="cursor: pointer" ToolTip="Calendar" />
                        <asp:RequiredFieldValidator ID="reqBookTo" runat="server" 
                            ControlToValidate="txtBookTo" Display="None" 
                            ErrorMessage="BOOKING TO must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqBookTo_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBookTo">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Remark</td>
                    <td colspan="3">
                        <asp:TextBox ID="REMARKTextBox" runat="server" Height="72px" 
                            Text='<%# Bind("REMARK") %>' TextMode="MultiLine" Width="232px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td class="FooterStyle" colspan="4">
                        <uc4:BtnInsert ID="BtnInsert1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT ETPENID, ETPENCODE, ETPENNAME, ETADMIN, ETPENALTY, ETUSED, REMARK, BOOKFROM, BOOKTO FROM ETPENALTY WITH (NOLOCK) WHERE (ETPENID = @ETPENID)" 
        DeleteCommand="UPDATE ETPENALTY SET DELETESTS = 1, LASTUPDATE = GETDATE(), LASTUSERID = @USERID WHERE (ETPENID = @ETPENID)" 
        UpdateCommand="ETPENALTYUpdate" InsertCommand="ETPENALTYAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="ETPENID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="ETPENID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ETPENID" Type="Int32" />
            <asp:Parameter Name="ETPENCODE" Type="String" />
            <asp:Parameter Name="ETPENNAME" Type="String" />
            <asp:Parameter Name="ETADMIN" Type="Decimal" />
            <asp:Parameter Name="ETPENALTY" Type="Decimal" />
            <asp:Parameter Name="ETUSED" Type="Byte" />
            <asp:Parameter Name="REMARK" Type="String" />
            <asp:Parameter Name="BOOKFROM" Type="String" />
            <asp:Parameter Name="BOOKTO" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="ETPENCODE" Type="String" />
            <asp:Parameter Name="ETPENNAME" Type="String" />
            <asp:Parameter Name="ETADMIN" Type="Decimal" />
            <asp:Parameter Name="ETPENALTY" Type="Decimal" />
            <asp:Parameter Name="ETUSED" Type="Byte" />
            <asp:Parameter Name="REMARK" Type="String" />
            <asp:Parameter Name="BOOKFROM" Type="String" />
            <asp:Parameter Name="BOOKTO" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsETUsed" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS CODE, '[ET USED]' AS ETUSED UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS ETUSED FROM PARAMGLOBAL WHERE (TYPE = 'ETUSED')">
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
</script>

</asp:Content>

