
Partial Class AppSetting_AppSetting
    Inherits System.Web.UI.Page



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        lblError.Visible = False
        If Not IsPostBack Then
            ''SetObjectValidation(txtSearch, True)
        End If
        DataSearch()
    End Sub


    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub gvData_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        If e.CommandName = "Select" Then
            fvData.ChangeMode(FormViewMode.Edit)
            fvData.Caption = "Edit Data"
        End If
    End Sub

    Protected Sub fvData_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvData.ItemCreated
        'lblError.Visible = False
        Dim oTextBox As TextBox
        oTextBox = CType(fvData.FindControl("txtCode"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase nospace")
        'oTextBox = CType(fvData.FindControl("txtValue"), TextBox)
        'If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, True)
        'oTextBox = CType(fvData.FindControl("txtDescription"), TextBox)
        'If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, True)

    End Sub

    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        'DataSearch()
    End Sub

    Private Sub DataSearch()
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
        End If
        gvData.DataBind()
    End Sub

    'Protected Sub fvData_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewUpdatedEventArgs) Handles fvData.ItemUpdated
    '    DataSearch()
    'End Sub

    'Protected Sub fvData_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles fvData.ItemInserted
    '    DataSearch()
    'End Sub

    'Protected Sub fvData_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewDeletedEventArgs) Handles fvData.ItemDeleted
    '    DataSearch()
    'End Sub

    Protected Sub imgBtnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        fvData.ChangeMode(FormViewMode.Insert)
        fvData.Caption = "New Data"

        'ajxCPEData.Collapsed = True
    End Sub


    Protected Sub sdsForm_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Inserted
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Data Code: " & e.Command.Parameters("@APPCode").Value & "  Already Exists...!"
            'Response.Write("Data Code: " & e.Command.Parameters("@APPCode").Value & "  Already Exists...!")
            'Dim lblError As Label
            'lblError = CType(fvData.FindControl("lblError"), Label)
            'If lblError IsNot Nothing Then
            '    lblError.Text = "Data Code: " & e.Command.Parameters("@APPCode").Value & "  Already Exists...!"
            '    'Response.Write("Data Code: " & e.Command.Parameters("@APPCode").Value & "  Already Exists...!")
            '    'fvData.ChangeMode(FormViewMode.Insert)

            'End If
        Else
            gvData.SelectedIndex = -1
            fvData.Caption = ""
            DataSearch()
        End If
    End Sub

    'Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
    '    DataSearch()
    'End Sub

    Protected Sub fvData_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvData.ItemCommand
        If e.CommandName = "Cancel" Then
            gvData.SelectedIndex = -1
            fvData.Caption = ""
        End If

    End Sub

    Protected Sub sdsForm_Updated(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Updated
        DataSearch()
        gvData.SelectedIndex = -1
        fvData.Caption = ""
    End Sub
End Class
