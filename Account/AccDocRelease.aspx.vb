
Partial Class Txn_AccRelease
    Inherits System.Web.UI.Page
    Public Shared strAppState As String
    Public Shared strLOCIDGrid As String = "", strACCIDGrid As String = ""

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
                "CAST(dbo.f_IsUserBranch(" & Request.Cookies("UID").Value & ") as VARCHAR(10)) ISUSERBRANCH, " & _
                "CONVERT(VARCHAR(20), DateAdd(day, 3, dbo.f_getAppDate()), 103) RETURNDATE FROM APPSETTING WITH(NOLOCK) WHERE APPCODE='APPDATE'")
                If oSDR.Read() Then
                    txtAppDate.Value = oSDR("APPVALUE").ToString()
                    txtReleaseDate.Text = oSDR("RETURNDATE").ToString()
                End If
                hidIsUserBranch.Value = oSDR("ISUSERBRANCH").ToString()
                oSDR.Close()
                oSDR = Nothing
                ddlAccStatus.SelectedValue = "2"
                ddlCollStatus.SelectedValue = "2"
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.LOCID=0 AND ACCOUNT.ACCID=0)"

            End If

            strLOCIDGrid = ""
            strACCIDGrid = ""
            txtAction.Value = Request.QueryString("Action")
            rbReqAll.Checked = True
            rbBookAll.Checked = True
            txtRequestForm.Text = txtAppDate.Value
            txtRequestTo.Text = txtAppDate.Value
            txtBookFrom.Text = txtAppDate.Value
            txtBookTo.Text = txtAppDate.Value

            SetObjectValidation(txtRequestForm, True, "date", "[0-9/]")
            SetObjectValidation(txtRequestTo, True, "date", "[0-9/]")
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

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR LOADING DOCUMENT RELEASE: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE..!"
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

        'If Not IsPostBack() Then
        '    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.LOCID=0 AND ACCOUNT.ACCID=0)"
        'End If

        If Len(Trim(txtSearch.Text)) > 0 Then
            If ddlCriteria.SelectedValue = "ACCNOX" Or ddlCriteria.SelectedValue = "CUSTNOX" Then
                Dim strBranchID As String = ""
                Dim strJFID As String = ""
                Dim strNumber As String = ""
                SplitFormatedNumber(txtSearch.Text, strBranchID, strNumber)
                If ddlCriteria.SelectedValue = "ACCNOX" Then
                    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.BRANCHID=" & strBranchID & "AND ACCOUNT.ACCOUNTNO=" & strNumber
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
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.CLOSETXNDATE BETWEEN CONVERT(DATETIME, '" + txtRequestForm.Text + "', 103) AND CONVERT(DATETIME, '" + txtRequestTo.Text + "', 103))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.CLOSETXNDATE BETWEEN CONVERT(DATETIME, '" + txtAppDate.Value + "', 103) AND CONVERT(DATETIME, '" + txtAppDate.Value + "', 103))"
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

        If Len(Trim(ddlFinanceCategory.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.FINCATID=" & ddlFinanceCategory.SelectedValue
        End If


        If Not IsPostBack Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND APPLICATION.APPSTATUS<>0"
        End If
        gvData.DataBind()
    End Sub

    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        lblMessage.Visible = False
        DataSearch()
    End Sub

    Protected Sub gvData_PageIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        lblMessage.Visible = False
        lblMessage.Text = ""
        Dim objDB As New DBX
        Try
            lblMessage.Visible = False
            Dim oCheckBox As CheckBox
            Dim strLOCID As String, strACCID As String
            'Dim intLOCIDBorrow As Integer, dblBorrowID As Double
            'Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            'Dim blnBorrowByJF As Boolean
            Dim lngRetVal As Integer = 0
            For Each row As GridViewRow In gvData.Rows
                oCheckBox = CType(row.FindControl("cbRelease"), CheckBox)
                lngRetVal = 0
                If oCheckBox IsNot Nothing Then
                    If oCheckBox.Checked Then
                        strLOCID = gvData.DataKeys(row.RowIndex).Values("LOCID").ToString()
                        strACCID = gvData.DataKeys(row.RowIndex).Values("ACCID").ToString()
                        lngRetVal = objDB.ExecSPReturnInteger("ACCOUNTReleaseSave", _
                                objDB.MP("@LOCID", Data.SqlDbType.Int, strLOCID, 10, Data.ParameterDirection.Input), _
                                objDB.MP("@ACCID", Data.SqlDbType.BigInt, strACCID, 30, Data.ParameterDirection.Input), _
                                objDB.MP("@RELEASEDATE", Data.SqlDbType.DateTime, ConvertDate(txtReleaseDate.Text), 10, Data.ParameterDirection.Input), _
                                objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 10, Data.ParameterDirection.Input) _
                            )
                        If lngRetVal = -1 Then
                            lblMessage.Visible = True
                            lblMessage.Text = "ACCOUNT STILL ACTIVE...!<BR>CANNOT RELEASE ACCOUNT...!"
                        ElseIf lngRetVal = -2 Then
                            lblMessage.Visible = True
                            lblMessage.Text = "PARIPASU ACCOUNT STILL ACTIVE...!<BR>CANNOT RELEASE ACCOUNT...!"
                        ElseIf lngRetVal = -3 Then
                            lblMessage.Visible = True
                            lblMessage.Text = "COLLATERAL PROCESS FOR DOWN PAYMENT NOT YET PAID...!<BR>CANNOT RELEASE ACCOUNT...!"
                        ElseIf lngRetVal = -4 Then
                            lblMessage.Visible = True
                            lblMessage.Text = "COLLATERAL PROCESS PAYMENT NOT YET PAID...!<BR>CANNOT RELEASE ACCOUNT...!"
                        ElseIf lngRetVal = -5 Then
                            lblMessage.Visible = True
                            lblMessage.Text = "ACCOUNT ALREADY RELEASED...!<BR>PLEASE CHECK IN ACCOUNT INQUIRY...!"
                        ElseIf lngRetVal = -6 Then
                            lblMessage.Visible = True
                            lblMessage.Text = "COLLATERAL DOCUMENT STATUS: NOT YET RECEIVED...!<BR>PLEASE RECEIVED FIRST COLLATERAL DOCUMENT...!"
                        End If

                        If lngRetVal <> 0 Then
                            Exit For
                        End If
                    End If
                End If
            Next
            If Len(Trim(lblMessage.Text)) <= 0 Then
                lblMessage.Visible = True
                lblMessage.Text = "SAVE RELEASED ACCOUNT COMPLETED...!"
            End If
            DataSearch()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RELEASE ACCOUNT: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE..!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub

    Protected Sub gvData_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvData.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim oCheckBox As CheckBox
            oCheckBox = CType(e.Row.FindControl("cbRelease"), CheckBox)
            If oCheckBox IsNot Nothing Then

                If DataBinder.Eval(e.Row.DataItem, "LOCID").ToString() = strLOCIDGrid And DataBinder.Eval(e.Row.DataItem, "ACCID").ToString() = strACCIDGrid Then
                    oCheckBox.Visible = False
                End If
                oCheckBox.Attributes.Add("onclick", "SelectRow(this);")
            End If
            strLOCIDGrid = DataBinder.Eval(e.Row.DataItem, "LOCID").ToString()
            strACCIDGrid = DataBinder.Eval(e.Row.DataItem, "ACCID").ToString()
        End If

    End Sub

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub
End Class
