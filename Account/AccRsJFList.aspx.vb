
Partial Class Account_AccRsJFList
    Inherits System.Web.UI.Page
    Public Shared strAppDate As String
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
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE FROM APPSETTING WHERE APPCODE='APPDATE'")
            If oSDR.Read Then
                strAppDate = oSDR("APPVALUE").ToString()
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

        If Not IsPostBack Then
            txtAction.Value = Request.QueryString("Action")
            hidRSType.Value = Request.QueryString("RSType")
            rbBookAll.Checked = True
            rbCloseAll.Checked = True
            txtBookFrom.Text = strAppDate
            txtBookTo.Text = strAppDate
            txtCloseFrom.Text = strAppDate
            txtCloseTo.Text = strAppDate

            'SetObjectValidation(txtSearch, True)
            SetObjectValidation(txtBookFrom, True, "date", "[0-9/]")
            SetObjectValidation(txtBookTo, True, "date", "[0-9/]")

            SetObjectValidation(txtCloseFrom, True, "date", "[0-9/]")
            SetObjectValidation(txtCloseTo, True, "date", "[0-9/]")

        End If
        DataSearch()

    End Sub


    Private Sub DataSearch()
        If Not IsPostBack() Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.LOCID=0 AND ACCOUNT.ACCID=0)"
        End If

        If Len(Trim(txtSearch.Text)) > 0 Then
            If ddlCriteria.SelectedValue = "ACCNOX" Or ddlCriteria.SelectedValue = "CUSTNOX" Then
                Dim strBranchID As String = ""
                Dim strCompID As String = ""
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


        If rbBookFrom.Checked Then
            If Len(Trim(txtBookFrom.Text)) > 0 And Len(Trim(txtBookTo.Text)) > 0 Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNTJF.JFBOOKINGDATE BETWEEN CONVERT(DATETIME, '" + txtBookFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtBookTo.Text + "', 103))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNTJF.JFBOOKINGDATE BETWEEN CONVERT(DATETIME, '" + strAppDate + "', 103) AND CONVERT(DATETIME, '" + strAppDate + "', 103))"
            End If
        End If

        If rbCloseFrom.Checked Then
            If Len(Trim(txtBookFrom.Text)) > 0 And Len(Trim(txtBookTo.Text)) > 0 Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNTJF.JFCLOSETXNDATE BETWEEN CONVERT(DATETIME, '" + txtCloseFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtCloseTo.Text + "', 103))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNTJF.JFCLOSETXNDATE BETWEEN CONVERT(DATETIME, '" + strAppDate + "', 103) AND CONVERT(DATETIME, '" + strAppDate + "', 103))"
            End If
        End If

        If Len(Trim(ddlAreaSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND AREA.AREAID=" & ddlAreaSearch.SelectedValue
        End If
        If Len(Trim(ddlBranchSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCH.BRANCHID=" & ddlBranchSearch.SelectedValue
        End If
        'If Len(Trim(ddlCompGroupSearch.SelectedValue)) > 0 Then
        'Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND COMPANYGROUP.COMPGROUPID=" & ddlCompGroupSearch.SelectedValue
        'End If
        'If Len(Trim(ddlCompSearch.SelectedValue)) > 0 Then
        'Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND COMPANY.COMPID=" & ddlCompSearch.SelectedValue
        'End If
        'If Len(Trim(ddlTPSearch.SelectedValue)) > 0 Then
        'Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND APPLICATION.TPID=" & ddlTPSearch.SelectedValue
        'End If

        If Len(Trim(ddlJFGroup.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND JFGROUP.JFGROUPID=" & ddlJFGroup.SelectedValue
        End If

        If Len(Trim(ddlJF.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND JF.JFID=" & ddlJF.SelectedValue
        End If

        If Len(Trim(ddlAccStatus.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.ACCSTATUS=" & ddlAccStatus.SelectedValue
        End If


        'If Not IsPostBack Then
        '    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND APPLICATION.APPSTATUS<>0"
        'End If
        gvData.DataBind()
    End Sub

End Class
