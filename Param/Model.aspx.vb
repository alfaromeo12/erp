
Partial Class Param_Model
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub sdsModelEdit_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsModelEdit.Inserted
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Model Code : " & e.Command.Parameters("@MODELCODE").Value & " already exists..!"
        Else
            lblError.Visible = False
            fvModel.Caption = ""
        End If

    End Sub

    Protected Sub sdsModelEdit_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsModelEdit.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Model Code : " & e.Command.Parameters("@MODELCODE").Value & " already exists..!"
        End If
    End Sub

    Protected Sub fvModel_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvModel.ItemCommand
        If e.CommandName = "Cancel" Then
            gvModel.SelectedIndex = -1
            fvModel.Caption = ""
        End If

    End Sub

    Protected Sub fvModel_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewDeletedEventArgs) Handles fvModel.ItemDeleted
        gvModel.DataBind()
    End Sub

    Protected Sub fvModel_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles fvModel.ItemInserted
        gvModel.DataBind()
    End Sub

    Protected Sub fvModel_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewUpdatedEventArgs) Handles fvModel.ItemUpdated
        gvModel.DataBind()
    End Sub

    Protected Sub fvModel_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvModel.ItemCreated
        SetValidation()
    End Sub

    Private Sub SetValidation()
        Dim oTextBox As TextBox
        oTextBox = CType(fvModel.FindControl("MODELCODETextBox"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase nospace")
            oTextBox.Focus()
        End If
        oTextBox = CType(fvModel.FindControl("MODELNAMETextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")

        If fvModel.Caption = "New Data" Then
            Dim oDropDown As DropDownList
            oDropDown = CType(fvModel.FindControl("ddlMerk"), DropDownList)
            If oDropDown IsNot Nothing Then
                oDropDown.SelectedValue = Request.QueryString("MERKID")
            End If
        End If
    End Sub

    Protected Sub imgBtnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        fvModel.ChangeMode(FormViewMode.Insert)
        fvModel.Caption = "New Data"

    End Sub

    Protected Sub gvModel_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvModel.RowCommand
        lblError.Visible = False
        If e.CommandName = "Select" Then
            fvModel.ChangeMode(FormViewMode.Edit)
            fvModel.Caption = "Edit Data"
        End If
    End Sub
End Class
