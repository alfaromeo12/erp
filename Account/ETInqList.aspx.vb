
Partial Class ET_Inq
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        txtUID.Value = Request.Cookies("UID").Value
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try


            If Not IsPostBack() Then
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE, CAST(dbo.f_IsUserBranch(" & Request.Cookies("UID").Value & ") as VARCHAR(10)) ISUSERBRANCH FROM APPSETTING WITH(NOLOCK)WHERE APPCODE='APPDATE'")
                If oSDR.Read Then
                    txtAppDate.Value = oSDR("APPVALUE").ToString()
                    hidIsUserBranch.Value = oSDR("ISUSERBRANCH").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing

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

        If Not IsPostBack() Then
            hidSPV.Value = Request.QueryString("SPV")
            '  txtFlag.Value = Request.QueryString("Flag")
            If Len(Trim(hidSPV.Value)) <= 0 Then
                hidSPV.Value = "0"
            End If
            txtAction.Value = Request.QueryString("Action")
            rbETAll.Checked = True
            rbBookAll.Checked = True
            txtETFrom.Text = txtAppDate.Value
            txtETTo.Text = txtAppDate.Value
            txtBookFrom.Text = txtAppDate.Value
            txtBookTo.Text = txtAppDate.Value

            'SetObjectValidation(txtSearch, True)
            SetObjectValidation(txtETFrom, True, "date", "[0-9/]")
            SetObjectValidation(txtETTo, True, "date", "[0-9/]")
            SetObjectValidation(txtBookFrom, True, "date", "[0-9/]")
            SetObjectValidation(txtBookTo, True, "date", "[0-9/]")
            If Request.QueryString("ACTION") = "INQ" Then
                lblETStatus.Visible = True
                ddlETStatusSearch.Visible = True
            End If

        End If

        DataSearch()

    End Sub


    Private Sub DataSearch()
        If hidIsUserBranch.Value = "1" Then 'jika user cabang, filter berdasarkan cabang yang berhak saja
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.BRANCHID IN (SELECT BRANCHID FROM dbo.f_getAPPUSERBRANCHList(" & txtUID.Value & "))"
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.FINCATID IN (SELECT FINCATID FROM dbo.f_getAPPUSERFINCATList(" & txtUID.Value & "))"
        End If
        If Not IsPostBack() Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.LOCID=0 AND ACCOUNT.ACCID=0)"
        End If

        If txtAction.Value = "WAIVE" Or txtAction.Value = "WAIVESPV" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ET.ETSTATUS=0"
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.ACCSTATUS=1 AND ACCOUNT.DELETESTS=0"
        ElseIf txtAction.Value = "APP" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ET.ETSTATUS=0 /*AND ET.ENTRYSOURCE=1*/"
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.ACCSTATUS=1 AND ACCOUNT.DELETESTS=0"
        ElseIf txtAction.Value = "PAY" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ET.ETSTATUS=1"
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.ACCSTATUS=1 AND ACCOUNT.DELETESTS=0"
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
            ElseIf ddlCriteria.SelectedValue = "COLLATERAL.BPKBNO" Or ddlCriteria.SelectedValue = "COLLATERAL.POLICENO" Or ddlCriteria.SelectedValue = "COLLATERAL.ENGINENO" Or ddlCriteria.SelectedValue = "COLLATERAL.CHASSISNO" Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND EXISTS (SELECT 'X' FROM COLLATERAL WITH(NOLOCK) " & _
                    " WHERE ACCOUNT.LOCID=COLLATERAL.LOCID AND ACCOUNT.ACCID=COLLATERAL.ACCID AND COLLATERAL.DELETESTS=0 AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'" & ")"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
            End If
        End If


        If rbETFrom.Checked Then
            If Len(Trim(txtETFrom.Text)) > 0 And Len(Trim(txtETTo.Text)) > 0 Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ET.ETTXNDATE BETWEEN CONVERT(DATETIME, '" + txtETFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtETTo.Text + "', 103))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ET.ETTXNDATE BETWEEN CONVERT(DATETIME, '" + txtAppDate.Value + "', 103) AND CONVERT(DATETIME, '" + txtAppDate.Value + "', 103))"
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

        If Len(Trim(ddlFinanceCategory.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.FINCATID=" & ddlFinanceCategory.SelectedValue
        End If
        'If Len(Trim(ddlJFGroupSearch.SelectedValue)) > 0 Then
        'Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND JFGROUP.JFGROUPID=" & ddlJFGroupSearch.SelectedValue
        'End If
        'If Len(Trim(ddlJFSearch.SelectedValue)) > 0 Then
        'Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND JF.JFID=" & ddlJFSearch.SelectedValue
        'End If

        If Len(Trim(ddlETStatusSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ET.ETSTATUS=" & ddlETStatusSearch.SelectedValue
        End If

        If Len(Trim(ddlETCalTypeSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ET.ETCALCTYPE=" & ddlETCalTypeSearch.SelectedValue
        End If

        Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " ORDER BY ET.ETTXNDATE DESC"

        gvData.DataBind()
    End Sub

    Protected Sub gvData_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvData.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If DataBinder.Eval(e.Row.DataItem, "ETSTATUS") = 9 Then
                e.Row.ForeColor = Drawing.Color.Red
            ElseIf DataBinder.Eval(e.Row.DataItem, "ETSTATUS") = 0 Then
                e.Row.ForeColor = Drawing.Color.Blue
            ElseIf DataBinder.Eval(e.Row.DataItem, "ETSTATUS") = 1 Then
                e.Row.Font.Bold = True
            End If
        End If

    End Sub
End Class
