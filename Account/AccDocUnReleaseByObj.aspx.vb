
Partial Class Txn_UnReleaseObj
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
            If Not IsPostBack() Then
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE, " & _
                  "CAST(dbo.f_IsUserBranch(" & txtUID.Value & ") as VARCHAR(10)) ISUSERBRANCH  FROM APPSETTING WITH(NOLOCK) WHERE APPCODE='APPDATE'")
                If oSDR.Read() Then
                    txtAppDate.Value = oSDR("APPVALUE").ToString()
                    hidIsUserBranch.Value = oSDR("ISUSERBRANCH").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing
                'hidBranch.Value = Request.QueryString("BRANCH")
                'ddlAccStatus.SelectedValue = "1"
                ddlCollStatus.SelectedValue = "4"
                'If hidBranch.Value = "1" Then ''cabang
                'Dim strBranchID As String = "0"
                'Dim strAreaID As String = "0"
                'oSDR = objDB.CreateSDRFromSQLSelect("SELECT BRANCHID FROM APPUSER WITH(NOLOCK) WHERE UID=" & Request.Cookies("UID").Value)
                'If oSDR.Read() Then
                '    strBranchID = oSDR("BRANCHID").ToString()
                '    hidBranchUser.Value = strBranchID
                'End If
                'oSDR.Close()
                'oSDR = Nothing

                'oSDR = objDB.CreateSDRFromSQLSelect("SELECT AREAID FROM BRANCH WITH(NOLOCK) WHERE BRANCHID=" & strBranchID)
                'If oSDR.Read() Then
                '    strAreaID = oSDR("AREAID").ToString()
                '    hidAreaUser.Value = strAreaID
                'End If
                'oSDR.Close()
                'oSDR = Nothing
                ' ddlBranchSearch.SelectedValue = strBranchID
                'ddlBranchSearch.Enabled = False

                'End If
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.LOCID=0 AND ACCOUNT.ACCID=0)"

                If hidIsUserBranch.Value = "1" Then 'user cabang
                    ajaxCDDArea.ContextKey = txtUID.Value
                    ajaxCDDBranch.ContextKey = txtUID.Value
                    ajaxCCDFincat.ContextKey = txtUID.Value
                End If
            Else
                ajaxCDDArea.ContextKey = "-999"
                ajaxCDDBranch.ContextKey = "-999"
                ajaxCCDFincat.ContextKey = "-999"
            End If
            'rbNo.Checked = True
            txtAction.Value = Request.QueryString("Action")
            rbReqAll.Checked = True
            rbBookAll.Checked = True
            txtRequestForm.Text = txtAppDate.Value
            txtRequestTo.Text = txtAppDate.Value
            txtBookFrom.Text = txtAppDate.Value
            txtBookTo.Text = txtAppDate.Value

            'SetObjectValidation(txtSearch, True)
            SetObjectValidation(txtRequestForm, True, "date", "[0-9/]")
            SetObjectValidation(txtRequestTo, True, "date", "[0-9/]")
            SetObjectValidation(txtBookFrom, True, "date", "[0-9/]")
            SetObjectValidation(txtBookTo, True, "date", "[0-9/]")

            pnlInit.Visible = False

            If hidIsUserBranch.Value = "1" Then 'user cabang
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT BRANCH.BRANCHID, BRANCH.AREAID FROM APPUSER WITH(NOLOCK) INNER JOIN BRANCH ON APPUSER.BRANCHID=BRANCH.BRANCHID WHERE APPUSER.UID=" & txtUID.Value)
                If oSDR.Read() Then
                    ajaxCDDArea.SelectedValue = oSDR("AREAID").ToString()
                    ajaxCDDBranch.SelectedValue = oSDR("BRANCHID").ToString()
                    'ajaxCCDAreaStore.SelectedValue = oSDR("AREAID").ToString()
                    'ajaxCCDBranchStore.SelectedValue = oSDR("BRANCHID").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing
            End If

            'If hidBranch.Value = "1" Then ' jika Branch = 1 Maka Filter Branch selain itu Head Office
            '    ajaxCDDArea.SelectedValue = hidAreaUser.Value
            '    ajaxCDDBranch.SelectedValue = hidBranchUser.Value
            'End If


        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

        'DataSearch()

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
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
            End If
        End If


        If rbReqDate.Checked Then
            If Len(Trim(txtRequestForm.Text)) > 0 And Len(Trim(txtRequestTo.Text)) > 0 Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (APPLICATION.REQUESTDATE BETWEEN CONVERT(DATETIME, '" + txtRequestForm.Text + "', 103) AND CONVERT(DATETIME, '" + txtRequestTo.Text + "', 103))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (APPLICATION.REQUESTDATE BETWEEN CONVERT(DATETIME, '" + txtAppDate.Value + "', 103) AND CONVERT(DATETIME, '" + txtAppDate.Value + "', 103))"
            End If
        End If

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

        'If Len(Trim(ddlJFGroupSearch.SelectedValue)) > 0 Then
        'Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND JFGROUP.JFGROUPID=" & ddlJFGroupSearch.SelectedValue
        'End If
        'If Len(Trim(ddlJFSearch.SelectedValue)) > 0 Then
        'Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND JF.JFID=" & ddlJFSearch.SelectedValue
        'End If

        If Len(Trim(ddlAccStatus.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.ACCSTATUS=" & ddlAccStatus.SelectedValue
        End If
        If Len(Trim(ddlCollStatus.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND COLLATERAL.BPKBSTATUS=" & ddlCollStatus.SelectedValue
        End If


        If Not IsPostBack Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND APPLICATION.APPSTATUS<>0"
        End If
        gvData.DataBind()
        If gvData.Rows.Count() > 0 Then
            pnlInit.Visible = True
        Else
            pnlInit.Visible = False
        End If
    End Sub

    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        lblMessage.Visible = False
        DataSearch()
    End Sub

    Protected Sub gvData_PageIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    'Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
    '    lblMessage.Visible = False
    '    Dim objDB As New DBX
    '    Try
    '        Dim oCheckBox As CheckBox
    '        Dim strLOCID As String, strOBJID As String
    '        Dim intLOCIDBorrow As Integer, dblBorrowID As Double
    '        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
    '        Dim blnBorrowByJF As Boolean
    '        If rbYes.Checked Then
    '            blnBorrowByJF = True
    '        Else
    '            blnBorrowByJF = False
    '        End If
    '        For Each row As GridViewRow In gvData.Rows
    '            oCheckBox = CType(row.FindControl("cbBorrow"), CheckBox)
    '            If oCheckBox IsNot Nothing Then
    '                If oCheckBox.Checked Then

    '                    strLOCID = gvData.DataKeys(row.RowIndex).Values("LOCID").ToString()
    '                    strOBJID = gvData.DataKeys(row.RowIndex).Values("OBJID").ToString()
    '                    oSQLParam = objDB.ExecSPReturnParam("COLLATERALBORROWSave", _
    '                        objDB.MP("@LOCID", Data.SqlDbType.Int, strLOCID, 10, Data.ParameterDirection.Input), _
    '                        objDB.MP("@OBJID", Data.SqlDbType.BigInt, strOBJID, 30, Data.ParameterDirection.Input), _
    '                        objDB.MP("@BPRID", Data.SqlDbType.Int, ddlBorrowPurpose.SelectedValue, 10, Data.ParameterDirection.Input), _
    '                        objDB.MP("@BORROWBYJF", Data.SqlDbType.Bit, blnBorrowByJF, 10, Data.ParameterDirection.Input), _
    '                        objDB.MP("@BORROWER", Data.SqlDbType.VarChar, txtBorrower.Text, 50, Data.ParameterDirection.Input), _
    '                        objDB.MP("@RETURNDATE", Data.SqlDbType.DateTime, ConvertDate(txtReturnDate.Text), 10, Data.ParameterDirection.Input), _
    '                        objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 10, Data.ParameterDirection.Input), _
    '                        objDB.MP("@LOCIDBORROW", Data.SqlDbType.Int, intLOCIDBorrow, 10, Data.ParameterDirection.Output), _
    '                        objDB.MP("@BORROWID", Data.SqlDbType.Int, dblBorrowID, 10, Data.ParameterDirection.Output) _
    '                    )
    '                    intLOCIDBorrow = oSQLParam("@LOCIDBORROW").Value
    '                    dblBorrowID = oSQLParam("@BORROWID").Value
    '                End If
    '            End If
    '        Next
    '        lblMessage.Visible = True
    '        lblMessage.Text = "DOCUMENT COLLATERAL BORROW SAVED SUCCESSFULLY..!"
    '        DataSearch()
    '    Catch ex As Exception
    '        lblMessage.Visible = True
    '        lblMessage.Text = "ERROR DOCUMENT COLLATERAL BORROW: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
    '    Finally
    '        objDB.Close()
    '        objDB = Nothing
    '    End Try

    'End Sub

    Protected Sub btnSaveCheck_Click(sender As Object, e As System.EventArgs) Handles btnSaveCheck.Click
        lblMessage.Visible = False
        Dim objDB As New DBX
        Try
            Dim oCheckBox As CheckBox
            For Each row As GridViewRow In gvData.Rows
                oCheckBox = CType(row.FindControl("cbBorrow"), CheckBox)
                Dim strLOCID, strOBJID As String
                Dim lngRetVal As Double
                If oCheckBox IsNot Nothing Then
                    If oCheckBox.Checked Then
                        strLOCID = gvData.DataKeys(row.RowIndex).Values("LOCID").ToString()
                        strOBJID = gvData.DataKeys(row.RowIndex).Values("OBJID").ToString()
                        lngRetVal = objDB.ExecSPReturnInteger("COLLATERALUnReleased", _
                            objDB.MP("@LOCID", Data.SqlDbType.Int, strLOCID),
                            objDB.MP("@OBJID", Data.SqlDbType.BigInt, strOBJID),
                            objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value)
                        )
                        If lngRetVal = -1 Then
                            lblMessage.Visible = True
                            lblMessage.Focus()
                            lblMessage.Text = "COLLATERAL STATUS NOT RELEASED..!<BR>PLEASE CHECK COLLATERAL INQUIRY..!"
                        ElseIf lngRetVal = -2 Then
                            lblMessage.Visible = True
                            lblMessage.Focus()
                            lblMessage.Text = "COLLATERAL ALREADY UN-RELEASED..!<BR>PLEASE CHECK COLLATERAL INQUIRY..!"
                        End If

                    End If
                End If
            Next
            DataSearch()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE COLLATERAL UN-RELEASED.!<BR>PLEASE CHECK DETAIL ERROR MESSAGE:<BR>" & ex.Message
            lblMessage.Focus()
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub

    Protected Sub gvData_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvData.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim oCheckBox As CheckBox
            oCheckBox = CType(e.Row.FindControl("cbBorrow"), CheckBox)
            If oCheckBox IsNot Nothing Then
                oCheckBox.Attributes.Add("onclick", "SelectRow(this);")
            End If
        End If
    End Sub
End Class
