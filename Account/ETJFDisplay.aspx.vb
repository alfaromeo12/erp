
Partial Class Account_ETJFDisplay
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            txtLocID.Value = Request.QueryString("LOCID")
            txtAccID.Value = Request.QueryString("ACCID")
            txtAccIDJF.Value = Request.QueryString("ACCIDJF")
            txtJFETID.Value = Request.QueryString("JFETID")
            txtAction.Value = Request.QueryString("Action")
            Dim objDB As New DBX
            Try
                Dim oSDR As System.Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT " & _
                    "(SELECT MIN(JFDUEDATE) FROM INSTALLMENTJF WHERE INSTALLMENTJF.ACCIDJF=ETJF.ACCIDJF AND INSTALLMENTJF.JFDUEDATE>dbo.f_getAppDate()) JFNEXTDUEDATEACC, " & _
                    " JFETDATE, JFOSPRINCIPAL, JFOSINTEREST, JFETINTEREST, JFETPENALTY, JFETPENALTYWAIVE, " & _
                    " JFETADMIN, JFETADMINWAIVE, JFETOTHERFEE, JFNEXTDUEDATE FROM ETJF WITH(NOLOCK) WHERE ACCIDJF=" & txtAccIDJF.Value & " AND JFETID=" & txtJFETID.Value)
                If oSDR.Read() Then
                    'sdsAccData.SelectParameters("LOCID").DefaultValue = txtLocID.Value
                    'sdsAccData.SelectParameters("ACCID").DefaultValue = txtAccID.Value

                    ctlDataAccountFromParamAccID.LOCID = txtLocID.Value
                    ctlDataAccountFromParamAccID.ACCID = txtAccID.Value

                    'sdsJF.SelectParameters("ACCIDJF").DefaultValue = txtAccIDJF.Value
                    ctlAccountJFbyACCIDJF.ACCIDJF = txtAccIDJF.Value

                    sdsInstallment.SelectParameters("ACCIDJF").DefaultValue = txtAccIDJF.Value
                    sdsInstallment.SelectParameters("TXNDATE").DefaultValue = oSDR("JFETDATE")

                    hidTxnDate.Value = oSDR("JFETDATE")

                    Dim oSDRAcc As Data.SqlClient.SqlDataReader
                    oSDRAcc = objDB.CreateSDRFromSQLSelect("SELECT ISNULL(SUM(JFPRINCIPAL-JFPRINCIPALPAID), 0) JFPRINCIPALUNPAID, " & _
                        " ISNULL(SUM(JFINTEREST-JFINTERESTPAID), 0) JFINTERESTUNPAID, " & _
                        " ISNULL(SUM(JFPENALTY), 0) JFPENALTY FROM dbo.f_AccInstalmentJFDueList(" & txtAccIDJF.Value & ", '" & oSDR("JFETDATE").ToString() & "') WHERE (JFDueDate <= dbo.f_getAppDate())")
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
                    oSDRAcc.Close()
                    oSDRAcc = Nothing
                    txtOSPrincipal.Text = String.Format("{0:N}", oSDR("JFOSPRINCIPAL"))
                    txtOSInterest.Text = String.Format("{0:N}", oSDR("JFOSINTEREST"))
                    txtETInterest.Text = String.Format("{0:N}", oSDR("JFETINTEREST"))

                    txtETPenalty.Text = String.Format("{0:N}", oSDR("JFETPENALTY"))
                    txtETPenaltyWaive.Text = String.Format("{0:N}", oSDR("JFETPENALTYWAIVE"))
                    txtETAdmin.Text = String.Format("{0:N}", oSDR("JFETADMIN"))
                    txtETAdminWaive.Text = String.Format("{0:N}", oSDR("JFETADMINWAIVE"))
                    txtOtherFee.Text = String.Format("{0:N}", oSDR("JFETOTHERFEE"))

                    txtETAmount.Text = String.Format("{0:N}", CType(txtInstallmentDue.Text, Double) + CType(txtOSPrincipal.Text, Double) + CType(txtETInterest.Text, Double) + CType(txtETPenalty.Text, Double) + CType(txtETAdmin.Text, Double) + CType(txtOtherFee.Text, Double))
                    txtETAmountWaive.Text = String.Format("{0:N}", CType(txtInstallmentDue.Text, Double) + CType(txtOSPrincipal.Text, Double) + CType(txtETInterest.Text, Double) + CType(txtETPenalty.Text, Double) + CType(txtETAdmin.Text, Double) + CType(txtOtherFee.Text, Double) - CType(txtETPenaltyWaive.Text, Double) - CType(txtETAdminWaive.Text, Double))
                    txtNextDueDateET.Value = String.Format("{0:dd/MM/yyyy}", oSDR("JFNEXTDUEDATE"))
                    txtNextDueDateCust.Value = String.Format("{0:dd/MM/yyyy}", oSDR("JFNEXTDUEDATEACC"))

                End If
                oSDR.Close()
                oSDR = Nothing
                FormValidation()
            Catch ex As Exception
                lblMessage.Visible = True
                lblMessage.Text = "ERROR LOADING ET JF (BUY BACK) : " & ex.Message
            Finally

                objDB.Close()
                objDB = Nothing

            End Try

        End If
    End Sub

    Private Sub FormValidation()
        SetObjectValidation(txtETAdminWaive, False, "float", "[0-9.,]")
        SetObjectValidation(txtETPenaltyWaive, False, "float", "[0-9.,]")
        txtETAdminWaive.Attributes.Add("onblur", "CalcETWaive();")
        txtETPenaltyWaive.Attributes.Add("onblur", "CalcETWaive();")
        If txtAction.Value = "WAIVE" Then
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
            If Not IsPostBack() Then
                btnProcess.Focus()
            End If
        End If

        If txtETAdmin.Text = "0" Then
            txtETAdminWaive.ReadOnly = True
            txtETAdminWaive.CssClass = "disabled"
        End If

        If txtETPenalty.Text = "0" Then
            txtETPenaltyWaive.ReadOnly = True
            txtETPenaltyWaive.CssClass = "disabled"
        End If

    End Sub

    Private Sub WaiveDisable()
        txtETPenaltyWaive.ReadOnly = True
        txtETPenaltyWaive.CssClass = "disabled"
        txtETAdminWaive.ReadOnly = True
        txtETAdminWaive.CssClass = "disabled"
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        If txtAction.Value = "WAIVE" Or txtAction.Value = "APP" Then
            Response.Redirect("ETJFInqList.aspx?Action=" + txtAction.Value)
        End If
    End Sub

    Protected Sub btnWaive_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnWaive.Click
        Dim objPay As New Payment
        Try
            lblMessage.Visible = True
            Dim intRetVal As Integer = 0
            intRetVal = objPay.ETJFWaiveUpdate(txtAccIDJF.Value, txtJFETID.Value, _
                Replace(txtETPenaltyWaive.Text, ",", ""), Replace(txtETAdminWaive.Text, ",", ""), Request.Cookies("UID").Value)
            If intRetVal = 0 Then
                Response.Redirect("ETJFInqList.aspx?Action=" + txtAction.Value)
            ElseIf intRetVal = -1 Then
                lblMessage.Text = "ET JF (BUYBACK) ACCOUNT ALREADY APPROVED OR REJECTED"
            End If


        Catch ex As Exception
            lblMessage.Text = "ET JF (BUYBACK) WAIVE ERROR : " & ex.Message
        Finally
            objPay = Nothing
        End Try
    End Sub

    Protected Sub btnApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApprove.Click
        Dim objPay As New Payment
        Try
            lblMessage.Visible = True
            Dim intRetVal As Integer = 0
            intRetVal = objPay.ETJFApproval(txtAccIDJF.Value, txtJFETID.Value, _
                1, Request.Cookies("UID").Value)
            If intRetVal = 0 Then
                Response.Redirect("ETJFInqList.aspx?Action=" + txtAction.Value)
            ElseIf intRetVal = -1 Then
                btnReject.Visible = False
                btnApprove.Visible = False
                lblMessage.Text = "ET JF (BUYBACK) ACCOUNT ALREADY APPROVED OR REJECTED"
            End If


        Catch ex As Exception
            lblMessage.Text = "ET JF (BUYBACK) APPROVE ERROR : " & ex.Message
        Finally
            objPay = Nothing
        End Try
    End Sub

    Protected Sub btnReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReject.Click
        Dim objPay As New Payment
        Try
            lblMessage.Visible = True
            Dim intRetVal As Integer = 0
            intRetVal = objPay.ETJFApproval(txtAccIDJF.Value, txtJFETID.Value, _
                9, Request.Cookies("UID").Value)
            If intRetVal = 0 Then
                Response.Redirect("ETJFInqList.aspx?Action=" + txtAction.Value)
            ElseIf intRetVal = -1 Then
                btnReject.Visible = False
                btnApprove.Visible = False
                lblMessage.Text = "ET JF (BUYBACK) ACCOUNT ALREADY APPROVED OR REJECTED"
            End If
        Catch ex As Exception
            lblMessage.Text = "ET JF (BUYBACK) APPROVE ERROR : " & ex.Message
        Finally
            objPay = Nothing
        End Try

    End Sub

    Protected Sub btnRejectPay_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRejectPay.Click
        Dim objPay As New Payment
        Try
            lblMessage.Visible = True
            Dim intRetVal As Integer = 0
            intRetVal = objPay.ETJFRejectAfterApp(txtAccIDJF.Value, txtJFETID.Value, _
                Request.Cookies("UID").Value)
            If intRetVal = 0 Then
                Response.Redirect("ETJFInqList.aspx?Action=" + txtAction.Value)
            ElseIf intRetVal = -1 Then
                lblMessage.Text = "ET JF (BUYBACK) ACCOUNT ALREADY REJECTED OR PAID"
                btnReject.Visible = False
                btnCancel.Focus()
            End If


        Catch ex As Exception
            lblMessage.Text = "ET JF (BUYBACK) REJECT AFTER APPROVE ERROR : " & ex.Message
        Finally
            objPay = Nothing
        End Try
    End Sub

    Protected Sub btnProcess_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcess.Click
        Dim objPay As New Payment
        Try
            lblMessage.Visible = True
            Dim intRetVal As Integer = 0
            intRetVal = objPay.ETJFPayment(txtAccIDJF.Value, txtJFETID.Value, _
                ddlAccountNo.SelectedValue, Request.Cookies("UID").Value)
            If intRetVal = 0 Then
                Response.Redirect("ETJFInqList.aspx?Action=" + txtAction.Value)
            ElseIf intRetVal = -1 Then
                lblMessage.Text = "ET JF (BUYBACK) ACCOUNT ALREADY PAID OR REJECTED "
                btnProcess.Visible = False
                btnCancel.Focus()
            End If


        Catch ex As Exception
            lblMessage.Text = "ET JF (BUYBACK) PAYMENT ERROR : " & ex.Message
        Finally
            objPay = Nothing
        End Try
    End Sub
End Class
