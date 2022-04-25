<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="RptMain.aspx.vb" Inherits="Reports_RptMain" title="Main Reporting for Supervisor"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="RowStyle">
                Report Modul</td>
            <td class="AlternatingRowStyle">
                <asp:DropDownList ID="ddlModul" runat="server" AutoPostBack="True" CssClass="required"
                    DataSourceID="sdsRptModulList" DataTextField="ModulName" DataValueField="ModulID">
                </asp:DropDownList><asp:RequiredFieldValidator ID="reqModul" runat="server" ControlToValidate="ddlModul"
                    Display="None" ErrorMessage="Report Modul must be choose..!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEReportModul" runat="server" HighlightCssClass="ErrHighLight"
                            TargetControlID="reqModul">
                    </ajaxToolkit:ValidatorCalloutExtender>
                <asp:SqlDataSource ID="sdsRptModulList" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT NULL AS ModulID, NULL AS ModulCode, '[CHOOSE REPORT MODUL]' AS ModulName UNION ALL SELECT ModulId, ModulCode, '(' + ModulCode + ') ' + ModulName AS ModulName FROM rptModul ORDER BY ModulCode">
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource
            ID="sdsModul" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            SelectCommand="SELECT rptList.ReportId, rptList.ReportName + ' (' + ISNULL(rptList.Description, '--') + ')' AS ReportName FROM rptModul INNER JOIN rptList ON rptModul.ModulId = rptList.ModulId WHERE (rptModul.ModulId = @ModulID) ORDER BY rptList.ReportNo">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlModul" Name="ModulID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td width="50%">
    <asp:Panel ID="pnlReportList" runat="server" Font-Bold="True" GroupingText="Report List" CssClass="ShowDetail">
    <asp:ListBox ID="lbReport" runat="server" DataSourceID="sdsModul" DataTextField="ReportName"
        DataValueField="ReportId" Height="160px" Width="100%" AutoPostBack="True" CssClass="required"></asp:ListBox></asp:Panel>
            </td>
            <td valign="bottom" width="50%">
    <asp:DataList ID="dlReport" runat="server" Caption="Report Information Detail" DataKeyField="ReportId"
        DataSourceID="sdsReportDetail" Width="100%" Height="160px">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td style="width: 126px" class="RowStyle">
                        Modul</td>
                    <td class="RowStyle">
                        (<asp:Label ID="ModulCodeLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ModulCode") %>'></asp:Label>)
                        <asp:Label ID="ModulNameLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ModulName") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 126px; height: 19px" class="AlternatingRowStyle">
                        Report Name&nbsp;</td>
                    <td class="AlternatingRowStyle" >
                        <asp:Label ID="ReportNameLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ReportName") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 126px" class="RowStyle">
                        File Name</td>
                    <td class="RowStyle">
                        <asp:Label ID="FileNameLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("FileName") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 126px" class="AlternatingRowStyle">
                        Description</td>
                    <td class="AlternatingRowStyle">
                        <asp:Label ID="DescriptionLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("Description") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList></td>
        </tr>
    </table>
    <asp:Panel ID="pnlSelectParam" runat="server" CssClass="ShowDetail" GroupingText="Select Parameter"
        Visible="False" Width="100%" Font-Bold="True">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                    <td style="width: 126px">
                        Parameter</td>
                    <td>
                        <asp:DropDownList ID="ddlParameter" runat="server" DataSourceID="sdsReportParam"
                            DataTextField="Param" DataValueField="ParamID" AutoPostBack="True" >
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqParameter" runat="server" ControlToValidate="ddlParameter"
                            Display="None" ErrorMessage="Parameter must be choose..!"></asp:RequiredFieldValidator><asp:SqlDataSource ID="sdsReportParam" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                            SelectCommand="SELECT NULL AS ParamID, '[CHOOSE PARAMETER]' AS Param UNION ALL SELECT ParamId, ParamName + ' (' + ISNULL(Description, '--') + ')' AS Param FROM rptParam WHERE (ReportId = @ReportID)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="lbReport" Name="ReportID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEParameter" runat="server" HighlightCssClass="ErrHighLight"
                            TargetControlID="reqParameter">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsReportDetail" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT rptList.ReportName, rptList.FileName, rptList.Description, rptModul.ModulCode, rptModul.ModulName, rptList.ReportId FROM rptList INNER JOIN rptModul ON rptList.ModulId = rptModul.ModulId WHERE (rptList.ReportId = @ReportID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="lbReport" Name="ReportID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Panel ID="pnlParamDetail" runat="server" GroupingText="Parameter(s) Detail"
        Width="100%" Visible="False" Font-Bold="True" CssClass="ShowDetail">
        Export To : 
        <asp:DropDownList ID="ddlExport" runat="server">
            <asp:ListItem Value="">NO EXPORT</asp:ListItem>
            <asp:ListItem Value="PDF">PDF FILE</asp:ListItem>
            <asp:ListItem Value="EXCEL">EXCEL FILE</asp:ListItem>
            <asp:ListItem Value="WORD">MS WORD</asp:ListItem>
        </asp:DropDownList>
        </asp:Panel>
<script type="text/javascript">
function getObjectbyClientID(ClientID){
    var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
    return(oObject)
}
function ParamChange(ModulID, ReportID){
    var oParam = getObjectbyClientID("<%=ddlParameter.ClientID%>");

    alert(ModulID);
    alert(ReportID);
    alert(oParam.value);
}
</script>
</asp:Content>

