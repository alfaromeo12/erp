
Partial Class Txn_AccBorrow
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
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE," & _
                        " CAST(dbo.f_IsUserBranch(" & Request.Cookies("UID").Value & ") as VARCHAR(10)) ISUSERBRANCH " & _
                        " FROM APPSETTING WITH(NOLOCK) WHERE APPCODE='APPDATE'")
                If oSDR.Read() Then
                    txtAppDate.Value = oSDR("APPVALUE").ToString()
                    hidIsUserBranch.Value = oSDR("ISUSERBRANCH").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing

                ddlCollStatus.SelectedValue = "3"
                txtAction.Value = Request.QueryString("Action")
                rbReqAll.Checked = True
                rbBookAll.Checked = True
                rbBookJFAll.Checked = True
                txtReturnDate.Text = txtAppDate.Value
                txtRequestForm.Text = txtAppDate.Value
                txtRequestTo.Text = txtAppDate.Value
                txtBookFrom.Text = txtAppDate.Value
                txtBookTo.Text = txtAppDate.Value
                txtBookJFFrom.Text = txtAppDate.Value
                txtBookJFTo.Text = txtAppDate.Value
                rbNo.Checked = True

                'SetObjectValidation(txtSearch, True)
                SetObjectValidation(txtBookJFFrom, True, "date", "[0-9/]")
                SetObjectValidation(txtBookJFTo, True, "date", "[0-9/]")
                SetObjectValidation(txtRequestForm, True, "date", "[0-9/]")
                SetObjectValidation(txtRequestTo, True, "date", "[0-9/]")
                SetObjectValidation(txtBookFrom, True, "date", "[0-9/]")
                SetObjectValidation(txtBookTo, True, "date", "[0-9/]")

                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.LOCID=0 AND ACCOUNT.ACCID=0)"

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
            End If
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

        If Not IsPostBack Then
       

        End If
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
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (COLLATERALBORROW.BORROWDATE BETWEEN CONVERT(DATETIME, '" + txtRequestForm.Text + "', 103) AND CONVERT(DATETIME, '" + txtRequestTo.Text + "', 103))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (COLLATERALBORROW.BORROWDATE BETWEEN CONVERT(DATETIME, '" + txtAppDate.Value + "', 103) AND CONVERT(DATETIME, '" + txtAppDate.Value + "', 103))"
            End If
        End If

        If rbBookFrom.Checked Then
            If Len(Trim(txtBookFrom.Text)) > 0 And Len(Trim(txtBookTo.Text)) > 0 Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.BOOKINGDATE BETWEEN CONVERT(DATETIME, '" + txtBookFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtBookTo.Text + "', 103))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.BOOKINGDATE BETWEEN CONVERT(DATETIME, '" + txtAppDate.Value + "', 103) AND CONVERT(DATETIME, '" + txtAppDate.Value + "', 103))"
            End If
        End If
        If rbBookJFFrom.Checked Then
            If Len(Trim(txtBookJFFrom.Text)) > 0 And Len(Trim(txtBookJFTo.Text)) > 0 Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (EXISTS(SELECT 'X' FROM ACCOUNTJF WITH(NOLOCK) WHERE LOCID = ACCOUNT.LOCID AND ACCID=ACCOUNT.ACCID  AND  (ACCOUNTJF.JFBOOKINGDATE BETWEEN CONVERT(DATETIME, '" + txtBookJFFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtBookJFTo.Text + "', 103))))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (EXISTS(SELECT 'X' FROM ACCOUNTJF WITH(NOLOCK) WHERE LOCID = ACCOUNT.LOCID AND ACCID=ACCOUNT.ACCID AND (ACCOUNTJF.JFBOOKINGDATE BETWEEN CONVERT(DATETIME, '" + txtAppDate.Value + "', 103) AND CONVERT(DATETIME, '" + txtAppDate.Value + "', 103))))"
            End If
        End If

        If Len(Trim(ddlAreaSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCH.AREAID=" & ddlAreaSearch.SelectedValue
        End If
        If Len(Trim(ddlBranchSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCH.BRANCHID=" & ddlBranchSearch.SelectedValue
        End If
        If Len(Trim(ddlJFGroup.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (EXISTS(SELECT 'X' FROM JFGROUP WITH(NOLOCK) WHERE JFGROUP.JFGROUPID=" & ddlJFGroup.SelectedValue & "))"
        End If

        If Len(Trim(ddlJF.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (EXISTS(SELECT 'X' FROM JF WITH(NOLOCK) WHERE JF.JFID=" & ddlJF.SelectedValue & "))"
        End If

        If Len(Trim(ddlAccStatus.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.ACCSTATUS=" & ddlAccStatus.SelectedValue
        End If
        If Len(Trim(ddlCollStatus.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND COLLATERAL.BPKBSTATUS=" & ddlCollStatus.SelectedValue
        End If
        If Len(Trim(ddlBorrowPurpose.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND COLLATERALBORROW.BPRID=" & ddlBorrowPurpose.SelectedValue
        End If

        If rbYes.Checked Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND COLLATERALBORROW.BORROWBYJF=1"
        Else
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND COLLATERALBORROW.BORROWBYJF=0"
        End If

        If Len(Trim(ddlFinanceCategory.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.FINCATID=" & ddlFinanceCategory.SelectedValue
        End If

        If Not IsPostBack Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND APPLICATION.APPSTATUS<>0"
        End If
        gvData.DataBind()
    End Sub

    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
    End Sub

    Protected Sub gvData_PageIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objDB As New DBX
        Try
            Dim oCheckBox As CheckBox
            Dim strLOCID As String, strOBJID As String
            For Each row As GridViewRow In gvData.Rows
                oCheckBox = CType(row.FindControl("cbBorrow"), CheckBox)
                If oCheckBox IsNot Nothing Then
                    If oCheckBox.Checked Then
                        strLOCID = gvData.DataKeys(row.RowIndex).Values("LOCID").ToString()
                        strOBJID = gvData.DataKeys(row.RowIndex).Values("OBJID").ToString()
                        objDB.ExecSP("COLLATERALBORROWReturn", _
                            objDB.MP("@LOCID", Data.SqlDbType.Int, strLOCID, 10, Data.ParameterDirection.Input), _
                            objDB.MP("@OBJID", Data.SqlDbType.BigInt, strOBJID, 30, Data.ParameterDirection.Input), _
                            objDB.MP("@RETURNDATE", Data.SqlDbType.DateTime, ConvertDate(txtReturnDate.Text), 10, Data.ParameterDirection.Input), _
                            objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 10, Data.ParameterDirection.Input) _
                        )
                    End If
                End If
            Next
            DataSearch()
            'Catch ex As Exception
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
