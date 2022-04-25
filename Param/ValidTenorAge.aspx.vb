
Partial Class Param_ValidTenorAge
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub imgBtnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        fvTenorAge.ChangeMode(FormViewMode.Insert)
        fvTenorAge.Caption = "New Data"
    End Sub

    Protected Sub fvInterestTenor_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvTenorAge.ItemCreated
        SetValidation()
    End Sub

    Private Sub SetValidation()
        Dim oTextBox As TextBox
        oTextBox = CType(fvTenorAge.FindControl("MINTENORTextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "", "[0-9]")
        oTextBox = CType(fvTenorAge.FindControl("MAXTENORTextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "", "[0-9]")
        oTextBox = CType(fvTenorAge.FindControl("MINAGETextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "", "[0-9]")
        oTextBox = CType(fvTenorAge.FindControl("MAXAGETextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "", "[0-9]")
    End Sub

    Protected Sub gvValidInterestTenor_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvValidTenorAge.RowCommand
        If e.CommandName = "Select" Then
            fvTenorAge.ChangeMode(FormViewMode.Edit)
            fvTenorAge.Caption = "Edit Data"
        End If
    End Sub

    Protected Sub fvInterestTenor_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvTenorAge.ItemCommand
        If e.CommandName = "Cancel" Then
            gvValidTenorAge.SelectedIndex = -1
            fvTenorAge.Caption = ""
        End If
    End Sub

    Protected Sub sdsInterestTenorEdit_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsTenorAgeEdit.Inserted
        fvTenorAge.Caption = ""
        gvValidTenorAge.DataBind()
    End Sub

    Protected Sub sdsInterestTenorEdit_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsTenorAgeEdit.Updated
        fvTenorAge.Caption = ""
        gvValidTenorAge.DataBind()
    End Sub

    Protected Sub sdsInterestTenorEdit_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsTenorAgeEdit.Deleted
        fvTenorAge.Caption = ""
        gvValidTenorAge.DataBind()
    End Sub
End Class
