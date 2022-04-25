<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="BranchRule.aspx.vb" Inherits="Param_BranchRule" MaintainScrollPositionOnPostback="true" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<%@ Register src="../UserControl/BtnUpdate.ascx" tagname="BtnUpdate" tagprefix="uc7" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
    <asp:HiddenField ID="hidFinCatID" runat="server" />
     <asp:HiddenField ID="hidBranchID" runat="server" />
    <asp:HiddenField ID="hidAction" runat="server" />
    <asp:CheckBox ID="ChkAddNew" style="display:none" runat="server" />
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Details...)</asp:Label>
        </div>
        <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" />
    </asp:Panel>
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
                        <asp:ListItem Value="BranchName">Branch Name</asp:ListItem>
                        <asp:ListItem Value="BranchCode">Branch Code</asp:ListItem>
                    </asp:DropDownList>
                </td>
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
        </asp:Panel>
        <br />
        <asp:Panel ID="pnlData" runat="server">
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="BRANCHID" DataSourceID="sdsGrid" 
            Width="100%" Caption="Branch List For Rule Setting" 
            RowHeaderColumn="BRANCHID">
            <Columns>
              
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/edit.gif" 
                        ShowSelectButton="True">
                    <HeaderStyle CssClass="FooterStyle" />
                <ItemStyle HorizontalAlign="Center" Width="20px" /></asp:CommandField>
                <asp:BoundField DataField="BRANCHID" HeaderText="ID" 
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
        
        SelectCommand="SELECT AREAID, BRANCHID, BRANCHCODE, BRANCHNAME, BRANCHPHONE, BRANCHFAX, BRANCHADDRESS, BRANCHCITY, AREA, NEW, Deletests, UPD FROM (SELECT BRANCH_1.BRANCHID, BRANCH_1.AREAID, BRANCH_1.BRANCHCODE, BRANCH_1.BRANCHNAME, BRANCH_1.BRANCHPHONE, BRANCH_1.BRANCHFAX, BRANCH_1.BRANCHADDRESS, BRANCH_1.BRANCHCITY, '(' + AREA.AREACODE + ') ' + AREA.AREANAME AS AREA, CAST(0 AS BIT) AS NEW, BRANCH_1.Deletests, CASE WHEN EXISTS (SELECT 'X' FROM BRANCHX WHERE BRANCH_1.BRANCHID = BRANCHX.BRANCHID) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS UPD FROM BRANCH AS BRANCH_1 INNER JOIN AREA WITH (NOLOCK) ON BRANCH_1.AREAID = AREA.AREAID WHERE (BRANCH_1.Deletests = 0) UNION ALL SELECT BRANCHX.BRANCHID, BRANCHX.AREAID, BRANCHX.BRANCHCODE, BRANCHX.BRANCHNAME, BRANCHX.BRANCHPHONE, BRANCHX.BRANCHFAX, BRANCHX.BRANCHADDRESS, BRANCHX.BRANCHCITY, '(' + AREA_1.AREACODE + ') ' + AREA_1.AREANAME AS AREA, CAST(1 AS BIT) AS NEW, BRANCHX.Deletests, CAST(0 AS BIT) AS UPD FROM BRANCHX INNER JOIN AREA AS AREA_1 WITH (NOLOCK) ON BRANCHX.AREAID = AREA_1.AREAID WHERE (BRANCHX.Deletests = 0) AND (NOT EXISTS (SELECT 'X' AS EXPR1 FROM BRANCH AS BRANCH_2 WHERE (BRANCHID = BRANCHX.BRANCHID)))) AS BRANCH WHERE (Deletests = 0)"></asp:SqlDataSource>
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
    
    <asp:DataList ID="dlBranchInfo" runat ="server" Caption="BRANCH INFO" 
        style="margin-right: 4px" Width="100%" DataSourceID="sdsInfoBranch" >
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%" >
            <tr>
                    <td class="FooterStyle" style="width: 118px">
                        Branch Area</td>
                    <td>
                        <asp:Label ID="lblArea" runat="server" Text='<%# Eval("AREANAME") %>' 
                            Font-Bold="True" Font-Underline="True"></asp:Label>
                    </td>
            </tr>
                <tr>
                    <td class="FooterStyle" style="width: 118px">
                        Branch Name</td>
                    <td>
                        (<asp:Label ID="lblBranchName0" runat="server" Font-Bold="True" 
                            Text='<%# Eval("BRANCHCODE") %>' Font-Underline="True"></asp:Label>)
                        <asp:Label ID="lblBranchName" runat="server" Font-Bold="True" 
                            Text='<%# Eval("BRANCHNAME") %>' Font-Underline="True"></asp:Label>
                    </td>
                </tr>
            <tr>
                    <td class="FooterStyle" style="width: 118px">
                        Address</td>
                    <td>
                        <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("BRANCHADDRESS") %>' 
                            Font-Bold="True" Font-Underline="True"></asp:Label>
                    </td>
            </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>

    <asp:SqlDataSource ID="sdsInfoBranch" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        SelectCommand="SELECT BRANCH.BRANCHID, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME, BRANCH.AREAID, BRANCH.BRANCHADDRESS, '(' + AREA.AREACODE + ') ' + AREA.AREANAME AS AREANAME FROM BRANCH INNER JOIN AREA ON BRANCH.AREAID = AREA.AREAID WHERE (BRANCH.Deletests = 0) AND (AREA.DELETESTS = 0) AND (BRANCH.BRANCHID = @BRANCHID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="BRANCHID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

   
    <asp:GridView ID="gvFinCat" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" Caption="FINANCING CATEGORY - BRANCH RULE SETTING" 
        DataKeyNames="FINCATID" DataSourceID="sdsFinCatList" Width="100%" 
        RowHeaderColumn="FINCATCODE">
        <Columns>
            <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/edit.gif" 
                ShowSelectButton="True">
            <ItemStyle HorizontalAlign="Center" Width="20px" />
            </asp:CommandField>
            <asp:BoundField DataField="FINCATCODE" HeaderText="Finance&lt;br&gt;Category Code" 
                HtmlEncode="False" SortExpression="FINCATCODE" />
            <asp:BoundField DataField="FINCATNAME" HeaderText="Finance&lt;br&gt;Category Name" 
                HtmlEncode="False" SortExpression="FINCATNAME" />
            <asp:BoundField DataField="FINCATTYPENAME" HeaderText="Finance&lt;br&gt;Category Type" 
                HtmlEncode="False" SortExpression="FINCATTYPENAME" />
            <asp:BoundField DataField="BranchRule" HeaderText="Branch Rule" ReadOnly="True" 
                SortExpression="BranchRule" />
            <asp:TemplateField HeaderText="Branch Rule&lt;br&gt;Penalty">
                <ItemTemplate>
                    <asp:ImageButton ID="imgPenalty" runat="server" 
                        ImageUrl="~/Images/view.gif"  OnCommand="imgPenalty_Command" 
                        CommandArgument='<%# CType(Container,GridViewRow).RowIndex %>' 
                        Visible='<%# Eval("[RULE EXIST]") %>' CausesValidation="False"  />
                    <asp:Label ID="lblFinCatID" runat="server" Text='<%# Eval("FINCATID") %>' 
                        Visible="False"></asp:Label>
                    <asp:Label ID="lblRuleExist" runat="server" Text='<%# Eval("RULE EXIST") %>' 
                        Visible="False"></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Branch Rule&lt;br&gt;ET Penalty">
                 <ItemTemplate>
                    <asp:ImageButton ID="imgETPenalty" runat="server" 
                        ImageUrl="~/Images/view.gif"  OnCommand="imgETPenalty_Command" 
                        CommandArgument='<%# CType(Container,GridViewRow).RowIndex %>' 
                        Visible='<%# Eval("[RULE EXIST]") %>' CausesValidation="False"  />
                    <asp:Label ID="lblFinCatIDET" runat="server" Text='<%# Eval("FINCATID") %>' 
                        Visible="False"></asp:Label>
                    <asp:Label ID="lblRuleExistET" runat="server" Text='<%# Eval("RULE EXIST") %>' 
                        Visible="False"></asp:Label>
                </ItemTemplate>
                 <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%" DataKeyNames="BRANCHID,FINCATID" 
        Caption="BRANCH RULE EDIT">
        <EditItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%" >
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
              
                <tr>
                    <td>
                     <asp:Label ID="lblFINCATID" runat="server" Visible="false" Text='<%# Bind("FINCATID") %>'></asp:Label>
                        Working Days</td>
                    <td>
                        <asp:TextBox ID="txtWorkingDays" runat="server" CssClass="required" 
                            MaxLength="4" style="text-align: right" Text='<%# Bind("WORKINGDAYS") %>' 
                            Width="50px"></asp:TextBox>
                        &nbsp;day(s)
                        <asp:RequiredFieldValidator ID="reqWorkingDays" runat="server" 
                            ControlToValidate="txtWorkingDays" Display="None" 
                            ErrorMessage="Working Days must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqWorkingDays_ValidatorCalloutExtender0" 
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
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqPenaltyType_ValidatorCalloutExtender0" 
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
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqPenaltyRate_ValidatorCalloutExtender0" 
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
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqCRID_ValidatorCalloutExtender0" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCRID">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Grace Periode</td>
                    <td>
                        <asp:TextBox ID="txtGracePeriode" runat="server" CssClass="required" 
                            MaxLength="4" Text='<%# Bind("GRACEPERIOD") %>' Width="50px" 
                            style="text-align: right"></asp:TextBox>
                        &nbsp;day(s)<asp:RequiredFieldValidator ID="reqGracePeriode" runat="server" 
                            ControlToValidate="txtGracePeriode" Display="None" 
                            ErrorMessage="Grace Periode must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqGracePeriode_ValidatorCalloutExtender0" 
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
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqFirstPaymentType_ValidatorCalloutExtender0" 
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
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqPaymentType_ValidatorCalloutExtender0" 
                            runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqPaymentType">
                        </ajaxToolkit:ValidatorCalloutExtender>
                        &nbsp;Early Payment
                        <asp:RadioButton ID="rbEarlyPayment_yes0" runat="server" 
                            Checked='<%# Bind("EARLYPAYMENT") %>' GroupName="rbEarlyPayment" 
                            Text="Yes" />
                        <asp:RadioButton ID="rbEarlyPayment_no0" runat="server" Checked="True" 
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
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqETPenaltyType_ValidatorCalloutExtender0" 
                            runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqETPenaltyType">
                        </ajaxToolkit:ValidatorCalloutExtender>
                        &nbsp;ET Penalty<asp:TextBox ID="txtETPenaltyRule" runat="server" CssClass="required" 
                            MaxLength="10" Text='<%# Bind("ETPENALTY") %>' Width="64px" 
                            style="text-align: right"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqETPenalty" runat="server" 
                            ControlToValidate="txtETPenaltyRule" Display="None" 
                            ErrorMessage="ET Penalty must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqETPenalty_ValidatorCalloutExtender0" 
                            runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqETPenalty">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        ADM Terminate</td>
                    <td>
                        <asp:TextBox ID="txtADMterminate" runat="server" CssClass="required" 
                            MaxLength="10" Text='<%# Bind("ADMTERMINATE", "{0:N}") %>' Width="64px" 
                            style="text-align: right"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="regADMterminate" runat="server" 
                            ControlToValidate="txtADMterminate" Display="None" 
                            ErrorMessage="Grace Periode must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="regADMterminate_ValidatorCalloutExtender0" 
                            runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="regADMterminate">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="FooterStyle">
                        &nbsp;<uc7:BtnUpdate ID="BtnUpdate1" runat="server" />
                        <uc2:BtnDelete ID="BtnDelete2" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
    </asp:FormView>


    <asp:Panel ID="pnlPenalty" runat="server">
    
    <asp:GridView ID="gvPenalty" runat="server" AutoGenerateColumns="False" BorderWidth="1px" 
            ShowFooter="True" style="margin-top: 0px" Width="100%" PageSize="15" 
            Caption="BRANCH RULE PENALTY" 
        DataKeyNames="BRANCHID,FINCATID">
        <Columns>
            <asp:TemplateField ControlStyle-CssClass="HeaderStyle" HeaderText="DEL" ShowHeader="False">
                <ItemTemplate>
                  <asp:TextBox ID="txtPenaltyID" runat="server" CssClass="required" Width="72px" Visible="false"
                        Text='<%# Eval("PENALTYID") %>'></asp:TextBox>
                    <asp:ImageButton ID="btnDelete" runat="server" CausesValidation="False" 
                            CommandName="Delete" ImageAlign="Middle" ImageUrl="~/Images/delete.gif" 
                            style="cursor: pointer" Text="Delete" />
                </ItemTemplate>
                <ControlStyle CssClass="HeaderStyle" />
                <ControlStyle CssClass="HeaderStyle" />
                <FooterStyle CssClass="HeaderStyle" HorizontalAlign="center" />
                <FooterTemplate>
                  
                    <asp:ImageButton ID="btnNewPenalty" runat="server" CausesValidation="True" 
                            CommandName="New" ImageAlign="Middle" ImageUrl="~/Images/New.png" 
                            onclick="btnNewPenalty_Click" style="cursor:pointer" Text="New" 
                        ValidationGroup="AddRule" />
                </FooterTemplate>
                <ItemStyle HorizontalAlign="Center" Width="30px" />
            </asp:TemplateField>
            <asp:BoundField DataField="PENALTYID" HeaderText="Penalty&lt;br&gt;ID" 
                HtmlEncode="False" SortExpression="PENALTYID" Visible="False">
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="No">
                <ItemStyle HorizontalAlign="Center" Width="20px" />
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="20px" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Book From" SortExpression="BOOKFROM">
                <Itemstyle HorizontalAlign="Center"  />
                <ItemTemplate>
                    <asp:TextBox ID="txtBookFrom" runat="server" CssClass="required" Width="72px" AutoComplete="off" 
                        Text='<%# Eval("BOOKFROM", "{0:dd/MM/yyyy}") %>' ValidationGroup="AddRule"></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="ajaxCEBookFrom" runat="server" 
                            Enabled="True" Format="dd/MM/yyyy" PopupButtonID="imgBookFrom" 
                            TargetControlID="txtBookFrom">
                        </ajaxToolkit:CalendarExtender>
                        <ajaxToolkit:MaskedEditExtender ID="ajaxMEBookFrom" runat="server" 
                            Mask="99/99/9999" MaskType="Date" TargetControlID="txtBookFrom">
                        </ajaxToolkit:MaskedEditExtender>
                        <asp:Image ID="imgBookFrom" runat="server" ImageUrl="~/images/grid.gif" 
                            Style="cursor: pointer" ToolTip="Calendar" />
                    <asp:RequiredFieldValidator ID="reqBookFrom" runat="server" 
                        ControlToValidate="txtBookFrom" Display="None" 
                        ErrorMessage="Book From must be entry...!" SetFocusOnError="True" 
                        ValidationGroup="AddRule"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEBookFrom" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqBookFrom"></ajaxToolkit:ValidatorCalloutExtender>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Book To" SortExpression="BOOKTO">
                <Itemstyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:TextBox ID="txtBookTo" runat="server" CssClass="required" Width="72px" 
                        Text='<%# Eval("BOOKTO", "{0:dd/MM/yyyy}") %>' ValidationGroup="AddRule"></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="ajaxCEBookTo" runat="server" 
                            Enabled="True" Format="dd/MM/yyyy" PopupButtonID="imgBookTo" 
                            TargetControlID="txtBookTo">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEBookTo" runat="server" 
                            Mask="99/99/9999" MaskType="Date" TargetControlID="txtBookTo">
                    </ajaxToolkit:MaskedEditExtender>
                    <asp:Image ID="imgBookTo" runat="server" ImageUrl="~/images/grid.gif" 
                            Style="cursor: pointer" ToolTip="Calendar" />
                    <asp:RequiredFieldValidator ID="reqBookTo" runat="server" 
                        ControlToValidate="txtBookTo" Display="None" 
                        ErrorMessage="Book To From must be entry...!" SetFocusOnError="True" 
                        ValidationGroup="AddRule"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEBookTo" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqBookTo"></ajaxToolkit:ValidatorCalloutExtender>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Penalty Type" SortExpression="PENALTYTYPE">
                <Itemstyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:DropDownList ID="ddlPenaltyType" runat="server" CssClass="required" 
                            DataSourceID="sdsparentGL_penaltytype" DataTextField="NAME" 
                            DataValueField="CODE" SelectedValue='<%# Eval("PENALTYTYPE") %>'>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="reqPenalty" runat="server" 
                            ControlToValidate="ddlPenaltyType" Display="None" 
                            ErrorMessage="Penalty Type must be entry...!" SetFocusOnError="True"> 
                    </asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPenType" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqPenalty"></ajaxToolkit:ValidatorCalloutExtender>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Penalty Rate" SortExpression="PENALTYRATE">
                <ItemTemplate>
                      
                    <asp:TextBox ID="txtPenaltyRate" runat="server" style="text-align: right" CssClass="required" Text='<%# Eval("PENALTYRATE" , "{0:n}") %>'>
                    </asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqPenaltyRate" runat="server" 
                            ControlToValidate="txtPenaltyRate" Display="None" 
                            ErrorMessage="Penalty rate  must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqPenaltyRate_ValidatorCalloutExtender0" 
                            runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqPenaltyRate">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />              
            </asp:TemplateField>

        </Columns>

        <EmptyDataTemplate>
            <uc6:NoDataFound ID="NoDataFound2" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <br />
    <br />
                            <asp:Label ID="lblMessage" runat="server" Width="100%" Font-Bold="False" 
                                style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
    <ajaxToolkit:AnimationExtender ID="ajaxAEMessageDtl" runat="server" TargetControlID="lblMessage">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
                            <asp:Button ID="btnSavePenalty" runat="server" 
                                Style="font-size: 8pt; cursor: pointer; border-top-style: ridge; border-right-style: ridge; border-left-style: ridge; border-bottom-style: ridge;  background-position-x: left; background-image: url(../images/Save.gif); background-repeat: no-repeat; text-align: right;" 
                                Text="Save" ToolTip="Save" Width="55px" />
                <table cellpadding="0" cellspacing="0" width="100%">
                </table>
     </asp:Panel>
    
    <asp:Panel ID="pnlETPenalty" runat="server">
    
    <asp:GridView ID="gvETPenalty" runat="server" AutoGenerateColumns="False" BorderWidth="1px" 
            ShowFooter="True" style="margin-top: 0px" Width="100%" PageSize="15" 
            Caption="BRANCH RULE ET PENALTY" 
        DataKeyNames="BRANCHID,FINCATID">
        <Columns>
            <asp:TemplateField ControlStyle-CssClass="HeaderStyle" HeaderText="DEL" ShowHeader="False">
                <ItemTemplate>
                  <asp:TextBox ID="txtETPenaltyID" runat="server" CssClass="required" Width="72px" Visible="false"
                        Text='<%# Eval("PENALTYID") %>'></asp:TextBox>
                    <asp:ImageButton ID="btnDelete" runat="server" CausesValidation="False" 
                            CommandName="Delete" ImageAlign="Middle" ImageUrl="~/Images/delete.gif" 
                            style="cursor: pointer" Text="Delete" />
                </ItemTemplate>
                <ControlStyle CssClass="HeaderStyle" />
                <ControlStyle CssClass="HeaderStyle" />
                <FooterStyle CssClass="HeaderStyle" HorizontalAlign="center" />
                <FooterTemplate>
                  
                    <asp:ImageButton ID="btnNewETPenalty" runat="server" CausesValidation="True" 
                            CommandName="New" ImageAlign="Middle" ImageUrl="~/Images/New.png" 
                            onclick="btnNewETPenalty_Click" style="cursor:pointer" Text="New" 
                        ValidationGroup="AddRule" />
                </FooterTemplate>
                <ItemStyle HorizontalAlign="Center" Width="30px" />
            </asp:TemplateField>
            <asp:BoundField DataField="PENALTYID" HeaderText="Penalty&lt;br&gt;ID" 
                HtmlEncode="False" SortExpression="PENALTYID" Visible="False">
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="No">
                <ItemStyle HorizontalAlign="Center" Width="20px" />
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="20px" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Book From" SortExpression="BOOKFROM">
                <Itemstyle HorizontalAlign="Center"  />
                <ItemTemplate>
                    <asp:TextBox ID="txtETBookFrom" runat="server" CssClass="required" Width="72px" AutoComplete="off" 
                        Text='<%# Eval("BOOKFROM", "{0:dd/MM/yyyy}") %>' ValidationGroup="AddRule"></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="ajaxCEBookFrom" runat="server" 
                            Enabled="True" Format="dd/MM/yyyy" PopupButtonID="imgBookFrom" 
                            TargetControlID="txtETBookFrom">
                        </ajaxToolkit:CalendarExtender>
                        <ajaxToolkit:MaskedEditExtender ID="ajaxMEBookFrom" runat="server" 
                            Mask="99/99/9999" MaskType="Date" TargetControlID="txtETBookFrom">
                        </ajaxToolkit:MaskedEditExtender>
                        <asp:Image ID="imgBookFrom" runat="server" ImageUrl="~/images/grid.gif" 
                            Style="cursor: pointer" ToolTip="Calendar" />
                    <asp:RequiredFieldValidator ID="reqBookFrom" runat="server" 
                        ControlToValidate="txtETBookFrom" Display="None" 
                        ErrorMessage="Book From must be entry...!" SetFocusOnError="True" 
                        ValidationGroup="AddRule"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEBookFrom" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqBookFrom"></ajaxToolkit:ValidatorCalloutExtender>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Book To" SortExpression="BOOKTO">
                <Itemstyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:TextBox ID="txtETBookTo" runat="server" CssClass="required" Width="72px" 
                        Text='<%# Eval("BOOKTO", "{0:dd/MM/yyyy}") %>' ValidationGroup="AddRule"></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="ajaxCEBookTo" runat="server" 
                            Enabled="True" Format="dd/MM/yyyy" PopupButtonID="imgBookTo" 
                            TargetControlID="txtETBookTo">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEBookTo" runat="server" 
                            Mask="99/99/9999" MaskType="Date" TargetControlID="txtETBookTo">
                    </ajaxToolkit:MaskedEditExtender>
                    <asp:Image ID="imgBookTo" runat="server" ImageUrl="~/images/grid.gif" 
                            Style="cursor: pointer" ToolTip="Calendar" />
                    <asp:RequiredFieldValidator ID="reqBookTo" runat="server" 
                        ControlToValidate="txtETBookTo" Display="None" 
                        ErrorMessage="Book To From must be entry...!" SetFocusOnError="True" 
                        ValidationGroup="AddRule"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEBookTo" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqBookTo"></ajaxToolkit:ValidatorCalloutExtender>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="ET Penalty Type" SortExpression="ETPENALTYTYPE">
                <Itemstyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:DropDownList ID="ddlETPenaltyType" runat="server" CssClass="required" 
                            DataSourceID="sdsparentGL_penaltytype" DataTextField="NAME" 
                            DataValueField="CODE" SelectedValue='<%# Eval("ETPENALTYTYPE") %>'>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="reqPenalty" runat="server" 
                            ControlToValidate="ddlETPenaltyType" Display="None" 
                            ErrorMessage="ET Penalty Type must be entry...!" SetFocusOnError="True"> 
                    </asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPenType" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqPenalty"></ajaxToolkit:ValidatorCalloutExtender>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="ET Penalty Rate" SortExpression="PENALTYRATE">
                <ItemTemplate>
                    <asp:TextBox ID="txtETPenaltyRate" runat="server" style="text-align: right" CssClass="required" Text='<%# Eval("ETPENALTY" , "{0:n}") %>'>
                    </asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqPenaltyRate" runat="server" 
                            ControlToValidate="txtETPenaltyRate" Display="None" 
                            ErrorMessage="ET Penalty rate  must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqPenaltyRate_ValidatorCalloutExtender0" 
                            runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqPenaltyRate">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />              
            </asp:TemplateField>

            <asp:TemplateField HeaderText="ADM Terminate" SortExpression="ADMTERMINATE">
                <ItemTemplate>
                    <asp:TextBox ID="txtETADMTerminate" runat="server" Text='<%# Eval("ADMTERMINATE" , "{0:n}") %>' style="text-align: right" CssClass="required">
                    </asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqETADMTerminate" runat="server" 
                            ControlToValidate="txtETADMTerminate" Display="None" 
                            ErrorMessage="ADM Terminate  must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqETADMTerminate_ValidatorCalloutExtender0" 
                            runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqETADMTerminate">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />              
            </asp:TemplateField>
        </Columns>

        <EmptyDataTemplate>
            <uc6:NoDataFound ID="NoDataFound2" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <br />
    <br />
                            <asp:Label ID="lblMessageET" runat="server" Width="100%" Font-Bold="False" 
                                style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
                            <ajaxToolkit:AnimationExtender ID="ajaxAEMessageET" runat="server" TargetControlID="lblMessageET">
                                         <Animations>
                                            <OnLoad>
                                                <Sequence>
                                                    <Pulse Duration="0.5" Iterations="0" />
                                                </Sequence>
                                            </OnLoad>
                                        </Animations>
                                        </ajaxToolkit:AnimationExtender>
                            <asp:Button ID="btnSaveETPenalty" runat="server" 
                                Style="font-size: 8pt; cursor: pointer; border-top-style: ridge; border-right-style: ridge; border-left-style: ridge; border-bottom-style: ridge;  background-position-x: left; background-image: url(../images/Save.gif); background-repeat: no-repeat; text-align: right;" 
                                Text="Save" ToolTip="Save" Width="55px" />
                <table cellpadding="0" cellspacing="0" width="100%">
                </table>
     </asp:Panel>
    <br />
    <br />
    <br />

    <asp:SqlDataSource ID="sdsFinCatList" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        
        
        SelectCommand="SELECT FINCATID, FINCATCODE, FINCATNAME, FINCATTYPE, '(' + CAST(FINCATTYPE AS VARCHAR(20)) + ') ' + dbo.f_getParamGlobalName('FINCATTYPE', FINCATTYPE) AS FINCATTYPENAME, CASE WHEN EXISTS (SELECT 'X' FROM BRANCHRULE WHERE BRANCHID = @BRANCHID AND BRANCHRULE.FINCATID = FINANCECATEGORY.FINCATID AND BRANCHRULE.Deletests = 0) THEN 'RULE EXIST' ELSE 'NO RULE' END AS BranchRule, CASE WHEN EXISTS (SELECT 'X' FROM BRANCHRULE WHERE BRANCHID = @BRANCHID AND BRANCHRULE.FINCATID = FINANCECATEGORY.FINCATID AND BRANCHRULE.Deletests = 0) THEN 1 ELSE 0 END AS 'RULE EXIST', CASE WHEN NOT EXISTS (SELECT 'X' FROM BRANCHRULE WHERE BRANCHID = @BRANCHID AND BRANCHRULE.FINCATID = FINANCECATEGORY.FINCATID AND BRANCHRULE.Deletests = 0) THEN 1 ELSE 0 END AS 'NO RULE' FROM FINANCECATEGORY WITH (NOLOCK) WHERE (Deletests = 0)">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="BranchID" 
                PropertyName="SelectedValue" />
           
        </SelectParameters>
    </asp:SqlDataSource>

   
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT BRANCHID, FINCATID, WORKINGDAYS, PENALTYTYPE, PENALTYRATE, PAYMENTTYPE, (SELECT CRID FROM VALIDCRITERIA WHERE (BRANCHRULE.CRID = CRID) AND (Deletests = 0)) AS CRID, GRACEPERIOD, EARLYPAYMENT, ETPENALTYTYPE, ETPENALTY, ADMTERMINATE, FIRSTPAYMENTTYPE FROM BRANCHRULE WHERE (BRANCHID = @BranchID) AND (FINCATID = @FINCATID) AND (Deletests = 0) UNION ALL SELECT BRANCHID, @FINCATID AS FINCATID, WORKINGDAYS, PENALTYTYPE, PENALTYRATE, PAYMENTTYPE, (SELECT CRID FROM VALIDCRITERIA AS VALIDCRITERIA_1 WHERE (BRANCH.CRID = CRID) AND (Deletests = 0)) AS CRID, GRACEPERIOD, EARLYPAYMENT, ETPENALTYTYPE, ETPENALTY, ADMTERMINATE, FIRSTPAYMENTTYPE FROM BRANCH WHERE (BRANCHID = @BranchID) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM BRANCHRULE AS BRANCHRULE_1 WHERE (BRANCH.BRANCHID = BRANCHID) AND (Deletests = 0) AND (FINCATID = @FINCATID)))" 
        DeleteCommand="UPDATE BRANCHRULE SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID&#13;&#10;WHERE BRANCHID=@BranchID AND FINCATID=@FINCATID" 
        UpdateCommand="BRANCHRULESave" InsertCommand="BRANCHRULESave" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:ControlParameter ControlID="gvData" Name="BranchID" 
                PropertyName="SelectedValue" />
           <asp:ControlParameter ControlID="hidFinCatID" Name="FINCATID" 
                PropertyName="Value" />
        </DeleteParameters>
      
        <InsertParameters>
            <asp:Parameter Name="BRANCHID" Type="Int32" />
            <asp:Parameter Name="FINCATID" Type="Int32" />
            <asp:Parameter Name="FIRSTPAYMENTTYPE" Type="Int32" />
            <asp:Parameter Name="WORKINGDAYS" Type="Int32" />
            <asp:Parameter Name="PENALTYTYPE" Type="Int16" />
            <asp:Parameter Name="PENALTYRATE" Type="Double" />
            <asp:Parameter Name="GRACEPERIOD" Type="Int32" />
            <asp:Parameter Name="PAYMENTTYPE" Type="Byte" />
            <asp:Parameter Name="EARLYPAYMENT" Type="Boolean" />
            <asp:Parameter Name="ETPENALTYTYPE" Type="Byte" />
            <asp:Parameter Name="ETPENALTY" Type="Double" />
            <asp:Parameter Name="ADMTERMINATE" Type="Decimal" />
            <asp:Parameter Name="CRID" Type="Int32" />
            <asp:Parameter Name="USERID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
      
        <SelectParameters>
            <asp:ControlParameter ControlID="hidBranchID" Name="BRANCHID" 
                PropertyName="Value" />
            <asp:ControlParameter ControlID="hidFinCatID" Name="FINCATID" 
                PropertyName="Value" />
        </SelectParameters> 
        <UpdateParameters>
            <asp:ControlParameter  ControlID="gvData"  PropertyName="SelectedValue"  
                Name="BRANCHID" Type="Int32" />
           <asp:ControlParameter ControlID="hidFinCatID" Name="FINCATID" 
                PropertyName="Value" Type="Int32"/>
            <asp:Parameter Name="FIRSTPAYMENTTYPE" Type="Int32" />
            <asp:Parameter Name="WORKINGDAYS" Type="Int32" />
            <asp:Parameter Name="PENALTYTYPE" Type="Int32" />
            <asp:Parameter Name="PENALTYRATE" Type="Double" />
            <asp:Parameter Name="GRACEPERIOD" Type="Int32" />
            <asp:Parameter Name="PAYMENTTYPE" Type="Int16" />
            <asp:Parameter Name="EARLYPAYMENT" Type="Boolean" />
            <asp:Parameter Name="ETPENALTYTYPE" Type="Int16" />
            <asp:Parameter Name="ETPENALTY" Type="Double" />
            <asp:Parameter Name="ADMTERMINATE" Type="Double" />
            <asp:Parameter Name="CRID" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
       
    </asp:SqlDataSource>

<asp:SqlDataSource ID="sdsArea" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                            
        SelectCommand="SELECT NULL AS AREAID, NULL AS AREACODE, '[CHOOSE AREA]' AS AREANAME UNION ALL SELECT AREAID, AREACODE, AREACODE + ' - ' + AREANAME AS AREANAME FROM AREA WHERE (DELETESTS = 0) ORDER BY AREACODE">
                        </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsValidCriteria" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        
        
        SelectCommand="SELECT NULL AS CODE, NULL AS CRCODE, '[VALIDATION CRITERIA]' AS NAME UNION ALL SELECT CRID, CRCODE, CRCODE + ' - ' + CRNAME AS NAME FROM VALIDCRITERIA WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY CRCODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsparentGL_penaltytype" runat="server" 
        
        SelectCommand="SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'PENALTYTYPE') ORDER BY CODE" 
        ConnectionString="<%$ ConnectionStrings:connection %>">
    </asp:SqlDataSource>
    <!--
    <asp:SqlDataSource ID="sdsParentGL_BranchCat" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        SelectCommand="SELECT NULL AS CODE, '[BRANCH CATEGORY]' AS NAME UNION ALL 
SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'BRANCHCAT') ORDER BY CODE">
    </asp:SqlDataSource>
    -->

    <asp:SqlDataSource ID="sdsParentGL_PaymentType" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        
    
        
        SelectCommand="SELECT NULL AS CODE, '[PAYMENT TYPE]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JFPAYMENTTYPE') ORDER BY CODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsParentGL_FirstPaymentType" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        SelectCommand="SELECT NULL AS CODE, '[SELECT FIRST PAYMENT TYPE]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JFFIRSTPAYMENTTYPE')"></asp:SqlDataSource>

   
    <asp:SqlDataSource ID="sdsPenalty" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        
        
        SelectCommand="SELECT BRANCHID, FINCATID, PENALTYTYPE, PENALTYRATE, (SELECT BOOKFROM FROM BRANCHRULEPENALTY WITH (NOLOCK) WHERE (BRANCHRULE.BRANCHID = BRANCHID) AND (BRANCHRULE.FINCATID = FINCATID) AND (Deletests = 0)) AS BOOKFROM, (SELECT BOOKTO FROM BRANCHRULEPENALTY AS BRANCHRULEPENALTY_1 WHERE (BRANCHRULE.BRANCHID = BRANCHID) AND (BRANCHRULE.FINCATID = FINCATID) AND (Deletests = 0)) AS BOOKTO, (SELECT PENALTYID FROM BRANCHRULEPENALTY AS BRANCHRULEPENALTY_1 WHERE (BRANCHRULE.BRANCHID = BRANCHID) AND (BRANCHRULE.FINCATID = FINCATID) AND (Deletests = 0)) AS PENALTYID FROM BRANCHRULE WITH (NOLOCK) WHERE (BRANCHID = @BRANCHID) AND (FINCATID = @FINCATID) AND (Deletests = 0)">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="BRANCHID" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="hidFinCatID" Name="FINCATID" 
                PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
     <script type="text/javascript" src="../include/TabEnter.js"></script>
     <script type="text/javascript" src="../include/TableHighLight.js"></script>
    <script type="text/javascript">
        FormatTable("<%=gvData.ClientID%>")
        FormatTable("<%=gvFinCat.ClientID%>");
        FormatTable("<%=gvPenalty.ClientID%>");
        FormatTable("<%=gvETPenalty.ClientID%>");
        window.onload = function () {
            TabToEnter();
           
        }

      </script>
    </asp:Content>

