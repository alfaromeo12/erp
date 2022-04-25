<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="Product.aspx.vb" Inherits="Param_Product" title="PRODUCT" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="ProductName">Product Name</asp:ListItem>
        <asp:ListItem Value="PRODUCTCODE">Product Code</asp:ListItem>
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
            DataKeyNames="PRODUCTID" Caption="Product List" 
            RowHeaderColumn="PRODUCTID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="25px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="PRODUCTID" HeaderText="ID" HtmlEncode="False"
                    ReadOnly="True" SortExpression="PRODUCTID">
                    <ItemStyle HorizontalAlign="Center"/>
                </asp:BoundField>
                
                <asp:BoundField DataField="PRODUCTCODE" HeaderText="Product&lt;br&gt;Code" HtmlEncode="False" 
                    SortExpression="PRODUCTCODE" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="PRODUCTTYPENAME" HeaderText="Product&lt;br&gt;Type" HtmlEncode="False"
                    SortExpression="PRODUCTTYPENAME" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="PRODUCTNAME" HeaderText="Product&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="PRODUCTNAME" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <EmptyDataTemplate>
                &nbsp;<uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT P.PRODUCTID AS PRODUCTID, P.PRODUCTCODE AS PRODUCTCODE,PT.PRODUCTTYPEID AS PRODUCTTYPEID , PT.PRODUCTTYPENAME AS PRODUCTTYPENAME,
                        P.PRODUCTNAME AS PRODUCTNAME FROM PRODUCT P
                        LEFT OUTER JOIN PRODUCTTYPE PT ON P.PRODUCTTYPEID = PT.PRODUCTTYPEID
                        WHERE (P.Deletests = 0)">

    </asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="600px" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
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
        DefaultMode="Edit" Width="100%" DataKeyNames="PRODUCTID">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="6">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Product ID</td>
                    <td>
                        <asp:Label ID="lblProductID" runat="server" Text='<%# Eval("PRODUCTID") %>'></asp:Label></td>
                </tr>
                 
                <tr>
                    <td>
                        Product Code</td>
                    <td>
                        <asp:TextBox ID="txtCode" runat="server" MaxLength="20" Text='<%# Bind("PRODUCTCODE") %>'
                            Width="56px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqCode" runat="server" ControlToValidate="txtCode" Display="None" ErrorMessage="[PRODUCT CODE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                 <tr>
                        <td>Product Type &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlProductType" runat="server" DataSourceID="sdsProductType" CssClass="required"
                                DataTextField="PRODUCTTYPENAME" DataValueField="PRODUCTTYPEID" SelectedValue='<%# Bind("PRODUCTTYPEID")%>'>
                            </asp:DropDownList><asp:RequiredFieldValidator
                                ID="reqType" runat="server" ControlToValidate="ddlProductType" Display="None" ErrorMessage="Product Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaVCEType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqType">
                                </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                <tr>
                    <td>
                        Product Name</td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" Width="264px" MaxLength="30" 
                            Text='<%# Bind("PRODUCTNAME") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtName" Display="None" 
                            ErrorMessage="[PRODUCT NAME] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                 <tr>
                        <td>Description Product &nbsp; &nbsp;&nbsp; &nbsp;</td>
                         <td>
                             <asp:TextBox ID="txtDescProduct" runat="server" MaxLength="255" Text='<%# Bind("DESCRIPTION")%>' TextMode="MultiLine" Width="260px"></asp:TextBox>
                         </td>
                    </tr>
                <tr>
                    <td colspan="6">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="6" class="FooterStyle">
                        <uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
                        &nbsp;<uc2:BtnDelete ID="BtnDelete1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <hr />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="6">
                        <hr />
                    </td>
                </tr>
                
                <tr>
                    <td>
                        Product Code</td>
                    <td>
                        <asp:TextBox ID="txtCode" runat="server" MaxLength="20" Text='<%# Bind("PRODUCTCODE") %>'
                            Width="56px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqCode"
                                runat="server" ControlToValidate="txtCode" Display="None" 
                            ErrorMessage="[PRODUCT CODE] must be entry...!" SetFocusOnError="True" 
                            Text='<%# Eval("PRODUCTCODE") %>'></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                        <td>Product Type &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlProductType" runat="server" DataSourceID="sdsProductType" CssClass="required"
                                DataTextField="PRODUCTTYPENAME" DataValueField="PRODUCTTYPEID" SelectedValue='<%# Bind("PRODUCTTYPEID")%>'>
                            </asp:DropDownList><asp:RequiredFieldValidator
                                ID="reqType" runat="server" ControlToValidate="ddlProductType" Display="None" ErrorMessage="Product Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaVCEType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqType">
                                </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                <tr>
                    <td>
                        Product Name</td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" MaxLength="30" Text='<%# Bind("PRODUCTNAME") %>'
                            Width="264px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqName"
                                runat="server" ControlToValidate="txtName" Display="None" 
                            ErrorMessage="[PRODUCT NAME] must be entry...!" SetFocusOnError="True" 
                            Text='<%# Eval("PRODUCTNAME") %>'></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                 <tr>
                        <td>Description Product &nbsp; &nbsp;&nbsp; &nbsp;</td>
                         <td>
                             <asp:TextBox ID="txtDescProduct" runat="server" MaxLength="255" Text='<%# Bind("DESCRIPTION")%>' TextMode="MultiLine" Width="260px"></asp:TextBox>
                         </td>
                    </tr>
                <tr>
                    <td colspan="6" style="height: 19px">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="6" class="FooterStyle">
                        <uc4:BtnInsert ID="BtnInsert2" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel2" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <hr />
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsProductType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand=" SELECT NULL AS PRODUCTTYPEID, '[DISPLAY ALL]' AS PRODUCTTYPENAME UNION ALL 
                                        SELECT PRODUCTTYPEID, PRODUCTTYPENAME FROM PRODUCTTYPE WHERE (DELETESTS= 0) ORDER BY PRODUCTTYPENAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand="SELECT P.PRODUCTID AS PRODUCTID, P.PRODUCTCODE AS PRODUCTCODE,PT.PRODUCTTYPEID AS PRODUCTTYPEID , PT.PRODUCTTYPENAME AS PRODUCTTYPENAME,
                        P.PRODUCTNAME AS PRODUCTNAME FROM PRODUCT P
                        LEFT OUTER JOIN PRODUCTTYPE PT ON P.PRODUCTTYPEID = PT.PRODUCTTYPEID WHERE P.PRODUCTID=@PRODUCTID" 
        DeleteCommand="UPDATE PRODUCT SET Deletests = 1, LastUserID = @UserID, LastUpdate = GETDATE() WHERE (PRODUCTID = @PRODUCTID)" 
        UpdateCommand="ProductUpdate" InsertCommand="ProductAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure" 
        ProviderName="<%$ ConnectionStrings:connection.ProviderName %>">
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="UserID" />
            <asp:Parameter Name="PRODUCTID" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="PRODUCTID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="PRODUCTID" Type="Int32" />
            <asp:Parameter Name="PRODUCTCODE" Type="String" />
            <asp:Parameter Name="PRODUCTTYPEID" Type="Int32" />
            <asp:Parameter Name="PRODUCTNAME" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="PRODUCTCODE" Type="String" />
            <asp:Parameter Name="PRODUCTTYPEID" Type="String" />
            <asp:Parameter Name="PRODUCTName" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
</script>

</asp:Content>

