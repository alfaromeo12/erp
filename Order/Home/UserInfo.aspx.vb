Imports System.Data.SqlClient

Partial Class UserInfo
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Dim objDBX As New DBX
        'Dim osdrUserInfo As SqlDataReader
        'Dim strInfo As String = ""
        'Dim strSession As String = ""
        'Dim strQuery As String = ""

        'Try
        '    If Request.Cookies("UID") IsNot Nothing Then
        '        strQuery = "SELECT APPUser.UserID, APPUser.UserName, APPUser.LastLogin, APPSessions.TimeOut, APPSessions.IP, PBranch.BranchName, PBranch.BranchCode FROM APPUser INNER JOIN APPSessions ON APPUser.UID = APPSessions.UID INNER JOIN PBranch ON APPUser.BranchID = PBranch.BranchID WHERE (APPUser.UID = " + Request.Cookies("UID").Value + ")"
        '        osdrUserInfo = objDBX.CreateSDRFromSQLSelect(strQuery)
        '        strInfo += "<table width='100%' border='1'>"
        '        strSession += "<table width='100%' border='1'>"
        '        While osdrUserInfo.Read()
        '            strInfo += "<tr><td>User ID</td><td> : </td><td>" + osdrUserInfo("UserID") + "</td></tr>"
        '            strInfo += "<tr><td>User Name</td><td> : </td><td>" + osdrUserInfo("UserName") + "</td></tr>"
        '            strInfo += "<tr><td>Branch</td><td> : </td><td>" + osdrUserInfo("BranchCode") + " - " + osdrUserInfo("BranchName") + "</td></tr>"
        '            strInfo += "<tr><td>Last Login</td><td> : </td><td>" + osdrUserInfo("LastLogin") + "</td></tr>"

        '            strSession += "<tr><td>Session Timeout</td><td> : </td><td>" + osdrUserInfo("TimeOut") + "</td></tr>"
        '            strSession += "<tr><td>Last Activity</td><td> : </td><td>" + osdrUserInfo("LastLogin") + "</td></tr>"
        '            strSession += "<tr><td>IP Address</td><td> : </td><td>" + osdrUserInfo("IP") + "</td></tr>"
        '        End While
        '        strInfo += "</table>"
        '        strSession += "</table>"
        '    End If
        'Catch ex As Exception
        '    Throw
        'Finally
        '    osdrUserInfo.Close()
        '    osdrUserInfo = Nothing
        '    objDBX.Close()
        '    objDBX = Nothing
        'End Try
        'lblUserInfo.Text = strInfo
        'lblUserSession.Text = strSession
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnLogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLogout.Click
        Response.Redirect("../logout.aspx?LogUserId=" & Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnPwd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPwd.Click
        Response.Redirect("ChangePassword.aspx")
    End Sub
End Class
