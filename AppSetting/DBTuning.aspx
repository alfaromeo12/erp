<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="DBTuning.aspx.vb" Inherits="AppSetting_DBTuning" title="DB Tuning" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Panel ID="pnlAlert" runat="server" CssClass="HeaderStyle" Width="100%">
        <asp:Label ID="lblAlert" runat="server" Font-Bold="True" Font-Underline="True" Text="All Transaction must be stopped, before process Database Tuning..!"></asp:Label></asp:Panel>
    <asp:Label ID="lblComplete" runat="server" CssClass="required" Text="Process Completed...!"
        Visible="False"></asp:Label><br />
    <asp:Button ID="btnProcess" runat="server" CausesValidation="False" Style="cursor: pointer"
        Text="Process" ToolTip="Click here to process database Tuning" /><asp:Button ID="btnBAck"
            runat="server" Style="cursor: pointer" Text="Back" Visible="False" />
</asp:Content>

