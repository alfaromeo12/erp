Imports System
Imports System.Data
Imports System.Configuration
Imports System.Collections
Imports System.Web.Services.Protocols
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls

Partial Class Reports_ReportView
    Inherits System.Web.UI.Page
    Public Shared strUrl As String = ""
    Public Shared strDiv As String = ""

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        strDiv = rptViewer.ClientID
        If Request.QueryString("Back") <> "0" Then
            pnlBack.Visible = True

            Dim strReportID As String = Request.QueryString("ReportID")
            Dim strParamID As String = Request.QueryString("ParamID")
            Dim objDB As New DBX
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            Dim strRSServer As String
            Dim strRSWeb As String
            Dim strReport As String = ""
            Dim strParam As String
            Dim intNumParam As Integer = 0

            strParam = ""
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

                'rptViewer.ServerReport.ReportServerCredentials = New MyReportServerCredentials
                rptViewer.ServerReport.ReportServerUrl = New System.Uri("http://" & strRSServer & "/" & strRSWeb)

                oSDR = objDB.CreateSDRFromSQLSelect("SELECT FileName FROM rptList WITH(NOLOCK) WHERE ReportId=" & strReportID)
                If oSDR.Read() Then
                    strReport = oSDR("FileName").ToString()
                End If
                If Left(strReport, 1) <> "/" Then
                    strReport = "/" & strReport
                End If
                oSDR.Close()
                oSDR = Nothing

                'Response.Write(strReport)
                'Response.End()
                rptViewer.ServerReport.ReportPath = strReport
                'Response.Write(rptViewer.ServerReport.GetDataSources)
                'Response.End()
                If Len(Trim(strParamID)) > 0 Then
                    oSDR = objDB.CreateSDRFromSQLSelect("SELECT count(*) JmlParam FROM rptParamDetail WITH(NOLOCK) WHERE ParamID=" & strParamID)
                    If oSDR.Read() Then
                        intNumParam = oSDR("JmlParam")
                    End If
                    oSDR.Close()
                    oSDR = Nothing
                    'Dim RptParameters(intNumParam) As Microsoft.Reporting.WebForms.ReportParameter
                    Dim RptParameters As New Generic.List(Of Microsoft.Reporting.WebForms.ReportParameter)
                    oSDR = objDB.CreateSDRFromSQLSelect("SELECT FieldName, FieldDataType FROM rptParamDetail WITH(NOLOCK) WHERE ParamID=" & strParamID & " ORDER BY ID")
                    Dim i As Integer = 0
                    While oSDR.Read()
                        strParam = Request.QueryString(oSDR("FieldName"))
                        'RptParameters(i) = New Microsoft.Reporting.WebForms.ReportParameter(oSDR("FieldName"), strParam)
                        RptParameters.Add(New Microsoft.Reporting.WebForms.ReportParameter(oSDR("FieldName"), strParam, False))
                        i = i + 1
                    End While
                    oSDR.Close()
                    oSDR = Nothing
                    rptViewer.ServerReport.SetParameters(RptParameters)
                    'RptParameters = Nothing
                End If
                rptViewer.ServerReport.Refresh()



                'export to pdf
                Dim format As String = "" '= "PDF" 'Desired format goes here (PDF, Excel, or Image)
                format = Request.QueryString("EXPORT")
                If Len(Trim(format)) > 0 Then
                    rptViewer.ExportContentDisposition = Microsoft.Reporting.WebForms.ContentDisposition.AlwaysInline
                    Dim mimeType As String = "", encoding As String = "", extension As String = "", deviceInfo As String = ""

                    Dim streamids() As String
                    streamids = New String() {""}

                    Dim warnings() As Microsoft.Reporting.WebForms.Warning

                    'jika error remark syntax dibawah ini
                    warnings = Nothing

                    deviceInfo = "<DeviceInfo>" +
                    "<SimplePageHeaders>True</SimplePageHeaders>" +
                    "</DeviceInfo>"

                    Dim bytes() As Byte = rptViewer.ServerReport.Render(format, deviceInfo, mimeType, encoding, extension, streamids, warnings)
                    'Dim bytes() As Byte = rptViewer.ServerReport.Render(format, deviceInfo)
                    Response.Clear()
                    If (format = "PDF") Then
                        Response.ContentType = "application/pdf"
                        Response.AddHeader("Content-disposition", "inline;filename=Report.pdf")
                    ElseIf (format = "EXCEL") Then
                        Response.ContentType = "application/excel"
                        Response.AddHeader("Content-disposition", "inline;filename=Report.xls")
                    ElseIf (format = "WORD") Then
                        Response.ContentType = "application/ms-word"
                        Response.AddHeader("Content-disposition", "filename=Report.doc")
                    End If
                    'Response.OutputStream.Write(bytes, 0, bytes.Length)
                    'Response.OutputStream.Flush()
                    'Response.OutputStream.Close()

                    Response.BinaryWrite(bytes)
                    Response.Buffer = True
                    Response.Flush()
                    Response.Close()

                End If

                'Catch ex As Exception
                'Throw
            Finally
                objDB.Close()
                objDB = Nothing
            End Try





        Else
            Dim objDB As New DBX
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            Dim strRSServer As String
            Dim strRSWeb As String
            Dim strReportName As String = ""
            Dim strParam As String
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

                rptViewer.ServerReport.ReportServerUrl = New System.Uri("http://" & strRSServer & "/" & strRSWeb)

                Dim strReport As String = Request.QueryString("RPT")
                rptViewer.ServerReport.ReportPath = strReport

                Dim RptParameters As New Generic.List(Of Microsoft.Reporting.WebForms.ReportParameter)
                Dim i As Integer
                Dim blnParam As Boolean = False
                For i = 0 To Request.QueryString.Count - 1
                    If Not (Request.QueryString.Keys(i) = "RPT" Or Request.QueryString.Keys(i) = "Back") Then
                        'strParam = strParam & "&" & Request.QueryString.Keys(i) & "=" & Request.QueryString(i)
                        RptParameters.Add(New Microsoft.Reporting.WebForms.ReportParameter(Request.QueryString.Keys(i), Request.QueryString(i), False))
                        blnParam = True
                    End If
                Next
                If blnParam Then
                    rptViewer.ServerReport.SetParameters(RptParameters)
                End If
                rptViewer.ServerReport.Refresh()
                'strUrl = strReportName & "&rs:Command=Render&rc:Parameters=false&rc:DocMap=true" & strParam
                'Response.Write(strUrl)
                'Response.End()
                'Catch ex As Exception
                'Throw
            Finally
                objDB.Close()
                objDB = Nothing
            End Try


        End If





    End Sub

    Private Sub ChangeDS()

        'Dim rs As New Microsoft.ReportingServices


        'rs.Credentials = System.Net.CredentialCache.DefaultCredentials

        'Dim definition As New DataSourceDefinition()
        'definition.CredentialRetrieval = CredentialRetrievalEnum.Integrated
        'definition.ConnectString = "data source=(local);initial catalog=AdventureWorks2000"
        'definition.Enabled = True
        'definition.EnabledSpecified = True
        'definition.Extension = "SQL"
        'definition.ImpersonateUser = False
        'definition.ImpersonateUserSpecified = True
        'definition.Prompt = Nothing
        'definition.WindowsCredentials = False

        'Try
        '    rs.SetDataSourceContents("/SampleReports/AdventureWorks", definition)

        'Catch e As SoapException
        '    Console.WriteLine(e.Detail.OuterXml)
        'End Try
    End Sub

End Class
