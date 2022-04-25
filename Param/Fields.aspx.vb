
Partial Class Param_Fields
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        'DataSearch()
    End Sub
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub ddlTableName_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTableName.SelectedIndexChanged
        DataSearch()
    End Sub

    Private Sub DataSearch()
        If Len(Trim(ddlTableName.SelectedValue)) > 0 Then
            'If InStr(Me.sdsFields.SelectCommand, "WHERE", CompareMethod.Text) < 0 Then
            Me.sdsFields.SelectCommand = Me.sdsFields.SelectCommand & " AND TABLENAME='" & ddlTableName.SelectedValue & "'"
            'End If
        End If
        gvData.DataBind()
    End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
        Dim objDB As New DBX
        Try
            Dim oCheckBox As CheckBox
            Dim oTextBox As TextBox
            Dim strTableName, strFieldName As String
            Dim strMandatory As String = "1"
            For Each row As GridViewRow In gvData.Rows
                oCheckBox = CType(row.FindControl("cbMandatory"), CheckBox)
                oTextBox = CType(row.FindControl("txtFieldAlias"), TextBox)
                If oCheckBox IsNot Nothing And oTextBox IsNot Nothing Then
                    strTableName = gvData.DataKeys(row.RowIndex).Values("TABLENAME").ToString()
                    strFieldName = gvData.DataKeys(row.RowIndex).Values("FIELDNAME").ToString()
                    If oCheckBox.Checked Then
                        strMandatory = "1"
                    Else
                        strMandatory = "0"
                    End If
                    objDB.ExecSQL("UPDATE FIELDS SET FIELDALIAS='" & oTextBox.Text & "', " & _
                        " Mandatory=" & strMandatory & ", lastupdate=getdate(), lastuserid='" & Request.Cookies("UID").Value & "'" & _
                        "WHERE TABLENAME='" & strTableName & "' AND FIELDNAME='" & strFieldName & "'")
                End If
            Next
            DataSearch()
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

        DataSearch()
    End Sub

    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvData_Sorting(sender As Object, e As System.Web.UI.WebControls.GridViewSortEventArgs) Handles gvData.Sorting
        DataSearch()
    End Sub

    Protected Sub gvData_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvData.RowDataBound
        If DataBinder.Eval(e.Row.DataItem, "MANDATORY") Then
            e.Row.Font.Bold = True
            e.Row.Font.Underline = True
        End If
    End Sub
End Class
