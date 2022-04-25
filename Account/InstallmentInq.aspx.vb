
Partial Class Account_LoanDataInq
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim strLocID As String = Request.QueryString("LOCID")
        Dim strAppID As String = Request.QueryString("APPID")
        Dim strAccID As String = ""
        Dim objDB As New DBX
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppDate() APPDATE, ACCID FROM ACCOUNT WITH(NOLOCK) WHERE LOCID=" & strLocID & " AND APPID=" & strAppID)
            If oSDR.Read() Then
                strAccID = oSDR("ACCID").ToString()
                hiLocID.Value = strLocID
                hiACCID.Value = strAccID
                ctlCollectibilityParamAccID.LOCID = strLocID
                ctlCollectibilityParamAccID.ACCID = strAccID
                hiTXNDATE.Value = oSDR("APPDATE").ToString()
            End If
            oSDR.Close()
            oSDR = Nothing

            ctlLoanDataFromParamAccID.LOCID = strLocID
            ctlLoanDataFromParamAccID.ACCID = strAccID

            ctlInstallmentDataAll.LOCID = strLocID
            ctlInstallmentDataAll.ACCID = strAccID

            If Request.QueryString("Action") = "InqAcc" Then
                ajaxCPELoanData.Collapsed = True
            End If
            'gvInstallment.DataBind()

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    'Protected Sub gvInstallment_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvInstallment.DataBound
    '    For Each gr As GridViewRow In sender.Rows
    '        'Response.Write(gr.Cells(7).Text & "<br>")
    '        If Len(gr.Cells(7).Text) = 0 Then
    '            gr.BackColor = Drawing.Color.Red
    '        End If
    '    Next
    'End Sub

End Class
