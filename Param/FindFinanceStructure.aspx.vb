
Partial Class Param_FindFinanceStructure
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            DataSearch()
        End If
    End Sub
    Protected Sub Page_PreInit(sender As Object, e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub
    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
    End Sub
    Private Sub DataSearch()
        If Not IsPostBack Then
            sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND FNFINSTRUCTURE.BRANCHID= -1"
        End If
        If ddlCriteria.SelectedItem.Text = "Product Code" Or ddlCriteria.SelectedItem.Text = "Product Name" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + "(EXISTS(SELECT 'X' FROM PRODUCT WHERE (PRODUCTID = FNFINSTRUCTURE.PRODUCTID AND " + ddlCriteria.SelectedValue + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%')))"
        ElseIf ddlCriteria.SelectedItem.Text = "Branch Name" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedValue + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
        ElseIf ddlCriteria.SelectedItem.Text = "Purpose Name" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + "(EXISTS(SELECT 'X' FROM OBJECTPURPOSE WHERE (PURPOSEID = FNFINSTRUCTURE.PURPOSEID AND " + ddlCriteria.SelectedValue + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%')))"
        ElseIf ddlCriteria.SelectedItem.Text = "Insurance Type" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + "(EXISTS(SELECT 'X' FROM PARAMGLOBAL WHERE (TYPE='INSURANCETYPE') AND (CODE = FNFINSTRUCTURE.INSURANCETYPE  AND " + ddlCriteria.SelectedValue + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%')))"
        ElseIf ddlCriteria.SelectedItem.Text = "Area Name" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + "(EXISTS(SELECT 'X' FROM AREA WHERE (AREAID = FNFINSTRUCTURE.AREAID AND " + ddlCriteria.SelectedValue + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%')))"
        Else
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
        End If
        gvData.DataBind()
    End Sub


    Protected Sub gvData_PageIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub
End Class
