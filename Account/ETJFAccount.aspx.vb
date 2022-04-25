
Partial Class Acc_ETJF
    Inherits System.Web.UI.Page
    Public Shared strAppDate As String

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        txtAccountNo.Focus()
        Dim objDB As New DBX
        Try
            Dim oSDR As Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppSetting('APPDATE') APPDATE")
            If oSDR.Read() Then
                strAppDate = oSDR("APPDATE").ToString()
                txtTxnDate.Text = strAppDate
            End If
            If Not IsPostBack() Then
                txtValueDate.Text = strAppDate
            End If
            oSDR.Close()
            oSDR = Nothing
            SetFormValidation()
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnView_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnView.Click
        Dim strBranchID As String = ""
        Dim strCompID As String = ""
        Dim strNumber As String = ""
        txtRemark.Text = ""
        SplitFormatedNumber(txtAccountNo.Text, strBranchID, strNumber)
        lblMessage.Visible = False

        Dim objDB As New DBX
        Try
            Dim oSDR As Data.SqlClient.SqlDataReader
            Dim strLocID As String = ""
            Dim strAccID As String = ""
            Dim strAccIDJF As String = ""
            Dim intTenorJF As Integer = 0

            oSDR = objDB.CreateSDRFromSQLSelect("SELECT ACCOUNT.LOCID, ACCOUNT.ACCID, ACCOUNTJF.ACCIDJF, ACCOUNTJF.JFTENOR, " & _
                "dbo.f_getETJFOSPrincipal(ACCOUNTJF.ACCIDJF, CONVERT(DATETIME, '" & txtValueDate.Text & "', 103)) OSPRINCIPAL, " & _
                "dbo.f_CalcInterestETJF(ACCOUNTJF.ACCIDJF, CONVERT(DATETIME, '" & txtValueDate.Text & "', 103)) ETINTEREST, " & _
                " dbo.f_CalcPenaltyETJF(ACCOUNTJF.JFID, ACCOUNTJF.JFOSPRINCIPALREAL) ETPENALTY, " & _
                " ISNULL(JF.JFADMTERMINATE, 0) ETADMIN, " & _
                " dbo.f_getETJFOSINTEREST(ACCOUNTJF.ACCIDJF, CONVERT(DATETIME, '" & txtValueDate.Text & "', 103)) OSINTEREST FROM ACCOUNT WITH (NOLOCK) INNER JOIN ACCOUNTJF ON ACCOUNT.LOCID=ACCOUNTJF.LOCID AND ACCOUNT.ACCID=ACCOUNTJF.ACCID INNER JOIN JF WITH(NOLOCK) ON JF.JFID=ACCOUNTJF.JFID " & _
                " WHERE ACCOUNT.BRANCHID=" & strBranchID & " AND ACCOUNT.ACCOUNTNO=" & strNumber & " AND ACCOUNTJF.JFACCSTATUS=1 ")
            If oSDR.Read() Then
                pnlPayment.Visible = True
                lblMessage.Visible = False
                txtValueDate.Focus()
                'txtTxnDate.Text = oSDR("APPDATE").ToString()
                'txtValueDate.Text = oSDR("APPDATE").ToString()
                strLocID = oSDR("LOCID").ToString()
                strAccID = oSDR("ACCID").ToString()
                strAccIDJF = oSDR("ACCIDJF").ToString()
                intTenorJF = oSDR("JFTENOR").ToString()
                txtLocID.Value = strLocID
                txtAccID.Value = strAccID
                txtAccIDJF.Value = strAccIDJF

                txtOSPrincipal.Text = String.Format("{0:N}", oSDR("OSPRINCIPAL"))
                txtOSInterest.Text = String.Format("{0:N}", oSDR("OSINTEREST"))
                txtETInterest.Text = String.Format("{0:N}", oSDR("ETINTEREST"))
                txtETPenalty.Text = String.Format("{0:N}", oSDR("ETPENALTY"))
                txtETAdmin.Text = String.Format("{0:N}", oSDR("ETADMIN"))

                ctlDataAccountFromParamAccID.LOCID = strLocID
                ctlDataAccountFromParamAccID.ACCID = strAccID

                ctlAccountJFbyACCIDJF.ACCIDJF = strAccIDJF
                'sdsAccData.SelectParameters("LOCID").DefaultValue = strLocID
                'sdsAccData.SelectParameters("ACCID").DefaultValue = strAccID

                'sdsJF.SelectParameters("ACCIDJF").DefaultValue = strAccIDJF


                sdsInstallment.SelectParameters("ACCIDJF").DefaultValue = strAccIDJF
                sdsInstallment.SelectParameters("TXNDATE").DefaultValue = ConvertDate(txtValueDate.Text)
                gvInstallment.DataBind()
                Dim oSDRAcc As Data.SqlClient.SqlDataReader



                oSDRAcc = objDB.CreateSDRFromSQLSelect("SELECT JFETID FROM ETJF WITH(NOLOCK) WHERE ETJF.ACCIDJF=" & strAccIDJF & " AND JFETSTATUS IN (0, 1)")
                If oSDRAcc.HasRows Then
                    lblMessage.Visible = True
                    lblMessage.Text = "THERE IS UNAPPROVE OR UNPAID ET JF/BUY BACK FOR THIS ACCOUNT..!<BR>PLEASE CANCEL FIRST THIS ACCOUNT ET JF/BUY BACK TO ENABLE NEW ET JF INPUT..!"
                    oSDRAcc.Close()
                    oSDRAcc = Nothing
                    oSDR.Close()
                    oSDR = Nothing
                    pnlPayment.Visible = False
                    Exit Sub
                Else
                    oSDRAcc.Close()
                    oSDRAcc = Nothing
                End If

                oSDRAcc = objDB.CreateSDRFromSQLSelect("SELECT COUNT(*) TENORDUE FROM INSTALLMENTJF WITH(NOLOCK) WHERE INSTALLMENTJF.ACCIDJF=" & strAccIDJF & " AND JFDUEDATE<=dbo.f_getAppDate()")
                If oSDRAcc.Read() Then
                    If intTenorJF <= oSDRAcc("TENORDUE") Then
                        lblMessage.Visible = True
                        lblMessage.Text = "ALL JF/BANK ACCOUNT INSTALLMENT HAS DUE..!<BR>PLEASE USE REGULAR JF PAYMENT..!"
                        oSDRAcc.Close()
                        oSDRAcc = Nothing
                        oSDR.Close()
                        oSDR = Nothing
                        pnlPayment.Visible = False
                        Exit Sub
                    End If
                End If
                oSDRAcc.Close()
                oSDRAcc = Nothing

                oSDRAcc = objDB.CreateSDRFromSQLSelect("SELECT ISNULL(SUM(JFPRINCIPAL-JFPRINCIPALPAID), 0) JFPRINCIPALUNPAID, " & _
                    " ISNULL(SUM(JFINTEREST - JFINTERESTPAID), 0) JFINTERESTUNPAID, " & _
                    " ISNULL(SUM(JFPENALTY), 0) JFPENALTY FROM dbo.f_AccInstalmentJFDueList(" & txtAccIDJF.Value & ", Convert(datetime, '" & txtValueDate.Text & "', 103)) WHERE (JFDueDate <= dbo.f_getAppDate())")
                If oSDRAcc.Read() Then
                    txtPrincipalDue.Text = String.Format("{0:N}", oSDRAcc("JFPRINCIPALUNPAID"))
                    txtPenaltyDue.Text = String.Format("{0:N}", oSDRAcc("JFPENALTY"))
                    txtInterestDue.Text = String.Format("{0:N}", oSDRAcc("JFINTERESTUNPAID"))
                    txtInstallmentDue.Text = String.Format("{0:N}", oSDRAcc("JFPRINCIPALUNPAID") + oSDRAcc("JFINTERESTUNPAID") + oSDRAcc("JFPENALTY"))
                Else
                    txtPrincipalDue.Text = 0
                    txtPenaltyDue.Text = 0
                    txtInterestDue.Text = 0
                    txtInstallmentDue.Text = 0
                End If
                txtOtherFee.Text = "0"
                oSDRAcc.Close()
                oSDRAcc = Nothing
                If Len(Trim(txtOSPrincipal.Text)) <= 0 Then
                    txtOSPrincipal.Text = "0"
                End If

                If Len(Trim(txtETInterest.Text)) <= 0 Then
                    txtETInterest.Text = "0"
                End If
                If Len(Trim(txtETAdmin.Text)) <= 0 Then
                    txtETAdmin.Text = "0"
                End If
                If Len(Trim(txtETPenalty.Text)) <= 0 Then
                    txtETPenalty.Text = "0"
                End If
                txtETAmountOri.Value = String.Format("{0:N}", CType(txtInstallmentDue.Text, Double) + CType(txtOSPrincipal.Text, Double) + CType(txtETInterest.Text, Double) + CType(txtETPenalty.Text, Double) + CType(txtETAdmin.Text, Double))
                txtETAmount.Text = String.Format("{0:N}", CType(txtInstallmentDue.Text, Double) + CType(txtOSPrincipal.Text, Double) + CType(txtETInterest.Text, Double) + CType(txtETPenalty.Text, Double) + CType(txtETAdmin.Text, Double))
                btnProcess.Focus()
                txtRemark.Focus()
            Else
                pnlPayment.Visible = False
                lblMessage.Visible = True
                lblMessage.Text = "ACCOUNT NO. " & txtAccountNo.Text & " NOT FOUND...!"
            End If
                oSDR.Close()
                oSDR = Nothing

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR ET JF ACCOUNT LOADING : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            'Throw
        Finally
            objDB.Close()
            objDB = Nothing

        End Try


    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        pnlPayment.Visible = False
        lblMessage.Visible = False
        txtAccountNo.Focus()
    End Sub

    Private Sub SetFormValidation()
        SetObjectValidation(txtETAmount, False, "float", "[0-9.,]")
        SetObjectValidation(txtValueDate, False, "date", "[0-9/]")
        SetObjectValidation(txtOtherFee, False, "float", "[0-9.,]")
        txtValueDate.Attributes.Add("onchange", "ValueDateChange();")
        txtAccountNo.Attributes.Add("onchange", "ValueDateChange();")
        txtOtherFee.Attributes.Add("onblur", "OtherFeeChange();")

        'ddlTxnType.Attributes.Add("onchange", "TxnTypeChange();")

    End Sub

    Protected Sub btnProcess_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcess.Click
        lblMessage.Visible = True
        Dim objPay As New Payment
        Try
            Dim intJFETID As Integer = 0, intRetVal As Integer
            lblMessage.Visible = True
            intRetVal = objPay.ETJFAdd(txtAccIDJF.Value, ConvertDate(txtValueDate.Text), ConvertDate(txtTxnDate.Text), _
                 0, Replace(txtETPenalty.Text, ",", ""), Replace(txtETAdmin.Text, ",", ""), Replace(txtOSPrincipal.Text, ",", ""), Replace(txtOSInterest.Text, ",", ""), _
                 Replace(txtETInterest.Text, ",", ""), Replace(txtOtherFee.Text, ",", ""), "01/01/1900", txtRemark.Text, Request.Cookies("UID").Value, intJFETID)
            If intRetVal = 0 Then
                pnlPayment.Visible = False
                lblMessage.Text = "DATA JF ACCOUNT : " & txtAccountNo.Text & " SAVED...!"
                lblMessage.Focus()
            ElseIf intRetVal = -1 Then

                lblMessage.Text = "DATA JF ACCOUNT : " & txtAccountNo.Text & " ALREADY EXISTS IN ET JF (BUY BACK) DATA...!<br>PLEASE APPROVE OR REJECT FIRST..!"
                btnProcess.Visible = False
                lblMessage.Focus()
                pnlPayment.Visible = False
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE ET JF (BUY BACK) : " & ex.Message
        Finally
            objPay = Nothing
        End Try
    End Sub

End Class
