
Partial Class Pay_TxnInput
    Inherits System.Web.UI.Page

    Public Shared strAppState As String
    Public Shared oStrtxtDebet, oStrtxtKredit, oStrtxtTotalDebet, oStrtxtTotalKredit As String
    Private TotalDebet As Decimal = 0.0
    Private TotalKredit As Decimal = 0.0
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try

            txtUID.Value = Request.Cookies("UID").Value
            If Not IsPostBack() Then
                ddlFinCatEntry.Attributes.Add("onchange", "FinCatChange();")
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE, dbo.f_getDefaultCurrency() CURRENCYIDEF, CAST(dbo.f_IsUserBranch(" & Request.Cookies("UID").Value & ") as VARCHAR(10)) ISUSERBRANCH FROM APPSETTING WITH(NOLOCK)  WHERE APPCODE='APPDATE'")
                If oSDR.Read Then
                    txtAppDate.Value = oSDR("APPVALUE").ToString()
                    hidIsUserBranch.Value = oSDR("ISUSERBRANCH").ToString()
                    hidCURRENCYDEF.Value = oSDR("CURRENCYIDEF").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing

                hidAction.Value = "LOAD"

                lblAppDate.Text = txtAppDate.Value
                txtValueDate.Text = txtAppDate.Value
                MVTxn.SetActiveView(vSearch)
                rbTxnAll.Checked = True
                'rbRevAll.Checked = True
                txtTxnFrom.Text = txtAppDate.Value
                txtTxnTo.Text = txtAppDate.Value

                'txtRevFrom.Text = txtAppDate.Value
                'txtRevTo.Text = txtAppDate.Value

                'SetObjectValidation(txtSearch, True)
                SetObjectValidation(txtTxnFrom, True, "date", "[0-9/]")
                SetObjectValidation(txtTxnTo, True, "date", "[0-9/]")

                'SetObjectValidation(txtRevFrom, True, "date", "[0-9/]")
                'SetObjectValidation(txtRevTo, True, "date", "[0-9/]")

                ReadOnlyAplicationField(vEntry)
                ajaxCDDArea.ContextKey = txtUID.Value
                ajaxCDDBranch.ContextKey = txtUID.Value
                ajaxCCDFincat.ContextKey = txtUID.Value
                ajaxCCDFinCatEntry.ContextKey = txtUID.Value

                ajaxCCDBankFrom.ContextKey = txtUID.Value & ","
                ajaxCCDBankTo.ContextKey = txtUID.Value & ","

                'Dim arrTxt As String() = (txtUID.Value & ",abc").Split(",")
                'Response.Write(arrTxt(1))
                'Response.End()


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
            oStrtxtDebet = ""
            oStrtxtKredit = ""
            DataSearch()

        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub

    Private Sub DataSearch()
        If hidIsUserBranch.Value = "1" Then 'jika user cabang, filter berdasarkan cabang yang berhak saja
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND BRANCH.BRANCHID IN (SELECT BRANCHID FROM dbo.f_getAPPUSERBRANCHList(" & txtUID.Value & "))"
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND TXN.FINCATID IN (SELECT FINCATID FROM dbo.f_getAPPUSERFINCATList(" & txtUID.Value & "))"
        End If
        If Not IsPostBack() Then
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND (TXN.LOCIDTXN=-1) AND (TXN.TXNID=-1)"
        End If
        If Len(Trim(txtSearch.Text)) > 0 Then
            If ddlCriteria.SelectedValue = "ACCNOX" Then
                Dim strBranchID As String = ""
                Dim strJFID As String = ""
                Dim strNumber As String = ""
                SplitFormatedNumber(txtSearch.Text, strBranchID, strNumber)
                If ddlCriteria.SelectedValue = "ACCNOX" Then
                    Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND ACCOUNT.BRANCHID=" & strBranchID & " AND ACCOUNT.ACCOUNTNO=" & strNumber
                End If
            ElseIf InStr(UCase(ddlCriteria.SelectedValue), "TXN.REFNO", CompareMethod.Text) > 0 Or _
                InStr(UCase(ddlCriteria.SelectedValue), "ACCOUNT.ACCOUNTNO", CompareMethod.Text) > 0 Or _
                InStr(UCase(ddlCriteria.SelectedValue), "TXN.TXNID", CompareMethod.Text) > 0 _
            Then
                If IsNumeric(txtSearch.Text) Then
                    Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + "=" + Me.txtSearch.Text
                Else
                    Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + "=0"
                End If
            Else
                Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
            End If
        End If

        If rbTxnDate.Checked Then
            If Len(Trim(txtTxnFrom.Text)) > 0 And Len(Trim(txtTxnTo.Text)) > 0 Then
                Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND (TXN.TXNDATE BETWEEN CONVERT(DATETIME, '" + txtTxnFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtTxnTo.Text + "', 103))"
            Else
                Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND (TXN.TXNDATE BETWEEN CONVERT(DATETIME, '" + txtAppDate.Value + "', 103) AND CONVERT(DATETIME, '" + txtAppDate.Value + "', 103))"
            End If
        End If

        'If rbRevFrom.Checked Then
        '    If Len(Trim(txtRevFrom.Text)) > 0 And Len(Trim(txtRevTo.Text)) > 0 Then
        '        Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND (TXN.REVERSALDATE BETWEEN CONVERT(DATETIME, '" + txtRevFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtRevTo.Text + "', 103))"
        '    Else
        '        Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND (TXN.REVERSALDATE BETWEEN CONVERT(DATETIME, '" + txtAppDate.Value + "', 103) AND CONVERT(DATETIME, '" + txtAppDate.Value + "', 103))"
        '    End If
        'End If

        If Len(Trim(ddlAreaSearch.SelectedValue)) > 0 Then
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND BRANCH.AREAID=" & ddlAreaSearch.SelectedValue
        End If
        If Len(Trim(ddlBranchSearch.SelectedValue)) > 0 Then
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND BRANCH.BRANCHID=" & ddlBranchSearch.SelectedValue
        End If

        If Len(Trim(ddlFinanceCategory.SelectedValue)) > 0 Then
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND TXN.FINCATID=" & ddlFinanceCategory.SelectedValue
        End If

        'If Len(Trim(ddlRevStatusSearch.SelectedValue)) > 0 Then
        '    Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND TXN.REVERSESTS=" & ddlRevStatusSearch.SelectedValue
        'End If
        If Len(Trim(ddlBookCodeSearch.SelectedValue)) > 0 Then
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND TXN.BCID=" & ddlBookCodeSearch.SelectedValue
        End If
        gvData.DataBind()
    End Sub

    Protected Sub imgBtnNew_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        MVTxn.SetActiveView(vEntry)
        gvJournal.DataBind()
        chkAddNew.Checked = True
        Validation.ClearViewAplicationField(vEntry)
        ddlBookCode.Enabled = True
        hidAction.Value = "NEW"
        txtValueDate.Text = txtAppDate.Value
        ddlCurrency.SelectedValue = hidCURRENCYDEF.Value
        ajaxCCDBankFrom.ContextKey = txtUID.Value & "," & ddlFinanceCategory.SelectedValue
        ajaxCCDBankTo.ContextKey = txtUID.Value & "," & ddlFinanceCategory.SelectedValue
        'ddlFinanceCategory.Attributes.Add("onchange", "FinCatChange();")

    End Sub


    Private Sub SetValidation()
        Dim oTextbox As TextBox
        oTextbox = CType(gvJournal.FindControl("txtAmountDebet"), TextBox)
        If oTextbox IsNot Nothing Then
            oTextbox.Text = 0.0
            SetObjectValidation(oTextbox, False, "float", "[0-9]")
            oStrtxtDebet = oTextbox.ClientID
        End If

        oTextbox = CType(gvJournal.FindControl("txtAmountKredit"), TextBox)
        If oTextbox IsNot Nothing Then
            oTextbox.Text = 0.0
            SetObjectValidation(oTextbox, False, "float", "[0-9]")
            oStrtxtKredit = oTextbox.ClientID
        End If
    End Sub

    Protected Sub gvJournal_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvJournal.RowDataBound
        Dim oTextBoxDbt As TextBox
        Dim oTextBoxKrd As TextBox
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            TotalDebet += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Debet"))
            TotalKredit += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Kredit"))
            oTextBoxDbt = CType(e.Row.FindControl("txtAmountDebet"), TextBox)
            If oTextBoxDbt IsNot Nothing Then
                oStrtxtDebet = oStrtxtDebet & oTextBoxDbt.ClientID & ","
                SetObjectValidation(oTextBoxDbt, False, "float", "[0-9.,]")
                oTextBoxDbt.Attributes.Add("onchange", "CalcTotalDebet();")
            End If

            oTextBoxKrd = CType(e.Row.FindControl("txtAmountKredit"), TextBox)
            If oTextBoxKrd IsNot Nothing Then
                oStrtxtKredit = oStrtxtKredit & oTextBoxKrd.ClientID & ","
                SetObjectValidation(oTextBoxKrd, False, "float", "[0-9.,]")
                oTextBoxKrd.Attributes.Add("onchange", "CalcTotalKredit();")
            End If
        ElseIf (e.Row.RowType = DataControlRowType.Footer) Then
            Dim oTextbox As TextBox
            oTextbox = CType(e.Row.FindControl("txtTotalAmountDebet"), TextBox)
            If oTextbox IsNot Nothing Then
                'oTextbox.Text = 0.0
                oStrtxtTotalDebet = oTextbox.ClientID
                oTextbox.Text = String.Format("{0:n}", TotalDebet)
                SetObjectValidation(oTextbox, False, "float", "[0-9.,]")
            End If
            oTextbox = CType(e.Row.FindControl("txtTotalAmountKredit"), TextBox)
            If oTextbox IsNot Nothing Then
                'oTextbox.Text = 0.0
                oStrtxtTotalKredit = oTextbox.ClientID
                oTextbox.Text = String.Format("{0:n}", TotalKredit)
                SetObjectValidation(oTextbox, False, "float", "[0-9.,]")
            End If
        End If
    End Sub

    Private Sub getBookInfo()
        Dim objDB As New DBX
        Dim strBOOKINFO As String = ""
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim strJournalType As String = "", strTxnType As String = ""
        If ddlBookCode.SelectedValue <> "" Then
            Try
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT JOURNALTYPE, TXNTYPE, CAST(JOURNALTYPE AS VARCHAR(20)) + '|' +  CAST(TXNTYPE AS VARCHAR(20)) + '|' +  dbo.f_getParamGlobalName('JOURNALTYPE', JOURNALTYPE) + '|' + dbo.f_getParamGlobalName('JOURNALTXNTYPE', TXNTYPE) AS BOOKINFO" & _
                    " FROM BOOKCODE WITH(NOLOCK) " & _
                    " WHERE BCID=" & ddlBookCode.SelectedValue)
                If oSDR.Read() Then
                    strJournalType = oSDR("JOURNALTYPE").ToString()
                    strTxnType = oSDR("TXNTYPE").ToString()
                    strBOOKINFO = oSDR("BOOKINFO").ToString()
                    Dim arrBookInfo = strBOOKINFO.Split("|")
                    Dim oBookRemark = lblBookRemark.Text
                    '  Dim oBankRemark = lblBankRemark.Text
                    hidJOURNALTYPE.Value = arrBookInfo(0).ToString()
                    hidTXNTYPE.Value = arrBookInfo(1).ToString()
                    lblBookRemark.Text = arrBookInfo(2).ToString() & " - " & arrBookInfo(3).ToString()
                    If arrBookInfo(1).ToString() = 1 Then
                        BankCheck(False)
                    ElseIf arrBookInfo(1).ToString() = 2 Then
                        BankCheck(True)
                    End If
                    If strTxnType = "1" And strJournalType = "1" Then 'CASH IN
                        ddlAccountNo.Visible = True
                        lblAccountFrom.Visible = True
                        ddlAccountTo.Visible = False
                        lblAccountTo.Visible = False
                    ElseIf strTxnType = "1" And strJournalType = "2" Then 'CASH OUT
                        ddlAccountNo.Visible = False
                        lblAccountFrom.Visible = False
                        ddlAccountTo.Visible = True
                        lblAccountTo.Visible = True
                    ElseIf strTxnType = "2" And strJournalType = "1" Then 'BANK IN
                        ddlAccountNo.Visible = True
                        ddlAccountTo.Visible = True
                        lblAccountFrom.Visible = True
                        lblAccountTo.Visible = True
                        ddlAccountNo.CssClass = ""
                        ddlAccountTo.CssClass = "required"
                        reqBankAcc.Enabled = False
                        reqBankAccTo.Enabled = True
                    Else 'If strTxnType = "2" And strJournalType = "2" Then 'BANK OUT
                        ddlAccountNo.Visible = True
                        ddlAccountTo.Visible = True
                        lblAccountFrom.Visible = True
                        lblAccountTo.Visible = True
                        ddlAccountNo.CssClass = "required"
                        ddlAccountTo.CssClass = ""
                        reqBankAcc.Enabled = True
                        reqBankAccTo.Enabled = False

                    End If
                End If
                oSDR.Close()
                oSDR = Nothing
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        Else
            ClearBookInfo()
        End If
    End Sub

    Private Sub ClearBookInfo()
        '    lblBankRemark.Text = ""
        lblBookRemark.Text = ""
        hidJOURNALTYPE.Value = ""
        hidTXNTYPE.Value = ""

        BankCheck(False)
    End Sub

    Private Sub BankCheck(ByVal Check As Boolean)
        reqBankAcc.Enabled = Check
        If Check = True Then
            ddlAccountNo.CssClass = "required"
        Else
            ddlAccountNo.CssClass = ""
        End If
    End Sub

    Protected Sub ddlBookCode_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlBookCode.SelectedIndexChanged
        ddlAccountNo.SelectedValue = ""
        ddlAccountTo.SelectedValue = ""
        getBookInfo()
        BindDataJournal()
        'If ddlBookCode.SelectedValue = 11 Then
        '    ddlAccountNo.Visible = True
        '    lblAccountFrom.Visible = True
        '    ddlAccountTo.Visible = False
        '    lblAccountTo.Visible = False
        'ElseIf ddlBookCode.SelectedValue = 12 Then
        '    ddlAccountNo.Visible = False
        '    lblAccountFrom.Visible = False
        '    ddlAccountTo.Visible = True
        '    lblAccountTo.Visible = True
        'ElseIf ddlBookCode.SelectedValue = 13 Then
        '    ddlAccountNo.Visible = True
        '    ddlAccountTo.Visible = True
        '    lblAccountFrom.Visible = True
        '    lblAccountTo.Visible = True
        '    ddlAccountNo.CssClass = ""
        '    ddlAccountTo.CssClass = "required"
        '    reqBankAcc.Enabled = False
        '    reqBankAccTo.Enabled = True
        'Else
        '    ddlAccountNo.Visible = True
        '    ddlAccountTo.Visible = True
        '    lblAccountFrom.Visible = True
        '    lblAccountTo.Visible = True
        '    ddlAccountNo.CssClass = "required"
        '    ddlAccountTo.CssClass = ""
        '    reqBankAcc.Enabled = True
        '    reqBankAccTo.Enabled = False
        'End If
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        SaveData(ConvertDate(txtValueDate.Text), ddlBookCode.SelectedValue, hidLOCID.Value, hidACCID.Value, txtRefNo.Text, ddlAccountNo.SelectedValue, ddlAccountTo.SelectedValue, LTrim(RTrim(txtRemark.Text)))
        DataSearch()
    End Sub

    Private Sub SaveData(ByVal dValueDate As String,
                         ByVal iBCID As String,
                         ByVal iLOCID As String,
                         ByVal iACCID As String,
                         ByVal sRefNo As String,
                         ByVal iAccountID As String,
                         ByVal iAccountIDTo As String,
                         ByVal sRemark As String)
        lblMessage.Visible = False
        Dim objDB As New DBX
        Dim intRetVal As Integer
        Dim iLOCIDTXN As Integer
        Dim iTXNID As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try

            If chkAddNew.Checked = True Then
                oSQLParam = objDB.ExecSPReturnParam("TXNAdd", _
                    objDB.MP("@VALUEDATE", Data.SqlDbType.DateTime, dValueDate),
                    objDB.MP("@BCID", Data.SqlDbType.Int, iBCID),
                    objDB.MP("@LOCID", Data.SqlDbType.Int, iLOCID),
                    objDB.MP("@ACCID", Data.SqlDbType.BigInt, iACCID),
                    objDB.MP("@REFNO", Data.SqlDbType.VarChar, sRefNo),
                    objDB.MP("@ACCOUNTID", Data.SqlDbType.Int, iAccountID),
                    objDB.MP("@REMARK", Data.SqlDbType.VarChar, sRemark),
                    objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value),
                    objDB.MP("@LOCIDTXN", Data.SqlDbType.Int, iLOCIDTXN, 12, Data.ParameterDirection.Output),
                    objDB.MP("@TXNID", Data.SqlDbType.BigInt, iTXNID, 20, Data.ParameterDirection.Output),
                    objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 10, Data.ParameterDirection.Output),
                    objDB.MP("@ACCOUNTIDTO", Data.SqlDbType.Int, iAccountIDTo),
                    objDB.MP("@CURRENCYID", Data.SqlDbType.Int, ddlCurrency.SelectedValue),
                    objDB.MP("@FINCATID", Data.SqlDbType.Int, ddlFinCatEntry.SelectedValue)
                )
                intRetVal = oSQLParam("@RETVAL").Value.ToString()
                If Not IsDBNull(oSQLParam("@LOCIDTXN").Value) Then
                    iLOCIDTXN = oSQLParam("@LOCIDTXN").Value
                End If
                If Not IsDBNull(oSQLParam("@TXNID").Value) Then
                    iTXNID = oSQLParam("@TXNID").Value
                End If
            Else
                oSQLParam = objDB.ExecSPReturnParam("TXNUpdate",
                    objDB.MP("@VALUEDATE", Data.SqlDbType.DateTime, dValueDate),
                    objDB.MP("@BCID", Data.SqlDbType.Int, iBCID),
                    objDB.MP("@LOCID", Data.SqlDbType.Int, iLOCID), _
                    objDB.MP("@ACCID", Data.SqlDbType.BigInt, iACCID), _
                    objDB.MP("@REFNO", Data.SqlDbType.VarChar, sRefNo), _
                    objDB.MP("@ACCOUNTID", Data.SqlDbType.Int, iAccountID), _
                    objDB.MP("@REMARK", Data.SqlDbType.VarChar, sRemark), _
                    objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value), _
                    objDB.MP("@LOCIDTXN", Data.SqlDbType.Int, hidLOCIDTXN.Value), _
                    objDB.MP("@TXNID", Data.SqlDbType.BigInt, hidTXNID.Value), _
                    objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 10, Data.ParameterDirection.Output), _
                    objDB.MP("@ACCOUNTIDTO", Data.SqlDbType.Int, iAccountIDTo), _
                    objDB.MP("@CURRENCYID", Data.SqlDbType.Int, ddlCurrency.SelectedValue), _
                    objDB.MP("@FINCATID", Data.SqlDbType.Int, ddlFinCatEntry.SelectedValue)
                   )
                intRetVal = oSQLParam("@RETVAL").Value.ToString()
            End If

            If intRetVal = -1 Then
                lblMessage.Visible = True
                lblMessage.Text = "TRANSACTION ALREADY INPUT..!"
            Else
                lblMessage.Text = ""
                lblMessage.Visible = False
                SaveTXNJOURNAL(iLOCIDTXN, iTXNID)
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = lblMessage.Text & " " & ex.Message
        Finally
            objDB = Nothing
        End Try
    End Sub

    Private Sub SaveTXNJOURNAL(ByVal iLOCIDTXN As Integer, ByVal iTXNID As Integer)
        Dim objDB As New DBX
        Dim iRow As Integer
        Dim iRows As Integer
        Dim mAmount As Double
        Dim sDRCR As String
        Dim intRetVal As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try
            If chkAddNew.Checked = True Then
                iRows = gvJournal.Rows.Count - 1
                For iRow = 0 To iRows
                    If CType(gvJournal.Rows(iRow).FindControl("txtAmountDebet"), TextBox).Text <> 0.0 Then
                        mAmount = NoComma(CType(gvJournal.Rows(iRow).FindControl("txtAmountDebet"), TextBox).Text)
                        sDRCR = "D"
                    Else
                        mAmount = NoComma(CType(gvJournal.Rows(iRow).FindControl("txtAmountKredit"), TextBox).Text)
                        sDRCR = "C"
                    End If
                    oSQLParam = objDB.ExecSPReturnParam("TXNJOURNALAdd",
                                objDB.MP("@LOCIDTXN", Data.SqlDbType.Int, iLOCIDTXN),
                                objDB.MP("@TXNID", Data.SqlDbType.BigInt, iTXNID),
                                objDB.MP("@COAID", Data.SqlDbType.BigInt, CType(gvJournal.Rows(iRow).FindControl("lblCoaID"), Label).Text),
                                objDB.MP("@DRCR", Data.SqlDbType.Char, sDRCR),
                                objDB.MP("@AMOUNT", Data.SqlDbType.Money, mAmount),
                                objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value),
                                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 10, Data.ParameterDirection.Output)
                                )
                    intRetVal = oSQLParam("@RETVAL").Value.ToString()
                Next
                If intRetVal = -1 Then
                    lblMessage.Visible = True
                    lblMessage.Text = "TXN JOURNAL ALREADY INPUT..!"
                Else
                    MVTxn.SetActiveView(vSearch)
                End If
            Else
                iRows = gvJournal.Rows.Count - 1
                For iRow = 0 To iRows
                    If CType(gvJournal.Rows(iRow).FindControl("txtAmountDebet"), TextBox).Text <> 0.0 Then
                        mAmount = NoComma(CType(gvJournal.Rows(iRow).FindControl("txtAmountDebet"), TextBox).Text)
                        sDRCR = "D"
                    Else
                        mAmount = NoComma(CType(gvJournal.Rows(iRow).FindControl("txtAmountKredit"), TextBox).Text)
                        sDRCR = "C"
                    End If
                    oSQLParam = objDB.ExecSPReturnParam("TXNJOURNALUpdate",
                                objDB.MP("@LOCIDTXN", Data.SqlDbType.Int, hidLOCIDTXN.Value),
                                objDB.MP("@TXNID", Data.SqlDbType.BigInt, hidTXNID.Value),
                                objDB.MP("@TXNJOURNALID", Data.SqlDbType.Int, CType(gvJournal.Rows(iRow).FindControl("lblTxnJournalID"), Label).Text),
                                objDB.MP("@DRCR", Data.SqlDbType.Char, sDRCR),
                                objDB.MP("@AMOUNT", Data.SqlDbType.Money, mAmount),
                                objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value),
                                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 10, Data.ParameterDirection.Output)
                                )
                    intRetVal = oSQLParam("@RETVAL").Value.ToString()
                Next
                If intRetVal = -1 Then
                    lblMessage.Visible = True
                    lblMessage.Text = "TXN JOURNAL NOT ALREADY INPUT..!"
                Else
                    MVTxn.SetActiveView(vSearch)
                End If
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = lblMessage.Text & " " & ex.Message
        Finally
            objDB = Nothing
        End Try
    End Sub

    Private Function NoComma(ByVal theValue As String) As String
        NoComma = Replace(theValue, ",", "")
    End Function

    Private Sub BindDataJournal()
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            If chkAddNew.Checked = True Then
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT 0 LOCIDTXN, 0 TXNID, 0 AS TXNJOURNALID,COA.COAID,  BOOKJOURNAL.DRCR, '(' + COA.COANO + ') ' + COA.COANAME AS COANO, " & _
                        " 0 AS DEBET, " & _
                        " 0 AS KREDIT" & _
                        " FROM BOOKJOURNAL INNER JOIN COA ON BOOKJOURNAL.COAID = COA.COAID WHERE (BOOKJOURNAL.BCID = " & ddlBookCode.SelectedValue & " ) AND (COA.DELETESTS = 0) ORDER BY BOOKJOURNAL.DRCR DESC")
            Else
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT LOCIDTXN, TXNID, TXNJOURNALID,COA.COAID,DRCR,'(' + COA.COANO + ') ' + COA.COANAME AS COANO, " & _
                        " CASE WHEN DRCR = 'C' THEN 0 ELSE AMOUNT END AS DEBET, " & _
                        " CASE WHEN DRCR = 'D' THEN 0 ELSE AMOUNT END AS KREDIT " & _
                        " FROM TXNJOURNAL WITH(NOLOCK) INNER JOIN COA WITH(NOLOCK) ON COA.COAID=TXNJOURNAL.COAID WHERE (LOCIDTXN = " & hidLOCIDTXN.Value & " ) AND (TXNID = " & hidTXNID.Value & ") ORDER BY DRCR DESC")
            End If

            If oSDR.HasRows Then

                Dim dtJournal As New System.Data.DataTable
                dtJournal.Load(oSDR)
                oSDR.Close()
                oSDR = Nothing

                If ViewState("VW_JOURNAL") IsNot Nothing Then
                    ViewState("VW_JOURNAL") = Nothing
                End If
                ViewState("VW_JOURNAL") = dtJournal
                gvJournal.DataSource = dtJournal
                gvJournal.DataBind()
            Else
                gvJournal.DataSource = Nothing
                gvJournal.DataBind()
            End If
            pnlControl.Visible = True
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RETRIVE DATA (JOURNAL TRANSACTION) ENTRY: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
        lblMessage.Visible = False

    End Sub
    

    Protected Sub gvData_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        If e.CommandName = "Select" Then
            MVTxn.SetActiveView(vEntry)
            lblMessage.Visible = False
            lblMessage.Text = ""
            gvData.SelectedIndex = e.CommandArgument
            GetData(gvData.SelectedDataKey("LOCIDTXN"), gvData.SelectedDataKey("TXNID"))
            hidTXNID.Value = gvData.SelectedDataKey("TXNID")
            hidLOCIDTXN.Value = gvData.SelectedDataKey("LOCIDTXN")
            ddlBookCode.Enabled = False
            hidAction.Value = "EDIT"
            SetValidation()
            'ddlFinanceCategory.Attributes.Add("onchange", "FinCatChange();")

        End If
    End Sub

    Private Sub GetData(ByVal iLocidTXN As Integer, ByVal iTxnID As Integer)
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim oSDRAcc As System.Data.SqlClient.SqlDataReader
        Try

            oSDR = objDB.CreateSDRFromSQLSelect("SELECT * FROM TXN WITH(NOLOCK) WHERE LOCIDTXN= " & iLocidTXN & " AND TXNID=" & iTxnID)
            If oSDR.Read Then
                txtValueDate.Text = String.Format("{0:dd/MM/yyyy}", oSDR("VALUEDATE"))
                ddlBookCode.SelectedValue = oSDR("BCID").ToString()
                'ddlAccountNo.SelectedValue = oSDR("ACCOUNTID").ToString()
                'ddlAccountTo.SelectedValue = oSDR("ACCOUNTIDTO").ToString()
                ajaxCCDBankFrom.SelectedValue = oSDR("ACCOUNTID").ToString()
                ajaxCCDBankTo.SelectedValue = oSDR("ACCOUNTIDTO").ToString()
                ajaxCCDFinCatEntry.SelectedValue = oSDR("FINCATID").ToString()
                ddlCurrency.SelectedValue = oSDR("CURRENCYID").ToString()
                hidLOCID.Value = oSDR("LOCID").ToString()
                hidACCID.Value = oSDR("ACCID").ToString()
                txtRefNo.Text = oSDR("REFNO").ToString()
                txtRemark.Text = oSDR("REMARK").ToString()

                ajaxCCDBankFrom.ContextKey = txtUID.Value & "," & oSDR("FINCATID").ToString()
                ajaxCCDBankTo.ContextKey = txtUID.Value & "," & oSDR("FINCATID").ToString()

                hidLOCIDTXN.Value = iLocidTXN
                hidTXNID.Value = iTxnID
                If hidLOCID.Value <> "" And hidACCID.Value <> "" Then
                    oSDRAcc = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_FormatAccNoByID(ACCOUNT.BRANCHID, ACCOUNT.ACCOUNTNO) AS ACCNOFORMAT,ACCOUNT.ACCOUNTNAME FROM ACCOUNT WHERE LOCID= " & hidLOCID.Value & " AND ACCID=" & hidACCID.Value)
                    If oSDRAcc.Read Then
                        txtAccNo_R_.Text = oSDRAcc("ACCNOFORMAT").ToString()
                        txtAccName_R_.Text = oSDRAcc("ACCOUNTNAME").ToString()
                    End If
                    oSDRAcc.Close()
                    oSDRAcc = Nothing
                End If
                BindDataJournal()
            End If
            oSDR.Close()
            oSDR = Nothing


        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = lblMessage.Text & " " & ex.Message
        Finally
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnBack_Click(sender As Object, e As System.EventArgs) Handles btnBack.Click
        MVTxn.SetActiveView(vSearch)
        chkAddNew.Checked = False
        hidLOCID.Value = ""
        hidACCID.Value = ""
        lblMessage.Visible = False
    End Sub
End Class
