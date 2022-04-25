Partial Class Account_AccDepositSetOffEntry
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        txtDepositSetOff.Attributes.Add("onblur", "CalcRemain();")
        ddlTxnType.Attributes.Add("onchange", "TxnTypeChange();")
        SetObjectValidation(txtDepositSetOff, False, "float", "[0-9.]")

        If Not IsPostBack() Then
            txtDepositSetOff.Focus()
            txtAction.Value = Request.QueryString("Action")
            Dim strLocID As String = "", strAccID As String = ""
            'ajaxCPELoanData.Collapsed = True
            Dim objDB As New DBX
            Try
                Dim oSDR As Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT LOCID, ACCID, DEPOSIT, FINCATID FROM ACCOUNT WITH(NOLOCK) WHERE LOCID=" & Request.QueryString("LOCID") & " AND ACCID=" & Request.QueryString("ACCID"))
                If oSDR.Read() Then
                    strLocID = oSDR("LOCID")
                    strAccID = oSDR("ACCID")
                    hidLocID.Value = strLocID
                    hidAccID.Value = strAccID
                    ctlDataAccountFromParamAccID.LOCID = strLocID
                    ctlDataAccountFromParamAccID.ACCID = strAccID

                    ctlCollectibilityParamAccID.LOCID = strLocID
                    ctlCollectibilityParamAccID.ACCID = strAccID

                    'sdsInstallment.SelectParameters("LOCID").DefaultValue = strLocID
                    'sdsInstallment.SelectParameters("ACCID").DefaultValue = strAccID
                    ctlInstallmentDataDue.LOCID = strLocID
                    ctlInstallmentDataDue.ACCID = strAccID
                    ctlInstallmentDataDue.TXNDATE = "" 'default app date

                    ajaxCCDBankAcc.ContextKey = Request.Cookies("UID").Value & "," & oSDR("FINCATID").ToString
                    If Not String.IsNullOrEmpty(oSDR("DEPOSIT").ToString()) Then
                        txtDeposit.Text = String.Format("{0:N}", oSDR("DEPOSIT"))
                    Else
                        txtDeposit.Text = "0"
                    End If
                End If
                txtDepositRemain.Text = txtDeposit.Text
                txtDepositSetOff.Text = "0"
                oSDR.Close()
                oSDR = Nothing
            Catch ex As Exception
                lblMessage.Visible = True
                lblMessage.Text = "ERROR LOADING DEPOSIT SET OFF ENTRY: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
                lblMessage.Focus()
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objDB As New DBX
        Try
            Dim lngRetVal As Integer
            lngRetVal = objDB.ExecSPReturnInteger("DEPOSITSETOFFAdd", _
                    objDB.MP("@LOCID", Data.SqlDbType.Int, hidLocID.Value, 10), _
                    objDB.MP("@ACCID", Data.SqlDbType.BigInt, hidAccID.Value, 20), _
                    objDB.MP("@SETOFF", Data.SqlDbType.Money, Replace(txtDepositSetOff.Text, ",", ""), 20), _
                    objDB.MP("@TXNTYPE", Data.SqlDbType.TinyInt, ddlTxnType.SelectedValue, 20), _
                    objDB.MP("@ACCOUNTID", Data.SqlDbType.TinyInt, ddlAccountNo.SelectedValue, 20), _
                    objDB.MP("@REMARK", Data.SqlDbType.VarChar, txtRemark.Text, 100), _
                    objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value, 20) _
                    )
            If lngRetVal = -1 Then
                lblMessage.Visible = True
                lblMessage.Text = "ACCOUNT ALREADY INPUT IN DEPOSIT SET OFF...!<BR>PLEASE CHECK ACCOUNT IN DEPOSIT SET OFF INQUIRY...!"
                lblMessage.Focus()
            ElseIf lngRetVal = -2 Then
                lblMessage.Visible = True
                lblMessage.Text = "ACCOUNT DOES NOT HAVE DEPOSIT...!<BR>PLEASE CHECK ACCOUNT IN ACCOUNT INQUIRY...!"
                lblMessage.Focus()
            ElseIf lngRetVal = -3 Then
                lblMessage.Visible = True
                lblMessage.Text = "SET OFF VALUE BIGGER THAN EXISTING DEPOSIT VALUE...!<BR>PLEASE CHECK SET OFF VALUE OR CHECK ACCOUNT IN ACCOUNT INQUIRY...!"
                lblMessage.Focus()
            ElseIf lngRetVal = -3 Then
                lblMessage.Visible = True
                lblMessage.Text = "PLEASE INPUT NON ZERO VALUE...!<BR>PLEASE CHECK SET OFF VALUE...!"
                lblMessage.Focus()
            ElseIf lngRetVal = 0 Then
                btnSave.Visible = False
                'Response.Write("<script type='text/javascript'>")
                'Response.Write("window.history.back(-2);")
                'Response.Write("</script>")
                lblMessage.Visible = True
                lblMessage.Text = "SAVE ENTRY DEPOSIT SET OFF COMPLETED...!"
                lblMessage.Focus()
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE DEPOSIT SET OFF: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
End Class
