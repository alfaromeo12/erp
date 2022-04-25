<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="FinanceStructure.aspx.vb" Inherits="Param_FinanceStructure" EnableEventValidation="false" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:ScriptManagerProxy ID="SMPFinanceStructure" runat="server">
    <Services>
    <asp:ServiceReference Path="GHWService.asmx" />
    </Services>
    </asp:ScriptManagerProxy>
      <asp:CheckBox ID="chkAddNew" runat="server" Font-Names="Lucida Sans" 
                            Font-Size="7.5pt" Visible="False"/>
        <asp:HiddenField ID="hidAction" runat="server" />
        <asp:HiddenField ID="hidAreaID" runat="server" />
        <asp:HiddenField ID="hidBranchID" runat="server" />
        <asp:HiddenField ID="hidProductID" runat="server" />
        <asp:HiddenField ID="hidCategoryID" runat="server" />
        <asp:HiddenField ID="hidPurposeCatID" runat="server" />
        <asp:HiddenField ID="hidFinID" runat="server" />
        <asp:HiddenField ID="hidAREACopy" runat="server" />
        <asp:HiddenField ID="hidBRANCHCopy" runat="server" />
    <asp:HiddenField ID="hidPRODUCTCopy" runat="server" />
    <asp:HiddenField ID="hidKINDCopy" runat="server" />
    <asp:HiddenField ID="hidCATEGORYCopy" runat="server" />
             <asp:TextBox ID="txtTmpSelectedIndex" runat="Server" style="display:none" Text="0" />    
    <asp:MultiView ID="MultiView_Utama" runat="server">
    <asp:View ID="View_View" runat="server">   
	<ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
		WatermarkText="%%"></ajaxToolkit:TextBoxWatermarkExtender>
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
		ImageControlID="imgButtonShow" TargetControlID="pnlData" TextLabelID="lblShow"></ajaxToolkit:CollapsiblePanelExtender>
	<asp:Panel ID="pnlData" runat="server">
		<table cellpadding="0" cellspacing="0" width="100%">
			<tr class="RowStyle">
				<td style="width: 115px">
	<asp:DropDownList ID="ddlCriteria" runat="server">
		<asp:ListItem Value="ProductCode">Product Code</asp:ListItem>
		<asp:ListItem Value="ProductName">Product Name</asp:ListItem>
	    <asp:ListItem Value="AreaCode">Area Code</asp:ListItem>
        <asp:ListItem Value="AREA.AreaName">Area Name</asp:ListItem>
	    <asp:ListItem Value="BranchName">Branch</asp:ListItem>
        <asp:ListItem Value="PURPOSENAME">Purpose Name</asp:ListItem>
	</asp:DropDownList></td>
				<td>
		<asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox>
        <asp:Button	ID="btnFunctionSearch" runat="server" Text="Search" CausesValidation="False" CssClass="Search" />
				</td>
			</tr>
			<tr class="AlternatingRowStyle">
				<td style="width: 115px">
					Area</td>
				<td>
					<asp:DropDownList ID="ddlSearchArea" runat="server" DataSourceID="sdsArea" 
                        DataTextField="AREANAME" DataValueField="AREAID" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsArea" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        
                        
                        
                        SelectCommand="SELECT NULL AS AREAID, NULL AS AREACODE, '[DISPLAY ALL AREA] ' AS AREANAME UNION ALL SELECT AREAID, AREACODE, '( ' + AREACODE + ') ' + AREANAME AS AREANAME FROM AREA WHERE (DELETESTS = 0) ORDER BY AREACODE">
                    </asp:SqlDataSource>
                </td>
			</tr>
		    <tr class="RowStyle">
                <td style="width: 115px">
                    Branch</td>
                <td>
                    <asp:DropDownList ID="ddlSearchBranch" runat="server" AutoPostBack="True" 
                        DataSourceID="sdsBranch" DataTextField="BRANCHNAME" DataValueField="BRANCHID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsBranch" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        
                        
                        SelectCommand="SELECT NULL AS BRANCHID, NULL AS BRANCHCODE, '[DISPLAY ALL BRANCH] ' AS BRANCHNAME UNION ALL SELECT BRANCHID, BRANCHCODE, '(' + BRANCHCODE + ') ' + BRANCHNAME AS BRANCHNAME FROM BRANCH WITH (NOLOCK) WHERE (Deletests = 0) AND (AREAID = @AREAID) ORDER BY BRANCHCODE">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlSearchArea" DefaultValue="-999" 
                                Name="AREAID" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
		    <tr class="AlternatingRowStyle">
                <td style="width: 115px">
                    Product</td>
                <td>
                    <asp:DropDownList ID="ddlSearchProduct" runat="server" AutoPostBack="True" 
                        DataSourceID="sdsProduct" DataTextField="PRODUCTNAME" 
                        DataValueField="PRODUCTID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsProduct" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        
                        SelectCommand="SELECT NULL AS PRODUCTID, '[DISPLAY ALL PRODUCT] ' AS PRODUCTNAME UNION ALL SELECT PRODUCTID, '(' + PRODUCTCODE + ') ' + PRODUCTNAME AS PRODUCTNAME FROM PRODUCT WHERE (Deletests = 0)">
                    </asp:SqlDataSource>
                </td>
            </tr>
		    <tr class="RowStyle">
                <td style="width: 115px">
                    Object Category</td>
                <td>
                    <asp:DropDownList ID="ddlSearchCategory" runat="server" AutoPostBack="True" 
                        DataSourceID="sdsCategory" DataTextField="CATEGORYNAME" 
                        DataValueField="CATEGORYID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsCategory" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        
                        SelectCommand="SELECT NULL AS CATEGORYID, '[DISPLAY ALL CATEGORY]' AS CATEGORYNAME UNION ALL SELECT CATEGORYID, '(' + CATEGORYCODE + ') ' + CATEGORYNAME AS CATEGORYNAME FROM OBJECTCATEGORY WHERE (Deletests = 0) AND (PRODUCTID = @PRODUCTID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlSearchProduct" DefaultValue="-99" 
                                Name="PRODUCTID" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
		    <tr class="AlternatingRowStyle">
                <td style="width: 115px">
                    Object Kind</td>
                <td>
                    <asp:DropDownList ID="ddlSearchObjectKind" runat="server" 
                        DataSourceID="sdsPurposeCat" DataTextField="PURPOSECATNAME" 
                        DataValueField="PURPOSECATID" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsPurposeCat" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        
                        SelectCommand="SELECT NULL AS PURPOSECATID, '[DISPLAY ALL KIND] ' AS PURPOSECATNAME UNION ALL SELECT PURPOSECATID, '( ' + PURPOSECATCODE + ') ' + PURPOSECATNAME AS PURPOSECATNAME FROM OBJECTPURPOSECAT WHERE (DELETESTS = 0) AND (PRODUCTID = @PRODUCTID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlSearchProduct" DefaultValue="-99" 
                                Name="PRODUCTID" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
		</table>
        	<asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CommandName="New" CausesValidation="False" />
	
    </asp:Panel>
		<asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
			AutoGenerateColumns="False" 
            DataKeyNames="AREAID,BRANCHID,PRODUCTID,PURPOSECATID,CATEGORYID" DataSourceID="sdsGrid" 
			Width="100%" Caption="Finance Structure List" RowHeaderColumn="INSURANCECODE">
			<Columns>
				
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                <ItemStyle Width="20px" HorizontalAlign="Center" /></asp:CommandField>
                  <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/delete.gif"  
                    ShowSelectButton="True" Visible="False"><ItemStyle Width="20px" /></asp:CommandField>
				<asp:BoundField DataField="AREANAME" HeaderText="Area&lt;br&gt;Name" 
                    SortExpression="AREANAME" HtmlEncode="False" />
                <asp:BoundField DataField="BRANCHNAME" HeaderText="Branch&lt;br&gt;Name" 
                    SortExpression="BRANCHNAME" HtmlEncode="False" />
                <asp:BoundField DataField="PRODUCTNAME" HeaderText="Product&lt;br&gt;Name" 
                    SortExpression="PRODUCTNAME" HtmlEncode="False" />
                <asp:BoundField DataField="CATEGORYNAME" HeaderText="Category&lt;br&gt;Name" 
                    HtmlEncode="False" SortExpression="CATEGORYNAME" />
                <asp:BoundField DataField="PURPOSECATNAME" HeaderText="Object&lt;br&gt;Kind" 
                    SortExpression="PURPOSECATNAME" HtmlEncode="False" />
			</Columns>
			<EmptyDataTemplate>
				<uc6:NoDataFound ID="NoDataFound1" runat="server" />
			</EmptyDataTemplate>
		</asp:GridView>
	    <asp:SqlDataSource ID="sdsGrid" runat="server" 
            ConnectionString="<%$ ConnectionStrings:connection %>" 
            
            
            SelectCommand="SELECT DISTINCT FNFINSTRUCTURE.DEALERID, FNFINSTRUCTURE.AREAID, (SELECT '(' + AREACODE + ') ' + AREANAME AS AREANAME FROM AREA WITH (NOLOCK) WHERE (AREAID = FNFINSTRUCTURE.AREAID)) AS AREANAME, FNFINSTRUCTURE.BRANCHID, ISNULL((SELECT '(' + BRANCHCODE + ') ' + BRANCHNAME AS BRANCHNAME FROM BRANCH WITH (NOLOCK) WHERE (BRANCHID = FNFINSTRUCTURE.BRANCHID)), 'ALL BRANCH') AS BRANCHNAME, FNFINSTRUCTURE.PRODUCTID, (SELECT '(' + PRODUCTCODE + ') ' + PRODUCTNAME AS PRODUCTNAME FROM PRODUCT WITH (NOLOCK) WHERE (PRODUCTID = FNFINSTRUCTURE.PRODUCTID)) AS PRODUCTNAME, FNFINSTRUCTURE.PURPOSECATID, (SELECT '(' + PURPOSECATCODE + ') ' + PURPOSECATNAME AS PURPOSECATNAME FROM OBJECTPURPOSECAT WITH (NOLOCK) WHERE (PURPOSECATID = FNFINSTRUCTURE.PURPOSECATID)) AS PURPOSECATNAME, FNFINSTRUCTURE.CATEGORYID, (SELECT '(' + CATEGORYCODE + ') ' + CATEGORYNAME AS CATEGORYNAME FROM OBJECTCATEGORY WITH (NOLOCK) WHERE (FNFINSTRUCTURE.CATEGORYID = CATEGORYID)) AS CATEGORYNAME FROM FNFINSTRUCTURE WITH (NOLOCK) LEFT OUTER JOIN BRANCH AS BRANCH_1 WITH (NOLOCK) ON FNFINSTRUCTURE.BRANCHID = BRANCH_1.BRANCHID WHERE (FNFINSTRUCTURE.DeleteSts = 0)">
        </asp:SqlDataSource>
	
    </asp:View>
    <asp:View ID="View_Search" runat="server">   
            <asp:Panel ID="pnlForm" runat="server" GroupingText="Search Criteria">
            <table style="width: 100%;" cellpadding="0" cellspacing="0">
            
            <tr>
                <td colspan="2"  class="title" style="text-align:center">
                        <asp:Label ID="lblCaption" runat="server"></asp:Label></td>
                    
            </tr>
            <tr>
                <td width="150px" class="FooterStyle">
                    Area</td>
                <td class="RowStyle">
                       <asp:DropDownList ID="ddlArea" runat="server" CssClass="required" 
                       DataTextField="AREANAME" DataValueField="AREAID" ValidationGroup="Search" >
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="reqArea" runat="server" 
                        ControlToValidate="ddlArea" Display="None" 
                        ErrorMessage="[AREA] must be entry...!" SetFocusOnError="True" 
                           ValidationGroup="Search"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqArea_ValidatorCalloutExtender" 
                        runat="server" BehaviorID="reqVCEArea" HighlightCssClass="ErrHighLight" 
                        TargetControlID="reqArea"></ajaxToolkit:ValidatorCalloutExtender>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDArea" runat="server" 
                        Category="AREAID" Enabled="True" LoadingText="[Loading Area..]" 
                         ServiceMethod="GetDropDownAreaWithAll" BehaviorID="BehavArea"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlArea"></ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
            <tr>
                <td width="150px" class="FooterStyle">
                    Branch</td>
                <td class="AlternatingRowStyle">
                    <asp:DropDownList ID="ddlBranch" runat="server" CssClass="required"
                     DataTextField="BRANCHNAME" DataValueField="BRANCHID">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDBranch" runat="server" Category="AREAID" 
						LoadingText="[Loading Branch..]"    BehaviorID="BehavBranch"
						ServiceMethod="GetDropDownBranchByArea1" ServicePath="~\Param\WebService.asmx" 
						TargetControlID="ddlBranch" ParentControlID="ddlArea"></ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
            <tr>
                <td class="FooterStyle">
                    Product</td>
                <td class="RowStyle">
                    <asp:DropDownList ID="ddlProduct" runat="server" CssClass="required" 
                        DataTextField="PRODUCTNAME" DataValueField="PRODUCTID" 
                        ValidationGroup="Search">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDProduct" runat="server" 
                        Category="PRODUCTID" Enabled="True" LoadingText="[Loading Product..]" 
                        PromptText="[SELECT PRODUCT]" ServiceMethod="GetDropDownProductPricing" BehaviorID="BehavProduct"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlProduct"></ajaxToolkit:CascadingDropDown>
                    <asp:RequiredFieldValidator ID="reqProduct" runat="server" 
                        ControlToValidate="ddlProduct" Display="None" 
                        ErrorMessage="[PRODUCT] must be entry...!" SetFocusOnError="True" 
                        ValidationGroup="Search"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqProduct_ValidatorCalloutExtender" 
                        runat="server" HighlightCssClass="ErrHighLight" 
                        TargetControlID="reqProduct" BehaviorID="reqVCEProduct"></ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
                <tr>
                    <td class="FooterStyle">
                        Object Category</td>
                    <td class="AlternatingRowStyle">
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="required" 
                            DataTextField="CATEGORYNAME" DataValueField="CATEGORYID" 
                            ValidationGroup="Search">
                        </asp:DropDownList>
                        <ajaxToolkit:CascadingDropDown ID="ajaxCDDCategory" runat="server" Category="ProductID" 
                            LoadingText="[Loading Object Category..]" ParentControlID="ddlProduct" 
                            PromptText="[SELECT OBJECT CATEGORY]" BehaviorID="BehavCategory"
                            ServiceMethod="GetDropDownCategoryByProduct" 
                            ServicePath="~\Param\WebService.asmx" TargetControlID="ddlCategory"></ajaxToolkit:CascadingDropDown>
                        <asp:RequiredFieldValidator ID="reqCategory" runat="server" 
                            ControlToValidate="ddlCategory" Display="None" 
                            ErrorMessage="[OBJECT CATEGORY] must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="Search"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPurpose" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqCategory" 
                            BehaviorID="ajaxVCEObjectCategory"></ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
            <tr>
                <td class="FooterStyle">
                    Object Kind</td>
                <td class="RowStyle">
                    <asp:DropDownList ID="ddlObjectKind" runat="server"
                        CssClass="required" DataTextField="NAME" DataValueField="CODE" 
                        ValidationGroup="Search" >
                    </asp:DropDownList>
                       <asp:RequiredFieldValidator
                    ID="reqObjectKind" runat="server" ControlToValidate="ddlObjectKind" 
                    Display="None" ErrorMessage="[OBJECT KIND] must be entry...!" 
                    SetFocusOnError="True" ValidationGroup="Search"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender
                        ID="ajaxVCEInsType" runat="server" HighlightCssClass="ErrHighLight" 
                        TargetControlID="reqObjectKind" BehaviorID="ajaxVCEObjectKind"></ajaxToolkit:ValidatorCalloutExtender>
                     <ajaxToolkit:CascadingDropDown ID="ajaxCDDObjectKind" runat="server" Category="ProductID" 
                            LoadingText="[Loading Object Kind..]" ParentControlID="ddlProduct" 
                            PromptText="[SELECT OBJECT KIND]" BehaviorID="BehavObjectKind"
                            ServiceMethod="GetDropDownObjectKindByProduct" 
                            ServicePath="~\Param\WebService.asmx" TargetControlID="ddlObjectKind"></ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
                <tr>
                    <td class="AlternatingRowStyle" colspan="2" >
                            <asp:Button ID="btnSearch" runat="server" 
                            Style="font-size: 8pt; cursor: pointer; background-image: url(../images/search.gif); 
                            background-repeat: no-repeat; text-align: right;" Text="Search" ToolTip="Search" 
                                Width="55px" ValidationGroup="Search" />
                        </td>
			        </tr>
            </table>
            </asp:Panel>
            <asp:Panel ID="pnlDPMinimum" runat="server" >
   
                    <table style="width: 100%;">
         
                <tr>
                    <td colspan="3">
                        <asp:SqlDataSource ID="sdsCondition" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            SelectCommand="SELECT NULL AS CODE, '( Select ) ' AS NAME UNION ALL SELECT CODE, NAME FROM PARAMGLOBAL WHERE (TYPE = 'CONDITION')">
                        </asp:SqlDataSource>
                        <asp:GridView ID="gvDPMinimum" runat="server" 
                            AutoGenerateColumns="False" BorderWidth="1px" 
                            DataKeyNames="FINID" OnRowCreated="gvDPMinimum_RowCreated"  
                            ShowFooter="True" style="margin-top: 0px" Width="100%" PageSize="15" 
                            Caption="Down Payment Minimum">
                            <Columns>
                                <asp:TemplateField ControlStyle-CssClass="HeaderStyle" HeaderText="DEL" 
                                    ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnDelete" runat="server" CausesValidation="False" 
                                            CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>" 
                                            CommandName="Delete" ImageAlign="Middle" ImageUrl="~/Images/delete.gif" 
                                            style="cursor: pointer" Text="Delete" oncommand="btnDelete_Command" 
                                            onclientclick="return confirm(&quot;Are you sure want to delete Data..?&quot;)" />
                                    </ItemTemplate>
                                   <ControlStyle CssClass="HeaderStyle" />
                                    <ControlStyle CssClass="HeaderStyle" />
                                    <FooterStyle CssClass="HeaderStyle" HorizontalAlign="center" />
                                    <FooterTemplate>
                                        <asp:ImageButton ID="btnNew" runat="server" CausesValidation="True" 
                                            CommandName="New" ImageAlign="Middle" ImageUrl="~/Images/New.png" 
                                            onclick="btnNewDP_Click" style="cursor:pointer" Text="New" 
                                            ValidationGroup="FinStrucSave" />
                                    </FooterTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="30px" />
                                </asp:TemplateField>
                                <asp:TemplateField ControlStyle-CssClass="HeaderStyle" HeaderText="DTL">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnFNDetail" runat="server" CausesValidation="False" 
                                            CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>" 
                                            CommandName="Detail" imageAlign="Middle" ImageUrl="~/Images/detail.gif" 
                                            OnCommand="btnFNDetail_Command" style="cursor: pointer" Text="Delete"/>
                                    </ItemTemplate>
                                        <ControlStyle CssClass="HeaderStyle" />
                                   <ItemStyle HorizontalAlign="Center" Width="30px" />

                                </asp:TemplateField>
                                <asp:TemplateField >
                                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="FALSE">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtFINID" runat="server" Font-Names="Lucida Sans" 
                                            Font-Size="Smaller" Text='<%#Databinder.Eval(Container.DataItem,"FINID") %>' 
                                            Visible="false" CausesValidation="True"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="From" SortExpression="YEARFROM">
                                    <Itemstyle HorizontalAlign="Right"  />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtYearFrom" runat="server" CssClass="required" MaxLength="4" 
                                            style="text-align: right" Text='<%# Eval("YEARFROM") %>' Width="70px" 
                                            ValidationGroup="FinStrucSave" CausesValidation="True"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="reqYearFrom" runat="server" 
                                            ControlToValidate="txtYearFrom" Display="None" 
                                            ErrorMessage="Year From must be entry...!" SetFocusOnError="True" 
                                            ValidationGroup="FinStrucSave"></asp:RequiredFieldValidator>
                                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEYearFrom" runat="server" 
                                            HighlightCssClass="ErrHighLight" TargetControlID="reqYearFrom"></ajaxToolkit:ValidatorCalloutExtender>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="To" SortExpression="YEARTO">
                                    <Itemstyle HorizontalAlign="Right" />
                                        <ItemTemplate>
                                        <asp:TextBox ID="txtYearTo" runat="server" CssClass="required" 
                                            MaxLength="4" 
                                            style="text-align: right" Text='<%# Eval("YEARTO") %>' Width="70px" 
                                                ValidationGroup="FinStrucSave" CausesValidation="True"></asp:TextBox>
                                       
                                       <asp:RequiredFieldValidator ID="reqYearTo" runat="server" 
                                            ControlToValidate="txtYearTo" Display="None" 
                                            ErrorMessage="To From must be entry...!" SetFocusOnError="True" 
                                                ValidationGroup="FinStrucSave"></asp:RequiredFieldValidator>
                                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEYearTo" runat="server" 
                                            HighlightCssClass="ErrHighLight" TargetControlID="reqYearTo"></ajaxToolkit:ValidatorCalloutExtender>
                                    </ItemTemplate>
                                    
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="CONDITION">
                                    
                                    <Itemstyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlCondition" runat="server" CssClass="required" 
                                            DataSourceID="sdsCondition" DataTextField="NAME" DataValueField="CODE" 
                                            SelectedValue='<%# Eval("CONDITION") %>' ValidationGroup="FinStrucSave" 
                                            CausesValidation="True">
                                            </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="reqCondition" runat="server" 
                                            ControlToValidate="ddlCondition" Display="None" 
                                            ErrorMessage="Condition must be entry...!" SetFocusOnError="True" 
                                            ValidationGroup="FinStrucSave"></asp:RequiredFieldValidator>
                                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECondition" runat="server" 
                                            HighlightCssClass="ErrHighLight" TargetControlID="reqCondition"></ajaxToolkit:ValidatorCalloutExtender>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField  SortExpression="DP">
                                    <Itemstyle HorizontalAlign="Right"  />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDP" runat="server" CssClass="required" style="text-align: right" 
                                            Text='<%# Eval("DP","{0:N}") %>' Width="80px" 
                                            ValidationGroup="FinStrucSave" CausesValidation="True" ></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="reqDP" runat="server" ControlToValidate="txtDP" 
                                            Display="None" ErrorMessage="DP must be entry...!" SetFocusOnError="True" 
                                            ValidationGroup="FinStrucSave"></asp:RequiredFieldValidator>
                                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEDP" runat="server" 
                                            HighlightCssClass="ErrHighLight" TargetControlID="reqDP"></ajaxToolkit:ValidatorCalloutExtender>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="Description">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("REMARK") %>' 
                                            Width="219px"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <uc6:NoDataFound ID="NoDataFound2" runat="server" />
                            </EmptyDataTemplate>
                        </asp:GridView>
                       
                        <br />
                        <br />
                        <br />
                        <br />
                       
                    </td>
                </tr>
        </table>
            
            </asp:Panel>
            <asp:Panel ID="pnlControl" runat="server" CssClass="HeaderStyle" 
                Visible="false" Width="99%">
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" 
                                Font-Bold="True" Font-Underline="True" Style="text-align: center" 
                                Visible="False" Width="100%"></asp:Label>
                                <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblMessage">
                                 <Animations>
                                    <OnLoad>
                                        <Sequence>
                                            <Pulse Duration="0.5" Iterations="0" />
                                        </Sequence>
                                    </OnLoad>
                                </Animations>
                                </ajaxToolkit:AnimationExtender>
                            <asp:Button ID="btnSave" runat="server" 
                                Style="font-size: 8pt; cursor: pointer; background-image: url(../images/Save.gif); background-repeat: no-repeat; text-align: right;" 
                                Text="Save" ToolTip="Save" Width="55px" OnClientClick="return CheckUserSPVDlrFinStr();" />
                            <asp:Button ID="btnbackView" runat="server" CausesValidation="False" 
                                Style="font-size: 8pt; cursor: pointer; background-image: url(../Images/back.png); cursor: pointer; background-repeat: no-repeat; text-align: right" 
                                Text="Back" ValidationGroup="Collector" Width="55px" />
                            <asp:Button ID="btnCopy" runat="server" CausesValidation="False" 
                                Style="font-size: 8pt; cursor: pointer; background-image: url(../Images/copying.png); cursor: pointer; background-repeat: no-repeat;  text-align: right" 
                                Text="Copy" Width="55px" onclientclick="return FinStructureCopy();" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEControl" runat="server" 
                TargetControlID="pnlControl" VerticalSide="Bottom"></ajaxToolkit:AlwaysVisibleControlExtender>
    </asp:View>
        <asp:View ID="View_Detail" runat="server">   
             <asp:Panel ID="pnlDtl" runat="server"  
                            Width="100%" GroupingText="Effective Rate Info">
                            <asp:DataList ID="dlDetail" runat="server" Caption="EFFECTIVE RATE INFO" DataKeyField="FINID"
                                DataSourceID="sdsEffRateInfo" Width="100%">
                                <ItemTemplate>
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td class="HeaderStyle" colspan="4">
                                                Finance Structure -&nbsp; Effective Rate</td>
                                        </tr>
                                        <tr>
                                            <td class="FooterStyle">
                                                Area</td>
                                            <td>
                                                <asp:Label ID="lbArea" runat="server" Font-Bold="True" Font-Underline="True" 
                                                    Text='<%# Eval("AREANAME") %>'></asp:Label>
                                            </td>
                                            <td>
                                                &nbsp;</td>
                                            <td>
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="FooterStyle">
                                                Product</td>
                                            <td >
                                                <asp:Label ID="lblProduct" runat="server" Font-Bold="True" 
                                                    Font-Underline="True" Text='<%# Eval("PRODUCTNAME") %>'></asp:Label>
                                            </td>
                                            <td class="FooterStyle">
                                                Category</td>
                                            <td>
                                                <asp:Label ID="lblCategory" runat="server" Font-Bold="True" 
                                                    Font-Underline="True" Text='<%# Eval("CATEGORYNAME") %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="FooterStyle">
                                                Object Kind</td>
                                            <td >
                                                <asp:Label ID="lblObjectKind" runat="server" Font-Bold="True" 
                                                    Font-Underline="True" Text='<%# Eval("PURPOSENAME") %>'></asp:Label>
                                            </td>
                                            <td class="FooterStyle">
                                                Build Year</td>
                                            <td>
                                                <asp:Label ID="lblYearFrom" runat="server" Font-Bold="True" 
                                                    Font-Underline="True" Text='<%# Eval("YEARFROM") %>'></asp:Label>
                                                &nbsp;-
                                                <asp:Label ID="lblYearTo" runat="server" Font-Bold="True" Font-Underline="True" 
                                                    Text='<%# Eval("YEARTO") %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="FooterStyle">
                                                DP Min</td>
                                            <td >
                                                <asp:Label ID="lblDPMinimum" runat="server" Font-Bold="True" 
                                                    Font-Underline="True" Text='<%# Eval("DP", "{0:N}") %>'></asp:Label>
                                                %</td>
                                            <td class="FooterStyle">
                                                Item Condition</td>
                                            <td>
                                                <asp:Label ID="lblItemCondition" runat="server" Font-Bold="True" 
                                                    Font-Underline="True" Text='<%# Eval("CONDITIONNM") %>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:DataList>
                            <asp:SqlDataSource ID="sdsEffRateInfo" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:connection %>" 
                                
                                
                                SelectCommand="SELECT TOP (500) FINID, DEALERID, (SELECT '(' + DEALERCODE + ') ' + DEALERNAME AS DEALERNAME FROM DEALER WHERE (DEALERID = FNFINSTRUCTURE.DEALERID)) AS DEALERNAME, AREAID, (SELECT '(' + AREACODE + ') ' + AREANAME AS AREANAME FROM AREA WHERE (AREAID = FNFINSTRUCTURE.AREAID)) AS AREANAME, BRANCHID, (SELECT '(' + BRANCHCODE + ') ' + BRANCHNAME AS AREANAME FROM BRANCH WHERE (BRANCHID = FNFINSTRUCTURE.BRANCHID)) AS BRANCHNAME, PRODUCTID, (SELECT '(' + PRODUCTCODE + ') ' + PRODUCTNAME AS PRODUCTNAME FROM PRODUCT WHERE (PRODUCTID = FNFINSTRUCTURE.PRODUCTID)) AS PRODUCTNAME, PURPOSECATID, (SELECT '(' + PURPOSECATCODE + ') ' + PURPOSECATNAME AS PURPOSECATNAME FROM OBJECTPURPOSECAT WHERE (PURPOSECATID = FNFINSTRUCTURE.PURPOSECATID)) AS PURPOSENAME, CATEGORYID, (SELECT '(' + CATEGORYCODE + ') ' + CATEGORYNAME AS CATEGORYNAME FROM OBJECTCATEGORY WHERE (FNFINSTRUCTURE.CATEGORYID = CATEGORYID)) AS CATEGORYNAME, YEARFROM, YEARTO, CONDITION, dbo.f_getParamGlobalName('CONDITION', CONDITION) AS CONDITIONNM, DP FROM FNFINSTRUCTURE WITH (NOLOCK) WHERE (DeleteSts = 0) AND (FINID = @FINID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hidFinID" Name="FINID" PropertyName="Value" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                    </asp:Panel>
            <asp:Panel ID="pnlEffRate" runat="server" >
             <table style="width: 100%;">
         
                <tr>
                    <td colspan="3">
                       <asp:GridView ID="gvEffRate" runat="server" 
                            AutoGenerateColumns="False" BorderColor="White"
                        BorderWidth="2px"  Caption="Interest Rate" DataKeyNames="FINDTLID"  
                            OnRowCreated="gvEffRate_RowCreated"  ShowFooter="True"
                        Width="99%"  >
                        <Columns>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFindtlKey" runat="server" 
                                            Text='<% #DataBinder.Eval(Container.DataItem,"FINDTLID") %>' Visible="false" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ControlStyle-CssClass="HeaderStyle" HeaderText="DEL" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnDeleteDtl" runat="server" CausesValidation="False" 
                                            CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>" 
                                            CommandName="Delete" ImageAlign="Middle" ImageUrl="~/Images/delete.gif" 
                                            style="cursor: pointer; height: 15px;" Text="Delete" 
                                            onclientclick="return confirm(&quot;Are you sure want to delete ?&quot;)" 
                                            oncommand="btnDeleteDtl_Command"  />
                                    </ItemTemplate>
                                    <ControlStyle CssClass="HeaderStyle" />
                                    <FooterStyle CssClass="HeaderStyle" HorizontalAlign="center" />
                                    <FooterTemplate>
                                        <asp:ImageButton ID="btnNewEffRate" runat="server" CausesValidation="True" 
                                            CommandName="New" ImageAlign="Middle" ImageUrl="~/Images/New.png" 
                                            onclick="btnNewEffRate_Click" style="cursor:pointer" Text="New" />
                                    </FooterTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="No.">
                                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="FROM" >
                                    <Itemstyle HorizontalAlign="Right"/>
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlOprFrTenor" runat="server" CssClass="required"  
                                            DataSourceID="sdsOperator" DataTextField="NAME" DataValueField="CODE" 
                                            SelectedValue='<%# Eval("TENOROPR1") %>'>
                                            </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="reqOprFrTenor" runat="server" 
                                            ControlToValidate="ddlOprFrTenor" Display="None" 
                                            ErrorMessage="Operator From Tenor must be entry...!" SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEOprFrTenor" runat="server" 
                                            HighlightCssClass="ErrHighLight" TargetControlID="reqOprFrTenor"></ajaxToolkit:ValidatorCalloutExtender>
                                    </ItemTemplate>
                                </asp:TemplateField>                                                                                                           
                                <asp:TemplateField >
                                    <Itemstyle HorizontalAlign="Right"/>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtTenorFrom" runat="server" CssClass="required" 
                                            style="text-align:right" Text='<%# Eval("TENORFROM") %>' MaxLength="5" 
                                            Width="50px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="reqtxtTenorFrom" runat="server" 
                                            ControlToValidate="txtTenorFrom" Display="None" 
                                            ErrorMessage="Tenor From must be entry...!" SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEtxtTenorFrom" runat="server" 
                                            HighlightCssClass="ErrHighLight" TargetControlID="reqtxtTenorFrom"></ajaxToolkit:ValidatorCalloutExtender>
                                    </ItemTemplate>
                                </asp:TemplateField>                                        
                                <asp:TemplateField HeaderText="TO" >
                                    <Itemstyle HorizontalAlign="Right"/>
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlOprToTenor" runat="server" DataSourceID="sdsOperator" 
                                            DataTextField="NAME" DataValueField="CODE" 
                                            SelectedValue='<%# Eval("TENOROPR2") %>'>
                                            </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>    
                                <asp:TemplateField >
                                    <Itemstyle HorizontalAlign="Right"/>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtTenorTo" runat="server" style="text-align:right" 
                                            Text='<%# Eval("TENORTO") %>' MaxLength="5" Width="50px"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>  
                                <asp:TemplateField HeaderText="FROM">
                                    <Itemstyle HorizontalAlign="Right"/>
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlOprFromPrincipal" runat="server" 
                                            DataSourceID="sdsOperator" DataTextField="NAME" DataValueField="CODE" 
                                            SelectedValue='<%# Eval("PRINCIPALOPR1") %>'>
                                            </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField  >
                                    <Itemstyle HorizontalAlign="Right"/>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtPrincipalFrom" runat="server" style="text-align:right" 
                                            Text='<%# Eval("PRINCIPALFROM", "{0:N}") %>'>
                                            </asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>     
                                <asp:TemplateField HeaderText="TO">
                                    <Itemstyle HorizontalAlign="Right"/>
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlOprToPrincipal" runat="server" 
                                            DataSourceID="sdsOperator" DataTextField="NAME" DataValueField="CODE" 
                                            SelectedValue='<%# Eval("PRINCIPALOPR2") %>'>
                                            </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField >
                                    <Itemstyle  HorizontalAlign="Right"/>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtPrincipalTo" runat="server" style="text-align:right" 
                                            Text='<%# Eval("PRINCIPALTO", "{0:N}") %>'>
                                            </asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField >     
                                <asp:TemplateField >
                                    <Itemstyle  HorizontalAlign="Right"/>
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlJnsTrayek" runat="server" DataSourceID="sdsRouteKind" 
                                            DataTextField="NAME" DataValueField="CODE" 
                                            SelectedValue='<%# Eval("ROUTEKIND") %>'>
                                            </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField  >
                                <asp:TemplateField >
                                    <Itemstyle  HorizontalAlign="Right"/>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtEffRate" runat="server" CssClass="required" 
                                            style="text-align:right" Text='<%# Eval("EFFRATE", "{0:N}") %>' 
                                            Width="100px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="reqEffRate" runat="server" 
                                            ControlToValidate="txtEffRate" Display="None" 
                                            ErrorMessage="Effective Rate must be entry...!" SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEEffRate" runat="server" 
                                            HighlightCssClass="ErrHighLight" TargetControlID="reqEffRate"></ajaxToolkit:ValidatorCalloutExtender>
                                    </ItemTemplate>
                                </asp:TemplateField>   
                        </Columns>
                          <EmptyDataTemplate>
                            <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                        </EmptyDataTemplate>  
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsOperator" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        
                            SelectCommand="SELECT NULL AS CODE, ' -- ' AS NAME UNION ALL SELECT CODE, NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'OPERATOR')">
                </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsRouteKind" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            SelectCommand="SELECT NULL AS CODE, '(-- SELECT --) ' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'ROUTEKIND')">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                </table>
                <br />
                <br />
                <br />
                <br />
            </asp:Panel>
               <asp:Panel ID="pnlControlIntRate" runat="server" CssClass="HeaderStyle" Width="99%" Visible="false" >
                <table cellpadding="0" cellspacing="0" width="100%">
			        <tr>
				        <td>
                            <asp:Label ID="lblMessageIntRate" runat="server" CssClass="ErrHighLight" 
			                    Font-Bold="True" Font-Underline="True" Style="text-align: center" 
			                    Visible="False" Width="100%"></asp:Label>
                                <ajaxToolkit:AnimationExtender ID="ajaxAEMessageIntRate" runat="server" TargetControlID="lblMessageIntRate">
                                 <Animations>
                                    <OnLoad>
                                        <Sequence>
                                            <Pulse Duration="0.5" Iterations="0" />
                                        </Sequence>
                                    </OnLoad>
                                </Animations>
                                </ajaxToolkit:AnimationExtender>
                            <asp:Button ID="btnSaveIntRate" runat="server" 
                            Style="font-size: 8pt; cursor: pointer; background-image: url(../images/Save.gif); 
                            background-repeat: no-repeat; text-align: right;" Text="Save" ToolTip="Save" 
                                Width="55px"  />
                            <asp:Button ID="btnBackIntRate" runat="server"
                            Style="font-size: 8pt; cursor: pointer; background-image: url(../Images/back.png);
                            cursor: pointer; background-repeat: no-repeat;  text-align: right"
                            Text="Back" Width="55px" CausesValidation="False" 
                                ValidationGroup="Interest" />
                        </td>
			        </tr>
                </table>
            </asp:Panel>
        <ajaxToolkit:AlwaysVisibleControlExtender ID="AlwaysVisibleControlExtender1" runat="server" 
            TargetControlID="pnlControlIntRate" VerticalSide="Bottom"></ajaxToolkit:AlwaysVisibleControlExtender>
        </asp:View>
    </asp:MultiView>
    <script type="text/javascript" src="../include/TabEnter.js"></script>
     <script type="text/javascript" src="../include/TableHighLight.js"></script>
    <script type="text/javascript">

        FormatTable("<%=gvData.ClientID%>")
        FormatTable("<%=gvEffRate.ClientID%>");
        FormatTable("<%=gvDPMinimum.ClientID%>");
        function getObjectbyClientID(ClientID) {
            var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
            return (oObject)
        }

        function SetValueTxtByClientID(ClientID, sValue) {
            var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
            if (oText)
                oText.value = sValue;
        }

        function GetValueTxtByClientID(ClientID) {
            var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
            if (oText)
                return (oText.value);
        }
        window.onload = function () {
            TabToEnter();
            Load();
        }
        function Load() {
            var Action = GetValueTxtByClientID('<%=hidAction.ClientID%>');
            if (Action == "NEW") {
                $find("BehavArea").add_populated(onPopulatedArea);
                $find("BehavBranch").add_populated(onPopulatedBranch);
                $find("BehavProduct").add_populated(onPopulatedProduct);
                $find("BehavCategory").add_populated(onPopulatedCategory);
                $find("BehavObjectKind").add_populated(onPopulatedObjectKind);
            }
            if (Action == "EDIT") {
                if ($find("BehavArea"))
                    $find("BehavArea").add_populated(onPopulatedArea);
                if ($find("BehavBranch"))
                    $find("BehavBranch").add_populated(onPopulatedBranch);
                if ($find("BehavProduct"))
                    $find("BehavProduct").add_populated(onPopulatedProduct);
                if ($find("BehavCategory"))
                    $find("BehavCategory").add_populated(onPopulatedCategory);
                if ($find("BehavObjectKind"))
                    $find("BehavObjectKind").add_populated(onPopulatedObjectKind);
            }
        }
        function onPopulatedArea() {
            if (GetValueTxtByClientID("<%=hidAction.ClientID%>") == "EDIT") {
                $get("<%=ddlArea.ClientID%>").disabled = true;
            } else {
                $get("<%=ddlArea.ClientID%>").disabled = false;
            }
        }

        function onPopulatedBranch() {
            if (GetValueTxtByClientID("<%=hidAction.ClientID%>") == "EDIT") {
                $get("<%=ddlBranch.ClientID%>").disabled = true;
            } else {
                $get("<%=ddlBranch.ClientID%>").disabled = false;
            }
        }
        function onPopulatedProduct() {
            if (GetValueTxtByClientID("<%=hidAction.ClientID%>") == "EDIT") {
                $get("<%=ddlProduct.ClientID%>").disabled = true;
            } else {
                $get("<%=ddlProduct.ClientID%>").disabled = false;
            }
        }
        function onPopulatedCategory() {
            if (GetValueTxtByClientID("<%=hidAction.ClientID%>") == "EDIT") {
                $get("<%=ddlCategory.ClientID%>").disabled = true;
            } else {
                $get("<%=ddlCategory.ClientID%>").disabled = false;
            }
        }
        function onPopulatedObjectKind() {
            if (GetValueTxtByClientID("<%=hidAction.ClientID%>") == "EDIT") {
                $get("<%=ddlObjectKind.ClientID%>").disabled = true;
            } else {
                $get("<%=ddlObjectKind.ClientID%>").disabled = false;
            }
        }
      

        function FinStructureCopy() {
            var WinRef = window.open("FindFinanceStructure.aspx?Action=Find", "CopyFNStructure", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
            WinRef.focus()
            return (false);
        }
        function SetCopyFinanceStructure(AREACOPY, BRANCHCOPY, PRODUCTCOPY,CATEGORYCOPY,KINDCOPY) {
            SetValueTxtByClientID("<%=hidAREACopy.ClientID%>", AREACOPY);
            SetValueTxtByClientID("<%=hidBRANCHCopy.ClientID %>", BRANCHCOPY);
            SetValueTxtByClientID("<%=hidPRODUCTCopy.ClientID %>", PRODUCTCOPY);
            SetValueTxtByClientID("<%=hidCATEGORYCopy.ClientID %>", CATEGORYCOPY);
            SetValueTxtByClientID("<%=hidKINDCopy.ClientID %>", KINDCOPY);
            document.forms[0].action = "FinanceStructure.aspx?ACTION=COPYAUTOMATIC";
            document.forms[0].submit();
            return (true);
        }

//        function ProcessSave() {
//            if (Page_ClientValidate("")) {
//                return false;
//            }
//            return true;
        //        }
        function CheckUserSPVDlrFinStr() {
            if (Page_ClientValidate) {
                if (Page_ClientValidate("")) {
                    var RetVal = window.showModalDialog("../Home/UserLoginSPV.aspx", "SPVAuthor", "dialogWidth:300px;dialogHeight:200px;center:yes;edge:raised;help:no;status:no;");
                    if (RetVal.Login == 1)
                        return (true);
                    else
                        return (false);
                } else {
                    return (false);
                }
            }
        }


    </script>
  
</asp:Content>

