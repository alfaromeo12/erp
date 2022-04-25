
Imports System.IO
Imports System.Security.Cryptography
Imports System.Web
Imports System.Web.Security
Imports System.Configuration
Imports System.Web.Configuration
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.Runtime.InteropServices.Marshal
Partial Class Reports_ReportViewerCrystal
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim crReportDocument, crSubreportDocument As New CrystalDecisions.CrystalReports.Engine.ReportDocument()

        'CrystalReport1' must be the name the CrystalReport
        Dim crTableLogOnInfo As New TableLogOnInfo()
        Dim crConnectionInfo As New ConnectionInfo()

        'Crystal Report Properties
        Dim crDatabase As CrystalDecisions.CrystalReports.Engine.Database
        Dim crTables As CrystalDecisions.CrystalReports.Engine.Tables
        Dim crTable As CrystalDecisions.CrystalReports.Engine.Table

        Dim crSections As Sections
        Dim crSubreportObject As SubreportObject
        Dim crReportObjects As ReportObjects
        Dim objDB As New DBX
        Try
            Dim strConnection As String = "", strServerName As String = ""
            Dim strDBName As String = "", strUserName As String = "", strPassword As String = ""
            Dim strTrustedCon As String = ""


            objDB.GetParamConnection(strConnection, strServerName, strDBName, strUserName, strPassword, strTrustedCon)

            'Response.Write(strTrustedCon.ToUpper())
            'Response.End()

            'Dim oCon As Data.SqlClient.SqlConnection
            'oCon = New Data.SqlClient.SqlConnection(strConnection)
            'oCon.

            Dim strFileName As String = Request.QueryString("Report")
            Dim strPathInfo As String = Request.ServerVariables("PATH_INFO")
            Dim strWeb As String = Mid(strPathInfo, 1, InStr(2, strPathInfo, "/") - 1)
            Dim strPrompt As String, i As Integer = 0
            Dim lsMethod As String = System.Reflection.MethodBase.GetCurrentMethod().Name

            Dim crParameterField As CrystalDecisions.Shared.ParameterField

            strFileName = strWeb & strFileName
            crReportDocument.FileName = Server.MapPath(strFileName)

            'If crConnectionInfo.IntegratedSecurity = False Then
            If strTrustedCon.ToUpper() = "TRUE" Then
                crConnectionInfo.ServerName = strServerName
                crConnectionInfo.DatabaseName = strDBName
                crConnectionInfo.IntegratedSecurity = True
            Else
                crConnectionInfo.ServerName = strServerName
                crConnectionInfo.DatabaseName = strDBName
                crConnectionInfo.UserID = strUserName
                crConnectionInfo.Password = strPassword
            End If


            For Each crParameterField In crReportDocument.ParameterFields
                i = i + 1
                strPrompt = "Prompt" & i.ToString()
                'Response.Write(i.ToString & "<BR>")
                'Response.Write(crParameterField.PromptText & "<BR>")
                If Len(Trim(crParameterField.PromptText)) > 0 Then
                    If crParameterField.ParameterValueType = ParameterValueKind.DateParameter Or crParameterField.ParameterValueType = ParameterValueKind.DateTimeParameter Then
                        crParameterField.CurrentValues.AddValue(ConvertDate(Request(strPrompt)))
                    Else
                        crParameterField.CurrentValues.AddValue(Request(strPrompt))
                    End If
                End If

            Next
            'Response.End()
            'Dim crParameterFieldSub As CrystalDecisions.Shared.ParameterField

            crSections = crReportDocument.ReportDefinition.Sections
            ' loop through all the sections to find all the report objects 
            For Each crSection As Section In crSections
                crReportObjects = crSection.ReportObjects
                'loop through all the report objects in there to find all subreports 
                For Each crReportObject As ReportObject In crReportObjects
                    If crReportObject.Kind = ReportObjectKind.SubreportObject Then
                        crSubreportObject = DirectCast(crReportObject, SubreportObject)
                        'open the subreport object and logon as for the general report 
                        crSubreportDocument = crSubreportObject.OpenSubreport(crSubreportObject.SubreportName)
                        crDatabase = crSubreportDocument.Database

                        crTables = crDatabase.Tables
                        For Each crTable In crTables
                            crTableLogOnInfo = crTable.LogOnInfo

                            crTableLogOnInfo.ConnectionInfo = crConnectionInfo
                            crTable.ApplyLogOnInfo(crTableLogOnInfo)
                        Next
                    End If
                Next
            Next
            crDatabase = crReportDocument.Database

            crTables = crDatabase.Tables

            For Each crTable In crTables
                crTableLogOnInfo = crTable.LogOnInfo
                crTableLogOnInfo.ConnectionInfo = crConnectionInfo
                crTable.ApplyLogOnInfo(crTableLogOnInfo)
                If Not crTable.TestConnectivity() Then
                    lblMessage.Visible = True
                    lblMessage.Text = lblMessage.Text & "<BR>NOT CONNECTED TO DATABASE"
                End If
            Next

            If Request.Params("stsprn") = "1" Then
                Dim oStream = DirectCast(crReportDocument.ExportToStream(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat), MemoryStream)
                Response.ClearContent()
                Response.ClearHeaders()
                Response.ContentType = "application/pdf"
                'crReportDocument.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, True, "Report")
                Response.AddHeader("Content-Disposition", "inline; filename=" & "Report.pdf")
                Response.BinaryWrite(oStream.ToArray())
                Response.End()
            ElseIf Request.Params("stsprn") = "0" Then
                CRViewer.ReportSource = crReportDocument
                CRViewer.HasPrintButton = False
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = lblMessage.Text & "<BR>ERROR VIEW CRYSTAL REPORT...!<BR>PLEASE CHECK DETAIL ERROR MESSAGE: " & ex.Message

        Finally
            crTableLogOnInfo = Nothing
            crConnectionInfo = Nothing
            crReportDocument.Close()
            crReportDocument = Nothing
            objDB.Close()
            objDB = Nothing

        End Try
    End Sub
 

End Class
