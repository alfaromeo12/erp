Imports System.Data
Imports System.Data.SqlClient
Partial Class Param_FinanceStructure
    Inherits System.Web.UI.Page
    Private dt As New DataTable
    Private dr As DataRow
    Private iError As Integer
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader

        If Request.QueryString("ACTION") = "COPYAUTOMATIC" Then

            If Len(Trim(hidBRANCHCopy.Value)) > 0 Then
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT AREAID,CAST(BRANCHID AS VARCHAR(10)) AS BRANCHID,PRODUCTID,PURPOSECATID,CATEGORYID, FINID,CAST(YEARFROM AS VARCHAR(10))YEARFROM,CAST(YEARTO AS VARCHAR(10))YEARTO, CAST(CONDITION AS VARCHAR(10)) CONDITION, DP,REMARK FROM FNFINSTRUCTURE WHERE (Deletests = 0)" & _
                                                " AND (AREAID= " & hidAREACopy.Value & ") AND (BRANCHID= " & hidBRANCHCopy.Value & ")" & _
                                                " AND (PRODUCTID= " & hidPRODUCTCopy.Value & ") AND (PURPOSECATID= " & hidKINDCopy.Value & ")" & _
                                                " AND (CATEGORYID= " & hidCATEGORYCopy.Value & ")")
            Else

                oSDR = objDB.CreateSDRFromSQLSelect("SELECT AREAID,CAST(BRANCHID AS VARCHAR(10)) AS BRANCHID,PRODUCTID,PURPOSECATID,CATEGORYID,FINID,CAST(YEARFROM AS VARCHAR(10))YEARFROM,CAST(YEARTO AS VARCHAR(10))YEARTO, CAST(CONDITION AS VARCHAR(10)) CONDITION, DP,REMARK FROM FNFINSTRUCTURE WHERE (Deletests = 0)" & _
                                                " AND (AREAID= " & hidAREACopy.Value & ") AND (BRANCHID IS NULL )" & _
                                                " AND (PRODUCTID= " & hidPRODUCTCopy.Value & ") AND (PURPOSECATID= " & hidKINDCopy.Value & ")" & _
                                                " AND (CATEGORYID= " & hidCATEGORYCopy.Value & ")")
            End If

            If oSDR.HasRows() Then
                Dim dtInsPrice As New System.Data.DataTable
                dtInsPrice.Load(oSDR)
                oSDR.Close()
                oSDR = Nothing

                If ViewState("VW_DPMINIMUM") IsNot Nothing Then
                    ViewState("VW_DPMINIMUM") = Nothing
                End If
                ViewState("VW_DPMINIMUM") = dtInsPrice
                gvDPMinimum.DataSource = dtInsPrice
                gvDPMinimum.DataBind()
            End If
            pnlControl.Visible = True
        End If
        If Not IsPostBack Then
            MultiView_Utama.SetActiveView(View_View)
            DataSearch()
        End If
    End Sub

    Protected Sub Page_PreInit(sender As Object, e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
    End Sub

    Private Sub DataSearch()
        If Not IsPostBack Then
            sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND FNFINSTRUCTURE.FINID= -1"
        End If
        If ddlCriteria.SelectedItem.Text = "Product Code" Or ddlCriteria.SelectedItem.Text = "Product Name" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + "(EXISTS(SELECT 'X' FROM PRODUCT WITH(NOLOCK) WHERE (PRODUCTID = FNFINSTRUCTURE.PRODUCTID AND " + ddlCriteria.SelectedValue + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%')))"
        ElseIf ddlCriteria.SelectedItem.Text = "Branch" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedValue + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
        ElseIf ddlCriteria.SelectedItem.Text = "Purpose Name" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + "(EXISTS(SELECT 'X' FROM OBJECTPURPOSE WITH(NOLOCK) WHERE (PURPOSEID = FNFINSTRUCTURE.PURPOSEID AND " + ddlCriteria.SelectedValue + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%')))"
        ElseIf ddlCriteria.SelectedItem.Text = "Insurance Type" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + "(EXISTS(SELECT 'X' FROM PARAMGLOBAL WITH(NOLOCK) WHERE (TYPE='INSURANCETYPE') AND (CODE = FNFINSTRUCTURE.INSURANCETYPE  AND " + ddlCriteria.SelectedValue + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%')))"
        ElseIf ddlCriteria.SelectedItem.Text = "Area Name" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + "(EXISTS(SELECT 'X' FROM AREA WITH(NOLOCK) WHERE (AREAID = FNFINSTRUCTURE.AREAID AND " + ddlCriteria.SelectedValue + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%')))"
        Else
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
        End If
        If Len(Trim(ddlSearchArea.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND FNFINSTRUCTURE.AREAID=" & ddlSearchArea.SelectedValue
        End If
        If Len(Trim(ddlSearchBranch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND FNFINSTRUCTURE.BRANCHID=" & ddlSearchBranch.SelectedValue
        End If
        If Len(Trim(ddlSearchProduct.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND FNFINSTRUCTURE.PRODUCTID=" & ddlSearchProduct.SelectedValue
        End If
        If Len(Trim(ddlSearchCategory.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND FNFINSTRUCTURE.CATEGORYID=" & ddlSearchCategory.SelectedValue
        End If
        If Len(Trim(ddlSearchObjectKind.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND FNFINSTRUCTURE.PURPOSECATID=" & ddlSearchObjectKind.SelectedValue
        End If
        gvData.DataBind()
    End Sub

    Protected Sub gvData_PageIndexChanging(sender As Object, e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvData.PageIndexChanging
        DataSearch()
        gvEffRate.PageIndex = e.NewPageIndex
        If gvEffRate.Rows.Count > 0 Then
            gvEffRate.SelectedIndex = 0
        End If
    End Sub
    Protected Sub gvData_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand

        If e.CommandName = "Select" Then
            lblCaption.Text = "Edit Data"
            pnlForm.Enabled = False
            gvData.SelectedIndex = e.CommandArgument
            hidAreaID.Value = gvData.SelectedDataKey("AREAID")
         
            If Not String.IsNullOrEmpty(gvData.SelectedDataKey("BRANCHID").ToString()) Then
                hidBranchID.Value = gvData.SelectedDataKey("BRANCHID")
            Else
                hidBranchID.Value = ""
            End If
            hidProductID.Value = gvData.SelectedDataKey("PRODUCTID")
            hidPurposeCatID.Value = gvData.SelectedDataKey("PURPOSECATID")
            hidCategoryID.Value = gvData.SelectedDataKey("CATEGORYID")
            chkAddNew.Checked = False
            hidAction.Value = "EDIT"

            MultiView_Utama.SetActiveView(View_Search)
            GetData(hidAreaID.Value, hidBranchID.Value, hidProductID.Value, hidCategoryID.Value, hidPurposeCatID.Value)
            pnlControl.Visible = True
            btnSearch.Visible = False

        End If
    End Sub


    Protected Sub gvEffRate_RowCreated(sender As Object, e As GridViewRowEventArgs) Handles gvEffRate.RowCreated
        If (e.Row.RowType = DataControlRowType.Header) Then

            Dim objGridView As GridView = DirectCast(sender, GridView)
            Dim objgridviewrow As New GridViewRow(1, 0, DataControlRowType.Header, DataControlRowState.Insert)
            Dim objtablecell As New TableCell()
            AddMergedCells(objgridviewrow, objtablecell, 2, String.Empty)
            AddMergedCells(objgridviewrow, objtablecell, 4, "TENOR (MONTHS(S))")
            AddMergedCells(objgridviewrow, objtablecell, 4, "PRINCIPAL")
            AddMergedCells(objgridviewrow, objtablecell, 1, "JENIS TRAYEK")
            AddMergedCells(objgridviewrow, objtablecell, 1, "EFFECTIVE RATE(%)")
            objGridView.Controls(0).Controls.AddAt(0, objgridviewrow)
        End If

    End Sub
    Protected Sub gvDPMinimum_RowCreated(sender As Object, e As GridViewRowEventArgs)
        If (e.Row.RowType = DataControlRowType.Header) Then

            Dim objGridView As GridView = DirectCast(sender, GridView)
            Dim objgridviewrow As New GridViewRow(1, 0, DataControlRowType.Header, DataControlRowState.Insert)
            Dim objtablecell As New TableCell()
            AddMergedCells(objgridviewrow, objtablecell, 2, String.Empty)
            AddMergedCells(objgridviewrow, objtablecell, 1, "NO")
            AddMergedCells(objgridviewrow, objtablecell, 2, "BUILD YEAR")
            AddMergedCells(objgridviewrow, objtablecell, 1, "ITEM<br>CONDITION")
            AddMergedCells(objgridviewrow, objtablecell, 1, "DP MIN(%)")
            AddMergedCells(objgridviewrow, objtablecell, 1, "DESCRIPTION")
            objGridView.Controls(0).Controls.AddAt(0, objgridviewrow)
        End If

    End Sub
#Region "Methods"
    Private Sub AddMergedCells(objgridviewrow As GridViewRow, objtablecell As TableCell, colspan As Integer, celltext As String)
        objtablecell = New TableCell()
        objtablecell.Text = celltext
        objtablecell.ColumnSpan = colspan
        objtablecell.HorizontalAlign = HorizontalAlign.Center
        objtablecell.BorderWidth = "1"
        objgridviewrow.Cells.Add(objtablecell)
    End Sub
#End Region
    Protected Sub btnNewDP_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs)
        Try

            Dim dtDPMinimum As New System.Data.DataTable
            Dim drDPMinimum As System.Data.DataRow

            dtDPMinimum = ViewState("VW_DPMINIMUM")

            GetDataDPMinimum(dtDPMinimum)
            drDPMinimum = dtDPMinimum.NewRow()

            drDPMinimum("AREAID") = "0"
            drDPMinimum("BRANCHID") = "0"
            drDPMinimum("PRODUCTID") = "0"
            drDPMinimum("PURPOSECATID") = "0"
            drDPMinimum("CATEGORYID") = "0"

            drDPMinimum("FINID") = "0"
            drDPMinimum("YEARFROM") = ""
            drDPMinimum("YEARTO") = ""

            drDPMinimum("CONDITION") = ""
            drDPMinimum("DP") = 0
            drDPMinimum("REMARK") = ""

            dtDPMinimum.Rows.Add(drDPMinimum)
            gvDPMinimum.DataSource = dtDPMinimum
            gvDPMinimum.DataBind()
            ViewState("VW_DPMINIMUM") = dtDPMinimum

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR NEW FINANCE STRUCTURE : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        End Try
    End Sub

    Private Sub GetDataDPMinimum(ByRef dtDPMinimum As System.Data.DataTable)

        dtDPMinimum.Clear()
        ' Dim oImageDel As ImageButton
        Dim sYEARFROM As String, sYEARTO As String, sCONDITION As String, sDP As Double, sDESCRIPTION As String
        Dim drDPMinimum As System.Data.DataRow
        Dim oTextBox As TextBox
        Dim oDropDownList As DropDownList
        Dim iFinID As String
        For Each gvRow As GridViewRow In gvDPMinimum.Rows


            iFinID = 0
            sYEARFROM = 0
            sYEARTO = 0
            sCONDITION = ""
            sDP = 0
            sDESCRIPTION = ""

            oTextBox = CType(gvRow.FindControl("txtFINID"), TextBox)
            If oTextBox IsNot Nothing Then
                iFinID = Replace(oTextBox.Text, ",", "")
            End If
            oTextBox = CType(gvRow.FindControl("txtYearFrom"), TextBox)
            If oTextBox IsNot Nothing Then
                sYEARFROM = Replace(oTextBox.Text, ",", "")
            End If
            oTextBox = CType(gvRow.FindControl("txtYearTo"), TextBox)
            If oTextBox IsNot Nothing Then
                sYEARTO = Replace(oTextBox.Text, ",", "")
            End If
            oTextBox = CType(gvRow.FindControl("txtDP"), TextBox)
            If oTextBox IsNot Nothing Then
                sDP = Replace(oTextBox.Text, ",", "")
            End If
            oDropDownList = CType(gvRow.FindControl("ddlCondition"), DropDownList)
            If oDropDownList IsNot Nothing Then
                sCONDITION = oDropDownList.SelectedValue
            End If
            oTextBox = CType(gvRow.FindControl("txtDescription"), TextBox)
            If oTextBox IsNot Nothing Then
                sDESCRIPTION = Replace(oTextBox.Text, ",", "")
            End If

            drDPMinimum = dtDPMinimum.NewRow()
            If Request.QueryString("ACTION") = "COPYAUTOMATIC" Then
                drDPMinimum("AREAID") = hidAREACopy.Value
                drDPMinimum("BRANCHID") = hidBRANCHCopy.Value
                drDPMinimum("PRODUCTID") = hidPRODUCTCopy.Value
                drDPMinimum("PURPOSECATID") = hidKINDCopy.Value
                drDPMinimum("CATEGORYID") = hidCATEGORYCopy.Value

            Else
                If chkAddNew.Checked Then
                    drDPMinimum("AREAID") = "0"
                    drDPMinimum("BRANCHID") = "0"
                    drDPMinimum("PRODUCTID") = "0"
                    drDPMinimum("PURPOSECATID") = "0"
                    drDPMinimum("CATEGORYID") = "0"
                Else
                    drDPMinimum("AREAID") = hidAreaID.Value
                    drDPMinimum("BRANCHID") = hidBranchID.Value
                    drDPMinimum("PRODUCTID") = hidProductID.Value
                    drDPMinimum("PURPOSECATID") = hidPurposeCatID.Value
                    drDPMinimum("CATEGORYID") = hidCategoryID.Value
                End If

            End If


            drDPMinimum("FINID") = iFinID
            drDPMinimum("YEARFROM") = sYEARFROM
            drDPMinimum("YEARTO") = sYEARTO
            drDPMinimum("CONDITION") = sCONDITION
            drDPMinimum("DP") = sDP
            drDPMinimum("REMARK") = sDESCRIPTION

            dtDPMinimum.Rows.Add(drDPMinimum)
            'oImageDel = DirectCast(gvDPMinimum.Rows(Convert.ToInt32(txtTmpSelectedIndex.Text)).FindControl("btnDelete"), ImageButton)
            'oImageDel.Visible = False
        Next
    End Sub
    Protected Sub imgBtnNew_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        ajaxCDDArea.SelectedValue = ddlSearchArea.SelectedValue
        ajaxCDDBranch.SelectedValue = ddlSearchBranch.SelectedValue
        ajaxCDDProduct.SelectedValue = ddlSearchProduct.SelectedValue
        ajaxCDDCategory.SelectedValue = ddlSearchCategory.SelectedValue
        ajaxCDDObjectKind.SelectedValue = ddlSearchObjectKind.SelectedValue
        chkAddNew.Checked = True
        hidAction.Value = "NEW"
        Validation.ClearPanelAplicationField(pnlForm)
        MultiView_Utama.SetActiveView(View_Search)
        lblCaption.Text = "New Data"
        pnlForm.Enabled = True

        btnSearch.Visible = True
        gvDPMinimum.DataSource = Nothing
        gvDPMinimum.DataBind()
    End Sub

    Protected Sub btnSearch_Click(sender As Object, e As System.EventArgs) Handles btnSearch.Click
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            If Len(Trim(ddlBranch.SelectedValue)) > 0 Then
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT AREAID,BRANCHID,PRODUCTID,PURPOSECATID,CATEGORYID, FINID,CAST(YEARFROM AS VARCHAR(10))YEARFROM,CAST(YEARTO AS VARCHAR(10))YEARTO, CAST(CONDITION AS VARCHAR(10)) CONDITION, DP,REMARK FROM FNFINSTRUCTURE WHERE (Deletests = 0)" & _
                                                " AND (AREAID= " & ddlArea.SelectedValue & ") AND (BRANCHID= " & ddlBranch.SelectedValue & ")" & _
                                                " AND (PRODUCTID= " & ddlProduct.SelectedValue & ") AND (PURPOSECATID= " & ddlObjectKind.SelectedValue & ")" & _
                                                " AND (CATEGORYID= " & ddlCategory.SelectedValue & ")")
            Else
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT AREAID,BRANCHID,PRODUCTID,PURPOSECATID,CATEGORYID,FINID,CAST(YEARFROM AS VARCHAR(10))YEARFROM,CAST(YEARTO AS VARCHAR(10))YEARTO, CAST(CONDITION AS VARCHAR(10)) CONDITION, DP,REMARK FROM FNFINSTRUCTURE WHERE (Deletests = 0)" & _
                                                " AND (AREAID= " & ddlArea.SelectedValue & ") AND (BRANCHID IS NULL )" & _
                                                " AND (PRODUCTID= " & ddlProduct.SelectedValue & ") AND (PURPOSECATID= " & ddlObjectKind.SelectedValue & ")" & _
                                                " AND (CATEGORYID= " & ddlCategory.SelectedValue & ")")
            End If

            If oSDR.HasRows Then
                Dim dtInsPrice As New System.Data.DataTable
                dtInsPrice.Load(oSDR)
                oSDR.Close()
                oSDR = Nothing

                If ViewState("VW_DPMINIMUM") IsNot Nothing Then
                    ViewState("VW_DPMINIMUM") = Nothing
                End If
                ViewState("VW_DPMINIMUM") = dtInsPrice
                gvDPMinimum.DataSource = dtInsPrice
                gvDPMinimum.DataBind()
            Else
                AddRowEmptyDPMinimum()
            End If
            pnlControl.Visible = True
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RETRIVE DATA (FINANCE STRUCTURE) ENTRY: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Private Sub AddRowEmptyDPMinimum()
        Dim dt As New DataTable()
        Dim dr As DataRow = Nothing
        Dim oImageDel As ImageButton

        dt.Columns.Add(New DataColumn("AREAID", GetType(String)))
        dt.Columns.Add(New DataColumn("BRANCHID", GetType(String)))
        dt.Columns.Add(New DataColumn("PRODUCTID", GetType(String)))
        dt.Columns.Add(New DataColumn("PURPOSECATID", GetType(String)))
        dt.Columns.Add(New DataColumn("CATEGORYID", GetType(String)))

        dt.Columns.Add(New DataColumn("FINID", GetType(String)))
        dt.Columns.Add(New DataColumn("YEARFROM", GetType(String)))
        dt.Columns.Add(New DataColumn("YEARTO", GetType(String)))
        dt.Columns.Add(New DataColumn("CONDITION", GetType(String)))
        dt.Columns.Add(New DataColumn("DP", GetType(String)))
        dt.Columns.Add(New DataColumn("REMARK", GetType(String)))
        dr = dt.NewRow()
        dr("AREAID") = 0
        dr("BRANCHID") = 0
        dr("PRODUCTID") = 0
        dr("PURPOSECATID") = 0
        dr("CATEGORYID") = 0

        dr("FINID") = 0
        dr("YEARFROM") = ""
        dr("YEARTO") = ""
        dr("CONDITION") = ""
        dr("DP") = 0
        dr("REMARK") = ""
        dt.Rows.Add(dr)

        ViewState("VW_DPMINIMUM") = dt

        gvDPMinimum.DataSource = dt
        gvDPMinimum.DataBind()

        oImageDel = DirectCast(gvDPMinimum.Rows(Convert.ToInt32(txtTmpSelectedIndex.Text)).FindControl("btnDelete"), ImageButton)
        oImageDel.Visible = False
    End Sub
    Protected Sub gvDPMinimum_DataBound(sender As Object, e As System.EventArgs) Handles gvDPMinimum.DataBound
        Dim oTextBox As TextBox
        For Each row As GridViewRow In gvDPMinimum.Rows
            oTextBox = CType(row.FindControl("txtYearFrom"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "Int", "[0-9]")
            End If
        Next
        For Each row As GridViewRow In gvDPMinimum.Rows
            oTextBox = CType(row.FindControl("txtYearTo"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "Int", "[0-9]")
            End If
        Next
        For Each row As GridViewRow In gvDPMinimum.Rows
            oTextBox = CType(row.FindControl("txtDP"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If
        Next
    End Sub

    Protected Sub gvDPMinimum_PageIndexChanging(sender As Object, e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvDPMinimum.PageIndexChanging
        gvDPMinimum.PageIndex = e.NewPageIndex
        Dim dt As DataTable = DirectCast(ViewState("VW_DPMINIMUM"), DataTable)
        gvDPMinimum.DataSource = dt
        gvDPMinimum.DataBind()
        If gvDPMinimum.Rows.Count > 0 Then
            gvDPMinimum.SelectedIndex = 0
        End If
        lblMessage.Visible = False
    End Sub

    Protected Sub btnbackView_Click(sender As Object, e As System.EventArgs) Handles btnbackView.Click
        MultiView_Utama.SetActiveView(View_View)
        lblMessage.Visible = False
        hidAction.Value = ""
        hidFinID.Value = ""
    End Sub

    Private Sub GetData(ByVal sAreaID As String, ByVal sBranchID As String, ByVal sProductID As String,
                        ByVal sCategoryID As String, ByVal sPurposeCatID As String)
        Dim objDB As New DBX
        Try

            Dim oSDR As System.Data.SqlClient.SqlDataReader
            ' Response.Write(sBranchID)
            If Len(Trim(sBranchID)) <= 0 Then
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT  * " & _
              "  FROM dbo.FNFINSTRUCTURE WITH(NOLOCK) WHERE AREAID=" & sAreaID & _
              " AND PRODUCTID =" & sProductID & " AND PURPOSECATID=" & sPurposeCatID & " AND CATEGORYID = " & sCategoryID & " AND BRANCHID IS NULL AND DeleteSts=0 ORDER BY YEARFROM, YEARTO")
            Else
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT  * " & _
              "  FROM dbo.FNFINSTRUCTURE WITH(NOLOCK) WHERE AREAID=" & sAreaID & " AND BRANCHID = " & sBranchID & _
              " AND PRODUCTID =" & sProductID & " AND PURPOSECATID=" & sPurposeCatID & " AND CATEGORYID = " & sCategoryID & " AND DeleteSts=0 ORDER BY YEARFROM, YEARTO")
            End If

            If oSDR.Read Then
                If Not String.IsNullOrEmpty(oSDR("AREAID").ToString()) Then
                    ajaxCDDArea.SelectedValue = oSDR("AREAID").ToString()
                    '  ddlArea.SelectedValue = ajaxCDDArea.SelectedValue
                Else
                    ajaxCDDArea.SelectedValue = 0
                End If
                If Not String.IsNullOrEmpty(oSDR("BRANCHID").ToString()) Then
                    ajaxCDDBranch.SelectedValue = oSDR("BRANCHID").ToString()
                Else
                    ajaxCDDBranch.SelectedValue = ""
                End If
                If Not String.IsNullOrEmpty(oSDR("PRODUCTID").ToString()) Then
                    ajaxCDDProduct.SelectedValue = oSDR("PRODUCTID").ToString()
                Else
                    ajaxCDDProduct.SelectedValue = 0
                End If
                If Not String.IsNullOrEmpty(oSDR("CATEGORYID").ToString()) Then
                    ajaxCDDCategory.SelectedValue = oSDR("CATEGORYID").ToString()
                Else
                    ajaxCDDCategory.SelectedValue = 0
                End If
                If Not String.IsNullOrEmpty(oSDR("PURPOSECATID").ToString()) Then
                    ajaxCDDObjectKind.SelectedValue = oSDR("PURPOSECATID").ToString()
                Else
                    ajaxCDDObjectKind.SelectedValue = 0
                End If

                oSDR.Close()
                oSDR = Nothing

                If sBranchID = "" Then
                    oSDR = objDB.CreateSDRFromSQLSelect("SELECT AREAID,CAST(BRANCHID AS VARCHAR(10)) AS BRANCHID,PRODUCTID,PURPOSECATID,CATEGORYID,FINID,CAST(YEARFROM AS VARCHAR(10))YEARFROM,CAST(YEARTO AS VARCHAR(10))YEARTO, CAST(CONDITION AS VARCHAR(10))AS CONDITION, DP,REMARK FROM FNFINSTRUCTURE WHERE (Deletests = 0)" & _
                                                    " AND (AREAID= " & sAreaID & ") AND (BRANCHID IS NULL )" & _
                                                    " AND (PRODUCTID= " & sProductID & ") AND (PURPOSECATID= " & sPurposeCatID & ")" & _
                                                    " AND (CATEGORYID= " & sCategoryID & ")")
                Else
                    oSDR = objDB.CreateSDRFromSQLSelect("SELECT AREAID,CAST(BRANCHID AS VARCHAR(10)) AS BRANCHID,PRODUCTID,PURPOSECATID,CATEGORYID,FINID,CAST(YEARFROM AS VARCHAR(10))YEARFROM,CAST(YEARTO AS VARCHAR(10))YEARTO, CAST(CONDITION AS VARCHAR(10))AS CONDITION, DP,REMARK FROM FNFINSTRUCTURE WHERE (Deletests = 0)" & _
                                                   " AND (AREAID= " & sAreaID & ") AND (BRANCHID= " & sBranchID & ")" & _
                                                   " AND (PRODUCTID= " & sProductID & ") AND (PURPOSECATID= " & sPurposeCatID & ")" & _
                                                   " AND (CATEGORYID= " & sCategoryID & ")")
                End If
                If oSDR.HasRows Then
                    Dim dtInsPrice As New System.Data.DataTable
                    dtInsPrice.Load(oSDR)
                    oSDR.Close()
                    oSDR = Nothing

                    If ViewState("VW_DPMINIMUM") IsNot Nothing Then
                        ViewState("VW_DPMINIMUM") = Nothing
                    End If
                    ViewState("VW_DPMINIMUM") = dtInsPrice
                    gvDPMinimum.DataSource = dtInsPrice
                    gvDPMinimum.DataBind()
                Else
                    AddRowEmptyDPMinimum()
                End If
            Else
                lblMessage.Visible = True
                lblMessage.Text = "FINANCE STRUCTURE NOT ALREADY EXIST..!"
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RETRIVE DATA (FINANCE STRUCTURE) ENTRY: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Protected Sub ddlSearchBranch_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlSearchBranch.SelectedIndexChanged
        DataSearch()
    End Sub

    Protected Sub ddlSearchCategory_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlSearchCategory.SelectedIndexChanged
        DataSearch()
    End Sub

    Protected Sub ddlSearchObjectKind_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlSearchObjectKind.SelectedIndexChanged
        DataSearch()
    End Sub

    Protected Sub ddlSearchArea_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlSearchArea.SelectedIndexChanged
        ddlSearchBranch.DataBind()
        DataSearch()
    End Sub

    Protected Sub gvDPMinimum_RowDeleting(sender As Object, e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles gvDPMinimum.RowDeleting
        Dim dtDPMinimum As New System.Data.DataTable
        dtDPMinimum = ViewState("VW_DPMINIMUM")
        GetDataDPMinimum(dtDPMinimum)
        dtDPMinimum = ViewState("VW_DPMINIMUM")
        dtDPMinimum.Rows.RemoveAt(e.RowIndex)
        dtDPMinimum.AcceptChanges()

        ViewState("VW_DPMINIMUM") = dtDPMinimum
        gvDPMinimum.DataSource = dtDPMinimum
        gvDPMinimum.DataBind()
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        Dim objDB As New DBX
        Dim oSDR As Data.SqlClient.SqlDataReader
        lblMessage.Text = ""
        lblMessage.Visible = False

        If DirectCast(ViewState("VW_DPMINIMUM"), DataTable) IsNot Nothing Then

            If Len(Trim(ddlBranch.SelectedValue)) > 0 Then
                oSDR = objDB.CreateSDRFromExecSQL("Update dbo.FNFINSTRUCTURE SET DeleteSTS=1 WHERE AREAID=" & ddlArea.SelectedValue & _
                                            " AND BRANCHID= " & ddlBranch.SelectedValue & " AND PRODUCTID =" & ddlProduct.SelectedValue & _
                                             " AND PURPOSECATID= " & ddlObjectKind.SelectedValue & " AND CATEGORYID =" & ddlCategory.SelectedValue)
            Else
                oSDR = objDB.CreateSDRFromExecSQL("Update dbo.FNFINSTRUCTURE SET DeleteSTS=1 WHERE AREAID=" & ddlArea.SelectedValue & _
                                            " AND PRODUCTID =" & ddlProduct.SelectedValue & _
                                             " AND PURPOSECATID= " & ddlObjectKind.SelectedValue & " AND CATEGORYID =" & ddlCategory.SelectedValue)
            End If

            If oSDR.Read() Then
            End If
            oSDR.Close()
            oSDR = Nothing
            Dim dtInsPricingSave As New System.Data.DataTable
            dtInsPricingSave = ViewState("VW_DPMINIMUM")
            GetDataDPMinimum(dtInsPricingSave)
            For Each row As System.Data.DataRow In dtInsPricingSave.Rows
                If row.Item("YEARFROM").ToString() > "0" Then
                    If chkAddNew.Checked = True Then
                        SaveFinanceStructure(ddlArea.SelectedValue, ddlBranch.SelectedValue, ddlProduct.SelectedValue,
                                     ddlObjectKind.SelectedValue, ddlCategory.SelectedValue, row.Item("FINID").ToString(),
                                    row.Item("YEARFROM").ToString(),
                                    row.Item("YEARTO").ToString(),
                                    row.Item("CONDITION").ToString(),
                                    row.Item("DP").ToString(),
                                    row.Item("REMARK").ToString())
                    Else
                        SaveFinanceStructure(hidAreaID.Value, hidBranchID.Value, hidProductID.Value,
                                    hidPurposeCatID.Value, hidCategoryID.Value, row.Item("FINID").ToString(),
                                   row.Item("YEARFROM").ToString(),
                                   row.Item("YEARTO").ToString(),
                                   row.Item("CONDITION").ToString(),
                                   row.Item("DP").ToString(),
                                   row.Item("REMARK").ToString())
                    End If

                End If
            Next
        End If

        If DirectCast(ViewState("VW_DPMINIMUM"), DataTable) Is Nothing Then
        Else
            DirectCast(ViewState("VW_DPMINIMUM"), DataTable).Rows.Clear()
            DirectCast(ViewState("VW_DPMINIMUM"), DataTable).Dispose()
        End If
        GetData(ddlArea.SelectedValue, ddlBranch.SelectedValue, ddlProduct.SelectedValue, ddlCategory.SelectedValue, ddlObjectKind.SelectedValue)
        ' MultiView_Utama.SetActiveView(View_View)
        'DataSearch()
    End Sub
    Private Sub SaveFinanceStructure(ByVal iAreaID As Integer, ByVal iBranchID As String, ByVal iProductID As Integer,
                                        ByVal iPurposeCatID As Integer, ByVal iCategoryID As Integer,
                                        ByVal iFinID As Integer, ByVal iYearFrom As Integer,
                                        ByVal iYearTo As Integer, ByVal iCondition As Integer,
                                        ByVal sDP As String, ByVal sRemark As String)

        Dim objDB As New DBX
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try

            oSQLParam = objDB.ExecSPReturnParam("FNFINSTRUCTURESave", _
                   objDB.MP("@FINID", Data.SqlDbType.BigInt, iFinID, 8), _
                   objDB.MP("@DEALERID", Data.SqlDbType.Int, "", 4), _
                   objDB.MP("@AREAID", Data.SqlDbType.Int, iAreaID, 4), _
                   objDB.MP("@BRANCHID", Data.SqlDbType.Int, iBranchID, 4), _
                   objDB.MP("@PRODUCTID", Data.SqlDbType.Int, iProductID, 4), _
                   objDB.MP("@PURPOSECATID", Data.SqlDbType.Int, iPurposeCatID, 4), _
                   objDB.MP("@CATEGORYID", Data.SqlDbType.Int, iCategoryID, 4), _
                   objDB.MP("@YEARFROM", Data.SqlDbType.Int, iYearFrom, 5), _
                   objDB.MP("@YEARTO", Data.SqlDbType.Int, iYearTo, 5), _
                   objDB.MP("@CONDITION", Data.SqlDbType.Int, iCondition, 4), _
                   objDB.MP("@DP", Data.SqlDbType.Money, sDP, 20), _
                   objDB.MP("@REMARK", Data.SqlDbType.VarChar, sRemark, 100), _
                   objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 20))
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE DATA FINANCING STRUCTURE : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnFNDetail_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        Dim currentCommand As String = e.CommandName
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument)
        Try
            hidFinID.Value = CType(gvDPMinimum.Rows(currentRowIndex).FindControl("txtFINID"), TextBox).Text
            MultiView_Utama.SetActiveView(View_Detail)
            GetDataDetail(hidFinID.Value)
            pnlControlIntRate.Visible = True
        Catch ex As Exception
            lblMessageIntRate.Visible = True
            lblMessageIntRate.Text = "ERROR RETRIEVE DATA FINANCING STRUCTURE DETAIL : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        End Try

    End Sub

    Private Sub GetDataDetail(ByVal iFinID As String)
        Dim objDB As New DBX
        Dim oSDR As Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT FINID,FINDTLID, TENOROPR1,TENORFROM,TENOROPR2,TENORTO,PRINCIPALOPR1,PRINCIPALFROM, PRINCIPALOPR2 ,PRINCIPALTO,EFFRATE,CAST(ROUTEKIND AS VARCHAR(10)) ROUTEKIND FROM FNFINSTRUCTUREDTL WHERE (Deletests = 0)" & _
                                                " AND (FINID= " & iFinID & ") ORDER BY TENORFROM ASC")

            If oSDR.HasRows Then
                Dim dtEffectiveRate As New System.Data.DataTable
                dtEffectiveRate.Load(oSDR)
                oSDR.Close()
                oSDR = Nothing

                If ViewState("VW_EFFECTIVERATE") IsNot Nothing Then
                    ViewState("VW_EFFECTIVERATE") = Nothing
                End If
                ViewState("VW_EFFECTIVERATE") = dtEffectiveRate
                gvEffRate.DataSource = dtEffectiveRate
                gvEffRate.DataBind()
            Else
                AddRowEmptyEffRate()
            End If
        Catch ex As Exception
            lblMessageIntRate.Visible = True
            lblMessageIntRate.Text = "ERROR BIND DATA FINANCING STRUCTURE DETAIL : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        End Try
    End Sub
    Private Sub AddRowEmptyEffRate()
        Dim dt As New DataTable()
        Dim dr As DataRow = Nothing
        Dim oImageDel As ImageButton

        dt.Columns.Add(New DataColumn("FINID", GetType(String)))
        dt.Columns.Add(New DataColumn("FINDTLID", GetType(String)))
        dt.Columns.Add(New DataColumn("TENOROPR1", GetType(String)))
        dt.Columns.Add(New DataColumn("TENORFROM", GetType(String)))
        dt.Columns.Add(New DataColumn("TENOROPR2", GetType(String)))
        dt.Columns.Add(New DataColumn("TENORTO", GetType(String)))

        dt.Columns.Add(New DataColumn("PRINCIPALOPR1", GetType(String)))
        dt.Columns.Add(New DataColumn("PRINCIPALFROM", GetType(String)))
        dt.Columns.Add(New DataColumn("PRINCIPALOPR2", GetType(String)))
        dt.Columns.Add(New DataColumn("PRINCIPALTO", GetType(String)))
        dt.Columns.Add(New DataColumn("EFFRATE", GetType(String)))
        dt.Columns.Add(New DataColumn("ROUTEKIND", GetType(String)))
        dr = dt.NewRow()
        dr("FINID") = 0
        dr("FINDTLID") = 0
        dr("TENOROPR1") = ""
        dr("TENORFROM") = ""
        dr("TENOROPR2") = ""
        dr("TENORTO") = ""

        dr("PRINCIPALOPR1") = ""
        dr("PRINCIPALFROM") = 0
        dr("PRINCIPALOPR2") = ""
        dr("PRINCIPALTO") = 0
        dr("EFFRATE") = 0
        dr("ROUTEKIND") = ""
        dt.Rows.Add(dr)

        ViewState("VW_EFFECTIVERATE") = dt

        gvEffRate.DataSource = dt
        gvEffRate.DataBind()

        oImageDel = DirectCast(gvEffRate.Rows(Convert.ToInt32(txtTmpSelectedIndex.Text)).FindControl("btnDelete"), ImageButton)
        oImageDel.Visible = False
    End Sub

    Protected Sub btnBackIntRate_Click(sender As Object, e As System.EventArgs) Handles btnBackIntRate.Click
        MultiView_Utama.SetActiveView(View_Search)
        lblMessageIntRate.Visible = False

        If DirectCast(ViewState("VW_EFFECTIVERATE"), DataTable) Is Nothing Then
        Else
            DirectCast(ViewState("VW_EFFECTIVERATE"), DataTable).Rows.Clear()
            DirectCast(ViewState("VW_EFFECTIVERATE"), DataTable).Dispose()
        End If
    End Sub
    Protected Sub btnNewEffRate_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs)
        Try

            Dim dtEffRate As New System.Data.DataTable
            Dim drEffRate As System.Data.DataRow

            dtEffRate = ViewState("VW_EFFECTIVERATE")
            GetDataEffRate(dtEffRate)
            drEffRate = dtEffRate.NewRow()


            drEffRate("FINDTLID") = "0"
            drEffRate("FINID") = "0"
            drEffRate("TENOROPR1") = ""
            drEffRate("TENORFROM") = 0
            drEffRate("TENOROPR2") = ""
            drEffRate("TENORTO") = 0
            drEffRate("PRINCIPALOPR1") = ""
            drEffRate("PRINCIPALFROM") = 0
            drEffRate("PRINCIPALOPR2") = ""

            drEffRate("PRINCIPALTO") = 0
            drEffRate("ROUTEKIND") = ""
            drEffRate("EFFRATE") = 0

            dtEffRate.Rows.Add(drEffRate)
            gvEffRate.DataSource = dtEffRate
            gvEffRate.DataBind()
            ViewState("VW_EFFECTIVERATE") = dtEffRate

        Catch ex As Exception
            lblMessageIntRate.Visible = True
            lblMessageIntRate.Text = "ERROR NEW FINANCE STRUCTURE DETAIL : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        End Try
    End Sub

    Protected Sub gvEffRate_DataBound(sender As Object, e As System.EventArgs) Handles gvEffRate.DataBound
        Dim oTextBox As TextBox
        For Each row As GridViewRow In gvEffRate.Rows
            oTextBox = CType(row.FindControl("txtPrincipalTo"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If
        Next
        For Each row As GridViewRow In gvEffRate.Rows
            oTextBox = CType(row.FindControl("txtEffRate"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If
        Next
        For Each row As GridViewRow In gvEffRate.Rows
            oTextBox = CType(row.FindControl("txtPrincipalFrom"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If
        Next
        For Each row As GridViewRow In gvEffRate.Rows
            oTextBox = CType(row.FindControl("txtTenorFrom"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "integer", "[0-9]")
            End If
        Next
        For Each row As GridViewRow In gvEffRate.Rows
            oTextBox = CType(row.FindControl("txtTenorTo"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "integer", "[0-9]")
            End If
        Next
    End Sub
    Private Sub GetDataEffRate(ByRef dtEffectiveRate As System.Data.DataTable)

        dtEffectiveRate.Clear()
        Dim sTenorOPR1 As String, sTenorFrom As String, sTenorOPR2 As String, sTenorTo As String, sPrincipalOPR1 As String, sPrincipalFrom As String, sPrincipalOPR2 As String
        Dim sPrincipalTo As String, sRouteKind As String, sEffRate As String
        Dim drEffectiveRate As System.Data.DataRow
        Dim oTextBox As TextBox
        Dim oLabel As Label
        Dim oDropDownList As DropDownList
        Dim iFinDtlID As String
        For Each gvRow As GridViewRow In gvEffRate.Rows

            iFinDtlID = 0
            sTenorOPR1 = ""
            sTenorFrom = 0
            sTenorOPR2 = ""
            sTenorTo = 0
            sPrincipalOPR1 = ""
            sPrincipalFrom = 0
            sPrincipalOPR2 = ""
            sPrincipalTo = 0
            sRouteKind = ""
            sEffRate = 0

            oLabel = CType(gvRow.FindControl("lblFindtlKey"), Label)
            If oLabel IsNot Nothing Then
                iFinDtlID = Replace(oLabel.Text, ",", "")
            End If
            oDropDownList = CType(gvRow.FindControl("ddlOprFrTenor"), DropDownList)
            If oDropDownList IsNot Nothing Then
                sTenorOPR1 = oDropDownList.SelectedValue
            End If
            oTextBox = CType(gvRow.FindControl("txtTenorFrom"), TextBox)
            If oTextBox IsNot Nothing Then
                sTenorFrom = Replace(oTextBox.Text, ",", "")
            End If
            oDropDownList = CType(gvRow.FindControl("ddlOprToTenor"), DropDownList)
            If oDropDownList IsNot Nothing Then
                sTenorOPR2 = oDropDownList.SelectedValue
            End If
            oTextBox = CType(gvRow.FindControl("txtTenorTo"), TextBox)
            If oTextBox IsNot Nothing Then
                sTenorTo = Replace(oTextBox.Text, ",", "")
            End If
            oDropDownList = CType(gvRow.FindControl("ddlOprFromPrincipal"), DropDownList)
            If oDropDownList IsNot Nothing Then
                sPrincipalOPR1 = oDropDownList.SelectedValue
            End If
            oTextBox = CType(gvRow.FindControl("txtPrincipalFrom"), TextBox)
            If oTextBox IsNot Nothing Then
                sPrincipalFrom = Replace(oTextBox.Text, ",", "")
            End If
            oDropDownList = CType(gvRow.FindControl("ddlOprToPrincipal"), DropDownList)
            If oDropDownList IsNot Nothing Then
                sPrincipalOPR2 = oDropDownList.SelectedValue
            End If
            oTextBox = CType(gvRow.FindControl("txtPrincipalTo"), TextBox)
            If oTextBox IsNot Nothing Then
                sPrincipalTo = Replace(oTextBox.Text, ",", "")
            End If
            oDropDownList = CType(gvRow.FindControl("ddlJnsTrayek"), DropDownList)
            If oDropDownList IsNot Nothing Then
                sRouteKind = oDropDownList.SelectedValue
            End If
            oTextBox = CType(gvRow.FindControl("txtEffRate"), TextBox)
            If oTextBox IsNot Nothing Then
                sEffRate = Replace(oTextBox.Text, ",", "")
            End If
            drEffectiveRate = dtEffectiveRate.NewRow()

            drEffectiveRate("FINID") = hidFinID.Value

            drEffectiveRate("FINDTLID") = iFinDtlID
            drEffectiveRate("TENOROPR1") = sTenorOPR1
            drEffectiveRate("TENORFROM") = sTenorFrom
            drEffectiveRate("TENOROPR2") = sTenorOPR2
            drEffectiveRate("TENORTO") = sTenorTo

            drEffectiveRate("PRINCIPALOPR1") = sPrincipalOPR1
            drEffectiveRate("PRINCIPALFROM") = String.Format("{0:N}", sPrincipalFrom)
            drEffectiveRate("PRINCIPALOPR2") = sPrincipalOPR2
            drEffectiveRate("PRINCIPALTO") = String.Format("{0:N}", sPrincipalTo)
            drEffectiveRate("ROUTEKIND") = sRouteKind
            drEffectiveRate("EFFRATE") = String.Format("{0:N}", sEffRate)

            dtEffectiveRate.Rows.Add(drEffectiveRate)
            'oImageDel = DirectCast(gvDPMinimum.Rows(Convert.ToInt32(txtTmpSelectedIndex.Text)).FindControl("btnDelete"), ImageButton)
            'oImageDel.Visible = False
        Next
    End Sub

    Private Sub SaveFinanceStructureDtl(ByVal iFinID As Integer, ByVal iFinDtlID As String, ByVal sTenorOPR1 As String,
                                        ByVal iTenorFrom As String, ByVal sTenorOPR2 As String,
                                        ByVal iTenorTo As String, ByVal sPrincipalOPR1 As String,
                                        ByVal iPrincipalFrom As String, ByVal sPrincipalOPR2 As String,
                                        ByVal iPrincipalTo As String, ByVal iEffRate As String, ByVal iRouteKind As String)

        Dim objDB As New DBX
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try

            oSQLParam = objDB.ExecSPReturnParam("FNFINSTRUCTUREDTLSave", _
                   objDB.MP("@FINID", Data.SqlDbType.BigInt, iFinID, 8), _
                   objDB.MP("@FINDTLID", Data.SqlDbType.Int, iFinDtlID, 8), _
                   objDB.MP("@TENOROPR1", Data.SqlDbType.VarChar, sTenorOPR1, 4), _
                   objDB.MP("@TENORFROM", Data.SqlDbType.Int, iTenorFrom, 4), _
                   objDB.MP("@TENOROPR2", Data.SqlDbType.VarChar, sTenorOPR2, 4), _
                   objDB.MP("@TENORTO", Data.SqlDbType.Int, iTenorTo, 4), _
                   objDB.MP("@PRINCIPALOPR1", Data.SqlDbType.VarChar, sPrincipalOPR1, 4), _
                   objDB.MP("@PRINCIPALFROM", Data.SqlDbType.Money, iPrincipalFrom, 20), _
                   objDB.MP("@PRINCIPALOPR2", Data.SqlDbType.VarChar, sPrincipalOPR2, 4), _
                   objDB.MP("@PRINCIPALTO", Data.SqlDbType.Money, iPrincipalTo, 20), _
                   objDB.MP("@EFFRATE", Data.SqlDbType.Money, iEffRate, 20), _
                   objDB.MP("@ROUTEKIND", Data.SqlDbType.VarChar, iRouteKind, 4), _
                   objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 20))
        Catch ex As Exception
            lblMessageIntRate.Visible = True
            lblMessageIntRate.Text = "ERROR SAVE DATA FINANCING STRUCTURE DETAIL : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub gvEffRate_PageIndexChanging(sender As Object, e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvEffRate.PageIndexChanging
        gvEffRate.PageIndex = e.NewPageIndex
        Dim dt As DataTable = DirectCast(ViewState("VW_EFFECTIVERATE"), DataTable)
        gvEffRate.DataSource = dt
        gvEffRate.DataBind()
        If gvEffRate.Rows.Count > 0 Then
            gvEffRate.SelectedIndex = 0
        End If
        lblMessageIntRate.Visible = False
    End Sub

    Protected Sub btnSaveIntRate_Click(sender As Object, e As System.EventArgs) Handles btnSaveIntRate.Click
        Dim objDB As New DBX
        Try

            If DirectCast(ViewState("VW_EFFECTIVERATE"), DataTable) IsNot Nothing Then
                objDB.ExecSQLWithParam("Update dbo.FNFINSTRUCTUREDTL SET DeleteSTS=1,  LastUpdate=getdate() WHERE FINID=@FINID",
                            objDB.MP("@FINID", SqlDbType.BigInt, hidFinID.Value))
                Dim dtIntRate As New System.Data.DataTable
                dtIntRate = ViewState("VW_EFFECTIVERATE")
                GetDataEffRate(dtIntRate)
                For Each row As System.Data.DataRow In dtIntRate.Rows
                    '     Response.Write(dtIntRate.Rows.Count)
                    If row.Item("TENOROPR1").ToString() <> "" Then
                        SaveFinanceStructureDtl(hidFinID.Value, row.Item("FINDTLID").ToString(),
                            row.Item("TENOROPR1").ToString(),
                            row.Item("TENORFROM").ToString(),
                            row.Item("TENOROPR2").ToString(),
                            row.Item("TENORTO").ToString(),
                            row.Item("PRINCIPALOPR1").ToString(),
                            row.Item("PRINCIPALFROM").ToString(),
                            row.Item("PRINCIPALOPR2").ToString(),
                            row.Item("PRINCIPALTO").ToString(),
                            row.Item("EFFRATE").ToString(),
                            row.Item("ROUTEKIND").ToString())
                    End If
                Next
            End If

            If DirectCast(ViewState("VW_EFFECTIVERATE"), DataTable) Is Nothing Then
            Else
                DirectCast(ViewState("VW_EFFECTIVERATE"), DataTable).Rows.Clear()
                DirectCast(ViewState("VW_EFFECTIVERATE"), DataTable).Dispose()
            End If
            MultiView_Utama.SetActiveView(View_Search)
        Catch ex As Exception
            lblMessageIntRate.Visible = True
            lblMessageIntRate.Text = "ERROR SAVE FINANCE STRUCTURE DETAIL : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub gvEffRate_RowDeleting(sender As Object, e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles gvEffRate.RowDeleting
        Dim dtEffRate As New System.Data.DataTable
        dtEffRate = ViewState("VW_EFFECTIVERATE")
        GetDataEffRate(dtEffRate)
        dtEffRate = ViewState("VW_EFFECTIVERATE")
        dtEffRate.Rows.RemoveAt(e.RowIndex)
        dtEffRate.AcceptChanges()

        ViewState("VW_EFFECTIVERATE") = dtEffRate
        gvEffRate.DataSource = dtEffRate
        gvEffRate.DataBind()
    End Sub

    Protected Sub ddlSearchProduct_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlSearchProduct.SelectedIndexChanged
        ddlSearchCategory.DataBind()
        ddlSearchObjectKind.DataBind()
        DataSearch()
    End Sub



    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub


    Protected Sub btnDelete_Command(sender As Object, e As System.Web.UI.WebControls.CommandEventArgs)
        If e.CommandName = "Delete" Then
            Dim objDB As New DBX

            Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument)
            Try
                hidFinID.Value = CType(gvDPMinimum.Rows(currentRowIndex).FindControl("txtFINID"), TextBox).Text
                objDB.ExecSQLWithParam("UPDATE FNFINSTRUCTURE SET DeleteSts=1, LastUpdate=GETDATE(), LastUserId=@USERID WHERE FINID=@FINID", _
                        objDB.MP("@USERID", SqlDbType.Int, Request.Cookies("UID").Value),
                        objDB.MP("@FINID", SqlDbType.BigInt, hidFinID.Value)
                        )
            Catch ex As Exception
                lblMessageIntRate.Visible = True
                lblMessageIntRate.Text = "ERROR DELETE DATA FINANCING STRUCTURE  : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            Finally
                objDB.Close()
                objDB = Nothing
            End Try

        End If
    End Sub



    Protected Sub btnDeleteDtl_Command(sender As Object, e As System.Web.UI.WebControls.CommandEventArgs)
        If e.CommandName = "Delete" Then
            Dim objDB As New DBX

            Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument)
            Try
                gvEffRate.SelectedIndex = e.CommandArgument
                'Response.Write(gvEffRate.SelectedDataKey("FINDTLID"))
                'Response.End()


                objDB.ExecSQLWithParam("UPDATE FNFINSTRUCTUREDTL SET DeleteSts=1, LastUpdate=GETDATE(), LastUserId=@USERID WHERE FINDTLID=@FINDTLID AND FINID=@FINID", _
                        objDB.MP("@USERID", SqlDbType.Int, Request.Cookies("UID").Value),
                        objDB.MP("@FINDTLID", SqlDbType.BigInt, gvEffRate.SelectedDataKey("FINDTLID")),
                        objDB.MP("@FINID", SqlDbType.BigInt, hidFinID.Value)
                        )
            Catch ex As Exception
                lblMessageIntRate.Visible = True
                lblMessageIntRate.Text = "ERROR DELETE DATA FINANCING STRUCTURE DETAIL : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            Finally
                objDB.Close()
                objDB = Nothing
            End Try

        End If

    End Sub
End Class
