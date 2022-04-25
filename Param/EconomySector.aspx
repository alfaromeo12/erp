<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="EconomySector.aspx.vb" Inherits="Param_Economy" title="Economy Sector" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="ECONAME">NAME</asp:ListItem>
        <asp:ListItem Value="ECOCODE">CODE</asp:ListItem>
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
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="100%" 
            DataKeyNames="ECOID" Caption="Economy Sector" RowHeaderColumn="ECOID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="20px" />
                </asp:CommandField>
                <asp:BoundField DataField="ECOID" HeaderText="Eco&lt;br&gt;ID" HtmlEncode="False"
                    ReadOnly="True" SortExpression="ECOID">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="ECOCODE" HeaderText="Economy&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="ECOCODE" />
                <asp:BoundField DataField="ECOCODEBI" HeaderText="Economy&lt;br&gt;Code(BI)" HtmlEncode="False"
                    SortExpression="ECOCODEBI" />
                <asp:BoundField DataField="ECONAME" HeaderText="Economy&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="ECONAME" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT ECOID, ECOCODE, ECONAME, ECOCODEBI FROM ECONOMYCODE WHERE (DELETESTS = 0)"></asp:SqlDataSource>
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
        DefaultMode="Edit" Width="100%" DataKeyNames="ECOID">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Economy ID</td>
                    <td>
                        <asp:Label ID="lblEcoID" runat="server" Text='<%# Eval("ECOID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Economy Code</td>
                    <td>
                        <asp:TextBox ID="txtEcoCode" runat="server" Width="56px" MaxLength="10" Text='<%# Bind("ECOCODE") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtEcoCode" Display="None" ErrorMessage="Economy Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td style="height: 19px">
                        Economy Code (BI)</td>
                    <td style="height: 19px">
                        <asp:TextBox ID="txtEcoCodeBI" runat="server" CssClass="required" MaxLength="10"
                            Text='<%# Bind("ECOCODEBI") %>' Width="56px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqCodeBI" runat="server" ControlToValidate="txtEcoCodeBI" Display="None"
                                ErrorMessage="Economy Code (BI) must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECodeBI" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCodeBI">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Economy Name</td>
                    <td>
                        <asp:TextBox ID="txtEcoName" runat="server" Width="438px" MaxLength="1000" 
                            Text='<%# Bind("ECONAME") %>' CssClass="required" Height="48px" 
                            TextMode="MultiLine"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtEcoName" Display="None" ErrorMessage="Economy Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
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
                        &nbsp;<uc2:BtnDelete ID="BtnDelete1" runat="server" />
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
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Economy Code</td>
                    <td>
                        <asp:TextBox ID="txtEcoCode" runat="server" CssClass="required" MaxLength="10" Text='<%# Bind("ECOCODE") %>'
                            Width="56px"></asp:TextBox><asp:RequiredFieldValidator ID="reqCode" runat="server"
                                ControlToValidate="txtEcoCode" Display="None" ErrorMessage="Economy Code must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td style="height: 19px">
                        Economy Code (BI)</td>
                    <td style="height: 19px">
                        <asp:TextBox ID="txtEcoCodeBI" runat="server" CssClass="required" MaxLength="10"
                            Text='<%# Bind("ECOCODEBI") %>' Width="56px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqCodeBI" runat="server" ControlToValidate="txtEcoCodeBI" Display="None"
                                ErrorMessage="Economy Code (BI) must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECodeBI" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCodeBI">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Economy Name</td>
                    <td>
                        <asp:TextBox ID="txtEcoName" runat="server" CssClass="required" 
                            MaxLength="1000" Text='<%# Bind("ECONAME") %>'
                            Width="480px" Height="46px" TextMode="MultiLine"></asp:TextBox><asp:RequiredFieldValidator ID="reqName" runat="server"
                                ControlToValidate="txtEcoName" Display="None" ErrorMessage="Economy Name must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" class="FooterStyle">
                        <uc4:BtnInsert ID="BtnInsert2" runat="server" />
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
        SelectCommand="SELECT ECOID, ECOCODE, ECONAME, ECOCODEBI FROM ECONOMYCODE WHERE (ECOID = @ECOID)" DeleteCommand="UPDATE ECONOMYCODE SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID WHERE ECOID=@ECOID" UpdateCommand="ECONOMYCODEUpdate" InsertCommand="ECONOMYCODEAdd" InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="ECOID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="ECOID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ECOID" Type="Int32" />
            <asp:Parameter Name="ECOCODE" Type="String" />
            <asp:Parameter Name="ECOCODEBI" Type="String" />
            <asp:Parameter Name="ECONAME" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="ECOCODE" Type="String" />
            <asp:Parameter Name="ECOCODEBI" Type="String" />
            <asp:Parameter Name="ECONAME" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
</script>

</asp:Content>

