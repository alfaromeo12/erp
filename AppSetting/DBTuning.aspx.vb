
Partial Class AppSetting_DBTuning
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnProcess_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcess.Click
        Dim objDB As New DBX
        Try
            objDB.ExecSQLNoTxn("exec DBTuning")
        Catch ex As Exception
            lblComplete.Visible = True
            lblComplete.Text = "ERROR DB TUNING: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        btnProcess.Visible = False
        btnBAck.Visible = True
        lblComplete.Visible = True
    End Sub

    Protected Sub btnBAck_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBAck.Click
        btnProcess.Visible = True
        btnBAck.Visible = False
        lblComplete.Visible = False
    End Sub
End Class
