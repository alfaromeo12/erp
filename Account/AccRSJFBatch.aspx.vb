
Partial Class Account_AccRSJFBatch
    Inherits System.Web.UI.Page
    Public Shared strAppDate As String

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Response.Write(Request.Cookies("AppDate").Value)

        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE FROM APPSETTING WHERE APPCODE='APPDATE'")
            If oSDR.Read Then
                strAppDate = oSDR("APPVALUE").ToString()
                If Not IsPostBack() Then
                    txtTxnDate.Text = strAppDate
                    txtTxnDateTo.Text = strAppDate
                    txtEffRAte.Text = "0"
                End If
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

        If Not IsPostBack() Then
            'rbReqDate.Checked = True
            txtAction.Value = Request.QueryString("Action")
            txtSPV.Value = Request.QueryString("SPV")

            'DataSearch()
        End If
        SetObjectValidation(txtEffRAte, False, "float", "[0-9.]")
    End Sub



    Private Sub DataSearch()

        gvData.DataBind()
        'gvSummary.DataBind()

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
            objDB.ExecSP("RESCHEDULEAddPerJF", _
                objDB.MP("@BOOKFROM", Data.SqlDbType.DateTime, ConvertDate(txtTxnDate.Text), 20, Data.ParameterDirection.Input), _
                    objDB.MP("@BOOKTO", Data.SqlDbType.DateTime, ConvertDate(txtTxnDateTo.Text), 20, Data.ParameterDirection.Input), _
                    objDB.MP("@JFID", Data.SqlDbType.Int, ddlJF.SelectedValue, 20, Data.ParameterDirection.Input), _
                    objDB.MP("@NEWEFFRATE", Data.SqlDbType.Float, txtEffRAte.Text, 20, Data.ParameterDirection.Input), _
                    objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 20, Data.ParameterDirection.Input) _
                    )
            lblMessage.Visible = True
            lblMessage.Text = "JF RESCHEDULE INPUT BATCH SAVED COMPLETED...!"
            DataSearch()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR JF RESCHEDULE INPUT BATCH: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing

        End Try
    End Sub
End Class
