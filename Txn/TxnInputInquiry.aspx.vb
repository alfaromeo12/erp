
Partial Class Txn_TxnInputInquiry
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
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE, CAST(dbo.f_IsUserBranch(" & Request.Cookies("UID").Value & ") as VARCHAR(10)) ISUSERBRANCH FROM APPSETTING WITH(NOLOCK)  WHERE APPCODE='APPDATE'")
                If oSDR.Read Then
                    txtAppDate.Value = oSDR("APPVALUE").ToString()
                    hidIsUserBranch.Value = oSDR("ISUSERBRANCH").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing

                MVTxn.SetActiveView(vSearch)
                rbTxnAll.Checked = True
                rbRevAll.Checked = True
                txtTxnFrom.Text = txtAppDate.Value
                txtTxnTo.Text = txtAppDate.Value

                txtRevFrom.Text = txtAppDate.Value
                txtRevTo.Text = txtAppDate.Value

                SetObjectValidation(txtTxnFrom, True, "date", "[0-9/]")
                SetObjectValidation(txtTxnTo, True, "date", "[0-9/]")

                SetObjectValidation(txtRevFrom, True, "date", "[0-9/]")
                SetObjectValidation(txtRevTo, True, "date", "[0-9/]")

                ReadOnlyAplicationField(vEntry)
                ajaxCDDArea.ContextKey = txtUID.Value
                ajaxCDDBranch.ContextKey = txtUID.Value
                ajaxCCDFincat.ContextKey = txtUID.Value

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

        If rbRevFrom.Checked Then
            If Len(Trim(txtRevFrom.Text)) > 0 And Len(Trim(txtRevTo.Text)) > 0 Then
                Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND (TXN.REVERSALDATE BETWEEN CONVERT(DATETIME, '" + txtRevFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtRevTo.Text + "', 103))"
            Else
                Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND (TXN.REVERSALDATE BETWEEN CONVERT(DATETIME, '" + txtAppDate.Value + "', 103) AND CONVERT(DATETIME, '" + txtAppDate.Value + "', 103))"
            End If
        End If

        If Len(Trim(ddlAreaSearch.SelectedValue)) > 0 Then
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND AREA.AREAID=" & ddlAreaSearch.SelectedValue
        End If
        If Len(Trim(ddlBranchSearch.SelectedValue)) > 0 Then
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND BRANCH.BRANCHID=" & ddlBranchSearch.SelectedValue
        End If

        If Len(Trim(ddlRevStatusSearch.SelectedValue)) > 0 Then
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND TXN.REVERSESTS=" & ddlRevStatusSearch.SelectedValue
        End If
        If Len(Trim(ddlBookCodeSearch.SelectedValue)) > 0 Then
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND TXN.BCID=" & ddlBookCodeSearch.SelectedValue
        End If
        If Len(Trim(ddlStatusSearch.SelectedValue)) > 0 Then
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND TXN.TXNSTATUS=" & ddlStatusSearch.SelectedValue
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
            hidTXNID.Value = gvData.SelectedDataKey("TXNID")
            hidLOCIDTXN.Value = gvData.SelectedDataKey("LOCIDTXN")
            hidRefNo.Value = hidLOCIDTXN.Value + "-" + hidTXNID.Value
            hidBookCode.Value = gvData.SelectedDataKey("BCCODE")
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
                oStrtxtTotalDebet = oTextbox.ClientID
                oTextbox.Text = String.Format("{0:n}", TotalDebet)
                SetObjectValidation(oTextbox, False, "float", "[0-9.,]")
            End If
            oTextbox = CType(e.Row.FindControl("txtTotalAmountKredit"), Label)
            If oTextbox IsNot Nothing Then
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

    Protected Sub gvData_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvData.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If DataBinder.Eval(e.Row.DataItem, "TXNSTATUS") = 0 Then
                e.Row.ForeColor = Drawing.Color.Blue ''UNAPPROVE
            ElseIf DataBinder.Eval(e.Row.DataItem, "TXNSTATUS") = 2 Then
                e.Row.ForeColor = Drawing.Color.Red ''REJECTED
            ElseIf DataBinder.Eval(e.Row.DataItem, "TXNSTATUS") = 3 Then
                e.Row.Font.Italic = True ''REVERSE
            End If
        End If
    End Sub

End Class


