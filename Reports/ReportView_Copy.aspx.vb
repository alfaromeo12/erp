
Partial Class Reports_ReportView
    Inherits System.Web.UI.Page
    Public Shared strUrl As String = ""

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("Back") <> "0" Then
            strUrl = Session("URLR")
        Else
            Dim objDB As New DBX
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            Dim strRSServer, strRSWeb, strReportName, strParam As String
            strParam = ""
            pnlBack.Visible = False
            Try
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

                strReportName = "http://" & strRSServer & "/" & strRSWeb & "?" & Request.QueryString("RPT")
                'Response.Write(strReportName)
                Dim i As Integer
                For i = 0 To Request.QueryString.Count - 1
                    If Not (Request.QueryString.Keys(i) = "RPT" Or Request.QueryString.Keys(i) = "Back") Then
                        strParam = strParam & "&" & Request.QueryString.Keys(i) & "=" & Request.QueryString(i)
                    End If
                Next
                strUrl = strReportName & "&rs:Command=Render&rc:Parameters=false&rc:DocMap=true" & strParam
                'Response.Write(strUrl)
                'Response.End()
            Catch ex As Exception
                Throw
            Finally
                objDB.Close()
                objDB = Nothing
            End Try


        End If
    End Sub

End Class
