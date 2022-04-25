
Partial Class Reports_ReportiFrameCR
    Inherits System.Web.UI.Page
    Public strParamID As String, strReportID As String, strReportType As String, strReportFileName As String
    Public strURL As String = ""

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim strParam As String = ""
        If Not IsPostBack Then
            If Request.QueryString("Action") = "2" Then
                strParam = Replace(Request.QueryString("Param"), "@", "&")
                strReportFileName = Request.QueryString("FileName")
                strURL = "ReportViewerCrystal.aspx?Report=" & strReportFileName & "&stsprn=1" & strParam
                Me.iFrame.Attributes("src") = strURL
            End If
        End If
    End Sub
 
End Class
