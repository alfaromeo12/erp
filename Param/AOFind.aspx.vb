
Partial Class Param_AOFind
    Inherits System.Web.UI.Page

    Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
        'DataSearch()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            'SetObjectValidation(txtSearch, True)
            Dim objDB As New DBX
            Try
                Dim strBranchID As String = "", strAreaID As String = ""
                Dim oSDR As System.Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT BRANCHID FROM APPUSER WITH(NOLOCK) WHERE UID=" & Request.Cookies("UID").Value)
                If oSDR.Read Then
                    strBranchID = oSDR("BRANCHID").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing

                oSDR = objDB.CreateSDRFromSQLSelect("SELECT AREAID FROM BRANCH WITH(NOLOCK) WHERE BRANCHID=" & strBranchID)
                If oSDR.Read Then
                    strAreaID = oSDR("AREAID").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing

                ajaxCDDArea.SelectedValue = strAreaID
                ajaxCDDBranch.SelectedValue = strBranchID
                ddlAreaSearch.SelectedValue = strAreaID
                ddlBranchSearch.SelectedValue = strBranchID
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND AREA.AREAID=" & strAreaID
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND AO.BRANCHID=" & strBranchID
                DataSearch()
                'Catch ex As Exception
            Finally
                objDB.Close()
                objDB = Nothing

            End Try

        End If
        txtSearch.Focus()
        DataSearch()
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Private Sub DataSearch()
        If Not IsPostBack() Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND AO.AOID=-999"
        End If
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        If Len(Trim(ddlAreaSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND AREA.AREAID=" & ddlAreaSearch.SelectedValue
        End If
        If Len(Trim(ddlBranchSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND AO.BRANCHID=" & ddlBranchSearch.SelectedValue
        End If
        gvData.DataBind()
    End Sub


    Protected Sub ddlBranchSearch_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlBranchSearch.SelectedIndexChanged
        DataSearch()
    End Sub




End Class
