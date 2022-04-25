<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ReportSQL.aspx.vb" Inherits="Repl_ReportSQL" title="Untitled Page" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:TextBox ID="txtSQL" runat="server" CssClass="required" Height="100px" TextMode="MultiLine"
        Width="97%"></asp:TextBox><br />
    <asp:Button ID="btnReport" runat="server"  Style="background-position: right;
        background-image: url(../Images/Generate.gif); cursor: pointer; background-repeat: no-repeat;
        text-align: left" Text="Report" Width="71px" /><br />
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Height="127%" Width="97%">
    </rsweb:ReportViewer><br />
    <asp:Label ID="txtMessage" runat="server" CssClass="ErrHighLight" Width="100%" 
        style="text-align: center" Visible="False"></asp:Label>
</asp:Content>

