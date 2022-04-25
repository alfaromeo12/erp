Imports Microsoft.VisualBasic
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.Security.Cryptography
Imports System.IO

Public Class CRExport

    Public Sub CRExport(ByVal strFileName As String, _
                        ByVal strParameter As String, _
                        ByVal strPathInfo As String, _
                        ByVal strSessionID As String, _
                        Optional ByVal strExportFormat As String = "PDF", _
                        Optional ByRef strFileExported As String = "")
        Dim crReportDocument As New CrystalDecisions.CrystalReports.Engine.ReportDocument()

        'CrystalReport1' must be the name the CrystalReport
        Dim crTableLogOnInfo As New TableLogOnInfo()
        Dim crConnectionInfo As New ConnectionInfo()

        'Crystal Report Properties
        Dim crDatabase As CrystalDecisions.CrystalReports.Engine.Database
        Dim crTables As CrystalDecisions.CrystalReports.Engine.Tables
        Dim crTable As CrystalDecisions.CrystalReports.Engine.Table

        Dim objDB As New DBX
        Try
            Dim strConnection As String = "", strServerName As String = ""
            Dim strDBName As String = "", strUserName As String = "", strPassword As String = ""

            objDB.GetParamConnection(strConnection, strServerName, strDBName, strUserName, strPassword)

            'Dim strFileName As String = Request.QueryString("Report")
            'Dim strPathInfo As String = Request.ServerVariables("PATH_INFO")
            Dim strFolderReportExport As String = strPathInfo + "\UPLOAD"
            If Not Directory.Exists(strFolderReportExport) Then
                Directory.CreateDirectory(strFolderReportExport)
            End If
            strFolderReportExport = strFolderReportExport & "\CRTempExp"
            If Not Directory.Exists(strFolderReportExport) Then
                Directory.CreateDirectory(strFolderReportExport)
            End If

            Dim strPrompt As String, i As Integer = 0
            Dim lsMethod As String = System.Reflection.MethodBase.GetCurrentMethod().Name

            Dim crParameterField As CrystalDecisions.Shared.ParameterField

            'strFileName = strWeb & strFileName
            crReportDocument.FileName = strFileName

            crConnectionInfo.ServerName = strServerName
            crConnectionInfo.DatabaseName = strDBName
            crConnectionInfo.UserID = strUserName
            crConnectionInfo.Password = strPassword
            crDatabase = crReportDocument.Database

            crTables = crDatabase.Tables

            For Each crTable In crTables
                crTableLogOnInfo = crTable.LogOnInfo
                crTableLogOnInfo.ConnectionInfo = crConnectionInfo
                crTable.ApplyLogOnInfo(crTableLogOnInfo)
                'If Not crTable.TestConnectivity() Then
                '    lblMessage.Visible = True
                '    lblMessage.Text = lblMessage.Text & "<BR>NOT CONNECTED TO DATABASE"
                'End If
            Next

            Dim arrParameter() As String
            arrParameter = Split(strParameter, "|")

            For Each crParameterField In crReportDocument.ParameterFields
                strPrompt = arrParameter(i)
                'Response.Write(ConvertDate(Request(strPrompt)))
                'Response.Write(crParameterField.ParameterValueType & "<br>")
                'Response.End()
                If crParameterField.ParameterValueType = ParameterValueKind.DateParameter Or crParameterField.ParameterValueType = ParameterValueKind.DateTimeParameter Then
                    crParameterField.CurrentValues.AddValue(ConvertDate(strPrompt))
                Else
                    crParameterField.CurrentValues.AddValue(strPrompt)
                End If
                i = i + 1
            Next
            If strExportFormat = "PDF" Then
                strFileExported = strFolderReportExport & "\" & strSessionID & ".pdf"
                If File.Exists(strFileExported) Then
                    File.Delete(strFileExported)
                End If

                crReportDocument.ExportToDisk(ExportFormatType.PortableDocFormat, strFileExported)
            ElseIf strExportFormat = "XLS" Then
                strFileExported = strFolderReportExport & "\" & strSessionID & ".xls"
                If File.Exists(strFileExported) Then
                    File.Delete(strFileExported)
                End If
                crReportDocument.ExportToDisk(ExportFormatType.Excel, strFileExported)
            ElseIf strExportFormat = "DOC" Then
                strFileExported = strFolderReportExport & "\" & strSessionID & ".doc"
                If File.Exists(strFileExported) Then
                    File.Delete(strFileExported)
                End If
                crReportDocument.ExportToDisk(ExportFormatType.WordForWindows, strFileExported)
            ElseIf strExportFormat = "RTF" Then
                strFileExported = strFolderReportExport & "\" & strSessionID & ".rtf"
                If File.Exists(strFileExported) Then
                    File.Delete(strFileExported)
                End If
                crReportDocument.ExportToDisk(ExportFormatType.RichText, strFileExported)
            ElseIf strExportFormat = "RPT" Then
                strFileExported = strFolderReportExport & "\" & strSessionID & ".rpt"
                If File.Exists(strFileExported) Then
                    File.Delete(strFileExported)
                End If
                crReportDocument.ExportToDisk(ExportFormatType.CrystalReport, strFileExported)
            End If



            crReportDocument.Dispose()
            crReportDocument = Nothing
        Catch ex As Exception
            Throw ex
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


End Class
