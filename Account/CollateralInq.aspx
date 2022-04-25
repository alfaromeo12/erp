<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="CollateralInq.aspx.vb" Inherits="Account_CollateralInq" title="Collateral Inquiry" MaintainScrollPositionOnPostback="true"%>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    	    <asp:Panel ID="pnlParipasuShow" runat="server" CssClass="ShowDetail" 
                Width="99%">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgParipasu" runat="server" AlternateText="(Show Details...)" 
                ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblParipasu" runat="server" CssClass="required">(Show Paripasu...)</asp:Label>
		</div>
		<input id="Button7" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
	        <asp:Panel ID="pnlParipasu" runat="server" Width="100%">
                <asp:GridView ID="gvParipasuTo" runat="server" AutoGenerateColumns="False" 
                    Caption="PARIPASU (TO)" DataKeyNames="LOCID,ACCID" 
                    DataSourceID="sdsParipasuTo" Width="100%">
                    <Columns>
                        <asp:TemplateField HeaderText="No.">
                            <ItemTemplate>
                                <asp:Label ID="lblNo" runat="server" style="font-weight: 700" 
                                    Text="<%#Container.DataItemIndex + 1 %>"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" 
                            HtmlEncode="False" SortExpression="ACCOUNTNAME" />
                        <asp:TemplateField HeaderText="Account No&lt;br&gt;Paripasu" 
                            SortExpression="ACCNOFORMATPARIPASU">
                            <ItemTemplate>
                                <a href="#" onclick='ViewDetailAcc(<%# eval("LOCIDPARIPASU") %>, <%# eval("APPIDPARIPASU") %>)'>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("ACCNOFORMATPARIPASU") %>'></asp:Label>
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ACCOUNTNAMEPARIPASU" 
                            HeaderText="Account Name&lt;br&gt;Paripasu" HtmlEncode="False" 
                            SortExpression="ACCOUNTNAMEPARIPASU" />
                        <asp:BoundField DataField="ACCSTATUSNAME" 
                            HeaderText="Account Sts&lt;br&gt;Paripasu" HtmlEncode="False" 
                            SortExpression="ACCSTATUSNAME" />
                        <asp:BoundField DataField="PRINCIPALTOTAL" DataFormatString="{0:N}" 
                            HeaderText="Principal&lt;br&gt;Paripasu" HtmlEncode="False" 
                            SortExpression="PRINCIPALTOTAL">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="INSTALLMENT" DataFormatString="{0:N}" 
                            HeaderText="Installment&lt;br&gt;Paripasu" HtmlEncode="False" 
                            SortExpression="INSTALLMENT">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BOOKINGDATEPARIPASU" HeaderText="Book Date&lt;br&gt;Paripasu" 
                            HtmlEncode="False" SortExpression="BOOKINGDATEPARIPASU" 
                            DataFormatString="{0:dd/MM/yyyy}" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PARIPASUSTSNAME" HeaderText="Paripasu&lt;br&gt;Sts" 
                            HtmlEncode="False" SortExpression="PARIPASUSTSNAME" />
                        <asp:BoundField DataField="OSPRINCIPALREAL" DataFormatString="{0:N}" 
                            HeaderText="OS&lt;br&gt;Principal" HtmlEncode="False" 
                            SortExpression="OSPRINCIPALREAL">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>
                    <EmptyDataTemplate>
                        <uc1:NoDataFound ID="NoDataFound4" runat="server" />
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsParipasuTo" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    
                    
                    
                    
                    
                    SelectCommand="SELECT ACCOUNT.BOOKINGDATE, dbo.f_FormatAccNoByID(ACCOUNT.BRANCHID, ACCOUNT.ACCOUNTNO) AS ACCNOFORMAT, ACCOUNT_1.PRINCIPALTOTAL, ACCOUNT_1.INSTALLMENT, '(' + CAST(ACCOUNT_1.ACCSTATUS AS VARCHAR(20)) + ') ' + dbo.f_getParamGlobalName('ACCSTATUS', ACCOUNT_1.ACCSTATUS) AS ACCSTATUSNAME, ACCOUNT.ACCOUNTNAME, ACCOUNT.LOCID, ACCOUNT.ACCID, ACCOUNT.APPID, '(' + CAST(PARIPASU.PARIPASUSTS AS VARCHAR(20)) + ') ' + dbo.f_getParamGlobalName('PARIPASUSTS', PARIPASU.PARIPASUSTS) AS PARIPASUSTSNAME, dbo.f_FormatAccNoByID(ACCOUNT_1.BRANCHID, ACCOUNT_1.ACCOUNTNO) AS ACCNOFORMATPARIPASU, ACCOUNT_1.ACCOUNTNAME AS ACCOUNTNAMEPARIPASU, ACCOUNT_1.BOOKINGDATE AS BOOKINGDATEPARIPASU, ACCOUNT_1.OSPRINCIPALREAL, PARIPASU.LOCIDPARIPASU, PARIPASU.ACCIDPARIPASU, ACCOUNT_1.APPID AS APPIDPARIPASU, PARIPASU.PARIPASUSTS, ACCOUNT_1.ACCSTATUS FROM ACCOUNT WITH (NOLOCK) INNER JOIN PARIPASU ON ACCOUNT.LOCID = PARIPASU.LOCID AND ACCOUNT.ACCID = PARIPASU.ACCID INNER JOIN ACCOUNT AS ACCOUNT_1 ON PARIPASU.LOCIDPARIPASU = ACCOUNT_1.LOCID AND PARIPASU.ACCIDPARIPASU = ACCOUNT_1.ACCID WHERE (PARIPASU.Deletests = 0) AND (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.APPID = @APPID)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
                        <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="gvParipasuFrom" runat="server" AutoGenerateColumns="False" 
                    Caption="PARIPASU (FROM)" DataKeyNames="LOCID,ACCID" DataSourceID="sdsParipasuFrom" 
                    Width="100%">
                    <Columns>
                        <asp:TemplateField HeaderText="No.">
                            <ItemTemplate>
                                <asp:Label ID="lblNo0" runat="server" style="font-weight: 700" 
                                    Text="<%#Container.DataItemIndex + 1 %>"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Account&lt;br&gt;No." 
                            SortExpression="ACCNOFORMAT">
                            <ItemTemplate>
                                <a href="#" onclick='ViewDetailAcc(<%# eval("LOCID") %>, <%# eval("APPID") %>)'>
                                <asp:Label D="Label194" runat="server" Text='<%# Eval("ACCNOFORMAT") %>'></asp:Label>
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="BOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Book&lt;br&gt;Date" HtmlEncode="False" SortExpression="BOOKINGDATE">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" 
                            HtmlEncode="False" SortExpression="ACCOUNTNAME" />
                        <asp:BoundField DataField="PRINCIPALTOTAL" DataFormatString="{0:N}" 
                            HeaderText="Principal&lt;br&gt;Total" HtmlEncode="False" 
                            SortExpression="PRINCIPALTOTAL">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="OSPRINCIPALREAL" DataFormatString="{0:N}" 
                            HeaderText="OS&lt;br&gt;Principal" HtmlEncode="False" 
                            SortExpression="OSPRINCIPALREAL">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="INSTALLMENT" DataFormatString="{0:N}" 
                            HeaderText="Installment" HtmlEncode="False" SortExpression="INSTALLMENT">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ACCSTATUSNAME" HeaderText="Account&lt;br&gt;Status" 
                            HtmlEncode="False" SortExpression="ACCSTATUSNAME" />
                        <asp:BoundField DataField="PARIPASUSTSNAME" HeaderText="Paripasu&lt;br&gt;Sts" 
                            HtmlEncode="False" SortExpression="PARIPASUSTSNAME" />
                    </Columns>
                    <EmptyDataTemplate>
                        <uc1:NoDataFound ID="NoDataFound5" runat="server" />
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsParipasuFrom" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    
                    
                    
                    SelectCommand="SELECT ACCOUNT.BOOKINGDATE, dbo.f_FormatAccNoByID(ACCOUNT_1.BRANCHID, ACCOUNT_1.ACCOUNTNO) AS ACCNOFORMAT, ACCOUNT_1.PRINCIPALTOTAL, ACCOUNT_1.INSTALLMENT, '(' + CAST(ACCOUNT_1.ACCSTATUS AS VARCHAR(20)) + ') ' + dbo.f_getParamGlobalName('ACCSTATUS', ACCOUNT_1.ACCSTATUS) AS ACCSTATUSNAME, ACCOUNT_1.ACCSTATUS, ACCOUNT_1.ACCOUNTNAME, PARIPASU.LOCIDPARIPASU, PARIPASU.ACCIDPARIPASU, ACCOUNT_1.LOCID, ACCOUNT_1.ACCID, ACCOUNT_1.APPID, '(' + CAST(PARIPASU.PARIPASUSTS AS VARCHAR(20)) + ') ' + dbo.f_getParamGlobalName('PARIPASUSTS', PARIPASU.PARIPASUSTS) AS PARIPASUSTSNAME, ACCOUNT.OSPRINCIPALREAL, ACCOUNT.ACCSTATUS AS Expr1, PARIPASU.PARIPASUSTS FROM ACCOUNT WITH (NOLOCK) INNER JOIN PARIPASU ON ACCOUNT.LOCID = PARIPASU.LOCIDPARIPASU AND ACCOUNT.ACCID = PARIPASU.ACCIDPARIPASU INNER JOIN ACCOUNT AS ACCOUNT_1 ON PARIPASU.LOCID = ACCOUNT_1.LOCID AND PARIPASU.ACCID = ACCOUNT_1.ACCID WHERE (PARIPASU.Deletests = 0) AND (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.APPID = @APPID)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
                        <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </asp:Panel>
        <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEParipasu" 
            runat="server" CollapseControlID="pnlParipasuShow" 
            CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Paripasu...)" 
            Enabled="True" ExpandControlID="pnlParipasuShow" 
            ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Paripasu...)" 
            ImageControlID="imgParipasu" TargetControlID="pnlParipasu" TextLabelID="lblParipasu">
        </ajaxToolkit:CollapsiblePanelExtender>
    	    <asp:Panel ID="pnlStoreShow" runat="server" CssClass="ShowDetail" Width="99%">
            <div style="float: right; vertical-align: middle">
                <asp:Image ID="imgStore" runat="server" AlternateText="(Show Details...)" 
                    ImageUrl="~/images/expand.jpg" />
                <asp:Label ID="lblStore" runat="server" CssClass="required">(Show Store Document...)</asp:Label>
            </div>
            <input id="Button6" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" />
        </asp:Panel>
        <asp:Panel ID="pnlStore" runat="server">
            <asp:FormView ID="fvDocStore" runat="server" Caption="COLLATERAL STORE INFO" 
                DataKeyNames="LOCID,ACCID" DataSourceID="sdsDocStore" Width="100%">
                <EditItemTemplate>
                    LOCID:
                    <asp:Label ID="LOCIDLabel1" runat="server" Text='<%# Eval("LOCID") %>' />
                    <br />
                    ACCID:
                    <asp:Label ID="ACCIDLabel1" runat="server" Text='<%# Eval("ACCID") %>' />
                    <br />
                    STOREDATE:
                    <asp:TextBox ID="STOREDATETextBox" runat="server" 
                        Text='<%# Eval("STOREDATE") %>' />
                    <br />
                    DOCSHELFCODE:
                    <asp:TextBox ID="DOCSHELFCODETextBox" runat="server" 
                        Text='<%# Eval("DOCSHELFCODE") %>' />
                    <br />
                    DOCSHELFNAME:
                    <asp:TextBox ID="DOCSHELFNAMETextBox" runat="server" 
                        Text='<%# Eval("DOCSHELFNAME") %>' />
                    <br />
                    DOCSAFECODE:
                    <asp:TextBox ID="DOCSAFECODETextBox" runat="server" 
                        Text='<%# Eval("DOCSAFECODE") %>' />
                    <br />
                    DOCSAFENAME:
                    <asp:TextBox ID="DOCSAFENAMETextBox" runat="server" 
                        Text='<%# Eval("DOCSAFENAME") %>' />
                    <br />
                    BRANCHCODE:
                    <asp:TextBox ID="BRANCHCODETextBox" runat="server" 
                        Text='<%# Eval("BRANCHCODE") %>' />
                    <br />
                    BRANCHNAME:
                    <asp:TextBox ID="BRANCHNAMETextBox" runat="server" 
                        Text='<%# Eval("BRANCHNAME") %>' />
                    <br />
                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                        CommandName="Update" Text="Update" />
                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
                        CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <uc1:NoDataFound ID="NoDataFound2" runat="server" />
                </EmptyDataTemplate>
                <InsertItemTemplate>
                    LOCID:
                    <asp:TextBox ID="LOCIDTextBox" runat="server" Text='<%# Eval("LOCID") %>' />
                    <br />
                    ACCID:
                    <asp:TextBox ID="ACCIDTextBox" runat="server" Text='<%# Eval("ACCID") %>' />
                    <br />
                    STOREDATE:
                    <asp:TextBox ID="STOREDATETextBox" runat="server" 
                        Text='<%# Eval("STOREDATE") %>' />
                    <br />
                    DOCSHELFCODE:
                    <asp:TextBox ID="DOCSHELFCODETextBox" runat="server" 
                        Text='<%# Eval("DOCSHELFCODE") %>' />
                    <br />
                    DOCSHELFNAME:
                    <asp:TextBox ID="DOCSHELFNAMETextBox" runat="server" 
                        Text='<%# Eval("DOCSHELFNAME") %>' />
                    <br />
                    DOCSAFECODE:
                    <asp:TextBox ID="DOCSAFECODETextBox" runat="server" 
                        Text='<%# Eval("DOCSAFECODE") %>' />
                    <br />
                    DOCSAFENAME:
                    <asp:TextBox ID="DOCSAFENAMETextBox" runat="server" 
                        Text='<%# Eval("DOCSAFENAME") %>' />
                    <br />
                    BRANCHCODE:
                    <asp:TextBox ID="BRANCHCODETextBox" runat="server" 
                        Text='<%# Eval("BRANCHCODE") %>' />
                    <br />
                    BRANCHNAME:
                    <asp:TextBox ID="BRANCHNAMETextBox" runat="server" 
                        Text='<%# Eval("BRANCHNAME") %>' />
                    <br />
                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                        CommandName="Insert" Text="Insert" />
                    &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
                        CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                </InsertItemTemplate>
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0" style="width:100%;">
                        <tr>
                            <td>
                                Store Date</td>
                            <td colspan="3">
                                <asp:Label ID="STOREDATELabel" runat="server" 
                                    style="font-weight: 700; text-decoration: underline" 
                                    Text='<%# Eval("STOREDATE", "{0:dd/MM/yyyy}") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Branch</td>
                            <td colspan="3">
                                (<asp:Label ID="BRANCHCODELabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("BRANCHCODE") %>' />)
                                <asp:Label ID="BRANCHNAMELabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("BRANCHNAME") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Safe Deposit</td>
                            <td>
                                (<asp:Label ID="DOCSAFECODELabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("DOCSAFECODE") %>' />)
                                <asp:Label ID="DOCSAFENAMELabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("DOCSAFENAME") %>' />
                            </td>
                            <td>
                                Shelf</td>
                            <td >
                                (<asp:Label ID="DOCSHELFCODELabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("DOCSHELFCODE") %>' />)
                                <asp:Label ID="DOCSHELFNAMELabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("DOCSHELFNAME") %>' />
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="sdsDocStore" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                SelectCommand="SELECT ACCOUNT.LOCID, ACCOUNT.ACCID, DOCSTORE.STOREDATE, DOCSHELF.DOCSHELFCODE, DOCSHELF.DOCSHELFNAME, DOCSAFE.DOCSAFECODE, DOCSAFE.DOCSAFENAME, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME FROM DOCSHELF WITH (NOLOCK) INNER JOIN DOCSTORE WITH (NOLOCK) ON DOCSHELF.DOCSHELFID = DOCSTORE.DOCSHELFID INNER JOIN DOCSAFE WITH (NOLOCK) ON DOCSHELF.DOCSAFEID = DOCSAFE.DOCSAFEID INNER JOIN BRANCH WITH (NOLOCK) ON DOCSAFE.BRANCHID = BRANCH.BRANCHID RIGHT OUTER JOIN ACCOUNT WITH (NOLOCK) ON DOCSTORE.LOCID = ACCOUNT.LOCID AND DOCSTORE.ACCID = ACCOUNT.ACCID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.APPID = @APPID)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
                    <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:Panel>
        <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEShow" 
            runat="server" CollapseControlID="pnlStoreShow" 
            CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Store Document...)" 
            Enabled="True" ExpandControlID="pnlStoreShow" 
            ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Store Document...)" 
            ImageControlID="imgStore" TargetControlID="pnlStore" TextLabelID="lblStore">
        </ajaxToolkit:CollapsiblePanelExtender>

    <asp:Panel ID="pnlCollateralShow" runat="server" CssClass="ShowDetail" Width="99%">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgCollateralData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblCollateralData" runat="server" CssClass="required">(Show Collateral Data...)</asp:Label>
		</div>
		<input id="Button1" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
	<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPECollateral" runat="server" CollapseControlID="pnlCollateralShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Collateral Data...)" Enabled="True"
		ExpandControlID="pnlCollateralShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Collateral Data...)"
		ImageControlID="imgCollateralData" TargetControlID="pnlCollateralData" TextLabelID="lblCollateralData">
	</ajaxToolkit:CollapsiblePanelExtender>
	<asp:Panel ID="pnlCollateralData" runat="server" Width="100%">
		<asp:FormView ID="fvCollateral" runat="server" Caption="COLLATERAL DATA INFO"
			DataSourceID="sdsCollateralData" Width="100%" AllowPaging="True">
			<ItemTemplate>
				<table cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td>
							Object/BPKB Status</td>
						<td>
							(<asp:Label ID="BPKBSTATUSLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("BPKBSTATUS") %>'></asp:Label>)
                            <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("BPKBSTATUSNAME") %>'></asp:Label>
						</td>
					    <td>
                            Blocking Status</td>
                        <td>
                            <asp:Label ID="Label177" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("BLOCKINGSTSNAME") %>'></asp:Label>
                        </td>
					</tr>
					<tr>
                        <td>
                            Object/BPKB Receive</td>
                        <td>
                            <asp:Label ID="Label179" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("RECEIVEDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </td>
                        <td>
                            Deliver Date</td>
                        <td>
                            <asp:Label ID="Label190" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("DELIVERDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Release Date</td>
                        <td>
                            <asp:Label ID="Label191" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("RELEASEDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle" colspan="4">
                            <hr />
                        </td>
                    </tr>
					<tr>
                        <td class="HeaderStyle">
                            OBJ ID</td>
                        <td class="ShowDetail" colspan="3">
                            <asp:Label ID="Label175" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("LOCID") %>'></asp:Label>
                            &nbsp;-
                            <asp:Label ID="Label174" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("OBJID") %>'></asp:Label>
                        </td>
                    </tr>
					<tr>
                        <td class="ShowDetail">
                            Object Info</td>
                        <td class="FooterStyle" colspan="3">
                            <hr />
                        </td>
                    </tr>
					<tr>
                        <td class="FooterStyle">
                            Product</td>
                        <td class="FooterStyle" colspan="3">
                            (<asp:Label ID="Label165" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("PRODUCTCODE") %>'></asp:Label>)
                            <asp:Label ID="Label166" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("PRODUCTNAME") %>'></asp:Label>
                        </td>
                    </tr>
					<tr>
						<td class="FooterStyle">
							Dealer</td>
						<td class="FooterStyle" colspan="3">
							(<asp:Label ID="Label167" runat="server" Font-Bold="True" Font-Underline="True" 
								Text='<%# Eval("DEALERCODE") %>'></asp:Label>)
							<asp:Label ID="Label168" runat="server" Font-Bold="True" Font-Underline="True" 
								Text='<%# Eval("DEALERNAME") %>'></asp:Label>
						</td>
					</tr>
					<tr>
						<td class="FooterStyle">
							Merk ID</td>
						<td class="FooterStyle">
							<asp:Label ID="MERKIDLabel" runat="server" Font-Bold="True" Font-Underline="True"
								Text='<%# Eval("MERKID") %>'></asp:Label>
						</td>
						<td class="FooterStyle">
							Model ID</td>
						<td class="FooterStyle">
							<asp:Label ID="MODELIDLabel" runat="server" Font-Bold="True" Font-Underline="True"
								Text='<%# Eval("MODELID") %>'></asp:Label>
						</td>
					</tr>
					<tr>
						<td class="FooterStyle">
							Merk Code</td>
						<td class="FooterStyle">
							<asp:Label ID="MERKCODELabel" runat="server" Font-Bold="True" Font-Underline="True"
								Text='<%# Eval("MERKCODE") %>'></asp:Label>
						</td>
						<td class="FooterStyle">
							Model Code</td>
						<td class="FooterStyle">
							<asp:Label ID="MODELCODELabel" runat="server" Font-Bold="True" Font-Underline="True"
								Text='<%# Eval("MODELCODE") %>'></asp:Label>
						</td>
					</tr>
					<tr>
						<td class="FooterStyle">
							Merk Name</td>
						<td class="FooterStyle">
							<asp:Label ID="MERKNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
								Text='<%# Eval("MERKNAME") %>'></asp:Label>
						</td>
						<td class="FooterStyle">
							Model Name</td>
						<td class="FooterStyle">
							<asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Underline="True" 
								Text='<%# Eval("MODELNAME") %>'></asp:Label>
						</td>
					</tr>
					<tr>
						<td>
							Object Type ID</td>
						<td>
							<asp:Label ID="Label170" runat="server" Font-Bold="True" Font-Underline="True" 
								Text='<%# Eval("OBJECTTYPEID") %>'></asp:Label>
						</td>
						<td>
							Object Type Name</td>
						<td>
							<asp:Label ID="Label169" runat="server" Font-Bold="True" Font-Underline="True" 
								Text='<%# Eval("TYPENAME") %>'></asp:Label>
						</td>
					</tr>
					<tr>
						<td>
							Kind/Category</td>
						<td>
							(<asp:Label ID="CARKINDLabel" runat="server" Font-Bold="True" Font-Underline="True"
								Text='<%# Eval("CATEGORYCODE") %>'></asp:Label>)
							<asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Underline="True" 
								Text='<%# Eval("CATEGORYNAME") %>'></asp:Label>
						</td>
						<td>
							Purpose</td>
						<td>
							(<asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Underline="True" 
								Text='<%# Eval("PURPOSECODE") %>'></asp:Label>
							)
							<asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Underline="True" 
								Text='<%# Eval("PURPOSENAME") %>'></asp:Label>
						</td>
					</tr>
					<tr>
						<td class="ShowDetail">
							Document Info</td>
						<td colspan="3">
							<hr />
						</td>
					</tr>
					<tr>
                        <td class="ErrHighLight">
                            Object//BPKB&nbsp; No</td>
                        <td class="ErrHighLight">
                            <asp:Label ID="BPKBNOLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("BPKBNO") %>'></asp:Label>
                        </td>
                        <td class="ErrHighLight">
                            Object/BPKB Date</td>
                        <td class="ErrHighLight">
                            <asp:Label ID="BPKBDATELabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("BPKBDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </td>
                    </tr>
					<tr>
						<td class="ErrHighLight">
							Object/BPKB Name</td>
						<td class="ErrHighLight">
							<asp:Label ID="BPKBNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
								Text='<%# Eval("BPKBNAME") %>'></asp:Label>
						</td>
						<td class="ErrHighLight">
							Object/BPKB Owner ID</td>
						<td class="ErrHighLight">
							<asp:Label ID="BPKBOWNERIDLabel" runat="server" Font-Bold="True" Font-Underline="True"
								Text='<%# Eval("BPKBOWNERID") %>'></asp:Label>
						</td>
					</tr>
					<tr>
						<td>
							Object/BPKB Address</td>
						<td colspan="3">
							<asp:Label ID="BPKBADDRESSLabel" runat="server" Font-Bold="True" Font-Underline="True"
								Text='<%# Eval("BPKBADDRESS") %>'></asp:Label>
						</td>
					</tr>
					<tr>
						<td>
							Object/BPKB City</td>
						<td>
							(<asp:Label ID="BPKBCITYIDLabel" runat="server" Font-Bold="True" Font-Underline="True"
								Text='<%# Eval("CITYCODE") %>'></asp:Label>)
                            <asp:Label ID="BPKBCITYIDLabel0" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("CITYNAME") %>'></asp:Label>
						</td>
						<td>
							Police No/Object Ref.</td>
						<td>
							<asp:Label ID="Label84" runat="server" Font-Bold="True" Font-Underline="True" 
								Text='<%# Eval("POLICENO") %>'></asp:Label>
						</td>
					</tr>
					<tr>
						<td>
							BPKB Car Type (Object Type)</td>
						<td>
							<asp:Label ID="BPKBCARTYPELabel" runat="server" Font-Bold="True" Font-Underline="True"
								Text='<%# Eval("BPKBCARTYPE") %>'></asp:Label>
						</td>
						<td>
							STNK Expire</td>
						<td>
							<asp:Label ID="Label85" runat="server" Font-Bold="True" Font-Underline="True" 
								Text='<%# Eval("STNKEXPIRED", "{0:dd/MM/yyyy}") %>'></asp:Label>
						</td>
					</tr>
					<tr>
						<td>
							Engine No (Object Ref. 1)</td>
						<td>
							<asp:Label ID="ENGINENOLabel" runat="server" Font-Bold="True" Font-Underline="True"
								Text='<%# Eval("ENGINENO") %>'></asp:Label>
						</td>
						<td>
							Chasis No (Object Ref. 2)</td>
						<td>
							<asp:Label ID="CHASSISNOLabel" runat="server" Font-Bold="True" Font-Underline="True"
								Text='<%# Eval("CHASSISNO") %>'></asp:Label>
						</td>
					</tr>
					<tr>
						<td>
							Car Year</td>
						<td>
							<asp:Label ID="CARYEARLabel" runat="server" Font-Bold="True" Font-Underline="True"
								Text='<%# Eval("CARYEAR") %>'></asp:Label>
						</td>
						<td>
							Build Year (Object Year)</td>
						<td>
							<asp:Label ID="BUILDYEARLabel" runat="server" Font-Bold="True" Font-Underline="True"
								Text='<%# Eval("BUILDYEAR") %>'></asp:Label>
						</td>
					</tr>
					<tr>
						<td>
							Object Condition</td>
						<td>
							(<asp:Label ID="CONDITIONLabel" runat="server" Font-Bold="True" Font-Underline="True"
								Text='<%# Eval("CONDITION") %>'></asp:Label>)
							<asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Underline="True" 
								Text='<%# Eval("CONDITIONNAME") %>'></asp:Label>
						</td>
						<td>
							Color</td>
						<td>
							<asp:Label ID="COLORLabel" runat="server" Font-Bold="True" Font-Underline="True"
								Text='<%# Eval("COLOR") %>'></asp:Label>
						</td>
					</tr>
					<tr>
                        <td class="ShowDetail">
                            Faktur Info</td>
                        <td colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Faktur No</td>
                        <td>
                            <asp:Label ID="Label186" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("FAKTURNO") %>'></asp:Label>
                        </td>
                        <td>
                            Faktur Name</td>
                        <td>
                            <asp:Label ID="Label187" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("FAKTURNAME") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="ShowDetail">
                            BI Info</td>
                        <td colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            ID Collateral</td>
                        <td>
                            <asp:Label ID="Label183" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("IDCOLLATERAL") %>'></asp:Label>
                        </td>
                        <td>
                            Collateral Type</td>
                        <td>
                            (<asp:Label ID="Label184" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("CTCODE") %>'></asp:Label>)
                            <asp:Label ID="Label185" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("CTNAME") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            SB Rank</td>
                        <td>
                            (<asp:Label ID="Label188" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("SBRANKCODE") %>'></asp:Label>)
                            <asp:Label ID="Label189" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("SBRANKNAME") %>'></asp:Label>
                        </td>
                        <td>
                            Survey Date</td>
                        <td>
                            <asp:Label ID="Label173" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("SURVEYDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Collateral Value</td>
                        <td>
                            <asp:Label ID="Label180" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("COLLATERALVALUE", "{0:N}") %>'></asp:Label>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td class="ShowDetail">
                            Route/Trayek Info</td>
                        <td colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Route</td>
                        <td>
                            (<asp:Label ID="Label171" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("ROUTENO") %>'></asp:Label>)
                            <asp:Label ID="Label172" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("ROUTENAME") %>'></asp:Label>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            SK Expired</td>
                        <td>
                            <asp:Label ID="Label181" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("SKEXPIRED", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </td>
                        <td>
                            KP Expired</td>
                        <td>
                            <asp:Label ID="Label182" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("KPEXPIRED", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </td>
                    </tr>
				    <tr>
                        <td class="ShowDetail">
                            Re-Survey</td>
                        <td class="FooterStyle" colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Re-Survey Date</td>
                        <td>
                            <asp:Label ID="Label192" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("RESURVEYDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </td>
                        <td>
                            Re-Survey Value</td>
                        <td>
                            <asp:Label ID="Label193" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("RESURVEYVALUE", "{0:N}") %>'></asp:Label>
                        </td>
                    </tr>
				</table>
			</ItemTemplate>
		</asp:FormView>
		<asp:GridView ID="gvBlocking" runat="server" AutoGenerateColumns="False" 
            Caption="COLLATERAL BLOCKING INFO" DataSourceID="sdsBlocking" Width="100%">
            <Columns>
                <asp:BoundField DataField="BLOCKEDDATE" DataFormatString="{0:dd/MM/yyyy}" 
                    HeaderText="Block&lt;br&gt;Date" HtmlEncode="False" 
                    SortExpression="BLOCKEDDATE">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="LETTERNOBLOCK" 
                    HeaderText="Letter&lt;br&gt;Block No." HtmlEncode="False" 
                    SortExpression="LETTERNOBLOCK" />
                <asp:BoundField DataField="LETTERTO" HeaderText="LETTERTO" 
                    SortExpression="LETTERTO" />
                <asp:BoundField DataField="UNBLOCKEDDATE" DataFormatString="{0:dd/MM/yyyy}" 
                    HeaderText="UnBlock&lt;br&gt;Date" HtmlEncode="False" 
                    SortExpression="UNBLOCKEDDATE">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="LETTERNOUNBLOCK" 
                    HeaderText="Letter&lt;br&gt;UnBlock No." HtmlEncode="False" 
                    SortExpression="LETTERNOUNBLOCK" />
            </Columns>
            <EmptyDataTemplate>
                <uc1:NoDataFound ID="NoDataFound3" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsBlocking" runat="server" 
            ConnectionString="<%$ ConnectionStrings:connection %>" 
            SelectCommand="SELECT COLLATERALBLOCK.BLOCKEDDATE, COLLATERALBLOCK.LETTERNOBLOCK, COLLATERALBLOCK.LETTERTO, COLLATERALBLOCK.UNBLOCKEDDATE, COLLATERALBLOCK.LETTERNOUNBLOCK FROM COLLATERALBLOCK WITH (NOLOCK) INNER JOIN COLLATERAL WITH (NOLOCK) ON COLLATERALBLOCK.LOCID = COLLATERAL.LOCID AND COLLATERALBLOCK.OBJID = COLLATERAL.OBJID INNER JOIN ACCOUNT WITH (NOLOCK) ON COLLATERAL.LOCID = ACCOUNT.LOCID AND COLLATERAL.ACCID = ACCOUNT.ACCID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.APPID = @APPID)">
            <SelectParameters>
                <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
                <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
            </SelectParameters>
        </asp:SqlDataSource>
		<asp:SqlDataSource ID="sdsCollateralData" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            
            SelectCommand="SELECT COLLATERAL.LOCID, COLLATERAL.OBJID, COLLATERAL.ACCID, COLLATERAL.MERKID, COLLATERAL.MODELID, COLLATERAL.BPKBNO, COLLATERAL.BPKBDATE, COLLATERAL.BPKBADDRESS, COLLATERAL.BPKBCITYID, COLLATERAL.BPKBNAME, COLLATERAL.BPKBOWNERID, COLLATERAL.BPKBCARTYPE, COLLATERAL.ENGINENO, COLLATERAL.CHASSISNO, COLLATERAL.CARYEAR, COLLATERAL.BUILDYEAR, COLLATERAL.CONDITION, dbo.f_getParamGlobalName('CONDITION', COLLATERAL.CONDITION) AS CONDITIONNAME, COLLATERAL.COLOR, COLLATERAL.BPKBSTATUS, COLLATERAL.RECEIVEDATE, MERK.MERKCODE, MERK.MERKNAME, MODEL.MODELCODE, MODEL.MODELNAME, dbo.f_getParamGlobalName('BPKBSTATUS', COLLATERAL.BPKBSTATUS) AS BPKBSTATUSNAME, COLLATERAL.POLICENO, COLLATERAL.STNKEXPIRED, COLLATERAL.SURVEYDATE, PRODUCT.PRODUCTCODE, PRODUCT.PRODUCTNAME, DEALER.DEALERCODE, DEALER.DEALERNAME, OBJECTPURPOSE.PURPOSECODE, OBJECTPURPOSE.PURPOSENAME, ROUTE.ROUTENO, ROUTE.ROUTENAME, OBJECTCATEGORY.CATEGORYCODE, OBJECTCATEGORY.CATEGORYNAME, OBJECTTYPE.TYPENAME, OBJECTTYPE.OBJECTTYPEID, CITY.CITYCODE, CITY.CITYNAME, COLLATERAL.FAKTURNO, COLLATERAL.KPEXPIRED, COLLATERAL.SKEXPIRED, COLLATERAL.CC, COLLATERAL.BLOCKINGSTS, CASE WHEN COLLATERAL.BLOCKINGSTS = 1 THEN 'YES' ELSE 'NO' END AS BLOCKINGSTSNAME, COLLATERAL.DELIVERDATE, COLLATERAL.FAKTURNAME, COLLATERAL.COLLATERALVALUE, SBRANK.SBRANKCODE, SBRANK.SBRANKNAME, COLLATERAL.IDCOLLATERAL, COLLATERALTYPE.CTCODE, COLLATERALTYPE.CTNAME, COLLATERAL.RELEASEDATE, COLLATERAL.RESURVEYDATE, COLLATERAL.RESURVEYVALUE FROM COLLATERAL WITH (NOLOCK) INNER JOIN ACCOUNT WITH (NOLOCK) ON COLLATERAL.LOCID = ACCOUNT.LOCID AND COLLATERAL.ACCID = ACCOUNT.ACCID LEFT OUTER JOIN COLLATERALTYPE WITH (NOLOCK) ON COLLATERAL.COLLATERALTYPEID = COLLATERALTYPE.COLLATERALTYPEID LEFT OUTER JOIN SBRANK WITH (NOLOCK) ON COLLATERAL.SBRANKID = SBRANK.SBRANKID LEFT OUTER JOIN CITY WITH (NOLOCK) ON COLLATERAL.BPKBCITYID = CITY.CITYID LEFT OUTER JOIN OBJECTCATEGORY WITH (NOLOCK) ON COLLATERAL.CATEGORYID = OBJECTCATEGORY.CATEGORYID LEFT OUTER JOIN OBJECTTYPE WITH (NOLOCK) ON COLLATERAL.OBJECTTYPEID = OBJECTTYPE.OBJECTTYPEID LEFT OUTER JOIN PRODUCT WITH (NOLOCK) ON COLLATERAL.PRODUCTID = PRODUCT.PRODUCTID LEFT OUTER JOIN ROUTE ON COLLATERAL.ROUTEID = ROUTE.ROUTEID LEFT OUTER JOIN OBJECTPURPOSE WITH (NOLOCK) ON COLLATERAL.PURPOSEID = OBJECTPURPOSE.PURPOSEID LEFT OUTER JOIN MODEL WITH (NOLOCK) ON COLLATERAL.MERKID = MODEL.MERKID AND COLLATERAL.MODELID = MODEL.MODELID LEFT OUTER JOIN MERK WITH (NOLOCK) ON COLLATERAL.MERKID = MERK.MERKID LEFT OUTER JOIN DEALER WITH (NOLOCK) ON COLLATERAL.DEALERID = DEALER.DEALERID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.APPID = @APPID)">
			<SelectParameters>
				<asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
				<asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
			</SelectParameters>
		</asp:SqlDataSource>
	</asp:Panel><asp:Panel ID="pnlBorrowShow" runat="server" CssClass="ShowDetail" Width="99%">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgBorrow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblBorrow" runat="server" CssClass="required">(Show Borrow History...)</asp:Label>
		</div>
		<input id="Button2" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
	<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEBorrow" runat="server" CollapseControlID="pnlBorrowShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Borrow History...)" Enabled="True"
		ExpandControlID="pnlBorrowShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Borrow History...)"
		ImageControlID="imgBorrow" TargetControlID="pnlBorrow" TextLabelID="lblBorrow">
	</ajaxToolkit:CollapsiblePanelExtender>
	<asp:Panel ID="pnlBorrow" runat="server">
		<asp:GridView ID="gvBorrow" runat="server" AllowPaging="True" AllowSorting="True"
			AutoGenerateColumns="False" Caption="COLLATERAL BORROW HISTORY" DataKeyNames="LOCIDBORROW,BORROWID"
			DataSourceID="sdsBorrowHistory" Width="100%">
			<Columns>
				<asp:BoundField DataField="BORROWDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Borrow&lt;br&gt;Date"
					HtmlEncode="False" SortExpression="BORROWDATE">
					<ItemStyle HorizontalAlign="Center" />
				</asp:BoundField>
				<asp:BoundField DataField="BORROWSTATUSNAME" HeaderText="Status" HtmlEncode="False"
					ReadOnly="True" SortExpression="BORROWSTATUSNAME" />
				<asp:BoundField DataField="BORROWBYJF" HeaderText="Borrow&lt;br&gt;By&lt;br&gt;JF"
					HtmlEncode="False" ReadOnly="True" SortExpression="BORROWBYJF">
					<ItemStyle HorizontalAlign="Center" />
				</asp:BoundField>
				<asp:BoundField DataField="BORROWER" HeaderText="Borrower" HtmlEncode="False" SortExpression="BORROWER" />
				<asp:BoundField DataField="RETURNDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="(Plan)&lt;br&gt;Return&lt;br&gt;Date"
					HtmlEncode="False" SortExpression="RETURNDATE">
					<ItemStyle HorizontalAlign="Center" />
				</asp:BoundField>
				<asp:BoundField DataField="BRPNAME" HeaderText="Purpose" ReadOnly="True" SortExpression="BRPNAME" />
			</Columns>
			<EmptyDataTemplate>
				<uc1:NoDataFound ID="NoDataFound1" runat="server" />
			</EmptyDataTemplate>
		</asp:GridView>
		<asp:SqlDataSource ID="sdsBorrowHistory" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
			SelectCommand="SELECT COLLATERALBORROW.LOCIDBORROW, COLLATERALBORROW.BORROWID, COLLATERALBORROW.BORROWDATE, '(' + CAST(COLLATERALBORROW.BORROWSTATUS AS VARCHAR(30)) + ') ' + dbo.f_getParamGlobalName('BORROWSTATUS ', COLLATERALBORROW.BORROWSTATUS) AS BORROWSTATUSNAME, CASE WHEN COLLATERALBORROW.BORROWBYJF = 1 THEN 'Yes' ELSE 'No' END AS BORROWBYJF, COLLATERALBORROW.BORROWER, COLLATERALBORROW.RETURNDATE, '(' + BORROWPURPOSE.BRPCODE + ') ' + BORROWPURPOSE.BRPNAME AS BRPNAME FROM ACCOUNT WITH (NOLOCK) INNER JOIN COLLATERAL WITH (NOLOCK) ON ACCOUNT.LOCID = COLLATERAL.LOCID AND ACCOUNT.ACCID = COLLATERAL.ACCID INNER JOIN COLLATERALBORROW WITH (NOLOCK) ON COLLATERAL.LOCID = COLLATERALBORROW.LOCID AND COLLATERAL.OBJID = COLLATERALBORROW.OBJID INNER JOIN BORROWPURPOSE WITH (NOLOCK) ON COLLATERALBORROW.BRPID = BORROWPURPOSE.BRPID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.APPID = @APPID)">
			<SelectParameters>
				<asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
				<asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
			</SelectParameters>
		</asp:SqlDataSource>
	</asp:Panel>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvBorrow.ClientID%>");
    FormatTable("<%=gvBlocking.ClientID%>");
    FormatTable("<%=gvParipasuTo.ClientID%>");
    FormatTable("<%=gvParipasuFrom.ClientID%>");
    function ViewDetailAcc(LOCID, APPID) {
        var winref = window.open("../Account/AccInqFrame.aspx?Action=View&LOCID=" + LOCID + "&APPID=" + APPID, "ShowParipasuAcc", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
        winref.focus();
    }
</script>
</asp:Content>

