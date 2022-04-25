
Partial Class Param_CollectWarningLetter
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
        End If
    End Sub
    Protected Sub Page_PreInit(sender As Object, e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnNew_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click

        lblError.Visible = False
        fvCollectDpd.ChangeMode(FormViewMode.Insert)
        fvCollectDpd.Caption = "New Data"
        gvData.SelectedIndex = -1
    End Sub

    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataGridArea()
    End Sub

    Protected Sub gvData_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        lblError.Visible = False
        If e.CommandName = "Select" Then
            fvCollectDpd.ChangeMode(FormViewMode.Edit)
            fvCollectDpd.Caption = "Edit Data"
        End If
    End Sub
    Protected Sub sdsData_Deleted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsData.Deleted
        fvCollectDpd.Caption = ""
        DataGridArea()
    End Sub

    Protected Sub sdsData_Inserted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsData.Inserted
       
            lblError.Visible = False
            fvCollectDpd.Caption = ""
            DataGridArea()

    End Sub

    Protected Sub sdsData_Selected(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsData.Selected
        sdsData.DataBind()
    End Sub

    Protected Sub sdsData_Updated(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsData.Updated
        lblError.Visible = False
        DataGridArea()
        gvData.SelectedIndex = -1
        fvCollectDpd.Caption = ""
    End Sub
    Private Sub DataGridArea()
        Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand
        gvData.DataBind()
    End Sub
    Private Sub SetValidation()
        Dim oTextBox As TextBox
        oTextBox = CType(fvCollectDpd.FindControl("txtDayFrom"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "integer", "[0-9]")

        oTextBox = CType(fvCollectDpd.FindControl("txtDayUntil"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "integer", "[0-9]")

    End Sub

    Protected Sub fvCollectDpd_ItemCommand(sender As Object, e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvCollectDpd.ItemCommand
        If e.CommandName = "Cancel" Then
            gvData.SelectedIndex = -1
            fvCollectDpd.Caption = ""
        End If
    End Sub
    Protected Sub fvCollectDpd_ItemCreated(sender As Object, e As System.EventArgs) Handles fvCollectDpd.ItemCreated
        SetValidation()
    End Sub
    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
        lblError.Visible = False
    End Sub
    Private Sub DataSearch()
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        gvData.DataBind()
    End Sub
End Class
