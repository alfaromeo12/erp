<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="InsBranch.aspx.vb" Inherits="Param_InsBranch" title="Insurance Branch" %>
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
		<asp:ListItem Value="INSBranchName">Branch Name</asp:ListItem>
		<asp:ListItem Value="INSBranchCode">Branch Code</asp:ListItem>
	</asp:DropDownList></td>
				<td>
					<asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
		ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
		border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
		Text="Search" CausesValidation="False" CssClass="Search" />
					&nbsp;&nbsp;
				</td>
			</tr>           
			<tr>
				<td style="width: 115px">
					Insurance Company</td>
				<td>
					<asp:DropDownList ID="ddlInsuranceCompanySearch" runat="server" 
						AutoPostBack="True" DataSourceID="sdsInsuranceCompanySearch" 
						DataTextField="INSURANCENAME" DataValueField="INSCOMPANYID">
					</asp:DropDownList>
					<asp:SqlDataSource ID="sdsInsuranceCompanySearch" runat="server" 
						ConnectionString="<%$ ConnectionStrings:connection %>" 
						SelectCommand="SELECT NULL AS INSCOMPANYID, NULL AS INSURANCECODE, '[ALL INSURANCE COMPANY]' AS INSURANCENAME UNION ALL SELECT INSCOMPANYID, INSURANCECODE, '(' + INSURANCECODE + ') ' + INSURANCENAME AS INSURANCENAME FROM INSCOMPANY WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY INSURANCECODE">
					</asp:SqlDataSource>
				</td>
			</tr>
		</table>

	<asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CommandName="New" CausesValidation="False" />
		</asp:Panel>
        <asp:Panel ID="pnlData" runat="server">
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
			AutoGenerateColumns="False" DataKeyNames="INSBRANCHID" 
			DataSourceID="sdsGrid" Width="100%" Caption="Insurance Branch List" 
			RowHeaderColumn="INSBRANCHCODE">
			<Columns>
				<asp:TemplateField ShowHeader="False">
					<ItemTemplate>
						<asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" 
							CommandName="Select" ImageUrl="../Images/edit.gif" Text="Select" 
							Visible='<%# Not Eval("NEW") %>' />
					</ItemTemplate>
					<ItemStyle HorizontalAlign="Center" Width="25px" />
				</asp:TemplateField>
				<asp:BoundField DataField="INSBRANCHCODE" HeaderText="Code" 
					SortExpression="INSBRANCHCODE" />
				<asp:BoundField DataField="INSBRANCHNAME" HeaderText="Insurance&lt;br&gt;Branch" 
					SortExpression="INSBRANCHNAME" HtmlEncode="False" />
				<asp:BoundField DataField="INSURANCENAME" HeaderText="Insurance&lt;BR&gt;Company" 
					SortExpression="INSURANCENAME" HtmlEncode="False" />
				<asp:BoundField DataField="INSBRANCHADDRESS" HeaderText="Address" 
					SortExpression="INSBRANCHADDRESS" />
				<asp:BoundField DataField="CITYNAME" HeaderText="City" 
					SortExpression="CITYNAME" />
				<asp:BoundField DataField="INSBRANCHPHONE" HeaderText="Phone" 
					SortExpression="INSBRANCHPHONE" />
				<asp:BoundField DataField="INSBRANCHFAX" HeaderText="Fax" 
					SortExpression="INSBRANCHFAX" />
			</Columns>
			<EmptyDataTemplate>
				<uc6:NoDataFound ID="NoDataFound1" runat="server" />
			</EmptyDataTemplate>
		</asp:GridView>
	</asp:Panel>
	<asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
		        SelectCommand="SELECT INSBRANCHID, INSCOMPANYID, INSURANCENAME, INSBRANCHCODE, INSBRANCHNAME, INSBRANCHADDRESS, CITYNAME, INSBRANCHPHONE, INSBRANCHFAX, NEW, Deletests, UPD FROM (SELECT TOP (700) INSBRANCH_2.INSBRANCHID, INSBRANCH_2.INSCOMPANYID, INSCOMPANY.INSURANCENAME, INSBRANCH_2.INSBRANCHCODE, INSBRANCH_2.INSBRANCHNAME, INSBRANCH_2.INSBRANCHADDRESS, CITY.CITYNAME, INSBRANCH_2.INSBRANCHPHONE, INSBRANCH_2.INSBRANCHFAX, CAST(0 AS BIT) AS NEW, CASE WHEN EXISTS (SELECT 'X' FROM INSBRANCHX WHERE INSBRANCH_2.INSBRANCHID = INSBRANCHX.INSBRANCHID) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS UPD, INSBRANCH_2.Deletests FROM INSBRANCH AS INSBRANCH_2 LEFT OUTER JOIN CITY WITH (NOLOCK) ON INSBRANCH_2.CITYID = CITY.CITYID LEFT OUTER JOIN INSCOMPANY ON INSBRANCH_2.INSCOMPANYID = INSCOMPANY.INSCOMPANYID WHERE (INSBRANCH_2.Deletests = 0) UNION ALL SELECT INSBRANCHX_1.INSBRANCHID, INSBRANCHX_1.INSCOMPANYID, INSCOMPANY_1.INSURANCENAME, INSBRANCHX_1.INSBRANCHCODE, INSBRANCHX_1.INSBRANCHNAME, INSBRANCHX_1.INSBRANCHADDRESS, CITY_1.CITYNAME, INSBRANCHX_1.INSBRANCHPHONE, INSBRANCHX_1.INSBRANCHFAX, CAST(1 AS BIT) AS NEW, CAST(0 AS BIT) AS UPD, INSBRANCHX_1.Deletests FROM INSBRANCHX AS INSBRANCHX_1 INNER JOIN CITY AS CITY_1 WITH (NOLOCK) ON INSBRANCHX_1.CITYID = CITY_1.CITYID INNER JOIN INSCOMPANY AS INSCOMPANY_1 ON INSBRANCHX_1.INSCOMPANYID = INSCOMPANY_1.INSCOMPANYID WHERE (INSBRANCHX_1.Deletests = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM INSBRANCH AS INSBRANCH_1 WHERE (INSBRANCHX_1.INSBRANCHID = INSBRANCHID)))) AS INSBRANCH WHERE (Deletests = 0)"></asp:SqlDataSource>
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
		DefaultMode="Edit" Width="100%" DataKeyNames="INSBRANCHID">
		<InsertItemTemplate>
			<table cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td colspan="2">
						<hr />
					</td>
				</tr>
				<tr>
					<td>
						Code</td>
					<td>
						<asp:TextBox ID="txtInsBranchCode" runat="server" CssClass="required" 
							MaxLength="5" Text='<%# Bind("INSBRANCHCODE") %>' Width="48px"></asp:TextBox>
						<asp:RequiredFieldValidator ID="reqCode" runat="server" 
							ControlToValidate="txtInsBranchCode" Display="None" 
							ErrorMessage="Branch Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						<ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECode" runat="server" 
							HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
						</ajaxToolkit:ValidatorCalloutExtender>
					</td>
				</tr>
				<tr>
					<td>
						Insurance Branch</td>
					<td>
						<asp:TextBox ID="txtInsBranchName" runat="server" CssClass="required" 
							MaxLength="50" Text='<%# Bind("INSBRANCHNAME") %>' Width="240px"></asp:TextBox>
						<asp:RequiredFieldValidator ID="reqInsBranchName" runat="server" 
							ControlToValidate="txtInsBranchName" Display="None" 
							ErrorMessage="Branch Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						<ajaxToolkit:ValidatorCalloutExtender ID="reqInsBranchName_ValidatorCalloutExtender" 
							runat="server" HighlightCssClass="ErrHighLight" 
							TargetControlID="reqInsBranchName">
						</ajaxToolkit:ValidatorCalloutExtender>
					</td>
				</tr>
				<tr>
					<td>
						Insurance Company</td>
					<td>
						<asp:DropDownList ID="ddlInsCompanyName" runat="server" CssClass="required" 
							DataSourceID="sdsInsCompanyName" DataTextField="INSURANCENAME" 
							DataValueField="INSCOMPANYID" SelectedValue='<%# Bind("INSCOMPANYID") %>'>
						</asp:DropDownList>
						<asp:RequiredFieldValidator ID="reqInsCompanyName" runat="server" 
							ControlToValidate="ddlInsCompanyName" Display="None" 
							ErrorMessage="Insurance Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						<ajaxToolkit:ValidatorCalloutExtender ID="reqInsCompanyName_ValidatorCalloutExtender" 
							runat="server" HighlightCssClass="ErrHighLight" 
							TargetControlID="reqInsCompanyName">
						</ajaxToolkit:ValidatorCalloutExtender>
					</td>
				</tr>
				<tr>
					<td>
						Address</td>
					<td>
						<asp:TextBox ID="txtBranchAddress" runat="server" 
							Height="40px" Text='<%# Bind("INSBRANCHADDRESS") %>' TextMode="MultiLine" 
							Width="280px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						City</td>
					<td>
						<asp:TextBox ID="txtCity" runat="server" MaxLength="50" ReadOnly="True" 
							Text='<%# Eval("DEALERNAME") %>' Width="240px"></asp:TextBox>
						<input
						id="Button14" noenter onclick="CityFind();" style="background-position: left;
						background-image: url(../images/search.gif); width: 45px; cursor: pointer; background-repeat: no-repeat;
						 text-align: right" type="button" value="Find" />
						<input
							id="Button15" onclick="CityClear();" style="background-position: left;
							background-image: url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter 
				value="Clear" />
						<asp:HiddenField ID="hidCity" runat="server" Value='<%# Bind("CITYID") %>' />
					</td>
				</tr>
				<tr>
					<td>
						Phone Number</td>
					<td>
						<asp:TextBox ID="txtInsBranchPhoneNumber" runat="server" MaxLength="15" 
							Text='<%# Bind("INSBRANCHPHONE") %>' Width="112px"></asp:TextBox>
						&nbsp;Fax
						<asp:TextBox ID="txtInsBranchFaxNo" runat="server" MaxLength="15" 
							Text='<%# Bind("INSBRANCHFAX") %>' Width="112px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						ZIP</td>
					<td>
						<asp:TextBox ID="txtInsBranchZip" runat="server" MaxLength="15" 
							Text='<%# Bind("INSBRANCHZIP") %>' Width="112px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						Email</td>
					<td>
						<asp:TextBox ID="txtInsBranchEmail" runat="server" MaxLength="50" 
							Text='<%# Bind("INSBRANCHEMAIL") %>' Width="240px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td style="height: 19px">
						Branch Manager</td>
					<td style="height: 19px">
						<asp:TextBox ID="txtInsBranchManager" runat="server" MaxLength="50" 
							Text='<%# Bind("INSBRANCHMANAGER") %>' Width="240px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						Contact Person</td>
					<td>
						<asp:TextBox ID="txtContactPerson" runat="server" MaxLength="15" 
							Text='<%# Bind("INSBRANCHCONTACTPERSON") %>' Width="112px"></asp:TextBox>
						&nbsp;Contact HP
						<asp:TextBox ID="txtContactHP" runat="server" MaxLength="15" 
							Text='<%# Bind("INSBRANCHCONTACTHP") %>' Width="112px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						Endorsement Cust.</td>
					<td>
						<asp:TextBox ID="txtEndorsementCust" runat="server" MaxLength="15" 
							Text='<%# Bind("INSENDORSEMENTCUST", "{0:N}") %>' Width="112px"></asp:TextBox>
						&nbsp;Endorsement Comp.
						<asp:TextBox ID="txtEndorsementComp" runat="server" MaxLength="15" 
							Text='<%# Bind("INSENDORSEMENTCOMP", "{0:N}") %>' Width="112px"></asp:TextBox>
					</td>
				</tr>
				<tr>
                    <td>
                        Insurance COA ID</td>
                    <td>
                        <asp:DropDownList ID="ddlInsCOAID" runat="server" CssClass="required" 
                            DataSourceID="sdsCOA" DataTextField="COA" DataValueField="COAID" 
                            SelectedValue='<%# Bind("INSCOAID") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqInsCoa" runat="server" 
							ControlToValidate="ddlInsCOAID" Display="None" 
							ErrorMessage="COA ID must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						<ajaxToolkit:ValidatorCalloutExtender ID="reqInsCoa_ValidatorCalloutExtender" 
							runat="server" HighlightCssClass="ErrHighLight" 
							TargetControlID="reqInsCoa">
						</ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Insurance Proportional</td>
                    <td>
                        <asp:TextBox ID="txtInsProp" runat="server" CssClass="required" 
                            Text='<%# Bind("INSPROP") %>' Width="50px"></asp:TextBox>
                        &nbsp;Month(s)
                        <asp:RequiredFieldValidator ID="reqInsProp" runat="server" 
							ControlToValidate="txtInsProp" Display="None" 
							ErrorMessage="Proportional must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						<ajaxToolkit:ValidatorCalloutExtender ID="reqInsProp_ValidatorCalloutExtender" 
							runat="server" HighlightCssClass="ErrHighLight" 
							TargetControlID="reqInsProp">
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
						<asp:Label ID="lblInsBranchID" runat="server" Text='<%# Eval("INSBRANCHID") %>'></asp:Label></td>
				</tr>
				<tr>
					<td>
						Code</td>
					<td>
						<asp:TextBox ID="txtInsBranchCode" runat="server" CssClass="required" 
							MaxLength="5" Text='<%# Bind("INSBRANCHCODE") %>' Width="48px"></asp:TextBox>
						<asp:RequiredFieldValidator ID="reqCode" runat="server" 
							ControlToValidate="txtInsBranchCode" Display="None" 
							ErrorMessage="Branch Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						<ajaxToolkit:ValidatorCalloutExtender ID="reqCode_ValidatorCalloutExtender" 
							runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
						</ajaxToolkit:ValidatorCalloutExtender>
					</td>
				</tr>
				<tr>
					<td>
						Insurance Branch</td>
					<td>
						<asp:TextBox ID="txtInsBranchName" runat="server" CssClass="required" 
							MaxLength="50" Text='<%# Bind("INSBRANCHNAME") %>' Width="240px"></asp:TextBox>
						<asp:RequiredFieldValidator ID="reqInsBranchName" runat="server" 
							ControlToValidate="txtInsBranchName" Display="None" 
							ErrorMessage="Branch Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						<ajaxToolkit:ValidatorCalloutExtender ID="reqInsBranchName_ValidatorCalloutExtender" 
							runat="server" HighlightCssClass="ErrHighLight" 
							TargetControlID="reqInsBranchName">
						</ajaxToolkit:ValidatorCalloutExtender>
					</td>
				</tr>
				<tr>
					<td>
						Insurance Company</td>
					<td>
						<asp:DropDownList ID="ddlInsCompanyName" runat="server" CssClass="required" 
							DataSourceID="sdsInsCompanyName" DataTextField="INSURANCENAME" 
							DataValueField="INSCOMPANYID" SelectedValue='<%# Bind("INSCOMPANYID") %>'>
						</asp:DropDownList>
						<asp:RequiredFieldValidator ID="reqInsCompanyName" runat="server" 
							ControlToValidate="ddlInsCompanyName" Display="None" 
							ErrorMessage="Insurance Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						<ajaxToolkit:ValidatorCalloutExtender ID="reqInsCompanyName_ValidatorCalloutExtender" 
							runat="server" HighlightCssClass="ErrHighLight" 
							TargetControlID="reqInsCompanyName">
						</ajaxToolkit:ValidatorCalloutExtender>
					</td>
				</tr>
				<tr>
					<td>
						Address</td>
					<td>
						<asp:TextBox ID="txtBranchAddress" runat="server" 
							Height="40px" Text='<%# Bind("INSBRANCHADDRESS") %>' TextMode="MultiLine" 
							Width="280px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						City</td>
					<td>
						<asp:TextBox ID="txtCity" runat="server" MaxLength="50" 
							Text='<%# Eval("CITYNAME") %>' ReadOnly="True" Width="240px"></asp:TextBox>
						<input
						id="Button12" noenter onclick="CityFind();" style="background-position: left;
						background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						 text-align: right" type="button" value="Find" />
						<input
							id="Button13" onclick="CityClear();" style="background-position: left;
							background-image: url(../images/clear.png);  width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidCity" runat="server" Value='<%# Bind("CITYID") %>' />
					</td>
				</tr>
				<tr>
					<td>
						Phone Number</td>
					<td>
						<asp:TextBox ID="txtInsBranchPhoneNumber" runat="server" MaxLength="15" 
							Text='<%# Bind("INSBRANCHPHONE") %>' Width="112px"></asp:TextBox>
						&nbsp;Fax
						<asp:TextBox ID="txtInsBranchFaxNo" runat="server" MaxLength="15" 
							Text='<%# Bind("INSBRANCHFAX") %>' Width="112px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						ZIP</td>
					<td>
						<asp:TextBox ID="txtInsBranchZip" runat="server" MaxLength="15" 
							Text='<%# Bind("INSBRANCHZIP") %>' Width="112px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						Email</td>
					<td>
						<asp:TextBox ID="txtInsBranchEmail" runat="server" MaxLength="50" 
							Text='<%# Bind("INSBRANCHEMAIL") %>' Width="240px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td style="height: 19px">
						Branch Manager</td>
					<td style="height: 19px">
						<asp:TextBox ID="txtInsBranchManager" runat="server" MaxLength="50" 
							Text='<%# Bind("INSBRANCHMANAGER") %>' Width="240px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						Contact Person</td>
					<td>
						<asp:TextBox ID="txtContactPerson" runat="server" MaxLength="15" 
							Text='<%# Bind("INSBRANCHCONTACTPERSON") %>' Width="112px"></asp:TextBox>
						&nbsp;Contact HP
						<asp:TextBox ID="txtContactHP" runat="server" MaxLength="15" 
							Text='<%# Bind("INSBRANCHCONTACTHP") %>' Width="112px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						Endorsement Cust.</td>
					<td>
						<asp:TextBox ID="txtEndorsementCust" runat="server" MaxLength="15" 
							Text='<%# Bind("INSENDORSEMENTCUST", "{0:N}") %>' Width="112px"></asp:TextBox>
						&nbsp;Endorsement Comp.
						<asp:TextBox ID="txtEndorsementComp" runat="server" MaxLength="15" 
							Text='<%# Bind("INSENDORSEMENTCOMP", "{0:N}") %>' Width="112px"></asp:TextBox>
					</td>
				</tr>
                <tr>
					<td>
						Insurance COA ID</td>
					<td>
						<asp:DropDownList ID="ddlInsCOAID" runat="server" CssClass="required" 
							DataSourceID="sdsCOA" DataTextField="COA" 
							DataValueField="COAID" SelectedValue='<%# Bind("INSCOAID") %>'>
						</asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqInsCoa" runat="server" 
							ControlToValidate="ddlInsCOAID" Display="None" 
							ErrorMessage="COA ID must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						<ajaxToolkit:ValidatorCalloutExtender ID="reqInsCoa_ValidatorCalloutExtender" 
							runat="server" HighlightCssClass="ErrHighLight" 
							TargetControlID="reqInsCoa">
						</ajaxToolkit:ValidatorCalloutExtender>
					</td>
				</tr>
				<tr>
                    <td>
                        Insurance Proportional</td>
                    <td>
                        <asp:TextBox ID="txtInsProp" runat="server" CssClass="required" 
                            Text='<%# Bind("INSPROP") %>' Width="50px"></asp:TextBox>
                        &nbsp;Month(s)
                        <asp:RequiredFieldValidator ID="reqInsProp" runat="server" 
							ControlToValidate="txtInsProp" Display="None" 
							ErrorMessage="Proportional must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						<ajaxToolkit:ValidatorCalloutExtender ID="reqInsProp_ValidatorCalloutExtender" 
							runat="server" HighlightCssClass="ErrHighLight" 
							TargetControlID="reqInsProp">
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
	<asp:SqlDataSource ID="sdsInsCompanyName" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
		SelectCommand="SELECT NULL AS INSCOMPANYID, NULL AS INSURANCECODE, '[CHOOSE INSURANCE]' AS INSURANCENAME 
                            UNION ALL 
                            SELECT INSCOMPANYID, INSURANCECODE, '(' + INSURANCECODE + ') ' + INSURANCENAME AS INSURANCENAME 
                            FROM INSCOMPANY 
                            WHERE (DELETESTS = 0)">
	</asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsCOA" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        SelectCommand="SELECT NULL AS COAID, NULL AS COANO, '[CHOOSE COA]' AS COA UNION ALL SELECT COAID, COANO, COANO + ' ' + COANAME AS COA FROM COA WITH (NOLOCK) WHERE (DELETESTS = 1) AND (HARDCODE = 0) ORDER BY COANO">
    </asp:SqlDataSource>

	<asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
		
		SelectCommand="SELECT INSBRANCH.INSBRANCHID, INSBRANCH.INSCOMPANYID, INSBRANCH.INSBRANCHCODE, INSBRANCH.INSBRANCHNAME, INSBRANCH.INSBRANCHADDRESS, INSBRANCH.CITYID, INSBRANCH.INSBRANCHZIP, INSBRANCH.INSBRANCHPHONE, INSBRANCH.INSBRANCHFAX, INSBRANCH.INSBRANCHEMAIL, INSBRANCH.INSBRANCHMANAGER, INSBRANCH.INSBRANCHCONTACTPERSON, INSBRANCH.INSBRANCHCONTACTHP, INSBRANCH.INSENDORSEMENTCUST, INSBRANCH.INSENDORSEMENTCOMP, CITY.CITYCODE, '(' + CITY.CITYCODE + ')' + CITY.CITYNAME AS CITYNAME, INSBRANCH.INSCOAID, INSBRANCH.INSPROP FROM INSBRANCH LEFT OUTER JOIN CITY ON INSBRANCH.CITYID = CITY.CITYID WHERE (INSBRANCH.INSBRANCHID = @INSBRANCHID) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM INSBRANCHX WHERE (INSBRANCH.INSBRANCHID = INSBRANCHID))) UNION ALL SELECT INSBRANCH_1.INSBRANCHID, INSBRANCH_1.INSCOMPANYID, INSBRANCH_1.INSBRANCHCODE, INSBRANCH_1.INSBRANCHNAME, INSBRANCH_1.INSBRANCHADDRESS, INSBRANCH_1.CITYID, INSBRANCH_1.INSBRANCHZIP, INSBRANCH_1.INSBRANCHPHONE, INSBRANCH_1.INSBRANCHFAX, INSBRANCH_1.INSBRANCHEMAIL, INSBRANCH_1.INSBRANCHMANAGER, INSBRANCH_1.INSBRANCHCONTACTPERSON, INSBRANCH_1.INSBRANCHCONTACTHP, INSBRANCH_1.INSENDORSEMENTCUST, INSBRANCH_1.INSENDORSEMENTCOMP, CITY_1.CITYCODE, '(' + CITY_1.CITYCODE + ')' + CITY_1.CITYNAME AS CITYNAME, INSBRANCH_1.INSCOAID, INSBRANCH_1.INSPROP FROM INSBRANCHX AS INSBRANCH_1 LEFT OUTER JOIN CITY AS CITY_1 ON INSBRANCH_1.CITYID = CITY_1.CITYID WHERE (INSBRANCH_1.INSBRANCHID = @INSBRANCHID)" 
		DeleteCommand="UPDATE INSBRANCH SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID
WHERE INSBRANCHiD=@INSBranchID" 
		UpdateCommand="INSBRANCHUPDATE" InsertCommand="INSBRANCHAdd" 
		InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
		<DeleteParameters>
			<asp:CookieParameter CookieName="UID" Name="USERID" />
			<asp:Parameter Name="INSBranchID" />
		</DeleteParameters>
		<SelectParameters>
			<asp:ControlParameter ControlID="gvData" Name="INSBRANCHID" 
				PropertyName="SelectedValue" />
		</SelectParameters>
		<UpdateParameters>
			<asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
			<asp:Parameter Name="INSBRANCHID" Type="Int32" />
			<asp:Parameter Name="INSCOMPANYID" Type="Int32" />
			<asp:Parameter Name="INSBRANCHCODE" Type="String" />
			<asp:Parameter Name="INSBRANCHNAME" Type="String" />
			<asp:Parameter Name="INSBRANCHADDRESS" Type="String" />
			<asp:Parameter Name="CITYID" Type="Int32" />
			<asp:Parameter Name="INSBRANCHZIP" Type="String" />
			<asp:Parameter Name="INSBRANCHPHONE" Type="String" />
			<asp:Parameter Name="INSBRANCHFAX" Type="String" />
			<asp:Parameter Name="INSBRANCHEMAIL" Type="String" />
			<asp:Parameter Name="INSBRANCHMANAGER" Type="String" />
			<asp:Parameter Name="INSBRANCHCONTACTPERSON" Type="String" />
			<asp:Parameter Name="INSBRANCHCONTACTHP" Type="String" />
			<asp:Parameter Name="INSENDORSEMENTCUST" Type="Decimal" />
			<asp:Parameter Name="INSENDORSEMENTCOMP" Type="Decimal" />
            <asp:Parameter Name="INSCOAID" Type="Int32" />
            <asp:Parameter Name="INSPROP" Type="Int32" />
			<asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
			<asp:Parameter Name="retval" Type="Int32" Direction="InputOutput" />
		</UpdateParameters>
		<InsertParameters>
			<asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
			<asp:Parameter Name="INSBRANCHID" Type="Int32" Direction="InputOutput" />
			<asp:Parameter Name="INSCOMPANYID" Type="Int32" />
			<asp:Parameter Name="INSBRANCHCODE" Type="String" />
			<asp:Parameter Name="INSBRANCHNAME" Type="String" />
			<asp:Parameter Name="INSBRANCHADDRESS" Type="String" />
			<asp:Parameter Name="CITYID" Type="Int32" />
			<asp:Parameter Name="INSBRANCHZIP" Type="String" />
			<asp:Parameter Name="INSBRANCHPHONE" Type="String" />
			<asp:Parameter Name="INSBRANCHFAX" Type="String" />
			<asp:Parameter Name="INSBRANCHEMAIL" Type="String" />
			<asp:Parameter Name="INSBRANCHMANAGER" Type="String" />
			<asp:Parameter Name="INSBRANCHCONTACTPERSON" Type="String" />
			<asp:Parameter Name="INSBRANCHCONTACTHP" Type="String" />
			<asp:Parameter Name="INSENDORSEMENTCUST" Type="Decimal" />
			<asp:Parameter Name="INSENDORSEMENTCOMP" Type="Decimal" />
            <asp:Parameter Name="INSCOAID" Type="Int32" />
            <asp:Parameter Name="INSPROP" Type="Int32" />
			<asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
			<asp:Parameter Name="retval" Type="Int32" Direction="InputOutput" />
		</InsertParameters>
	</asp:SqlDataSource>

	&nbsp; &nbsp; &nbsp;&nbsp;
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript">
TabToEnter();
FormatTable("<%=gvData.ClientID%>")

function SetValueTxtByClientID(ClientID, sValue) {
	var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
	if (oText)
		oText.value = sValue;
}

function CityFind() {
	WinRef = window.open("../Param/CitySearch.aspx?Action=Find", "CityFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
	WinRef.focus();
}

function SetCity(CityID, City) {    
	SetValueTxtByClientID("<%=strCityID%>", CityID);
	SetValueTxtByClientID("<%=strCity%>", City);
}

function CityClear() {
	SetValueTxtByClientID("<%=strCityID%>", "");
	SetValueTxtByClientID("<%=strCity%>", "");
}

</script>

</asp:Content>

