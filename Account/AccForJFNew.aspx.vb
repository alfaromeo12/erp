
Partial Class Txn_AccForJFNew
    Inherits System.Web.UI.Page
    Public Shared strAppState As String
    Public Shared strCheckBox As String

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

                txtRequestDate.Text = txtAppDate.Value
                txtAction.Value = Request.QueryString("Action")
                rbReqAll.Checked = True
                rbBookAll.Checked = True
                txtRequestForm.Text = txtAppDate.Value
                txtRequestTo.Text = txtAppDate.Value
                txtBookFrom.Text = txtAppDate.Value
                txtBookTo.Text = txtAppDate.Value
                rbJFRate.Checked = True

                'SetObjectValidation(txtSearch, True)
                SetObjectValidation(txtRequestForm, True, "date", "[0-9/]")
                SetObjectValidation(txtRequestTo, True, "date", "[0-9/]")
                SetObjectValidation(txtBookFrom, True, "date", "[0-9/]")
                SetObjectValidation(txtBookTo, True, "date", "[0-9/]")

                txtTenorFrom.Text = "0"
                txtTenorTo.Text = "0"
                txtPrincipalFrom.Text = "0"
                txtPrincipalTo.Text = "0"
                txtDSR.Text = "0"
                txtAge.Text = "0"
                txtDPMin.Text = "0"

                ddlInstallmentTypeSearch.SelectedValue = "1"
                txtDPMin.CssClass = "disabled"
                rbEarlyExclude.Checked = True

                txtTenorFrom.CssClass = "disabled"
                txtTenorTo.CssClass = "disabled"
                txtPrincipalFrom.CssClass = "disabled"
                txtPrincipalTo.CssClass = "disabled"
                txtDSR.CssClass = "disabled"
                txtAge.CssClass = "disabled"
                txtPageSize.Text = "50"

                DataSearch()
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
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        FormValidation()
    End Sub

    Private Sub FormValidation()
        SetObjectValidation(txtTenorFrom, False, "integer", "[0-9]")
        SetObjectValidation(txtTenorTo, False, "integer", "[0-9]")
        SetObjectValidation(txtPrincipalFrom, False, "float", "[0-9,.]")
        SetObjectValidation(txtPrincipalTo, False, "float", "[0-9,.]")
        SetObjectValidation(txtDSR, False, "float", "[0-9,.]")
        SetObjectValidation(txtAge, False, "integer", "[0-9]")
        SetObjectValidation(txtPageSize, False, "integer", "[0-9]")
        SetObjectValidation(txtTenor, False, "integer", "[0-9]")
        SetObjectValidation(txtInstallmentDay, False, "integer", "[0-9]")
        cbOSTenor.Attributes.Add("onclick", "TenorCheck()")
        cbOSPrincipal.Attributes.Add("onclick", "PrincipalCheck()")
        cbDSR.Attributes.Add("onclick", "fCheck('" & cbDSR.ClientID & "', '" & txtDSR.ClientID & "')")
        cbAge.Attributes.Add("onclick", "fCheck('" & cbAge.ClientID & "', '" & txtAge.ClientID & "')")
        cbDPMin.Attributes.Add("onclick", "fCheck('" & cbDPMin.ClientID & "', '" & txtDPMin.ClientID & "')")
        ddlJF.Attributes.Add("onchange", "getMirrorStatus()")
        chkAll.Attributes.Add("onclick", "CheckAll()")

    End Sub

    Private Sub DataSearch()
        chkAll.Checked = False
        strCheckBox = ""
        If hidIsUserBranch.Value = "1" Then 'jika user cabang, filter berdasarkan cabang yang berhak saja
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCHID IN (SELECT BRANCHID FROM dbo.f_getAPPUSERBRANCHList(" & txtUID.Value & "))"
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND FINCATID IN (SELECT FINCATID FROM dbo.f_getAPPUSERFINCATList(" & txtUID.Value & "))"
        End If

        If Not IsPostBack() Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (LOCID=0 AND ACCID=0)"
        End If

        If Len(Trim(txtSearch.Text)) > 0 Then
            If ddlCriteria.SelectedValue = "ACCNOX" Or ddlCriteria.SelectedValue = "CUSTNOX" Then
                Dim strBranchID As String = ""
                Dim strCompID As String = ""
                Dim strNumber As String = ""
                SplitFormatedNumber(txtSearch.Text, strBranchID, strNumber)
                If ddlCriteria.SelectedValue = "ACCNOX" Then
                    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCHID=" & strBranchID & " AND ACCOUNTNO=" & strNumber
                ElseIf ddlCriteria.SelectedValue = "CUSTNOX" Then
                    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCHID=" & strBranchID & " AND CUSTNO=" & strNumber
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


        If rbReqDate.Checked Then
            If Len(Trim(txtRequestForm.Text)) > 0 And Len(Trim(txtRequestTo.Text)) > 0 Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (REQUESTDATE BETWEEN CONVERT(DATETIME, '" + txtRequestForm.Text + "', 103) AND CONVERT(DATETIME, '" + txtRequestTo.Text + "', 103))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (REQUESTDATE BETWEEN CONVERT(DATETIME, '" + txtAppDate.Value + "', 103) AND CONVERT(DATETIME, '" + txtAppDate.Value + "', 103))"
            End If
        End If

        If rbBookFrom.Checked Then
            If Len(Trim(txtBookFrom.Text)) > 0 And Len(Trim(txtBookTo.Text)) > 0 Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (BOOKINGDATE BETWEEN CONVERT(DATETIME, '" + txtBookFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtBookTo.Text + "', 103))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (BOOKINGDATE BETWEEN CONVERT(DATETIME, '" + txtAppDate.Value + "', 103) AND CONVERT(DATETIME, '" + txtAppDate.Value + "', 103))"
            End If
        End If


        If Len(Trim(ddlAreaSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND AREAID=" & ddlAreaSearch.SelectedValue
        End If
        If Len(Trim(ddlBranchSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCHID=" & ddlBranchSearch.SelectedValue
        End If
        'If Len(Trim(ddlCompGroupSearch.SelectedValue)) > 0 Then
        'Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND COMPGROUPID=" & ddlCompGroupSearch.SelectedValue
        'End If
        'If Len(Trim(ddlCompSearch.SelectedValue)) > 0 Then
        'Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND COMPID=" & ddlCompSearch.SelectedValue
        'End If
        'If Len(Trim(ddlTPSearch.SelectedValue)) > 0 Then
        'Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND TPID=" & ddlTPSearch.SelectedValue
        'End If

        If Len(Trim(ddlLoanTypeSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND LOANTYPE=" & ddlLoanTypeSearch.SelectedValue
        End If

        If Len(Trim(ddlFinanceCategory.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND FINCATID=" & ddlFinanceCategory.SelectedValue
        End If

        'If Len(Trim(ddlLoanPurposeSearch.SelectedValue)) > 0 Then
        'Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND LOANPURPOSE=" & ddlLoanPurposeSearch.SelectedValue
        'End If

        If cbOSTenor.Checked Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (OSTENOR BETWEEN " & txtTenorFrom.Text & " AND " & txtTenorTo.Text & ") "
        End If

        If cbOSPrincipal.Checked Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (OSPRINCIPAL BETWEEN " & Replace(txtPrincipalFrom.Text, ",", "") & " AND " & Replace(txtPrincipalTo.Text, ",", "") & ") "
        End If

        If cbDSR.Checked Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND DSR * 100 <= " & Replace(txtDSR.Text, ",", "")
        End If

        If cbPastDue.Checked Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND NOT EXISTS (SELECT 'X' FROM INSTALLMENT WITH(NOLOCK) WHERE v_AccountForJFNew.LOCID=INSTALLMENT.LOCID AND v_AccountForJFNew.ACCID=INSTALLMENT.ACCID AND PAIDSTS=0 AND DUEDATE<=dbo.f_getAppDate())"
        End If

        If cbAge.Checked Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND DATEDIFF(YEAR, BIRTHDATE, BOOKINGDATE) + TENOR <= " + Replace(txtAge.Text, ",", "")
        End If

        If Len(Trim(ddlInstallmentTypeSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND INSTALLMENTTYPE=" & ddlInstallmentTypeSearch.SelectedValue
        End If

        If Len(Trim(ddlCurrencySearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND CURRENCYID=" & ddlCurrencySearch.SelectedValue
        End If

        If cbDPMin.Checked Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND DPPERCENT>=" & txtDPMin.Text
        End If

        If Len(Trim(ddlProductID.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND EXISTS (SELECT 'X' FROM COLLATERAL WITH(NOLOCK) WHERE v_AccountForJFNew.LOCID=COLLATERAL.LOCID AND v_AccountForJFNew.ACCID=COLLATERAL.ACCID AND COLLATERAL.PRODUCTID=" & ddlProductID.SelectedValue & ")"
        End If

        If Len(Trim(ddlCondition.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND EXISTS (SELECT 'X' FROM COLLATERAL WITH(NOLOCK) WHERE v_AccountForJFNew.LOCID=COLLATERAL.LOCID AND v_AccountForJFNew.ACCID=COLLATERAL.ACCID AND COLLATERAL.CONDITION=" & ddlCondition.SelectedValue & ")"
        End If

        If Len(Trim(ddlPurpose.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND EXISTS (SELECT 'X' FROM COLLATERAL WITH(NOLOCK) WHERE v_AccountForJFNew.LOCID=COLLATERAL.LOCID AND v_AccountForJFNew.ACCID=COLLATERAL.ACCID AND COLLATERAL.PURPOSEID=" & ddlPurpose.SelectedValue & ")"
        End If

        If Len(Trim(ddlBPKBStatus.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND EXISTS (SELECT 'X' FROM COLLATERAL WITH(NOLOCK) WHERE v_AccountForJFNew.LOCID=COLLATERAL.LOCID AND v_AccountForJFNew.ACCID=COLLATERAL.ACCID AND COLLATERAL.BPKBSTATUS=" & ddlBPKBStatus.SelectedValue & ")"
        End If

        If rbEarlyExclude.Checked Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND NOT EXISTS (SELECT 'X' FROM INSTALLMENT WITH(NOLOCK) WHERE v_AccountForJFNew.LOCID=INSTALLMENT.LOCID AND v_AccountForJFNew.ACCID=INSTALLMENT.ACCID AND INSTALLMENT.DUEDATE>dbo.f_getAppDAte() AND (INSTALLMENT.PRINCIPALPAID>0 OR INSTALLMENT.INTERESTPAID>0))"
        End If

        gvData.PageSize = CType(txtPageSize.Text, Integer)
        gvData.DataBind()
        chkAll.Checked = False
        If gvData.Rows.Count() <= 0 Then
            'btnCheckAll.Enabled = False
            chkAll.Visible = False
            btnSave.Enabled = False
        Else
            'btnCheckAll.Enabled = True
            chkAll.Visible = True
            btnSave.Enabled = True
        End If
    End Sub



    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        lblMessage.Visible = False
        DataSearch()
    End Sub

    'Protected Sub btnCheckAll_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCheckAll.Click
    '    lblMessage.Visible = False
    '    Dim oCheckBox As CheckBox
    '    For Each row As GridViewRow In gvData.Rows
    '        oCheckBox = CType(row.FindControl("cbChk"), CheckBox)
    '        If oCheckBox IsNot Nothing Then
    '            oCheckBox.Checked = True
    '            row.CssClass = "SelectedRowStyle"
    '        End If
    '    Next
    'End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objCore As New Core
        Try
            Dim intRetVal As Integer = 0
            Dim strLOCID As String, strACCID As String
            Dim oCheckBox As CheckBox
            Dim oTextBox As HiddenField
            Dim intUseRate As Integer = 1
            For Each row As GridViewRow In gvData.Rows
                oCheckBox = CType(row.FindControl("cbChk"), CheckBox)

                If oCheckBox IsNot Nothing Then
                    If oCheckBox.Checked Then
                        'Response.Write(gvData.DataKeys(row.RowIndex).Values("ACCID") & "<br>")
                        strLOCID = gvData.DataKeys(row.RowIndex).Values("LOCID").ToString()
                        strACCID = gvData.DataKeys(row.RowIndex).Values("ACCID").ToString()
                        oTextBox = CType(row.FindControl("txtAccNo"), HiddenField)
                        If rbCustRate.Checked Then
                            intUseRate = 2
                        Else
                            intUseRate = 1
                        End If

                        intRetVal = objCore.JFREQUESTACCAdd(ConvertDate(txtRequestDate.Text), ddlJF.SelectedValue, _
                             strLOCID, strACCID, txtInstallmentDay.Text, 1, txtTenor.Text, ddlLoanType.SelectedValue, intUseRate, Request.Cookies("UID").Value)
                        If intRetVal = -1 Then
                            lblMessage.Visible = True
                            lblMessage.Text = "ACCOUNT " & oTextBox.Value & " ALREADY IN JF..!"
                            Exit For
                        ElseIf intRetVal = -2 Then
                            lblMessage.Visible = True
                            lblMessage.Text = "ACCOUNT " & oTextBox.Value & "  ALREADY IN REQUEST JF..!"
                            Exit For
                        ElseIf intRetVal = -3 Then
                            lblMessage.Visible = True
                            lblMessage.Text = "ACCOUNT " & oTextBox.Value & " ALREADY CLOSED..!"
                            Exit For
                        ElseIf intRetVal = -4 Then
                            lblMessage.Visible = True
                            lblMessage.Text = "ACCOUNT " & oTextBox.Value & " ALREADY IN THIS REQUEST DATE..!"
                            Exit For
                        ElseIf intRetVal = -6 Then
                            lblMessage.Visible = True
                            lblMessage.Text = "ACCOUNT " & oTextBox.Value & " CANNOT CALCULATE JF INSTALLMENT..!"
                            Exit For
                        ElseIf intRetVal = -7 Then
                            lblMessage.Visible = True
                            lblMessage.Text = "ACCOUNT " & oTextBox.Value & " HAS ZERO TENOR..!"
                            Exit For
                        End If
                    End If
                End If
            Next
            DataSearch()

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE DATA REQUEST JF NEW: " & ex.Message & "<br>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
        Finally
            objCore = Nothing

        End Try
    End Sub

    Protected Sub gvData_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvData.RowDataBound
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            Dim oCheckBox As CheckBox
            oCheckBox = CType(e.Row.FindControl("cbChk"), CheckBox)
            If oCheckBox IsNot Nothing Then
                oCheckBox.Attributes.Add("onclick", "SelectRow(this);")
                strCheckBox = strCheckBox & oCheckBox.ClientID & ","
            End If
        End If
    End Sub

    Protected Sub sdsGrid_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles sdsGrid.Selecting
        e.Command.CommandTimeout = 0
    End Sub

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub
End Class
