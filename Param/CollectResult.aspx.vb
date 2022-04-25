
Partial Class Param_CollectResult
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
        fvCollectResult.ChangeMode(FormViewMode.Insert)
        fvCollectResult.Caption = "New Data"
        gvData.SelectedIndex = -1
    End Sub

    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvData_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        lblError.Visible = False
        If e.CommandName = "Select" Then
            fvCollectResult.ChangeMode(FormViewMode.Edit)
            fvCollectResult.Caption = "Edit Data"
        End If
    End Sub

    Protected Sub sdsCollResult_Deleted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCollResult.Deleted
        fvCollectResult.Caption = ""
        DataSearch()
    End Sub

    Protected Sub sdsCollResult_Inserted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCollResult.Inserted
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Collector Result ID : " & e.Command.Parameters("@COLLECTRESULTID").Value & " already exists..!"
        Else
            lblError.Visible = False
            fvCollectResult.Caption = ""
            DataSearch()
        End If
    End Sub

    Protected Sub sdsCollResult_Selected(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCollResult.Selected
        sdsCollResult.DataBind()
    End Sub

    Protected Sub sdsCollResult_Updated(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCollResult.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Collector Result ID : " & e.Command.Parameters("@COLLECTRESULTID").Value & " already exists..!"
        Else
            lblError.Visible = False
            DataSearch()
        End If
    End Sub
    Private Sub SetValidation()
        Dim oTextBox As TextBox

        oTextBox = CType(fvCollectResult.FindControl("txtCollResultName"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")

        oTextBox = CType(fvCollectResult.FindControl("txtCollResultURL"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")

    End Sub

    Protected Sub fvCollectResult_ItemCommand(sender As Object, e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvCollectResult.ItemCommand
        If e.CommandName = "Cancel" Then
            gvData.SelectedIndex = -1
            fvCollectResult.Caption = ""
        End If
    End Sub
    Protected Sub fvCollectResult_ItemCreated(sender As Object, e As System.EventArgs) Handles fvCollectResult.ItemCreated
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
        If Len(Trim(ddlCollectTypeSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND CT.COLLECTORTYPE=" & ddlCollectTypeSearch.SelectedValue
        End If
        gvData.DataBind()
    End Sub

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub

    Protected Sub ddlCollectTypeSearch_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlCollectTypeSearch.SelectedIndexChanged
        DataSearch()
    End Sub
End Class
