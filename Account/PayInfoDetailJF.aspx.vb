
Partial Class Account_JFPayInfoDetail
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ajaxCPEAccData.Collapsed = True
            ajaxCPELoanData.Collapsed = True
            lblMessage.Visible = False
        End If
        If Request.QueryString("Action") = "Reverse" Then
            btnClose.Visible = False
            btnReverse.Visible = True
            btnBack.Visible = True
        ElseIf Request.QueryString("Action") = "INQ" Then
            btnClose.Visible = False
            btnReverse.Visible = False
            btnBack.Visible = True
        End If
    End Sub

    Protected Sub btnReverse_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReverse.Click
        Dim objpay As New Payment
        Try
            lblMessage.Visible = True
            Dim intRetVal As Integer
            intRetVal = objpay.PAYMENTJFReversal(Request.QueryString("PAYIDJF"), _
                Request.Cookies("UID").Value)
            Response.Redirect("../Pay/PayReversalJFList.aspx")
            If intRetVal = -1 Then
                lblMessage.Text = "JF TRANSACTION ALREADY REVERSE...!"
                lblMessage.Focus()
                btnReverse.Visible = False
            ElseIf intRetVal = -2 Then
                lblMessage.Text = "THERE IS OLD JF TRANSACTION MUST BE REVERSE FIRST...!"
                btnReverse.Visible = False
                lblMessage.Focus()
            End If
        Catch ex As Exception
            lblMessage.Text = "JF REVERSE ERROR : " & ex.Message
            lblMessage.Focus()
        Finally
            objpay = Nothing
        End Try
    End Sub
End Class
