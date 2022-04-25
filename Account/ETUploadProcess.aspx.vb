
Partial Class Account_ETUploadProcess
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub


    Private Sub DataSearch()

        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsETUpload.SelectCommand = Me.sdsETUpload.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
        End If
        gvETUpload.DataBind()
        If gvETUpload.Rows.Count() <= 0 Then
            pnlProcess.Visible = False
            'btnProcess.Visible = False
            'btnDelete.Visible = False
            'btnProcess.Enabled = False
            'btnPrint.Enabled = False
        Else
            pnlProcess.Visible = True
            'btnProcess.Visible = True
            'btnDelete.Visible = True
            'btnProcess.Enabled = True
            'btnPrint.Enabled = True
        End If


    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        DataSearch()
        If Not IsPostBack() Then
            Dim objDB As New DBX
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            Try
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE FROM APPSETTING WHERE APPCODE='APPDATE'")
                If oSDR.Read Then
                    txtTxnDate.Text = oSDR("APPVALUE").ToString()
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
        lblMessage.Visible = False
        Dim objDB As New DBX
        Try
            objDB.ExecSP("ETUPLOADProcess", _
            objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 20, Data.ParameterDirection.Input) _
            )
            lblMessage.Visible = True
            lblMessage.Text = "EARLY TERMINATION UPLOAD PROCESS EXECUTE COMPLETED...!"
            DataSearch()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR ET UPLOAD PROCESS : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        lblMessage.Visible = False
        Dim objDB As New DBX
        Try
            objDB.ExecSQL("TRUNCATE TABLE ETUPLOAD")
            'objDB.ExecSQLWithParam("DELETE ETUPLOAD WHERE JFID=@JFID", _
            '       objDB.MP("@JFID", Data.SqlDbType.Int, ddlJF.SelectedValue, 20, Data.ParameterDirection.Input) _
            '   )
            DataSearch()
            lblMessage.Visible = True
            lblMessage.Text = "DELETE ET UPLOAD DATA COMPLETED..!"
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR ET UPLOAD DATA: " & ex.Message & "<br>PLEASE CHECK DETAIL ERROR..!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
        lblMessage.Visible = False
    End Sub
End Class
