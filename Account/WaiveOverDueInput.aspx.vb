
Partial Class Account_WaiveOverDueInput
    Inherits System.Web.UI.Page

    Public Shared strAppDate As String

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim objDB As New DBX
        Try
            txtLocID.Value = Request.QueryString("LOCID")
            txtAccID.Value = Request.QueryString("ACCID")
            txtAction.Value = Request.QueryString("Action")
            txtACCOUNTNO.Value = Request.QueryString("ACCNO")
            'Response.Write(txtAccID.Value)

            Dim oSDR As Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppSetting('APPDATE') APPDATE")
            If oSDR.Read() Then
                strAppDate = oSDR("APPDATE").ToString()
                txtTxnDate.Value = strAppDate
                lblDueUntil.Text = strAppDate
            End If
            If Not IsPostBack() Then
              
                DataAccountFromParamAccID1.LOCID = txtLocID.Value
                DataAccountFromParamAccID1.ACCID = txtAccID.Value

                LoanDataFromParamAccID1.LOCID = txtLocID.Value
                LoanDataFromParamAccID1.ACCID = txtAccID.Value

                InstallmentDataDue.LOCID = txtLocID.Value
                InstallmentDataDue.ACCID = txtAccID.Value
                InstallmentDataDue.TXNDATE = ConvertDate(txtTxnDate.Value)
                WaiveDisable(True, "disabled")
                GetData()
                txtWaivePrincipalDue.Focus()
            End If
            oSDR.Close()
            oSDR = Nothing
            SetFormValidation()
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Response.Redirect("../Pay/PayWaiveList.aspx?Action=" + txtAction.Value)
    End Sub
    Private Sub GetData()
        Dim objDB As New DBX
        Try
            Dim strDecPointNet As String = ""
            Dim oSDRCATEGORYFIN As System.Data.SqlClient.SqlDataReader
            oSDRCATEGORYFIN = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getCurrencyDecPointForNet(ACCOUNT.CURRENCYID) DecPointNet, " & _
                "dbo.f_getTermPrincipal(ACCOUNT.FINCATID) AS FINCATPRINCIPAL, " & _
                "dbo.f_getTermInterest(ACCOUNT.FINCATID) AS FINCATINTEREST FROM ACCOUNT WITH(NOLOCK) WHERE LOCID=" & txtLocID.Value & " AND ACCID= " & txtAccID.Value & "")
            If oSDRCATEGORYFIN.Read() Then
                strDecPointNet = oSDRCATEGORYFIN("DecPointNet")
                lblPrincipalDue.Text = oSDRCATEGORYFIN("FINCATPRINCIPAL").ToString()
                lblInterestDue.Text = oSDRCATEGORYFIN("FINCATINTEREST").ToString()
            End If
            oSDRCATEGORYFIN.Close()
            oSDRCATEGORYFIN = Nothing

            Dim oSDRAcc As Data.SqlClient.SqlDataReader
            oSDRAcc = objDB.CreateSDRFromSQLSelect("SELECT ISNULL(SUM(PRINCIPAL-PRINCIPALPAID-PRINCIPALWAIVE), 0) PRINCIPALUNPAID, " & _
                " ISNULL(SUM(INTEREST-INTERESTPAID-INTERESTWAIVE), 0) INTERESTUNPAID, " & _
                "ISNULL(SUM(INSTDIFF-INSTDIFFPAID-INSTDIFFWAIVE), 0) INSTDIFFUNPAID, " & _
                " ISNULL(SUM(PENALTY), 0) PENALTY FROM dbo.f_AccInstalmentDueList(" & txtLocID.Value & ", " & txtAccID.Value & ", Convert(datetime, '" & txtTxnDate.Value & "', 103)) WHERE (DueDate <= dbo.f_getAppDate())")
            If oSDRAcc.Read() Then
                If oSDRAcc("PRINCIPALUNPAID") = 0 And oSDRAcc("PENALTY") = 0 And oSDRAcc("INTERESTUNPAID") = 0 And oSDRAcc("INSTDIFFUNPAID") = 0 Then
                    txtPrincipalDue.Text = String.Format(strDecPointNet, oSDRAcc("PRINCIPALUNPAID"))
                    txtPenaltyDue.Text = String.Format(strDecPointNet, oSDRAcc("PENALTY"))
                    txtInterestDue.Text = String.Format(strDecPointNet, oSDRAcc("INTERESTUNPAID"))
                    txtInstDiffDue.Text = String.Format(strDecPointNet, oSDRAcc("INSTDIFFUNPAID"))
                    txtInstallmentDue.Text = String.Format(strDecPointNet, oSDRAcc("PRINCIPALUNPAID") + oSDRAcc("INTERESTUNPAID") + oSDRAcc("PENALTY") + oSDRAcc("INSTDIFFUNPAID"))
                    txtWaiveInstallmentDue.Text = txtInstallmentDue.Text
                    WaiveDisable(True, "disabled")
                    btnSave.Visible = False
                Else
                    txtPrincipalDue.Text = String.Format(strDecPointNet, oSDRAcc("PRINCIPALUNPAID"))
                    txtPenaltyDue.Text = String.Format(strDecPointNet, oSDRAcc("PENALTY"))
                    txtInterestDue.Text = String.Format(strDecPointNet, oSDRAcc("INTERESTUNPAID"))
                    txtInstDiffDue.Text = String.Format(strDecPointNet, oSDRAcc("INSTDIFFUNPAID"))
                    txtInstallmentDue.Text = String.Format(strDecPointNet, oSDRAcc("PRINCIPALUNPAID") + oSDRAcc("INTERESTUNPAID") + oSDRAcc("PENALTY") + oSDRAcc("INSTDIFFUNPAID"))
                    txtWaiveInstallmentDue.Text = txtInstallmentDue.Text
                    WaiveDisable(False, "required")
                    btnSave.Visible = True
                End If

                If oSDRAcc("PRINCIPALUNPAID") = 0 Then
                    txtWaivePrincipalDue.ReadOnly = True
                    txtWaivePrincipalDue.CssClass = "disabled"
                    txtWaivePrincipalDue.Text = "0"
                End If

                If oSDRAcc("INTERESTUNPAID") = 0 Then
                    txtWaiveInterestDue.ReadOnly = True
                    txtWaiveInterestDue.CssClass = "disabled"
                    txtWaiveInterestDue.Text = "0"
                End If

                If oSDRAcc("PENALTY") = 0 Then
                    txtWaivePenaltyDue.ReadOnly = True
                    txtWaivePenaltyDue.CssClass = "disabled"
                    txtWaivePenaltyDue.Text = "0"
                End If

                If oSDRAcc("INSTDIFFUNPAID") = 0 Then
                    txtWaiveInstDiffDue.ReadOnly = True
                    txtWaiveInstDiffDue.CssClass = "disabled"
                    txtWaiveInstDiffDue.Text = "0"
                End If

            Else
                txtPrincipalDue.Text = "0"
                txtPenaltyDue.Text = "0"
                txtInterestDue.Text = "0"
                txtInstallmentDue.Text = "0"
                txtInstDiffDue.Text = "0"
            End If
            oSDRAcc.Close()
            oSDRAcc = Nothing


        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR WAIVE OVER DUE VIEW (INPUT): " & ex.Message & "<br>PLEASE CHECK DETAIL ERROR...!"
            lblMessage.Focus()
            'Throw
        Finally
            objDB.Close()
            objDB = Nothing

        End Try

    End Sub

    Private Sub SetFormValidation()
        SetObjectValidation(txtWaivePrincipalDue, False, "float", "[0-9.,]")
        SetObjectValidation(txtWaiveInterestDue, False, "float", "[0-9.,]")
        SetObjectValidation(txtWaivePenaltyDue, False, "float", "[0-9.,]")
        SetObjectValidation(txtWaiveInstDiffDue, False, "float", "[0-9.,]")
        txtWaivePrincipalDue.Attributes.Add("onchange", "CalcETWaive();")
        txtWaiveInterestDue.Attributes.Add("onchange", "CalcETWaive();")
        txtWaivePenaltyDue.Attributes.Add("onchange", "CalcETWaive();")
        txtWaiveInstDiffDue.Attributes.Add("onchange", "CalcETWaive();")

        SetObjectValidation(txtWaiveTotal, False, "float", "[0-9.,]")
    End Sub

    Private Sub WaiveDisable(ByVal value As Boolean, ByVal cssClass As String)
        txtWaivePrincipalDue.ReadOnly = value
        txtWaivePrincipalDue.CssClass = cssClass
        txtWaivePrincipalDue.Text = "0"

        txtWaiveInterestDue.ReadOnly = value
        txtWaiveInterestDue.CssClass = cssClass
        txtWaiveInterestDue.Text = "0"

        txtWaivePenaltyDue.ReadOnly = value
        txtWaivePenaltyDue.CssClass = cssClass
        txtWaivePenaltyDue.Text = "0"

        'txtWaiveInstallmentDue.Text = "0"
        txtWaiveTotal.ReadOnly = value
        txtWaiveTotal.CssClass = cssClass
        txtWaiveTotal.Text = "0"

        txtWaiveInstDiffDue.ReadOnly = value
        txtWaiveInstDiffDue.CssClass = cssClass
        txtWaiveInstDiffDue.Text = "0"

    End Sub
    Protected Sub btnProcess_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        lblMessage.Visible = False
        Dim objPay As New Payment
        Try
            Dim intETID As Integer = 0, intRetVal As Integer
            lblMessage.Visible = True
            If txtAction.Value = "INP" Then
                intRetVal = objPay.WaiveODAdd(txtLocID.Value, txtAccID.Value, Replace(txtWaivePrincipalDue.Text, ",", ""), Replace(txtWaiveInterestDue.Text, ",", ""), _
                 Replace(txtWaivePenaltyDue.Text, ",", ""), ConvertDate(txtTxnDate.Value), txtRemark.Text, Request.Cookies("UID").Value, _
                 Replace(txtWaiveInstDiffDue.Text, ",", ""))
            ElseIf txtAction.Value = "INPSPV" Then
                intRetVal = objPay.WaiveODAddSPV(txtLocID.Value, txtAccID.Value, Replace(txtWaiveTotal.Text, ",", ""), _
                 ConvertDate(txtTxnDate.Value), txtRemark.Text, Request.Cookies("UID").Value)
            End If
            
            If intRetVal = 0 Then
                Response.Redirect("../Pay/PayWaiveList.aspx?Action=" + txtAction.Value)
                ' lblMessage.Text = "DATA ACCOUNT : " & txtACCOUNTNO.Value & " SAVED...!"
            ElseIf intRetVal = -1 Then
                lblMessage.Text = "DATA ACCOUNT : " & txtACCOUNTNO.Value & " ALREADY IN WAIVE OVERDUE DATA LIST, WAIVE OVERDUE NEED APPROVAL...!"
                btnSave.Visible = False
                btnCancel.Focus()
            ElseIf intRetVal = -2 Then
                lblMessage.Text = "DATA ACCOUNT : " & txtACCOUNTNO.Value & " ACCOUNT DOEST NOT HAVE OVERDUE INSTALLMENT..!"
                btnSave.Visible = False
                btnCancel.Focus()
            ElseIf intRetVal = -3 Then
                lblMessage.Text = "DATA ACCOUNT : " & txtACCOUNTNO.Value & " TOTAL AMOUNT WAIVE GREATER THAN AMOUNT OVERDUE..!"
                btnSave.Visible = False
                btnCancel.Focus()
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE WAIVE OVER DUE : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
        Finally
            objPay = Nothing
        End Try
    End Sub
End Class
