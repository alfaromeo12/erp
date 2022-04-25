Imports System.Data
Imports System.Data.SqlClient
Partial Class Param_OTR
    Inherits System.Web.UI.Page
    Private dt As New DataTable
    Private dr As DataRow

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            MultiView_Utama.SetActiveView(View_View)
        End If

        If ViewState("VSShare") IsNot Nothing Then
            ViewState("VSShare") = Nothing
        End If
    End Sub
    Protected Sub Page_PreInit(sender As Object, e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub
    
    Protected Sub gvOTR_RowCreated(sender As Object, e As GridViewRowEventArgs)
        If (e.Row.RowType = DataControlRowType.Header) Then

            Dim objGridView As GridView = DirectCast(sender, GridView)
            Dim objgridviewrow As New GridViewRow(1, 0, DataControlRowType.Header, DataControlRowState.Insert)
            Dim objtablecell As New TableCell()
            AddMergedCells(objgridviewrow, objtablecell, 1, String.Empty)
            AddMergedCells(objgridviewrow, objtablecell, 1, "NO")
            AddMergedCells(objgridviewrow, objtablecell, 2, "BUILD YEAR")
            AddMergedCells(objgridviewrow, objtablecell, 1, "ITEM<br>CONDITION")
            AddMergedCells(objgridviewrow, objtablecell, 1, "Recommended OTR")
            AddMergedCells(objgridviewrow, objtablecell, 1, "Principal")
            objGridView.Controls(0).Controls.AddAt(0, objgridviewrow)
        End If

    End Sub
#Region "Methods"
    Private Sub AddMergedCells(objgridviewrow As GridViewRow, objtablecell As TableCell, colspan As Integer, celltext As String)
        objtablecell = New TableCell()
        objtablecell.Text = celltext
        objtablecell.ColumnSpan = colspan
        objtablecell.BorderWidth = "1"
        objtablecell.HorizontalAlign = HorizontalAlign.Center
        objgridviewrow.Cells.Add(objtablecell)
    End Sub
#End Region

    Protected Sub btnSearch_Click(sender As Object, e As System.EventArgs) Handles btnSearch.Click
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            ajaxCDDProduct.SelectedValue = ddlSearchProduct.SelectedValue
            ajaxCDDMerk.SelectedValue = ddlSearchMerk.SelectedValue
            ajaxCDDModel.SelectedValue = ddlSearchModel.SelectedValue
            ajaxCDDType.SelectedValue = ddlSearchType.SelectedValue
            hidTypeID.Value = ddlSearchType.SelectedValue
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT OBJECTVALUEID,CAST(OBJECTTYPEID AS VARCHAR(10))OBJECTTYPEID,CAST(YEARFROM AS VARCHAR(5))YEARFROM, CAST(YEARTO AS VARCHAR(5))YEARTO,CAST(CONDITION AS VARCHAR(10)) CONDITION, RECOMMENDEDVALUE,RECOMMENDEDPRINCIPAL FROM FNOBJECTVALUE WHERE (Deletests = 0)" & _
                                            " AND (OBJECTTYPEID= " & ddlSearchType.SelectedValue & ") ORDER BY YEARFROM, YEARTO")
            If oSDR.HasRows Then
                Dim dtOTR As New System.Data.DataTable
                dtOTR.Load(oSDR)
                oSDR.Close()
                oSDR = Nothing

                If ViewState("VW_OTR") IsNot Nothing Then
                    ViewState("VW_OTR") = Nothing
                End If
                ViewState("VW_OTR") = dtOTR
                gvOTR.DataSource = dtOTR
                gvOTR.DataBind()
                lblCaption.Text = "EDIT RECOMMENDED OTR"
                pnlData.Enabled = False
            Else
                gvOTR.DataSource = Nothing
                gvOTR.DataBind()
                lblCaption.Text = "NEW RECOMMENDED OTR"
                AddRowEmptyOTR()
                pnlData.Enabled = False

            End If
            hidAction.Value = "EDIT"
            MultiView_Utama.SetActiveView(View_OTR)
            pnlControl.Visible = True
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RETRIVE DATA (OTR) ENTRY: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Private Sub AddRowEmptyOTR()
        Dim dt As New DataTable()
        Dim dr As DataRow = Nothing
        Dim oImageDel As ImageButton

        dt.Columns.Add(New DataColumn("OBJECTVALUEID", GetType(String)))
        dt.Columns.Add(New DataColumn("OBJECTTYPEID", GetType(String)))
        dt.Columns.Add(New DataColumn("YEARFROM", GetType(String)))
        dt.Columns.Add(New DataColumn("YEARTO", GetType(String)))
        dt.Columns.Add(New DataColumn("CONDITION", GetType(String)))
        dt.Columns.Add(New DataColumn("RECOMMENDEDVALUE", GetType(String)))
        dt.Columns.Add(New DataColumn("RECOMMENDEDPRINCIPAL", GetType(String)))
        dr = dt.NewRow()
        dr("OBJECTVALUEID") = 0
        dr("OBJECTTYPEID") = 0
        dr("YEARFROM") = ""
        dr("YEARTO") = ""
        dr("CONDITION") = ""
        dr("RECOMMENDEDVALUE") = 0
        dr("RECOMMENDEDPRINCIPAL") = 0
        dt.Rows.Add(dr)

        ViewState("VW_OTR") = dt
        If Not IsPostBack Then
            GvwSearch.DataSource = dt
            GvwSearch.DataBind()
        Else
            gvOTR.DataSource = dt
            gvOTR.DataBind()
            oImageDel = DirectCast(gvOTR.Rows(Convert.ToInt32(txtTmpSelectedIndex.Text)).FindControl("btnDelete"), ImageButton)
            oImageDel.Visible = False
        End If
    End Sub
    Protected Sub gvOTR_DataBound(sender As Object, e As System.EventArgs) Handles gvOTR.DataBound
        Dim oTextBox As TextBox
        For Each row As GridViewRow In gvOTR.Rows
            oTextBox = CType(row.FindControl("txtYearFrom"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "Int", "[0-9]")
                oTextBox.Attributes.Add("onkeypress", "return doClick(event,'" + btnSearch.ClientID & "')")
                oTextBox.Attributes.Add("onkeypress", "return doClick(event,'" + btnSave.ClientID & "')")
                oTextBox.Attributes.Add("onkeypress", "return doClick(event,'" + btnbackView.ClientID & "')")
            End If
        Next
        For Each row As GridViewRow In gvOTR.Rows
            oTextBox = CType(row.FindControl("txtYearTo"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "Int", "[0-9]")
                oTextBox.Attributes.Add("onkeypress", "return doClick(event,'" + btnSearch.ClientID & "')")
                oTextBox.Attributes.Add("onkeypress", "return doClick(event,'" + btnSave.ClientID & "')")
                oTextBox.Attributes.Add("onkeypress", "return doClick(event,'" + btnbackView.ClientID & "')")
            End If
        Next
        For Each row As GridViewRow In gvOTR.Rows
            oTextBox = CType(row.FindControl("txtRECOMMENDEDVALUE"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
                oTextBox.Attributes.Add("onkeypress", "return doClick(event,'" + btnSearch.ClientID & "')")
                oTextBox.Attributes.Add("onkeypress", "return doClick(event,'" + btnSave.ClientID & "')")
                oTextBox.Attributes.Add("onkeypress", "return doClick(event,'" + btnbackView.ClientID & "')")
            End If
        Next
        For Each row As GridViewRow In gvOTR.Rows
            oTextBox = CType(row.FindControl("txtRECOMMENDEDPRINCIPAL"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
                oTextBox.Attributes.Add("onkeypress", "return doClick(event,'" + btnSearch.ClientID & "')")
                oTextBox.Attributes.Add("onkeypress", "return doClick(event,'" + btnSave.ClientID & "')")
                oTextBox.Attributes.Add("onkeypress", "return doClick(event,'" + btnbackView.ClientID & "')")
            End If
        Next
    End Sub

    Protected Sub gvOTR_PageIndexChanging(sender As Object, e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvOTR.PageIndexChanging
        gvOTR.PageIndex = e.NewPageIndex
        Dim dt As DataTable = DirectCast(ViewState("VW_OTR"), DataTable)
        gvOTR.DataSource = dt
        gvOTR.DataBind()
        If gvOTR.Rows.Count > 0 Then
            gvOTR.SelectedIndex = 0
        End If
        lblMessage.Visible = False
    End Sub

    Protected Sub btnbackView_Click(sender As Object, e As System.EventArgs) Handles btnbackView.Click
        MultiView_Utama.SetActiveView(View_View)
        lblMessage.Visible = False
        lblMessage.Text = ""
        hidAction.Value = ""
        pnlData.Enabled = True
        GvwSearch.DataBind()
    End Sub
    Protected Sub btnNewOTR_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs)
        Try

            Dim dtOTR As New System.Data.DataTable
            Dim drOTR As System.Data.DataRow

            dtOTR = ViewState("VW_OTR")

            GetDataOTR(dtOTR)
            drOTR = dtOTR.NewRow()

            drOTR("OBJECTVALUEID") = "0"
            drOTR("OBJECTTYPEID") = "0"
            drOTR("YEARFROM") = ""
            drOTR("YEARTO") = ""
            drOTR("CONDITION") = ""

            drOTR("RECOMMENDEDVALUE") = "0"
            drOTR("RECOMMENDEDPRINCIPAL") = "0"

            dtOTR.Rows.Add(drOTR)
            gvOTR.DataSource = dtOTR
            gvOTR.DataBind()
            ViewState("VW_OTR") = dtOTR

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR NEW OTR : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        End Try
    End Sub

    Private Sub GetDataOTR(ByRef dtOTR As System.Data.DataTable)

        dtOTR.Clear()
        ' Dim oImageDel As ImageButton
        Dim sYEARFROM As String, sYEARTO As String, sCONDITION As String, dRecommendedValue As Double, dRecommendedPrincipal As Double
        Dim drOTR As System.Data.DataRow
        Dim oTextBox As TextBox
        Dim oDropDownList As DropDownList
        Dim iOBJECTVALUEID As String
        For Each gvRow As GridViewRow In gvOTR.Rows
            iOBJECTVALUEID = 0
            sYEARFROM = ""
            sYEARTO = ""
            sCONDITION = ""
            dRecommendedValue = 0
            dRecommendedPrincipal = 0

            oTextBox = CType(gvRow.FindControl("txtOBJECTVALUEID"), TextBox)
            If oTextBox IsNot Nothing Then
                iOBJECTVALUEID = Replace(oTextBox.Text, ",", "")
            End If
            oTextBox = CType(gvRow.FindControl("txtYearFrom"), TextBox)
            If oTextBox IsNot Nothing Then
                sYEARFROM = Replace(oTextBox.Text, ",", "")
            End If
            oTextBox = CType(gvRow.FindControl("txtYearTo"), TextBox)
            If oTextBox IsNot Nothing Then
                sYEARTO = Replace(oTextBox.Text, ",", "")
            End If
            oDropDownList = CType(gvRow.FindControl("ddlCondition"), DropDownList)
            If oDropDownList IsNot Nothing Then
                sCONDITION = oDropDownList.SelectedValue
            End If
            oTextBox = CType(gvRow.FindControl("txtRECOMMENDEDVALUE"), TextBox)
            If oTextBox IsNot Nothing Then
                dRecommendedValue = Replace(oTextBox.Text, ",", "")
            End If
            oTextBox = CType(gvRow.FindControl("txtRECOMMENDEDPRINCIPAL"), TextBox)
            If oTextBox IsNot Nothing Then
                dRecommendedPrincipal = Replace(oTextBox.Text, ",", "")
            End If

            drOTR = dtOTR.NewRow()

            If chkAddNew.Checked Then
                drOTR("OBJECTTYPEID") = "0"
            Else
                drOTR("OBJECTTYPEID") = hidTypeID.Value
            End If

            drOTR("OBJECTVALUEID") = iOBJECTVALUEID
            drOTR("YEARFROM") = sYEARFROM
            drOTR("YEARTO") = sYEARTO
            drOTR("CONDITION") = sCONDITION
            drOTR("RECOMMENDEDPRINCIPAL") = String.Format("{0:N}", dRecommendedPrincipal)
            drOTR("RECOMMENDEDVALUE") = String.Format("{0:N}", dRecommendedValue)

            dtOTR.Rows.Add(drOTR)
            'oImageDel = DirectCast(gvDPMinimum.Rows(Convert.ToInt32(txtTmpSelectedIndex.Text)).FindControl("btnDelete"), ImageButton)
            'oImageDel.Visible = False
        Next
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        Dim objDB As New DBX
        'Dim oSDR As Data.SqlClient.SqlDataReader
        If DirectCast(ViewState("VW_OTR"), DataTable) IsNot Nothing Then
            'oSDR = objDB.CreateSDRFromExecSQL("Update dbo.FNOBJECTVALUE SET DeleteSTS=1 WHERE OBJECTTYPEID=" & hidTypeID.Value)
            'If oSDR.Read() Then
            'End If
            'oSDR.Close()

            Dim dtOTR As New System.Data.DataTable
            dtOTR = ViewState("VW_OTR")
            GetDataOTR(dtOTR)
            For Each row As System.Data.DataRow In dtOTR.Rows
                If CType(row.Item("YEARFROM"), Double) > 0 Then
                    SaveFinanceStructure(row.Item("OBJECTVALUEID").ToString(), ddlType.SelectedValue,
                                    row.Item("YEARFROM").ToString(),
                                    row.Item("YEARTO").ToString(),
                                    row.Item("CONDITION").ToString(),
                                    row.Item("RECOMMENDEDVALUE").ToString(),
                                    row.Item("RECOMMENDEDPRINCIPAL").ToString())
                End If
            Next
        End If

        If DirectCast(ViewState("VW_OTR"), DataTable) Is Nothing Then
        Else
            DirectCast(ViewState("VW_OTR"), DataTable).Rows.Clear()
            DirectCast(ViewState("VW_OTR"), DataTable).Dispose()
        End If
        MultiView_Utama.SetActiveView(View_View)

    End Sub

    Private Sub SaveFinanceStructure(ByVal iObjectValue As String, ByVal iObjectType As String,
                                     ByVal iYearFrom As Integer, ByVal iYearTo As Integer, ByVal iCondition As Integer,
                                      ByVal sRecommendedValue As String, ByVal sRecommendedPrincipal As String)

        Dim objDB As New DBX
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try

            oSQLParam = objDB.ExecSPReturnParam("FNOBJECTVALUESave", _
                   objDB.MP("@OBJECTVALUEID", Data.SqlDbType.BigInt, iObjectValue), _
                   objDB.MP("@OBJECTTYPEID", Data.SqlDbType.Int, iObjectType), _
                   objDB.MP("@YEARFROM", Data.SqlDbType.Int, iYearFrom), _
                   objDB.MP("@YEARTO", Data.SqlDbType.Int, iYearTo), _
                   objDB.MP("@CONDITION", Data.SqlDbType.Int, iCondition), _
                   objDB.MP("@RECOMMENDEDVALUE", Data.SqlDbType.Money, sRecommendedValue), _
                   objDB.MP("@RECOMMENDEDPRINCIPAL", Data.SqlDbType.Money, sRecommendedPrincipal), _
                   objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value))
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE DATA RECOMMENDED OTR : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            lblMessage.Visible = False
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Protected Sub gvOTR_RowDeleting(sender As Object, e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles gvOTR.RowDeleting
        Dim dtOTR As New System.Data.DataTable
        dtOTR = ViewState("VW_OTR")
        GetDataOTR(dtOTR)
        dtOTR = ViewState("VW_OTR")
        dtOTR.Rows.RemoveAt(e.RowIndex)
        dtOTR.AcceptChanges()
        ViewState("VW_OTR") = dtOTR
        gvOTR.DataSource = dtOTR
        gvOTR.DataBind()
    End Sub
  
    Protected Sub gvOTR_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvOTR.RowCommand
        lblMessage.Visible = False
        lblMessage.Text = ""
        If e.CommandName = "Delete" Then

            Dim objDB As New DBX

            Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument)
            Try
                gvOTR.SelectedIndex = e.CommandArgument
                'Response.Write(gvEffRate.SelectedDataKey("FINDTLID"))
                'Response.End()


                objDB.ExecSQLWithParam("UPDATE FNOBJECTVALUE SET DeleteSts=1, LastUpdate=GETDATE(), LastUserId=@USERID WHERE OBJECTVALUEID=@OBJECTVALUEID", _
                        objDB.MP("@USERID", SqlDbType.Int, Request.Cookies("UID").Value),
                        objDB.MP("@OBJECTVALUEID", SqlDbType.BigInt, gvOTR.SelectedDataKey("OBJECTVALUEID"))
                        )
            Catch ex As Exception
                lblMessage.Visible = True
                lblMessage.Text = "ERROR DELETE OBJECTVALUE DATA : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        End If
    End Sub
End Class
