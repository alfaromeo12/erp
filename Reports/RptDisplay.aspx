<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="RptDisplay.aspx.vb" Inherits="Reports_RptDisplay" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <input id="btnBack" type="button" value="Back"  onclick="window.history.back(-1);"/>
<IFRAME id="iFrameReport" scrolling="auto" width="100%" height="95%" src="<%=strURL%>" >
</IFRAME>    
</asp:Content>

