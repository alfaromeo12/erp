<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" EnableEventValidation="false" CodeFile="Route.aspx.vb" Inherits="Param_Route" title="Route" %>
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
		ImageControlID="imgButtonShow" TargetControlID="pnlSearchMaintenance" TextLabelID="lblShow">
	</ajaxToolkit:CollapsiblePanelExtender>
	
    <asp:Panel ID="pnlSearchMaintenance" runat="server">
		<table cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td style="width: 115px">
	<asp:DropDownList ID="ddlCriteria" runat="server">
		<asp:ListItem Value="RouteName">Route Name</asp:ListItem>
		<asp:ListItem Value="ROUTENO">Route No.</asp:ListItem>
	</asp:DropDownList></td>
				<td>
					<asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
		ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
		border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
		Text="Search" CausesValidation="False" CssClass="Search" />
					</td>
			</tr>
			<tr>
				<td style="width: 115px">
					Route Kind</td>
				<td>
					<asp:DropDownList ID="ddlRouteKindSearch" runat="server" AutoPostBack="True" 
						DataSourceID="sdsRouteKindSearch" DataTextField="NAME" DataValueField="CODE">
					</asp:DropDownList>
					<asp:SqlDataSource ID="sdsRouteKindSearch" runat="server" 
						ConnectionString="<%$ ConnectionStrings:connection %>" 
						
                        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL ROUTE KIND]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'ROUTEKIND')">
					</asp:SqlDataSource>
				</td>
			</tr>
			<tr>
				<td style="width: 115px">
					Route Group</td>
				<td>
					<asp:DropDownList ID="ddlRouteGroupSearch" runat="server" AutoPostBack="True" 
						DataSourceID="sdsRouteGroupSearch" DataTextField="NAME" DataValueField="CODE">
					</asp:DropDownList>
					<asp:SqlDataSource ID="sdsRouteGroupSearch" runat="server" 
						ConnectionString="<%$ ConnectionStrings:connection %>" 
						
                        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL ROUTE GROUP]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'ROUTEGROUP')">
					</asp:SqlDataSource>
				</td>
			</tr>
		</table>

	<asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CommandName="New" CausesValidation="False" />
		</asp:Panel>
        <asp:Panel ID="pnlData" runat="server">
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
			AutoGenerateColumns="False" DataKeyNames="ROUTEID" DataSourceID="sdsGrid" 
			Width="100%" Caption="Route List" RowHeaderColumn="ROUTEID">
			<Columns>
				<asp:TemplateField ShowHeader="False">
					<ItemTemplate>
						<asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" 
							CommandName="Select" ImageUrl="~/images/edit.gif" Text="Select" 
							Visible='<%# NOT EVAL("NEW") %>' />
					</ItemTemplate>
				    <ItemStyle HorizontalAlign="Center" Width="20px" />
				</asp:TemplateField>
				<asp:BoundField DataField="ROUTEID" HeaderText="ID" SortExpression="ROUTEID" />
				<asp:BoundField DataField="ROUTENO" HeaderText="Route&lt;br&gt;No" 
					SortExpression="ROUTENO" HtmlEncode="False" />
				<asp:BoundField DataField="ROUTENAME" HeaderText="Route" HtmlEncode="False" 
					SortExpression="ROUTENAME" />
				<asp:BoundField DataField="ROUTEKINDNAME" HeaderText="Route&lt;br&gt;Kind" 
					HtmlEncode="False" SortExpression="ROUTEKINDNAME" />
				<asp:BoundField DataField="ROUTEGROUPNAME" HeaderText="Route&lt;br&gt;Group" 
					HtmlEncode="False" SortExpression="ROUTEGROUPNAME" />
				<asp:BoundField DataField="CITYNAME" HeaderText="City" 
					SortExpression="CITYNAME" />
			</Columns>
			<EmptyDataTemplate>
				<uc6:NoDataFound ID="NoDataFound1" runat="server" />
			</EmptyDataTemplate>
		</asp:GridView>
	</asp:Panel>
	<asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
		
		SelectCommand="SELECT ROUTEID, ROUTEKIND, ROUTEGROUP, ROUTENO, ROUTENAME, CITYNAME, ROUTEKINDNAME, ROUTEGROUPNAME, NEW, UPD, Deletests FROM (SELECT TOP (700) ROUTE_2.ROUTEID, ROUTE_2.ROUTEKIND, ROUTE_2.ROUTEGROUP, ROUTE_2.ROUTENO, ROUTE_2.ROUTENAME, CITY.CITYNAME, dbo.f_getParamGlobalName('ROUTEKIND', ROUTE_2.ROUTEKIND) AS ROUTEKINDNAME, dbo.f_getParamGlobalName('ROUTEGROUP', ROUTE_2.ROUTEGROUP) AS ROUTEGROUPNAME, CAST(0 AS BIT) AS NEW, CASE WHEN EXISTS (SELECT 'X' FROM ROUTEX WHERE ROUTEID = ROUTE_2.ROUTEID) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS UPD, ROUTE_2.Deletests FROM ROUTE AS ROUTE_2 LEFT OUTER JOIN CITY ON ROUTE_2.CITYID = CITY.CITYID WHERE (ROUTE_2.Deletests = 0) UNION ALL SELECT TOP (1000) ROUTEX.ROUTEID, ROUTEX.ROUTEKIND, ROUTEX.ROUTEGROUP, ROUTEX.ROUTENO, ROUTEX.ROUTENAME, CITY_1.CITYNAME, dbo.f_getParamGlobalName('ROUTEKIND', ROUTEX.ROUTEKIND) AS ROUTEKINDNAME, dbo.f_getParamGlobalName('ROUTEGROUP', ROUTEX.ROUTEGROUP) AS ROUTEGROUPNAME, CAST(1 AS BIT) AS NEW, CAST(0 AS BIT) AS UPD, ROUTEX.Deletests FROM ROUTEX LEFT OUTER JOIN CITY AS CITY_1 ON ROUTEX.CITYID = CITY_1.CITYID WHERE (ROUTEX.Deletests = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM ROUTE AS ROUTE_1 WHERE (ROUTEID = ROUTEX.ROUTEID)))) AS ROUTE WHERE (Deletests = 0)"></asp:SqlDataSource>
	<asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
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
		DefaultMode="Edit" Width="100%" DataKeyNames="ROUTEID">
		<InsertItemTemplate>
			<table cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td colspan="2">
						<hr />
					</td>
				</tr>
				<tr>
					<td>
						Route Number</td>
					<td>
						<asp:TextBox ID="txtRouteNumber" runat="server" CssClass="required" 
							MaxLength="10" Text='<%# Bind("ROUTENO") %>' Width="64px"></asp:TextBox>
						<asp:RequiredFieldValidator ID="reqRouteNumber" runat="server" 
							ControlToValidate="txtRouteNumber" Display="None" 
							ErrorMessage="Route Number must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						<ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECode0" runat="server" 
							HighlightCssClass="ErrHighLight" TargetControlID="reqRouteNumber">
						</ajaxToolkit:ValidatorCalloutExtender>
					</td>
				</tr>
				<tr>
					<td>
						City</td>
					<td>
						<asp:DropDownList ID="ddlCity0" runat="server" DataSourceID="sdsCity" 
							DataTextField="CITY" DataValueField="CITYID" 
							SelectedValue='<%# Bind("CITYID") %>'>
						</asp:DropDownList>
					</td>
				</tr>
				<tr>
					<td>
						Route Kind</td>
					<td>
						<asp:DropDownList ID="ddlRouteKind" runat="server" 
							DataSourceID="sdsParamGlobal_Routekind" DataTextField="NAME" 
							DataValueField="CODE" SelectedValue='<%# Bind("ROUTEKIND") %>'>
						</asp:DropDownList>
					</td>
				</tr>
				<tr>
					<td>
						Route Group</td>
					<td>
						<asp:DropDownList ID="ddlRouteGroup" runat="server" 
							DataSourceID="sdsParamGlobal_RouteGroup" DataTextField="NAME" 
							DataValueField="CODE" SelectedValue='<%# Bind("ROUTEKIND") %>'>
						</asp:DropDownList>
					</td>
				</tr>
				<tr>
					<td>
						Route</td>
					<td>
						<asp:TextBox ID="txtRouteName" runat="server" CssClass="required" 
							MaxLength="50" Text='<%# Bind("ROUTENAME") %>' Width="240px"></asp:TextBox>
						<asp:RequiredFieldValidator ID="reqRouteName" runat="server" 
							ControlToValidate="txtRouteName" Display="None" 
							ErrorMessage="Route Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						<ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEName0" runat="server" 
							HighlightCssClass="ErrHighLight" TargetControlID="reqRouteName">
						</ajaxToolkit:ValidatorCalloutExtender>
						&nbsp;</td>
				</tr>
				<tr>
					<td>
						Request Date</td>
					<td>
						<asp:TextBox ID="txtRequestDate" runat="server" 
							Text='<%# Bind("REQUESTDATE") %>' Width="72px"></asp:TextBox>
						<ajaxToolkit:CalendarExtender ID="txtRequestDate_CalendarExtender" runat="server" 
							Enabled="True" PopupButtonID="imgRequestDate" 
							TargetControlID="txtRequestDate">
						</ajaxToolkit:CalendarExtender>
						<ajaxToolkit:MaskedEditExtender ID="txtRequestDate_MaskedEditExtender" runat="server" 
							CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" 
							CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
							CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" 
							Mask="99/99/9999" MaskType="Date" TargetControlID="txtRequestDate">
						</ajaxToolkit:MaskedEditExtender>
						<asp:Image ID="imgRequestDate" runat="server" ImageUrl="~/images/grid.gif" 
							style="cursor: pointer" ToolTip="Calendar" />
					</td>
				</tr>
				<tr>
					<td>
						SK Status</td>
					<td>
						<asp:RadioButton ID="rbSKstatus_yes" runat="server" 
							Checked='<%# Bind("SKSTS") %>' GroupName="rbSKstatus" Text="Yes" />
						<asp:RadioButton ID="rbSKstatus_no" runat="server" 
							Checked='<%# IIF(Eval("SKSTS"),FALSE,TRUE) %>' GroupName="rbSKstatus" 
							Text="No" />
					</td>
				</tr>
				<tr>
					<td>
						Unit Allocation</td>
					<td>
						<asp:TextBox ID="txtUnitALC" runat="server" MaxLength="15" 
							Text='<%# Bind("UNITALC") %>' Width="50px"></asp:TextBox>
						&nbsp;Unit Realization
						<asp:TextBox ID="txtUnitRLZ" runat="server" MaxLength="15" 
							Text='<%# Bind("UNITRLZ") %>' Width="50px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						Dealer</td>
					<td>
						<asp:TextBox ID="txtDealer" runat="server" MaxLength="50" ReadOnly="True" 
							Text='<%# Bind("DEALERID") %>' Width="240px"></asp:TextBox>
						<input
						id="Button14" noenter onclick="DealerFind();" style="background-position: left;
						background-image: url('http://localhost:1069/WebDLEAS/images/search.gif'); width: 45px; cursor: pointer; background-repeat: no-repeat;
						 text-align: right" type="button" value="Find" />
						<input
							id="Button15" onclick="DealerClear();" style="background-position: left;
							background-image: url('http://localhost:1069/WebDLEAS/images/clear.png'); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter 
				value="Clear" />
						<asp:HiddenField ID="hidDealerID" runat="server" />
					</td>
				</tr>
				<tr>
					<td>
						Product</td>
					<td>
						<asp:DropDownList ID="ddlproduct" runat="server">
						</asp:DropDownList>
						<ajaxToolkit:CascadingDropDown ID="ddlproduct_CascadingDropDown" runat="server" 
							BehaviorID="AJAXCDDProduct" Category="PRODUCT" Enabled="True" 
							LoadingText="[Loading Product..]" PromptText="[SELECT PRODUCT]" 
							ServiceMethod="GetDropDownProduct" ServicePath="~\Param\WebService.asmx" 
							TargetControlID="ddlproduct">
						</ajaxToolkit:CascadingDropDown>
						&nbsp;Merk
						<asp:DropDownList ID="ddlMerk" runat="server">
						</asp:DropDownList>
						<ajaxToolkit:CascadingDropDown ID="ddlMerk_CascadingDropDown" runat="server" 
							BehaviorID="AJAXCDDMerk" Category="MERK" Enabled="True" 
							LoadingText="[Loading Merk...]" 
							ServiceMethod="GetDropDownMerkByProduct" ServicePath="~\Param\WebService.asmx" 
							TargetControlID="ddlMerk" ParentControlID="ddlproduct" 
							PromptText="[SELECT MERK]">
						</ajaxToolkit:CascadingDropDown>
					</td>
				</tr>
				<tr>
					<td>
						Model</td>
					<td>
						<asp:DropDownList ID="ddlModel" runat="server">
						</asp:DropDownList>
						<ajaxToolkit:CascadingDropDown ID="ddlModel_CascadingDropDown" runat="server" 
							BehaviorID="AJAXCDDModel" Category="MODEL" Enabled="True" 
							LoadingText="[Loading Model...]" PromptText="[SELECT Model]" 
							ServiceMethod="GetDropDownModelByMerk" ServicePath="~\Param\WebService.asmx" 
							TargetControlID="ddlModel" ParentControlID="ddlMerk">
						</ajaxToolkit:CascadingDropDown>
						&nbsp;Type
						<asp:DropDownList ID="ddlType" runat="server">
						</asp:DropDownList>
						<ajaxToolkit:CascadingDropDown ID="ddlType_CascadingDropDown" runat="server" 
							BehaviorID="AJAXCDDType" Category="TYPE" Enabled="True" 
							LoadingText="[Loading Type...]" 
							ServiceMethod="GetDropDownObjecTypeByModel" 
							ServicePath="~\Param\WebService.asmx" TargetControlID="ddlType" 
							ParentControlID="ddlModel" PromptText="[SELECT TYPE]">
						</ajaxToolkit:CascadingDropDown>
					</td>
				</tr>
				<tr>
					<td>
						Setoran</td>
					<td>
						<asp:TextBox ID="txtSetoran" runat="server" MaxLength="15" 
							Text='<%# Bind("SETORAN", "{0:N}") %>' Width="112px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						Work days</td>
					<td>
						<asp:TextBox ID="txtWorkDay" runat="server" CssClass="required" MaxLength="15" 
							Text='<%# Bind("WORKDAY") %>' Width="50px"></asp:TextBox>
					    per month</td>
				</tr>
				<tr>
					<td>
						Route Price</td>
					<td>
						<asp:TextBox ID="txtRoutePrice" runat="server" MaxLength="15" 
							Text='<%# Bind("ROUTEPRICE", "{0:N}") %>' Width="112px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						Remark</td>
					<td>
						<asp:TextBox ID="txtRemark" runat="server" CssClass="required" 
							Height="40px" Text='<%# Bind("REMARK") %>' TextMode="MultiLine" Width="280px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						<asp:HiddenField ID="hidTrayekCode" runat="server" 
							Value='<%# Bind("TRAYEKCODE") %>' />
					</td>
					<td>
						&nbsp;</td>
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
						<asp:Label ID="lblRouteID" runat="server" Text='<%# Eval("ROUTEID") %>'></asp:Label></td>
				</tr>
				<tr>
					<td>
						Route Number</td>
					<td>
						<asp:TextBox ID="txtRouteNumber" runat="server" MaxLength="10" Text='<%# Bind("ROUTENO") %>'
							Width="64px" CssClass="required"></asp:TextBox>
						<asp:RequiredFieldValidator ID="reqRouteNumber"
								runat="server" ControlToValidate="txtRouteNumber" Display="None" 
							ErrorMessage="Route Number must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						<ajaxToolkit:ValidatorCalloutExtender
									ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" 
							TargetControlID="reqRouteNumber">
								</ajaxToolkit:ValidatorCalloutExtender>
					</td>
				</tr>
				<tr>
					<td>
						City</td>
					<td>
						<asp:DropDownList ID="ddlCity" runat="server" DataSourceID="sdsCity" 
							DataTextField="CITY" DataValueField="CITYID" 
							SelectedValue='<%# Bind("CITYID") %>'>
						</asp:DropDownList>
					</td>
				</tr>
				<tr>
					<td>
						Route Kind</td>
					<td>
						<asp:DropDownList ID="ddlRouteKind" runat="server" 
							DataSourceID="sdsParamGlobal_Routekind" DataTextField="NAME" 
							DataValueField="CODE" SelectedValue='<%# Bind("ROUTEKIND") %>'>
						</asp:DropDownList>
					</td>
				</tr>
				<tr>
					<td>
						Route Group</td>
					<td>
						<asp:DropDownList ID="ddlRouteGroup" runat="server" 
							DataSourceID="sdsParamGlobal_RouteGroup" DataTextField="NAME" 
							DataValueField="CODE" SelectedValue='<%# Bind("ROUTEKIND") %>'>
						</asp:DropDownList>
					</td>
				</tr>
				<tr>
					<td>
						Route</td>
					<td>
						<asp:TextBox ID="txtRouteName" runat="server" CssClass="required" 
							MaxLength="50" Text='<%# Bind("ROUTENAME") %>' Width="240px"></asp:TextBox>
						<asp:RequiredFieldValidator ID="reqRouteName" runat="server" 
							ControlToValidate="txtRouteName" Display="None" 
							ErrorMessage="Route Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						<ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEName" runat="server" 
							HighlightCssClass="ErrHighLight" TargetControlID="reqRouteName">
						</ajaxToolkit:ValidatorCalloutExtender>
						&nbsp;</td>
				</tr>
				<tr>
					<td>
						Request Date</td>
					<td>
						<asp:TextBox ID="txtRequestDate" runat="server" 
							Text='<%# Bind("REQUESTDATE") %>' Width="72px"></asp:TextBox>
						<asp:Image ID="imgRequestDate" runat="server" ImageUrl="~/images/grid.gif" 
							style="cursor: pointer" ToolTip="Calendar" />
					</td>
				</tr>
				<tr>
					<td>
						SK Status</td>
					<td>
						<asp:RadioButton ID="rbSKstatus_yes" runat="server" 
							Checked='<%# Bind("SKSTS") %>' GroupName="rbSKstatus" Text="Yes" />
						<asp:RadioButton ID="rbSKstatus_no" runat="server" 
							Checked='<%# IIF(Eval("SKSTS"),FALSE,TRUE) %>' GroupName="rbSKstatus" 
							Text="No" />
					</td>
				</tr>
				<tr>
					<td>
						Unit Allocation</td>
					<td>
						<asp:TextBox ID="txtUnitALC" runat="server" MaxLength="15" 
							Text='<%# Bind("UNITALC") %>' Width="50px"></asp:TextBox>
						&nbsp;Unit Realization
						<asp:TextBox ID="txtUnitRLZ" runat="server" MaxLength="15" 
							Text='<%# Bind("UNITRLZ") %>' Width="50px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						Dealer</td>
					<td>
						<asp:TextBox ID="txtDealer" runat="server" 
							MaxLength="50" Width="240px" 
							ReadOnly="True" Text='<%# Eval("DEALERNAME") %>'></asp:TextBox>
						<input
						id="Button12" noenter onclick="DealerFind();" style="background-position: left;
						background-image: url('http://localhost:1069/WebDLEAS/images/search.gif'); width: 45px; cursor: pointer; background-repeat: no-repeat;
						 text-align: right" type="button" value="Find" />
						<input
							id="Button13" onclick="DealerClear();" style="background-position: left;
							background-image: url('http://localhost:1069/WebDLEAS/images/clear.png'); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidDealerID" runat="server" 
							Value='<%# Bind("DEALERID") %>' />
					</td>
				</tr>
				<tr>
					<td>
						Product</td>
					<td>                        
						<asp:DropDownList ID="ddlproduct" runat="server">
						</asp:DropDownList>
						<ajaxToolkit:CascadingDropDown ID="ddlproduct_CascadingDropDown" runat="server" 
							BehaviorID="AJAXCDDProduct" Category="PRODUCT" Enabled="True" 
							LoadingText="[Loading Product..]" PromptText="[SELECT PRODUCT]" 
							ServiceMethod="GetDropDownProduct" ServicePath="~\Param\WebService.asmx" 
							TargetControlID="ddlproduct">
						</ajaxToolkit:CascadingDropDown>
						&nbsp;Merk
						<asp:DropDownList ID="ddlMerk" runat="server">
						</asp:DropDownList>
						<ajaxToolkit:CascadingDropDown ID="ddlMerk_CascadingDropDown" runat="server" 
							BehaviorID="AJAXCDDMerk" Category="MERK" Enabled="True" 
							LoadingText="[Loading Merk...]" 
							ServiceMethod="GetDropDownMerkByProduct" ServicePath="~\Param\WebService.asmx" 
							TargetControlID="ddlMerk" ParentControlID="ddlproduct" 
							PromptText="[SELECT MERK]">
						</ajaxToolkit:CascadingDropDown>
					</td>
				</tr>
				<tr>
					<td>
						Model</td>
					<td>
						<asp:DropDownList ID="ddlModel" runat="server">
						</asp:DropDownList>
						<ajaxToolkit:CascadingDropDown ID="ddlModel_CascadingDropDown" runat="server" 
							BehaviorID="AJAXCDDModel" Category="MODEL" Enabled="True" 
							LoadingText="[Loading Model...]" PromptText="[SELECT Model]" 
							ServiceMethod="GetDropDownModelByMerk" ServicePath="~\Param\WebService.asmx" 
							TargetControlID="ddlModel" ParentControlID="ddlMerk">
						</ajaxToolkit:CascadingDropDown>
						&nbsp;Type
						<asp:DropDownList ID="ddlType" runat="server">
						</asp:DropDownList>
						<ajaxToolkit:CascadingDropDown ID="ddlType_CascadingDropDown" runat="server" 
							BehaviorID="AJAXCDDType" Category="TYPE" Enabled="True" 
							LoadingText="[Loading Type...]" 
							ServiceMethod="GetDropDownObjecTypeByModel" 
							ServicePath="~\Param\WebService.asmx" TargetControlID="ddlType" 
							PromptText="[SELECT TYPE]" ParentControlID="ddlModel">
						</ajaxToolkit:CascadingDropDown>
					</td>
				</tr>
				<tr>
					<td>
						Setoran</td>
					<td>
						<asp:TextBox ID="txtSetoran" runat="server" MaxLength="15" 
							Text='<%# Bind("SETORAN", "{0:N}") %>' Width="112px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						Work days</td>
					<td>
						<asp:TextBox ID="txtWorkDay" runat="server" CssClass="required" MaxLength="15" 
							Text='<%# Bind("WORKDAY") %>' Width="50px"></asp:TextBox>
					    &nbsp;per month</td>
				</tr>
				<tr>
					<td>
						Route Price</td>
					<td>
						<asp:TextBox ID="txtRoutePrice" runat="server" MaxLength="15" 
							Text='<%# Bind("ROUTEPRICE", "{0:N}") %>' Width="112px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						Remark</td>
					<td>
						<asp:TextBox ID="txtRemark" runat="server" CssClass="required" 
							Height="40px" Text='<%# Bind("REMARK") %>' TextMode="MultiLine" Width="280px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;</td>
					<td>
						<asp:HiddenField ID="hidTrayekCode" runat="server" 
							Value='<%# Bind("TRAYEKCODE") %>' />
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
	<asp:SqlDataSource ID="sdsCity" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
		
		
		
        SelectCommand="SELECT NULL AS CITYID, NULL AS CITYCODE, '[SELECT CITY]' AS CITY UNION ALL SELECT CITYID, CITYCODE, CITYCODE + ' - ' + CITYNAME AS CITY FROM CITY WITH (nolock) WHERE (DELETESTS = 0) ORDER BY CITYCODE">
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sdsParamGlobal_Routekind" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
		
		
        SelectCommand="SELECT NULL AS CODE, '[SELECT ROUTE KIND]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'ROUTEKIND')">
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sdsParamGlobal_RouteGroup" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
		
		
        SelectCommand="SELECT NULL AS CODE, '[SELECT ROUTE KIND]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'ROUTEGROUP')">
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
		
		SelectCommand="SELECT ROUTE.ROUTEID, ROUTE.ROUTENO, ROUTE.CITYID, ROUTE.ROUTEKIND, ROUTE.ROUTEGROUP, ROUTE.ROUTENAME, ROUTE.REQUESTDATE, ROUTE.SKSTS, ROUTE.UNITALC, ROUTE.UNITRLZ, ROUTE.DEALERID, ROUTE.PRODUCTID, ROUTE.MERKID, ROUTE.MODELID, ROUTE.OBJECTTYPEID, ROUTE.SETORAN, ROUTE.WORKDAY, ROUTE.ROUTEPRICE, ROUTE.REMARK, ROUTE.TRAYEKCODE, '(' + DEALER.DEALERCODE + ') ' + DEALER.DEALERNAME AS DEALERNAME FROM ROUTE LEFT OUTER JOIN DEALER ON ROUTE.DEALERID = DEALER.DEALERID WHERE (ROUTE.ROUTEID = @ROUTEID) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM ROUTEX WHERE (ROUTE.ROUTEID = ROUTEID))) UNION ALL SELECT ROUTE_1.ROUTEID, ROUTE_1.ROUTENO, ROUTE_1.CITYID, ROUTE_1.ROUTEKIND, ROUTE_1.ROUTEGROUP, ROUTE_1.ROUTENAME, ROUTE_1.REQUESTDATE, ROUTE_1.SKSTS, ROUTE_1.UNITALC, ROUTE_1.UNITRLZ, ROUTE_1.DEALERID, ROUTE_1.PRODUCTID, ROUTE_1.MERKID, ROUTE_1.MODELID, ROUTE_1.OBJECTTYPEID, ROUTE_1.SETORAN, ROUTE_1.WORKDAY, ROUTE_1.ROUTEPRICE, ROUTE_1.REMARK, ROUTE_1.TRAYEKCODE, '(' + DEALER_1.DEALERCODE + ') ' + DEALER_1.DEALERNAME AS DEALERNAME FROM ROUTEX AS ROUTE_1 LEFT OUTER JOIN DEALER AS DEALER_1 ON ROUTE_1.DEALERID = DEALER_1.DEALERID WHERE (ROUTE_1.ROUTEID = @ROUTEID)" 
		DeleteCommand="UPDATE ROUTE SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID
WHERE ROUTEID=@ROUTEID" 
		UpdateCommand="ROUTEUpdate" InsertCommand="ROUTEAdd" 
		InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
		<DeleteParameters>
			<asp:CookieParameter CookieName="UID" Name="USERID" />
			<asp:Parameter Name="ROUTEID" />
		</DeleteParameters>
		<SelectParameters>
			<asp:ControlParameter ControlID="gvData" Name="ROUTEID" 
				PropertyName="SelectedValue" />
		</SelectParameters>
		<UpdateParameters>
			<asp:Parameter Name="ROUTENO" Type="String" />
			<asp:Parameter Name="CITYID" Type="Int32" />
			<asp:Parameter Name="ROUTEKIND" Type="Int32" />
			<asp:Parameter Name="ROUTEGROUP" Type="Int32" />
			<asp:Parameter Name="ROUTENAME" Type="String" />
			<asp:Parameter Name="REQUESTDATE" Type="DateTime" />
			<asp:Parameter Name="SKSTS" Type="Boolean" />
			<asp:Parameter Name="UNITALC" Type="Int32" />
			<asp:Parameter Name="UNITRLZ" Type="Int32" />
			<asp:Parameter Name="DEALERID" Type="Int64" />
			<asp:Parameter Name="PRODUCTID" Type="Int32" />
			<asp:Parameter Name="MERKID" Type="Int32" />
			<asp:Parameter Name="MODELID" Type="Int32" />
			<asp:Parameter Name="OBJECTTYPEID" Type="Int32" />
			<asp:Parameter Name="SETORAN" Type="Decimal" />
			<asp:Parameter Name="WORKDAY" Type="Int32" />
			<asp:Parameter Name="ROUTEPRICE" Type="Decimal" />
			<asp:Parameter Name="REMARK" Type="String" />
			<asp:Parameter Name="TRAYEKCODE" Type="String" />
			<asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
			<asp:Parameter Name="ROUTEID" Type="Int64" Direction="InputOutput" />
			<asp:Parameter Name="retval" Type="Int32" Direction="InputOutput" />
		</UpdateParameters>
		<InsertParameters>
			<asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
			<asp:Parameter Name="ROUTENO" Type="String" />
			<asp:Parameter Name="CITYID" Type="Int32" />
			<asp:Parameter Name="ROUTEKIND" Type="Int32" />
			<asp:Parameter Name="ROUTEGROUP" Type="Int32" />
			<asp:Parameter Name="ROUTENAME" Type="String" />
			<asp:Parameter Name="REQUESTDATE" Type="DateTime" />
			<asp:Parameter Name="SKSTS" Type="Boolean" />
			<asp:Parameter Name="UNITALC" Type="Int32" />
			<asp:Parameter Name="UNITRLZ" Type="Int32" />
			<asp:Parameter Name="DEALERID" Type="Int64" />
			<asp:Parameter Name="PRODUCTID" Type="Int32" />
			<asp:Parameter Name="MERKID" Type="Int32" />
			<asp:Parameter Name="MODELID" Type="Int32" />
			<asp:Parameter Name="OBJECTTYPEID" Type="Int32" />
			<asp:Parameter Name="SETORAN" Type="Decimal" />
			<asp:Parameter Name="WORKDAY" Type="Int32" />
			<asp:Parameter Name="ROUTEPRICE" Type="Decimal" />
			<asp:Parameter Name="REMARK" Type="String" />
			<asp:Parameter Name="TRAYEKCODE" Type="String" />
			<asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
			<asp:Parameter Name="ROUTEID" Type="Int64" Direction="InputOutput" />
			<asp:Parameter Name="retval" Type="Int32" Direction="InputOutput" />
		</InsertParameters>
	</asp:SqlDataSource>

	&nbsp; &nbsp; &nbsp;&nbsp;
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
function SetValueTxtByClientID(ClientID, sValue){
	var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
	if (oText)
		oText.value = sValue;
}

function DealerFind() {
	var WinRef = window.open("../Param/DealerFind.aspx?Action=Find", "DealerFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
	WinRef.focus();
}

function SetDealer(DealerID, Dealer) {    
	SetValueTxtByClientID("<%=strDealerID%>", DealerID);
	SetValueTxtByClientID("<%=strDealer%>", Dealer);
}
function DealerClear() {
	SetValueTxtByClientID("<%=strDealerID%>", "");
	SetValueTxtByClientID("<%=strDealer%>", "");
}

window.onload = function () {
    TabToEnter();
}

</script>

</asp:Content>

