
Partial Class Account_ETDisplay
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Overloads Overrides Sub OnPreRender(ByVal e As EventArgs)
        MyBase.OnPreRender(e)
        Dim strDisAbleBackButton As String
        strDisAbleBackButton = ""
        ClientScript.RegisterClientScriptBlock(Me.Page.[GetType](), "clientScript", strDisAbleBackButton)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            txtLocID.Value = Request.QueryString("LOCID")
            txtAccID.Value = Request.QueryString("ACCID")
            txtETID.Value = Request.QueryString("ETID")
            txtAction.Value = Request.QueryString("Action")
            txtUID.Value = Request.Cookies("UID").Value

            hidSPV.Value = Request.QueryString("SPV")
            If Len(Trim(hidSPV.Value)) <= 0 Then
                hidSPV.Value = "0"
            End If


            If txtAction.Value = "WAIVESPV" Then
                'txtWaiveInstallmentDue.Visible = True
                'txtWaivePrincipalDue.Visible = True
                'txtWaiveInterestDue.Visible = True
                'txtWaivePenaltyDue.Visible = True
                'txtWaiveOSPrincipal.Visible = True
                'txtWaiveInstDiffDue.Visible = True

                'txtWaiveInstallmentDue.ReadOnly = False
                txtWaivePrincipalDue.ReadOnly = False
                txtWaiveInterestDue.ReadOnly = False
                txtWaivePenaltyDue.ReadOnly = False
                txtWaiveOSPrincipal.ReadOnly = False
                txtWaiveOSInterest.ReadOnly = False
                txtWaiveInstDiffDue.ReadOnly = False


                'txtWaiveInstallmentDue.CssClass = "required"
                txtWaivePrincipalDue.CssClass = "required"
                txtWaiveInterestDue.CssClass = "required"
                txtWaivePenaltyDue.CssClass = "required"
                txtWaiveOSPrincipal.CssClass = "required"
                txtWaiveOSInterest.CssClass = "required"
                txtWaiveInstDiffDue.CssClass = "required"
            Else
                'txtWaiveInstallmentDue.ReadOnly = True
                txtWaivePrincipalDue.ReadOnly = True
                txtWaiveInterestDue.ReadOnly = True
                txtWaivePenaltyDue.ReadOnly = True
                txtWaiveOSPrincipal.ReadOnly = True
                txtWaiveOSInterest.ReadOnly = True
                txtWaiveInstDiffDue.ReadOnly = True


                'txtWaiveInstallmentDue.CssClass = "disabled"
                txtWaivePrincipalDue.CssClass = "disabled"
                txtWaiveInterestDue.CssClass = "disabled"
                txtWaivePenaltyDue.CssClass = "disabled"
                txtWaiveOSPrincipal.CssClass = "disabled"
                txtWaiveOSInterest.CssClass = "disabled"
                txtWaiveInstDiffDue.CssClass = "disabled"


            End If

            Dim objDB As New DBX
            Try
                Dim oSDR As System.Data.SqlClient.SqlDataReader

                If txtAction.Value = "PAY" Then
                    oSDR = objDB.CreateSDRFromSQLSelect("SELECT " & _
                            " (SELECT COA.COAID FROM COA WITH(NOLOCK) WHERE COA.COAID=APPUSER.COAID AND COA.DELETESTS=0) COAID, USERID, USERNAME FROM APPUSER WITH(NOLOCK) WHERE UID=" & Request.Cookies("UID").Value)
                    If oSDR.Read() Then

                        If String.IsNullOrEmpty(oSDR("COAID").ToString()) Then
                            lblMessage.Visible = True
                            lblMessage.Text = "USER ID : " & oSDR("USERID").ToString() & "-" & oSDR("USERNAME").ToString() & " CANNOT PROCESS THIS TRANSACTION...!<BR>CURRENT USER IS NOT TELLER/CASHIER USER..!"
                            lblMessage.Focus()
                            btnProcess.Visible = False
                            btnRejectPay.Visible = False
                        End If
                    End If
                    oSDR.Close()
                    oSDR = Nothing
                End If

                Dim strDecPointNet As String = ""
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppSetting('APPDATE') APPDATE, ETDATE, ETTXNDATE, ACCOUNT.DEPOSIT, ACCOUNT.FINCATID, " & _
                    "(SELECT MIN(DUEDATE) FROM INSTALLMENT WHERE INSTALLMENT.LOCID=ACCOUNT.LOCID AND INSTALLMENT.ACCID=ACCOUNT.ACCID AND INSTALLMENT.DUEDATE>dbo.f_getAppDate()) NEXTDUEDATECUST, " & _
                    "'(' + CAST(ET.ENTRYSOURCE AS VARCHAR(20)) + ') ' + dbo.f_getParamGlobalName('ENTRYSOURCE', ET.ENTRYSOURCE) ENTRYSOURCENAME," & _
                    "'(' + CAST(ET.ETSTATUS AS VARCHAR(20)) + ') ' + dbo.f_getParamGlobalName('ETSTATUS', ET.ETSTATUS) ETSTATUSNAME," & _
                    "'(' + CAST(ET.ETCALCTYPE AS VARCHAR(20)) + ') ' + dbo.f_getParamGlobalName('ETCALCTYPE', ET.ETCALCTYPE) ETCALCTYPENAME," & _
                    "ACCOUNT.FINCATID FINCATID, dbo.f_getCurrencyDecPointForNet(ACCOUNT.CURRENCYID) DECPOINTNET, " & _
                    " ISNULL(dbo.f_getAppSetting('PAYBACKDATECASH'), '7') BACKCASH, dbo.f_getCurrencyDecPoint(ACCOUNT.CURRENCYID) AS DECPOINT, " & _
                    " ISNULL(dbo.f_getAppSetting('PAYBACKDATEBANK'), '7') BACKBANK, dbo.f_getCurrencyDecPointForNet(ACCOUNT.CURRENCYID) AS DECPOINTNET, " & _
                    " ET.* FROM ET WITH(NOLOCK) INNER JOIN ACCOUNT WITH(NOLOCK) ON ACCOUNT.LOCID=ET.LOCID AND ACCOUNT.ACCID=ET.ACCID WHERE ET.LOCID=" & txtLocID.Value & " AND ET.ACCID=" & txtAccID.Value & " AND ET.ETID=" & txtETID.Value)
                If oSDR.Read() Then
                    hidDecPoint.Value = oSDR("DECPOINT").ToString()
                    hidFincatID.Value = oSDR("FINCATID").ToString()
                    hidBackCash.Value = oSDR("BACKCASH").ToString()
                    hidBackBank.Value = oSDR("BACKBANK").ToString()
                    hidAPPDATE.Value = oSDR("APPDATE").ToString()
                    txtPaidDate.Text = oSDR("APPDATE")
                    strDecPointNet = oSDR("DECPOINTNET")
                    hidETCALC.Value = oSDR("ETCALCTYPE")
                    If hidETCALC.Value = "2" Then
                        lblCalcType2.Visible = True
                    Else
                        lblCalcType1.Visible = True
                    End If

                    ajaxCCDBankAcc.ContextKey = txtUID.Value & "," & oSDR("FINCATID").ToString()
                    lblETDate.Text = String.Format("{0:dd/MM/yyyy}", oSDR("ETDATE"))
                    txtValueDate.Text = lblETDate.Text
                    lblDueUntil.Text = lblETDate.Text
                    lblOSPrincipalUntil.Text = lblETDate.Text
                    lblOSInterestUntil.Text = lblETDate.Text
                    lblETTxnDate.Text = String.Format("{0:dd/MM/yyyy}", oSDR("ETTXNDATE"))
                    'sdsAccData.SelectParameters("LOCID").DefaultValue = txtLocID.Value
                    'sdsAccData.SelectParameters("ACCID").DefaultValue = txtAccID.Value
                    ctlDataAccountFromParamAccID.LOCID = txtLocID.Value
                    ctlDataAccountFromParamAccID.ACCID = txtAccID.Value

                    'sdsLoanData.SelectParameters("LOCID").DefaultValue = txtLocID.Value
                    'sdsLoanData.SelectParameters("ACCID").DefaultValue = txtAccID.Value
                    ctlLoanDataFromParamAccID.LOCID = txtLocID.Value
                    ctlLoanDataFromParamAccID.ACCID = txtAccID.Value

                    sdsInstallment.SelectParameters("LOCID").DefaultValue = txtLocID.Value
                    sdsInstallment.SelectParameters("ACCID").DefaultValue = txtAccID.Value
                    sdsInstallment.SelectParameters("TXNDATE").DefaultValue = oSDR("ETDATE")

                    Dim dblPrincipalOD As Double = 0
                    Dim dblInterestOD As Double = 0
                    Dim dblPenaltyOD As Double = 0
                    Dim dblInstDiffOD As Double = 0


                    Dim oSDRAcc As Data.SqlClient.SqlDataReader
                    oSDRAcc = objDB.CreateSDRFromSQLSelect("SELECT ISNULL(SUM(PRINCIPAL-PRINCIPALPAID-PRINCIPALWAIVE), 0) PRINCIPALUNPAID, " & _
                        " ISNULL(SUM(INTEREST-INTERESTPAID-INTERESTWAIVE), 0) INTERESTUNPAID, " & _
                        " ISNULL(SUM(INSTDIFF-INSTDIFFPAID-INSTDIFFWAIVE), 0) INSTDIFF, " & _
                        " ISNULL(SUM(PENALTY), 0) PENALTY FROM dbo.f_AccInstalmentDueList(" & txtLocID.Value & ", " & txtAccID.Value & ", '" & oSDR("ETDATE").ToString() & "') WHERE (DueDate <= dbo.f_getAppDate())")
                    If oSDRAcc.Read() Then
                        'hidDecPoint.Value = oSDRAcc("DECPOINT").ToString()
                        dblPrincipalOD = oSDRAcc("PRINCIPALUNPAID")
                        dblInterestOD = oSDRAcc("INTERESTUNPAID")
                        dblPenaltyOD = oSDRAcc("PENALTY")
                        dblInstDiffOD = oSDRAcc("INSTDIFF")
                        txtPrincipalDue.Text = String.Format(strDecPointNet, dblPrincipalOD)
                        txtInterestDue.Text = String.Format(strDecPointNet, dblInterestOD)
                        'txtPrincipalDue.Text = String.Format("{0:N}", oSDRAcc("PRINCIPALUNPAID"))
                        txtPenaltyDue.Text = String.Format(strDecPointNet, dblPenaltyOD)
                        txtInstDiffDue.Text = String.Format(strDecPointNet, dblInstDiffOD)
                        txtInstallmentDue.Text = String.Format(strDecPointNet, dblPrincipalOD + dblInterestOD + dblPenaltyOD + dblInstDiffOD)
                    Else
                        txtPrincipalDue.Text = 0
                        txtPenaltyDue.Text = 0
                        txtInterestDue.Text = 0
                        txtInstallmentDue.Text = 0
                        txtInstDiffDue.Text = 0
                    End If
                    oSDRAcc.Close()
                    oSDRAcc = Nothing

                    Dim dblPrincipalPaidEarly As Double = 0
                    Dim dblInterestPaidEarly As Double = 0

                    'JIKA STATUS PAID, REVERSED, REJECT AMBIL DATA DUE DARI TABLE ET JUGA
                    If oSDR("ETSTATUS") = 2 Or oSDR("ETSTATUS") = 3 Or oSDR("ETSTATUS") = 9 Then
                        pnlInstData.Visible = False
                        pnlInstShow.Visible = False
                        'gvInstallment.Visible = False
                        dblPrincipalOD = oSDR("PRINCIPALDUE")
                        dblInterestOD = oSDR("INTERESTDUE")
                        dblPenaltyOD = oSDR("PENALTYDUE")
                        dblInstDiffOD = oSDR("INSTDIFFDUE")
                        txtPrincipalDue.Text = String.Format(strDecPointNet, dblPrincipalOD)
                        txtInterestDue.Text = String.Format(strDecPointNet, dblInterestOD)
                        txtPenaltyDue.Text = String.Format(strDecPointNet, dblPenaltyOD)
                        txtInstDiffDue.Text = String.Format(strDecPointNet, dblInstDiffOD)
                        txtInstallmentDue.Text = String.Format(strDecPointNet, dblPrincipalOD + dblInterestOD + dblPenaltyOD + dblInstDiffOD)
                    Else
                        'cek jika ada pembayaran dipercepat, untuk mengurangi OS Principal dan OS Interest
                        'HANYa untuk status unapprove atau approve
                        oSDRAcc = objDB.CreateSDRFromSQLSelect("SELECT " & _
                            "ISNULL(SUM(PRINCIPALPAID), 0)  PRINCIPALPAID, " & _
                            "ISNULL(SUM(INTERESTPAID), 0)  INTERESTPAID " & _
                            "FROM INSTALLMENT " & _
                            " WHERE INSTALLMENT.LOCID=" & txtLocID.Value & " AND INSTALLMENT.ACCID=" & txtAccID.Value & " AND INSTALLMENT.DUEDATE>CONVERT(DATETIME, '" & txtValueDate.Text & "', 103)")
                        If oSDRAcc.Read() Then
                            dblPrincipalPaidEarly = oSDRAcc("PRINCIPALPAID")
                            dblInterestPaidEarly = oSDRAcc("INTERESTPAID")
                        End If
                        oSDRAcc.Close()
                        oSDRAcc = Nothing

                    End If

                    txtOSPrincipal.Text = String.Format(strDecPointNet, oSDR("OSPRINCIPAL") - dblPrincipalPaidEarly)
                    txtOSInterest.Text = String.Format(strDecPointNet, oSDR("OSINTEREST") - dblInterestPaidEarly)
                    txtETInterest.Text = String.Format(strDecPointNet, oSDR("ETINTEREST"))
                    txtETInterestWaive.Text = String.Format(strDecPointNet, oSDR("ETINTERESTWAIVE"))

                    txtWaiveInstallmentDue.Text = String.Format(strDecPointNet, (dblPrincipalOD + dblInterestOD + dblPenaltyOD + dblInstDiffOD) - (oSDR("PRINCIPALDUEWAIVE") + oSDR("INTERESTDUEWAIVE") + oSDR("PENALTYDUEWAIVE")))
                    txtWaivePrincipalDue.Text = String.Format(strDecPointNet, oSDR("PRINCIPALDUEWAIVE"))
                    txtWaiveInterestDue.Text = String.Format(strDecPointNet, oSDR("INTERESTDUEWAIVE"))
                    txtWaivePenaltyDue.Text = String.Format(strDecPointNet, oSDR("PENALTYDUEWAIVE"))
                    txtWaiveOSPrincipal.Text = String.Format(strDecPointNet, oSDR("OSPRINCIPALWAIVE"))
                    txtWaiveOSInterest.Text = String.Format(strDecPointNet, oSDR("OSINTERESTWAIVE"))
                    txtWaiveInstDiffDue.Text = String.Format(strDecPointNet, oSDR("INSTDIFFDUEWAIVE"))

                    txtETPenalty.Text = String.Format(strDecPointNet, oSDR("ETPENALTY"))
                    txtETPenaltyWaive.Text = String.Format(strDecPointNet, oSDR("ETPENALTYWAIVE"))
                    txtETAdmin.Text = String.Format(strDecPointNet, oSDR("ETADMIN"))
                    txtETAdminWaive.Text = String.Format(strDecPointNet, oSDR("ETADMINWAIVE"))
                    txtOtherFee.Text = String.Format(strDecPointNet, oSDR("ETOTHERFEE"))
                    txtDeposit.Text = String.Format(strDecPointNet, oSDR("DEPOSIT"))

                    'txtETAmount.Text = String.Format("{0:N}", CType(txtInstallmentDue.Text, Double) + CType(txtOSPrincipal.Text, Double) + CType(txtETInterest.Text, Double) + CType(txtETPenalty.Text, Double) + CType(txtETAdmin.Text, Double) + CType(txtOtherFee.Text, Double) - CType(txtDeposit.Text, Double))
                    'txtETAmountWaive.Text = String.Format("{0:N}", CType(txtInstallmentDue.Text, Double) + CType(txtOSPrincipal.Text, Double) + CType(txtETInterest.Text, Double) + CType(txtETPenalty.Text, Double) + CType(txtETAdmin.Text, Double) + CType(txtOtherFee.Text, Double) - CType(txtDeposit.Text, Double) - CType(txtETPenaltyWaive.Text, Double) - CType(txtETAdminWaive.Text, Double) - CType(txtETInterestWaive.Text, Double))
                    If hidETCALC.Value = "2" Then
                        txtETInterestWaive.ReadOnly = True
                        txtETInterestWaive.CssClass = "disabled"
                        txtETAmount.Text = String.Format(strDecPointNet, CType(txtInstallmentDue.Text, Double) + CType(txtOSPrincipal.Text, Double) + CType(txtOSInterest.Text, Double) + CType(txtETPenalty.Text, Double) + CType(txtETAdmin.Text, Double) + CType(txtOtherFee.Text, Double) - CType(txtDeposit.Text, Double))
                        txtETAmountWaive.Text = String.Format(strDecPointNet, CType(txtWaiveInstallmentDue.Text, Double) + CType(txtOSPrincipal.Text, Double) + CType(txtOSInterest.Text, Double) + CType(txtETPenalty.Text, Double) + CType(txtETAdmin.Text, Double) + CType(txtOtherFee.Text, Double) - CType(txtDeposit.Text, Double) - CType(txtETPenaltyWaive.Text, Double) - CType(txtETAdminWaive.Text, Double) - CType(txtWaiveOSInterest.Text, Double) - CType(txtWaiveOSPrincipal.Text, Double) - CType(txtWaiveInstDiffDue.Text, Double))
                    Else
                        txtWaiveOSInterest.ReadOnly = True
                        txtWaiveOSInterest.CssClass = "disabled"
                        txtETAmount.Text = String.Format(strDecPointNet, CType(txtInstallmentDue.Text, Double) + CType(txtOSPrincipal.Text, Double) + CType(txtETInterest.Text, Double) + CType(txtETPenalty.Text, Double) + CType(txtETAdmin.Text, Double) + CType(txtOtherFee.Text, Double) - CType(txtDeposit.Text, Double))
                        txtETAmountWaive.Text = String.Format(strDecPointNet, CType(txtWaiveInstallmentDue.Text, Double) + CType(txtOSPrincipal.Text, Double) + CType(txtETInterest.Text, Double) + CType(txtETPenalty.Text, Double) + CType(txtETAdmin.Text, Double) + CType(txtOtherFee.Text, Double) - CType(txtDeposit.Text, Double) - CType(txtETPenaltyWaive.Text, Double) - CType(txtETAdminWaive.Text, Double) - CType(txtETInterestWaive.Text, Double) - CType(txtWaiveOSPrincipal.Text, Double) - CType(txtWaiveInstDiffDue.Text, Double))
                    End If

                    txtNextDueDateET.Value = String.Format("{0:dd/MM/yyyy}", oSDR("NEXTDUEDATE"))
                    txtNextDueDateCust.Value = String.Format("{0:dd/MM/yyyy}", oSDR("NEXTDUEDATECUST"))


                    If Not String.IsNullOrEmpty(oSDR("ETDESC").ToString()) Then
                        txtDescription.Text = oSDR("ETDESC")
                        txtDescription.Enabled = False
                    End If
                    If oSDR("ENTRYSOURCE") = 2 Then
                        lblEntrySource.Text = oSDR("ENTRYSOURCENAME").ToString()
                        fvETUpload.Visible = True
                    Else
                        lblEntrySource.Text = oSDR("ENTRYSOURCENAME").ToString()
                        fvETUpload.Visible = False
                    End If

                    'Dim oSDRETStatus As System.Data.SqlClient.SqlDataReader
                    'oSDRETStatus = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getParamglobalName('ETSTATUS', " & oSDR("ETSTATUS").ToString() & " ) ETSTATUS")
                    'If oSDRETStatus.Read() Then
                    '    lblETStatus.Text = oSDRETStatus("ETSTATUS")
                    'End If
                    'oSDRETStatus.Close()
                    'oSDRETStatus = Nothing

                    lblETStatus.Text = oSDR("ETSTATUSNAME").ToString()
                    lblETCalcType.Text = oSDR("ETCALCTYPENAME").ToString()

                    Dim oSDRFINCATEGORY As System.Data.SqlClient.SqlDataReader
                    oSDRFINCATEGORY = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getTermPrincipal(" & hidFincatID.Value & ") as PRINCIPALNAME, " & _
                                "dbo.f_getTermInterest(" & hidFincatID.Value & ") as INTERESTNAME, " & _
                                "dbo.f_getTermPenalty(" & hidFincatID.Value & ") as PENALTYNAME")
                    If oSDRFINCATEGORY.Read() Then
                        lblPrincipalDue.Text = oSDRFINCATEGORY("PRINCIPALNAME").ToString()
                        lblOSPrincipal.Text = oSDRFINCATEGORY("PRINCIPALNAME").ToString()
                        lblInterestDue.Text = oSDRFINCATEGORY("INTERESTNAME").ToString()
                        lblOSInterest.Text = oSDRFINCATEGORY("INTERESTNAME").ToString()
                        lblETInterest.Text = oSDRFINCATEGORY("INTERESTNAME").ToString()

                        lblPenalty.Text = oSDRFINCATEGORY("PENALTYNAME").ToString()
                        lblETPenalty.Text = oSDRFINCATEGORY("PENALTYNAME").ToString()

                        gvInstallment.Columns(2).HeaderText = oSDRFINCATEGORY("PRINCIPALNAME")
                        gvInstallment.Columns(3).HeaderText = oSDRFINCATEGORY("INTERESTNAME")
                        gvInstallment.Columns(4).HeaderText = oSDRFINCATEGORY("PRINCIPALNAME") & "<br>Paid"
                        gvInstallment.Columns(5).HeaderText = oSDRFINCATEGORY("INTERESTNAME") & "<br>Paid"
                        gvInstallment.Columns(6).HeaderText = oSDRFINCATEGORY("PRINCIPALNAME") & "<br>Waive"
                        gvInstallment.Columns(7).HeaderText = oSDRFINCATEGORY("INTERESTNAME") & "<br>Waive"

                        gvInstallment.Columns(9).HeaderText = oSDRFINCATEGORY("PENALTYNAME")
                        gvInstallment.Columns(10).HeaderText = oSDRFINCATEGORY("PENALTYNAME") & "<br>Paid"
                        gvInstallment.Columns(11).HeaderText = oSDRFINCATEGORY("PENALTYNAME") & "<br>Waive"



                    End If
                    oSDRFINCATEGORY.Close()
                    oSDRFINCATEGORY = Nothing

                End If

                oSDR.Close()
                oSDR = Nothing
                FormValidation()
            Catch ex As Exception
                lblMessage.Visible = True
                lblMessage.Text = "ERROR LOADING ET : " & ex.Message
                lblMessage.Focus()
            Finally

                objDB.Close()
                objDB = Nothing

            End Try

        End If
    End Sub

    Private Sub FormValidation()
        SetObjectValidation(txtETAdminWaive, False, "float", "[0-9.,]")
        SetObjectValidation(txtETPenaltyWaive, False, "float", "[0-9.,]")
        SetObjectValidation(txtETInterestWaive, False, "float", "[0-9.,]")
        SetObjectValidation(txtWaiveOSPrincipal, False, "float", "[0-9.,]")
        SetObjectValidation(txtWaiveOSInterest, False, "float", "[0-9.,]")
        SetObjectValidation(txtWaivePrincipalDue, False, "float", "[0-9.,]")
        SetObjectValidation(txtWaiveInterestDue, False, "float", "[0-9.,]")
        SetObjectValidation(txtWaivePenaltyDue, False, "float", "[0-9.,]")
        SetObjectValidation(txtWaiveInstDiffDue, False, "float", "[0-9.,]")

        SetObjectValidation(txtCardExpiredDt, False, "date", "[0-9/]")
        SetObjectValidation(txtCollectFee, False, "float", "[0-9.,]")
        SetObjectValidation(txtCardHolder, False, "uppercase")
        SetObjectValidation(txtAddFee, False, "float", "[0-9.,]")


        txtETAdminWaive.Attributes.Add("onchange", "CalcETWaive();")
        txtETPenaltyWaive.Attributes.Add("onchange", "CalcETWaive();")
        txtETInterestWaive.Attributes.Add("onchange", "CalcETWaive();")
        txtWaiveOSPrincipal.Attributes.Add("onchange", "CalcETWaive();")
        txtWaiveOSInterest.Attributes.Add("onchange", "CalcETWaive();")

        txtWaivePrincipalDue.Attributes.Add("onchange", "CalcETWaive();")
        txtWaiveInterestDue.Attributes.Add("onchange", "CalcETWaive();")
        txtWaivePenaltyDue.Attributes.Add("onchange", "CalcETWaive();")
        txtWaiveInstDiffDue.Attributes.Add("onchange", "CalcETWaive();")
        txtInvoiceNo.Attributes.Add("onchange", "CheckInvoice();")


        If txtAction.Value = "WAIVE" Or txtAction.Value = "WAIVESPV" Then
            btnWaive.Visible = True
            If Not IsPostBack() Then btnWaive.Focus()
        ElseIf txtAction.Value = "APP" Then
            btnApprove.Visible = True
            btnReject.Visible = True
            WaiveDisable()
            If Not IsPostBack() Then btnApprove.Focus()
        ElseIf txtAction.Value = "INQ" Then
            WaiveDisable()
            If Not IsPostBack() Then btnCancel.Focus()
        ElseIf txtAction.Value = "PAY" Then
            WaiveDisable()
            btnCancel.Visible = False
            pnlPayment.Visible = True
            ddlTxnType.Attributes.Add("onchange", "TxnTypeChange();IsTypeChange();")
            SetObjectValidation(txtAmount, False, "float", "[0-9.,]")
            If Not IsPostBack() Then
                ddlTxnType.SelectedValue = 2
                btnProcess.Focus()
            End If
            txtCollectFee.Text = "0"
        End If

        If txtPrincipalDue.Text = "0" Then
            txtWaivePrincipalDue.ReadOnly = True
            txtWaivePrincipalDue.CssClass = "disabled"
        End If

        If txtInterestDue.Text = "0" Then
            txtWaiveInterestDue.ReadOnly = True
            txtWaiveInterestDue.CssClass = "disabled"
        End If

        If txtPenaltyDue.Text = "0" Then
            txtWaivePenaltyDue.ReadOnly = True
            txtWaivePenaltyDue.CssClass = "disabled"
        End If

        If txtOSPrincipal.Text = "0" Then
            txtWaiveOSPrincipal.ReadOnly = True
            txtWaiveOSPrincipal.CssClass = "disabled"
        End If

        If txtOSInterest.Text = "0" Then
            txtWaiveOSInterest.ReadOnly = True
            txtWaiveOSInterest.CssClass = "disabled"
        End If

        If txtETInterest.Text = "0" Then
            txtETInterestWaive.ReadOnly = True
            txtETInterestWaive.CssClass = "disabled"
        End If

        If txtETPenalty.Text = "0" Then
            txtETPenaltyWaive.ReadOnly = True
            txtETPenaltyWaive.CssClass = "disabled"
        End If

        If txtETAdmin.Text = "0" Then
            txtETAdminWaive.ReadOnly = True
            txtETAdminWaive.CssClass = "disabled"
        End If

        If txtInstDiffDue.Text = "0" Then
            txtWaiveInstDiffDue.ReadOnly = True
            txtWaiveInstDiffDue.CssClass = "disabled"
        End If

    End Sub

    Private Sub WaiveDisable()
        txtETPenaltyWaive.ReadOnly = True
        txtETPenaltyWaive.CssClass = "disabled"
        txtETAdminWaive.ReadOnly = True
        txtETAdminWaive.CssClass = "disabled"

        txtETInterestWaive.ReadOnly = True
        txtETInterestWaive.CssClass = "disabled"

        txtWaiveOSPrincipal.ReadOnly = True
        txtWaiveOSPrincipal.CssClass = "disabled"

        txtWaiveOSInterest.ReadOnly = True
        txtWaiveOSInterest.CssClass = "disabled"

        txtWaivePrincipalDue.ReadOnly = True
        txtWaivePrincipalDue.CssClass = "disabled"

        txtWaiveInterestDue.ReadOnly = True
        txtWaiveInterestDue.CssClass = "disabled"

        txtWaivePenaltyDue.ReadOnly = True
        txtWaivePenaltyDue.CssClass = "disabled"

        txtWaiveInstDiffDue.ReadOnly = True
        txtWaiveInstDiffDue.CssClass = "disabled"

    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click

        If txtAction.Value = "WAIVE" Or txtAction.Value = "APP" Or txtAction.Value = "WAIVESPV" Then
            Response.Redirect("ETInqList.aspx?Action=" + txtAction.Value)
        End If
    End Sub

    Protected Sub btnWaive_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnWaive.Click
        lblMessage.Visible = False
        Dim objPay As New Payment
        Try
            'Response.Write(Replace(txtETPenaltyWaive.Text, ",", ""))
            'Response.End()
            lblMessage.Visible = True
            Dim intRetVal As Integer = 0
            intRetVal = objPay.ETWaiveUpdate(txtLocID.Value, txtAccID.Value, txtETID.Value, _
                Replace(txtETPenaltyWaive.Text, ",", ""), Replace(txtETAdminWaive.Text, ",", ""), _
                Replace(txtETInterestWaive.Text, ",", ""), Replace(txtWaiveOSPrincipal.Text, ",", ""), _
                Replace(txtWaivePrincipalDue.Text, ",", ""), Replace(txtWaiveInterestDue.Text, ",", ""), _
                Replace(txtWaivePenaltyDue.Text, ",", ""), _
                Replace(txtWaiveInstDiffDue.Text, ",", ""), _
                Replace(txtWaiveOSInterest.Text, ",", ""), _
                Request.Cookies("UID").Value)
            If intRetVal = 0 Then
                Response.Redirect("ETInqList.aspx?Action=" + txtAction.Value)
            ElseIf intRetVal = -1 Then
                lblMessage.Visible = True
                lblMessage.Text = "EARLY TERMINATION ACCOUNT ALREADY APPROVED OR REJECTED<BR>PLEASE CHECK IN INQUIRY EARLY TERMINATION..!"
                lblMessage.Focus()
            End If

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ET WAIVE ERROR : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
        Finally
            objPay = Nothing
        End Try
    End Sub

    Protected Sub btnApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApprove.Click
        lblMessage.Visible = False
        Dim objPay As New Payment
        Try
            lblMessage.Visible = True
            Dim intRetVal As Integer = 0
            intRetVal = objPay.ETApproval(txtLocID.Value, txtAccID.Value, txtETID.Value, _
                1, Request.Cookies("UID").Value)
            If intRetVal = 0 Then
                Response.Redirect("ETInqList.aspx?Action=" + txtAction.Value)
            ElseIf intRetVal = -1 Then
                btnReject.Visible = False
                btnApprove.Visible = False
                lblMessage.Text = "EARLY TERMINATION ACCOUNT ALREADY APPROVED OR REJECTED<BR>PLEASE CHECK IN INQUIRY EARLY TERMINATION..!"
                lblMessage.Focus()
            ElseIf intRetVal = -2 Then
                btnReject.Visible = False
                btnApprove.Visible = False
                lblMessage.Text = "EARLY TERMINATION VALUES CHANGED..!<BR>PLEASE REJECT/CANCEL THIS ACCOUNT EARLY TERMINATION AND INPUT AGAIN..!"
                lblMessage.Focus()
            End If


        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ET APPROVE ERROR : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
        Finally
            objPay = Nothing
        End Try
    End Sub

    Protected Sub btnReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReject.Click
        lblMessage.Visible = False
        Dim objPay As New Payment
        Try
            lblMessage.Visible = True
            Dim intRetVal As Integer = 0
            intRetVal = objPay.ETApproval(txtLocID.Value, txtAccID.Value, txtETID.Value, _
                9, Request.Cookies("UID").Value)
            If intRetVal = 0 Then
                Response.Redirect("ETInqList.aspx?Action=" + txtAction.Value)
            ElseIf intRetVal = -1 Then
                btnReject.Visible = False
                btnApprove.Visible = False
                lblMessage.Text = "ET ACCOUNT ALREADY APPROVED OR REJECTED<BR>PLEASE CHECK IN INQUIRY EARLY TERMINATION..!"
                lblMessage.Focus()
            End If


        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ET REJECT ERROR : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
        Finally
            objPay = Nothing
        End Try

    End Sub

    Protected Sub btnRejectPay_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRejectPay.Click
        lblMessage.Visible = False
        Dim objPay As New Payment
        Try
            lblMessage.Visible = True
            Dim intRetVal As Integer = 0
            intRetVal = objPay.ETRejectAfterApp(txtLocID.Value, txtAccID.Value, txtETID.Value, _
                Request.Cookies("UID").Value)
            If intRetVal = 0 Then
                Response.Redirect("ETInqList.aspx?Action=" + txtAction.Value)
            ElseIf intRetVal = -1 Then
                lblMessage.Text = "ET ACCOUNT ALREADY REJECTED OR PAID<BR>PLEASE CHECK IN INQUIRY EARLY TERMINATION..!"
                lblMessage.Focus()
                btnReject.Visible = False
                'btnCancel.Focus()
            End If


        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ET REJECT AFTER APPROVE ERROR : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
        Finally
            objPay = Nothing
        End Try
    End Sub

    Protected Sub btnProcess_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcess.Click
        lblMessage.Visible = False
        Dim objPay As New Payment
        Dim objDB As New DBX
        Try
            lblMessage.Visible = True
            lblMessage.Text = ""
            Dim intRetVal As Integer = 0

            Dim oSDR As System.Data.SqlClient.SqlDataReader

            oSDR = objDB.CreateSDRFromSQLSelect("SELECT (SELECT COA.COAID FROM COA WHERE COA.COAID=APPUSER.COAID AND COA.DELETESTS=0) COAID, USERID, USERNAME FROM APPUSER WITH(NOLOCK) WHERE UID=" & Request.Cookies("UID").Value)
            If oSDR.Read() Then

                If String.IsNullOrEmpty(oSDR("COAID").ToString()) Then
                    Response.Write("USER ID : " & oSDR("USERID").ToString() & "-" & oSDR("USERNAME").ToString() & " CANNOT PROCESS THIS TRANSACTION...!<BR>USER IS NOT TELLER/CASHIER USER..!")
                    oSDR.Close()
                    oSDR = Nothing
                    'objDB.Close()
                    'objDB = Nothing
                    Response.End()
                End If
            End If
            oSDR.Close()
            oSDR = Nothing
            Dim intLOCIDPAY As Integer
            Dim dblPAYID As Double
            intRetVal = objPay.ETPayment(txtLocID.Value, txtAccID.Value, txtETID.Value, _
                NoComma(txtAmount.Text), ddlTxnType.SelectedValue, ddlAccountNo.SelectedValue, _
                txtInvoiceNo.Text, Request.Cookies("UID").Value, intLOCIDPAY, dblPAYID, _
                txtCardHolder.Text, ddlCardType.SelectedValue, ddlBank.SelectedValue, txtCardNo.Text, _
                ConvertDate(txtCardExpiredDt.Text), NoComma(txtAddFee.Text), hidInvPaperID.Value, _
                 ddlCurrency.SelectedValue, NoComma(txtCollectFee.Text), ConvertDate(txtPaidDate.Text))
            If intRetVal = 0 Then
                Response.Redirect("ETInqList.aspx?Action=" + txtAction.Value)
            ElseIf intRetVal = -1 Then
                lblMessage.Text = "MESSAGE : ET ACCOUNT ALREADY PAID OR REJECTEDD<BR>PLEASE CHECK IN INQUIRY EARLY TERMINATION..!"
                btnProcess.Visible = False
                lblMessage.Focus()
                'btnCancel.Focus()
            ElseIf intRetVal = -2 Then
                lblMessage.Text = "MESSAGE : NOT ENOUGH AMOUNT PAYMENT FOR EARLY TERMINATION..!<BR>TRANSACTION CANNOT PROCEED...! "
                btnProcess.Visible = False
                lblMessage.Focus()
                'btnCancel.Focus()
            ElseIf intRetVal = -3 Then
                lblMessage.Text = "MESSAGE : ACCOUNT ALREADY CLOSED..! BR> PLEASE CHECK ACCOUNT INQUIRY... "
                btnProcess.Visible = False
                lblMessage.Focus()
                'btnCancel.Focus()
            ElseIf intRetVal = -4 Then
                lblMessage.Text = "MESSAGE : OS PRINCIPAL HAS CHANGE...! <BR> PLEASE CANCEL ET AND INPUT AGAIN..! "
                btnProcess.Visible = False
                lblMessage.Focus()
            ElseIf intRetVal = -5 Then
                lblMessage.Text = "MESSAGE : VALUE DATE GREATER THAN ET DATE (TERMINATE DATE)..!<BR> PLEASE CANCEL ET AND INPUT AGAIN..!"
                btnProcess.Visible = False
                lblMessage.Focus()
            End If


        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ET PAYMENT ERROR : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
        Finally
            objPay = Nothing
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Private Function NoComma(ByVal strValue As String) As String
        If Len(Trim(strValue)) <= 0 Then
            NoComma = "0"
        Else
            NoComma = Replace(strValue, ",", "")
        End If
    End Function

End Class
