
Partial Class Param_ValidInterestTenor
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub imgBtnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        fvInterestTenor.ChangeMode(FormViewMode.Insert)
        fvInterestTenor.Caption = "New Data"
    End Sub

    Protected Sub fvInterestTenor_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvInterestTenor.ItemCreated
        SetValidation()
    End Sub

    Private Sub SetValidation()
        Dim oTextBox As TextBox
        oTextBox = CType(fvInterestTenor.FindControl("MININTERESTTextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "", "[0-9.]")
        oTextBox = CType(fvInterestTenor.FindControl("MAXINTERESTTextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "", "[0-9.]")
        oTextBox = CType(fvInterestTenor.FindControl("MINTENORTextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "", "[0-9]")
        oTextBox = CType(fvInterestTenor.FindControl("MAXTENORTextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "", "[0-9]")
    End Sub

    Protected Sub gvValidInterestTenor_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvValidInterestTenor.RowCommand
        If e.CommandName = "Select" Then
            fvInterestTenor.ChangeMode(FormViewMode.Edit)
            fvInterestTenor.Caption = "Edit Data"
        End If
    End Sub

    Protected Sub fvInterestTenor_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvInterestTenor.ItemCommand
        If e.CommandName = "Cancel" Then
            gvValidInterestTenor.SelectedIndex = -1
            fvInterestTenor.Caption = ""
        End If
    End Sub

    Protected Sub sdsInterestTenorEdit_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsInterestTenorEdit.Inserted
        fvInterestTenor.Caption = ""
        gvValidInterestTenor.DataBind()
    End Sub

    Protected Sub sdsInterestTenorEdit_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsInterestTenorEdit.Updated
        fvInterestTenor.Caption = ""
        gvValidInterestTenor.DataBind()
    End Sub

    Protected Sub sdsInterestTenorEdit_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsInterestTenorEdit.Deleted
        fvInterestTenor.Caption = ""
        gvValidInterestTenor.DataBind()
    End Sub
End Class
