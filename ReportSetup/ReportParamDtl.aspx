<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ReportParamDtl.aspx.vb" Inherits="ReportSetup_ReportParamDtl" title="Report Parameter(s) Detail" EnableEventValidation="false" MaintainScrollPositionOnPostback="true"%>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc3" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="100%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Details...)</asp:Label>
        </div>
        <asp:Button ID="btnBack" runat="server" CausesValidation="False" Style="cursor: pointer; background-image: url(../images/back.gif); background-repeat: no-repeat;"
            Text="Back To Parameter" /></asp:Panel>
    <ajaxToolkit:collapsiblepanelextender id="ajaxCPEData" runat="server" collapsecontrolid="pnlShow"
        collapsedimage="~/images/expand.jpg" collapsedtext="(Show Detail...)" enabled="True"
        expandcontrolid="pnlShow" expandedimage="~/images/collapse.jpg" expandedtext="(Hide Detail...)"
        imagecontrolid="imgButtonShow" targetcontrolid="pnlData" textlabelid="lblShow">
    </ajaxToolkit:collapsiblepanelextender>
    <asp:Panel ID="pnlData" runat="server" GroupingText="Detail Data">
    <asp:DataList ID="dlReport" runat="server" Caption="Report Info" DataKeyField="ReportId"
        DataSourceID="sdsReport" Width="100%">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td style="width: 105px; height: 19px;">
                        Report
                        ID</td>
                    <td style="height: 19px">
                        <asp:Label ID="ReportIdLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ReportId") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 105px">
                        Modul</td>
                    <td>
                        (<asp:Label ID="ModulCodeLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ModulCode") %>'></asp:Label>)
                        <asp:Label ID="ModulNameLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ModulName") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 105px">
                        Report
                    </td>
                    <td>
                        <asp:Label ID="ReportNameLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ReportName") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 105px">
                        File</td>
                    <td>
                        <asp:Label ID="FileNameLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("FileName") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 105px">
                        Description</td>
                    <td>
                        <asp:Label ID="DescriptionLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("Description") %>'></asp:Label></td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="sdsReport" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT rptModul.ModulCode, rptModul.ModulName, rptList.ReportName, rptList.FileName, rptList.Description, rptList.ReportId FROM rptList INNER JOIN rptModul ON rptList.ModulId = rptModul.ModulId WHERE (rptList.ReportId = @ReportID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ReportID" QueryStringField="ReportID" />
        </SelectParameters>
    </asp:SqlDataSource>
        <asp:DataList ID="dlParameter" runat="server" Caption="Parameter Info" DataSourceID="sdsParamInfo"
            Width="100%">
            <ItemTemplate>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td style="width: 105px">
                            Param ID</td>
                        <td>
                            <asp:Label ID="lblParamID" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("ParamID") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 105px">
                            Parameter Name</td>
                        <td>
                            <asp:Label ID="ParamNameLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("ParamName") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 105px">
                            Description</td>
                        <td>
                            <asp:Label ID="DescriptionLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("Description") %>'></asp:Label></td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList><asp:SqlDataSource ID="sdsParamInfo" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            SelectCommand="SELECT ParamID, ParamName, Description FROM rptParam WHERE (ParamId = @ParamID)">
            <SelectParameters>
                <asp:QueryStringParameter Name="ParamID" QueryStringField="ParamID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>
    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" ToolTip="New Parameter Detail" CausesValidation="False" /><br />
    <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
        DataKeyNames="ID" DataSourceID="sdsGrid" Width="100%" Caption="Report Parameter(s) Detail">
        <Columns>
            <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                <ItemStyle Width="20px" />
            </asp:CommandField>
            <asp:BoundField DataField="FieldName" HeaderText="Field&lt;br&gt;Name" HtmlEncode="False"
                SortExpression="FieldName" />
            <asp:BoundField DataField="PromptText" HeaderText="Prompt&lt;br&gt;Text" HtmlEncode="False"
                SortExpression="PromptText" />
            <asp:BoundField DataField="FieldDataType" HeaderText="Field&lt;br&gt;DataType" HtmlEncode="False"
                ReadOnly="True" SortExpression="FieldDataType" />
            <asp:BoundField DataField="FieldInputType" HeaderText="Field&lt;br&gt;InputType"
                HtmlEncode="False" ReadOnly="True" SortExpression="FieldInputType" />
            <asp:BoundField DataField="Source" HeaderText="Source" SortExpression="Source" />
        </Columns>
        <EmptyDataTemplate>
            <uc1:NoDataFound ID="NoDataFound1" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT rptParamDetail.ID, rptParamDetail.ParamId, rptParamDetail.FieldName, rptParamDetail.PromptText, rptParamDetail.Source, '(' + CAST(rptParamDetail.FieldDataType AS VARCHAR(20)) + ') ' + PARAMGLOBAL.NAME AS FieldDataType, '(' + CAST(rptParamDetail.FieldInputType AS varchar(20)) + ') ' + + PARAMGLOBAL_1.NAME AS FieldInputType FROM rptParamDetail INNER JOIN PARAMGLOBAL ON rptParamDetail.FieldDataType = PARAMGLOBAL.CODE AND PARAMGLOBAL.TYPE = 'FIELDDATATYPE' INNER JOIN PARAMGLOBAL AS PARAMGLOBAL_1 ON rptParamDetail.FieldInputType = PARAMGLOBAL_1.CODE AND PARAMGLOBAL_1.TYPE = 'FIELDINPUTTYPE' WHERE (rptParamDetail.ParamId = @ParamID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ParamID" QueryStringField="ParamID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <input id="btnCopy" style="background-position: left; background-image: url(../images/expand.jpg);
        cursor: pointer; background-repeat: no-repeat" type="button" value="Copy Parameter(s)" onclick="ParamCopy()"/>
    <asp:FormView ID="fvData" runat="server" DataKeyNames="ID" DataSourceID="sdsForm" DefaultMode="Edit" Width="100%">
        <InsertItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        Field Name</td>
                    <td>
                        <asp:TextBox ID="txtFieldName" runat="server" MaxLength="50" Text='<%# Bind("FieldName") %>'
                            Width="264px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqFieldName"
                                runat="server" ControlToValidate="txtFieldName" Display="None" ErrorMessage="Field Name must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEFieldName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqFieldName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Prompt Text</td>
                    <td>
                        <asp:TextBox ID="txtPromptText" runat="server" MaxLength="50" Text='<%# Bind("PromptText") %>'
                            Width="264px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqPromptText"
                                runat="server" ControlToValidate="txtPromptText" Display="None" ErrorMessage="Prompt Text must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEPromptText" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPromptText">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Field Data Type</td>
                    <td>
                        <asp:DropDownList ID="ddlDataType" runat="server" DataSourceID="sdsFieldDataType"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("FieldDataType") %>'>
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td>
                        Field Input Type</td>
                    <td>
                        <asp:DropDownList ID="ddlFieldInputType" runat="server" DataSourceID="sdsFieldInputType"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("FieldInputType") %>'>
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td>
                        Field Size</td>
                    <td>
                        <asp:TextBox ID="txtFieldSize" runat="server" Text='<%# Bind("FieldSize") %>' Width="48px" style="text-align: right" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqFieldSize" runat="server" ControlToValidate="txtFieldSize" Display="None"
                            ErrorMessage="Field Size must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEFieldSize" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqFieldSize">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Required</td>
                    <td>
                        <asp:DropDownList ID="ddlRequired" runat="server" DataSourceID="sdsRequired" DataTextField="NAME"
                            DataValueField="CODE" SelectedValue='<%# Bind("Required") %>'>
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td>
                        &nbsp; &nbsp; Source</td>
                    <td>
                        <asp:DropDownList ID="ddlSource" runat="server" SelectedValue='<%# Bind("Source") %>'>
                        </asp:DropDownList><ajaxToolkit:CascadingDropDown ID="ajaxCDDSource" runat="server" Category="SOURCE" LoadingText="[Loading DB Source..]"
                            PromptText="[CHOOSE SOURCE]" ServiceMethod="GetDropDownSource" TargetControlID="ddlSource" ServicePath="~\Param\WebService.asmx" SelectedValue='<%# eval("Source") %>'>
                        </ajaxToolkit:CascadingDropDown>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp; &nbsp; Field Value</td>
                    <td>
                        <asp:DropDownList ID="ddlFieldValue" runat="server" SelectedValue='<%# Bind("FieldValue") %>'>
                        </asp:DropDownList><ajaxToolkit:CascadingDropDown ID="ajaxFieldValue" runat="server" Category="FIELDVALUE" LoadingText="[Loading Field Value..]"
                            PromptText="[CHOOSE FIELD VALUE]" ServiceMethod="GetDropDownFieldBySource" TargetControlID="ddlFieldValue" ParentControlID="ddlSource" ServicePath="~\Param\WebService.asmx">
                        </ajaxToolkit:CascadingDropDown>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;&nbsp; &nbsp;Field Text</td>
                    <td>
                        <asp:DropDownList ID="ddlFieldText" runat="server" SelectedValue='<%# Bind("FieldText") %>'>
                        </asp:DropDownList>
                        <ajaxToolkit:CascadingDropDown ID="ajaxCCDFieldText" runat="server" Category="FIELDTEXT" LoadingText="[Loading Field Text..]"
                            PromptText="[CHOOSE FIELD TEXT]" ServiceMethod="GetDropDownFieldBySource" TargetControlID="ddlFieldText" ParentControlID="ddlSource" ServicePath="~\Param\WebService.asmx">
                        </ajaxToolkit:CascadingDropDown>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp; &nbsp; Field Default Value</td>
                    <td>
                        <asp:TextBox ID="txtFieldDefaultValue" runat="server" MaxLength="50" Text='<%# Bind("FieldDefaultValue") %>'
                            Width="264px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        &nbsp; &nbsp; Field Condition</td>
                    <td>
                        <asp:TextBox ID="txtFieldCondition" runat="server" MaxLength="100" Text='<%# Bind("FieldCondition") %>'
                            Width="416px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        Branch Filter</td>
                    <td>
                        <asp:DropDownList ID="ddlBranchFilter" runat="server" 
                            DataSourceID="sdsBranchFilter" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("BRANCHFILTER") %>'>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Finance Cat. Filter</td>
                    <td>
                        <asp:DropDownList ID="ddlFinCatFilter" runat="server" 
                            DataSourceID="sdsBranchFilter" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("FINCATFILTER") %>'>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <uc2:BtnInsert ID="BtnInsert1" runat="server" />
                        <uc4:BtnCancelHTML ID="BtnCancelHTML1" runat="server" />
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
        <EditItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        ID</td>
                    <td>
                        <asp:Label ID="lblID" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("ID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Field Name</td>
                    <td>
                        <asp:TextBox ID="txtFieldName" runat="server" MaxLength="50" Text='<%# Bind("FieldName") %>'
                            Width="264px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqFieldName"
                                runat="server" ControlToValidate="txtFieldName" Display="None" ErrorMessage="Field Name must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEFieldName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqFieldName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Prompt Text</td>
                    <td>
                        <asp:TextBox ID="txtPromptText" runat="server" MaxLength="50" Text='<%# Bind("PromptText") %>'
                            Width="264px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqPromptText"
                                runat="server" ControlToValidate="txtPromptText" Display="None" ErrorMessage="Prompt Text must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEPromptText" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPromptText">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Field Data Type</td>
                    <td>
                        <asp:DropDownList ID="ddlDataType" runat="server" DataSourceID="sdsFieldDataType"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("FieldDataType") %>'>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Field Input Type</td>
                    <td>
                        <asp:DropDownList ID="ddlFieldInputType" runat="server" DataSourceID="sdsFieldInputType"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("FieldInputType") %>'>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Field Size</td>
                    <td>
                        <asp:TextBox ID="txtFieldSize" runat="server" Text='<%# Bind("FieldSize") %>' Width="48px" style="text-align: right" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqFieldSize" runat="server" ControlToValidate="txtFieldSize" Display="None"
                            ErrorMessage="Field Size must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEFieldSize" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqFieldSize">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Required</td>
                    <td>
                        <asp:DropDownList ID="ddlRequired" runat="server" DataSourceID="sdsRequired" DataTextField="NAME"
                            DataValueField="CODE" SelectedValue='<%# Bind("Required") %>'>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp; &nbsp; Source</td>
                    <td>
                        <asp:DropDownList ID="ddlSource" runat="server" SelectedValue='<%# Bind("Source") %>' DataSourceID="sdsSource" DataTextField="name" DataValueField="name">
                        </asp:DropDownList>
                        <ajaxToolkit:CascadingDropDown ID="ajaxCDDSource" runat="server" Category="SOURCE" LoadingText="[Loading DB Source..]"
                            PromptText="[CHOOSE SOURCE]" ServiceMethod="GetDropDownSource" TargetControlID="ddlSource" ServicePath="~\Param\WebService.asmx" SelectedValue='<%#eval("source")%>'>
                        </ajaxToolkit:CascadingDropDown>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp; &nbsp; Field Value</td>
                    <td>
                        <asp:DropDownList ID="ddlFieldValue" runat="server" SelectedValue='<%# Bind("FieldValue") %>' DataSourceID="sdsFieldValue" DataTextField="name" DataValueField="name">
                        </asp:DropDownList><ajaxToolkit:CascadingDropDown ID="ajaxFieldValue" runat="server" Category="FIELDVALUE" LoadingText="[Loading Field Value..]"
                            PromptText="[CHOOSE FIELD]" ServiceMethod="GetDropDownFieldBySource" TargetControlID="ddlFieldValue" ParentControlID="ddlSource" ServicePath="~\Param\WebService.asmx" SelectedValue='<%#eval("FieldValue")%>'>
                        </ajaxToolkit:CascadingDropDown>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;&nbsp; &nbsp;Field Text</td>
                    <td>
                        <asp:DropDownList ID="ddlFieldText" runat="server" SelectedValue='<%# Bind("FieldText") %>' DataSourceID="sdsFieldValue" DataTextField="name" DataValueField="name">
                        </asp:DropDownList>
                        <ajaxToolkit:CascadingDropDown ID="ajaxCCDFieldText" runat="server" Category="FIELDTEXT" LoadingText="[Loading Field Text..]"
                            PromptText="[CHOOSE FIELD TEXT]" ServiceMethod="GetDropDownFieldBySource" TargetControlID="ddlFieldText" ParentControlID="ddlSource" ServicePath="~\Param\WebService.asmx" SelectedValue='<%#eval("FieldText")%>'>
                        </ajaxToolkit:CascadingDropDown>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp; &nbsp; Field Default Value</td>
                    <td>
                        <asp:TextBox ID="txtFieldDefaultValue" runat="server" MaxLength="50" Text='<%# Bind("FieldDefaultValue") %>'
                            Width="264px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        &nbsp; &nbsp; Field Condition</td>
                    <td>
                        <asp:TextBox ID="txtFieldCondition" runat="server" MaxLength="100" Text='<%# Bind("FieldCondition") %>'
                            Width="416px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Branch Filter
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlBranchFilter" runat="server" 
                            DataSourceID="sdsBranchFilter" DataTextField="NAME"
                            DataValueField="CODE" SelectedValue='<%# Bind("BRANCHFILTER") %>'>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Finance Cat. Filter</td>
                    <td>
                        <asp:DropDownList ID="ddlFinCatFilter" runat="server" 
                            DataSourceID="sdsBranchFilter" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("FINCATFILTER") %>'>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <uc5:BtnUpdate ID="BtnUpdate1" runat="server" />
                        <uc3:BtnDelete ID="BtnDelete1" runat="server" />
                        <uc6:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT ID, ParamId, FieldName, PromptText, FieldDataType, FieldInputType, Source, FieldSize, FieldValue, FieldText, FieldDefaultValue, FieldCondition, Required, BRANCHFILTER, FINCATFILTER FROM rptParamDetail WITH (NOLOCK) WHERE (ID = @ID)" 
        DeleteCommand="DELETE FROM rptParamDetail WHERE (ID = @ID)" 
        InsertCommand="rptParamDetailAdd" InsertCommandType="StoredProcedure" 
        
        UpdateCommand="UPDATE rptParamDetail SET ParamId = @ParamId, FieldName = @FieldName, PromptText = @PromptText, FieldDataType = @FieldDataType, FieldInputType = @FieldInputType, Source = @Source, FieldSize = @FieldSize, FieldValue = @FieldValue, FieldText = @FieldText, FieldDefaultValue = @FieldDefaultValue, FieldCondition = @FieldCondition, LastUpdate = GETDATE(), Required = @Required, BRANCHFILTER = @BRANCHFILTER, LastUserId = @UserID, FINCATFILTER = @FINCATFILTER WHERE (ID = @ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="ID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="ID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:QueryStringParameter Name="ParamId" QueryStringField="ParamID" />
            <asp:Parameter Name="FieldName" />
            <asp:Parameter Name="PromptText" />
            <asp:Parameter Name="FieldDataType" />
            <asp:Parameter Name="FieldInputType" />
            <asp:Parameter Name="Source" />
            <asp:Parameter Name="FieldSize" />
            <asp:Parameter Name="FieldValue" />
            <asp:Parameter Name="FieldText" />
            <asp:Parameter Name="FieldDefaultValue" />
            <asp:Parameter Name="FieldCondition" />
            <asp:Parameter Name="Required" />
            <asp:Parameter Name="BRANCHFILTER" />
            <asp:CookieParameter CookieName="UID" Name="UserID" />
            <asp:Parameter Name="FINCATFILTER" />
            <asp:Parameter Name="ID" />
        </UpdateParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="ParamId" QueryStringField="ParamID" Type="Int32" />
            <asp:Parameter Name="FieldName" Type="String" />
            <asp:Parameter Name="PromptText" Type="String" />
            <asp:Parameter Name="FieldDataType" Type="Int16" />
            <asp:Parameter Name="FieldInputType" Type="Int16" />
            <asp:Parameter Name="Source" Type="String" />
            <asp:Parameter Name="FieldSize" Type="Int16" />
            <asp:Parameter Name="FieldValue" Type="String" />
            <asp:Parameter Name="FieldText" Type="String" />
            <asp:Parameter Name="FieldDefaultValue" Type="String" />
            <asp:Parameter Name="FieldCondition" Type="String" />
            <asp:Parameter Name="Required" Type="Boolean" />
            <asp:Parameter Name="BRANCHFILTER" Type="Boolean" />
            <asp:Parameter Name="FINCATFILTER" Type="Boolean" />
            <asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="ID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
<asp:SqlDataSource ID="sdsFieldDataType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                            SelectCommand="SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'FIELDDATATYPE')">
                        </asp:SqlDataSource>
<asp:SqlDataSource ID="sdsFieldInputType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                            SelectCommand="SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'FIELDINPUTTYPE')">
                        </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sdsRequired" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                            SelectCommand="SELECT CAST(CODE AS bit) AS CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'YESNO')">
                        </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSource" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS name UNION ALL SELECT name FROM sys.sysobjects WHERE (xtype IN ('U', 'V')) ORDER BY name">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsFieldValue" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS NAME UNION ALL SELECT sys.syscolumns.name FROM rptParamDetail INNER JOIN sys.sysobjects ON rptParamDetail.Source = sys.sysobjects.name INNER JOIN sys.syscolumns ON sys.sysobjects.id = sys.syscolumns.id WHERE (rptParamDetail.ParamId = @ParamID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ParamID" QueryStringField="ParamID" />
        </SelectParameters>
    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sdsBranchFilter" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                     SelectCommand="SELECT CAST(CODE AS bit) AS CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'YESNO')">
                        </asp:SqlDataSource>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>");
function getObjectbyClientID(ClientID){
    var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
    return(oObject)
}
function SetValueTxtByClientID(ClientID, sValue){
    var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
    if (oText)
        oText.value = sValue;
}

function GetValueTxtByClientID(ClientID){
    var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
    if (oText)
        return(oText.value);
}

function DataTypeChange(sDataType, sFieldSize){
    var oFieldSize=getObjectbyClientID(sFieldSize);
    var oDataType=getObjectbyClientID(sDataType);
    if (oDataType.value=="3"){
        oFieldSize.value="10";
        oFieldSize.className="disabled";
        oFieldSize.readOnly=true;
    }else{
        oFieldSize.className="required";
        oFieldSize.readOnly=false;
    
    }
}
function InputTypeChange(sInputType, sSource, sFieldValue, sFieldText, sFieldDefault, sFieldCondition, sBranchFilter){
    var oInputType=getObjectbyClientID(sInputType);
    var oSource=getObjectbyClientID(sSource);
    var oFieldValue=getObjectbyClientID(sFieldValue);
    var oFieldText=getObjectbyClientID(sFieldText);
    var oFieldDefault=getObjectbyClientID(sFieldDefault);
    var oFieldCondition=getObjectbyClientID(sFieldCondition);
    var oBranchFilter=getObjectbyClientID(sBranchFilter);
    if(oInputType.value=="1"){
        oSource.value="";
        oFieldValue.value="";
        oFieldText.value="";
        oFieldDefault.value="";
        oFieldCondition.value="";
        oSource.className="disabled";
        oSource.disabled=true;
        oFieldValue.className="disabled";
        oFieldValue.disabled=true;
        oFieldText.className="disabled";
        oFieldText.disabled=true;
        oFieldDefault.readOnly=true;
        oFieldDefault.className="disabled";
        oFieldCondition.readOnly=true;
        oFieldCondition.className="disabled";
        oBranchFilter.disabled=true;
        oBranchFilter.className="disabled";
        oBranchFilter.selectedIndex="0";
    }else{
        oSource.className="required";
        oSource.disabled=false;
        oFieldValue.className="required";
        oFieldValue.disabled=false;
        oFieldText.className="required";
        oFieldText.disabled=false;
        oFieldDefault.readOnly=false;
        oFieldDefault.className="";
        oFieldCondition.readOnly=false;
        oFieldCondition.className="";
    }
        
    if (oFieldValue.value=="BRANCHID"){
        oBranchFilter.className="required";
        oBranchFilter.disabled=false;
    }else{
        oBranchFilter.className="disabled";
        oBranchFilter.disabled=true;
    }
}


function ParamCopy(){
   window.open("ParamCopy.aspx?Action=Copy","CopyParam", "height=500,width=600,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes")
}
function CopyParam(ParamID){
    window.location="ReportParamDtl.aspx?Action=Copy&ReportID=<%=Request.QueryString("ReportID")%>&ParamID=<%=Request.QueryString("ParamID")%>&ParamIDCopy=" + ParamID
}
</script>
</asp:Content>

