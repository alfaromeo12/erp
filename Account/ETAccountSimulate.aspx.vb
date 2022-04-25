
Partial Class Acc_ETSimulate
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
                txtOtherFee.Text = "0"
                hidETCALC.Value = Request.QueryString("ETCalc")
                If Len(Trim(hidETCALC.Value)) <= 0 Then
                    hidETCALC.Value = "1"
                End If

                If hidETCALC.Value = "2" Then
                    lblCalcType2.Visible = True
                Else
                    lblCalcType1.Visible = True
                End If
            End If
            oSDR.Close()
            oSDR = Nothing

            SetFormValidation()
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        lblOSPrincipalUntil.Text = txtValueDate.Text
        lblOSInterestUntil.Text = txtValueDate.Text
        lblDueUntil.Text = txtValueDate.Text
    End Sub

    Private Sub FinanceCategory()
        Dim objDBCATEGORY As New DBX
        Dim oSDRCATEGORYFIN As System.Data.SqlClient.SqlDataReader
        Try
            oSDRCATEGORYFIN = objDBCATEGORY.CreateSDRFromSQLSelect("SELECT FINCATID FROM ACCOUNT WHERE (LOCID =" & txtLocID.Value & ") AND (ACCID=" & txtAccID.Value & ")")
            If oSDRCATEGORYFIN.Read() Then
                hidFINCATID.Value = oSDRCATEGORYFIN("FINCATID").ToString()
            End If
            oSDRCATEGORYFIN.Close()
            oSDRCATEGORYFIN = Nothing

            oSDRCATEGORYFIN = objDBCATEGORY.CreateSDRFromSQLSelect("SELECT dbo.f_getTermPrincipal(" & hidFINCATID.Value & ") as PRINCIPALNAME, " & _
                                "dbo.f_getTermInterest(" & hidFINCATID.Value & ") as INTERESTNAME, dbo.f_getTermPenalty(" & hidFINCATID.Value & ") as PENALTYNAME")
            If oSDRCATEGORYFIN.Read() Then
                lblPrincipal.Text = oSDRCATEGORYFIN("PRINCIPALNAME").ToString()
                lblOSPrincipal.Text = oSDRCATEGORYFIN("PRINCIPALNAME").ToString()
                lblInterest.Text = oSDRCATEGORYFIN("INTERESTNAME").ToString()
                lblOSInterest.Text = oSDRCATEGORYFIN("INTERESTNAME").ToString()
                lblETInterest.Text = oSDRCATEGORYFIN("INTERESTNAME").ToString()
                lblPenalty.Text = oSDRCATEGORYFIN("PENALTYNAME").ToString()
                lblETPenalty.Text = oSDRCATEGORYFIN("PENALTYNAME").ToString()

                gvInstallment.Columns(2).HeaderText = oSDRCATEGORYFIN("PRINCIPALNAME")
                gvInstallment.Columns(3).HeaderText = oSDRCATEGORYFIN("INTERESTNAME")
                gvInstallment.Columns(4).HeaderText = oSDRCATEGORYFIN("PRINCIPALNAME") & "<br>Paid"
                gvInstallment.Columns(5).HeaderText = oSDRCATEGORYFIN("INTERESTNAME") & "<br>Paid"
                gvInstallment.Columns(6).HeaderText = oSDRCATEGORYFIN("PRINCIPALNAME") & "<br>Waive"
                gvInstallment.Columns(7).HeaderText = oSDRCATEGORYFIN("INTERESTNAME") & "<br>Waive"

                gvInstallment.Columns(9).HeaderText = oSDRCATEGORYFIN("PENALTYNAME")
                gvInstallment.Columns(10).HeaderText = oSDRCATEGORYFIN("PENALTYNAME") & "<br>Paid"
                gvInstallment.Columns(11).HeaderText = oSDRCATEGORYFIN("PENALTYNAME") & "<br>Waive"

            End If
            oSDRCATEGORYFIN.Close()
            oSDRCATEGORYFIN = Nothing


        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RETRIVE DATA (FINANCE CATEGORY) : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDBCATEGORY.Close()
            objDBCATEGORY = Nothing
        End Try
    End Sub

    Protected Sub btnView_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnView.Click
        Dim strBranchID As String = ""
        Dim strBranchIDDB As String = ""
        Dim strNumber As String = ""
        lblMessage.Visible = False
        'txtRemark.Text = ""
        SplitFormatedNumber(txtAccountNo.Text, strBranchID, strNumber)
        Dim strValueDate As String = ""
        Dim blnFound As Boolean = False

        Dim objDB As New DBX
        Try
            Dim oSDR As Data.SqlClient.SqlDataReader
            Dim oSDRAcc As Data.SqlClient.SqlDataReader
            Dim strLocID As String = ""
            Dim strAccID As String = ""
            Dim strFINCATID As String = ""
            Dim strBOOKINGDATE As String = ""
            Dim strDecPointNet As String = ""
            Dim intTenor As Integer = -0

            Dim dblPrincipalTotal As Double, dblInterestTotal As Double, dblDeposit As Double
            Dim dblETInterest As Double
            strValueDate = ConvertDate(txtValueDate.Text)
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT LOCID, ACCID, TENOR, DEPOSIT,  ACCOUNT.BRANCHID, FINCATID,BOOKINGDATE," & _
                "PRINCIPALTOTAL, INTERESTTOTAL, dbo.f_getCurrencyDecPointForNet(ACCOUNT.CURRENCYID) DecPointNet, " & _
                "PRINCIPALTOTAL - (SELECT  ISNULL(SUM(PRINCIPAL), 0) FROM INSTALLMENT WHERE ACCOUNT.LOCID=INSTALLMENT.LOCID AND ACCOUNT.ACCID=INSTALLMENT.ACCID AND DUEDATE<= CONVERT(DATETIME, '" & txtValueDate.Text & "', 103) ) OSPRINCIPAL, " & _
                "INTERESTTOTAL  - (SELECT  ISNULL(SUM(INTEREST), 0) FROM INSTALLMENT WHERE ACCOUNT.LOCID=INSTALLMENT.LOCID AND ACCOUNT.ACCID=INSTALLMENT.ACCID AND DUEDATE <= CONVERT(DATETIME, '" & txtValueDate.Text & "', 103) ) OSINTEREST, " & _
                "dbo.f_CalcInterestETSimulate(LOCID, ACCID, CONVERT(DATETIME, '" & txtValueDate.Text & "', 103)) ETINTEREST FROM ACCOUNT WITH (NOLOCK) " & _
                    " WHERE ACCOUNT.BRANCHID=" & strBranchID & " AND ACCOUNT.ACCOUNTNO=" & strNumber & " AND ACCOUNT.ACCSTATUS=1")
            If oSDR.HasRows() Then
                If oSDR.Read() Then
                    blnFound = True
                    strLocID = oSDR("LOCID").ToString()
                    strAccID = oSDR("ACCID").ToString()
                    strDecPointNet = oSDR("DecPointNet")
                    intTenor = oSDR("TENOR")
                    txtLocID.Value = strLocID
                    txtAccID.Value = strAccID
                    strBranchIDDB = oSDR("BRANCHID").ToString()
                    dblPrincipalTotal = oSDR("PRINCIPALTOTAL")
                    dblInterestTotal = oSDR("INTERESTTOTAL")
                    dblDeposit = oSDR("DEPOSIT")
                    dblETInterest = oSDR("ETINTEREST")
                    txtDeposit.Text = String.Format(strDecPointNet, dblDeposit)
                    txtETInterest.Text = String.Format(strDecPointNet, dblETInterest)
                    strFINCATID = oSDR("FINCATID").ToString()
                    strBOOKINGDATE = String.Format("{0:yyy-MM-dd}", oSDR("BOOKINGDATE"))

                    pnlPayment.Visible = True
                    lblMessage.Visible = False
                    txtValueDate.Focus()

                    Dim dblPrincipalPaidEarly As Double = 0
                    Dim dblInterestPaidEarly As Double = 0
                    'cek jika ada pembayaran dipercepat, untuk mengurangi OS Principal dan OS Interest
                    oSDRAcc = objDB.CreateSDRFromSQLSelect("SELECT " & _
                        "ISNULL(SUM(PRINCIPALPAID), 0)  PRINCIPALPAID, " & _
                        "ISNULL(SUM(INTERESTPAID), 0)  INTERESTPAID " & _
                        "FROM INSTALLMENT " & _
                        " WHERE INSTALLMENT.LOCID=" & strLocID & " AND INSTALLMENT.ACCID=" & strAccID & " AND INSTALLMENT.DUEDATE>CONVERT(DATETIME, '" & txtValueDate.Text & "', 103)")
                    If oSDRAcc.Read() Then
                        dblPrincipalPaidEarly = oSDRAcc("PRINCIPALPAID")
                        dblInterestPaidEarly = oSDRAcc("INTERESTPAID")
                    End If
                    oSDRAcc.Close()
                    oSDRAcc = Nothing

                    txtOSPrincipal.Text = String.Format(strDecPointNet, oSDR("OSPRINCIPAL") - dblPrincipalPaidEarly)
                    txtOSInterest.Text = String.Format(strDecPointNet, oSDR("OSINTEREST") - dblInterestPaidEarly)

                    'CEK APAKAH PEMBAYARAN BUNGA TELAH MELEBIHI BUNGA BERJALAN
                    'JIKA IYA.. MAKA bunga berjalan jadi nol
                    'TIDAK PERLU DIKURANGI PEMBAYARAN DI PERCEPAT, KARENA DI FUNCTION SUDAH DIKURANGI
                    'If dblInterestPaidEarly > dblETInterest Then
                    '    txtETInterest.Text = String.Format(strDecPointNet, 0)
                    'End If

                    'sdsAccData.SelectParameters("LOCID").DefaultValue = strLocID
                    'sdsAccData.SelectParameters("ACCID").DefaultValue = strAccID
                    ctlDataAccountFromParamAccID.LOCID = strLocID
                    ctlDataAccountFromParamAccID.ACCID = strAccID

                    'sdsLoanData.SelectParameters("LOCID").DefaultValue = strLocID
                    'sdsLoanData.SelectParameters("ACCID").DefaultValue = strAccID
                    ctlLoanDataFromParamAccID.LOCID = strLocID
                    ctlLoanDataFromParamAccID.ACCID = strAccID

                    sdsInstallment.SelectParameters("LOCID").DefaultValue = strLocID
                    sdsInstallment.SelectParameters("ACCID").DefaultValue = strAccID
                    sdsInstallment.SelectParameters("TXNDATE").DefaultValue = ConvertDate(txtValueDate.Text)
                    gvInstallment.DataBind()
                    FinanceCategory()

                    oSDRAcc = objDB.CreateSDRFromSQLSelect("SELECT COUNT(*) TENORDUE FROM INSTALLMENT WITH(NOLOCK) WHERE INSTALLMENT.LOCID=" & strLocID & " AND INSTALLMENT.ACCID=" & strAccID & " AND DUEDATE<=dbo.f_getAppDate()")
                    If oSDRAcc.Read() Then
                        If intTenor <= oSDRAcc("TENORDUE") Then
                            lblMessage.Visible = True
                            lblMessage.Text = "ALL ACCOUNT INSTALLMENT HAS DUE..!<BR>PLEASE USE INSTALLMENT PAYMENT SIMULATION ..!"
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
                End If
                oSDR.Close()
                oSDR = Nothing

                'oSDRAcc = objDB.CreateSDRFromSQLSelect("SELECT ISNULL(SUM(PRINCIPAL-PRINCIPALPAID), 0) PRINCIPALUNPAID, " & _
                '   " ISNULL(SUM(INTEREST-INTERESTPAID), 0) INTERESTUNPAID, " & _
                '   " ISNULL(SUM(PENALTY), 0) PENALTY FROM dbo.f_AccInstalmentDueList(" & txtLocID.Value & ", " & txtAccID.Value & ", Convert(datetime, '" & txtValueDate.Text & "', 103)) WHERE (DueDate <= dbo.f_getAppDate())")
                oSDRAcc = objDB.CreateSDRFromSQLSelect("SELECT ISNULL(SUM(PRINCIPAL-PRINCIPALPAID-PRINCIPALWAIVE), 0) PRINCIPALUNPAID, " & _
                    " ISNULL(SUM(INTEREST-INTERESTPAID-INTERESTWAIVE), 0) INTERESTUNPAID, " & _
                    "ISNULL(SUM(INSTDIFF-INSTDIFFPAID-INSTDIFFWAIVE), 0) INSTDIFF, " & _
                    " ISNULL(SUM(PENALTY), 0) PENALTY FROM dbo.f_AccInstalmentList(" & txtLocID.Value & ", " & txtAccID.Value & ", Convert(datetime, '" & txtValueDate.Text & "', 103)) WHERE PAIDSTS=0 AND (DueDate <=  Convert(datetime, '" & txtValueDate.Text & "', 103))")
                If oSDRAcc.Read() Then
                    txtPrincipalDue.Text = String.Format(strDecPointNet, oSDRAcc("PRINCIPALUNPAID"))
                    txtPenaltyDue.Text = String.Format(strDecPointNet, oSDRAcc("PENALTY"))
                    txtInterestDue.Text = String.Format(strDecPointNet, oSDRAcc("INTERESTUNPAID"))
                    txtInstDiff.Text = String.Format(strDecPointNet, oSDRAcc("INSTDIFF"))
                    txtInstallmentDue.Text = String.Format(strDecPointNet, oSDRAcc("PRINCIPALUNPAID") + oSDRAcc("INTERESTUNPAID") + oSDRAcc("PENALTY") + oSDRAcc("INSTDIFF"))
                Else
                    txtPrincipalDue.Text = "0"
                    txtPenaltyDue.Text = "0"
                    txtInterestDue.Text = "0"
                    txtInstallmentDue.Text = "0"
                    txtInstDiff.Text = "0"
                End If
                txtOtherFee.Text = "0"
                oSDRAcc.Close()
                oSDRAcc = Nothing
                If Len(Trim(strBranchIDDB)) <= 0 Then strBranchIDDB = "0"
                oSDRAcc = objDB.CreateSDRFromSQLSelect("SELECT * FROM dbo.f_ETPenaltyAndAdmin(" & strBranchIDDB & "," & Replace(txtOSPrincipal.Text, ",", "") & "," & strFINCATID & ",'" & strBOOKINGDATE & "')")
                If oSDRAcc.Read() Then
                    txtETPenalty.Text = String.Format(strDecPointNet, oSDRAcc("PENALTY"))
                    txtETAdmin.Text = String.Format(strDecPointNet, oSDRAcc("ADMINFEE"))
                End If
                oSDRAcc.Close()
                oSDRAcc = Nothing

                If Len(Trim(txtInstallmentDue.Text)) <= 0 Then
                    txtInstallmentDue.Text = "0"
                End If

                If Len(Trim(txtOSPrincipal.Text)) <= 0 Then
                    txtOSPrincipal.Text = "0"
                End If

                If Len(Trim(txtETInterest.Text)) <= 0 Then
                    txtETInterest.Text = "0"
                End If
                If Len(Trim(txtETPenalty.Text)) <= 0 Then
                    txtETPenalty.Text = "0"
                End If
                If Len(Trim(txtETAdmin.Text)) <= 0 Then
                    txtETAdmin.Text = "0"
                End If
                If Len(Trim(txtDeposit.Text)) <= 0 Then
                    txtDeposit.Text = "0"
                End If

                If hidETCALC.Value = "2" Then
                    txtETAmountOri.Value = String.Format(strDecPointNet, CType(txtInstallmentDue.Text, Double) + CType(txtOSPrincipal.Text, Double) + CType(txtOSInterest.Text, Double) + CType(txtETPenalty.Text, Double) + CType(txtETAdmin.Text, Double) - CType(txtDeposit.Text, Double))
                    txtETAmount.Text = String.Format(strDecPointNet, CType(txtInstallmentDue.Text, Double) + CType(txtOSPrincipal.Text, Double) + CType(txtOSInterest.Text, Double) + CType(txtETPenalty.Text, Double) + CType(txtETAdmin.Text, Double) - CType(txtDeposit.Text, Double))
                Else
                    txtETAmountOri.Value = String.Format(strDecPointNet, CType(txtInstallmentDue.Text, Double) + CType(txtOSPrincipal.Text, Double) + CType(txtETInterest.Text, Double) + CType(txtETPenalty.Text, Double) + CType(txtETAdmin.Text, Double) - CType(txtDeposit.Text, Double))
                    txtETAmount.Text = String.Format(strDecPointNet, CType(txtInstallmentDue.Text, Double) + CType(txtOSPrincipal.Text, Double) + CType(txtETInterest.Text, Double) + CType(txtETPenalty.Text, Double) + CType(txtETAdmin.Text, Double) - CType(txtDeposit.Text, Double))
                End If
            Else
                pnlPayment.Visible = False
                lblMessage.Visible = True
                lblMessage.Text = "ACCOUNT NO. " & txtAccountNo.Text & " NOT FOUND...!<br>PLEASE CHECK ACCOUNT NO...!"
                lblMessage.Focus()
            End If



        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR ET SIMULATE VIEW: " & ex.Message & "<br>PLEASE CHECK DETAIL ERROR...!"
            'Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Private Sub SetFormValidation()
        SetObjectValidation(txtETAmount, False, "float", "[0-9.,]")
        SetObjectValidation(txtValueDate, False, "date", "[0-9/]")
        SetObjectValidation(txtOtherFee, False, "float", "[0-9.,]")
        txtValueDate.Attributes.Add("onchange", "ValueDateChange();")
        txtAccountNo.Attributes.Add("onchange", "ValueDateChange();")
        txtOtherFee.Attributes.Add("onblur", "OtherFeeChange();")


    End Sub

End Class
