<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ReportViewerCrystal.aspx.vb" Inherits="Reports_ReportViewerCrystal" %>
<%@ Register assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head >
        <title>Report Viewer</title>
        <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
            rel="stylesheet" type="text/css" />
        <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
            rel="stylesheet" type="text/css" />
        <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
            rel="stylesheet" type="text/css" />
      
    </head>
    <body>
        <form id="ReportViewerCrystal" >
            <div>
           
                    <CR:CrystalReportViewer ID="CRViewer" runat="server" AutoDataBind="True"
                       EnableParameterPrompt="False" 
                        Height="100%" Width="100%" 
                                HasCrystalLogo="False" HasToggleGroupTreeButton="False" 
                                HasPrintButton="False" PrintMode="ActiveX" />
  
		                <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" 
			                Font-Bold="True" Font-Underline="True" Style="text-align: center" 
			                Visible="False" Width="100%"></asp:Label>
                        &nbsp;
                        <br />
                      
            </div>
        </form>
    </body>

</html>

</asp:Content>