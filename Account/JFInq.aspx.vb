
Partial Class Account_JFInq
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim objDB As New DBX
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppDate() APPDATE ")
            If oSDR.Read() Then
                hidTxnDate.Value = oSDR("APPDATE").ToString()
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        End Try

    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

End Class
