
Partial Class Account_CollateralInq
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("Action") = "InqAcc" Then
            'ajaxCPELoanData.Collapsed = True
        End If
        'ctlLoanDataFromParamAppID.LOCID = Request.QueryString("LOCID")
        'ctlLoanDataFromParamAppID.APPID = Request.QueryString("APPID")

    End Sub


    Protected Sub gvParipasuTo_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvParipasuTo.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If DataBinder.Eval(e.Row.DataItem, "ACCSTATUS") <> 1 Then
                e.Row.ForeColor = Drawing.Color.Red
                e.Row.Font.Bold = True
            End If
            If DataBinder.Eval(e.Row.DataItem, "PARIPASUSTS") = 0 Then
                e.Row.Font.Italic = True
                e.Row.Font.Bold = True
            End If
        End If
    End Sub

    Protected Sub gvParipasuFrom_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvParipasuFrom.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If DataBinder.Eval(e.Row.DataItem, "ACCSTATUS") <> 1 Then
                e.Row.ForeColor = Drawing.Color.Red
                e.Row.Font.Bold = True
            End If
            If DataBinder.Eval(e.Row.DataItem, "PARIPASUSTS") = 0 Then
                e.Row.Font.Italic = True
                e.Row.Font.Bold = True
            End If
        End If
    End Sub
End Class
