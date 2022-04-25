<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="InsurancePricing.aspx.vb" Inherits="Param_InsurancePricing" EnableEventValidation="false" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:ScriptManagerProxy ID="SMPCustPricing" runat="server">
	<Services>
	<asp:ServiceReference Path="GHWService.asmx" />
	</Services>
	</asp:ScriptManagerProxy>
       <asp:CheckBox ID="chkAddNew" runat="server" Font-Names="Lucida Sans" 
                            Font-Size="7.5pt" Visible="False"/>
        <asp:HiddenField ID="hidAction" runat="server" />
         <asp:TextBox ID="txtTmpSelectedIndex" runat="Server" style="display:none" Text="0" />    
    <asp:MultiView ID="MultiView_Utama" runat="server">
    <asp:View ID="View_View" runat="server">   
     <asp:Panel ID="pnlSearch" runat="server" GroupingText="Search Criteria" 
        Width="100%">
            <table cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td style="width: 115px" class="RowStyle">
	                Insurance</td>
				<td class="AlternatingRowStyle">
		            <asp:DropDownList ID="ddlSearchInsurance" runat="server" >
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="AjaxCDDSrcInsurance" runat="server"  Category="INSCOMPANYID" 
						LoadingText="[Loading Insurance Company ..]" PromptText="[DISPLAY ALL INSURANCE COMPANY]" 
						ServiceMethod="GetDropDownInsuranceCompany" ServicePath="~\Param\WebService.asmx" 
						TargetControlID="ddlSearchInsurance" ></ajaxToolkit:CascadingDropDown>
				</td>
			</tr>
		    <tr>
                <td style="width: 115px" class="RowStyle">
                    Branch</td>
                <td class="AlternatingRowStyle">
                    <asp:DropDownList ID="ddlSearchBranch" runat="server" >
                    </asp:DropDownList>
                        <ajaxToolkit:CascadingDropDown ID="AjaxCDDSrcBranch" runat="server" Category="INSCOMPANYID" 
						LoadingText="[Loading Branch Company ..]" PromptText="[DISPLAY ALL BRANCH COMPANY]" 
						ServiceMethod="GetDropDownBranchByInsCompany" ServicePath="~\Param\WebService.asmx" 
						TargetControlID="ddlSearchBranch" ParentControlID="ddlSearchInsurance"></ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
            <tr>
                <td style="width: 115px" class="RowStyle">
                    Product</td>
                <td class="AlternatingRowStyle">
                    <asp:DropDownList ID="ddlSearchProduct" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="AjaxCDDSrcProduct" runat="server" Category="Product" 
                        Enabled="True" LoadingText="[Loading Product..]" 
                        PromptText="[DISPLAY ALL PRODUCT]" ServiceMethod="GetDropDownProduct" 
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlSearchProduct">
                    </ajaxToolkit:CascadingDropDown>
                    &nbsp;</td>
            </tr>
		        <tr>
                    <td class="RowStyle" style="width: 115px">
                        Object Category</td>
                    <td class="AlternatingRowStyle">
                        <asp:DropDownList ID="ddlSearchCategory" runat="server">
                        </asp:DropDownList>
                        <ajaxToolkit:CascadingDropDown ID="ajaxCCEObjCategory" runat="server" 
                            Category="ObjCategory" Enabled="True" LoadingText="[Loading Object Category..]" 
                            ParentControlID="ddlSearchProduct" PromptText="[DISPLAY ALL PRODUCT]" 
                            ServiceMethod="GetDropDownObjCategoryByProduct" 
                            ServicePath="~\Param\WebService.asmx" TargetControlID="ddlSearchCategory">
                        </ajaxToolkit:CascadingDropDown>
                    </td>
                </tr>
                <tr>
                    <td class="RowStyle" style="width: 115px">
                        Object Purpose</td>
                    <td class="AlternatingRowStyle">
                        <asp:DropDownList ID="ddlSearchPurpose" runat="server">
                        </asp:DropDownList>
                        <ajaxToolkit:CascadingDropDown ID="ajaxCCEObjPurpose" runat="server" 
                            Category="ObjPurpose" Enabled="True" LoadingText="[Loading Object Purpose..]" 
                            ParentControlID="ddlSearchProduct" PromptText="[DISPLAY ALL PURPOSE]" 
                            ServiceMethod="GetDropDownObjPurposeByProductWithAll" 
                            ServicePath="~\Param\WebService.asmx" TargetControlID="ddlSearchPurpose">
                        </ajaxToolkit:CascadingDropDown>
                        <asp:Button ID="btnFunctionSearch" runat="server" CausesValidation="False" 
                            CssClass="Search" Style="font-size: 8pt; border-top-style: outset;
		border-right-style: outset; border-left-style: outset; border-bottom-style: outset;" Text="Search" />
                    </td>
                </tr>
		</table>
    </asp:Panel>
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
		
        	<asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CommandName="New" CausesValidation="False" />
		<asp:HiddenField ID="hidInsPricingID" runat="server" />
		<asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
			AutoGenerateColumns="False" DataKeyNames="INSPRICINGCOMPID,INSBRANCHID" DataSourceID="sdsGrid" 
			Width="100%" Caption="Insurance Pricing CompanyList" RowHeaderColumn="INSURANCECODE">
			<Columns>
				
              <asp:TemplateField ShowHeader="False">
                      <ItemTemplate>
                          <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False"  OnCommand="btnEdit_Command" 
                              CommandArgument='<%# CType(Container,GridViewRow).RowIndex %>'  ImageUrl="~/Images/edit.gif" Text="Delete" />
                      </ItemTemplate>
                      <ItemStyle Width="20px" HorizontalAlign="Center" />
                </asp:TemplateField>
              <%--  <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="20px" />
                </asp:CommandField>--%>
                <asp:TemplateField Visible="False">
                    <ItemTemplate>
                        <asp:label ID="lblBranchID" runat="server" Font-Size="Smaller" Font-Names="Lucida Sans" 
                            Visible="false" Text='<% #DataBinder.Eval(Container.DataItem,"INSBRANCHID") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
               
                <asp:BoundField DataField="PRODUCTNAME" HeaderText="Product&lt;br&gt;Name" 
                    SortExpression="PRODUCTNAME" HtmlEncode="False" />
                <asp:BoundField DataField="CATEGORYNAME" HeaderText="Category&lt;br&gt;Name" 
                    SortExpression="CATEGORYNAME" HtmlEncode="False" />
                <asp:BoundField DataField="PURPOSENAME" HeaderText="Purpose&lt;br&gt;Name" 
                    SortExpression="PURPOSENAME" HtmlEncode="False" />
                <asp:BoundField DataField="INSURANCETYPENM" HeaderText="Type&lt;br&gt;Name" 
                    SortExpression="INSURANCETYPENM" HtmlEncode="False" />
                <asp:BoundField DataField="BASERATE" HeaderText="Rate (%)" 
                    SortExpression="BASERATE" >
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="INSYEAR" HeaderText="Num of&lt;br&gt;Year" 
                    SortExpression="INSYEAR" HtmlEncode="False" >
			    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
			    <asp:BoundField DataField="SUMASSUREDFROM" DataFormatString="{0:n}" 
                    HeaderText="Sum Assured&lt;br&gt;From" HtmlEncode="False" 
                    SortExpression="SUMASSUREDFROM">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="SUMASSUREDTO" DataFormatString="{0:n}" 
                    HeaderText="Sum Assured&lt;br&gt;To" HtmlEncode="False" 
                    SortExpression="SUMASSUREDTO">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
			</Columns>
			<EmptyDataTemplate>
				<uc6:NoDataFound ID="NoDataFound1" runat="server" />
			</EmptyDataTemplate>
		</asp:GridView>
	    <asp:SqlDataSource ID="sdsGrid" runat="server" 
            ConnectionString="<%$ ConnectionStrings:connection %>" 
            
                
                
                SelectCommand="SELECT TOP (1000) PRODUCTID, INSBRANCHID, REMARK, (SELECT '(' + PRODUCTCODE + ') ' + PRODUCTNAME AS PRODUCTNAME FROM PRODUCT WHERE (PRODUCTID = INSPRICINGCOMP.PRODUCTID)) AS PRODUCTNAME, CATEGORYID, (SELECT '(' + CATEGORYCODE + ') ' + CATEGORYNAME AS CATEGORYNAME FROM OBJECTCATEGORY WHERE (CATEGORYID = INSPRICINGCOMP.CATEGORYID)) AS CATEGORYNAME, PURPOSEID, ISNULL((SELECT '(' + PURPOSECODE + ') ' + PURPOSENAME AS PURPOSENAME FROM OBJECTPURPOSE WHERE (PURPOSEID = INSPRICINGCOMP.PURPOSEID)), '[ALL PURPOSE]') AS PURPOSENAME, INSURANCETYPE, '(' + CAST(INSURANCETYPE AS VARCHAR(5)) + ') ' + dbo.f_getParamGlobalName('INSURANCETYPE', INSURANCETYPE) AS INSURANCETYPENM, (SELECT SUM(BASERATE) AS BASERATE FROM INSPRICINGCOMPDTL AS INSPRICINGCOMPDTL_1 WITH (NOLOCK) WHERE (INSPRICINGCOMPID = INSPRICINGCOMP.INSPRICINGCOMPID) AND (Deletests = 0)) AS BASERATE, (SELECT COUNT(INSYEAR) AS INSYEAR FROM INSPRICINGCOMPDTL AS INSPRICINGCOMPDTL WITH (NOLOCK) WHERE (INSPRICINGCOMPID = INSPRICINGCOMP.INSPRICINGCOMPID) AND (Deletests = 0)) AS INSYEAR, INSPRICINGCOMPID, SUMASSUREDFROM, SUMASSUREDTO FROM INSPRICINGCOMP WITH (NOLOCK) WHERE (Deletests = 0)">
        </asp:SqlDataSource>
	</asp:Panel>
    </asp:View>
    <asp:View ID="View_Form" runat="server">   
     	<asp:Panel ID="pnlForm" runat="server">
            <table style="width: 100%;" cellpadding="0" cellspacing="0">
            
            <tr>
                <td colspan="3"  class="HeaderStyle" style="text-align:center">
                        <asp:Label ID="lblCaption" runat="server"></asp:Label></td>
                    
            </tr>
            <tr>
                <td colspan="3">
                    <hr />
                </td>
            </tr>
            <tr id="rowNotaryID" >
                <td class="FooterStyle">
                    Inspricing Comp ID</td>
                <td colspan="2" class="AlternatingRowStyle">
                    <asp:Label ID="lblInspricingCompID" runat="server" Font-Bold="True" 
                        Font-Underline="True"></asp:Label>
                </td>
            </tr>
            <tr id="rowInsurance" >
                <td class="FooterStyle">
                    Insurance</td>
                <td class="AlternatingRowStyle" colspan="2">
                 
                       <asp:DropDownList ID="ddlInsurance" runat="server" CssClass="required" >
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="reqInsurance" runat="server" 
                        ControlToValidate="ddlInsurance" Display="None" 
                        ErrorMessage="Insurance must be entry...!" SetFocusOnError="True" 
                        ValidationGroup="Pricing"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqInsurance_ValidatorCalloutExtender" 
                        runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqInsurance"></ajaxToolkit:ValidatorCalloutExtender>
                     <ajaxToolkit:CascadingDropDown ID="ajaxCDDInsurance" runat="server" Category="INSCOMPANYID" BehaviorID="BehavInsurance"
                        Enabled="True" LoadingText="[Loading Insurance Company..]" PromptText="[SELECT INSURANCE COMPANY]" 
                        ServiceMethod="GetDropDownInsuranceCompany" ServicePath="~\Param\WebService.asmx" 
                        TargetControlID="ddlInsurance"></ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
            <tr>
                <td class="FooterStyle">
                    Branch</td>
                <td class="AlternatingRowStyle" colspan="2">
                    <asp:DropDownList ID="ddlBranch" runat="server"  CssClass="required"
                        DataTextField="INSBRANCHCODE" DataValueField="INSBRANCHID" 
                        ValidationGroup="Pricing">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="reqBranch" runat="server" 
                        ControlToValidate="ddlBranch" Display="None" 
                        ErrorMessage="Branch must be entry...!" SetFocusOnError="True" 
                        ValidationGroup="Pricing"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqBranch_ValidatorCalloutExtender" 
                        runat="server" HighlightCssClass="ErrHighLight" 
                        TargetControlID="reqBranch"></ajaxToolkit:ValidatorCalloutExtender>
                     <ajaxToolkit:CascadingDropDown ID="ajaxCDDBranch" runat="server" Category="INSCOMPANYID" 
						LoadingText="[Loading Branch Company ..]" PromptText="[SELECT BRANCH COMPANY]" BehaviorID="BehavBranch"
						ServiceMethod="GetDropDownBranchByInsCompany" ServicePath="~\Param\WebService.asmx" 
						TargetControlID="ddlBranch" ParentControlID="ddlInsurance"></ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
            <tr>
                <td class="FooterStyle">
                    Product</td>
                <td class="AlternatingRowStyle" colspan="2">
                    <asp:DropDownList ID="ddlProduct" runat="server" CssClass="required" 
                        DataTextField="PRODUCTNAME" DataValueField="PRODUCTID" 
                        ValidationGroup="Pricing">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCCDProduct" runat="server" Category="PRODUCTID" 
                        Enabled="True" LoadingText="[Loading Product..]" PromptText="[SELECT PRODUCT]" BehaviorID="BehavProduct"
                        ServiceMethod="GetDropDownProductPricing" ServicePath="~\Param\WebService.asmx" 
                        TargetControlID="ddlProduct"></ajaxToolkit:CascadingDropDown>
                    <asp:RequiredFieldValidator ID="reqProduct" runat="server" 
                        ControlToValidate="ddlProduct" Display="None" 
                        ErrorMessage="Product must be entry...!" SetFocusOnError="True" 
                        ValidationGroup="Pricing"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEproduct" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqProduct"></ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="FooterStyle">
                    Object Category</td>
                <td class="AlternatingRowStyle" colspan="2">
                    <asp:DropDownList ID="ddlType" runat="server" CssClass="required" 
                        DataTextField="CATEGORYNAME" DataValueField="CATEGORYID" 
                        ValidationGroup="Pricing">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDCategoryType" runat="server" 
                        Category="ProductID" LoadingText="[Loading Object Category..]" 
                        ParentControlID="ddlProduct" PromptText="[SELECT OBJECT CATEGORY]" 
                        ServiceMethod="GetDropDownCategoryByProduct" BehaviorID="BehavType"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlType"></ajaxToolkit:CascadingDropDown>
                    <asp:RequiredFieldValidator ID="reqType" runat="server" 
                        ControlToValidate="ddlType" Display="None" 
                        ErrorMessage="Type must be entry...!" SetFocusOnError="True" 
                        ValidationGroup="Pricing"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEType" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqType"></ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
                <tr>
                    <td class="FooterStyle">
                        Object Purposes</td>
                    <td class="AlternatingRowStyle" colspan="2">
                        <asp:DropDownList ID="ddlPurpose" runat="server" 
                            DataTextField="PURPOSENAME" DataValueField="PURPOSEID" 
                            ValidationGroup="Pricing">
                        </asp:DropDownList>
                        <ajaxToolkit:CascadingDropDown ID="ajaxCDDPurpose" runat="server" Category="ProductID" 
                            LoadingText="[Loading Object Purpose..]" ParentControlID="ddlProduct" 
                            BehaviorID="BehavObjectPurpose" PromptText="[ALL PURPOSE]" 
                            ServiceMethod="GetDropDownPurposeByCategory" 
                            ServicePath="~\Param\WebService.asmx" TargetControlID="ddlPurpose"></ajaxToolkit:CascadingDropDown>
                    </td>
                </tr>
                <tr>
                    <td class="FooterStyle">
                        Insurance Type</td>
                    <td class="AlternatingRowStyle" colspan="2">
                        <asp:DropDownList ID="ddlInsType" runat="server" CssClass="required" 
                            DataSourceID="sdsType" DataTextField="NAME" DataValueField="CODE" 
                            ValidationGroup="Pricing">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqInsType" runat="server" 
                            ControlToValidate="ddlInsType" Display="None" 
                            ErrorMessage="Insurance Type must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="Pricing"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEInsType" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqInsType"></ajaxToolkit:ValidatorCalloutExtender>
                        <asp:SqlDataSource ID="sdsType" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            SelectCommand="SELECT NULL AS CODE, '[CHOOSE TYPE]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'INSURANCETYPE')">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                   <tr>
                    <td class="FooterStyle">
                        Sum Assured</td>
                    <td class="AlternatingRowStyle" colspan="2">
                        From
                        <asp:TextBox ID="txtSumAssuredFrom" runat="server" style="text-align:right" CssClass="required"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="reqSumAssFrom" runat="server" ControlToValidate="txtSumAssuredFrom" 
                            Display="None" ErrorMessage="[SUM ASSURED FROM] must be entry...!" 
                            SetFocusOnError="True" ValidationGroup="Pricing">
                         </asp:RequiredFieldValidator>
                         <ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCESumAssFrom" runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqSumAssFrom"></ajaxToolkit:ValidatorCalloutExtender>
                        &nbsp;To
                        <asp:TextBox ID="txtSumAssuredTo" runat="server" style="text-align:right" CssClass="required"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="reqSumAssTo" runat="server" ControlToValidate="txtSumAssuredTo" 
                            Display="None" ErrorMessage="[SUM ASSURED TO] must be entry...!" 
                            SetFocusOnError="True" ValidationGroup="Pricing">
                      
                         </asp:RequiredFieldValidator>
                         <ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCESumAssTo" runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqSumAssTo"></ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
            <tr>
                <td colspan="3">
                
                             <asp:GridView ID="gvInsPricingComp" runat="server" AllowPaging="True"
                        AutoGenerateColumns="False" BorderWidth="1px" DataKeyNames="INSPRICINGCOMPID" 
                                 ShowFooter="True" style="margin-top: 0px" Width="100%">
                        <Columns>
                            
                            <asp:TemplateField HeaderText="DEL" ShowHeader="False"  ControlStyle-CssClass="HeaderStyle">
                                <ItemTemplate>
                                
                                    <asp:ImageButton ID="btnDelete" runat="server" CausesValidation="False" 
                                        CommandName="Delete" ImageAlign="Middle" ImageUrl="~/Images/delete.gif" 
                                        style="cursor: pointer" Text="Delete" />
                                </ItemTemplate>
                                   <ControlStyle CssClass="HeaderStyle" />
                                   <FooterStyle HorizontalAlign="center" CssClass="HeaderStyle" />
                                    <FooterTemplate>
                                            <asp:ImageButton ID="btnNew" runat="server" CausesValidation="True"  onclick="btnNew_Click"
                                            CommandName="New" ImageAlign="Middle" ImageUrl="~/Images/New.png" 
                                            style="cursor:pointer" Text="New" >
                                        </asp:ImageButton>
                                    </FooterTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </asp:TemplateField>
                           
                            <asp:TemplateField HeaderText="Year.">
                                <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate><%# Container.DataItemIndex + 1 %>
                                    <asp:HiddenField ID="hidInsYear" runat="server" value="<%# Container.DataItemIndex + 1 %>"/>
                                </ItemTemplate>
                                  <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </asp:TemplateField>
                           
                          <asp:TemplateField Visible="FALSE" >
                                <ItemTemplate>
                                     <asp:TextBox ID="txtINSYEAR" runat="server" Font-Names="Lucida Sans" 
                                        Font-Size="Smaller" Visible="false"
                                        Text='<%#Databinder.Eval(Container.DataItem,"INSYEAR") %>' ></asp:TextBox>
                                    <asp:TextBox ID="txtINSYEARID" runat="server" Font-Names="Lucida Sans" 
                                        Font-Size="Smaller" Visible="false"
                                        Text='<%#Databinder.Eval(Container.DataItem,"INSYEARCOMPID") %>' ></asp:TextBox>
                                </ItemTemplate>
                        </asp:TemplateField>               
                            <asp:TemplateField HeaderText="Rate" SortExpression="BASERATE">
                                <Itemstyle HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtBaseRate" runat="server" CssClass="required" 
                                        Font-Names="Lucida Sans" Font-Size="Smaller" style="text-align: right" 
                                        Text='<%# Eval("BASERATE") %>' Width="50px" ></asp:TextBox>%
                                        <asp:RequiredFieldValidator ID="reqBaseRate" runat="server" 
                                        ControlToValidate="txtBaseRate" Display="None" 
                                        ErrorMessage="Base Rate must be entry...!" SetFocusOnError="True"> 
                                                                </asp:RequiredFieldValidator>
                                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEBaseRate" runat="server" 
                                        HighlightCssClass="ErrHighLight" TargetControlID="reqBaseRate"></ajaxToolkit:ValidatorCalloutExtender>
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Disc.&lt;BR&gt;Rate" 
                                SortExpression="DISCOUNTRATE">
                                <Itemstyle HorizontalAlign="Right"  />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtDiscBaseRate" runat="server" CssClass="required" 
                                        Font-Names="Lucida Sans" Font-Size="Smaller" style="text-align: right" 
                                        Text='<%# Eval("DISCOUNTRATE") %>' Width="50px"></asp:TextBox>%
                                    <asp:RequiredFieldValidator ID="reqDiscBaseRate" runat="server" 
                                        ControlToValidate="txtDiscBaseRate" Display="None" 
                                        ErrorMessage="Discount Base Rate must be entry...!" SetFocusOnError="True"> 
                                                                </asp:RequiredFieldValidator>
                                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEDiscBaseRate" runat="server" 
                                        HighlightCssClass="ErrHighLight" TargetControlID="reqDiscBaseRate"></ajaxToolkit:ValidatorCalloutExtender>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="RSCC&lt;BR&gt;Rate" 
                                SortExpression="BASERATERSCC">
                                <Itemstyle HorizontalAlign="Right"  />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtBaseRateRSCC" runat="server"
                                        Font-Names="Lucida Sans" Font-Size="Smaller" style="text-align: right" 
                                        Text='<%# Eval("BASERATERSCC") %>' Width="50px"></asp:TextBox>%
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Disc.&lt;BR&gt;RSCC&lt;BR&gt;Rate" 
                                SortExpression="DISCOUNTRATERSCC">
                                <Itemstyle HorizontalAlign="Right"  />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtDiscBaseRateRSCC" runat="server"
                                        Font-Names="Lucida Sans" Font-Size="Smaller" style="text-align: right" 
                                        Text='<%# Eval("DISCOUNTRATERSCC") %>' Width="50px"></asp:TextBox>%
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="RSMB&lt;BR&gt;Rate" 
                                SortExpression="BASERATERSMB">
                                <Itemstyle HorizontalAlign="Right"  />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtRSMBRate" runat="server" 
                                        Font-Names="Lucida Sans" Font-Size="Smaller" style="text-align: right" 
                                        Text='<%# Eval("BASERATERSMB") %>' Width="50px"></asp:TextBox>%
                                </ItemTemplate>
                            </asp:TemplateField>
                              <asp:TemplateField HeaderText="Disc.&lt;BR&gt;RSMB&lt;BR&gt;Rate" 
                                SortExpression="DISCOUNTRATERSMB">
                                <Itemstyle HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtDiscBaseRateRSMB" runat="server"
                                        Font-Names="Lucida Sans" Font-Size="Smaller" style="text-align: right" 
                                        Text='<%# Eval("DISCOUNTRATERSMB") %>' Width="50px"></asp:TextBox>%
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Other&lt;br&gt;Rate" 
                                SortExpression="BASERATEOTHER">
                                <Itemstyle HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtRSMBRateOther" runat="server" 
                                        Font-Names="Lucida Sans" Font-Size="Smaller" style="text-align: right" 
                                        Text='<%# Eval("BASERATEOTHER") %>' Width="50px"></asp:TextBox>%
                                </ItemTemplate>
                            </asp:TemplateField>
                                <asp:TemplateField HeaderText="Disc.&lt;br&gt;Other&lt;br&gt;Rate" 
                                SortExpression="DISCOUNTRATEOTHER">
                                <Itemstyle HorizontalAlign="Right"/>
                                <ItemTemplate>
                                    <asp:TextBox ID="txtDiscBaseRateRSMBOther" runat="server"
                                        Font-Names="Lucida Sans" Font-Size="Smaller" style="text-align: right" 
                                        Text='<%# Eval("DISCOUNTRATEOTHER") %>' Width="50px"></asp:TextBox>%
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <uc6:NoDataFound ID="NoDataFound2" runat="server" />
                        </EmptyDataTemplate>
                    </asp:GridView>
                    
                </td>
            </tr>
            <tr>
                <td class="ShowDetail">
                    Remark</td>
                <td class="ShowDetail">
                    <asp:TextBox ID="txtRemark" runat="server" Rows="3" TextMode="MultiLine" 
                        Width="300px"></asp:TextBox>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                 
                </td>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
          
            <asp:Panel ID="pnlControl" runat="server" CssClass="HeaderStyle" Width="99%" Visible="false" >
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
                            Style="font-size: 8pt; cursor: pointer; background-position: left; background-image: url(../images/Save.gif); 
                            background-repeat: no-repeat; text-align: right;" Text="Save" ToolTip="Save" 
                                Width="55px" ValidationGroup="Pricing" 
                                onclientclick="return CheckUserSPVSaveInsPrc()" />
                            <asp:Button ID="btnDelete" runat="server" CausesValidation="False" 
                                Style="font-size: 8pt; cursor: pointer; background-position: left; background-image: url(../Images/Delete.gif); cursor: pointer; background-repeat: no-repeat;  text-align: right" 
                                Text="Delete" Width="55px" 
                                onclientclick="return CheckUserSPVDelInsPrc();" />
                            <asp:Button ID="btnCancel" runat="server"
                            Style="font-size: 8pt; cursor: pointer; background-position: left; background-image: url(../Images/back.png);
                            cursor: pointer; background-repeat: no-repeat;  text-align: right"
                            Text="Back" Width="55px" CausesValidation="False" 
                                ValidationGroup="Collector" />
                        </td>
			        </tr>
                </table>
            </asp:Panel>
        <br>
        <br>
        <br>
        <br>
        <br>

        <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEControl" runat="server" 
            TargetControlID="pnlControl" VerticalSide="Bottom"></ajaxToolkit:AlwaysVisibleControlExtender>
      </asp:Panel>
    </asp:View>
    </asp:MultiView>
     <script type="text/javascript" src="../include/TableHighLight.js"></script>
    <script type="text/javascript">

        FormatTable("<%=gvData.ClientID%>");
        FormatTable("<%=gvInsPricingComp.ClientID%>");
        
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
            Load();
        }
        function Load() {
            var Action = GetValueTxtByClientID('<%=hidAction.ClientID%>');
            if (Action == "NEW") {
                HidRowID();
                if ($find("BehavInsurance")) {
                    $find("BehavInsurance").add_populated(onPopulatedInsurance);
                    $find("BehavBranch").add_populated(onPopulatedBranch);
                    $find("BehavProduct").add_populated(onPopulatedProduct);
                    $find("BehavType").add_populated(onPopulatedCategory);
                    $find("BehavObjectPurpose").add_populated(onPopulatedObjectKind);
                }
            }
            if (Action == "EDIT") {
                displayRowID();
                if ($find("BehavInsurance")) {
                    $find("BehavInsurance").add_populated(onPopulatedInsurance);
                    $find("BehavBranch").add_populated(onPopulatedBranch);
                    $find("BehavProduct").add_populated(onPopulatedProduct);
                    $find("BehavType").add_populated(onPopulatedCategory);
                    $find("BehavObjectPurpose").add_populated(onPopulatedObjectKind);
                }
            }
        }

        function displayRowID() {
            var row = getObjectbyClientID("rowNotaryID");
            if (row)
                row.style.display = "";
        }
        function HidRowID() {
            var row = getObjectbyClientID("rowNotaryID");
            if (row)
                row.style.display = "none";
        }
        function onPopulatedInsurance() {
            if (GetValueTxtByClientID("<%=hidAction.ClientID%>") == "EDIT") {
                $get("<%=ddlInsurance.ClientID%>").disabled = true;
            } else {
                $get("<%=ddlInsurance.ClientID%>").disabled = false;
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
                $get("<%=ddlType.ClientID%>").disabled = true;
            } else {
                $get("<%=ddlType.ClientID%>").disabled = false;
            }
        }
        function onPopulatedObjectKind() {
            if (GetValueTxtByClientID("<%=hidAction.ClientID%>") == "EDIT") {
                $get("<%=ddlPurpose.ClientID%>").disabled = true;
            } else {
                $get("<%=ddlPurpose.ClientID%>").disabled = false;
            }
        }

        function CheckUserSPVSaveInsPrc() {
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

        function CheckUserSPVDelInsPrc() {
            var RetVal = window.showModalDialog("../Home/UserLoginSPV.aspx", "SPVAuthor", "dialogWidth:300px;dialogHeight:200px;center:yes;edge:raised;help:no;status:no;");
            if (RetVal.Login == 1)
                return (true);
            else
                return (false);
        }
</script>

</asp:Content>

