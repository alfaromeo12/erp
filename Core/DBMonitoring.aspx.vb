
Partial Class Core_DBMonitoring
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Request.QueryString("ACTION") = "KILL" Then
            Dim objDB As New DBX
            Try
                objDB.ExecSQLNoTxn("KILL " & Request.QueryString("ProcID") & " ")
                Response.Redirect("DBMonitoring.aspx?ACTION=Refresh")
            Catch ex As Exception
                lblError.Visible = True
                lblError.Text = "Error : " & ex.Message
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        ElseIf Request.QueryString("ACTION") = "Refresh" Then
            gvDBProcess.DataBind()
        End If
    End Sub
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnRefresh_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRefresh.Click
        gvDBProcess.DataBind()
        lblError.Visible = False
    End Sub

    Protected Sub gvDBProcess_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvDBProcess.RowCreated
        Dim strSPID As String
        Dim sdsSQL As System.Data.SqlClient.SqlDataReader
        Dim objDB As New DBX
        Try

            'Catch ex As Exception
            Select Case e.Row.RowType
                Case DataControlRowType.DataRow
                    'e.Row.Cells(4).HorizontalAlign = HorizontalAlign.Right
                    'e.Row.Cells(5).HorizontalAlign = HorizontalAlign.Right
                    strSPID = DataBinder.Eval(e.Row.DataItem, "spid")
                    If Len(Trim(strSPID)) > 0 Then
                        sdsSQL = objDB.CreateSDRFromSQLSelect("dbcc inputbuffer(" & strSPID & ")")
                        If sdsSQL.Read() Then
                            e.Row.Cells(5).Text = sdsSQL("EventInfo")
                        End If
                        sdsSQL.Close()
                        sdsSQL = Nothing
                    End If
            End Select
        Finally
            objDB.Close()
            objDB = Nothing

        End Try

    End Sub
End Class
