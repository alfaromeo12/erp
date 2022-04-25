
Imports Microsoft.Reporting.WebForms

Partial Class Reports_RptDashboard
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        'rptDash.ServerReport.ReportPath = "/" & "DLEAS/Param_Area"

        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            Dim rptReport As ReportViewer
            Dim i As Integer = 0
            Dim strReport As String = ""
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPDASHBOARD.DASHBOARDID, DASHBOARDNAME, DESCRIPTION, FILENAME, DESCRIPTION FROM APPDASHBOARD WITH(NOLOCK) INNER JOIN DASHBOARD WITH(NOLOCK) ON APPDASHBOARD.DASHBOARDID=DASHBOARD.DASHBOARDID  WHERE APPDASHBOARD.UID=" & Request.Cookies("UID").Value & " AND APPDASHBOARD.DELETESTS=0 AND DASHBOARD.DELETESTS=0 ORDER BY APPDASHBOARD.SORT")
            While oSDR.Read()
                i = i + 1
                rptReport = New ReportViewer
                rptReport.ID = "rptDashBoard" & i.ToString
                'rptReport.ServerReport.ReportPath = "/DLEAS/Param_Area"
                strReport = oSDR("FILENAME").ToString()
                If Left(strReport, 1) <> "/" Then
                    strReport = "/" & strReport
                End If
                rptReport.ServerReport.ReportPath = strReport
                'rptReport.Width = "50%"
                rptReport.Style.Add("width", "100%")
                rptReport.Style.Add("height", "200px")
                rptReport.Style.Add("font-size", "xx-small")

                'rptReport.Style.Add("display", "table")
                'rptReport.Height = "150"
                rptReport.CssClass = "report"
                rptReport.ProcessingMode = ProcessingMode.Remote
                rptReport.ShowPrintButton = False
                rptReport.ShowPageNavigationControls = False
                rptReport.ShowPromptAreaButton = False
                rptReport.ShowFindControls = False
                rptReport.ShowCredentialPrompts = False
                rptReport.ShowParameterPrompts = False
                rptReport.ShowBackButton = False
                rptReport.ShowDocumentMapButton = False
                rptReport.ShowZoomControl = False
                rptReport.LinkDisabledColor = Drawing.Color.Tomato
                rptReport.LinkActiveColor = Drawing.Color.Gold
                'rptReport.Font.Size = "XX - Small"

                'rptReport.LinkActiveColor = RGB(64, 0, 0)
                rptReport.SizeToReportContent = True
                Dim RptParameters As New Generic.List(Of Microsoft.Reporting.WebForms.ReportParameter)

                Dim oSDRParam As System.Data.SqlClient.SqlDataReader
                oSDRParam = objDB.CreateSDRFromSQLSelect("SELECT DASHBOARDPARAMNAME, dbo.f_getDASHBOARDPARAM(DASHBOARDPARAMTYPE, dbo.f_getAppDate()," & Request.Cookies("UID").Value & ") as PARAMVALUE FROM DASHBOARDPARAM WITH(NOLOCK) WHERE DASHBOARDID=" & oSDR("DASHBOARDID").ToString() & " and DeleteSts=0 ORDER BY DASHBOARDPARAMID")
                If oSDRParam.HasRows() Then
                    While oSDRParam.Read()
                        RptParameters.Add(New Microsoft.Reporting.WebForms.ReportParameter(oSDRParam("DASHBOARDPARAMNAME"), oSDRParam("PARAMVALUE").ToString, False))
                    End While
                End If
                oSDRParam.Close()
                oSDRParam = Nothing

                rptReport.ServerReport.SetParameters(RptParameters)
                rptReport.ServerReport.Refresh()


                'Me.Form.Controls.Add(New LiteralControl("<div id='oDiv" & i.ToString() & "' style='display: inline-block;width: 50%;' class='required' align='right'>test"))
                Me.Form.Controls.Add(New LiteralControl("<div id='oDiv" & i.ToString() & "' style='display: inline-block;width: 50%;' class='required' align='right'><b><u>" & oSDR("DASHBOARDNAME") & "</u></b>&nbsp;&nbsp;&nbsp;"))
                Me.Form.Controls.Add(New LiteralControl("<img alt='Close' src='../Images/close.png' style='cursor: hand' onclick=""CloseRpt('oDiv" & i.ToString() & "');"" />&nbsp;"))
                Me.Form.Controls.Add(New LiteralControl("<img alt='Expand' src='../Images/expand.gif' style='cursor: hand' onclick=""ExpandRpt('oDiv" & i.ToString() & "', '" & rptReport.ClientID & "', this);"" />"))
                Me.Form.Controls.Add(rptReport)
                Me.Form.Controls.Add(New LiteralControl("</div>"))
                If i Mod 2 = 0 Then
                    Me.Form.Controls.Add(New LiteralControl("<br />"))
                End If
                rptReport.Dispose()
                rptReport = Nothing



                RptParameters.Clear()
                RptParameters = Nothing
            End While
            oSDR.Close()
            oSDR = Nothing

            'Catch ex As Exception
        Finally
            objDB.Close()
            objDB = Nothing

        End Try




    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub
End Class
