<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="Report.aspx.vb" Inherits="RptSetup_Report" title="Report List" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="100%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Details...)</asp:Label>
        </div>
        <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" />
        <asp:Button ID="btnBack" runat="server" Text="Back to Report Module" Visible="False" style="cursor: pointer; background-image: url(../images/back.gif); background-repeat: no-repeat;" CausesValidation="False" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Detail...)" Enabled="True"
        ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Detail...)"
        ImageControlID="imgButtonShow" TargetControlID="pnlData" TextLabelID="lblShow">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlData" runat="server" Width="100%">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td style="width: 120px">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="rptList.ReportName">Report Name</asp:ListItem>
        <asp:ListItem Value="rptList.FileName">File Name</asp:ListItem>
        <asp:ListItem Value="rptList.Description">Description</asp:ListItem>
        <asp:ListItem Value="rptModul.ModulName">Modul Name</asp:ListItem>
        <asp:ListItem Value="rptModul.ModulCode">Modul Code</asp:ListItem>
        <asp:ListItem></asp:ListItem>
        <asp:ListItem Value="rptList.ReportID">RPTID</asp:ListItem>
    </asp:DropDownList></td>
                <td>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /></td>
            </tr>
            <tr>
                <td style="width: 120px">
                    Report Modul</td>
                <td>
                    <asp:DropDownList ID="ddlRptModulSearch" runat="server" DataSourceID="sdsModulSearch"
                        DataTextField="Modul" DataValueField="ModulId" AutoPostBack="True">
                    </asp:DropDownList><asp:SqlDataSource ID="sdsModulSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        SelectCommand="SELECT NULL AS ModulId, NULL AS ModulName, '[DISPLAY ALL]' AS Modul UNION ALL SELECT ModulId, ModulName, ModulName + ' (' + ModulCode + ')' AS Modul FROM rptModul ORDER BY ModulName">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="width: 120px">
                    Report Type</td>
                <td>
                    <asp:DropDownList ID="ddlReportTypeSearch" runat="server" 
                        DataSourceID="sdsReportTypeSearch" DataTextField="NAME" DataValueField="CODE">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsReportTypeSearch" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, NAME FROM (SELECT CAST(CODE AS INT) AS CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'REPORTTYPE')) AS derivedtbl_1 ORDER BY CODE">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="width: 120px">

    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False" /></td>
                <td>
                </td>
            </tr>
        </table>
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="ReportId" DataSourceID="sdsGrid" Width="100%" Caption="Report List" RowHeaderColumn="ReportId">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="20px" />
                </asp:CommandField>
                <asp:BoundField DataField="ReportId" HeaderText="RPT&lt;BR&gt;ID" HtmlEncode="False"
                    InsertVisible="False" ReadOnly="True" SortExpression="ReportId" />
                <asp:TemplateField HeaderText="Param" SortExpression="ReportID">
                    <ItemTemplate>
                        <input id="btnEditParam" type="button" value="Edit" onclick="EditParam('<%#eval("ReportID")%>')" style="background-repeat: no-repeat" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="40px" />
                </asp:TemplateField>
                <asp:BoundField DataField="ReportNo" HeaderText="Rpt&lt;br&gt;No" HtmlEncode="False"
                    SortExpression="ReportNo" />
                <asp:BoundField DataField="ModulCode" HeaderText="Modul&lt;BR&gt;Code" HtmlEncode="False"
                    SortExpression="ModulCode" />
                <asp:BoundField DataField="ModulName" HeaderText="Modul&lt;BR&gt;Name" HtmlEncode="False"
                    SortExpression="ModulName" />
                <asp:BoundField DataField="ReportName" HeaderText="Report&lt;BR&gt;Name" HtmlEncode="False"
                    SortExpression="ReportName" />
                <asp:BoundField DataField="FileName" HeaderText="File&lt;BR&gt;Name" HtmlEncode="False"
                    SortExpression="FileName" />
                <asp:BoundField DataField="REPORTTYPENAME" HeaderText="Report&lt;br&gt;Type" 
                    HtmlEncode="False" SortExpression="REPORTTYPENAME" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        SelectCommand="SELECT TOP (700) rptList.ReportId, rptModul.ModulCode, rptModul.ModulName, rptList.ReportName, rptList.FileName, rptList.ReportNo, '(' + CAST(rptList.REPORTTYPE AS VARCHAR(20)) + ') ' + dbo.f_getParamGlobalName('REPORTTYPE', rptList.REPORTTYPE) AS REPORTTYPENAME FROM rptModul WITH (NOLOCK) INNER JOIN rptList WITH (NOLOCK) ON rptModul.ModulId = rptList.ModulId WHERE (rptList.ReportId &lt;&gt; - 1)"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="600px" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>

                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblError">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
    <asp:FormView ID="fvData" runat="server" DataKeyNames="ReportId" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%">
        <EditItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        Report
                    ID</td>
                    <td>
                        <asp:Label ID="lblReportID" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ReportId") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        No. / Order</td>
                    <td>
                        <asp:TextBox ID="txtReportNo" runat="server" Text='<%# Bind("ReportNo") %>' Width="32px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqNo" runat="server" ControlToValidate="txtReportNo" Display="None" ErrorMessage="Report No. must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCENo" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqNo">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Modul</td>
                    <td>
                        <asp:DropDownList ID="ddlModul" runat="server" DataSourceID="sdsModul" DataTextField="Modul"
                            DataValueField="ModulId" SelectedValue='<%# Bind("ModulId") %>' CssClass="required">
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqModul" runat="server" ControlToValidate="ddlModul"
                            Display="None" ErrorMessage="Report modul must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEModul" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqModul">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Report Type</td>
                    <td>
                        <asp:DropDownList ID="ddlReportType" runat="server" CssClass="required" 
                            DataSourceID="sdsReportType" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("REPORTTYPE") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqReportType" runat="server" 
                            ControlToValidate="ddlReportType" Display="None" 
                            ErrorMessage="Report Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqReportType_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqReportType">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Report Name</td>
                    <td>
                        <asp:TextBox ID="txtReportName" runat="server" CssClass="required" 
                            MaxLength="100" Text='<%# Bind("ReportName") %>' Width="320px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqReportName" runat="server" 
                            ControlToValidate="txtReportName" Display="None" 
                            ErrorMessage="Report Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEReportName" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqReportName">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        File Name</td>
                    <td>
                        <asp:TextBox ID="txtFileName" runat="server" MaxLength="100" Text='<%# Bind("FileName") %>'
                            Width="320px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqFileName"
                                runat="server" ControlToValidate="txtFileName" Display="None" ErrorMessage="File Name must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEFileName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqFileName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Description</td>
                    <td>
                        <asp:TextBox ID="txtDescription" runat="server" MaxLength="200" Text='<%# Bind("Description") %>'
                            Width="472px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
                        <uc2:BtnDelete ID="BtnDelete1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        No. / Order</td>
                    <td>
                        <asp:TextBox ID="txtReportNo" runat="server" Text='<%# Bind("ReportNo") %>' Width="32px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqNo" runat="server" ControlToValidate="txtReportNo" Display="None" ErrorMessage="Report No. must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCENo" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqNo">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Modul</td>
                    <td>
                        <asp:DropDownList ID="ddlModul" runat="server" DataSourceID="sdsModul" DataTextField="Modul"
                            DataValueField="ModulId" SelectedValue='<%# Bind("ModulId") %>' CssClass="required">
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqModul" runat="server" ControlToValidate="ddlModul"
                            Display="None" ErrorMessage="Report modul must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEModul" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqModul">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Report Type</td>
                    <td>
                        <asp:DropDownList ID="ddlReportType" runat="server" CssClass="required" 
                            DataSourceID="sdsReportType" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("REPORTTYPE") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqReportType" runat="server" 
                            ControlToValidate="ddlReportType" Display="None" 
                            ErrorMessage="Report Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqReportType_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqReportType">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Report Name</td>
                    <td>
                        <asp:TextBox ID="txtReportName" runat="server" MaxLength="100" Text='<%# Bind("ReportName") %>'
                            Width="320px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqReportName"
                                runat="server" ControlToValidate="txtReportName" Display="None" ErrorMessage="Report Name must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEReportName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqReportName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        File Name</td>
                    <td>
                        <asp:TextBox ID="txtFileName" runat="server" MaxLength="100" Text='<%# Bind("FileName") %>'
                            Width="320px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqFileName"
                                runat="server" ControlToValidate="txtFileName" Display="None" ErrorMessage="File Name must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEFileName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqFileName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Description</td>
                    <td>
                        <asp:TextBox ID="txtDescription" runat="server" MaxLength="200" Text='<%# Bind("Description") %>'
                            Width="472px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <uc4:BtnInsert ID="BtnInsert1" runat="server" />
                        <uc5:BtnCancelHTML ID="BtnCancelHTML1" runat="server" />
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT ModulId, ReportId, ReportName, FileName, Description, ReportNo, REPORTTYPE FROM rptList WHERE (ReportId = @ReportID)" 
        DeleteCommand="DELETE rptList WHERE ReportID=@ReportID&#13;&#10;" 
        UpdateCommand="UPDATE rptList SET ModulId = @ModulID, ReportName = @ReportName, FileName = @FileName, Description = @Description, ReportNo = @ReportNo, LastUpdate = GETDATE(), LastUserId = @UserID, REPORTTYPE = @REPORTTYPE WHERE (ReportId = @ReportID)" 
        InsertCommand="rptListAdd" InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="ReportID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="ReportID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ModulID" />
            <asp:Parameter Name="ReportName" />
            <asp:Parameter Name="FileName" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="ReportNo" />
            <asp:CookieParameter CookieName="UID" Name="UserID" />
            <asp:Parameter Name="ReportID" />
            <asp:Parameter Name="REPORTTYPE" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="ReportNo" Type="Int32" />
            <asp:Parameter Name="ModulID" Type="Int32" />
            <asp:Parameter Name="ReportName" Type="String" />
            <asp:Parameter Name="FileName" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="ReportID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
            <asp:Parameter Name="REPORTTYPE" Type="Byte" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsReportType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS CODE, '[REPORT TYPE]' AS NAME UNION ALL SELECT CODE, NAME FROM (SELECT CAST(CODE AS INT) AS CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'REPORTTYPE')) AS derivedtbl_1 ORDER BY CODE">
                </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsModul" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS ModulID, NULL AS ModulName, '[CHOOSE MODUL]' AS Modul UNION ALL SELECT ModulId, ModulName, ModulName + ' (' + ModulCode + ')' AS Modul FROM rptModul ORDER BY ModulName">
    </asp:SqlDataSource>
    &nbsp;
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
function EditParam(ReportID){
    window.location="ReportParam.aspx?ReportID=" + ReportID
}
</script>


</asp:Content>

