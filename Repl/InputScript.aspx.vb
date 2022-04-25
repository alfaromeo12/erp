
Partial Class Repl_InputScript
    Inherits System.Web.UI.Page
    Public strScript As String = ""

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnProcess_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcess.Click
        lblMessage.Visible = True
        Dim objDB As New DBX
        'Dim oSDR As System.Data.SqlClient.SqlDataReader

        Try
            If rbSQLSelect.Checked Then
                gvSQL.Caption = "Result"
                gvSQL.Visible = True

                Dim oSC As New System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("connection").ConnectionString())
                Dim oSDA As New System.Data.SqlClient.SqlDataAdapter(txtSQL.Text, oSC)
                Dim oDS As New System.Data.DataSet()


                oSDA.Fill(oDS, "SQL")
                'gvSQL.AllowSorting = True
                'gvSQL.AllowPaging = True
                'gvSQL.EnableViewState = True


                gvSQL.Columns.Clear()
                gvSQL.AutoGenerateColumns = True

                gvSQL.DataSource = oDS
                gvSQL.DataBind()


                lblMessage.Text = "SQL Script has Executed...!"
                oSC.Close()
                oSDA.Dispose()
                oDS.Clear()
            Else
                gvSQL.Caption = ""
                objDB.ExecSQL(txtSQL.Text)
                gvSQL.Columns.Clear()
                gvSQL.Visible = False
            End If

        Catch ex As Exception
            lblMessage.Text = "ERROR SCRIPT : " & ex.Message
            strScript = "<script type='text/javascript'>" & Chr(13)
            strScript = strScript & "ShowAlert();" & Chr(13)
            strScript = strScript & "</script>" & Chr(13)
            'Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

End Class
