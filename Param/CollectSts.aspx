<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="CollectSts.aspx.vb" Inherits="Param_Collect" title="Collect Status" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsertNoSPV.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdateNoSPV.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td style="width: 125px">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="COLLECTNAME">COLLECT NAME</asp:ListItem>
    </asp:DropDownList></td>
            <td>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /></td>
        </tr>
        <tr>
            <td style="width: 125px">
                Collect Category
            </td>
            <td>
                <asp:DropDownList ID="ddlCollectCatSearch" runat="server" DataSourceID="sdsCollectCatSearch"
                    DataTextField="NAME" DataValueField="CODE" AutoPostBack="True">
                </asp:DropDownList><asp:SqlDataSource ID="sdsCollectCatSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'COLLECTCAT')">
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
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="100%" DataKeyNames="COLLECTID" Caption="Collectibility Status List" RowHeaderColumn="COLLECTID">
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" 
                            CommandName="Select" ImageUrl="~/Images/edit.gif" Text="Select" 
                            Visible='<%# NOT Eval("NEW") %>' />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:TemplateField>
                <asp:BoundField DataField="COLLECTID" HeaderText="ID" ReadOnly="True" SortExpression="COLLECTID" />
                <asp:BoundField DataField="COLLECTCODE" HeaderText="Collect&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="COLLECTCODE" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="COLLECTNAME" HeaderText="Collect&lt;BR&gt;Name" HtmlEncode="False"
                    SortExpression="COLLECTNAME" />
                <asp:BoundField DataField="CONDITION1" HeaderText="Condition&lt;br&gt;1" HtmlEncode="False"
                    ReadOnly="True" SortExpression="CONDITION1" />
                <asp:BoundField DataField="CONDITION2" HeaderText="Condition&lt;br&gt;2" HtmlEncode="False"
                    ReadOnly="True" SortExpression="CONDITION2" />
                <asp:BoundField DataField="REMARK" HeaderText="Remark" HtmlEncode="False" SortExpression="REMARK" />
                <asp:BoundField DataField="RESERVED" DataFormatString="{0:N2}" HeaderText="Reserved&lt;BR&gt;(%)"
                    HtmlEncode="False" SortExpression="RESERVED">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT COLLECTID, COLLECTNAME, CONDITION1, CONDITION2, REMARK, COLLECTCODE, RESERVED, COLLATERALPERCENTAGE, COLLECTCAT, NEW, UPD, FROMDPD FROM (SELECT COLLECTID, COLLECTNAME, 'X' + FROMOPR + CAST(FROMDPD AS VARCHAR(20)) AS CONDITION1, 'X' + TOOPR + CAST(TODPD AS VARCHAR(20)) AS CONDITION2, REMARK, COLLECTCODE, RESERVED, COLLATERALPERCENTAGE, COLLECTCAT, CAST(0 AS BIT) AS NEW, CASE WHEN EXISTS (SELECT 'X' FROM COLLECTSTSX WHERE COLLECTSTS_1.COLLECTID = COLLECTSTSX.COLLECTID) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS UPD, FROMDPD FROM COLLECTSTS AS COLLECTSTS_1 WHERE (COLLECTCAT = @COLLECTCAT) UNION ALL SELECT COLLECTID, COLLECTNAME, 'X' + FROMOPR + CAST(FROMDPD AS VARCHAR(20)) AS CONDITION1, 'X' + TOOPR + CAST(TODPD AS VARCHAR(20)) AS CONDITION2, REMARK, COLLECTCODE, RESERVED, COLLATERALPERCENTAGE, COLLECTCAT, CAST(1 AS BIT) AS NEW, CAST(0 AS BIT) AS UPD, FROMDPD FROM COLLECTSTSX WHERE (COLLECTCAT = @COLLECTCAT) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM COLLECTSTS AS COLLECTSTS_2 WHERE (COLLECTSTSX.COLLECTID = COLLECTID)))) AS COLLECTSTS WHERE (COLLECTCAT = @COLLECTCAT)">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlCollectCatSearch" Name="COLLECTCAT" PropertyName="SelectedValue" />
        </SelectParameters>
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
        DefaultMode="Edit" Width="100%" DataKeyNames="COLLECTID">
        <EditItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        ID</td>
                    <td>
            <asp:Label ID="COLLECTIDLabel1" runat="server" Text='<%# Eval("COLLECTID") %>' Font-Bold="True" Font-Underline="True"></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Collect Code</td>
                    <td>
                        <asp:TextBox ID="txtCollectCode" runat="server" CssClass="required" MaxLength="5"
                            Text='<%# Bind("COLLECTCODE") %>' Width="54px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqCollectCode" runat="server" ControlToValidate="txtCollectCode" Display="None"
                                ErrorMessage="COLLECT CODE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCECollectCode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCollectCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Collectibility Category</td>
                    <td>
                        <asp:DropDownList ID="ddlCollectCat" runat="server" CssClass="required" DataSourceID="sdsCollectCat"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("COLLECTCAT") %>'>
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqCollectCat" runat="server"
                            ControlToValidate="ddlCollectCat" Display="None" ErrorMessage="COLLECT CATEGORY must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECollectCat" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCollectCat">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Collectibility Name</td>
                    <td>
                        <asp:TextBox ID="txtCollectName" runat="server" CssClass="required" MaxLength="50"
                            Text='<%# Bind("COLLECTNAME") %>'></asp:TextBox><asp:RequiredFieldValidator ID="reqCollectName"
                                runat="server" ControlToValidate="txtCollectName" Display="None" ErrorMessage="COLLECT NAME must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCECollectName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCollectName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Condition 1</td>
                    <td>
                        X
                        <asp:DropDownList ID="ddlOPRFrom" runat="server" CssClass="required" DataSourceID="sdsOPR"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("FROMOPR") %>'>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtDPDFrom" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("FROMDPD") %>' Width="64px"></asp:TextBox>day(s)<asp:RequiredFieldValidator
                                ID="reqDPDFrom" runat="server" ControlToValidate="txtDPDFrom" Display="None"
                                ErrorMessage="DPD FROM must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEDPDFrom" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDPDFrom">
                                </ajaxToolkit:ValidatorCalloutExtender>
                        <asp:RequiredFieldValidator ID="reqOPRFrom" runat="server" ControlToValidate="ddlOPRFrom"
                            Display="None" ErrorMessage="OPERATOR FROM must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEOPRFrom" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqOPRFrom">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Conditon 2</td>
                    <td>
                        X
                        <asp:DropDownList ID="ddlOPRTo" runat="server" CssClass="required" DataSourceID="sdsOPR"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("TOOPR") %>'>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtDPDTo" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("TODPD") %>' Width="64px"></asp:TextBox>day(s)<asp:RequiredFieldValidator
                                ID="reqDPDTo" runat="server" ControlToValidate="txtDPDTo" Display="None" ErrorMessage="DPD TO must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEDPDTo" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDPDTo">
                                </ajaxToolkit:ValidatorCalloutExtender>
                        <asp:RequiredFieldValidator ID="reqOPRTo" runat="server" ControlToValidate="ddlOPRTo"
                            Display="None" ErrorMessage="OPERATOR TO must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEOPRTo" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqOPRTo">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Remark</td>
                    <td>
                        <asp:TextBox ID="REMARKTextBox" runat="server" MaxLength="100" Text='<%# Bind("REMARK") %>'
                            Width="248px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        Collateral Pecentage</td>
                    <td>
                        <asp:TextBox ID="txtCollateralPercent" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("COLLATERALPERCENTAGE") %>' Width="48px"></asp:TextBox>
                        %<asp:RequiredFieldValidator ID="reqCollateralPercent" runat="server" ControlToValidate="txtCollateralPercent"
                            Display="None" ErrorMessage="COLLATERAL PERCENTAGE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECollateralPercentage" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCollateralPercent">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Reserved</td>
                    <td>
                        <asp:TextBox ID="txtReserved" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("RESERVED") %>' Width="48px"></asp:TextBox>
                        %<asp:RequiredFieldValidator ID="reqReserved" runat="server" ControlToValidate="txtReserved"
                            Display="None" ErrorMessage="RESERVED must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEReserved" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqReserved">
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
                        <uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
                        <uc2:BtnDelete ID="BtnDelete1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel2" runat="server" />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        Collect Code</td>
                    <td>
                        <asp:TextBox ID="txtCollectCode" runat="server" CssClass="required" MaxLength="5"
                            Text='<%# Bind("COLLECTCODE") %>' Width="54px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqCollectCode" runat="server" ControlToValidate="txtCollectCode" Display="None"
                                ErrorMessage="COLLECT CODE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCECollectCode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCollectCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr style="text-decoration: underline">
                    <td>
                        Collectibility Category</td>
                    <td>
                        <asp:DropDownList ID="ddlCollectCat" runat="server" CssClass="required" DataSourceID="sdsCollectCat"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("COLLECTCAT") %>'>
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqCollectCat" runat="server"
                            ControlToValidate="ddlCollectCat" Display="None" ErrorMessage="COLLECT CATEGORY must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECollectCat" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCollectCat">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Collectibility Name</td>
                    <td>
                        <asp:TextBox ID="txtCollectName" runat="server" CssClass="required" MaxLength="50"
                            Text='<%# Bind("COLLECTNAME") %>'></asp:TextBox><asp:RequiredFieldValidator ID="reqCollectName"
                                runat="server" ControlToValidate="txtCollectName" Display="None" ErrorMessage="COLLECT NAME must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCECollectName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCollectName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Condition 1</td>
                    <td>
                        X
                        <asp:DropDownList ID="ddlOPRFrom" runat="server" CssClass="required" DataSourceID="sdsOPR"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("FROMOPR") %>'>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtDPDFrom" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("FROMDPD") %>' Width="64px"></asp:TextBox>day(s)<asp:RequiredFieldValidator
                                ID="reqDPDFrom" runat="server" ControlToValidate="txtDPDFrom" Display="None"
                                ErrorMessage="DPD FROM must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEDPDFrom" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDPDFrom">
                                </ajaxToolkit:ValidatorCalloutExtender>
                        <asp:RequiredFieldValidator ID="reqOPRFrom" runat="server" ControlToValidate="ddlOPRFrom"
                            Display="None" ErrorMessage="OPERATOR FROM must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEOPRFrom" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqOPRFrom">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Conditon 2</td>
                    <td>
                        X
                        <asp:DropDownList ID="ddlOPRTo" runat="server" CssClass="required" DataSourceID="sdsOPR"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("TOOPR") %>'>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtDPDTo" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("TODPD") %>' Width="64px"></asp:TextBox>day(s)<asp:RequiredFieldValidator
                                ID="reqDPDTo" runat="server" ControlToValidate="txtDPDTo" Display="None" ErrorMessage="DPD TO must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEDPDTo" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDPDTo">
                                </ajaxToolkit:ValidatorCalloutExtender>
                        <asp:RequiredFieldValidator ID="reqOPRTo" runat="server" ControlToValidate="ddlOPRTo"
                            Display="None" ErrorMessage="OPERATOR TO must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEOPRTo" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqOPRTo">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Remark</td>
                    <td>
                        <asp:TextBox ID="REMARKTextBox" runat="server" MaxLength="100" Text='<%# Bind("REMARK") %>'
                            Width="248px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        Collateral Pecentage</td>
                    <td>
                        <asp:TextBox ID="txtCollateralPercent" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("COLLATERALPERCENTAGE") %>' Width="48px"></asp:TextBox>
                        %<asp:RequiredFieldValidator ID="reqCollateralPercent" runat="server" ControlToValidate="txtCollateralPercent"
                            Display="None" ErrorMessage="COLLATERAL PERCENTAGE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECollateralPercentage" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCollateralPercent">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Reserved</td>
                    <td>
                        <asp:TextBox ID="txtReserved" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("RESERVED") %>' Width="48px"></asp:TextBox>
                        %<asp:RequiredFieldValidator ID="reqReserved" runat="server" ControlToValidate="txtReserved"
                            Display="None" ErrorMessage="RESERVED must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEReserved" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqReserved">
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
                        <uc4:BtnInsert ID="BtnInsert1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT COLLECTID, COLLECTCAT, COLLECTNAME, FROMDPD, FROMOPR, TODPD, TOOPR, REMARK, COLLECTCODE, RESERVED, COLLATERALPERCENTAGE FROM COLLECTSTS WHERE (COLLECTID = @COLLECTID) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM COLLECTSTSX WHERE (COLLECTSTS.COLLECTID = COLLECTID))) UNION ALL SELECT COLLECTID, COLLECTCAT, COLLECTNAME, FROMDPD, FROMOPR, TODPD, TOOPR, REMARK, COLLECTCODE, RESERVED, COLLATERALPERCENTAGE FROM COLLECTSTSX AS COLLECTSTSX_1 WHERE (COLLECTID = @COLLECTID)" 
        DeleteCommand="DELETE FROM COLLECTSTS WHERE (COLLECTID = @COLLECTID)" 
        UpdateCommand="COLLECTSTSUpdate" InsertCommand="COLLECTSTSAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="COLLECTID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="COLLECTID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="COLLECTID" Type="Int32" />
            <asp:Parameter Name="COLLECTCODE" Type="String" />
            <asp:Parameter Name="COLLECTCAT" Type="String" />
            <asp:Parameter Name="COLLECTNAME" Type="String" />
            <asp:Parameter Name="FROMDPD" Type="Int32" />
            <asp:Parameter Name="FROMOPR" Type="String" />
            <asp:Parameter Name="TODPD" Type="Int32" />
            <asp:Parameter Name="TOOPR" Type="String" />
            <asp:Parameter Name="REMARK" Type="String" />
            <asp:Parameter Name="RESERVED" Type="Double" />
            <asp:Parameter Name="COLLATERALPERCENTAGE" Type="Double" />
            <asp:CookieParameter CookieName="UID" Name="USERID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="RETVAL" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="COLLECTCAT" Type="String" />
            <asp:Parameter Name="COLLECTCODE" Type="String" />
            <asp:Parameter Name="COLLECTNAME" Type="String" />
            <asp:Parameter Name="FROMDPD" Type="Int32" />
            <asp:Parameter Name="FROMOPR" Type="String" />
            <asp:Parameter Name="TODPD" Type="Int32" />
            <asp:Parameter Name="TOOPR" Type="String" />
            <asp:Parameter Name="REMARK" Type="String" />
            <asp:Parameter Name="RESERVED" Type="Double" />
            <asp:Parameter Name="COLLATERALPERCENTAGE" Type="Double" />
            <asp:CookieParameter CookieName="UID" Name="USERID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="RETVAL" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsOPR" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS CODE, '[OPERATOR]' AS NAME UNION ALL SELECT CODE, NAME FROM PARAMGLOBAL WHERE (TYPE = 'OPERATOR')">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCollectCat" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS CODE, '[COLLECT CATEGORY]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'COLLECTCAT')">
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
</script>

</asp:Content>

