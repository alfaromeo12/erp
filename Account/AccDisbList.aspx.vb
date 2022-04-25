
Partial Class Txn_AccDisburse
    Inherits System.Web.UI.Page
    Public Shared strPlanPaid As String = "", strCheckBox As String = ""
    Public Shared strLOCIDGrid As String = "", strACCIDGrid As String = ""

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Response.Write(Request.Cookies("AppDate").Value)

        txtUID.Value = Request.Cookies("UID").Value
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try


            If Not IsPostBack() Then
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE, CAST(dbo.f_IsUserBranch(" & Request.Cookies("UID").Value & ") as VARCHAR(10)) ISUSERBRANCH FROM APPSETTING WITH(NOLOCK) WHERE APPCODE='APPDATE'")
                If oSDR.Read Then
                    txtAppDate.Value = oSDR("APPVALUE").ToString()
                    txtPaidDate.Text = txtAppDate.Value
                    txtPaidTxnDate.Text = txtAppDate.Value
                    hidIsUserBranch.Value = oSDR("ISUSERBRANCH").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing

                'ddlTxnType.SelectedValue = "2" 'bank
                strLOCIDGrid = ""
                strACCIDGrid = ""
                txtAction.Value = Request.QueryString("Action")
                rbPlanAll.Checked = True
                rbBookAll.Checked = True
                rbTxnAll.Checked = True
                rbReceive.Checked = True
                txtPlanFrom.Text = txtAppDate.Value
                txtPlanTo.Text = txtAppDate.Value
                txtBookFrom.Text = txtAppDate.Value
                txtBookTo.Text = txtAppDate.Value
                txtTxnFrom.Text = txtAppDate.Value
                txtTxnTo.Text = txtAppDate.Value
                txtPlanPaidDate.Text = txtAppDate.Value
                If txtAction.Value = "INIT" Then
                    hidDisburseSts.Value = "0"
                    lblStatus.Visible = False
                    ddlStatusSearch.Visible = False
                    gvData.Columns(2).Visible = False
                ElseIf txtAction.Value = "APP" Then
                    hidDisburseSts.Value = "1"
                    pnlProcess.Visible = False
                    'gvData.Columns(0).Visible = False
                    gvData.Columns(2).Visible = False
                    lblStatus.Visible = False
                    ddlStatusSearch.Visible = False
                    ddlTxnType.Attributes.Add("onchange", "TxnTypeChange();")
                Else
                    lblStatus.Visible = True
                    ddlStatusSearch.Visible = True
                    hidDisburseSts.Value = "99"
                    pnlProcess.Visible = False
                    gvData.Columns(0).Visible = False

                End If

                ''SetObjectValidation(txtSearch, True)
                SetObjectValidation(txtPlanFrom, True, "date", "[0-9/]")
                SetObjectValidation(txtPlanTo, True, "date", "[0-9/]")
                SetObjectValidation(txtBookFrom, True, "date", "[0-9/]")
                SetObjectValidation(txtBookTo, True, "date", "[0-9/]")
                SetObjectValidation(txtTxnFrom, True, "date", "[0-9/]")
                SetObjectValidation(txtTxnTo, True, "date", "[0-9/]")

                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.LOCID=0 AND ACCOUNT.ACCID=0)"
                pnlProcess.Visible = False
                ajaxCDDArea.ContextKey = txtUID.Value
                ajaxCDDBranch.ContextKey = txtUID.Value
                ajaxCCDFincat.ContextKey = txtUID.Value

                ajaxCCDDealer.ContextKey = hidDisburseSts.Value

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
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        chkAll.Attributes.Add("onclick", "CheckAll();")
        ajaxCCDBankAcc.ContextKey = txtUID.Value & "," & ddlFinanceCategory.SelectedValue

    End Sub


    Private Sub DataSearch()
        strLOCIDGrid = ""
        strACCIDGrid = ""

        If hidIsUserBranch.Value = "1" Then 'jika user cabang, filter berdasarkan cabang yang berhak saja
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.BRANCHID IN (SELECT BRANCHID FROM dbo.f_getAPPUSERBRANCHList(" & txtUID.Value & "))"
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.FINCATID IN (SELECT FINCATID FROM dbo.f_getAPPUSERFINCATList(" & txtUID.Value & "))"
        End If
        If txtAction.Value = "INIT" Then
            lblStatus.Visible = False
            ddlStatusSearch.Visible = False
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.DISBURSESTS=0 "
        ElseIf txtAction.Value = "APP" Then
            lblStatus.Visible = False
            ddlStatusSearch.Visible = False
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.DISBURSESTS=1 "
        Else
            lblStatus.Visible = True
            ddlStatusSearch.Visible = True
        End If

        If Len(Trim(txtSearch.Text)) > 0 Then
            If ddlCriteria.SelectedValue = "ACCNOX" Or ddlCriteria.SelectedValue = "CUSTNOX" Then
                Dim strBranchID As String = ""
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
            ElseIf ddlCriteria.SelectedValue = "COLLATERAL.BPKBNO" Or ddlCriteria.SelectedValue = "COLLATERAL.POLICENO" Or ddlCriteria.SelectedValue = "COLLATERAL.ENGINENO" Or ddlCriteria.SelectedValue = "COLLATERAL.CHASSISNO" Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND EXISTS (SELECT 'X' FROM COLLATERAL WITH(NOLOCK) " & _
                    " WHERE ACCOUNT.LOCID=COLLATERAL.LOCID AND ACCOUNT.ACCID=COLLATERAL.ACCID AND COLLATERAL.DELETESTS=0 AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'" & ")"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
            End If
        End If


        If rbPlanDate.Checked Then
            If Len(Trim(txtPlanFrom.Text)) > 0 And Len(Trim(txtPlanTo.Text)) > 0 Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND EXISTS (SELECT 'X' FROM ACCOUNTDISBURSE WHERE ACCOUNT.LOCID=ACCOUNTDISBURSE.LOCID AND ACCOUNT.ACCID=ACCOUNTDISBURSE.ACCID AND ACCOUNTDISBURSE.PLANPAIDDATE BETWEEN CONVERT(DATETIME, '" + txtPlanFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtPlanTo.Text + "', 103))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND EXISTS (SELECT 'X' FROM ACCOUNTDISBURSE WHERE ACCOUNT.LOCID=ACCOUNTDISBURSE.LOCID AND ACCOUNT.ACCID=ACCOUNTDISBURSE.ACCID AND ACCOUNTDISBURSE.PLANPAIDDATE BETWEEN CONVERT(DATETIME, '" + txtAppDate.Value + "', 103) AND CONVERT(DATETIME, '" + txtAppDate.Value + "', 103))"
            End If
        End If

        If rbTxnDate.Checked Then
            If Len(Trim(txtTxnFrom.Text)) > 0 And Len(Trim(txtTxnTo.Text)) > 0 Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND EXISTS (SELECT 'X' FROM ACCOUNTDISBURSE WHERE ACCOUNT.LOCID=ACCOUNTDISBURSE.LOCID AND ACCOUNT.ACCID=ACCOUNTDISBURSE.ACCID AND ACCOUNTDISBURSE.PAIDTXNDATE BETWEEN CONVERT(DATETIME, '" + txtTxnFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtTxnTo.Text + "', 103))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND EXISTS (SELECT 'X' FROM ACCOUNTDISBURSE WHERE ACCOUNT.LOCID=ACCOUNTDISBURSE.LOCID AND ACCOUNT.ACCID=ACCOUNTDISBURSE.ACCID AND ACCOUNTDISBURSE.PAIDTXNDATE BETWEEN CONVERT(DATETIME, '" + txtAppDate.Value + "', 103) AND CONVERT(DATETIME, '" + txtAppDate.Value + "', 103))"
            End If
        End If

        If rbBookFrom.Checked Then
            If Len(Trim(txtBookFrom.Text)) > 0 And Len(Trim(txtBookTo.Text)) > 0 Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.BOOKINGDATE BETWEEN CONVERT(DATETIME, '" + txtBookFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtBookTo.Text + "', 103))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.BOOKINGDATE BETWEEN CONVERT(DATETIME, '" + txtAppDate.Value + "', 103) AND CONVERT(DATETIME, '" + txtAppDate.Value + "', 103))"
            End If
        End If


        If Len(Trim(ddlAreaSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCH.AREAID=" & ddlAreaSearch.SelectedValue
        End If
        If Len(Trim(ddlBranchSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCH.BRANCHID=" & ddlBranchSearch.SelectedValue
        End If
        If Len(Trim(ddlDealer.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND COLLATERAL.DEALERID=" & ddlDealer.SelectedValue
        End If

        If Len(Trim(ddlCondition.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND COLLATERAL.CONDITION=" & ddlCondition.SelectedValue
        End If

        If Len(Trim(ddlStatusSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.DISBURSESTS=" & ddlStatusSearch.SelectedValue
        End If

        If Len(Trim(ddlFinanceCategory.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.FINCATID=" & ddlFinanceCategory.SelectedValue
        End If

        If txtAction.Value = "INIT" Then
            If rbReceive.Checked Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND COLLATERAL.BPKBSTATUS=2"
            End If
        End If

        gvData.DataBind()
        If gvData.Rows.Count > 0 Then

            If txtAction.Value = "INIT" Then
                pnlProcess.Visible = True
                chkAll.Visible = True
            Else
                pnlProcess.Visible = False
            End If

            If txtAction.Value = "APP" Then
                pnlDisbursment.Visible = True
                chkAll.Visible = True
            Else
                pnlDisbursment.Visible = False
            End If
        Else
            pnlProcess.Visible = False
            pnlDisbursment.Visible = False
            chkAll.Visible = False
        End If
        chkAll.Checked = False
    End Sub

    Protected Sub gvData_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvData.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then
            If DataBinder.Eval(e.Row.DataItem, "DISBURSESTS") = 0 Then
                e.Row.ForeColor = Drawing.Color.Red
            ElseIf DataBinder.Eval(e.Row.DataItem, "DISBURSESTS") = 1 Then
                e.Row.Font.Italic = True
                e.Row.ForeColor = Drawing.Color.Blue
            End If

            Dim oCheckBox As CheckBox
            oCheckBox = CType(e.Row.FindControl("chkBox"), CheckBox)
            If oCheckBox IsNot Nothing Then
                strCheckBox = strCheckBox & oCheckBox.ClientID & ","


                If DataBinder.Eval(e.Row.DataItem, "LOCID").ToString() = strLOCIDGrid And DataBinder.Eval(e.Row.DataItem, "ACCID").ToString() = strACCIDGrid Then
                    oCheckBox.Visible = False
                    e.Row.Cells(1).Text = "-"
                End If
                oCheckBox.Attributes.Add("onclick", "SelectRow(this);")
            End If
            strLOCIDGrid = DataBinder.Eval(e.Row.DataItem, "LOCID").ToString()
            strACCIDGrid = DataBinder.Eval(e.Row.DataItem, "ACCID").ToString()
            'If e.Row.RowIndex <> 0 Then
                '    Dim PrevRow As GridViewRow = gvData.Rows(e.Row.RowIndex - 1)
                '    If PrevRow.RowType = DataControlRowType.DataRow Then
                '        Response.Write(PrevRow.)
                '        If DataBinder.Eval(e.Row.DataItem, "LOCID") = DataBinder.Eval(PrevRow.DataItem, "LOCID") _
                '            And DataBinder.Eval(e.Row.DataItem, "ACCID") = DataBinder.Eval(PrevRow.DataItem, "ACCID") Then
                '            Response.Write("AAA<BR>")
                '        End If
                '    End If
                'End If
            End If


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

    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        Dim oCheckBox As CheckBox
        Dim strLOCID As String, strACCID As String
        Dim objCore As New Core
        Try

            For Each gvr As GridViewRow In gvData.Rows
                oCheckBox = CType(gvr.FindControl("chkBox"), CheckBox)
                If oCheckBox IsNot Nothing Then
                    If oCheckBox.Checked Then
                        strLOCID = gvData.DataKeys(gvr.RowIndex).Values(0).ToString()
                        strACCID = gvData.DataKeys(gvr.RowIndex).Values(1).ToString()
                        Dim intRetVal As Integer = 0
                        intRetVal = objCore.ACCOUNTDISBURSEPlanPaid(strLOCID, strACCID, _
                            ConvertDate(txtPlanPaidDate.Text), Request.Cookies("UID").Value)
                        'If intRetVal = -1 Then
                        '    lblMessage.Text = "ACCOUNT ALREADY EXIST IN DISBURSEMENT DATA<BR>PLEASE CHECK THIS ACCOUNT IN DISBURSEMENT INQUIRY...!"
                        '    btnSave.Visible = False
                        '    lblMessage.Focus()
                        'ElseIf intRetVal = 0 Then
                        '    Response.Redirect("AccDisbList.aspx?Action=" & txtAction.Value)
                        'End If
                    End If

                End If
            Next
            DataSearch()
            ddlDealer.DataBind()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE DISBURSEMENT...!<BR>PLEASE CHECK DETAIL ERROR MESSAGE : <BR>" & ex.Message
        Finally
            objCore = Nothing
        End Try


    End Sub

    Protected Sub ddlDealer_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlDealer.SelectedIndexChanged
        DataSearch()
    End Sub

    Protected Sub btnApprove_Click(sender As Object, e As System.EventArgs) Handles btnApprove.Click
        lblMessage.Visible = False
        lblMessage.Text = ""
        Dim oCheckBox As CheckBox
        Dim strLOCID As String, strACCID As String
        Dim objCore As New Core
        Try

            For Each gvr As GridViewRow In gvData.Rows
                oCheckBox = CType(gvr.FindControl("chkBox"), CheckBox)
                If oCheckBox IsNot Nothing Then
                    If oCheckBox.Checked Then
                        strLOCID = gvData.DataKeys(gvr.RowIndex).Values(0).ToString()
                        strACCID = gvData.DataKeys(gvr.RowIndex).Values(1).ToString()
                        Dim intRetVal As Integer = 0
                        intRetVal = objCore.ACCOUNTDISBURSEApprove(strLOCID, strACCID, _
                             ddlTxnType.SelectedValue, ddlAccountNo.SelectedValue, ConvertDate(txtPaidDate.Text), ddlDealerAccount.SelectedValue, Request.Cookies("UID").Value)
                        If intRetVal = -1 Then
                            lblMessage.Visible = True
                            lblMessage.Text = "ACCOUNT DISBURSEMENT ALREADY APPROVED (PAID) OR REJECTED<BR>PLEASE CHECK THIS ACCOUNT IN DISBURSEMENT INQUIRY...!"
                            lblMessage.Focus()
                            Exit For
                        End If
                    End If
                End If
            Next
            DataSearch()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR APPROVE (PAID) DISBURSEMENT...!<BR>PLEASE CHECK DETAIL ERROR MESSAGE : <BR>" & ex.Message
            lblMessage.Focus()
        Finally
            objCore = Nothing
        End Try
    End Sub

    Protected Sub ddlFinanceCategory_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlFinanceCategory.SelectedIndexChanged
        DataSearch()
    End Sub
End Class
