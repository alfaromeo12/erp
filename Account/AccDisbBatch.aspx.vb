
Partial Class Txn_DisbBatch
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Response.Write(Request.Cookies("AppDate").Value)
        txtUID.Value = Request.Cookies("UID").Value
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try

            If Not IsPostBack() Then
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE, CAST(dbo.f_IsUserBranch(" & txtUID.Value & ") as VARCHAR(10)) ISUSERBRANCH FROM APPSETTING WITH(NOLOCK) WHERE APPCODE='APPDATE'")
                If oSDR.Read Then
                    txtAppDate.Value = oSDR("APPVALUE").ToString()
                    If Not IsPostBack() Then
                        txtBookFrom.Text = txtAppDate.Value
                        txtBookTo.Text = txtAppDate.Value
                        txtPlanPaid.Text = txtAppDate.Value
                        rbReceive.Checked = True
                    End If
                    hidIsUserBranch.Value = oSDR("ISUSERBRANCH").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing
                txtAction.Value = Request.QueryString("Action")
                txtSPV.Value = Request.QueryString("SPV")
                pnlInit.Visible = False

                ajaxCDDArea.ContextKey = txtUID.Value
                ajaxCDDBranch.ContextKey = txtUID.Value
                If hidIsUserBranch.Value = "1" Then 'user cabang
                    oSDR = objDB.CreateSDRFromSQLSelect("SELECT BRANCH.BRANCHID, BRANCH.AREAID FROM APPUSER WITH(NOLOCK) INNER JOIN BRANCH ON APPUSER.BRANCHID=BRANCH.BRANCHID WHERE APPUSER.UID=" & txtUID.Value)
                    If oSDR.Read() Then
                        ajaxCDDArea.SelectedValue = oSDR("AREAID").ToString()
                        ajaxCDDBranch.SelectedValue = oSDR("BRANCHID").ToString()
                    End If
                    oSDR.Close()
                    oSDR = Nothing
                End If
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR LOADING DISBURSE INPUT BATCH: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

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
            btnSave.Enabled = False
            btnPrint.Enabled = False
            pnlInit.Visible = False
        Else
            btnSave.Enabled = True
            btnPrint.Enabled = True
            pnlInit.Visible = True
        End If
    End Sub

    Protected Sub btnView_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnView.Click
        lblMessage.Visible = False
        DataSearch()
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        lblMessage.Visible = False
        Dim objCore As New Core
        Try
            Dim intReceive As Integer = 0
            If rbReceive.Checked Then
                intReceive = 1
            End If
            objCore.ACCOUNTDISBURSEPlanPaidBatch(ConvertDate(txtPlanPaid.Text), _
                ConvertDate(txtBookFrom.Text), ConvertDate(txtBookTo.Text), _
                ddlBranch.SelectedValue, intReceive, _
                Request.Cookies("UID").Value)
            lblMessage.Visible = True
            lblMessage.Text = "DISBURSE INPUT BATCH SAVED COMPLETED...!"
            DataSearch()

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR DISBURSE INPUT BATCH: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objCore = Nothing

        End Try
    End Sub

End Class
