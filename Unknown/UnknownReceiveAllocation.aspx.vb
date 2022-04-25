
Partial Class Unknown_UnknownReceiveAllocation
    Inherits System.Web.UI.Page
    Public Shared strAppDate As String
    Private TotalAllocation As Decimal = 0.0
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
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

            Catch ex As Exception
                lblMessage.Visible = True
                lblMessage.Text = "ERROR LOADING ASSET PLEDGE ENTRY..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE : <BR>" & ex.Message
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
            txtDateStart.Text = strAppDate
            txtDateEnd.Text = strAppDate
            MultiView_Utama.SetActiveView(View_View)
            DataGrid()
        End If
        SetObjectValidation(txtDateStart, True, "date", "[0-9/]")
        SetObjectValidation(txtDateEnd, True, "date", "[0-9/]")

    End Sub

    Protected Sub Page_PreInit(sender As Object, e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Private Sub DataGrid()
        If Not IsPostBack Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand + " AND PAYUNKNOWN.LOCIDUN=0 AND PAYUNKNOWN.UNKNOWNID = 0"
        End If

        If Len(Trim(ddlCriteria.SelectedValue)) > 0 And txtSearch.Text <> "" Then
            If ddlCriteria.SelectedValue = "REFNO" Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
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
    Protected Sub btnView_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument).ToString
        lblMessage.Visible = False
        Try

            hidLocidUN.Value = CType(gvData.Rows(currentRowIndex).FindControl("lblKeyLocid"), Label).Text
            hidIDUnReceive.Value = gvData.DataKeys(currentRowIndex).Value
            MultiView_Utama.SetActiveView(View_Receive)
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR UNKNOWN PAYMENT ALLOCATION: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        End Try
    End Sub

    Protected Sub btnNew_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        pnlUnknownData.Visible = True
        pnlControl.Visible = True
        chkAdd.Checked = True
        setValidation()
        lblAllocateID.Text = ""
        hidAction.Value = "NEW"
        ValidationEdit("required", True, False, False)
        Validation.ClearPanelAplicationField(pnlUnknownData)
        btnSave.Visible = True
        btnDelete.Visible = False
    End Sub

    Protected Sub btnBack_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnBack.Click
        MultiView_Utama.SetActiveView(View_View)
        pnlUnknownData.Visible = False
        pnlControl.Visible = False
        DataGrid()
    End Sub
    Private Sub setValidation()
        SetObjectValidation(txtAmountAllocate, False, "float", "[0-9]")
    End Sub
    Protected Sub gvAllocation_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvAllocation.RowCommand
        lblMessage.Visible = False
        If e.CommandName = "Select" Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            hidAction.Value = "EDIT"
            Dim UNKNOWNID As Integer = Convert.ToInt32(gvAllocation.DataKeys(index).Values("UNKNOWNID"))
            Dim ALLOCATEID As Integer = Convert.ToInt32(gvAllocation.DataKeys(index).Values("ALLOCATEID"))
            pnlUnknownData.Visible = True
            pnlControl.Visible = True
            GetData(hidLocidUN.Value, UNKNOWNID, ALLOCATEID)
        End If
    End Sub

    Private Sub GetData(ByVal sLocid As String, ByVal strUnknownID As String, ByVal sAllocatedID As String)
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT PAYUNKNOWNALLOCATE.ALLOCATEID,PAYUNKNOWNALLOCATE.LOCID,PAYUNKNOWNALLOCATE.LOCIDUN,PAYUNKNOWNALLOCATE.POSTINGSTS, PAYUNKNOWNALLOCATE.ACCID,dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCNO,ACCOUNT.ACCOUNTNAME, " & _
                                                " PAYUNKNOWNALLOCATE.AMOUNTALLOCATE,PAYUNKNOWNALLOCATE.BTID " & _
                                                " FROM dbo.PAYUNKNOWNALLOCATE WITH(NOLOCK)  " & _
                                                " INNER JOIN dbo.ACCOUNT WITH(NOLOCK) ON PAYUNKNOWNALLOCATE.LOCID=ACCOUNT.LOCID AND PAYUNKNOWNALLOCATE.ACCID=ACCOUNT.ACCID " & _
                                                " INNER JOIN BRANCH  WITH (NOLOCK) ON   BRANCH.BRANCHID = ACCOUNT.BRANCHID " & _
                                                " WHERE PAYUNKNOWNALLOCATE.LOCIDUN=" & sLocid & " AND PAYUNKNOWNALLOCATE.UNKNOWNID=" & strUnknownID & " AND PAYUNKNOWNALLOCATE.ALLOCATEID=" & sAllocatedID)
            If oSDR.Read Then
                Dim oSDRParam As System.Data.SqlClient.SqlDataReader
                lblAllocateID.Text = oSDR("ALLOCATEID")
                hidAccID.Value = oSDR("ACCID")
                hidLocID.Value = oSDR("LOCID")
                hidLocidUN.Value = oSDR("LOCIDUN")
                txtAccountID.Text = "(" + oSDR("ACCNO") + ") " + oSDR("ACCOUNTNAME")
                txtAmountAllocate.Text = String.Format("{0:N}", oSDR("AMOUNTALLOCATE"))
                If Not String.IsNullOrEmpty(oSDR("BTID").ToString()) Then
                    oSDRParam = objDB.CreateSDRFromSQLSelect("SELECT BTID FROM BOOKTYPE WHERE BTID= " & oSDR("BTID"))
                    If oSDRParam.Read() Then
                        ddlFunctionType.SelectedValue = oSDRParam("BTID")
                    End If
                    oSDRParam.Close()
                    oSDRParam = Nothing
                End If
                hidAction.Value = "EDIT"
                btnSave.Visible = False
                btnDelete.Visible = True
                ValidationEdit("disabled", False, True, True)
                If oSDR("POSTINGSTS") = "1" Then
                    btnDelete.Visible = False
                Else
                    btnDelete.Visible = True
                End If
            Else
                lblMessage.Visible = True
                lblMessage.Text = "UNKNOWN PAYMENT DATA " & sAllocatedID & " NOT ALREADY EXIST..!"
            End If
            setValidation()
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

    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        If chkAdd.Checked Then
            SaveData(hidLocidUN.Value, hidIDUnReceive.Value, hidLocID.Value, _
                    hidAccID.Value, NoComma(txtAmountAllocate.Text), ddlFunctionType.SelectedValue, Request.Cookies("UID").Value)
        End If
    End Sub

    Private Function NoComma(ByVal strValue As String) As String
        NoComma = Replace(strValue, ",", "")
    End Function

    Private Sub SaveData(ByVal intLOCIDUN As String, _
     ByVal IntUNKNOWNID As String, _
     ByVal IntLOCID As String, _
     ByVal IntACCID As String, _
     ByVal MonAMOUNTALLOCATE As String, _
     ByVal IntBTID As Integer, _
     ByVal intUSERID As Integer)
        Dim objDB As New DBX
        Dim intRetVal As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try
            oSQLParam = objDB.ExecSPReturnParam("PAYUNKNOWNALLOCATEAdd", _
                     objDB.MP("@LOCIDUN", Data.SqlDbType.Int, intLOCIDUN), _
                     objDB.MP("@UNKNOWNID", Data.SqlDbType.BigInt, IntUNKNOWNID), _
                     objDB.MP("@LOCID", Data.SqlDbType.Int, IntLOCID), _
                     objDB.MP("@ACCID", Data.SqlDbType.BigInt, IntACCID), _
                     objDB.MP("@AMOUNTALLOCATE", Data.SqlDbType.Money, MonAMOUNTALLOCATE), _
                     objDB.MP("@BTID", Data.SqlDbType.Int, IntBTID), _
                     objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                     objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 10, Data.ParameterDirection.Output) _
                     )
            intRetVal = oSQLParam("@RETVAL").Value
            If intRetVal = -2 Then
                txtAccountID.Text = hidAccountNm.Value
                lblMessageDtl.Visible = True
                lblMessageDtl.Text = "AMOUNT HAS ALLOCATED TO THIS ACCOUNT NUMBER..!<BR>PLEASE CHECK ACCOUNT NO TO BE ALLOCATED."
            ElseIf intRetVal = -1 Then
                txtAccountID.Text = hidAccountNm.Value
                lblMessageDtl.Visible = True
                lblMessageDtl.Text = "AMOUNT ALLOCATED IS EXCEED THAN AMOUNT RECEIVED..!"

            Else
                lblMessageDtl.Text = ""
                lblMessageDtl.Visible = False
                chkAdd.Checked = False
                hidAction.Value = "SAVE"
                gvAllocation.DataBind()
                pnlUnknownData.Visible = False
                pnlControl.Visible = False
            End If

        Catch ex As Exception
            lblMessageDtl.Visible = True
            lblMessageDtl.Text = "ERROR SAVE DATA PAYMENT UNKNOWN : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Private Sub DataGridAllocation()
        sdsAllocation.SelectCommand = sdsAllocation.SelectCommand
        gvAllocation.DataBind()
    End Sub

    Protected Sub btnDelete_Click(sender As Object, e As System.EventArgs) Handles btnDelete.Click
        Dim objDB As New DBX
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Dim intRetVal As Integer
        Try

            oSQLParam = objDB.ExecSPReturnParam("PAYUNKNOWNALLOCATEDelete", _
                   objDB.MP("@LOCIDUN", Data.SqlDbType.BigInt, hidLocidUN.Value, 10), _
                   objDB.MP("@UNKNOWNID", Data.SqlDbType.Int, hidIDUnReceive.Value, 10), _
                   objDB.MP("@ALLOCATEID", Data.SqlDbType.Int, lblAllocateID.Text, 10), _
                   objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 10), _
                   objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 10, Data.ParameterDirection.Output))
            intRetVal = oSQLParam("@RETVAL").Value.ToString()
            If intRetVal = -1 Then
                lblMessageDtl.Visible = True
                lblMessageDtl.Text = "UNKOWN PAYMENT ALREADY ALLOCATED, CANNOT BE DELETED...!"
            Else
                lblMessageDtl.Text = ""
                lblMessageDtl.Visible = False
                hidAction.Value = "EDIT"
                gvAllocation.DataBind()
                pnlUnknownData.Visible = False
                pnlControl.Visible = False
            End If
        Catch ex As Exception
            lblMessageDtl.Visible = True
            lblMessageDtl.Text = "ERROR DELETE DATA UKNOWN PAYMENT: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub gvAllocation_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvAllocation.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            TotalAllocation += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "AMOUNTALLOCATE"))
        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(6).Text = String.Format("{0:n}", TotalAllocation)
        End If
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As System.EventArgs) Handles btnCancel.Click
        pnlUnknownData.Visible = False
        chkAdd.Checked = False
        pnlControl.Visible = False
    End Sub

    Private Sub ValidationEdit(ByVal sCssClass As String, ByVal sEnabled As Boolean, ByVal sRead As Boolean, ByVal sBold As Boolean)
        ddlFunctionType.CssClass = sCssClass
        txtAmountAllocate.CssClass = sCssClass
        ddlFunctionType.Enabled = sEnabled
        'btnSearch.Enabled = sEnabled
        btnSearch.Visible = sEnabled
        txtAmountAllocate.ReadOnly = sRead

        txtAccountID.Font.Bold = sBold
        txtAmountAllocate.Font.Bold = sBold
        ddlFunctionType.Font.Bold = sBold
    End Sub

    Protected Sub btnFunction_Click(sender As Object, e As System.EventArgs) Handles btnFunction.Click
        DataGrid()
    End Sub

    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataGrid()
    End Sub

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataGrid()
    End Sub
End Class
