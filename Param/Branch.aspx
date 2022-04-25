<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="Branch.aspx.vb" Inherits="Param_Branch" title="Branch" %>
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
        ImageControlID="imgButtonShow" TargetControlID="pnlData" TextLabelID="lblShow">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlData" runat="server">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td style="width: 115px" class="RowStyle">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="BranchName">Branch Name</asp:ListItem>
        <asp:ListItem Value="BranchCode">Branch Code</asp:ListItem>
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
        <asp:DropDownList ID="ddlAreaSearch" runat="server" DataSourceID="sdsAreaSearch"
            DataTextField="AREA" DataValueField="AREAID" AutoPostBack="True">
        </asp:DropDownList><asp:SqlDataSource ID="sdsAreaSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            
                        SelectCommand="SELECT NULL AS AREAID, NULL AS AREACODE, 'ALL AREA' AS AREA UNION ALL SELECT AREAID, AREACODE, AREACODE + ' - ' + AREANAME AS AREA FROM AREA WITH (NOLOCK) WHERE (DELETESTS = 0) ORDER BY AREACODE">
        </asp:SqlDataSource>
                </td>
            </tr>
        </table>

    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CommandName="New" CausesValidation="False" />
    </asp:Panel>
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="BRANCHID" DataSourceID="sdsGrid" 
            Width="100%" Caption="Branch List" RowHeaderColumn="BRANCHID">
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" 
                            CommandName="Select" ImageUrl="../Images/edit.gif" Text="Select" 
                            Visible='<%# Not Eval("NEW") %>' />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                </asp:TemplateField>
                <asp:BoundField DataField="BRANCHID" HeaderText="ID" 
                    SortExpression="BRANCHID" />
                <asp:BoundField DataField="AREA" HeaderText="Area" SortExpression="AREA" />
                <asp:BoundField DataField="BRANCHCODE" HeaderText="Code" 
                    SortExpression="BRANCHCODE" />
                <asp:BoundField DataField="BRANCHNAME" HeaderText="Name" 
                    SortExpression="BRANCHNAME" />
                <asp:BoundField DataField="BRANCHADDRESS" HeaderText="Address" 
                    SortExpression="BRANCHADDR" />
                <asp:BoundField DataField="BRANCHCITY" HeaderText="City" 
                    SortExpression="BRANCHCITY" />
                <asp:BoundField DataField="BRANCHPHONE" HeaderText="Phone" 
                    SortExpression="PHONE" />
                <asp:BoundField DataField="BRANCHFAX" HeaderText="Fax" 
                    SortExpression="BRANCHFAX" />
  
                
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            
        
        SelectCommand="SELECT AREAID, BRANCHID, BRANCHCODE, BRANCHNAME, BRANCHPHONE, BRANCHFAX, BRANCHADDRESS, BRANCHCITY, AREA, NEW, Deletests, UPD FROM (SELECT BRANCH_1.BRANCHID, BRANCH_1.AREAID, BRANCH_1.BRANCHCODE, BRANCH_1.BRANCHNAME, BRANCH_1.BRANCHPHONE, BRANCH_1.BRANCHFAX, BRANCH_1.BRANCHADDRESS, BRANCH_1.BRANCHCITY, '(' + AREA.AREACODE + ') ' + AREA.AREANAME AS AREA, CAST(0 AS BIT) AS NEW, BRANCH_1.Deletests, CASE WHEN EXISTS (SELECT 'X' FROM BRANCHX WHERE BRANCH_1.BRANCHID = BRANCHX.BRANCHID) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS UPD FROM BRANCH AS BRANCH_1 INNER JOIN AREA WITH (NOLOCK) ON BRANCH_1.AREAID = AREA.AREAID WHERE (BRANCH_1.Deletests = 0) UNION ALL SELECT BRANCHX.BRANCHID, BRANCHX.AREAID, BRANCHX.BRANCHCODE, BRANCHX.BRANCHNAME, BRANCHX.BRANCHPHONE, BRANCHX.BRANCHFAX, BRANCHX.BRANCHADDRESS, BRANCHX.BRANCHCITY, '(' + AREA_1.AREACODE + ') ' + AREA_1.AREANAME AS AREA, CAST(1 AS BIT) AS NEW, BRANCHX.Deletests, CAST(0 AS BIT) AS UPD FROM BRANCHX INNER JOIN AREA AS AREA_1 WITH (NOLOCK) ON BRANCHX.AREAID = AREA_1.AREAID WHERE (BRANCHX.Deletests = 0) AND (NOT EXISTS (SELECT 'X' AS EXPR1 FROM BRANCH AS BRANCH_2 WHERE (BRANCHID = BRANCHX.BRANCHID)))) AS BRANCH WHERE (Deletests = 0)"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>

    <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%" DataKeyNames="BRANCHID">
        <InsertItemTemplate>
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
                        <asp:Label ID="lblBranchID" runat="server" Text='<%# Eval("BRANCHID") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        Branch Code</td>
                    <td>
                        <asp:TextBox ID="txtBranchCode" runat="server" CssClass="required" 
                            MaxLength="5" Text='<%# Bind("BRANCHCODE") %>' Width="48px"></asp:TextBox>
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
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        Working Days</td>
                    <td>
                        <asp:TextBox ID="txtWorkingDays" runat="server" CssClass="required" 
                            MaxLength="10" Text='<%# Bind("WORKINGDAYS") %>' Width="64px"></asp:TextBox>
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
                        &nbsp;Penalty Rate
                        <asp:TextBox ID="txtPenaltyRate" runat="server" CssClass="required" 
                            MaxLength="10" Text='<%# Bind("PENALTYRATE") %>' Width="64px" 
                            style="text-align: right"></asp:TextBox>
                        &nbsp;<asp:RequiredFieldValidator ID="reqPenaltyRate" runat="server" 
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
                        Validation Criteria</td>
                    <td>
                        <asp:DropDownList ID="ddlCRID" runat="server" DataSourceID="sdsValidCriteria" 
                            DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("CRID") %>' CssClass="required">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqCRID" runat="server" 
                            ControlToValidate="ddlCRID" Display="None" 
                            ErrorMessage="CRID must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqCRID_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCRID">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Grace Periode</td>
                    <td>
                        <asp:TextBox ID="txtGracePeriode" runat="server" CssClass="required" 
                            MaxLength="10" Text='<%# Bind("GRACEPERIOD") %>' Width="50px" 
                            style="text-align: right"></asp:TextBox>
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
                        <asp:RadioButton ID="rbEarlyPayment_no" runat="server" Checked="True" 
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
                            MaxLength="10" Text='<%# Bind("ETPENALTY") %>' Width="64px" style="text-align: right" 
                            ></asp:TextBox>
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
                        Initial Approver</td>
                    <td>
                        <asp:DropDownList ID="ddlUID" runat="server" DataSourceID="SdsInitApp"
                            DataTextField="UserName" DataValueField="UserId" 
                            SelectedValue='<%# Bind("INITIALAPPROVER") %>' >
                          </asp:DropDownList>
                    </td>
                     <tr>
                         <td>
                             ADM Terminate</td>
                         <td>
                             <asp:TextBox ID="txtADMterminate" runat="server" CssClass="required" 
                                 MaxLength="15" Text='<%# Bind("ADMTERMINATE", "{0:N}") %>' Width="90px"></asp:TextBox>
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
                     <tr>
                         <td colspan="2">
                             <uc4:BtnInsert ID="BtnInsert1" runat="server" />
                             <uc3:BtnCancel ID="BtnCancel2" runat="server" />
                         </td>
                     </tr>
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
                        <asp:Label ID="lblBranchID" runat="server" Text='<%# Eval("BRANCHID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td style="height: 26px">
                        Branch Code</td>
                    <td style="height: 26px">
                        <asp:TextBox ID="txtBranchCode" runat="server" MaxLength="5" Text='<%# Bind("BRANCHCODE") %>'
                            Width="48px" CssClass="disabled" ReadOnly="True"></asp:TextBox><asp:RequiredFieldValidator ID="reqCode"
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
                        <asp:TextBox ID="txtBranchAddress" runat="server" CssClass="required" 
                            Height="40px" Text='<%# Bind("BRANCHADDRESS") %>' TextMode="MultiLine" 
                            Width="280px"></asp:TextBox>
                        <asp:RequiredFieldValidator
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
                        <asp:TextBox ID="txtBranchCity" runat="server" MaxLength="30" Text='<%# Bind("BRANCHCITY") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCity" runat="server" ControlToValidate="txtBranchCity" Display="None"
                            ErrorMessage="City must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
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
                        Phone Number</td>
                    <td>
                        <asp:TextBox ID="txtPhoneNo" runat="server" MaxLength="15" Text='<%# Bind("BRANCHPHONE") %>'
                            Width="112px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        Fax Number</td>
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
                        </asp:DropDownList><asp:RequiredFieldValidator
                            ID="reqBranchCOA" runat="server" ControlToValidate="ddlCOABranch" Display="None"
                            ErrorMessage="Branch COA must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEBranchCOA" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBranchCOA">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Parent Branch COA</td>
                    <td>
                        <asp:DropDownList ID="ddlCOAParent" runat="server" CssClass="required" DataSourceID="sdsCOA"
                            DataTextField="COA" DataValueField="COAID" SelectedValue='<%# Bind("PARENTGL") %>'>
                        </asp:DropDownList><asp:RequiredFieldValidator
                            ID="reqParentCOA" runat="server" ControlToValidate="ddlCOAParent" Display="None"
                            ErrorMessage="Parent Branch COA must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEParentCOA" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqParentCOA">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Working Days</td>
                    <td>
                        <asp:TextBox ID="txtWorkingDays" runat="server" CssClass="required" 
                            MaxLength="10" Text='<%# Bind("WORKINGDAYS") %>' Width="50px" 
                            style="text-align: right"></asp:TextBox>
                        &nbsp;day(s)
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
                            MaxLength="10" Text='<%# Bind("PENALTYRATE") %>' Width="64px" 
                            style="text-align: right"></asp:TextBox>
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
                        Validation Criteria</td>
                    <td>
                        <asp:DropDownList ID="ddlCRID" runat="server" CssClass="required" 
                            DataSourceID="sdsValidCriteria" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("CRID") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqCRID" runat="server" 
                            ControlToValidate="ddlCRID" Display="None" 
                            ErrorMessage="CRID must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqCRID_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCRID">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Grace Periode</td>
                    <td>
                        <asp:TextBox ID="txtGracePeriode" runat="server" CssClass="required" 
                            MaxLength="10" Text='<%# Bind("GRACEPERIOD") %>' Width="50px" 
                            style="text-align: right"></asp:TextBox>
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
                            MaxLength="10" Text='<%# Bind("ETPENALTY") %>' Width="64px" 
                            style="text-align: right"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqETPenalty" runat="server" 
                            ControlToValidate="txtETPenalty" Display="None" 
                            ErrorMessage="ET Penalty must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqETPenalty_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqETPenalty">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                <tr>
                    <td>
                        Initial Approver</td>
                    <td>
                        <asp:DropDownList ID="ddlUID" runat="server" DataSourceID="sdsInitApp"
                            DataTextField="UserName" DataValueField="UserId" 
                            SelectedValue='<%# Bind("INITIALAPPROVER") %>' >
                           
                        </asp:DropDownList>
                    </td>
                </tr></tr>


                <tr>
                    <td>
                        ADM Terminate</td>
                    <td>
                        <asp:TextBox ID="txtADMterminate" runat="server" CssClass="required" 
                            MaxLength="10" Width="64px" 
                            style="text-align: right" Text='<%# Bind("ADMTERMINATE", "{0:N}") %>'></asp:TextBox>
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
        
        SelectCommand="SELECT BRANCHID, (SELECT AREAID FROM AREA WHERE (AREAID = BRANCH.AREAID) AND (DELETESTS = 0)) AS AREAID, BRANCHCODE, BRANCHNAME, BRANCHADDRESS, BRANCHCITY, BRANCHZIP, BRANCHHEAD, BRANCHPHONE, BRANCHFAX, BRANCHTYPE, WORKINGDAYS, PENALTYTYPE, PENALTYRATE, PAYMENTTYPE, BRANCHCAT, (SELECT CRID FROM VALIDCRITERIA WHERE (CRID = BRANCH.CRID) AND (Deletests = 0)) AS CRID, GRACEPERIOD, EARLYPAYMENT, ETPENALTYTYPE, ETPENALTY, ADMTERMINATE, (SELECT MIN(BRANCHID) AS Expr1 FROM BRANCH AS A WHERE (BRANCHID = BRANCH.PARENTBRANCHID) AND (Deletests = 0) AND (BRANCHTYPE = 1)) AS PARENTBRANCHID, (SELECT COAID FROM COA WHERE (COAID = BRANCH.BRANCHGL) AND (DELETESTS = 0) AND (HARDCODE = 0)) AS BRANCHGL, (SELECT COAID FROM COA AS COA_1 WHERE (COAID = BRANCH.PARENTGL) AND (DELETESTS = 0) AND (HARDCODE = 0)) AS PARENTGL, (SELECT BRANCH.BRANCHDATI FROM CITY WHERE (CITYID = BRANCH.BRANCHDATI) AND (DELETESTS = 0)) AS BRANCHDATI, FIRSTPAYMENTTYPE, BRANCHEMAIL, (SELECT BRANCH.INITIALAPPROVER FROM APPUSER WHERE (UID = BRANCH.INITIALAPPROVER) AND (Deletests = 0)) AS INITIALAPPROVER FROM BRANCH WHERE (BRANCHID = @BranchID) AND (NOT EXISTS (SELECT 'x' AS Expr1 FROM BRANCHX WHERE (BRANCHID = BRANCH.BRANCHID))) UNION ALL SELECT BRANCHID, (SELECT AREAID FROM AREA AS AREA_1 WHERE (AREAID = BRANCHX_1.AREAID) AND (DELETESTS = 0)) AS AREAID, BRANCHCODE, BRANCHNAME, BRANCHADDRESS, BRANCHCITY, BRANCHZIP, BRANCHHEAD, BRANCHPHONE, BRANCHFAX, BRANCHTYPE, WORKINGDAYS, PENALTYTYPE, PENALTYRATE, PAYMENTTYPE, BRANCHCAT, (SELECT CRID FROM VALIDCRITERIA AS VALIDCRITERIA_1 WHERE (CRID = BRANCHX_1.CRID) AND (Deletests = 0)) AS CRID, GRACEPERIOD, EARLYPAYMENT, ETPENALTYTYPE, ETPENALTY, ADMTERMINATE, (SELECT MIN(BRANCHID) AS Expr1 FROM BRANCH AS A WHERE (BRANCHID = BRANCHX_1.PARENTBRANCHID) AND (Deletests = 0) AND (BRANCHTYPE = 1)) AS PARENTBRANCHID, (SELECT COAID FROM COA AS COA_2 WHERE (COAID = BRANCHX_1.BRANCHGL) AND (DELETESTS = 0) AND (HARDCODE = 0)) AS BRANCHGL, (SELECT COAID FROM COA AS COA_1 WHERE (COAID = BRANCHX_1.PARENTGL) AND (DELETESTS = 0) AND (HARDCODE = 0)) AS PARENTGL, (SELECT BRANCHX_1.BRANCHDATI FROM CITY AS CITY_1 WHERE (CITYID = BRANCHX_1.BRANCHDATI) AND (DELETESTS = 0)) AS BRANCHDATI, FIRSTPAYMENTTYPE, BRANCHEMAIL, (SELECT BRANCHX_1.INITIALAPPROVER FROM APPUSER AS APPUSER_1 WHERE (UID = BRANCHX_1.INITIALAPPROVER) AND (Deletests = 0)) AS INITIALAPPROVER FROM BRANCHX AS BRANCHX_1 WHERE (BRANCHID = @BranchID)" 
        DeleteCommand="UPDATE BRANCH SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID&#13;&#10;WHERE BRANCHiD=@BranchID" 
        UpdateCommand="BranchUpdate" InsertCommand="BranchAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="BranchID" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="BRANCHID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="BRANCHID" Type="Int32" />
            <asp:Parameter Name="AREAID" Type="Int16" />
            <asp:Parameter Name="BRANCHTYPE" Type="Int16" />
            <asp:Parameter Name="BRANCHCODE" Type="String" />
            <asp:Parameter Name="BRANCHNAME" Type="String" />
            <asp:Parameter Name="BRANCHADDRESS" Type="String" />
            <asp:Parameter Name="BRANCHCITY" Type="String" />
            <asp:Parameter Name="BRANCHZIP" Type="String" />
            <asp:Parameter Name="BRANCHHEAD" Type="String" />
            <asp:Parameter Name="BRANCHPHONE" Type="String" />
            <asp:Parameter Name="BRANCHFAX" Type="String" />
            <asp:Parameter Name="SERVICETYPE" Type="Int16" />
            <asp:Parameter Name="PARENTBRANCHID" Type="Int32" />
            <asp:Parameter Name="BRANCHGL" Type="Int32" />
            <asp:Parameter Name="PARENTGL" Type="Int32" />
            <asp:Parameter Name="BRANCHDATI" Type="Int32" />
            <asp:Parameter Name="WORKINGDAYS" Type="Int32" />
            <asp:Parameter Name="PENALTYTYPE" Type="Int32" />
            <asp:Parameter Name="PENALTYRATE" Type="Double" />
            <asp:Parameter Name="BRANCHCAT" Type="Int32" DefaultValue="1" />
            <asp:Parameter Name="INITIALAPPROVER" Type="Int32" />
            <asp:Parameter Name="CRID" Type="Int32" />
            <asp:Parameter Name="GRACEPERIOD" Type="Int32" />
            <asp:Parameter Name="PAYMENTTYPE" Type="Int16" />
            <asp:Parameter Name="EARLYPAYMENT" Type="Boolean" />
            <asp:Parameter Name="ETPENALTYTYPE" Type="Int16" />
            <asp:Parameter Name="ETPENALTY" Type="Double" />
            <asp:Parameter Name="ADMTERMINATE" Type="Double" />
            <asp:Parameter Name="FIRSTPAYMENTTYPE" Type="Int32" />             
            <asp:Parameter Name="BRANCHEMAIL" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="AREAID" Type="Int16" />
            <asp:Parameter Name="BRANCHTYPE" Type="Int16" />
            <asp:Parameter Name="BRANCHCODE" Type="String" />
            <asp:Parameter Name="BRANCHNAME" Type="String" />
            <asp:Parameter Name="BRANCHADDRESS" Type="String" />
            <asp:Parameter Name="BRANCHCITY" Type="String" />
            <asp:Parameter Name="BRANCHZIP" Type="String" />
            <asp:Parameter Name="BRANCHHEAD" Type="String" />
            <asp:Parameter Name="BRANCHPHONE" Type="String" />
            <asp:Parameter Name="BRANCHFAX" Type="String" />
            <asp:Parameter Name="PARENTBRANCHID" Type="Int32" />
            <asp:Parameter Name="BRANCHGL" Type="Int32" />
            <asp:Parameter Name="PARENTGL" Type="Int32" />
            <asp:Parameter Name="BRANCHDATI" Type="Int32" />
            <asp:Parameter Name="WORKINGDAYS" Type="Int32" />
            <asp:Parameter Name="PENALTYTYPE" Type="Int32" />
            <asp:Parameter Name="PENALTYRATE" Type="Int32" />
            <asp:Parameter Name="BRANCHCAT" Type="Int32" DefaultValue="1" />
            <asp:Parameter Name="INITIALAPPROVER" Type="Int32" />
            <asp:Parameter Name="CRID" Type="Int32" />
            <asp:Parameter Name="GRACEPERIOD" Type="Int32" />
            <asp:Parameter Name="PAYMENTTYPE" Type="Int32" />
            <asp:Parameter Name="EARLYPAYMENT" Type="Boolean" />
            <asp:Parameter Name="ETPENALTYTYPE" Type="Int32" />
            <asp:Parameter Name="ETPENALTY" Type="Double" />
            <asp:Parameter Name="ADMTERMINATE" Type="Decimal" />
            <asp:Parameter Name="FIRSTPAYMENTTYPE" Type="Int32" />
            <asp:Parameter Name="BRANCHEMAIL" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="BRANCHID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
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
        
        
        
        
        
        
        SelectCommand="SELECT NULL AS UserId, '[INITIAL APPROVER]' AS UserName UNION ALL SELECT UID, CAST(UserID AS varchar(20)) + ' - ' + UserName AS UserName FROM APPUSER WITH (nolock) WHERE (Deletests = '0') ORDER BY UserID"></asp:SqlDataSource>

</asp:Content>

