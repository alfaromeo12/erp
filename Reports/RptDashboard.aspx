<%@ Page Title="" Language="VB" MasterPageFile="~/MXPageNoTitle.master" AutoEventWireup="false" CodeFile="RptDashboard.aspx.vb" Inherits="Reports_RptDashboard" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
<script src="../include/JQuery.js" type="text/javascript"></script>
    <script type="text/javascript">
        function getObjectMSGbyClientID(ClientID) {
            var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
            return (oObject)
        }

        function CloseRpt(sDiv) {
            if (confirm("Are you sure want to close window dashboard..?")){
                var oDiv = getObjectMSGbyClientID(sDiv);
                if (oDiv)
                    oDiv.style.display = "none";
            }
        }

        function ExpandRpt(sDiv, sReport, oButton) {
            var sAct = oButton.alt;
            var oDiv = getObjectMSGbyClientID(sDiv);
            var oRpt = getObjectMSGbyClientID(sReport);


            if (sAct == "Expand") {
                oButton.alt = "Minimize";
                oButton.src = "../images/minimize.gif"
            }
            else {
                oButton.alt = "Expand";
                oButton.src = "../images/expand.gif"
            }
            if (sAct == "Expand") {
                oDiv.style.width = "100%";
                oRpt.style.width = "100%";

                oRpt.style.height = "400px";
                oDiv.style.height = "400px";

            } else {
                oDiv.style.width = "50%";
                oRpt.style.width = "100%";

                oRpt.style.height = "200px";
                oDiv.style.height = "200px";
            }



            /*
            if (window.innerHeight) {
                height = window.innerHeight;
            } else if (body.parentElement.clientHeight) {
                height = body.parentElement.clientHeight;
            } else if (body && body.clientHeight) {
                height = body.clientHeight;
            }

            oDiv.style.height = ((height - oDiv.offsetTop) + "px");
            oRpt.style.height = ((height - oRpt.offsetTop) + "px");
            */
            //oDiv.style.height = "700px";
            //oRpt.style.height = "700px";

            //$(sDiv).height($("#<%=Form.ClientID%>").height());
            //$(sDiv).width($("#<%=Form.ClientID%>").width());



            //$(sReport).height($("#<%=Form.ClientID%>").height());
            //$(sReport).width($("#<%=Form.ClientID%>").width());

        }

    </script>
    </asp:Content>

