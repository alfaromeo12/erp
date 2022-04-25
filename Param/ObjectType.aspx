<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ObjectType.aspx.vb" Inherits="Param_ObjectType" title="ObjectType" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsertNoSPV.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdateNoSPV.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail">
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
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td style="width: 115px">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="TypeName">Type Name</asp:ListItem>
        <asp:ListItem Value="TypeAlias">Type Alias</asp:ListItem>
    </asp:DropDownList></td>
                <td>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="required" 
                        style="margin-left: 0px"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" />
                    &nbsp;&nbsp;
                </td>           
                </td>
            </tr>
        </table>

    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CommandName="New" CausesValidation="False" />
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="OBJECTTYPEID" 
            DataSourceID="sdsGrid" Width="100%" Caption="Object Type" 
            RowHeaderColumn="BRANCHCODE">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="../Images/edit.gif" 
                    ShowSelectButton="True" >
                <ItemStyle HorizontalAlign="Center" Width="25px" />
                </asp:CommandField>
                <asp:BoundField DataField="ObjectTypeID" HeaderText="ObjectType&lt;br&gt;ID" 
                    SortExpression="ObjectTypeID" HtmlEncode="False" />
                <asp:BoundField DataField="TYPENAME" HeaderText="Type&lt;br&gt;Name" 
                    SortExpression="TYPENAME" HtmlEncode="False" />
                <asp:BoundField DataField="TYPEALIAS" HeaderText="Type&lt;br&gt;Alias" 
                    SortExpression="TYPEALIAS" HtmlEncode="False" />
                <asp:BoundField DataField="TRANSMITION" HeaderText="Transmition" 
                    SortExpression="TRANSMITION" />
                <asp:BoundField DataField="FUEL" HeaderText="Fuel" SortExpression="FUEL" />
                <asp:BoundField DataField="CC" HeaderText="CC" SortExpression="CC" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        
        
        
        SelectCommand="SELECT MODELID, OBJECTTYPEID, TYPENAME, TYPEALIAS, KIND, BUILD, TRANSMITION, FUEL, CC, CATEGORYID, GAIKINDOCATEGORYID, COUNTRYID, Deletests 
FROM OBJECTTYPE WHERE (Deletests = 0) AND (MODELID = @MODELID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="MODELID" QueryStringField="MODELID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>

    <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%" DataKeyNames="OBJECTTYPEID">
        <InsertItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Model</td>
                    <td>
                        <asp:DropDownList ID="ddlModel" runat="server" CssClass="required" 
                            DataSourceID="sdsModel" DataTextField="MODELNAME" DataValueField="MODELID" 
                            SelectedValue='<%# Bind("MODELID") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqModel" runat="server" 
                            ControlToValidate="ddlModel" Display="None" 
                            ErrorMessage="MODEL must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqModel_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqModel">
                        </ajaxToolkit:ValidatorCalloutExtender>
                        <asp:HiddenField ID="hidKind" runat="server" Value='<%# Bind("KIND") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        Type Name</td>
                    <td>
                        <asp:TextBox ID="txtTypeName" runat="server" CssClass="required" MaxLength="100" 
                            Text='<%# Bind("TYPENAME") %>' Width="300px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqTypeName" runat="server" 
                            ControlToValidate="txtTypeName" Display="None" 
                            ErrorMessage="TYPE NAME must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECode" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqTypeName">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Alias</td>
                    <td>
                        <asp:TextBox ID="txtAlias" runat="server" MaxLength="100" 
                            Text='<%# Bind("TYPEALIAS") %>' Width="300px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Build</td>
                    <td>
                        <asp:DropDownList ID="ddlBuild" runat="server" DataSourceID="sdsBuild" 
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("BUILD") %>' 
                            Width="180px">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Transmition</td>
                    <td>
                        <asp:DropDownList ID="ddlTranmition" runat="server" 
                            DataSourceID="sdsTransmition" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("TRANSMITION") %>'>
                        </asp:DropDownList>
                        &nbsp;Fuel&nbsp;<asp:DropDownList ID="ddlFuel" runat="server" DataSourceID="sdsFuel" 
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("FUEL") %>'>
                        </asp:DropDownList>
                        &nbsp;CC
                        <asp:TextBox ID="txtCC" runat="server" MaxLength="10" style="text-align: right" 
                            Text='<%# Bind("CC") %>' Width="36px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Category</td>
                    <td>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="required" 
                            DataSourceID="sdsCategory" DataTextField="CATEGORYNAME" 
                            DataValueField="CATEGORYID" SelectedValue='<%# Bind("CATEGORYID") %>'>
                        </asp:DropDownList>
                        &nbsp;<asp:RequiredFieldValidator ID="reqCategory" runat="server" 
                            ControlToValidate="ddlCategory" Display="None" 
                            ErrorMessage="CATEGORY must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqCategory_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCategory">
                        </ajaxToolkit:ValidatorCalloutExtender>
                        &nbsp;Gaikindo CategoryID
                        <asp:DropDownList ID="ddlGaikindoCategoryID" runat="server" 
                            DataSourceID="sdsGaikindoCategory" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("GAIKINDOCATEGORYID") %>' Width="180px">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Country</td>
                    <td>
                        <asp:DropDownList ID="ddlCountry" runat="server" CssClass="required" 
                            DataSourceID="sdsCountry" DataTextField="COUNTRYNAME" 
                            DataValueField="COUNTRYID" SelectedValue='<%# Bind("COUNTRYID") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqCountry" runat="server" 
                            ControlToValidate="ddlCountry" Display="None" 
                            ErrorMessage="Branch COA must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEBranchCOA" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqCountry">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr />
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2">
                        <uc4:BtnInsert ID="BtnInsert1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel2" runat="server" />
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
        <EditItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        ID</td>
                    <td>
                        <asp:Label ID="lblObjectTypeID" runat="server" 
                            Text='<%# Eval("OBJECTTYPEID") %>'></asp:Label>
                        <asp:HiddenField ID="hidKind" runat="server" Value='<%# Bind("KIND") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        Model</td>
                    <td>
                        <asp:DropDownList ID="ddlModel" runat="server" CssClass="required" 
                            DataSourceID="sdsModel" DataTextField="MODELNAME" DataValueField="MODELID" 
                            SelectedValue='<%# Bind("MODELID") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqModel" runat="server" 
                            ControlToValidate="ddlModel" Display="None" 
                            ErrorMessage="MODEL must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqModel_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqModel">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Type Name</td>
                    <td>
                        <asp:TextBox ID="txtTypeName" runat="server" MaxLength="100" 
                            Text='<%# Bind("TYPENAME") %>' Width="300px" CssClass="required"></asp:TextBox>                    
                        <asp:RequiredFieldValidator ID="reqTypeName" runat="server" 
                            ControlToValidate="txtTypeName" Display="None" 
                            ErrorMessage="TYPE NAME must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECode" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqTypeName">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Alias</td>
                    <td>
                        <asp:TextBox ID="txtAlias" runat="server" MaxLength="100" 
                            Text='<%# Bind("TYPEALIAS") %>' Width="300px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Build</td>
                    <td>
                        <asp:DropDownList ID="ddlBuild" runat="server" 
                            DataSourceID="sdsBuild" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("BUILD") %>' Width="180px">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Transmition</td>
                    <td>
                        <asp:DropDownList ID="ddlTranmition" runat="server" 
                            DataSourceID="sdsTransmition" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("TRANSMITION") %>'>
                        </asp:DropDownList>
                        &nbsp;Fuel
                        <asp:DropDownList ID="ddlFuel" runat="server" DataSourceID="sdsFuel" 
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("FUEL") %>'>
                        </asp:DropDownList>
                        &nbsp;CC
                        <asp:TextBox ID="txtCC" runat="server" MaxLength="10" style="text-align: right" 
                            Text='<%# Bind("CC") %>' Width="36px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Category</td>
                    <td>
                        <asp:DropDownList ID="ddlCategory" runat="server" DataSourceID="sdsCategory" 
                            DataTextField="CATEGORYNAME" DataValueField="CATEGORYID" 
                            SelectedValue='<%# Bind("CATEGORYID") %>' CssClass="required">
                        </asp:DropDownList>
                        &nbsp;<asp:RequiredFieldValidator ID="reqCategory" runat="server" 
                            ControlToValidate="ddlCategory" Display="None" 
                            ErrorMessage="CATEGORY must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqCategory_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCategory">
                        </ajaxToolkit:ValidatorCalloutExtender>
                        &nbsp;Gaikindo Category
                        <asp:DropDownList ID="ddlGaikindoCategoryID" runat="server" 
                            DataSourceID="sdsGaikindoCategory" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("GAIKINDOCATEGORYID") %>' Width="180px">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Country</td>
                    <td>
                        <asp:DropDownList ID="ddlCountry" runat="server" CssClass="required" 
                            DataSourceID="sdsCountry" DataTextField="COUNTRYNAME" 
                            DataValueField="COUNTRYID" SelectedValue='<%# Bind("COUNTRYID") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqCountry" runat="server" 
                            ControlToValidate="ddlCountry" Display="None" 
                            ErrorMessage="Branch COA must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEBranchCOA" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqCountry">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr />
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2">
                        <uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
                        &nbsp;<uc2:BtnDelete ID="BtnDelete1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT (SELECT MODELID FROM MODEL WITH (NOLOCK) WHERE (MODELID = OBJECTTYPE.MODELID) AND (Deletests = 0)) AS MODELID, OBJECTTYPEID, TYPENAME, TYPEALIAS, KIND, BUILD, TRANSMITION, FUEL, CC, CATEGORYID, GAIKINDOCATEGORYID, COUNTRYID, Deletests FROM OBJECTTYPE WITH (NOLOCK) WHERE (OBJECTTYPEID = @OBJECTTYPEID) AND (Deletests = 0)" 
        DeleteCommand="UPDATE OBJECTTYPE SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID
WHERE OBJECTTYPEID=@OBJECTTYPEID" 
        UpdateCommand="OBJECTTYPEUpdate" InsertCommand="OBJECTTYPEAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="OBJECTTYPEID" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="OBJECTTYPEID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:Parameter Name="OBJECTTYPEID" Type="Int32" />
            <asp:Parameter Name="MODELID" Type="Int32" />
            <asp:Parameter Name="TYPENAME" Type="String" />
            <asp:Parameter Name="TYPEALIAS" Type="String" />
            <asp:Parameter Name="KIND" Type="String" />
            <asp:Parameter Name="BUILD" Type="String" />
            <asp:Parameter Name="TRANSMITION" Type="String" />
            <asp:Parameter Name="FUEL" Type="String" />
            <asp:Parameter Name="CC" Type="Int32" />
            <asp:Parameter Name="CATEGORYID" Type="Int32" />
            <asp:Parameter Name="GAIKINDOCATEGORYID" Type="Int32" />
            <asp:Parameter Name="COUNTRYID" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Name="retval" Type="Int32" Direction="InputOutput" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:Parameter Name="MODELID" Type="Int32" />
            <asp:Parameter Name="TYPENAME" Type="String" />
            <asp:Parameter Name="TYPEALIAS" Type="String" />
            <asp:Parameter Name="KIND" Type="String" />
            <asp:Parameter Name="BUILD" Type="String" />
            <asp:Parameter Name="TRANSMITION" Type="String" />
            <asp:Parameter Name="FUEL" Type="String" />
            <asp:Parameter Name="CC" Type="Int32" />
            <asp:Parameter Name="CATEGORYID" Type="Int32" />
            <asp:Parameter Name="GAIKINDOCATEGORYID" Type="Int32" />
            <asp:Parameter Name="COUNTRYID" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Name="retval" Type="Int32" Direction="InputOutput" />
        </InsertParameters>
    </asp:SqlDataSource>

<asp:SqlDataSource ID="sdsModel" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                            
        SelectCommand="SELECT NULL AS MODELID, NULL AS MODELCODE, '[SELECT MODEL]' AS MODELNAME UNION ALL SELECT MODELID, MODELCODE, + '(' + MODELCODE + ') ' + MODELNAME AS MODELNAME FROM MODEL WHERE (Deletests = 0)">
                        </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsTransmition" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        SelectCommand="SELECT NULL AS CODE, '[SELECT TRANSMITION]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'TRANSMITION')">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsFuel" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        SelectCommand="SELECT NULL AS CODE, '[SELECT FUEL]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'FUEL')">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsBuild" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        SelectCommand="SELECT NULL AS CODE, '[SELECT BUILD]' AS NAME
UNION ALL
SELECT CODE, + '[' + CODE + '] ' + NAME AS NAME
FROM PARAMGLOBAL WHERE TYPE = 'BUILD'">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsGaikindoCategory" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        
        SelectCommand="SELECT NULL AS CODE, '[SELECT GAIKINDO CATEGORY]' AS NAME UNION ALL SELECT CODE, + '[' + CODE + '] ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'GAIKINDOCATEGORYID')">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCategory" runat="server" 
        
        SelectCommand="SELECT NULL AS CATEGORYID, NULL AS CATEGORYCODE, '[SELECT CATEGORY]' AS CATEGORYNAME
UNION ALL
SELECT CATEGORYID,CATEGORYCODE, + '(' + CATEGORYCODE + ') ' + CATEGORYNAME AS CATEGORYNAME
FROM OBJECTCATEGORY WHERE Deletests=0" 
        ConnectionString="<%$ ConnectionStrings:connection %>">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCountry" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        SelectCommand="SELECT NULL AS COUNTRYID, NULL AS COUNTRYCODE, '[SELECT CATEGORY]' AS COUNTRYNAME
UNION ALL
SELECT COUNTRYID,COUNTRYCODE, + '(' + COUNTRYCODE + ') ' + COUNTRYNAME AS COUNTRYNAME
FROM COUNTRY WHERE Deletests=0">
    </asp:SqlDataSource>
    &nbsp; &nbsp; &nbsp;&nbsp;
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript">
TabToEnter();
FormatTable("<%=gvData.ClientID%>")
</script>

</asp:Content>

