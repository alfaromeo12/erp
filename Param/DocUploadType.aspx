<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="DocUploadType.aspx.vb" Inherits="FrontEnd_DocUploadType" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">

<asp:DropDownList ID="ddlCriteria" runat="server">
		<asp:ListItem Value="DOCNAME">Document Name</asp:ListItem>
		<asp:ListItem Value="DOCID">Document ID</asp:ListItem>
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
			AutoGenerateColumns="False" DataKeyNames="DOCID" DataSourceID="sdsGrid" 
			Width="100%" Caption="Document Upload Type List" RowHeaderColumn="COANAME">
			<Columns>
				<asp:TemplateField ShowHeader="False">
					<ItemTemplate>
						<asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" 
							CommandName="Select" ImageUrl="~/images/edit.gif" Visible='<%# Eval("VISIBLE") %>' />
					</ItemTemplate>
					<ItemStyle Width="25px" HorizontalAlign="Center" />
				</asp:TemplateField>
				<asp:BoundField DataField="DOCID" HeaderText="Document&lt;BR&gt;ID" 
                    HtmlEncode="False" SortExpression="DOCID" />
				<asp:BoundField DataField="DOCNAME" HeaderText="Document&lt;br&gt;Name" HtmlEncode="False"
					SortExpression="DOCNAME" />
				<asp:BoundField DataField="ALLOWPRINTINGNM" 
                    HeaderText="Allow&lt;br&gt;Printing" HtmlEncode="False"
					SortExpression="ALLOWPRINTINGNM" />
				<asp:BoundField DataField="ALLOWCONTENTMODINM" 
                    HeaderText="Allow&lt;br&gt;Modify" HtmlEncode="False" 
                    SortExpression="ALLOWCONTENTMODINM" />
                <asp:BoundField DataField="ALLOWCOPYTEXTNM" 
                    HeaderText="Allow&lt;br&gt;CopyText" HtmlEncode="False"
                    SortExpression="ALLOWCOPYTEXTNM" />
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
		
        
        
        
        
        SelectCommand="SELECT DOCID, DOCNAME, ALLOWPRINTING, ALLOWCONTENTMODI, ALLOWCOPYTEXT, HARDCODE, CASE WHEN ALLOWPRINTING = 1 THEN 'YES' ELSE 'NO' END AS ALLOWPRINTINGNM, CASE WHEN ALLOWCONTENTMODI = 1 THEN 'YES' ELSE 'NO' END AS ALLOWCONTENTMODINM, CASE WHEN ALLOWCOPYTEXT = 1 THEN 'YES' ELSE 'NO' END AS ALLOWCOPYTEXTNM, CASE WHEN HARDCODE = 1 THEN 'YES' ELSE 'NO' END AS HARDCODENAME, CAST(CASE WHEN HARDCODE = 1 THEN 0 ELSE 1 END AS BIT) AS VISIBLE FROM DOCUPLOADTYPE WHERE (DOCID IS NOT NULL)"></asp:SqlDataSource>
	<asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" 
        style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>

	<asp:FormView ID="fvData" runat="server" DataKeyNames="DOCID" DataSourceID="sdsForm"
		DefaultMode="Edit" Width="100%">
		<EditItemTemplate><table cellpadding="0" cellspacing="0" width="600">
			<tr>
				<td>
					Document ID</td>
				<td>
					<asp:TextBox ID="txtDocID" runat="server" MaxLength="30" 
                        Text='<%# Bind("DOCID") %>' Enabled="False" Width="50px"></asp:TextBox>
                    <asp:RequiredFieldValidator
						ID="reqDocID" runat="server" ControlToValidate="txtDocID" Display="None" ErrorMessage="Document ID must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
							ID="ajaxVCEDocID" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDocID">
						</ajaxToolkit:ValidatorCalloutExtender>
				</td>
			</tr>
			<tr>
				<td>
					Document Name</td>
				<td>
					<asp:TextBox ID="txtDocName" runat="server" CssClass="required" MaxLength="80"
						Width="368px" Text='<%# Bind("DOCNAME") %>'></asp:TextBox><asp:RequiredFieldValidator ID="reqDocName" runat="server"
							ControlToValidate="txtDocName" Display="None" ErrorMessage="Document Name must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
								ID="ajaxVCEDocName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDocName">
							</ajaxToolkit:ValidatorCalloutExtender>
				</td>
			</tr>
			<tr>
                <td style="width: 122px; ">
                    Printing</td>
                <td>
                    <asp:RadioButton ID="rbPrintYes" runat="server" 
                        Checked='<%# Bind("ALLOWPRINTING") %>' GroupName="rbPrint" Text="Yes" />
                    <asp:RadioButton ID="rbPrintNo" runat="server" 
                        Checked='<%# IIF(Eval("ALLOWPRINTING"), false, true) %>' GroupName="rbPrint" 
                        Text="No" />
                </td>
            </tr>
            <tr>
                <td style="width: 122px; ">
                    Content Modify</td>
                <td>
                    <asp:RadioButton ID="rbContModYes" runat="server" 
                        Checked='<%# Bind("ALLOWCONTENTMODI") %>' GroupName="rbModif" Text="Yes" />
                    <asp:RadioButton ID="rbConteModNo" runat="server" 
                        Checked='<%# IIF(Eval("ALLOWCONTENTMODI"), false, true) %>' GroupName="rbModif" 
                        Text="No" />
                </td>
            </tr>
            <tr>
                <td style="width: 122px; ">
                    Copy Text</td>
                <td>
                    <asp:RadioButton ID="rbCopyYes" runat="server" 
                        Checked='<%# Bind("ALLOWCOPYTEXT") %>' GroupName="rbCopy" Text="Yes" />
                    <asp:RadioButton ID="rbCopyNo" runat="server" 
                        Checked='<%# IIF(Eval("ALLOWCOPYTEXT"), false, true) %>' GroupName="rbCopy" 
                        Text="No" />
                </td>
            </tr>
			<tr>
				<td colspan="2" style="height: 19px">
					<uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
					<uc2:BtnDelete ID="BtnDelete1" runat="server" />
					<uc3:BtnCancel ID="BtnCancel2" runat="server" />
				</td>
			</tr>
		</table>
		</EditItemTemplate>
		<InsertItemTemplate>
			<table cellpadding="0" cellspacing="0" width="600">
				<tr>
                    <td>
                        Document ID</td>
                    <td>
                        <asp:TextBox ID="txtDocID" runat="server" CssClass="required" MaxLength="10" 
                            Text='<%# Bind("DOCID") %>' Width="50px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqDocID" runat="server" 
                            ControlToValidate="txtDocID" Display="None" 
                            ErrorMessage="Document ID must be entry...!"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEDocID" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqDocID">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Document Name</td>
                    <td>
                        <asp:TextBox ID="txtDocName" runat="server" CssClass="required" MaxLength="80" 
                            Text='<%# Bind("DOCNAME") %>' Width="368px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqDocName" runat="server" 
                            ControlToValidate="txtDocName" Display="None" 
                            ErrorMessage="Document Name must be entry...!"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEDocName" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqDocName">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td style="width: 122px;">
                        Printing</td>
                    <td>
                        <asp:RadioButton ID="rbPrintYes" runat="server" 
                            Checked='<%# Bind("ALLOWPRINTING") %>' GroupName="rbPrint" Text="Yes" />
                        <asp:RadioButton ID="rbPrintNo" runat="server" 
                            Checked='<%# IIF(Eval("ALLOWPRINTING"), false, true) %>' GroupName="rbPrint" 
                            Text="No" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 122px;">
                        Content Modify</td>
                    <td>
                        <asp:RadioButton ID="rbContModYes" runat="server" 
                            Checked='<%# Bind("ALLOWCONTENTMODI") %>' GroupName="rbModif" Text="Yes" />
                        <asp:RadioButton ID="rbContModNo" runat="server" 
                            Checked='<%# IIF(Eval("ALLOWCONTENTMODI"), false, true) %>' GroupName="rbModif" 
                            Text="No" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 122px;">
                        Copy Text</td>
                    <td>
                        <asp:RadioButton ID="rbCopyYes" runat="server" 
                            Checked='<%# Bind("ALLOWCOPYTEXT") %>' GroupName="rbCopy" Text="Yes" />
                        <asp:RadioButton ID="rbCopyNo" runat="server" 
                            Checked='<%# IIF(Eval("ALLOWCOPYTEXT"), false, true) %>' GroupName="rbCopy" 
                            Text="No" />
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
		
		SelectCommand="SELECT DOCID, DOCNAME, ALLOWPRINTING, ALLOWCONTENTMODI, ALLOWCOPYTEXT, HARDCODE FROM DOCUPLOADTYPE WHERE (DOCID = @DOCID)" 
		UpdateCommand="DOCUPLOADTYPEUpdate" InsertCommand="DOCUPLOADTYPEAdd" 
		InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure" DeleteCommand="delete DOCUPLOADTYPE
where DOCID=@DOCID">
		<SelectParameters>
			<asp:ControlParameter ControlID="gvData" Name="DOCID" 
                PropertyName="SelectedValue" />
		</SelectParameters>
		<UpdateParameters>
			<asp:Parameter Name="DOCID" Type="Int32" />
			<asp:Parameter Name="DOCNAME" Type="String" />
			<asp:Parameter Name="ALLOWPRINTING" Type="Boolean" />
			<asp:Parameter Name="ALLOWCONTENTMODI" Type="Boolean" />
            <asp:Parameter Name="ALLOWCOPYTEXT" Type="Boolean" />
			<asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
			<asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
		</UpdateParameters>
		<DeleteParameters>
            <asp:Parameter Name="DOCID" />
        </DeleteParameters>
		<InsertParameters>
			<asp:Parameter Name="DOCID" Type="Int32" />
			<asp:Parameter Name="DOCNAME" Type="String" />
			<asp:Parameter Name="ALLOWPRINTING" Type="Boolean" />
            <asp:Parameter Name="ALLOWCONTENTMODI" Type="Boolean" />
            <asp:Parameter Name="ALLOWCOPYTEXT" Type="Boolean" />
			<asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
			<asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
		</InsertParameters>
	</asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>")
</script>

</asp:Content>

