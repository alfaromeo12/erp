
Partial Class AppSetting_EOD

    Inherits System.Web.UI.Page

    Public Delegate Sub EODTask_Delegate(ByVal dtAppDate As Date, ByVal strUserID As String)

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim objDB As New DBX
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppDate() AppDate, CASE WHEN EXISTS(SELECT PROCESSID FROM APPPROCESS WITH(NOLOCK) WHERE PROCESSSTATUS=1) THEN 1 ELSE 0 END APPPROCESS")
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
            gvDataAcc.DataBind()
            gvDataAcc.Caption = "Account must be BOD until " + txtAppDate.Text

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR LOADING EOD PROCESS: " & ex.Message & "<br>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Protected Sub btnProcess_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcess.Click
        'Dim d As EODTask_Delegate
        'd = New EODTask_Delegate(AddressOf EODTask)
        'Dim R As IAsyncResult
        'R = d.BeginInvoke(ConvertDate(txtAppDate.Text), Request.Cookies("UID").Value, Nothing, Nothing)
        'Response.Redirect("ProcessMonitor.aspx")
        lblMessage.Visible = False
        Dim objCore As New Core
        Try
            gvDataAcc.DataBind()
            If gvDataAcc.Rows.Count() <= 0 Then
                objCore.EOD(ConvertDate(txtAppDate.Text), Request.Cookies("UID").Value)
                objCore.EODCOLLECTSTSUpdate(ConvertDate(txtAppDate.Text), Request.Cookies("UID").Value)
                lblMessage.Visible = True
                lblMessage.Text = "END OF DAY PROCESS  COMPLETED..!"
                gvData.DataBind()
                gvDataAcc.DataBind()
            Else
                lblMessage.Visible = True
                lblMessage.Text = "END OF DAY CANNOT BE PROCEDD..!<BR>THERE IS ACCOUNT MUST BE BOD FIRST..!<BR>PLEASE CHECK ACCOUNT BELLOW..!"
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR EOD PROCESS...!<BR>PLEASE CHECK DETAIL ERROR MESSAGE : <BR>" & ex.Message & "<br>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
        Finally
            objCore = Nothing
        End Try
        btnProcess.Visible = False
    End Sub


    Public Sub EODTask(ByVal dtAppDate As Date, ByVal strUserID As String)
        Dim objCore As New Core
        Try
            Dim objDB As New DBX
            objDB.ExecSQLNoTxn("UPDATE APPPROCESS SET PROCESSDESC='IN PROGRESS' WHERE PROCESSNAME LIKE 'EOD%'")
            objDB.Close()
            objDB = Nothing
            objCore.EODCOLLECTSTSUpdate(dtAppDate, strUserID)
            objCore.EOD(dtAppDate, strUserID)
        Catch ex As Exception
            Throw
        Finally
            objCore = Nothing
        End Try

    End Sub

    Protected Sub sdsGridAcc_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles sdsGridAcc.Selecting
        e.Command.CommandTimeout = 0
    End Sub

    Protected Sub sdsGridAccJF_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles sdsGridAccJF.Selecting
        e.Command.CommandTimeout = 0
    End Sub
End Class
