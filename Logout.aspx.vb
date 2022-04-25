Partial Class Logout
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.Cookies("UID") IsNot Nothing Then
            Dim strUID As String = Request.Cookies("UID").Value
            If Len(Trim(strUId)) <= 0 Then
                strUID = Request.QueryString("LogUserID")
            End If
            If strUId <> "" Then
                removeCookies()
                delSession(strUId)
            End If
        Else
            removeCookies()
        End If
    End Sub

    Public Sub delSession(ByVal strUID As String)
        Dim objDBX As New DBX
        Try
            Dim strQuery As String = "DELETE FROM APPSessions WHERE (UID=" + strUID + ")"
            objDBX.ExecSQLNoTxn(strQuery)
            strQuery = "UPDATE APPLICATION SET ROWLOCK=0 WHERE ROWLOCK=1 AND LastUserID=" + strUID
            objDBX.ExecSQLNoTxn(strQuery)
        Catch ex As Exception
            Throw
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Sub

    Public Sub removeCookies()
        'Dim strPath As String = Left(Request.ServerVariables("PATH_INFO"), InStr(2, Request.ServerVariables("PATH_INFO"), "/") - 1)

        ' Response.Cookies("UID").Path = strPath
        Response.Cookies("UID").Expires = DateTime.Now

        'Response.Cookies("BranchID").Path = strPath
        'Response.Cookies("BranchID").Expires = DateTime.Now

        'Response.Cookies("AppDate").Path = strPath
        Response.Cookies("AppDate").Expires = DateTime.Now

        'Response.Cookies("SessionID").Path = strPath
        Response.Cookies("SessionID").Expires = DateTime.Now

        'esponse.Cookies("UserID").Path = strPath
        Response.Cookies("UserID").Expires = DateTime.Now

        'Response.Cookies("ChangePass").Path = strPath
        'Response.Cookies("ChangePass").Expires = DateTime.Now
        Session("SessionID") = ""
        Session.Clear()
        Session.Abandon()

    End Sub
End Class
