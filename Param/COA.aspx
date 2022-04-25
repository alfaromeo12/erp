<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="COA.aspx.vb" Inherits="Param_COA" title="COA" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsertNoSPV.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdateNoSPV.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
	<asp:DropDownList ID="ddlCriteria" runat="server">
		<asp:ListItem Value="COAName">COA Name</asp:ListItem>
		<asp:ListItem Value="COANo">COA No</asp:ListItem>
	</asp:DropDownList><asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
		ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
		border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
		Text="Search" CausesValidation="False" CssClass="Search" /><br />

	Hard Code :
    <asp:DropDownList ID="ddlYesNo" runat="server" AutoPostBack="True" 
        DataSourceID="sdsYesNo" DataTextField="NAME" DataValueField="CODE">
    </asp:DropDownList>
    <asp:SqlDataSource ID="sdsYesNo" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'YESNO')">
    </asp:SqlDataSource>
    <br />

	<asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False" /><br />
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
			AutoGenerateColumns="False" DataKeyNames="COAID" DataSourceID="sdsGrid" 
			Width="100%" Caption="Charts Of Account (COA) List" RowHeaderColumn="COAID">
			<Columns>
				<asp:TemplateField ShowHeader="False">
					<ItemTemplate>
						<asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" 
							CommandName="Select" ImageUrl="~/images/edit.gif" 
							Visible='<%# Not Eval("NEW") %>' />
					</ItemTemplate>
					<ItemStyle Width="25px" HorizontalAlign="Center" />
				</asp:TemplateField>
				<asp:BoundField DataField="COAID" HeaderText="COA&lt;BR&gt;ID" 
                    HtmlEncode="False" SortExpression="COAID" />
				<asp:BoundField DataField="COANO" HeaderText="COA&lt;br&gt;No" HtmlEncode="False"
					SortExpression="COANO" />
				<asp:BoundField DataField="COANAME" HeaderText="COA&lt;br&gt;Name" HtmlEncode="False"
					SortExpression="COANAME" />
				<asp:BoundField DataField="HARDCODENAME" HeaderText="Hard&lt;br&gt;Code" HtmlEncode="False"
					ReadOnly="True" SortExpression="HARDCODENAME" >
				<ItemStyle HorizontalAlign="Center" />
				</asp:BoundField>
			</Columns>
			<EmptyDataTemplate>
				<uc6:NoDataFound ID="NoDataFound1" runat="server" />
			</EmptyDataTemplate>
		</asp:GridView>
	</asp:Panel>
	<asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
		
        SelectCommand="SELECT COAID, COANO, COANAME, DELETESTS, HARDCODENAME, HARDCODE, NEW, UPD FROM (SELECT COAID, COANO, COANAME, DELETESTS, CASE WHEN HARDCODE = 1 THEN 'YES' ELSE 'NO' END AS HARDCODENAME, HARDCODE, CAST(0 AS BIT) AS NEW, CASE WHEN EXISTS (SELECT 'X' FROM COAX WHERE COA_2.COAID = COAX.COAID) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS UPD FROM COA AS COA_2 WHERE (DELETESTS = 0) UNION ALL SELECT COAID, COANO, COANAME, DELETESTS, CASE WHEN HARDCODE = 1 THEN 'YES' ELSE 'NO' END AS HARDCODENAME, HARDCODE, CAST(1 AS BIT) AS NEW, CAST(0 AS BIT) AS UPD FROM COAX WHERE (DELETESTS = 0) AND (NOT EXISTS (SELECT 'X' AS A FROM COA AS COA_1 WHERE (COAID = COAX.COAID)))) AS COA WHERE (DELETESTS = 0)"></asp:SqlDataSource>
	<asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" 
        style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>

	<asp:FormView ID="fvData" runat="server" DataKeyNames="COAID" DataSourceID="sdsForm"
		DefaultMode="Edit" Width="100%">
		<EditItemTemplate><table cellpadding="0" cellspacing="0" width="600">
			<tr>
				<td>
					COA ID</td>
				<td>
					<asp:Label ID="lblCOAID" runat="server" Text='<%# Eval("COAID") %>'></asp:Label></td>
			</tr>
			<tr>
				<td>
					COA No</td>
				<td>
					<asp:TextBox ID="txtCOANo" runat="server" CssClass="required" MaxLength="30" Text='<%# Bind("COANO") %>'></asp:TextBox><asp:RequiredFieldValidator
						ID="reqCOANo" runat="server" ControlToValidate="txtCOANo" Display="None" ErrorMessage="COA No. must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
							ID="ajaxVCECOANo" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCOANo">
						</ajaxToolkit:ValidatorCalloutExtender>
				</td>
			</tr>
			<tr>
				<td>
					COA Name</td>
				<td>
					<asp:TextBox ID="txtCOAName" runat="server" CssClass="required" MaxLength="80" Text='<%# Bind("COANAME") %>'
						Width="368px"></asp:TextBox><asp:RequiredFieldValidator ID="reqCOAName" runat="server"
							ControlToValidate="txtCOAName" Display="None" ErrorMessage="COA Name must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
								ID="ajaxVCECOAName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCOAName">
							</ajaxToolkit:ValidatorCalloutExtender>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="height: 19px">
					<uc1:BtnUpdate ID="BtnUpdate1" runat="server" Visible='<%# NOT Eval("HARDCODE") %>' />
					<uc2:BtnDelete ID="BtnDelete1" runat="server" Visible='<%# NOT Eval("HARDCODE") %>' />
					<uc3:BtnCancel ID="BtnCancel2" runat="server" />
				</td>
			</tr>
		</table>
		</EditItemTemplate>
		<InsertItemTemplate>
			<table cellpadding="0" cellspacing="0" width="600">
				<tr>
					<td>
						COA No</td>
					<td>
						<asp:TextBox ID="txtCOANo" runat="server" CssClass="required" MaxLength="30" Text='<%# Bind("COANO") %>'></asp:TextBox><asp:RequiredFieldValidator
							ID="reqCOANo" runat="server" ControlToValidate="txtCOANo" Display="None" ErrorMessage="COA No. must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
								ID="ajaxVCECOANo" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCOANo">
							</ajaxToolkit:ValidatorCalloutExtender>
					</td>
				</tr>
				<tr>
					<td>
						COA Name</td>
					<td>
						<asp:TextBox ID="txtCOAName" runat="server" CssClass="required" MaxLength="80" Text='<%# Bind("COANAME") %>'
							Width="368px"></asp:TextBox><asp:RequiredFieldValidator ID="reqCOAName" runat="server"
								ControlToValidate="txtCOAName" Display="None" ErrorMessage="COA Name must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
									ID="ajaxVCECOAName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCOAName">
								</ajaxToolkit:ValidatorCalloutExtender>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="height: 19px">
						<uc4:BtnInsert ID="BtnInsert1" runat="server" />
						<uc3:BtnCancel ID="BtnCancel1" runat="server" />
					</td>
				</tr>
			</table>
		</InsertItemTemplate>
	</asp:FormView>
	<asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
		
		SelectCommand="SELECT COAID, COANO, COANAME, HARDCODE FROM COA WHERE (COAID = @COAID) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM COAX WHERE (COA.COAID = COAID))) UNION ALL SELECT COAID, COANO, COANAME, HARDCODE FROM COAX AS COAX_1 WHERE (COAID = @COAID)" 
		DeleteCommand="UPDATE COA SET DELETESTS=1, LASTUSERID=@USERID WHERE COAID=@COAID" 
		UpdateCommand="COAUpdate" InsertCommand="COAAdd" 
		InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
		<SelectParameters>
			<asp:ControlParameter ControlID="gvData" Name="COAID" PropertyName="SelectedValue" />
		</SelectParameters>
		<DeleteParameters>
			<asp:CookieParameter CookieName="UID" Name="USERID" />
			<asp:Parameter Name="COAID" />
		</DeleteParameters>
		<UpdateParameters>
			<asp:Parameter Name="COAID" Type="Int32" />
			<asp:Parameter Name="COANo" Type="String" />
			<asp:Parameter Name="COANAME" Type="String" />
			<asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
			<asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
		</UpdateParameters>
		<InsertParameters>
			<asp:Parameter Name="COANo" Type="String" />
			<asp:Parameter Name="COAName" Type="String" />
			<asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
			<asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
		</InsertParameters>
	</asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
</script>

</asp:Content>

