
Partial Class Account_AccountFrame
    Inherits System.Web.UI.Page

    Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
        Dim strLocID As String, strAppID As String
        strLocID = Request.QueryString("LOCID")
        strAppID = Request.QueryString("APPID")

        'Response.Write("<frameset rows='193,*'>")
        Response.Write("<frameset rows='165,*'>")
        Response.Write("<frame name='header' scrolling='no' noresize target='AccInq' src='../UserControl/MenuInq.aspx?LOCID=" + strLocID + "&APPID=" + strAppID + "'>")
        'Response.Write("<frame name='AccInq' src='../FrontEnd/AppInq.aspx?Action=InqAcc&LOCID=" + strLocID + "&APPID=" + strAppID + ">")
        Response.Write("<frame name='AccInq' src='../Account/LoanDataInq.aspx?MenuInq=1&Action=InqAcc&LOCID=" + strLocID + "&APPID=" + strAppID + "'>")
        Response.Write("<noframes>")
        Response.Write("<body>")


        Response.Write("</body>")
        Response.Write("</noframes>")
        Response.Write("</frameset>")
    End Sub
End Class
