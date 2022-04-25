Imports System.Data
Imports System.Data.SqlClient
Partial Class Param_InsurancePricing
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
            sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCH.BRANCHID= -1"
        End If
        If Len(Trim(ddlSearchInsurance.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + "(EXISTS(SELECT INSCOMPANY.INSCOMPANYID FROM INSCOMPANY INNER JOIN INSBRANCH ON INSBRANCH.INSCOMPANYID= " & ddlSearchInsurance.SelectedValue & " ))"
        End If
        If Len(Trim(ddlSearchBranch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND INSPRICINGCOMP.INSBRANCHID=" & ddlSearchBranch.SelectedValue
        End If
        If Len(Trim(ddlSearchProduct.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND INSPRICINGCOMP.PRODUCTID=" & ddlSearchProduct.SelectedValue
        End If

        If Len(Trim(ddlSearchCategory.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND INSPRICINGCOMP.CATEGORYID=" & ddlSearchCategory.SelectedValue
        End If


        If Len(Trim(ddlSearchPurpose.SelectedValue)) > 0 Then
            If ddlSearchPurpose.SelectedValue.ToString() = "-1" Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND INSPRICINGCOMP.PURPOSEID IS NULL"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND INSPRICINGCOMP.PURPOSEID=" & ddlSearchPurpose.SelectedValue
            End If
        End If

        gvData.DataBind()


    End Sub
 
    Protected Sub btnEdit_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        Dim currentCommand As String = e.CommandName
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument)
        lblCaption.Text = "Edit Data"
        hidAction.Value = "EDIT"
        gvData.SelectedIndex = e.CommandArgument
        hidInsPricingID.Value = gvData.SelectedDataKey("INSPRICINGCOMPID")
        chkAddNew.Checked = False
        MultiView_Utama.SetActiveView(View_Form)
        GetData(hidInsPricingID.Value)
        pnlControl.Visible = True
        btnDelete.Visible = True
    End Sub
  
    Private Sub GetData(ByVal strKey As String)
        Dim objDB As New DBX
        Try

            Dim oSDR As System.Data.SqlClient.SqlDataReader

            oSDR = objDB.CreateSDRFromSQLSelect("SELECT  *,(SELECT INSCOMPANY.INSCOMPANYID FROM INSCOMPANY INNER JOIN INSBRANCH ON INSBRANCH.INSCOMPANYID=INSCOMPANY.INSCOMPANYID AND INSBRANCH.INSBRANCHID=INSPRICINGCOMP.INSBRANCHID)AS INSCOMPANYID " & _
              "  FROM dbo.INSPRICINGCOMP WITH(NOLOCK) WHERE INSPRICINGCOMPID=" & strKey)
            If oSDR.Read Then

                lblInspricingCompID.Text = oSDR("INSPRICINGCOMPID")
                If Not String.IsNullOrEmpty(oSDR("INSCOMPANYID").ToString()) Then
                    ajaxCDDInsurance.SelectedValue = oSDR("INSCOMPANYID").ToString()
                Else
                    ajaxCDDInsurance.SelectedValue = 0
                End If
                If Not String.IsNullOrEmpty(oSDR("INSBRANCHID").ToString()) Then
                    ajaxCDDBranch.SelectedValue = oSDR("INSBRANCHID").ToString()
                Else
                    ajaxCDDBranch.SelectedValue = 0
                End If
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
                txtSumAssuredFrom.Text = String.Format("{0:N2}", oSDR("SUMASSUREDFROM"))
                txtSumAssuredTo.Text = String.Format("{0:N2}", oSDR("SUMASSUREDTO"))
                txtRemark.Text = oSDR("REMARK").ToString()
                EnabledSumAssured(True, "disabled")
                oSDR.Close()
                oSDR = Nothing

                oSDR = objDB.CreateSDRFromSQLSelect("SELECT * FROM dbo.INSPRICINGCOMP WITH(NOLOCK) WHERE INSPRICINGCOMPID=" & strKey)
                If oSDR.Read Then

                End If
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT INSPRICINGCOMPID,INSYEARCOMPID,INSYEAR, BASERATE,DISCOUNTRATE, BASERATERSCC,DISCOUNTRATERSCC, BASERATERSMB,DISCOUNTRATERSMB, BASERATEOTHER,DISCOUNTRATEOTHER FROM INSPRICINGCOMPDTL WHERE (Deletests = 0) AND (INSPRICINGCOMPID= " & strKey & ")")
                If oSDR.HasRows Then
                    Dim dtInsPrice As New System.Data.DataTable
                    dtInsPrice.Load(oSDR)
                    oSDR.Close()
                    oSDR = Nothing

                    If ViewState("CurrentTable") IsNot Nothing Then
                        ViewState("CurrentTable") = Nothing
                    End If
                    ViewState("CurrentTable") = dtInsPrice
                    gvInsPricingComp.DataSource = dtInsPrice
                    gvInsPricingComp.DataBind()
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

    Private Sub EnabledSumAssured(ByVal value As Boolean, ByVal sClass As String)
        'txtSumAssuredFrom.ReadOnly = value
        'txtSumAssuredTo.ReadOnly = value
        'txtSumAssuredFrom.CssClass = sClass
        'txtSumAssuredTo.CssClass = sClass
    End Sub
    Protected Sub btnCancel_Click(sender As Object, e As System.EventArgs) Handles btnCancel.Click
        lblMessage.Visible = False
        hidInsPricingID.Value = ""
        lblInspricingCompID.Text = ""
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

        dt.Columns.Add(New DataColumn("INSPRICINGCOMPID", GetType(String)))
        dt.Columns.Add(New DataColumn("INSYEARCOMPID", GetType(String)))
        dt.Columns.Add(New DataColumn("INSYEAR", GetType(String)))
        dt.Columns.Add(New DataColumn("BASERATE", GetType(String)))
        dt.Columns.Add(New DataColumn("DISCOUNTRATE", GetType(String)))
        dt.Columns.Add(New DataColumn("BASERATERSCC", GetType(String)))
        dt.Columns.Add(New DataColumn("DISCOUNTRATERSCC", GetType(String)))
        dt.Columns.Add(New DataColumn("BASERATERSMB", GetType(String)))
        dt.Columns.Add(New DataColumn("DISCOUNTRATERSMB", GetType(String)))
        dt.Columns.Add(New DataColumn("BASERATEOTHER", GetType(String)))
        dt.Columns.Add(New DataColumn("DISCOUNTRATEOTHER", GetType(String)))
        dr = dt.NewRow()
        dr("INSPRICINGCOMPID") = 0
        dr("INSYEARCOMPID") = 0
        dr("INSYEAR") = 1
        dr("BASERATE") = 0
        dr("DISCOUNTRATE") = 0
        dr("BASERATERSCC") = 0
        dr("DISCOUNTRATERSCC") = 0
        dr("BASERATERSMB") = 0
        dr("DISCOUNTRATERSMB") = 0
        dr("BASERATEOTHER") = 0
        dr("DISCOUNTRATEOTHER") = 0
        dt.Rows.Add(dr)

        ViewState("CurrentTable") = dt

        gvInsPricingComp.DataSourceID = String.Empty
        gvInsPricingComp.DataSource = dt
        gvInsPricingComp.DataBind()

        oImageDel = DirectCast(gvInsPricingComp.Rows(Convert.ToInt32(txtTmpSelectedIndex.Text)).FindControl("btnDelete"), ImageButton)
        oImageDel.Visible = False
    End Sub
    Protected Sub gvInsPricingComp_DataBound(sender As Object, e As System.EventArgs) Handles gvInsPricingComp.DataBound
        Dim oTextBox As TextBox
        For Each row As GridViewRow In gvInsPricingComp.Rows
            oTextBox = CType(row.FindControl("txtBaseRate"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If

            oTextBox = CType(row.FindControl("txtDiscBaseRate"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If

            oTextBox = CType(row.FindControl("txtBaseRateRSCC"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If

            oTextBox = CType(row.FindControl("txtDiscBaseRateRSCC"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If

            oTextBox = CType(row.FindControl("txtRSMBRate"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If

            oTextBox = CType(row.FindControl("txtDiscBaseRateRSMB"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If

            oTextBox = CType(row.FindControl("txtRSMBRateOther"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If

            oTextBox = CType(row.FindControl("txtDiscBaseRateRSMBOther"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If

        Next

    End Sub
    Private Sub SetFormValidation()
        'txtSumAssuredFrom.Text = "0"
        'txtSumAssuredTo.Text = "0"
        SetObjectValidation(txtSumAssuredFrom, False, "float", "[0-9]")
        SetObjectValidation(txtSumAssuredTo, False, "float", "[0-9]")
    End Sub
    Protected Sub btnNew_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs)
        Try
            Dim dtInsPricing As New System.Data.DataTable
            Dim drInsPricing As System.Data.DataRow

            dtInsPricing = ViewState("CurrentTable")
           
            GetDataFee(dtInsPricing)

            drInsPricing = dtInsPricing.NewRow()
            drInsPricing("INSPRICINGCOMPID") = "0"
            drInsPricing("INSYEARCOMPID") = "0"
            drInsPricing("INSYEAR") = "1"

            drInsPricing("BASERATE") = 0
            drInsPricing("DISCOUNTRATE") = 0
            drInsPricing("BASERATERSCC") = 0
            drInsPricing("DISCOUNTRATERSCC") = 0
            drInsPricing("BASERATERSMB") = 0
            drInsPricing("DISCOUNTRATERSMB") = 0
            drInsPricing("BASERATEOTHER") = 0
            drInsPricing("DISCOUNTRATEOTHER") = 0

            dtInsPricing.Rows.Add(drInsPricing)

            gvInsPricingComp.DataSource = dtInsPricing

            gvInsPricingComp.DataBind()
            ViewState("CurrentTable") = dtInsPricing
           
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR NEW INSURANCE COMPANY PRICING: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        End Try
    End Sub
    Private Sub GetDataFee(ByRef dtInsPricingFee As System.Data.DataTable)

        dtInsPricingFee.Clear()

        Dim dblBaseRate As Double, dblRateRSCC As Double, dblRateRSMB As Double, dblRateOther As Double
        Dim dblDiscBaseRate As Double, dblDiscRateRSCC As Double, dblDiscRateRSMB As Double, dblDiscRateOther As Double
        Dim drInsPricingFee As System.Data.DataRow
        Dim oTextBox As TextBox
        Dim intYear As String
        Dim intYearID As String
        For Each gvRow As GridViewRow In gvInsPricingComp.Rows

            dblRateRSCC = 0
            dblRateRSMB = 0
            dblRateOther = 0
            dblDiscBaseRate = 0
            dblDiscRateRSCC = 0
            dblDiscRateRSMB = 0
            dblDiscRateOther = 0
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

            oTextBox = CType(gvRow.FindControl("txtDiscBaseRate"), TextBox)
            If oTextBox IsNot Nothing Then
                dblDiscBaseRate = Replace(oTextBox.Text, ",", "")
            End If

            oTextBox = CType(gvRow.FindControl("txtBaseRateRSCC"), TextBox)
            If oTextBox IsNot Nothing Then
                dblRateRSCC = Replace(oTextBox.Text, ",", "")
            End If

            oTextBox = CType(gvRow.FindControl("txtDiscBaseRateRSCC"), TextBox)
            If oTextBox IsNot Nothing Then
                dblDiscRateRSCC = Replace(oTextBox.Text, ",", "")
            End If

            oTextBox = CType(gvRow.FindControl("txtRSMBRate"), TextBox)
            If oTextBox IsNot Nothing Then
                dblRateRSMB = Replace(oTextBox.Text, ",", "")
            End If

            oTextBox = CType(gvRow.FindControl("txtDiscBaseRateRSMB"), TextBox)
            If oTextBox IsNot Nothing Then
                dblDiscRateRSMB = Replace(oTextBox.Text, ",", "")
            End If

            oTextBox = CType(gvRow.FindControl("txtRSMBRateOther"), TextBox)
            If oTextBox IsNot Nothing Then
                dblRateOther = Replace(oTextBox.Text, ",", "")
            End If

            oTextBox = CType(gvRow.FindControl("txtDiscBaseRateRSMBOther"), TextBox)
            If oTextBox IsNot Nothing Then
                dblDiscRateOther = Replace(oTextBox.Text, ",", "")
            End If

            drInsPricingFee = dtInsPricingFee.NewRow()
            If chkAddNew.Checked Then
                drInsPricingFee("INSPRICINGCOMPID") = "0"
            Else
                drInsPricingFee("INSPRICINGCOMPID") = hidInsPricingID.Value
            End If



            drInsPricingFee("INSYEARCOMPID") = intYearID
            drInsPricingFee("INSYEAR") = intYear
            'drInsPricingFee("BASERATE") = String.Format("{0:N}", dblBaseRate)
            'drInsPricingFee("DISCOUNTRATE") = String.Format("{0:N}", dblDiscBaseRate)
            'drInsPricingFee("BASERATERSCC") = String.Format("{0:N}", dblRateRSCC)
            'drInsPricingFee("DISCOUNTRATERSCC") = String.Format("{0:N}", dblDiscRateRSCC)
            'drInsPricingFee("BASERATERSMB") = String.Format("{0:N}", dblRateRSCC)
            'drInsPricingFee("DISCOUNTRATERSMB") = String.Format("{0:N}", dblDiscRateRSMB)
            'drInsPricingFee("BASERATEOTHER") = String.Format("{0:N}", dblRateRSMB)
            'drInsPricingFee("DISCOUNTRATEOTHER") = String.Format("{0:N}", dblDiscRateOther)

            drInsPricingFee("BASERATE") = dblBaseRate
            drInsPricingFee("DISCOUNTRATE") = dblDiscBaseRate
            drInsPricingFee("BASERATERSCC") = dblRateRSCC
            drInsPricingFee("DISCOUNTRATERSCC") = dblDiscRateRSCC
            drInsPricingFee("BASERATERSMB") = dblRateRSCC
            drInsPricingFee("DISCOUNTRATERSMB") = dblDiscRateRSMB
            drInsPricingFee("BASERATEOTHER") = dblRateRSMB
            drInsPricingFee("DISCOUNTRATEOTHER") = dblDiscRateOther


            dtInsPricingFee.Rows.Add(drInsPricingFee)
        
            'End If
        Next
    End Sub
    Protected Sub gvInsPricingComp_PageIndexChanging(sender As Object, e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvInsPricingComp.PageIndexChanging
        gvInsPricingComp.PageIndex = e.NewPageIndex
        Dim dt As DataTable = DirectCast(ViewState("CurrentTable"), DataTable)
        gvInsPricingComp.DataSource = dt
        gvInsPricingComp.DataBind()
        If gvInsPricingComp.Rows.Count > 0 Then
            gvInsPricingComp.SelectedIndex = 0
        End If
        lblMessage.Visible = False
    End Sub

    Protected Sub gvInsPricingComp_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvInsPricingComp.RowDataBound
        Dim oTextBox As TextBox
        For Each row As GridViewRow In gvInsPricingComp.Rows
            If row.RowType = DataControlRowType.DataRow Then
                oTextBox = CType(row.FindControl("txtBaseRate"), TextBox)
                If oTextBox IsNot Nothing Then
                    SetObjectValidation(oTextBox, False, , "[0-9.,]")
                    If Len(Trim(oTextBox.Text)) <= 0 Then
                        '  oTextBox.Text = "0"
                    End If
                End If
                oTextBox = CType(row.FindControl("txtDiscBaseRate"), TextBox)
                If oTextBox IsNot Nothing Then
                    SetObjectValidation(oTextBox, False, , "[0-9.,]")
                    If Len(Trim(oTextBox.Text)) <= 0 Then
                        '  oTextBox.Text = "0"
                    End If
                End If
                oTextBox = CType(row.FindControl("txtBaseRateRSCC"), TextBox)
                If oTextBox IsNot Nothing Then
                    SetObjectValidation(oTextBox, False, , "[0-9.,]")
                    If Len(Trim(oTextBox.Text)) <= 0 Then
                        oTextBox.Text = "0"
                    End If
                End If
                oTextBox = CType(row.FindControl("txtDiscBaseRateRSCC"), TextBox)
                If oTextBox IsNot Nothing Then
                    SetObjectValidation(oTextBox, False, , "[0-9.,]")
                    If Len(Trim(oTextBox.Text)) <= 0 Then
                        oTextBox.Text = "0"
                    End If
                End If
                oTextBox = CType(row.FindControl("txtRSMBRate"), TextBox)
                If oTextBox IsNot Nothing Then
                    SetObjectValidation(oTextBox, False, , "[0-9.,]")
                    If Len(Trim(oTextBox.Text)) <= 0 Then
                        oTextBox.Text = "0"
                    End If
                End If
                oTextBox = CType(row.FindControl("txtDiscBaseRateRSMB"), TextBox)
                If oTextBox IsNot Nothing Then
                    SetObjectValidation(oTextBox, False, , "[0-9.,]")
                    If Len(Trim(oTextBox.Text)) <= 0 Then
                        oTextBox.Text = "0"
                    End If
                End If
                oTextBox = CType(row.FindControl("txtRSMBRateOther"), TextBox)
                If oTextBox IsNot Nothing Then
                    SetObjectValidation(oTextBox, False, , "[0-9.,]")
                    If Len(Trim(oTextBox.Text)) <= 0 Then
                        oTextBox.Text = "0"
                    End If
                End If
                oTextBox = CType(row.FindControl("txtDiscBaseRateRSMBOther"), TextBox)
                If oTextBox IsNot Nothing Then
                    SetObjectValidation(oTextBox, False, , "[0-9.,]")
                    If Len(Trim(oTextBox.Text)) <= 0 Then
                        oTextBox.Text = "0"
                    End If
                End If
            End If
        Next
    End Sub
    Protected Sub gvInsPricingComp_RowDeleting(sender As Object, e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles gvInsPricingComp.RowDeleting
        Dim dtInsPricing As New System.Data.DataTable
        dtInsPricing = ViewState("CurrentTable")
        GetDataFee(dtInsPricing)
        dtInsPricing = ViewState("CurrentTable")
        dtInsPricing.Rows.RemoveAt(e.RowIndex)
        dtInsPricing.AcceptChanges()

        ViewState("CurrentTable") = dtInsPricing
        gvInsPricingComp.DataSource = dtInsPricing
        gvInsPricingComp.DataBind()
    End Sub

    Protected Sub imgBtnNew_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        chkAddNew.Checked = True
        pnlControl.Visible = True
        Validation.ClearPanelAplicationField(pnlForm)
        MultiView_Utama.SetActiveView(View_Form)
        hidAction.Value = "NEW"
        lblCaption.Text = "New Data"
        AddRowEmpty()
        EnabledSumAssured(False, "required")
        btnDelete.Visible = False
        ddlInsType.Enabled = True
        SetFormValidation()
        ajaxCDDInsurance.SelectedValue = AjaxCDDSrcInsurance.SelectedValue
        ajaxCDDBranch.SelectedValue = AjaxCDDSrcBranch.SelectedValue
        ajaxCCDProduct.SelectedValue = AjaxCDDSrcProduct.SelectedValue
        ajaxCDDCategoryType.SelectedValue = ajaxCCEObjCategory.SelectedValue
        ajaxCDDPurpose.SelectedValue = ajaxCCEObjPurpose.SelectedValue
    End Sub

    Private Function NoComma(ByVal theValue As String) As String
        NoComma = Replace(theValue, ",", "")
    End Function

    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        'Dim iRow As Integer
        'Dim iRows As Integer
        lblMessage.Visible = False
        Dim objDB As New DBX

        Try

            '### 1) Save InPricing ##
            'Response.Write(txtSumAssuredTo.Text)
            'Response.End()
            SaveData(ddlProduct.SelectedValue, ddlBranch.SelectedValue, ddlType.SelectedValue, ddlPurpose.SelectedValue, ddlInsType.SelectedValue,
                         txtRemark.Text, NoComma(txtSumAssuredFrom.Text), NoComma(txtSumAssuredTo.Text), Request.Cookies("UID").Value)
            If iError = 0 Then
                '### 2) Save InPricingCompDtl ###
                'Dim oSDR As Data.SqlClient.SqlDataReader
                If DirectCast(ViewState("CurrentTable"), DataTable) IsNot Nothing Then
                    'oSDR = objDB.CreateSDRFromExecSQL("Update dbo.INSPRICINGCOMPDTL SET DeleteSTS=1 WHERE INSPRICINGCOMPID=" & hidInsPricingID.Value)
                    'If oSDR.Read() Then
                    'End If
                    'oSDR.Close()
                    objDB.ExecSQLWithParam("Update dbo.INSPRICINGCOMPDTL SET DeleteSTS=1 WHERE INSPRICINGCOMPID=@INSPRICINGCOMPID",
                                           objDB.MP("@INSPRICINGCOMPID", SqlDbType.BigInt, hidInsPricingID.Value))
                    Dim dtInsPricingSave As New System.Data.DataTable
                    dtInsPricingSave = ViewState("CurrentTable")
                    GetDataFee(dtInsPricingSave)
                    Dim iYear As Integer = 0
                    For Each row As System.Data.DataRow In dtInsPricingSave.Rows
                        If row.Item("BASERATE").ToString() <> 0 Then
                            iYear = iYear + 1
                            SaveInspricingDtl(hidInsPricingID.Value, row.Item("INSYEARCOMPID").ToString(),
                                              iYear,
                                             row.Item("BASERATE").ToString(),
                                             row.Item("DISCOUNTRATE").ToString(),
                                             row.Item("BASERATERSCC").ToString(),
                                             row.Item("DISCOUNTRATERSCC").ToString(),
                                             row.Item("BASERATERSMB").ToString(),
                                             row.Item("DISCOUNTRATERSMB").ToString(),
                                             row.Item("BASERATEOTHER").ToString(),
                                             row.Item("DISCOUNTRATEOTHER").ToString())
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
            lblMessage.Text = "ERROR SAVING INSURANCE COMPANY PRICING..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE:<BR>" & ex.Message
        Finally
            objDB.Close()
            objDB = Nothing

        End Try


    End Sub

    Private Sub SaveData(ByVal iProductID As Integer,
                         ByVal iInsBranchID As Integer,
                        ByVal iCategoryId As Integer,
                        ByVal iPurposeID As String,
                        ByVal iInsuranceType As Integer,
                        ByVal sRemark As String,
                        ByVal iSumAssuredFrom As Double,
                        ByVal iSumAssuredTo As Double,
                        ByVal sUserId As String)
        Dim objDB As New DBX
        Dim intRetVal As Integer
        Dim inINSPRICINGID As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection

        Try
            If chkAddNew.Checked Then
                oSQLParam = objDB.ExecSPReturnParam("INSPRICINGCOMPAdd", _
                   objDB.MP("@PRODUCTID", Data.SqlDbType.Int, iProductID, 8), _
                   objDB.MP("@INSBRANCHID", Data.SqlDbType.Int, iInsBranchID, 8), _
                   objDB.MP("@CATEGORYID", Data.SqlDbType.Int, iCategoryId, 8), _
                   objDB.MP("@PURPOSEID", Data.SqlDbType.Int, iPurposeID, 8), _
                   objDB.MP("@INSURANCETYPE", Data.SqlDbType.Int, iInsuranceType, 8), _
                   objDB.MP("@REMARK", Data.SqlDbType.VarChar, sRemark, 100), _
                   objDB.MP("@SUMASSUREDFROM", Data.SqlDbType.Money, iSumAssuredFrom, 20), _
                   objDB.MP("@SUMASSUREDTO", Data.SqlDbType.Money, iSumAssuredTo, 20), _
                   objDB.MP("@INSPRICINGCOMPID", Data.SqlDbType.Int, inINSPRICINGID, 8, Data.ParameterDirection.Output), _
                   objDB.MP("@USERID", Data.SqlDbType.BigInt, sUserId, 20), _
                   objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 10, Data.ParameterDirection.Output) _
                    )
                If Not IsDBNull(oSQLParam("@INSPRICINGCOMPID").Value) Then
                    inINSPRICINGID = oSQLParam("@INSPRICINGCOMPID").Value
                End If
                intRetVal = oSQLParam("@RETVAL").Value.ToString()
                hidInsPricingID.Value = inINSPRICINGID
            Else
                oSQLParam = objDB.ExecSPReturnParam("INSPRICINGCOMPUpdate", _
                  objDB.MP("@INSPRICINGCOMPID", Data.SqlDbType.Int, lblInspricingCompID.Text, 8), _
                  objDB.MP("@PRODUCTID", Data.SqlDbType.Int, iProductID, 8), _
                  objDB.MP("@INSBRANCHID", Data.SqlDbType.Int, iInsBranchID, 8), _
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
                lblMessage.Text = "INSURANCE COMPANY PRICING ALREADY EXIST..!"
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
            lblMessage.Text = "ERROR SAVE DATA INSURANCE COMPANY PRICING: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Private Sub SaveInspricingDtl(ByVal iInspricingID As Integer, ByVal iInsYearID As Integer, ByVal iInsYear As Integer,
                                  ByVal mBaseRate As String, ByVal mDiscRate As String,
                                    ByVal mBaseRateRSCC As String, ByVal mDiscRateRSCC As String,
                                    ByVal mBaseRateRSMB As String, ByVal mDiscRateRSMB As String,
                                    ByVal mBaseRateOther As String, ByVal mDiscRateOther As String)

        Dim objDB As New DBX
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try

            oSQLParam = objDB.ExecSPReturnParam("INSPRICINGCOMPDTLSave", _
                   objDB.MP("@INSPRICINGCOMPID", Data.SqlDbType.BigInt, iInspricingID, 8), _
                   objDB.MP("@INSYEARCOMPID", Data.SqlDbType.Int, iInsYearID, 4), _
                   objDB.MP("@INSYEAR", Data.SqlDbType.Int, iInsYear, 4), _
                   objDB.MP("@BASERATE", Data.SqlDbType.Float, mBaseRate, 20), _
                   objDB.MP("@DISCOUNTRATE", Data.SqlDbType.Float, mDiscRate, 20), _
                   objDB.MP("@BASERATERSCC", Data.SqlDbType.Float, mBaseRateRSCC, 20), _
                   objDB.MP("@DISCOUNTRATERSCC", Data.SqlDbType.Float, mDiscRateRSCC, 20), _
                   objDB.MP("@BASERATERSMB", Data.SqlDbType.Float, mBaseRateRSMB, 20), _
                   objDB.MP("@DISCOUNTRATERSMB", Data.SqlDbType.Float, mDiscRateRSMB, 20), _
                   objDB.MP("@BASERATEOTHER", Data.SqlDbType.Float, mBaseRateOther, 20), _
                   objDB.MP("@DISCOUNTRATEOTHER", Data.SqlDbType.Float, mDiscRateOther, 20), _
                   objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 20))
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE DATA INSURANCE PRICING  DETAIL : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            lblMessage.Visible = False
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub ddlSearchBranch_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlSearchBranch.SelectedIndexChanged
        DataSearch()
        lblMessage.Visible = False
    End Sub

    Protected Sub btnDelete_Click(sender As Object, e As System.EventArgs) Handles btnDelete.Click
        Dim objDB As New DBX
        Try
            lblMessage.Visible = False
            'Dim oSDR As Data.SqlClient.SqlDataReader
            'oSDR = objDB.CreateSDRFromExecSQL("Update dbo.INSPRICINGCOMP SET DeleteSTS=1 , LastUpdate=getdate() , LastUserID= " & Request.Cookies("UID").Value & " WHERE INSPRICINGCOMPID=" & lblInspricingCompID.Text)
            'If oSDR.Read() Then
            'End If
            'oSDR.Close()
            objDB.ExecSP("INSPRICINGCOMPDelete", _
                    objDB.MP("@INSPRICINGCOMPID", SqlDbType.BigInt, lblInspricingCompID.Text), _
                    objDB.MP("@USERID", SqlDbType.Int, Request.Cookies("UID").Value))
            lblInspricingCompID.Text = ""
            MultiView_Utama.SetActiveView(View_View)
            DataSearch()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR DELETE INSURANCE PRICING COMPANY : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub
End Class
