<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="OTR.aspx.vb" EnableEventValidation="false" Inherits="Param_OTR" %>
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
        <asp:HiddenField ID="hidTypeID" runat="server" />
        <asp:HiddenField ID="hidProductID" runat="server" />
        <asp:HiddenField ID="hidMerkID" runat="server" />
        <asp:HiddenField ID="hidModelId" runat="server" />
        <asp:HiddenField ID="hidFinID" runat="server" />
    <asp:TextBox ID="txtTmpSelectedIndex" runat="Server" style="display:none" Text="0" />    
   <asp:MultiView ID="MultiView_Utama" runat="server">
        <asp:View ID="View_View" runat="server">   
	        <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail">
		            <div style="float: right; vertical-align: middle">
			            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
			            <asp:Label ID="lblShow" runat="server">(Show Details...)</asp:Label>
		            </div>
		                <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
			                background-repeat: no-repeat; height: 16px" type="button" />
            </asp:Panel>
	                <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
		                CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Detail...)" Enabled="True"
		                ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Detail...)"
		                ImageControlID="imgButtonShow" TargetControlID="pnlSearch" TextLabelID="lblShow"></ajaxToolkit:CollapsiblePanelExtender>
	        <asp:Panel ID="pnlSearch" runat="server" GroupingText="Search Criteria" 
                CssClass="FooterStyle">
		        <table  style="width: 100%;" cellpadding="0" cellspacing="0" >
		            <tr>
                        <td style="width: 115px" class="RowStyle">
                            Product</td>
                        <td class="RowStyle">
                            <asp:DropDownList ID="ddlSearchProduct" runat="server" AutoPostBack="false" DataTextField="PRODUCTNAME" 
                                DataValueField="PRODUCTID" CssClass="required" ValidationGroup="Search">
                            </asp:DropDownList>
                            <ajaxToolkit:CascadingDropDown ID="ajaxCDDSearchProduct" runat="server" 
                                Category="PRODUCT" Enabled="True" LoadingText="[Loading Product..]" 
                                PromptText="[SELECT PRODUCT]" ServiceMethod="GetDropDownProductPricing" BehaviorID="BehavSearchProduct"
                                ServicePath="~\Param\WebService.asmx" TargetControlID="ddlSearchProduct"></ajaxToolkit:CascadingDropDown>
                            <asp:RequiredFieldValidator ID="reqSearchProduct" runat="server" 
                                ControlToValidate="ddlSearchProduct" Display="None" 
                                ErrorMessage="[PRODUCT] must be entry...!" SetFocusOnError="True">

                            </asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCESearchProduct" 
                                runat="server" HighlightCssClass="ErrHighLight" 
                                TargetControlID="reqSearchProduct" BehaviorID="reqVCESearchProduct"></ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
		            <tr>
                        <td style="width: 115px" class="AlternatingRowStyle">
                            Merk</td>
                        <td class="AlternatingRowStyle">
                            <asp:DropDownList ID="ddlSearchMerk" runat="server" AutoPostBack="false" DataTextField="MERKNAME" 
                                DataValueField="MERKID" CssClass="required" ValidationGroup="Search">
                            </asp:DropDownList>
                            <ajaxToolkit:CascadingDropDown ID="ajaxCDDSearchMerk" runat="server" Category="Merk" 
                                LoadingText="[Loading Merk..]" ParentControlID="ddlSearchProduct" 
                                PromptText="[SELECT MERK]" BehaviorID="BehavSearchMerk" 
                                ServiceMethod="GetDropDownMerkByProduct" 
                                ServicePath="~\Param\WebService.asmx" TargetControlID="ddlSearchMerk"></ajaxToolkit:CascadingDropDown>
                            <asp:RequiredFieldValidator ID="reqSearchMerk" runat="server" 
                                ControlToValidate="ddlSearchMerk" Display="None" 
                                ErrorMessage="[MERK] must be entry...!" SetFocusOnError="True" 
                                ValidationGroup="Search">
                            </asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCESearchMerk" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqSearchMerk" 
                                BehaviorID="reqVCESearchMerk"></ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
		            <tr>
                        <td style="width: 115px" class="RowStyle">
                            Model</td>
                        <td class="RowStyle">
                            <asp:DropDownList ID="ddlSearchModel" runat="server" DataTextField="MODELNAME" 
                                DataValueField="MODELID" AutoPostBack="false" CssClass="required" 
                                ValidationGroup="Search">
                            </asp:DropDownList>
                             <ajaxToolkit:CascadingDropDown ID="ajaxCDDSearchModel" runat="server" Category="Model" 
                                LoadingText="[Loading Model..]" ParentControlID="ddlSearchMerk" 
                                PromptText="[SELECT MODEL]" BehaviorID="BehavSearchModel"
                                ServiceMethod="GetDropDownModelByMerk" 
                                ServicePath="~\Param\WebService.asmx" TargetControlID="ddlSearchModel"></ajaxToolkit:CascadingDropDown>
                            <asp:RequiredFieldValidator ID="reqSearchModel" runat="server" 
                                ControlToValidate="ddlSearchModel" Display="None" 
                                ErrorMessage="[MODEL] must be entry...!" SetFocusOnError="True" 
                                ValidationGroup="Search">
                            </asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCESearchModel" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqSearchModel" 
                                BehaviorID="ajaxVCESearchModel"></ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
		            <tr>
                        <td style="width: 115px" class="AlternatingRowStyle">
                            Type</td>
                        <td class="AlternatingRowStyle">
                            <asp:DropDownList ID="ddlSearchType" runat="server" DataTextField="TYPENAME" 
                                DataValueField="OBJECTTYPEID" AutoPostBack="false" CssClass="required" 
                                ValidationGroup="Search">
                            </asp:DropDownList>
                               <ajaxToolkit:CascadingDropDown ID="ajaxCDDSearchType" runat="server" Category="Model" 
                                LoadingText="[Loading Type..]" ParentControlID="ddlSearchModel" 
                                PromptText="[SELECT TYPE]" BehaviorID="BehavSearchType"
                                ServiceMethod="GetDropDownObjecTypeByModel" 
                                ServicePath="~\Param\WebService.asmx" TargetControlID="ddlSearchType"></ajaxToolkit:CascadingDropDown>
                            <asp:RequiredFieldValidator ID="reqSearchType" runat="server" 
                                ControlToValidate="ddlSearchType" Display="None" 
                                ErrorMessage="[TYPE] must be entry...!" SetFocusOnError="True" 
                                ValidationGroup="Search">
                            </asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCESearchType" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqSearchType" 
                                BehaviorID="ajaxVCESearchType"></ajaxToolkit:ValidatorCalloutExtender>
                            <asp:Button ID="btnSearch" runat="server" 
                                Style="font-size: 8pt; cursor: pointer; background-position: left; background-image: url(../images/search.gif); background-repeat: no-repeat; text-align: right;" 
                                Text="Search" ToolTip="Search" Width="55px" ValidationGroup="Search" />
                        </td>
                    </tr>
                   
		        </table>
	        </asp:Panel>
             <asp:GridView ID="GvwSearch" runat="server" 
                    AutoGenerateColumns="False" 
                 style="margin-top: 0px" Width="100%" 
                    DataSourceID="sdsData">
                    <Columns>
                        <asp:TemplateField HeaderText="NO" >
                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                                <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="5%" />
                        </asp:TemplateField>
                        
                        <asp:BoundField DataField="YEARFROM" HeaderText="Year&lt;br&gt;From" 
                            HtmlEncode="False" SortExpression="YEARFROM" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="YEARTO" HeaderText="Year&lt;br&gt;To" 
                            HtmlEncode="False" SortExpression="YEARTO" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CONDITIONNAME" HeaderText="Condition" 
                            SortExpression="CONDITIONNAME" />
                        <asp:BoundField DataField="RECOMMENDEDVALUE" DataFormatString="{0:N}" 
                            HeaderText="Recommended&lt;br&gt;Value" HtmlEncode="False" 
                            SortExpression="RECOMMENDEDVALUE" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="RECOMMENDEDPRINCIPAL" DataFormatString="{0:N}" 
                            HeaderText="Recommended&lt;br&gt;Principal" HtmlEncode="False" 
                            SortExpression="RECOMMENDEDPRINCIPAL" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>
                    <EmptyDataTemplate>
                        <uc6:NoDataFound ID="NoDataFound2" runat="server" />
                    </EmptyDataTemplate>
                </asp:GridView>
            <asp:SqlDataSource ID="sdsData" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                
                SelectCommand="SELECT OBJECTVALUEID, CAST(OBJECTTYPEID AS VARCHAR(10)) AS OBJECTTYPEID, YEARFROM, YEARTO, '(' + CAST(CONDITION AS VARCHAR(10)) + ') ' + dbo.f_getParamGlobalName('CONDITION', CONDITION) AS CONDITIONNAME, RECOMMENDEDVALUE, RECOMMENDEDPRINCIPAL FROM FNOBJECTVALUE WHERE (OBJECTTYPEID = @OBJECTTYPEID) AND (Deletests = 0)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlSearchType" Name="OBJECTTYPEID" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:View>
        <asp:View ID="View_OTR" runat="server">   
            <asp:Panel ID="pnlData" runat="server" GroupingText="Edit Recommended OTR" 
                CssClass="FooterStyle">
		        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            
            <tr>
                <td colspan="2"  class="HeaderStyle" style="text-align:center">
                        <asp:Label ID="lblCaption" runat="server"></asp:Label></td>
                    
            </tr>
            <tr>
                <td class="RowStyle" width="115px">
                    Product</td>
                <td class="RowStyle">
                    <asp:DropDownList ID="ddlProduct" runat="server" CssClass="required" 
                        DataTextField="PRODUCTNAME" DataValueField="PRODUCTID" 
                        ValidationGroup="Pricing">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDProduct" runat="server" 
                        Category="PRODUCT" Enabled="True" LoadingText="[Loading Product..]" 
                        PromptText="[SELECT PRODUCT]" ServiceMethod="GetDropDownProductPricing" BehaviorID="BehavProduct"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlProduct"></ajaxToolkit:CascadingDropDown>
                    <asp:RequiredFieldValidator ID="reqProduct" runat="server" 
                        ControlToValidate="ddlProduct" Display="None" 
                        ErrorMessage="[PRODUCT] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqProduct_ValidatorCalloutExtender" 
                        runat="server" HighlightCssClass="ErrHighLight" 
                        TargetControlID="reqProduct" BehaviorID="reqVCEProduct"></ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        Merk</td>
                    <td class="AlternatingRowStyle">
                        <asp:DropDownList ID="ddlMerk" runat="server" AutoPostBack="false" DataTextField="MERKNAME" 
                                DataValueField="MERKID" CssClass="required">
                            </asp:DropDownList>
                            <ajaxToolkit:CascadingDropDown ID="ajaxCDDMerk" runat="server" Category="Merk" 
                                LoadingText="[Loading Merk..]" ParentControlID="ddlProduct" 
                                PromptText="[SELECT MERK]" BehaviorID="BehavMerk" 
                                ServiceMethod="GetDropDownMerkByProduct" 
                                ServicePath="~\Param\WebService.asmx" TargetControlID="ddlMerk"></ajaxToolkit:CascadingDropDown>
                            <asp:RequiredFieldValidator ID="reqMerk" runat="server" 
                                ControlToValidate="ddlMerk" Display="None" 
                                ErrorMessage="[MERK] must be entry...!" SetFocusOnError="True" 
                                ValidationGroup="Search">
                            </asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="reqVCEMerk" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqMerk" 
                                BehaviorID="reqVCEMerk"></ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
            <tr>
                <td class="RowStyle">
                    Model</td>
                <td class="RowStyle">
                      <asp:DropDownList ID="ddlModel" runat="server" DataTextField="MODELNAME" 
                                DataValueField="MODELID" AutoPostBack="false" CssClass="required">
                            </asp:DropDownList>
                             <ajaxToolkit:CascadingDropDown ID="ajaxCDDModel" runat="server" Category="Model" 
                                LoadingText="[Loading Model..]" ParentControlID="ddlMerk" 
                                PromptText="[SELECT MODEL]" BehaviorID="BehavModel"
                                ServiceMethod="GetDropDownModelByMerk" 
                                ServicePath="~\Param\WebService.asmx" TargetControlID="ddlModel"></ajaxToolkit:CascadingDropDown>
                            <asp:RequiredFieldValidator ID="reqModel" runat="server" 
                                ControlToValidate="ddlModel" Display="None" 
                                ErrorMessage="[MODEL] must be entry...!" SetFocusOnError="True" 
                                ValidationGroup="Search">
                            </asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="reqVCEModel" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqModel" 
                                BehaviorID="ajaxVCEModel"></ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
                    <tr>
                        <td class="AlternatingRowStyle">
                            Type</td>
                        <td class="AlternatingRowStyle">
                            <asp:DropDownList ID="ddlType" runat="server" DataTextField="TYPENAME" 
                                DataValueField="OBJECTTYPEID" AutoPostBack="false" CssClass="required">
                            </asp:DropDownList>
                               <ajaxToolkit:CascadingDropDown ID="ajaxCDDType" runat="server" Category="Type" 
                                LoadingText="[Loading Type..]" ParentControlID="ddlModel" 
                                PromptText="[SELECT TYPE]" BehaviorID="BehavType"
                                ServiceMethod="GetDropDownObjecTypeByModel" 
                                ServicePath="~\Param\WebService.asmx" TargetControlID="ddlType"></ajaxToolkit:CascadingDropDown>
                            <asp:RequiredFieldValidator ID="reqType" runat="server" 
                                ControlToValidate="ddlType" Display="None" 
                                ErrorMessage="[TYPE] must be entry...!" SetFocusOnError="True" 
                                ValidationGroup="Search">
                            </asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="reqVCEType" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqType" 
                                BehaviorID="ajaxVCEType"></ajaxToolkit:ValidatorCalloutExtender>
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
                            <asp:GridView ID="gvOTR" runat="server" 
                                AutoGenerateColumns="False" 
                                DataKeyNames="OBJECTVALUEID,OBJECTTYPEID" OnRowCreated="gvOTR_RowCreated"  
                                ShowFooter="True" style="margin-top: 0px" Width="100%" PageSize="15">
                                <Columns>
                                    <asp:TemplateField ControlStyle-CssClass="HeaderStyle" HeaderText="DEL" 
                                        ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnDelete" runat="server" CausesValidation="False" 
                                                CommandName="Delete" ImageAlign="Middle" ImageUrl="~/Images/delete.gif" 
                                                CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>" 
                                                style="cursor: pointer" Text="Delete" 
                                                onclientclick="return confirm(&quot;Are you sure want to delete?&quot;)" />
                                        </ItemTemplate>
                                    <ControlStyle CssClass="HeaderStyle" />
                                    <ControlStyle CssClass="HeaderStyle" />
                                    <FooterStyle CssClass="HeaderStyle" HorizontalAlign="center" />
                                        <FooterTemplate>
                                            <asp:ImageButton ID="btnNewOTR" runat="server" CausesValidation="True" ValidationGroup="AddOTR"
                                                CommandName="New" ImageAlign="Middle" ImageUrl="~/Images/New.png" 
                                                onclick="btnNewOTR_Click" style="cursor:pointer" Text="New" />
                                        </FooterTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField >
                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                            <ItemTemplate>
                                                  <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="FALSE">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtOBJECTVALUEID" runat="server" Text='<%#Databinder.Eval(Container.DataItem,"OBJECTVALUEID") %>' 
                                                Visible="false"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Year From" SortExpression="YEARFROM">
                                        <Itemstyle HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtYearFrom" runat="server" CssClass="required" MaxLength="4" ValidationGroup="AddOTR"
                                                    style="text-align: right" Text='<%# Eval("YEARFROM") %>' Width="50px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="reqYearFrom" runat="server" 
                                                    ControlToValidate="txtYearFrom" Display="None" ValidationGroup="AddOTR"
                                                    ErrorMessage="Year From must be entry...!" SetFocusOnError="True"> 
                                                </asp:RequiredFieldValidator>
                                                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEYearFrom" runat="server" 
                                                    HighlightCssClass="ErrHighLight" TargetControlID="reqYearFrom">
                                                </ajaxToolkit:ValidatorCalloutExtender>
                                            </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Year To" SortExpression="YEARTO">
                                        <Itemstyle HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtYearTo" runat="server" CssClass="required" MaxLength="4" ValidationGroup="AddOTR"
                                                    style="text-align: right" Text='<%# Eval("YEARTO") %>' Width="50px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="reqYearTo" runat="server" ValidationGroup="AddOTR"
                                                    ControlToValidate="txtYearTo" Display="None" 
                                                    ErrorMessage="To From must be entry...!" SetFocusOnError="True"> 
                                                </asp:RequiredFieldValidator>
                                                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEYearTo" runat="server" 
                                                    HighlightCssClass="ErrHighLight" TargetControlID="reqYearTo">
                                                </ajaxToolkit:ValidatorCalloutExtender>
                                            </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField SortExpression="CONDITION">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlCondition" runat="server" CssClass="required" ValidationGroup="AddOTR"
                                                    DataSourceID="sdsCondition" DataTextField="NAME" DataValueField="CODE" 
                                                    SelectedValue='<%# Eval("CONDITION") %>'>
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="reqCondition" runat="server" 
                                                    ControlToValidate="ddlCondition" Display="None" ValidationGroup="AddOTR"
                                                    ErrorMessage="Condition must be entry...!" SetFocusOnError="True"> 
                                                </asp:RequiredFieldValidator>
                                                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECondition" runat="server" 
                                                    HighlightCssClass="ErrHighLight" TargetControlID="reqCondition">
                                                </ajaxToolkit:ValidatorCalloutExtender>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField  SortExpression="RECOMMENDEDVALUE">
                                        <Itemstyle HorizontalAlign="Right" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtRECOMMENDEDVALUE" runat="server" CssClass="required" style="text-align: right" ValidationGroup="AddOTR"
                                                    Text='<%# Eval("RECOMMENDEDVALUE","{0:N}") %>'></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="reqOTR" runat="server" ControlToValidate="txtRECOMMENDEDVALUE" ValidationGroup="AddOTR"
                                                    Display="None" ErrorMessage="Recommended OTR must be entry...!" SetFocusOnError="True">
                                                </asp:RequiredFieldValidator>
                                                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEOTR" runat="server" 
                                                    HighlightCssClass="ErrHighLight" TargetControlID="reqOTR">
                                                </ajaxToolkit:ValidatorCalloutExtender>
                                            </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField  SortExpression="RECOMMENDEDPRINCIPAL">
                                        <Itemstyle HorizontalAlign="Right" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtRECOMMENDEDPRINCIPAL" runat="server" style="text-align: right" CssClass="required" 
                                                    Text='<%# Eval("RECOMMENDEDPRINCIPAL","{0:N}") %>'></asp:TextBox>
                                                 <asp:RequiredFieldValidator ID="reqRecPrincipal" runat="server" ControlToValidate="txtRECOMMENDEDPRINCIPAL" ValidationGroup="AddOTR"
                                                    Display="None" ErrorMessage="RECOMMENDED PRINCIPAL must be entry...!" SetFocusOnError="True">
                                                </asp:RequiredFieldValidator>
                                                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPRINCIPAL" runat="server" 
                                                    HighlightCssClass="ErrHighLight" TargetControlID="reqRecPrincipal">
                                                </ajaxToolkit:ValidatorCalloutExtender>
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
                                Style="font-size: 8pt; cursor: pointer; background-position: left; background-image: url(../images/Save.gif); background-repeat: no-repeat; text-align: right;" 
                                Text="Save" ToolTip="Save" Width="55px" 
                                onclientclick="return CheckValidator();" ValidationGroup="AddOTR" />
                            <asp:Button ID="btnbackView" runat="server" CausesValidation="False" 
                                Style="font-size: 8pt; cursor: pointer; background-position: left; background-image: url(../Images/back.png); cursor: pointer; background-repeat: no-repeat;  text-align: right" 
                                Text="Back" ValidationGroup="Collector" Width="55px" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEControl" runat="server" 
                TargetControlID="pnlControl" VerticalSide="Bottom"></ajaxToolkit:AlwaysVisibleControlExtender>
      </asp:View>
    </asp:MultiView>
     <script type="text/javascript" src="../include/TableHighLight.js"></script>
    <script type="text/javascript">
        FormatTable("<%=gvOTR.ClientID%>");
        FormatTable("<%=GvwSearch.ClientID%>");
        
        function getObjectbyClientID(ClientID) {
            var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
            return (oObject);
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
        /*
        window.onload = function () {
            TabToEnter();
            Load();
        }*/
        window.onload = function () {
            //TabToEnter();
            Load();
        }
        function Load() {
            var Action = GetValueTxtByClientID('<%=hidAction.ClientID%>');
            if (Action == "NEW") {
                $find("BehavProduct").add_populated(onPopulatedProduct);
                $find("BehavMerk").add_populated(onPopulatedMerk);
                $find("BehavModel").add_populated(onPopulatedModel);
                $find("BehavType").add_populated(onPopulatedType);
            }
            if (Action == "EDIT") {
                if ($find("BehavProduct"))
                    $find("BehavProduct").add_populated(onPopulatedProduct);
                if ($find("BehavMerk"))
                    $find("BehavMerk").add_populated(onPopulatedMerk);
                if ($find("BehavModel"))
                    $find("BehavModel").add_populated(onPopulatedModel);
                if ($find("BehavType"))
                    $find("BehavType").add_populated(onPopulatedType);
            }
        }
        function onPopulatedProduct() {
            if (GetValueTxtByClientID("<%=hidAction.ClientID%>") == "EDIT") {
                $get("<%=ddlProduct.ClientID%>").disabled = true;
            } else {
                $get("<%=ddlProduct.ClientID%>").disabled = false;
            }
        }

        function onPopulatedMerk() {
            if (GetValueTxtByClientID("<%=hidAction.ClientID%>") == "EDIT") {
                $get("<%=ddlMerk.ClientID%>").disabled = true;
            } else {
                $get("<%=ddlMerk.ClientID%>").disabled = false;
            }
        }
        function onPopulatedModel() {
            if (GetValueTxtByClientID("<%=hidAction.ClientID%>") == "EDIT") {
                $get("<%=ddlModel.ClientID%>").disabled = true;
            } else {
                $get("<%=ddlModel.ClientID%>").disabled = false;
            }
        }
        function onPopulatedType() {
            if (GetValueTxtByClientID("<%=hidAction.ClientID%>") == "EDIT") {
                $get("<%=ddlType.ClientID%>").disabled = true;
            } else {
                $get("<%=ddlType.ClientID%>").disabled = false;
            }
        }
        function doClick(e, buttonid) {
            var evt = e ? e : window.event;
            var bt = document.getElementById(buttonid);
            
            if (bt) {
                if (evt.keyCode == 13) {
                    //bt.click();
                    return false;
                }
            }
        }
        function CheckValidator() {
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

