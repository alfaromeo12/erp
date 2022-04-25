<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" EnableEventValidation="false" CodeFile="InsCompany.aspx.vb" Inherits="Param_InsCompany" title="Insurance Company" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsertNoSPV.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdateNoSPV.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:HiddenField ID="hidInsCompanyId" runat="server" />
  <asp:MultiView id="Multi_View" runat="server">
        <asp:View id="view_Main" runat="server">
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
	        <asp:DropDownList ID="ddlInsurance" runat="server">
		        <asp:ListItem Value="InsuranceName">Insurance Name</asp:ListItem>
		        <asp:ListItem Value="InsuranceCode">Insurance Code</asp:ListItem>
	        </asp:DropDownList></td>
				        <td>
		        <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox>
                <asp:Button	ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
		        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
		        Text="Search" CausesValidation="False" CssClass="Search" />
					        &nbsp;&nbsp;
				        </td>
			        </tr>
		        </table>

	        <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CommandName="New" CausesValidation="False" />
		        </asp:Panel>
                <asp:Panel ID="pnlData" runat="server">
                <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
			        AutoGenerateColumns="False" DataKeyNames="INSCOMPANYID" DataSourceID="sdsGrid" 
			        Width="100%" Caption="Insurance List" RowHeaderColumn="INSCOMPANYID">
			        <Columns>
				        <asp:TemplateField HeaderText="Edt" ShowHeader="False">
					        <ItemTemplate>
						        <asp:ImageButton ID="imgBtn" runat="server" CausesValidation="False" 
							        CommandName="Select" ImageUrl="~/images/edit.gif" Text="Select" 
							        Visible='<%# NOT EVAL("NEW") %>' />
					        </ItemTemplate>
				            <ItemStyle HorizontalAlign="Center" Width="25px" />
				        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Agt" ShowHeader="False">
                            <ItemTemplate>
                                <asp:ImageButton ID="imgbtnAgent" runat="server" CausesValidation="False" 
                                    CommandName="Select" ImageUrl="~/Images/Branch.gif" Text="Select" 
                                    OnCommand="imgbtnAgent_Command"  CommandArgument='<%# CType(Container,GridViewRow).RowIndex %>' 
                                    Visible='<%# Eval("BROKERFLAG") %>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                        </asp:TemplateField>
				        <asp:BoundField DataField="INSCOMPANYID" HeaderText="ID" 
                            SortExpression="INSCOMPANYID" />
				        <asp:BoundField DataField="INSURANCECODE" HeaderText="Insurance&lt;br&gt;Code" 
					        SortExpression="INSURANCECODE" HtmlEncode="False" />
				        <asp:BoundField DataField="INSURANCENAME" HeaderText="Insurance&lt;br&gt;Name" 
					        SortExpression="INSURANCENAME" HtmlEncode="False" />
				        <asp:BoundField DataField="INSURANCEADDRESS" HeaderText="Address" 
					        SortExpression="INSURANCEADDRESS" />
				        <asp:BoundField DataField="CITYNAME" HeaderText="City" 
					        SortExpression="CITYNAME" />
				        <asp:BoundField DataField="INSURANCEPHONE" HeaderText="Phone" 
					        SortExpression="INSURANCEPHONE" />
			            <asp:BoundField DataField="BROKERFLAGNM" HeaderText="Broker&lt;br&gt;Flag" 
                            HtmlEncode="False" SortExpression="BROKERFLAGNM">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
			        </Columns>
			        <EmptyDataTemplate>
				        <uc6:NoDataFound ID="NoDataFound1" runat="server" />
			        </EmptyDataTemplate>
		        </asp:GridView>
	        </asp:Panel>
	        <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
				
                
                SelectCommand="SELECT INSCOMPANYID, INSURANCECODE, INSURANCENAME, INSURANCEADDRESS, CITYNAME, INSURANCEPHONE, NEW, UPD, Deletests, BROKERFLAG, CASE WHEN BROKERFLAG = 1 THEN 'YES' ELSE 'NO' END AS BROKERFLAGNM FROM (SELECT INSCOMPANY_2.INSCOMPANYID, INSCOMPANY_2.INSURANCECODE, INSCOMPANY_2.INSURANCENAME, INSCOMPANY_2.INSURANCEADDRESS, CITY.CITYNAME, INSCOMPANY_2.INSURANCEPHONE, CAST(0 AS BIT) AS NEW, CASE WHEN EXISTS (SELECT 'X' FROM INSCOMPANYX WHERE INSCOMPANYID = INSCOMPANY_2.INSCOMPANYID) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS UPD, INSCOMPANY_2.Deletests, INSCOMPANY_2.BROKERFLAG FROM INSCOMPANY AS INSCOMPANY_2 LEFT OUTER JOIN CITY ON INSCOMPANY_2.CITYID = CITY.CITYID WHERE (INSCOMPANY_2.Deletests = 0) UNION ALL SELECT INSCOMPANYX.INSCOMPANYID, INSCOMPANYX.INSURANCECODE, INSCOMPANYX.INSURANCENAME, INSCOMPANYX.INSURANCEADDRESS, CITY_1.CITYNAME, INSCOMPANYX.INSURANCEPHONE, CAST(1 AS BIT) AS NEW, CAST(0 AS BIT) AS UPD, INSCOMPANYX.Deletests, INSCOMPANYX.BROKERFLAG FROM INSCOMPANYX LEFT OUTER JOIN CITY AS CITY_1 ON INSCOMPANYX.CITYID = CITY_1.CITYID WHERE (INSCOMPANYX.Deletests = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM INSCOMPANY AS INSCOMPANY_1 WHERE (INSCOMPANYID = INSCOMPANYX.INSCOMPANYID)))) AS INSCOMPANY WHERE (Deletests = 0)"></asp:SqlDataSource>
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
		DefaultMode="Edit" Width="100%" DataKeyNames="INSCOMPANYID">
		<InsertItemTemplate>
			<table cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td colspan="2">
						<hr />
					</td>
				</tr>
				<tr>
					<td>
						Insurance Code</td>
					<td>
						<asp:TextBox ID="txtInsuranceCode" runat="server" CssClass="required" 
							MaxLength="10" Text='<%# Bind("INSURANCECODE") %>' Width="64px"></asp:TextBox>
						<asp:RequiredFieldValidator ID="reqInsuranceCode" runat="server" 
							ControlToValidate="txtInsuranceCode" Display="None" 
							ErrorMessage="Insurance Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						<ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECode" runat="server" 
							HighlightCssClass="ErrHighLight" TargetControlID="reqInsuranceCode">
						</ajaxToolkit:ValidatorCalloutExtender>
					</td>
				</tr>
				<tr>
					<td>
						Name</td>
					<td>
						<asp:TextBox ID="txtInsuranceName" runat="server" CssClass="required" 
							MaxLength="50" Text='<%# Bind("INSURANCENAME") %>' Width="240px"></asp:TextBox>
						<asp:RequiredFieldValidator ID="reqInsuranceName" runat="server" 
							ControlToValidate="txtInsuranceName" Display="None" 
							ErrorMessage="Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						<ajaxToolkit:ValidatorCalloutExtender ID="reqInsuranceName_ValidatorCalloutExtender" 
							runat="server" HighlightCssClass="ErrHighLight" 
							TargetControlID="reqInsuranceName">
						</ajaxToolkit:ValidatorCalloutExtender>
					</td>
				</tr>
				<tr>
					<td>
						Address</td>
					<td>
						<asp:TextBox ID="txtInsuranceAddress" runat="server" Height="40px" 
							Text='<%# Bind("INSURANCEADDRESS") %>' TextMode="MultiLine" Width="280px"></asp:TextBox>
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
							background-image:url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidCity" runat="server" Value='<%# Bind("CITYID") %>' />
					</td>
				</tr>
				<tr>
					<td>
						ZIP</td>
					<td>
						<asp:TextBox ID="txtInsuranceZIP" runat="server" MaxLength="15" 
							Text='<%# Bind("INSURANCEZIP") %>' Width="112px"></asp:TextBox>
						&nbsp;</td>
				</tr>
				<tr>
					<td>
						Phone</td>
					<td>
						<asp:TextBox ID="txtInsurancePhone" runat="server" MaxLength="15" 
							Text='<%# Bind("INSURANCEPHONE") %>' Width="112px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						Fax</td>
					<td>
						<asp:TextBox ID="txtInsuranceFax" runat="server" MaxLength="15" 
							Text='<%# Bind("INSURANCEFAX") %>' Width="112px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						eMail</td>
					<td>
						<asp:TextBox ID="txtInsuranceEmail" runat="server" MaxLength="50" 
							Text='<%# Bind("INSURANCEEMAIL") %>' Width="240px"></asp:TextBox>
					</td>
				</tr>
				
				<tr>
					<td>
						Insurance GL</td>
					<td>
						<asp:DropDownList ID="ddlInsuranceGL" runat="server" DataSourceID="sdsCOA" 
							DataTextField="COANAME" DataValueField="COAID" 
							SelectedValue='<%# Bind("INSURANCEGL") %>'>
						</asp:DropDownList>
					</td>
				</tr>
				<tr>
					<td>
						Active</td>
					<td>
						<asp:RadioButton ID="rbActive_Yes" runat="server" 
							Checked='<%# Bind("ACTIVE") %>' GroupName="rbActive" Text="Yes" />
						<asp:RadioButton ID="rbActive_No" runat="server" 
							Checked='<%# IIF(Eval("ACTIVE"),FALSE,TRUE) %>' GroupName="rbActive" 
							Text="No" />
					</td>
				</tr>
				<tr>
					<td style="height: 21px">
						Agent Flag</td>
					<td style="height: 21px">
						<asp:RadioButton ID="rbAgenFlag_Yes" runat="server" 
							Checked='<%# Bind("AGENTFLAG") %>' GroupName="rbAgentFlag" Text="Yes" />
						<asp:RadioButton ID="rbAgentFlag_No" runat="server" 
							Checked='<%# IIF(Eval("AGENTFLAG"),FALSE,TRUE) %>' GroupName="rbAgentFlag" 
							Text="No" />
					</td>
				</tr>
                <tr>
                    <td style="height: 21px">
                        Broker Flag</td>
                    <td style="height: 21px">
                        <asp:RadioButton ID="rbBrokerFlag_Yes" runat="server" 
                            Checked='<%# Bind("BROKERFLAG") %>' GroupName="rbBrokerFlag" Text="Yes" />
                        <asp:RadioButton ID="rbBrokerFlag_No" runat="server" 
                            Checked='<%# IIF(Eval("BROKERFLAG"),FALSE,TRUE) %>' GroupName="rbBrokerFlag" 
                            Text="No" />
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
						<asp:Label ID="lblInsCompanyID" runat="server" 
							Text='<%# Eval("INSCOMPANYID") %>'></asp:Label></td>
				</tr>
				<tr>
					<td>
						Insurance Code</td>
					<td>
						<asp:TextBox ID="txtInsuranceCode" runat="server" MaxLength="10" Text='<%# Bind("INSURANCECODE") %>'
							Width="64px" CssClass="required"></asp:TextBox>
						<asp:RequiredFieldValidator ID="reqInsuranceCode"
								runat="server" ControlToValidate="txtInsuranceCode" Display="None" 
							ErrorMessage="Insurance Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						<ajaxToolkit:ValidatorCalloutExtender
									ID="reqInsuranceCode_ValidatorCalloutExtender" runat="server" HighlightCssClass="ErrHighLight" 
							TargetControlID="reqInsuranceCode">
								</ajaxToolkit:ValidatorCalloutExtender>
					</td>
				</tr>
				<tr>
					<td>
						Name</td>
					<td>
						<asp:TextBox ID="txtInsuranceName" runat="server" CssClass="required" 
							MaxLength="50" Text='<%# Bind("INSURANCENAME") %>' Width="240px"></asp:TextBox>
						<asp:RequiredFieldValidator ID="reqInsuranceName" runat="server" 
							ControlToValidate="txtInsuranceName" Display="None" 
							ErrorMessage="Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						<ajaxToolkit:ValidatorCalloutExtender ID="reqInsuranceName_ValidatorCalloutExtender" 
							runat="server" HighlightCssClass="ErrHighLight" 
							TargetControlID="reqInsuranceName">
						</ajaxToolkit:ValidatorCalloutExtender>
					</td>
				</tr>
				<tr>
					<td>
						Address</td>
					<td>
						<asp:TextBox ID="txtInsuranceAddress" runat="server" 
							Height="40px" Text='<%# Bind("INSURANCEADDRESS") %>' TextMode="MultiLine" 
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
							background-image: url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidCity" runat="server" Value='<%# Bind("CITYID") %>' />
					</td>
				</tr>
				<tr>
					<td>
						ZIP</td>
					<td>
						<asp:TextBox ID="txtInsuranceZIP" runat="server" 
							MaxLength="15" Text='<%# Bind("INSURANCEZIP") %>' Width="112px"></asp:TextBox>
						&nbsp;</td>
				</tr>
				<tr>
					<td>
						Phone</td>
					<td>
						<asp:TextBox ID="txtInsurancePhone" runat="server" MaxLength="15" 
							Text='<%# Bind("INSURANCEPHONE") %>' Width="112px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						Fax</td>
					<td>
						<asp:TextBox ID="txtInsuranceFax" runat="server" MaxLength="15" 
							Text='<%# Bind("INSURANCEFAX") %>' Width="112px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						eMail</td>
					<td>
						<asp:TextBox ID="txtInsuranceEmail" runat="server" 
							MaxLength="100" Text='<%# Bind("INSURANCEEMAIL") %>' Width="240px"></asp:TextBox>
					</td>
				</tr>
				
				<tr>
					<td>
						Insurance GL</td>
					<td>                        
						<asp:DropDownList ID="ddlInsuranceGL" runat="server" DataSourceID="sdsCOA" 
							DataTextField="COANAME" DataValueField="COAID" 
							SelectedValue='<%# Bind("INSURANCEGL") %>'>
						</asp:DropDownList>
					</td>
				</tr>
				<tr>
					<td>
						Active</td>
					<td>
						<asp:RadioButton ID="rbActive_Yes" runat="server" 
							Checked='<%# Bind("ACTIVE") %>' GroupName="rbActive" Text="Yes" />
						<asp:RadioButton ID="rbActive_No" runat="server" 
							Checked='<%# IIF(Eval("ACTIVE"),FALSE,TRUE) %>' GroupName="rbActive" 
							Text="No" />
					</td>
				</tr>
				<tr>
					<td style="height: 21px">
						Agent Flag</td>
					<td style="height: 21px">
						<asp:RadioButton ID="rbAgenFlag_Yes" runat="server" 
							Checked='<%# Bind("AGENTFLAG") %>' GroupName="rbAgentFlag" Text="Yes" />
						<asp:RadioButton ID="rbAgentFlag_No" runat="server" 
							Checked='<%# IIF(Eval("AGENTFLAG"),FALSE,TRUE) %>' GroupName="rbAgentFlag" 
							Text="No" />
					</td>
				</tr>
				<tr>
                    <td style="height: 21px">
                        Broker Flag</td>
                    <td style="height: 21px">
                        <asp:RadioButton ID="rbBrokerFlag_Yes" runat="server" 
                            Checked='<%# Bind("BROKERFLAG") %>' GroupName="rbBrokerFlag" Text="Yes" />
                        <asp:RadioButton ID="rbBrokerFlag_No" runat="server" 
                            Checked='<%# IIF(Eval("BROKERFLAG"),FALSE,TRUE) %>' GroupName="rbBrokerFlag" 
                            Text="No" />
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
	<asp:SqlDataSource ID="sdsCOA" runat="server" 
		ConnectionString="<%$ ConnectionStrings:connection %>" 
		
                SelectCommand="SELECT NULL AS COAID, '[SELECT COA]' AS COANAME UNION ALL SELECT COAID, COANO + ' -  ' + COANAME AS COANAME FROM COA WITH (nolock) WHERE (DELETESTS = 0) AND (HARDCODE = 0)">
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
		SelectCommand="SELECT INSCOMPANY.INSCOMPANYID, INSCOMPANY.INSURANCECODE, INSCOMPANY.INSURANCENAME, INSCOMPANY.INSURANCEADDRESS, INSCOMPANY.CITYID, INSCOMPANY.INSURANCEZIP, INSCOMPANY.INSURANCEPHONE, INSCOMPANY.INSURANCEFAX, INSCOMPANY.INSURANCEEMAIL, (SELECT COAID FROM COA WHERE (COAID = INSCOMPANY.INSURANCEGL) AND (DELETESTS = 0) AND (HARDCODE = 0)) AS INSURANCEGL, INSCOMPANY.ACTIVE, INSCOMPANY.AGENTFLAG, CITY.CITYCODE, '(' + CITY.CITYCODE + ')' + CITY.CITYNAME AS CITYNAME, INSCOMPANY.BROKERFLAG FROM INSCOMPANY LEFT OUTER JOIN CITY ON INSCOMPANY.CITYID = CITY.CITYID AND CITY.DELETESTS = 0 WHERE (INSCOMPANY.INSCOMPANYID = @INSCOMPANYID) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM INSCOMPANYX WHERE (INSCOMPANY.INSCOMPANYID = INSCOMPANYID))) UNION ALL SELECT INSCOMPANY_1.INSCOMPANYID, INSCOMPANY_1.INSURANCECODE, INSCOMPANY_1.INSURANCENAME, INSCOMPANY_1.INSURANCEADDRESS, INSCOMPANY_1.CITYID, INSCOMPANY_1.INSURANCEZIP, INSCOMPANY_1.INSURANCEPHONE, INSCOMPANY_1.INSURANCEFAX, INSCOMPANY_1.INSURANCEEMAIL, (SELECT COAID FROM COA AS COA_1 WHERE (COAID = INSCOMPANY_1.INSURANCEGL) AND (DELETESTS = 0) AND (HARDCODE = 0)) AS INSURANCEGL, INSCOMPANY_1.ACTIVE, INSCOMPANY_1.AGENTFLAG, CITY_1.CITYCODE, '(' + CITY_1.CITYCODE + ')' + CITY_1.CITYNAME AS CITYNAME, INSCOMPANY_1.BROKERFLAG FROM INSCOMPANYX AS INSCOMPANY_1 LEFT OUTER JOIN CITY AS CITY_1 ON INSCOMPANY_1.CITYID = CITY_1.CITYID AND CITY_1.DELETESTS = 0 WHERE (INSCOMPANY_1.INSCOMPANYID = @INSCOMPANYID)" 
		DeleteCommand="UPDATE INSCOMPANY SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID
WHERE INSCOMPANYID= @INSCOMPANYID" 
		UpdateCommand="INSCOMPANYUpdate" InsertCommand="INSCOMPANYAdd" 
		InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
		<DeleteParameters>
			<asp:CookieParameter CookieName="UID" Name="USERID" />
			<asp:Parameter Name="INSCOMPANYID" />
		</DeleteParameters>
		<SelectParameters>
			<asp:ControlParameter ControlID="gvData" Name="INSCOMPANYID" 
				PropertyName="SelectedValue" />
		</SelectParameters>
		<UpdateParameters>
			<asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
			<asp:Parameter Name="INSCOMPANYID" Type="Int32" />
			<asp:Parameter Name="INSURANCECODE" Type="String" />
			<asp:Parameter Name="INSURANCENAME" Type="String" />
			<asp:Parameter Name="INSURANCEADDRESS" Type="String" />
			<asp:Parameter Name="CITYID" Type="Int32" />
			<asp:Parameter Name="INSURANCEZIP" Type="String" />
			<asp:Parameter Name="INSURANCEPHONE" Type="String" />
			<asp:Parameter Name="INSURANCEFAX" Type="String" />
			<asp:Parameter Name="INSURANCEEMAIL" Type="String" />
			<asp:Parameter Name="INSURANCEGL" Type="Int32" />
			<asp:Parameter Name="ACTIVE" Type="Boolean" />
			<asp:Parameter Name="AGENTFLAG" Type="Boolean" />
            <asp:Parameter Name="BROKERFLAG" Type="Boolean" />
			<asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
			<asp:Parameter Name="retval" Type="Int32" Direction="InputOutput" />
		</UpdateParameters>
		<InsertParameters>
			<asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
			<asp:Parameter Name="INSURANCECODE" Type="String" />
			<asp:Parameter Name="INSURANCENAME" Type="String" />
			<asp:Parameter Name="INSURANCEADDRESS" Type="String" />
			<asp:Parameter Name="CITYID" Type="Int32" />
			<asp:Parameter Name="INSURANCEZIP" Type="String" />
			<asp:Parameter Name="INSURANCEPHONE" Type="String" />
			<asp:Parameter Name="INSURANCEFAX" Type="String" />
			<asp:Parameter Name="INSURANCEEMAIL" Type="String" />
			<asp:Parameter Name="INSURANCEGL" Type="Int32" />
			<asp:Parameter Name="ACTIVE" Type="Boolean" />
			<asp:Parameter Name="AGENTFLAG" Type="Boolean" />
            <asp:Parameter Name="BROKERFLAG" Type="Boolean" />
			<asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
			<asp:Parameter Name="INSCOMPANYID" Type="Int32" Direction="InputOutput" />
			<asp:Parameter Name="retval" Type="Int32" Direction="InputOutput" />
		</InsertParameters>
	</asp:SqlDataSource>
    </asp:View>
        <asp:View ID="v_Agent" runat="server">
        <asp:DataList ID="dlInsuranceInfo" runat="server" Caption="INSURANCE COMPANY INFO"
            DataSourceID="sdsInsuranceInfo" Width="100%">
            <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td colspan="2">
						<hr />
					</td>
				</tr>
				<tr>
					<td width="20%">
						Insurance Company</td>
					<td>
						(<asp:Label ID="lblInsuranceComp" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("INSURANCECODE") %>'></asp:Label>
					    )&nbsp;<asp:Label ID="lblInsuranceComp0" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("INSURANCENAME") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td>
						Address</td>
					<td>
						<asp:Label ID="lblInsuranceAdd" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("INSURANCEADDRESS") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td>
						City</td>
					<td>
						<asp:Label ID="lblInsuranceCity" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("CITYNAME") %>'></asp:Label>
					</td>
				</tr>
                <tr>
                    <td>
                        Phone</td>
                    <td>
                        <asp:Label ID="lblInsurancePhone" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("INSURANCEPHONE") %>'></asp:Label>
                    </td>
                </tr>
            </table>
            </ItemTemplate>
        </asp:DataList>
          <asp:SqlDataSource ID="sdsInsuranceInfo" runat="server" 
              ConnectionString="<%$ ConnectionStrings:connection %>" 
              SelectCommand="SELECT INSURANCECODE, INSURANCENAME, INSURANCEADDRESS, (SELECT '(' + CITYCODE + ') ' + CITYNAME AS CITYNAME FROM CITY WHERE (CITYID = INSCOMPANY.CITYID) AND (DELETESTS = 0)) AS CITYNAME, INSURANCEPHONE, INSCOMPANYID FROM INSCOMPANY WHERE (INSCOMPANYID = @INSCOMPANYID)">
              <SelectParameters>
                  <asp:ControlParameter ControlID="gvData" Name="INSCOMPANYID" 
                      PropertyName="SelectedValue" />
              </SelectParameters>
          </asp:SqlDataSource>
         <asp:Panel ID="pnlAgentShow" runat="server" CssClass="ShowDetail"  Width="99%">
		    <div style="float: right; vertical-align: middle">
			    <asp:Image ID="imgAgentData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
			    <asp:Label ID="lblAgentData" runat="server" CssClass="required">(Show Agent Data...)</asp:Label>
		    </div>
		    <input id="Button3" style="background-position: left top; width: 24px; cursor: pointer;
			    background-repeat: no-repeat; height: 16px" type="button" noenter />
        </asp:Panel>
	    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEAgent" runat="server" CollapseControlID="pnlAgentShow"
		    CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Agent Data...)"
		    Enabled="True" ExpandControlID="pnlAgentShow" ExpandedImage="~/images/collapse.jpg"
		    ExpandedText="(Hide Agent Data...)" ImageControlID="imgAgentData" TargetControlID="pnlAgentAreaData"
		    TextLabelID="lblAgentData">
	    </ajaxToolkit:CollapsiblePanelExtender>
                  
	    <asp:Panel ID="pnlAgentAreaData" runat="server" Width="100%" Font-Bold="True" >
             <asp:UpdatePanel ID="UpdListBox" runat="server" UpdateMode="Conditional" >
                    <ContentTemplate>
                        <table cellpadding="0" cellspacing="0" width="100%" >
			                <tr>
				                <th class="title" colspan="4">
					                Insurance Agent </th>
			                </tr>
                                <tr>
                                    <td class="RowStyle" style="text-align: right">
                                            <asp:ListBox Runat="server" ID="lvbSourceAgent" SelectionMode="Multiple" DataTextField="INSURANCENAME"
                                            DataValueField="INSCOMPANYID" Height="150px" 
                                            DataSourceID="sdsSourceAgent" Width="200px" Rows="10" />
                                            <asp:SqlDataSource ID="sdsSourceAgent" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:connection %>" 
                                                
                                                
                                                SelectCommand="SELECT INSCOMPANYID, '(' + INSURANCECODE + ') ' + INSURANCENAME AS INSURANCENAME FROM INSCOMPANY WHERE (Deletests = 0) AND (BROKERFLAG = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM INSMEMBER WHERE (INSCOMPANYIDAGENT = INSCOMPANY.INSCOMPANYID) AND (INSCOMPANYID = @INSCOMPANYID) AND (Deletests = 0))) ORDER BY INSURANCECODE">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="hidInsCompanyId" Name="INSCOMPANYID" 
                                                        PropertyName="Value" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                    </td>
                                    <td class="FooterStyle" style="vertical-align: middle; text-align: center">  
                                            <p>
                                                <asp:Button ID="btnMove" runat="server" Text=">>" Height="30px" />
                                            </p>
                                            <p>
                                                <asp:Button ID="btnBack" runat="server" Text="<<" Height="30px"/>
                                            </p>
                                         
                                    </td>
                                    <td class="AlternatingRowStyle">
                                        
                                            <asp:ListBox ID="lvbDestinationAgent" width="200px" Height="150px" runat="server" 
                                                DataSourceID="sdsDestinationAgent" DataTextField="INSURANCENAME" 
                                                DataValueField="INSCOMPANYID" SelectionMode="Multiple" />
                                            <asp:SqlDataSource ID="sdsDestinationAgent" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:connection %>" 
                                                
                                                
                                                
                                                SelectCommand="SELECT INSCOMPANY.INSCOMPANYID, '(' + INSCOMPANY.INSURANCECODE + ')' + INSCOMPANY.INSURANCENAME AS INSURANCENAME FROM INSCOMPANY INNER JOIN INSMEMBER ON INSMEMBER.INSCOMPANYIDAGENT = INSCOMPANY.INSCOMPANYID WHERE (INSCOMPANY.BROKERFLAG = 0) AND (INSMEMBER.Deletests = 0) AND (INSMEMBER.INSCOMPANYID = @INSCOMPANYID) ORDER BY INSCOMPANY.INSURANCECODE">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="hidInsCompanyId" Name="INSCOMPANYID" 
                                                        PropertyName="Value" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                    </td>
                                </tr>
                            <tr>
                                <td colspan="3">
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </ContentTemplate>
             </asp:UpdatePanel>
            </asp:Panel>
            <asp:Panel ID="pnlControl" runat="server" CssClass="HeaderStyle" Width="99%">
                <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight"
			        Font-Bold="True" Font-Underline="True" Style="text-align: center" 
			        Visible="False" Width="100%"></asp:Label>
		        <asp:Button ID="btnSaveAgent" runat="server" CommandName="Save" OnClientClick="return CheckUserSPVInsAgent();"
                    Style="background-position: left; background-image: url(../images/Save.gif);
			        cursor: pointer; background-repeat: no-repeat; text-align: right; " 
                    Text="Save" ToolTip="Save Transaction"
			        Width="72px"  />
		        <asp:Button ID="btnBackAgent" runat="server" CausesValidation="False" CommandName="Cancel"
                    Style="background-position: left; background-image: url(../images/back.png);
			        cursor: pointer; background-repeat: no-repeat; text-align: right; " 
                    Text="Back" ToolTip="Back to List"
			        Width="72px"   />
		    </asp:Panel>
	            <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEControl" runat="server" 
                    TargetControlID="pnlControl" VerticalSide="Bottom">
	            </ajaxToolkit:AlwaysVisibleControlExtender>
      </asp:View>
    </asp:MultiView>
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

function CheckUserSPVInsAgent() {
    var RetVal = window.showModalDialog("../Home/UserLoginSPV.aspx", "SPVAuthor", "dialogWidth:300px;dialogHeight:200px;center:yes;edge:raised;help:no;status:no;");
    if (RetVal.Login == 1)
        return (true);
    else
        return (false);
}
</script>

</asp:Content>

