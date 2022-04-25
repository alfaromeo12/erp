Partial Class Account_AccRSEntry
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            hidLocID.Value = Request.QueryString("LOCID")
            hidAccID.Value = Request.QueryString("ACCID")
            hidRSID.Value = Request.QueryString("RSID")
            txtAction.Value = Request.QueryString("Action")

            Dim objDB As New DBX
            Try
                Dim oSDR As Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppDate() APPDATE, RSTYPE FROM RESCHEDULE WITH(NOLOCK) WHERE LOCID=" & hidLocID.Value & " AND ACCID=" & hidAccID.Value & " AND RSID=" & hidRSID.Value)
                If oSDR.Read() Then
                    hidTxnDate.Value = oSDR("APPDATE").ToString()
                    txtPaidTxnDate.Text = String.Format("{0:dd/MM/yyyy}", oSDR("APPDATE"))
                    hidRSTYPE.Value = oSDR("RSTYPE").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing

                If hidRSTYPE.Value = "4" Then
                    dlRSPayment.Visible = True
                End If

                oSDR = objDB.CreateSDRFromSQLSelect("SELECT FINCATID FROM ACCOUNT WITH(NOLOCK) WHERE LOCID=" & hidLocID.Value & " AND ACCID=" & hidAccID.Value)
                If oSDR.Read() Then
                    ajaxCCDBankAcc.ContextKey = Request.Cookies("UID").Value & "," & oSDR("FINCATID").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing


            Finally
                objDB.Close()
                objDB = Nothing
            End Try
            ctlDataAccountFromParamAccIDOS.LOCID = hidLocID.Value
            ctlDataAccountFromParamAccIDOS.ACCID = hidAccID.Value

            ctlCollectibilityParamAccID.LOCID = hidLocID.Value
            ctlCollectibilityParamAccID.ACCID = hidAccID.Value

            ctlLoanDataFromParamAccID.LOCID = hidLocID.Value
            ctlLoanDataFromParamAccID.ACCID = hidAccID.Value

            ctlInstallmentDataAll.LOCID = hidLocID.Value
            ctlInstallmentDataAll.ACCID = hidAccID.Value

            If txtAction.Value = "APP" Then
                btnApprove.Visible = True
                btnReject.Visible = True
            ElseIf txtAction.Value = "PAY" Then
                pnlPayment.Visible = True
                ddlTxnType.Attributes.Add("onchange", "TxnTypeChange();")
                btnPaid.Visible = True
                btnPaid.Focus()
            End If

            Dim strLocID As String = "", strAccID As String = ""
        End If
    End Sub


    Protected Sub btnApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApprove.Click
        lblMessage.Visible = False
        lblMessage.Text = ""
        Dim objDB As New DBX
        Try

            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("[RESCHEDULEApproval]", _
                    objDB.MP("@LOCID", Data.SqlDbType.Int, hidLocID.Value), _
                    objDB.MP("@ACCID", Data.SqlDbType.BigInt, hidAccID.Value), _
                    objDB.MP("@RSID", Data.SqlDbType.BigInt, hidRSID.Value), _
                    objDB.MP("@RSSTATUS", Data.SqlDbType.Int, 1), _
                    objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value), _
                    objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 20, Data.ParameterDirection.InputOutput) _
                    )
            intRetVal = oSQLParam("@RETVAL").Value
            'Response.Write("<script type='text/javascript'>")
            'Response.Write("window.history.back(-2);")
            'Response.Write("</script>")
            lblMessage.Visible = True
            If intRetVal = -1 Then
                lblMessage.Text = "MESSAGE : Reschedule ALREADY APPROVED or REJECTED..!"
            ElseIf intRetVal = -2 Then
                lblMessage.Text = "MESSAGE : Account has another due/OS Principal Current has change.. !RESCHEDULE must be REJECT first!"
            ElseIf intRetVal = -3 Then
                lblMessage.Text = "MESSAGE : Interest Accrued for Reschedule Installment Day must be paid first..!Reschedule can not be done..!"
            Else
                lblMessage.Text = "MESSAGE : Reschedule data has APPROVED..!"
            End If
            lblMessage.Focus()
            'ctlInstallmentDataAll.LOCID = hidLocID.Value
            'ctlInstallmentDataAll.ACCID = hidAccID.Value
            Dim grv As GridView = CType(ctlInstallmentDataAll.FindControl("gvInstallment"), GridView)
            If grv IsNot Nothing Then
                grv.DataBind()
            End If
            Dim dl As DataList = CType(ctlLoanDataFromParamAccID.FindControl("dlLoanData"), DataList)
            If dl IsNot Nothing Then
                dl.DataBind()
            End If

            dl = CType(ctlDataAccountFromParamAccIDOS.FindControl("dlAppID"), DataList)
            If dl IsNot Nothing Then
                dl.DataBind()
            End If

            fvRSInfo.DataBind()

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RESCHEDULE APPROVED : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
        Finally
            btnApprove.Visible = False
            btnReject.Visible = False
            objDB.Close()
            objDB = Nothing

        End Try

    End Sub

    Protected Sub btnReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReject.Click
        Dim objDB As New DBX
        Try
            lblMessage.Visible = False
            lblMessage.Text = ""
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("[RESCHEDULEApproval]", _
                    objDB.MP("@LOCID", Data.SqlDbType.Int, hidLocID.Value), _
                    objDB.MP("@ACCID", Data.SqlDbType.BigInt, hidAccID.Value), _
                    objDB.MP("@RSID", Data.SqlDbType.BigInt, hidRSID.Value), _
                    objDB.MP("@RSSTATUS", Data.SqlDbType.Int, 9), _
                    objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value), _
                    objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 20, Data.ParameterDirection.InputOutput) _
                    )
            intRetVal = oSQLParam("@RETVAL").Value
            'Response.Write("<script type='text/javascript'>")
            'Response.Write("window.history.back(-2);")
            'Response.Write("</script>")
            lblMessage.Visible = True
            If intRetVal = -1 Then
                lblMessage.Text = "MESSAGE : Reschedule ALREADY APPROVED or REJECTED..!"
                lblMessage.Focus()
            Else
                lblMessage.Text = "MESSAGE : Reschedule data has REJECTED..!"
                lblMessage.Focus()
            End If
            fvRSInfo.DataBind()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RESCHEDULE REJECTED : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE..!"
            lblMessage.Focus()
        Finally
            btnApprove.Visible = False
            btnReject.Visible = False
            objDB.Close()
            objDB = Nothing

        End Try

    End Sub


    Protected Sub btnPaid_Click(sender As Object, e As System.EventArgs) Handles btnPaid.Click
        lblMessage.Visible = False
        lblMessage.Text = ""
        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("[RESCHEDULEPayment]", _
                    objDB.MP("@LOCID", Data.SqlDbType.Int, hidLocID.Value), _
                    objDB.MP("@ACCID", Data.SqlDbType.BigInt, hidAccID.Value), _
                    objDB.MP("@RSID", Data.SqlDbType.BigInt, hidRSID.Value), _
                    objDB.MP("@INTERESTTXNTYPE", Data.SqlDbType.Int, ddlTxnType.SelectedValue), _
                    objDB.MP("@INTERESTACCOUNTID", Data.SqlDbType.Int, ddlAccountNo.SelectedValue), _
                    objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value), _
                    objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 20, Data.ParameterDirection.InputOutput) _
                    )
            intRetVal = oSQLParam("@RETVAL").Value
            If intRetVal = -1 Then
                lblMessage.Visible = True
                lblMessage.Text = "MESSAGE : Reschedule Payment already PAID..!"
                lblMessage.Focus()
            Else
                lblMessage.Visible = True
                lblMessage.Text = "MESSAGE : Reschedule Payment completed succefully..!"
                lblMessage.Focus()
            End If

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RESCHEDULE PAYMENT: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE..!"
            lblMessage.Focus()
        Finally
            dlRSPayment.DataBind()
            pnlPayment.Visible = False
            btnPaid.Visible = False
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub
End Class
