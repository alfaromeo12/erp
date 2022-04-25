
Partial Class FrontEnd_UploadProcess
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            'DataSearch()
            'btnDelete.Enabled = False
            'btnProcess.Enabled = False
            'btnPrint.Enabled = False
            CheckNumRow()

        End If
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        lblMessage.Visible = False
        DataSearch()
    End Sub

    Private Sub DataSearch()
        gvSummary.DataBind()
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsCollateral.SelectCommand = Me.sdsCollateral.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
        End If
        gvBPKB.DataBind()
        CheckNumRow()

    End Sub

    Private Sub CheckNumRow()
        If gvBPKB.Rows.Count() <= 0 Then
            btnDelete.Enabled = False
            btnProcess.Enabled = False
            btnPrint.Enabled = False
        Else
            btnDelete.Enabled = True
            btnProcess.Enabled = True
            btnPrint.Enabled = True
        End If
    End Sub
    Protected Sub btnProcess_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcess.Click
        lblMessage.Visible = False
        Dim objDB As New DBX
        Try
            objDB.ExecSP("BPKBUPLOADProcess", _
            objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value) _
            )
            lblMessage.Visible = True
            lblMessage.Text = "DOCUMENT PROCESS UPLOAD COMPLETED...!"
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR DOCUMENT PROCESS UPLOAD: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        DataSearch()
    End Sub

    Protected Sub btnDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        lblMessage.Visible = False
        Dim objDB As New DBX
        Try
            'objDB.ExecSQL("DELETE BPKBUPLOAD WHERE JFID=" & ddlJF.SelectedValue)
            objDB.ExecSQL("TRUNCATE TABLE BPKBUPLOAD")
            lblMessage.Visible = True
            lblMessage.Text = "DELETE DOCUMENT UPLOAD COMPLETED...!"
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR DELETE DOCUMENT UPLOAD: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        DataSearch()
    End Sub


    Protected Sub gvPayment_PageIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvBPKB.PageIndexChanged
        DataSearch()
    End Sub

    'Protected Sub ddlJF_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlJF.SelectedIndexChanged
    '    DataSearch()
    'End Sub

End Class
