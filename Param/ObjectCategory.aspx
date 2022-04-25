<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ObjectCategory.aspx.vb" Inherits="Param_ObjectCategory" title="OBJECTCATEGORY" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <table cellpadding="0" cellspacing="0" style="width: 100%;">
        <tr>
            <td style="width: 123px">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="CategoryName">Category Name</asp:ListItem>
        <asp:ListItem Value="CategoryCode">Category Code</asp:ListItem>
    </asp:DropDownList>
            </td>
            <td>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox>
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
                <asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" />
            </td>
        </tr>
        <tr>
            <td style="width: 123px">
                Product</td>
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
            DataKeyNames="CATEGORYID" Caption="Category List" 
            RowHeaderColumn="CategoryID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="25px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="CategoryID" HeaderText="ID" HtmlEncode="False"
                    ReadOnly="True" SortExpression="CategoryID">
                    <ItemStyle HorizontalAlign="Center" Width="60px" />
                </asp:BoundField>
                <asp:BoundField DataField="CategoryCode" HeaderText="Category&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="CategoryCode" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="CategoryNAME" HeaderText="Category&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="CategoryNAME" />
                <asp:BoundField DataField="PRODUCTNAME" HeaderText="Product" 
                    HtmlEncode="False" SortExpression="PRODUCTNAME" />
            </Columns>
            <EmptyDataTemplate>
                &nbsp;<uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        
        SelectCommand="SELECT OBJECTCATEGORY.CATEGORYID, OBJECTCATEGORY.CATEGORYCODE, OBJECTCATEGORY.CATEGORYNAME, OBJECTCATEGORY.PRODUCTID, '(' + PRODUCT.PRODUCTCODE + ') ' + PRODUCT.PRODUCTNAME AS PRODUCTNAME FROM OBJECTCATEGORY LEFT OUTER JOIN PRODUCT ON PRODUCT.PRODUCTID = OBJECTCATEGORY.PRODUCTID WHERE (OBJECTCATEGORY.Deletests = 0)"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" 
        style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
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
        DefaultMode="Edit" Width="100%" DataKeyNames="CATEGORYID">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Category ID</td>
                    <td>
                        <asp:Label ID="lblCategoryID" runat="server" Text='<%# Eval("CATEGORYID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Category Code</td>
                    <td>
                        <asp:TextBox ID="txtCode" runat="server" Width="56px" MaxLength="5" 
                            Text='<%# Bind("CATEGORYCODE") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtCode" Display="None" 
                            ErrorMessage="[PRODUCT CODE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Category Name</td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" Width="264px" MaxLength="30" 
                            Text='<%# Bind("CATEGORYNAME") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtName" Display="None" 
                            ErrorMessage="[PRODUCT NAME] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Maximum Age</td>
                    <td>
                        <asp:TextBox ID="txtMaxAge" runat="server" MaxLength="5" 
                            Text='<%# Bind("MAXAGEOBJ") %>' Width="56px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Product</td>
                    <td>
                        <asp:DropDownList ID="ddlProduct" runat="server" CssClass="required" 
                            DataSourceID="sdsProductName" DataTextField="PRODUCTNAME" 
                            DataValueField="PRODUCTID" SelectedValue='<%# Bind("PRODUCTID") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqProduct" runat="server" 
                            ControlToValidate="ddlProduct" Display="None" 
                            ErrorMessage="[PRODUCT NAME] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqProduct_ValidatorCalloutExtender" 
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
                        Category Code</td>
                    <td>
                        <asp:TextBox ID="txtCode" runat="server" MaxLength="5" Text='<%# Bind("CATEGORYCODE") %>'
                            Width="56px" CssClass="required"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqCode"
                                runat="server" ControlToValidate="txtCode" Display="None" 
                            ErrorMessage="CATEGORY CODE must be entry...!" SetFocusOnError="True" 
                            Text='<%# Eval("PRODUCTCODE") %>'></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Category Name</td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" MaxLength="30" Text='<%# Bind("CATEGORYNAME") %>'
                            Width="264px" CssClass="required"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqName"
                                runat="server" ControlToValidate="txtName" Display="None" 
                            ErrorMessage="CATEGORY NAME must be entry...!" SetFocusOnError="True" 
                            Text='<%# Eval("PRODUCTNAME") %>'></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Maximum Age</td>
                    <td>
                        <asp:TextBox ID="txtMaxAge" runat="server" MaxLength="5" 
                            Text='<%# Bind("MAXAGEOBJ") %>' Width="56px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Product</td>
                    <td>
                        <asp:DropDownList ID="ddlProduct" runat="server" CssClass="required" 
                            DataSourceID="sdsProductName" DataTextField="PRODUCTNAME" 
                            DataValueField="PRODUCTID" SelectedValue='<%# Bind("PRODUCTID") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqProduct" runat="server" 
                            ControlToValidate="ddlProduct" Display="None" 
                            ErrorMessage="[PRODUCT NAME] must be entry...!" SetFocusOnError="True" 
                            Text='<%# Eval("PRODUCTNAME") %>'></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqProduct_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqProduct">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 19px">
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
        
        SelectCommand="SELECT CATEGORYID, CATEGORYCODE, CATEGORYNAME, MAXAGEOBJ, (SELECT PRODUCTID FROM PRODUCT WHERE (PRODUCTID = OBJECTCATEGORY.PRODUCTID) AND (Deletests = 0)) AS PRODUCTID FROM OBJECTCATEGORY WHERE (CATEGORYID = @CATEGORYID)" 
        DeleteCommand="UPDATE OBJECTCATEGORY SET Deletests = 1, LastUserID = @UserID, LastUpdate = GETDATE() WHERE (CATEGORYID = @CATEGORYID)" 
        UpdateCommand="ObjectCategoryUpdate" InsertCommand="ObjectCategoryAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure" 
        
        
        ProviderName="<%$ ConnectionStrings:connection.ProviderName %>">
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="UserID" />
            <asp:Parameter Name="CATEGORYID" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="CATEGORYID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="CATEGORYID" Type="Int32" />
            <asp:Parameter Name="CATEGORYCODE" Type="String" />
            <asp:Parameter Name="CATEGORYNAME" Type="String" />
            <asp:Parameter Name="MAXAGEOBJ" Type="Int32" />
            <asp:Parameter Name="PRODUCTID" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="CATEGORYCODE" Type="String" />
            <asp:Parameter Name="CATEGORYNAME" Type="String" />
            <asp:Parameter Name="MAXAGEOBJ" Type="Int32" />
            <asp:Parameter Name="PRODUCTID" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
    <asp:SqlDataSource ID="sdsProductName" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        SelectCommand="SELECT NULL AS PRODUCTID, NULL AS PRODUCTCODE, '[SELECT PRODUCT]' AS PRODUCTNAME UNION ALL SELECT PRODUCTID, PRODUCTCODE, + '(' + PRODUCTCODE + ') ' + PRODUCTNAME AS PRODUCTNAME FROM PRODUCT WHERE (Deletests = 0) ORDER BY PRODUCTCODE">
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
</script>
</asp:Content>

