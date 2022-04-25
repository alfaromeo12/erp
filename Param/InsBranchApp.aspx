<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="InsBranchApp.aspx.vb" Inherits="Param_InsBranchApp" title="Insurance BranchApp" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsertNoSPV.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdateNoSPV.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<%@ Register src="../UserControl/BtnApprovetNoSPV.ascx" tagname="BtnApprovetNoSPV" tagprefix="uc7" %>
<%@ Register src="../UserControl/BtnRejectNoSPV.ascx" tagname="BtnRejectNoSPV" tagprefix="uc8" %>

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
		</table>
        </asp:Panel>
        <asp:Panel ID="pnlData" runat="server">
		<asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
			AutoGenerateColumns="False" DataKeyNames="INSBRANCHID" 
			DataSourceID="sdsGrid" Width="100%" Caption="Insurance Branch List" 
			RowHeaderColumn="INSBRANCHCODE">
			<Columns>
				<asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" 
					ShowSelectButton="True" />
				<asp:BoundField DataField="INSBRANCHCODE" HeaderText="Code" 
					SortExpression="INSBRANCHCODE" />
				<asp:BoundField DataField="INSBRANCHNAME" HeaderText="Insurance&lt;br&gt;Branch" 
					SortExpression="INSBRANCHNAME" HtmlEncode="False" />
				<asp:BoundField DataField="INSURANCENAME" HeaderText="Insurance&lt;br&gt;Company" 
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
		
		
		
		
		
		SelectCommand="SELECT INSBRANCHID, INSURANCENAME, INSBRANCHCODE, INSBRANCHNAME, INSBRANCHADDRESS, CITYNAME, 
INSBRANCHPHONE, INSBRANCHFAX FROM INSBRANCHX
LEFT JOIN CITY WITH (NOLOCK) ON INSBRANCHX.CITYID = CITY.CITYID
LEFT JOIN INSCOMPANY ON INSBRANCHX.INSCOMPANYID=INSCOMPANY.INSCOMPANYID 
WHERE (INSBRANCHX.Deletests = 0)"></asp:SqlDataSource>
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
		<EditItemTemplate>
		  <asp:Panel ID="pnlApprove" runat="server" Enabled="False">
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
						background-image:  url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						 text-align: right" type="button" value="Find" />
						<input
							id="Button13" onclick="CityClear();" style="background-position: left;
							background-image: url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
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
							Text='<%# Eval("INSBRANCHEMAIL") %>' Width="240px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td style="height: 19px">
						Branch Manager</td>
					<td style="height: 19px">
						<asp:TextBox ID="txtInsBranchManager" runat="server" MaxLength="50" 
							Text='<%# Eval("INSBRANCHMANAGER") %>' Width="240px"></asp:TextBox>
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
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqInsProp">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
			  </asp:Panel>
				<tr>
					<td colspan="2">
						<hr />
						&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2">
						&nbsp;<uc7:BtnApprovetNoSPV ID="BtnApprovetNoSPV1" runat="server" />
						<uc8:BtnRejectNoSPV ID="BtnRejectNoSPV1" runat="server" />
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
	<asp:SqlDataSource ID="sdsParamGlobal_BankSts" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
		SelectCommand="SELECT NULL AS CODE,'[SELECT BANK STATUS]' AS NAME
UNION ALL
SELECT CODE, '(' + CODE + ') ' + NAME AS NAME
FROM PARAMGLOBAL WHERE TYPE='BANKACCSTATUS'">
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
		
		SelectCommand="SELECT INSBRANCH.INSBRANCHID, INSBRANCH.INSCOMPANYID, INSBRANCH.INSBRANCHCODE, INSBRANCH.INSBRANCHNAME, INSBRANCH.INSBRANCHADDRESS, INSBRANCH.CITYID, INSBRANCH.INSBRANCHZIP, INSBRANCH.INSBRANCHPHONE, INSBRANCH.INSBRANCHFAX, INSBRANCH.INSBRANCHEMAIL, INSBRANCH.INSBRANCHMANAGER, INSBRANCH.INSBRANCHCONTACTPERSON, INSBRANCH.INSBRANCHCONTACTHP, INSBRANCH.INSENDORSEMENTCUST, INSBRANCH.INSENDORSEMENTCOMP, CITY.CITYCODE, '(' + CITY.CITYCODE + ')' + CITY.CITYNAME AS CITYNAME, INSBRANCH.INSCOAID, INSBRANCH.INSPROP FROM INSBRANCHX AS INSBRANCH LEFT OUTER JOIN CITY ON INSBRANCH.CITYID = CITY.CITYID WHERE (INSBRANCH.INSBRANCHID = @INSBRANCHID)" 
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

	<asp:SqlDataSource ID="sdsBank" runat="server" 
		ConnectionString="<%$ ConnectionStrings:connection %>" 
		SelectCommand="SELECT NULL AS BANKID, NULL AS BANKCODE, '[SELECT BANK]' AS BANKNAME UNION ALL SELECT BANKID, BANKCODE, '(' + BANKCODE + ') ' + BANKNAME AS BANKNAME FROM BANK ORDER BY BANKCODE">
	</asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsCOA" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        SelectCommand="SELECT NULL AS COAID, NULL AS COANO, '[CHOOSE COA]' AS COA UNION ALL SELECT COAID, COANO, COANO + ' ' + COANAME AS COA FROM COA WITH (NOLOCK) WHERE (DELETESTS = 1) AND (HARDCODE = 0) ORDER BY COANO">
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

