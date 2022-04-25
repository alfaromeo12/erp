
Partial Class AppSetting_BODManual
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            Dim objDB As New DBX
            Try
                Dim oSDR As System.Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppDate() AppDate, CASE WHEN EXISTS(SELECT PROCESSID FROM APPPROCESS WHERE PROCESSSTATUS=1) THEN 1 ELSE 0 END APPPROCESS")
                If oSDR.Read() Then
                    txtAppDate.Text = String.Format("{0:dd/MM/yyyy}", oSDR("AppDate"))
                    If oSDR("APPPROCESS").ToString() = "1" Then
                        lblMessage.Visible = True
                        lblMessage.Text = "THERE IS ANOTHER BACK END PROCESS RUNNING.. PLEASE WAIT UNTIL IT'S COMPLETED...!"
                        btnProcess.Visible = False
                    End If

                End If
                oSDR.Close()
                oSDR = Nothing
                gvDataAcc.Caption = "Account must be BOD until " + txtAppDate.Text
                gvDataAccJF.Caption = "Account JF must be BOD until " + txtAppDate.Text
                lblMessage.Text = ""
            Catch ex As Exception

                Throw
            Finally
                objDB.Close()
                objDB = Nothing
            End Try


            txtJF.Value = Request.QueryString("JF")
            If txtJF.Value = "0" Then
                gvDataAcc.DataBind()
                gvDataAccJF.Visible = False
            ElseIf txtJF.Value = "1" Then
                gvDataAccJF.DataBind()
                gvDataAcc.Visible = False
            End If
        End If
    End Sub

    Protected Sub btnProcess_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcess.Click
        Dim objCore As New Core
        Try
            If txtJF.Value = "0" Then
                objCore.BODCustomer(ConvertDate(txtAppDate.Text), Request.Cookies("UID").Value)
            ElseIf txtJF.Value = "1" Then
                objCore.BODJF(ConvertDate(txtAppDate.Text), Request.Cookies("UID").Value)
            ElseIf txtJF.Value = "2" Then
                objCore.BODPaymentFromDeposit(Request.Cookies("UID").Value)
            End If
            lblMessage.Visible = True
            lblMessage.Text = "PROCESS COMPLETED...!"
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR BOD MANUAL...!<br>PLEASE CHECK DETAIL ERROR MESSAGE : " & ex.Message
            lblMessage.Focus()
            'Throw
        Finally
            objCore = Nothing
        End Try
        'lblComplete.Visible = True
        btnProcess.Visible = False
    End Sub

    Protected Sub btnRefresh_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRefresh.Click
        If txtJF.Value = "0" Then
            gvDataAcc.DataBind()
        ElseIf txtJF.Value = "1" Then
            gvDataAccJF.DataBind()
        End If
    End Sub

    Protected Sub sdsGridAcc_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles sdsGridAcc.Selecting
        e.Command.CommandTimeout = 0
    End Sub

    Protected Sub sdsGridAccJF_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles sdsGridAccJF.Selecting
        e.Command.CommandTimeout = 0
    End Sub
End Class
