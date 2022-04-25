<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MainDDM.aspx.vb" Inherits="Welcome" %>
<%@ Register Assembly="BusyBoxDotNet" Namespace="BusyBoxDotNet" TagPrefix="busyboxdotnet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Welcome to ..::SIGNALBIT::..</title>
    <link rel="stylesheet" href="include/menuG5.css" type="text/css" />
    <link rel="stylesheet" href="include/TB.css" type="text/css" />
    <link rel="stylesheet" href="include/StyleTag.css" type="text/css" />
    <style type="text/css">
    <!--
    DIV.Section1 {
	    page: Section1
    }
    -->
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <ajaxToolkit:ToolkitScriptManager ID="ajaxSMMain" runat="server">
    </ajaxToolkit:ToolkitScriptManager>

        <busyboxdotnet:BusyBox ID="BusyBox1" runat="server" Image="GearsBig" 
            ShowBusyBox="OnLeavingPage" GZipCompression="False" />
            <asp:Image ID="imgLogo" runat="server" 
    ImageUrl="~/Images/signalbit2.png" />
        <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCELogo" runat="server" HorizontalSide="Center"
            TargetControlID="imgLogo" VerticalSide="Middle">
        </ajaxToolkit:AlwaysVisibleControlExtender>

        <asp:Panel ID="pnlGHW" runat="server" BorderStyle="Inset" BorderWidth="2px" CssClass="ShowDetail"
            Style="font-family:'Franklin Gothic Book'; text-align: center" Width="100%" Wrap="False">
            <b><u><%=strAppName%></u></b> - 
            Copyright @2009 SignalBit -
            <%=strCompany%>
        </asp:Panel>
        <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEGHW" runat="server" HorizontalSide="Right"
            TargetControlID="pnlGHW" VerticalSide="Bottom">
        </ajaxToolkit:AlwaysVisibleControlExtender>
    </form>
</body>
<script type="text/javascript">
window.parent.status="<%=strCompany%> - <%=strAppName%>";
window.parent.document.title="<%=strCompany%> - <%=strAppName%>";
</script>
</html>
