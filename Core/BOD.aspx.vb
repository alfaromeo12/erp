
Partial Class AppSetting_BOD
    Inherits System.Web.UI.Page

    Public Delegate Sub BODTask_Delegate(ByVal dtAppDate As Date, ByVal strUserID As String)
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
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
            DataSearch()
            gvDataAcc.Caption = "Account must be BOD until " + txtAppDate.Text
            gvDataAccJF.Caption = "Account JF must be BOD until " + txtAppDate.Text
            lblMessage.Text = ""
        Catch ex As Exception
            lblMessage.Text = "ERROR LOADING BOD...!PLEASE CHECK DETAIL ERROR MESSAGE : " & ex.Message
            lblMessage.Focus()
            'Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub

    Private Sub DataSearch()
        gvDataAcc.DataBind()
        gvDataAccJF.DataBind()
        gvData.DataBind()
    End Sub

    Protected Sub btnProcess_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcess.Click

        Dim objCore As New Core
        Try
            lblMessage.Visible = True
            objCore.BODCustomer(ConvertDate(txtAppDate.Text), Request.Cookies("UID").Value)
            objCore.BODJF(ConvertDate(txtAppDate.Text), Request.Cookies("UID").Value)
            objCore.ASSETPLEDGEINSTALLBOD(ConvertDate(txtAppDate.Text), Request.Cookies("UID").Value)
            objCore.BODPaymentFromDeposit(Request.Cookies("UID").Value)
            DataSearch()
            lblMessage.Text = "MESSAGE : PROCESS COMPLETED...!"
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR BOD..!PLEASE CHECK DETAIL ERROR MESSAGE : " & ex.Message
        Finally
            objCore = Nothing
        End Try
        btnProcess.Visible = False

        'Dim d As BODTask_Delegate
        'd = New BODTask_Delegate(AddressOf BODTask)
        'Dim R As IAsyncResult
        'R = d.BeginInvoke(ConvertDate(txtAppDate.Text), Request.Cookies("UID").Value, Nothing, Nothing)
        'Response.Redirect("ProcessMonitor.aspx")

    End Sub

    Public Sub BODTask(ByVal dtAppDate As Date, ByVal strUserID As String)
        Dim objCore As New Core
        Try
            Dim objDB As New DBX
            objDB.ExecSQLNoTxn("UPDATE APPPROCESS SET PROCESSDESC='IN PROGRESS' WHERE PROCESSNAME LIKE 'BOD%'")
            objDB.Close()
            objDB = Nothing
            objCore.BODCustomer(dtAppDate, strUserID)
            objCore.BODJF(dtAppDate, strUserID)
            objCore.BODPaymentFromDeposit(strUserID)
            objCore.ASSETPLEDGEINSTALLBOD(dtAppDate, strUserID)
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR BOD..!PLEASE CHECK DETAIL ERROR MESSAGE : " & ex.Message
        Finally
            objCore = Nothing
        End Try

    End Sub



    Protected Sub btnRefresh_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRefresh.Click
        DataSearch()
    End Sub

    Protected Sub sdsGridAcc_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles sdsGridAcc.Selecting
        e.Command.CommandTimeout = 0
    End Sub

    Protected Sub sdsGridAccJF_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles sdsGridAccJF.Selecting
        e.Command.CommandTimeout = 0
    End Sub
End Class
