<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="BranchApp.aspx.vb" Inherits="Param_Branch" title="Branch" EnableEventValidation="false" %>
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
                <td style="width: 115px" class="RowStyle">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="BranchX.BranchName">Branch Name</asp:ListItem>
        <asp:ListItem Value="BranchX.BranchCode">Branch Code</asp:ListItem>
    </asp:DropDownList></td>
                <td class="RowStyle">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" />
                    &nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td style="width: 115px" class="AlternatingRowStyle">
                    Area</td>
                <td class="AlternatingRowStyle">
        <asp:DropDownList ID="ddlAreaSearch" runat="server" AutoPostBack="True" DataSourceID="sdsAreaSearch"
            DataTextField="AREA" DataValueField="AREAID">
        </asp:DropDownList><asp:SqlDataSource ID="sdsAreaSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            
                        SelectCommand="SELECT NULL AS AREAID, NULL AS AREACODE, 'ALL AREA' AS AREA UNION ALL SELECT AREAID, AREACODE, AREACODE + ' - ' + AREANAME AS AREA FROM AREA WITH (NOLOCK) WHERE (DELETESTS = 0) ORDER BY AREACODE">
        </asp:SqlDataSource>
                </td>
            </tr>
        </table>
        </asp:Panel>
        <br />
        <asp:Panel ID="pnlData" runat="server">
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="BRANCHID" DataSourceID="sdsGrid" 
            Width="100%" Caption="Branch Approval List" RowHeaderColumn="BRANCHID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" 
                    ShowSelectButton="True" >
                    <ItemStyle Width="20px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="BRANCHID" HeaderText="ID" ReadOnly="True" 
                    SortExpression="BRANCHID" />
                <asp:BoundField DataField="AREA" HeaderText="Area" SortExpression="AREA" />
                <asp:BoundField DataField="BRANCHCODE" HeaderText="Code" SortExpression="BRANCHCODE" />
                <asp:BoundField DataField="BRANCHNAME" HeaderText="Name" SortExpression="BRANCHNAME" />
                <asp:BoundField DataField="BRANCHADDRESS" HeaderText="Address" SortExpression="BRANCHADDR" />
                <asp:BoundField DataField="BRANCHCITY" HeaderText="City" SortExpression="BRANCHCITY" />
                <asp:BoundField DataField="BRANCHPHONE" HeaderText="Phone" SortExpression="PHONE" />
                <asp:BoundField DataField="BRANCHFAX" HeaderText="Fax" SortExpression="BRANCHFAX" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        SelectCommand="SELECT BRANCHX.BRANCHID, BRANCHX.BRANCHCODE, BRANCHX.BRANCHNAME, BRANCHX.BRANCHPHONE, BRANCHX.BRANCHFAX, BRANCHX.BRANCHADDRESS, BRANCHX.BRANCHCITY, '(' + AREA.AREACODE + ') ' + AREA.AREANAME AS AREA FROM BRANCHX WITH (nolock) INNER JOIN AREA WITH (nolock) ON BRANCHX.AREAID = AREA.AREAID WHERE (BRANCHX.Deletests = 0)"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>

    <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%" DataKeyNames="BRANCHID">
        <EditItemTemplate>
            <asp:Panel ID="pnlApprove" runat="server" Enabled="False">
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td colspan="2">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 19px">
                            ID</td>
                        <td style="height: 19px">
                            <asp:Label ID="lblBranchID" runat="server" Text='<%# Eval("BRANCHID") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Branch Code</td>
                        <td>
                            <asp:TextBox ID="txtBranchCode" runat="server" CssClass="disabled" 
                                MaxLength="5" ReadOnly="True" Text='<%# Bind("BRANCHCODE") %>' Width="48px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqCode" runat="server" 
                                ControlToValidate="txtBranchCode" Display="None" 
                                ErrorMessage="Branch Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECode" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Branch Name</td>
                        <td>
                            <asp:TextBox ID="txtBranchName" runat="server" CssClass="required" 
                                MaxLength="50" Text='<%# Bind("BRANCHNAME") %>' Width="240px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqBranchName" runat="server" 
                                ControlToValidate="txtBranchName" Display="None" 
                                ErrorMessage="Branch Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEName" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqBranchName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Branch Area</td>
                        <td>
                            <asp:DropDownList ID="ddlBranchArea" runat="server" CssClass="required" 
                                DataSourceID="sdsArea" DataTextField="AREANAME" DataValueField="AREAID" 
                                SelectedValue='<%# Bind("AREAID") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqArea" runat="server" 
                                ControlToValidate="ddlBranchArea" Display="None" 
                                ErrorMessage="Area must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEArea" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqArea">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Address</td>
                        <td>
                            <asp:TextBox ID="txtBranchAddress" runat="server" CssClass="required" 
                                Height="40px" Text='<%# Bind("BRANCHADDRESS") %>' TextMode="MultiLine" 
                                Width="280px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqAddress" runat="server" 
                                ControlToValidate="txtBranchAddress" Display="None" 
                                ErrorMessage="Address must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEAddress" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqAddress">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            City</td>
                        <td>
                            <asp:TextBox ID="txtBranchCity" runat="server" CssClass="required" 
                                MaxLength="30" Text='<%# Bind("BRANCHCITY") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqCity" runat="server" 
                                ControlToValidate="txtBranchCity" Display="None" 
                                ErrorMessage="City must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECity" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqCity">
                            </ajaxToolkit:ValidatorCalloutExtender>
                            Zip&nbsp;
                            <asp:TextBox ID="txtBranchZip" runat="server" MaxLength="10" 
                                Text='<%# Bind("BRANCHZIP") %>' Width="64px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            City ID</td>
                        <td>
                            <asp:DropDownList ID="ddlCityID" runat="server" CssClass="required" 
                                DataSourceID="sdsCity" DataTextField="CITY" DataValueField="CITYID" 
                                SelectedValue='<%# Bind("BRANCHDATI") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqCityID" runat="server" 
                                ControlToValidate="ddlCityID" Display="None" 
                                ErrorMessage="City ID must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECityID" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqCityID">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Phone Number</td>
                        <td>
                            <asp:TextBox ID="txtPhoneNo" runat="server" MaxLength="15" 
                                Text='<%# Bind("BRANCHPHONE") %>' Width="112px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Fax Number</td>
                        <td>
                            <asp:TextBox ID="txtFaxNo" runat="server" MaxLength="15" 
                                Text='<%# Bind("BRANCHFAX") %>' Width="112px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Branch Head</td>
                        <td>
                            <asp:TextBox ID="txtBranchHead" runat="server" Text='<%# Bind("BRANCHHEAD") %>' 
                                Width="192px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Branch Type</td>
                        <td>
                            <asp:DropDownList ID="ddlBranchType" runat="server" CssClass="required" 
                                DataSourceID="sdsBranchType" DataTextField="NAME" DataValueField="CODE" 
                                SelectedValue='<%# Bind("BRANCHTYPE") %>'>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Parent Branch</td>
                        <td>
                            <asp:DropDownList ID="ddlParentBranch" runat="server" 
                                DataSourceID="sdsParentGL" DataTextField="BRANCHNAME" DataValueField="BRANCHID" 
                                SelectedValue='<%# Bind("PARENTBRANCHID") %>'>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Branch COA</td>
                        <td>
                            <asp:DropDownList ID="ddlCOABranch" runat="server" CssClass="required" 
                                DataSourceID="sdsCOA" DataTextField="COA" DataValueField="COAID" 
                                SelectedValue='<%# Bind("BRANCHGL") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqBranchCOA" runat="server" 
                                ControlToValidate="ddlCOABranch" Display="None" 
                                ErrorMessage="Branch COA must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEBranchCOA" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqBranchCOA">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Parent Branch COA</td>
                        <td>
                            <asp:DropDownList ID="ddlCOAParent" runat="server" CssClass="required" 
                                DataSourceID="sdsCOA" DataTextField="COA" DataValueField="COAID" 
                                SelectedValue='<%# Bind("PARENTGL") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqParentCOA" runat="server" 
                                ControlToValidate="ddlCOAParent" Display="None" 
                                ErrorMessage="Parent Branch COA must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEParentCOA" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqParentCOA">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Working Days</td>
                        <td>
                            <asp:TextBox ID="txtWorkingDays" runat="server" CssClass="required" 
                                MaxLength="10" Text='<%# Bind("WORKINGDAYS") %>' Width="50px"></asp:TextBox>
                            &nbsp;day(s)<asp:RequiredFieldValidator ID="reqWorkingDays" runat="server" 
                                ControlToValidate="txtWorkingDays" Display="None" 
                                ErrorMessage="Working Days must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="reqWorkingDays_ValidatorCalloutExtender" 
                                runat="server" HighlightCssClass="ErrHighLight" 
                                TargetControlID="reqWorkingDays">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Penalty Type</td>
                        <td>
                            <asp:DropDownList ID="ddlPenaltyType" runat="server" CssClass="required" 
                                DataSourceID="sdsparentGL_penaltytype" DataTextField="NAME" 
                                DataValueField="CODE" SelectedValue='<%# Bind("PENALTYTYPE") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqPenaltyType" runat="server" 
                                ControlToValidate="ddlPenaltyType" Display="None" 
                                ErrorMessage="Penalty type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="reqPenaltyType_ValidatorCalloutExtender" 
                                runat="server" HighlightCssClass="ErrHighLight" 
                                TargetControlID="reqPenaltyType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Penalty Rate</td>
                        <td>
                            <asp:TextBox ID="txtPenaltyRate" runat="server" CssClass="required" 
                                MaxLength="10" Text='<%# Bind("PENALTYRATE") %>' Width="64px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqPenaltyRate" runat="server" 
                                ControlToValidate="txtPenaltyRate" Display="None" 
                                ErrorMessage="Penalty rate  must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="reqPenaltyRate_ValidatorCalloutExtender" 
                                runat="server" HighlightCssClass="ErrHighLight" 
                                TargetControlID="reqPenaltyRate">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            CRID</td>
                        <td>
                            <asp:DropDownList ID="ddlCRID" runat="server" DataSourceID="sdsValidCriteria" 
                                DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("CRID") %>'>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Grace Periode</td>
                        <td>
                            <asp:TextBox ID="txtGracePeriode" runat="server" CssClass="required" 
                                MaxLength="10" Text='<%# Bind("GRACEPERIOD") %>' Width="50px"></asp:TextBox>
                            &nbsp;day(s)<asp:RequiredFieldValidator ID="reqGracePeriode" runat="server" 
                                ControlToValidate="txtGracePeriode" Display="None" 
                                ErrorMessage="Grace Periode must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="reqGracePeriode_ValidatorCalloutExtender" 
                                runat="server" HighlightCssClass="ErrHighLight" 
                                TargetControlID="reqGracePeriode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            First Payment Type</td>
                        <td>
                            <asp:DropDownList ID="ddlFirstPaymentType" runat="server" CssClass="required" 
                                DataSourceID="sdsParentGL_FirstPaymentType" DataTextField="NAME" 
                                DataValueField="CODE" SelectedValue='<%# Bind("FIRSTPAYMENTTYPE") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqFirstPaymentType" runat="server" 
                                ControlToValidate="ddlFirstPaymentType" Display="None" 
                                ErrorMessage="First Payment type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="reqFirstPaymentType_ValidatorCalloutExtender" 
                                runat="server" HighlightCssClass="ErrHighLight" 
                                TargetControlID="reqFirstPaymentType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Payment Type</td>
                        <td>
                            <asp:DropDownList ID="ddlPaymentType" runat="server" CssClass="required" 
                                DataSourceID="sdsParentGL_PaymentType" DataTextField="NAME" 
                                DataValueField="CODE" SelectedValue='<%# Bind("PAYMENTTYPE") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqPaymentType" runat="server" 
                                ControlToValidate="ddlPaymentType" Display="None" 
                                ErrorMessage="Payment type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="reqPaymentType_ValidatorCalloutExtender" 
                                runat="server" HighlightCssClass="ErrHighLight" 
                                TargetControlID="reqPaymentType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                            &nbsp;Early Payment
                            <asp:RadioButton ID="rbEarlyPayment_yes" runat="server" 
                                Checked='<%# Bind("EARLYPAYMENT") %>' GroupName="rbEarlyPayment" Text="Yes" />
                            <asp:RadioButton ID="rbEarlyPayment_no" runat="server" Checked='<%# IIF(Eval("EARLYPAYMENT"), false, true) %>' 
                                GroupName="rbEarlyPayment" Text="No" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            ET Penalty Type</td>
                        <td>
                            <asp:DropDownList ID="ddlETpenaltyType" runat="server" CssClass="required" 
                                DataSourceID="sdsparentGL_penaltytype" DataTextField="NAME" 
                                DataValueField="CODE" SelectedValue='<%# Bind("ETPENALTYTYPE") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqETPenaltyType" runat="server" 
                                ControlToValidate="ddlETpenaltyType" Display="None" 
                                ErrorMessage="Penalty type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="reqETPenaltyType_ValidatorCalloutExtender" 
                                runat="server" HighlightCssClass="ErrHighLight" 
                                TargetControlID="reqETPenaltyType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                            &nbsp;ET Penalty<asp:TextBox ID="txtETPenalty" runat="server" CssClass="required" 
                                MaxLength="10" style="text-align: right" Text='<%# Bind("ETPENALTY") %>' 
                                Width="80px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqETPenalty" runat="server" 
                                ControlToValidate="txtETPenalty" Display="None" 
                                ErrorMessage="ET Penalty must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="reqETPenalty_ValidatorCalloutExtender" 
                                runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqETPenalty">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>

                    <tr>
                    <td>
                        Initial Approval</td>
                    <td>
                        <asp:DropDownList ID="ddlUID" runat="server" CssClass="required" DataSourceID="sdsInitApp"
                            DataTextField="UserID" DataValueField="UID" 
                            SelectedValue='<%# Bind("INITIALAPPROVER") %>' >
                           
                        </asp:DropDownList>
                    </td>
                </tr>
                    <tr>
                        <td>
                            ADM Terminate</td>
                        <td>
                            <asp:TextBox ID="txtADMterminate" runat="server" CssClass="required" 
                                MaxLength="15" style="text-align: right" Text='<%# Bind("ADMTERMINATE", "{0:N}") %>' 
                                Width="80px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="regADMterminate" runat="server" 
                                ControlToValidate="txtADMterminate" Display="None" 
                                ErrorMessage="Grace Periode must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="regADMterminate_ValidatorCalloutExtender" 
                                runat="server" HighlightCssClass="ErrHighLight" 
                                TargetControlID="regADMterminate">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Email</td>
                        <td>
                            <asp:TextBox ID="txtBranchEmail" runat="server" MaxLength="50" 
                                Text='<%# Bind("BRANCHEMAIL") %>' Width="240px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <hr />
                            &nbsp;</td>
                    </tr>                                  
            </asp:Panel>
                    <tr>
                        <td colspan="2">
                            &nbsp;<uc7:BtnApprovetNoSPV ID="BtnApprovetNoSPV1" runat="server" />
                            <uc8:BtnRejectNoSPV ID="BtnRejectNoSPV1" runat="server" />
                            <uc3:BtnCancel ID="BtnCancel3" runat="server" />
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
                    <td>
                        Branch Code</td>
                    <td>
                        <asp:TextBox ID="txtBranchCode" runat="server" MaxLength="5" Text='<%# Bind("BRANCHCODE") %>'
                            Width="48px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqCode"
                                runat="server" ControlToValidate="txtBranchCode" Display="None" ErrorMessage="Branch Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Branch Name</td>
                    <td>
                        <asp:TextBox ID="txtBranchName" runat="server" MaxLength="50" Text='<%# Bind("BRANCHNAME") %>'
                            Width="240px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqBranchName"
                                runat="server" ControlToValidate="txtBranchName" Display="None" ErrorMessage="Branch Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBranchName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Branch Area</td>
                    <td>
                        <asp:DropDownList ID="ddlBranchArea" runat="server" DataSourceID="sdsArea" DataTextField="AREANAME"
                            DataValueField="AREAID" SelectedValue='<%# Bind("AREAID") %>' CssClass="required">
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqArea" runat="server" ControlToValidate="ddlBranchArea"
                            Display="None" ErrorMessage="Area must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEArea" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqArea">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Address</td>
                    <td>
                        <asp:TextBox ID="txtBranchAddress" runat="server" Height="40px" TextMode="MultiLine" Width="280px" Text='<%# Bind("BRANCHADDRESS") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqAddress" runat="server" ControlToValidate="txtBranchAddress" Display="None"
                            ErrorMessage="Address must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEAddress" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAddress">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        City</td>
                    <td>
                        <asp:TextBox ID="txtBranchCity" runat="server" MaxLength="30" Text='<%# Bind("BRANCHCITY") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqCity" runat="server" ControlToValidate="txtBranchCity"
                            Display="None" ErrorMessage="City must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECity" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCity">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        Zip&nbsp;
                        <asp:TextBox ID="txtBranchZip" runat="server" MaxLength="10" Text='<%# Bind("BRANCHZIP") %>'
                            Width="64px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        City ID</td>
                    <td>
                        <asp:DropDownList ID="ddlCityID" runat="server" CssClass="required" DataSourceID="sdsCity"
                            DataTextField="CITY" DataValueField="CITYID" SelectedValue='<%# Bind("BRANCHDATI") %>'>
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqCityID" runat="server" ControlToValidate="ddlCityID"
                            Display="None" ErrorMessage="City ID must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECityID" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCityID">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Phone Number&nbsp;</td>
                    <td>
                        <asp:TextBox ID="txtPhoneNo" runat="server" MaxLength="15" Text='<%# Bind("BRANCHPHONE") %>'
                            Width="112px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        Fax</td>
                    <td>
                        <asp:TextBox ID="txtFaxNo" runat="server" MaxLength="15" Text='<%# Bind("BRANCHFAX") %>'
                            Width="112px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        Branch Head</td>
                    <td>
                        <asp:TextBox ID="txtBranchHead" runat="server" Text='<%# Bind("BRANCHHEAD") %>' Width="192px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        Branch Type</td>
                    <td>
                        <asp:DropDownList ID="ddlBranchType" runat="server" CssClass="required" DataSourceID="sdsBranchType"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("BRANCHTYPE") %>'>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Parent Branch</td>
                    <td>
                        <asp:DropDownList ID="ddlParentBranch" runat="server" DataSourceID="sdsParentGL"
                            DataTextField="BRANCHNAME" DataValueField="BRANCHID" SelectedValue='<%# Bind("PARENTBRANCHID") %>'>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Branch COA</td>
                    <td>
                        <asp:DropDownList ID="ddlCOABranch" runat="server" CssClass="required" DataSourceID="sdsCOA"
                            DataTextField="COA" DataValueField="COAID" SelectedValue='<%# Bind("BRANCHGL") %>'>
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqBranchCOA" runat="server" ControlToValidate="ddlCOABranch"
                            Display="None" ErrorMessage="Branch COA must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEBranchCOA" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBranchCOA">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        Parent Branch COA</td>
                    <td>
                        <asp:DropDownList ID="ddlCOAParent" runat="server" CssClass="required" DataSourceID="sdsCOA"
                            DataTextField="COA" DataValueField="COAID" SelectedValue='<%# Bind("PARENTGL") %>'>
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqParentCOA" runat="server" ControlToValidate="ddlCOAParent"
                            Display="None" ErrorMessage="Parent Branch COA must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEParentCOA" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqParentCOA">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        Working Days</td>
                    <td>
                        <asp:TextBox ID="txtWorkingDays" runat="server" CssClass="required" 
                            MaxLength="10" Text='<%# Bind("WORKINGDAYS") %>' Width="64px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqWorkingDays" runat="server" 
                            ControlToValidate="txtWorkingDays" Display="None" 
                            ErrorMessage="Working Days must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqWorkingDays_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqWorkingDays">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Penalty Type</td>
                    <td>
                        <asp:DropDownList ID="ddlPenaltyType" runat="server" CssClass="required" 
                            DataSourceID="sdsparentGL_penaltytype" DataTextField="NAME" 
                            DataValueField="CODE" SelectedValue='<%# Bind("PENALTYTYPE") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqPenaltyType" runat="server" 
                            ControlToValidate="ddlPenaltyType" Display="None" 
                            ErrorMessage="Penalty type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqPenaltyType_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqPenaltyType">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Penalty Rate</td>
                    <td>
                        <asp:TextBox ID="txtPenaltyRate" runat="server" CssClass="required" 
                            MaxLength="10" Text='<%# Bind("PENALTYRATE") %>' Width="64px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqPenaltyRate" runat="server" 
                            ControlToValidate="txtPenaltyRate" Display="None" 
                            ErrorMessage="Penalty rate  must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqPenaltyRate_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqPenaltyRate">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Branch Category</td>
                    <td>
                        <asp:DropDownList ID="ddlBranchCat" runat="server" CssClass="required" 
                            DataSourceID="sdsParentGL_BranchCat" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("BRANCHCAT") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqBranchCat" runat="server" 
                            ControlToValidate="ddlBranchCat" Display="None" 
                            ErrorMessage="Branch Cat must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqBranchCat_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBranchCat">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Initial Approval</td>
                    <td>
                              <asp:DropDownList ID="ddlUID" runat="server" CssClass="required" DataSourceID="sdsInitApp"
                            DataTextField="UserID" DataValueField="UID" 
                                  SelectedValue='<%# Bind("INITIALAPPROVER") %>' >
                           
                        </asp:DropDownList>
                    </td>
                </tr>


                <tr>
                    <td>
                        CRID</td>
                    <td>
                        <asp:DropDownList ID="ddlCRID" runat="server" DataSourceID="sdsValidCriteria" 
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("CRID") %>'>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Grace Periode</td>
                    <td>
                        <asp:TextBox ID="txtGracePeriode" runat="server" CssClass="required" 
                            MaxLength="10" Text='<%# Bind("GRACEPERIOD") %>' Width="64px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqGracePeriode" runat="server" 
                            ControlToValidate="txtGracePeriode" Display="None" 
                            ErrorMessage="Grace Periode must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqGracePeriode_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqGracePeriode">
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
    </asp:FormView>
    <asp:SqlDataSource ID="sdsCity" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS CITYID, NULL AS CITYCODE, '[CHOOSE CITY]' AS CITY UNION ALL SELECT CITYID, CITYCODE, CITYCODE + ' -  ' + CITYNAME AS CITY FROM CITY WITH (nolock) WHERE (DELETESTS = 0) ORDER BY CITYCODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsParentGL" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS BRANCHID, '[PARENT BRANCH]' AS BRANCHNAME UNION ALL SELECT BRANCHID, BRANCHCODE + ' -  ' + BRANCHNAME AS BRANCHNAME FROM BRANCH WITH (NOLOCK) WHERE (BRANCHTYPE = 1) AND (Deletests = 0)">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCOA" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS COAID, NULL AS COANO, '[CHOOSE COA]' AS COA UNION ALL SELECT COAID, COANO, COANO + ' -  ' + COANAME AS COA FROM COA WITH (NOLOCK) WHERE (DELETESTS = 0) AND (HARDCODE = 0) ORDER BY COANO">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsBranchType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS CODE, '[BRANCH TYPE]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'BRANCHTYPE') ORDER BY CODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT BRANCHID, (SELECT AREAID FROM AREA WHERE (AREAID = BRANCHX.AREAID) AND (DELETESTS = 0)) AS AREAID, BRANCHCODE, BRANCHNAME, BRANCHADDRESS, BRANCHCITY, BRANCHZIP, BRANCHHEAD, BRANCHPHONE, BRANCHFAX, BRANCHTYPE, (SELECT MIN(BRANCHID) AS Expr1 FROM BRANCH AS A WHERE (BRANCHID = BRANCHX.PARENTBRANCHID) AND (Deletests = 0) AND (BRANCHTYPE = 1)) AS PARENTBRANCHID, (SELECT COAID FROM COA WHERE (COAID = BRANCHX.BRANCHGL) AND (DELETESTS = 0)) AS BRANCHGL, (SELECT COAID FROM COA AS COA_1 WHERE (COAID = BRANCHX.PARENTGL) AND (DELETESTS = 0)) AS PARENTGL, (SELECT BRANCHX.BRANCHDATI FROM CITY WHERE (CITYID = BRANCHX.BRANCHDATI) AND (DELETESTS = 0)) AS BRANCHDATI, WORKINGDAYS, PENALTYTYPE, PENALTYRATE, BRANCHCAT, (SELECT CRID FROM VALIDCRITERIA WHERE (CRID = BRANCHX.CRID) AND (Deletests = 0)) AS CRID, GRACEPERIOD, PAYMENTTYPE, EARLYPAYMENT, ETPENALTYTYPE, ETPENALTY, ADMTERMINATE, FIRSTPAYMENTTYPE, BRANCHEMAIL, (SELECT BRANCHX.INITIALAPPROVER FROM APPUSER AS APPUSER_1 WHERE (UID = BRANCHX.INITIALAPPROVER) AND (Deletests = 0)) AS INITIALAPPROVER FROM BRANCHX WHERE (BRANCHID = @BRANCHID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="BRANCHID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

<asp:SqlDataSource ID="sdsArea" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                            
        SelectCommand="SELECT NULL AS AREAID, NULL AS AREACODE, '[CHOOSE AREA]' AS AREANAME UNION ALL SELECT AREAID, AREACODE, AREACODE + ' -  ' + AREANAME AS AREANAME FROM AREA WHERE (DELETESTS = 0) ORDER BY AREACODE">
                        </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsValidCriteria" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        
        
        SelectCommand="SELECT NULL AS CODE, NULL AS CRCODE, '[CHOOSE VALIDATION CRITERIA]' AS NAME UNION ALL SELECT CRID, CRCODE, CRCODE + ' -  ' + CRNAME AS NAME FROM VALIDCRITERIA WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY CRCODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsparentGL_penaltytype" runat="server" 
        
        SelectCommand="SELECT NULL AS CODE, '[PENALTY TYPE]' AS NAME UNION ALL SELECT CODE, CODE + ' -  ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'PENALTYTYPE') ORDER BY CODE" 
        ConnectionString="<%$ ConnectionStrings:connection %>">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsParentGL_BranchCat" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        
        SelectCommand="SELECT NULL AS CODE, '[BRANCH CATEGORY]' AS NAME UNION ALL SELECT CODE, CODE + ' -  ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'BRANCHCAT') ORDER BY CODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsParentGL_PaymentType" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        
    
        SelectCommand="SELECT NULL AS CODE, '[PAYMENT TYPE]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JFPAYMENTTYPE') ORDER BY CODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsParentGL_FirstPaymentType" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        SelectCommand="SELECT NULL AS CODE, '[SELECT FIRST PAYMENT TYPE]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JFFIRSTPAYMENTTYPE')"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsInitApp" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        
        
        
        
        
        
        SelectCommand="SELECT NULL AS UID, '[INITIAL APPROVAL]' AS UserID UNION ALL SELECT UID, UserID + ' - ' + UserName AS UserId FROM APPUSER WITH (nolock) WHERE (Deletests = '0') ORDER BY UserID"></asp:SqlDataSource>

    &nbsp; &nbsp; &nbsp;&nbsp;
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript">
TabToEnter();
FormatTable("<%=gvData.ClientID%>")
</script>

                </asp:Content>

