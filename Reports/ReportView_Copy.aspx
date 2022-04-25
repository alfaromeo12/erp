<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ReportView_Copy.aspx.vb" Inherits="Reports_ReportView" title="Report Viewer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Panel ID="Panel1" runat="server" Height="100%" Width="100%" GroupingText="Report Viewer" CssClass="ShowDetail" Font-Bold="True">
    <iframe  id="iFrameReport" width="100%" height="95%" src="<%=strURL%>" style="width: 100%; height: 100%;" title="Report Viewer">
    </iframe>
    <br />
    </asp:Panel>
    
<script type="text/javascript">
/*window.onload=Load();
function Load(){
    iframe.height="100%";
}
*/

function resizeIframe() {
    var height = document.documentElement.clientHeight;
    height -= document.getElementById('iFrameReport').offsetTop;
    // not sure how to get this dynamically
    height -= 75; 
    // whatever you set your body bottom margin/padding to be 
    
    document.getElementById('iFrameReport').style.height = height +"px";
    
}
document.getElementById('iFrameReport').onload = resizeIframe;
//alert(document.getElementById('iFrameReport').onload);
window.onresize = resizeIframe;

</script>
    <asp:Panel ID="pnlBack" runat="server" Width="100%" CssClass="FooterStyle">
    <input id="btnBack" onclick="window.history.back(-1);" type="button" value="Back" style="cursor: pointer; background-position: left; background-image: url(../images/back.png); width: 56px; background-repeat: no-repeat; text-align: right; " /></asp:Panel>
</asp:Content>

