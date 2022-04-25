
Partial Class Unknown_UnknownReceive
    Inherits System.Web.UI.Page
    Public Shared strAppDate As String

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            Dim objDB As New DBX
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            Try
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE, CAST(dbo.f_IsUserBranch(" & Request.Cookies("UID").Value & ") as VARCHAR(10)) ISUSERBRANCH, dbo.f_getDefaultCurrency() CURRENCYIDEF FROM APPSETTING WITH(NOLOCK) WHERE APPCODE='APPDATE'")
                If oSDR.Read Then
                    strAppDate = oSDR("APPVALUE").ToString()
                    ddlCurrency.SelectedValue = oSDR("CURRENCYIDEF").ToString()
                    hidIsUserBranch.Value = oSDR("ISUSERBRANCH").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing
                SetObjectValidation(txtDateStart, True, "date", "[0-9/]")
                SetObjectValidation(txtDateEnd, True, "date", "[0-9/]")
                SetObjectValidation(txtDateReceive, True, "date", "[0-9/]")
                SetValidation()
                DataGrid()
                txtDateStart.Text = strAppDate
                txtDateEnd.Text = strAppDate
                HideAllPanel(False)
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
                lblMessage.Text = "ERROR LOADING ASSET PLEDGE ENTRY..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE : <BR>" & ex.Message
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        End If
    End Sub

    Protected Sub Page_PreInit(sender As Object, e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnNew_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        HideAllPanel(True)
        hidAction.Value = "NEW"
        chkAdd.Checked = True
        lblMessage.Visible = False
        ClearPanelAplicationField(pnlUnknownData)
        gvData.SelectedIndex = -1
        btnDelete.Visible = False
        btnSave.Text = "Save"
        imgDateReceive.Visible = True
        txtDateReceive.Text = strAppDate
        FlagEdit("required", False, True)
    End Sub

    Private Sub DataGrid()
        If Not IsPostBack Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand + " AND PAYUNKNOWN.LOCIDUN=0 AND PAYUNKNOWN.UNKNOWNID = 0"
        End If

        If Len(Trim(ddlCriteria.SelectedValue)) > 0 And txtSearch.Text <> "" Then
            If ddlCriteria.SelectedValue = "REFNO" Then
                If IsNumeric(txtSearch.Text) Then
                    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " = " + txtSearch.Text
                End If
            ElseIf ddlCriteria.SelectedValue = "BANKNAME" Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
            End If

        ElseIf txtSearch.Text = "" Or txtSearch.Text = "%%" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
        End If

        If rdbFromUnknownDate.Checked Then
            If Len(Trim(txtDateStart.Text)) > 0 And Len(Trim(txtDateEnd.Text)) > 0 Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (PAYUNKNOWN.TXNDATE BETWEEN CONVERT(DATETIME, '" + txtDateStart.Text + "', 103) AND CONVERT(DATETIME, '" + txtDateEnd.Text + "', 103))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (PAYUNKNOWN.TXNDATE BETWEEN CONVERT(DATETIME, '" + strAppDate + "', 103) AND CONVERT(DATETIME, '" + strAppDate + "', 103))"
            End If
        End If

        If Len(Trim(ddlAreaSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCH.AREAID=" & ddlAreaSearch.SelectedValue
        End If
        If Len(Trim(ddlBranchSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCH.BRANCHID=" & ddlBranchSearch.SelectedValue
        End If

        gvData.DataBind()
    End Sub

    Private Sub SetValidation()
        'SetObjectValidation(txtRefNo, False, "integer", "[0-9]")
        txtRefNo.Focus()
        lblTransDate.Text = strAppDate
        SetObjectValidation(txtAmount, False, "float", "[0-9]")
    End Sub

    Private Sub HideAllPanel(ByVal bValue As Boolean)
        pnlUnknownData.Visible = bValue
        pnlControl.Visible = bValue
    End Sub

    Protected Sub gvData_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument).ToString
        lblMessage.Visible = False
        Dim sLocid As String
        If e.CommandName = "Select" Then
            HideAllPanel(True)
            sLocid = CType(gvData.Rows(currentRowIndex).FindControl("lblKeyLocid"), Label).Text
            hidAction.Value = "EDIT"
            chkAdd.Checked = False
            btnSave.Text = "Update"
            HideAllPanel(True)
            ajaxCCDBankAcc.ContextKey = Request.Cookies("UID").Value & ","
            GetData(sLocid, gvData.DataKeys(currentRowIndex).Value)
            btnDelete.Visible = True
        End If

    End Sub
    Private Sub GetData(ByVal strKey As String, ByVal strUnknownID As String)
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT  * " & _
                 "  FROM dbo.PAYUNKNOWN WITH(NOLOCK) WHERE LOCIDUN=" & strKey & " AND UNKNOWNID=" & strUnknownID)
            If oSDR.Read Then
                Dim oSDRParam As System.Data.SqlClient.SqlDataReader
                lbllocidUn.Text = oSDR("LOCIDUN")
                lblUnknownId.Text = oSDR("UNKNOWNID")
                lblTransDate.Text = String.Format("{0:dd/MM/yyyy}", oSDR("TXNDATE"))
                txtDateReceive.Text = String.Format("{0:dd/MM/yyyy}", oSDR("VALUEDATE"))
                If Not String.IsNullOrEmpty(oSDR("ACCOUNTID").ToString()) Then
                    oSDRParam = objDB.CreateSDRFromSQLSelect("SELECT ACCOUNTID FROM BANKACCOUNT WHERE ACCOUNTID= " & oSDR("ACCOUNTID") & " AND DELETESTS=0")
                    If oSDRParam.Read() Then
                        'ddlAccountNo.SelectedValue = oSDRParam("ACCOUNTID")
                        ajaxCCDBankAcc.SelectedValue = oSDRParam("ACCOUNTID")
                    End If
                    oSDRParam.Close()
                    oSDRParam = Nothing
                End If
                txtRefNo.Text = oSDR("REFNO")
                txtAmount.Text = String.Format("{0:N}", oSDR("AMOUNT"))
                If Not String.IsNullOrEmpty(oSDR("REMARK").ToString()) Then
                    txtDescription.Text = oSDR("REMARK")
                Else
                    txtDescription.Text = ""
                End If
                ddlCurrency.SelectedValue = oSDR("CURRENCYID").ToString
            Else
                lblMessage.Visible = True
                lblMessage.Text = "UNKNOWN PAYMENT DATA " & strKey & " NOT ALREADY EXIST..!"
            End If
            SetValidation()
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR UNKNOWN PAYMENT DATA: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Private Sub FlagEdit(ByVal sCSS As String, ByVal sRead As Boolean, ByVal sEnable As Boolean)
        txtDateReceive.CssClass = sCSS
        ddlAccountNo.CssClass = sCSS
        txtAmount.CssClass = sCSS
        txtDateReceive.ReadOnly = sRead
        txtAmount.ReadOnly = sRead
        ddlAccountNo.Enabled = sEnable
    End Sub
    Private Function NoComma(ByVal strValue As String) As String
        NoComma = Replace(strValue, ",", "")
    End Function

    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        If chkAdd.Checked Then
            SaveData(ConvertDate(txtDateReceive.Text), ddlAccountNo.SelectedValue, NoComma(txtAmount.Text), _
                    txtRefNo.Text.Trim, txtDescription.Text.Trim, Request.Cookies("UID").Value)
        Else
            EditData(lbllocidUn.Text, lblUnknownId.Text, ConvertDate(txtDateReceive.Text), txtRefNo.Text.Trim, ddlAccountNo.SelectedValue, NoComma(txtAmount.Text), _
                    txtDescription.Text.Trim, Request.Cookies("UID").Value)
        End If
        HideAllPanel(False)

    End Sub

    Private Sub SaveData(ByVal dtValueDt As String, _
        ByVal intAccountid As String, _
        ByVal monAmount As String, _
        ByVal strReffno As String, _
        ByVal strRemark As String, _
        ByVal intUSERID As Integer)
        Dim objDB As New DBX
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try
            oSQLParam = objDB.ExecSPReturnParam("PAYUNKNOWNAdd", _
                     objDB.MP("@VALUEDATE", Data.SqlDbType.DateTime, dtValueDt), _
                     objDB.MP("@ACCOUNTID", Data.SqlDbType.Int, intAccountid), _
                     objDB.MP("@REFNO", Data.SqlDbType.VarChar, strReffno), _
                     objDB.MP("@AMOUNT", Data.SqlDbType.Money, monAmount), _
                     objDB.MP("@REMARK", Data.SqlDbType.VarChar, strRemark), _
                     objDB.MP("@CURRENCYID", Data.SqlDbType.Int, ddlCurrency.SelectedValue), _
                     objDB.MP("@USERID", Data.SqlDbType.BigInt, intUSERID) _
                     )
            chkAdd.Checked = False
            hidAction.Value = "SAVE"
            DataGrid()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE DATA PAYMENT UNKNOWN : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Private Sub EditData(ByVal intLOCIDUN As String, _
                         ByVal intUNKNOWNID As String, _
                         ByVal dtValueDt As String, _
                         ByVal intReffNo As String, _
                         ByVal intAccountid As String, _
                         ByVal monAmount As String, _
                         ByVal strRemark As String, _
                         ByVal intUSERID As Integer)
        Dim objDB As New DBX
        Dim intRetVal As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try
            oSQLParam = objDB.ExecSPReturnParam("PAYUNKNOWNUpdate", _
                     objDB.MP("@LOCIDUN", Data.SqlDbType.Int, intLOCIDUN), _
                     objDB.MP("@UNKNOWNID", Data.SqlDbType.BigInt, intUNKNOWNID), _
                     objDB.MP("@VALUEDATE", Data.SqlDbType.DateTime, dtValueDt), _
                     objDB.MP("@REFNO", Data.SqlDbType.VarChar, intReffNo), _
                     objDB.MP("@ACCOUNTID", Data.SqlDbType.Int, intAccountid), _
                     objDB.MP("@AMOUNT", Data.SqlDbType.Money, monAmount), _
                     objDB.MP("@REMARK", Data.SqlDbType.VarChar, strRemark), _
                     objDB.MP("@USERID", Data.SqlDbType.BigInt, intUSERID), _
                     objDB.MP("@CURRENCYID", Data.SqlDbType.Int, ddlCurrency.SelectedValue), _
                     objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 10, Data.ParameterDirection.Output) _
                     )
            intRetVal = oSQLParam("@RETVAL").Value.ToString()
            If intRetVal = -1 Then
                lblMessage.Visible = True
                lblMessage.Text = "UNKNOWN PAYMENT ALREADY ALOCATED..!<BR>PLEASE CHECK IN UNKNOWN INQURY."
            Else
                lblMessage.Text = ""
                lblMessage.Visible = False
                hidAction.Value = "EDIT"
            End If
            chkAdd.Checked = False
            DataGrid()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE DATA PAYMENT UNKNOWN : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnDelete_Click(sender As Object, e As System.EventArgs) Handles btnDelete.Click
        Dim objDB As New DBX
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Dim intRetVal As Integer
        Try

            oSQLParam = objDB.ExecSPReturnParam("PAYUNKNOWNDelete", _
                   objDB.MP("@LOCIDUN", Data.SqlDbType.Int, lbllocidUn.Text), _
                   objDB.MP("@UNKNOWNID", Data.SqlDbType.BigInt, lblUnknownId.Text), _
                   objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 10, Data.ParameterDirection.Output))
            intRetVal = oSQLParam("@RETVAL").Value.ToString()
            If intRetVal = -1 Then
                lblMessage.Visible = True
                lblMessage.Text = "UKNOWN PAYMENT ALREADY ALLOCATED, CAN NOT BE DELETED..!<BR>PLEASE CHECK IN UNKNOWN INQUIRY."
            Else
                DataGrid()
                lblMessage.Text = ""
                lblMessage.Visible = False
                hidAction.Value = "EDIT"
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE DATA UKNOWN PAYMENT : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As System.EventArgs) Handles btnCancel.Click
        HideAllPanel(False)
    End Sub

    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataGrid()
    End Sub

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataGrid()
    End Sub

    Protected Sub btnFunction_Click(sender As Object, e As System.EventArgs) Handles btnFunction.Click
        DataGrid()
    End Sub
End Class
