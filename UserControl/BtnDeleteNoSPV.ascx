<%@ Control Language="VB" AutoEventWireup="false" CodeFile="BtnDeleteNoSPV.ascx.vb" Inherits="UserControl_BtnDelete" %>
<asp:Button ID="btnDelete" runat="server" CausesValidation="False" CommandName="Delete"
    OnClientClick='return(confirm("Are you sure want to delete data ?"))' Style="font-size: 8pt;
    cursor: pointer; background-position: left top; background-image: url(../images/delete.gif); background-repeat: no-repeat; text-align: right;" Text="Delete" ToolTip="Delete Data" Width="55px" />
