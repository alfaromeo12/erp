<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="MktSurveyUpd.aspx.vb" Inherits="Tools_MktSurveyUpd" EnableEventValidation="false" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>

<%@ Register src="../UserControl/DataAccountFromParamAccID.ascx" tagname="DataAccountFromParamAccID" tagprefix="uc1" %>

<%@ Register src="../UserControl/CollateralDataFromAccID.ascx" tagname="CollateralDataFromAccID" tagprefix="uc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:MultiView ID="MultiView_Utama" runat="server"> 
   <asp:View ID="View_View" runat="server"> 
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Search Criteria...)</asp:Label>
        </div>
        <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Search Criteria...)" Enabled="True"
        ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Search Criteria...)"
        ImageControlID="imgButtonShow" TargetControlID="pnlData" TextLabelID="lblShow"></ajaxToolkit:CollapsiblePanelExtender>
    <asp:HiddenField ID="txtUID" runat="server" />
    <asp:HiddenField ID="txtAction" runat="server" />
    <asp:HiddenField ID="hidIsUserBranch" runat="server" />
       <asp:HiddenField ID="hidLocid" runat="server" />
       <asp:HiddenField ID="hidAccID" runat="server" />
       <asp:HiddenField ID="hidAppID" runat="server" />
       <asp:HiddenField ID="hidUPDATE" runat="server" />
    <asp:Panel ID="pnlData" runat="server" GroupingText="Search Criteria" Width="99%">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="ACCOUNT.ACCOUNTNO">Account No.</asp:ListItem>
        <asp:ListItem Value="ACCNOX">Account No. (Formated)</asp:ListItem>
        <asp:ListItem Value="ACCOUNT.ACCOUNTNAME">Account Name</asp:ListItem>
        <asp:ListItem Value="CUSTOMER.CUSTNO">Cust No.</asp:ListItem>
        <asp:ListItem Value="CUSTNOX">Cust No. (Formated)</asp:ListItem>
        <asp:ListItem Value="CUSTOMER.IDNUMBER">ID Number</asp:ListItem>
        <asp:ListItem Value="ACCOUNT.REFNO">Reference No.</asp:ListItem>
        <asp:ListItem Value="CUSTOMER.CUSTID">CUST ID</asp:ListItem>
        <asp:ListItem Value="ACCOUNTJF.ACCIDJF">ACC ID JF</asp:ListItem>
        <asp:ListItem Value="ACCOUNT.ACCID">ACC ID</asp:ListItem>
    </asp:DropDownList></td>
                <td colspan="3">
                    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset"
        Text="Search" CssClass="Search" />
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%"></ajaxToolkit:TextBoxWatermarkExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Booking Date</td>
                <td colspan="3">
                    <asp:RadioButton ID="rbBookAll" runat="server" GroupName="rbBook" Text="All" /><asp:RadioButton
                        ID="rbBookFrom" runat="server" GroupName="rbBook" Text="From" />
                    <asp:TextBox ID="txtBookFrom"
                            runat="server" Width="72px"></asp:TextBox><asp:Image
                        ID="imgBookFrom" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />&nbsp;
                    To
                    <asp:TextBox ID="txtBookTo" runat="server" Width="72px"></asp:TextBox><asp:Image ID="imgBookTo" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxCEBookFrom" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgBookFrom"
                        TargetControlID="txtBookFrom"></ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxCEBookTo" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgBookTo"
                        TargetControlID="txtBookTo"></ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEBookFrom" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtBookFrom"></ajaxToolkit:MaskedEditExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEBookTo" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtBookTo"></ajaxToolkit:MaskedEditExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Close Txn Date</td>
                <td colspan="3">
                    <asp:RadioButton ID="rbCloseAll" runat="server" GroupName="rbClose" Text="All" /><asp:RadioButton
                        ID="rbCloseFrom" runat="server" GroupName="rbClose" Text="From" />
                    <asp:TextBox ID="txtCloseFrom"
                            runat="server" Width="72px"></asp:TextBox><asp:Image
                        ID="imgCloseFrom" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />&nbsp;
                    To
                    <asp:TextBox ID="txtCloseTo" runat="server" Width="72px"></asp:TextBox><asp:Image ID="imgCloseTo" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxCECloseFrom" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgCloseFrom"
                        TargetControlID="txtCloseFrom"></ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxCECloseTo" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgCloseTo"
                        TargetControlID="txtCloseTo"></ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEECloseFrom" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtCloseFrom"></ajaxToolkit:MaskedEditExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEECloseTo" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtCloseTo"></ajaxToolkit:MaskedEditExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Area</td>
                <td>
                    <asp:DropDownList ID="ddlAreaSearch" runat="server">
                    </asp:DropDownList><ajaxToolkit:CascadingDropDown ID="ajaxCDDArea" runat="server" Category="AREA"
                        LoadingText="[Loading Area ...]" PromptText="[DISPLAY ALL]" ServiceMethod="GetDropDownArea"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlAreaSearch" BehaviorID="BehavArea"></ajaxToolkit:CascadingDropDown>
                </td>
                <td>
                    Branch</td>
                <td>
                    <asp:DropDownList ID="ddlBranchSearch" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDBranch" runat="server" Category="BRANCH"
                        LoadingText="[Loading Branch...]" PromptText="[DISPLAY ALL]" ServiceMethod="GetDropDownBranchByArea"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlBranchSearch" ParentControlID="ddlAreaSearch" BehaviorID="BehavBranch"></ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
            <tr>
                <td>
                    Finance Category</td>
                <td colspan="3" style="font-weight: 700">
                    <asp:DropDownList ID="ddlFinanceCategory" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCCDFincat" runat="server" 
                        BehaviorID="BehavFinCat" Category="FINCAT" 
                        LoadingText="[Loading Finance Category ...]" PromptText="[DISPLAY ALL]" 
                        ServiceMethod="GetDropDownFinCatbyAppUserBranch" 
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlFinanceCategory">
                    </ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
        </table>
    </asp:Panel>
     <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="LOCID,APPID,ACCID" DataSourceID="sdsGrid" Width="99%" Caption="Account List" RowHeaderColumn="ACCID">
            <Columns>
         
                 <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/edit.gif" 
                        ShowSelectButton="True">
                    <HeaderStyle CssClass="FooterStyle" />
                    <ItemStyle HorizontalAlign="Center" Width="30px" /></asp:CommandField>
                <asp:BoundField DataField="LOCID" HeaderText="Loc&lt;br&gt;ID" HtmlEncode="False"
                    SortExpression="LOCID" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="ACCID" HeaderText="Acc&lt;br&gt;ID" HtmlEncode="False"
                    SortExpression="ACCID" />
                <asp:BoundField DataField="ACCNO" HeaderText="Acc. No.&lt;br&gt;(Formated)" SortExpression="ACCNO" HtmlEncode="False" />
                <asp:BoundField DataField="BOOKINGDATE" HeaderText="Booking&lt;br&gt;Date" HtmlEncode="False"
                    SortExpression="BOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="ACCOUNTNAME" />
                <asp:BoundField DataField="BRANCH" HeaderText="Branch" ReadOnly="True" SortExpression="BRANCH" />
                <asp:BoundField DataField="CUSTNO" HeaderText="Cust. No.&lt;BR&gt;(Formated)" SortExpression="CUSTNO" HtmlEncode="False" />
                <asp:BoundField DataField="PRINCIPALTOTAL" HeaderText="Principal" HtmlEncode="False"
                    SortExpression="PRINCIPALTOTAL" DataFormatString="{0:n}" >
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
           
           
           SelectCommand="SELECT TOP (500) ACCOUNT.ACCOUNTNAME, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCH, CUSTOMER.CUSTID, CUSTOMER.IDNUMBER, ACCOUNT.BOOKINGDATE, ACCOUNT.REFNO, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCNO, dbo.f_FormatCustNo(BRANCH.BRANCHCODE, CUSTOMER.CUSTNO) AS CUSTNO, ACCOUNT.ACCSTATUS, ACCOUNT.PRINCIPALTOTAL, CUSTOMER.LOCIDCUST, ACCOUNT.LOCID, ACCOUNT.ACCID, ACCOUNT.APPID FROM ACCOUNT WITH (NOLOCK) INNER JOIN CUSTOMER WITH (NOLOCK) ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID INNER JOIN AREA WITH (NOLOCK) INNER JOIN BRANCH WITH (NOLOCK) ON AREA.AREAID = BRANCH.AREAID ON ACCOUNT.BRANCHID = BRANCH.BRANCHID WHERE (ACCOUNT.ACCSTATUS &lt;&gt; 0)"></asp:SqlDataSource>

   </asp:View>
     
    
   <asp:View ID="View_Form" runat="server"> 
   <asp:Panel ID="pnlAccShow" runat="server" CssClass="ShowDetail" Width="99%">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgAccData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblAccData" runat="server" CssClass="required">(Show Account Data...)</asp:Label>
		</div>
		<input id="Button1" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <asp:Panel ID="pnlAccData" runat="server" Width="100%">
	    <uc1:DataAccountFromParamAccID ID="ctlDataAccountFromParamAccID" 
            runat="server" />
	</asp:Panel>
	<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEAccData" runat="server" CollapseControlID="pnlAccShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Account Data...)" Enabled="True"
		ExpandControlID="pnlAccShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Account Data...)"
		ImageControlID="imgAccData" TargetControlID="pnlAccData" TextLabelID="lblAccData"></ajaxToolkit:CollapsiblePanelExtender>

        <asp:Panel ID="pnlCollateralShow" runat="server" CssClass="ShowDetail" 
        Width="99%">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgCollateral" runat="server" AlternateText="(Show Details...)" 
                ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblCollateral" runat="server" CssClass="required">(Show Collateral Data...)</asp:Label>
		</div>
		<input id="Button6" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
	<asp:Panel ID="pnlCollateral" runat="server" Width="100%">
        <uc2:CollateralDataFromAccID ID="ctlCollateralDataFromAccID" runat="server" />
	</asp:Panel>
	<ajaxToolkit:CollapsiblePanelExtender ID="pnlCollateral_CollapsiblePanelExtender" 
        runat="server" CollapseControlID="pnlCollateralShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Collateral Data...)" Enabled="True"
		ExpandControlID="pnlCollateralShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Collateral Data...)"
		ImageControlID="imgCollateral" TargetControlID="pnlCollateral" 
        TextLabelID="lblCollateral"></ajaxToolkit:CollapsiblePanelExtender>

     <asp:Panel ID="pnlAppShow" runat="server" CssClass="ShowDetail" Width="99%">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgApp" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblApp" runat="server" CssClass="required">(Show Application Data...)</asp:Label>
		</div>
		<input id="Button2" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <asp:Panel ID="pnlApp" runat="server" Width="100%">
		<asp:DataList ID="dlApp" runat="server"  
			Caption="APPLICATION DATA" DataSourceID="sdsFeeData" Width="100%">
			<ItemTemplate>
				<table cellpadding="0" cellspacing="0" width="100%">
					<tr>
                        <td class="FooterStyle">
                            Application Type</td>
                        <td class="FooterStyle" colspan="2">
                            <asp:Label ID="lblAppType" runat="server" Font-Bold="True" Font-Underline="True" 
								Text='<%# Bind("APPTYPENAME") %>'></asp:Label>
                        </td>
                        <td class="FooterStyle">
                            Sale Source</td>
                        <td class="FooterStyle">
                            <asp:Label ID="lblSaleSource" runat="server" Font-Bold="True" Font-Underline="True"
								Text='<%# Bind("SALESOURCENAME") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="FooterStyle">
                            Marketing Officer</td>
                        <td class="FooterStyle" colspan="2">
                            <asp:Label ID="lblMktOff" runat="server" Font-Bold="True" Font-Underline="True" 
								Text='<%# Eval("MKTOFF") %>'></asp:Label>
                        </td>
                        <td class="FooterStyle">
                            Surveyor</td>
                        <td class="FooterStyle">
                            <asp:Label ID="lblSurvey" runat="server" Font-Bold="True" Font-Underline="True"
								Text='<%# Bind("SURVEYOR") %>'></asp:Label>
                        </td>
                    </tr>
				</table>
			</ItemTemplate>
		</asp:DataList>
        <asp:SqlDataSource ID="sdsFeeData" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
		    
            
            SelectCommand="SELECT APPLICATION.APPTYPE, (SELECT '(' + CODE + ') ' + NAME AS APPTYPE FROM PARAMGLOBAL WHERE (TYPE = 'APPTYPE') AND (CODE = APPLICATION.APPTYPE)) AS APPTYPENAME, APPLICATION.SALESOURCE, (SELECT '(' + CODE + ') ' + NAME AS SALESOURCE FROM PARAMGLOBAL AS PARAMGLOBAL_1 WHERE (TYPE = 'SALESOURCE') AND (CODE = APPLICATION.SALESOURCE)) AS SALESOURCENAME, APPLICATION.MARKETINGID, (SELECT '(' + AOCODE + ') ' + '(' + AONAME + ') ' AS MKT FROM AO WHERE (AOID = APPLICATION.MARKETINGID)) AS MKTOFF, APPLICATION.SURVEYORID, (SELECT '(' + AOCODE + ') ' + '(' + AONAME + ') ' AS SVY FROM AO AS AO_1 WHERE (AOID = APPLICATION.MARKETINGID)) AS SURVEYOR FROM ACCOUNT WITH (NOLOCK) INNER JOIN APPLICATION ON ACCOUNT.LOCID = APPLICATION.LOCID AND ACCOUNT.APPID = APPLICATION.APPID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.ACCID = @ACCID)">
            <SelectParameters>
				<asp:ControlParameter ControlID="hidLocid" Name="LOCID" PropertyName="Value" />
                <asp:ControlParameter ControlID="hidAccID" Name="ACCID" PropertyName="Value" />
			</SelectParameters>
		</asp:SqlDataSource>
	</asp:Panel>
	<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEAppData" runat="server" CollapseControlID="pnlAppShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Fee Data...)" Enabled="True"
		ExpandControlID="pnlAppShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Application Data...)"
		ImageControlID="imgApp" TargetControlID="pnlApp" TextLabelID="lblApp"></ajaxToolkit:CollapsiblePanelExtender>

    <asp:Panel ID="pnlApplicationSale" runat="server">
            <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                    <td colspan="4"  class="HeaderStyle" style="text-align:center">
                        Application Type and Sale Source</td>
                </tr>
            <tr>
				<td class="AlternatingRowStyle" >
					Application Type</td>
				<td class="AlternatingRowStyle" >
					<asp:DropDownList ID="ddlAppType" runat="server" CssClass="required" 
                        DataSourceID="sdsAppType" DataTextField="NAME" DataValueField="CODE">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsAppType" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 

                        SelectCommand="SELECT NULL AS CODE, '[APPLICATION TYPE]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'APPTYPE')">
                    </asp:SqlDataSource>
                    <asp:RequiredFieldValidator ID="reqAppType" runat="server" 
                        ControlToValidate="ddlAppType" Display="None" 
                        ErrorMessage="[APPLICATION TYPE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqAppType_ValidatorCalloutExtender" 
                        runat="server" HighlightCssClass="ErrHighLight" 
                        TargetControlID="reqAppType">
                    </ajaxToolkit:ValidatorCalloutExtender>
				</td>
				<td class="AlternatingRowStyle" >
					Sale Source</td>
				<td class="AlternatingRowStyle" >
					<asp:DropDownList ID="ddlSaleSource" runat="server" CssClass="required" 
                        DataSourceID="sdsSaleSource" DataTextField="NAME" DataValueField="CODE">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsSaleSource" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        
                        SelectCommand="SELECT NULL AS CODE, '[SALE SOURCE]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'SALESOURCE')">
                    </asp:SqlDataSource>
                    <asp:RequiredFieldValidator ID="reqSaleSource" runat="server" 
                        ControlToValidate="ddlSaleSource" Display="None" 
                        ErrorMessage="[SALE SOURCE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqSaleSource_ValidatorCalloutExtender" 
                        runat="server" HighlightCssClass="ErrHighLight" 
                        TargetControlID="reqSaleSource">
                    </ajaxToolkit:ValidatorCalloutExtender>
				</td>
			</tr>
                
            </table>
        </asp:Panel>
        <asp:Panel ID="pnlMarketingSurveyor" runat="server">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="4"  class="HeaderStyle" style="text-align:center">
                        Marketing Officer and Surveyor Update</td>
                </tr>
                <tr>
                <td class="RowStyle" >
                    Marketing Officer</td>
                <td  colspan="3" class="RowStyle">
                    <asp:TextBox ID="txtMarketing" runat="server" ReadOnly="True" Width="240px" 
                        CssClass="required"></asp:TextBox>
                    <input
						id="Button17" noenter onclick="AOFind(1);" style="background-position: left;
						background-image: url(../images/search.gif); width: 45px; cursor: pointer; background-repeat: no-repeat;
						 text-align: right" type="button" value="Find"  onclick="return Button17_onclick()" />
                    <input
							id="Button18" onclick="AOClear(1);" style="background-position: left;
							background-image: url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear"  />
                    <asp:HiddenField ID="hidMarketingID" runat="server" />
                    <asp:RequiredFieldValidator
							ID="reqMarketing" runat="server" ControlToValidate="txtMarketing" Display="None"
							ErrorMessage="[MARKETING OFFICER] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender
								ID="reqMarketing_ValidatorCalloutExtender" runat="server" HighlightCssClass="ErrHighLight" 
                        TargetControlID="reqMarketing" Enabled="True">
							</ajaxToolkit:ValidatorCalloutExtender>
				&nbsp;
                </td>
                </tr>
            <tr>
                <td class="AlternatingRowStyle" >
                    Surveyor Update</td>
                <td  colspan="3" class="AlternatingRowStyle">
                    <asp:TextBox ID="txtSurveyor" runat="server" ReadOnly="True" Width="240px" 
                        CssClass="required"></asp:TextBox>
                    <input
						id="Button19" noenter onclick="AOFind(2);" style="background-position: left;
						background-image: url(../images/search.gif); width: 45px; cursor: pointer; background-repeat: no-repeat;
						 text-align: right" type="button" value="Find"  /><input
							id="Button20" onclick="AOClear(2);" style="background-position: left;
							background-image: url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" /><asp:HiddenField 
                        ID="hidSurveyorID" runat="server" />
                    <asp:RequiredFieldValidator
							ID="reqSurveyor" runat="server" ControlToValidate="txtSurveyor" Display="None"
							ErrorMessage="[SURVEYOR] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender
								ID="reqSurveyor_ValidatorCalloutExtender" runat="server" HighlightCssClass="ErrHighLight" 
                        TargetControlID="reqSurveyor" Enabled="True">
							</ajaxToolkit:ValidatorCalloutExtender>
                </td>
                </tr>
            </table>
        </asp:Panel>
       <br />
       <br />
       <br />
       <br />

    <asp:Panel ID="pnlControl" runat="server" CssClass="HeaderStyle" Style="border-right: thin inset;
		    border-top: thin inset; border-left: thin inset; border-bottom: thin inset" Width="99%">
		        <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" Font-Bold="True" 
                    Font-Underline="True" Style="text-align: center" Visible="False" Width="100%"></asp:Label>
		        <asp:Button ID="btnUpdate" runat="server" CausesValidation="true" CommandName="Update" Style="background-position: left; background-image: url(../images/Save.gif);
			        cursor: pointer; background-repeat: no-repeat; text-align: right;  cursor: pointer;" 
                    Text="Update" ToolTip="Update Admin Fee" Width="72px"  />
                <asp:Button ID="btnBack" runat="server" CausesValidation="False" CommandName="Cancel" Style="background-position: left; 
		            background-image: url(../images/back.png); cursor: pointer; background-repeat: no-repeat; text-align: right; " 
                    Text="Back" ToolTip="Back to List" Width="72px"/>
		    Please check data carefully before SAVE..!
            </asp:Panel>
	    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEControl" runat="server" TargetControlID="pnlControl"
		    VerticalSide="Bottom">
	    </ajaxToolkit:AlwaysVisibleControlExtender>
     <br/>

   </asp:View>
 </asp:MultiView>
     <script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");

    window.onload = function () {
        TabToEnter();
        Load();
    }
    function Load() {
        var Action = GetValueTxtByClientID('<%=txtAction.ClientID%>');
        if (Action == "LOAD") {
            LoadBranch();
        }
    }
    function LoadBranch() {
        if ($find("BehavArea"))
            $find("BehavArea").add_populated(onPopulatedArea);
        if ($find("BehavBranch"))
            $find("BehavBranch").add_populated(onPopulatedBranch);
    }

    function onPopulatedArea() {
        if (GetValueTxtByClientID("<%=hidIsUserBranch.ClientID%>") == "1") {
            $get("<%=ddlAreaSearch.ClientID%>").disabled = true;
        }
    }

    function onPopulatedBranch() {
        if (GetValueTxtByClientID("<%=hidIsUserBranch.ClientID%>") == "1") {
            $get("<%=ddlBranchSearch.ClientID%>").disabled = true;
        }
    }
    function SetValueTxtByClientID(ClientID, sValue) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            oText.value = sValue;
    }

    function getObjectbyClientID(ClientID) {
        var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        return (oObject)
    }
    function GetValueTxtByClientID(ClientID) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            return (oText.value);
    }

    function Edit(LOCID, ACCID) {
        SetValueTxtByClientID("<%=txtAction.ClientID%>", "UPDATE");
        document.forms[0].action = "MktSurveyUpd.aspx?LOCID=" + LOCID + "&ACCID=" + ACCID;
        document.forms[0].submit();
    }
    function toNumeric(theValue) {
        var ValX = parseFloat(FormatNumberClear(theValue));
        if (isNaN(ValX))
            ValX = 0;
        return (ValX);
    }
   
    function ViewDetailAcc(LOCID, APPID) {
        var winref = window.open("../Account/AccInqFrame.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
        winref.focus();
    }
    var iAOFind = "1";
    function AOFind(xAOFind) {
        iAOFind = xAOFind;
        WinRef = window.open("../Param/AOFind.aspx?Action=Find", "AOFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
        WinRef.focus();
    }

    function SetAO(AOID, AO) {
        if (iAOFind == "2") {
            SetValueTxtByClientID("<%=hidSurveyorID.ClientID%>", AOID);
            SetValueTxtByClientID("<%=txtSurveyor.ClientID%>", AO);
        } else {
            SetValueTxtByClientID("<%=hidMarketingID.ClientID%>", AOID);
            SetValueTxtByClientID("<%=txtMarketing.ClientID%>", AO);
        }
    }

    function AOClear(iAOFind) {
        if (iAOFind == "2") {
            SetValueTxtByClientID("<%=hidSurveyorID.ClientID%>", "");
            SetValueTxtByClientID("<%=txtSurveyor.ClientID%>", "");
        } else {
            SetValueTxtByClientID("<%=hidMarketingID.ClientID%>", "");
            SetValueTxtByClientID("<%=txtMarketing.ClientID%>", "");
        }
    }

    </script>
    </asp:Content>
