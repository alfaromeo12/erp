Partial Class Param_PortfolioCategory

    Inherits System.Web.UI.Page

    Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
        DataSearch()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ''SetObjectValidation(txtSearch, True)
        End If
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub gvData_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        'lblError.Text = ""
        lblError.Visible = False
        If e.CommandName = "Select" Then
            fvData.ChangeMode(FormViewMode.Edit)
            fvData.Caption = "Edit Data"
        End If
    End Sub

    Protected Sub imgBtnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        fvData.ChangeMode(FormViewMode.Insert)
        fvData.Caption = "New Data"
    End Sub

    Protected Sub fvData_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvData.ItemCreated
        SetValidation()
    End Sub

    Private Sub SetValidation()
        Dim oTextBox As TextBox
        oTextBox = CType(fvData.FindControl("txtCode"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase nospace")
            oTextBox.Focus()
        End If
        oTextBox = CType(fvData.FindControl("txtName"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")

    End Sub

    Private Sub DataSearch()
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        gvData.DataBind()
    End Sub


    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        'DataSearch()
        'lblError.Text = ""
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
            lblError.Text = "Code (BI Code) : " & e.Command.Parameters("@PORTFOLIOCATCODE").Value & " already exists..!"
        Else
            lblError.Visible = False
            fvData.Caption = ""
        End If
        DataSearch()
    End Sub

    Protected Sub sdsForm_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Code (BI Code) : " & e.Command.Parameters("@PORTFOLIOCATCODE").Value & " already exists..!"
        End If
        DataSearch()
    End Sub

    Protected Sub sdsForm_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Deleted
        fvData.Caption = ""
        DataSearch()
    End Sub
End Class
