
Partial Class Txn_DisbBatchDealer
    Inherits System.Web.UI.Page
    Public Shared strAppDate As String


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Response.Write(Request.Cookies("AppDate").Value)

        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE FROM APPSETTING WHERE APPCODE='APPDATE'")
            If oSDR.Read Then
                strAppDate = oSDR("APPVALUE").ToString()
                If Not IsPostBack() Then
                    txtBookFrom.Text = strAppDate
                    txtBookTo.Text = strAppDate
                    txtPlanPaid.Text = strAppDate
                    rbReceive.Checked = True
                End If
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR LOADING DISBURSE INPUT BATCH: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

        If Not IsPostBack() Then
            'rbReqDate.Checked = True
            txtAction.Value = Request.QueryString("Action")
            txtSPV.Value = Request.QueryString("SPV")

            DataSearch()
        End If

    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub


    Private Sub DataSearch()
        gvData.DataBind()
        gvSummary.DataBind()

        If gvData.Rows.Count <= 0 Then
            btnSave.Enabled = False
            btnPrint.Enabled = False
        Else
            btnSave.Enabled = True
            btnPrint.Enabled = True
        End If
    End Sub




    Protected Sub btnView_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnView.Click
        lblMessage.Visible = False
        DataSearch()
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        lblMessage.Visible = False
        Dim objDB As New DBX
        Try
            Dim intReceive As Integer = 0
            If rbReceive.Checked Then
                intReceive = 1
            End If
            objDB.ExecSP("[ACCOUNTDISBURSEPlanPaidDealer]", _
                objDB.MP("@PLANPAIDDATE", Data.SqlDbType.DateTime, ConvertDate(txtPlanPaid.Text)), _
                objDB.MP("@BOOKINGFROM", Data.SqlDbType.DateTime, ConvertDate(txtBookFrom.Text)), _
                objDB.MP("@BOOKINGTO", Data.SqlDbType.DateTime, ConvertDate(txtBookTo.Text)), _
                objDB.MP("@DEALERID", Data.SqlDbType.Int, ddlDealer.SelectedValue), _
                objDB.MP("@RECEIVEONLY", Data.SqlDbType.Int, intReceive), _
                objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value) _
            )
            lblMessage.Visible = True
            lblMessage.Text = "DISBURSE INPUT PER DEALER PROCESS COMPLETED...!"
            DataSearch()
            ddlDealer.DataBind()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR DISBURSEMENT INPUT PER DEALER...!<BR>PLEASE CHECK DETAIL ERROR MESSAGE: <BR>" & ex.Message
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

End Class
