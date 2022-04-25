Imports System.IO
Imports System.Data.SqlClient
Imports System.Data
Imports System.Drawing
Partial Class Product_MitraSearch
    Inherits System.Web.UI.Page
    Private iPartId As Integer
    Private lblImageId As String
    Public Shared iError As Integer = 0
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack() Then
            DataSearch()
            'fvData.Visible = True
            'formImage.Visible = True
        End If
        'ImageBtnNew.Visible = False
    End Sub
    Public Function getActive(ByVal Active As Boolean) As String
        getActive = "Yes"
        If Not Active Then
            getActive = "No"
        End If
    End Function

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub
    Protected Sub gvData_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        lblError.Text = ""
        If e.CommandName = "Select" Then
            'fvData.ChangeMode(FormViewMode.Edit)
            'fvData.Caption = "Edit Data"
            'fvData.Visible = True
            'formImage.Caption = "Tech File"
            'gvImage.Visible = True
            'ImageBtnNew.Visible = True
            'formImage.Visible = True
            'pnlImage.Visible = True
        End If
    End Sub

    Private Sub DataSearch()
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
        End If
        'gvData.DataBind()
        'fvData.Visible = True
        'fvData.DataBind()
        'formImage.Visible = True
        'gvImage.Visible = False
        'ImageBtnNew.Visible = False
    End Sub

    'Protected Sub fvData_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewUpdatedEventArgs) Handles fvData.ItemUpdated
    '    DataSearch()
    '    'fvData.Visible = True
    '    'formImage.Visible = True
    '    'gvImage.Visible = True
    'End Sub
    'Protected Sub imgBtnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
    '    'fvData.ChangeMode(FormViewMode.Insert)
    '    ' fvData.Caption = "New Data"
    '    'fvData.Visible = True
    '    'fvData.DataBind()
    '    'ImageBtnNew.Visible = False
    '    'formImage.Visible = False
    '    'gvImage.Visible = False
    'End Sub
    'Protected Sub fvData_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles fvData.ItemInserted
    '    DataSearch()
    'End Sub
    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
        lblError.Text = ""
    End Sub
    'Protected Sub fvData_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvData.ItemCommand
    '    If e.CommandName = "Cancel" Then
    '        gvData.SelectedIndex = -1
    '        'fvData.Caption = ""
    '        'fvData.Visible = True
    '    End If
    'End Sub
    'Protected Sub fvData_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvData.ItemCreated
    '    'SetValidation()
    'End Sub
    'Private Sub SetValidation()
    '    Dim oTextBox As TextBox
    '    oTextBox = CType(fvData.FindControl("txtUserName"), TextBox)
    '    If oTextBox IsNot Nothing Then
    '        SetObjectValidation(oTextBox, False, "uppercase nospace")
    '        oTextBox.Focus()
    '    End If
    'End Sub
    'Protected Sub sdsForm_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Inserted
    '    If e.Command.Parameters("@retval").Value = -1 Then
    '        lblError.Visible = True
    '        lblError.Text = "User Name : " & e.Command.Parameters("@USERNAME").Value & " already exists..!"
    '    Else
    '        lblError.Visible = False
    '        'fvData.Caption = ""
    '    End If
    '    DataSearch()
    'End Sub
    'Protected Sub sdsForm_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Deleted
    '    'fvData.Caption = ""
    '    DataSearch()
    'End Sub

    Protected Sub gvData_PageIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    'Protected Sub ImageBtnNew_Click(sender As Object, e As ImageClickEventArgs) Handles ImageBtnNew.Click
    '    formImage.ChangeMode(FormViewMode.Insert)
    '    formImage.Caption = "New Data"
    '    formImage.Visible = True
    '    gvImage.Visible = True
    'End Sub

  
 

End Class