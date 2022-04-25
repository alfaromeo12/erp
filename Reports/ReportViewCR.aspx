<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReportViewCR.aspx.vb" Inherits="Reports_ReportViewCR" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Report Viewer</title>
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <CR:CrystalReportViewer ID="CRViewer" runat="server" AutoDataBind="True" Height="50px" Width="350px" />
		<asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" 
			Font-Bold="True" Font-Underline="True" Style="text-align: center" 
			Visible="False" Width="100%"></asp:Label>
        &nbsp;
    
    </div>
    </form>
</body>
</html>
