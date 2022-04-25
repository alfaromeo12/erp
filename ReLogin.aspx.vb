
Partial Class ReLogin
    Inherits System.Web.UI.Page

    Public intTimeOut As String

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Option Explicit


        'Dim i As Integer = 0
        Dim objConnectDB As New DBX

        Try

            Dim rstTimeOut As System.Data.SqlClient.SqlDataReader

            rstTimeOut = objConnectDB.CreateSDRFromSQLSelect("select AppValue from APPSetting where AppCode='USRTIMEOUT'")
            If rstTimeOut.Read Then
                intTimeOut = rstTimeOut("AppValue")
            Else
                intTimeOut = "15"
            End If
            rstTimeOut.Close()
            rstTimeOut = Nothing

            Session.Abandon()
            Response.Expires = 1
            'For i = 1 To Request.Cookies.Count
            'Response.Cookies(i).Value = ""
            'Next
        Finally
            objConnectDB.Close()
            objConnectDB = Nothing
        End Try
    End Sub

End Class
