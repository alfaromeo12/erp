
Partial Class Account_AccInqCollection
    Inherits System.Web.UI.Page
    Public Shared strScript As String = ""

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("Action") = "InqAcc" Then
            ajaxCPELoanData.Collapsed = False
        End If
        If Not IsPostBack() Then
            ' strScript = ""
            txtAction.Value = Request.QueryString("INQ")
            Dim objDB As New DBX
            Try
                Dim oSDR As System.Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT LOCID, ACCID FROM ACCOUNT WITH(NOLOCK) WHERE LOCID=" & Request.QueryString("LOCID") & " AND APPID=" & Request.QueryString("APPID"))
                If oSDR.Read() Then
                    hidLocID.Value = oSDR("LOCID").ToString()
                    hidAccID.Value = oSDR("ACCID").ToString()
                    ctlDataAccountFromParamAccIDOS.LOCID = hidLocID.Value
                    ctlDataAccountFromParamAccIDOS.ACCID = hidAccID.Value
                    ctlCollectibilityParamAccID.LOCID = hidLocID.Value
                    ctlCollectibilityParamAccID.ACCID = hidAccID.Value
                End If
                oSDR.Close()
                oSDR = Nothing
            Catch ex As Exception
                Throw
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        End If
    End Sub

    Protected Sub gvReposes_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvReposes.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If DataBinder.Eval(e.Row.DataItem, "REPOSESSTATUS") = 9 Then
                e.Row.ForeColor = Drawing.Color.Red
            ElseIf DataBinder.Eval(e.Row.DataItem, "REPOSESSTATUS") = 2 Then
                e.Row.Font.Italic = True
            ElseIf DataBinder.Eval(e.Row.DataItem, "REPOSESSTATUS") = 3 Then
                e.Row.Font.Bold = True
            End If
        End If
    End Sub

  
End Class
