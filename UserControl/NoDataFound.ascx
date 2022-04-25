<%@ Control Language="VB" AutoEventWireup="false" CodeFile="NoDataFound.ascx.vb" Inherits="UserControl_NoDataFound" %>
 <asp:Panel ID="pnlNoData" runat="server" 
    style="background-image:url('../images/blank.gif');background-repeat:repeat-x;margin-top:0;margin-left:0;" Width="100%" 
    Height="18px" CssClass="HeaderStyle">
</asp:Panel>
    <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="pnlNoData">
 <Animations>
    <OnLoad>
        <Sequence>
            <Pulse Duration="0.5" Iterations="0" />
        </Sequence>
    </OnLoad>
</Animations>
    </ajaxToolkit:AnimationExtender>

