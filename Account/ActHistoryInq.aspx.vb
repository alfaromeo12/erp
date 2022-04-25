
Partial Class Account_ActHistoryInq
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("Action") = "InqAcc" Then
            ajaxCPELoanData.Collapsed = True
        End If
        If Not IsPostBack() Then
            Dim objDB As New DBX
            Try
                Dim oSDR As System.Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT LOCID, ACCID FROM ACCOUNT WITH(NOLOCK) WHERE LOCID=" & Request.QueryString("LOCID") & " AND APPID=" & Request.QueryString("APPID"))
                If oSDR.Read() Then
                    hidLocID.Value = oSDR("LOCID").ToString()
                    hidAccID.Value = oSDR("ACCID").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing
                ctlLoanDataFromParamAccID.LOCID = hidLocID.Value
                ctlLoanDataFromParamAccID.ACCID = hidAccID.Value
            Catch ex As Exception
                Throw
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        End If
    End Sub

End Class
