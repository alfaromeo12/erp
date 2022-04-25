
Partial Class MXPage
    Inherits System.Web.UI.MasterPage

    Public strWindowStatus As String
    Public strAppName As String = ""

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Len(Trim(Request.Cookies("UID").Value)) <= 0 Then
            Response.Write("You don't have authorized to access or User already timeout...!<BR>PLEASE LOGOUT AND RE-LOGIN..!")
            Response.End()
        End If

        If Not IsPostBack() Then
            SetFormValidation(form1)
            'form1.Attributes.Add("onsubmit", "ClearComma();return true;")
        End If

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
            'Response.Write("<br>Path : " & strPath)
            'SET TITLE PAGE FROM MENU
            Dim strMenuID As String = Request.QueryString("MenuID") 'Request.QueryString("MenUID")
            If Len(Trim(strMenuID)) <= 0 Then
                strMenuID = Request.Cookies("cMenuID").Value
                'Response.Write("<br>menuID " & Request.Cookies("cMenuID").Value)
                'Else
                'If Response.Cookies("cMenuID").Value Is Nothing Then
                '    Response.Cookies.Add(New HttpCookie("cMenuID", strMenuID))
                '    Response.Cookies("cMenuID").Value = strMenuID
                '    Response.Cookies("cMenuID").Path = strPath
                'Else
                '    Response.Cookies("cMenuID").Value = strMenuID
                '    Response.Cookies("cMenuID").Path = strPath
                'End If
            End If
            'Response.Write(strMenuID)
            Response.Cookies("cMenuID").Path = strPath
            Response.Cookies("cMenuID").Value = Server.HtmlEncode(strMenuID)

            'Response.Write("<br>menuID " & Request.Cookies("cMenuID").Value)
            Dim strSQL As String
            'Dim strSQL As String = "SELECT MenuName, dbo.f_getAppSetting('APPNAME')AppName, dbo.f_getAppDate() APPDATE  FROM APPMenu WITH(NOLOCK) WHERE MenUID='" & strMenuID & "'"
            'If Len(Trim(strMenuID)) > 0 Then
            '    oSDR = objDBX.CreateSDRFromSQLSelect(strSQL)
            '    If oSDR.Read() Then
            '        If oSDR("APPDATE").ToString() <> Date.Today() Then
            '            pnlWarning.Visible = True
            '            txtAppDate.Text = FormatDate(oSDR("APPDATE").ToString())
            '            txtCompDate.Text = FormatDate(Date.Today.ToString())
            '        End If

            '        lblTitle.Text = oSDR("MenuName")
            '        strAppName = oSDR("AppName").ToString()
            '        Page.Title = strAppName & " ==> " & oSDR("MenuName")

            '    Else
            '        lblTitle.Text = "No Title"
            '        Page.Title = "No Title"
            '    End If
            '    oSDR.Close()
            '    oSDR = Nothing
            'End If
            'strWindowStatus = Page.Title

            'GET USER TIME OUT (MINUTE)
            strSQL = "SELECT AppValue FROM APPSetting WITH(NOLOCK) WHERE AppCode='USRTIMEOUT'"
            oSDR = objDBX.CreateSDRFromSQLSelect(strSQL)
            If oSDR.Read() Then
                intTimeOut = CType(oSDR("AppValue").ToString(), Integer)
            Else
                intTimeOut = 15
            End If
            oSDR.Close()
            oSDR = Nothing

            strUID = Request.Cookies("UID").Value
            Session.Timeout = intTimeOut
            strSessionID = Request.Cookies("SessionID").Value
            strSessionID = Session("SessionID")


            strIPAddress = Request.ServerVariables("REMOTE_ADDR")

            lngStatus = objSession.SessionRefresh(strIPAddress, strUID, strSessionID, intTimeOut, strNewSessionID)

            If lngStatus.ToString() = "0" Then
                objSession.SessionNew(strUID, intTimeOut, strIPAddress, strNewSessionID)

                Response.Cookies("SessionID").Path = strPath
                Response.Cookies("SessionID").Value = Trim(strNewSessionID)
                'Response.Cookies("SessionID").Expires = Now.AddMinutes(intTimeOut)
                Session.Timeout = intTimeOut
                Session("SessionID") = Trim(strNewSessionID)

                'Response.Cookies("UID").Expires = Now.AddMinutes(intTimeOut)
                'Session.Item("SessionID") = Trim(strNewSessionID)
            Else
                Session.Clear()
                Session.Abandon()
                Response.Redirect(strPath & "/Expired.aspx")
                'Response.Write(lngStatus.ToString())
            End If

            'reset title
            'If Not IsPostBack Then
            '    txtTitle.Value = lblTitle.Text
            'End If
            'If Len(Trim(txtTitle.Value)) > 0 Then
            '    lblTitle.Text = txtTitle.Value
            'End If
            'oSDR = Nothing
        Catch ex As Exception
            lblError.Visible = True
            lblError.Text = ex.Message
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try


    End Sub

    Public Function PathInfo() As String
        Dim strPath As String = Request.ServerVariables("PATH_INFO")
        Dim idx As Integer = InStr(2, strPath, "/", 1)
        Dim strRoot As String = Mid(strPath, 1, idx)
        Dim strURl As String = "http://" & Request.ServerVariables("SERVER_NAME") & ":" & Request.ServerVariables("SERVER_PORT") & strRoot
        PathInfo = strURl
    End Function



End Class

