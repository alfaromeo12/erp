
Partial Class Teller_TellerBalanceSPV
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            Me.sdsUser.SelectCommand = Me.sdsUser.SelectCommand & " AND APPUSER.UID=-99999"
        End If
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
    End Sub

    Private Sub DataSearch()
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsUser.SelectCommand = Me.sdsUser.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
        End If
        gvUser.DataBind()
    End Sub

    Protected Sub gvUser_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvUser.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvUser_Sorted(sender As Object, e As System.EventArgs) Handles gvUser.Sorted
        DataSearch()
    End Sub
End Class
