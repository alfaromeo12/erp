
Partial Class Param_RouteFind
    Inherits System.Web.UI.Page

    Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
        'DataSearch()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            'SetObjectValidation(txtSearch, True)
        End If
        txtSearch.Focus()
        DataSearch()
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Private Sub DataSearch()
        If Not IsPostBack() Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ROUTEID=-999"
        End If
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        'If Len(Trim(ddlAreaSearch.SelectedValue)) > 0 Then
        'Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND AREA.AREAID=" & ddlAreaSearch.SelectedValue
        'End If
        'If Len(Trim(ddlBranchSearch.SelectedValue)) > 0 Then
        'Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND DEALER.BRANCHID=" & ddlBranchSearch.SelectedValue
        'End If
        If Len(Trim(ddlRouteKindSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ROUTEKIND='" & ddlRouteKindSearch.SelectedValue & "'"
        End If
        If Len(Trim(ddlRouteGroupSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ROUTEGROUP='" & ddlRouteGroupSearch.SelectedValue & "'"
        End If

        gvData.DataBind()
    End Sub


    'Protected Sub ddlBranchSearch_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlBranchSearch.SelectedIndexChanged
    '    DataSearch()
    'End Sub




    Protected Sub ddlRouteKindSearch_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlRouteKindSearch.SelectedIndexChanged
        DataSearch()
    End Sub

    Protected Sub ddlRouteGroupSearch_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlRouteGroupSearch.SelectedIndexChanged
        DataSearch()
    End Sub
End Class
