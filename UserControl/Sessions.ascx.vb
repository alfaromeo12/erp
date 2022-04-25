
Partial Class UserControl_Sessions
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim objDBX As New DBX
        Try
            Dim objSession As New Sessions
            Dim intTimeOut As Integer = 0
            Dim lngStatus As Long = 0
            Dim strPath As String = ""
            Dim strUID As String = ""
            Dim strSessionID As String = ""
            Dim datAppDate As String = ""
            Dim strIPAddress As String = ""
            Dim strNewSessionID As String = ""

            Dim oSDR As Data.SqlClient.SqlDataReader
            strPath = Left(Request.ServerVariables("PATH_INFO"), InStr(2, Request.ServerVariables("PATH_INFO"), "/") - 1)
            'SET TITLE PAGE FROM MENU
            'Dim strMenuID As String = Request.QueryString("MenuID") 'Request.QueryString("MenUID")
            'If Len(Trim(strMenuID)) <= 0 Then
            'strMenuID = Request.Cookies("cMenuID").Value
            'End If
            'Response.Cookies("cMenuID").Path = strPath
            'Response.Cookies("cMenuID").Value = Server.HtmlEncode(strMenuID)

            'Response.Write("<br>menuID " & Request.Cookies("cMenuID").Value)
            'Dim strSQL As String = "SELECT MenuName FROM APPMenu WHERE MenUID='" & strMenuID & "'"
            'If Len(Trim(strMenuID)) > 0 Then
            '    oSDR = objDBX.CreateSDRFromSQLSelect(strSQL)
            '    If oSDR.Read() Then
            '        'lblTitle.Text = oSDR("MenuName")
            '        Page.Title = "Agent ==> " & oSDR("MenuName")
            '    Else
            '        'lblTitle.Text = "No Title"
            '        Page.Title = "Agent - No Title"
            '    End If
            '    oSDR.Close()
            'End If

            'GET USER TIME OUT (MINUTE)
            Dim strSQL As String = ""
            strSQL = "SELECT AppValue FROM APPSetting WHERE AppCode='USRTIMEOUT'"
            oSDR = objDBX.CreateSDRFromSQLSelect(strSQL)
            If oSDR.Read() Then
                intTimeOut = CType(oSDR("AppValue").ToString(), Integer)
            Else
                intTimeOut = 15
            End If
            oSDR.Close()

            'If Session.Item("SessionID") Is Nothing Then
            'Session.Add("SessionID", Trim(Server.UrlDecode(Request.Cookies("SessionID").Value)))
            'End If

            'If Session.Item("UID") Is Nothing Then
            'Session.Add("UID", Trim(Server.UrlDecode(Request.Cookies.Get("UID").Value)))
            'End If

            'If Session.Item("AppDate") Is Nothing Then
            'Session.Add("AppDate", Trim(Server.UrlDecode(Request.Cookies.Get("AppDate").Value)))
            'End If

            'strUID = Server.UrlEncode(Request.Cookies("UID").Value)
            'strSessionID = Server.UrlDecode(Request.Cookies("SessionID").Value)

            strUID = Request.Cookies("UID").Value
            strSessionID = Request.Cookies("SessionID").Value

            'Response.Write(Request.Cookies("SessionID").Value & "<br>")
            'Response.Write("------<br>")

            strIPAddress = Request.ServerVariables("REMOTE_ADDR")

            lngStatus = objSession.SessionRefresh(strIPAddress, strUID, strSessionID, intTimeOut, strNewSessionID)

            If lngStatus.ToString() = "0" Then
                'objSession.SessionNew(strUID, intTimeOut, strIPAddress, strSessionID)

                Response.Cookies("SessionID").Path = strPath
                Response.Cookies("SessionID").Value = Trim(strNewSessionID)

            Else
                Session.Clear()
                Session.Abandon()
                Response.Redirect(strPath & "/Expired.aspx")
                'Response.Write(lngStatus.ToString())
            End If

        Catch ex As Exception
            'lblError.Text = ex.Message
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try

    End Sub
End Class
