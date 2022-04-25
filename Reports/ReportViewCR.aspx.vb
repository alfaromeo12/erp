
' Add namespaces at top.
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.Security.Cryptography
Imports System.IO
'Crystal Report Variables
Partial Class Reports_ReportViewCR
    Inherits System.Web.UI.Page



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'CrystalReport1 crReportDocument = new CrystalReport1();
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

            Dim strFileName As String = Request.QueryString("Report")
            Dim strPathInfo As String = Request.ServerVariables("PATH_INFO")
            Dim strWeb As String = Mid(strPathInfo, 1, InStr(2, strPathInfo, "/") - 1)
            Dim strPrompt As String, i As Integer = 0
            Dim lsMethod As String = System.Reflection.MethodBase.GetCurrentMethod().Name

            Dim crParameterField As CrystalDecisions.Shared.ParameterField

            strFileName = strWeb & strFileName
            crReportDocument.FileName = Server.MapPath(strFileName)
            'Response.Write(strServerName & "<br>")
            'Response.Write(strDBName & "<br>")
            'Response.Write(strUserName & "<br>")
            'Response.Write(strPassword & "<br>")
            'Response.Write(strConnection & "<br>")

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
                If Not crTable.TestConnectivity() Then
                    lblMessage.Visible = True
                    lblMessage.Text = lblMessage.Text & "<BR>NOT CONNECTED TO DATABASE"
                End If
            Next



            For Each crParameterField In crReportDocument.ParameterFields
                i = i + 1
                strPrompt = "Prompt" & i.ToString()
                'Response.Write(ConvertDate(Request(strPrompt)))
                'Response.Write(crParameterField.ParameterValueType & "<br>")
                'Response.End()
                If crParameterField.ParameterValueType = ParameterValueKind.DateParameter Or crParameterField.ParameterValueType = ParameterValueKind.DateTimeParameter Then
                    crParameterField.CurrentValues.AddValue(ConvertDate(Request(strPrompt)))
                Else
                    crParameterField.CurrentValues.AddValue(Request(strPrompt))
                End If
            Next
            CRViewer.ReportSource = crReportDocument
        Catch ex As Exception
            'Throw
            lblMessage.Visible = True
            lblMessage.Text = lblMessage.Text & "<BR>ERROR VIEW CRYSTAL REPORT...!<BR>PLEASE CHECK DETAIL ERROR MESSAGE: " & ex.Message

        Finally
            objDB.Close()
            objDB = Nothing

        End Try

    End Sub

End Class
