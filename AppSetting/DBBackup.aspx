<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="DBBackup.aspx.vb" Inherits="AppSetting_DBBackup" title="DB Backup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Panel ID="pnlBackup" runat="server" CssClass="HeaderStyle">
        <strong>File Backup in Database Server</strong> :
        <asp:Label ID="lblFile" runat="server" Font-Bold="True" Font-Underline="True" CssClass="ErrHighLight"></asp:Label>
        <br />
        Direktory Backup :
        <asp:Label ID="lblDir" runat="server" CssClass="ErrHighLight" Font-Bold="True" Font-Underline="True"></asp:Label></asp:Panel>
    <asp:Label ID="lblComplete" runat="server" CssClass="required" Font-Bold="True" Font-Underline="True"
        Text="Database Backup Completed...!" Visible="False"></asp:Label><br />
    <asp:Label ID="lblDirDelete" runat="server" Font-Bold="True"></asp:Label><br />
    <asp:Button ID="btnBackup" runat="server" CausesValidation="False" Style="cursor: pointer"
        Text="Process" ToolTip="Click here to process backup..!" /><asp:Button ID="btnBack" runat="server" CausesValidation="False" Style="cursor: pointer"
        Text="Back" Visible="False" />
</asp:Content>

