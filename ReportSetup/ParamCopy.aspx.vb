
Partial Class ReportSetup_ParamCopy
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        DataSearch()
    End Sub

    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
    End Sub

    Private Sub DataSearch()
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Me.txtSearch.Text + "%'"
        End If
        If Len(Trim(ddlRptModulSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND rptModul.ModulID=" + ddlRptModulSearch.SelectedValue
        End If
        'If Len(Trim(strModulID)) > 0 Then
        '    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND rptModul.ModulID=" + strModulID
        'End If
        gvData.DataBind()
    End Sub
End Class
