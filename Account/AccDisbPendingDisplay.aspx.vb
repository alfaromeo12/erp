
Partial Class Account_DisbPendingInfo
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then

            txtLocID.Value = Request.QueryString("LOCID")
            txtAccID.Value = Request.QueryString("ACCID")
            txtAction.Value = Request.QueryString("Action")
            ctlDataAccountFromParamAccID.LOCID = txtLocID.Value
            ctlDataAccountFromParamAccID.ACCID = txtAccID.Value
            ctlCollateralDataFromAccID.LOCID = txtLocID.Value
            ctlCollateralDataFromAccID.ACCID = txtAccID.Value
            Dim objDB As New DBX
            Try
                Dim oSDR As System.Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppSetting('APPDATE') APPDATE")
                If oSDR.Read() Then
                    If txtAction.Value = "INIT" Then
                        'txtPlanPaid.Text = oSDR("APPDATE").ToString()
                        hidDisburseSts.Value = "0"

                    ElseIf txtAction.Value = "APP" Then
                        ddlTxnType.SelectedValue = 2
                        txtPaidTxnDate.Text = oSDR("APPDATE").ToString()
                        'txtPaidDate.Text = oSDR("APPDATE").ToString()
                        hidDisburseSts.Value = "1"
                    Else
                        hidDisburseSts.Value = "-1"

                    End If

                    txtAppDate.Value = oSDR("APPDATE").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing

                'CARI DEALERID
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT DEALERID FROM COLLATERAL WITH(NOLOCK) WHERE LOCID=" & txtLocID.Value & " AND ACCID=" & txtAccID.Value)
                If oSDR.Read() Then
                    hidDealerID.Value = oSDR("DEALERID")
                End If
                oSDR.Close()
                oSDR = Nothing

                If txtAction.Value <> "INIT" Then
                    oSDR = objDB.CreateSDRFromSQLSelect("SELECT PENDINGPAIDDATE, PENDINGTXNTYPE, PENDINGACCOUNTID, PENDINGDEALERACCOUNTID FROM ACCOUNTDTL WITH(NOLOCK) WHERE LOCID=" & txtLocID.Value & " AND ACCID=" & txtAccID.Value)
                    If oSDR.Read() Then
                        'If Not String.IsNullOrEmpty(oSDR("PLANPAIDDATE").ToString()) Then
                        '    'txtPlanPaid.Text = String.Format("{0:dd/MM/yyyy}", oSDR("PLANPAIDDATE"))
                        'Else
                        '    'txtPlanPaid.Text = ""
                        'End If
                        If txtAction.Value = "INQ" Then
                            If Not String.IsNullOrEmpty(oSDR("PENDINGPAIDDATE").ToString()) Then
                                txtPaidTxnDate.Text = String.Format("{0:dd/MM/yyyy}", oSDR("PENDINGPAIDDATE"))
                            Else
                                txtPaidTxnDate.Text = ""
                            End If

                            'If Not String.IsNullOrEmpty(oSDR("PAIDDATE").ToString()) Then
                            '    txtPaidDate.Text = String.Format("{0:dd/MM/yyyy}", oSDR("PAIDDATE"))
                            'Else
                            '    txtPaidDate.Text = ""
                            'End If
                            If Not String.IsNullOrEmpty(oSDR("PENDINGTXNTYPE").ToString()) Then
                                ddlTxnType.SelectedValue = oSDR("PENDINGTXNTYPE").ToString()
                            End If
                            If Not String.IsNullOrEmpty(oSDR("PENDINGACCOUNTID").ToString()) Then
                                ddlAccountNo.SelectedValue = oSDR("PENDINGACCOUNTID").ToString()
                            End If

                            If Not String.IsNullOrEmpty(oSDR("PENDINGDEALERACCOUNTID").ToString()) Then
                                ddlDealerAccount.SelectedValue = oSDR("PENDINGDEALERACCOUNTID")
                            End If
                        End If


                    End If
                    oSDR.Close()
                    oSDR = Nothing

                    oSDR = objDB.CreateSDRFromSQLSelect("SELECT PENDINGSTS FROM ACCOUNTDTL WITH(NOLOCK) WHERE LOCID=" & txtLocID.Value & " AND ACCID=" & txtAccID.Value)
                    If oSDR.Read() Then
                        If oSDR("PENDINGSTS").ToString() = "2" Then
                            btnJournal.Visible = True
                        End If
                    End If
                    oSDR.Close()
                    oSDR = Nothing



                End If


                FormValidation()
                ''JIKA BELUM DI DISBURSE, PENDING-NYA JANGAN DI DISBURSE DULU
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT DISBURSESTS, FINCATID FROM ACCOUNT WITH(NOLOCK) WHERE LOCID=" & txtLocID.Value & " AND ACCID=" & txtAccID.Value)
                If oSDR.Read() Then
                    If oSDR("DISBURSESTS").ToString() <> "2" Then
                        btnSave.Visible = False
                    End If
                    ajaxCCDBankAcc.ContextKey = Request.Cookies("UID").Value & "," & oSDR("FINCATID").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing



                'Catch ex As Exception
                '    lblMessage.Visible = True
                '    lblMessage.Text = "ERROR LOADING DISBURSEMENT, ERROR :" & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
                '    lblMessage.Focus()
            Finally
                objDB.Close()
                objDB = Nothing

            End Try


        End If
    End Sub

    Private Sub FormValidation()
        If txtAction.Value = "APP" Then
            pnlDisbursment.Visible = True
            btnApprove.Visible = True
            btnReject.Visible = True
            'pnlInit.Visible = True
            'imgPlanPaid.Visible = False
            'ajaxCEPlanPaid.Enabled = False
            'txtPlanPaid.ReadOnly = True
            'txtPlanPaid.CssClass = "disabled"
            ddlTxnType.Attributes.Add("onchange", "TxnTypeChange();")
            If Not IsPostBack() Then btnApprove.Focus()
        ElseIf txtAction.Value = "INQ" Then
            'pnlInit.Visible = True
            pnlDisbursment.Visible = True
            'txtPlanPaid.ReadOnly = True
            'txtPlanPaid.CssClass = "disabled"
            ddlTxnType.Enabled = False
            ddlTxnType.CssClass = "disabled"
            ddlAccountNo.Enabled = False
            ddlAccountNo.CssClass = "disabled"
            ddlDealerAccount.Enabled = False
            ddlDealerAccount.CssClass = "disabled"
            'txtPaidDate.ReadOnly = True
            'txtPaidDate.CssClass = "disabled"
            'imgPaidDate.Visible = False
            'ajaxCEPaiddate.Enabled = False


            If Not IsPostBack() Then btnCancel.Focus()
        ElseIf txtAction.Value = "INIT" Then
            btnApprove.Visible = False
            btnReject.Visible = False
            btnSave.Visible = True
            'pnlInit.Visible = True
            If Not IsPostBack() Then btnSave.Focus()

        End If
    End Sub



    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click

    End Sub



    Protected Sub btnApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApprove.Click
        Dim objDB As New DBX
        Try
            lblMessage.Visible = True
            Dim intRetVal As Integer = 0
            intRetVal = objDB.ExecSPReturnInteger("ACCOUNTDTLPendingDisbursePaid",
                objDB.MP("@LOCID", Data.SqlDbType.Int, txtLocID.Value),
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, txtAccID.Value),
                objDB.MP("@PENDINGTXNTYPE", Data.SqlDbType.Int, ddlTxnType.SelectedValue),
                objDB.MP("@PENDINGACCOUNTID", Data.SqlDbType.Int, ddlAccountNo.SelectedValue),
                objDB.MP("@PENDINGDEALERACCOUNTID", Data.SqlDbType.BigInt, ddlDealerAccount.SelectedValue),
                objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value)
                )
            If intRetVal = 0 Then
                Response.Redirect("AccDisbPendingList.aspx?Action=" + txtAction.Value)
            ElseIf intRetVal = -1 Then
                btnReject.Visible = False
                btnApprove.Visible = False
                lblMessage.Text = "ACCOUNT PENDING DISBURSEMENT ALREADY APPROVED (PAID) OR REJECTED<BR>PLEASE CHECK THIS ACCOUNT IN DISBURSEMENT INQUIRY...!"
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ACCOUNT PENDING DISBURSEMENT APPROVE ERROR : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReject.Click
        Dim objDB As New DBX
        Try
            lblMessage.Visible = True
            Dim intRetVal As Integer = 0
            intRetVal = objDB.ExecSPReturnInteger("ACCOUNTDtlPendingDisburseReject",
                objDB.MP("@LOCID", Data.SqlDbType.Int, txtLocID.Value),
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, txtAccID.Value),
                objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value)
                )
            If intRetVal = 0 Then
                Response.Redirect("AccDisbPendingList.aspx?Action=" + txtAction.Value)
            ElseIf intRetVal = -1 Then
                btnReject.Visible = False
                btnApprove.Visible = False
                lblMessage.Text = "ACCOUNT PENDING DISBURSEMENT ALREADY APPROVED OR REJECTED<BR>PLEASE CHECK THIS ACCOUNT IN PENDING DISBURSEMENT INQUIRY...!"
                lblMessage.Focus()
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ACCOUNT PENDING DISBURSMENT REJECT ERROR : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        lblMessage.Visible = True
        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            intRetVal = objDB.ExecSPReturnInteger("ACCOUNTDTLPendingDisburseApprove",
                objDB.MP("@LOCID", Data.SqlDbType.Int, txtLocID.Value),
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, txtAccID.Value),
                objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value)
                )
            If intRetVal = -1 Then
                lblMessage.Text = "ACCOUNT DISBURSE STATUS NOT PAID YET..!<BR>PLEASE CHECK THIS ACCOUNT IN DISBURSEMENT INQUIRY...!"
                btnSave.Visible = False
                lblMessage.Focus()
            ElseIf intRetVal = -2 Then
                lblMessage.Text = "PENDING DISBURSE ALREADY APPROVED..!<BR>PLEASE CHECK THIS ACCOUNT IN PENDING DISBURSEMENT INQUIRY...!"
                btnSave.Visible = False
                lblMessage.Focus()

            ElseIf intRetVal = 0 Then
                Response.Redirect("AccDisbPendingList.aspx?Action=" & txtAction.Value)
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ACCOUNT PENDING DISBURSMENT INPUT ERROR : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


End Class
