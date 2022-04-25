
Partial Class Param_JFAdmRate
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub gvTPPerson_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvJFAdmRate.RowCommand
        If e.CommandName = "Select" Then
            fvTPAdmRate.ChangeMode(FormViewMode.Edit)
            fvTPAdmRate.Caption = "Edit Data"
        End If

    End Sub

    Protected Sub imgBtnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        fvTPAdmRate.ChangeMode(FormViewMode.Insert)
        fvTPAdmRate.Caption = "New Data"

    End Sub

    Protected Sub fvTPPerson_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvTPAdmRate.ItemCommand
        If e.CommandName = "Cancel" Then
            gvJFAdmRate.SelectedIndex = -1
            fvTPAdmRate.Caption = ""
        End If
    End Sub

    Protected Sub sdsTPPersonEdit_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsJFAdmRateEdit.Inserted
        fvTPAdmRate.Caption = ""
        gvJFAdmRate.DataBind()
    End Sub

    Protected Sub sdsTPPersonEdit_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsJFAdmRateEdit.Deleted
        fvTPAdmRate.Caption = ""
        gvJFAdmRate.DataBind()
    End Sub

    Protected Sub sdsTPPersonEdit_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsJFAdmRateEdit.Updated
        fvTPAdmRate.Caption = ""
        gvJFAdmRate.DataBind()
    End Sub

    Protected Sub fvTPPerson_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvTPAdmRate.ItemCreated
        SetValidation()
    End Sub

    Private Sub SetValidation()
        Dim oTextBox As TextBox
        oTextBox = CType(fvTPAdmRate.FindControl("txtTenorFrom"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "integer", "[0-9]")
            oTextBox.Focus()
        End If
        oTextBox = CType(fvTPAdmRate.FindControl("txtTenorTo"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "integer", "[0-9]")
        oTextBox = CType(fvTPAdmRate.FindControl("txtAdmin"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
        oTextBox = CType(fvTPAdmRate.FindControl("txtEffRate"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, , "[0-9.,]")
    End Sub

End Class
