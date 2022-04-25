
Partial Class TopFrame
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.Cookies("UID") IsNot Nothing Then
            Dim objDB As New DBX
            Dim strUserId As String = Request.Cookies("UserID").Value
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            Try
                lblUserID.Text = strUserId
                lblIP.Text = Request.ServerVariables("REMOTE_ADDR")
                oSDR = objDB.CreateSDRFromSQLSelect("Select dbo.f_getAppSetting('COMPANY') CompanyName, dbo.f_getAppSetting('APPDATE') AppDate, dbo.f_getAppSetting('MESSAGE') MESSAGE, dbo.f_getAppSetting('LOCID') LOCID, dbo.f_getAppSetting('APPNAME') APPNAME")
                If oSDR.Read() Then
                    'lblCompany.Text = oSDR("CompanyName")
                    lblAppDate.Text = oSDR("AppDate")
                    'lblMessage.Text = oSDR("APPNAME") & " - " & oSDR("CompanyName") & " - " & "APPLICATION DATE : " & oSDR("AppDate") & " - " & oSDR("Message")
                    lblMessage.Text = oSDR("Message")
                    lblLocID.Text = oSDR("LOCID")
                    lblAppName.Text = oSDR("APPNAME")
                    lblCompName.Text = oSDR("CompanyName")
                End If
                oSDR.Close()
                oSDR = Nothing

                oSDR = objDB.CreateSDRFromSQLSelect("Select UserName, Convert(varchar(20), LastLogin, 113) LastLogin from APPUSER WITH(NOLOCK) where UserId='" & strUserId & "'")
                If oSDR.Read Then
                    lblUserName.Text = oSDR("UserName")
                    lblLastLogin.Text = oSDR("LastLogin").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing
            Catch ex As Exception
                Throw
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        End If
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub
End Class
