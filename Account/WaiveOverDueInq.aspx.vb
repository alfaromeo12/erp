
Partial Class Account_WaiveOverDueInq
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
            hidWAIVEID.Value = Request.QueryString("WAIVEODID")
            txtACCOUNTNO.Value = Request.QueryString("ACCNO")
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

                InstallmentDataDue1.LOCID = txtLocID.Value
                InstallmentDataDue1.ACCID = txtAccID.Value
                InstallmentDataDue1.TXNDATE = ConvertDate(txtTxnDate.Value)

                sdsWaiveOD.SelectParameters("LOCID").DefaultValue = txtLocID.Value
                sdsWaiveOD.SelectParameters("ACCID").DefaultValue = txtAccID.Value
                sdsWaiveOD.SelectParameters("WAIVEODID").DefaultValue = hidWAIVEID.Value
                GetData()
            End If
            oSDR.Close()
            oSDR = Nothing

        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Private Sub GetData()
        Dim objDB As New DBX
        Try

            Dim strDecPointNet As String = ""
            Dim oSDRCATEGORYFIN As System.Data.SqlClient.SqlDataReader
            oSDRCATEGORYFIN = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getCurrencyDecPointForNet(ACCOUNT.CURRENCYID) DecPointNet, " & _
                    "dbo.f_getTermPrincipal(ACCOUNT.FINCATID) AS FINCATPRINCIPAL ,dbo.f_getTermInterest(ACCOUNT.FINCATID) AS FINCATINTEREST FROM ACCOUNT WITH(NOLOCK) WHERE LOCID=" & txtLocID.Value & " AND ACCID= " & txtAccID.Value & "")
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
                " ISNULL(SUM(INSTDIFF-INSTDIFFPAID-INSTDIFFWAIVE), 0) INSTDIFFUNPAID, " & _
                " ISNULL(SUM(PENALTY), 0) PENALTY FROM dbo.f_AccInstalmentDueList(" & txtLocID.Value & ", " & txtAccID.Value & ", Convert(datetime, '" & txtTxnDate.Value & "', 103)) WHERE (DueDate <= dbo.f_getAppDate())")
            If oSDRAcc.Read() Then
                If oSDRAcc("PRINCIPALUNPAID") = 0 And oSDRAcc("PENALTY") = 0 And oSDRAcc("INTERESTUNPAID") = 0 Then
                    txtPrincipalDue.Text = String.Format(strDecPointNet, oSDRAcc("PRINCIPALUNPAID"))
                    txtPenaltyDue.Text = String.Format(strDecPointNet, oSDRAcc("PENALTY"))
                    txtInterestDue.Text = String.Format(strDecPointNet, oSDRAcc("INTERESTUNPAID"))
                    txtInstDiffDue.Text = String.Format(strDecPointNet, oSDRAcc("INSTDIFFUNPAID"))
                    txtInstallmentDue.Text = String.Format(strDecPointNet, oSDRAcc("PRINCIPALUNPAID") + oSDRAcc("INTERESTUNPAID") + oSDRAcc("PENALTY") + oSDRAcc("INSTDIFFUNPAID"))
                Else
                    txtPrincipalDue.Text = String.Format(strDecPointNet, oSDRAcc("PRINCIPALUNPAID"))
                    txtPenaltyDue.Text = String.Format(strDecPointNet, oSDRAcc("PENALTY"))
                    txtInterestDue.Text = String.Format(strDecPointNet, oSDRAcc("INTERESTUNPAID"))
                    txtInstDiffDue.Text = String.Format(strDecPointNet, oSDRAcc("INSTDIFFUNPAID"))
                    txtInstallmentDue.Text = String.Format(strDecPointNet, oSDRAcc("PRINCIPALUNPAID") + oSDRAcc("INTERESTUNPAID") + oSDRAcc("PENALTY") + oSDRAcc("INSTDIFFUNPAID"))
                End If
            Else
                txtPrincipalDue.Text = 0
                txtPenaltyDue.Text = 0
                txtInterestDue.Text = 0
                txtInstallmentDue.Text = 0
                txtInstDiffDue.Text = "0"
            End If
            oSDRAcc.Close()
            oSDRAcc = Nothing


            oSDRAcc = objDB.CreateSDRFromSQLSelect("SELECT WAIVEINTEREST,WAIVEPENALTY,WAIVEPRINCIPAL,REMARK, WAIVEINSTDIFF FROM WAIVEOD WITH(NOLOCK)" & _
                            " WHERE LOCID=" & txtLocID.Value & " AND ACCID=" & txtAccID.Value & " AND WAIVEODID=" & hidWAIVEID.Value & "")
            If oSDRAcc.Read() Then
                txtWaivePrincipalDue.Text = String.Format(strDecPointNet, oSDRAcc("WAIVEPRINCIPAL"))
                txtWaiveInterestDue.Text = String.Format(strDecPointNet, oSDRAcc("WAIVEINTEREST"))
                txtWaivePenaltyDue.Text = String.Format(strDecPointNet, oSDRAcc("WAIVEPENALTY"))
                txtWaiveInstDiffDue.Text = String.Format(strDecPointNet, oSDRAcc("WAIVEINSTDIFF"))
                txtWaiveInstallmentDue.Text = String.Format(strDecPointNet, oSDRAcc("WAIVEPRINCIPAL") + oSDRAcc("WAIVEINTEREST") + oSDRAcc("WAIVEPENALTY") + oSDRAcc("WAIVEINSTDIFF"))
                txtRemark.Text = oSDRAcc("REMARK").ToString()
            End If
            oSDRAcc.Close()
            oSDRAcc = Nothing




        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR WAIVE OVER DUE VIEW (INQUIRY): " & ex.Message & "<br>PLEASE CHECK DETAIL ERROR...!"
            lblMessage.Focus()
            'Throw
        Finally
            objDB.Close()
            objDB = Nothing

        End Try

    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As System.EventArgs) Handles btnCancel.Click
        Response.Redirect("../Pay/PayWaiveList.aspx?Action=" + txtAction.Value)
    End Sub
End Class
