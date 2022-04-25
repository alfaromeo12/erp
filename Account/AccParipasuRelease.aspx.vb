Partial Class Txn_ParipasuRelease
    Inherits System.Web.UI.Page
    Public Shared strAppState As String

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Response.Write(Request.Cookies("AppDate").Value)

        txtUID.Value = Request.Cookies("UID").Value
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE, CAST(dbo.f_IsUserBranch(" & Request.Cookies("UID").Value & ") as VARCHAR(10)) ISUSERBRANCH FROM APPSETTING WITH(NOLOCK) WHERE APPCODE='APPDATE'")
            If oSDR.Read Then
                txtAppDate.Value = oSDR("APPVALUE").ToString()
                hidIsUserBranch.Value = oSDR("ISUSERBRANCH").ToString()
            End If
            oSDR.Close()
            oSDR = Nothing
            If Not IsPostBack() Then
                btnRelease.Visible = False
                MVMain.SetActiveView(vSearch)
                txtAction.Value = Request.QueryString("Action")
                rbBookAll.Checked = True
                txtBookFrom.Text = txtAppDate.Value
                txtBookTo.Text = txtAppDate.Value
                SetObjectValidation(txtBookFrom, True, "date", "[0-9/]")
                SetObjectValidation(txtBookTo, True, "date", "[0-9/]")
                ajaxCDDArea.ContextKey = txtUID.Value
                ajaxCDDBranch.ContextKey = txtUID.Value
                ajaxCCDFincat.ContextKey = txtUID.Value
                If hidIsUserBranch.Value = "1" Then 'user cabang
                    oSDR = objDB.CreateSDRFromSQLSelect("SELECT BRANCH.BRANCHID, BRANCH.AREAID FROM APPUSER WITH(NOLOCK) INNER JOIN BRANCH ON APPUSER.BRANCHID=BRANCH.BRANCHID WHERE APPUSER.UID=" & Request.Cookies("UID").Value)
                    If oSDR.Read() Then
                        ajaxCDDArea.SelectedValue = oSDR("AREAID").ToString()
                        ajaxCDDBranch.SelectedValue = oSDR("BRANCHID").ToString()
                    End If
                    oSDR.Close()
                    oSDR = Nothing
                End If
                DataSearch()
            End If
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Private Sub DataSearch()

        If hidIsUserBranch.Value = "1" Then 'jika user cabang, filter berdasarkan cabang yang berhak saja
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.BRANCHID IN (SELECT BRANCHID FROM dbo.f_getAPPUSERBRANCHList(" & txtUID.Value & "))"
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.FINCATID IN (SELECT FINCATID FROM dbo.f_getAPPUSERFINCATList(" & txtUID.Value & "))"
        End If

        If Not IsPostBack() Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.LOCID=0 AND ACCOUNT.ACCID=0)"
        End If

        If Len(Trim(txtSearch.Text)) > 0 Then
            If ddlCriteria.SelectedValue = "ACCNOX" Or ddlCriteria.SelectedValue = "CUSTNOX" Then
                Dim strBranchID As String = ""
                Dim strJFID As String = ""
                Dim strNumber As String = ""
                SplitFormatedNumber(txtSearch.Text, strBranchID, strNumber)
                If ddlCriteria.SelectedValue = "ACCNOX" Then
                    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.BRANCHID=" & strBranchID & " AND ACCOUNT.ACCOUNTNO=" & strNumber
                ElseIf ddlCriteria.SelectedValue = "CUSTNOX" Then
                    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND CUSTOMER.BRANCHID=" & strBranchID & " AND CUSTOMER.CUSTNO=" & strNumber
                End If
            ElseIf InStr(UCase(ddlCriteria.SelectedValue), "APPID", CompareMethod.Text) > 0 Or _
                InStr(UCase(ddlCriteria.SelectedValue), "CUSTID", CompareMethod.Text) > 0 Or _
                InStr(UCase(ddlCriteria.SelectedValue), "ACCID", CompareMethod.Text) > 0 Or _
                InStr(UCase(ddlCriteria.SelectedValue), "ACCOUNTNO", CompareMethod.Text) > 0 Or _
                InStr(UCase(ddlCriteria.SelectedValue), "CUSTNO", CompareMethod.Text) > 0 _
            Then
                If IsNumeric(txtSearch.Text) Then
                    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + "=" + Me.txtSearch.Text
                Else
                    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + "=0"
                End If
            ElseIf ddlCriteria.SelectedValue = "COLLATERAL.BPKBNO" Or ddlCriteria.SelectedValue = "COLLATERAL.POLICENO" Or ddlCriteria.SelectedValue = "COLLATERAL.ENGINENO" Or ddlCriteria.SelectedValue = "COLLATERAL.CHASSISNO" Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND EXISTS (SELECT 'X' FROM COLLATERAL WITH(NOLOCK) " & _
                    " WHERE ACCOUNT.LOCID=COLLATERAL.LOCID AND ACCOUNT.ACCID=COLLATERAL.ACCID AND COLLATERAL.DELETESTS=0 AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'" & ")"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
            End If
        End If


        'If rbReqDate.Checked Then
        '    If Len(Trim(txtRequestForm.Text)) > 0 And Len(Trim(txtRequestTo.Text)) > 0 Then
        '        Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (APPLICATION.REQUESTDATE BETWEEN CONVERT(DATETIME, '" + txtRequestForm.Text + "', 103) AND CONVERT(DATETIME, '" + txtRequestTo.Text + "', 103))"
        '    Else
        '        Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (APPLICATION.REQUESTDATE BETWEEN CONVERT(DATETIME, '" + txtAppDate.Value + "', 103) AND CONVERT(DATETIME, '" + txtAppDate.Value + "', 103))"
        '    End If
        'End If

        If rbBookFrom.Checked Then
            If Len(Trim(txtBookFrom.Text)) > 0 And Len(Trim(txtBookTo.Text)) > 0 Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.BOOKINGDATE BETWEEN CONVERT(DATETIME, '" + txtBookFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtBookTo.Text + "', 103))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.BOOKINGDATE BETWEEN CONVERT(DATETIME, '" + txtAppDate.Value + "', 103) AND CONVERT(DATETIME, '" + txtAppDate.Value + "', 103))"
            End If
        End If

        If Len(Trim(ddlAreaSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCH.AREAID=" & ddlAreaSearch.SelectedValue
        End If
        If Len(Trim(ddlBranchSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCH.BRANCHID=" & ddlBranchSearch.SelectedValue
        End If

        If Len(Trim(ddlFinanceCategory.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.FINCATID=" & ddlFinanceCategory.SelectedValue
        End If

        gvData.DataBind()
    End Sub



    Protected Sub gvData_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvData.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If DataBinder.Eval(e.Row.DataItem, "ACCSTATUS") <> 1 Then
                e.Row.ForeColor = Drawing.Color.Red
            End If
        End If
    End Sub

    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
    End Sub

    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub

    Protected Sub gvData_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        If e.CommandName = "Select" Then
            gvData.SelectedIndex = e.CommandArgument
            hidLOCID.Value = gvData.SelectedDataKey("LOCID")
            hidACCID.Value = gvData.SelectedDataKey("ACCID")
            hidLOCIDPARIPASU.Value = gvData.SelectedDataKey("LOCIDPARIPASU")
            hidACCIDPARIPASU.Value = gvData.SelectedDataKey("ACCIDPARIPASU")
            hidPARIPASUID.Value = gvData.SelectedDataKey("PARIPASUID")
            ctlDataAccountFromParamAccIDOS.LOCID = hidLOCIDPARIPASU.Value
            ctlDataAccountFromParamAccIDOS.ACCID = hidACCIDPARIPASU.Value
            MVMain.SetActiveView(vEdit)
            gvParipasu.DataBind()
            If gvParipasu.Rows.Count > 0 Then
                btnRelease.Visible = True
            Else
                btnRelease.Visible = False
            End If
            'Dim objDB As New DBX
            'Try
            '    'Dim oSDR As System.Data.SqlClient.SqlDataReader
            '    'oSDR = objDB.CreateSDRFromSQLSelect("SELECT COUNT(*) JML FROM COLLATERAL WITH(NOLOCK) WHERE LOCID=" & hidLOCID.Value & " AND ACCID=" & hidACCID.Value & " AND BPKBSTATUS IN (1,2,3)")
            '    'If oSDR.Read() Then
            '    '    hidCOUNT.Value = oSDR("JML")
            '    '    If oSDR("JML") <= 1 Then
            '    '        btnRelease.Visible = False
            '    '    Else
            '    '        btnRelease.Visible = True
            '    '    End If
            '    'End If
            '    'oSDR.Close()
            '    'oSDR = Nothing
            'Catch ex As Exception
            'Finally
            '    objDB.Close()
            '    objDB = Nothing
            'End Try
        End If
    End Sub


    Protected Sub btnCancel_Click(sender As Object, e As System.EventArgs) Handles btnCancel.Click
        ClearValues()
        MVMain.SetActiveView(vSearch)
    End Sub

    Private Sub ClearValues()
        hidACCID.Value = ""
        hidLOCID.Value = ""
        hidLOCIDPARIPASU.Value = ""
        hidACCIDPARIPASU.Value = "'"
        hidPARIPASUID.Value = ""
        gvParipasu.DataBind()
        gvParipasu.SelectedIndex = -1

        'fvCollateral.DataBind()
    End Sub

    Protected Sub gvParipasu_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvParipasu.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If DataBinder.Eval(e.Row.DataItem, "ACCSTATUS") <> 1 Then
                e.Row.ForeColor = Drawing.Color.Red
                e.Row.Font.Bold = True
            End If
            If DataBinder.Eval(e.Row.DataItem, "PARIPASUSTS") = 0 Then
                e.Row.Font.Italic = True
                e.Row.Font.Bold = True
            End If
            Dim oCheckBox As CheckBox
            oCheckBox = CType(e.Row.FindControl("chkBox"), CheckBox)
            If oCheckBox IsNot Nothing Then
                oCheckBox.Attributes.Add("onclick", "HighlightRow(this);")
            End If

            If DataBinder.Eval(e.Row.DataItem, "CHECKVISIBLE") Then
                btnRelease.Visible = True
            End If

        End If
    End Sub

    Protected Sub btnRelease_Click(sender As Object, e As System.EventArgs) Handles btnRelease.Click
        lblError.Visible = False
        Dim oCheckBox As CheckBox
        Dim intRetVal As Integer
        Dim objDB As New DBX
        Dim strLOCID As String = ""
        Dim strACCID As String = ""
        Dim strPARIPASUID As String = ""

        Try
            For Each row As GridViewRow In gvParipasu.Rows
                oCheckBox = CType(row.FindControl("chkBox"), CheckBox)
                If oCheckBox IsNot Nothing Then
                    If oCheckBox.Checked Then
                        strLOCID = gvParipasu.DataKeys(row.RowIndex).Values("LOCID").ToString()
                        strACCID = gvParipasu.DataKeys(row.RowIndex).Values("ACCID").ToString()
                        strPARIPASUID = gvParipasu.DataKeys(row.RowIndex).Values("PARIPASUID").ToString()
                        intRetVal = objDB.ExecSPReturnInteger("PARIPARURelease", _
                                   objDB.MP("@LOCID", Data.SqlDbType.Int, strLOCID), _
                                   objDB.MP("@ACCID", Data.SqlDbType.BigInt, strACCID), _
                                   objDB.MP("@PARIPASUID", Data.SqlDbType.Int, strPARIPASUID), _
                                   objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value) _
                                   )
                        If intRetVal = -1 Then
                            lblError.Visible = True
                            lblError.Text = "PARIPASU ALREADY RELEASED..!"
                            lblError.Focus()
                            'DataSearch()
                            Exit For
                        End If
                    End If
                End If
            Next
            gvParipasu.DataBind()
            DataSearch()
        Catch ex As Exception
            lblError.Focus()
            lblError.Visible = True
            lblError.Text = "ERROR SAVE RELEASE PARIPASU: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing

        End Try

    End Sub
End Class
