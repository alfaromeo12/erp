<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ObjectPurpose.aspx.vb" Inherits="Param_ObjectPurpose" title="OBJECTPURPOSE" EnableEventValidation="false" %>
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
                    DataTextField="PRODUCTNAME" ValidationGroup="PurposeCat"
                    DataValueField="PRODUCTID">
                </asp:DropDownList>
                
                <ajaxToolkit:CascadingDropDown ID="ajaxCCDProduct" runat="server" Category="PRODUCTID" 
                    Enabled="True" LoadingText="[Loading Product..]" 
                    PromptText="[DISPLAY ALL]" ServiceMethod="GetDropDownProductPricing" 
                    ServicePath="~\Param\WebService.asmx" TargetControlID="ddlProductSearch">
                </ajaxToolkit:CascadingDropDown>
                       
            </td>
        </tr>
        <tr>
            <td style="width: 118px">
                Purpose Category</td>
            <td>
                <asp:DropDownList ID="ddlPurposeCategorySearch" runat="server" AutoPostBack="True" 
                    DataTextField="PURPOSECATNAME" ValidationGroup="PurposeCat"
                    DataValueField="PURPOSECATID">
                </asp:DropDownList>
                
                <ajaxToolkit:CascadingDropDown ID="ajaxCDDPurpose" runat="server" Category="ProductID" 
						LoadingText="[Loading Object Purpose..]"
                        PromptText="[DISPLAY ALL]"
						ServiceMethod="GetDropDownObjectKindByProduct" ServicePath="~\Param\WebService.asmx" 
						TargetControlID="ddlPurposeCategorySearch" ParentControlID="ddlProductSearch">
                </ajaxToolkit:CascadingDropDown>
                    
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
            DataKeyNames="PURPOSEID" Caption="Object Purpose List" 
            RowHeaderColumn="PURPOSEID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="25px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="PURPOSEID" HeaderText="ID" HtmlEncode="False"
                    ReadOnly="True" SortExpression="PURPOSEID">
                    <ItemStyle HorizontalAlign="Center" Width="60px" />
                </asp:BoundField>
                <asp:BoundField DataField="PURPOSECODE" HeaderText="Purpose&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="PURPOSECODE" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="PURPOSENAME" HeaderText="Purpose&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="PURPOSENAME" />
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
        
        
        
        
        SelectCommand="SELECT OBJECTPURPOSE.PURPOSEID, OBJECTPURPOSE.PURPOSECODE, OBJECTPURPOSE.PURPOSENAME, '(' + PRODUCT.PRODUCTCODE + ') ' + PRODUCT.PRODUCTNAME AS PRODUCTNAME, '(' + OBJECTPURPOSECAT.PURPOSECATCODE + ') ' + OBJECTPURPOSECAT.PURPOSECATNAME AS PURPOSECATNAME FROM OBJECTPURPOSECAT RIGHT OUTER JOIN OBJECTPURPOSE ON OBJECTPURPOSECAT.PURPOSECATID = OBJECTPURPOSE.PURPOSECATID LEFT OUTER JOIN PRODUCT ON OBJECTPURPOSE.PRODUCTID = PRODUCT.PRODUCTID WHERE (OBJECTPURPOSE.DELETESTS = 0)"></asp:SqlDataSource>
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
        DefaultMode="Edit" Width="100%" DataKeyNames="PURPOSEID">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Purpose ID</td>
                    <td>
                        <asp:Label ID="lblPurposeID" runat="server" Text='<%# Eval("PURPOSEID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Purpose Code</td>
                    <td>
                        <asp:TextBox ID="txtCode" runat="server" Width="56px" MaxLength="5" 
                            Text='<%# Bind("PURPOSECODE") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtCode" Display="None" 
                            ErrorMessage="[PRODUCT CODE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Purpose Name</td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" Width="264px" MaxLength="30" 
                            Text='<%# Bind("PURPOSENAME") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtName" Display="None" 
                            ErrorMessage="[PRODUCT NAME] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
               <tr>
                <td >
                    Product</td>
                <td >
                    <asp:DropDownList ID="ddlProduct" runat="server"  CssClass="required"
                        DataTextField="PRODUCTNAME" DataValueField='<%# Bind("PRODUCTID") %>'
                        ValidationGroup="PurposeCat" >
                    </asp:DropDownList>
                       <ajaxToolkit:CascadingDropDown ID="ajaxCCDProduct" runat="server" Category="PRODUCTID" 
                                Enabled="True" LoadingText="[Loading Product..]"  BehaviorID="BehavProduct"
                                ServiceMethod="GetDropDownProductPricing" SelectedValue='<%# Bind("PRODUCTID") %>'
                                ServicePath="~\Param\WebService.asmx"  TargetControlID="ddlProduct"></ajaxToolkit:CascadingDropDown>
                      <asp:RequiredFieldValidator
                            ID="reqProduct" runat="server" ControlToValidate="ddlProduct" 
                            Display="None" ErrorMessage="Product must be entry...!" 
                            SetFocusOnError="True" ValidationGroup="Pricing"></asp:RequiredFieldValidator>
                      <ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEproduct" runat="server" HighlightCssClass="ErrHighLight" 
                                TargetControlID="reqProduct"></ajaxToolkit:ValidatorCalloutExtender>
                    <asp:HiddenField ID="hidProductID" runat="server" 
                        Value='<%# Bind("PRODUCTID") %>' />
                </td>
            </tr>
                <tr>
                    <td>
                        Need Route</td>
                    <td>
                        <asp:RadioButtonList SelectedValue='<%# Bind("NEEDROUTE") %>'  
                                ID="cblQualify" runat="server" RepeatLayout="Flow" 
                                RepeatDirection="Horizontal">
                            <asp:ListItem Value="1" Text="Yes" />
                            <asp:ListItem Value="0" Text="No" />
                            <asp:ListItem Value="2" Text="Optional" />
                        </asp:RadioButtonList>
                    </td>
                </tr>
               <tr>
                <td >
                    Purpose Category</td>
                <td >
                    <asp:DropDownList ID="ddlPurpose" runat="server"
                        DataTextField="PURPOSENAME" DataValueField="PURPOSEID"
                        ValidationGroup="PurposeCat"  >
                    </asp:DropDownList>
                     <ajaxToolkit:CascadingDropDown ID="ajaxCDDPurpose" runat="server" Category="ProductID" 
                        SelectedValue='<%# Bind("PURPOSECATID") %>'
						LoadingText="[Loading Object Purpose..]"  BehaviorID="BehavObjectPurpose"
						ServiceMethod="GetDropDownObjectKindByProduct" ServicePath="~\Param\WebService.asmx" 
						TargetControlID="ddlPurpose" ParentControlID="ddlProduct"></ajaxToolkit:CascadingDropDown>
                    <asp:RequiredFieldValidator
                        ID="reqPurpose" runat="server" ControlToValidate="ddlPurpose" 
                        Display="None" ErrorMessage="Purpose Category must be entry...!" 
                        SetFocusOnError="True" ValidationGroup="Pricing"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender
                        ID="ajaxVCEPurpose" runat="server" HighlightCssClass="ErrHighLight" 
                        TargetControlID="reqPurpose"></ajaxToolkit:ValidatorCalloutExtender>
                    <asp:HiddenField ID="hidPurposeCategory" runat="server" 
                        Value='<%# Bind("PURPOSECATID") %>' />
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
                        Product Code</td>
                    <td>
                        <asp:TextBox ID="txtCode" runat="server" MaxLength="5" Text='<%# Bind("PURPOSECODE") %>'
                            Width="56px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqCode"
                                runat="server" ControlToValidate="txtCode" Display="None" 
                            ErrorMessage="[PRODUCT CODE] must be entry...!" SetFocusOnError="True" 
                            Text='<%# Eval("PRODUCTCODE") %>'></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Product Name</td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" MaxLength="30" Text='<%# Bind("PURPOSENAME") %>'
                            Width="264px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqName"
                                runat="server" ControlToValidate="txtName" Display="None" 
                            ErrorMessage="[PRODUCT NAME] must be entry...!" SetFocusOnError="True" 
                            Text='<%# Eval("PRODUCTNAME") %>'></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                <td >
                    Product</td>
                <td >
                    <asp:DropDownList ID="ddlProduct" runat="server"  CssClass="required"
                        DataTextField="PRODUCTNAME" DataValueField="PRODUCTID" 
                        ValidationGroup="PurposeCat" SelectedValue='<%# Bind("PRODUCTID") %>'>
                    </asp:DropDownList>
                       <ajaxToolkit:CascadingDropDown ID="ajaxCCDProduct" runat="server" Category="PRODUCTID" 
                                Enabled="True" LoadingText="[Loading Product..]"  BehaviorID="BehavProduct"
                                PromptText="[SELECT PRODUCT]" ServiceMethod="GetDropDownProductPricing" 
                                ServicePath="~\Param\WebService.asmx" TargetControlID="ddlProduct"></ajaxToolkit:CascadingDropDown>
                       <asp:RequiredFieldValidator
                            ID="reqProduct" runat="server" ControlToValidate="ddlProduct" 
                            Display="None" ErrorMessage="Product must be entry...!" 
                            SetFocusOnError="True" ValidationGroup="Pricing"></asp:RequiredFieldValidator>
                      <ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEproduct" runat="server" HighlightCssClass="ErrHighLight" 
                                TargetControlID="reqProduct"></ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
                <tr>
                    <td>
                        Need Route</td>
                    <td>
                        <asp:RadioButtonList SelectedValue='<%# Bind("NEEDROUTE") %>'  
                                ID="cblQualify" runat="server" RepeatLayout="Flow" 
                                RepeatDirection="Horizontal">
                            <asp:ListItem Value="1" Text="Yes" />
                            <asp:ListItem Value="0" Text="No" />
                            <asp:ListItem Value="2" Text="Optional" />
                        </asp:RadioButtonList>
                    </td>
                </tr>
                 <tr>
                <td >
                    Purpose Category</td>
                <td >
                    <asp:DropDownList ID="ddlPurpose" runat="server"
                        DataTextField="PURPOSENAME" DataValueField="PURPOSEID" 
                        ValidationGroup="PurposeCat" SelectedValue='<%# Bind("PURPOSECATID") %>'>
                    </asp:DropDownList>
                     <ajaxToolkit:CascadingDropDown ID="ajaxCDDPurpose" runat="server" Category="ProductID" 
						LoadingText="[Loading Object Purpose..]" 
                        PromptText="[SELECT PURPOSE CATEGORY]" BehaviorID="BehavObjectPurpose"
						ServiceMethod="GetDropDownObjectKindByProduct" ServicePath="~\Param\WebService.asmx" 
						TargetControlID="ddlPurpose" ParentControlID="ddlProduct"></ajaxToolkit:CascadingDropDown>
                        <asp:RequiredFieldValidator
                        ID="reqPurpose" runat="server" ControlToValidate="ddlPurpose" 
                        Display="None" ErrorMessage="Purpose Category must be entry...!" 
                        SetFocusOnError="True" ValidationGroup="Pricing"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender
                        ID="ajaxVCEPurpose" runat="server" HighlightCssClass="ErrHighLight" 
                        TargetControlID="reqPurpose"></ajaxToolkit:ValidatorCalloutExtender>
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
        
        SelectCommand="SELECT PURPOSEID, PURPOSECODE, PURPOSENAME, NEEDROUTE, (SELECT PRODUCTID FROM PRODUCT WHERE (PRODUCTID = OBJECTPURPOSE.PRODUCTID) AND (Deletests = 0)) AS PRODUCTID, (SELECT PURPOSECATID FROM OBJECTPURPOSECAT WHERE (PURPOSECATID = OBJECTPURPOSE.PURPOSECATID) AND (DELETESTS = 0)) AS PURPOSECATID FROM OBJECTPURPOSE WHERE (PURPOSEID = @PURPOSEID)" 
        DeleteCommand="UPDATE OBJECTPURPOSE SET DELETESTS = 1, LASTUSERID = @UserID, LASTUPDATE = GETDATE() WHERE (PURPOSEID = @PURPOSEID)" 
        UpdateCommand="OBJECTPURPOSEUpdate" InsertCommand="OBJECTPURPOSEAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure" 
        ProviderName="<%$ ConnectionStrings:connection.ProviderName %>">
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="UserID" />
            <asp:Parameter Name="PURPOSEID" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="PURPOSEID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="PURPOSEID" Type="Int32" />
            <asp:Parameter Name="PRODUCTID" Type="Int32" />
            <asp:Parameter Name="PURPOSECODE" Type="String" />
            <asp:Parameter Name="PURPOSENAME" Type="String" />
            <asp:Parameter Name="NEEDROUTE" Type="Int16" />
            <asp:Parameter Name="PURPOSECATID" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Name="retval" Type="Int32" Direction="InputOutput" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="PURPOSECODE" Type="String" />
            <asp:Parameter Name="PURPOSENAME" Type="String" />
            <asp:Parameter Name="NEEDROUTE" Type="Int16" />
            <asp:Parameter Name="PRODUCTID" Type="Int32" />
            <asp:Parameter Name="PURPOSECATID" Type="Int32" />
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
   <asp:SqlDataSource ID="sdsPurpose" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        SelectCommand="SELECT NULL AS PURPOSECATID, '[SELECT PURPOSE CAT.]' AS PURPOSECATNAME
                        UNION ALL
                        SELECT PURPOSECATID, '(' + PURPOSECATCODE + ') ' + PURPOSECATNAME AS PURPOSECATNAME
                        FROM OBJECTPURPOSECAT">
    </asp:SqlDataSource>
    <asp:HiddenField ID="hidAction" runat="server" />
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
    function GetValueTxtByClientID(ClientID) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            return (oText.value);
    }
    window.onload = function () {
        Load();
    }
    function Load() {
        var Action = GetValueTxtByClientID('<%=hidAction.ClientID%>');

        if (Action == "NEW") {
            $find("BehavProduct");
            $find("BehavObjectPurpose");
        }
        if (Action == "EDIT") {
            $find("BehavProduct");
            $find("BehavObjectPurpose");
        }
    }
</script>

</asp:Content>

