
Partial Class Welcome
    Inherits System.Web.UI.Page
    Public strCompany As String = ""
    Public strAppName As String = ""

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Dim objConnectDB As New ConnectDB
        'Try
        '    Dim oSDRComp As System.Data.SqlClient.SqlDataReader
        '    oSDRComp = objConnectDB.CreateRS("select AppValue from GLAppSetting where AppCode='COMPANY'")
        '    If oSDRComp.Read Then
        '        strCompany = oSDRComp("AppValue")
        '    End If
        '    oSDRComp.Close()
        '    oSDRComp = Nothing
        'Catch ex As Exception
        '    Throw
        'Finally
        '    objConnectDB.Close()
        '    objConnectDB = Nothing

        'End Try
        Dim strPath As String = Left(Request.ServerVariables("PATH_INFO"), InStr(2, Request.ServerVariables("PATH_INFO"), "/") - 1)
        SetFormValidation(form1)

        If Request.Cookies("UID") IsNot Nothing Then
            If Request.Cookies("ChangePass") IsNot Nothing Then
                If Request.Cookies("ChangePass").Value <> "" Then
                    Response.Redirect("./Home/ChangePassword.aspx")
                End If
            End If
        Else
            Response.Redirect("Logout.aspx")
        End If
        Dim objDB As New DBX
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppSetting('COMPANY') CompanyName, dbo.f_getAppSetting('APPNAME') AppName")
            If oSDR.Read Then
                strCompany = oSDR("CompanyName")
                strAppName = oSDR("AppName")
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub
End Class
