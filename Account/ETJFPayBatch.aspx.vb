
Partial Class ETJF_PayBatch
    Inherits System.Web.UI.Page
    Public Shared strAppDate As String

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE FROM APPSETTING WHERE APPCODE='APPDATE'")
            If oSDR.Read Then
                strAppDate = oSDR("APPVALUE").ToString()
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

        If Not IsPostBack() Then
            txtAction.Value = Request.QueryString("Action")
            rbETAll.Checked = True
            rbBookAll.Checked = True
            txtETFrom.Text = strAppDate
            txtETTo.Text = strAppDate
            txtBookFrom.Text = strAppDate
            txtBookTo.Text = strAppDate

            'SetObjectValidation(txtSearch, True)
            SetObjectValidation(txtETFrom, True, "date", "[0-9/]")
            SetObjectValidation(txtETTo, True, "date", "[0-9/]")
            SetObjectValidation(txtBookFrom, True, "date", "[0-9/]")
            SetObjectValidation(txtBookTo, True, "date", "[0-9/]")
            'If Request.QueryString("ACTION") = "INQ" Then
            '    lblETStatus.Visible = True
            '    ddlETStatusSearch.Visible = True
            '    gvData.Columns(1).Visible = True
            '    gvData.Columns(2).Visible = True
            'Else
            '    gvData.Columns(1).Visible = False
            '    gvData.Columns(2).Visible = False
            'End If
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.LOCID=0 AND ACCOUNT.ACCID=0)"
            DataSearch()

        End If

    End Sub


    Private Sub DataSearch()

        Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ETJF.JFETSTATUS=1"
        Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNTJF.JFACCSTATUS=1"

        If Len(Trim(txtSearch.Text)) > 0 Then
            If ddlCriteria.SelectedValue = "ACCNOX" Or ddlCriteria.SelectedValue = "CUSTNOX" Then
                Dim strBranchID As String = ""
                Dim strCompID As String = ""
                Dim strNumber As String = ""
                SplitFormatedNumber(txtSearch.Text, strBranchID, strNumber)
                If ddlCriteria.SelectedValue = "ACCNOX" Then
                    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.BRANCHID=" & strBranchID & " AND ACCOUNT.ACCOUNTNO=" & strNumber
                ElseIf ddlCriteria.SelectedValue = "CUSTNOX" Then
                    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND CUSTOMER.BRANCHID=" & strBranchID & " AND CUSTOMER.CUSTNO=" & strNumber
                End If
            ElseIf InStr(UCase(ddlCriteria.SelectedValue), "CUSTID", CompareMethod.Text) > 0 Or _
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
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ETJF.JFETTXNDATE BETWEEN CONVERT(DATETIME, '" + txtETFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtETTo.Text + "', 103))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ETJF.JFETTXNDATE BETWEEN CONVERT(DATETIME, '" + strAppDate + "', 103) AND CONVERT(DATETIME, '" + strAppDate + "', 103))"
            End If
        End If

        If rbBookFrom.Checked Then
            If Len(Trim(txtBookFrom.Text)) > 0 And Len(Trim(txtBookTo.Text)) > 0 Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNTJF.JFBOOKINGDATE BETWEEN CONVERT(DATETIME, '" + txtBookFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtBookTo.Text + "', 103))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNTJF.JFBOOKINGDATE BETWEEN CONVERT(DATETIME, '" + strAppDate + "', 103) AND CONVERT(DATETIME, '" + strAppDate + "', 103))"
            End If
        End If


        If Len(Trim(ddlAreaSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCH.AREAID=" & ddlAreaSearch.SelectedValue
        End If
        If Len(Trim(ddlBranchSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCH.BRANCHID=" & ddlBranchSearch.SelectedValue
        End If

        'If Len(Trim(ddlETStatusSearch.SelectedValue)) > 0 Then
        '    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ETJF.JFETSTATUS=" & ddlETStatusSearch.SelectedValue
        'End If

        If Len(Trim(ddlJFGroup.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND JFGROUP.JFGROUPID=" & ddlJFGroup.SelectedValue
        End If

        If Len(Trim(ddlJF.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND JF.JFID=" & ddlJF.SelectedValue
        End If

        If Len(Trim(ddlFinanceCategory.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.FINCATID=" & ddlFinanceCategory.SelectedValue
        End If

        Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " ORDER BY ETJF.JFETTXNDATE DESC"

        gvData.DataBind()
        If gvData.Rows.Count() > 0 Then
            pnlPayment.Visible = True
        Else
            pnlPayment.Visible = False
        End If
    End Sub


    'Protected Sub gvData_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvData.RowDataBound
    '    If e.Row.RowType = DataControlRowType.DataRow Then
    '        If DataBinder.Eval(e.Row.DataItem, "JFETSTATUS") = 9 Then
    '            e.Row.ForeColor = Drawing.Color.Red
    '        ElseIf DataBinder.Eval(e.Row.DataItem, "JFETSTATUS") = 1 Then
    '            e.Row.ForeColor = Drawing.Color.Blue
    '        ElseIf DataBinder.Eval(e.Row.DataItem, "JFETSTATUS") = 2 Then
    '            e.Row.Font.Bold = True
    '        End If
    '    End If
    'End Sub

    Protected Sub btnProcess_Click(sender As Object, e As System.EventArgs) Handles btnProcess.Click
        lblMessage.Visible = False
        lblMessage.Text = ""
        Dim oCheckBox As CheckBox
        'Dim objDB As New DBX
        Dim objPay As New Payment
        Dim strACCIDJF As String = ""
        Dim strJFETID As String = ""
        Try
            For Each row As GridViewRow In gvData.Rows
                oCheckBox = CType(row.FindControl("chkPay"), CheckBox)
                If oCheckBox IsNot Nothing Then
                    If oCheckBox.Checked Then
                        Dim intRetVal As Integer = 0
                        strACCIDJF = gvData.DataKeys(row.RowIndex).Values("ACCIDJF").ToString()
                        strJFETID = gvData.DataKeys(row.RowIndex).Values("JFETID").ToString()

                        intRetVal = objPay.ETJFPayment(strACCIDJF, strJFETID, _
                            ddlAccountNo.SelectedValue, Request.Cookies("UID").Value)
                        If intRetVal = -1 Then
                            lblMessage.Focus()
                            lblMessage.Visible = True
                            lblMessage.Text = "ET JF (BUYBACK) ACCOUNT ALREADY PAID OR REJECTED "
                            Exit For
                        End If

                    End If
                End If
            Next

            DataSearch()
        Catch ex As Exception
            lblMessage.Focus()
            lblMessage.Visible = True
            lblMessage.Text = "Error Payment Process ET JF from Payment per Batch..!<br>Please Check detail error message : " & ex.Message
        Finally
            objPay = Nothing
            'objDB.Close()
            'objDB = Nothing
        End Try

    End Sub

    Protected Sub btnRejectPay_Click(sender As Object, e As System.EventArgs) Handles btnRejectPay.Click
        lblMessage.Visible = False
        lblMessage.Text = ""
        Dim oCheckBox As CheckBox
        'Dim objDB As New DBX
        Dim objPay As New Payment
        Dim strACCIDJF As String = ""
        Dim strJFETID As String = ""
        Try
            For Each row As GridViewRow In gvData.Rows
                oCheckBox = CType(row.FindControl("chkPay"), CheckBox)
                If oCheckBox IsNot Nothing Then
                    If oCheckBox.Checked Then
                        Dim intRetVal As Integer = 0
                        strACCIDJF = gvData.DataKeys(row.RowIndex).Values("ACCIDJF").ToString()
                        strJFETID = gvData.DataKeys(row.RowIndex).Values("JFETID").ToString()

                        intRetVal = objPay.ETJFRejectAfterApp(strACCIDJF, strJFETID, _
                            Request.Cookies("UID").Value)
                        If intRetVal = -1 Then
                            lblMessage.Focus()
                            lblMessage.Visible = True
                            lblMessage.Text = "ET JF (BUYBACK) ACCOUNT ALREADY REJECTED OR PAID"
                            Exit For
                        End If

                    End If
                End If
            Next

            DataSearch()
        Catch ex As Exception
            lblMessage.Focus()
            lblMessage.Visible = True
            lblMessage.Text = "Error reject ET JF from Payment per Batch..!<br>Please Check detail error message : " & ex.Message
        Finally
            objPay = Nothing
            'objDB.Close()
            'objDB = Nothing
        End Try

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
