<%@ Page Language="VB" MasterPageFile="~/MXPageNoTitle.master" AutoEventWireup="false" CodeFile="ReportView.aspx.vb" Inherits="Reports_ReportView" title="Report Viewer" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server"> 
        <rsweb:ReportViewer ID="rptViewer" runat="server" Font-Names="Verdana" Font-Size="XX-Small" ProcessingMode="Remote" Width="100%" SizeToReportContent="True" BorderStyle="Outset" BorderWidth="2px" Font-Bold="True" LinkActiveColor="64, 0, 0" CssClass="report" DocumentMapWidth="20%" Height="196%" LinkDisabledColor="Tomato" ShowParameterPrompts="False" style="display:table;">
        </rsweb:ReportViewer>    

    <asp:Panel ID="pnlBack" runat="server" Width="100%" CssClass="FooterStyle">
    <input id="btnBack" onclick="window.history.back(-1);" type="button" value="Back" style="cursor: pointer; background-position: left; background-image: url(../images/back.png); width: 56px; background-repeat: no-repeat; text-align: right; " /></asp:Panel>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEBack" runat="server" TargetControlID="pnlBack"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
<script type="text/javascript">

function resizeIframe() {
    var height = document.documentElement.clientHeight;
    height -= document.getElementById("<%=strDiv%>").offsetTop;
    height -= 80;
    document.getElementById("<%=strDiv%>").style.height = height + "px";
    var rptViewer = document.getElementById("<%=rptViewer.ClientID%>");
    //alert(rptViewer.id);
    rptViewer.style.height=height + "px"
    rptViewer.style.width = "100%"

}
document.getElementById("<%=strDiv%>").onload = resizeIframe;
window.onresize = function () { resizeIframe(); }
window.onload = function () { resizeIframe(); }
</script>

</asp:Content>

