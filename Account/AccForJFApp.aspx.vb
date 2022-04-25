
Partial Class Txn_JFApproval
    Inherits System.Web.UI.Page
    Public Shared strAppDate As String
    Public Shared strAppState As String
    Public Shared strCheckBox As String

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Response.Write(Request.Cookies("AppDate").Value)

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

        If Not IsPostBack() Then
            txtAction.Value = Request.QueryString("Action")
            txtValueDate.Text = strAppDate
            If txtAction.Value = "INQ" Then
                'btnCheckAll.Visible = False
                chkAll.Visible = False
                pnlProcess.Visible = False
            Else
                'btnCheckAll.Visible = True
                chkAll.Visible = True
                pnlProcess.Visible = True
            End If
            rbReqAll.Checked = True
            txtRequestForm.Text = strAppDate
            txtRequestTo.Text = strAppDate

            'SetObjectValidation(txtSearch, True)
            SetObjectValidation(txtRequestForm, True, "date", "[0-9/]")
            SetObjectValidation(txtRequestTo, True, "date", "[0-9/]")
            chkAll.Attributes.Add("onclick", "CheckAll()")

            DataSearch()
            If txtAction.Value = "INQ" Then
                gvData.Columns(2).Visible = False
            End If

        End If

    End Sub


    Private Sub DataSearch()
        chkAll.Checked = False
        strCheckBox = ""
        If Not IsPostBack() Then
            Me.sdsGrid.SelectCommand = Replace(Me.sdsGrid.SelectCommand, "1 = 1", " (1 = 1) AND (REQUESTID=0)")
        End If

        If Len(Trim(txtSearch.Text)) > 0 Then
            If ddlCriteria.SelectedValue = "ACCNOX" Or ddlCriteria.SelectedValue = "CUSTNOX" Then
                Dim strBranchID As String = ""
                Dim strCompID As String = ""
                Dim strNumber As String = ""
                SplitFormatedNumber(txtSearch.Text, strBranchID, strNumber)
                If ddlCriteria.SelectedValue = "ACCNOX" Then
                    Me.sdsGrid.SelectCommand = Replace(Me.sdsGrid.SelectCommand, "1 = 1", " (1 = 1) AND EXISTS (SELECT 'X' FROM ACCOUNT WITH(NOLOCK), JFREQUESTACC WITH(NOLOCK) WHERE JFREQUEST.REQUESTID=JFREQUESTACC.REQUESTID AND JFREQUESTACC.LOCID=ACCOUNT.LOCID AND JFREQUESTACC.ACCID=ACCOUNT.ACCID AND ACCOUNT.BRANCHID=" & strBranchID & " AND ACCOUNT.ACCOUNTNO=" & strNumber & ")")
                End If
            ElseIf InStr(UCase(ddlCriteria.SelectedValue), "ACCID", CompareMethod.Text) > 0 Or _
                InStr(UCase(ddlCriteria.SelectedValue), "ACCOUNTNO", CompareMethod.Text) > 0 _
            Then
                If IsNumeric(txtSearch.Text) Then
                    Me.sdsGrid.SelectCommand = Replace(Me.sdsGrid.SelectCommand, "1 = 1", " (1 = 1) AND EXISTS (SELECT 'X' FROM ACCOUNT WITH(NOLOCK), JFREQUESTACC WITH(NOLOCK) WHERE JFREQUEST.REQUESTID=JFREQUESTACC.REQUESTID AND JFREQUESTACC.LOCID=ACCOUNT.LOCID AND JFREQUESTACC.ACCID=ACCOUNT.ACCID AND  " + ddlCriteria.SelectedItem.Value + "=" + Me.txtSearch.Text & ")")
                Else
                    Me.sdsGrid.SelectCommand = Replace(Me.sdsGrid.SelectCommand, "1 = 1", " (1 = 1) AND REQUESTID=0")
                End If
            ElseIf InStr(UCase(ddlCriteria.SelectedValue), "ACCOUNTNAME") Then
                Me.sdsGrid.SelectCommand = Replace(Me.sdsGrid.SelectCommand, "1 = 1", " (1 = 1) AND EXISTS (SELECT 'X' FROM ACCOUNT WITH(NOLOCK), JFREQUESTACC WITH(NOLOCK) WHERE JFREQUEST.REQUESTID=JFREQUESTACC.REQUESTID AND JFREQUESTACC.LOCID=ACCOUNT.LOCID AND JFREQUESTACC.ACCID=ACCOUNT.ACCID AND  " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%')")

            Else
                Me.sdsGrid.SelectCommand = Replace(Me.sdsGrid.SelectCommand, "1 = 1", " (1 = 1) AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'")
            End If
        End If



        If rbReqFrom.Checked Then
            If Len(Trim(txtRequestForm.Text)) > 0 And Len(Trim(txtRequestTo.Text)) > 0 Then
                Me.sdsGrid.SelectCommand = Replace(Me.sdsGrid.SelectCommand, "1 = 1", " (1 = 1) AND (REQUESTDATE BETWEEN CONVERT(DATETIME, '" + txtRequestForm.Text + "', 103) AND CONVERT(DATETIME, '" + txtRequestTo.Text + "', 103))")
            Else
                Me.sdsGrid.SelectCommand = Replace(Me.sdsGrid.SelectCommand, "1 = 1", " (1 = 1) AND (REQUESTDATE BETWEEN CONVERT(DATETIME, '" + strAppDate + "', 103) AND CONVERT(DATETIME, '" + strAppDate + "', 103))")
            End If
        End If

        gvData.DataBind()
        chkAll.Checked = False
        If gvData.Rows.Count() <= 0 Then
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
    '    'lblMessage.Visible = False
    '    Dim oCheckBox As CheckBox
    '    For Each row As GridViewRow In gvData.Rows
    '        oCheckBox = CType(row.FindControl("cbChk"), CheckBox)
    '        If oCheckBox IsNot Nothing Then
    '            oCheckBox.Checked = True
    '            If oCheckBox.Visible Then
    '                row.CssClass = "SelectedRowStyle"
    '            End If
    '        End If
    '    Next
    'End Sub

    Protected Sub btnApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApprove.Click
        Dim objCore As New Core
        Try
            Dim strRequestID As String
            Dim oCheckBox As CheckBox
            For Each row As GridViewRow In gvData.Rows
                oCheckBox = CType(row.FindControl("cbChk"), CheckBox)
                If oCheckBox IsNot Nothing Then
                    If oCheckBox.Checked Then
                        strRequestID = gvData.DataKeys(row.RowIndex).Values("REQUESTID").ToString()
                        objCore.JFREQUESTACCApprovalbyRequestID(strRequestID, 1, ConvertDate(txtValueDate.Text), Request.Cookies("UID").Value)
                    End If
                End If
            Next
            lblMessage.Visible = True
            lblMessage.Text = "APPROVAL JF COMPLETED..!"
            DataSearch()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR APPROVAL JF : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objCore = Nothing

        End Try

    End Sub

    Protected Sub btnReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReject.Click
        Dim objCore As New Core
        Try
            Dim strRequestID As String
            Dim oCheckBox As CheckBox
            For Each row As GridViewRow In gvData.Rows
                oCheckBox = CType(row.FindControl("cbChk"), CheckBox)
                If oCheckBox IsNot Nothing Then
                    If oCheckBox.Checked Then
                        strRequestID = gvData.DataKeys(row.RowIndex).Values("REQUESTID").ToString()
                        objCore.JFREQUESTACCApprovalbyRequestID(strRequestID, 9, ConvertDate(txtValueDate.Text), Request.Cookies("UID").Value)
                    End If
                End If
            Next
            DataSearch()
            lblMessage.Visible = True
            lblMessage.Text = "REJECT JF COMPLETED..!"
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR REJECT JF : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objCore = Nothing

        End Try

    End Sub

    Protected Sub gvData_PageIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvData.PageIndexChanged
        lblMessage.Visible = False
        DataSearch()
    End Sub

    Protected Sub gvData_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvData.RowDataBound
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            Dim oCheckBox As CheckBox
            oCheckBox = CType(e.Row.FindControl("cbChk"), CheckBox)
            If oCheckBox IsNot Nothing Then
                oCheckBox.Attributes.Add("onclick", "SelectRow(this);")
                strCheckBox = strCheckBox & oCheckBox.ClientID & ","
            End If
        End If
    End Sub
End Class
