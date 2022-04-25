
Partial Class Param_Document
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            DataSearch()
        End If
    End Sub
    Protected Sub Page_PreInit(sender As Object, e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnNew_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click

        lblError.Visible = False
        fvDocument.ChangeMode(FormViewMode.Insert)
        fvDocument.Caption = "New Data"
        gvData.SelectedIndex = -1
    End Sub

    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvData_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        lblError.Visible = False
        If e.CommandName = "Select" Then
            fvDocument.ChangeMode(FormViewMode.Edit)
            fvDocument.Caption = "Edit Data"
        End If
    End Sub

    Protected Sub sdsDocument_Deleted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsDocument.Deleted
        fvDocument.Caption = ""
        DataSearch()
    End Sub

    Protected Sub sdsDocument_Inserted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsDocument.Inserted
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Document Code : " & e.Command.Parameters("@DocCode").Value & " already exists..!"
        Else
            lblError.Visible = False
            fvDocument.Caption = ""
            DataSearch()
        End If
    End Sub

    Protected Sub sdsDocument_Selected(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsDocument.Selected
        sdsDocument.DataBind()
    End Sub

    Protected Sub sdsDocument_Updated(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsDocument.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Document Code : " & e.Command.Parameters("@DocCode").Value & " already exists..!"
        Else
            lblError.Visible = False
            DataSearch()
        End If
    End Sub
    Private Sub SetValidation()
        Dim oTextBox As TextBox

        oTextBox = CType(fvDocument.FindControl("txtDocCode"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase nospace")
            oTextBox.Focus()
        End If
        oTextBox = CType(fvDocument.FindControl("txtDocName"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")

        oTextBox = CType(fvDocument.FindControl("txtDocOrder"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "integer", "[0-9]")
    End Sub

    Protected Sub fvDocument_ItemCommand(sender As Object, e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvDocument.ItemCommand
        If e.CommandName = "Cancel" Then
            gvData.SelectedIndex = -1
            fvDocument.Caption = ""
        End If
    End Sub
    Protected Sub fvDocument_ItemCreated(sender As Object, e As System.EventArgs) Handles fvDocument.ItemCreated
        SetValidation()
    End Sub
    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
        lblError.Visible = False
    End Sub

    Private Sub DataSearch()
        If Not IsPostBack() Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND DC.DOCID=-999"
        End If
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        If Len(Trim(ddlDocTypeSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND DC.DOCTYPE=" & ddlDocTypeSearch.SelectedValue
        End If
        gvData.DataBind()
    End Sub

    Protected Sub ddlDocTypeSearch_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlDocTypeSearch.SelectedIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub
End Class
