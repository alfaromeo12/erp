<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="InsBranchAccBank.aspx.vb" EnableEventValidation="false" Inherits="Param_InsBranchAccBank" %>
<%@ Register Src="~/usercontrol/btncancel.ascx" TagPrefix="uc" TagName="BtnCancel" %>
<%@ Register Src="~/usercontrol/btninsert.ascx" TagPrefix="uc" TagName="BtnInsert" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<%@ Register src="../UserControl/BtnInsert.ascx" tagname="BtnInsert" tagprefix="uc7" %>
<%@ Register src="../UserControl/BtnUpdate.ascx" tagname="BtnUpdate" tagprefix="uc8" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:ScriptManagerProxy ID="SMPBranchAcc" runat="server">
	<Services>
	<asp:ServiceReference Path="GHWService.asmx" />
	</Services>
	</asp:ScriptManagerProxy>
<ajaxToolkit:textboxwatermarkextender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
            WatermarkText="%%"></ajaxToolkit:textboxwatermarkextender>
        <asp:CheckBox ID="chkAdd" runat="server" style="display:none" />
        <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail">
            <div style="float: right; vertical-align: middle">
                <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
                <asp:Label ID="lblShow" runat="server">(Show Details...)</asp:Label>
            </div>
            <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
                    background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
            <ajaxToolkit:collapsiblepanelextender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
                CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Detail...)" Enabled="True"
                ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Detail...)"
                ImageControlID="imgButtonShow" TargetControlID="pnlSearchMaintenance" 
                TextLabelID="lblShow"></ajaxToolkit:collapsiblepanelextender>
                    
                    <asp:Panel ID="pnlSearchMaintenance" runat="server">
                    <table cellpadding="0" cellspacing="0" width="100%">
                         <tr>
                            <td style="width: 115px">
                                <asp:DropDownList ID="ddlCriteria" runat="server">
                                    <asp:ListItem Value="INSURANCENAME">Insurance Name</asp:ListItem>
                                    <asp:ListItem Value="INSBRANCHNAME">Insurance Branch Name</asp:ListItem>
                                    <asp:ListItem Value="ACCBANKBRANCH">Bank Branch</asp:ListItem>
                                    <asp:ListItem Value="ACCNAME">Account Name</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                   <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
                                    ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
                                    border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
                                    Text="Search" CausesValidation="False" CssClass="Search" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 115px">
                                    Insurance Company
                            </td>
                            <td>
                                  <asp:DropDownList ID="ddlInsCompanySrc" runat="server" AutoPostBack="True" 
                                       DataTextField="NAME" DataValueField="CODE">
                                    </asp:DropDownList>
                                    <ajaxToolkit:CascadingDropDown ID="ajaxCCDInsCompanySrc" runat="server" Category="INSCOMPANYID" 
                                        Enabled="True" LoadingText="[Loading Company..]" 
                                        PromptText="[SELECT INSURANCE COMPANY]" ServiceMethod="GetDropDownInsuranceCompany" 
                                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlInsCompanySrc">
                                    </ajaxToolkit:CascadingDropDown>
                                &nbsp;&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 115px">
                                Insurance Branch
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlInsBranchSrc" runat="server" >
					            </asp:DropDownList>
					            <ajaxToolkit:CascadingDropDown ID="ajaxCDDInsBranchSrc" runat="server" Category="INSBRANCHID" 
						            LoadingText="[Loading Branch ..]" PromptText="[SELECT BRANCH]" 
						            ServiceMethod="GetDropDownBranchByInsCompany" ServicePath="~\Param\WebService.asmx" 
						            TargetControlID="ddlInsBranchSrc" ParentControlID="ddlInsCompanySrc">
					            </ajaxToolkit:CascadingDropDown>
					       
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 115px">
                                &nbsp;</td>
                            <td>
                                     
                            </td>
                        </tr>
                    </table>
                     <asp:SqlDataSource ID="sdsInsCompany" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        SelectCommand="SELECT NULL AS INSCOMPANYID,'[SELECT INSURANCE COMPANY]' AS INSURANCENAME
                                        UNION ALL
                                        SELECT INSCOMPANYID, '(' + INSURANCECODE + ')' + INSURANCENAME AS  INSURANCENAME
                                        FROM INSCOMPANY 
                                        WHERE Deletests=0">
                    </asp:SqlDataSource>
                      <asp:SqlDataSource ID="sdsInsBranch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        SelectCommand="SELECT NULL AS INSCOMPANYID,'[SELECT INSURANCE BRANCH]' AS INSURANCENAME
                                        UNION ALL
                                        SELECT INSBRANCHID, '(' + INSBRANCHCODE + ')' + INSBRANCHNAME AS  INSURANCENAME
                                        FROM INSBRANCH 
                                        WHERE Deletests=0">
                    </asp:SqlDataSource>
                        
                        <asp:HiddenField ID="HdnBranchId" runat="server" />
                        
                        <asp:ImageButton ID="btnNew" runat="server" ImageUrl="~/images/add.gif" 
                                CommandName="New" CausesValidation="False" Height="19px" />
                                </asp:Panel>
                                <asp:Panel ID="pnlData" runat="server">
                    <asp:GridView ID="gvData" runat="server" AllowPaging="True"
                        AutoGenerateColumns="False" DataKeyNames="INSBRANCHACCID" 
                            DataSourceID="sdsGrid" Width="100%" 
                        Caption="Branch Acc List" RowHeaderColumn="INSBRANCHACCID">
                        <Columns>
                            <asp:CommandField ButtonType="Image" ShowSelectButton="True" SelectImageUrl="~/Images/edit.gif">
                                <ItemStyle HorizontalAlign="Center" Width="2px" />
                            </asp:CommandField>
                            <asp:BoundField DataField="INSBRANCHACCID" HeaderText="ID" SortExpression="INSBRANCHACCID" />
                       
                            <asp:BoundField DataField="INSURANCENAME" HeaderText="Ins.Company Name" SortExpression="INSURANCENAME" />
                            <asp:BoundField DataField="INSBRANCHID" HeaderText="Ins.Branch ID" SortExpression="INSBRANCHID" />
                            <asp:BoundField DataField="INSBRANCHNAME" HeaderText="Ins.Branch Name" SortExpression="INSBRANCHNAME" />
                            <asp:BoundField DataField="ACCBANKID" HeaderText="Account Bank.ID" SortExpression="ACCBANKID" />
                            <asp:BoundField DataField="ACCBANKBRANCH" HeaderText="Account Bank.Branch" SortExpression="ACCBANKBRANCH" />
                            <asp:BoundField DataField="ACCNO" HeaderText="Account No."  SortExpression="ACCNO" />
                            <asp:BoundField DataField="ACCNAME" HeaderText="Account Name"  SortExpression="ACCNAME" />
                        </Columns>
                        <EmptyDataTemplate>
                            <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                        </EmptyDataTemplate>
                    </asp:GridView>
            </asp:Panel>
        <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            SelectCommand=" SELECT BA.INSBRANCHACCID, '(' + CP.INSURANCECODE + ') '+ CP.INSURANCENAME AS INSURANCENAME,
                                    BR.INSBRANCHID, '(' + BR.INSBRANCHCODE + ') '+ BR.INSBRANCHNAME AS INSBRANCHNAME,
                                    BA.ACCBANKBRANCH,'('+ CAST(BA.ACCBANKID AS VARCHAR(5)) + ') '+ BK.BANKNAME AS ACCBANKID,BA.ACCNAME,BA.ACCNO
                            FROM INSBRANCH BR
                            INNER JOIN INSCOMPANY CP ON CP.INSCOMPANYID=BR.INSCOMPANYID
                            INNER JOIN INSBRANCHACCOUNT BA ON BR.INSBRANCHID=BA.INSBRANCHID
                            INNER JOIN BANK BK ON BK.BANKID=BA.ACCBANKID
                            WHERE BA.Deletests=0">
        </asp:SqlDataSource>
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
                     
                     <asp:FormView ID="fvBranchAccBank" runat="server" DataSourceID="sdsBranchAccBank"
                            DefaultMode="Edit" Width="100%" DataKeyNames="INSBRANCHACCID">
                            <EditItemTemplate>
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

                                           <asp:DropDownList ID="ddlInsCompany" runat="server" 
                                                CssClass="required"  DataTextField="INSURANCENAME" 
                                                DataSourceID="sdsInsCompanyEdit" 
                                                DataValueField="INSCOMPANYID"  >
                                            </asp:DropDownList>
                                            <ajaxToolkit:CascadingDropDown ID="ajaxCCDInsCompany" runat="server" Category="INSCOMPANYID" 
                                                Enabled="True" LoadingText="[Loading Company..]"  SelectedValue='<%# eval("INSCOMPANYID") %>' 
                                                PromptText="[SELECT INSURANCE COMPANY]" ServiceMethod="GetDropDownInsuranceCompany" 
                                                ServicePath="~\Param\WebService.asmx" TargetControlID="ddlInsCompany">
                                            </ajaxToolkit:CascadingDropDown>
                                            <asp:RequiredFieldValidator ID="reqType" runat="server" 
                                                ControlToValidate="ddlInsCompany" Display="None" 
                                                ErrorMessage="Insurance Company must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEType" runat="server" 
                                                HighlightCssClass="ErrHighLight" TargetControlID="reqType">
                                            </ajaxToolkit:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                   
                                    <tr>
                                        <td width="20%">
                                            Insurance Branch</td>
                                        <td>
                                         
                                             <asp:DropDownList ID="ddlInsBranch" runat="server"  CssClass="required" DataSourceID="sdsInsBranchEdit"
                                              DataTextField="INSBRANCHNAME" DataValueField="INSBRANCHID"  SelectedValue='<%#Bind("INSBRANCHID") %>' >
					                            </asp:DropDownList>
					                            <ajaxToolkit:CascadingDropDown ID="ajaxCDDInsBranch" runat="server" Category="INSBRANCHID" 
						                            LoadingText="[Loading Branch ..]" PromptText="[SELECT BRANCH]"  SelectedValue='<%# eval("INSBRANCHID") %>' 
						                            ServiceMethod="GetDropDownBranchByInsCompany" ServicePath="~\Param\WebService.asmx" 
						                            TargetControlID="ddlInsBranch" ParentControlID="ddlInsCompany">
					                            </ajaxToolkit:CascadingDropDown>
					                            <asp:RequiredFieldValidator ID="reqInsBranch" runat="server" 
						                            ControlToValidate="ddlInsBranch" Display="None" 
						                            ErrorMessage="Insurance Branch must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
					                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCETypeTitle" runat="server" 
						                            HighlightCssClass="ErrHighLight" TargetControlID="reqInsBranch">
					                            </ajaxToolkit:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td width="20%">
                                            Insurance Branch Acc ID</td>
                                        <td>
                                            <asp:Label ID="lblInsBranchAccID" runat="server" Font-Underline="true" Text='<%# Bind("INSBRANCHACCID") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
					                    <td>
						                    Account Bank</td>
					                    <td>
						                    <asp:DropDownList ID="ddlBankID" runat="server" DataSourceID="sdsBank" 
							                    DataTextField="BANKNAME" DataValueField="BANKID" 
							                    SelectedValue='<%# Bind("ACCBANKID") %>'>
						                    </asp:DropDownList>
						                    <asp:RequiredFieldValidator ID="reqAccBankID" runat="server" 
							                    ControlToValidate="ddlBankID" Display="None" 
							                    ErrorMessage="Account BankID Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="reqAccBankID_ValidatorCalloutExtender" 
							                    runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAccBankID">
						                    </ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Account Bank Branch</td>
					                    <td>
						                    <asp:TextBox ID="txtAccBankBranch" runat="server" CssClass="required" 
							                    MaxLength="50" Text='<%# Bind("ACCBANKBRANCH") %>' Width="240px"></asp:TextBox>
						                    <asp:RequiredFieldValidator ID="reqAccBankBranch" runat="server" 
							                    ControlToValidate="txtAccBankBranch" Display="None" 
							                    ErrorMessage="Account Bank Branch Name must be entry...!" 
							                    SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="reqAccBankBranch_ValidatorCalloutExtender" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqAccBankBranch">
						                    </ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Account No</td>
					                    <td>
						                    <asp:TextBox ID="txtAccNo" runat="server" CssClass="required" 
							                    MaxLength="50" Text='<%# Bind("ACCNO") %>' Width="200px"></asp:TextBox>
						                    <asp:RequiredFieldValidator ID="reqAccNO" runat="server" 
							                    ControlToValidate="txtAccNo" Display="None" 
							                    ErrorMessage="Account Number must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="reqAccNO_ValidatorCalloutExtender" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqAccNO">
						                    </ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Account Name</td>
					                    <td>
						                    <asp:TextBox ID="txtAccName" runat="server" CssClass="required" MaxLength="50" 
							                    Text='<%# Bind("ACCNAME") %>' Width="240px"></asp:TextBox>
						                    <asp:RequiredFieldValidator ID="reqAccName" runat="server" 
							                    ControlToValidate="txtAccName" Display="None" 
							                    ErrorMessage="Account Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="reqAccName_ValidatorCalloutExtender" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqAccName">
						                    </ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Bank Account Status</td>
					                    <td>
						                    <asp:DropDownList ID="ddlBankAccStatus" runat="server" CssClass="required" 
							                    DataSourceID="sdsParamGlobal_BankSts" DataTextField="NAME" DataValueField="CODE" 
							                    SelectedValue='<%# Bind("BANKACCSTATUS") %>'>
						                    </asp:DropDownList>
						                    <asp:RequiredFieldValidator ID="reqBankAccStatus" runat="server" 
							                    ControlToValidate="ddlBankAccStatus" Display="None" 
							                    ErrorMessage="Bank Status must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="reqBankAccStatus_ValidatorCalloutExtender" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqBankAccStatus">
						                    </ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
                                   <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                     <tr>
                                        <td class="FooterStyle" colspan="2">
                                            &nbsp;<uc8:BtnUpdate ID="BtnUpdate2" runat="server" />
                                            <uc2:BtnDelete ID="BtnDelete1" runat="server" />
                                            <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                                        </td>
                                    </tr>
                                </table>

                            </EditItemTemplate>
                             <InsertItemTemplate>
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
                                           <asp:DropDownList ID="ddlInsCompany" runat="server" 
                                                CssClass="required"  DataTextField="INSURANCENAME" DataValueField="INSCOMPANYID">
                                            </asp:DropDownList>
                                            <ajaxToolkit:CascadingDropDown ID="ajaxCCDInsCompany" runat="server" Category="INSCOMPANYID" 
                                                Enabled="True" LoadingText="[Loading Company..]" 
                                                PromptText="[SELECT INSURANCE COMPANY]" ServiceMethod="GetDropDownInsuranceCompany" 
                                                ServicePath="~\Param\WebService.asmx" TargetControlID="ddlInsCompany">
                                            </ajaxToolkit:CascadingDropDown>
                                            <asp:RequiredFieldValidator ID="reqType" runat="server" 
                                                ControlToValidate="ddlInsCompany" Display="None" 
                                                ErrorMessage="Insurance Company must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEType" runat="server" 
                                                HighlightCssClass="ErrHighLight" TargetControlID="reqType">
                                            </ajaxToolkit:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                   
                                    <tr>
                                        <td width="20%">
                                            Insurance Branch</td>
                                        <td>
                                             <asp:DropDownList ID="ddlInsBranch" runat="server"  CssClass="required"
                                              SelectedValue='<%# Bind("INSBRANCHID") %>'    DataTextField="INSBRANCHNAME" DataValueField="INSBRANCHID"   >
					                            </asp:DropDownList>
					                            <ajaxToolkit:CascadingDropDown ID="ajaxCDDInsBranch" runat="server" Category="INSBRANCHID" 
						                            LoadingText="[Loading Branch ..]" PromptText="[SELECT BRANCH]" 
						                            ServiceMethod="GetDropDownBranchByInsCompany" ServicePath="~\Param\WebService.asmx" 
						                            TargetControlID="ddlInsBranch" ParentControlID="ddlInsCompany">
					                            </ajaxToolkit:CascadingDropDown>
					                            <asp:RequiredFieldValidator ID="reqInsBranch" runat="server" 
						                            ControlToValidate="ddlInsBranch" Display="None" 
						                            ErrorMessage="Insurance Branch must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
					                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEInsBranch" runat="server" 
						                            HighlightCssClass="ErrHighLight" TargetControlID="reqInsBranch">
					                            </ajaxToolkit:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                    <%-- <tr>
                                        <td width="20%">
                                            Insurance Branch Acc ID</td>
                                        <td>
                                            <asp:Label ID="lblInsBranchAccID" runat="server" Text='<%# Bind("INSBRANCHACCID") %>'></asp:Label>
                                        </td>
                                    </tr>--%>
                                    <tr>
					                    <td>
						                    Account Bank</td>
					                    <td>
						                    <asp:DropDownList ID="ddlBankID" runat="server" DataSourceID="sdsBank" 
							                    DataTextField="BANKNAME" DataValueField="BANKID" 
							                    SelectedValue='<%# Bind("ACCBANKID") %>'>
						                    </asp:DropDownList>
						                    <asp:RequiredFieldValidator ID="reqAccBankID" runat="server" 
							                    ControlToValidate="ddlBankID" Display="None" 
							                    ErrorMessage="Account BankID Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="reqAccBankID_ValidatorCalloutExtender" 
							                    runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAccBankID">
						                    </ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Account Bank Branch</td>
					                    <td>
						                    <asp:TextBox ID="txtAccBankBranch" runat="server" CssClass="required" 
							                    MaxLength="50" Text='<%# Bind("ACCBANKBRANCH") %>' Width="240px"></asp:TextBox>
						                    <asp:RequiredFieldValidator ID="reqAccBankBranch" runat="server" 
							                    ControlToValidate="txtAccBankBranch" Display="None" 
							                    ErrorMessage="Account Bank Branch Name must be entry...!" 
							                    SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="reqAccBankBranch_ValidatorCalloutExtender" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqAccBankBranch">
						                    </ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Account No</td>
					                    <td>
						                    <asp:TextBox ID="txtAccNo" runat="server" CssClass="required" 
							                    MaxLength="50" Text='<%# Bind("ACCNO") %>' Width="200px"></asp:TextBox>
						                    <asp:RequiredFieldValidator ID="reqAccNO" runat="server" 
							                    ControlToValidate="txtAccNo" Display="None" 
							                    ErrorMessage="Account Number must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="reqAccNO_ValidatorCalloutExtender" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqAccNO">
						                    </ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Account Name</td>
					                    <td>
						                    <asp:TextBox ID="txtAccName" runat="server" CssClass="required" MaxLength="50" 
							                    Text='<%# Bind("ACCNAME") %>' Width="240px"></asp:TextBox>
						                    <asp:RequiredFieldValidator ID="reqAccName" runat="server" 
							                    ControlToValidate="txtAccName" Display="None" 
							                    ErrorMessage="Account Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="reqAccName_ValidatorCalloutExtender" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqAccName">
						                    </ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Bank Account Status</td>
					                    <td>
						                    <asp:DropDownList ID="ddlBankAccStatus" runat="server" CssClass="required" 
							                    DataSourceID="sdsParamGlobal_BankSts" DataTextField="NAME" DataValueField="CODE" 
							                    SelectedValue='<%# Bind("BANKACCSTATUS") %>'>
						                    </asp:DropDownList>
						                    <asp:RequiredFieldValidator ID="reqBankAccStatus" runat="server" 
							                    ControlToValidate="ddlBankAccStatus" Display="None" 
							                    ErrorMessage="Bank Status must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="reqBankAccStatus_ValidatorCalloutExtender" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqBankAccStatus">
						                    </ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                      <tr>
                                        <td colspan="2" class="FooterStyle">
                                            <uc7:BtnInsert ID="BtnInsert1" runat="server" />
                                            <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </InsertItemTemplate>
                        </asp:FormView>    
                        <asp:SqlDataSource ID="sdsBranchAccBank" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT (SELECT INSCOMPANYID FROM INSCOMPANY WITH (NOLOCK) WHERE (INSCOMPANYID = CP.INSCOMPANYID) AND (Deletests = 0)) AS INSCOMPANYID, (SELECT INSBRANCHID FROM INSBRANCH WITH (NOLOCK) WHERE (INSBRANCHID = BA.INSBRANCHID) AND (Deletests = 0)) AS INSBRANCHID, BA.INSBRANCHACCID, BR.INSBRANCHNAME, BA.ACCBANKBRANCH, BA.ACCBANKID, BA.ACCNAME, BA.ACCNO, BA.BANKACCSTATUS FROM INSCOMPANY AS CP INNER JOIN INSBRANCH AS BR ON CP.INSCOMPANYID = BR.INSCOMPANYID INNER JOIN INSBRANCHACCOUNT AS BA ON BR.INSBRANCHID = BA.INSBRANCHID WHERE (BA.INSBRANCHACCID = @INSBRANCHACCID)" 
                    DeleteCommand="UPDATE INSBRANCHACCOUNT SET DELETESTS = 1, LASTUSERID = @UserID, LASTUPDATE = GETDATE() WHERE  INSBRANCHACCID=@INSBRANCHACCID AND INSBRANCHID=@INSBRANCHID" 
                    UpdateCommand="INSBRANCHACCOUNTUpdate" InsertCommand="INSBRANCHACCOUNTAdd" 
                    InsertCommandType="StoredProcedure" 
        UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvData" Name="INSBRANCHACCID" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:CookieParameter CookieName="UID" Name="UserID" />
                        <asp:ControlParameter ControlID="gvData" Name="INSBRANCHACCID" 
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="HdnBranchId" DefaultValue="" 
                            Name="INSBRANCHID" PropertyName="Value" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="gvData" Name="INSBRANCHACCID" 
                            PropertyName="SelectedValue" Type="Int32" />
                      <asp:ControlParameter ControlID="HdnBranchId" Name="INSBRANCHID" 
                            PropertyName="Value" Type="Int32" />
                     <%--  <asp:Parameter Name="INSBRANCHID" Type="int32" />--%>
                        <asp:Parameter Name="ACCBANKID" Type="Int32" />  
                        <asp:Parameter Name="ACCBANKBRANCH" Type="String" />
                        <asp:Parameter Name="ACCNO" Type="String" />
                        <asp:Parameter Name="ACCNAME" Type="String" />
                        <asp:Parameter Name="BANKACCSTATUS" Type="Int32" />
                        <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="INSBRANCHID" Type="int32" />
                        <asp:Parameter Name="ACCBANKID" Type="Int32" />  
                        <asp:Parameter Name="ACCBANKBRANCH" Type="String" />
                        <asp:Parameter Name="ACCNO" Type="String" />
                        <asp:Parameter Name="ACCNAME" Type="String" />
                        <asp:Parameter Name="BANKACCSTATUS" Type="Int32" />
                        <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                    </InsertParameters>
                </asp:SqlDataSource>
               <asp:SqlDataSource ID="sdsBank" runat="server" 
		            ConnectionString="<%$ ConnectionStrings:connection %>" 
		            SelectCommand="SELECT NULL AS BANKID, NULL AS BANKCODE, '[SELECT BANK]' AS BANKNAME UNION ALL SELECT BANKID, BANKCODE, '(' + BANKCODE + ') ' + BANKNAME AS BANKNAME FROM BANK ORDER BY BANKCODE">
	            </asp:SqlDataSource>   
                <asp:SqlDataSource ID="sdsParamGlobal_BankSts" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        SelectCommand="SELECT NULL AS CODE,'[SELECT BANK STATUS]' AS NAME
                        UNION ALL
                        SELECT CODE, '(' + CODE + ') ' + NAME AS NAME
                        FROM PARAMGLOBAL WHERE TYPE='BANKACCSTATUS'">
                </asp:SqlDataSource>
                   <asp:SqlDataSource ID="sdsInsCompanyEdit" runat="server" 
		            ConnectionString="<%$ ConnectionStrings:connection %>" 
		            SelectCommand="SELECT INSCOMPANYID, '(' + INSURANCECODE + ')' + INSURANCENAME AS  INSURANCENAME FROM INSCOMPANY WHERE Deletests=0">
	            </asp:SqlDataSource>   
                <asp:SqlDataSource ID="sdsInsBranchEdit" runat="server" 
		            ConnectionString="<%$ ConnectionStrings:connection %>" 
		            
        SelectCommand="SELECT NULL AS INSBRANCHID, NULL AS INSBRANCHCODE, '[INSURANCE BRANCH]' AS INSBRANCHNAME UNION ALL SELECT INSBRANCHID, INSBRANCHCODE, '(' + INSBRANCHCODE + ') ' + INSBRANCHNAME AS INSBRANCHNAME FROM INSBRANCH WHERE (Deletests = 0) ORDER BY INSBRANCHCODE">
	            </asp:SqlDataSource>   
</asp:Content>

