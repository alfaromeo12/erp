Imports System.Data
Imports System.Data.SqlClient
Partial Class Param_InsCustPricing
    Inherits System.Web.UI.Page
    Private dt As New DataTable
    Private dr As DataRow
    Private iError As Integer
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            MultiView_Utama.SetActiveView(View_View)
        End If
        SetFormValidation()
    End Sub
    Protected Sub Page_PreInit(sender As Object, e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
    End Sub

    Private Sub DataSearch()
        If Not IsPostBack Then
            sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND INSPRICING.INSPRICINGID= -1"
        End If
        If ddlCriteria.SelectedItem.Text = "Product Code" Or ddlCriteria.SelectedItem.Text = "Product Name" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + "(EXISTS(SELECT 'X' FROM PRODUCT WHERE (PRODUCTID = INSPRICING.PRODUCTID AND " + ddlCriteria.SelectedValue + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%')))"
        ElseIf ddlCriteria.SelectedItem.Text = "Branch" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedValue + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
        ElseIf ddlCriteria.SelectedItem.Text = "Purpose Name" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + "(EXISTS(SELECT 'X' FROM OBJECTPURPOSE WHERE (PURPOSEID = INSPRICING.PURPOSEID AND " + ddlCriteria.SelectedValue + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%')))"
        ElseIf ddlCriteria.SelectedItem.Text = "Insurance Type" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + "(EXISTS(SELECT 'X' FROM PARAMGLOBAL WHERE (TYPE='INSURANCETYPE') AND (CODE = INSPRICING.INSURANCETYPE  AND " + ddlCriteria.SelectedValue + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%')))"
        Else
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
        End If
        If Len(Trim(ddlSearchBranch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND INSPRICINGBRANCH.BRANCHID=" & ddlSearchBranch.SelectedValue
        End If

        'Response.Write("A" & ddlProduct.SelectedValue)

        If Len(Trim(ddlSearchProduct.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND INSPRICING.PRODUCTID=" & ddlSearchProduct.SelectedValue
        End If

        If Len(Trim(ddlSearchCategory.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND INSPRICING.CATEGORYID=" & ddlSearchCategory.SelectedValue
        End If




        If Len(Trim(ddlSearchPurpose.SelectedValue)) > 0 Then
            If ddlSearchPurpose.SelectedValue.ToString() = "-1" Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND INSPRICING.PURPOSEID IS NULL"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND INSPRICING.PURPOSEID=" & ddlSearchPurpose.SelectedValue
            End If
        End If
        gvData.DataBind()


    End Sub
    Private Sub SetFormValidation()
        'txtSumAssuredFrom.Text = "0"
        'txtSumAssuredTo.Text = "0"
        SetObjectValidation(txtSumAssuredFrom, False, "float", "[0-9]")
        SetObjectValidation(txtSumAssuredTo, False, "float", "[0-9]")
    End Sub
    Protected Sub btnEdit_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        Dim currentCommand As String = e.CommandName
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument)
        lblCaption.Text = "Edit Data"
        gvData.SelectedIndex = e.CommandArgument
        hidInsPricingID.Value = gvData.SelectedDataKey("INSPRICINGID")
        'ddlBranch.SelectedValue = CType(gvData.Rows(currentRowIndex).FindControl("lblBranchID"), Label).Text
        chkAddNew.Checked = False
        hidAction.Value = "EDIT"
        MultiView_Utama.SetActiveView(View_Form)
        SetFormValidation()
        GetData(hidInsPricingID.Value)
        pnlControl.Visible = True
        btnDelete.Visible = True
        lvbBranchSrc.DataBind()
        lvbBranchDst.DataBind()
    End Sub
   
    Private Sub GetData(ByVal strKey As String)
        Dim objDB As New DBX
        Try

            Dim oSDR As System.Data.SqlClient.SqlDataReader

            oSDR = objDB.CreateSDRFromSQLSelect("SELECT  * " & _
              "  FROM dbo.INSPRICING WITH(NOLOCK) WHERE INSPRICINGID=" & strKey)
            If oSDR.Read Then
                lblInspricingID.Text = oSDR("INSPRICINGID")
                If Not String.IsNullOrEmpty(oSDR("PRODUCTID").ToString()) Then
                    ajaxCCDProduct.SelectedValue = oSDR("PRODUCTID").ToString()
                Else
                    ajaxCCDProduct.SelectedValue = 0
                End If
                If Not String.IsNullOrEmpty(oSDR("CATEGORYID").ToString()) Then
                    ajaxCDDCategoryType.SelectedValue = oSDR("CATEGORYID").ToString()
                Else
                    ajaxCDDCategoryType.SelectedValue = 0
                End If
                If Not String.IsNullOrEmpty(oSDR("PURPOSEID").ToString()) Then
                    ajaxCDDPurpose.SelectedValue = oSDR("PURPOSEID").ToString()
                Else
                    ajaxCDDPurpose.SelectedValue = IsDBNull(oSDR("PURPOSEID").ToString)
                End If
                If Not String.IsNullOrEmpty(oSDR("INSURANCETYPE").ToString()) Then
                    ddlInsType.SelectedValue = oSDR("INSURANCETYPE").ToString()
                Else
                    ddlInsType.SelectedValue = 0
                End If
                ddlInsType.Enabled = False
                'ddlBranch.Enabled = False
                txtSumAssuredFrom.Text = String.Format("{0:N2}", oSDR("SUMASSUREDFROM"))
                txtSumAssuredTo.Text = String.Format("{0:N2}", oSDR("SUMASSUREDTO"))
                txtRemark.Text = oSDR("REMARK").ToString()
                EnabledSumAssured(True, "disabled")
                oSDR.Close()
                oSDR = Nothing

                oSDR = objDB.CreateSDRFromSQLSelect("SELECT INSPRICINGID,INSYEARID,INSYEAR, BASERATE, BASERATERSCC, BASERATERSMB, BASERATEOTHER FROM INSPRICINGDTL WHERE (Deletests = 0) AND (INSPRICINGID= " & strKey & ")")
                If oSDR.HasRows Then
                    Dim dtInsPrice As New System.Data.DataTable
                    dtInsPrice.Load(oSDR)
                    oSDR.Close()
                    oSDR = Nothing

                    If ViewState("CurrentTable") IsNot Nothing Then
                        ViewState("CurrentTable") = Nothing
                    End If
                    ViewState("CurrentTable") = dtInsPrice
                    gvNotaryFee.DataSource = dtInsPrice
                    gvNotaryFee.DataBind()
                Else
                    AddRowEmpty()
                End If

            Else
                lblMessage.Visible = True
                lblMessage.Text = "INSPRICING ID : " & strKey & " NOT ALREADY EXIST..!"
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RETRIVE DATA (INSURANCE PRICING) ENTRY: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As System.EventArgs) Handles btnCancel.Click
        hidInsPricingID.Value = ""
        MultiView_Utama.SetActiveView(View_View)
        Validation.ClearPanelAplicationField(pnlForm)
        pnlControl.Visible = False
        If DirectCast(ViewState("CurrentTable"), DataTable) Is Nothing Then
        Else
            DirectCast(ViewState("CurrentTable"), DataTable).Rows.Clear()
            DirectCast(ViewState("CurrentTable"), DataTable).Dispose()
        End If

        DataSearch()
    End Sub

    Private Sub AddRowEmpty()
        Dim dt As New DataTable()
        Dim dr As DataRow = Nothing
        Dim oImageDel As ImageButton

        dt.Columns.Add(New DataColumn("INSPRICINGID", GetType(String)))
        dt.Columns.Add(New DataColumn("INSYEARID", GetType(String)))
        dt.Columns.Add(New DataColumn("INSYEAR", GetType(String)))
        dt.Columns.Add(New DataColumn("BASERATE", GetType(String)))
        dt.Columns.Add(New DataColumn("BASERATERSCC", GetType(String)))
        dt.Columns.Add(New DataColumn("BASERATERSMB", GetType(String)))
        dt.Columns.Add(New DataColumn("BASERATEOTHER", GetType(String)))
        dr = dt.NewRow()
        dr("INSPRICINGID") = 0
        dr("INSYEARID") = 0
        dr("INSYEAR") = 1
        dr("BASERATE") = ""
        dr("BASERATERSCC") = 0
        dr("BASERATERSMB") = 0
        dr("BASERATEOTHER") = 0
        dt.Rows.Add(dr)

        ViewState("CurrentTable") = dt

        gvNotaryFee.DataSourceID = String.Empty
        gvNotaryFee.DataSource = dt
        gvNotaryFee.DataBind()

        oImageDel = DirectCast(gvNotaryFee.Rows(Convert.ToInt32(txtTmpSelectedIndex.Text)).FindControl("btnDelete"), ImageButton)
        oImageDel.Visible = False
    End Sub

    Protected Sub gvNotaryFee_DataBound(sender As Object, e As System.EventArgs) Handles gvNotaryFee.DataBound
        Dim oTextBox As TextBox
        For Each row As GridViewRow In gvNotaryFee.Rows
            oTextBox = CType(row.FindControl("txtBaseRate"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, , "[0-9.,]")
            End If
        Next
        For Each row As GridViewRow In gvNotaryFee.Rows
            oTextBox = CType(row.FindControl("txtBaseRateRSCC"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, , "[0-9.,]")
            End If
        Next
        For Each row As GridViewRow In gvNotaryFee.Rows
            oTextBox = CType(row.FindControl("txtRSMBRate"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, , "[0-9.,]")
            End If
        Next
        For Each row As GridViewRow In gvNotaryFee.Rows
            oTextBox = CType(row.FindControl("txtRSMBRateOther"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, , "[0-9.,]")
            End If
        Next

    End Sub

    Protected Sub btnNew_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs)
        Try

            Dim dtInsPricing As New System.Data.DataTable
            Dim drInsPricing As System.Data.DataRow

            dtInsPricing = ViewState("CurrentTable")

            GetDataFee(dtInsPricing)

            'Dim intYear As Integer = dtInsPricing.Rows.Count + 1
            drInsPricing = dtInsPricing.NewRow()
            drInsPricing("INSPRICINGID") = "0"
            drInsPricing("INSYEARID") = "0"
            'drInsPricing("INSYEAR") += intYear
            drInsPricing("INSYEAR") = "1"

            drInsPricing("BASERATE") = "0"
            drInsPricing("BASERATERSCC") = 0
            drInsPricing("BASERATERSMB") = 0
            drInsPricing("BASERATEOTHER") = 0

            dtInsPricing.Rows.Add(drInsPricing)

            gvNotaryFee.DataSource = dtInsPricing

            gvNotaryFee.DataBind()
            ViewState("CurrentTable") = dtInsPricing

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR NEW INSURANCE PRICING: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        End Try
    End Sub

    Private Sub GetDataFee(ByRef dtInsPricingFee As System.Data.DataTable)

        dtInsPricingFee.Clear()
        Dim oImageDel As ImageButton
        Dim dblBaseRate As Double, dblRateRSCC As Double, dblRateRSMB As Double, dblRateOther As Double
        Dim drInsPricingFee As System.Data.DataRow
        Dim oTextBox As TextBox
        Dim intYear As String
        Dim intYearID As String
        For Each gvRow As GridViewRow In gvNotaryFee.Rows

            dblRateRSCC = 0
            dblRateRSMB = 0
            dblRateOther = 0
            intYearID = 0
            intYear = 1

            oTextBox = CType(gvRow.FindControl("txtINSYEARID"), TextBox)
            If oTextBox IsNot Nothing Then
                intYearID = Replace(oTextBox.Text, ",", "")
            End If
            oTextBox = CType(gvRow.FindControl("txtINSYEAR"), TextBox)
            If oTextBox IsNot Nothing Then
                intYear = Replace(oTextBox.Text, ",", "")
            End If
            oTextBox = CType(gvRow.FindControl("txtBaseRate"), TextBox)
            If oTextBox IsNot Nothing Then
                dblBaseRate = Replace(oTextBox.Text, ",", "")
            End If

            oTextBox = CType(gvRow.FindControl("txtBaseRateRSCC"), TextBox)
            If oTextBox IsNot Nothing Then
                dblRateRSCC = Replace(oTextBox.Text, ",", "")
            End If

            oTextBox = CType(gvRow.FindControl("txtRSMBRate"), TextBox)
            If oTextBox IsNot Nothing Then
                dblRateRSMB = Replace(oTextBox.Text, ",", "")
            End If

            oTextBox = CType(gvRow.FindControl("txtRSMBRateOther"), TextBox)
            If oTextBox IsNot Nothing Then
                dblRateOther = Replace(oTextBox.Text, ",", "")
            End If

            drInsPricingFee = dtInsPricingFee.NewRow()
            If chkAddNew.Checked Then
                drInsPricingFee("INSPRICINGID") = "0"
            Else
                drInsPricingFee("INSPRICINGID") = hidInsPricingID.Value
            End If



            drInsPricingFee("INSYEARID") = intYearID
            drInsPricingFee("INSYEAR") = intYear
            'drInsPricingFee("BASERATE") = String.Format("{0:N}", dblBaseRate)
            'drInsPricingFee("BASERATERSCC") = String.Format("{0:N}", dblRateRSCC)
            'drInsPricingFee("BASERATERSMB") = String.Format("{0:N}", dblRateRSCC)
            'drInsPricingFee("BASERATEOTHER") = String.Format("{0:N}", dblRateRSMB)

            drInsPricingFee("BASERATE") = dblBaseRate
            drInsPricingFee("BASERATERSCC") = dblRateRSCC
            drInsPricingFee("BASERATERSMB") = dblRateRSCC
            drInsPricingFee("BASERATEOTHER") = dblRateRSMB

            dtInsPricingFee.Rows.Add(drInsPricingFee)
            oImageDel = DirectCast(gvNotaryFee.Rows(Convert.ToInt32(txtTmpSelectedIndex.Text)).FindControl("btnDelete"), ImageButton)
            oImageDel.Visible = False
            'End If
        Next
    End Sub
    Protected Sub gvNotaryFee_PageIndexChanging(sender As Object, e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvNotaryFee.PageIndexChanging
        gvNotaryFee.PageIndex = e.NewPageIndex
        Dim dt As DataTable = DirectCast(ViewState("CurrentTable"), DataTable)
        gvNotaryFee.DataSource = dt
        gvNotaryFee.DataBind()
        If gvNotaryFee.Rows.Count > 0 Then
            gvNotaryFee.SelectedIndex = 0
        End If
        lblMessage.Visible = False
    End Sub

    Protected Sub gvNotaryFee_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvNotaryFee.RowDataBound
        Dim oTextBox As TextBox
        For Each row As GridViewRow In gvNotaryFee.Rows
            If row.RowType = DataControlRowType.DataRow Then
                oTextBox = CType(row.FindControl("txtBaseRate"), TextBox)
                If oTextBox IsNot Nothing Then
                    SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
                    If Len(Trim(oTextBox.Text)) <= 0 Then
                        '  oTextBox.Text = "0"
                    End If
                End If
                oTextBox = CType(row.FindControl("txtBaseRateRSCC"), TextBox)
                If oTextBox IsNot Nothing Then
                    SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
                    If Len(Trim(oTextBox.Text)) <= 0 Then
                        oTextBox.Text = "0"
                    End If
                End If
                oTextBox = CType(row.FindControl("txtRSMBRate"), TextBox)
                If oTextBox IsNot Nothing Then
                    SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
                    If Len(Trim(oTextBox.Text)) <= 0 Then
                        oTextBox.Text = "0"
                    End If
                End If
                oTextBox = CType(row.FindControl("txtRSMBRateOther"), TextBox)
                If oTextBox IsNot Nothing Then
                    SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
                    If Len(Trim(oTextBox.Text)) <= 0 Then
                        oTextBox.Text = "0"
                    End If
                End If
            End If
        Next
    End Sub

    Protected Sub gvNotaryFee_RowDeleting(sender As Object, e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles gvNotaryFee.RowDeleting
        Dim dtInsPricing As New System.Data.DataTable
        dtInsPricing = ViewState("CurrentTable")
        GetDataFee(dtInsPricing)
        dtInsPricing = ViewState("CurrentTable")
        dtInsPricing.Rows.RemoveAt(e.RowIndex)
        dtInsPricing.AcceptChanges()

        ViewState("CurrentTable") = dtInsPricing
        gvNotaryFee.DataSource = dtInsPricing
        gvNotaryFee.DataBind()
    End Sub

    Protected Sub btnMove_Click(sender As Object, e As System.EventArgs) Handles btnMove.Click
        For i As Integer = lvbBranchSrc.Items.Count - 1 To 0 Step -1
            If lvbBranchSrc.Items(i).Selected Then
                lvbBranchDst.Items.Add(lvbBranchSrc.Items(i))
                lvbBranchDst.ClearSelection()
                lvbBranchSrc.Items.Remove(lvbBranchSrc.Items(i))
            End If
        Next
    End Sub

    Protected Sub btnBack_Click(sender As Object, e As System.EventArgs) Handles btnBack.Click
        For i As Integer = lvbBranchDst.Items.Count - 1 To 0 Step -1
            If lvbBranchDst.Items(i).Selected Then
                lvbBranchSrc.Items.Add(lvbBranchDst.Items(i))
                lvbBranchSrc.ClearSelection()
                lvbBranchDst.Items.Remove(lvbBranchDst.Items(i))
            End If
        Next
    End Sub
    Protected Sub imgBtnNew_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        chkAddNew.Checked = True
        pnlControl.Visible = True
        Validation.ClearPanelAplicationField(pnlForm)
        MultiView_Utama.SetActiveView(View_Form)
        hidAction.Value = "NEW"
        lblCaption.Text = "New Data"
        AddRowEmpty()
        btnDelete.Visible = False
        EnabledSumAssured(False, "required")
        ddlInsType.Enabled = True
        lvbBranchDst.Items.Clear()
        SetFormValidation()
        ajaxCCDProduct.SelectedValue = Nothing
    End Sub
    Private Sub EnabledSumAssured(ByVal value As Boolean, ByVal sClass As String)
        'txtSumAssuredFrom.ReadOnly = value
        'txtSumAssuredTo.ReadOnly = value
        'txtSumAssuredFrom.CssClass = sClass
        'txtSumAssuredTo.CssClass = sClass
    End Sub
    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        Dim iRow As Integer
        Dim iRows As Integer
        Dim objDB As New DBX
        lblMessage.Visible = False
        Try

            '### 1) Save InPricing ##
            SaveData(ddlProduct.SelectedValue, ddlType.SelectedValue, ddlPurpose.SelectedValue, ddlInsType.SelectedValue,
                         txtRemark.Text, NoComma(txtSumAssuredFrom.Text), NoComma(txtSumAssuredTo.Text), Request.Cookies("UID").Value)
            If iError = 0 Then
                '### 2) Save InPricingBranch ##
                'Dim oSDR As Data.SqlClient.SqlDataReader
                'oSDR = objDB.CreateSDRFromExecSQL("Update dbo.INSPRICINGBRANCH SET DeleteSTS=1 WHERE INSPRICINGID=" & hidInsPricingID.Value)
                'If oSDR.Read() Then
                'End If
                'oSDR.Close()
                objDB.ExecSQLWithParam("Update dbo.INSPRICINGBRANCH SET DeleteSTS=1 WHERE INSPRICINGID=@INSPRICINGID", _
                        objDB.MP("@INSPRICINGID", SqlDbType.BigInt, hidInsPricingID.Value))
                iRows = lvbBranchDst.Items.Count.ToString - 1
                For iRow = 0 To iRows
                    SaveInspricingBranch(hidInsPricingID.Value, lvbBranchDst.Items.Item(iRow).Value)
                Next

                '### 3) Save InPricingDtl ##
                If DirectCast(ViewState("CurrentTable"), DataTable) IsNot Nothing Then
                    'oSDR = objDB.CreateSDRFromExecSQL("Update dbo.INSPRICINGDTL SET DeleteSTS=1 WHERE INSPRICINGID=" & hidInsPricingID.Value)
                    'If oSDR.Read() Then
                    'End If
                    'oSDR.Close()
                    objDB.ExecSQLWithParam("Update dbo.INSPRICINGDTL SET DeleteSTS=1 WHERE INSPRICINGID=@INSPRICINGID", _
                        objDB.MP("@INSPRICINGID", SqlDbType.BigInt, hidInsPricingID.Value))

                    Dim dtInsPricingSave As New System.Data.DataTable
                    dtInsPricingSave = ViewState("CurrentTable")
                    GetDataFee(dtInsPricingSave)
                    Dim iYear As Integer = 0
                    For Each row As System.Data.DataRow In dtInsPricingSave.Rows
                        If row.Item("BASERATE").ToString() <> 0 Then
                            iYear = iYear + 1
                            SaveInspricingDtl(hidInsPricingID.Value, row.Item("INSYEARID").ToString(),
                                             iYear,
                                             row.Item("BASERATE").ToString(),
                                             row.Item("BASERATERSCC").ToString(),
                                             row.Item("BASERATERSMB").ToString(),
                                             row.Item("BASERATEOTHER").ToString())
                        End If
                    Next
                End If

                If DirectCast(ViewState("CurrentTable"), DataTable) Is Nothing Then
                Else
                    DirectCast(ViewState("CurrentTable"), DataTable).Rows.Clear()
                    DirectCast(ViewState("CurrentTable"), DataTable).Dispose()
                End If
                hidInsPricingID.Value = ""
                MultiView_Utama.SetActiveView(View_View)
                DataSearch()
                pnlControl.Visible = False
            End If

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE INSURANCE CUSTOMER PRICING..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE:<BR>" & ex.Message

        Finally
            objDB.Close()
            objDB = Nothing

        End Try

    End Sub
    Private Sub SaveData(ByVal iProductID As Integer,
                        ByVal iCategoryId As Integer,
                        ByVal iPurposeID As String,
                        ByVal iInsuranceType As Integer,
                        ByVal sRemark As String,
                        ByVal iSumAssuredFrom As Integer,
                        ByVal iSumAssuredTo As Integer,
                        ByVal sUserId As String)
        Dim objDB As New DBX
        Dim intRetVal As Integer
        Dim inINSPRICINGID As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection

        Try
            If chkAddNew.Checked Then
                oSQLParam = objDB.ExecSPReturnParam("INSPRICINGAdd", _
                   objDB.MP("@PRODUCTID", Data.SqlDbType.Int, iProductID, 8), _
                   objDB.MP("@CATEGORYID", Data.SqlDbType.Int, iCategoryId, 8), _
                   objDB.MP("@PURPOSEID", Data.SqlDbType.Int, iPurposeID, 8), _
                   objDB.MP("@INSURANCETYPE", Data.SqlDbType.Int, iInsuranceType, 8), _
                   objDB.MP("@REMARK", Data.SqlDbType.VarChar, sRemark, 100), _
                   objDB.MP("@SUMASSUREDFROM", Data.SqlDbType.Money, iSumAssuredFrom, 20), _
                   objDB.MP("@SUMASSUREDTO", Data.SqlDbType.Money, iSumAssuredTo, 20), _
                   objDB.MP("@INSPRICINGID", Data.SqlDbType.Int, inINSPRICINGID, 8, Data.ParameterDirection.Output), _
                   objDB.MP("@USERID", Data.SqlDbType.BigInt, sUserId, 20), _
                   objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 10, Data.ParameterDirection.Output) _
                    )
                If Not IsDBNull(oSQLParam("@INSPRICINGID").Value) Then
                    inINSPRICINGID = oSQLParam("@INSPRICINGID").Value
                End If
                intRetVal = oSQLParam("@RETVAL").Value.ToString()
                hidInsPricingID.Value = inINSPRICINGID
            Else
                oSQLParam = objDB.ExecSPReturnParam("INSPRICINGUpdate", _
                  objDB.MP("@INSPRICINGID", Data.SqlDbType.Int, lblInspricingID.Text, 8), _
                  objDB.MP("@PRODUCTID", Data.SqlDbType.Int, iProductID, 8), _
                  objDB.MP("@CATEGORYID", Data.SqlDbType.Int, iCategoryId, 8), _
                  objDB.MP("@PURPOSEID", Data.SqlDbType.Int, iPurposeID, 8), _
                  objDB.MP("@INSURANCETYPE", Data.SqlDbType.Int, iInsuranceType, 8), _
                  objDB.MP("@REMARK", Data.SqlDbType.VarChar, sRemark, 100), _
                  objDB.MP("@SUMASSUREDFROM", Data.SqlDbType.Money, iSumAssuredFrom, 20), _
                  objDB.MP("@SUMASSUREDTO", Data.SqlDbType.Money, iSumAssuredTo, 20), _
                  objDB.MP("@USERID", Data.SqlDbType.BigInt, sUserId, 20), _
                  objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 10, Data.ParameterDirection.Output) _
                   )
                intRetVal = oSQLParam("@RETVAL").Value.ToString()
            End If

            If intRetVal = -1 Then
                lblMessage.Visible = True
                lblMessage.Text = "INSURANCE PRICING ALREADY IN INSPRICING..!"
                iError = 1
            Else
                iError = 0
                lblMessage.Text = ""
                lblMessage.Visible = False
                hidAction.Value = "SAVE"
            End If


        Catch ex As Exception
            iError = 1
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE DATA INSURANCE PRICING: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Private Sub SaveInspricingBranch(ByVal iInspricingID As Integer,
                           ByVal iBranchID As Integer)

        Dim objDB As New DBX
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try

            oSQLParam = objDB.ExecSPReturnParam("INSPRICINGBRANCHSave", _
                   objDB.MP("@INSPRICINGID", Data.SqlDbType.BigInt, iInspricingID, 8), _
                   objDB.MP("@BRANCHID", Data.SqlDbType.Int, iBranchID, 4), _
                   objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 20))
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE DATA PRICING BRANCH : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            lblMessage.Visible = False
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Private Sub SaveInspricingDtl(ByVal iInspricingID As Integer, ByVal iInsYearID As Integer, ByVal iInsYear As Integer, ByVal mBaseRate As String,
                            ByVal mBaseRateRSCC As String, ByVal mBaseRateRSMB As String, ByVal mBaseRateOther As String)

        Dim objDB As New DBX
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try

            oSQLParam = objDB.ExecSPReturnParam("INSPRICINGDTLSave", _
                   objDB.MP("@INSPRICINGID", Data.SqlDbType.BigInt, iInspricingID, 8), _
                   objDB.MP("@INSYEARID", Data.SqlDbType.Int, iInsYearID, 4), _
                   objDB.MP("@INSYEAR", Data.SqlDbType.Int, iInsYear, 4), _
                   objDB.MP("@BASERATE", Data.SqlDbType.Float, mBaseRate, 20), _
                   objDB.MP("@BASERATERSCC", Data.SqlDbType.Float, mBaseRateRSCC, 20), _
                   objDB.MP("@BASERATERSMB", Data.SqlDbType.Float, mBaseRateRSMB, 20), _
                   objDB.MP("@BASERATEOTHER", Data.SqlDbType.Float, mBaseRateOther, 20), _
                   objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 20))
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE DATA PRICING DETAIL : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            lblMessage.Visible = False
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    'Protected Sub ddlSearchBranch_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlSearchBranch.SelectedIndexChanged
    '    DataSearch()
    '    lblMessage.Visible = False
    'End Sub

    'Protected Sub ddlSearchCategory_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlSearchCategory.SelectedIndexChanged
    '    DataSearch()
    '    lblMessage.Visible = False
    'End Sub

    'Protected Sub ddlSearchPurpose_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlSearchPurpose.SelectedIndexChanged
    '    DataSearch()
    '    lblMessage.Visible = False
    'End Sub

    Protected Sub btnDelete_Click(sender As Object, e As System.EventArgs) Handles btnDelete.Click
        lblMessage.Visible = False
        Dim objDB As New DBX
        Try
            objDB.ExecSP("INSPRICINGDelete", _
                    objDB.MP("@INSPRICINGID", SqlDbType.BigInt, hidInsPricingID.Value), _
                    objDB.MP("@USERID", SqlDbType.BigInt, Request.Cookies("UID").Value))
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR DELETE PRICING..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE: <BR>" & ex.Message
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        'Dim oSDR As Data.SqlClient.SqlDataReader
        ' Dim oSDRPrc As Data.SqlClient.SqlDataReader
        ' Dim oSDRPrcDTL As Data.SqlClient.SqlDataReader
        'oSDR = objDB.CreateSDRFromExecSQL("Update dbo.INSPRICINGBRANCH SET DeleteSTS=1, LastUpdate=GetDate(), LastUserID=" & Request.Cookies("UID").Value & " WHERE INSPRICINGID=" & lblInspricingID.Text & " AND BRANCHID=" & ddlBranch.SelectedValue)
        'If oSDR.Read() Then
        'oSDRPrc = objDB.CreateSDRFromExecSQL("Update dbo.INSPRICING SET DeleteSTS=1, LastUpdate=GetDate(), LastUserID=" & Request.Cookies("UID").Value & " WHERE INSPRICINGID=" & lblInspricingID.Text)
        'If oSDRPrc.Read() Then
        '    oSDRPrcDTL = objDB.CreateSDRFromExecSQL("Update dbo.INSPRICINGDTL SET DeleteSTS=1, LastUpdate=GetDate(), LastUserID=" & Request.Cookies("UID").Value & " WHERE INSPRICINGID=" & lblInspricingID.Text)
        '    If oSDRPrcDTL.Read() Then
        '        oSDRPrcDTL.Close()
        '    End If
        'End If
        'oSDRPrc.Close()
        'End If
        'oSDR.Close()
        hidInsPricingID.Value = ""
        MultiView_Utama.SetActiveView(View_View)
        DataSearch()

    End Sub
    Private Function NoComma(ByVal theValue As String) As String
        NoComma = Replace(theValue, ",", "")
    End Function

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub

    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub
End Class
