
Partial Class Expired
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim strPath As String = ""
        strPath = Left(Request.ServerVariables("PATH_INFO"), InStr(2, Request.ServerVariables("PATH_INFO"), "/") - 1)

        Session.Abandon()
        Response.Cookies("UID").Value = ""
        Response.Cookies("UID").Path = strPath

        Response.Cookies("SessionID").Value = ""
        Response.Cookies("SessionID").Path = strPath

        Response.Cookies("UserID").Value = ""
        Response.Cookies("UserID").Path = strPath

        Response.Cookies("UserName").Value = ""
        Response.Cookies("UserName").Path = strPath

        Response.Cookies("AppDate").Value = ""
        Response.Cookies("AppDate").Path = strPath


        Response.Cookies("cMenuID").Value = ""
        Response.Cookies("cMenuID").Path = strPath

        Response.Redirect("ReLogin.aspx")
    End Sub

End Class
