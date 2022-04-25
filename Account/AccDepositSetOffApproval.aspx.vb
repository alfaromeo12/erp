Partial Class Account_AccDepositSetOffApp
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'SetObjectValidation(txtDepositSetOff, False, "float", "[0-9.]")
        'txtDepositSetOff.Attributes.Add("onblur", "CalcRemain();")

        If Not IsPostBack() Then
            txtDepositSetOff.Focus()
            txtAction.Value = Request.QueryString("Action")
            If txtAction.Value = "APP" Then
                btnApprove.Visible = True
                btnReject.Visible = True
            End If
            hidLocID.Value = Request.QueryString("LOCID")
            hidAccID.Value = Request.QueryString("ACCID")

            ctlDataAccountFromParamAccID.LOCID = hidLocID.Value
            ctlDataAccountFromParamAccID.ACCID = hidAccID.Value

            ctlCollectibilityParamAccID.LOCID = hidLocID.Value
            ctlCollectibilityParamAccID.ACCID = hidAccID.Value

            ctlInstallmentDataDue.LOCID = hidLocID.Value
            ctlInstallmentDataDue.ACCID = hidAccID.Value
            ctlInstallmentDataDue.TXNDATE = "" 'app date

            hidDepID.Value = Request.QueryString("DEPID")
        End If
        'ajaxCPELoanData.Collapsed = True
        Dim objDB As New DBX
        Try

            'sdsInstallment.SelectParameters("LOCID").DefaultValue = hidLocID.Value
            'sdsInstallment.SelectParameters("ACCID").DefaultValue = hidAccID.Value
            Dim oSDRDep As Data.SqlClient.SqlDataReader
            oSDRDep = objDB.CreateSDRFromSQLSelect("SELECT ISNULL(DEPOSIT, 0) DEPOSIT, ISNULL(SETOFF, 0) SETOFF, " & _
                        " TXNDATE, STATUS, dbo.f_getParamGlobalName('WOSTATUS', STATUS) STATUSNAME, REMARK, " & _
                        " TXNTYPE,  dbo.f_getParamGlobalName('TXNTYPE', TXNTYPE) TXNTYPENAME, BANKACCOUNT.ACCOUNTNO, BANK.BANKNAME" & _
                        " FROM DEPOSITSETOFF WITH(NOLOCK) LEFT JOIN  BANKACCOUNT " & _
                        " ON  DEPOSITSETOFF.ACCOUNTID=BANKACCOUNT.ACCOUNTID " & _
                        "  LEFT JOIN BANK ON BANKACCOUNT.BANKID=BANK.BANKID WHERE LOCID=" & hidLocID.Value & " AND ACCID=" & hidAccID.Value & " AND DEPID=" & hidDepID.Value)

            If oSDRDep.Read() Then
                txtDeposit.Text = String.Format("{0:N}", oSDRDep("DEPOSIT"))
                txtDepositSetOff.Text = String.Format("{0:N}", oSDRDep("SETOFF"))
                txtDepositRemain.Text = String.Format("{0:N}", oSDRDep("DEPOSIT") - oSDRDep("SETOFF"))
                lblTxnDate.Text = String.Format("{0:dd/MM/yyyy}", oSDRDep("TXNDATE"))
                lblSetOffStatus.Text = "(" & oSDRDep("STATUS").ToString & ") " & oSDRDep("STATUSNAME")
                lblTxnType.Text = "(" & oSDRDep("TXNTYPE").ToString & ") " & oSDRDep("TXNTYPENAME")
                lblBankAccNo.Text = "(" & oSDRDep("BANKNAME").ToString & ") " & oSDRDep("ACCOUNTNO")
                lblRemark.Text = oSDRDep("REMARK").ToString()
            End If
            oSDRDep.Close()
            oSDRDep = Nothing
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR LOADING DEPOSIT SET OFF APPROVAL: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Protected Sub btnReject_Click(sender As Object, e As System.EventArgs) Handles btnReject.Click
        Dim objDB As New DBX
        Try
            Dim lngRetVal As Integer
            lngRetVal = objDB.ExecSPReturnInteger("DEPOSITSETOFFApproval", _
                    objDB.MP("@LOCID", Data.SqlDbType.Int, hidLocID.Value, 10), _
                    objDB.MP("@ACCID", Data.SqlDbType.BigInt, hidAccID.Value, 20), _
                    objDB.MP("@DEPID", Data.SqlDbType.Int, hidDepID.Value, 10), _
                    objDB.MP("@STATUS", Data.SqlDbType.Int, 9, 10), _
                    objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value, 20) _
                    )
            If lngRetVal = -1 Then
                lblMessage.Visible = True
                lblMessage.Text = "DEPOSIT SET OFF ALREADY APPROVED OR REJECTED....!<BR>PLEASE CHECK ACCOUNT IN DEPOSIT SET OFF INQUIRY...!"
                lblMessage.Focus()
            ElseIf lngRetVal = 0 Then
                btnApprove.Visible = False
                btnReject.Visible = False
                lblMessage.Visible = True
                lblMessage.Text = "DEPOSIT SET OFF REJECTED COMPLETED...!"
                lblSetOffStatus.Text = "(9) REJECTED"
                lblMessage.Focus()
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR DEPOSIT SET OFF REJECT: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub

    Protected Sub btnApprove_Click(sender As Object, e As System.EventArgs) Handles btnApprove.Click
        Dim objDB As New DBX
        Try
            Dim lngRetVal As Integer
            lngRetVal = objDB.ExecSPReturnInteger("DEPOSITSETOFFApproval", _
                    objDB.MP("@LOCID", Data.SqlDbType.Int, hidLocID.Value, 10), _
                    objDB.MP("@ACCID", Data.SqlDbType.BigInt, hidAccID.Value, 20), _
                    objDB.MP("@DEPID", Data.SqlDbType.Int, hidDepID.Value, 10), _
                    objDB.MP("@STATUS", Data.SqlDbType.Int, 1, 10), _
                    objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value, 20) _
                    )
            If lngRetVal = -1 Then
                lblMessage.Visible = True
                lblMessage.Text = "DEPOSIT SET OFF ALREADY APPROVED OR REJECTED....!<BR>PLEASE CHECK ACCOUNT IN DEPOSIT SET OFF INQUIRY...!"
                lblMessage.Focus()
            ElseIf lngRetVal = -2 Then
                lblMessage.Visible = True
                lblMessage.Text = "DEPOSIT ACCOUNT ALREADY CHANGED..!<BR>PLEASE REJECT FIRST THIS DEPOSIT SETOFF...! <BR>CHECK CURRENT ACCOUNT DEPOSIT IN ACCOUNT INQUIRY...!"
                lblMessage.Focus()
            ElseIf lngRetVal = 0 Then
                btnApprove.Visible = False
                btnReject.Visible = False
                lblMessage.Visible = True
                lblMessage.Text = "DEPOSIT SET OFF APPROVED COMPLETED...!"
                lblMessage.Focus()
                lblSetOffStatus.Text = "(1) APPROVED"
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR DEPOSIT SET OFF APPROVE: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub
End Class
