
Partial Class Account_WODisplay
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack() Then
            Dim dtDate As Date
            Dim dblOSPrincipal, dblOSInterest As Double

            dtDate = Date.Now()

            txtLocID.Value = Request.QueryString("LOCID")
            txtAccID.Value = Request.QueryString("ACCID")
            txtWOID.Value = Request.QueryString("WOID")
            txtAction.Value = Request.QueryString("Action")

            ctlDataAccountFromParamAccID.LOCID = txtLocID.Value
            ctlDataAccountFromParamAccID.ACCID = txtAccID.Value
            ctlLoanDataFromParamAccID.LOCID = txtLocID.Value
            ctlLoanDataFromParamAccID.ACCID = txtAccID.Value

            ctlCollectibilityParamAccID.LOCID = txtLocID.Value
            ctlCollectibilityParamAccID.ACCID = txtAccID.Value

            ctlInstallmentDataAll.LOCID = txtLocID.Value
            ctlInstallmentDataAll.ACCID = txtAccID.Value



            Dim objDB As New DBX
            Try

                Dim oSDR As System.Data.SqlClient.SqlDataReader
                If txtWOID.Value <> "0" Then
                    oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getParamGlobalName('WOSTATUS', WOSTATUS) WOSTATUSNAME, (SELECT DEPOSIT FROM ACCOUNT WITH(NOLOCK) WHERE ACCOUNT.LOCID=WO.LOCID AND ACCOUNT.ACCID=WO.ACCID) DEPOSIT, " & _
                        "(SELECT NEXTDUEDATE FROM ACCOUNT WITH(NOLOCK) WHERE ACCOUNT.LOCID=WO.LOCID AND ACCOUNT.ACCID=WO.ACCID) NEXTDUEDATECUST, " & _
                        " * FROM WO WITH(NOLOCK) WHERE LOCID=" & txtLocID.Value & " AND ACCID=" & txtAccID.Value & " AND WOID=" & txtWOID.Value)
                    If oSDR.Read() Then
                        dtDate = oSDR("WODATE")
                        lblWODate.Text = String.Format("{0:dd/MM/yyyy}", dtDate)
                        lblWOStatus.Text = oSDR("WOSTATUSNAME")
                        dblOSPrincipal = oSDR("OSPRINCIPAL")
                        dblOSInterest = oSDR("OSINTEREST")
                        txtRemark.Text = oSDR("WODESC").ToString()

                        Dim oSDRFINCATEGORY As System.Data.SqlClient.SqlDataReader
                        oSDRFINCATEGORY = objDB.CreateSDRFromSQLSelect("SELECT FINCATID FROM ACCOUNT WITH(NOLOCK) WHERE (LOCID =" & txtLocID.Value & ") AND (ACCID=" & txtAccID.Value & ")")
                        If oSDRFINCATEGORY.Read() Then
                            hidFincatID.Value = oSDRFINCATEGORY("FINCATID").ToString()
                        End If
                        oSDRFINCATEGORY.Close()
                        oSDRFINCATEGORY = Nothing
                        oSDRFINCATEGORY = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getTermPrincipal(" & hidFincatID.Value & ") as NAME")
                        If oSDRFINCATEGORY.Read() Then
                            lblPrincipalDue.Text = oSDRFINCATEGORY("NAME").ToString()
                        End If
                        oSDRFINCATEGORY.Close()
                        oSDRFINCATEGORY = Nothing

                        oSDRFINCATEGORY = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getTermInterest(" & hidFincatID.Value & ") as NAME")
                        If oSDRFINCATEGORY.Read() Then
                            lblInterestDue.Text = oSDRFINCATEGORY("NAME").ToString()
                        End If

                        oSDRFINCATEGORY = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getTermPenalty(" & hidFincatID.Value & ") as NAME")
                        If oSDRFINCATEGORY.Read() Then
                            lblPenaltyDue.Text = oSDRFINCATEGORY("NAME").ToString()
                        End If

                        oSDRFINCATEGORY.Close()
                        oSDRFINCATEGORY = Nothing

                    End If
                    oSDR.Close()
                    oSDR = Nothing
                Else
                    oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppDate() APPDate, " & _
                        " dbo.f_getOSPrincipalRealAccount(" & txtLocID.Value & ", " & txtAccID.Value & ") OSPRINCIPAL, " & _
                        " dbo.f_getOSInterestRealAccount(" & txtLocID.Value & ", " & txtAccID.Value & ") OSINTEREST " _
                        )
                    If oSDR.Read() Then
                        lblWODate.Text = String.Format("{0:dd/MM/yyyy}", dtDate)
                        lblWOStatus.Text = "UNAPPROVE"
                        dtDate = oSDR("APPDate")
                        dblOSPrincipal = oSDR("OSPRINCIPAL")
                        dblOSInterest = oSDR("OSINTEREST")

                        Dim oSDRFINCATEGORY As System.Data.SqlClient.SqlDataReader
                        oSDRFINCATEGORY = objDB.CreateSDRFromSQLSelect("SELECT FINCATID FROM ACCOUNT WITH(NOLOCK) WHERE (LOCID =" & txtLocID.Value & ") AND (ACCID=" & txtAccID.Value & ")")
                        If oSDRFINCATEGORY.Read() Then
                            hidFincatID.Value = oSDRFINCATEGORY("FINCATID").ToString()
                        End If
                        oSDRFINCATEGORY.Close()
                        oSDRFINCATEGORY = Nothing
                        oSDRFINCATEGORY = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getTermPrincipal(" & hidFincatID.Value & ") as NAME")
                        If oSDRFINCATEGORY.Read() Then
                            lblPrincipalDue.Text = oSDRFINCATEGORY("NAME").ToString()
                        End If
                        oSDRFINCATEGORY.Close()
                        oSDRFINCATEGORY = Nothing

                        oSDRFINCATEGORY = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getTermInterest(" & hidFincatID.Value & ") as NAME")
                        If oSDRFINCATEGORY.Read() Then
                            lblInterestDue.Text = oSDRFINCATEGORY("NAME").ToString()
                        End If

                        oSDRFINCATEGORY = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getTermPenalty(" & hidFincatID.Value & ") as NAME")
                        If oSDRFINCATEGORY.Read() Then
                            lblPenaltyDue.Text = oSDRFINCATEGORY("NAME").ToString()
                        End If

                        oSDRFINCATEGORY.Close()
                        oSDRFINCATEGORY = Nothing

                    End If
                    oSDR.Close()
                    oSDR = Nothing
                End If

                txtOSPrincipal.Text = String.Format("{0:N}", dblOSPrincipal)
                txtOSInterest.Text = String.Format("{0:N}", dblOSInterest)

                'Dim oSDRAcc As Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT ISNULL(SUM(PRINCIPAL-PRINCIPALPAID-PRINCIPALWAIVE), 0) PRINCIPALUNPAID, " & _
                    " ISNULL(SUM(INTEREST-INTERESTPAID-INTERESTWAIVE), 0) INTERESTUNPAID, " & _
                    " ISNULL(SUM(PENALTY), 0) PENALTY FROM dbo.f_AccInstalmentDueList(" & txtLocID.Value & ", " & txtAccID.Value & ", '" & dtDate.ToString & "') WHERE (DueDate <= dbo.f_getAppDate())")
                If oSDR.Read() Then
                    txtPrincipalDue.Text = String.Format("{0:N}", oSDR("PRINCIPALUNPAID"))
                    txtPenaltyDue.Text = String.Format("{0:N}", oSDR("PENALTY"))
                    txtInterestDue.Text = String.Format("{0:N}", oSDR("INTERESTUNPAID"))
                    txtInstallmentDue.Text = String.Format("{0:N}", oSDR("PRINCIPALUNPAID") + oSDR("INTERESTUNPAID") + oSDR("PENALTY"))
                Else
                    txtPrincipalDue.Text = 0
                    txtPenaltyDue.Text = 0
                    txtInterestDue.Text = 0
                    txtInstallmentDue.Text = 0
                End If
                oSDR.Close()
                oSDR = Nothing

                'sdsInstallment.SelectParameters("LOCID").DefaultValue = txtLocID.Value
                'sdsInstallment.SelectParameters("ACCID").DefaultValue = txtAccID.Value
                'sdsInstallment.SelectParameters("TXNDATE").DefaultValue = dtDate

                'sdsAccData.SelectParameters("LOCID").DefaultValue = txtLocID.Value
                'sdsAccData.SelectParameters("ACCID").DefaultValue = txtAccID.Value

                'sdsLoanData.SelectParameters("LOCID").DefaultValue = txtLocID.Value
                'sdsLoanData.SelectParameters("ACCID").DefaultValue = txtAccID.Value

                FormValidation()
            Catch ex As Exception
                lblMessage.Visible = True
                lblMessage.Text = "ERROR LOADING WO : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
                lblMessage.Focus()
            Finally

                objDB.Close()
                objDB = Nothing

            End Try

        End If
    End Sub

    Private Sub FormValidation()
        If txtAction.Value = "APP" Then
            btnApprove.Visible = True
            btnReject.Visible = True
            'WaiveDisable()
            If Not IsPostBack() Then btnApprove.Focus()
        ElseIf txtAction.Value = "INQ" Then
            'WaiveDisable()
            txtRemark.ReadOnly = True
            txtRemark.CssClass = "disabled"
            If Not IsPostBack() Then btnCancel.Focus()
        ElseIf txtAction.Value = "INPUT" Then
            btnApprove.Visible = False
            btnReject.Visible = False
            btnSave.Visible = True
            If Not IsPostBack() Then btnSave.Focus()

        End If
    End Sub





    Protected Sub btnApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApprove.Click
        Dim objCore As New Core
        Try
            lblMessage.Visible = True
            Dim intRetVal As Integer = 0
            intRetVal = objCore.WOApproval(txtLocID.Value, txtAccID.Value, txtWOID.Value, _
                1, txtRemark.Text, Request.Cookies("UID").Value)
            If intRetVal = 0 Then
                Response.Redirect("WOInqList.aspx?Action=" + txtAction.Value)
            ElseIf intRetVal = -1 Then
                btnReject.Visible = False
                btnApprove.Visible = False
                lblMessage.Text = "WRITE OFF ACCOUNT ALREADY APPROVED OR REJECTED<BR>PLEASE CHECK THIS ACCOUNT FROM WRITE OFF INQUIRY...!"
                lblMessage.Focus()
            ElseIf intRetVal = -2 Then
                btnApprove.Visible = False
                lblMessage.Text = "OS PRINCIPAL OR OS INTEREST ACCOUNT ALREADY CHANGED...<BR>PLEASE CANCEL THIS WRITE OFF ACCOUNT..!"
                lblMessage.Focus()
            End If
        Catch ex As Exception
            lblMessage.Text = "WRITE OFF APPROVE ERROR : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
        Finally
            objCore = Nothing
        End Try
    End Sub

    Protected Sub btnReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReject.Click
        Dim objCore As New Core
        Try
            lblMessage.Visible = True
            Dim intRetVal As Integer = 0
            intRetVal = objCore.WOApproval(txtLocID.Value, txtAccID.Value, txtWOID.Value, _
                9, txtRemark.Text, Request.Cookies("UID").Value)
            If intRetVal = 0 Then
                Response.Redirect("WOInqList.aspx?Action=" + txtAction.Value)
            ElseIf intRetVal = -1 Then
                btnReject.Visible = False
                btnApprove.Visible = False
                lblMessage.Text = "WRITE OFF ACCOUNT ALREADY APPROVED OR REJECTED<BR>PLEASE CHECK THIS ACCOUNT FROM WRITE OFF INQUIRY...!"
                lblMessage.Focus()
            End If


        Catch ex As Exception
            lblMessage.Text = "WRITE OFF REJECT ERROR : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
        Finally
            objCore = Nothing
        End Try

    End Sub


    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        lblMessage.Visible = True
        Dim objCore As New Core
        Try
            Dim intWOID As Integer = 0, intRetVal As Integer = 0

            intRetVal = objCore.WOAdd(txtLocID.Value, txtAccID.Value, "01/01/1900", 0, _
                    txtOSPrincipal.Text, txtOSInterest.Text, txtRemark.Text, _
                    Request.Cookies("UID").Value, intWOID)
            If intRetVal = -1 Then
                lblMessage.Text = "ACCOUNT ALREADY EXIST IN WRITE OFF DATA<BR>PLEASE CHECK THIS ACCOUNT FROM WRITE OFF INQUIRY...!"
                lblMessage.Focus()
                btnSave.Visible = False
                btnCancel.Focus()
            ElseIf intRetVal = 0 Then
                Response.Redirect("AccForWOList.aspx?Action=" & txtAction.Value)
            End If
        Catch ex As Exception
            lblMessage.Text = "WRITE OFF ADD ACCOUNT ERROR : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
        Finally
            objCore = Nothing
        End Try
    End Sub
End Class
