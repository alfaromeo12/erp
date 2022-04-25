<%@ Control Language="VB" AutoEventWireup="false" CodeFile="BtnApprovetNoSPV.ascx.vb" Inherits="UserControl_BtnDelete" %>
<asp:Button ID="btnApprove" runat="server" CausesValidation="False" CommandName="Approve"
    OnClientClick='return(confirm("Are you sure want to Approve data ?"))' 
    Style="font-size: 8pt;
    cursor: pointer; background-position: left top; background-image: url(../images/approve.gif); background-repeat: no-repeat; text-align: right;" 
    Text="Approve" ToolTip="Approve Data" Width="55px" />
