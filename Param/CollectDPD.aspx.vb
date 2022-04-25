
Partial Class Param_CollectDPD
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
    Protected Sub sdsCollectDPD_Deleted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCollectDPD.Deleted
        fvCollectDpd.Caption = ""
        DataGridArea()
    End Sub

    Protected Sub sdsCollectDPD_Inserted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCollectDPD.Inserted
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Collector DPD Code : " & e.Command.Parameters("@COLLECTORDPDCODE").Value & " already exists..!"
        Else
            lblError.Visible = False
            fvCollectDpd.Caption = ""
            DataGridArea()
        End If
    End Sub

    Protected Sub sdsCollectDPD_Selected(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCollectDPD.Selected
        sdsCollectDPD.DataBind()
    End Sub

    Protected Sub sdsCollectDPD_Updated(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCollectDPD.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Collector DPD Code : " & e.Command.Parameters("@COLLECTORDPDCODE").Value & " already exists..!"
        End If
        DataGridArea()
    End Sub
    Private Sub DataGridArea()
        Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand
        gvData.DataBind()
    End Sub
    Private Sub SetValidation()
        Dim oTextBox As TextBox
        oTextBox = CType(fvCollectDpd.FindControl("txtCollCode"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase")
            oTextBox.Focus()
        End If
        oTextBox = CType(fvCollectDpd.FindControl("txtCollName"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")

        oTextBox = CType(fvCollectDpd.FindControl("txtCollFrom"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "integer", "[0-9]")

        oTextBox = CType(fvCollectDpd.FindControl("txtCollTo"), TextBox)
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

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub
End Class
