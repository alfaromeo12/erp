
Partial Class Txn_AccRefundInput
    Inherits System.Web.UI.Page
    Public Shared strPlanPaid As String = "", strCheckBox As String = ""

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
                    hidIsUserBranch.Value = oSDR("ISUSERBRANCH").ToString()
                   
                End If
                oSDR.Close()
                oSDR = Nothing

                mvAction.SetActiveView(vSearch)
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
                txtPlanPaidDateAcc.Text = txtAppDate.Value
                txtPaidDate.Text = txtAppDate.Value
                If txtAction.Value = "INIT" Then
                    hidDisburseSts.Value = "0"
                    lblStatus.Visible = False
                    ddlStatusSearch.Visible = False
                    pnlINIT.Visible = True
                    pnlApp.Visible = False
                    pnlINQ.Visible = False
                    gvData.Columns(2).Visible = False
                ElseIf txtAction.Value = "APP" Then
                    hidDisburseSts.Value = "1"
                    pnlProcess.Visible = False
                    gvData.Columns(0).Visible = False
                    gvData.Columns(2).Visible = False
                    lblStatus.Visible = False
                    ddlStatusSearch.Visible = False
                    pnlINIT.Visible = False
                    pnlApp.Visible = True
                    pnlINQ.Visible = False
                Else
                    lblStatus.Visible = True
                    ddlStatusSearch.Visible = True
                    hidDisburseSts.Value = "99"
                    pnlProcess.Visible = False
                    gvData.Columns(0).Visible = False
                    pnlINIT.Visible = False
                    pnlApp.Visible = False
                    pnlINQ.Visible = True

                End If

                ''SetObjectValidation(txtSearch, True)
                SetObjectValidation(txtPlanFrom, True, "date", "[0-9/]")
                SetObjectValidation(txtPlanTo, True, "date", "[0-9/]")
                SetObjectValidation(txtBookFrom, True, "date", "[0-9/]")
                SetObjectValidation(txtBookTo, True, "date", "[0-9/]")
                SetObjectValidation(txtTxnFrom, True, "date", "[0-9/]")
                SetObjectValidation(txtTxnTo, True, "date", "[0-9/]")
                SetObjectValidation(txtPlanPaidDate, False, "date", "[0-9/]")
                SetObjectValidation(txtPaidDate, False, "date", "[0-9/]")

                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.LOCID=0 AND ACCOUNT.ACCID=0)"
                pnlProcess.Visible = False

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
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        chkAll.Attributes.Add("onclick", "CheckAll();")
    End Sub


    Private Sub DataSearch()
        If hidIsUserBranch.Value = "1" Then 'jika user cabang, filter berdasarkan cabang yang berhak saja
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.BRANCHID IN (SELECT BRANCHID FROM dbo.f_getAPPUSERBRANCHList(" & txtUID.Value & "))"
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.FINCATID IN (SELECT FINCATID FROM dbo.f_getAPPUSERFINCATList(" & txtUID.Value & "))"
        End If
        If txtAction.Value = "INIT" Then
            lblStatus.Visible = False
            ddlStatusSearch.Visible = False
            'Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND EXISTS (SELECT 'X' FROM REFUNDTRX WHERE REFUNDTRX.LOCID=ACCOUNT.LOCID AND REFUNDTRX.ACCID=ACCOUNT.ACCID AND REFUNDTRX.DELETESTS=0 AND REFUNDTRX.INCLUDEDISBURSE=0 AND REFUNDTRX.REFUNDSTS=0) "
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND REFUNDTRX.REFUNDSTS=0 "
        ElseIf txtAction.Value = "APP" Then
            lblStatus.Visible = False
            ddlStatusSearch.Visible = False
            'Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND EXISTS (SELECT 'X' FROM REFUNDTRX WHERE REFUNDTRX.LOCID=ACCOUNT.LOCID AND REFUNDTRX.ACCID=ACCOUNT.ACCID AND REFUNDTRX.DELETESTS=0 AND REFUNDTRX.INCLUDEDISBURSE=0 AND REFUNDTRX.REFUNDSTS=1) "
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND REFUNDTRX.REFUNDSTS=1 "
        Else
            lblStatus.Visible = True
            ddlStatusSearch.Visible = True
            'Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND EXISTS (SELECT 'X' FROM REFUNDTRX WHERE REFUNDTRX.LOCID=ACCOUNT.LOCID AND REFUNDTRX.ACCID=ACCOUNT.ACCID AND REFUNDTRX.DELETESTS=0 AND REFUNDTRX.INCLUDEDISBURSE=0) "
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
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (REFUNDTRX.PLANPAIDDATE BETWEEN CONVERT(DATETIME, '" + txtPlanFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtPlanTo.Text + "', 103))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (REFUNDTRX.PLANPAIDDATE BETWEEN CONVERT(DATETIME, '" + txtAppDate.Value + "', 103) AND CONVERT(DATETIME, '" + txtAppDate.Value + "', 103))"
            End If
        End If

        If rbTxnDate.Checked Then
            If Len(Trim(txtPlanFrom.Text)) > 0 And Len(Trim(txtPlanTo.Text)) > 0 Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (REFUNDTRX.PAIDTXNDATE BETWEEN CONVERT(DATETIME, '" + txtPlanFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtPlanTo.Text + "', 103))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (REFUNDTRX.PAIDTXNDATE BETWEEN CONVERT(DATETIME, '" + txtAppDate.Value + "', 103) AND CONVERT(DATETIME, '" + txtAppDate.Value + "', 103))"
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
            Else
                pnlProcess.Visible = False
            End If
        Else
            pnlProcess.Visible = False
        End If
    End Sub

    Protected Sub gvData_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvData.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If DataBinder.Eval(e.Row.DataItem, "REFUNDSTS") = 0 Then
                'e.Row.ForeColor = Drawing.Color.Green
                e.Row.Font.Bold = True
                e.Row.Font.Underline = True
            ElseIf DataBinder.Eval(e.Row.DataItem, "REFUNDSTS") = 1 Then
                e.Row.Font.Italic = True
            ElseIf DataBinder.Eval(e.Row.DataItem, "REFUNDSTS") = 2 Then
                e.Row.Font.Bold = True
            ElseIf DataBinder.Eval(e.Row.DataItem, "REFUNDSTS") = 9 Then
                e.Row.ForeColor = Drawing.Color.Red
            End If

            Dim oCheckBox As CheckBox
            oCheckBox = CType(e.Row.FindControl("chkBox"), CheckBox)
            If oCheckBox IsNot Nothing Then
                strCheckBox = strCheckBox & oCheckBox.ClientID & ","
                oCheckBox.Attributes.Add("onclick", "SelectRow(this);")
            End If


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
        Dim strLOCID As String, strACCID As String, strREFUNDTRXID As String
        Dim objDB As New DBX
        Try

            For Each gvr As GridViewRow In gvData.Rows
                oCheckBox = CType(gvr.FindControl("chkBox"), CheckBox)
                If oCheckBox IsNot Nothing Then
                    If oCheckBox.Checked Then
                        strLOCID = gvData.DataKeys(gvr.RowIndex).Values(0).ToString()
                        strACCID = gvData.DataKeys(gvr.RowIndex).Values(1).ToString()
                        strREFUNDTRXID = gvData.DataKeys(gvr.RowIndex).Values(2).ToString()
                        Dim intRetVal As Integer = 0
                        intRetVal = objDB.ExecSPReturnInteger("REFUNDTRXPlanPaid", _
                            objDB.MP("@REFUNDTRXID", Data.SqlDbType.Int, strREFUNDTRXID), _
                            objDB.MP("@LOCID", Data.SqlDbType.Int, strLOCID), _
                            objDB.MP("@ACCID", Data.SqlDbType.BigInt, strACCID), _
                            objDB.MP("@PLANPAIDDATE", Data.SqlDbType.DateTime, ConvertDate(txtPlanPaidDateAcc.Text)), _
                            objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value) _
                            )
                        If intRetVal = -1 Then
                            btnSave.Visible = False
                            lblMessage.Text = "ACCOUNT ALREADY APPROVED OR REJECTED..!<BR>PLEASE CHECK THIS ACCOUNT IN REFUND INQUIRY...!"
                            btnSave.Visible = False
                            lblMessage.Focus()
                        ElseIf intRetVal = 0 Then
                            ddlDealer.DataBind()
                            DataSearch()
                            mvAction.SetActiveView(vSearch)
                            ClearValue()
                        End If
                    End If

                End If
            Next
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE REFUND PLAN PLAID...!<BR>PLEASE CHECK DETAIL ERROR MESSAGE : <BR>" & ex.Message
            lblMessage.Focus()
        Finally
            objDB.Close()
            objDB = Nothing
        End Try


    End Sub

    Protected Sub gvData_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        If e.CommandName = "Select" Then
            lblMessage.Visible = False
            mvAction.SetActiveView(vAction)
            gvData.SelectedIndex = e.CommandArgument
            If txtAction.Value = "INIT" Then
                sdsRefund.SelectParameters("LOCID").DefaultValue = gvData.SelectedDataKey("LOCID")
                sdsRefund.SelectParameters("ACCID").DefaultValue = gvData.SelectedDataKey("ACCID")
                sdsRefund.SelectParameters("REFUNDTRXID").DefaultValue = gvData.SelectedDataKey("REFUNDTRXID")
            ElseIf txtAction.Value = "APP" Then
                sdsRefundApp.SelectParameters("LOCID").DefaultValue = gvData.SelectedDataKey("LOCID")
                sdsRefundApp.SelectParameters("ACCID").DefaultValue = gvData.SelectedDataKey("ACCID")
                sdsRefundApp.SelectParameters("REFUNDTRXID").DefaultValue = gvData.SelectedDataKey("REFUNDTRXID")
                Dim objDB As New DBX
                Try
                    Dim oSDR As System.Data.SqlClient.SqlDataReader
                    oSDR = objDB.CreateSDRFromSQLSelect("SELECT FINCATID FROM ACCOUNT WITH(NOLOCK) WHERE LOCID=" & gvData.SelectedDataKey("LOCID") & " AND ACCID=" & gvData.SelectedDataKey("ACCID"))
                    If oSDR.Read() Then
                        ajaxCCDBankAcc.ContextKey = Request.Cookies("UID").Value & "," & oSDR("FINCATID").ToString()
                    End If
                    oSDR.Close()
                    oSDR = Nothing
                    'Catch ex As Exception
                Finally
                    objDB.Close()
                    objDB = Nothing
                End Try
            ElseIf txtAction.Value = "INQ" Then
                sdsRefundInq.SelectParameters("LOCID").DefaultValue = gvData.SelectedDataKey("LOCID")
                sdsRefundInq.SelectParameters("ACCID").DefaultValue = gvData.SelectedDataKey("ACCID")
                sdsRefundInq.SelectParameters("REFUNDTRXID").DefaultValue = gvData.SelectedDataKey("REFUNDTRXID")
            End If
            hidLOCID.Value = gvData.SelectedDataKey("LOCID")
            hidACCID.Value = gvData.SelectedDataKey("ACCID")
            hidDEALERID.Value = gvData.SelectedDataKey("DEALERID")

            ctlDataAccountFromParamAccID.LOCID = hidLOCID.Value
            ctlDataAccountFromParamAccID.ACCID = hidACCID.Value
            ctlCollateralDataFromAccID.LOCID = hidLOCID.Value
            ctlCollateralDataFromAccID.ACCID = hidACCID.Value

        End If
    End Sub

    Protected Sub btnBack_Click(sender As Object, e As System.EventArgs) Handles btnBack.Click
        lblMessage.Visible = False
        gvData.SelectedIndex = -1
        ClearValue()
        mvAction.SetActiveView(vSearch)
    End Sub

    Private Sub ClearValue()
        hidLOCID.Value = ""
        hidACCID.Value = ""
        hidDEALERID.Value = ""
    End Sub

    Protected Sub gvRefund_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvRefund.RowDataBound
        Dim oDropDown As DropDownList
        Dim oTextbox As TextBox
        If e.Row.RowType = DataControlRowType.DataRow Then
            'e.Row.DataItem("PERSONID")
            oDropDown = CType(e.Row.FindControl("ddlDealerPersonAccount"), DropDownList)
            If oDropDown IsNot Nothing Then
                If Not e.Row.DataItem("VISIBLE") Then
                    oDropDown.Enabled = False
                End If


                oDropDown.DataSource = GetDSPersonAcount(e.Row.DataItem("PERSONID"))
                oDropDown.DataTextField = "BANKACCNO"
                oDropDown.DataValueField = "PERSONACCOUNTID"

                If Not String.IsNullOrEmpty(e.Row.DataItem("PERSONACCOUNTID").ToString()) Then
                    oDropDown.SelectedValue = e.Row.DataItem("PERSONACCOUNTID")
                End If

                oDropDown.DataBind()
            End If

            oTextbox = CType(e.Row.FindControl("txtAmount"), TextBox)
            If oTextbox IsNot Nothing Then
                SetObjectValidation(oTextbox, False, "float", "[0-9.,]")
            End If

            Dim oCheckBox As CheckBox
            oCheckBox = CType(e.Row.FindControl("chkBox"), CheckBox)
            If oCheckBox IsNot Nothing Then
                oCheckBox.Attributes.Add("onclick", "SelectRow(this);")
                If oCheckBox.Checked And oCheckBox.Enabled Then
                    e.Row.CssClass = "SelectedRowStyle"
                End If
            End If

        End If
    End Sub


    Private Function GetDSPersonAcount(ByVal strPersonID As String) As System.Data.DataTable
        Dim oTable As New System.Data.DataTable
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        oSDR = objDB.CreateSDRFromExecSQL("SELECT DEALERPERSONACCOUNT.PERSONACCOUNTID, '(' + BANK.BANKNAME + ')' + DEALERPERSONACCOUNT.ACCOUNTNO + ' - ' + DEALERPERSONACCOUNT.ACCOUNTNAME AS BANKACCNO FROM DEALERPERSONACCOUNT INNER JOIN BANK ON DEALERPERSONACCOUNT.BANKID = BANK.BANKID WHERE (DEALERPERSONACCOUNT.Deletests = 0) " & _
                                          "AND (DEALERPERSONACCOUNT.PERSONID = " & strPersonID & ") ORDER BY DEALERPERSONACCOUNT.BANKACCSTATUS")
        oTable.Load(oSDR)
        'Catch ex As Exception
        GetDSPersonAcount = oTable
        oSDR.Close()
        oSDR = Nothing
        objDB.Close()
        objDB = Nothing



    End Function

    Protected Sub btnSaveAcc_Click(sender As Object, e As System.EventArgs) Handles btnSaveAcc.Click
        lblMessage.Visible = False
        Dim intRetVal As Integer
        Dim objDB As New DBX
        Dim oTextBox As TextBox
        Dim oDropDown As DropDownList
        Dim dblAmount As Double = 0
        Dim strAccountID As String = ""
        Dim oCheckBox As CheckBox
        Dim oHidden As HiddenField
        Try
            For Each row As GridViewRow In gvRefund.Rows
                strAccountID = ""
                oCheckBox = CType(row.FindControl("chkBox"), CheckBox)
                If oCheckBox IsNot Nothing Then
                    If oCheckBox.Checked Then
                        oHidden = CType(row.FindControl("hidREFUNDSTS"), HiddenField)
                        'Response.Write(oHidden.Value & "<br>")
                        If oHidden.Value = "0" Then
                            oTextBox = CType(row.FindControl("txtAmount"), TextBox)
                            dblAmount = 0
                            If oTextBox IsNot Nothing Then
                                dblAmount = Replace(oTextBox.Text, ",", "")
                            End If
                            'Response.Write(dblAmount.ToString() & "<BR>")
                            'Response.Write(row.DataItem("REFUNDTRXID").ToString() & "<br>")
                            oHidden = CType(row.FindControl("hidREFUNDTRXID"), HiddenField)
                            If oHidden IsNot Nothing Then
                                oDropDown = CType(row.FindControl("ddlDealerPersonAccount"), DropDownList)
                                If oDropDown IsNot Nothing Then
                                    strAccountID = oDropDown.SelectedValue
                                End If
                                intRetVal = objDB.ExecSPReturnInteger("REFUNDTRXPlanPaidWithPersonAccountID", _
                                        objDB.MP("@REFUNDTRXID", Data.SqlDbType.Int, oHidden.Value), _
                                        objDB.MP("@LOCID", Data.SqlDbType.Int, hidLOCID.Value), _
                                        objDB.MP("@ACCID", Data.SqlDbType.BigInt, hidACCID.Value), _
                                        objDB.MP("@PLANPAIDDATE", Data.SqlDbType.DateTime, ConvertDate(txtPlanPaidDateAcc.Text)), _
                                        objDB.MP("@PERSONACCOUNTID", Data.SqlDbType.VarChar, strAccountID), _
                                        objDB.MP("@AMOUNT", Data.SqlDbType.Money, dblAmount), _
                                        objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value) _
                                        )

                            End If


                        End If
                    End If
                End If
            Next
            gvRefund.DataBind()
            DataSearch()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Focus()
            lblMessage.Text = "ERROR SAVE PLAN PAID BY DEALER PERSON..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE:<BR>" & ex.Message
        Finally
            'gvRefund.DataBind()
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub gvRefundApp_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvRefundApp.RowDataBound
        Dim oDropDown As DropDownList
        If e.Row.RowType = DataControlRowType.DataRow Then
            oDropDown = CType(e.Row.FindControl("ddlDealerPersonAccountApp"), DropDownList)
            If oDropDown IsNot Nothing Then
                If Not e.Row.DataItem("VISIBLE") Then
                    oDropDown.Enabled = False
                End If


                oDropDown.DataSource = GetDSPersonAcount(e.Row.DataItem("PERSONID"))
                oDropDown.DataTextField = "BANKACCNO"
                oDropDown.DataValueField = "PERSONACCOUNTID"

                If Not String.IsNullOrEmpty(e.Row.DataItem("PERSONACCOUNTID").ToString()) Then
                    oDropDown.SelectedValue = e.Row.DataItem("PERSONACCOUNTID")
                End If

                oDropDown.DataBind()
            End If
            Dim oCheckBox As CheckBox
            oCheckBox = CType(e.Row.FindControl("chkBoxApp"), CheckBox)
            If oCheckBox IsNot Nothing Then
                oCheckBox.Attributes.Add("onclick", "SelectRow(this);")
                If oCheckBox.Checked And oCheckBox.Enabled Then
                    e.Row.CssClass = "SelectedRowStyle"
                End If
            End If

        End If

    End Sub

    Protected Sub btnApprove_Click(sender As Object, e As System.EventArgs) Handles btnApprove.Click
        lblMessage.Visible = False
        Dim intRetVal As Integer
        Dim objDB As New DBX
        Dim oDropDown As DropDownList
        Dim strAccountID As String = ""
        Dim oCheckBox As CheckBox
        Dim oHidden As HiddenField
        Try
            For Each row As GridViewRow In gvRefundApp.Rows
                strAccountID = ""
                oCheckBox = CType(row.FindControl("chkBoxApp"), CheckBox)
                If oCheckBox IsNot Nothing Then
                    If oCheckBox.Checked Then
                        oHidden = CType(row.FindControl("hidREFUNDSTSApp"), HiddenField)
                        'Response.Write(oHidden.Value & "<br>")
                        If oHidden.Value = "1" Then
                            oHidden = CType(row.FindControl("hidREFUNDTRXIDApp"), HiddenField)
                            If oHidden IsNot Nothing Then
                                oDropDown = CType(row.FindControl("ddlDealerPersonAccountApp"), DropDownList)
                                If oDropDown IsNot Nothing Then
                                    strAccountID = oDropDown.SelectedValue
                                End If
                                intRetVal = objDB.ExecSPReturnInteger("REFUNDTRXApprove", _
                                        objDB.MP("@REFUNDTRXID", Data.SqlDbType.Int, oHidden.Value), _
                                        objDB.MP("@LOCID", Data.SqlDbType.Int, hidLOCID.Value), _
                                        objDB.MP("@ACCID", Data.SqlDbType.BigInt, hidACCID.Value), _
                                        objDB.MP("@PAIDATE", Data.SqlDbType.DateTime, ConvertDate(txtPaidDate.Text)), _
                                        objDB.MP("@PERSONACCOUNTID", Data.SqlDbType.VarChar, strAccountID), _
                                        objDB.MP("@ACCOUNTID", Data.SqlDbType.Int, ddlAccountNo.SelectedValue), _
                                        objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value) _
                                        )
                            End If
                        End If
                    End If
                End If
            Next
            gvRefundApp.DataBind()
            DataSearch()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Focus()
            lblMessage.Text = "ERROR APPROVE DEALER REFUND PERSON..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE:<BR>" & ex.Message
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnReject_Click(sender As Object, e As System.EventArgs) Handles btnReject.Click
        lblMessage.Visible = False
        Dim intRetVal As Integer
        Dim objDB As New DBX
        Dim oCheckBox As CheckBox
        Dim oHidden As HiddenField
        Try
            For Each row As GridViewRow In gvRefundApp.Rows
                oCheckBox = CType(row.FindControl("chkBoxApp"), CheckBox)
                If oCheckBox IsNot Nothing Then
                    If oCheckBox.Checked Then
                        oHidden = CType(row.FindControl("hidREFUNDSTSApp"), HiddenField)
                        If oHidden.Value = "1" Then
                            oHidden = CType(row.FindControl("hidREFUNDTRXIDApp"), HiddenField)
                            If oHidden IsNot Nothing Then
                                intRetVal = objDB.ExecSPReturnInteger("REFUNDTRXReject", _
                                        objDB.MP("@REFUNDTRXID", Data.SqlDbType.Int, oHidden.Value), _
                                        objDB.MP("@LOCID", Data.SqlDbType.Int, hidLOCID.Value), _
                                        objDB.MP("@ACCID", Data.SqlDbType.BigInt, hidACCID.Value), _
                                        objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value) _
                                        )
                            End If
                        End If
                    End If
                End If
            Next
            gvRefundApp.DataBind()
            DataSearch()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Focus()
            lblMessage.Text = "ERROR APPROVE DEALER REFUND PERSON..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE:<BR>" & ex.Message
        Finally
            'gvRefund.DataBind()
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub
End Class
