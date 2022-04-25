<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="Merk.aspx.vb" Inherits="Param_Merk" title="Merk/Branch" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <table style="width:100%;" cellpadding="0" cellspacing="0" >
        <tr>
            <td style="width: 142px">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="ProductCode">Product Code</asp:ListItem>
        <asp:ListItem Value="ProductName">Product Name</asp:ListItem>
        <asp:ListItem Value="MerkName">Merk/Brand Name</asp:ListItem>
        <asp:ListItem Value="MerkCode">Merk/Brand Code</asp:ListItem>
    </asp:DropDownList>
            </td>
            <td>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox>
    <ajaxToolkit:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
    
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
            <td style="width: 142px">
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
    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False" CssClass="New" />
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
            DataKeyNames="MERKID" Caption="MERK/BRAND LIST" RowHeaderColumn="MERKID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="25px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:TemplateField HeaderText="MODEL">
                    <ItemTemplate>                        
                        <img src="../Images/car.gif" style="cursor: pointer" alt="Model : <%#eval("MERKCODE")%>" onclick="ModelEdit(<%#eval("MERKID")%>)" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                </asp:TemplateField>
                <asp:BoundField DataField="MERKID" HeaderText="ID" HtmlEncode="False"
                    ReadOnly="True" SortExpression="MERKID">
                    <ItemStyle HorizontalAlign="Center" Width="60px" />
                </asp:BoundField>
                <asp:BoundField DataField="MERKCODE" HeaderText="Merk&lt;br&gt;Code" 
                    HtmlEncode="False" SortExpression="MERKCODE" />
                <asp:BoundField DataField="MERKNAME" HeaderText="Merk&lt;br&gt;Name" 
                    HtmlEncode="False" SortExpression="MERKNAME" />
                <asp:BoundField DataField="productName" HeaderText="Product&lt;br&gt;Name" 
                    HtmlEncode="False" SortExpression="productName" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                SelectCommand="SELECT MERK.PRODUCTID, PRODUCT.PRODUCTCODE, '(' + PRODUCT.PRODUCTCODE + ') ' + PRODUCT.PRODUCTNAME AS PRODUCTNAME, MERK.MERKID, MERK.MERKCODE, MERK.MERKNAME FROM MERK LEFT OUTER JOIN PRODUCT ON PRODUCT.PRODUCTID = MERK.PRODUCTID WHERE (MERK.Deletests = 0)"></asp:SqlDataSource>
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
        DefaultMode="Edit" Width="100%" DataKeyNames="MERKID">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Merk ID</td>
                    <td>
                        <asp:Label ID="lblMerkID" runat="server" Text='<%# Eval("MERKID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Product</td>
                    <td>
                        <asp:DropDownList ID="ddlProductID" runat="server" DataSourceID="sdsProductName" 
                            DataTextField="PRODUCTNAME" DataValueField="PRODUCTID" 
                            SelectedValue='<%# Bind("PRODUCTID") %>' CssClass="required">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqProductName" runat="server" 
                            ControlToValidate="ddlProductID" Display="None" 
                            ErrorMessage="[PRODUCT] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqProductName_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqProductName">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Merk Code</td>
                    <td>
                        <asp:TextBox ID="txtMerkCode" runat="server" Width="56px" MaxLength="10" Text='<%# Bind("MERKCODE") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtMerkCode" Display="None" ErrorMessage="[MERK/BRAND CODE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Merk Name</td>
                    <td>
                        <asp:TextBox ID="txtMerkName" runat="server" Width="264px" MaxLength="50" Text='<%# Bind("MERKNAME") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtMerkName" Display="None" ErrorMessage="[MERK/BRAND NAME] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
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
                        Merk ID</td>
                    <td>
                        <asp:Label ID="lblMerkID" runat="server" Text='<%# Eval("MERKID") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        Product</td>
                    <td>
                        <asp:DropDownList ID="ddlProductID" runat="server" CssClass="required" 
                            DataSourceID="sdsProductName" DataTextField="PRODUCTNAME" 
                            DataValueField="PRODUCTID" SelectedValue='<%# Bind("PRODUCTID") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqProductName" runat="server" 
                            ControlToValidate="ddlProductID" Display="None" 
                            ErrorMessage="[PRODUCT] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqProductName_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqProductName">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Merk Code</td>
                    <td>
                        <asp:TextBox ID="txtMerkCode" runat="server" CssClass="required" MaxLength="10" 
                            Text='<%# Bind("MERKCODE") %>' Width="56px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqCode" runat="server" 
                            ControlToValidate="txtMerkCode" Display="None" 
                            ErrorMessage="[MERK/BRAND CODE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECode" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Merk Name</td>
                    <td>
                        <asp:TextBox ID="txtMerkName" runat="server" CssClass="required" MaxLength="50" Text='<%# Bind("MERKNAME") %>'
                            Width="264px"></asp:TextBox><asp:RequiredFieldValidator ID="reqName" runat="server"
                                ControlToValidate="txtMerkName" Display="None" ErrorMessage="[MERK/BRAND NAME] must be entry...!"
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
        SelectCommand="SELECT MERKID, MERKCODE, MERKNAME, (SELECT PRODUCTID FROM PRODUCT WHERE (MERK.PRODUCTID = PRODUCTID) AND (Deletests = 0)) AS PRODUCTID FROM MERK WHERE (MERKID = @MERKID)" 
        DeleteCommand="UPDATE MERK SET DELETESTS = 1, LASTUSERID = @UserID, LASTUPDATE = GETDATE() WHERE (MERKID = @MERKID)" 
        UpdateCommand="MERKUpdate" InsertCommand="MERKAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="MERKID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="UserID" />
            <asp:Parameter Name="MERKID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="PRODUCTID" Type="Int32" />
            <asp:Parameter Name="MERKID" Type="Int32" />
            <asp:Parameter Name="MERKCode" Type="String" />
            <asp:Parameter Name="MERKName" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="PRODUCTID" Type="Int32" />
            <asp:Parameter Name="MERKCode" Type="String" />
            <asp:Parameter Name="MERKName" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
    <asp:SqlDataSource ID="sdsProductName" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        
        SelectCommand="SELECT NULL AS PRODUCTID, NULL AS PRODUCTCODE, '[SELECT PRODUCT]' AS PRODUCTNAME UNION ALL SELECT PRODUCTID, PRODUCTCODE, '(' + PRODUCTCODE + ') ' + PRODUCTNAME AS PRODUCTNAME FROM PRODUCT WHERE (Deletests = 0) ORDER BY PRODUCTCODE">
    </asp:SqlDataSource>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
function ModelEdit(MerkID) {
    window.location="Model.aspx?MerkID=" + MerkID + "&Action=Edit"
}
</script>

</asp:Content>

