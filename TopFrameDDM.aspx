<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TopFrameDDM.aspx.vb" Inherits="topFrame" Debug="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>LEGGEN</title>
    <link rel="stylesheet" href="include/TB.css" type="text/css" />
    <script type="text/javascript" language="javascript" src="include/menuG5FX.js"></script>
    <script type="text/javascript" language="javascript">
    function loadMenu(){
        initMenu('Demo','top');setSubFrame('Demo', parent.main);        
    }
    </script>
</head>
<body onload="javascript:loadMenu()" link="#0066CC" vlink="#660033" alink="#FF9933" style="left: 0px; position: absolute; top: 0px">
<form id="form1" runat="server">
    <ajaxToolkit:ToolkitScriptManager ID="ajaxSMHeaderInfo" runat="server">
    </ajaxToolkit:ToolkitScriptManager>
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td style="border-top-width: thin; border-left-width: thin; border-bottom-width: thin;
                text-align: center; border-right-width: thin">
                <center>
                    &nbsp;</center>
            </td>
        </tr>
        <tr>
            <td style="text-align: center;">
                <asp:Image ID="Image1" runat="server" Height="48px" ImageUrl="~/images/j0439239.jpg"
                    Width="65px" />
                <asp:Image ID="Image2" runat="server" Height="48px" ImageUrl="~/images/j0439242.jpg"
                    Width="65px" />
                <asp:Image ID="Image3" runat="server" Height="48px" ImageUrl="~/images/j0439308.jpg"
                    Width="65px" />
                <asp:Image ID="Image4" runat="server" Height="48px" ImageUrl="~/images/j0439348.jpg"
                    Width="65px" />
                <asp:Image ID="Image15" runat="server" Height="48px" ImageUrl="~/images/j0439347.jpg"
                    Width="65px" />
                <asp:Image ID="Image5" runat="server" Height="48px" ImageUrl="~/images/j0439356.jpg"
                    Width="65px" />
                <asp:Image ID="Image6" runat="server" Height="48px" ImageUrl="~/images/j0439359.jpg"
                    Width="65px" />
                <asp:Image ID="Image7" runat="server" Height="48px" ImageUrl="~/images/j0439258.jpg"
                    Width="65px" />
                <asp:Image ID="Image8" runat="server" Height="48px" ImageUrl="~/images/j0439261.jpg"
                    Width="65px" />
                <asp:Image ID="Image9" runat="server" Height="48px" ImageUrl="~/images/j0439262.jpg"
                    Width="65px" />
                <asp:Image ID="Image10" runat="server" Height="48px" ImageUrl="~/images/j0439318.jpg"
                    Width="65px" />
                <asp:Image ID="Image11" runat="server" Height="48px" ImageUrl="~/images/j0439328.jpg"
                    Width="65px" />
                <asp:Image ID="Image12" runat="server" Height="48px" ImageUrl="~/images/j0439329.jpg"
                    Width="65px" />
                <asp:Image ID="Image13" runat="server" Height="48px" ImageUrl="~/images/j0435725.jpg"
                    Width="65px" />
                <asp:Image ID="Image14" runat="server" Height="50px" ImageUrl="~/images/j0439344.jpg"
                    Width="65px" />
                </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlHeaderInfo" runat="server" BorderStyle="Outset" CssClass="HeaderStyle"
                    HorizontalAlign="Center" Style="font-size: 8pt; cursor: pointer" Width="100%">
                    App Name :
                    <asp:Label ID="lblAppName" runat="server" Font-Bold="True" Font-Underline="True"></asp:Label>
                    Company :
                    <asp:Label ID="lblCompany" runat="server" Font-Bold="True" Font-Underline="True"></asp:Label>
                    User Name: (<asp:Label ID="lblUserID" runat="server" Font-Bold="True" Font-Underline="True"
                        Text="Label"></asp:Label>)<asp:Label ID="lblUserName" runat="server" Font-Bold="True"
                            Font-Underline="True"></asp:Label>
                    App Date:
                    <asp:Label ID="lblAppDate" runat="server" Font-Bold="True" Font-Underline="True"></asp:Label>
                    IP Address:<asp:Label ID="lblIP" runat="server" Font-Bold="True" Font-Underline="True"></asp:Label>
                    Last Login:
                    <asp:Label ID="lblLastLogin" runat="server" Font-Bold="True" Font-Underline="True"></asp:Label>
                    <span class="required">Location ID :
                        <asp:Label ID="lblLocID" runat="server" Font-Bold="True" Font-Underline="True"></asp:Label>
                        &nbsp;&nbsp;</span></asp:Panel>
            </td>
        </tr>
    </table>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEInfo" runat="server" TargetControlID="pnlHeaderInfo">
    </ajaxToolkit:AlwaysVisibleControlExtender>
    <asp:Panel ID="pnlMessage" runat="server">
        <table cellpadding="0" cellspacing="0" width="600">
            <tr>
                <td class="required" style="border-right: thin inset; border-top: thin inset; border-left: thin inset;
                    border-bottom: thin inset">
                    <marquee>
                        <asp:Label ID="lblMessage" runat="server" Font-Bold="True" Font-Underline="True"></asp:Label></marquee>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEMessage" runat="server" HorizontalSide="Right"
        TargetControlID="pnlMessage" VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
    </form>
</body>
</html>
