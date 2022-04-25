Imports System.Data
Imports System.Data.SqlClient
Partial Class Param_Notary
    Inherits System.Web.UI.Page
    Private dt As New DataTable
    Private dr As DataRow
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            MultiView_Utama.SetActiveView(View_View)
            AddRowEmpty()
        End If
        SetValidation()
        DataSearch()
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub gvData_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        'lblError.Text = ""
        lblError.Visible = False
        If e.CommandName = "Select" Then
            gvData.SelectedIndex = e.CommandArgument
            lblCaption.Text = "Edit Data"
            hidNotaryID.Value = gvData.SelectedDataKey("NOTARYID")
            chkAddNew.Checked = False
            MultiView_Utama.SetActiveView(View_Form)
            lblMessage.Visible = False
            lblMessage.Text = ""
            GetData(hidNotaryID.Value)
            pnlControl.Visible = True
           
        End If
    End Sub

    Protected Sub imgBtnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        lblCaption.Text = "New Data"
        chkAddNew.Checked = True
        SetValidation()
        pnlControl.Visible = True
        Validation.ClearPanelAplicationField(pnlFormSB)
        MultiView_Utama.SetActiveView(View_Form)
        hidAction.Value = "NEW"
        AddRowEmpty()
       
    End Sub

    Private Sub SetValidation()
        SetObjectValidation(txtNotaryCode, False, "uppercase nospace")
        SetObjectValidation(txtNotaryName, False, "uppercase")
        SetObjectValidation(txtAccountNo, False, "integer", "[0-9]")
        SetObjectValidation(txtNotaryZip, False, "integer", "[0-9]")
        SetObjectValidation(txtNotaryTax, False, "integer", "[0-9]")

    End Sub

    Private Sub DataSearch()
        If Not IsPostBack() Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND NOTARY.NOTARYID=-999"
        End If
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        gvData.DataBind()
    End Sub
    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
        lblError.Visible = False
    End Sub
    Private Sub GetData(ByVal strKey As String)
        Dim objDB As New DBX
        Try

            Dim oSDR As System.Data.SqlClient.SqlDataReader

            oSDR = objDB.CreateSDRFromSQLSelect("SELECT  * " & _
              "  FROM dbo.NOTARY WITH(NOLOCK) WHERE NOTARYID=" & strKey)
            If oSDR.Read Then

                lblNotaryID.Text = oSDR("NOTARYID")
                txtNotaryCode.Text = oSDR("NOTARYCODE")
                txtNotaryName.Text = oSDR("NOTARYNAME")
                txtNotaryAddress.Text = oSDR("NOTARYADDRESS").ToString
                If Not String.IsNullOrEmpty(oSDR("NOTARYZIP").ToString()) Then
                    txtNotaryZip.Text = oSDR("NOTARYZIP").ToString()
                Else
                    txtNotaryZip.Text = ""
                End If
                If Not String.IsNullOrEmpty(oSDR("NOTARYCITY").ToString()) Then
                    txtNotaryCity.Text = oSDR("NOTARYCITY").ToString()
                Else
                    txtNotaryCity.Text = ""
                End If
                If Not String.IsNullOrEmpty(oSDR("NOTARYFAX").ToString()) Then
                    txtNotaryFax.Text = oSDR("NOTARYFAX").ToString()
                Else
                    txtNotaryFax.Text = ""
                End If
                If Not String.IsNullOrEmpty(oSDR("NOTARYPHONE").ToString()) Then
                    txtNotaryPhone.Text = oSDR("NOTARYPHONE").ToString()
                Else
                    txtNotaryPhone.Text = ""
                End If
                If Not String.IsNullOrEmpty(oSDR("NOTARYBANKID").ToString()) Then
                    ddlbank.SelectedValue = oSDR("NOTARYBANKID").ToString()
                Else
                    ddlbank.SelectedValue = 0
                End If
                If Not String.IsNullOrEmpty(oSDR("BRANCHID").ToString()) Then
                    ddlBranch.SelectedValue = oSDR("BRANCHID").ToString()
                Else
                    'ddlBranch.SelectedValue = 
                    'ddlBranch.SelectedValue = IsDBNull(oSDR("BRANCHID").ToString())
                End If
                If Not String.IsNullOrEmpty(oSDR("NPWP").ToString()) Then
                    txtNPWPNo.Text = oSDR("NPWP").ToString()
                Else
                    txtNPWPNo.Text = ""
                End If
                If Not String.IsNullOrEmpty(oSDR("NPWPNAME").ToString()) Then
                    txtNPWPName.Text = oSDR("NPWPNAME").ToString()
                Else
                    txtNPWPName.Text = ""
                End If
                txtAccountNo.Text = oSDR("NOTARYACCNO").ToString
                txtAccountNm.Text = oSDR("NOTARYACCNONAME").ToString
                txtContactPerson.Text = oSDR("CONTACTPERSON").ToString
                txtNotaryTax.Text = oSDR("NOTARYTAX").ToString
                oSDR.Close()
                oSDR = Nothing
              

                oSDR = objDB.CreateSDRFromSQLSelect("SELECT NOTARYFEE.FEEID,ISNULL(NOTARYFEE.PRINCIPALFROM,0)PRINCIPALFROM, ISNULL(NOTARYFEE.PRINCIPALTO,0)PRINCIPALTO,ISNULL(NOTARYFEE.NOTARYFEE,0)NOTARYFEE,  ISNULL(NOTARYFEE.INTERNALFEE,0)INTERNALFEE" & _
                " FROM NOTARYFEE  WITH(NOLOCK) " & _
                " WHERE NOTARYFEE.NOTARYID= " & strKey & " AND DELETESTS=0")
                If oSDR.HasRows Then
                    Dim dtNotaryFee As New System.Data.DataTable
                    dtNotaryFee.Load(oSDR)
                    oSDR.Close()
                    oSDR = Nothing

                    If ViewState("CurrentTable") IsNot Nothing Then
                        ViewState("CurrentTable") = Nothing
                    End If
                    ViewState("CurrentTable") = dtNotaryFee
                    gvNotaryFee.DataSource = dtNotaryFee
                    gvNotaryFee.DataBind()
                End If
            Else
                lblMessage.Visible = True
                lblMessage.Text = "NOTARY ID : " & strKey & " NOT ALREADY EXIST..!"
            End If
       
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RETRIVE NOTARY DATA: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

   

    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        Dim conn As SqlConnection = Nothing
        Dim cmd As SqlCommand
        Dim tran As SqlTransaction
        Dim objDB As New DBX

        conn = New SqlClient.SqlConnection(objDB.getConnectionString())
        conn.Open()
        If conn.State = Data.ConnectionState.Closed Then
            conn.Open()
        End If
        cmd = New SqlCommand()
        tran = conn.BeginTransaction
        cmd.Transaction = tran
        Try
            With cmd
                .CommandType = CommandType.StoredProcedure
                If chkAddNew.Checked Then
                    .CommandText = "NOTARYAdd"
                Else
                    .CommandText = "NOTARYUpdate"
                End If

                .Connection = conn
                If chkAddNew.Checked = False Then
                    .Parameters.Add("@NOTARYID", SqlDbType.Int)
                End If
                '  Add input and output parameters
                .Parameters.Add("@NOTARYCODE", SqlDbType.VarChar)
                .Parameters.Add("@NOTARYNAME", SqlDbType.VarChar)
                .Parameters.Add("@NOTARYADDRESS", SqlDbType.VarChar)
                .Parameters.Add("@NOTARYZIP", SqlDbType.VarChar)
                .Parameters.Add("@NOTARYCITY", SqlDbType.VarChar)
                .Parameters.Add("@NOTARYPHONE", SqlDbType.VarChar)
                .Parameters.Add("@NOTARYFAX", SqlDbType.VarChar)
                .Parameters.Add("@CONTACTPERSON", SqlDbType.VarChar)
                .Parameters.Add("@NOTARYBANKID", SqlDbType.Int)
                .Parameters.Add("@NOTARYACCOUNTNO", SqlDbType.VarChar)
                .Parameters.Add("@NOTARYACCOUNTNAME", SqlDbType.VarChar)
                .Parameters.Add("@BRANCHID", SqlDbType.VarChar)
                .Parameters.Add("@NPWP", SqlDbType.VarChar)
                .Parameters.Add("@NPWPNAME", SqlDbType.VarChar)
                .Parameters.Add("@NOTARYTAX", SqlDbType.Float)
                .Parameters.Add("@UserId", SqlDbType.Int)
                If chkAddNew.Checked Then
                    .Parameters.Add("@NOTARYID", SqlDbType.Int)
                End If
                .Parameters.Add("@retval", SqlDbType.Int)

                If chkAddNew.Checked = False Then
                    .Parameters("@NOTARYID").Direction = ParameterDirection.Input
                End If
                .Parameters("@NOTARYCODE").Direction = ParameterDirection.Input
                .Parameters("@NOTARYNAME").Direction = ParameterDirection.Input
                .Parameters("@NOTARYADDRESS").Direction = ParameterDirection.Input
                .Parameters("@NOTARYZIP").Direction = ParameterDirection.Input
                .Parameters("@NOTARYCITY").Direction = ParameterDirection.Input
                .Parameters("@NOTARYPHONE").Direction = ParameterDirection.Input
                .Parameters("@NOTARYFAX").Direction = ParameterDirection.Input
                .Parameters("@CONTACTPERSON").Direction = ParameterDirection.Input
                .Parameters("@NOTARYBANKID").Direction = ParameterDirection.Input
                .Parameters("@NOTARYACCOUNTNO").Direction = ParameterDirection.Input
                .Parameters("@NOTARYACCOUNTNAME").Direction = ParameterDirection.Input
                .Parameters("@BRANCHID").Direction = ParameterDirection.Input
                .Parameters("@NPWP").Direction = ParameterDirection.Input
                .Parameters("@NPWPNAME").Direction = ParameterDirection.Input
                .Parameters("@NOTARYTAX").Direction = ParameterDirection.Input
                .Parameters("@USERID").Direction = ParameterDirection.Input
                If chkAddNew.Checked Then
                    .Parameters("@NOTARYID").Direction = ParameterDirection.Output
                End If
                .Parameters("@retval").Direction = ParameterDirection.Output

                ' Set the parameter values
                If chkAddNew.Checked = False Then
                    .Parameters("@NOTARYID").Value = lblNotaryID.Text
                End If
                .Parameters("@NOTARYCODE").Value = txtNotaryCode.Text
                .Parameters("@NOTARYNAME").Value = txtNotaryName.Text
                .Parameters("@NOTARYADDRESS").Value = txtNotaryAddress.Text
                .Parameters("@NOTARYZIP").Value = txtNotaryZip.Text
                .Parameters("@NOTARYCITY").Value = txtNotaryCity.Text
                .Parameters("@NOTARYPHONE").Value = txtNotaryPhone.Text
                .Parameters("@NOTARYFAX").Value = txtNotaryFax.Text
                .Parameters("@CONTACTPERSON").Value = txtContactPerson.Text
                .Parameters("@NOTARYBANKID").Value = ddlbank.SelectedValue
                .Parameters("@NOTARYACCOUNTNO").Value = txtAccountNo.Text
                .Parameters("@NOTARYACCOUNTNAME").Value = txtAccountNm.Text
                .Parameters("@BRANCHID").Value = ddlBranch.SelectedValue
                .Parameters("@NPWP").Value = txtNPWPNo.Text
                .Parameters("@NPWPNAME").Value = txtNPWPName.Text
                .Parameters("@NOTARYTAX").Value = txtNotaryTax.Text
                .Parameters("@USERID").Value = Request.Cookies("UID").Value
                If chkAddNew.Checked Then
                    .Parameters("@NOTARYID").Value = ""
                End If
                .Parameters("@retval").Value = "0"
                .ExecuteNonQuery()
                If chkAddNew.Checked Then
                    hidNotaryID.Value = .Parameters("@NOTARYID").Value
                End If
                If .Parameters("@retval").Value = -1 Then
                    lblMessage.Visible = True
                    lblMessage.Text = "DATA NOTARY ALREADY EXISTS..!! "
                    tran.Rollback()
                    Exit Sub
                Else
                    .Parameters.Clear()
                End If
            End With

            Dim oSDR As Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromExecSQL("Update dbo.NOTARYFEE SET DeleteSTS=1 WHERE NOTARYID=" & hidNotaryID.Value)
            If oSDR.Read() Then

            End If
            oSDR.Close()
            If DirectCast(ViewState("CurrentTable"), DataTable) IsNot Nothing Then
                Dim dtNotaryFee As New System.Data.DataTable
                dtNotaryFee = ViewState("CurrentTable")
                GetDataNotaryFee(dtNotaryFee)
                For Each row As System.Data.DataRow In dtNotaryFee.Rows
                    With cmd
                        .CommandType = CommandType.StoredProcedure
                        .CommandText = "NOTARYFEESave"
                        .Connection = conn
                        .Parameters.Add("@NOTARYID", SqlDbType.Int)
                        .Parameters.Add("@FEEID", SqlDbType.BigInt)
                        .Parameters.Add("@PRINCIPALFROM", SqlDbType.Money)
                        .Parameters.Add("@PRINCIPALTO", SqlDbType.Money)
                        .Parameters.Add("@NOTARYFEE", SqlDbType.Money)
                        .Parameters.Add("@INTERNALFEE", SqlDbType.Money)
                        .Parameters.Add("@USERID", SqlDbType.BigInt)

                        .Parameters("@NOTARYID").Direction = ParameterDirection.Input
                        .Parameters("@FEEID").Direction = ParameterDirection.Input
                        .Parameters("@PRINCIPALFROM").Direction = ParameterDirection.Input
                        .Parameters("@PRINCIPALTO").Direction = ParameterDirection.Input
                        .Parameters("@NOTARYFEE").Direction = ParameterDirection.Input
                        .Parameters("@INTERNALFEE").Direction = ParameterDirection.Input
                        .Parameters("@USERID").Direction = ParameterDirection.Input

                        .Parameters("@NOTARYID").Value = hidNotaryID.Value
                        .Parameters("@FEEID").Value = row.Item("FEEID").ToString()
                        .Parameters("@PRINCIPALFROM").Value = row.Item("PRINCIPALFROM").ToString()
                        .Parameters("@PRINCIPALTO").Value = row.Item("PRINCIPALTO").ToString()
                        .Parameters("@NOTARYFEE").Value = row.Item("NOTARYFEE").ToString()
                        .Parameters("@INTERNALFEE").Value = row.Item("INTERNALFEE").ToString()
                        .Parameters("@USERID").Value = Request.Cookies("UID").Value
                        ' Execute the command
                        .ExecuteNonQuery()
                        ' Repeat the above few lines for each order detail
                        .Parameters.Clear()
                    End With
                Next

            End If

            ' Commit the Transaction
            tran.Commit()
            If DirectCast(ViewState("CurrentTable"), DataTable) Is Nothing Then
            Else
                DirectCast(ViewState("CurrentTable"), DataTable).Rows.Clear()
                DirectCast(ViewState("CurrentTable"), DataTable).Dispose()
            End If

            MultiView_Utama.SetActiveView(View_Form)
            'DataSearch()
            'pnlControl.Visible = False
        Catch ex As Exception
            ' Rollback the Transaction
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE NOTARY DATA: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            tran.Rollback()
        Finally
            ' Cleanup Code
            ' Close the Connection
            conn.Close()
        End Try

    End Sub


    Protected Sub btnCancel_Click(sender As Object, e As System.EventArgs) Handles btnCancel.Click
        MultiView_Utama.SetActiveView(View_View)
        Validation.ClearPanelAplicationField(pnlFormSB)
        pnlControl.Visible = False
        If DirectCast(ViewState("CurrentTable"), DataTable) Is Nothing Then
        Else
            DirectCast(ViewState("CurrentTable"), DataTable).Rows.Clear()
            DirectCast(ViewState("CurrentTable"), DataTable).Dispose()
        End If

        DataSearch()
    End Sub

    Private Sub AddRowEmpty()
        Dim dt As New DataTable()
        Dim dr As DataRow = Nothing
        Dim oImageDel As ImageButton

        dt.Columns.Add(New DataColumn("FEEID", GetType(String)))
        dt.Columns.Add(New DataColumn("NOTARYID", GetType(String)))
        dt.Columns.Add(New DataColumn("PRINCIPALFROM", GetType(Double)))
        dt.Columns.Add(New DataColumn("PRINCIPALTO", GetType(Double)))
        dt.Columns.Add(New DataColumn("NOTARYFEE", GetType(Double)))
        dt.Columns.Add(New DataColumn("INTERNALFEE", GetType(Double)))
        dr = dt.NewRow()
        dr("FEEID") = 0
        dr("NOTARYID") = 0
        dr("PRINCIPALFROM") = 0.0
        dr("PRINCIPALTO") = 0.0
        dr("NOTARYFEE") = 0.0
        dr("INTERNALFEE") = 0.0
        dt.Rows.Add(dr)

        ViewState("CurrentTable") = dt

        'gvNotaryFee.DataSourceID = String.Empty
        gvNotaryFee.DataSource = dt
        gvNotaryFee.DataBind()

        oImageDel = DirectCast(gvNotaryFee.Rows(Convert.ToInt32(txtTmpSelectedIndex.Text)).FindControl("btnDelete"), ImageButton)
        oImageDel.Visible = False
    End Sub
  
    Protected Sub gvNotaryFee_DataBound(sender As Object, e As System.EventArgs) Handles gvNotaryFee.DataBound
        Dim oTextBox As TextBox
        For Each row As GridViewRow In gvNotaryFee.Rows
            oTextBox = CType(row.FindControl("txtStartRange"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If
        Next
        For Each row As GridViewRow In gvNotaryFee.Rows
            oTextBox = CType(row.FindControl("txtEndRange"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If
        Next
        For Each row As GridViewRow In gvNotaryFee.Rows
            oTextBox = CType(row.FindControl("txtNotaryFee"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If
        Next
        For Each row As GridViewRow In gvNotaryFee.Rows
            oTextBox = CType(row.FindControl("txtInternalFee"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If
        Next

    End Sub
  
    Protected Sub btnNew_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs)
        Try
            ' BindGridFEE()
            Dim dtNotaryFee As New System.Data.DataTable
            Dim drNotaryFee As System.Data.DataRow

            dtNotaryFee = ViewState("CurrentTable")
            GetDataNotaryFee(dtNotaryFee)
            drNotaryFee = dtNotaryFee.NewRow()

            drNotaryFee("FEEID") = 0
            drNotaryFee("PRINCIPALFROM") = 0
            drNotaryFee("PRINCIPALTO") = 0
            drNotaryFee("NOTARYFEE") = 0
            drNotaryFee("INTERNALFEE") = 0

            dtNotaryFee.Rows.Add(drNotaryFee)
            gvNotaryFee.DataSource = dtNotaryFee
            gvNotaryFee.DataBind()
            ViewState("CurrentTable") = dtNotaryFee
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR NEW NOTARYFEE: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        End Try
    End Sub
    Private Sub GetDataNotaryFee(ByRef dtNotaryFee As System.Data.DataTable)

        dtNotaryFee.Clear()
        Dim sPrinFrom As String, sPrinTo As String, sInternalFee As String, sNotaryFee As String
        Dim drNotaryFee As System.Data.DataRow
        Dim oTextBox As TextBox
        Dim oLabel As Label
        Dim iNotaryId As String, iFeeId As String
        For Each gvRow As GridViewRow In gvNotaryFee.Rows

            iNotaryId = 0
            iFeeId = 0
            sPrinFrom = 0
            sPrinTo = 0
            sInternalFee = 0
            sNotaryFee = 0

            oLabel = CType(gvRow.FindControl("lblFeeID"), Label)
            If oLabel IsNot Nothing Then
                iFeeId = Replace(oLabel.Text, ",", "")
            End If

            oTextBox = CType(gvRow.FindControl("txtStartRange"), TextBox)
            If oTextBox IsNot Nothing Then
                sPrinFrom = Replace(oTextBox.Text, ",", "")
            End If

            oTextBox = CType(gvRow.FindControl("txtEndRange"), TextBox)
            If oTextBox IsNot Nothing Then
                sPrinTo = Replace(oTextBox.Text, ",", "")
            End If

            oTextBox = CType(gvRow.FindControl("txtNotaryFee"), TextBox)
            If oTextBox IsNot Nothing Then
                sNotaryFee = Replace(oTextBox.Text, ",", "")
            End If

            oTextBox = CType(gvRow.FindControl("txtInternalFee"), TextBox)
            If oTextBox IsNot Nothing Then
                sInternalFee = Replace(oTextBox.Text, ",", "")
            End If
            drNotaryFee = dtNotaryFee.NewRow()

            drNotaryFee("FEEID") = iFeeId
            drNotaryFee("PRINCIPALFROM") = String.Format("{0:N}", sPrinFrom)
            drNotaryFee("PRINCIPALTO") = String.Format("{0:N}", sPrinTo)
            drNotaryFee("NOTARYFEE") = String.Format("{0:N}", sNotaryFee)
            drNotaryFee("INTERNALFEE") = String.Format("{0:N}", sInternalFee)

            dtNotaryFee.Rows.Add(drNotaryFee)
            'oImageDel = DirectCast(gvDPMinimum.Rows(Convert.ToInt32(txtTmpSelectedIndex.Text)).FindControl("btnDelete"), ImageButton)
            'oImageDel.Visible = False
        Next
    End Sub
    Protected Sub gvNotaryFee_PageIndexChanging(sender As Object, e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvNotaryFee.PageIndexChanging
        gvNotaryFee.PageIndex = e.NewPageIndex
        Dim dt As DataTable = DirectCast(ViewState("CurrentTable"), DataTable)
        gvNotaryFee.DataSource = dt
        gvNotaryFee.DataBind()
        If gvNotaryFee.Rows.Count > 0 Then
            gvNotaryFee.SelectedIndex = 0
        End If
        lblError.Visible = False
    End Sub

    Protected Sub gvNotaryFee_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvNotaryFee.RowDataBound
        Dim oTextBox As TextBox
        For Each row As GridViewRow In gvNotaryFee.Rows
            oTextBox = CType(row.FindControl("txtStartRange"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
                If Len(Trim(oTextBox.Text)) <= 0 Then
                    oTextBox.Text = "0"
                End If
            End If
            oTextBox = CType(row.FindControl("txtEndRange"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
                If Len(Trim(oTextBox.Text)) <= 0 Then
                    oTextBox.Text = "0"
                End If
            End If
            oTextBox = CType(row.FindControl("txtNotaryFee"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
                If Len(Trim(oTextBox.Text)) <= 0 Then
                    oTextBox.Text = "0"
                End If
            End If
            oTextBox = CType(row.FindControl("txtInternalFee"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
                If Len(Trim(oTextBox.Text)) <= 0 Then
                    oTextBox.Text = "0"
                End If
            End If
        Next
    End Sub

    Protected Sub gvNotaryFee_RowDeleting(sender As Object, e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles gvNotaryFee.RowDeleting
        Dim dtNotaryFee As New System.Data.DataTable
        dtNotaryFee = ViewState("CurrentTable")
        GetDataNotaryFee(dtNotaryFee)
        dtNotaryFee = ViewState("CurrentTable")
        dtNotaryFee.Rows.RemoveAt(e.RowIndex)
        dtNotaryFee.AcceptChanges()

        ViewState("CurrentTable") = dtNotaryFee
        gvNotaryFee.DataSource = dtNotaryFee
        gvNotaryFee.DataBind()
    End Sub
   
 
    Protected Sub btnDelete_Click(sender As Object, e As System.EventArgs) Handles btnDelete.Click
        Dim objDB As New DBX
        Dim oSDR As Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromExecSQL("Update dbo.NOTARY SET DeleteSTS=1 WHERE NOTARYID=" & hidNotaryID.Value)
            If oSDR.Read() Then
            End If
            MultiView_Utama.SetActiveView(View_View)
            DataSearch()
            pnlControl.Visible = False
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR DELETE DATA NOTARY: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            lblMessage.Visible = False
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

End Class
