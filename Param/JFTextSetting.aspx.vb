
Partial Class Param_JFTextSetting
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub


    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            hidJFID.Value = Request.QueryString("JFID")
        End If

        If hidACTION.Value = "COPY" Then
            'Response.Write(Request.QueryString("JFIDCOPY"))
            lblError.Visible = False
            lblError.Text = ""
            Dim objDB As New DBX
            Try
                objDB.ExecSP("MOSTtextSettingJFCopy",
                        objDB.MP("@JFIDCOPY", Data.SqlDbType.Int, Request.QueryString("JFIDCOPY")),
                        objDB.MP("@JFID", Data.SqlDbType.Int, hidJFID.Value),
                        objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value)
                        )
                gvJFText.DataBind()
            Catch ex As Exception
                lblError.Visible = True
                lblError.Text = "ERROR COPY TEXT SETTING JF..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE : " & ex.Message
            Finally
                objDB.Close()
                objDB = Nothing
            End Try

            hidACTION.Value = ""
        End If
    End Sub

End Class
