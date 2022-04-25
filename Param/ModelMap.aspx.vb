
Partial Class Param_ModelMap
    Inherits System.Web.UI.Page
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objDB As New DBX
        Try
            Dim oTextBox As TextBox
            Dim strModelID As String
            Dim strMandatory As String = "1"
            For Each row As GridViewRow In gvModel.Rows
                oTextBox = CType(row.FindControl("txtJFModelCode"), TextBox)
                If Len(Trim(oTextBox.Text)) > 0 Then
                    strModelID = gvModel.DataKeys(row.RowIndex).Values("MODELID").ToString()
                    objDB.ExecSP("MODELJFSave", objDB.MP("@MODELID", Data.SqlDbType.Int, strModelID, 20), _
                        objDB.MP("@JFID", Data.SqlDbType.Int, Request.QueryString("JFID"), 20), _
                        objDB.MP("@JFMODELCODE", Data.SqlDbType.VarChar, oTextBox.Text, 20), _
                        objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 20) _
                       )
                End If
            Next
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
End Class
