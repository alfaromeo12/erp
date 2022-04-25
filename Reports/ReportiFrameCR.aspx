<%@ Page Title="" Language="VB" MasterPageFile="~/MXPageNoTitle.master" AutoEventWireup="false" CodeFile="ReportiFrameCR.aspx.vb" Inherits="Reports_ReportiFrameCR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">

<style type="text/css">
 html, body,
   iframe { margin:0; padding:0; width:100%; height:95%; border:none; }
        iframe { position:fixed; width:100%; border:none; }   
 
</style>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<body>

    <form id="form1"  >
    <div>
        <asp:Panel ID="pnlLoading" runat="server" CssClass="title" BorderStyle="Dotted" 
           style="text-align:center"  Font-Bold="True" Font-Size="Large">
        LOADING REPORT... !PLEASE WAIT...!
        </asp:Panel>
     
           
        <iframe id="iFrame" name="iFrame" runat="server" width="100%" scrolling="auto" height="100%" frameborder="0"></iframe>

        <asp:Panel ID="pnlBack" runat="server" Width="100%" CssClass="HeaderStyle">
        <input id="btnBack" onclick="window.history.back(-1);" type="button" value="Back" style="cursor: pointer; 
            background-position: left; background-image: url(../images/back.png); width: 56px; 
            background-repeat: no-repeat; text-align: right; " />
        </asp:Panel>
        <ajaxToolkit:alwaysvisiblecontrolextender ID="ajaxAVCEBack" runat="server" TargetControlID="pnlBack"
            VerticalSide="Bottom">
        </ajaxToolkit:alwaysvisiblecontrolextender>
       </div>
    </form>
</body>
</html>
 <script  language="javascript" type="text/javascript">
     window.onload = function () {
         var divLoad = getObjectbyClientID("<%=pnlLoading.ClientID %>");
         divLoad.style.display = "none";
       
     }
     function getObjectbyClientID(ClientID) {
         var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
         return (oObject)
     }
</script>

</asp:Content>

