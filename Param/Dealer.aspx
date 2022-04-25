<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="Dealer.aspx.vb" Inherits="Param_Dealer" title="Dealer" %>
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
        ImageControlID="imgButtonShow" TargetControlID="pnlSearchMaintenance" TextLabelID="lblShow">
    </ajaxToolkit:CollapsiblePanelExtender>
    
    <asp:Panel ID="pnlSearchMaintenance" runat="server">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td style="width: 115px" class="FooterStyle">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="DealerName">Dealer Name</asp:ListItem>
        <asp:ListItem Value="DealerCode">Dealer Code</asp:ListItem>
    </asp:DropDownList></td>
                <td class="FooterStyle">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" />
                    &nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td style="width: 115px" class="RowStyle">
                    Branch</td>
                <td class="RowStyle">
                    <asp:DropDownList ID="ddlBranchSearch" runat="server" AutoPostBack="True" 
                        DataSourceID="sdsBranchSearch" DataTextField="BRANCHNAME" 
                        DataValueField="BRANCHID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsBranchSearch" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        
                        SelectCommand="SELECT NULL AS BRANCHID, NULL AS BRANCHCODE, '[ALL BRANCH]' AS BRANCHNAME UNION ALL SELECT BRANCHID, BRANCHCODE, BRANCHCODE + ' - ' + BRANCHNAME AS BRANCHNAME FROM BRANCH WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY BRANCHCODE">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="width: 115px" class="AlternatingRowStyle">
                    Main Dealer</td>
                <td class="AlternatingRowStyle">
                    <asp:DropDownList ID="ddlMainDealerSearch" runat="server" AutoPostBack="True" 
                        DataSourceID="sdsMainDealerSearch" DataTextField="DEALERMAINNAME" 
                        DataValueField="DEALERMAINID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsMainDealerSearch" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        
                        
                        SelectCommand="SELECT NULL AS DEALERMAINID, NULL AS DEALERMAINCODE, '[ALL MAIN DEALER]' AS DEALERMAINNAME UNION ALL SELECT DEALERMAINID, DEALERMAINCODE, DEALERMAINCODE + ' - ' + DEALERMAINNAME AS DEALERMAINNAME FROM DEALERMAIN WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY DEALERMAINCODE">
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>

    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CommandName="New" CausesValidation="False" />
    </asp:Panel>
    <asp:Panel ID="pnlData" runat="server">
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="DEALERID" DataSourceID="sdsGrid" 
            Width="100%" Caption="Dealer List" RowHeaderColumn="DEALERID">
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" 
                            CommandName="Select" ImageUrl="~/images/edit.gif" Text="Select" 
                            Visible='<%# NOT EVAL("NEW") %>' />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:TemplateField>
                <asp:BoundField DataField="DEALERID" HeaderText="ID" 
                    SortExpression="DEALERID" />
                <asp:BoundField DataField="DEALERCODE" HeaderText="Dealer&lt;br&gt;Code" 
                    SortExpression="DEALERCODE" HtmlEncode="False" />
                <asp:BoundField DataField="DEALERNAME" HeaderText="Dealer&lt;br&gt;Name" 
                    SortExpression="DEALERNAME" HtmlEncode="False" />
                <asp:BoundField DataField="BRANCHNAME" HeaderText="Branch" 
                    SortExpression="BRANCHNAME" />
                <asp:BoundField DataField="ADDRESS" HeaderText="Address" 
                    SortExpression="ADDRESS" />
                <asp:BoundField DataField="CITYNAME" HeaderText="City" 
                    SortExpression="CITYNAME" HtmlEncode="False" />
                <asp:BoundField DataField="HEADDEALER" HeaderText="Head&lt;br&gt;Dealer" 
                    SortExpression="HEADDEALER" HtmlEncode="False" />
                <asp:BoundField DataField="PHONE" HeaderText="Phone" SortExpression="PHONE" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
      SelectCommand="SELECT DEALERID, DEALERCODE, DEALERMAINID, DEALERNAME, BRANCHID, BRANCHCODE, BRANCHNAME, ADDRESS, CITYID, PROVINCE, HEADDEALER, PHONE, NEW, UPD, Deletests, CITYNAME FROM (SELECT TOP (700) DEALER_2.DEALERID, DEALER_2.DEALERMAINID, DEALER_2.DEALERCODE, DEALER_2.DEALERNAME, DEALER_2.BRANCHID, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME, DEALER_2.ADDRESS, DEALER_2.CITYID, DEALER_2.PROVINCE, DEALER_2.HEADDEALER, '(' + DEALER_2.PHONEAREA + ') ' + DEALER_2.PHONE AS PHONE, CAST(0 AS BIT) AS NEW, CASE WHEN EXISTS (SELECT 'X' FROM DEALERX WHERE DEALER_2.DEALERID = DEALERX.DEALERID) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS UPD, DEALER_2.Deletests, CITY.CITYNAME FROM DEALER AS DEALER_2 LEFT OUTER JOIN BRANCH WITH (NOLOCK) ON DEALER_2.BRANCHID = BRANCH.BRANCHID LEFT OUTER JOIN CITY ON DEALER_2.CITYID = CITY.CITYID WHERE (DEALER_2.Deletests = 0) UNION ALL SELECT DEALERX.DEALERID, DEALERX.DEALERMAINID, DEALERX.DEALERCODE, DEALERX.DEALERNAME, DEALERX.BRANCHID, BRANCH_1.BRANCHCODE, BRANCH_1.BRANCHNAME, DEALERX.ADDRESS, DEALERX.CITYID, DEALERX.PROVINCE, DEALERX.HEADDEALER, '(' + DEALERX.PHONEAREA + ') ' + DEALERX.PHONE AS PHONE, CAST(1 AS BIT) AS NEW, CAST(0 AS BIT) AS UPD, DEALERX.Deletests, CITY_1.CITYNAME FROM DEALERX LEFT OUTER JOIN BRANCH AS BRANCH_1 WITH (NOLOCK) ON DEALERX.BRANCHID = BRANCH_1.BRANCHID LEFT OUTER JOIN CITY AS CITY_1 ON DEALERX.CITYID = CITY_1.CITYID WHERE (DEALERX.Deletests = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM DEALER AS DEALER_1 WHERE (DEALERID = DEALERX.DEALERID)))) AS DEALER WHERE (DEALERID &lt;&gt; - 1)"></asp:SqlDataSource>
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
        DefaultMode="Edit" Width="100%" DataKeyNames="DEALERID">
        <InsertItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Dealer Code</td>
                    <td>
                        <asp:TextBox ID="txtDealerCode" runat="server" CssClass="required" 
                            MaxLength="10" Text='<%# Bind("DEALERCODE") %>' Width="64px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqDealerCode" runat="server" 
                            ControlToValidate="txtDealerCode" Display="None" 
                            ErrorMessage="Dealer Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECode" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqDealerCode">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Dealer Name</td>
                    <td>
                        <asp:TextBox ID="txtDealerName" runat="server" MaxLength="50" Text='<%# Bind("DEALERNAME") %>'
                            Width="240px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqDealerName"
                                runat="server" ControlToValidate="txtDealerName" Display="None" 
                            ErrorMessage="Dealer Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqDealerName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        Dealer Alias</td>
                    <td>
                        <asp:TextBox ID="txtDealerAlias" runat="server" 
                            MaxLength="50" Text='<%# Bind("DEALERALIAS") %>' Width="239px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Branch</td>
                    <td>
                        <asp:DropDownList ID="ddlBranch" runat="server" 
                            DataSourceID="sdsBranch" DataTextField="BRANCHNAME" DataValueField="BRANCHID" 
                            SelectedValue='<%# Bind("BRANCHID") %>'>
                        </asp:DropDownList>
                        &nbsp;Dealer Main
                        <asp:DropDownList ID="ddlDealerMain" runat="server" CssClass="required" 
                            DataSourceID="sdsDealer" DataTextField="DEALERMAINNAME" 
                            DataValueField="DEALERMAINID" SelectedValue='<%# Bind("DEALERMAINID") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator
                            ID="reqDealerMain" runat="server" ControlToValidate="ddlDealerMain" Display="None"
                            ErrorMessage="Dealer Main must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="reqDealerMain_ValidatorCalloutExtender" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqDealerMain">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Officer</td>
                    <td>
                        <asp:DropDownList ID="ddlMOID" runat="server" 
                            DataSourceID="sdsAO" DataTextField="AONAME" DataValueField="MOID" 
                            SelectedValue='<%# Bind("MOID") %>'>
                        </asp:DropDownList>
                        &nbsp;ATPM
                        <asp:DropDownList ID="ddlATPM" runat="server" 
                            DataSourceID="sdsParamGlobal_ATPM" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("ATPM") %>'>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Corporate</td>
                    <td>
                        <asp:DropDownList ID="ddlCorporate" runat="server" DataSourceID="sdsCorporate"
                            DataTextField="CONAME" DataValueField="COTYPEID" 
                            SelectedValue='<%# Bind("COTYPEID") %>'>
                        </asp:DropDownList>&nbsp;Has Workshop
                        <asp:RadioButton ID="rbHasWorkshop_yes" runat="server" 
                            Checked='<%# Bind("HASWORKSHOP") %>' GroupName="rbHasWorkshop" Text="Yes" />
                        <asp:RadioButton ID="rbHasWorkshop_no" runat="server" GroupName="rbHasWorkshop" 
                            Text="No" Checked="True" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Place Status</td>
                    <td>
                        <asp:DropDownList ID="ddlPlacests" runat="server" 
                            DataSourceID="sdsparamGL_placests" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("PLACESTS") %>'>
                        </asp:DropDownList>
                        &nbsp;Date Start
                        <asp:TextBox ID="txtDateStart" runat="server" Text='<%# Bind("DATESTART") %>'
                            Width="72px"></asp:TextBox>
                        <ajaxToolkit:CalendarExtender ID="ajaxCEstartdate" runat="server" Format="dd/MM/yyyy" 
                            PopupButtonID="imgDateStart" TargetControlID="txtDateStart">
                        </ajaxToolkit:CalendarExtender>
                        <ajaxToolkit:MaskedEditExtender ID="ajaxMEEstartdate" runat="server" Mask="99/99/9999" 
                            MaskType="Date" TargetControlID="txtDateStart">
                        </ajaxToolkit:MaskedEditExtender>
                        <asp:Image ID="imgDateStart" runat="server" ImageUrl="~/images/grid.gif" 
                            style="cursor: pointer" ToolTip="Calendar" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Address</td>
                    <td>
                        <asp:TextBox ID="txtAddress" runat="server" Text='<%# Bind("ADDRESS") %>'
                            Width="280px" Height="40px" TextMode="MultiLine" CssClass="required"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        City</td>
                    <td>
                        <asp:DropDownList ID="ddlCity" runat="server" 
                            DataSourceID="sdsCity" DataTextField="CITY" DataValueField="CITYID" 
                            SelectedValue='<%# Bind("CITYID") %>'>
                        </asp:DropDownList>
                        &nbsp;Zip&nbsp;
                        <asp:TextBox ID="txtZip" runat="server" Text='<%# Bind("ZIP") %>' Width="64px" 
                            MaxLength="10"></asp:TextBox>&nbsp;Province
                        <asp:TextBox ID="txtProvince" runat="server" MaxLength="15" 
                            Text='<%# Bind("PROVINCE") %>' Width="112px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        NPWP</td>
                    <td>
                        <asp:TextBox ID="txtNPWP" runat="server" MaxLength="15" 
                            Text='<%# Bind("NPWP") %>' Width="112px"></asp:TextBox>
                        &nbsp;Head Dealer
                        <asp:TextBox ID="txtHeadDealer" runat="server" Text='<%# Bind("HEADDEALER") %>' 
                            Width="192px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Phone1</td>
                    <td>
                        <asp:TextBox ID="txtPhoneArea1" runat="server" CssClass="required" 
                            MaxLength="4" Text='<%# Bind("PHONEAREA") %>' Width="50px"></asp:TextBox>
                        <asp:TextBox ID="txtPhone1" runat="server" CssClass="required" MaxLength="15" 
                            Text='<%# Bind("PHONE") %>' Width="112px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Phone2</td>
                    <td>
                        <asp:TextBox ID="txtPhoneArea2" runat="server" MaxLength="4" 
                            Text='<%# Bind("PHONEAREA2") %>' Width="50px"></asp:TextBox>
                        <asp:TextBox ID="txtPhone2" runat="server" MaxLength="15" 
                            Text='<%# Bind("PHONE2") %>' Width="112px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Phone3</td>
                    <td>
                        <asp:TextBox ID="txtPhoneArea3" runat="server" MaxLength="4" 
                            Text='<%# Bind("PHONEARE3") %>' Width="50px"></asp:TextBox>
                        <asp:TextBox ID="txtPhone3" runat="server" MaxLength="15" 
                            Text='<%# Bind("PHONE3") %>' Width="112px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Fax</td>
                    <td>
                        <asp:TextBox ID="txtFaxArea" runat="server" MaxLength="4" 
                            Text='<%# Bind("FAXAREA") %>' Width="50px"></asp:TextBox>
                        <asp:TextBox ID="txtFax" runat="server" MaxLength="15" 
                            Text='<%# Bind("FAX") %>' Width="112px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Email</td>
                    <td>
                        <asp:TextBox ID="txtEmail" runat="server" 
                            MaxLength="15" Text='<%# Bind("EMAIL") %>' Width="200px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Sell Item Condition</td>
                    <td>
                        <asp:DropDownList ID="ddlItemCondition" runat="server" 
                            DataSourceID="sdsparamGL_condition" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("ITEMCONDITION") %>'>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Days to Disburse</td>
                    <td>
                        <asp:TextBox ID="txtDaysToDisb" runat="server"
                        MaxLength="2" Text='<%# Bind("DAYSTODISBURSE") %>' Width="30px"></asp:TextBox>
                        &nbsp;day(s) after booking</td>
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
                        <asp:Label ID="lblDealerID" runat="server" Text='<%# Eval("DEALERID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Dealer Code</td>
                    <td>
                        <asp:TextBox ID="txtDealerCode" runat="server" MaxLength="10" Text='<%# Bind("DEALERCODE") %>'
                            Width="64px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqDealerCode"
                                runat="server" ControlToValidate="txtDealerCode" Display="None" 
                            ErrorMessage="Dealer Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqDealerCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Dealer Name</td>
                    <td>
                        <asp:TextBox ID="txtDealerName" runat="server" MaxLength="50" Text='<%# Bind("DEALERNAME") %>'
                            Width="240px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqDealerName"
                                runat="server" ControlToValidate="txtDealerName" Display="None" 
                            ErrorMessage="Dealer Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqDealerName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        Dealer Alias</td>
                    <td>
                        <asp:TextBox ID="txtDealerAlias" runat="server" 
                            MaxLength="50" Text='<%# Bind("DEALERALIAS") %>' Width="240px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Branch</td>
                    <td>
                        <asp:DropDownList ID="ddlBranch" runat="server" 
                            DataSourceID="sdsBranch" DataTextField="BRANCHNAME" DataValueField="BRANCHID" 
                            SelectedValue='<%# Bind("BRANCHID") %>'>
                        </asp:DropDownList>
                        &nbsp;Dealer Main
                        <asp:DropDownList ID="ddlDealerMain" runat="server" CssClass="required" 
                            DataSourceID="sdsDealer" DataTextField="DEALERMAINNAME" 
                            DataValueField="DEALERMAINID" SelectedValue='<%# Bind("DEALERMAINID") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqDealerMain" runat="server" 
                            ControlToValidate="ddlDealerMain" Display="None" 
                            ErrorMessage="Dealer Main must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqDealerMain_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDealerMain">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Officer</td>
                    <td>
                        <asp:DropDownList ID="ddlMOID" runat="server" 
                            DataSourceID="sdsAO" DataTextField="AONAME" DataValueField="MOID" 
                            SelectedValue='<%# Bind("MOID") %>'>
                        </asp:DropDownList>
                        &nbsp;ATPM
                        <asp:DropDownList ID="ddlATPM" runat="server" 
                            DataSourceID="sdsParamGlobal_ATPM" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("ATPM") %>'>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Corporate</td>
                    <td>
                        <asp:DropDownList ID="ddlCorporate" runat="server" 
                            DataSourceID="sdsCorporate" DataTextField="CONAME" DataValueField="COTYPEID" 
                            SelectedValue='<%# Bind("COTYPEID") %>'>
                        </asp:DropDownList>
                        &nbsp;Has Workshop
                        <asp:RadioButton ID="rbHasWorkshop_yes" runat="server" 
                            Checked='<%# Bind("HASWORKSHOP") %>' GroupName="rbHasWorkshop" Text="Yes" />
                        <asp:RadioButton ID="rbHasWorkshop_no" runat="server" GroupName="rbHasWorkshop" 
                            Text="No" Checked='<%# IIF(Eval("HASWORKSHOP"), false, true) %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        Place Status</td>
                    <td>
                        <asp:DropDownList ID="ddlPlacests" runat="server" 
                            DataSourceID="sdsparamGL_placests" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("PLACESTS") %>'>
                        </asp:DropDownList>
                        &nbsp;Date Start
                        <asp:TextBox ID="txtDateStart" runat="server" Text='<%# Bind("DATESTART") %>' 
                            Width="72px"></asp:TextBox>
                        <ajaxToolkit:CalendarExtender ID="ajaxCEDateStart" runat="server" 
                            Enabled="True" PopupButtonID="imgDateStart" TargetControlID="txtDateStart">
                        </ajaxToolkit:CalendarExtender>
                        <ajaxToolkit:MaskedEditExtender ID="txtDateStart_MaskedEditExtender" runat="server" 
                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" 
                            CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                            CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" 
                            Mask="99/99/9999" MaskType="Date" TargetControlID="txtDateStart">
                        </ajaxToolkit:MaskedEditExtender>
                        <asp:Image ID="imgDateStart" runat="server" ImageUrl="~/images/grid.gif" 
                            style="cursor: pointer" ToolTip="Calendar" />
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        Address</td>
                    <td>
                        <asp:TextBox ID="txtAddress" runat="server" 
                            Height="40px" Text='<%# Bind("ADDRESS") %>' TextMode="MultiLine" 
                            Width="280px" CssClass="required"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        City</td>
                    <td>
                        <asp:DropDownList ID="ddlCity" runat="server" 
                            DataSourceID="sdsCity" DataTextField="CITY" DataValueField="CITYID" 
                            SelectedValue='<%# Bind("CITYID") %>'>
                        </asp:DropDownList>
                        &nbsp;Zip&nbsp;
                        <asp:TextBox ID="txtZip" runat="server" MaxLength="10" 
                            Text='<%# Bind("ZIP") %>' Width="64px"></asp:TextBox>&nbsp;Province
                        <asp:TextBox ID="txtProvince" runat="server" MaxLength="15" 
                            Text='<%# Bind("PROVINCE") %>' Width="112px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        NPWP</td>
                    <td>
                        <asp:TextBox ID="txtNPWP" runat="server" MaxLength="15" Text='<%# Bind("NPWP") %>'
                            Width="112px"></asp:TextBox>&nbsp;Head Dealer
                        <asp:TextBox ID="txtHeadDealer" runat="server" Text='<%# Bind("HEADDEALER") %>' 
                            Width="192px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Phone1</td>
                    <td>
                        <asp:TextBox ID="txtPhoneArea1" runat="server" CssClass="required" 
                            MaxLength="4" Text='<%# Bind("PHONEAREA") %>' Width="50px"></asp:TextBox>
                        <asp:TextBox ID="txtPhone1" runat="server" CssClass="required" MaxLength="15" 
                            Text='<%# Bind("PHONE") %>' Width="112px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Phone2</td>
                    <td>
                        <asp:TextBox ID="txtPhoneArea2" runat="server" MaxLength="4" 
                            Text='<%# Bind("PHONEAREA2") %>' Width="50px"></asp:TextBox>
                        <asp:TextBox ID="txtPhone2" runat="server" MaxLength="15" 
                            Text='<%# Bind("PHONE2") %>' Width="112px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Phone3</td>
                    <td>
                        <asp:TextBox ID="txtPhoneArea3" runat="server" MaxLength="4" 
                            Text='<%# Bind("PHONEARE3") %>' Width="50px"></asp:TextBox>
                        <asp:TextBox ID="txtPhone3" runat="server" MaxLength="15" 
                            Text='<%# Bind("PHONE3") %>' Width="112px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Fax</td>
                    <td>
                        <asp:TextBox ID="txtFaxArea" runat="server" MaxLength="4" 
                            Text='<%# Bind("FAXAREA") %>' Width="50px"></asp:TextBox>
                        <asp:TextBox ID="txtFax" runat="server" MaxLength="15" 
                            Text='<%# Bind("FAX") %>' Width="112px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Email</td>
                    <td>
                        <asp:TextBox ID="txtEmail" runat="server" MaxLength="15" 
                            Text='<%# Bind("EMAIL") %>' Width="200px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Sell Item Condition</td>
                    <td>
                        <asp:DropDownList ID="ddlItemCondition" runat="server" 
                            DataSourceID="sdsparamGL_condition" DataTextField="NAME" 
                            DataValueField="CODE" SelectedValue='<%# Bind("ITEMCONDITION") %>'>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Days to Disburse</td>
                    <td>
                        <asp:TextBox ID="txtDaysToDisb" runat="server"
                        MaxLength="2" Text='<%# Bind("DAYSTODISBURSE") %>' Width="40px"></asp:TextBox>
                        &nbsp;day(s) after booking</td>
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
    <asp:SqlDataSource ID="sdsDealer" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS DEALERMAINID, NULL AS DEALERMAINCODE, '[SELECT DEALER NAME]' AS DEALERMAINNAME UNION ALL SELECT DEALERMAINID, DEALERMAINCODE, DEALERMAINCODE + ' - ' + DEALERMAINNAME AS DEALERMAINNAME FROM DEALERMAIN WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY DEALERMAINCODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsAO" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS MOID, NULL AS AOCODE, '[SELECT ACCOUNT OFFICER]' AS AONAME UNION ALL SELECT AOID, AOCODE, AOCODE + ' - ' + AONAME AS AONAME FROM AO WITH (NOLOCK) WHERE (DELETESTS = 0) ORDER BY AOCODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsBranch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS BRANCHID, NULL AS BRANCHCODE, '[SELECT BRANCH]' AS BRANCHNAME UNION ALL SELECT BRANCHID, BRANCHCODE, BRANCHCODE + ' -  ' + BRANCHNAME AS BRANCHNAME FROM BRANCH WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY BRANCHCODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT DEALER.DEALERID, DEALER.DEALERCODE, DEALER.DEALERNAME, (SELECT BRANCHID FROM BRANCH WITH (NOLOCK) WHERE (BRANCHID = DEALER.BRANCHID) AND (Deletests = 0)) AS BRANCHID, BRANCH_1.BRANCHCODE, BRANCH_1.BRANCHNAME, DEALER.ADDRESS, DEALER.CITYID, DEALER.PROVINCE, DEALER.HEADDEALER, DEALER.PHONEAREA, DEALER.PHONE, '(' + DEALER.PHONEAREA + ') ' + DEALER.PHONE AS TELPON, DEALERMAIN_1.DEALERMAINCODE, DEALERMAIN_1.DEALERMAINNAME, (SELECT AOID FROM AO WITH (NOLOCK) WHERE (AOID = DEALER.MOID) AND (DELETESTS = 0)) AS MOID, (SELECT CODE FROM PARAMGLOBAL WHERE (TYPE = 'ATPM') AND (CODE = DEALER.ATPM)) AS ATPM, (SELECT COTYPEID FROM CORPORATETYPE WHERE (COTYPEID = DEALER.COTYPEID) AND (DELETESTS = 0)) AS COTYPEID, DEALER.HASWORKSHOP, (SELECT CODE FROM PARAMGLOBAL AS PARAMGLOBAL_2 WHERE (TYPE = 'PLACESTS') AND (CODE = DEALER.PLACESTS)) AS PLACESTS, DEALER.DATESTART, DEALER.ZIP, DEALER.NPWP, DEALER.PHONEAREA2, DEALER.PHONE2, DEALER.PHONEARE3, DEALER.PHONE3, DEALER.FAXAREA, DEALER.FAX, DEALER.EMAIL, DEALER.ITEMCONDITION, DEALER.DEALERALIAS, (SELECT DEALERMAINID FROM DEALERMAIN WITH (NOLOCK) WHERE (DEALERMAINID = DEALER.DEALERMAINID) AND (Deletests = 0)) AS DEALERMAINID, DEALER.DAYSTODISBURSE FROM DEALER WITH (NOLOCK) INNER JOIN DEALERMAIN AS DEALERMAIN_1 WITH (NOLOCK) ON DEALER.DEALERMAINID = DEALERMAIN_1.DEALERMAINID LEFT OUTER JOIN BRANCH AS BRANCH_1 WITH (NOLOCK) ON DEALER.BRANCHID = BRANCH_1.BRANCHID WHERE (DEALER.DEALERID = @DEALERID) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM DEALERX WHERE (DEALERID = DEALER.DEALERID))) UNION ALL SELECT DEALER_1.DEALERID, DEALER_1.DEALERCODE, DEALER_1.DEALERNAME, (SELECT BRANCHID FROM BRANCH AS BRANCH_2 WITH (NOLOCK) WHERE (BRANCHID = DEALER_1.BRANCHID) AND (Deletests = 0)) AS BRANCHID, BRANCH_1.BRANCHCODE, BRANCH_1.BRANCHNAME, DEALER_1.ADDRESS, DEALER_1.CITYID, DEALER_1.PROVINCE, DEALER_1.HEADDEALER, DEALER_1.PHONEAREA, DEALER_1.PHONE, '(' + DEALER_1.PHONEAREA + ') ' + DEALER_1.PHONE AS TELPON, DEALERMAIN_1.DEALERMAINCODE, DEALERMAIN_1.DEALERMAINNAME, (SELECT AOID FROM AO AS AO_1 WITH (NOLOCK) WHERE (AOID = DEALER_1.MOID) AND (DELETESTS = 0)) AS MOID, (SELECT CODE FROM PARAMGLOBAL AS PARAMGLOBAL_3 WHERE (TYPE = 'ATPM') AND (CODE = DEALER_1.ATPM)) AS ATPM, (SELECT COTYPEID FROM CORPORATETYPE AS CORPORATETYPE_1 WHERE (COTYPEID = DEALER_1.COTYPEID) AND (DELETESTS = 0)) AS COTYPEID, DEALER_1.HASWORKSHOP, (SELECT CODE FROM PARAMGLOBAL AS PARAMGLOBAL_1 WHERE (TYPE = 'PLACESTS') AND (CODE = DEALER_1.PLACESTS)) AS PLACESTS, DEALER_1.DATESTART, DEALER_1.ZIP, DEALER_1.NPWP, DEALER_1.PHONEAREA2, DEALER_1.PHONE2, DEALER_1.PHONEARE3, DEALER_1.PHONE3, DEALER_1.FAXAREA, DEALER_1.FAX, DEALER_1.EMAIL, DEALER_1.ITEMCONDITION, DEALER_1.DEALERALIAS, (SELECT DEALERMAINID FROM DEALERMAIN AS DEALERMAIN_2 WITH (NOLOCK) WHERE (DEALERMAINID = DEALER_1.DEALERMAINID) AND (Deletests = 0)) AS DEALERMAINID, DEALER_1.DAYSTODISBURSE FROM DEALERX AS DEALER_1 WITH (NOLOCK) INNER JOIN DEALERMAIN AS DEALERMAIN_1 WITH (NOLOCK) ON DEALER_1.DEALERMAINID = DEALERMAIN_1.DEALERMAINID LEFT OUTER JOIN BRANCH AS BRANCH_1 WITH (NOLOCK) ON DEALER_1.BRANCHID = BRANCH_1.BRANCHID WHERE (DEALER_1.DEALERID = @DEALERID)" 
        DeleteCommand="UPDATE DEALER SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID
WHERE DEALERID=@DEALERID" 
        UpdateCommand="DEALERUpdate" InsertCommand="DEALERAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="DEALERID" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="DEALERID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="DEALERID" Type="Int64" />
            <asp:Parameter Name="DEALERCODE" Type="String" />
            <asp:Parameter Name="DEALERNAME" Type="String" />
            <asp:Parameter Name="DEALERALIAS" Type="String" />
            <asp:Parameter Name="DEALERMAINID" Type="Int64" />
            <asp:Parameter Name="BRANCHID" Type="Int32" />
            <asp:Parameter Name="MOID" Type="Int32" />
            <asp:Parameter Name="ATPM" Type="Int32" />
            <asp:Parameter Name="COTYPEID" Type="Int32" />
            <asp:Parameter Name="HASWORKSHOP" Type="Boolean" />
            <asp:Parameter Name="PLACESTS" Type="Int32" />
            <asp:Parameter Name="DATESTART" Type="DateTime" />
            <asp:Parameter Name="ADDRESS" Type="String" />
            <asp:Parameter Name="CITYID" Type="Int32" />
            <asp:Parameter Name="ZIP" Type="String" />
            <asp:Parameter Name="PROVINCE" Type="String" />
            <asp:Parameter Name="NPWP" Type="String" />
            <asp:Parameter Name="HEADDEALER" Type="String" />
            <asp:Parameter Name="PHONEAREA" Type="String" />
            <asp:Parameter Name="PHONE" Type="String" />
            <asp:Parameter Name="PHONEAREA2" Type="String" />
            <asp:Parameter Name="PHONE2" Type="String" />
            <asp:Parameter Name="PHONEARE3" Type="String" />
            <asp:Parameter Name="PHONE3" Type="String" />
            <asp:Parameter Name="FAXAREA" Type="String" />
            <asp:Parameter Name="FAX" Type="String" />
            <asp:Parameter Name="EMAIL" Type="String" />
            <asp:Parameter Name="ITEMCONDITION" Type="Int32" />
            <asp:Parameter Name="DAYSTODISBURSE" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="DEALERID" Type="Int64" />
            <asp:Parameter Name="DEALERCODE" Type="String" />
            <asp:Parameter Name="DEALERNAME" Type="String" />
            <asp:Parameter Name="DEALERALIAS" Type="String" />
            <asp:Parameter Name="DEALERMAINID" Type="Int64" />
            <asp:Parameter Name="BRANCHID" Type="Int32" />
            <asp:Parameter Name="MOID" Type="Int32" />
            <asp:Parameter Name="ATPM" Type="Int32" />
            <asp:Parameter Name="COTYPEID" Type="Int32" />
            <asp:Parameter Name="HASWORKSHOP" Type="Boolean" />
            <asp:Parameter Name="PLACESTS" Type="Int32" />
            <asp:Parameter Name="DATESTART" Type="DateTime" />
            <asp:Parameter Name="ADDRESS" Type="String" />
            <asp:Parameter Name="CITYID" Type="Int32" />
            <asp:Parameter Name="ZIP" Type="String" />
            <asp:Parameter Name="PROVINCE" Type="String" />
            <asp:Parameter Name="NPWP" Type="String" />
            <asp:Parameter Name="HEADDEALER" Type="String" />
            <asp:Parameter Name="PHONEAREA" Type="String" />
            <asp:Parameter Name="PHONE" Type="String" />
            <asp:Parameter Name="PHONEAREA2" Type="String" />
            <asp:Parameter Name="PHONE2" Type="String" />
            <asp:Parameter Name="PHONEARE3" Type="String" />
            <asp:Parameter Name="PHONE3" Type="String" />
            <asp:Parameter Name="FAXAREA" Type="String" />
            <asp:Parameter Name="FAX" Type="String" />
            <asp:Parameter Name="EMAIL" Type="String" />
            <asp:Parameter Name="ITEMCONDITION" Type="Int32" />
            <asp:Parameter Name="DAYSTODISBURSE" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>

<asp:SqlDataSource ID="sdsParamGlobal_ATPM" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                            
        SelectCommand="SELECT NULL AS CODE, '[SELECT ATPM]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'ATPM')">
                        </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCorporate" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        
        SelectCommand="SELECT NULL AS COTYPEID, '[SELECT CORPORATE]' AS CONAME UNION ALL SELECT COTYPEID, CAST(COTYPEID AS VARCHAR) + ' - ' + CONAME AS CONAME FROM CORPORATETYPE WITH (NOLOCK) WHERE (DELETESTS = 0)">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsparamGL_placests" runat="server" 
        
        SelectCommand="SELECT NULL AS CODE, '[SELECT STATUS PLACE]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'PLACESTS')" 
        ConnectionString="<%$ ConnectionStrings:connection %>">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsparamGL_condition" runat="server" 
        
        SelectCommand="SELECT NULL AS CODE, '[SELECT CONDITION]' AS NAME UNION ALL SELECT CODE, CODE + ' -  ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'CONDITION')" 
        ConnectionString="<%$ ConnectionStrings:connection %>">
    </asp:SqlDataSource>
    &nbsp; &nbsp; &nbsp;&nbsp;
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript">
TabToEnter();
FormatTable("<%=gvData.ClientID%>")
</script>

</asp:Content>

