
Partial Class Txn_DisbBatchApp
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Response.Write(Request.Cookies("AppDate").Value)
        txtUID.Value = Request.Cookies("UID").Value
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            If Not IsPostBack() Then
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE, CAST(dbo.f_IsUserBranch(" & Request.Cookies("UID").Value & ") as VARCHAR(10)) ISUSERBRANCH FROM APPSETTING WITH(NOLOCK) WHERE APPCODE='APPDATE'")
                If oSDR.Read Then
                    txtAppDate.Value = oSDR("APPVALUE").ToString()
                    If Not IsPostBack() Then
                        txtPaidFrom.Text = txtAppDate.Value
                        txtPaidTo.Text = txtAppDate.Value
                        txtPaidTxnDate.Text = txtAppDate.Value
                        txtPaidDate.Text = txtAppDate.Value
                        ddlTxnType.SelectedValue = "2"
                    End If
                    hidIsUserBranch.Value = oSDR("ISUSERBRANCH").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing
                ajaxCDDArea.ContextKey = txtUID.Value
                ajaxCDDBranch.ContextKey = txtUID.Value
                If hidIsUserBranch.Value = "1" Then 'user cabang
                    oSDR = objDB.CreateSDRFromSQLSelect("SELECT BRANCH.BRANCHID, BRANCH.AREAID FROM APPUSER WITH(NOLOCK) INNER JOIN BRANCH ON APPUSER.BRANCHID=BRANCH.BRANCHID WHERE APPUSER.UID=" & Request.Cookies("UID").Value)
                    If oSDR.Read() Then
                        ajaxCDDArea.SelectedValue = oSDR("AREAID").ToString()
                        ajaxCDDBranch.SelectedValue = oSDR("BRANCHID").ToString()
                    End If
                    oSDR.Close()
                    oSDR = Nothing
                End If
            End If

            'Catch ex As Exception
            'Throw
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
        If hidIsUserBranch.Value = "1" Then 'jika user cabang, filter berdasarkan cabang yang berhak saja
            Me.sdsGrid.SelectCommand = Replace(Me.sdsGrid.SelectCommand, "(1 = 1)", " BRANCH.BRANCHID IN (SELECT BRANCHID FROM dbo.f_getAPPUSERBRANCHList(" & txtUID.Value & "))")
        End If
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
    End Sub

    Private Sub SetFormValidation()
        ddlTxnType.Attributes.Add("onchange", "TxnTypeChange()")
    End Sub

    Protected Sub btnApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApprove.Click
        lblMessage.Visible = False
        Dim objCore As New Core
        Try
            objCore.ACCOUNTDISBURSEApproveBatch(ConvertDate(txtPaidFrom.Text), ConvertDate(txtPaidTo.Text), _
                    ddlBranch.SelectedValue, ddlTxnType.SelectedValue, ddlAccountNo.SelectedValue, _
                    ConvertDate(txtPaidDate.Text), Request.Cookies("UID").Value)
            lblMessage.Visible = True
            lblMessage.Text = "DISBURSE APPROVAL BATCH PROCESS COMPLETED...!"
            DataSearch()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR DISBURSE APPROVAL BATCH: " & ex.Message & "PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objCore = Nothing

        End Try
    End Sub

    Protected Sub btnReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReject.Click
        lblMessage.Visible = False
        Dim objCore As New Core
        Try
            objCore.ACCOUNTDISBURSERejectBatch(ConvertDate(txtPaidFrom.Text), ConvertDate(txtPaidTo.Text), _
                    ddlBranch.SelectedValue, Request.Cookies("UID").Value)
            DataSearch()
            lblMessage.Visible = True
            lblMessage.Text = "DISBURSE REJECT BATCH PROCESS COMPLETED...!"
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR DISBURSE REJECT BATCH: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objCore = Nothing

        End Try

    End Sub

End Class
