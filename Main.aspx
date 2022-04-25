<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Main.aspx.vb" Inherits="Main" %>
<%@ Register Assembly="BusyBoxDotNet" Namespace="BusyBoxDotNet" TagPrefix="busyboxdotnet" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Main</title>
</head>
<body style="width: 832px">
    <form id="form1" runat="server" >

        <ajaxToolkit:ToolkitScriptManager ID="ajaxSMMain" runat="server">
    </ajaxToolkit:ToolkitScriptManager>
       <%-- <table>
        <tr>
            <td>
        <asp:ImageButton ID="imgCostingIco" runat="server" Height="92px" ImageUrl="~/Images/Login.png" Width="101px" ostBackUrl="~/Costing/CostingInput.aspx" PostBackUrl="~/Costing/CostingInput.aspx" ToolTip="Costing Design" />
               </td>
               
           </tr>
            <tr>
                 <td align="center">
                     <asp:HyperLink ID="hlCostingInput" runat="server" NavigateUrl="~/Costing/CostingInput.aspx" Font-Bold="True">COSTING DESIGN</asp:HyperLink>
                    </td>
            </tr>
            </table>--%>
                <busyboxdotnet:BusyBox ID="BusyBox1" runat="server" Image="GearsBig" 
            ShowBusyBox="OnLeavingPage" GZipCompression="False" />
         

        <asp:Panel ID="pnlGHW" runat="server" BorderStyle="Inset" BorderWidth="2px" Style="text-align: center; font-family:'Franklin Gothic Book';" Width="100%" Wrap="False" CssClass="ShowDetail"><%=strCompany%>
        </asp:Panel>
        <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEGHW" runat="server" HorizontalSide="Right"
            TargetControlID="pnlGHW" VerticalSide="Bottom">
        </ajaxToolkit:AlwaysVisibleControlExtender>
        
    </form>
</body>
<script type="text/javascript">
    window.parent.status = "<%=strAppName%> - <%=strCompany%>";
    window.parent.document.title = "<%=strAppName%> - <%=strCompany%>";
</script>
</html>
