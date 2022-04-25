
Partial Class Param_ValidDPMerk
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub imgBtnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        fvDPMerk.ChangeMode(FormViewMode.Insert)
        fvDPMerk.Caption = "New Data"
    End Sub

    Protected Sub fvInterestTenor_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvDPMerk.ItemCreated
        SetValidation()
    End Sub

    Private Sub SetValidation()
        Dim oTextBox As TextBox
        oTextBox = CType(fvDPMerk.FindControl("MINTENORTextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "", "[0-9]")
        oTextBox = CType(fvDPMerk.FindControl("MAXTENORTextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "", "[0-9]")
        oTextBox = CType(fvDPMerk.FindControl("MINAGETextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "", "[0-9]")
        oTextBox = CType(fvDPMerk.FindControl("MAXAGETextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "", "[0-9]")
    End Sub

    Protected Sub gvValidInterestTenor_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvValidDPMerk.RowCommand
        If e.CommandName = "Select" Then
            fvDPMerk.ChangeMode(FormViewMode.Edit)
            fvDPMerk.Caption = "Edit Data"
        End If
    End Sub

    Protected Sub fvInterestTenor_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvDPMerk.ItemCommand
        If e.CommandName = "Cancel" Then
            gvValidDPMerk.SelectedIndex = -1
            fvDPMerk.Caption = ""
        End If
    End Sub

    Protected Sub sdsInterestTenorEdit_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsDPMerkEdit.Inserted
        fvDPMerk.Caption = ""
        gvValidDPMerk.DataBind()
    End Sub

    Protected Sub sdsInterestTenorEdit_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsDPMerkEdit.Updated
        fvDPMerk.Caption = ""
        gvValidDPMerk.DataBind()
    End Sub

    Protected Sub sdsInterestTenorEdit_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsDPMerkEdit.Deleted
        fvDPMerk.Caption = ""
        gvValidDPMerk.DataBind()
    End Sub
End Class
