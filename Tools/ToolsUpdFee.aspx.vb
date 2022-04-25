
Partial Class Tools_ToolsUpdFee
    Inherits System.Web.UI.Page
    Public Shared strAppDate As String
    Public Shared strAppState As String
    Public Shared strCorrection, strOriFee, strNewFee As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        txtUID.Value = Request.Cookies("UID").Value
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE, CAST(dbo.f_IsUserBranch(" & Request.Cookies("UID").Value & ") as VARCHAR(10)) ISUSERBRANCH FROM APPSETTING WITH(NOLOCK) WHERE APPCODE='APPDATE'")
            If oSDR.Read Then
                strAppDate = oSDR("APPVALUE").ToString()
                hidIsUserBranch.Value = oSDR("ISUSERBRANCH").ToString()
            End If
            oSDR.Close()
            oSDR = Nothing

            If Not IsPostBack() Then
                MultiView_Utama.SetActiveView(View_View)
                txtAction.Value = "LOAD"
                rbReqAll.Checked = True
                rbBookAll.Checked = True
                'rbCloseAll.Checked = True
                txtRequestForm.Text = strAppDate
                txtRequestTo.Text = strAppDate
                txtBookFrom.Text = strAppDate
                txtBookTo.Text = strAppDate
                'txtCloseFrom.Text = strAppDate
                'txtCloseTo.Text = strAppDate

                'SetObjectValidation(txtSearch, True)
                SetObjectValidation(txtRequestForm, True, "date", "[0-9/]")
                SetObjectValidation(txtRequestTo, True, "date", "[0-9/]")
                SetObjectValidation(txtBookFrom, True, "date", "[0-9/]")
                SetObjectValidation(txtBookTo, True, "date", "[0-9/]")

                'SetObjectValidation(txtCloseFrom, True, "date", "[0-9/]")
                'SetObjectValidation(txtCloseTo, True, "date", "[0-9/]")

            End If

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

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try


    End Sub
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub
    Private Sub DataSearch()
        If Not IsPostBack() Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.LOCID=0 AND ACCOUNT.ACCID=0)"
        End If

        If Len(Trim(txtSearch.Text)) > 0 Then
            If ddlCriteria.SelectedValue = "ACCNOX" Or ddlCriteria.SelectedValue = "CUSTNOX" Then
                Dim strBranchID As String = ""
                'Dim strJFID As String = ""
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
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (APPLICATION.REQUESTDATE BETWEEN CONVERT(DATETIME, '" + strAppDate + "', 103) AND CONVERT(DATETIME, '" + strAppDate + "', 103))"
            End If
        End If

        If rbBookFrom.Checked Then
            If Len(Trim(txtBookFrom.Text)) > 0 And Len(Trim(txtBookTo.Text)) > 0 Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.BOOKINGDATE BETWEEN CONVERT(DATETIME, '" + txtBookFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtBookTo.Text + "', 103))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.BOOKINGDATE BETWEEN CONVERT(DATETIME, '" + strAppDate + "', 103) AND CONVERT(DATETIME, '" + strAppDate + "', 103))"
            End If
        End If

        'If rbCloseFrom.Checked Then
        '    If Len(Trim(txtBookFrom.Text)) > 0 And Len(Trim(txtBookTo.Text)) > 0 Then
        '        Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.CLOSETXNDATE BETWEEN CONVERT(DATETIME, '" + txtCloseFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtCloseTo.Text + "', 103))"
        '    Else
        '        Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (ACCOUNT.CLOSETXNDATE BETWEEN CONVERT(DATETIME, '" + strAppDate + "', 103) AND CONVERT(DATETIME, '" + strAppDate + "', 103))"
        '    End If
        'End If

        If Len(Trim(ddlFinanceCategory.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND ACCOUNT.FINCATID=" & ddlFinanceCategory.SelectedValue
        End If

        If Len(Trim(ddlAreaSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND AREA.AREAID=" & ddlAreaSearch.SelectedValue
        End If
        If Len(Trim(ddlBranchSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCH.BRANCHID=" & ddlBranchSearch.SelectedValue
        End If

        If Not IsPostBack Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND APPLICATION.APPSTATUS<>0"
        End If
        gvData.DataBind()
    End Sub
    Private Sub SetValidation()

        If txtOriFee IsNot Nothing Then
            strOriFee = txtOriFee.ClientID
            txtOriFee.Text = 0
            SetObjectValidation(txtOriFee, False, "signed float", "[0-9,-]")
        End If
        If txtNewFee IsNot Nothing Then
            strNewFee = txtNewFee.ClientID
        End If
        If txtCorrection IsNot Nothing Then
            strCorrection = txtCorrection.ClientID
            txtCorrection.Text = 0
            SetObjectValidation(txtCorrection, False, "signed float", "[0-9,-]")
            txtCorrection.Attributes.Add("onchange", "CalcTotal();")
        End If


        If txtNewFee IsNot Nothing Then
            txtNewFee.Text = 0
            txtNewFee.Text = String.Format("{0:n}", Convert.ToDouble(txtOriFee.Text) + Convert.ToDouble(txtCorrection.Text))
            SetObjectValidation(txtNewFee, False, "signed float", "[0-9,-]")
        End If
    End Sub
    Private Sub getData()
        Dim objDB As New DBX
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader

            oSDR = objDB.CreateSDRFromSQLSelect("SELECT  * " & _
              " FROM dbo.ACCOUNTDTL WITH(NOLOCK) WHERE LOCID=" & hidLocid.Value & " and ACCID = " & hidAccID.Value)
            If oSDR.Read Then
                txtOriFee.Text = String.Format("{0:N}", oSDR("ADMFEE"))
                txtNewFee.Text = txtOriFee.Text
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RETRIVE DATA (TOOLS ADMIN FEE) ENTRY: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub
    Protected Sub gvData_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        If e.CommandName = "Select" Then
            gvData.SelectedIndex = e.CommandArgument
            MultiView_Utama.SetActiveView(View_Form)
            hidLocid.Value = gvData.SelectedDataKey("LOCID")
            hidAccID.Value = gvData.SelectedDataKey("ACCID")

            ctlDataAccountFromParamAccID.LOCID = hidLocid.Value
            ctlDataAccountFromParamAccID.ACCID = hidAccID.Value

            ctlCollateralDataFromAccID.LOCID = hidLocid.Value
            ctlCollateralDataFromAccID.ACCID = hidAccID.Value
            SetValidation()
            getData()

        End If
    End Sub
    Protected Sub btnBack_Click(sender As Object, e As System.EventArgs) Handles btnBack.Click
        Dim objDB As New DBX
        Try
            MultiView_Utama.SetActiveView(View_View)

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR BACK: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB = Nothing
        End Try

    End Sub
    Private Sub SaveData(ByVal sLocid As String,
                      ByVal sACCID As String,
                      ByVal sADMFEE As String,
                      ByVal sUserId As String)
        Dim objDB As New DBX
        Dim intRetVal As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection

        Try

            oSQLParam = objDB.ExecSPReturnParam("ADMINFEEUpdate", _
                   objDB.MP("@LOCID", Data.SqlDbType.Int, sLocid, 10), _
                   objDB.MP("@ACCID", Data.SqlDbType.BigInt, sACCID, 20), _
                   objDB.MP("@ADMFEE", Data.SqlDbType.Money, sADMFEE, 20), _
                   objDB.MP("@USERID", Data.SqlDbType.Int, sUserId, 20), _
                    objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 10, Data.ParameterDirection.Output) _
                    )

            intRetVal = oSQLParam("@RETVAL").Value.ToString()

            If intRetVal = -1 Then
                lblMessage.Visible = True
                lblMessage.Text = "DATA ACCOUNT : " & sACCID & " IS NOT EXISTS"
            Else
                lblMessage.Text = ""
                lblMessage.Visible = False
            End If


        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE DATA: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Private Function NoComma(ByVal strValue As String) As String
        NoComma = Replace(strValue, ",", "")
    End Function

    Protected Sub btnUpdate_Click(sender As Object, e As System.EventArgs) Handles btnUpdate.Click
        Dim objDB As New DBX
        Try
            txtNewFee.Text = String.Format("{0:n}", Convert.ToDouble(txtOriFee.Text) + Convert.ToDouble(txtCorrection.Text))
            SaveData(hidLocid.Value, hidAccID.Value, NoComma(txtNewFee.Text), Request.Cookies("UID").Value)
            MultiView_Utama.SetActiveView(View_View)
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = " ERROR SAVE DATA: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
    End Sub
End Class
