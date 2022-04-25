Imports System.Data
Imports System.Data.SqlClient
Partial Class Param_BranchRule
    Inherits System.Web.UI.Page
    Public strBranchId As String
    Private dt As New DataTable
    Private dr As DataRow
    Public Shared strAppDate As String

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE, CAST(dbo.f_IsUserBranch(" & Request.Cookies("UID").Value & ") as VARCHAR(10)) ISUSERBRANCH FROM APPSETTING WITH(NOLOCK) WHERE APPCODE='APPDATE'")
            If oSDR.Read Then
                'strAppDate = String.Format("{0:dd/MM/yyyy}", oSDR("APPVALUE"))
                strAppDate = oSDR("APPVALUE")
            End If
            oSDR.Close()
            oSDR = Nothing
            If Not IsPostBack Then
                hidBranchID.Value = ""
                hidFinCatID.Value = ""
                fvData.Caption = ""
                pnlPenalty.Visible = False
                pnlETPenalty.Visible = False
                SetValidation()
            End If
          

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub

    Private Sub SetValidation()
        Dim oTextBox As TextBox
        oTextBox = CType(fvData.FindControl("txtBranchCode"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase nospace")
            oTextBox.Focus()
        End If
        oTextBox = CType(fvData.FindControl("txtBranchName"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")

        oTextBox = CType(fvData.FindControl("txtWorkingDays"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "int", "[0-9]")

        oTextBox = CType(fvData.FindControl("txtPenaltyRate"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")

        oTextBox = CType(fvData.FindControl("txtADMterminate"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")

        oTextBox = CType(fvData.FindControl("txtGracePeriode"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "int", "[0-9]")

        oTextBox = CType(fvData.FindControl("txtETPenaltyRule"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "decimal signed float", "[0-9.]")

        oTextBox = CType(gvPenalty.FindControl("txtPenaltyRate"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")

    End Sub

    Private Sub DataSearch()

        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If

        If Len(Trim(ddlAreaSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND AREAID=" & ddlAreaSearch.SelectedValue
        End If
        gvData.DataBind()
        fvData.Visible = False
    End Sub

    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        hidBranchID.Value = ""
        hidFinCatID.Value = ""
        gvData.SelectedIndex = -1
        DataSearch()
        lblError.Visible = False
    End Sub

    Protected Sub ddlAreaSearch_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlAreaSearch.SelectedIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
        fvData.Visible = False
    End Sub

    Protected Sub gvData_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        If e.CommandName = "Select" Then
            gvData.SelectedIndex = e.CommandArgument
            hidBranchID.Value = gvData.SelectedDataKey("BRANCHID")
            pnlETPenalty.Visible = False
            pnlPenalty.Visible = False
            hidFinCatID.Value = ""
            fvData.Caption = ""
        End If

    End Sub

    Protected Sub gvFinCat_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvFinCat.RowCommand
        If e.CommandName = "Select" Then
            gvFinCat.SelectedIndex = e.CommandArgument
            hidFinCatID.Value = gvFinCat.SelectedDataKey("FINCATID")
            fvData.Visible = True
            pnlPenalty.Visible = False
            pnlETPenalty.Visible = False
            fvData.ChangeMode(FormViewMode.Edit)
            fvData.Caption = "BRANCH RULE EDIT"
            If CType(gvFinCat.Rows(e.CommandArgument).FindControl("lblRuleExist"), Label).Text = 0 Then
                pnlPenalty.Visible = False
                pnlETPenalty.Visible = False
            End If
        End If

    End Sub

    Protected Sub fvData_ItemCommand(sender As Object, e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvData.ItemCommand
        If e.CommandName = "Cancel" Then
            hidFinCatID.Value = ""
            fvData.Caption = ""
        End If

    End Sub

    Protected Sub sdsForm_Updated(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Branch Rule : " & e.Command.Parameters("@BranchID").Value & " already exists..!"
        Else
            lblError.Visible = False
            DataSearch()
        End If
    End Sub

    Protected Sub fvData_ItemCreated(sender As Object, e As System.EventArgs) Handles fvData.ItemCreated
        SetValidation()
    End Sub

    Protected Sub fvData_ItemDeleted(sender As Object, e As System.Web.UI.WebControls.FormViewDeletedEventArgs) Handles fvData.ItemDeleted
        gvFinCat.DataBind()
        hidFinCatID.Value = ""
        fvData.Caption = ""
    End Sub
    Protected Sub fvData_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewUpdatedEventArgs) Handles fvData.ItemUpdated
        gvFinCat.DataBind()
    End Sub

    Protected Sub gvFinCat_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvFinCat.RowDataBound
        If DataBinder.Eval(e.Row.DataItem, "RULE EXIST") Then
            e.Row.ForeColor = Drawing.Color.Blue
            e.Row.Font.Bold = True
        ElseIf DataBinder.Eval(e.Row.DataItem, "NO RULE") Then
            e.Row.Font.Italic = True
        End If
        If (e.Row.RowType = DataControlRowType.DataRow) Then

        End If

    End Sub
    Protected Sub imgPenalty_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        Dim currentCommand As String = e.CommandName
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument)
        Dim sFinCatId As String

        Try
            sFinCatId = (CType(gvFinCat.Rows(currentRowIndex).FindControl("lblFinCatID"), Label).Text)
            hidFinCatID.Value = sFinCatId
            GetDataPenaltyRule()
            pnlPenalty.Visible = True
            fvData.Visible = False
            pnlETPenalty.Visible = False
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = ""
        End Try
        SetValidation()
    End Sub

    Protected Sub btnNewPenalty_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs)
        Try

            Dim dtPenalty As New System.Data.DataTable
            Dim drPenalty As System.Data.DataRow
            dtPenalty = ViewState("VW_PENALTY")
            GetDataPenalty(dtPenalty)
            drPenalty = dtPenalty.NewRow()

            drPenalty("BRANCHID") = 0
            drPenalty("FINCATID") = 0
            drPenalty("PENALTYID") = 0
            'drPenalty("BOOKFROM") = String.Format("{0:dd/MM/yyyy}", strAppDate)
            'drPenalty("BOOKTO") = String.Format("{0:dd/MM/yyyy}", strAppDate)
            drPenalty("BOOKFROM") = strAppDate
            drPenalty("BOOKTO") = strAppDate
            drPenalty("PENALTYTYPE") = 1
            drPenalty("PENALTYRATE") = 0
            dtPenalty.Rows.Add(drPenalty)
            gvPenalty.DataSource = dtPenalty
            gvPenalty.DataBind()
            ViewState("VW_PENALTY") = dtPenalty

        Catch ex As Exception
            lblError.Visible = True
            lblError.Text = "ERROR NEW BRANCH RULE PENALTY : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        End Try
    End Sub
    Private Sub AddRowEmptyPenalty()
        Dim dt As New DataTable()
        Dim dr As DataRow = Nothing
        ' Dim oImageDel As ImageButton

        dt.Columns.Add(New DataColumn("BRANCHID", GetType(String)))
        dt.Columns.Add(New DataColumn("FINCATID", GetType(String)))
        dt.Columns.Add(New DataColumn("PENALTYID", GetType(String)))
        dt.Columns.Add(New DataColumn("BOOKFROM", GetType(String)))
        dt.Columns.Add(New DataColumn("BOOKTO", GetType(String)))
        dt.Columns.Add(New DataColumn("PENALTYTYPE", GetType(String)))
        dt.Columns.Add(New DataColumn("PENALTYRATE", GetType(Double)))

        dr = dt.NewRow()
        dr("BRANCHID") = 0
        dr("FINCATID") = 0
        dr("PENALTYID") = 0
        'dr("BOOKFROM") = String.Format("{0:dd/MM/yyyy}", strAppDate)
        'dr("BOOKTO") = String.Format("{0:dd/MM/yyyy}", strAppDate)
        dr("BOOKFROM") = strAppDate
        dr("BOOKTO") = strAppDate
        dr("PENALTYTYPE") = 1
        dr("PENALTYRATE") = 0

        dt.Rows.Add(dr)

        ViewState("VW_PENALTY") = dt

        gvPenalty.DataSource = dt
        gvPenalty.DataBind()

        'oImageDel = DirectCast(gvPenalty.Rows(Convert.ToInt32(txtTmpSelectedIndex.Text)).FindControl("btnDelete"), ImageButton)
        'oImageDel.Visible = False
    End Sub

    Protected Sub gvPenalty_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvPenalty.RowDataBound
        Dim oTextBox As TextBox
        For Each row As GridViewRow In gvPenalty.Rows
            oTextBox = CType(row.FindControl("txtPenaltyRate"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If
        Next
    End Sub

    Protected Sub gvPenalty_RowDeleting(sender As Object, e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles gvPenalty.RowDeleting
        Dim dtPenalty As New System.Data.DataTable
        dtPenalty = ViewState("VW_PENALTY")
        dtPenalty.Rows.RemoveAt(e.RowIndex)
        dtPenalty.AcceptChanges()

        ViewState("VW_PENALTY") = dtPenalty
        gvPenalty.DataSource = dtPenalty
        gvPenalty.DataBind()
    End Sub
    Private Sub GetDataPenalty(ByRef dtPenalty As System.Data.DataTable)
        'If dtPenalty Is Nothing Then
        dtPenalty.Clear()
        'End If

        ' Dim oImageDel As ImageButton
        Dim sBookFrom As String
        Dim sBookTo As String
        Dim sPenaltyType As String
        Dim dPenaltyRate As Double
        Dim drPenalty As System.Data.DataRow
        Dim oTextBox As TextBox
        Dim oDropDownList As DropDownList
        Dim iPenaltyID As Integer
        For Each gvRow As GridViewRow In gvPenalty.Rows

            iPenaltyID = 0
            sBookFrom = ""
            sBookTo = ""
            sPenaltyType = ""
            dPenaltyRate = 0

            oTextBox = CType(gvRow.FindControl("txtPenaltyID"), TextBox)
            If oTextBox IsNot Nothing Then
                iPenaltyID = Replace(oTextBox.Text, ",", "")
            End If

            oTextBox = CType(gvRow.FindControl("txtBookFrom"), TextBox)
            If oTextBox IsNot Nothing Then
                If hidAction.Value = "NEW" Then
                    sBookFrom = Replace(oTextBox.Text, ",", "")
                    ' sBookFrom = Replace(ConvertDate(oTextBox.Text), ",", "")
                ElseIf hidAction.Value = "EDIT" Then
                    sBookFrom = Replace(ConvertDate(oTextBox.Text), ",", "")
                End If
            End If

            oTextBox = CType(gvRow.FindControl("txtBookTo"), TextBox)
            If oTextBox IsNot Nothing Then
                If hidAction.Value = "NEW" Then
                    sBookTo = Replace(oTextBox.Text, ",", "")
                    'sBookTo = Replace(ConvertDate(oTextBox.Text), ",", "")
                ElseIf hidAction.Value = "EDIT" Then
                    sBookTo = Replace(ConvertDate(oTextBox.Text), ",", "")
                End If
            End If

            oDropDownList = CType(gvRow.FindControl("ddlPenaltyType"), DropDownList)
            If oDropDownList IsNot Nothing Then
                sPenaltyType = oDropDownList.SelectedValue
            End If
            oTextBox = CType(gvRow.FindControl("txtPenaltyRate"), TextBox)
            If oTextBox IsNot Nothing Then
                dPenaltyRate = Replace(oTextBox.Text, ",", "")
            End If

            drPenalty = dtPenalty.NewRow()

            If ChkAddNew.Checked Then
                drPenalty("BRANCHID") = "0"
                drPenalty("FINCATID") = "0"
            Else
                drPenalty("BRANCHID") = hidBranchID.Value
                drPenalty("FINCATID") = hidFinCatID.Value
            End If

            drPenalty("PENALTYID") = iPenaltyID

            If hidAction.Value = "NEW" Then
                drPenalty("BOOKFROM") = sBookFrom
                drPenalty("BOOKTO") = sBookTo
            ElseIf hidAction.Value = "EDIT" Then
                drPenalty("BOOKFROM") = String.Format("{0:dd/MM/yyyy}", sBookFrom)
                drPenalty("BOOKTO") = String.Format("{0:dd/MM/yyyy}", sBookTo)
            End If
            drPenalty("PENALTYTYPE") = sPenaltyType
            drPenalty("PENALTYRATE") = String.Format("{0:N}", dPenaltyRate)

            dtPenalty.Rows.Add(drPenalty)
        Next
    End Sub
    Private Sub SavePenalty(ByVal sBranchID As Integer, ByVal sFinCatID As Integer, ByVal sPenaltyID As Integer, ByVal sBookFrom As String,
            ByVal sBookTo As String, ByVal sPenaltyType As String, ByVal sPenaltyRate As Double)

        Dim objDB As New DBX
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try

            oSQLParam = objDB.ExecSPReturnParam("BRANCHRULEPENALTYSave", _
                   objDB.MP("@BRANCHID", Data.SqlDbType.Int, sBranchID, 8), _
                   objDB.MP("@FINCATID", Data.SqlDbType.Int, sFinCatID, 8), _
                   objDB.MP("@PENALTYID", Data.SqlDbType.Int, sPenaltyID, 8), _
                   objDB.MP("@BOOKFROM", Data.SqlDbType.DateTime, ConvertDate(sBookFrom), 8), _
                   objDB.MP("@BOOKTO", Data.SqlDbType.DateTime, ConvertDate(sBookTo), 8), _
                   objDB.MP("@PENALTYTYPE", Data.SqlDbType.SmallInt, sPenaltyType, 8), _
                   objDB.MP("@PENALTYRATE", Data.SqlDbType.Float, sPenaltyRate, 8), _
                   objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 20))

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE DATA BRANCH RULE PENALTY : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnSavePenalty_Click(sender As Object, e As System.EventArgs) Handles btnSavePenalty.Click
        Dim objDB As New DBX
        'Dim oSDR As Data.SqlClient.SqlDataReader
        Dim iRow As Integer
        Dim iRows As Integer
        Try
            If DirectCast(ViewState("VW_PENALTY"), DataTable) IsNot Nothing Then
                'oSDR = objDB.CreateSDRFromExecSQL("Update dbo.BRANCHRULEPENALTY SET DeleteSTS=1, LASTUPDATE=GETDATE() WHERE BRANCHID=" & hidBranchID.Value & " AND FINCATID=" & hidFinCatID.Value)
                'If oSDR.Read() Then
                'End If
                'oSDR.Close()

                objDB.ExecSQLWithParam("UPDATE BRANCHRULEPENALTY SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSER=@USERID WHERE BRANCHID=@BRANCHID AND FINCATID=@FINCATID", _
                            objDB.MP("@USERID", SqlDbType.Int, Request.Cookies("UID").Value), _
                            objDB.MP("@BRANCHID", SqlDbType.Int, hidBranchID.Value), _
                            objDB.MP("@FINCATID", SqlDbType.Int, hidFinCatID.Value))
                'Dim dtPenalty As New System.Data.DataTable
                'dtPenalty = ViewState("VW_PENALTY")
                'GetDataPenalty(dtPenalty)
                'For Each row As System.Data.DataRow In dtPenalty.Rows
                iRows = gvPenalty.Rows.Count
                For iRow = 0 To iRows - 1
                    If CType(gvPenalty.Rows(iRow).FindControl("txtBookFrom"), TextBox).Text > "0" Then
                        SavePenalty(hidBranchID.Value, hidFinCatID.Value,
                                    CType(gvPenalty.Rows(iRow).FindControl("txtPenaltyID"), TextBox).Text,
                                    CType(gvPenalty.Rows(iRow).FindControl("txtBookFrom"), TextBox).Text,
                                    CType(gvPenalty.Rows(iRow).FindControl("txtBookTo"), TextBox).Text,
                                    CType(gvPenalty.Rows(iRow).FindControl("ddlPenaltyType"), DropDownList).SelectedValue,
                                    CType(gvPenalty.Rows(iRow).FindControl("txtPenaltyRate"), TextBox).Text)
                    End If
                Next
            End If

            If DirectCast(ViewState("VW_PENALTY"), DataTable) Is Nothing Then
            Else
                DirectCast(ViewState("VW_PENALTY"), DataTable).Rows.Clear()
                DirectCast(ViewState("VW_PENALTY"), DataTable).Dispose()
            End If
            GetDataPenaltyRule()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE BRANCH RULE PENALTY : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        DataSearch()
    End Sub
    Private Sub GetDataPenaltyRule()
        Dim objDB As New DBX
        Try
            Dim oSDR As Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT BRANCHID,FINCATID,PENALTYID,PENALTYTYPE,PENALTYRATE,BOOKFROM,BOOKTO FROM BRANCHRULEPENALTY WHERE (BRANCHID = " & hidBranchID.Value & ") AND (FINCATID = " & hidFinCatID.Value & ") AND DELETESTS=0")
            If oSDR.HasRows Then
                Dim dtPenalty As New System.Data.DataTable
                dtPenalty.Load(oSDR)
                If ViewState("VW_PENALTY") IsNot Nothing Then
                    ViewState("VW_PENALTY") = Nothing
                End If
                ViewState("VW_PENALTY") = dtPenalty
                gvPenalty.DataSource = dtPenalty
                gvPenalty.DataBind()
                hidAction.Value = "EDIT"
                dtPenalty = ViewState("VW_PENALTY")
                GetDataPenalty(dtPenalty)
                oSDR.Close()
                oSDR = Nothing
            Else
                hidAction.Value = "NEW"
                AddRowEmptyPenalty()
            End If

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RETRIVE DATA PENALTY RULE ENTRY: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub
    Protected Sub imgETPenalty_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        Dim currentCommand As String = e.CommandName
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument)
        Dim sFinCatId As String

        Try
            sFinCatId = (CType(gvFinCat.Rows(currentRowIndex).FindControl("lblFinCatID"), Label).Text)
            hidFinCatID.Value = sFinCatId
            GetDataETPenaltyRule()
            pnlETPenalty.Visible = True
            fvData.Visible = False
            pnlPenalty.Visible = False
        Catch ex As Exception
            lblMessageET.Visible = True
            lblMessageET.Text = ""
        End Try
        SetValidation()
    End Sub
    Protected Sub btnNewETPenalty_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs)
        Try

            Dim dtETPenalty As New System.Data.DataTable
            Dim drETPenalty As System.Data.DataRow
            dtETPenalty = ViewState("VW_ETPENALTY")
            GetDataETPenalty(dtETPenalty)
            drETPenalty = dtETPenalty.NewRow()

            drETPenalty("BRANCHID") = 0
            drETPenalty("FINCATID") = 0
            drETPenalty("PENALTYID") = 0
            drETPenalty("BOOKFROM") = String.Format("{0:dd/MM/yyyy}", strAppDate)
            drETPenalty("BOOKTO") = String.Format("{0:dd/MM/yyyy}", strAppDate)

            'drPenalty("BOOKFROM") = ""
            'drPenalty("BOOKTO") = ""
            drETPenalty("ETPENALTYTYPE") = 1
            drETPenalty("ETPENALTY") = 0
            drETPenalty("ADMTERMINATE") = 0

            dtETPenalty.Rows.Add(drETPenalty)
            gvETPenalty.DataSource = dtETPenalty
            gvETPenalty.DataBind()
            ViewState("VW_ETPENALTY") = dtETPenalty

        Catch ex As Exception
            lblError.Visible = True
            lblError.Text = "ERROR NEW BRANCH RULE ET PENALTY : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        End Try
    End Sub

    Private Sub AddRowEmptyETPenalty()
        Dim dt As New DataTable()
        Dim dr As DataRow = Nothing
        ' Dim oImageDel As ImageButton

        dt.Columns.Add(New DataColumn("BRANCHID", GetType(String)))
        dt.Columns.Add(New DataColumn("FINCATID", GetType(String)))
        dt.Columns.Add(New DataColumn("PENALTYID", GetType(String)))
        dt.Columns.Add(New DataColumn("BOOKFROM", GetType(String)))
        dt.Columns.Add(New DataColumn("BOOKTO", GetType(String)))
        dt.Columns.Add(New DataColumn("ETPENALTYTYPE", GetType(String)))
        dt.Columns.Add(New DataColumn("ETPENALTY", GetType(Double)))
        dt.Columns.Add(New DataColumn("ADMTERMINATE", GetType(Double)))

        dr = dt.NewRow()
        dr("BRANCHID") = 0
        dr("FINCATID") = 0
        dr("PENALTYID") = 0
        'dr("BOOKFROM") = String.Format("{0:dd/MM/yyyy}", strAppDate)
        'dr("BOOKTO") = String.Format("{0:dd/MM/yyyy}", strAppDate)
        dr("BOOKFROM") = strAppDate
        dr("BOOKTO") = strAppDate
        dr("ETPENALTYTYPE") = 1
        dr("ETPENALTY") = 0
        dr("ADMTERMINATE") = 0

        dt.Rows.Add(dr)

        ViewState("VW_ETPENALTY") = dt

        gvETPenalty.DataSource = dt
        gvETPenalty.DataBind()

        'oImageDel = DirectCast(gvPenalty.Rows(Convert.ToInt32(txtTmpSelectedIndex.Text)).FindControl("btnDelete"), ImageButton)
        'oImageDel.Visible = False
    End Sub

    Protected Sub gvETPenalty_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvETPenalty.RowDataBound
        Dim oTextBox As TextBox
        For Each row As GridViewRow In gvETPenalty.Rows
            oTextBox = CType(row.FindControl("txtETPenaltyRate"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "decimal signed float", "[0-9.]")
            End If

            oTextBox = CType(row.FindControl("txtETADMTerminate"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "decimal signed float", "[0-9.]")
            End If
        Next
    End Sub

    Protected Sub gvETPenalty_RowDeleting(sender As Object, e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles gvETPenalty.RowDeleting
        Dim dtETPenalty As New System.Data.DataTable
        dtETPenalty = ViewState("VW_ETPENALTY")
        dtETPenalty.Rows.RemoveAt(e.RowIndex)
        dtETPenalty.AcceptChanges()

        ViewState("VW_ETPENALTY") = dtETPenalty
        gvETPenalty.DataSource = dtETPenalty
        gvETPenalty.DataBind()
    End Sub
    Private Sub GetDataETPenalty(ByRef dtETPenalty As System.Data.DataTable)
        'If dtPenalty Is Nothing Then
        dtETPenalty.Clear()
        'End If

        ' Dim oImageDel As ImageButton
        Dim sETBookFrom As String
        Dim sETBookTo As String
        Dim sETPenaltyType As String
        Dim sETPenalty As Double
        Dim sADMTerminate As Double

        Dim drETPenalty As System.Data.DataRow

        Dim oTextBox As TextBox
        Dim oDropDownList As DropDownList
        Dim iPenaltyID As Integer
        For Each gvRow As GridViewRow In gvETPenalty.Rows

            iPenaltyID = 0
            sETBookFrom = ""
            sETBookTo = ""
            sETPenaltyType = ""
            sETPenalty = 0
            sADMTerminate = 0

            oTextBox = CType(gvRow.FindControl("txtETPenaltyID"), TextBox)
            If oTextBox IsNot Nothing Then
                iPenaltyID = Replace(oTextBox.Text, ",", "")
            End If

            oTextBox = CType(gvRow.FindControl("txtETBookFrom"), TextBox)
            If oTextBox IsNot Nothing Then
                If hidAction.Value = "NEW" Then
                    sETBookFrom = Replace(oTextBox.Text, ",", "")
                    ' sBookFrom = Replace(ConvertDate(oTextBox.Text), ",", "")
                ElseIf hidAction.Value = "EDIT" Then
                    sETBookFrom = Replace(ConvertDate(oTextBox.Text), ",", "")
                End If
            End If

            oTextBox = CType(gvRow.FindControl("txtETBookTo"), TextBox)
            If oTextBox IsNot Nothing Then
                If hidAction.Value = "NEW" Then
                    sETBookTo = Replace(oTextBox.Text, ",", "")
                    'sBookTo = Replace(ConvertDate(oTextBox.Text), ",", "")
                ElseIf hidAction.Value = "EDIT" Then
                    sETBookTo = Replace(ConvertDate(oTextBox.Text), ",", "")
                End If
            End If

            oDropDownList = CType(gvRow.FindControl("ddlETPenaltyType"), DropDownList)
            If oDropDownList IsNot Nothing Then
                sETPenaltyType = oDropDownList.SelectedValue
            End If

            oTextBox = CType(gvRow.FindControl("txtETPenaltyRate"), TextBox)
            If oTextBox IsNot Nothing Then
                sETPenalty = Replace(oTextBox.Text, ",", "")
            End If

            oTextBox = CType(gvRow.FindControl("txtETADMTerminate"), TextBox)
            If oTextBox IsNot Nothing Then
                sADMTerminate = Replace(oTextBox.Text, ",", "")
            End If

            drETPenalty = dtETPenalty.NewRow()

            If ChkAddNew.Checked Then
                drETPenalty("BRANCHID") = "0"
                drETPenalty("FINCATID") = "0"
            Else
                drETPenalty("BRANCHID") = hidBranchID.Value
                drETPenalty("FINCATID") = hidFinCatID.Value
            End If

            drETPenalty("PENALTYID") = iPenaltyID

            If hidAction.Value = "NEW" Then
                drETPenalty("BOOKFROM") = sETBookFrom
                drETPenalty("BOOKTO") = sETBookTo
            ElseIf hidAction.Value = "EDIT" Then
                drETPenalty("BOOKFROM") = String.Format("{0:dd/MM/yyyy}", sETBookFrom)
                drETPenalty("BOOKTO") = String.Format("{0:dd/MM/yyyy}", sETBookTo)
            End If
            drETPenalty("ETPENALTYTYPE") = sETPenaltyType
            drETPenalty("ETPENALTY") = String.Format("{0:N}", sETPenalty)
            drETPenalty("ADMTerminate") = sADMTerminate

            dtETPenalty.Rows.Add(drETPenalty)
        Next
    End Sub
    Private Sub GetDataETPenaltyRule()
        Dim objDB As New DBX
        Try
            Dim oSDR As Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT BRANCHID,FINCATID,PENALTYID,ETPENALTYTYPE,ETPENALTY,BOOKFROM,BOOKTO,ADMTERMINATE FROM BRANCHRULEETPENALTY WHERE (BRANCHID = " & hidBranchID.Value & ") AND (FINCATID = " & hidFinCatID.Value & ") AND DELETESTS=0")
            If oSDR.HasRows Then
                Dim dtETPenalty As New System.Data.DataTable
                dtETPenalty.Load(oSDR)
                If ViewState("VW_ETPENALTY") IsNot Nothing Then
                    ViewState("VW_ETPENALTY") = Nothing
                End If
                ViewState("VW_ETPENALTY") = dtETPenalty
                gvETPenalty.DataSource = dtETPenalty
                gvETPenalty.DataBind()
                hidAction.Value = "EDIT"
                dtETPenalty = ViewState("VW_ETPENALTY")
                GetDataETPenalty(dtETPenalty)
                oSDR.Close()
                oSDR = Nothing
            Else
                hidAction.Value = "NEW"
                AddRowEmptyETPenalty()
            End If

        Catch ex As Exception
            lblMessageET.Visible = True
            lblMessageET.Text = "ERROR RETRIVE DATA ET PENALTY RULE ENTRY: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub

    Private Sub SaveETPenalty(ByVal sETBranchID As Integer, ByVal sETFinCatID As Integer, ByVal sETPenaltyID As Integer, ByVal sETBookFrom As String,
            ByVal sETBookTo As String, ByVal sETPenaltyType As String, ByVal sETPenalty As Double, ByVal sADMTerminate As Double)

        Dim objDB As New DBX
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try

            oSQLParam = objDB.ExecSPReturnParam("BRANCHRULEETPENALTYSave", _
                   objDB.MP("@BRANCHID", Data.SqlDbType.Int, sETBranchID, 8), _
                   objDB.MP("@FINCATID", Data.SqlDbType.Int, sETFinCatID, 8), _
                   objDB.MP("@PENALTYID", Data.SqlDbType.Int, sETPenaltyID, 8), _
                   objDB.MP("@BOOKFROM", Data.SqlDbType.DateTime, ConvertDate(sETBookFrom), 8), _
                   objDB.MP("@BOOKTO", Data.SqlDbType.DateTime, ConvertDate(sETBookTo), 8), _
                   objDB.MP("@ETPENALTYTYPE", Data.SqlDbType.SmallInt, sETPenaltyType, 8), _
                   objDB.MP("@ETPENALTY", Data.SqlDbType.Float, sETPenalty, 8), _
                   objDB.MP("@ADMTERMINATE", Data.SqlDbType.Money, sADMTerminate, 8), _
                   objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 20))

        Catch ex As Exception
            lblMessageET.Visible = True
            lblMessageET.Text = "ERROR SAVE DATA BRANCH RULE ET PENALTY : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Protected Sub btnSaveETPenalty_Click(sender As Object, e As System.EventArgs) Handles btnSaveETPenalty.Click
        Dim objDB As New DBX
        Dim iRow As Integer
        Dim iRows As Integer
        Try
            If DirectCast(ViewState("VW_ETPENALTY"), DataTable) IsNot Nothing Then
                objDB.ExecSQLWithParam("UPDATE BRANCHRULEETPENALTY SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSER=@USERID WHERE BRANCHID=@BRANCHID AND FINCATID=@FINCATID", _
                            objDB.MP("@USERID", SqlDbType.Int, Request.Cookies("UID").Value), _
                            objDB.MP("@BRANCHID", SqlDbType.Int, hidBranchID.Value), _
                            objDB.MP("@FINCATID", SqlDbType.Int, hidFinCatID.Value))
                iRows = gvETPenalty.Rows.Count
                For iRow = 0 To iRows - 1
                    If CType(gvETPenalty.Rows(iRow).FindControl("txtETBookFrom"), TextBox).Text > "0" Then
                        SaveETPenalty(hidBranchID.Value, hidFinCatID.Value,
                                    CType(gvETPenalty.Rows(iRow).FindControl("txtETPenaltyID"), TextBox).Text,
                                    CType(gvETPenalty.Rows(iRow).FindControl("txtETBookFrom"), TextBox).Text,
                                    CType(gvETPenalty.Rows(iRow).FindControl("txtETBookTo"), TextBox).Text,
                                    CType(gvETPenalty.Rows(iRow).FindControl("ddlETPenaltyType"), DropDownList).SelectedValue,
                                    CType(gvETPenalty.Rows(iRow).FindControl("txtETPenaltyRate"), TextBox).Text,
                                    CType(gvETPenalty.Rows(iRow).FindControl("txtETADMTerminate"), TextBox).Text)
                    End If
                Next
            End If
            If DirectCast(ViewState("VW_ETPENALTY"), DataTable) Is Nothing Then
            Else
                DirectCast(ViewState("VW_ETPENALTY"), DataTable).Rows.Clear()
                DirectCast(ViewState("VW_ETPENALTY"), DataTable).Dispose()
            End If
            GetDataETPenaltyRule()
        Catch ex As Exception
            lblMessageET.Visible = True
            lblMessageET.Text = "ERROR SAVE BRANCH RULE ET PENALTY : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        DataSearch()
    End Sub

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub
End Class
