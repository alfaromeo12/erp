Imports System.Data
Imports System.Data.SqlClient
Imports Microsoft.Reporting.WebForms
Imports System.Collections.Generic
Imports System.IO

Partial Class Audit_AuditSQL
    Inherits System.Web.UI.Page
    Private dataTable As DataTable
    Private m_rdl As MemoryStream

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        'ClientScript.RegisterStartupScript(Me.GetType(), "CreateGridHeader", "<script>CreateGridHeader('DataDiv', 'gvColumn', 'HeaderDiv');</script>")
        'gvColumn.DataBind()
        If Not IsPostBack() Then
            rbLimitRow.Checked = True
            txtRows.Text = "100"
            imgButtonAddFilter.Visible = False
            pnlReport.Visible = False
        End If
        SetObjectValidation(txtRows, False, "integer", "[0-9]")
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub ddlView_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlView.SelectedIndexChanged
        If Len(Trim(ddlView.SelectedValue)) > 0 Then
            DataSearch()
            ResetDefaultFilter()
        End If
    End Sub

    Private Sub DataSearch()
        lblMessage.Visible = False
        gvColumn.DataBind()
        If gvColumn.Rows.Count <= 0 Then
            imgButtonAddFilter.Visible = False
            pnlReport.Visible = False
        Else
            imgButtonAddFilter.Visible = True
            pnlReport.Visible = True

        End If
    End Sub


    Private Sub ResetDefaultFilter()
        Dim dtFilter As New System.Data.DataTable

        Dim objDB As New DBX
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT CAST('' AS VARCHAR(500)) [COLUMN], '='  OPERATOR, CAST('' AS NVARCHAR(1000)) [FILTER], CAST(' ' AS VARCHAR(30)) OPERAND")
            dtFilter.Load(oSDR)
            If ViewState("VSFilter") IsNot Nothing Then
                ViewState("VSFilter") = Nothing
            End If

            ViewState("VSFilter") = dtFilter

            gvFilter.DataSource = dtFilter
            gvFilter.DataBind()

            oSDR.Close()
            oSDR = Nothing

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR AUDIT RESET DATA DEFAULT..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE:<BR>" & ex.Message
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Private Sub ResetFilterEmpty()
        Dim dtFilter As New System.Data.DataTable

        Dim objDB As New DBX
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT CAST('' AS VARCHAR(500)) [COLUMN], '='  OPERATOR, CAST('' AS NVARCHAR(1000)) [FILTER], CAST(' ' AS VARCHAR(30)) OPERAND")
            dtFilter.Load(oSDR)
            If ViewState("VSFilter") IsNot Nothing Then
                ViewState("VSFilter") = Nothing
            End If

            ViewState("VSFilter") = dtFilter

            gvFilter.DataSource = dtFilter
            gvFilter.DataBind()

            oSDR.Close()
            oSDR = Nothing

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR AUDIT RESET DATA DEFAULT..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE:<BR>" & ex.Message
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub imgButtonAddFilter_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imgButtonAddFilter.Click
        Dim dtFilter As New System.Data.DataTable

        dtFilter = ViewState("VSFilter")

        GetData(True, dtFilter)
        gvFilter.DataSource = dtFilter
        gvFilter.DataBind()
    End Sub

    Private Sub GetData(ByVal blnNew As Boolean, _
                        ByRef dtFilter As System.Data.DataTable)
        dtFilter.Clear()
        Dim drFilter As System.Data.DataRow
        Dim oDropDown As DropDownList
        Dim oTextBox As TextBox
        Dim strColumn As String = "", strOperator As String = "", strFilter As String = ""
        Dim strOperand As String = ""

        For Each gvRow As GridViewRow In gvFilter.Rows
            drFilter = dtFilter.NewRow()
            oDropDown = CType(gvRow.FindControl("ddlColumn"), DropDownList)
            If oDropDown IsNot Nothing Then
                strColumn = oDropDown.SelectedValue
            End If

            oDropDown = CType(gvRow.FindControl("ddlOperator"), DropDownList)
            If oDropDown IsNot Nothing Then
                strOperator = oDropDown.SelectedValue
            End If

            oTextBox = CType(gvRow.FindControl("txtFilter"), TextBox)
            If oTextBox IsNot Nothing Then
                strFilter = oTextBox.Text
            End If

            oDropDown = CType(gvRow.FindControl("ddlOperand"), DropDownList)
            If oDropDown IsNot Nothing Then
                strOperand = oDropDown.SelectedValue
            End If

            drFilter("COLUMN") = strColumn
            drFilter("OPERATOR") = strOperator
            drFilter("FILTER") = strFilter
            drFilter("OPERAND") = strOperand
            dtFilter.Rows.Add(drFilter)

        Next

        If blnNew Then
            drFilter = dtFilter.NewRow()
            drFilter("COLUMN") = ""
            drFilter("OPERATOR") = "="
            drFilter("FILTER") = ""
            drFilter("OPERAND") = " "
            dtFilter.Rows.Add(drFilter)

        End If

        ViewState("VSFilter") = dtFilter
    End Sub

    Private Sub GetDataNoBlank(ByRef dtFilter As System.Data.DataTable)
        dtFilter.Clear()
        Dim drFilter As System.Data.DataRow
        Dim oDropDown As DropDownList
        Dim oTextBox As TextBox
        Dim strColumn As String = "", strOperator As String = "", strFilter As String = ""
        Dim strOperand As String = ""

        For Each gvRow As GridViewRow In gvFilter.Rows
            drFilter = dtFilter.NewRow()
            oDropDown = CType(gvRow.FindControl("ddlColumn"), DropDownList)
            If oDropDown IsNot Nothing Then
                strColumn = oDropDown.SelectedValue
            End If

            oDropDown = CType(gvRow.FindControl("ddlOperator"), DropDownList)
            If oDropDown IsNot Nothing Then
                strOperator = oDropDown.SelectedValue
            End If

            oTextBox = CType(gvRow.FindControl("txtFilter"), TextBox)
            If oTextBox IsNot Nothing Then
                strFilter = oTextBox.Text
            End If

            oDropDown = CType(gvRow.FindControl("ddlOperand"), DropDownList)
            If oDropDown IsNot Nothing Then
                strOperand = oDropDown.SelectedValue
            End If
            If Len(Trim(strColumn)) > 0 And Len(Trim(strFilter)) > 0 Then
                drFilter("COLUMN") = strColumn
                drFilter("OPERATOR") = strOperator
                drFilter("FILTER") = strFilter
                drFilter("OPERAND") = strOperand
                dtFilter.Rows.Add(drFilter)
            End If
        Next
    End Sub


    Protected Sub btnReport_Click(sender As Object, e As System.EventArgs) Handles btnReport.Click
        Try

            If gvFilter.Rows.Count > 1 Then
                Dim dtFilter As New System.Data.DataTable

                dtFilter = ViewState("VSFilter")

                GetDataNoBlank(dtFilter)
                gvFilter.DataSource = dtFilter
                gvFilter.DataBind()
            End If

            lblMessage.Visible = False
            Dim strSQL As String = ""
            Dim oHidden As HiddenField
            Dim strColumns As String = ""
            Dim strTop As String = ""
            Dim oCheckBox As CheckBox
            Dim oDropDown As DropDownList
            Dim oTextBox As TextBox

            For Each gvRow As GridViewRow In gvColumn.Rows
                oCheckBox = CType(gvRow.FindControl("cbCheck"), CheckBox)
                If oCheckBox IsNot Nothing Then
                    If oCheckBox.Checked Then
                        oHidden = CType(gvRow.FindControl("hidColumn"), HiddenField)
                        If oHidden IsNot Nothing Then
                            strColumns = strColumns & oHidden.Value & ","
                        End If
                    End If
                End If
            Next
            Dim strWhere As String = ""
            Dim i As Integer = 0
            For Each gvRow As GridViewRow In gvFilter.Rows
                i = i + 1
                oDropDown = CType(gvRow.FindControl("ddlColumn"), DropDownList)
                oTextBox = CType(gvRow.FindControl("txtFilter"), TextBox)
                If oDropDown IsNot Nothing And oTextBox IsNot Nothing Then
                    If Len(Trim(oDropDown.SelectedValue)) > 0 And Len(Trim(oTextBox.Text)) > 0 Then
                        'column filter
                        strWhere = strWhere & " " & oDropDown.SelectedValue
                        oDropDown = CType(gvRow.FindControl("ddlOperator"), DropDownList)
                        If oDropDown IsNot Nothing Then
                            'operator
                            strWhere = strWhere & " " & oDropDown.SelectedValue & " "
                        End If
                        'filter value
                        strWhere = strWhere & " '" & oTextBox.Text & "' "

                        'jika bukan filter terakhir, ambil operand
                        If i < gvFilter.Rows.Count Then
                            oDropDown = CType(gvRow.FindControl("ddlOperand"), DropDownList)
                            If oDropDown IsNot Nothing Then
                                If Len(Trim(oDropDown.SelectedValue)) > 0 Then
                                    strWhere = strWhere & oDropDown.SelectedValue
                                End If
                            End If
                        End If

                    End If
                End If

            Next


            If rbLimitRow.Checked Then
                strTop = " TOP " & txtRows.Text & " "
            End If
            If Len(Trim(strColumns)) > 0 Then
                strColumns = Left(strColumns, Len(strColumns) - 1)
            Else
                strColumns = "*"
            End If



            strSQL = "SELECT " & strTop & strColumns & " FROM " & ddlView.SelectedItem.Text & " WITH(NOLOCK)"
            If Len(Trim(strWhere)) > 0 Then
                strSQL = strSQL & " WHERE " & strWhere
            End If

            Dim oSC As New System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("connection").ConnectionString())
            Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
            Dim dss As New System.Data.DataSet()

            da.Fill(dss)
            dataTable = dss.Tables(0)
            da.Dispose()
            Dim allFields As List(Of String) = GetAvailableFields()
            Dim selectedFields As List(Of String) = GetAvailableFields()
            m_rdl = GenerateRdl(allFields, selectedFields)
            If Not (m_rdl Is Nothing) Then
                m_rdl.Dispose()
            End If
            m_rdl = GenerateRdl(allFields, selectedFields)

            ShowReport()

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR GENERATE REPORT...!<BR>PLEASE CHECK DETAIL ERROR MESSAGE:<BR>" & ex.Message
        End Try
    End Sub

    Private Sub ShowReport()
        Me.ReportViewer1.Reset()
        Me.ReportViewer1.LocalReport.LoadReportDefinition(m_rdl)
        'Me.ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("MyData", m_dataSet.Tables(0)))
        'Me.ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("MyData", dataTable))

        'Me.ReportViewer1.RefreshReport()
        Me.ReportViewer1.LocalReport.Refresh()
    End Sub

    Private Function GenerateRdl(ByVal allFields As List(Of String), ByVal selectedFields As List(Of String)) As MemoryStream
        Dim ms As New MemoryStream()
        Dim gen As New DynamicTable.RdlGenerator()
        gen.AllFields = allFields
        gen.SelectedFields = selectedFields
        gen.WriteXml(ms)
        ms.Position = 0
        Return ms
    End Function

    Private Function GetAvailableFields() As List(Of String)
        'Dim dataTable As DataTable = m_dataSet.Tables(0)
        Dim availableFields As New List(Of String)
        Dim i As Integer
        For i = 0 To dataTable.Columns.Count - 1
            availableFields.Add(dataTable.Columns(i).ColumnName)
        Next i
        Return availableFields
    End Function

    Protected Sub gvFilter_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvFilter.RowCommand
        If e.CommandName = "DeleteRow" Then
            Response.Write(e.CommandArgument)

        End If
    End Sub
End Class
