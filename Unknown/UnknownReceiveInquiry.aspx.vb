
Partial Class Unknown_UnknownReceiveInquiry
    Inherits System.Web.UI.Page
    Public Shared strAppDate As String
    Private TotalAllocation As Decimal = 0.0
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim objDB As New DBX
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            Try
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE, CAST(dbo.f_IsUserBranch(" & Request.Cookies("UID").Value & ") as VARCHAR(10)) AS ISUSERBRANCH FROM APPSETTING WITH(NOLOCK) WHERE APPCODE='APPDATE'")
                If oSDR.Read Then
                    strAppDate = oSDR("APPVALUE").ToString()
                    hidIsUserBranch.Value = oSDR("ISUSERBRANCH").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing

                If Not IsPostBack() Then
                    If hidIsUserBranch.Value = "1" Then 'user cabang
                        oSDR = objDB.CreateSDRFromSQLSelect("SELECT BRANCH.BRANCHID, BRANCH.AREAID FROM APPUSER WITH(NOLOCK) INNER JOIN BRANCH ON APPUSER.BRANCHID=BRANCH.BRANCHID WHERE APPUSER.UID=" & Request.Cookies("UID").Value)
                        If oSDR.Read() Then
                            ajaxCDDArea.SelectedValue = oSDR("AREAID").ToString()
                            ajaxCDDBranch.SelectedValue = oSDR("BRANCHID").ToString()
                        End If
                        oSDR.Close()
                        oSDR = Nothing
                    End If
                End If

            Catch ex As Exception
                lblMessage.Visible = True
                lblMessage.Text = "ERROR LOADING ASSET PLEDGE ENTRY..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE : <BR>" & ex.Message
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
            txtDateStart.Text = strAppDate
            txtDateEnd.Text = strAppDate
            MultiView_Utama.SetActiveView(View_View)
        End If
        SetObjectValidation(txtDateStart, True, "date", "[0-9/]")
        SetObjectValidation(txtDateEnd, True, "date", "[0-9/]")
        DataGrid()
    End Sub
    Protected Sub Page_PreInit(sender As Object, e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub
    Private Sub DataGrid()
        If Not IsPostBack Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand + " AND PAYUNKNOWN.LOCIDUN=0 AND PAYUNKNOWN.UNKNOWNID = 0"
        End If


        If Len(Trim(ddlCriteria.SelectedValue)) > 0 And txtSearch.Text <> "" Then
            If ddlCriteria.SelectedValue = "REFNO" Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
            ElseIf ddlCriteria.SelectedValue = "BANKNAME" Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
            End If
        ElseIf txtSearch.Text = "" Or txtSearch.Text = "%%" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
        End If
         If Len(Trim(ddlStatus.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND PAYUNKNOWN.UNKNOWNSTS=" & ddlStatus.SelectedValue
        End If

        If Len(Trim(ddlStatusPosting.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND EXISTS(SELECT 'X' FROM PAYUNKNOWNALLOCATE WITH(NOLOCK) WHERE POSTINGSTS= " + ddlStatusPosting.SelectedValue + " AND PAYUNKNOWN.LOCIDUN=PAYUNKNOWNALLOCATE.LOCIDUN AND PAYUNKNOWN.UNKNOWNID=PAYUNKNOWNALLOCATE.UNKNOWNID)"
        End If

        If Len(Trim(ddlAreaSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCH.AREAID=" & ddlAreaSearch.SelectedValue
        End If
        If Len(Trim(ddlBranchSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCH.BRANCHID=" & ddlBranchSearch.SelectedValue
        End If


        If rdbFromUnknownDate.Checked Then
            If Len(Trim(txtDateStart.Text)) > 0 And Len(Trim(txtDateEnd.Text)) > 0 Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (PAYUNKNOWN.TXNDATE BETWEEN CONVERT(DATETIME, '" + txtDateStart.Text + "', 103) AND CONVERT(DATETIME, '" + txtDateEnd.Text + "', 103))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (PAYUNKNOWN.TXNDATE BETWEEN CONVERT(DATETIME, '" + strAppDate + "', 103) AND CONVERT(DATETIME, '" + strAppDate + "', 103))"
            End If
        End If
        gvData.DataBind()
    End Sub
    Protected Sub btnView_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument).ToString
        lblMessage.Visible = False
        Try

            hidLocidUN.Value = CType(gvData.Rows(currentRowIndex).FindControl("lblKeyLocid"), Label).Text
            hidIDUnReceive.Value = gvData.DataKeys(currentRowIndex).Value
            MultiView_Utama.SetActiveView(View_Receive)
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR UNKNOWN PAYMENT ALLOCATION: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        End Try
    End Sub


    Protected Sub btnBack_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnBack.Click
        MultiView_Utama.SetActiveView(View_View)
    End Sub

    Protected Sub gvAllocation_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvAllocation.RowCommand
        lblMessage.Visible = False
        If e.CommandName = "Select" Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim UNKNOWNID As Integer = Convert.ToInt32(gvAllocation.DataKeys(index).Values("UNKNOWNID"))
            Dim ALLOCATEID As Integer = Convert.ToInt32(gvAllocation.DataKeys(index).Values("ALLOCATEID"))
        End If
    End Sub

    Private Sub DataGridAllocation()
        sdsAllocation.SelectCommand = sdsAllocation.SelectCommand
        gvAllocation.DataBind()
    End Sub

    Protected Sub gvAllocation_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvAllocation.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            TotalAllocation += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "AMOUNTALLOCATE"))
            If DataBinder.Eval(e.Row.DataItem, "POSTINGSTS") Then
                e.Row.Font.Bold = True
            Else
                e.Row.ForeColor = Drawing.Color.Red
            End If

        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(5).Text = String.Format("{0:n}", TotalAllocation)
        End If

    End Sub

    Protected Sub gvData_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvData.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If DataBinder.Eval(e.Row.DataItem, "UNKNOWNSTS") = 9 Then
                e.Row.ForeColor = Drawing.Color.Red
            ElseIf DataBinder.Eval(e.Row.DataItem, "UNKNOWNSTS") = 0 Then
                e.Row.ForeColor = Drawing.Color.Blue
            End If
        End If

    End Sub
End Class
