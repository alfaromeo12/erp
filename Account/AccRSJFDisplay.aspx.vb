
Partial Class Account_AccRSJFDisplay
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim objDB As New DBX
        If Not IsPostBack() Then
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppDate() APPDATE ")
            If oSDR.Read() Then
                hidTxnDate.Value = oSDR("APPDATE").ToString()
            End If
            oSDR.Close()
            oSDR = Nothing
            'Dim strLocID As String = "", strAccID As String = ""

            hidLocID.Value = Request.QueryString("LOCID")
            hidAccID.Value = Request.QueryString("ACCID")
            hidRSID.Value = Request.QueryString("RSID")
            hidAccIDJF.Value = Request.QueryString("ACCIDJF")

            ctlAccountJFbyACCIDJF.ACCIDJF = hidAccIDJF.Value

            ctlDataAccountFromParamAccIDOS.LOCID = hidLocID.Value
            ctlDataAccountFromParamAccIDOS.ACCID = hidAccID.Value

            ctlJFInstallmentDataAll.ACCIDJF = hidAccIDJF.Value
            ctlJFInstallmentDataAll.TXNDATE = hidTxnDate.Value

            txtAction.Value = Request.QueryString("Action")
            If txtAction.Value = "APP" Then
                btnApprove.Visible = True
                btnReject.Visible = True
            End If
        End If
    End Sub


    Protected Sub btnApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApprove.Click
        Dim objDB As New DBX
        Try

            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("[RESCHEDULEJFApproval]", _
                    objDB.MP("@ACCIDJF", Data.SqlDbType.BigInt, hidAccIDJF.Value, 20, Data.ParameterDirection.Input), _
                    objDB.MP("@RSID", Data.SqlDbType.BigInt, hidRSID.Value, 20, Data.ParameterDirection.Input), _
                    objDB.MP("@RSSTATUS", Data.SqlDbType.Float, 1, 20, Data.ParameterDirection.Input), _
                    objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value, 20, Data.ParameterDirection.Input), _
                    objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 20, Data.ParameterDirection.InputOutput) _
                    )
            intRetVal = oSQLParam("@RETVAL").Value
            'Response.Write("<script type='text/javascript'>")
            'Response.Write("window.history.back(-2);")
            'Response.Write("</script>")
            lblMessage.Visible = True
            If intRetVal = -1 Then
                lblMessage.Text = "MESSAGE : Reschedule JF ALREADY APPROVED or REJECTED..!"
            ElseIf intRetVal = -2 Then
                lblMessage.Text = "MESSAGE : Account has another due.. RESCHEDULE JF must be REJECT first!"
            Else
                lblMessage.Text = "MESSAGE : Reschedule JF data has APPROVED..!"
            End If
            fvRSInfo.DataBind()
            Dim dl As DataList = CType(ctlAccountJFbyACCIDJF.FindControl("dlJF"), DataList)
            If dl IsNot Nothing Then
                dl.DataBind()
            End If
            Dim grv As GridView = CType(ctlJFInstallmentDataAll.FindControl("gvInstallment"), GridView)
            If grv IsNot Nothing Then
                grv.DataBind()
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RESCHEDULE JF APPROVED : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            Throw
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

            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("[RESCHEDULEJFApproval]", _
                    objDB.MP("@ACCIDJF", Data.SqlDbType.BigInt, hidAccIDJF.Value, 20, Data.ParameterDirection.Input), _
                    objDB.MP("@RSID", Data.SqlDbType.BigInt, hidRSID.Value, 20, Data.ParameterDirection.Input), _
                    objDB.MP("@RSSTATUS", Data.SqlDbType.Float, 9, 20, Data.ParameterDirection.Input), _
                    objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value, 20, Data.ParameterDirection.Input), _
                    objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 20, Data.ParameterDirection.InputOutput) _
                    )
            intRetVal = oSQLParam("@RETVAL").Value
            'Response.Write("<script type='text/javascript'>")
            'Response.Write("window.history.back(-2);")
            'Response.Write("</script>")
            lblMessage.Visible = True
            If intRetVal = -1 Then
                lblMessage.Text = "MESSAGE : Reschedule JF ALREADY APPROVED or REJECTED..!"
            Else
                lblMessage.Text = "MESSAGE : Reschedule JF data has REJECTED..!"
            End If
            fvRSInfo.DataBind()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RESCHEDULE JF REJECTED : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE..!"
            Throw
        Finally
            btnApprove.Visible = False
            btnReject.Visible = False
            objDB.Close()
            objDB = Nothing

        End Try

    End Sub


End Class
