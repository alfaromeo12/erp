
Partial Class Account_ETUploadApp
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
            lblMessage.Visible = True
            lblMessage.Text = "ERROR LOADING EARLY TERMINATION UPLOAD PROCESS: " & ex.Message & "<br>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

        If Not IsPostBack() Then
            txtETFrom.Text = strAppDate
            txtETTo.Text = strAppDate
            txtTxnDate.Text = strAppDate
            hidAction.Value = Request.QueryString("Action")
            'SetObjectValidation(txtSearch, True)
            SetObjectValidation(txtETFrom, True, "date", "[0-9/]")
            SetObjectValidation(txtETTo, True, "date", "[0-9/]")
        End If
        If Len(Trim(ddlTxnType.SelectedValue)) <= 0 Then
            ddlTxnType.SelectedValue = "2"
        End If
        ddlTxnType.Attributes.Add("onchange", "TxnTypeChange();")
        DataSearch()
    End Sub

    Private Sub DataSearch()

        If Not IsPostBack() Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.LOCID=0 AND ACCOUNT.ACCID=0)"
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

        If Len(Trim(txtETFrom.Text)) > 0 And Len(Trim(txtETTo.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ET.ETDATE BETWEEN CONVERT(DATETIME, '" + txtETFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtETTo.Text + "', 103))"
        Else
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ET.ETDATE BETWEEN CONVERT(DATETIME, '" + strAppDate + "', 103) AND CONVERT(DATETIME, '" + strAppDate + "', 103))"
        End If
        'If Len(Trim(ddlJF.SelectedValue)) > 0 Then
        'Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.JFID=" & ddlJF.SelectedValue
        'End If
        If hidAction.Value = "PAY" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ET.ETSTATUS=1"
        End If

        gvData.DataBind()
        If gvData.Rows.Count() <= 0 Then
            pnlProcess.Visible = False
            pnlPayment.Visible = False
        Else
            If hidAction.Value = "PAY" Then
                pnlProcess.Visible = False
                pnlPayment.Visible = True
            Else
                pnlProcess.Visible = True
                pnlPayment.Visible = False
            End If
        End If


    End Sub


    Protected Sub gvData_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvData.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If DataBinder.Eval(e.Row.DataItem, "ETSTATUS") = 9 Then
                e.Row.ForeColor = Drawing.Color.Red
            ElseIf DataBinder.Eval(e.Row.DataItem, "ETSTATUS") = 0 Then
                e.Row.Font.Italic = True
            ElseIf DataBinder.Eval(e.Row.DataItem, "ETSTATUS") = 1 Then
                e.Row.Font.Bold = True
            End If
        End If
    End Sub

    Protected Sub btnApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApprove.Click
        lblMessage.Visible = False
        Dim objDB As New DBX
        Try
            objDB.ExecSP("ETUPLOADApproval", _
              objDB.MP("@ETDATEFROM", Data.SqlDbType.DateTime, ConvertDate(txtETFrom.Text), 20, Data.ParameterDirection.Input), _
              objDB.MP("@ETDATETO", Data.SqlDbType.DateTime, ConvertDate(txtETTo.Text), 20, Data.ParameterDirection.Input), _
              objDB.MP("@ETSTATUS", Data.SqlDbType.Int, 1, 20, Data.ParameterDirection.Input), _
              objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 20, Data.ParameterDirection.Input) _
              )
            lblMessage.Visible = True
            lblMessage.Text = "EARLY TERMINATION APPROVE PROCESS COMPLETED..!"
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR EARLY TERMINATION APPROVE: " & ex.Message & "<br>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        DataSearch()
    End Sub

    Protected Sub btnReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReject.Click
        lblMessage.Visible = False
        Dim objDB As New DBX
        Try
            objDB.ExecSP("ETUPLOADApproval", _
              objDB.MP("@ETDATEFROM", Data.SqlDbType.DateTime, ConvertDate(txtETFrom.Text), 20, Data.ParameterDirection.Input), _
              objDB.MP("@ETDATETO", Data.SqlDbType.DateTime, ConvertDate(txtETTo.Text), 20, Data.ParameterDirection.Input), _
              objDB.MP("@ETSTATUS", Data.SqlDbType.Int, 9, 20, Data.ParameterDirection.Input), _
              objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 20, Data.ParameterDirection.Input) _
              )
            lblMessage.Visible = True
            lblMessage.Text = "EARLY TERMINATION REJECT PROCESS COMPLETED..!"
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR EARLY TERMINATION REJECT: " & ex.Message & "<br>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        DataSearch()
    End Sub

    Protected Sub btnProcess_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcess.Click
        lblMessage.Visible = False
        Dim objDB As New DBX
        Try

            objDB.ExecSP("ETUPLOADPayment", _
              objDB.MP("@TXNTYPE", Data.SqlDbType.Int, ddlTxnType.SelectedValue, 20, Data.ParameterDirection.Input), _
              objDB.MP("@ACCOUNTID", Data.SqlDbType.Int, ddlAccountNo.SelectedValue, 20, Data.ParameterDirection.Input), _
              objDB.MP("@ETDATEFROM", Data.SqlDbType.DateTime, ConvertDate(txtETFrom.Text), 20, Data.ParameterDirection.Input), _
              objDB.MP("@ETDATETO", Data.SqlDbType.DateTime, ConvertDate(txtETTo.Text), 20, Data.ParameterDirection.Input), _
              objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 20, Data.ParameterDirection.Input) _
              )
            lblMessage.Visible = True
            lblMessage.Text = "EARLY TERMINATION PAYMENT PROCESS COMPLETED...!"
            DataSearch()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR EARLY TERMINATION PAYMENT : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        DataSearch()
    End Sub

    Protected Sub btnRejectPay_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRejectPay.Click
        lblMessage.Visible = False
        Dim objDB As New DBX
        Try
            objDB.ExecSP("ETUPLOADRejectAfterApp", _
              objDB.MP("@ETDATEFROM", Data.SqlDbType.DateTime, ConvertDate(txtETFrom.Text), 20, Data.ParameterDirection.Input), _
              objDB.MP("@ETDATETO", Data.SqlDbType.DateTime, ConvertDate(txtETTo.Text), 20, Data.ParameterDirection.Input), _
              objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 20, Data.ParameterDirection.Input) _
              )
            lblMessage.Visible = True
            lblMessage.Text = "EARLY TERMINATION REJECT PROCESS COMPLETED...!"
            DataSearch()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR EARLY TERMINATION REJECT AFTER APPROVAL: " & ex.Message & "<br>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        DataSearch()
    End Sub

    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        lblMessage.Visible = False
        DataSearch()
    End Sub
End Class
