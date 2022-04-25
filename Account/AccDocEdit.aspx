<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccDocEdit.aspx.vb" Inherits="Account_AccDocEdit" title="Collatera : Editing" EnableEventValidation="false" %>

<%@ Register src="../UserControl/NoDataFound.ascx" tagname="NoDataFound" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
        <asp:ScriptManagerProxy ID="SMPCollEdit" runat="server">
			<Services>
				<asp:ServiceReference Path="GHWService.asmx" />
			</Services>
		</asp:ScriptManagerProxy>

	<asp:Panel ID="pnlCustShow" runat="server" CssClass="ShowDetail" Width="99%">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgCustData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblCustData" runat="server" CssClass="required">(Show Customer Data...)</asp:Label>
		</div>
		<input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
			background-repeat: no-repeat; height: 16px" type="button" />
	</asp:Panel>
	<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPECustData" runat="server" CollapseControlID="pnlCustShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Customer Data...)"
		Enabled="True" ExpandControlID="pnlCustShow" ExpandedImage="~/images/collapse.jpg"
		ExpandedText="(Hide Customer Data...)" ImageControlID="imgCustData" TargetControlID="pnlCustData"
		TextLabelID="lblCustData">
	</ajaxToolkit:CollapsiblePanelExtender>
	<asp:Panel ID="pnlCustData" runat="server"  Width="100%">
		<asp:DataList ID="dlCustData" runat="server"  
			Caption="CUSTOMER DATA" DataSourceID="sdsCustData" Width="100%">
			<ItemTemplate>
            
				<table cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td class="ErrHighLight">
							Negative Customer</td>
						<td class="ErrHighLight" colspan="3">
							<asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("NEGATIVESTS") %>'
								Enabled="False" /></td>
					</tr>
					<tr>
						<td class="FooterStyle">
							Name</td>
						<td class="FooterStyle" colspan="3">
							<asp:Label ID="Label23" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTNAME") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							Full Name</td>
						<td colspan="3">
							<asp:Label ID="Label24" runat="server" Font-Underline="True" 
                                Text='<%# Eval("FULLNAME") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							Title</td>
						<td colspan="3">
							<asp:Label ID="Label128" runat="server" Font-Underline="True" 
                                Text='<%# Eval("TITLE") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							Mother Maiden name</td>
						<td colspan="3">
							<asp:Label ID="Label25" runat="server" Font-Underline="True" 
                                Text='<%# Eval("MMN") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							Gender</td>
						<td colspan="3">
							(<asp:Label ID="Label26" runat="server" Font-Underline="True" 
                                Text='<%# Eval("GENDER") %>' style="font-weight: bold"></asp:Label>)
							<asp:Label ID="Label70" runat="server" Font-Underline="True" 
                                Text='<%# Eval("GENDERNAME") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td class="RowStyle">
							Marital Status</td>
						<td class="AlternatingRowStyle" colspan="3">
							(<asp:Label ID="Label27" runat="server" Font-Underline="True" 
                                Text='<%# Eval("MARITALSTATUS") %>' style="font-weight: bold"></asp:Label>)
							<asp:Label ID="Label71" runat="server" Font-Underline="True" 
                                Text='<%# Eval("MARITALSTSNAME") %>' style="font-weight: bold"></asp:Label>
							&nbsp; Dependent&nbsp;
							<asp:Label ID="Label28" runat="server" Font-Underline="True" 
                                Text='<%# Eval("DEPENDENT") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							ID Type</td>
						<td>
							(<asp:Label ID="Label31" runat="server" Font-Underline="True" 
                                Text='<%# Eval("IDTYPE") %>' style="font-weight: bold"></asp:Label>)<asp:Label
								ID="Label72" runat="server" Font-Underline="True" Text='<%# Eval("IDTYPENAME") %>' 
                                style="font-weight: bold"></asp:Label></td>
						<td>
							ID Number</td>
						<td>
							<asp:Label ID="Label29" runat="server" Font-Underline="True" 
                                Text='<%# Eval("IDNUMBER") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							ID Expired</td>
						<td colspan="3">
							<asp:Label ID="Label32" runat="server" Font-Underline="True" 
                                Text='<%# Eval("IDEXPIRED", "{0:dd/MM/yyyy}") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							Birth Place</td>
						<td>
							<asp:Label ID="Label33" runat="server" Font-Underline="True" 
                                Text='<%# Eval("BIRTHPLACE") %>' style="font-weight: bold"></asp:Label></td>
						<td>
							Birth Date</td>
						<td>
							<asp:Label ID="Label30" runat="server" Font-Underline="True" 
                                Text='<%# Eval("BIRTHDATE", "{0:dd/MM/yyyy}") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							Birth City ID</td>
						<td colspan="3">
							(<asp:Label ID="Label34" runat="server" Font-Underline="True" 
                                Text='<%# Eval("BIRTHDATI") %>' style="font-weight: bold"></asp:Label>)
							<asp:Label ID="Label35" runat="server" Font-Underline="True" 
                                Text='<%# Eval("BIRTHDATINAME") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							Reference No.</td>
						<td colspan="3">
							<asp:Label ID="Label36" runat="server" Font-Underline="True" 
                                Text='<%# Eval("REFNO") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td class="HeaderStyle">
							EDUCATION &amp; BI DATA</td>
						<td class="FooterStyle" colspan="3">
							<hr />
						</td>
					</tr>
					<tr>
						<td>
							Last Education</td>
						<td colspan="3">
							(<asp:Label ID="Label37" runat="server" Font-Underline="True" 
                                Text='<%# Eval("EDUCODE") %>' style="font-weight: bold"></asp:Label>)
							<asp:Label ID="Label38" runat="server" Font-Underline="True" 
                                Text='<%# Eval("EDUNAME") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							Economy Sector</td>
						<td colspan="3">
							(<asp:Label ID="Label39" runat="server" Font-Underline="True" 
                                Text='<%# Eval("ECOCODE") %>' style="font-weight: bold"></asp:Label>)
							<asp:Label ID="Label40" runat="server" Font-Underline="True" 
                                Text='<%# Eval("ECONAME") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							Debitor Code</td>
						<td colspan="3">
							(<asp:Label ID="Label41" runat="server" Font-Underline="True" 
                                Text='<%# Eval("DEBCODE") %>' style="font-weight: bold"></asp:Label>)<asp:Label
								ID="Label42" runat="server" Font-Underline="True" Text='<%# Eval("DEBNAME") %>' 
                                style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							NPWP</td>
						<td colspan="3" style="height: 19px">
							<asp:Label ID="Label43" runat="server" Font-Underline="True" 
                                Text='<%# Eval("NPWP") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td class="HeaderStyle">
							ID(KTP) ADDRESS</td>
						<td class="FooterStyle" colspan="3">
							<hr />
						</td>
					</tr>
					<tr>
						<td>
							ID Address</td>
						<td colspan="3">
							<asp:Label ID="Label44" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTADDRESS") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							RT/RW</td>
						<td colspan="3">
							<asp:Label ID="Label45" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTRT") %>' style="font-weight: bold"></asp:Label>/<asp:Label
								ID="Label61" runat="server" Font-Underline="True" Text='<%# Eval("CUSTRW") %>' 
                                style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							Kelurahan</td>
						<td>
							<asp:Label ID="Label46" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTKEL") %>' style="font-weight: bold"></asp:Label></td>
						<td>
							Kecamatan</td>
						<td>
							<asp:Label ID="Label47" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTKEC") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							Kab/City</td>
						<td>
							<asp:Label ID="Label49" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTCITY") %>' style="font-weight: bold"></asp:Label></td>
						<td>
							Province</td>
						<td>
							<asp:Label ID="Label48" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTPROV") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							Zip Code</td>
						<td colspan="3">
							<asp:Label ID="Label50" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTZIP") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							City ID</td>
						<td colspan="3">
							(<asp:Label ID="Label51" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTDATI") %>' style="font-weight: bold"></asp:Label>)
							<asp:Label ID="Label73" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTDATINAME") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							Home Status</td>
						<td colspan="3">
							(<asp:Label ID="Label52" runat="server" Font-Underline="True" 
                                Text='<%# Eval("HOMESTATUS") %>' style="font-weight: bold"></asp:Label>)
							<asp:Label ID="Label76" runat="server" Font-Underline="True" 
                                Text='<%# Eval("HOMESTATUSNAME") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							Lived Since</td>
						<td colspan="3">
							<asp:Label ID="Label53" runat="server" Font-Underline="True" 
                                Text='<%# Eval("LIVEDSINCE", "{0:dd/MM/yyyy}") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td class="HeaderStyle">
							PHONE &amp; MOBILE</td>
						<td class="FooterStyle" colspan="3">
							<hr />
						</td>
					</tr>
					<tr>
						<td>
							Phone Area</td>
						<td>
							<asp:Label ID="Label54" runat="server" Font-Underline="True" 
                                Text='<%# Eval("PHONEAREA") %>' style="font-weight: bold"></asp:Label></td>
						<td>
							Phone No.</td>
						<td>
							<asp:Label ID="Label55" runat="server" Font-Underline="True" 
                                Text='<%# Eval("PHONENO") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							Mobile No.</td>
						<td colspan="3">
							<asp:Label ID="Label56" runat="server" Font-Underline="True" 
                                Text='<%# Eval("MOBILENO") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							IDAddress=HomeAddress?</td>
						<td colspan="3">
							(<asp:Label ID="Label57" runat="server" Font-Underline="True" 
                                Text='<%# Eval("SAMEIDHOMEADDR") %>' style="font-weight: bold"></asp:Label>)
							<asp:Label ID="Label74" runat="server" Font-Underline="True" 
                                Text='<%# Eval("SAMEIDHOMEADDRNAME") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td colspan="4">
						</td>
					</tr>
					<tr>
						<td class="HeaderStyle">
							HOME ADDRESS</td>
						<td class="FooterStyle" colspan="3">
							<hr />
						</td>
					</tr>
					<tr>
						<td>
							Home Address</td>
						<td colspan="3">
							<asp:Label ID="Label58" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTADDRESSHOME") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							RT/RW</td>
						<td colspan="3">
							<asp:Label ID="Label59" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTRTHOME") %>' style="font-weight: bold"></asp:Label>/<asp:Label
								ID="Label60" runat="server" Font-Underline="True" Text='<%# Eval("CUSTRWHOME") %>' 
                                style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							Kelurahan</td>
						<td>
							<asp:Label ID="Label62" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTKELHOME") %>' style="font-weight: bold"></asp:Label></td>
						<td>
							Kecamatan</td>
						<td>
							<asp:Label ID="Label63" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTKECHOME") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							Kab/City</td>
						<td style="height: 19px">
							<asp:Label ID="Label64" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTCITYHOME") %>' style="font-weight: bold"></asp:Label></td>
						<td style="height: 19px">
							Province</td>
						<td>
							<asp:Label ID="Label65" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTPROVHOME") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							Zip Code</td>
						<td colspan="3">
							<asp:Label ID="Label66" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTZIPHOME") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
					<tr>
						<td>
							City ID</td>
						<td colspan="3">
							(<asp:Label ID="Label67" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTDATIHOME") %>' style="font-weight: bold"></asp:Label>)
							<asp:Label ID="Label75" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTDATIHOMENAME") %>' style="font-weight: bold"></asp:Label></td>
					</tr>
				</table>
			</ItemTemplate>
		</asp:DataList><asp:SqlDataSource ID="sdsCustData" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
			
            
            SelectCommand="SELECT ACCOUNT.LOCID, ACCOUNT.APPID, CUSTOMER.CUSTID, CUSTOMER.CUSTNO, CUSTOMER.FULLNAME, CUSTOMER.MMN, CUSTOMER.GENDER, dbo.f_getParamGlobalName('GENDER', CUSTOMER.GENDER) AS GENDERNAME, CUSTOMER.MARITALSTATUS, dbo.f_getParamGlobalName('MARITALSTS', CUSTOMER.MARITALSTATUS) AS MARITALSTSNAME, CUSTOMER.IDNUMBER, CUSTOMER.IDTYPE, dbo.f_getParamGlobalName('IDTYPE', CUSTOMER.IDTYPE) AS IDTYPENAME, CUSTOMER.IDEXPIRED, CUSTOMER.BIRTHPLACE, CUSTOMER.BIRTHDATE, CITY.CITYCODE AS BIRTHDATI, CITY.CITYNAME AS BIRTHDATINAME, ACCOUNT.ACCOUNTNAME, ACCOUNT.REFNO, CUSTOMER.LASTEDUCATION, dbo.f_getParamGlobalName('LASTEDUCATION', CUSTOMER.LASTEDUCATION) AS LASTEDUCATIONNAME, ECONOMYCODE.ECOCODE, ECONOMYCODE.ECONAME, CUSTOMER.DEBITURCODE, dbo.f_getParamGlobalName('DEBITURCODE', CUSTOMER.DEBITURCODE) AS DEBITURCODENAME, CUSTOMER.NPWP, CUSTOMER.CUSTNAME, CUSTOMER.CUSTADDRESS, CUSTOMER.CUSTRT, CUSTOMER.CUSTRW, CUSTOMER.CUSTKEL, CUSTOMER.CUSTKEC, CUSTOMER.CUSTCITY, CUSTOMER.CUSTPROV, CUSTOMER.CUSTZIP, CUSTOMER.WORKSINCE, CUSTOMER.LIVEDSINCE, CUSTOMER.PHONEAREA, CUSTOMER.PHONENO, CUSTOMER.MOBILENO, CUSTOMER.DEPENDENT, CUSTOMER.GROSSINCOME, CUSTOMER.EXPENSES, CITY_1.CITYCODE AS CUSTDATI, CITY_1.CITYNAME AS CUSTDATINAME, CUSTOMERDTL.CUSTRTHOME, CUSTOMERDTL.CUSTRWHOME, CUSTOMERDTL.CUSTKELHOME, CUSTOMERDTL.CUSTKECHOME, CUSTOMERDTL.CUSTCITYHOME, CUSTOMERDTL.CUSTPROVHOME, CUSTOMERDTL.CUSTZIPHOME, CUSTOMERDTL.CUSTADDRESSHOME, CUSTOMER.HOMESTATUS, dbo.f_getParamGlobalName('HOMESTATUS', CUSTOMER.HOMESTATUS) AS HOMESTATUSNAME, CITY_2.CITYCODE AS CUSTDATIHOME, CITY_2.CITYNAME AS CUSTDATIHOMENAME, CAST(CUSTOMERDTL.SAMEIDHOMEADDR AS VARCHAR(20)) AS SAMEIDHOMEADDR, dbo.f_getParamGlobalName('YESNO', CAST(CUSTOMERDTL.SAMEIDHOMEADDR AS VARCHAR(20))) AS SAMEIDHOMEADDRNAME, CUSTOMER.TITLE, CUSTOMER.NEGATIVESTS, CASE WHEN GROSSINCOME &gt; 0 THEN (ACCOUNT.INSTALLMENT / GROSSINCOME) * 100.00 ELSE 0 END AS DSR, CUSTOMERDTL.COMPANYNAME, CUSTOMERDTL.COMPANYADDR, CUSTOMERDTL.COMPANYCITY, CUSTOMERDTL.COMPANYZIP, CUSTOMERDTL.COMPANYPHONE, EDUCATION.EDUCODE, EDUCATION.EDUNAME, DEBITURCODE.DEBCODE, DEBITURCODE.DEBNAME FROM DEBITURCODE WITH (NOLOCK) INNER JOIN ACCOUNT WITH (NOLOCK) INNER JOIN CUSTOMER WITH (NOLOCK) ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID ON DEBITURCODE.DEBID = CUSTOMER.DEBITURCODE LEFT OUTER JOIN EDUCATION WITH (NOLOCK) ON CUSTOMER.LASTEDUCATION = EDUCATION.EDUID RIGHT OUTER JOIN CUSTOMERDTL WITH (NOLOCK) LEFT OUTER JOIN CITY AS CITY_2 ON CUSTOMERDTL.CUSTDATIHOME = CITY_2.CITYID ON CUSTOMER.LOCIDCUST = CUSTOMERDTL.LOCIDCUST AND CUSTOMER.CUSTID = CUSTOMERDTL.CUSTID LEFT OUTER JOIN CITY AS CITY_1 ON CUSTOMER.CUSTDATI = CITY_1.CITYID LEFT OUTER JOIN ECONOMYCODE ON CUSTOMER.ECONOMYCODE = ECONOMYCODE.ECOID LEFT OUTER JOIN CITY ON CUSTOMER.BIRTHDATI = CITY.CITYID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.ACCID = @ACCID)">
			<SelectParameters>
				<asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
				<asp:QueryStringParameter Name="ACCID" QueryStringField="ACCID" />
			</SelectParameters>
		</asp:SqlDataSource>
	</asp:Panel>
	<asp:Panel ID="pnlCollateralShow" runat="server" CssClass="ShowDetail" Width="99%">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgCollateral" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblCollateral" runat="server" CssClass="required">(Show Current Collateral Data...)</asp:Label>
		</div>
		<input id="Button2" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
	<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPECollateral" runat="server" CollapseControlID="pnlCollateralShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Current Collateral Data...)"
		Enabled="True" ExpandControlID="pnlCollateralShow" ExpandedImage="~/images/collapse.jpg"
		ExpandedText="(Hide Current Collateral Data...)" ImageControlID="imgCollateral"
		TargetControlID="pnlCollateral" TextLabelID="lblCollateral">
	</ajaxToolkit:CollapsiblePanelExtender>
	<asp:Panel ID="pnlCollateral" runat="server"  Width="100%">
        <asp:Button ID="btnPrintLoan" runat="server" OnClientClick='return PrintData();'
            Style="background-position: right; background-image: url('../Images/print.jpg');
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Print Collateral Data" Width="136px" />
		<asp:FormView ID="fvCollateral" runat="server" AllowPaging="True" 
            Caption="CURRENT COLLATERAL DATA INFO" DataSourceID="sdsCollateralData" 
            Width="100%">
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
                            <asp:Label ID="MERKIDLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("MERKID") %>'></asp:Label>
                        </td>
                        <td class="FooterStyle">
                            Model ID</td>
                        <td class="FooterStyle">
                            <asp:Label ID="MODELIDLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("MODELID") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="FooterStyle">
                            Merk Code</td>
                        <td class="FooterStyle">
                            <asp:Label ID="MERKCODELabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("MERKCODE") %>'></asp:Label>
                        </td>
                        <td class="FooterStyle">
                            Model Code</td>
                        <td class="FooterStyle">
                            <asp:Label ID="MODELCODELabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("MODELCODE") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="FooterStyle">
                            Merk Name</td>
                        <td class="FooterStyle">
                            <asp:Label ID="MERKNAMELabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("MERKNAME") %>'></asp:Label>
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
                            (<asp:Label ID="CARKINDLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("CATEGORYCODE") %>'></asp:Label>)
                            <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("CATEGORYNAME") %>'></asp:Label>
                        </td>
                        <td>
                            Purpose</td>
                        <td>
                            (<asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("PURPOSECODE") %>'></asp:Label>)
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
                            <asp:Label ID="BPKBNAMELabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("BPKBNAME") %>'></asp:Label>
                        </td>
                        <td class="ErrHighLight">
                            Object/BPKB Owner ID</td>
                        <td class="ErrHighLight">
                            <asp:Label ID="BPKBOWNERIDLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("BPKBOWNERID") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Object/BPKB Address</td>
                        <td colspan="3">
                            <asp:Label ID="BPKBADDRESSLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("BPKBADDRESS") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Object/BPKB City</td>
                        <td>
                            (<asp:Label ID="BPKBCITYIDLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("CITYCODE") %>'></asp:Label>)
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
                            <asp:Label ID="BPKBCARTYPELabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("BPKBCARTYPE") %>'></asp:Label>
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
                            <asp:Label ID="ENGINENOLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("ENGINENO") %>'></asp:Label>
                        </td>
                        <td>
                            Chasis No (Object Ref. 2)</td>
                        <td>
                            <asp:Label ID="CHASSISNOLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("CHASSISNO") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Car Year</td>
                        <td>
                            <asp:Label ID="CARYEARLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("CARYEAR") %>'></asp:Label>
                        </td>
                        <td>
                            Build Year (Object Year)</td>
                        <td>
                            <asp:Label ID="BUILDYEARLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("BUILDYEAR") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Object Condition</td>
                        <td>
                            (<asp:Label ID="CONDITIONLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("CONDITION") %>'></asp:Label>)
                            <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("CONDITIONNAME") %>'></asp:Label>
                        </td>
                        <td>
                            Color</td>
                        <td>
                            <asp:Label ID="COLORLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("COLOR") %>'></asp:Label>
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
                                Text='<%# Eval("SBRANKCODE") %>'></asp:Label>
                            )
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
                            Document Info</td>
                        <td colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Re-Survey Date</td>
                        <td>
                            <asp:Label ID="Label193" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("RESURVEYDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </td>
                        <td>
                            Re-Survey Value</td>
                        <td>
                            <asp:Label ID="Label192" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("RESURVEYVALUE", "{0:N}") %>'></asp:Label>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource ID="sdsCollateralData" runat="server" 
            ConnectionString="<%$ ConnectionStrings:connection %>" 
            
            
            
            SelectCommand="SELECT COLLATERAL.LOCID, COLLATERAL.OBJID, COLLATERAL.ACCID, COLLATERAL.MERKID, COLLATERAL.MODELID, COLLATERAL.BPKBNO, COLLATERAL.BPKBDATE, COLLATERAL.BPKBADDRESS, COLLATERAL.BPKBCITYID, COLLATERAL.BPKBNAME, COLLATERAL.BPKBOWNERID, COLLATERAL.BPKBCARTYPE, COLLATERAL.ENGINENO, COLLATERAL.CHASSISNO, COLLATERAL.CARYEAR, COLLATERAL.BUILDYEAR, COLLATERAL.CONDITION, dbo.f_getParamGlobalName('CONDITION', COLLATERAL.CONDITION) AS CONDITIONNAME, COLLATERAL.COLOR, COLLATERAL.BPKBSTATUS, COLLATERAL.RECEIVEDATE, MERK.MERKCODE, MERK.MERKNAME, MODEL.MODELCODE, MODEL.MODELNAME, dbo.f_getParamGlobalName('BPKBSTATUS', COLLATERAL.BPKBSTATUS) AS BPKBSTATUSNAME, COLLATERAL.POLICENO, COLLATERAL.STNKEXPIRED, COLLATERAL.SURVEYDATE, PRODUCT.PRODUCTCODE, PRODUCT.PRODUCTNAME, DEALER.DEALERCODE, DEALER.DEALERNAME, OBJECTPURPOSE.PURPOSECODE, OBJECTPURPOSE.PURPOSENAME, ROUTE.ROUTENO, ROUTE.ROUTENAME, OBJECTCATEGORY.CATEGORYCODE, OBJECTCATEGORY.CATEGORYNAME, OBJECTTYPE.TYPENAME, OBJECTTYPE.OBJECTTYPEID, CITY.CITYCODE, CITY.CITYNAME, COLLATERAL.FAKTURNO, COLLATERAL.KPEXPIRED, COLLATERAL.SKEXPIRED, COLLATERAL.CC, COLLATERAL.BLOCKINGSTS, CASE WHEN COLLATERAL.BLOCKINGSTS = 1 THEN 'YES' ELSE 'NO' END AS BLOCKINGSTSNAME, COLLATERAL.DELIVERDATE, COLLATERAL.FAKTURNAME, COLLATERAL.COLLATERALVALUE, SBRANK.SBRANKCODE, SBRANK.SBRANKNAME, COLLATERAL.IDCOLLATERAL, COLLATERALTYPE.CTCODE, COLLATERALTYPE.CTNAME, COLLATERAL.RELEASEDATE, COLLATERAL.RESURVEYDATE, COLLATERAL.RESURVEYVALUE FROM COLLATERAL WITH (NOLOCK) LEFT OUTER JOIN COLLATERALTYPE WITH (NOLOCK) ON COLLATERAL.COLLATERALTYPEID = COLLATERALTYPE.COLLATERALTYPEID LEFT OUTER JOIN SBRANK WITH (NOLOCK) ON COLLATERAL.SBRANKID = SBRANK.SBRANKID LEFT OUTER JOIN CITY WITH (NOLOCK) ON COLLATERAL.BPKBCITYID = CITY.CITYID LEFT OUTER JOIN OBJECTCATEGORY WITH (NOLOCK) ON COLLATERAL.CATEGORYID = OBJECTCATEGORY.CATEGORYID LEFT OUTER JOIN OBJECTTYPE WITH (NOLOCK) ON COLLATERAL.OBJECTTYPEID = OBJECTTYPE.OBJECTTYPEID LEFT OUTER JOIN PRODUCT WITH (NOLOCK) ON COLLATERAL.PRODUCTID = PRODUCT.PRODUCTID LEFT OUTER JOIN ROUTE ON COLLATERAL.ROUTEID = ROUTE.ROUTEID LEFT OUTER JOIN OBJECTPURPOSE WITH (NOLOCK) ON COLLATERAL.PURPOSEID = OBJECTPURPOSE.PURPOSEID LEFT OUTER JOIN MODEL WITH (NOLOCK) ON COLLATERAL.MERKID = MODEL.MERKID AND COLLATERAL.MODELID = MODEL.MODELID LEFT OUTER JOIN MERK WITH (NOLOCK) ON COLLATERAL.MERKID = MERK.MERKID LEFT OUTER JOIN DEALER WITH (NOLOCK) ON COLLATERAL.DEALERID = DEALER.DEALERID WHERE (COLLATERAL.LOCID = @LOCID) AND (COLLATERAL.ACCID = @ACCID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="hidLocID" Name="LOCID" PropertyName="Value" />
                <asp:ControlParameter ControlID="hidAccID" Name="ACCID" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:DataList ID="dlStorePlace" runat="server" Caption="DOCUMENT STORE PLACE" 
            DataSourceID="sdsStorePlace" Width="100%">
            <ItemTemplate>
                <table style="width: 100%;" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            Store Date</td>
                        <td colspan="3">
                            <asp:Label ID="lblStoreDate" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("STOREDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Area</td>
                        <td>
                            (<asp:Label ID="lblAREACode" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("AREACODE") %>'></asp:Label>)
                            <asp:Label ID="lblAREANAME" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("AREANAME") %>'></asp:Label>
                        </td>
                        <td>
                            Branch</td>
                        <td>
                            (<asp:Label ID="lblBRANCHCODE" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("BRANCHCODE") %>'></asp:Label>)
                            <asp:Label ID="lblBRANCHNAME" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("BRANCHNAME") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr class="FooterStyle">
                        <td class="ShowDetail">
                            Document Store</td>
                        <td colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Safe Document</td>
                        <td colspan="3">
                            (<asp:Label ID="lblDOCUMENTSAFE" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("DOCSAFECODE") %>'></asp:Label>)&nbsp;
                            <asp:Label ID="lblDocumentShelf1" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("DOCSAFENAME") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Shelf Document</td>
                        <td colspan="3">
                            (<asp:Label ID="lblDocumentShelf" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("DOCSHELFCODE") %>'></asp:Label>)&nbsp;
                            <asp:Label ID="lblDocumentShelf0" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("DOCSHELFNAME") %>'></asp:Label>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
        <asp:SqlDataSource ID="sdsStorePlace" runat="server" 
            ConnectionString="<%$ ConnectionStrings:connection %>" 
            
            SelectCommand="SELECT DOCSTORE.STOREDATE, DOCSHELF.DOCSHELFID, DOCSHELF.DOCSHELFCODE, DOCSHELF.DOCSHELFNAME, DOCSHELF.DOCSHELFDESC, DOCSAFE.DOCSAFEID, DOCSAFE.BRANCHID, DOCSAFE.DOCSAFECODE, DOCSAFE.DOCSAFENAME, DOCSAFE.DOCSAFEDESC, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME, AREA.AREACODE, AREA.AREANAME FROM AREA WITH (NOLOCK) RIGHT OUTER JOIN BRANCH WITH (NOLOCK) ON AREA.AREAID = BRANCH.AREAID RIGHT OUTER JOIN DOCSAFE WITH (NOLOCK) ON BRANCH.BRANCHID = DOCSAFE.BRANCHID LEFT OUTER JOIN DOCSHELF WITH (NOLOCK) ON DOCSAFE.DOCSAFEID = DOCSHELF.DOCSAFEID RIGHT OUTER JOIN DOCSTORE WITH (NOLOCK) ON DOCSHELF.DOCSHELFID = DOCSTORE.DOCSHELFID RIGHT OUTER JOIN ACCOUNT WITH (NOLOCK) ON DOCSTORE.LOCID = ACCOUNT.LOCID AND DOCSTORE.ACCID = ACCOUNT.ACCID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.ACCID = @ACCID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="hidLocID" Name="LOCID" PropertyName="Value" />
                <asp:ControlParameter ControlID="hidAccID" Name="ACCID" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GvBorrowDoc" runat="server" AutoGenerateColumns="False" 
            Caption="DOCUMENT BORROW INFO" DataSourceID="sdsDocumentBorrow" 
            Width="100%">
            <Columns>
                <asp:BoundField DataField="BORROWDATE" DataFormatString="{0:dd/MM/yyyy}" 
                    HeaderText="Borrow&lt;br&gt;Date" HtmlEncode="False" 
                    SortExpression="BORROWDATE">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="BORROWER" HeaderText="Borrower" 
                    SortExpression="BORROWER" />
                <asp:BoundField DataField="BORROWSTATUS" HeaderText="Borrow&lt;br&gt;Status" 
                    HtmlEncode="False" ReadOnly="True" SortExpression="BORROWSTATUS" />
                <asp:BoundField DataField="BORROWBYJF" HeaderText="Borrow&lt;br&gt;JF?" 
                    HtmlEncode="False" SortExpression="BORROWBYJF" />
                <asp:BoundField DataField="RETURNDATE" DataFormatString="{0:dd/MM/yyyy}" 
                    HeaderText="Return&lt;br&gt;Date" HtmlEncode="False" 
                    SortExpression="RETURNDATE">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <EmptyDataTemplate>
                <uc1:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsDocumentBorrow" runat="server" 
            ConnectionString="<%$ ConnectionStrings:connection %>" 
            
            SelectCommand="SELECT BORROWID, BORROWDATE, '(' + CAST(BORROWSTATUS AS VARCHAR(20)) + ') ' + dbo.f_getParamGlobalName('BORROWSTATUS', BORROWSTATUS) AS BORROWSTATUS, BORROWER, RETURNDATE, CASE WHEN BORROWBYJF = 1 THEN 'YES' ELSE 'NO' END AS BORROWBYJF FROM COLLATERALBORROW WITH (NOLOCK) WHERE (LOCID = @LOCID) AND (OBJID = @OBJID) ORDER BY BORROWDATE">
            <SelectParameters>
                <asp:ControlParameter ControlID="hidLocID" Name="LOCID" PropertyName="Value" />
                <asp:ControlParameter ControlID="hidObjID" Name="OBJID" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
	</asp:Panel>

    <asp:Panel ID="pnlCollEdit" runat="server" Width="100%">
    <table cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td class="ShowDetail" colspan="4" style="font-weight: normal; font-size: 12pt; text-align: center">
				COLLATERAL DATA EDITING</td>
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
					Dealer</td>
				<td class="RowStyle" colspan="3">
					<asp:TextBox ID="txtDealerID" runat="server" Width="311px" CssClass="required" 
						ReadOnly="True"></asp:TextBox>
					<input
						id="Button12" noenter onclick="DealerFind();" style="background-position: left;
						background-image: url(../images/search.gif); width: 45px; cursor: pointer; background-repeat: no-repeat;
						 text-align: right" type="button" value="Find" />
					<input
							id="Button13" onclick="DealerClear();" style="background-position: left;
							background-image: url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
					<asp:HiddenField ID="hidDealerID" runat="server" />
				</td>
			</tr>
		<tr>
				<td class="FooterStyle" >
					Product</td>
				<td class="RowStyle" colspan="3">
					<asp:DropDownList ID="ddlProductID" runat="server" 
						DataTextField="PRODUCTNAME" DataValueField="PRODUCTID" CssClass="required" Width="200px">
					</asp:DropDownList>
					<ajaxToolkit:CascadingDropDown ID="ajaxCCDProduct" runat="server" Category="PRODUCT" 
						Enabled="True" LoadingText="[Loading Product..]" PromptText="[SELECT PRODUCT]" 
						ServiceMethod="GetDropDownProduct" TargetControlID="ddlProductID" 
						ServicePath="~\Param\WebService.asmx">
					</ajaxToolkit:CascadingDropDown>
					<asp:RequiredFieldValidator ID="reqProduct" runat="server" 
						ControlToValidate="ddlProductID" Display="None" 
						ErrorMessage="PRODUCT must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
					<ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEProduct" 
						runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqProduct">
					</ajaxToolkit:ValidatorCalloutExtender>
				</td>
			</tr>
		<tr style="font-weight: bold">
			<td class="FooterStyle">
				Merk</td>
			<td class="FooterStyle">
					<asp:DropDownList ID="ddlMerkID" runat="server" CssClass="required" 
                        Width="200px">
					</asp:DropDownList>
					<ajaxToolkit:CascadingDropDown ID="ajaxCDDMerk" runat="server" Category="MERK" 
						LoadingText="[Loading Merk/Brand...]" PromptText="[SELECT MERK]" 
						ServiceMethod="GetDropDownMerkByProduct" ServicePath="~\Param\WebService.asmx" 
						TargetControlID="ddlMerkID" ParentControlID="ddlProductID">
					</ajaxToolkit:CascadingDropDown>
					<asp:RequiredFieldValidator ID="reqMerk" runat="server" 
						ControlToValidate="ddlMerkID" Display="None" 
						ErrorMessage="MERK must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
					<ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEMerk" runat="server" 
						HighlightCssClass="ErrHighLight" TargetControlID="reqMerk">
					</ajaxToolkit:ValidatorCalloutExtender>
			</td>
			<td class="FooterStyle">
				<span style="font-weight: normal">Model</span>
			</td>
			<td class="FooterStyle">
				<asp:DropDownList ID="ddlModelID" runat="server" CssClass="required" 
                    Width="200px">
				</asp:DropDownList><ajaxToolkit:CascadingDropDown ID="ajaxCDDModel" runat="server" Category="MODEL"
					LoadingText="[Loading Model...]" ParentControlID="ddlMerkID" PromptText="[SELECT MODEL]"
					ServiceMethod="GetDropDownModelByMerk" ServicePath="~\Param\WebService.asmx"
					TargetControlID="ddlModelID">
				</ajaxToolkit:CascadingDropDown>
				<asp:RequiredFieldValidator ID="reqModel" runat="server" ControlToValidate="ddlModelID"
					Display="None" ErrorMessage="MODEL must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
						ID="ajaxVCEModel" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqModel">
					</ajaxToolkit:ValidatorCalloutExtender>
			</td>
		</tr>
		<tr>
				<td >
					Type</td>
				<td class="RowStyle">
					<asp:DropDownList ID="ddlType" runat="server" CssClass="required" Width="200px">
					</asp:DropDownList>
					<ajaxToolkit:CascadingDropDown ID="ajaxCCDType" runat="server" 
						Category="TYPE" LoadingText="[Loading Object Type...]" ParentControlID="ddlModelID" 
						PromptText="[SELECT OBJECT TYPE]" ServiceMethod="GetDropDownObjecTypeByModel" 
						ServicePath="~\Param\WebService.asmx" TargetControlID="ddlType" >
					</ajaxToolkit:CascadingDropDown>
					<asp:RequiredFieldValidator ID="reqType" runat="server" 
						ControlToValidate="ddlType" Display="None" 
						ErrorMessage="TYPE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
					<ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEType" 
						runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqType">
					</ajaxToolkit:ValidatorCalloutExtender>
				</td>
                <td>
				CC</td>
			    <td>
                    
                    <asp:TextBox ID="txtCC" runat="server" CssClass="required" MaxLength="6" 
                        Width="75px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqCC" runat="server" ControlToValidate="txtCC" 
                        Display="None" ErrorMessage="[CC] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqCC_ValidatorCalloutExtender" 
                        runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCC">
                    </ajaxToolkit:ValidatorCalloutExtender>
                    
                </td>
			</tr>
		<tr >
			<td>
				Kind</td>
			<td>
					<asp:DropDownList ID="ddlKind" runat="server" CssClass="required" 
                        DataTextField="CATEGORYNAME" DataValueField="CATEGORYID" 
                        style="margin-bottom: 0px" Width="200px">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCCDObjCategory" runat="server" 
                        Category="ObjCategory" Enabled="True" LoadingText="[Loading Object Category]" 
                        ParentControlID="ddlType" ServiceMethod="GetDropDownObjCategoryByObjectType" 
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlKind">
                    </ajaxToolkit:CascadingDropDown>
					<asp:RequiredFieldValidator ID="reqKind" runat="server" 
						ControlToValidate="ddlKind" Display="None" 
						ErrorMessage="[KIND] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
					<ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEKind" runat="server" 
						HighlightCssClass="ErrHighLight" TargetControlID="reqKind">
					</ajaxToolkit:ValidatorCalloutExtender>
			</td>
			<td>
				Purpose</td>
			<td>
					<asp:DropDownList ID="ddlPurpose" runat="server" CssClass="required" 
                        DataTextField="PURPOSENAME" DataValueField="PURPOSEID" Width="200px">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCCDObjPurpose" runat="server" 
                        Category="ObjPurpose" Enabled="True" LoadingText="[Loading Object Purpose]" 
                        ParentControlID="ddlProductID" PromptText="[SELECT PURPOSE]" 
                        ServiceMethod="GetDropDownObjPurposeByProduct" 
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlPurpose">
                    </ajaxToolkit:CascadingDropDown>
					<asp:RequiredFieldValidator ID="reqPurpose" runat="server" 
						ControlToValidate="ddlPurpose" Display="None" 
						ErrorMessage="[PURPOSE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
					<ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPurpose" runat="server" 
						HighlightCssClass="ErrHighLight" TargetControlID="reqPurpose">
					</ajaxToolkit:ValidatorCalloutExtender>
			</td>
		</tr>
		<tr>
            <td>
                Condition</td>
            <td colspan="3">
                <asp:DropDownList ID="ddlCondition" runat="server" CssClass="required" 
                    DataSourceID="sdsCondition" DataTextField="NAME" DataValueField="CODE">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsCondition" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    SelectCommand="SELECT NULL AS CODE, '[CONDITION]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'CONDITION')">
                </asp:SqlDataSource>
                <asp:RequiredFieldValidator ID="reqCondition" runat="server" 
                    ControlToValidate="ddlCondition" Display="None" 
                    ErrorMessage="[CONDITION] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECondition" runat="server" 
                    HighlightCssClass="ErrHighLight" TargetControlID="reqCondition">
                </ajaxToolkit:ValidatorCalloutExtender>
            </td>
        </tr>
		<tr>
			<td class="ShowDetail">
				Document Info</td>
			<td colspan="3">
				<hr />
			</td>
		</tr>
		<tr >
            <td class="ErrHighLight" style="">
                BPKB&nbsp; No</td>
            <td class="ErrHighLight">
                <asp:TextBox ID="txtBPKBNo" runat="server" CssClass="required" MaxLength="30" 
                    Width="92px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqBPKBNo" runat="server" 
                    ControlToValidate="txtBPKBNo" Display="None" 
                    ErrorMessage="[BPKB No.] must be entry...!" SetFocusOnError="True" 
                    Enabled="False"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEBPKBNo" runat="server" Enabled="True" 
                    HighlightCssClass="ErrHighLight" TargetControlID="reqBPKBNo">
                </ajaxToolkit:ValidatorCalloutExtender>
            </td>
            <td class="ErrHighLight" style="">
                BPKB Date</td>
            <td class="ErrHighLight">
                <asp:TextBox ID="txtBPKBDate" runat="server" CssClass="required" MaxLength="10" 
                    Width="72px"></asp:TextBox>
                <asp:Image ID="imgBPKBDate" runat="server" ImageUrl="~/images/grid.gif" 
                    Style="cursor: pointer" ToolTip="Calendar" />
                <asp:RequiredFieldValidator ID="reqBPKBDate" runat="server" 
                    ControlToValidate="txtBPKBDate" Display="None" 
                    ErrorMessage="[BPKB DATE] must be entry...!" SetFocusOnError="True" 
                    Enabled="False"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEBPKBDate" runat="server" 
                    HighlightCssClass="ErrHighLight" TargetControlID="reqBPKBDate">
                </ajaxToolkit:ValidatorCalloutExtender>
                <ajaxToolkit:CalendarExtender ID="ajaxCEBPKBDate" runat="server" Format="dd/MM/yyyy" 
                    PopupButtonID="imgBPKBDate" TargetControlID="txtBPKBDate">
                </ajaxToolkit:CalendarExtender>
                <ajaxToolkit:MaskedEditExtender ID="ajaxMEEBPKBDate" runat="server" Mask="99/99/9999" 
                    MaskType="Date" TargetControlID="txtBPKBDate">
                </ajaxToolkit:MaskedEditExtender>
            </td>
        </tr>
		<tr>
			<td class="ErrHighLight">
				BPKB Name</td>
			<td class="ErrHighLight">
				<asp:TextBox ID="txtBPKBName" runat="server" CssClass="required" MaxLength="60" Width="257px"></asp:TextBox>
                <asp:RequiredFieldValidator
					ID="reqBPKBName" runat="server" ControlToValidate="txtBPKBName" Display="None"
					ErrorMessage="[BPKB Name] must be entry...!" SetFocusOnError="True" Enabled="False"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
						ID="ajaxVCEBPKBAddress" runat="server" Enabled="True" HighlightCssClass="ErrHighLight"
						TargetControlID="reqBPKBName">
					</ajaxToolkit:ValidatorCalloutExtender>
			</td>
			<td class="ErrHighLight">
				BPKB Owner ID</td>
			<td class="ErrHighLight">
				<asp:TextBox ID="txtBPKBOwnerID" runat="server" CssClass="required" MaxLength="30"
					Width="200px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqBPKBOwnerID" runat="server"
						ControlToValidate="txtBPKBOwnerID" Display="None" ErrorMessage="[BPKB Owner ID] must be entry...!"
						SetFocusOnError="True" Enabled="False"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
							ID="ajaxVCEBPKBOwnerID" runat="server" Enabled="True" HighlightCssClass="ErrHighLight"
							TargetControlID="reqBPKBOwnerID">
						</ajaxToolkit:ValidatorCalloutExtender>
			</td>
		</tr>
		<tr>
			<td>
				BPKB Address</td>
			<td colspan="3">
				<asp:TextBox ID="txtBPKBAddress" runat="server" CssClass="required" MaxLength="80"
					Width="445px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqBPKBAddress" runat="server"
						ControlToValidate="txtBPKBAddress" Display="None" ErrorMessage="[BPKB Address] must be entry...!"
						SetFocusOnError="True" Enabled="False"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
							ID="ValidatorCalloutExtender3" runat="server" Enabled="True" HighlightCssClass="ErrHighLight"
							TargetControlID="reqBPKBNo">
						</ajaxToolkit:ValidatorCalloutExtender>
			</td>
		</tr>
		<tr>
			<td>
				BPKB City</td>
			<td>
				<asp:TextBox ID="txtBPKBCityName" runat="server" CssClass="required" ReadOnly="True"
					Width="208px"></asp:TextBox><input id="btnCityBirthFind" noenter="" onclick="CityFind(1);"
						style="background-position: left; background-image: url(../images/search.gif);
						width: 45px; cursor: pointer; background-repeat: no-repeat; 
						text-align: right" type="button" value="Find" /><input id="btnCityBirthClear" noenter=""
							onclick="CityClear(1);" style="background-position: left; background-image: url(../images/clear.png);
							width: 45px; cursor: pointer; background-repeat: no-repeat; 
							text-align: right" type="button" value="Clear" /><asp:HiddenField ID="txtBPKBCity"
								runat="server" />
				<asp:RequiredFieldValidator ID="reqBPKBCity" runat="server" ControlToValidate="txtBPKBCityName"
					Display="None" ErrorMessage="[BPKB CITY] must be entry...!" SetFocusOnError="True" 
                    Enabled="False"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
						ID="ajaxVCEBPKBCity" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBPKBCity">
					</ajaxToolkit:ValidatorCalloutExtender>
			</td>
			<td>
				Police No</td>
			<td>
				<asp:TextBox ID="txtPoliceNo" runat="server" CssClass="required" MaxLength="20" Width="92px"></asp:TextBox>
                <asp:RequiredFieldValidator
					ID="reqPoliceNo" runat="server" ControlToValidate="txtPoliceNo" Display="None"
					ErrorMessage="[POLICE No.] must be entry...!" SetFocusOnError="True" Enabled="False"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
						ID="ajaxVCEPoliceNo" runat="server" Enabled="True" HighlightCssClass="ErrHighLight"
						TargetControlID="reqPoliceNo">
					</ajaxToolkit:ValidatorCalloutExtender>
			</td>
		</tr>
		<tr>
			<td>
				BPKB Car Type</td>
			<td>
				<asp:TextBox ID="txtBPKBCarType" runat="server" CssClass="required" MaxLength="50"
					Width="257px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqBPKBCarType" runat="server"
						ControlToValidate="txtBPKBCarType" Display="None" ErrorMessage="[Object Type/BPKB CAR TYPE] must be entry...!"
						SetFocusOnError="True" Enabled="False"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender
							ID="ajaxVCEBPKBCarType0" runat="server" Enabled="True" HighlightCssClass="ErrHighLight"
							TargetControlID="reqBPKBCarType">
						</ajaxToolkit:ValidatorCalloutExtender>
			</td>
			<td>
				STNK Expire</td>
			<td>
				<asp:TextBox ID="txtSTNKExpire" runat="server" CssClass="required" MaxLength="10"
					Width="72px"></asp:TextBox><asp:Image ID="imgSTNKExpire" runat="server" ImageUrl="~/images/grid.gif"
						Style="cursor: pointer" ToolTip="Calendar" />
                <asp:RequiredFieldValidator ID="reqSTNKExpire"
							runat="server" ControlToValidate="txtSTNKExpire" Display="None" ErrorMessage="[STNK EXPIRED DATE] must be entry...!"
							SetFocusOnError="True" Enabled="False"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
								ID="ajaxVCESTNKExpire" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqSTNKExpire">
							</ajaxToolkit:ValidatorCalloutExtender>
				<ajaxToolkit:CalendarExtender ID="ajaxCESTNKExpire" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgSTNKExpire"
					TargetControlID="txtSTNKExpire">
				</ajaxToolkit:CalendarExtender>
				<ajaxToolkit:MaskedEditExtender ID="ajaxMEESTNKExpire" runat="server" Mask="99/99/9999" MaskType="Date"
					TargetControlID="txtSTNKExpire">
				</ajaxToolkit:MaskedEditExtender>
			</td>
		</tr>
		<tr>
			<td>
				Engine No</td>
			<td>
				<asp:TextBox ID="txtEngineNo" runat="server" CssClass="required" MaxLength="50" Width="257px"></asp:TextBox><asp:RequiredFieldValidator
					ID="reqEngineNo" runat="server" ControlToValidate="txtEngineNo" Display="None"
					ErrorMessage="[ENGINE NO] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
						ID="ajaxVCEEngineNo" runat="server" Enabled="True" HighlightCssClass="ErrHighLight"
						TargetControlID="reqEngineNo">
					</ajaxToolkit:ValidatorCalloutExtender>
			</td>
			<td>
				Chasis No</td>
			<td>
				<asp:TextBox ID="txtChasisNo" runat="server" CssClass="required" MaxLength="50" 
                    Width="200px"></asp:TextBox><asp:RequiredFieldValidator
					ID="reqChasisNo" runat="server" ControlToValidate="txtChasisNo" Display="None"
					ErrorMessage="[CHASIS NO] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
						ID="ajaxVCEChasisNo" runat="server" Enabled="True" HighlightCssClass="ErrHighLight"
						TargetControlID="reqChasisNo">
					</ajaxToolkit:ValidatorCalloutExtender>
			</td>
		</tr>
		<tr>
			<td>
				Car Year</td>
			<td>
				<asp:TextBox ID="txtCarYear" runat="server" CssClass="required" Style="text-align: right"
					Width="54px"></asp:TextBox><asp:RequiredFieldValidator ID="reqCarYear" runat="server"
						ControlToValidate="txtCarYear" Display="None" ErrorMessage="[CAR YEAR] must be entry...!"
						SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
							ID="ajaxVCECarYear" runat="server" Enabled="True" HighlightCssClass="ErrHighLight"
							TargetControlID="reqCarYear">
						</ajaxToolkit:ValidatorCalloutExtender>
			</td>
			<td>
				Build Year</td>
			<td>
				<asp:TextBox ID="txtBuildYear" runat="server" CssClass="required" Style="text-align: right"
					Width="49px"></asp:TextBox><asp:RequiredFieldValidator ID="reqBuildYear" runat="server"
						ControlToValidate="txtBuildYear" Display="None" ErrorMessage="[BUILD YEAR] must be entry...!"
						SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
							ID="ajaxVCEBuildYear" runat="server" Enabled="True" HighlightCssClass="ErrHighLight"
							TargetControlID="reqBuildYear">
						</ajaxToolkit:ValidatorCalloutExtender>
			</td>
		</tr>
		<tr>
			<td>
				Color</td>
			<td>
				<asp:TextBox ID="txtColor" runat="server" CssClass="required" MaxLength="60" 
                    Width="200px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqColor" runat="server" 
                    ControlToValidate="txtColor" Display="None" 
                    ErrorMessage="[COLOR] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEColor" runat="server" Enabled="True" 
                    HighlightCssClass="ErrHighLight" TargetControlID="reqColor">
                </ajaxToolkit:ValidatorCalloutExtender>
			</td>
			<td>
				Collateral Value</td>
			<td>
				<asp:TextBox ID="txtCollateralValue" runat="server"></asp:TextBox>
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
                <asp:TextBox ID="txtNoFaktur" runat="server" CssClass="required" MaxLength="60" 
                    Width="100px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqNoFaktur" runat="server" 
                    ControlToValidate="txtNoFaktur" Display="None" 
                    ErrorMessage="[NO FAKTUR] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender ID="reqNoFaktur_ValidatorCalloutExtender" 
                    runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqNoFaktur">
                </ajaxToolkit:ValidatorCalloutExtender>
            </td>
            <td>
                Faktur Name</td>
            <td>
                <asp:TextBox ID="txtNmFaktur" runat="server" CssClass="required" MaxLength="60" 
                    Width="200px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqNmFaktur" runat="server" 
                    ControlToValidate="txtNmFaktur" Display="None" 
                    ErrorMessage="[NAMA FAKTUR] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender ID="reqNmFaktur_ValidatorCalloutExtender" 
                    runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqNmFaktur">
                </ajaxToolkit:ValidatorCalloutExtender>
            </td>
        </tr>
		<tr>
			<td style="height: 26px">
				Survey Date</td>
			<td style="height: 26px" colspan="3">
				<asp:TextBox ID="txtSurveyDate" runat="server" CssClass="required" MaxLength="10"
					Width="72px"></asp:TextBox><asp:Image
					ID="imgSurveyDate" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer"
					ToolTip="Calendar" /><asp:RequiredFieldValidator ID="reqSurveyDate"
							runat="server" ControlToValidate="txtSurveyDate" Display="None" ErrorMessage="[SURVEY DATE] must be entry...!"
							SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
						ID="ajaxVCESurveyDate" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqSurveyDate">
							</ajaxToolkit:ValidatorCalloutExtender>
				<ajaxToolkit:CalendarExtender ID="ajaxCESurveyDate" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgSurveyDate"
					TargetControlID="txtSurveyDate">
				</ajaxToolkit:CalendarExtender>
				<ajaxToolkit:MaskedEditExtender ID="ajaxMEESurveyDate" runat="server" Mask="99/99/9999" MaskType="Date"
					TargetControlID="txtSurveyDate">
				</ajaxToolkit:MaskedEditExtender>
			</td>
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
                Route/Trayek</td>
            <td colspan="3">
                <asp:TextBox ID="txtRoute" runat="server" CssClass="required" ReadOnly="True" 
                    Width="311px"></asp:TextBox>
                <input
						id="btnRouteFind" noenter onclick="RouteFind();" style="background-position: left;
						background-image: url(../images/search.gif); width: 45px; cursor: pointer; background-repeat: no-repeat;
						 text-align: right" type="button" value="Find" />
                <input
							id="btnRouteClear" onclick="RouteClear();" style="background-position: left;
							background-image: url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
                <asp:HiddenField ID="hidRoute" runat="server" />
                <asp:RequiredFieldValidator ID="reqRoute" runat="server" 
                    ControlToValidate="txtRoute" Display="None" 
                    ErrorMessage="[ROUTE/TRAYEK] must be entry...!" SetFocusOnError="True" 
                    Enabled="False"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender ID="reqRoute_ValidatorCalloutExtender" 
                    runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqRoute">
                </ajaxToolkit:ValidatorCalloutExtender>
            </td>
        </tr>
		<tr class="RowStyle">
			<td>KP Expired</td>
			<td >
			    <asp:TextBox ID="txtKPExpiredDate" runat="server" CssClass="required" 
                    MaxLength="10" Width="72px"></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="txtKPExpiredDate_CalendarExtender" runat="server" 
                    Format="dd/MM/yyyy" PopupButtonID="imgKPExpiredDate" 
                    TargetControlID="txtKPExpiredDate">
                </ajaxToolkit:CalendarExtender>
                <ajaxToolkit:MaskedEditExtender ID="txtKPExpiredDate_MaskedEditExtender" runat="server" 
                    Mask="99/99/9999" MaskType="Date" TargetControlID="txtKPExpiredDate">
                </ajaxToolkit:MaskedEditExtender>
                <asp:Image ID="imgKPExpiredDate" runat="server" ImageUrl="~/images/grid.gif" 
                    Style="cursor: pointer" ToolTip="Calendar" />
                <asp:RequiredFieldValidator ID="reqKPExpired" runat="server" 
                    ControlToValidate="txtKPExpiredDate" Display="None" 
                    ErrorMessage="[KP Expired] must be entry...!" SetFocusOnError="True" 
                    Enabled="False"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender ID="reqKPExpired_ValidatorCalloutExtender" 
                    runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqKPExpired">
                </ajaxToolkit:ValidatorCalloutExtender>
			</td>
            <td >
			    SK Expired</td>
            <td >
			    <asp:TextBox ID="txtSKExpiredDate" runat="server" CssClass="required" 
                    MaxLength="10" Width="72px"></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="txtSKExpiredDate_CalendarExtender" runat="server" 
                    Format="dd/MM/yyyy" PopupButtonID="imgSKExpiredDate" 
                    TargetControlID="txtSKExpiredDate">
                </ajaxToolkit:CalendarExtender>
                <ajaxToolkit:MaskedEditExtender ID="txtSKExpiredDate_MaskedEditExtender" runat="server" 
                    Mask="99/99/9999" MaskType="Date" TargetControlID="txtSKExpiredDate">
                </ajaxToolkit:MaskedEditExtender>
                <asp:Image ID="imgSKExpiredDate" runat="server" ImageUrl="~/images/grid.gif" 
                    Style="cursor: pointer" ToolTip="Calendar" />
                <asp:RequiredFieldValidator ID="reqSKExpiredDate" runat="server" 
                    ControlToValidate="txtSKExpiredDate" Display="None" 
                    ErrorMessage="[SK Expired] must be entry...!" SetFocusOnError="True" 
                    Enabled="False"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender ID="reqSKExpiredDate_ValidatorCalloutExtender" 
                    runat="server" HighlightCssClass="ErrHighLight" 
                    TargetControlID="reqSKExpiredDate">
                </ajaxToolkit:ValidatorCalloutExtender>
			</td>
		</tr>

		<tr>
			<td class="ShowDetail">
					BI Info</td>
			<td colspan="3">
					<hr />
			</td>
		</tr>
		<tr class="RowStyle">
            <td>
                Binding Type
                <asp:Label ID="Label129" runat="server" CssClass="ErrHighLight" 
                    style="background-color: #FFCC00" Text="(Jenis Pengikatan)"></asp:Label>
            </td>
            <td colspan="3">
                <asp:DropDownList ID="ddlBindType" runat="server" CssClass="required" 
                    DataSourceID="sdsBindType" DataTextField="BTNAME" DataValueField="BINDTYPEID">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="reqBindType" runat="server" 
                    ControlToValidate="ddlBindType" Display="None" 
                    ErrorMessage="[BINDING TYPE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEBindType" runat="server" 
                    Enabled="True" HighlightCssClass="ErrHighLight" TargetControlID="reqBindType">
                </ajaxToolkit:ValidatorCalloutExtender>
                <asp:SqlDataSource ID="sdsBindType" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    
                    SelectCommand="SELECT NULL AS BINDTYPEID, NULL AS BTCODE, '[BINDING TYPE]' AS BTNAME UNION ALL SELECT BINDTYPEID, BTCODE, BTCODE + ' - ' + BTNAME AS BTNAME FROM BINDTYPE WITH (NOLOCK) WHERE (DELETESTS = 0) ORDER BY BTCODE">
                </asp:SqlDataSource>
            </td>
        </tr>
		<tr class="AlternatingRowStyle">
			<td>
				Collateral Type<br />
					<asp:Label ID="Label2" runat="server" CssClass="ErrHighLight" 
						Text="(Jenis Agunan)" style="background-color: #FFCC00"></asp:Label></td>
			<td colspan="3">
					<asp:DropDownList ID="ddlCollType" runat="server" CssClass="required" DataSourceID="sdsCollType"
						DataTextField="CTNAME" DataValueField="COLLATERALTYPEID">
					</asp:DropDownList>
					<asp:RequiredFieldValidator ID="reqCollType" runat="server" ControlToValidate="ddlCollType"
						Display="None" ErrorMessage="[COLLATERAL TYPE] must be entry...!" SetFocusOnError="True"
						Width="87px"></asp:RequiredFieldValidator>
					<ajaxToolkit:ValidatorCalloutExtender
							ID="ajaxVCECollType" runat="server" Enabled="True" HighlightCssClass="ErrHighLight"
							TargetControlID="reqCollType">
						</ajaxToolkit:ValidatorCalloutExtender>
					<asp:SqlDataSource ID="sdsCollType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
					
                        SelectCommand="SELECT NULL AS COLLATERALTYPEID, NULL AS CTCODE, '[COLLATERAL TYPE]' AS CTNAME UNION ALL SELECT COLLATERALTYPEID, CTCODE, CTCODE + ' - ' + CTNAME AS CTNAME FROM COLLATERALTYPE WITH (NOLOCK) WHERE (DELETESTS = 0) ORDER BY CTCODE">
					</asp:SqlDataSource>
			</td>
		</tr>
		<tr class="RowStyle">
			<td>
				SB Rank<br />
				<span style="background-color: #FFCC00">(Peringkat SB)</span></td>
			<td colspan="3">
				<asp:DropDownList ID="ddlSBRank" runat="server" DataSourceID="sdsSBRank" DataTextField="SBRANKNAME"
					DataValueField="SBRANKID">
				</asp:DropDownList><asp:SqlDataSource ID="sdsSBRank" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
					
                    SelectCommand="SELECT NULL AS SBRANKID, NULL AS SBRANKCODE, '[SB RANK]' AS SBRANKNAME UNION ALL SELECT SBRANKID, SBRANKCODE, SBRANKCODE + ' - ' + SBRANKNAME AS SBRANKNAME FROM SBRANK WITH (NOLOCK) WHERE (DELETESTS = 0) ORDER BY SBRANKCODE">
				</asp:SqlDataSource>
			</td>
		</tr>
	</table>
    </asp:Panel>
   
	<br />
	<asp:HiddenField ID="hidLocID" runat="server" />
	<asp:HiddenField ID="hidAccID" runat="server" />
	<asp:HiddenField ID="hidObjID" runat="server" />
	<asp:HiddenField ID="hidAction" runat="server" />
	<asp:HiddenField ID="hidAppID" runat="server" />
	    <br />
	<br />
	<br />
	<ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEProcess" runat="server" TargetControlID="pnlProcess"
		VerticalSide="Bottom">
	</ajaxToolkit:AlwaysVisibleControlExtender>
	<asp:Panel ID="pnlProcess" runat="server" CssClass="ShowDetail" Width="100%">
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
		<asp:Button ID="btnSave" runat="server" Style="background-position: right; background-image: url(../Images/Save.gif);
			cursor: pointer; background-repeat: no-repeat;  text-align: left"
			Text="Save" Width="88px" />
		<asp:Button ID="btnCancel" runat="server" CausesValidation="False" OnClientClick="return Back();"
			Style="background-position: right; background-image: url(../Images/back.png);
			cursor: pointer; background-repeat: no-repeat;  text-align: left"
			Text="Back" Width="88px" /></asp:Panel>
<script src="../include/JQuery.js" type="text/javascript"></script>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=GvBorrowDoc.ClientID%>");
function CityFind(xFind) {
	iFind=xFind;
	var winref = window.open("../Param/CitySearch.aspx?Action=Find", "CityFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
	winref.focus();
}
var oForm = document.getElementById ? document.getElementById("<%=Form.ClientID%>") : document.forms["<%=Form.ClientID%>"]; 
function getObjectbyClientID(ClientID){
	var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
	return(oObject)
}

function getObjectbyClientID(ClientID){
	var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
	return(oObject)
}

function SetValueTxtByClientID(ClientID, sValue){
	var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
	if (oText)
		oText.value = sValue;
}

function GetValueTxtByClientID(ClientID){
	var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
	if (oText)
		return(oText.value);
}

function SetCity(CityID, City){
	if (iFind=="1") {
		SetValueTxtByClientID("<%=txtBPKBCity.ClientID%>", CityID);
		SetValueTxtByClientID("<%=txtBPKBCityName.ClientID%>", City);
		if (GetValueTxtByClientID("<%=txtBPKBCity.ClientID%>")==""){
			SetValueTxtByClientID("<%=txtBPKBCity.ClientID%>", CityID);
			SetValueTxtByClientID("<%=txtBPKBCityName.ClientID%>", City);
		}
	}       
}

function CityClear(iFind){
	if(iFind=="1"){
		SetValueTxtByClientID("<%=txtBPKBCity.ClientID%>", "");
		SetValueTxtByClientID("<%=txtBPKBCityName.ClientID%>", "");
	}
}

    function getNeedRoute() {
        var PurposeID = GetValueTxtByClientID("<%=ddlPurpose.ClientID%>");
        if (PurposeID == "")
            PurposeID = "0"; //supaya getneedroute di eksekusi terus

        if (PurposeID != "") {
            ret = GHWService.ObjectPurposeNeedRoute(PurposeID, OnCompleteNeedRoute, OnTimeOutNeedRoute, OnErrorNeedRoute);
        }
    }
    function OnCompleteNeedRoute(arg) {
        var oRouteName = getObjectbyClientID("<%=txtRoute.ClientID%>");
        var oRouteID = getObjectbyClientID("<%=hidRoute.ClientID%>");
        var oFind = getObjectbyClientID("btnRouteFind");
        var oClear = getObjectbyClientID("btnRouteClear");
        var oKPExpiredDate = getObjectbyClientID("<%=txtKPExpiredDate.ClientID%>");
        var oimgKPExpiredDate = getObjectbyClientID("<%=imgKPExpiredDate.ClientID%>");
        var oSKExpiredDate = getObjectbyClientID("<%=txtSKExpiredDate.ClientID%>");
        var oimgSKExpiredDate = getObjectbyClientID("<%=imgSKExpiredDate.ClientID%>");
        if (arg == "0") {
            oRouteName.className = "disabled";
            ValidatorEnable(getObjectbyClientID("<%=reqRoute.ClientID%>"), false);
            oRouteName.value = "";
            oRouteID.value = "";
            oFind.style.display = "none";
            oClear.style.display = "none";

            oKPExpiredDate.className="disabled";
            ValidatorEnable(getObjectbyClientID("<%=reqKPExpired.ClientID%>"), false);
            oimgKPExpiredDate.style.display="none";

            oSKExpiredDate.className="disabled";
            ValidatorEnable(getObjectbyClientID("<%=reqSKExpiredDate.ClientID%>"), false);
            oimgSKExpiredDate.style.display="none";
        }
        else if (arg=="1") {
            oRouteName.className = "required";
            ValidatorEnable(getObjectbyClientID("<%=reqRoute.ClientID%>"), true);
            oFind.style.display = "";
            oClear.style.display = "";
            oKPExpiredDate.className="required";
            ValidatorEnable(getObjectbyClientID("<%=reqKPExpired.ClientID%>"), true);
            oimgKPExpiredDate.style.display="";

            oSKExpiredDate.className="required";
            ValidatorEnable(getObjectbyClientID("<%=reqSKExpiredDate.ClientID%>"), true);
            oimgSKExpiredDate.style.display="";
        }
        else{
             oRouteName.className = "RowStyle";
            oFind.style.display = "";
            oClear.style.display = "";
            ValidatorEnable(getObjectbyClientID("<%=reqRoute.ClientID%>"), false);

            oKPExpiredDate.className = "RowStyle";
            oimgKPExpiredDate.style.display="";
            ValidatorEnable(getObjectbyClientID("<%=reqKPExpired.ClientID%>"), false);
            
            oSKExpiredDate.className = "RowStyle";
            oimgSKExpiredDate.style.display="";
            ValidatorEnable(getObjectbyClientID("<%=reqSKExpiredDate.ClientID%>"), false);
        }
    }
    function OnTimeOutNeedRoute(arg) {alert("TimeOut encountered when calling getNeedRoute.");}
    function OnErrorNeedRoute(arg) {alert("Error encountered when calling getNeedRoute.");}

function DealerFind() {
	WinRef = window.open("../Param/DealerFind.aspx?Action=Find", "DealerFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
	WinRef.focus();
}

function SetDealer(DealerID, Dealer) {
	SetValueTxtByClientID("<%=hidDealerID.ClientID%>", DealerID);
	SetValueTxtByClientID("<%=txtDealerID.ClientID%>", Dealer);
}
function DealerClear() {
	SetValueTxtByClientID("<%=hidDealerID.ClientID%>", "");
	SetValueTxtByClientID("<%=txtDealerID.ClientID%>", "");
}

function RouteFind() {
	WinRef = window.open("../Param/RouteFind.aspx?Action=Find", "RouteFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
	WinRef.focus();
}

function SetRoute(RouteID, Route) {
	SetValueTxtByClientID("<%=hidRoute.ClientID%>", RouteID);
	SetValueTxtByClientID("<%=txtRoute.ClientID%>", Route);
}
function RouteClear() {
	SetValueTxtByClientID("<%=hidRoute.ClientID%>", "");
	SetValueTxtByClientID("<%=txtRoute.ClientID%>", "");
}

    function Back(){
	    //window.history.back(-1);
        if (GetValueTxtByClientID("<%=hidAction.ClientID%>") == "EDIT") {
            window.location = "AccDocEditList.aspx?Action=EDIT"
        } else {
            window.history.back(-1);
        }
	    return false;
    }
    function Load() {
        ConditionChange();
        getNeedRoute();
    }

    window.onload = function () {
        if (GetValueTxtByClientID("<%=hidAction.ClientID%>") == "EDIT") {
            Load();
            TabToEnter();
        }
    }

    function PrintData() {
        var LOCID = GetValueTxtByClientID("<%=hidLocID.ClientID%>");
        var OBJID = GetValueTxtByClientID("<%=hidObjID.ClientID%>");

        var winref = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/CollateralData&LOCID=" + LOCID + "&OBJID=" + OBJID, "PrintCustomer", "height=450,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
        winref.focus();
        return false;
    }
   function getCC() {
        var Model = GetValueTxtByClientID("<%=ddlModelID.ClientID%>");
        var Type = GetValueTxtByClientID("<%=ddlType.ClientID%>");
        if (Type != "") {
            ret = GHWService.GetCC(Model ,Type , OnCompletegetCC, OnTimeOutgetCC, OnErrorgetCC);
        }
    }
    function OnCompletegetCC(arg) {
        var oCC = getObjectbyClientID("<%=txtCC.ClientID%>");
        oCC.value=arg;

    }
    function OnTimeOutgetCC(arg) {alert("TimeOut encountered when calling getCC.");}
    function OnErrorgetCC(arg) { alert("Error encountered when calling getCC."); }

    function ConditionChange() {
        ValidateCondition(false);
        RemoveRequired(getObjectbyClientID("<%=txtBPKBNo.ClientID%>"));
        RemoveRequired(getObjectbyClientID("<%=txtBPKBName.ClientID%>"));
        RemoveRequired(getObjectbyClientID("<%=txtBPKBCityName.ClientID%>"));
        RemoveRequired(getObjectbyClientID("<%=txtBPKBAddress.ClientID%>"));
        RemoveRequired(getObjectbyClientID("<%=txtBPKBOwnerID.ClientID%>"));
        RemoveRequired(getObjectbyClientID("<%=txtBPKBCarType.ClientID%>"));
        RemoveRequired(getObjectbyClientID("<%=txtBPKBDate.ClientID%>"));
        RemoveRequired(getObjectbyClientID("<%=txtPoliceNo.ClientID%>"));
        RemoveRequired(getObjectbyClientID("<%=txtSTNKExpire.ClientID%>"));

        if ($("#<%=ddlCondition.ClientID%>").val() == "2") {
            ValidateCondition(true);
            AddRequired(getObjectbyClientID("<%=txtBPKBNo.ClientID%>"));
            AddRequired(getObjectbyClientID("<%=txtBPKBName.ClientID%>"));
            AddRequired(getObjectbyClientID("<%=txtBPKBCityName.ClientID%>"));
            AddRequired(getObjectbyClientID("<%=txtBPKBAddress.ClientID%>"));
            AddRequired(getObjectbyClientID("<%=txtBPKBOwnerID.ClientID%>"));
            AddRequired(getObjectbyClientID("<%=txtBPKBCarType.ClientID%>"));
            AddRequired(getObjectbyClientID("<%=txtBPKBDate.ClientID%>"));
            AddRequired(getObjectbyClientID("<%=txtPoliceNo.ClientID%>"));
            AddRequired(getObjectbyClientID("<%=txtSTNKExpire.ClientID%>"));
        }
    }
    function ValidateCondition(bValid) {
        ValidatorEnable(getObjectbyClientID("<%=reqBPKBNo.ClientID%>"), bValid);
        ValidatorEnable(getObjectbyClientID("<%=reqBPKBName.ClientID%>"), bValid);
        ValidatorEnable(getObjectbyClientID("<%=reqBPKBCity.ClientID%>"), bValid);
        ValidatorEnable(getObjectbyClientID("<%=reqBPKBAddress.ClientID%>"), bValid);
        ValidatorEnable(getObjectbyClientID("<%=reqBPKBOwnerID.ClientID%>"), bValid);
        ValidatorEnable(getObjectbyClientID("<%=reqBPKBAddress.ClientID%>"), bValid);
        ValidatorEnable(getObjectbyClientID("<%=reqBPKBCarType.ClientID%>"), bValid);
        ValidatorEnable(getObjectbyClientID("<%=reqPoliceNo.ClientID%>"), bValid);
        ValidatorEnable(getObjectbyClientID("<%=reqSTNKExpire.ClientID%>"), bValid);

    }


    function RemoveRequired(o) {
        o.className = "";
    }

    function AddRequired(o) {
        o.className = "required";
    }
</script>

</asp:Content>

