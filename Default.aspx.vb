
Partial Class _Default
    Inherits System.Web.UI.Page


    Private Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Dim objDB As New DBX
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("select APPVALUE from appsetting  WITH(NOLOCK) where appcode='APPNAME'")
            If oSDR.Read Then
                Page.Title = oSDR("APPVALUE")
                'Title = oSDR("APPVALUE")
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
End Class