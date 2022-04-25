
Partial Class Reports_RptDisplay
    Inherits System.Web.UI.Page
    Public strURL As String

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim strRSServer, strRSWeb As String

        If Request.QueryString("Action") = "Report" Then

            Dim strParamID As String = Request.QueryString("ParamID")
            Dim strReportID As String = Request.QueryString("ReportID")
            Dim strParam As String = ""
            Dim objDB As New DBX
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            Dim strReportName As String
            'ReportParameter[] parm = new ReportParameter[1];
            oSDR = objDB.CreateSDRFromSQLSelect("select dbo.f_getAppSetting('RSSERVER') RSSERVER, dbo.f_getAppSetting('RSWEB') RSWEB")
            If oSDR.Read Then
                strRSServer = oSDR("RSSERVER")
                strRSWeb = oSDR("RSWEB")
            Else
                strRSServer = "localhost"
                strRSWeb = "ReportServer"
            End If
            oSDR.Close()
            oSDR = Nothing

            strReportName = "http://" & strRSServer & "/ReportServer" & strRSWeb
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT FileName FROM rptList WHERE ReportId=" & strReportID)
            If oSDR.Read Then
                strReportName = "http://" & strRSServer & "/" & strRSWeb & "?/" & oSDR("FileName").ToString
            End If
            oSDR.Close()
            oSDR = Nothing

            Try
                If Len(Trim(strParamID)) > 0 Then
                    oSDR = objDB.CreateSDRFromSQLSelect("SELECT FieldName, FieldDataType FROM rptParamDetail WHERE ParamID=" & strParamID)
                    While oSDR.Read
                        If oSDR("FieldDataType").ToString = "3" Then
                            strParam = strParam & "&" & oSDR("FieldName").ToString & "=" & ConvertDateToYMD(Request.Form("ctl00$cphMain$" & oSDR("FieldName").ToString))
                        Else
                            strParam = strParam & "&" & oSDR("FieldName").ToString & "=" & Request.Form("ctl00$cphMain$" & oSDR("FieldName").ToString)
                        End If
                        'Response.Write(Request.Form("ctl00$cphMain$" & oSDR("FieldName").ToString) & "<br>")
                    End While
                    oSDR.Close()
                    oSDR = Nothing

                End If
                strURL = strReportName & "&rs:Command=Render&rc:Parameters=false&rc:DocMap=true" & strParam
                Response.Redirect(strURL)

            Catch ex As Exception
                Throw
            Finally
                objDB.Close()
                objDB = Nothing
            End Try

        End If
    End Sub

    Private Function ConvertDateToYMD(ByVal strDateDMY As String) As String
        Dim m, d, y As String
        Dim arrDate() As String

        arrDate = Split(strDateDMY, "/")
        d = arrDate(0)
        m = arrDate(1)
        y = arrDate(2)
        ConvertDateToYMD = y & "-" & m & "-" & d
    End Function


End Class
