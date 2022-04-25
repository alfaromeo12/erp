
Partial Class Txn_DisbBatchAppDealer
    Inherits System.Web.UI.Page
    Public Shared strAppDate As String


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Response.Write(Request.Cookies("AppDate").Value)

        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE FROM APPSETTING WHERE APPCODE='APPDATE'")
            If oSDR.Read Then
                strAppDate = oSDR("APPVALUE").ToString()
                If Not IsPostBack() Then
                    txtPaidFrom.Text = strAppDate
                    txtPaidTo.Text = strAppDate
                    txtPaidTxnDate.Text = strAppDate
                    txtPaidDate.Text = strAppDate
                    ddlTxnType.SelectedValue = "2"
                End If
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

        If Not IsPostBack() Then
            'rbReqDate.Checked = True
            txtAction.Value = Request.QueryString("Action")
            txtSPV.Value = Request.QueryString("SPV")

            DataSearch()
        End If
        SetFormValidation()
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub


    Private Sub DataSearch()
        gvData.DataBind()
        gvSummary.DataBind()

        If gvData.Rows.Count <= 0 Then
            btnApprove.Enabled = False
            btnReject.Enabled = False
            btnPrint.Enabled = False
        Else
            btnApprove.Enabled = True
            btnReject.Enabled = True
            btnPrint.Enabled = True
        End If
    End Sub




    Protected Sub btnView_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnView.Click
        lblMessage.Visible = False
        DataSearch()
        ddlDealerAccount.DataBind()
    End Sub

    Private Sub SetFormValidation()
        ddlTxnType.Attributes.Add("onchange", "TxnTypeChange()")
    End Sub

    Protected Sub btnApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApprove.Click
        lblMessage.Visible = False
        Dim objDB As New DBX
        Try
            objDB.ExecSP("[ACCOUNTDISBURSEApproveDealer]", _
                objDB.MP("@PLANPAIDFROM", Data.SqlDbType.DateTime, ConvertDate(txtPaidFrom.Text)), _
                objDB.MP("@PLANPAIDTO", Data.SqlDbType.DateTime, ConvertDate(txtPaidTo.Text)), _
                objDB.MP("@DEALERID", Data.SqlDbType.BigInt, ddlDealer.SelectedValue), _
                objDB.MP("@TXNTYPE", Data.SqlDbType.Int, ddlTxnType.SelectedValue), _
                objDB.MP("@ACCOUNTID", Data.SqlDbType.Int, ddlAccountNo.SelectedValue), _
                objDB.MP("@DEALERACCOUNTID", Data.SqlDbType.BigInt, ddlDealerAccount.SelectedValue), _
                objDB.MP("@PAIDDATE", Data.SqlDbType.DateTime, ConvertDate(txtPaidDate.Text)), _
                objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value) _
            )
            ddlDealer.DataBind()
            ddlDealerAccount.DataBind()
            lblMessage.Visible = True
            lblMessage.Text = "DISBURSE APPROVAL PER DEALER PROCESS COMPLETED...!"
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR DISBURSE APPROVAL PER DEALER: <BR>" & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try


        'Dim objCore As New Core
        'Try
        '    'objCore.ACCOUNTDISBURSEApproveBatch(ConvertDate(txtPaidFrom.Text), ConvertDate(txtPaidTo.Text), _
        '    '        ddlBranch.SelectedValue, ddlTxnType.SelectedValue, ddlAccountNo.SelectedValue, _
        '    '        ConvertDate(txtPaidDate.Text), Request.Cookies("UID").Value)
        '    lblMessage.Visible = True
        '    lblMessage.Text = "DISBURSE APPROVAL BATCH PROCESS COMPLETED...!"
        '    DataSearch()
        'Catch ex As Exception
        '    lblMessage.Visible = True
        '    lblMessage.Text = "ERROR DISBURSE APPROVAL BATCH: " & ex.Message & "PLEASE CHECK DETAIL ERROR MESSAGE...!"
        'Finally
        '    objCore = Nothing

        'End Try
    End Sub

    Protected Sub btnReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReject.Click
        lblMessage.Visible = False
        Dim objDB As New DBX
        Try
            objDB.ExecSP("[ACCOUNTDISBURSERejectDealer]", _
                objDB.MP("@PLANPAIDFROM", Data.SqlDbType.DateTime, ConvertDate(txtPaidFrom.Text)), _
                objDB.MP("@PLANPAIDTO", Data.SqlDbType.DateTime, ConvertDate(txtPaidTo.Text)), _
                objDB.MP("@DEALERID", Data.SqlDbType.BigInt, ddlDealer.SelectedValue), _
                objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value) _
            )
            DataSearch()
            ddlDealer.DataBind()
            ddlDealerAccount.DataBind()
            lblMessage.Visible = True
            lblMessage.Text = "DISBURSE REJECT PER DELAER PROCESS COMPLETED...!"
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR DISBURSE REJECT PER DEALER: <BR>" & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

        'Dim objCore As New Core
        'Try
        '    'objCore.ACCOUNTDISBURSERejectBatch(ConvertDate(txtPaidFrom.Text), ConvertDate(txtPaidTo.Text), _
        '    '        ddlBranch.SelectedValue, Request.Cookies("UID").Value)
        '    DataSearch()
        '    lblMessage.Visible = True
        '    lblMessage.Text = "DISBURSE REJECT BATCH PROCESS COMPLETED...!"
        'Catch ex As Exception
        '    lblMessage.Visible = True
        '    lblMessage.Text = "ERROR DISBURSE REJECT BATCH: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        'Finally
        '    objCore = Nothing

        'End Try

    End Sub

End Class
