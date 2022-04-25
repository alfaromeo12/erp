
Partial Class Account_AccForJFAppDtl
    Inherits System.Web.UI.Page
    Public Shared strCheckBox As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack() Then
            txtAction.Value = Request.QueryString("ACTION")
            hidRequestID.Value = Request.QueryString("REQUESTID")
            If txtAction.Value = "INQ" Then
                'btnCheckAll.Visible = False
                chkAll.Visible = False
                gvRequestAcc.Columns(2).Visible = False
                pnlProcess.Visible = False
            Else
                'btnCheckAll.Visible = True
                chkAll.Visible = True
                pnlProcess.Visible = True
            End If

            Dim objDB As New DBX
            Try
                Dim oSDR As Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppSetting('APPDATE') APPDATE")
                If oSDR.Read() Then
                    txtValueDate.Text = oSDR("APPDATE").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT TOP 1 REQUESTIDACC FROM JFREQUESTACC WHERE REQUESTID=" & hidRequestID.Value & " AND JFREQUESTSTATUS=0")
                If Not oSDR.HasRows() Then
                    chkAll.Visible = False
                    pnlProcess.Visible = False
                    gvRequestAcc.Columns(2).Visible = False
                End If

            Finally
                objDB.Close()
                objDB = Nothing

            End Try
            SetFormValidation()
            txtPageSize.Text = "50"
            DataSearch()
        End If
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Private Sub DataSearch()

        If Not IsPostBack() Then
            Me.sdsJFRequestAcc.SelectCommand = Me.sdsJFRequestAcc.SelectCommand & " AND JFREQUESTSTATUS IN (0,1)"
        End If

        chkAll.Checked = False
        strCheckBox = ""
        If Len(Trim(txtSearch.Text)) > 0 Then
            If ddlCriteria.SelectedValue = "ACCNOX" Or ddlCriteria.SelectedValue = "CUSTNOX" Then
                Dim strBranchID As String = ""
                Dim strCompID As String = ""
                Dim strNumber As String = ""
                SplitFormatedNumber(txtSearch.Text, strBranchID, strNumber)
                If ddlCriteria.SelectedValue = "ACCNOX" Then
                    Me.sdsJFRequestAcc.SelectCommand = Me.sdsJFRequestAcc.SelectCommand & " AND BRANCHID=" & strBranchID & " AND ACCOUNTNO=" & strNumber
                ElseIf ddlCriteria.SelectedValue = "CUSTNOX" Then
                    Me.sdsJFRequestAcc.SelectCommand = Me.sdsJFRequestAcc.SelectCommand & " AND BRANCHID=" & strBranchID & " AND CUSTNO=" & strNumber
                End If
            ElseIf InStr(UCase(ddlCriteria.SelectedValue), "APPID", CompareMethod.Text) > 0 Or _
                InStr(UCase(ddlCriteria.SelectedValue), "CUSTID", CompareMethod.Text) > 0 Or _
                InStr(UCase(ddlCriteria.SelectedValue), "ACCID", CompareMethod.Text) > 0 Or _
                InStr(UCase(ddlCriteria.SelectedValue), "ACCOUNTNO", CompareMethod.Text) > 0 Or _
                InStr(UCase(ddlCriteria.SelectedValue), "CUSTNO", CompareMethod.Text) > 0 _
            Then
                If IsNumeric(txtSearch.Text) Then
                    Me.sdsJFRequestAcc.SelectCommand = Me.sdsJFRequestAcc.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + "=" + Me.txtSearch.Text
                Else
                    Me.sdsJFRequestAcc.SelectCommand = Me.sdsJFRequestAcc.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + "=0"
                End If
            Else
                Me.sdsJFRequestAcc.SelectCommand = Me.sdsJFRequestAcc.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
            End If
        End If

        If Len(Trim(ddlJFRequestSearch.SelectedValue.ToString())) > 0 Then
            If ddlJFRequestSearch.SelectedValue.ToString() = "-1" Then
                Me.sdsJFRequestAcc.SelectCommand = Me.sdsJFRequestAcc.SelectCommand & " AND JFREQUESTSTATUS IN (0,1)"
            Else
                Me.sdsJFRequestAcc.SelectCommand = Me.sdsJFRequestAcc.SelectCommand & " AND JFREQUESTSTATUS = " & ddlJFRequestSearch.SelectedValue
            End If
        End If

        If Len(Trim(ddlJFRequestTypeSearch.SelectedValue)) > 0 Then
            Me.sdsJFRequestAcc.SelectCommand = Me.sdsJFRequestAcc.SelectCommand & " AND JFREQUESTTYPE = " & ddlJFRequestTypeSearch.SelectedValue
        End If


        Me.sdsJFRequestAcc.SelectCommand = Me.sdsJFRequestAcc.SelectCommand & " ORDER BY ACCOUNT.BRANCHID, ACCOUNT.ACCOUNTNO"

        gvSummary.DataBind()
        gvRequestAcc.PageSize = txtPageSize.Text
        gvRequestAcc.DataBind()
        chkAll.Checked = False
        If gvRequestAcc.Rows.Count() <= 0 Then
            'btnCheckAll.Enabled = False
            chkAll.Enabled = False
            btnReject.Enabled = False
            btnApprove.Enabled = False
        Else
            'btnCheckAll.Enabled = True
            chkAll.Enabled = True
            btnReject.Enabled = True
            btnApprove.Enabled = True
        End If

    End Sub

    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        lblMessage.Visible = False
        DataSearch()
    End Sub

    'Protected Sub btnCheckAll_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCheckAll.Click
    '    lblMessage.Visible = False
    '    Dim oCheckBox As CheckBox
    '    For Each row As GridViewRow In gvRequestAcc.Rows
    '        oCheckBox = CType(row.FindControl("cbChk"), CheckBox)
    '        If oCheckBox IsNot Nothing Then
    '            oCheckBox.Checked = True
    '            If oCheckBox.Visible Then
    '                row.CssClass = "SelectedRowStyle"
    '            End If
    '        End If
    '    Next

    'End Sub

    Protected Sub btnBack_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBack.Click
        Response.Redirect("AccforJFApp.aspx?Action=" & txtAction.Value)
    End Sub

    Protected Sub btnApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApprove.Click
        Dim objCore As New Core
        Try
            lblMessage.Text = ""
            lblMessage.Visible = False
            Dim strRequestIDAcc As String
            Dim oCheckBox As CheckBox
            Dim intRetVal As Integer = 0
            For Each row As GridViewRow In gvRequestAcc.Rows
                oCheckBox = CType(row.FindControl("cbChk"), CheckBox)
                If oCheckBox IsNot Nothing Then
                    If oCheckBox.Checked Then
                        strRequestIDAcc = gvRequestAcc.DataKeys(row.RowIndex).Values("REQUESTIDACC").ToString()
                        intRetVal = objCore.JFREQUESTACCApproval(strRequestIDAcc, 1, ConvertDate(txtValueDate.Text), Request.Cookies("UID").Value)
                        If intRetVal = -1 Then
                            Dim oHidden As HiddenField, strAccountNo As String = ""
                            oHidden = CType(row.FindControl("txtAccountNo"), HiddenField)
                            If oCheckBox IsNot Nothing Then
                                strAccountNo = oHidden.Value
                            End If

                            lblMessage.Visible = True
                            lblMessage.Text = "ACCOUNT : " & strAccountNo & " ALREADY APPROVE OR REJECT"
                            Exit For
                        ElseIf intRetVal = -2 Then
                            Dim oHidden As HiddenField, strAccountNo As String = ""
                            oHidden = CType(row.FindControl("txtAccountNo"), HiddenField)
                            If oCheckBox IsNot Nothing Then
                                strAccountNo = oHidden.Value
                            End If

                            lblMessage.Visible = True
                            lblMessage.Text = "ACCOUNT : " & strAccountNo & " ALREADY IN JF ACCOUNT (ACTIVE JF ACCOUNT)..!<BR>PLEASE CHECK ACCOUNT IN JF ACCOUNT INQUIRY..!"
                            Exit For
                        ElseIf intRetVal = -3 Then
                            Dim oHidden As HiddenField, strAccountNo As String = ""
                            oHidden = CType(row.FindControl("txtAccountNo"), HiddenField)
                            If oCheckBox IsNot Nothing Then
                                strAccountNo = oHidden.Value
                            End If

                            lblMessage.Visible = True
                            lblMessage.Text = "PLAFOND IS NOT ENOUGH FOR ACCOUNT : " & strAccountNo & "..!<BR>PLEASE CHECK JF/BANK PARAMETER...!"
                            Exit For

                        End If
                    End If
                End If
            Next

            DataSearch()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = ex.Message
        Finally
            objCore = Nothing
        End Try
    End Sub

    Protected Sub btnReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReject.Click
        Dim objCore As New Core
        Try
            lblMessage.Visible = False
            Dim strRequestIDAcc As String
            Dim oCheckBox As CheckBox
            Dim intRetVal As Integer = 0
            For Each row As GridViewRow In gvRequestAcc.Rows
                oCheckBox = CType(row.FindControl("cbChk"), CheckBox)
                If oCheckBox IsNot Nothing Then
                    If oCheckBox.Checked Then
                        strRequestIDAcc = gvRequestAcc.DataKeys(row.RowIndex).Values("REQUESTIDACC").ToString()
                        intRetVal = objCore.JFREQUESTACCApproval(strRequestIDAcc, 9, ConvertDate(txtValueDate.Text), Request.Cookies("UID").Value)
                        If intRetVal = -1 Then
                            Dim oHidden As HiddenField, strAccountNo As String = ""
                            oHidden = CType(row.FindControl("txtAccountNo"), HiddenField)
                            If oCheckBox IsNot Nothing Then
                                strAccountNo = oHidden.Value
                            End If

                            lblMessage.Visible = True
                            lblMessage.Text = "ACCOUNT : " & strAccountNo & " ALREADY APPROVE OR REJECT"
                            Exit For
                        End If
                    End If
                End If
            Next
            DataSearch()

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR JF REQUEST REJECT: " & ex.Message & "PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objCore = Nothing

        End Try
    End Sub

    Private Sub SetFormValidation()
        SetObjectValidation(txtNewInstDay, False, "integer", "[0-9]")
        SetObjectValidation(txtValueDate, False, "date", "[0-9/]")
        chkAll.Attributes.Add("onclick", "CheckAll()")
    End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
        Dim objCore As New Core
        Try
            lblMessage.Visible = False
            Dim strRequestIDAcc As String
            Dim oCheckBox As CheckBox
            For Each row As GridViewRow In gvRequestAcc.Rows
                oCheckBox = CType(row.FindControl("cbChk"), CheckBox)
                If oCheckBox IsNot Nothing Then
                    If oCheckBox.Checked Then
                        strRequestIDAcc = gvRequestAcc.DataKeys(row.RowIndex).Values("REQUESTIDACC").ToString()
                        objCore.JFREQUESTACCInstDayUpdate(strRequestIDAcc, _
                            txtNewInstDay.Text, Request.Cookies("UID").Value)
                    End If
                End If
            Next
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR UPDATE JF INSTALLMENT DAY : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objCore = Nothing
        End Try
        DataSearch()
    End Sub

    Protected Sub ddlJFRequestSearch_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlJFRequestSearch.SelectedIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvRequestAcc_PageIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvRequestAcc.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub btnUpdateBookDate_Click(sender As Object, e As System.EventArgs) Handles btnUpdateBookDate.Click
        Dim objCore As New Core
        Try
            lblMessage.Visible = False
            Dim strRequestIDAcc As String
            Dim oCheckBox As CheckBox
            For Each row As GridViewRow In gvRequestAcc.Rows
                oCheckBox = CType(row.FindControl("cbChk"), CheckBox)
                If oCheckBox IsNot Nothing Then
                    If oCheckBox.Checked Then
                        strRequestIDAcc = gvRequestAcc.DataKeys(row.RowIndex).Values("REQUESTIDACC").ToString()
                        objCore.JFREQUESTACCJFBookedDateUpdate(strRequestIDAcc, _
                            ConvertDate(txtValueDate.Text), Request.Cookies("UID").Value)
                    End If
                End If
            Next
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR UPDATE JF BOOKED DATE : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objCore = Nothing
        End Try
        DataSearch()

    End Sub

    Protected Sub gvRequestAcc_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvRequestAcc.RowDataBound
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            Dim oCheckBox As CheckBox
            oCheckBox = CType(e.Row.FindControl("cbChk"), CheckBox)
            If oCheckBox IsNot Nothing Then
                oCheckBox.Attributes.Add("onclick", "SelectRow(this);")
                strCheckBox = strCheckBox & oCheckBox.ClientID & ","
            End If
        End If
    End Sub

    Protected Sub ddlJFRequestTypeSearch_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlJFRequestTypeSearch.SelectedIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvRequestAcc_Sorted(sender As Object, e As System.EventArgs) Handles gvRequestAcc.Sorted
        DataSearch()
    End Sub
End Class
