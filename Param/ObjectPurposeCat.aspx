<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ObjectPurposeCat.aspx.vb" Inherits="Param_ObjectPurposeCat" EnableEventValidation="false" %>
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
                    <asp:ListItem Value="PurposeName">Purpose Name</asp:ListItem>
                    <asp:ListItem Value="PurposeCode">Purpose Code</asp:ListItem>
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
            <td style="width: 118px">
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
        <tr>
            <td style="width: 118px">
                Purpose Category</td>
            <td>
                <asp:DropDownList ID="ddlPurposeCategorySearch" runat="server" AutoPostBack="True" 
                    DataSourceID="sdsProductCategorySearch" DataTextField="PURPOSECATNAME" 
                    DataValueField="PURPOSECATID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsProductCategorySearch" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    
                    SelectCommand="SELECT NULL AS PURPOSECATID, '[DISPLAY ALL]' AS PURPOSECATNAME UNION ALL SELECT PURPOSECATID, '(' + PURPOSECATCODE + ') ' + PURPOSECATNAME AS PURPOSECATNAME FROM OBJECTPURPOSECAT WHERE (DELETESTS = 0)">
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
            DataKeyNames="PURPOSECATID" Caption="Object Purpose Category List" 
            RowHeaderColumn="PURPOSEID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="25px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="PURPOSECATID" 
                    HeaderText="ID" HtmlEncode="False"
                    ReadOnly="True" SortExpression="PURPOSECATID">
                    <ItemStyle HorizontalAlign="Center" Width="60px" />
                </asp:BoundField>
                <asp:BoundField DataField="PURPOSECATCODE" 
                    HeaderText="Purpose Category&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="PURPOSECATCODE" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="PURPOSECATNAME" 
                    HeaderText="Purpose Category&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="PURPOSECATNAME" />
                <asp:BoundField DataField="PRODUCTNAME" HeaderText="Product" 
                    SortExpression="PRODUCTNAME" />
                <asp:BoundField DataField="PURPOSECATNAME" 
                    HeaderText="Purpose&lt;br&gt;Category" HtmlEncode="False" 
                    SortExpression="PURPOSECATNAME" />
            </Columns>
            <EmptyDataTemplate>
                &nbsp;<uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT OBJECTPURPOSECAT.PURPOSECATID, OBJECTPURPOSECAT.PURPOSECATCODE, OBJECTPURPOSECAT.PURPOSECATNAME, '(' + PRODUCT.PRODUCTCODE + ') ' + PRODUCT.PRODUCTNAME AS PRODUCTNAME FROM OBJECTPURPOSECAT LEFT OUTER JOIN PRODUCT ON OBJECTPURPOSECAT.PRODUCTID = PRODUCT.PRODUCTID WHERE (OBJECTPURPOSECAT.DELETESTS = 0)"></asp:SqlDataSource>
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
        DefaultMode="Edit" Width="100%" DataKeyNames="PURPOSECATID">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Purpose Category ID</td>
                    <td>
                        <asp:Label ID="lblPurposeID" runat="server" Text='<%# Eval("PURPOSECATID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Purpose Category Code</td>
                    <td>
                        <asp:TextBox ID="txtCode" runat="server" Width="56px" MaxLength="5" 
                            Text='<%# Bind("PURPOSECATCODE") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtCode" Display="None" 
                            ErrorMessage="[PRODUCT CODE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Purpose Category Name</td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" Width="264px" MaxLength="30" 
                            Text='<%# Bind("PURPOSECATNAME") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtName" Display="None" 
                            ErrorMessage="[PRODUCT NAME] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Product</td>
                    <td>
                        <asp:DropDownList ID="ddlProduct" runat="server" CssClass="required" 
                            DataSourceID="sdsProduct" DataTextField="PRODUCTNAME" 
                            DataValueField="PRODUCTID" SelectedValue='<%# Bind("PRODUCTID") %>'>
                        </asp:DropDownList>
                    </td>
                </tr>
              
                <tr>
                    <td>
                        &nbsp;</td>
                    <td>
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
                        Purpose Category Code</td>
                    <td>
                        <asp:TextBox ID="txtCode" runat="server" Width="56px" MaxLength="5" 
                            Text='<%# Bind("PURPOSECATCODE") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtCode" Display="None" 
                            ErrorMessage="[PRODUCT CODE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Purpose Category Name</td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" Width="264px" MaxLength="30" 
                            Text='<%# Bind("PURPOSECATNAME") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtName" Display="None" 
                            ErrorMessage="[PRODUCT NAME] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Product</td>
                    <td>
                        <asp:DropDownList ID="ddlProduct" runat="server" CssClass="required" 
                            DataSourceID="sdsProduct" DataTextField="PRODUCTNAME" 
                            DataValueField="PRODUCTID" SelectedValue='<%# Bind("PRODUCTID") %>'>
                        </asp:DropDownList>
                    </td>
                </tr>
              
                <tr>
                    <td>
                        &nbsp;</td>
                    <td>
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
        
        SelectCommand="SELECT PURPOSECATID, PURPOSECATCODE, PURPOSECATNAME, (SELECT PRODUCTID FROM PRODUCT WHERE (PRODUCTID = OBJECTPURPOSECAT.PRODUCTID) AND (Deletests = 0)) AS PRODUCTID FROM OBJECTPURPOSECAT WHERE (PURPOSECATID = @PURPOSECATID)" 
        DeleteCommand="UPDATE OBJECTPURPOSECAT SET DELETESTS = 1, LASTUSERID = @UserID, LASTUPDATE = GETDATE() WHERE (PURPOSECATID = @PURPOSECATID)" 
        UpdateCommand="OBJECTPURPOSECATUpdate" InsertCommand="OBJECTPURPOSECATAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure" 
        ProviderName="<%$ ConnectionStrings:connection.ProviderName %>">
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="UserID" />
            <asp:Parameter Name="PURPOSECATID" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="PURPOSECATID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="PRODUCTID" Type="Int32" />
            <asp:Parameter Name="PURPOSECATCODE" Type="String" />
            <asp:Parameter Name="PURPOSECATNAME" Type="String" />
            <asp:Parameter Name="PURPOSECATID" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="PURPOSECATCODE" Type="String" />
            <asp:Parameter Name="PURPOSECATNAME" Type="String" />
            <asp:Parameter Name="PRODUCTID" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
    <asp:SqlDataSource ID="sdsProduct" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand="SELECT NULL AS PRODUCTID, NULL AS PRODUCTCODE, '[SELECT PRODUCT]' AS PRODUCTNAME
UNION ALL
SELECT PRODUCTID, PRODUCTCODE, '(' + PRODUCTCODE + ') ' + PRODUCTNAME AS PRODUCTNAME
FROM PRODUCT"></asp:SqlDataSource>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
    
</script>

</asp:Content>

