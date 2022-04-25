
Partial Class Txn_DocReceived
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Response.Write(Request.Cookies("AppDate").Value)
        txtUID.Value = Request.Cookies("UID").Value
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try

            If Not IsPostBack() Then
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE, CAST(dbo.f_IsUserBranch(" & Request.Cookies("UID").Value & ") as VARCHAR(10)) ISUSERBRANCH FROM APPSETTING WITH(NOLOCK) WHERE APPCODE='APPDATE'")
                If oSDR.Read() Then
                    txtAppDate.Value = oSDR("APPVALUE").ToString()
                    hidIsUserBranch.Value = oSDR("ISUSERBRANCH").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing
                txtTxnDate.Text = txtAppDate.Value
                txtTxnDateTo.Text = txtAppDate.Value
                txtReceiveDate.Text = txtAppDate.Value

                txtAction.Value = Request.QueryString("Action")
                DataSearch()
                ajaxCDDArea.ContextKey = txtUID.Value
                ajaxCDDBranch.ContextKey = txtUID.Value
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT BRANCH.BRANCHID, BRANCH.AREAID FROM APPUSER WITH(NOLOCK) INNER JOIN BRANCH ON APPUSER.BRANCHID=BRANCH.BRANCHID WHERE APPUSER.UID=" & Request.Cookies("UID").Value)
                If oSDR.Read() Then
                    If hidIsUserBranch.Value = "1" Then 'user cabang
                        ajaxCDDArea.SelectedValue = oSDR("AREAID").ToString()
                        ajaxCDDBranch.SelectedValue = oSDR("BRANCHID").ToString()
                    End If
                    ajaxCCDAreaSafe.SelectedValue = oSDR("AREAID").ToString()
                    ajaxCCDBranchSafe.SelectedValue = oSDR("BRANCHID").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR LOADING RECEIVE COLLATERAL: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub


    Private Sub DataSearch()
        If hidIsUserBranch.Value = "1" Then 'jika user cabang, filter berdasarkan cabang yang berhak saja
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCH.BRANCHID IN (SELECT BRANCHID FROM dbo.f_getAPPUSERBRANCHList(" & txtUID.Value & "))"
        End If
        If Len(Trim(txtSearch.Text)) > 0 Then
            If ddlCriteria.SelectedValue = "ACCNOX" Or ddlCriteria.SelectedValue = "CUSTNOX" Then
                Dim strBranchID As String = ""
                Dim strJFID As String = ""
                Dim strNumber As String = ""
                SplitFormatedNumber(txtSearch.Text, strBranchID, strNumber)
                If ddlCriteria.SelectedValue = "ACCNOX" Then
                    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.BRANCHID=" & strBranchID & " AND ACCOUNT.ACCOUNTNO=" & strNumber
                ElseIf ddlCriteria.SelectedValue = "CUSTNOX" Then
                    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND CUSTOMER.BRANCHID=" & strBranchID & " AND CUSTOMER.CUSTNO=" & strNumber
                End If
            ElseIf InStr(UCase(ddlCriteria.SelectedValue), "APPID", CompareMethod.Text) > 0 Or _
                InStr(UCase(ddlCriteria.SelectedValue), "CUSTID", CompareMethod.Text) > 0 Or _
                InStr(UCase(ddlCriteria.SelectedValue), "ACCID", CompareMethod.Text) > 0 Or _
                InStr(UCase(ddlCriteria.SelectedValue), "ACCOUNTNO", CompareMethod.Text) > 0 Or _
                InStr(UCase(ddlCriteria.SelectedValue), "CUSTNO", CompareMethod.Text) > 0 _
            Then
                If IsNumeric(txtSearch.Text) Then
                    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + "=" + Me.txtSearch.Text
                Else
                    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + "=0"
                End If
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
            End If
        End If


        gvData.DataBind()
        gvSummary.DataBind()

        If gvData.Rows.Count <= 0 Then
            btnSaveAll.Enabled = False
            btnSaveCheck.Enabled = False
            pnlSearchAccount.Visible = False
        Else
            btnSaveAll.Enabled = True
            btnSaveCheck.Enabled = True
            pnlSearchAccount.Visible = True
        End If
    End Sub




    Protected Sub btnView_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnView.Click
        lblMessage.Visible = False
        DataSearch()
    End Sub


    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
    End Sub

    Protected Sub gvData_PageIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub btnSaveAll_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveAll.Click
        lblMessage.Visible = False
        Dim objDB As New DBX
        Try
            objDB.ExecSP("COLLATERALReceiveBatch", _
                objDB.MP("@BRANCHID", Data.SqlDbType.Int, ddlBranch.SelectedValue, 10, Data.ParameterDirection.Input), _
                objDB.MP("@BOOKFROM", Data.SqlDbType.DateTime, ConvertDate(txtTxnDate.Text), 10, Data.ParameterDirection.Input), _
                objDB.MP("@BOOKTO", Data.SqlDbType.DateTime, ConvertDate(txtTxnDateTo.Text), 10, Data.ParameterDirection.Input), _
                objDB.MP("@RECEIVEDATE", Data.SqlDbType.DateTime, ConvertDate(txtReceiveDate.Text), 10, Data.ParameterDirection.Input), _
                objDB.MP("@DOCSHELFID", Data.SqlDbType.BigInt, ddlDocShelf.SelectedValue, 30, Data.ParameterDirection.Input), _
                objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 10, Data.ParameterDirection.Input) _
            )
            lblMessage.Visible = True
            lblMessage.Text = "COLLATERAL RECEIVE BATCH SAVE COMPLETED...!"
            DataSearch()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR COLLATERAL RECEIVE BATCH: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing

        End Try
    End Sub

    Protected Sub btnSaveCheck_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveCheck.Click
        lblMessage.Visible = False
        Dim objDB As New DBX
        Try
            Dim oCheckBox As CheckBox
            Dim strLOCID, strOBJID As String
            For Each row As GridViewRow In gvData.Rows
                oCheckBox = CType(row.FindControl("cbReceive"), CheckBox)
                If oCheckBox IsNot Nothing Then
                    If oCheckBox.Checked Then
                        strLOCID = gvData.DataKeys(row.RowIndex).Values("LOCID").ToString()
                        strOBJID = gvData.DataKeys(row.RowIndex).Values("OBJID").ToString()
                        objDB.ExecSP("COLLATERALReceive", _
                            objDB.MP("@LOCID", Data.SqlDbType.Int, strLOCID, 10, Data.ParameterDirection.Input), _
                            objDB.MP("@OBJID", Data.SqlDbType.BigInt, strOBJID, 30, Data.ParameterDirection.Input), _
                            objDB.MP("@RECEIVEDATE", Data.SqlDbType.DateTime, ConvertDate(txtReceiveDate.Text), 10, Data.ParameterDirection.Input), _
                            objDB.MP("@DOCSHELFID", Data.SqlDbType.BigInt, ddlDocShelf.SelectedValue, 30, Data.ParameterDirection.Input), _
                            objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 10, Data.ParameterDirection.Input) _
                        )
                    End If
                End If
            Next
            lblMessage.Visible = True
            lblMessage.Text = "COLLATERAL RECEIVE BY CHECKLIST SAVE COMPLETED...!"
            DataSearch()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR COLLATERAL RECEIVE BY CHECKLIST: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub gvData_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvData.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim oCheckBox As CheckBox
            oCheckBox = CType(e.Row.FindControl("cbReceive"), CheckBox)
            If oCheckBox IsNot Nothing Then
                oCheckBox.Attributes.Add("onclick", "SelectRow(this);")
            End If
        End If
    End Sub

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub

    Protected Sub sdsSummary_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles sdsSummary.Selecting
        e.Command.CommandTimeout = 0
    End Sub

    Protected Sub sdsGrid_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles sdsGrid.Selecting
        e.Command.CommandTimeout = 0
    End Sub
End Class
