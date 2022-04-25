<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="CollateralActivity.aspx.vb" Inherits="Param_CollateralActivity" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
 
 <table cellpadding="0" cellspacing="0" style="width: 100%;">
        <tr>
            <td style="width: 118px">
                <asp:DropDownList ID="ddlCriteria" runat="server">
                    <asp:ListItem Value="COLLACTNAME">Collateral Name</asp:ListItem>
                    <asp:ListItem Value="COLLACTCODE">Collateral Code</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
                ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
                border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
                Text="Search" CausesValidation="False" CssClass="Search" /><br />
            </td>
        </tr>
        <tr>
            <td style="width: 118px">
                Product
            </td>
            <td>
            <asp:DropDownList ID="ddlProductSearch" runat="server" AutoPostBack="True" 
                    DataSourceID="sdsProductSearch" DataTextField="PRODUCTNAME" 
                    DataValueField="PRODUCTID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsProductSearch" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    SelectCommand="SELECT NULL AS PRODUCTID, '[SHOW ALL PRODUCT]' AS PRODUCTNAME UNION ALL SELECT PRODUCTID, '(' + PRODUCTCODE + ') ' + PRODUCTNAME AS PRODUCTNAME FROM PRODUCT WHERE (Deletests = 0)">
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>

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
            DataKeyNames="COLLACTID" Caption="Collateral Activity List" 
            RowHeaderColumn="CITYID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="25px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="COLLACTID" HeaderText="ID" HtmlEncode="False"
                    SortExpression="COLLACTID">
                    <ItemStyle HorizontalAlign="Center" Width="60px" />
                </asp:BoundField>
                <asp:BoundField DataField="COLLACTCODE" HeaderText="Collateral&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="COLLACTCODE" />
                <asp:BoundField DataField="COLLACTNAME" HeaderText="Collateral&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="COLLACTNAME" />
                <asp:BoundField DataField="COLLACTFEE" DataFormatString="{0:n}" 
                    HeaderText="Collateral&lt;br&gt;Fee" HtmlEncode="False" 
                    SortExpression="COLLACTFEE">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="PRODUCTNAME" HeaderText="Product" 
                    SortExpression="PRODUCTNAME" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        SelectCommand="SELECT COLLATERALACTIVITY.COLLACTID, COLLATERALACTIVITY.COLLACTCODE, COLLATERALACTIVITY.COLLACTNAME, COLLATERALACTIVITY.COLLACTFEE, '(' + PRODUCT.PRODUCTCODE + ') ' + PRODUCT.PRODUCTNAME AS PRODUCTNAME, PRODUCT.PRODUCTID FROM COLLATERALACTIVITY LEFT OUTER JOIN PRODUCT ON COLLATERALACTIVITY.PRODUCTID = PRODUCT.PRODUCTID WHERE (COLLATERALACTIVITY.Deletests = 0) AND (PRODUCT.Deletests = 0)"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="744px" Font-Bold="False" 
        style="text-align: center" CssClass="ErrHighLight" Visible="False" 
        Height="16px"></asp:Label>
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
        DefaultMode="Edit" Width="100%" DataKeyNames="COLLACTID">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Collateral ID</td>
                    <td>
                        <asp:Label ID="lblCollateralID" runat="server" Text='<%# Bind("COLLACTID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Collateral Code</td>
                    <td>
                        <asp:TextBox ID="txtCollateralCode" runat="server" Width="56px" MaxLength="10" 
                            Text='<%# Bind("COLLACTCODE") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtCollateralCode" 
                            Display="None" ErrorMessage="Collateral Code must be entry...!" 
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Collateral Name</td>
                    <td>
                        <asp:TextBox ID="txtCollateralName" runat="server" Width="264px" MaxLength="70" 
                            Text='<%# Bind("COLLACTNAME") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtCollateralName" 
                            Display="None" ErrorMessage="Collateral Name must be entry...!" 
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Collateral Fee</td>
                    <td>
                        <asp:TextBox ID="txtCollateralFee" runat="server" CssClass="required" 
                            MaxLength="20" Text='<%# Bind("COLLACTFEE", "{0:N}") %>' Width="120px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqFee" runat="server" 
                            ControlToValidate="txtCollateralFee" Display="None" 
                            ErrorMessage="Collateral Fee must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqFee_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqFee">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Product
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlProduct" runat="server" CssClass="required" 
                            DataSourceID="sdsProduct" DataTextField="PRODUCTNAME" 
                            DataValueField="PRODUCTID" SelectedValue='<%# Bind("PRODUCTID") %>'>
                        </asp:DropDownList>
                          <asp:RequiredFieldValidator ID="reqProduct" runat="server" 
                            ControlToValidate="ddlProduct" Display="None" 
                            ErrorMessage="Product must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="VCEProduct" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqProduct">
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
                        Collateral Code</td>
                    <td>
                        <asp:TextBox ID="txtCollateralCode" runat="server" Width="56px" MaxLength="10" 
                            Text='<%# Bind("COLLACTCODE") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtCollateralCode" 
                            Display="None" ErrorMessage="Collateral Code must be entry...!" 
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Collateral Name</td>
                    <td>
                        <asp:TextBox ID="txtCollateralName" runat="server" Width="264px" MaxLength="70" 
                            Text='<%# Bind("COLLACTNAME") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtCollateralName" 
                            Display="None" ErrorMessage="Collateral Name must be entry...!" 
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Collateral Fee</td>
                    <td>
                        <asp:TextBox ID="txtCollateralFee" runat="server" CssClass="required" 
                            MaxLength="20" Text='<%# Bind("COLLACTFEE", "{0:N}") %>' Width="120px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqFee" runat="server" 
                            ControlToValidate="txtCollateralFee" Display="None" 
                            ErrorMessage="Collateral Fee must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqFee_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqFee">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Product
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlProduct" runat="server" CssClass="required" 
                            DataSourceID="sdsProduct" DataTextField="PRODUCTNAME" 
                            DataValueField="PRODUCTID" SelectedValue='<%# Bind("PRODUCTID") %>'>
                        </asp:DropDownList>
                          <asp:RequiredFieldValidator ID="reqProduct" runat="server" 
                            ControlToValidate="ddlProduct" Display="None" 
                            ErrorMessage="Product must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="VCEProduct" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqProduct">
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
        
        SelectCommand="SELECT COLLACTID, COLLACTCODE, COLLACTNAME, COLLACTFEE, PRODUCTID FROM COLLATERALACTIVITY WHERE (Deletests = 0) AND (COLLACTID = @COLLACTID)" 
        DeleteCommand="UPDATE COLLATERALACTIVITY SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID WHERE COLLACTID=@COLLACTID" 
        UpdateCommand="COLLATERALACTIVITYUpdate" InsertCommand="COLLATERALACTIVITYAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="COLLACTID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="COLLACTID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="COLLACTID" Type="Int32" />
            <asp:Parameter Name="COLLACTCODE" Type="String" />
            <asp:Parameter Name="COLLACTNAME" Type="String" />
            <asp:Parameter Name="COLLACTFEE" Type="Decimal" />
            <asp:Parameter Name="PRODUCTID" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="COLLACTCODE" Type="String" />
            <asp:Parameter Name="COLLACTNAME" Type="String" />
            <asp:Parameter Name="COLLACTFEE" Type="Decimal" />
            <asp:Parameter Name="PRODUCTID" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsProduct" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand="SELECT NULL AS PRODUCTID, NULL AS PRODUCTCODE, '[SELECT PRODUCT]' AS PRODUCTNAME
UNION ALL
SELECT PRODUCTID, PRODUCTCODE, '(' + PRODUCTCODE + ') ' + PRODUCTNAME AS PRODUCTNAME
FROM PRODUCT"></asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>")
</script>
</asp:Content>

