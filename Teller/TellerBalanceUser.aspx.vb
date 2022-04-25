
Partial Class Teller_TellerBalanceUser
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            hidTellerID.Value = Request.QueryString("TELLERID")
            If Len(Trim(hidTellerID.Value)) <= 0 Then
                hidTellerID.Value = Request.Cookies("UID").Value
            End If
        End If
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

End Class
