<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="Rpt.aspx.vb" Inherits="Reports_Rpt" title="Reporting"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:SqlDataSource
            ID="sdsModul" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            SelectCommand="SELECT rptList.ReportId, rptList.ReportName + ' (' + ISNULL(rptList.Description, '--') + ')' AS ReportName FROM rptModul INNER JOIN rptList ON rptModul.ModulId = rptList.ModulId WHERE (rptModul.ModulCode = @ModulID) ORDER BY rptList.ReportNo">
            <SelectParameters>
                <asp:QueryStringParameter Name="ModulID" QueryStringField="ModulID" />
            </SelectParameters>
        </asp:SqlDataSource>
    <asp:HiddenField ID="hidIsUserBranch" runat="server" />
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
                    <td style="width: 126px" class="HeaderStyle">
                        Modul</td>
                    <td class="HeaderStyle">
                        (<asp:Label ID="ModulCodeLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ModulCode") %>'></asp:Label>)
                        <asp:Label ID="ModulNameLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ModulName") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 126px; height: 19px" class="RowStyle">
                        Report Type</td>
                    <td class="RowStyle" >
                        (<asp:Label ID="Label1" runat="server" 
                            style="text-decoration: underline; font-weight: 700" 
                            Text='<%# Eval("REPORTTYPE") %>'></asp:Label>)
                        <asp:Label ID="Label2" runat="server" 
                            style="text-decoration: underline; font-weight: 700" 
                            Text='<%# Eval("REPORTTYPENAME") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle" style="width: 126px; height: 19px">
                        Report Name&nbsp;</td>
                    <td class="AlternatingRowStyle">
                        <asp:Label ID="ReportNameLabel" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("ReportName") %>'></asp:Label>
                    </td>
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
                    <td colspan="2" class="FooterStyle">
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
                            DataTextField="Param" DataValueField="ParamID" AutoPostBack="True" OnSelectedIndexChanged="ddlParameter_SelectedIndexChanged" >
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqParameter" runat="server" ControlToValidate="ddlParameter"
                            Display="None" ErrorMessage="Parameter must be choose..!"></asp:RequiredFieldValidator>
                            <asp:SqlDataSource ID="sdsReportParam" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                            SelectCommand="SELECT NULL AS ParamID, '[CHOOSE PARAMETER]' AS Param UNION ALL SELECT ParamId, ParamName + ' (' + ISNULL(Description, '--') + ')' AS Param FROM rptParam WHERE (ReportId = @ReportID)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="lbReport" Name="ReportID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEParameter" runat="server" HighlightCssClass="ErrHighLight"
                            TargetControlID="reqParameter" PopupPosition="TopRight">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsReportDetail" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT rptList.ReportName, rptList.FileName, rptList.Description, rptModul.ModulCode, rptModul.ModulName, rptList.ReportId, rptList.REPORTTYPE, dbo.f_getParamGlobalName('REPORTTYPE', rptList.REPORTTYPE) AS REPORTTYPENAME FROM rptList WITH (NOLOCK) INNER JOIN rptModul WITH (NOLOCK) ON rptList.ModulId = rptModul.ModulId WHERE (rptList.ReportId = @ReportID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="lbReport" Name="ReportID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Panel ID="pnlParamDetail" runat="server" GroupingText="Parameter(s) Detail"
        Width="100%" Visible="False" Font-Bold="True" CssClass="ShowDetail">
        </asp:Panel>
<script type="text/javascript">
function getObjectbyClientID(ClientID){
    var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
    return(oObject)
}
function ParamChange(){
    var oParam = getObjectbyClientID("<%=ddlParameter.ClientID%>");

    //alert(ModulID);
    //alert(ReportID);
    alert(oParam.value);
    return (false);
}
//function dibawah di hapus, jika firefox sudah comply
/*
function ValidatorOnChange(event) {
    event = event || window.event;
    if (event) {
        Page_InvalidControlToBeFocused = null;

        var targetedControl;
        if ((typeof (srcElm) != "undefined") && (srcElm != null)) {
            targetedControl = event.srcElement;
        }
        else {
            targetedControl = window.event.target;
        }
        var vals;
            if (typeof (targetedControl.Validators) != "undefined") {
                vals = targetedControl.Validators;
            }
            else {
                if (targetedControl.tagName.toLowerCase() == "label") {
                    targetedControl = document.getElementById(targetedControl.htmlFor);
                    vals = targetedControl.Validators;
                }
            }
        if (vals) {
            for (var i = 0; i < vals.length; i++) {
                ValidatorValidate(vals[i], null, event);
            }
        }
        ValidatorUpdateIsValid();
    }
} 
*/
/*
function ValidatorOnChange(event) {
    event = event || window.event;
    if (!event)
        return true;
    Page_InvalidControlToBeFocused = null;
    var targetedControl;
    if ((typeof (event.srcElement) != "undefined") && (event.srcElement != null)) {
        targetedControl = event.srcElement;
    }
    else {
        targetedControl = event.target;
    }
    var vals;
    if (typeof (targetedControl.Validators) != "undefined") {
        vals = targetedControl.Validators;
    }
    else {
        if (targetedControl.tagName.toLowerCase() == "label") {
            targetedControl = document.getElementById(targetedControl.htmlFor);
            vals = targetedControl.Validators;
        }
    }
    if (vals) {
        for (var i = 0; i < vals.length; i++) {
            ValidatorValidate(vals[i], null, event);
        }
    }
    ValidatorUpdateIsValid();
} 
*/
</script>

</asp:Content>

