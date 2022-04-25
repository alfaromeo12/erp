
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
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT ACCID FROM ACCOUNT WITH(NOLOCK) WHERE LOCID=" & strLocID & " AND APPID=" & strAppID)
            If oSDR.Read() Then
                strAccID = oSDR("ACCID").ToString()
            End If
            oSDR.Close()
            oSDR = Nothing
            sdsInstallment.SelectParameters("LOCID").DefaultValue = strLocID
            sdsInstallment.SelectParameters("ACCID").DefaultValue = strAccID
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

End Class
