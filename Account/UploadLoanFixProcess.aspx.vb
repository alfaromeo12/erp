
Partial Class UploadLoanFixProcess
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            hidAPP.Value = Request.QueryString("APP")
            If hidAPP.Value = "1" Then
                btnProcess.Text = "Approve"
                'pnlTxn.Visible = True
            Else
                'pnlTxn.Visible = False
            End If
            'ddlTxnType.Attributes.Add("onchange", "TxnTypeChange();")

            'CheckNumRow()
            DataSearch()
        End If
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        lblMessage.Visible = False
        DataSearch()
    End Sub

    Private Sub DataSearch()
        'gvSummary.DataBind()
        If hidAPP.Value = "0" Then
            Me.sdsLoanFixUpload.SelectCommand = Me.sdsLoanFixUpload.SelectCommand & " AND LOANUPLOADFIX.STATUS=0 "
        ElseIf hidAPP.Value = "1" Then
            Me.sdsLoanFixUpload.SelectCommand = Me.sdsLoanFixUpload.SelectCommand & " AND LOANUPLOADFIX.STATUS=1 "
        End If
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsLoanFixUpload.SelectCommand = Me.sdsLoanFixUpload.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
        End If
        gvLoanFix.DataBind()
        CheckNumRow()

    End Sub

    Private Sub CheckNumRow()
        If gvLoanFix.Rows.Count() <= 0 Then
            btnDelete.Enabled = False
            btnProcess.Enabled = False
            btnPrint.Enabled = False
        Else
            btnDelete.Enabled = True
            btnProcess.Enabled = True
            btnPrint.Enabled = True
        End If

    End Sub
    Protected Sub btnProcess_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcess.Click
        lblMessage.Visible = False
        'Dim objPay As New Payment
        'Try
        '    If hidAPP.Value = "0" Then
        '        objPay.PAYMENTUPLOADApproval(Request.Cookies("UID").Value)
        '        lblMessage.Visible = True
        '        lblMessage.Text = "PAYMENT - UPLOAD PROCESS EXECUTE COMPLETED..!"
        '    Else
        '        objPay.PAYMENTUPLOADProcess(ddlTxnType.SelectedValue, ddlAccountNo.SelectedValue, Request.Cookies("UID").Value)
        '        lblMessage.Visible = True
        '        lblMessage.Text = "PAYMENT - UPLOAD APPROVAL EXECUTE COMPLETED..!"

        '    End If
        'Catch ex As Exception
        '    lblMessage.Visible = True
        '    lblMessage.Text = "ERROR PAYMENT UPLOAD PROCESS/APPROVAL : " & ex.Message & "<br>PLEASE CHECK DETAIL ERROR MESSAGE..!"
        'Finally
        '    objPay = Nothing
        'End Try
        Dim objDBX As New DBX
        Try
            If hidAPP.Value = "0" Then
                objDBX.ExecSQL("UPDATE LOANUPLOADFIX SET STATUS=1 WHERE STATUS=0")
                lblMessage.Visible = True
                lblMessage.Text = "LOAN DATA FIX - UPLOAD HAS BEEN PROCESSES..!"
            Else
                objDBX.ExecSP("LOANFIXProcess", _
                    objDBX.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value))
                lblMessage.Text = "LOAN DATA FIX - UPLOAD HAS BEEN APPROVE..!"
            End If

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR PROCESS LOAN DATA FIX APPROVAL : " & ex.Message & "<br>PLEASE CHECK DETAIL ERROR MESSAGE..!"
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
        DataSearch()
    End Sub

    Protected Sub btnDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        lblMessage.Visible = False
        Dim objDB As New DBX
        Try
            objDB.ExecSQL("TRUNCATE TABLE LOANUPLOADFIX")
            lblMessage.Visible = True
            lblMessage.Text = "LOAN DATA FIX - UPLOAD HAS BEEN DELETED..!"
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR DELETE LOAN DATA FIX DELETE : " & ex.Message & "<br>PLEASE CHECK DETAIL ERROR MESSAGE..!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        DataSearch()
    End Sub


    Protected Sub gvPayment_PageIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvLoanFix.PageIndexChanged
        DataSearch()
    End Sub


End Class
