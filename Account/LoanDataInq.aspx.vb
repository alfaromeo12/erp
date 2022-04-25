
Partial Class Account_LoanDataInq
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim strLocID As String = Request.QueryString("LOCID")
        Dim strAppID As String = Request.QueryString("APPID")
        Dim strAccID As String = ""
        Dim strLocIDCust As String = "", strCustID As String = ""
        Dim objDB As New DBX
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT LOCIDCUST, CUSTID, ACCID, dbo.f_getAppDate() APPDATE FROM ACCOUNT WITH(NOLOCK) WHERE LOCID=" & strLocID & " AND APPID=" & strAppID)
            If oSDR.Read() Then
                strAccID = oSDR("ACCID").ToString()
                strLocIDCust = oSDR("LOCIDCUST").ToString()
                strCustID = oSDR("CUSTID").ToString()
                hiLocID.Value = strLocID
                hiACCID.Value = strAccID
                hiTXNDATE.Value = oSDR("APPDATE").ToString()
            End If
            oSDR.Close()
            oSDR = Nothing

            'ctlLoanDataFromParamAppID.LOCID = Request.QueryString("LOCID")
            'ctlLoanDataFromParamAppID.APPID = Request.QueryString("APPID")
            ctlLoanDataFromParamAccID.LOCID = strLocID
            ctlLoanDataFromParamAccID.ACCID = strAccID

            InstallmentDataDue.LOCID = strLocID
            InstallmentDataDue.ACCID = strAccID
            InstallmentDataDue.TXNDATE = hiTXNDATE.Value

            sdsOtherAccount.SelectParameters("LOCIDCUST").DefaultValue = strLocIDCust
            sdsOtherAccount.SelectParameters("CUSTID").DefaultValue = strCustID
            If gvOtherAcc.Rows.Count <= 0 Then
                gvOtherAcc.Visible = False
            Else
                gvOtherAcc.Visible = True
            End If

            'gvInstallment.DataBind()

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub gvOtherAcc_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvOtherAcc.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If DataBinder.Eval(e.Row.DataItem, "ACCSTATUS") <> 1 Then
                e.Row.ForeColor = Drawing.Color.Red
            End If
        End If
    End Sub
End Class
