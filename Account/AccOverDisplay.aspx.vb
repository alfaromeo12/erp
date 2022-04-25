Partial Class Account_AccOverApp
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            Dim objDB As New DBX
            Try
                Dim oSDR As Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppDate() APPDATE")
                If oSDR.Read() Then
                    hidTxnDate.Value = oSDR("APPDATE").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing

            Finally
                objDB.Close()
                objDB = Nothing
            End Try

            hidOverID.Value = Request.QueryString("OVERID")
            hidLocID.Value = Request.QueryString("LOCID")
            hidAccID.Value = Request.QueryString("ACCID")
            txtAction.Value = Request.QueryString("Action")


            ctlDataAccountFromParamAccID.LOCID = hidLocID.Value
            ctlDataAccountFromParamAccID.ACCID = hidAccID.Value

            ctlCollectibilityParamAccID.LOCID = hidLocID.Value
            ctlCollectibilityParamAccID.ACCID = hidAccID.Value

            ctlLoanDataFromParamAccID.LOCID = hidLocID.Value
            ctlLoanDataFromParamAccID.ACCID = hidAccID.Value


            ctlInstallmentDataAll.LOCID = hidLocID.Value
            ctlInstallmentDataAll.ACCID = hidAccID.Value


            If txtAction.Value = "APP" Then
                btnApprove.Visible = True
                btnReject.Visible = True
            End If
        End If
        'sdsInstallment.SelectParameters("LOCID").DefaultValue = hidLocID.Value
        'sdsInstallment.SelectParameters("ACCID").DefaultValue = hidAccID.Value
    End Sub

    Protected Sub btnApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApprove.Click
        OverStatusUpdate(1)
    End Sub

    Protected Sub btnReject_Click(sender As Object, e As System.EventArgs) Handles btnReject.Click
        OverStatusUpdate(9)
    End Sub

    Private Sub OverStatusUpdate(ByVal intStatus As Integer)
        Dim objDB As New DBX
        Try

            lblMessage.Visible = True
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection

            oSQLParam = objDB.ExecSPReturnParam("OVERKREDITUpdateStatus", _
                    objDB.MP("@LOCID", Data.SqlDbType.Int, hidLocID.Value), _
                    objDB.MP("@ACCID", Data.SqlDbType.BigInt, hidAccID.Value), _
                    objDB.MP("@OVERID", Data.SqlDbType.Int, hidOverID.Value), _
                    objDB.MP("@OVERSTATUS", Data.SqlDbType.Int, intStatus), _
                    objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value), _
                    objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 20, Data.ParameterDirection.InputOutput) _
                    )
            intRetVal = oSQLParam("@RETVAL").Value

            If intRetVal = -1 Then
                lblMessage.Text = "MESSAGE : OVER CREDIT data ALREADY APPROVED OR REJECTED..!<br>PLEASE CHECK ACCOUNT IN OVER CREDIT INQUIRY...!"
            ElseIf intRetVal = -2 Then
                lblMessage.Text = "MESSAGE : ACCOUNT OVER CREDIT ALREADY CLOSED..!<br>PLEASE CHECK ACCOUNT IN ACCOUNT INQUIRY...!"
            ElseIf intRetVal = 0 Then
                Response.Redirect("AccOverList.aspx?Action=" & txtAction.Value)
            End If

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR OVER CREDIT APPROVAL : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
            'Throw
        Finally
            btnApprove.Visible = False
            btnReject.Visible = False
            objDB.Close()
            objDB = Nothing

        End Try

    End Sub


End Class
