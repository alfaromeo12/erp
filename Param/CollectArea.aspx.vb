
Partial Class Param_CollectArea
    Inherits System.Web.UI.Page
    Private sError As String
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            DataSearch()
            MultiView_Utama.SetActiveView(View_Area)
        End If
    End Sub
    Protected Sub Page_PreInit(sender As Object, e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnNew_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click

        lblError.Visible = False
        fvCollect.ChangeMode(FormViewMode.Insert)
        fvCollect.Caption = "New Data"
        gvData.SelectedIndex = -1
    End Sub

    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataGridArea()
    End Sub

    Protected Sub gvData_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        lblError.Visible = False
        If e.CommandName = "Select" Then
            fvCollect.ChangeMode(FormViewMode.Edit)
            fvCollect.Caption = "Edit Data"
        End If
    End Sub

    Protected Sub sdsCollectArea_Deleted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCollectArea.Deleted
        fvCollect.Caption = ""
        DataGridArea()
    End Sub

    Protected Sub sdsCollectArea_Inserted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCollectArea.Inserted
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Collector ID : " & e.Command.Parameters("@COLLECTAREAID").Value & " already exists..!"
        Else
            lblError.Visible = False
            fvCollect.Caption = ""
            DataGridArea()
        End If
    End Sub

    Protected Sub sdsCollectArea_Selected(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCollectArea.Selected
        sdsCollectArea.DataBind()
    End Sub

    Protected Sub sdsCollectArea_Updated(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCollectArea.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Collector AREA  ID : " & e.Command.Parameters("@COLLECTORAREAID").Value & " already exists..!"
        Else
            lblError.Visible = False
            DataGridArea()
        End If
    End Sub
    Private Sub DataGridArea()
        Me.sdsCollectArea.SelectCommand = Me.sdsCollectArea.SelectCommand
        gvData.DataBind()
    End Sub
    Protected Sub btnViewDtl_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        Dim currentCommand As String = e.CommandName
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument)
        Dim CollectID As String
        Try
            CollectID = gvData.DataKeys(currentRowIndex).Value

            lblCommand.Text = currentCommand
            lblIndex.Text = currentRowIndex.ToString
            lblKey.Text = CollectID
            gvData.SelectedIndex = currentRowIndex
            MultiView_Utama.SetActiveView(View_Area_Detail)
        Catch ex As Exception
            sError = Validation.ReplaceMessage(ex.Message.ToString)
            'ScriptManager.RegisterStartupScript(Me.pnlUpdate, GetType(String), "err", "alert('" & sError & "');", True)
        End Try
    End Sub
    Private Sub SetValidation()
        Dim oTextBox As TextBox
        oTextBox = CType(fvCollect.FindControl("txtCollname"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")
    End Sub

    Protected Sub fvCollect_ItemCommand(sender As Object, e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvCollect.ItemCommand
        If e.CommandName = "Cancel" Then
            gvData.SelectedIndex = -1
            fvCollect.Caption = ""
        End If
    End Sub

    Protected Sub fvCollect_ItemCreated(sender As Object, e As System.EventArgs) Handles fvCollect.ItemCreated
        SetValidation()
    End Sub

    Protected Sub btnNewDtl_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnNewDtl.Click
        lblErrorDetail.Visible = False
        fvCollectDtl.ChangeMode(FormViewMode.Insert)
        fvCollectDtl.Caption = "New Data"
        GvCollectorDtl.SelectedIndex = -1
    End Sub
    Protected Sub sdsCollDtl_Deleted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCollDtl.Deleted
        fvCollectDtl.Caption = ""
        DataGridDetail()
    End Sub

    Protected Sub sdsCollDtl_Inserted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCollDtl.Inserted
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Collector Area. ID : " & e.Command.Parameters("@COLLECTAREAID").Value & " already exists..!"
        Else
            lblError.Visible = False
            fvCollect.Caption = ""
            DataGridDetail()
        End If
    End Sub

    Protected Sub sdsCollDtl_Selected(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCollDtl.Selected
        sdsCollectArea.DataBind()
    End Sub

    Protected Sub sdsCollDtl_Updated(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCollDtl.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Detail. ID : " & e.Command.Parameters("@DETAILID").Value & " already exists..!"
        Else
            lblError.Visible = False
            DataGridDetail()
        End If
    End Sub
    Private Sub DataGridDetail()
        Me.sdsCollDtlGrid.SelectCommand = Me.sdsCollDtlGrid.SelectCommand
        GvCollectorDtl.DataBind()
    End Sub

    Protected Sub fvCollectDtl_ItemCommand(sender As Object, e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvCollectDtl.ItemCommand
        If e.CommandName = "Cancel" Then
            GvCollectorDtl.SelectedIndex = -1
            fvCollectDtl.Caption = ""
        End If
    End Sub

    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
        lblError.Visible = False
    End Sub

    Private Sub DataSearch()
        If Not IsPostBack() Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND COLLECTORAREA.COLLECTORAREAID=-999"
        End If
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        gvData.DataBind()
    End Sub

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub
End Class
