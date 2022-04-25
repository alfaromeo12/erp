
Partial Class Param_NotaryFind
    Inherits System.Web.UI.Page

    Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
        'DataSearch()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            'SetObjectValidation(txtSearch, True)
            Dim strBranchID As String = Request.QueryString("BRANCHID")
            If Len(Trim(strBranchID)) > 0 Then
                Dim objDB As New DBX
                Try
                    Dim strAreaID As String = ""
                    Dim oSDR As System.Data.SqlClient.SqlDataReader

                    oSDR = objDB.CreateSDRFromSQLSelect("SELECT AREAID FROM BRANCH WITH(NOLOCK) WHERE BRANCHID=" & strBranchID)
                    If oSDR.Read Then
                        strAreaID = oSDR("AREAID").ToString()
                    End If
                    oSDR.Close()
                    oSDR = Nothing

                    'Response.Write(strAreaID)
                    'Response.End()

                    ajaxCDDArea.SelectedValue = strAreaID
                    ajaxCDDBranch.SelectedValue = strBranchID
                    ddlAreaSearch.SelectedValue = strAreaID
                    ddlBranchSearch.SelectedValue = strBranchID
                    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND AREA.AREAID=" & strAreaID
                    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND NOTARY.BRANCHID=" & strBranchID
                    DataSearch()
                    'Catch ex As Exception
                Finally
                    objDB.Close()
                    objDB = Nothing

                End Try
            End If
        End If
        txtSearch.Focus()
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Private Sub DataSearch()
        'If Not IsPostBack() Then
        '    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND NOTARY.NOTARYID=-999"
        'End If

        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        If Len(Trim(ddlAreaSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND AREA.AREAID=" & ddlAreaSearch.SelectedValue
        End If
        If Len(Trim(ddlBranchSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND NOTARY.BRANCHID=" & ddlBranchSearch.SelectedValue
        End If

        gvData.DataBind()
    End Sub

    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
    End Sub

    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub
End Class
