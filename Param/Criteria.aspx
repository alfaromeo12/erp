<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="Criteria.aspx.vb" Inherits="Param_Reason" title="Reason Reject" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td style="width: 160px">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="CRNAME">Criteria Name</asp:ListItem>
        <asp:ListItem Value="CRCODE">Criteria Code</asp:ListItem>
    </asp:DropDownList></td>
            <td>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /></td>
        </tr>
        <tr>
            <td style="width: 160px">
                Interest Scheme</td>
            <td>
                <asp:DropDownList ID="ddlInterestSearch" runat="server" AutoPostBack="True" DataSourceID="sdsInterestSearch"
                    DataTextField="INTERESTNAME" DataValueField="INTERESTID">
                </asp:DropDownList><asp:SqlDataSource ID="sdsInterestSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    
                    SelectCommand="SELECT NULL AS INTERESTID, '[DISPLAY ALL]' AS INTERESTNAME UNION ALL SELECT INTERESTID, INTERESTNAME FROM VALIDINTEREST WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY INTERESTNAME">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td style="width: 160px">
                Tenor Scheme</td>
            <td>
                <asp:DropDownList ID="ddlTenorSearch" runat="server" AutoPostBack="True" DataSourceID="sdsTenorSearch"
                    DataTextField="TENORNAME" DataValueField="TENORID">
                </asp:DropDownList><asp:SqlDataSource ID="sdsTenorSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    
                    SelectCommand="SELECT NULL AS TENORID, '[DISPLAY ALL]' AS TENORNAME UNION ALL SELECT TENORID, TENORNAME FROM VALIDTENOR WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY TENORNAME">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td style="width: 160px">
                Down Payment Scheme</td>
            <td>
                <asp:DropDownList ID="ddlDPSearch" runat="server" AutoPostBack="True" DataSourceID="sdsDPSearch"
                    DataTextField="DPVALIDNAME" DataValueField="DPID">
                </asp:DropDownList><asp:SqlDataSource ID="sdsDPSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    
                    SelectCommand="SELECT NULL AS DPID, '[DISPLAY ALL]' AS DPVALIDNAME UNION ALL SELECT DPID, DPVALIDNAME FROM VALIDDP WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY DPVALIDNAME">
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>

    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False" CssClass="New" /><br />
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
            AutoGenerateColumns="False" Caption="VALIDATION CRITERIA LIST" DataKeyNames="CRID"
            DataSourceID="sdsGrid" RowHeaderColumn="CRID" Width="100%">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/edit.gif" ShowSelectButton="True">
                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:CommandField>
                <asp:BoundField DataField="CRID" HeaderText="ID" ReadOnly="True" SortExpression="CRID" />
                <asp:BoundField DataField="CRCODE" HeaderText="Code" SortExpression="CRCODE" />
                <asp:BoundField DataField="CRNAME" HeaderText="Name" SortExpression="CRNAME" />
                <asp:BoundField DataField="DPVALIDNAME" HeaderText="Valid&lt;br&gt;DP" HtmlEncode="False"
                    SortExpression="DPVALIDNAME" />
                <asp:BoundField DataField="TENORNAME" HeaderText="Valid&lt;br&gt;Tenor" HtmlEncode="False"
                    SortExpression="TENORNAME" />
                <asp:BoundField DataField="INTERESTNAME" HeaderText="Valid&lt;br&gt;Interest" HtmlEncode="False"
                    SortExpression="INTERESTNAME" />
                <asp:BoundField DataField="MAXIMUMLOAN" DataFormatString="{0:N}" HeaderText="Max.&lt;br&gt;Loan"
                    HtmlEncode="False" SortExpression="MAXIMUMLOAN">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="DSR" HeaderText="DSR&lt;br&gt;(%)" HtmlEncode="False"
                    SortExpression="DSR">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="DESCRIPTION" HeaderText="Description" SortExpression="DESCRIPTION" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT VALIDCRITERIA.CRID, VALIDCRITERIA.CRCODE, VALIDCRITERIA.CRNAME, VALIDCRITERIA.DESCRIPTION, VALIDDP.DPVALIDNAME, VALIDTENOR.TENORNAME, VALIDINTEREST.INTERESTNAME, VALIDCRITERIA.MAXIMUMLOAN, VALIDCRITERIA.DSR FROM VALIDCRITERIA LEFT OUTER JOIN VALIDDP ON VALIDCRITERIA.DPID = VALIDDP.DPID LEFT OUTER JOIN VALIDTENOR ON VALIDCRITERIA.TENORID = VALIDTENOR.TENORID LEFT OUTER JOIN VALIDINTEREST ON VALIDCRITERIA.INTERESTID = VALIDINTEREST.INTERESTID WHERE (VALIDCRITERIA.Deletests = 0)">
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
    <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%" DataKeyNames="CRID">
        <EditItemTemplate><table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                    CR
                        ID</td>
                <td colspan="3">
                    <asp:Label ID="lblCRID" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("CRID") %>'></asp:Label></td>
            </tr>
            <tr>
                <td>
                    Code</td>
                <td colspan="3">
                    <asp:TextBox ID="CRCODETextBox" runat="server" CssClass="required" MaxLength="10"
                        Text='<%# Bind("CRCODE") %>' Width="64px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="CRCODETextBox" Display="None"
                            ErrorMessage="Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Name</td>
                <td colspan="3">
                    <asp:TextBox ID="CRNAMETextBox" runat="server" CssClass="required" MaxLength="100"
                        Text='<%# Bind("CRNAME") %>' Width="384px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="CRNAMETextBox" Display="None"
                            ErrorMessage="Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="ShowDetail">
                    Scheme Validation</td>
                <td colspan="3">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    Interest Scheme</td>
                <td colspan="3">
                    <asp:DropDownList ID="ddlValidInterest" runat="server" CssClass="required" DataSourceID="sdsValidInterest"
                        DataTextField="INTERESTNAME" DataValueField="INTERESTID" SelectedValue='<%# Bind("INTERESTID") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqInterest" runat="server" ControlToValidate="ddlValidInterest"
                        Display="None" ErrorMessage="Interest Scheme must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEInterest" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqInterest">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Tenor Scheme</td>
                <td colspan="3">
                    <asp:DropDownList ID="ddlValidTenor" runat="server" CssClass="required" DataSourceID="sdsValidTenor"
                        DataTextField="TENORNAME" DataValueField="TENORID" SelectedValue='<%# Bind("TENORID") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqTenor" runat="server" ControlToValidate="ddlValidTenor"
                        Display="None" ErrorMessage="Tenor Scheme must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCETenor" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqTenor">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Down Payment Scheme</td>
                <td colspan="3">
                    <asp:DropDownList ID="ddlValidDP" runat="server" CssClass="required" DataSourceID="sdsValidDP"
                        DataTextField="DPVALIDNAME" DataValueField="DPID" SelectedValue='<%# Bind("DPID") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqDP" runat="server" ControlToValidate="ddlValidDP"
                        Display="None" ErrorMessage="Down Payment Scheme must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEDP" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDP">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Maximum Loan</td>
                <td>
                    <asp:TextBox ID="txtMaxLoan" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("MAXIMUMLOAN", "{0:N}") %>' Width="96px" MaxLength="17"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqMaxLoan" runat="server" ControlToValidate="txtMaxLoan" Display="None"
                            ErrorMessage="Minimum Loan must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEMaxLoan" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxLoan">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Allow Used Vehicle</td>
                <td>
                    <asp:CheckBox ID="cbUsedCar" runat="server" Checked='<%# Bind("USEDCAR") %>' CssClass="FooterStyle"
                        Text="Checked if allow used vehicle(car)." /></td>
            </tr>
            <tr>
                <td class="ShowDetail">
                    Installment Deviation</td>
                <td colspan="3">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    Min. Dev.</td>
                <td>
                    <asp:TextBox ID="txtMinInstDev" runat="server" CssClass="required" MaxLength="6"
                        Style="text-align: right" Text='<%# Bind("MINDEVINSTALLMENT", "{0:N}") %>' Width="96px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqMinInstDev" runat="server" ControlToValidate="txtMinInstDev" Display="None"
                            ErrorMessage="Minimum Installment Deviation must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEMinInstDev" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinInstDev">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Max Dev.</td>
                <td>
                    <asp:TextBox ID="txtMaxInstDev" runat="server" CssClass="required" MaxLength="6"
                        Style="text-align: right" Text='<%# Bind("MAXDEVINSTALLMENT", "{0:N}") %>'
                        Width="88px"></asp:TextBox><asp:RequiredFieldValidator ID="reqMaxInstDev" runat="server"
                            ControlToValidate="txtMaxInstDev" Display="None" ErrorMessage="Maximum Installment Deviation must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEMaxInstDev" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxInstDev">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="ShowDetail">
                    Age Validation</td>
                <td colspan="3">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    Marital Status Age Checking</td>
                <td colspan="3">
                    <asp:CheckBox ID="cbMaritalStatus" runat="server" Checked='<%# Bind("AGECHECK") %>'
                        CssClass="FooterStyle" Text="Check this box for checking Age for Single Marital Status, if not check, age validation for all customer" /></td>
            </tr>
            <tr>
                <td>
                    Min (year)</td>
                <td>
                    <asp:TextBox ID="MINAGETextBox" runat="server" CssClass="required" MaxLength="6"
                        Style="text-align: right" Text='<%# Bind("MINAGE", "{0:N2}") %>' Width="64px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqMinAge" runat="server" ControlToValidate="MINAGETextBox" Display="None"
                            ErrorMessage="Minimum Age must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEMinAge" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinAge">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Max (year)</td>
                <td>
                    <asp:TextBox ID="MAXAGETextBox" runat="server" CssClass="required" MaxLength="6"
                        Style="text-align: right" Text='<%# Bind("MAXAGE", "{0:N2}") %>' Width="64px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqMaxAge" runat="server" ControlToValidate="MAXAGETextBox" Display="None"
                            ErrorMessage="Maximum Age must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEMaxAge" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxAge">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="ShowDetail">
                    Working Time Validation</td>
                <td colspan="3">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    Min (year)</td>
                <td>
                    <asp:TextBox ID="MINWORKTextBox" runat="server" CssClass="required" MaxLength="6"
                        Style="text-align: right" Text='<%# Bind("MINWORK", "{0:N2}") %>' Width="64px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqMinWork" runat="server" ControlToValidate="MINWORKTextBox" Display="None"
                            ErrorMessage="Minimum Working Time must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEMinWork" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinWork">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Max (year)</td>
                <td>
                    <asp:TextBox ID="MAXWORKTextBox" runat="server" CssClass="required" MaxLength="6"
                        Style="text-align: right" Text='<%# Bind("MAXWORK", "{0:N2}") %>' Width="64px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqMaxWork" runat="server" ControlToValidate="MAXWORKTextBox" Display="None"
                            ErrorMessage="Maximum Working Time must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEMaxWork" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxWork">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="ShowDetail">
                    Employee&nbsp; Validation</td>
                <td colspan="3">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    Employe Status</td>
                <td>
                    <asp:DropDownList ID="ddlEmpSts" runat="server" CssClass="required" DataSourceID="sdsEMPStatys"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("EMPLOYEESTS") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqEmpSts" runat="server" ControlToValidate="ddlEmpSts"
                        Display="None" ErrorMessage="Employee Status must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEEmpSts" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqEmpSts">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Contract end (month)</td>
                <td>
                    <asp:TextBox ID="MINCONTRACTENDTextBox" runat="server" Style="text-align: right" 
                        Text='<%# Bind("MINCONTRACTEND", "{0:N2}") %>' Width="72px" MaxLength="3"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqContractEnd" runat="server" ControlToValidate="MINCONTRACTENDTextBox"
                            Display="None" ErrorMessage="Contract End must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEContractEnd" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqContractEnd">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Min Income (Salary)</td>
                <td colspan="3">
                    <asp:TextBox ID="MININCOMETextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("MININCOME", "{0:N2}") %>'></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqMinINcome" runat="server" ControlToValidate="MININCOMETextBox" Display="None"
                            ErrorMessage="Minimum Income (Salary) must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEMinIncome" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinINcome">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    &nbsp;(* Set 0 to disable Minimum Income Checking</td>
            </tr>
            <tr>
                <td>
                    DSR</td>
                <td colspan="3">
                    <asp:TextBox ID="DSRTextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("DSR", "{0:N2}") %>' Width="56px" MaxLength="7"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqDSR" runat="server" ControlToValidate="DSRTextBox" Display="None" ErrorMessage="DSR must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEDSR" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDSR">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    &nbsp;(*Set 100 % to disable DSR checking</td>
            </tr>
            <tr>
                <td class="ShowDetail">
                    Stay Length and Home Status</td>
                <td colspan="3">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    Min Home Stay Length (year)</td>
                <td colspan="3">
                    <asp:TextBox ID="txtStayLength" runat="server" CssClass="required" MaxLength="6"
                        Style="text-align: right" Text='<%# Bind("MINSTAYLENGTH", "{0:N2}") %>' Width="64px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="regStayLength" runat="server" ControlToValidate="txtStayLength" Display="None"
                            ErrorMessage="Minimum Home Stay Length must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEStayLength" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="regStayLength">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    &nbsp;(* Set 0 to disable Stay Length Checking</td>
            </tr>
            <tr>
                <td>
                    Home Status</td>
                <td colspan="3">
                    <asp:CheckBoxList ID="ckListHomeSts" runat="server" DataSourceID="sdsValidHomeSts"
                        DataTextField="HOMESTATUSNAME" DataValueField="CODE">
                    </asp:CheckBoxList><asp:SqlDataSource ID="sdsValidHomeSts" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        SelectCommand="SELECT '(' + CODE + ') ' + NAME AS HOMESTATUSNAME,  CODE FROM PARAMGLOBAL WHERE (TYPE = 'HOMESTATUS')">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="ShowDetail">
                    Other Validation</td>
                <td colspan="3">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    ID (KTP) Expired Checking</td>
                <td colspan="3">
                    <asp:RadioButton ID="RBidexp_enable" runat="server" Checked='<%# Bind("IDEXPIRED") %>' 
                        Text="Enable" GroupName="IDexpired" />
                    <asp:RadioButton ID="RBidexp_disable" runat="server" Text="Disable" 
                        Checked='<%# IIF(Eval("IDEXPIRED"), false, true) %>' 
                        GroupName="IDexpired" />
                </td>
            </tr>
            <tr>
                <td>
                    Portion (Max Portion) Checking</td>
                <td colspan="3">
                    <asp:RadioButton ID="RBportion_enable" runat="server" Checked='<%# Bind("PORTION") %>' 
                        Text="Enable" GroupName="PortionMax" />
                    <asp:RadioButton ID="RBportion_disable" runat="server" Text="Disable" 
                        Checked='<%# IIF(Eval("PORTION"), False, True) %>' 
                        GroupName="PortionMax" />
                </td>
            </tr>
            <tr>
                <td>
                    First Installment Date Checking</td>
                <td colspan="3">
                    <asp:RadioButton ID="RBFirstIns_enabl" runat="server" 
                        Checked='<%# Bind("FIRSTINSTDATE") %>' GroupName="FirstInstallment" 
                        Text="Enable" />
                    <asp:RadioButton ID="RBFirstIns_disabled" runat="server" 
                        Checked='<%# IIF(Eval("FIRSTINSTDATE"), false, true) %>' GroupName="FirstInstallment" 
                        Text="Disable" />
                </td>
            </tr>
            <tr>
                <td class="FooterStyle">
                    Description</td>
                <td class="FooterStyle" colspan="3">
                    <asp:TextBox ID="DESCRIPTIONTextBox" runat="server" Height="48px" 
                        MaxLength="200" Text='<%# Bind("DESCRIPTION") %>' TextMode="MultiLine" 
                        Width="376px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <hr />
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
                    <uc2:BtnDelete ID="BtnDelete1" runat="server" />
                    <uc3:BtnCancel ID="BtnCancel2" runat="server" />
                </td>
            </tr>
        </table>
        </EditItemTemplate>
        <InsertItemTemplate><table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                    Code</td>
                <td colspan="3">
                    <asp:TextBox ID="CRCODETextBox" runat="server" CssClass="required" MaxLength="10"
                        Text='<%# Bind("CRCODE") %>' Width="64px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="CRCODETextBox" Display="None"
                            ErrorMessage="Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Name</td>
                <td colspan="3">
                    <asp:TextBox ID="CRNAMETextBox" runat="server" CssClass="required" MaxLength="100"
                        Text='<%# Bind("CRNAME") %>' Width="384px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="CRNAMETextBox" Display="None"
                            ErrorMessage="Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="ShowDetail">
                    Scheme Validation</td>
                <td colspan="3">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    Interest Scheme</td>
                <td colspan="3">
                    <asp:DropDownList ID="ddlValidInterest" runat="server" CssClass="required" DataSourceID="sdsValidInterest"
                        DataTextField="INTERESTNAME" DataValueField="INTERESTID" SelectedValue='<%# Bind("INTERESTID") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqInterest" runat="server" ControlToValidate="ddlValidInterest"
                        Display="None" ErrorMessage="Interest Scheme must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEInterest" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqInterest">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Tenor Scheme</td>
                <td colspan="3">
                    <asp:DropDownList ID="ddlValidTenor" runat="server" CssClass="required" DataSourceID="sdsValidTenor"
                        DataTextField="TENORNAME" DataValueField="TENORID" SelectedValue='<%# Bind("TENORID") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqTenor" runat="server" ControlToValidate="ddlValidTenor"
                        Display="None" ErrorMessage="Tenor Scheme must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCETenor" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqTenor">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Down Payment Scheme</td>
                <td colspan="3">
                    <asp:DropDownList ID="ddlValidDP" runat="server" CssClass="required" DataSourceID="sdsValidDP"
                        DataTextField="DPVALIDNAME" DataValueField="DPID" SelectedValue='<%# Bind("DPID") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqDP" runat="server" ControlToValidate="ddlValidDP"
                        Display="None" ErrorMessage="Down Payment Scheme must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEDP" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDP">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Maximum Loan</td>
                <td>
                    <asp:TextBox ID="txtMaxLoan" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("MAXIMUMLOAN", "{0:N}") %>' Width="96px" MaxLength="17"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqMaxLoan" runat="server" ControlToValidate="txtMaxLoan" Display="None"
                            ErrorMessage="Minimum Loan must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEMaxLoan" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxLoan">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Allow Used Vehicle</td>
                <td>
                    <asp:CheckBox ID="cbUsedCar" runat="server" Checked='<%# Bind("USEDCAR") %>' CssClass="FooterStyle"
                        Text="Checked if allow used vehicle(car)." /></td>
            </tr>
            <tr>
                <td class="ShowDetail">
                    Installment Deviation</td>
                <td colspan="3">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    Min. Dev.</td>
                <td>
                    <asp:TextBox ID="txtMinInstDev" runat="server" CssClass="required" MaxLength="6"
                        Style="text-align: right" Text='<%# Bind("MINDEVINSTALLMENT", "{0:N}") %>' Width="96px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqMinInstDev" runat="server" ControlToValidate="txtMinInstDev" Display="None"
                            ErrorMessage="Minimum Installment Deviation must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEMinInstDev" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinInstDev">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Max Dev.</td>
                <td>
                    <asp:TextBox ID="txtMaxInstDev" runat="server" CssClass="required" MaxLength="6"
                        Style="text-align: right" Text='<%# Bind("MAXDEVINSTALLMENT", "{0:N}") %>' Width="88px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqMaxInstDev" runat="server" ControlToValidate="txtMaxInstDev" Display="None"
                            ErrorMessage="Maximum Installment Deviation must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEMaxInstDev" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxInstDev">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="ShowDetail">
                    Age Validation</td>
                <td colspan="3">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    Marital Status Age Checking</td>
                <td colspan="3">
                    <asp:CheckBox ID="cbMaritalStatus" runat="server" Checked='<%# Bind("AGECHECK") %>'
                        CssClass="FooterStyle" Text="Check this box for checking Age for Single Marital Status, if not check, age validation for all customer" /></td>
            </tr>
            <tr>
                <td>
                    Min (year)</td>
                <td>
                    <asp:TextBox ID="MINAGETextBox" runat="server" CssClass="required" MaxLength="6"
                        Style="text-align: right" Text='<%# Bind("MINAGE", "{0:N2}") %>' Width="64px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqMinAge" runat="server" ControlToValidate="MINAGETextBox" Display="None"
                            ErrorMessage="Minimum Age must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEMinAge" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinAge">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Max (year)</td>
                <td>
                    <asp:TextBox ID="MAXAGETextBox" runat="server" CssClass="required" MaxLength="6"
                        Style="text-align: right" Text='<%# Bind("MAXAGE", "{0:N2}") %>' Width="64px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqMaxAge" runat="server" ControlToValidate="MAXAGETextBox" Display="None"
                            ErrorMessage="Maximum Age must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEMaxAge" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxAge">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="ShowDetail">
                    Working Time Validation</td>
                <td colspan="3">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    Min (year)</td>
                <td>
                    <asp:TextBox ID="MINWORKTextBox" runat="server" CssClass="required" MaxLength="6"
                        Style="text-align: right" Text='<%# Bind("MINWORK", "{0:N2}") %>' Width="64px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqMinWork" runat="server" ControlToValidate="MINWORKTextBox" Display="None"
                            ErrorMessage="Minimum Working Time must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEMinWork" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinWork">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Max (year)</td>
                <td>
                    <asp:TextBox ID="MAXWORKTextBox" runat="server" CssClass="required" MaxLength="6"
                        Style="text-align: right" Text='<%# Bind("MAXWORK", "{0:N2}") %>' Width="64px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqMaxWork" runat="server" ControlToValidate="MAXWORKTextBox" Display="None"
                            ErrorMessage="Maximum Working Time must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEMaxWork" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMaxWork">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="ShowDetail">
                    Employee&nbsp; Validation</td>
                <td colspan="3">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    Employe Status</td>
                <td>
                    <asp:DropDownList ID="ddlEmpSts" runat="server" CssClass="required" DataSourceID="sdsEMPStatys"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("EMPLOYEESTS") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqEmpSts" runat="server" ControlToValidate="ddlEmpSts"
                        Display="None" ErrorMessage="Employee Status must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEEmpSts" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqEmpSts">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Contract end (month)</td>
                <td>
                    <asp:TextBox ID="MINCONTRACTENDTextBox" runat="server" Style="text-align: right" 
                        Text='<%# Bind("MINCONTRACTEND", "{0:N2}") %>' Width="72px" MaxLength="4"></asp:TextBox>
                 <asp:RequiredFieldValidator
                            ID="reqContractEnd" runat="server" ControlToValidate="MINCONTRACTENDTextBox"
                            Display="None" ErrorMessage="Contract End must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEContractEnd" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqContractEnd">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Min Income (Salary)</td>
                <td colspan="3">
                    <asp:TextBox ID="MININCOMETextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("MININCOME", "{0:N2}") %>' MaxLength="15"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqMinINcome" runat="server" ControlToValidate="MININCOMETextBox" Display="None"
                            ErrorMessage="Minimum Income (Salary) must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEMinIncome" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinINcome">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    (* Set 0 to disabled minimum&nbsp; Checking</td>
            </tr>
            <tr>
                <td>
                    DSR</td>
                <td colspan="3">
                    <asp:TextBox ID="DSRTextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("DSR", "{0:N2}") %>' Width="56px" MaxLength="6"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqDSR" runat="server" ControlToValidate="DSRTextBox" Display="None" ErrorMessage="DSR must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEDSR" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDSR">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    &nbsp;(*Set 100 % to disable DSR checking</td>
            </tr>
            <tr>
                <td class="ShowDetail">
                    Stay Length and Home Status</td>
                <td colspan="3">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    Min Home Stay Length (year)</td>
                <td colspan="3">
                    <asp:TextBox ID="txtStayLength" runat="server" CssClass="required" MaxLength="6"
                        Style="text-align: right" Text='<%# Bind("MINSTAYLENGTH", "{0:N2}") %>' Width="64px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="regStayLength" runat="server" ControlToValidate="txtStayLength" Display="None"
                            ErrorMessage="Minimum Home Stay Length must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEStayLength" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="regStayLength">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    &nbsp;(* Set 0 to disabled stay length checking</td>
            </tr>
            <tr>
                <td>
                    Home Status</td>
                <td colspan="3">
                    <asp:CheckBoxList ID="ckListHomeSts" runat="server" DataSourceID="sdsValidHomeSts"
                        DataTextField="HOMESTATUSNAME" DataValueField="CODE">
                    </asp:CheckBoxList><asp:SqlDataSource ID="sdsValidHomeSts" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        SelectCommand="SELECT '(' + CODE + ') ' + NAME AS HOMESTATUSNAME,  CODE FROM PARAMGLOBAL WHERE (TYPE = 'HOMESTATUS')">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="ShowDetail" style="height: 25px">
                    Other Validation</td>
                <td colspan="3" style="height: 25px">
                    <hr />
                </td>
            </tr>
            <tr>
                <td class="FooterStyle">
                    ID (KTP) Expired</td>
                <td colspan="3">
                    <asp:RadioButton ID="RBidexp_enable" runat="server" Checked='<%# Bind("IDEXPIRED") %>' 
                        Text="Enable" GroupName="IDexpired" />
                    <asp:RadioButton ID="RBidexp_disable" runat="server" Text="Disable" 
                        Checked='True' GroupName="IDexpired" />
                </td>
            </tr>
            <tr>
                <td>
                    Portion (Max Portion)</td>
                <td colspan="3">
                    <asp:RadioButton ID="RBportion_enable" runat="server" Checked='<%# Bind("PORTION") %>' 
                        Text="Enable" GroupName="PortionMax" />
                    <asp:RadioButton ID="RBportion_disable" runat="server" Text="Disable" 
                        Checked='True' GroupName="PortionMax" />
                </td>
            </tr>
            <tr>
                <td>
                    First Installment Date Checking</td>
                <td colspan="3">
                    <asp:RadioButton ID="RBFirstIns_enable" runat="server" 
                        Checked='<%# Bind("FIRSTINSTDATE") %>' GroupName="FirstInstallment" Text="Enable" />
                    <asp:RadioButton ID="RBFirstIns_disabled" runat="server" 
                        Checked='true' GroupName="FirstInstallment" Text="Disable" />
                </td>
            </tr>
            <tr>
                <td class="FooterStyle">
                    Description</td>
                <td colspan="3" class="FooterStyle">
                    <asp:TextBox ID="DESCRIPTIONTextBox" runat="server" Height="48px" MaxLength="200"
                        Text='<%# Bind("DESCRIPTION") %>' TextMode="MultiLine" Width="376px"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="4">
                    <hr />
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <uc4:BtnInsert ID="BtnInsert1" runat="server" />
                    &nbsp;<uc3:BtnCancel ID="BtnCancel1" runat="server" />
                </td>
            </tr>
        </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsEMPStatys" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS CODE, '[EMPLOYEE STATUS]' AS NAME UNION ALL SELECT 0 AS CODE, '(0) ALL STATUS' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'EMPLOYEESTS')">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT CRID, CRCODE, CRNAME, MINAGE, MAXAGE, MINWORK, MAXWORK, AGECHECK, DSR, EMPLOYEESTS, MINCONTRACTEND, MININCOME, DESCRIPTION, MINSTAYLENGTH, (SELECT INTERESTID FROM VALIDINTEREST WITH (NOLOCK) WHERE (INTERESTID = VALIDCRITERIA.INTERESTID) AND (Deletests = 0)) AS INTERESTID, (SELECT DPID FROM VALIDDP WITH (NOLOCK) WHERE (DPID = VALIDCRITERIA.DPID) AND (Deletests = 0)) AS DPID, (SELECT TENORID FROM VALIDTENOR WITH (NOLOCK) WHERE (TENORID = VALIDCRITERIA.TENORID) AND (Deletests = 0)) AS TENORID, MAXIMUMLOAN, USEDCAR, MINDEVINSTALLMENT, MAXDEVINSTALLMENT, IDEXPIRED, PORTION, FIRSTINSTDATE FROM VALIDCRITERIA WITH (NOLOCK) WHERE (CRID = @CRID)" 
        DeleteCommand="VALIDCRITERIADelete" UpdateCommand="VALIDCRITERIAUpdate" 
        InsertCommand="VALIDCRITERIAAdd" InsertCommandType="StoredProcedure" 
        UpdateCommandType="StoredProcedure" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="CRID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="CRID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="CRID" />
            <asp:Parameter Name="CRCODE"  />
            <asp:Parameter Name="CRNAME" />
            <asp:Parameter Name="INTERESTID" Type="Int32" />
            <asp:Parameter Name="DPID" Type="Int32" />
            <asp:Parameter Name="TENORID" Type="Int32" />
            <asp:Parameter Name="MAXIMUMLOAN" Type="Decimal" />
            <asp:Parameter Name="AGECHECK" Type="Boolean" />
            <asp:Parameter Name="MINAGE" Type="Double" />
            <asp:Parameter Name="MAXAGE" Type="Double" />
            <asp:Parameter Name="MINWORK" Type="Double" />
            <asp:Parameter Name="MAXWORK" Type="Double" />
            <asp:Parameter Name="DSR"  Type="Double" />
            <asp:Parameter Name="EMPLOYEESTS" Type="Int32" />
            <asp:Parameter Name="MINCONTRACTEND" Type="Double"  />
            <asp:Parameter Name="MININCOME" Type="Double" />
            <asp:Parameter Name="MINSTAYLENGTH" Type="Decimal" />
            <asp:Parameter Name="USEDCAR" Type="Boolean" />
            <asp:Parameter Name="MINDEVINSTALLMENT" Type="Decimal" />
            <asp:Parameter Name="MAXDEVINSTALLMENT" Type="Decimal" />
            <asp:Parameter Name="DESCRIPTION"  />
            <asp:Parameter DefaultValue="" Name="IDEXPIRED" Type="Boolean" />
            <asp:Parameter DefaultValue="" Name="PORTION" Type="Boolean" />
            <asp:Parameter DefaultValue="" Name="FIRSTINSTDATE" Type="Boolean" />
            <asp:CookieParameter CookieName="UID" Name="USERID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="CRCODE" Type="String" />
            <asp:Parameter Name="CRNAME" Type="String" />
            <asp:Parameter Name="INTERESTID" Type="Int32" />
            <asp:Parameter Name="DPID" Type="Int32" />
            <asp:Parameter Name="TENORID" Type="Int32" />
            <asp:Parameter Name="MAXIMUMLOAN" Type="Decimal" />
            <asp:Parameter Name="AGECHECK" Type="Boolean" />
            <asp:Parameter Name="MINAGE" Type="Double" />
            <asp:Parameter Name="MAXAGE" Type="Double" />
            <asp:Parameter Name="MINWORK" Type="Double" />
            <asp:Parameter Name="MAXWORK" Type="Double" />
            <asp:Parameter Name="DSR" Type="Double" />
            <asp:Parameter Name="EMPLOYEESTS" Type="Int32" />
            <asp:Parameter Name="MINCONTRACTEND" Type="Double" />
            <asp:Parameter Name="MININCOME" Type="Double" />
            <asp:Parameter Name="MINSTAYLENGTH" Type="Decimal" />
            <asp:Parameter Name="USEDCAR" Type="Boolean" />
            <asp:Parameter Name="MINDEVINSTALLMENT" Type="Decimal" />
            <asp:Parameter Name="MAXDEVINSTALLMENT" Type="Decimal" />
            <asp:Parameter Name="DESCRIPTION" Type="String" />
            <asp:Parameter Name="IDEXPIRED" Type="Boolean" />
            <asp:Parameter Name="PORTION" Type="Boolean" />
            <asp:Parameter Name="FIRSTINSTDATE" Type="Boolean" />
            <asp:CookieParameter CookieName="UID" Name="USERID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="CRID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsValidInterest" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS INTERESTID, '[INTEREST SCHEME NAME]' AS INTERESTNAME UNION ALL SELECT INTERESTID, INTERESTNAME FROM VALIDINTEREST WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY INTERESTNAME">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsValidTenor" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS TENORID, '[TENOR SCHEME NAME]' AS TENORNAME UNION ALL SELECT TENORID, TENORNAME FROM VALIDTENOR WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY TENORNAME">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsValidDP" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS DPID, '[DP SCHEME NAME]' AS DPVALIDNAME UNION ALL SELECT DPID, DPVALIDNAME FROM VALIDDP WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY DPVALIDNAME">
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
    function getObjectbyClientID(ClientID) {
        var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        return (oObject)
    }

    function SetValueTxtByClientID(ClientID, sValue) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            oText.value = sValue;
    }

    function GetValueTxtByClientID(ClientID) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            return (oText.value);
    }
    window.onload = function () {
        TabToEnter();
        load();
    }

    function load() {
        checkFlagEmpStatus();
    }

    function checkFlagEmpStatus() {

        var Status = getObjectbyClientID("<%=oStrddlEmpSts%>");

        if (Status) {
            if (Status.value == "2") {
                ValidatorEnable(getObjectbyClientID("<%=oStrreqContractEnd%>"), true);
                AddRequired(getObjectbyClientID("<%=ostrMINCONTRACTENDTextBox%>"));
            } else {
                ValidatorEnable(getObjectbyClientID("<%=oStrreqContractEnd%>"), false);
                RemoveRequired(getObjectbyClientID("<%=ostrMINCONTRACTENDTextBox%>"));
            }
        }
    }

    function RemoveRequired(o) {
        o.className = "";
    }

    function AddRequired(o) {
        o.className = "required";
    }
</script>

</asp:Content>

