
Partial Class Txn_TxnInputApproval
    Inherits System.Web.UI.Page
    Public Shared strAppState As String
    Public Shared oStrtxtDebet, oStrtxtKredit, oStrtxtTotalDebet, oStrtxtTotalKredit As String
    Private TotalDebet As Decimal = 0.0
    Private TotalKredit As Decimal = 0.0
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            txtUID.Value = Request.Cookies("UID").Value
            If Not IsPostBack() Then
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE, CAST(dbo.f_IsUserBranch(" & txtUID.Value & ") as VARCHAR(10)) ISUSERBRANCH FROM APPSETTING WITH(NOLOCK)  WHERE APPCODE='APPDATE'")
                If oSDR.Read Then
                    txtAppDate.Value = oSDR("APPVALUE").ToString()
                    hidIsUserBranch.Value = oSDR("ISUSERBRANCH").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing
                hidAction.Value = "LOAD"
                MVTxn.SetActiveView(vSearch)
                rbTxnAll.Checked = True
                'rbRevAll.Checked = True
                txtTxnFrom.Text = txtAppDate.Value
                txtTxnTo.Text = txtAppDate.Value

                'txtRevFrom.Text = txtAppDate.Value
                'txtRevTo.Text = txtAppDate.Value

                'SetObjectValidation(txtSearch, True)
                SetObjectValidation(txtTxnFrom, True, "date", "[0-9/]")
                SetObjectValidation(txtTxnTo, True, "date", "[0-9/]")

                'SetObjectValidation(txtRevFrom, True, "date", "[0-9/]")
                'SetObjectValidation(txtRevTo, True, "date", "[0-9/]")

                ReadOnlyAplicationField(vEntry)
                ajaxCDDArea.ContextKey = txtUID.Value
                ajaxCDDBranch.ContextKey = txtUID.Value
                ajaxCCDFincat.ContextKey = txtUID.Value
                If hidIsUserBranch.Value = "1" Then 'user cabang
                    oSDR = objDB.CreateSDRFromSQLSelect("SELECT BRANCH.BRANCHID, BRANCH.AREAID FROM APPUSER WITH(NOLOCK) INNER JOIN BRANCH ON APPUSER.BRANCHID=BRANCH.BRANCHID WHERE APPUSER.UID=" & txtUID.Value)
                    If oSDR.Read() Then
                        ajaxCDDArea.SelectedValue = oSDR("AREAID").ToString()
                        ajaxCDDBranch.SelectedValue = oSDR("BRANCHID").ToString()
                    End If
                    oSDR.Close()
                    oSDR = Nothing
                End If
            End If

            oStrtxtDebet = ""
            oStrtxtKredit = ""
            DataSearch()
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Private Sub DataSearch()
        If hidIsUserBranch.Value = "1" Then 'jika user cabang, filter berdasarkan cabang yang berhak saja
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND BRANCH.BRANCHID IN (SELECT BRANCHID FROM dbo.f_getAPPUSERBRANCHList(" & txtUID.Value & "))"
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND TXN.FINCATID IN (SELECT FINCATID FROM dbo.f_getAPPUSERFINCATList(" & txtUID.Value & "))"
        End If
        If Not IsPostBack() Then
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND (TXN.LOCIDTXN=-1) AND (TXN.TXNID=-1)"
        End If
        If Len(Trim(txtSearch.Text)) > 0 Then
            If ddlCriteria.SelectedValue = "ACCNOX" Then
                Dim strBranchID As String = ""
                Dim strJFID As String = ""
                Dim strNumber As String = ""
                SplitFormatedNumber(txtSearch.Text, strBranchID, strNumber)
                If ddlCriteria.SelectedValue = "ACCNOX" Then
                    Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND ACCOUNT.BRANCHID=" & strBranchID & " AND ACCOUNT.ACCOUNTNO=" & strNumber
                End If
            ElseIf InStr(UCase(ddlCriteria.SelectedValue), "TXN.REFNO", CompareMethod.Text) > 0 Or _
                InStr(UCase(ddlCriteria.SelectedValue), "ACCOUNT.ACCOUNTNO", CompareMethod.Text) > 0 Or _
                InStr(UCase(ddlCriteria.SelectedValue), "TXN.TXNID", CompareMethod.Text) > 0 _
            Then
                If IsNumeric(txtSearch.Text) Then
                    Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + "=" + Me.txtSearch.Text
                Else
                    Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + "=0"
                End If
            Else
                Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
            End If
        End If

        If rbTxnDate.Checked Then
            If Len(Trim(txtTxnFrom.Text)) > 0 And Len(Trim(txtTxnTo.Text)) > 0 Then
                Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND (TXN.TXNDATE BETWEEN CONVERT(DATETIME, '" + txtTxnFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtTxnTo.Text + "', 103))"
            Else
                Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND (TXN.TXNDATE BETWEEN CONVERT(DATETIME, '" + txtAppDate.Value + "', 103) AND CONVERT(DATETIME, '" + txtAppDate.Value + "', 103))"
            End If
        End If

        'If rbRevFrom.Checked Then
        '    If Len(Trim(txtRevFrom.Text)) > 0 And Len(Trim(txtRevTo.Text)) > 0 Then
        '        Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND (TXN.REVERSALDATE BETWEEN CONVERT(DATETIME, '" + txtRevFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtRevTo.Text + "', 103))"
        '    Else
        '        Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND (TXN.REVERSALDATE BETWEEN CONVERT(DATETIME, '" + txtAppDate.Value + "', 103) AND CONVERT(DATETIME, '" + txtAppDate.Value + "', 103))"
        '    End If
        'End If

        If Len(Trim(ddlAreaSearch.SelectedValue)) > 0 Then
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND BRANCH.AREAID=" & ddlAreaSearch.SelectedValue
        End If
        If Len(Trim(ddlBranchSearch.SelectedValue)) > 0 Then
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND BRANCH.BRANCHID=" & ddlBranchSearch.SelectedValue
        End If

        'If Len(Trim(ddlRevStatusSearch.SelectedValue)) > 0 Then
        '    Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND TXN.REVERSESTS=" & ddlRevStatusSearch.SelectedValue
        'End If
        If Len(Trim(ddlBookCodeSearch.SelectedValue)) > 0 Then
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND TXN.BCID=" & ddlBookCodeSearch.SelectedValue
        End If

        If Len(Trim(ddlFinanceCategory.SelectedValue)) > 0 Then
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND TXN.FINCATID=" & ddlFinanceCategory.SelectedValue
        End If

        gvData.DataBind()
    End Sub
    Protected Sub gvData_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        If e.CommandName = "Select" Then
            MVTxn.SetActiveView(vEntry)
            lblMessage.Visible = False
            lblMessage.Text = ""
            gvData.SelectedIndex = e.CommandArgument
            '  GetData(gvData.SelectedDataKey("LOCIDTXN"), gvData.SelectedDataKey("TXNID"))
            hidTXNID.Value = gvData.SelectedDataKey("TXNID")
            hidLOCIDTXN.Value = gvData.SelectedDataKey("LOCIDTXN")
            ' ddlBookCode.Enabled = False
            hidAction.Value = "EDIT"
            ' SetValidation()
        End If
    End Sub

    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
        lblMessage.Visible = False
    End Sub

    Protected Sub gvJournal_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvJournal.RowDataBound
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            TotalDebet += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Debet"))
            TotalKredit += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Kredit"))
        ElseIf (e.Row.RowType = DataControlRowType.Footer) Then
            Dim oTextbox As Label
            oTextbox = CType(e.Row.FindControl("txtTotalAmountDebet"), Label)
            If oTextbox IsNot Nothing Then
                'oTextbox.Text = 0.0
                oStrtxtTotalDebet = oTextbox.ClientID
                oTextbox.Text = String.Format("{0:n}", TotalDebet)
                SetObjectValidation(oTextbox, False, "float", "[0-9.,]")
            End If
            oTextbox = CType(e.Row.FindControl("txtTotalAmountKredit"), Label)
            If oTextbox IsNot Nothing Then
                'oTextbox.Text = 0.0
                oStrtxtTotalKredit = oTextbox.ClientID
                oTextbox.Text = String.Format("{0:n}", TotalKredit)
                SetObjectValidation(oTextbox, False, "float", "[0-9.,]")
            End If
        End If
    End Sub
    Protected Sub btnBack_Click(sender As Object, e As System.EventArgs) Handles btnBack.Click
        MVTxn.SetActiveView(vSearch)
        chkAddNew.Checked = False
    End Sub

    Protected Sub btnApprove_Click(sender As Object, e As System.EventArgs) Handles btnApprove.Click
        lblMessage.Visible = False
        Dim objDB As New DBX
        Dim intRetVal As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try
            oSQLParam = objDB.ExecSPReturnParam("TXNApproval", _
                         objDB.MP("@LOCIDTXN", Data.SqlDbType.Int, hidLOCIDTXN.Value), _
                         objDB.MP("@TXNID", Data.SqlDbType.BigInt, hidTXNID.Value), _
                         objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value), _
                         objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 10, Data.ParameterDirection.Output) _
                         )
            intRetVal = oSQLParam("@RETVAL").Value.ToString()
            If intRetVal = -1 Then
                lblMessage.Visible = True
                lblMessage.Text = "JOURNAL TRANSACTION ALREADY APPROVED..!<BR>PLEASE CHECK TRANSACTION IN GENERAL TRANSACTION INQUIRY..!"
            Else

                MVTxn.SetActiveView(vSearch)
                DataSearch()
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR APPROVE GENERAL TRANSACTION..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE:" & ex.Message
        Finally
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnReject_Click(sender As Object, e As System.EventArgs) Handles btnReject.Click
        lblMessage.Visible = False
        Dim objDB As New DBX
        Dim intRetVal As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try
            oSQLParam = objDB.ExecSPReturnParam("TXNReject", _
                         objDB.MP("@LOCIDTXN", Data.SqlDbType.Int, hidLOCIDTXN.Value), _
                         objDB.MP("@TXNID", Data.SqlDbType.BigInt, hidTXNID.Value), _
                         objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value), _
                         objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 12, Data.ParameterDirection.Output) _
                         )
            intRetVal = oSQLParam("@RETVAL").Value.ToString()
            If intRetVal = -1 Then
                lblMessage.Visible = True
                lblMessage.Text = "JOURNAL TRANSACTION ALREADY REJECTED/APPROVED..!<BR>PLEASE CHECK TRANSACTION IN GENERAL TRANSACTION INQUIRY..!"
            Else
                MVTxn.SetActiveView(vSearch)
                DataSearch()
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR APPROVE GENERAL TRANSACTION..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE:" & ex.Message
        Finally
            objDB = Nothing
        End Try
    End Sub
End Class
