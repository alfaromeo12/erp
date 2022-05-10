<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Menu.aspx.vb" Inherits="Menu" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Menu</title>
</head>
<body style="margin-top:0;margin-left:0;">
    <form id="form1" runat="server">
    <div style="width:auto">
    <ajaxToolkit:ToolkitScriptManager ID="ajaxSMMenu" runat="server">
    </ajaxToolkit:ToolkitScriptManager>
        <asp:Panel ID="pnlDleas" runat="server" style="text-align: center">
            <asp:Image ID="imgDLEAS" runat="server" 
    ImageUrl="~/Images/ERP_LOGO.PNG" Height="162px" Width="170px" />
            <br />
            </asp:Panel>
    </div>
        <asp:Menu ID="MenuX" runat="server" BackColor="#F7F6F3" 
        DynamicHorizontalOffset="2" Font-Names="Franklin Gothic Book" Font-Size="7pt" 
        ForeColor="#7C6F57" StaticSubMenuIndent="1px" RenderingMode="Table">
            <StaticMenuItemStyle HorizontalPadding="1px" VerticalPadding="1px" 
                BorderStyle="Ridge" BorderWidth="0px" />
            <DynamicHoverStyle BackColor="#7C6F57" ForeColor="White" BorderStyle="Inset" BorderWidth="1px" Font-Italic="True" />
            <DynamicMenuStyle BackColor="#F7F6F3" BorderStyle="Ridge" BorderWidth="1px" />
            <StaticSelectedStyle BackColor="#5D7B9D" />
            <DynamicSelectedStyle BackColor="#5D7B9D" />
            <DynamicMenuItemStyle HorizontalPadding="2px" VerticalPadding="1px" 
                BorderStyle="Outset" BorderWidth="1px" Font-Size="7pt" />
            <StaticHoverStyle BackColor="#7C6F57" ForeColor="White" />
        </asp:Menu>
        <asp:TreeView ID="tvMenu" runat="server" ImageSet="WindowsHelp" style="border-right: thin dotted; font-family:'Franklin Gothic Book'; border-top: thin dotted; border-left: thin dotted; border-bottom: thin dotted" EnableTheming="True" ShowCheckBoxes="Parent">
            <ParentNodeStyle Font-Bold="False" Width="200px" />
            <HoverNodeStyle Font-Underline="True" ForeColor="#6666AA" Width="200px"  />
            <SelectedNodeStyle BackColor="#B5B5B5" Font-Underline="False" HorizontalPadding="0px"
                VerticalPadding="0px" Width="200px"/>
            <NodeStyle Font-Names="Franklin Gothic Book" Font-Size="9pt" ForeColor="Black" HorizontalPadding="5px"
                NodeSpacing="0px" VerticalPadding="1px" />
        </asp:TreeView>
        <table cellpadding="0" cellspacing="0" width="184">
            <tr>
                <td>
                <center>
                </center>                        
                        </td>
            </tr>
        </table>
    </form>
    <script type="text/javascript">
        function SetWinStatus(STS) {
            alert(STS);
            window.status = STS;
        }
    </script>
</body>
</html>
