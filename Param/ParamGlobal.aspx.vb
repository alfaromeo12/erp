
Partial Class Param_ParamGlobal
    Inherits System.Web.UI.Page

    'Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
    'End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ''SetObjectValidation(txtSearch, True)
        End If
        DataSearch()

    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub gvData_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        lblError.Visible = False
        If e.CommandName = "Select" Then
            fvData.ChangeMode(FormViewMode.Edit)
            fvData.Caption = "Edit Data"
        End If
    End Sub

    Protected Sub imgBtnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        lblError.Visible = False
        fvData.ChangeMode(FormViewMode.Insert)
        fvData.Caption = "New Data"
        'ajaxCPEData.Collapsed = True
    End Sub

    Protected Sub fvData_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvData.ItemCreated
        SetValidation()
    End Sub

    Private Sub SetValidation()
        Dim oTextBox As TextBox
        oTextBox = CType(fvData.FindControl("txtType"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase nospace")
            oTextBox.Focus()
        End If
        'oTextBox = CType(fvData.FindControl("txtCode"), TextBox)
        'If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, True, "uppercase nospace")
        'oTextBox = CType(fvData.FindControl("txtName"), TextBox)
        'If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, True)
    End Sub

    Private Sub DataSearch()
        'Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " WHERE TYPE LIKE '%%'"
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        'If ddlType.SelectedValue <> "--ALL TYPE--" Then
        If Len(Trim(ddlType.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND TYPE = '" + ddlType.SelectedValue + "'"
        End If
        'ddlType.DataBind()
        gvData.DataBind()
    End Sub

    Protected Sub fvData_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewDeletedEventArgs) Handles fvData.ItemDeleted
        DataSearch()
    End Sub

    Protected Sub fvData_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles fvData.ItemInserted
        ddlType.DataBind()
        DataSearch()
    End Sub

    Protected Sub fvData_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewUpdatedEventArgs) Handles fvData.ItemUpdated
        DataSearch()
    End Sub

    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        'DataSearch()
        lblError.Visible = False
    End Sub

    Protected Sub fvData_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvData.ItemCommand
        If e.CommandName = "Cancel" Then
            gvData.SelectedIndex = -1
            fvData.Caption = ""
        End If
    End Sub

    Protected Sub sdsForm_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Inserted
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Type : " & e.Command.Parameters("@Type").Value & " and  Code : " & e.Command.Parameters("@Code").Value & " already exists..!"
        Else
            fvData.Caption = ""
            lblError.Visible = False
        End If
    End Sub

    Protected Sub sdsForm_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Deleted
        fvData.Caption = ""
    End Sub

    Protected Sub ddlType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlType.SelectedIndexChanged
        DataSearch()
    End Sub

End Class
