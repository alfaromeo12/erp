
Partial Class Param_ObjStorePlace
    Inherits System.Web.UI.Page
    Private sError As String
    Public strDocSafeId As String
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            MultiView_Utama.SetActiveView(View_View)
            DataSearch()
        End If
    End Sub

    Protected Sub Page_PreInit(sender As Object, e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub
    
    Protected Sub btnNewStore_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnNewStore.Click
        'fvDocStore.ChangeMode(FormViewMode.Insert)
        'fvDocStore.Caption = "New Data"

        lblError.Visible = False
        fvDocStore.ChangeMode(FormViewMode.Insert)
        fvDocStore.Caption = "New Data"
        GvStorePlace.SelectedIndex = -1
    End Sub

    Protected Sub GvStorePlace_PageIndexChanged(sender As Object, e As System.EventArgs) Handles GvStorePlace.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub GvStorePlace_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GvStorePlace.RowCommand
        lblError.Visible = False
        If e.CommandName = "Select" Then
            fvDocStore.ChangeMode(FormViewMode.Edit)
            fvDocStore.Caption = "Edit Data"
        End If
    End Sub

    Protected Sub fvDocStore_ItemCommand(sender As Object, e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvDocStore.ItemCommand
        If e.CommandName = "Cancel" Then
            GvStorePlace.SelectedIndex = -1
            fvDocStore.Caption = ""
        End If
    End Sub

    Protected Sub fvDocStore_ItemCreated(sender As Object, e As System.EventArgs) Handles fvDocStore.ItemCreated
        SetValidation()
    End Sub
    Protected Sub fvDocSelf_ItemCreated(sender As Object, e As System.EventArgs) Handles fvDocSelf.ItemCreated
        SetValidationShelf()
    End Sub
    Private Sub SetValidation()
        Dim oTextBox As TextBox
        oTextBox = CType(fvDocStore.FindControl("txtDocSafeCode"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "integer", "[0-9]")
            oTextBox.Focus()
        End If
        oTextBox = CType(fvDocStore.FindControl("txtDocSafeName"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")

        oTextBox = CType(fvDocStore.FindControl("txtDocSafeDesc"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")
    End Sub
    Private Sub SetValidationShelf()
        Dim oTextBox As TextBox
        oTextBox = CType(fvDocSelf.FindControl("txtDocShelfCode"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase nospace")
            oTextBox.Focus()
        End If
        oTextBox = CType(fvDocSelf.FindControl("txtDocShelfName"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")

        oTextBox = CType(fvDocSelf.FindControl("txtDocShelfDesc"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")
    End Sub
    Protected Sub fvDocStore_ItemDeleted(sender As Object, e As System.Web.UI.WebControls.FormViewDeletedEventArgs) Handles fvDocStore.ItemDeleted
        DataSearch()
    End Sub

    Protected Sub fvDocStore_ItemInserted(sender As Object, e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles fvDocStore.ItemInserted
        DataSearch()
    End Sub

    Protected Sub fvDocStore_ItemUpdated(sender As Object, e As System.Web.UI.WebControls.FormViewUpdatedEventArgs) Handles fvDocStore.ItemUpdated
        DataSearch()
    End Sub
    Protected Sub btnViewStr_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        Dim currentCommand As String = e.CommandName
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument)
        Dim BranchId As String
        Try
            BranchId = gvData.DataKeys(currentRowIndex).Value

            lblCommand.Text = currentCommand
            lblIndex.Text = currentRowIndex.ToString
            lblKey.Text = BranchId
            gvData.SelectedIndex = currentRowIndex
            MultiView_Utama.SetActiveView(View_Store)
        Catch ex As Exception
            sError = Validation.ReplaceMessage(ex.Message.ToString)
            'ScriptManager.RegisterStartupScript(Me.pnlUpdate, GetType(String), "err", "alert('" & sError & "');", True)
        End Try

    End Sub

    Protected Sub sdsSafe_Deleted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsSafe.Deleted
        fvDocStore.Caption = ""
        DataGridStore()
    End Sub

    Protected Sub sdsSafe_Inserted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsSafe.Inserted
        If e.Command.Parameters("@retval").Value = -1 Then
            lblErrorStore.Visible = True
            lblErrorStore.Text = "Safe Code : " & e.Command.Parameters("@DOCSAFECode").Value & " already exists..!"
        Else
            'strDocSafeId = e.Command.Parameters("@DOCSAFEID").Value
            lblErrorStore.Visible = False
            fvDocStore.Caption = ""
            DataGridStore()
        End If
    End Sub
    Protected Sub sdsSafe_Updated(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsSafe.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblErrorStore.Visible = True
            lblErrorStore.Text = "Safe Code  : " & e.Command.Parameters("@DOCSAFECode").Value & " already exists..!"
        Else
            lblErrorStore.Visible = False
            DataGridStore()
        End If
    End Sub
    Protected Sub sdsSafe_Selected(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsSafe.Selected
        sdsSafe.DataBind()
    End Sub
    Protected Sub btnViewShelf_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        Dim currentCommand As String = e.CommandName
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument)
        'Dim BranchId As String
        Dim DocSafeId As String
        Try
            DocSafeId = GvStorePlace.DataKeys(currentRowIndex).Value

            lblCommand.Text = currentCommand
            lblIndex.Text = currentRowIndex.ToString
            lblKey.Text = DocSafeId
            GvStorePlace.SelectedIndex = currentRowIndex
            MultiView_Utama.SetActiveView(View_DocShelf)
        Catch ex As Exception
            sError = Validation.ReplaceMessage(ex.Message.ToString)
        End Try
    End Sub

    Private Sub DataSearch()
        If Not IsPostBack() Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCHID=-999"
        End If
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If

        If Len(Trim(ddlAreaSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND AREAID=" & ddlAreaSearch.SelectedValue
        End If

        gvData.DataBind()
    End Sub
    Private Sub DataGridStore()
        Me.sdsSafeGrid.SelectCommand = Me.sdsSafeGrid.SelectCommand
        GvStorePlace.DataBind()
    End Sub
    Protected Sub ddlAreaSearch_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlAreaSearch.SelectedIndexChanged
        DataSearch()
    End Sub

    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
        lblError.Visible = False
    End Sub

    Protected Sub sdsShelf_Deleted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsShelf.Deleted
        fvDocSelf.Caption = ""
        DataGridShelf()
    End Sub

    Protected Sub sdsShelf_Selected(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsShelf.Selected
        sdsSafe.DataBind()
    End Sub

 
    Protected Sub btnNewShelf_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnNewShelf.Click

        lblError.Visible = False
        fvDocSelf.ChangeMode(FormViewMode.Insert)
        fvDocSelf.Caption = "New Data"
        GvShelf.SelectedIndex = -1
    End Sub
    Protected Sub GvShelf_PageIndexChanged(sender As Object, e As System.EventArgs) Handles GvShelf.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub GvShelf_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GvShelf.RowCommand
        lblError.Visible = False
        If e.CommandName = "Select" Then
            fvDocSelf.ChangeMode(FormViewMode.Edit)
            fvDocSelf.Caption = "Edit Data"
        End If
    End Sub
    Protected Sub sdsShelf_Inserted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsShelf.Inserted
        If e.Command.Parameters("@retval").Value = -1 Then
            lblErrorShelf.Visible = True
            lblErrorShelf.Text = "Shelf Code : " & e.Command.Parameters("@DOCSHELFCode").Value & " already exists..!"
        Else
            'strDocSafeId = e.Command.Parameters("@DOCSAFEID").Value
            lblErrorShelf.Visible = False
            fvDocSelf.Caption = ""
            DataGridShelf()
        End If
    End Sub
    Protected Sub sdsShelf_Updated(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsShelf.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblErrorShelf.Visible = True
            lblErrorShelf.Text = "Shelf Code  : " & e.Command.Parameters("@DOCSHELFCode").Value & " already exists..!"
        Else
            lblErrorShelf.Visible = False
            DataGridShelf()
        End If
    End Sub
    Private Sub DataGridShelf()
        Me.sdsShelfGrid.SelectCommand = Me.sdsShelfGrid.SelectCommand
        GvShelf.DataBind()
    End Sub

    Protected Sub fvDocSelf_ItemCommand(sender As Object, e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvDocSelf.ItemCommand
        If e.CommandName = "Cancel" Then
            GvShelf.SelectedIndex = -1
            fvDocSelf.Caption = ""
        End If
    End Sub

    Protected Sub btnBackShelf_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnBackShelf.Click
        MultiView_Utama.SetActiveView(View_Store)
    End Sub

    Protected Sub btnBackStore_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnBackStore.Click
        MultiView_Utama.SetActiveView(View_View)
    End Sub
End Class
