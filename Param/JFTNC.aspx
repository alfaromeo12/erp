<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="JFTNC.aspx.vb" Inherits="Param_JFTNC" EnableEventValidation="false" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    
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
                <td style="width: 115px; height: 26px;" class="FooterStyle">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="DealerName">TNC Name</asp:ListItem>
        <asp:ListItem Value="DealerCode">TNC Code</asp:ListItem>
    </asp:DropDownList></td>
                <td class="FooterStyle" style="height: 26px">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" />
                    &nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td style="width: 115px" class="RowStyle">
                    &nbsp;</td>
                <td class="RowStyle">
                    &nbsp;</td>
            </tr>
        </table>

    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CommandName="New" CausesValidation="False" />
        </asp:Panel>
        <asp:Panel ID="pnlData" runat="server">
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="100%" 
            DataKeyNames="JFTNCID" Caption="Term and Condition List" RowHeaderColumn="JFTNCID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="20px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="JFTNCID" HeaderText="ID"
                    SortExpression="JFTNCID">
                    <ItemStyle HorizontalAlign="Center" Width="60px" />
                </asp:BoundField>
                <asp:BoundField DataField="JFTNCCODE" HeaderText="Term and Condition&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="JFTNCCODE" />
                <asp:BoundField DataField="JFTNCNAME" HeaderText="Term and Condition&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="JFTNCNAME" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
      SelectCommand="SELECT JFTNCID, JFTNCCODE, JFTNCNAME FROM JFTNC"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" 
        style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
        <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblError">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>

   <asp:Panel ID="pnlTNC" runat="server">

            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="4">
                        <hr />
                    </td>
                </tr>
                <tr >
				    <td colspan="4" class="HeaderStyle" align="center" style="font-weight: bold;">
					    Term and Condition Data</td>
			        </tr>
                <tr>
                    <td>
                      TNC Code
                    </td>
                    <td colspan="3">
                    <asp:TextBox ID="txtTNCCode" runat="server" Width="72px" 
                            CssClass="required" MaxLength="15"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqCode" runat="server" ControlToValidate="txtTNCCode" 
                            Display="None" ErrorMessage="TNC Code must be entry...!" 
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                      TNC Name
                    </td>
                    <td colspan="3">
                    <asp:TextBox ID="txtTNCName" runat="server" Width="150px" 
                            CssClass="required" MaxLength="100"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqName" runat="server" ControlToValidate="txtTNCName" 
                            Display="None" ErrorMessage="TNC Name must be entry...!" 
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                      Description
                    </td>
                    <td colspan="3">
                    <asp:TextBox ID="txtDescription" runat="server" Width="329px" 
                            CssClass="required" Height="54px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqDesc" runat="server" ControlToValidate="txtDescription" 
                            Display="None" ErrorMessage="Description must be entry...!" 
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCEDesc" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDesc">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                    Booking Date</td>
                <td colspan="3">
                    From
                    <asp:TextBox ID="txtBookFrom" runat="server" Width="72px" 
                        CssClass="required"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqBookFrom" runat="server" ControlToValidate="txtBookFrom" 
                            Display="None" ErrorMessage="Booking Date must be entry...!" 
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCEBookFrom" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBookFrom">
                            </ajaxToolkit:ValidatorCalloutExtender>
                            <asp:Image ID="imgBookFrom" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />&nbsp;
                    To
                    <asp:TextBox ID="txtBookTo" runat="server" Width="72px" 
                        CssClass="required"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqBookTo" runat="server" ControlToValidate="txtBookTo" 
                            Display="None" ErrorMessage="Booking Date must be entry...!" 
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCEBookTo" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBookTo">
                            </ajaxToolkit:ValidatorCalloutExtender>
                            <asp:Image ID="imgBookTo" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxCEBookFrom" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgBookFrom"
                        TargetControlID="txtBookFrom">
                        </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxCEBookTo" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgBookTo"
                        TargetControlID="txtBookTo">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEBookFrom" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtBookFrom">
                    </ajaxToolkit:MaskedEditExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEBookTo" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtBookTo">
                    </ajaxToolkit:MaskedEditExtender>
                  </td>
                </tr>
                <tr>
                <td>
                    Past Due</td>
                <td style="width: 275px">
                    <asp:RadioButton ID="rbPastDueExclude" runat="server" GroupName="rbPastDue" 
                        Text="Exclude"  />
                    <asp:RadioButton ID="rbPastDueInclude" runat="server" GroupName="rbPastDue" 
                        Text="Include" Checked="True" />
                </td>
                <td style="width: 90px">
                    New Account</td>
                <td>
                    <asp:RadioButton ID="rbNewAccountExclude" runat="server" GroupName="rbNewAccount" 
                        Text="Exclude" />
                    <asp:RadioButton ID="rbNewAccountInclude" runat="server" GroupName="rbNewAccount" 
                        Text="Include" Checked="True"/>
                </td>
            </tr>
                
                <tr>
                <td>
                    Loan Type</td>
                <td style="width: 275px">
                    <asp:DropDownList ID="ddlLoanTypeSearch" runat="server" 
                        DataSourceID="sdsLoanTypeSearch" DataTextField="NAME"
                        DataValueField="CODE" >
                    </asp:DropDownList><asp:SqlDataSource ID="sdsLoanTypeSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        
                        
                        
                        SelectCommand="SELECT NULL AS CODE, '[ALL LOAN TYPE]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'LOANTYPE')">
                    </asp:SqlDataSource>
                </td>
                    <td style="width: 90px">
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
            </tr
            
            <tr>
            </tr>
            <tr>
                <td>
                    OS Tenor</td>
                <td style="width: 275px">
                    From
                    <asp:TextBox ID="txtTenorFrom" runat="server" style="text-align: right" 
                        Width="40px" CssClass="required"></asp:TextBox>
                    
                    To
                    <asp:TextBox ID="txtTenorTo" runat="server" style="text-align: right" 
                        Width="40px" CssClass="required"></asp:TextBox>
                    
                    <asp:RequiredFieldValidator ID="reqTenorFrom" runat="server" 
                        ControlToValidate="txtTenorFrom" Display="None" 
                        ErrorMessage="TENOR FROM must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCETenorFrom" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqTenorFrom">
                    </ajaxToolkit:ValidatorCalloutExtender>
                    <asp:RequiredFieldValidator ID="reqTenorTo" runat="server" 
                        ControlToValidate="txtTenorTo" Display="None" 
                        ErrorMessage="TENOR TO must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCETenorTo" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqTenorTo">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td style="width: 90px">
                    OS Principal</td>
                <td>
                    From
                    <asp:TextBox ID="txtPrincipalFrom" runat="server" style="text-align: right" 
                        Width="88px" CssClass="required"></asp:TextBox>
                    To
                    <asp:TextBox ID="txtPrincipalTo" runat="server" style="text-align: right" 
                        Width="88px" CssClass="required"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqPrincipalFrom" runat="server" 
                        ControlToValidate="txtPrincipalFrom" Display="None" 
                        ErrorMessage="PRINCIPAL FROM must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPrincipalFrom" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqPrincipalFrom">
                    </ajaxToolkit:ValidatorCalloutExtender>
                    <asp:RequiredFieldValidator ID="reqPrincipalTo" runat="server" 
                        ControlToValidate="txtPrincipalTo" Display="None" 
                        ErrorMessage="PRINCIPAL TO must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPrincipalTo" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqPrincipalTo">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                </tr>
                <tr>
                    <td>
                        DP Minimum</td>
                    <td style="width: 275px">
                        &gt;=<asp:TextBox ID="txtDPMin" runat="server" style="text-align: right" 
                            Width="40px" CssClass="required"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqDPMin" runat="server" 
                            ControlToValidate="txtDPMin" Display="None" 
                            ErrorMessage="MINIMUM DP  must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqDPMin_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDPMin">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td style="width: 90px">
                    ID/KTP Expired</td>
                <td>
                    <asp:RadioButton ID="rbIDExclude" runat="server" GroupName="rbID" 
                        Text="Exclude"  />
                    <asp:RadioButton ID="rbIDInclude" runat="server" GroupName="rbID" 
                        Text="Include" Checked="True" />
                </td>
                </tr>
                <tr>
                    <td>
                        DSR</td>
                    <td style="width: 275px">
                        &lt;=
                        <asp:TextBox ID="txtDSR" runat="server" style="text-align: right" Width="40px" 
                            CssClass="required"></asp:TextBox>
                        %<asp:RequiredFieldValidator ID="reqDSR" runat="server" 
                            ControlToValidate="txtDSR" Display="None" ErrorMessage="DSR must be entry...!" 
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEDSR" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqDSR">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td style="width: 90px">
                        Age</td>
                    <td>
                        &lt;=
                        <asp:TextBox ID="txtAge" runat="server" style="text-align: right" Width="40px" CssClass="required"></asp:TextBox>
                        Year<asp:RequiredFieldValidator ID="reqAGe" runat="server" 
                            ControlToValidate="txtAge" Display="None" ErrorMessage="AGE  must be entry...!" 
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEAge" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqAGe">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Installment Type</td>
                    <td style="width: 275px">
                        <asp:DropDownList ID="ddlInstallmentTypeSearch" runat="server" 
                            DataSourceID="sdsInstallmentTypeSearch" DataTextField="NAME" 
                            DataValueField="CODE" >
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsInstallmentTypeSearch" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            SelectCommand="SELECT NULL AS CODE, '[ALL INST. TYPE]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'INSTALLMENTTYPE')">
                        </asp:SqlDataSource>
                    </td>
                    <td style="width: 90px">
                        Currency</td>
                    <td>
                        <asp:DropDownList ID="ddlCurrencySearch" runat="server" 
                            DataSourceID="sdsCurrency" DataTextField="CURRENCYNAME" 
                            DataValueField="CURRENCYID">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsCurrency" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            SelectCommand="SELECT NULL AS CURRENCYID, NULL AS CURRENCYCODE, '[ALL CURRENCY]' AS CURRENCYNAME UNION ALL SELECT CURRENCYID, CURRENCYCODE, CURRENCYCODE + ' - ' + CURRENCYNAME AS CURRENCYNAME FROM CURRENCY WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY CURRENCYCODE">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        Obj. Condition</td>
                    <td style="width: 275px">
                        <asp:DropDownList ID="ddlCondition" runat="server" DataSourceID="sdsCondition" 
                            DataTextField="NAME" DataValueField="CODE">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsCondition" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            SelectCommand="SELECT NULL AS CODE, '[ALL CONDITION]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'CONDITION')">
                        </asp:SqlDataSource>
                    </td>
                    <td style="width: 90px">
                        Obj./BPKB Status</td>
                    <td>
                        <asp:DropDownList ID="ddlBPKBStatus" runat="server" 
                            DataSourceID="sdsBPKBStatus" DataTextField="NAME" DataValueField="CODE">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsBPKBStatus" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            SelectCommand="SELECT NULL AS CODE, '[ALL STATUS]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'BPKBSTATUS')">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        Early Payment</td>
                    <td style="width: 275px">
                        <asp:RadioButton ID="rbEarlyExclude" runat="server" GroupName="rbPayEarly" 
                            Text="Exclude" />
                        <asp:RadioButton ID="rbEarlyInclude" runat="server" GroupName="rbPayEarly" 
                            Text="Include" Checked="True"/>
                    </td>
                    <td style="width: 90px">
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
                
                <tr>
                    <td>
                        &nbsp;</td>
                    <td style="width: 275px">
                        &nbsp;</td>
                    <td style="width: 90px">
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
            
         </table>
    
     <asp:UpdatePanel ID="UpdListBox" runat="server" UpdateMode="Conditional" >
                    <ContentTemplate>
                        <table cellpadding="0" cellspacing="0" width="100%" >
			                <tr>
				                <td colspan="3" class="HeaderStyle" align="center" style="font-weight: bold;">
					                 BRANCH</td>
                                <td class="HeaderStyle">&nbsp;</td>
			                </tr>
                            <tr>
                        <td style="width: 260px">
                            Branch List</td>
                        <td style="width: 61px">
                            &nbsp;</td>
                        <td>
                            Branch Selected</td>
                            
                        </tr>
                              <tr>
                    <td style="width: 260px">
                        <asp:ListBox ID="lvbBrchSrc" Runat="server" DataSourceID="sdsBranchSrc" 
                            DataTextField="BRANCHNAME" DataValueField="BRANCHID" Height="150px" Rows="10" 
                            SelectionMode="Multiple" Width="250px" />
                        <asp:SqlDataSource ID="sdsBranchSrc" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            
                            SelectCommand="SELECT BRANCHID, '(' + BRANCHCODE + ') ' + BRANCHNAME AS BRANCHNAME FROM BRANCH WITH (NOLOCK) WHERE (Deletests = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM JFTNCBRANCH WITH (NOLOCK) WHERE (BRANCH.Deletests = 0) AND (BRANCH.BRANCHID = BRANCHID) AND (JFTNCID = @JFTNCID))) ORDER BY BRANCHCODE">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvData" ConvertEmptyStringToNull="False" 
                                    DefaultValue="-1" Name="JFTNCID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                                  </td>
                    <td style="width: 61px">
                    <p style="vertical-align: middle">
                        <asp:Button ID="btnMove" runat="server" Height="37px" Text="&gt;&gt;" 
                            Width="50px" />
                    </p>
                    <p>
                        <asp:Button ID="btnBack" runat="server" Height="40px" Text="&lt;&lt;" 
                            Width="50px" />
                    </p>
                    </td>
                    <td style="width: 60px">
                        <asp:ListBox ID="lvbBrchDest" DataSourceID="sdsBranchDest" 
                            DataTextField="BRANCHNAME" DataValueField="BRANCHID" Height="150px" 
                            SelectionMode="Multiple" width="250px" Runat="server" Rows="10" />
                        <asp:SqlDataSource ID="sdsBranchDest" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            SelectCommand="SELECT JFTNCBRANCH.BRANCHID, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCHNAME FROM JFTNCBRANCH WITH (NOLOCK) INNER JOIN BRANCH WITH (NOLOCK) ON JFTNCBRANCH.BRANCHID = BRANCH.BRANCHID WHERE (JFTNCBRANCH.JFTNCID = @JFTNCID) ORDER BY BRANCH.BRANCHCODE">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvData" Name="JFTNCID" 
                                    PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                    <td>
                        
                        &nbsp;</td>
                </tr>
                            <tr>
                                <td colspan="4">
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </ContentTemplate>
             </asp:UpdatePanel>
    
     <asp:UpdatePanel ID="UpdFinCat" runat="server" UpdateMode="Conditional" >
                    <ContentTemplate>
                        <table cellpadding="0" cellspacing="0" width="100%" >
			                <tr>
				                <td  colspan="3" class="HeaderStyle" align="center" style="font-weight: bold;">
					                 FINANCE CATEGORY</td>
                                <td class="HeaderStyle">&nbsp;</td>
			                </tr>
                             <tr>
                        <td style="width: 260px">
                            Finance Category List</td>
                        <td style="width: 60px">
                            &nbsp;</td>
                        <td>
                            Finance Category Selected</td>
                        </tr>
                             <tr>
                    
                    <td>
                        <asp:ListBox ID="lvbFinCatSrc" Runat="server" DataSourceID="sdsFinCatSrc" 
                            DataTextField="FINCATNAME" DataValueField="FINCATID" Height="75px" Rows="10" 
                            SelectionMode="Multiple" Width="250px" />
                        <asp:SqlDataSource ID="sdsFinCatSrc" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            SelectCommand="SELECT FINCATID, '(' + FINCATCODE + ') ' + FINCATNAME AS FINCATNAME FROM FINANCECATEGORY WITH (NOLOCK) WHERE (Deletests = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM JFTNCFINCAT WITH (NOLOCK) WHERE (Deletests = 0) AND (FINCATID = FINANCECATEGORY.FINCATID) AND (JFTNCID = @JFTNCID))) ORDER BY FINCATCODE">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvData" ConvertEmptyStringToNull="False" 
                                    DefaultValue="-1" Name="JFTNCID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                                 </td><td style="width: 60px">
                                 <p style="vertical-align: middle">
                                     <asp:Button ID="btnMoveF" runat="server" Height="25px" Text="&gt;&gt;" 
                                         Width="50px" />
                                         </p>
                                 <p>
                                     <asp:Button ID="btnBackF" runat="server" Height="25px" Text="&lt;&lt;" 
                                         Width="50px" />
                                         </p>
                                 </td>
                    <td style="width: 60px">
                        <asp:ListBox ID="lvbFinCatDest" runat="server" DataSourceID="sdsFinCatDest" 
                            DataTextField="FINCATNAME" DataValueField="FINCATID" Height="75px" 
                            SelectionMode="Multiple" width="250px" />
                        <asp:SqlDataSource ID="sdsFinCatDest" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            
                            SelectCommand="SELECT JFTNCFINCAT.FINCATID, '(' + FINANCECATEGORY.FINCATCODE + ') ' + FINANCECATEGORY.FINCATNAME AS FINCATNAME FROM JFTNCFINCAT WITH (NOLOCK) INNER JOIN FINANCECATEGORY WITH (NOLOCK) ON JFTNCFINCAT.FINCATID = FINANCECATEGORY.FINCATID WHERE (JFTNCFINCAT.JFTNCID = @JFTNCID) ORDER BY FINANCECATEGORY.FINCATCODE">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvData" Name="JFTNCID" 
                                    PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                                 </td>
                                 <td>
                                     &nbsp;</td>
                </tr>
                            <tr>
                                <td colspan="4">
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </ContentTemplate>
             </asp:UpdatePanel>

              <asp:UpdatePanel ID="UpdProduct" runat="server" UpdateMode="Conditional" >
                    <ContentTemplate>
                        <table cellpadding="0" cellspacing="0" width="100%" >
			                <tr>
				                <td colspan="3" class="HeaderStyle" align="center" style="font-weight: bold;">
					                 PRODUCT</td>
                                <td class="HeaderStyle">&nbsp;</td>
			                </tr>
                             <tr>
                        <td style="width: 260px">
                            Product List</td>
                        <td style="width: 60px">
                            &nbsp;</td>
                        <td>
                            Product Selected</td>
                        </tr>
                            <tr>
                    <td>
                        <asp:ListBox ID="lvbProductSrc" Runat="server" DataSourceID="sdsProductSrc" 
                            DataTextField="PRODUCTNAME" DataValueField="PRODUCTID" Height="100px" Rows="10" 
                            SelectionMode="Multiple" Width="250px" />
                        <asp:SqlDataSource ID="sdsProductSrc" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            
                            SelectCommand="SELECT PRODUCTID, '(' + PRODUCTCODE + ') ' + PRODUCTNAME AS PRODUCTNAME FROM PRODUCT WITH (NOLOCK) WHERE (Deletests = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM JFTNCPRODUCT WITH (NOLOCK) WHERE (PRODUCT.Deletests = 0) AND (PRODUCT.PRODUCTID = PRODUCTID) AND (JFTNCID = @JFTNCID))) ORDER BY PRODUCTCODE">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvData" ConvertEmptyStringToNull="False" 
                                    DefaultValue="-1" Name="JFTNCID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                                </td>
                    <td style="width: 60px">
                    <p style="vertical-align: middle">
                        <asp:Button ID="btnMoveP" runat="server" Height="25px" Text="&gt;&gt;" 
                            Width="50px" />
                            </p>
                    <p>
                        <asp:Button ID="btnBackP" runat="server" Height="25px" Text="&lt;&lt;" 
                            Width="50px" />
                            </p>
                    </td>
                    <td style="width: 60px">
                        <asp:ListBox ID="lvbProductDest" runat="server" DataSourceID="sdsProductDest" 
                            DataTextField="PRODUCTNAME" DataValueField="PRODUCTID" Height="100px" 
                            SelectionMode="Multiple" width="250px" />
                        <asp:SqlDataSource ID="sdsProductDest" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            SelectCommand="SELECT JFTNCPRODUCT.PRODUCTID, '(' + PRODUCT.PRODUCTCODE + ') ' + PRODUCT.PRODUCTNAME AS PRODUCTNAME FROM JFTNCPRODUCT WITH (NOLOCK) INNER JOIN PRODUCT WITH (NOLOCK) ON JFTNCPRODUCT.PRODUCTID = PRODUCT.PRODUCTID WHERE (JFTNCPRODUCT.JFTNCID = @JFTNCID) ORDER BY PRODUCT.PRODUCTCODE">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvData" Name="JFTNCID" 
                                    PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
                            <tr>
                                <td colspan="4">
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </ContentTemplate>
             </asp:UpdatePanel>

              <asp:UpdatePanel ID="UpdPurposeCat" runat="server" UpdateMode="Conditional" >
                    <ContentTemplate>
                        <table cellpadding="0" cellspacing="0" width="100%" >
			                <tr>
			                <td colspan="3" class="HeaderStyle" align="center" style="font-weight: bold;">
					                 PURPOSE CATEGORY</td>
                            <td class="HeaderStyle">&nbsp;</td>
			                </tr>
                            <tr align="center">
                        <td style="width: 260px" align="left">
                            Purpose Category List</td>
                        <td style="width: 60px" align="left">
                            &nbsp;</td>
                        <td align="left">
                            Purpose Category Selected</td>
                        </tr>
                            <tr>
                                <td>
                                    <asp:ListBox ID="lvbPurposeSrc" Runat="server" DataSourceID="sdsPurposeSrc" 
                                        DataTextField="PURPOSECATNAME" DataValueField="PURPOSECATID" Height="75px" 
                                        Rows="10" SelectionMode="Multiple" Width="250px" />
                                    <asp:SqlDataSource ID="sdsPurposeSrc" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                                        
                                        SelectCommand="SELECT PURPOSECATID, '(' + PURPOSECATCODE + ') ' + PURPOSECATNAME AS PURPOSECATNAME FROM OBJECTPURPOSECAT WITH (NOLOCK) WHERE (DELETESTS = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM JFTNCPURPOSECAT WITH (NOLOCK) WHERE (OBJECTPURPOSECAT.DELETESTS = 0) AND (OBJECTPURPOSECAT.PURPOSECATID = PURPOSECATID) AND (JFTNCID = @JFTNCID))) ORDER BY PURPOSECATCODE">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="gvData" ConvertEmptyStringToNull="False" 
                                                DefaultValue="-1" Name="JFTNCID" PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                                <td style="width: 60px">
                                <p style="vertical-align: middle">
                                    <asp:Button ID="btnMoveR" runat="server" Height="25px" Text="&gt;&gt;" 
                                        Width="50px" />
                                   </p>
                                <p>
                                    <asp:Button ID="btnBackR" runat="server" Height="25px" Text="&lt;&lt;" 
                                        Width="50px" />
                                        </p>
                                </td>
                                <td style="width: 60px">
                                    <asp:ListBox ID="lvbPurposeDest" runat="server" DataSourceID="sdsPurposeDest" 
                                        DataTextField="PURPOSECATNAME" DataValueField="PURPOSECATID" Height="75px" 
                                        SelectionMode="Multiple" width="250px" />
                                    <asp:SqlDataSource ID="sdsPurposeDest" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                                        SelectCommand="SELECT JFTNCPURPOSECAT.PURPOSECATID, '(' + OBJECTPURPOSECAT.PURPOSECATCODE + ') ' + OBJECTPURPOSECAT.PURPOSECATNAME AS PURPOSECATNAME FROM JFTNCPURPOSECAT WITH (NOLOCK) INNER JOIN OBJECTPURPOSECAT WITH (NOLOCK) ON JFTNCPURPOSECAT.PURPOSECATID = OBJECTPURPOSECAT.PURPOSECATID WHERE (JFTNCPURPOSECAT.JFTNCID = @JFTNCID) ORDER BY OBJECTPURPOSECAT.PURPOSECATCODE">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="gvData" Name="JFTNCID" 
                                                PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <tr>
                                    <td colspan="4">
                                        &nbsp;</td>
                                </tr>
                                
                                <tr>
                                    <td colspan="4">
                                        &nbsp;</td>
                                </tr>
                            </tr>
                        </table>
                    </ContentTemplate>
             </asp:UpdatePanel>
             <asp:Button ID="btnSave" runat="server" 
                    Style="font-size: 8pt; cursor: pointer; background-position: left; background-image: url(../images/Save.gif); background-repeat: no-repeat; text-align: right;" 
                    Text="Save" ToolTip="Save" ValidationGroup="Collector" Width="60px" OnClientClick="return CheckUserSPVTnC();" />
             <asp:Button ID="btnDelete" runat="server"
                            Style="font-size: 8pt; cursor: pointer;   
                            background-position: left; background-image: url(../images/Delete.gif); 
                            background-repeat: no-repeat; text-align: right;" Text="Delete" ToolTip="Delete" 
                            Width="55px" CausesValidation="False" 
                            onclientclick="return CheckUserSPVDelete();" />
             <asp:Button ID="btnCancel" runat="server" CausesValidation="False" 
                    Style="font-size: 8pt; cursor: pointer; background-position: left; background-image: url(../Images/back.png); cursor: pointer; background-repeat: no-repeat; text-align: right" 
                    Text="Cancel" ValidationGroup="Collector" Width="71px" />
                                              
                                   
             </asp:Panel>
    <asp:HiddenField ID="hidJFTNCID" runat="server" />
    
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript">
    TabToEnter();
    FormatTable("<%=gvData.ClientID%>")
    function CheckUserSPVTnC() {
        if (Page_ClientValidate) {
            if (Page_ClientValidate("")) {
                var RetVal = window.showModalDialog("../Home/UserLoginSPV.aspx", "SPVAuthor", "dialogWidth:300px;dialogHeight:200px;center:yes;edge:raised;help:no;status:no;");
                if (RetVal.Login == 1)
                    return (true);
                else
                    return (false);
            } else {
                return (false);
            }
        }
    }

    function CheckUserSPVDelete() {
        var RetVal = window.showModalDialog("../Home/UserLoginSPV.aspx", "SPVAuthor", "dialogWidth:300px;dialogHeight:200px;center:yes;edge:raised;help:no;status:no;");
        if (RetVal.Login == 1)
            return (true);
        else
            return (false);
    }
</script>
</asp:Content>

