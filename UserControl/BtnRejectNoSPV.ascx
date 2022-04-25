<%@ Control Language="VB" AutoEventWireup="false" CodeFile="BtnRejectNoSPV.ascx.vb" Inherits="UserControl_BtnDelete" %>
<asp:Button ID="btnReject" runat="server" CausesValidation="False" CommandName="Reject"
    OnClientClick='return(confirm("Are you sure want to Reject data ?"))' 
    Style="font-size: 8pt;
    cursor: pointer; background-position: left top; background-image: url(../images/reject.png); background-repeat: no-repeat; text-align: right;" 
    Text="Reject" ToolTip="Reject Data" Width="55px" />
