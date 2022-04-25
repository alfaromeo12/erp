
Partial Class Param_BC
    Inherits System.Web.UI.Page

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
    End Sub

    Protected Sub fvData_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvData.ItemCreated
        SetValidation()
    End Sub

    Private Sub SetValidation()
        Dim oTextBox As TextBox
        oTextBox = CType(fvData.FindControl("txtBCCode"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase nospace")
            oTextBox.Focus()
        End If
        'oTextBox = CType(fvData.FindControl("txtBankName"), TextBox)
        'If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, True)

    End Sub

    Private Sub DataSearch()
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        If Len(Trim(ddlBTSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BOOKTYPE.BTID=" & ddlBTSearch.SelectedValue
        End If

        If Len(Trim(ddlUsedTxnSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BOOKCODE.USEDTXN=" & ddlUsedTxnSearch.SelectedValue
        End If

        If Len(Trim(ddlJournalTypeSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BOOKCODE.JOURNALTYPE=" & ddlJournalTypeSearch.SelectedValue
        End If

        If Len(Trim(ddlTxnTypeSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BOOKCODE.TXNTYPE=" & ddlTxnTypeSearch.SelectedValue
        End If
        gvData.DataBind()
    End Sub

    Protected Sub fvData_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewDeletedEventArgs) Handles fvData.ItemDeleted
        DataSearch()
    End Sub

    Protected Sub fvData_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles fvData.ItemInserted
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
            lblError.Text = "Code : " & e.Command.Parameters("@BCCode").Value & " already exists..!"
        Else
            lblError.Visible = False
            fvData.Caption = ""
        End If
    End Sub

    Protected Sub sdsForm_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Deleted
        fvData.Caption = ""
    End Sub

    Protected Sub sdsForm_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Code : " & e.Command.Parameters("@BCCode").Value & " already exists..!"
        Else
            lblError.Visible = False
        End If
    End Sub

    Protected Sub ddlBTSearch_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlBTSearch.SelectedIndexChanged
        DataSearch()
    End Sub

    Protected Sub ddlUsedTxnSearch_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlUsedTxnSearch.SelectedIndexChanged
        DataSearch
    End Sub

    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub

    Protected Sub ddlJournalTypeSearch_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlJournalTypeSearch.SelectedIndexChanged
        DataSearch()
    End Sub

    Protected Sub ddlTxnTypeSearch_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlTxnTypeSearch.SelectedIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvData_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvData.RowDataBound
        If DataBinder.Eval(e.Row.DataItem, "USEDTXN") Then
            e.Row.Font.Bold = True
        End If
    End Sub
End Class
