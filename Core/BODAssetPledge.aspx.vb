
Partial Class AppSetting_BODAP
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            Dim objDB As New DBX
            Try
                Dim oSDR As System.Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppDate() AppDate")
                If oSDR.Read() Then
                    txtAppDate.Text = String.Format("{0:dd/MM/yyyy}", oSDR("AppDate"))
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

    Protected Sub btnProcess_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcess.Click
        lblMessage.Visible = True
        Dim objCore As New Core
        Try
            objCore.ASSETPLEDGEINSTALLBOD(ConvertDate(txtAppDate.Text), Request.Cookies("UID").Value)
            lblMessage.Visible = True
            lblMessage.Text = "PROCESS BOD ASSET PLEDGE COMPLETED...!"
            btnProcess.Visible = False
        Catch ex As Exception
            lblMessage.Text = "ERROR BOD ASSET PLEDGE MANUAL...!<br>PLEASE CHECK DETAIL ERROR MESSAGE : " & ex.Message
            lblMessage.Focus()
            'Throw
        Finally
            objCore = Nothing
        End Try
        'lblComplete.Visible = True
        btnProcess.Visible = False
    End Sub

End Class
