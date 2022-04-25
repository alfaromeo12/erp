
Partial Class Home_ChangeTheme
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'If Not IsPostBack Then
        '    Dim objDB As New DBX
        '    Try
        '        Dim oSDR As System.Data.SqlClient.SqlDataReader

        '        oSDR = objDB.CreateSDRFromSQLSelect("SELECT THEME FROM APPUSER WHERE UID=" & Request.Cookies("UID").Value)
        '        If oSDR.Read Then
        '            ddlTheme.SelectedValue = oSDR("THEME")
        '        End If
        '        oSDR.Close()
        '        oSDR = Nothing
        '    Catch ex As Exception
        '        Throw
        '    Finally
        '        objDB.Close()
        '        objDB = Nothing
        '    End Try

        'End If

    End Sub


    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub


    Protected Sub ddlTheme_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTheme.SelectedIndexChanged
        If ddlTheme.SelectedValue <> "0" Then
            Dim objDB As New DBX
            Try
                objDB.ExecSQL("UPDATE APPUSER SET THEME='" & ddlTheme.SelectedValue & "' WHERE UID=" & Request.Cookies("UID").Value)
            Catch ex As Exception
                Throw
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
            dlUser.DataBind()
            Response.Redirect("ChangeTheme.aspx?Theme=" & ddlTheme.SelectedValue)
        End If
    End Sub

End Class
