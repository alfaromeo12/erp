<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="FinanceCategory.aspx.vb" Inherits="Param_FinanceCategory" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="FINCATNAME">Category Name</asp:ListItem>
        <asp:ListItem Value="FINCATCODE">Category Code</asp:ListItem>
    </asp:DropDownList><asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /><br />

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
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="100%" 
            DataKeyNames="FINCATID" Caption="Finance Category List" 
            RowHeaderColumn="FINCATID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="20px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="FINCATID" HeaderText="ID"
                    SortExpression="FINCATID">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="FINCATCODE" HeaderText="Category&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="FINCATCODE" />
                <asp:BoundField DataField="FINCATNAME" HeaderText="Category&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="FINCATNAME" />
                <asp:BoundField DataField="FINCATTYPENAME" HeaderText="Category&lt;br&gt;Type" HtmlEncode="False"
                    SortExpression="FINCATTYPENAME" />
                <asp:BoundField DataField="PRINCIPALTERM" HeaderText="Principal&lt;br&gt;Term" 
                    HtmlEncode="False" SortExpression="PRINCIPALTERM" />
                <asp:BoundField DataField="INTERESTTERM" HeaderText="Interest&lt;br&gt;Term" HtmlEncode="False"
                    SortExpression="INTERESTTERM" />
                <asp:BoundField DataField="ARTERM" HeaderText="AR&lt;br&gt;Term" HtmlEncode="False"
                    SortExpression="ARTERM" />
                <asp:BoundField DataField="EFFRATETERM" HeaderText="Eff Rate&lt;br&gt;Term" HtmlEncode="False"
                    SortExpression="EFFRATETERM" />
                <asp:BoundField DataField="PENALTYTERM" HeaderText="Penalty&lt;br&gt;Term" HtmlEncode="False"
                    SortExpression="PENALTYTERM" />
                <asp:BoundField DataField="OBJECTVALUETERM" HeaderText="Object Value&lt;br&gt;Term" HtmlEncode="False" 
                    SortExpression="OBJECTVALUETERM" />
                <asp:BoundField DataField="DPTERM" HeaderText="DP&lt;br&gt;Term" HtmlEncode="False" SortExpression="DPTERM" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        
        
        
        SelectCommand="SELECT FINCATID, FINCATCODE, FINCATNAME, '(' + CAST(FINCATTYPE AS VARCHAR(20)) + ') ' + dbo.f_getParamGlobalName('FINCATTYPE', FINCATTYPE) AS FINCATTYPENAME, PRINCIPALTERM, INTERESTTERM, ARTERM, EFFRATETERM, PENALTYTERM, OBJECTVALUETERM, DPTERM FROM FINANCECATEGORY WITH (NOLOCK) WHERE (Deletests = 0)"></asp:SqlDataSource>
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
    <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%" DataKeyNames="FINCATID">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Category ID</td>
                    <td>
                        <asp:Label ID="lblFinCatID" runat="server" Text='<%# Eval("FINCATID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Category Code</td>
                    <td>
                        <asp:TextBox ID="txtFinCatCode" runat="server" Width="56px" MaxLength="10" 
                            Text='<%# Bind("FINCATCODE") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtFinCatCode" 
                            Display="None" ErrorMessage="Category Code must be entry...!" 
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Category Name</td>
                    <td>
                        <asp:TextBox ID="txtFinCatName" runat="server" Width="264px" MaxLength="100" 
                            Text='<%# Bind("FINCATNAME") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtFinCatName" 
                            Display="None" ErrorMessage="Finance Category Name must be entry...!" 
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Category Type</td>
                    <td>
                        <asp:DropDownList ID="ddlFinCatType" runat="server" CssClass="required" 
                            DataSourceID="sdsFinCatType" DataTextField="FINCATTYPE" 
                            DataValueField="CODE" SelectedValue='<%# Bind("FINCATTYPE") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqType" runat="server"
                                ControlToValidate="ddlFinCatType" Display="None" ErrorMessage="Category Type must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqType">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Principal Term</td>
                    <td>
                        <asp:TextBox ID="txtPrinTerm" runat="server" CssClass="required" 
                            MaxLength="100" Text='<%# Bind("PRINCIPALTERM") %>' Width="264px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqPrinTerm" runat="server" 
                            ControlToValidate="txtPrinTerm" Display="None" 
                            ErrorMessage="Principal Term must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEPrin" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPrinTerm">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Interest Term</td>
                    <td>
                        <asp:TextBox ID="txtIntTerm" runat="server" CssClass="required" 
                            MaxLength="100" Width="264px" Text='<%# Bind("INTERESTTERM") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqIntTerm" runat="server"
                                ControlToValidate="txtIntTerm" Display="None" ErrorMessage="Interest Term must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEInt" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqIntTerm">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        AR Term</td>
                    <td>
                        <asp:TextBox ID="txtARTerm" runat="server" CssClass="required" 
                            MaxLength="100" Width="264px" Text='<%# Bind("ARTERM") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqARTerm" runat="server"
                                ControlToValidate="txtARTerm" Display="None" ErrorMessage="AR Term must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender
                                ID="ValidatorCalloutExtender1" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqARTerm">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td >
                        Eff Rate Term</td>
                    <td >
                        <asp:TextBox ID="txtEffRateTerm" runat="server" CssClass="required" MaxLength="100" 
                            Text='<%# Bind("EFFRATETERM") %>' Width="264px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqEffRateTerm" runat="server" 
                            ControlToValidate="txtEffRateTerm" Display="None" 
                            ErrorMessage="Eff Rate Term must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqEffRateTerm_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqEffRateTerm">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Penalty Term</td>
                    <td>
                        <asp:TextBox ID="txtPenaltyTerm" runat="server" CssClass="required" 
                            MaxLength="100" Text='<%# Bind("PENALTYTERM") %>' Width="264px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqPenaltyTerm" runat="server" 
                            ControlToValidate="txtPenaltyTerm" Display="None" 
                            ErrorMessage="Penalty Term must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqPenaltyTerm_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqPenaltyTerm">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Object Value Term</td>
                    <td>
                        <asp:TextBox ID="txtOVTerm" runat="server" CssClass="required" 
                            MaxLength="100" Text='<%# Bind("OBJECTVALUETERM") %>' Width="264px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqOVTerm" runat="server" 
                            ControlToValidate="txtOVTerm" Display="None" 
                            ErrorMessage="Object Value Term must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqOVTerm_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqOVTerm">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Down Payment Term</td>
                    <td>
                        <asp:TextBox ID="txtDPTerm" runat="server" CssClass="required" MaxLength="100" 
                            Text='<%# Bind("DPTERM") %>' Width="264px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqDPTerm" runat="server" 
                            ControlToValidate="txtDPTerm" Display="None" 
                            ErrorMessage="Down Payment Term must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqDPTerm_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDPTerm">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" class="FooterStyle">
                        <uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
                        &nbsp;<uc2:BtnDelete ID="BtnDelete1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table cellpadding=0 cellspacing=0 width=600>
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Category Code</td>
                    <td>
                        <asp:TextBox ID="txtFinCatCode" runat="server" CssClass="required" 
                            MaxLength="10" Width="56px" Text='<%# Bind("FINCATCODE") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqCode" runat="server"
                                ControlToValidate="txtFinCatCode" Display="None" ErrorMessage="Category Code must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Category Name</td>
                    <td>
                        <asp:TextBox ID="txtFinCatName" runat="server" CssClass="required" 
                            MaxLength="100" Width="264px" Text='<%# Bind("FINCATNAME") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqName" runat="server"
                                ControlToValidate="txtFinCatName" Display="None" ErrorMessage="Category Name must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Category Type</td>
                    <td>
                        <asp:DropDownList ID="ddlFinCatType" runat="server" CssClass="required" 
                            DataSourceID="sdsFinCatType" DataTextField="FINCATTYPE" 
                            DataValueField="CODE" SelectedValue='<%# Bind("FINCATTYPE") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqType" runat="server"
                                ControlToValidate="ddlFinCatType" Display="None" ErrorMessage="Category Type must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqType">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Principal Term</td>
                    <td>
                        <asp:TextBox ID="txtPrinTerm" runat="server" CssClass="required" 
                            MaxLength="100" Text='<%# Bind("PRINCIPALTERM") %>' Width="264px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqPrinTerm" runat="server" 
                            ControlToValidate="txtPrinTerm" Display="None" 
                            ErrorMessage="Principal Term must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEPrin" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPrinTerm">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Interest Term</td>
                    <td>
                        <asp:TextBox ID="txtIntTerm" runat="server" CssClass="required" 
                            MaxLength="100" Width="264px" Text='<%# Bind("INTERESTTERM") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqIntTerm" runat="server"
                                ControlToValidate="txtIntTerm" Display="None" ErrorMessage="Interest Term must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEInt" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqIntTerm">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        AR Term</td>
                    <td>
                        <asp:TextBox ID="txtARTerm" runat="server" CssClass="required" 
                            MaxLength="100" Width="264px" Text='<%# Bind("ARTERM") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqARTerm" runat="server"
                                ControlToValidate="txtARTerm" Display="None" ErrorMessage="AR Term must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEAR" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqARTerm">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Eff Rate Term</td>
                    <td>
                        <asp:TextBox ID="txtEffRateTerm" runat="server" CssClass="required" 
                            MaxLength="100" Text='<%# Bind("EFFRATETERM") %>' Width="264px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqEffRateTerm" runat="server" 
                            ControlToValidate="txtEffRateTerm" Display="None" 
                            ErrorMessage="Eff Rate Term must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqEffRateTerm_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqEffRateTerm">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Penalty Term</td>
                    <td>
                        <asp:TextBox ID="txtPenaltyTerm" runat="server" CssClass="required" 
                            MaxLength="100" Text='<%# Bind("PENALTYTERM") %>' Width="264px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqPenaltyTerm" runat="server" 
                            ControlToValidate="txtPenaltyTerm" Display="None" 
                            ErrorMessage="Penalty Term must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqPenaltyTerm_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqPenaltyTerm">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Object Value Term</td>
                    <td>
                        <asp:TextBox ID="txtOVTerm" runat="server" CssClass="required" MaxLength="100" 
                            Text='<%# Bind("OBJECTVALUETERM") %>' Width="264px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqOVTerm" runat="server" 
                            ControlToValidate="txtOVTerm" Display="None" 
                            ErrorMessage="Object Value Term must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqOVTerm_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqOVTerm">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Down Payment Term</td>
                    <td>
                        <asp:TextBox ID="txtDPTerm" runat="server" CssClass="required" MaxLength="100" 
                            Text='<%# Bind("DPTERM") %>' Width="264px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqDPTerm" runat="server" 
                            ControlToValidate="txtDPTerm" Display="None" 
                            ErrorMessage="Down Payment Term must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqDPTerm_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDPTerm">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" class="FooterStyle">
                        <uc4:BtnInsert ID="BtnInsert2" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel2" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT FINCATID, FINCATCODE, FINCATNAME, FINCATTYPE, PRINCIPALTERM, INTERESTTERM, ARTERM, EFFRATETERM, PENALTYTERM, OBJECTVALUETERM, DPTERM FROM FINANCECATEGORY WHERE (FINCATID = @FINCATID) AND (Deletests = 0)" 
        DeleteCommand="UPDATE FINANCECATEGORY SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID WHERE FINCATID=@FINCATID" 
        UpdateCommand="FinanceCategoryUpdate" InsertCommand="FinanceCategoryAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="FINCATID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="FINCATID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="FINCATID" Type="Int32" />
            <asp:Parameter Name="FINCATCODE" Type="String" />
            <asp:Parameter Name="FINCATNAME" Type="String" />
            <asp:Parameter Name="FINCATTYPE" Type="Int32" />
            <asp:Parameter Name="PrincipalTerm" Type="String" />
            <asp:Parameter Name="INTERESTTERM" Type="String" />
            <asp:Parameter Name="ARTERM" Type="String" />
            <asp:Parameter Name="EFFRATETERM" Type="String" />
            <asp:Parameter Name="PENALTYTERM" Type="String" />
            <asp:Parameter Name="OBJECTVALUETERM" Type="String" />
            <asp:Parameter Name="DPTERM" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="FINCATCODE" Type="String" />
            <asp:Parameter Name="FINCATNAME" Type="String" />
            <asp:Parameter Name="FINCATTYPE" Type="Int32" />
            <asp:Parameter Name="PrincipalTerm" Type="String" />
            <asp:Parameter Name="INTERESTTERM" Type="String" />
            <asp:Parameter Name="ARTERM" Type="String" />
            <asp:Parameter Name="EFFRATETERM" Type="String" />
            <asp:Parameter Name="PENALTYTERM" Type="String" />
            <asp:Parameter Name="OBJECTVALUETERM" Type="String" />
            <asp:Parameter Name="DPTERM" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsFinCatType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT CODE, '(' + CODE + ') ' + NAME AS FINCATTYPE FROM PARAMGLOBAL WHERE (TYPE = 'FINCATTYPE')" 
        DeleteCommand="UPDATE FINANCECATEGORY SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID WHERE FINCATID=@FINCATID" 
        UpdateCommand="FinanceCategoryUpdate" InsertCommand="FinanceCategoryAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="FINCATID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="FINCATID" Type="Int32" />
            <asp:Parameter Name="FINCATCODE" Type="String" />
            <asp:Parameter Name="FINCATNAME" Type="String" />
            <asp:Parameter Name="FINCATTYPE" Type="Int32" />
            <asp:Parameter Name="PrincipalTerm" Type="String" />
            <asp:Parameter Name="INTERESTTERM" Type="String" />
            <asp:Parameter Name="ARTERM" Type="String" />            
            <asp:Parameter Name="EFFRATETERM" Type="String" />
            <asp:Parameter Name="PENALTYTERM" Type="String" />
            <asp:Parameter Name="OBJECTVALUETERM" Type="String" />
            <asp:Parameter Name="DPTERM" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="FINCATCODE" Type="String" />
            <asp:Parameter Name="FINCATNAME" Type="String" />
            <asp:Parameter Name="FINCATTYPE" Type="Int32" />
            <asp:Parameter Name="PrincipalTerm" Type="String" />
            <asp:Parameter Name="INTERESTTERM" Type="String" />
            <asp:Parameter Name="ARTERM" Type="String" />
            <asp:Parameter Name="EFFRATETERM" Type="String" />
            <asp:Parameter Name="PENALTYTERM" Type="String" />
            <asp:Parameter Name="OBJECTVALUETERM" Type="String" />
            <asp:Parameter Name="DPTERM" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
</script>
</asp:Content>

