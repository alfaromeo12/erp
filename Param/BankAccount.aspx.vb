
Partial Class Param_BankAccount
    Inherits System.Web.UI.Page

    'Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
    '    DataSearch()
    'End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ''SetObjectValidation(txtSearch, True)
            DataSearch()
        End If
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
        Dim oTextDoc As TextBox
        Dim oTextDocOth As TextBox
        Dim oTextDoi As TextBox
        Dim oTextDoiOth As TextBox
        Dim oTextDos As TextBox
        Dim oTextDosOth As TextBox

        oTextBox = CType(fvData.FindControl("txtAccountNo"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase nospace")
            oTextBox.Focus()
        End If

        oTextDoc = CType(fvData.FindControl("txtDoC"), TextBox)
        If oTextDoc IsNot Nothing Then
            SetObjectValidation(oTextDoc, False, "integer", "[0-9]")
        End If

        oTextDocOth = CType(fvData.FindControl("txtDoCOTH"), TextBox)
        If oTextDocOth IsNot Nothing Then
            SetObjectValidation(oTextDocOth, False, "integer", "[0-9]")
        End If

        oTextDoi = CType(fvData.FindControl("txtDayInkaso"), TextBox)
        If oTextDoi IsNot Nothing Then
            SetObjectValidation(oTextDoi, False, "integer", "[0-9]")
        End If

        oTextDoiOth = CType(fvData.FindControl("txtDoIOTH"), TextBox)
        If oTextDoiOth IsNot Nothing Then
            SetObjectValidation(oTextDoiOth, False, "integer", "[0-9]")
        End If

        oTextDos = CType(fvData.FindControl("txtDaySucess"), TextBox)
        If oTextDos IsNot Nothing Then
            SetObjectValidation(oTextDos, False, "integer", "[0-9]")
        End If

        oTextDosOth = CType(fvData.FindControl("txtDoSOTH"), TextBox)
        If oTextDosOth IsNot Nothing Then
            SetObjectValidation(oTextDosOth, False, "integer", "[0-9]")
        End If
        'oTextBox = CType(fvData.FindControl("txtBankBranch"), TextBox)
        'If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, True)
        'oTextBox = CType(fvData.FindControl("txtCOANo"), TextBox)
        'If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, True)
    End Sub

    Private Sub DataSearch()
        If Not IsPostBack() Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BANKACCOUNT.ACCOUNTID=-999"
        End If
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        If Len(Trim(ddlBankSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BANKACCOUNT.BANKID=" & ddlBankSearch.SelectedValue
        End If
        gvData.DataBind()
    End Sub

    Protected Sub fvData_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewDeletedEventArgs) Handles fvData.ItemDeleted
        DataSearch()
    End Sub

    Protected Sub fvData_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles fvData.ItemInserted
        ddlBankSearch.DataBind()
        DataSearch()
    End Sub

    Protected Sub fvData_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewUpdatedEventArgs) Handles fvData.ItemUpdated
        DataSearch()
    End Sub

    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
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
            lblError.Text = "Account No : " & e.Command.Parameters("@AccountNo").Value & " already exists..!"
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
            lblError.Text = "Account No : " & e.Command.Parameters("@AccountNo").Value & " already exists..!"
        End If
    End Sub

    Protected Sub gvData_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvData.RowDataBound
        If DataBinder.Eval(e.Row.DataItem, "NEW") Then
            e.Row.ForeColor = Drawing.Color.White
            e.Row.BackColor = Drawing.Color.Black
            e.Row.Font.Bold = True
            e.Row.Font.Italic = True
        ElseIf DataBinder.Eval(e.Row.DataItem, "UPD") Then
            e.Row.ForeColor = Drawing.Color.Yellow
            e.Row.BackColor = Drawing.Color.Gray
            e.Row.Font.Bold = True
            e.Row.Font.Italic = True
        End If
    End Sub

    Protected Sub ddlBankSearch_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlBankSearch.SelectedIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub
End Class