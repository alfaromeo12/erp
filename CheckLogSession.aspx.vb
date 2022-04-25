
Partial Class CheckLogSession
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Dim objDB As New DBX
        Dim oSDR As Data.SqlClient.SqlDataReader
        Dim strSQL As String
        Try
            Select Case UCase(Request.QueryString("xmlid"))
                Case "CHECKSESSION"
                    Dim strUserID As String = Request.QueryString("UserID")
                    strSQL = "SELECT IP, Convert(varchar(30), TimeOut, 103) SessionTimeOut, Convert(varchar(50), TimeOut, 114) TimeOut " & _
                        "FROM APPSessions, APPUser WHERE APPSessions.UID=APPUser.UID AND APPUser.UserID='" & strUserID & "'"
                    oSDR = objDB.CreateSDRFromSQLSelect(strSQL)
                    BuildXML(oSDR)
                    oSDR.Close()
                    oSDR = Nothing
                Case "USRTIMEOUT"
                    Dim strAppCode As String = "USRTIMEOUT"
                    strSQL = "SELECT AppValue FROM APPSetting WHERE AppCode='" & strAppCode & "'"
                    oSDR = objDB.CreateSDRFromSQLSelect(strSQL)
                    BuildXML(oSDR)
                    oSDR.Close()
                    oSDR = Nothing
            End Select
        Finally
            objDB.Close()
            objDB = Nothing

        End Try
    End Sub

    Private Sub BuildXML(ByVal oSDR As Data.SqlClient.SqlDataReader)
        Dim i As Byte
        Response.ContentType = "text/xml"
        Response.Write("<?xml version=""1.0""?>")
        Response.Write("<root>")
        While oSDR.Read
            Response.Write("<data>")
            For i = 0 To oSDR.FieldCount - 1
                Response.Write("<" & oSDR.GetName(i) & ">")
                Response.Write(Server.HtmlEncode(oSDR(i)))
                Response.Write("</" & oSDR.GetName(i) & ">")
            Next
            Response.Write("</data>")
        End While
        Response.Write("</root>")
    End Sub
End Class
