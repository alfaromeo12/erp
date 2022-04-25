<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TopFrame.aspx.vb" Inherits="TopFrame" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Top Frame</title>
</head>
<body>
    <form id="form1" runat="server">
    <ajaxToolkit:ToolkitScriptManager ID="ajaxSMHeaderInfo" runat="server">
    </ajaxToolkit:ToolkitScriptManager>
        <asp:Panel ID="pnlMessage" runat="server" CssClass="required" 
            style="text-align: center" Width="100%" BorderStyle="Ridge" 
        BorderWidth="1px">
            <asp:Label ID="lblAppName" runat="server" Font-Bold="True" Font-Names="Franklin Gothic Book"
                Font-Underline="True"></asp:Label>
            - Application Date :
            <asp:Label ID="lblAppDate" runat="server" CssClass="ErrHighLight" 
                Font-Bold="True" Font-Underline="True" Font-Names="Franklin Gothic Book"></asp:Label>
            &nbsp;-
            <asp:Label ID="lblMessage" runat="server" Font-Bold="True" 
    Font-Underline="True" style="text-align: center" Font-Names="Franklin Gothic Book"></asp:Label>
        </asp:Panel>
    <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblMessage">
 <Animations>
    <OnLoad>
        <Sequence>
            <Pulse Duration="0.3" Iterations="0" />
        </Sequence>
    </OnLoad>
</Animations>
    </ajaxToolkit:AnimationExtender>
         <asp:Panel ID="pnlCompany" runat="server" CssClass="title" 
            BorderStyle="Outset" BorderWidth="3" HorizontalAlign="Center" Width="40%">
            <asp:Label ID="lblCompName" runat="server" Font-Names="Franklin Gothic Book"></asp:Label></asp:Panel>
        <ajaxToolkit:DropShadowExtender ID="ajaxDSECompany" runat="server" Enabled="True" 
            TargetControlID="pnlCompany" Radius="2" Rounded="True" 
            TrackPosition="True" Opacity="0.5">
        </ajaxToolkit:DropShadowExtender>
        <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCECompName" runat="server" TargetControlID="pnlCompany" VerticalSide="Middle" HorizontalSide="Center">
        </ajaxToolkit:AlwaysVisibleControlExtender>
        <asp:Panel ID="pnlHeaderInfo" runat="server" 
            style="font-size: 8pt;font-family:'Franklin Gothic Book'; cursor: pointer;" BorderStyle="Outset" Width="100%" 
            CssClass="ShowDetail" BorderWidth="2px">
            <input id="btnFrame" type="button" value="Hide Menu" 
    onclick="HideShowMenu(this);" class="HeaderStyle" style="cursor:pointer"/>
            User Name: (<asp:Label ID="lblUserID" runat="server" Font-Bold="True" 
                Font-Underline="True" Text="Label" CssClass="ErrHighLight"></asp:Label>)&nbsp;<asp:Label 
                ID="lblUserName" runat="server" Font-Bold="True" 
                Font-Underline="True" CssClass="ErrHighLight"></asp:Label>
            &nbsp;IP Address:<asp:Label ID="lblIP" runat="server" Font-Bold="True" 
                Font-Underline="True"></asp:Label>
            Last Login:
            <asp:Label ID="lblLastLogin" runat="server" Font-Bold="True" 
                Font-Underline="True"></asp:Label>
            <span class="required">Location ID :
            <asp:Label ID="lblLocID" runat="server" Font-Bold="True" Font-Underline="True"></asp:Label>&nbsp;&nbsp;&nbsp;</span></asp:Panel>
        <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEHdr" runat="server" TargetControlID="pnlHeaderInfo" VerticalSide="Bottom">
        </ajaxToolkit:AlwaysVisibleControlExtender>
    </form>
        <script type="text/javascript">
            function HideShowMenu(theObject) {
                if (theObject.value == "Hide Menu") {
                    parent.document.getElementById('FrameTxn').setAttribute('cols', '0,*', 0);
                    theObject.value = "Show Menu";
                } else {
                    parent.document.getElementById('FrameTxn').setAttribute('cols', '220,*', 0);
                    theObject.value = "Hide Menu";
                }
           }
        </script>
</body>
</html>
