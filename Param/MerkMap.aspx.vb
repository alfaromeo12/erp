
Partial Class Param_MerkMap
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objDB As New DBX
        Try
            Dim oTextBox As TextBox
            Dim strMerkID As String
            Dim strMandatory As String = "1"
            For Each row As GridViewRow In gvMerk.Rows
                oTextBox = CType(row.FindControl("txtJFMerkCode"), TextBox)
                If Len(Trim(oTextBox.Text)) > 0 Then
                    strMerkID = gvMerk.DataKeys(row.RowIndex).Values("MERKID").ToString()
                    objDB.ExecSP("MERKJJFSave", objDB.MP("@MERKID", Data.SqlDbType.Int, strMerkID, 20), _
                        objDB.MP("@JFID", Data.SqlDbType.Int, Request.QueryString("JFID"), 20), _
                        objDB.MP("@JFMERKCODE", Data.SqlDbType.VarChar, oTextBox.Text, 20), _
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
