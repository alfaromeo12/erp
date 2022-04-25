Partial Class Txn_RSBatchApp
    Inherits System.Web.UI.Page
    Public Shared strAppDate As String

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Response.Write(Request.Cookies("AppDate").Value)

        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE FROM APPSETTING WHERE APPCODE='APPDATE'")
            If oSDR.Read Then
                strAppDate = oSDR("APPVALUE").ToString()
                If Not IsPostBack() Then
                    txtTxnDate.Text = strAppDate
                    txtTxnDateTo.Text = strAppDate
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

            'DataSearch()
        End If
    End Sub



    Private Sub DataSearch()

        gvData.DataBind()
        'gvSummary.DataBind()

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

    'Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
    '    Dim objDB As New DBX
    '    Try
    '        objDB.ExecSP("RESCHEDULEAddPerJF", _
    '            objDB.MP("@BOOKFROM", Data.SqlDbType.DateTime, ConvertDate(txtTxnDate.Text), 20, Data.ParameterDirection.Input), _
    '                objDB.MP("@BOOKTO", Data.SqlDbType.DateTime, ConvertDate(txtTxnDateTo.Text), 20, Data.ParameterDirection.Input), _
    '                objDB.MP("@JFID", Data.SqlDbType.Int, ddlJF.SelectedValue, 20, Data.ParameterDirection.Input), _
    '                objDB.MP("@NEWEFFRATE", Data.SqlDbType.Float, txtEffRAte.Text, 20, Data.ParameterDirection.Input), _
    '                objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 20, Data.ParameterDirection.Input) _
    '                )

    '        'objCore.ACCOUNTDISBURSEPlanPaidBatch(ConvertDate(txtEffRAte.Text), ConvertDate(txtTxnDate.Text), ddlJF.SelectedValue, _
    '        '    Request.Cookies("UID").Value)
    '        DataSearch()
    '        'Catch ex As Exception
    '    Finally
    '        objDB.Close()
    '        objDB = Nothing

    '    End Try
    'End Sub

    Protected Sub btnApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApprove.Click
        lblMessage.Visible = False
        Dim objDB As New DBX
        Try
            objDB.ExecSP("[RESCHEDULEApprovalPerBranch]", _
                objDB.MP("@BOOKFROM", Data.SqlDbType.DateTime, ConvertDate(txtTxnDate.Text), 20, Data.ParameterDirection.Input), _
                    objDB.MP("@BOOKTO", Data.SqlDbType.DateTime, ConvertDate(txtTxnDateTo.Text), 20, Data.ParameterDirection.Input), _
                    objDB.MP("@BRANCHID", Data.SqlDbType.Int, ddlBranch.SelectedValue, 20, Data.ParameterDirection.Input), _
                    objDB.MP("@RSSTATUS", Data.SqlDbType.Int, 1, 20, Data.ParameterDirection.Input), _
                    objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 20, Data.ParameterDirection.Input) _
                    )
            lblMessage.Visible = True
            lblMessage.Text = "RESCHEDULE APPROVE BATCH SAVED COMPLETED...!"
            DataSearch()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RESCHEDULE APPROVE BATCH: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE..!"
        Finally
            objDB.Close()
            objDB = Nothing

        End Try
    End Sub

    Protected Sub btnReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReject.Click
        lblMessage.Visible = False
        Dim objDB As New DBX
        Try
            objDB.ExecSP("[RESCHEDULEApprovalPerBranch]", _
                objDB.MP("@BOOKFROM", Data.SqlDbType.DateTime, ConvertDate(txtTxnDate.Text), 20, Data.ParameterDirection.Input), _
                    objDB.MP("@BOOKTO", Data.SqlDbType.DateTime, ConvertDate(txtTxnDateTo.Text), 20, Data.ParameterDirection.Input), _
                    objDB.MP("@BRANCHID", Data.SqlDbType.Int, ddlBranch.SelectedValue, 20, Data.ParameterDirection.Input), _
                    objDB.MP("@RSSTATUS", Data.SqlDbType.Int, 9, 20, Data.ParameterDirection.Input), _
                    objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 20, Data.ParameterDirection.Input) _
                    )
            lblMessage.Visible = True
            lblMessage.Text = "RESCHEDULE REJECT BATCH SAVED COMPLETED...!"
            DataSearch()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RESCHEDULE REJECT BATCH: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE..!"
        Finally
            objDB.Close()
            objDB = Nothing

        End Try
    End Sub
End Class
