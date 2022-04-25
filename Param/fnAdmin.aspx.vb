Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections

Partial Class Param_fnAdmin
    Inherits System.Web.UI.Page
    Private dt As New DataTable
    Public strDealer As String
    Public strDealerID As String
    Private oOprFromTenor As DropDownList
    Private oTenorFrom As TextBox
    Private oOprToTenor As DropDownList
    Private oTenorTo As TextBox
    Private oOprFromPrincipal As DropDownList
    Private oPrincipalFrom As TextBox
    Private oOprToPrincipal As DropDownList
    Private oPrincipalTo As TextBox
    Private oAdminFee As TextBox
    Private oDescription As TextBox
    Public Shared oStrreqNewOprFrTenor As String
    Public Shared oStrreqtxtNewTenorFrom As String
    Public Shared oStrreqNewOprFromPrcipal As String
    Public Shared oStrreqNewPrincipalFrom As String
    Public Shared oStrddlNewOprFrTenor As String
    Public Shared oStrtxtNewTenorFrom As String
    Public Shared oStrddlNewOprFromPrcipal As String
    Public Shared oStrtxtNewPrincipalFrom As String
    Private bLostFocus As Boolean
    Private dr As DataRow
    Protected Sub Page_PreInit(sender As Object, e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        'gvData.Attributes.Add("cellspacing", "1")
        'gvData.Attributes.Add("cellpadding", "1")
        If Not IsPostBack Then
            hidAction.Value = "LOAD"
            btnNew.Visible = False
            rdbNonDealer.Checked = True
            sdsAdmin.SelectCommand = sdsAdmin.SelectCommand & " AND ADMINID=-1"
            gvData.DataBind()
        Else
            hidAction.Value = ""
        End If
        RefreshDataGrid()

    End Sub

    Private Sub RefreshDataGrid(Optional ByVal row As Integer = 0)
        CheckFlag()
        If hidAction.Value = "NEW" Then
            SetObjectValidation(DirectCast(gvData.FooterRow.FindControl("txtNewPrincipalTo"), TextBox), False, "float", "[0-9.,]")
            SetObjectValidation(DirectCast(gvData.FooterRow.FindControl("txtNewAdminFee"), TextBox), False, "float", "[0-9.,]")
            SetObjectValidation(DirectCast(gvData.FooterRow.FindControl("txtNewPrincipalFrom"), TextBox), False, "float", "[0-9.,]")
            SetObjectValidation(DirectCast(gvData.FooterRow.FindControl("txtNewTenorFrom"), TextBox), False, "integer", "[0-9]")
            SetObjectValidation(DirectCast(gvData.FooterRow.FindControl("txtNewTenorTo"), TextBox), False, "integer", "[0-9]")
        End If
    End Sub

    Private Sub SetValidation()
        Dim oRequired As RequiredFieldValidator
        Dim oTextbox As TextBox
        Dim oDropDownList As DropDownList
        oRequired = CType(gvData.FooterRow.FindControl("reqNewOprFrTenor"), RequiredFieldValidator)
        If oRequired IsNot Nothing Then oStrreqNewOprFrTenor = oRequired.ClientID

        oRequired = CType(gvData.FooterRow.FindControl("reqtxtNewTenorFrom"), RequiredFieldValidator)
        If oRequired IsNot Nothing Then oStrreqtxtNewTenorFrom = oRequired.ClientID

        oRequired = CType(gvData.FooterRow.FindControl("reqNewOprFromPrcipal"), RequiredFieldValidator)
        If oRequired IsNot Nothing Then oStrreqNewOprFromPrcipal = oRequired.ClientID

        oRequired = CType(gvData.FooterRow.FindControl("reqNewPrincipalFrom"), RequiredFieldValidator)
        If oRequired IsNot Nothing Then oStrreqNewPrincipalFrom = oRequired.ClientID

        oDropDownList = CType(gvData.FooterRow.FindControl("ddlNewOprFrTenor"), DropDownList)
        If oDropDownList IsNot Nothing Then oStrddlNewOprFrTenor = oDropDownList.ClientID

        oTextbox = CType(gvData.FooterRow.FindControl("txtNewTenorFrom"), TextBox)
        If oTextbox IsNot Nothing Then oStrtxtNewTenorFrom = oTextbox.ClientID

        oDropDownList = CType(gvData.FooterRow.FindControl("ddlNewOprFromPrcipal"), DropDownList)
        If oDropDownList IsNot Nothing Then oStrddlNewOprFromPrcipal = oDropDownList.ClientID

        oTextbox = CType(gvData.FooterRow.FindControl("txtNewPrincipalFrom"), TextBox)
        If oTextbox IsNot Nothing Then oStrtxtNewPrincipalFrom = oTextbox.ClientID

    End Sub

    Private Sub SetInitialRow()
        Dim dt As New DataTable()
        Dim dr As DataRow = Nothing
        Dim oImageDel As ImageButton
        dt.Columns.Add(New DataColumn("ADMINID", GetType(String)))
        dt.Columns.Add(New DataColumn("TENOROPR1", GetType(String)))
        dt.Columns.Add(New DataColumn("TENORFROM", GetType(String)))
        dt.Columns.Add(New DataColumn("TENOROPR2", GetType(String)))
        dt.Columns.Add(New DataColumn("TENORTO", GetType(String)))
        dt.Columns.Add(New DataColumn("PRINCIPALOPR1", GetType(String)))
        dt.Columns.Add(New DataColumn("PRINCIPALFROM", GetType(String)))
        dt.Columns.Add(New DataColumn("PRINCIPALOPR2", GetType(String)))
        dt.Columns.Add(New DataColumn("PRINCIPALTO", GetType(String)))
        dt.Columns.Add(New DataColumn("ADMINFEE", GetType(String)))
        dt.Columns.Add(New DataColumn("REMARK", GetType(String)))
        dr = dt.NewRow()
        dr("ADMINID") = String.Empty
        dr("TENOROPR1") = String.Empty
        dr("TENORFROM") = String.Empty
        dr("TENOROPR2") = String.Empty
        dr("TENORTO") = String.Empty
        dr("PRINCIPALOPR1") = String.Empty
        dr("PRINCIPALFROM") = String.Empty
        dr("PRINCIPALOPR2") = String.Empty
        dr("PRINCIPALTO") = String.Empty
        dr("ADMINFEE") = String.Empty
        dr("REMARK") = String.Empty
        dt.Rows.Add(dr)

        'Store the DataTable in ViewState
        ViewState("CurrentTable") = dt
        gvData.DataSourceID = String.Empty
        gvData.DataSource = dt
        gvData.DataBind()

        oImageDel = DirectCast(gvData.Rows(Convert.ToInt32(txtTmpSelectedIndex.Text)).FindControl("btnEdit"), ImageButton)
        If oImageDel IsNot Nothing Then
            oImageDel.Visible = False
        End If
        oImageDel = DirectCast(gvData.Rows(Convert.ToInt32(txtTmpSelectedIndex.Text)).FindControl("btnDelete"), ImageButton)
        If oImageDel IsNot Nothing Then
            oImageDel.Visible = False
        End If
    End Sub

    Private Sub BindData()
        Try
            If rdbDealer.Checked = True Then
                If Len(Trim(hidDealer.Value)) > 0 Then
                    sdsAdmin.SelectCommand = sdsAdmin.SelectCommand & " AND DEALERID=" & hidDealer.Value
                End If
            End If
            If rdbNonDealer.Checked = True Then
                If Len(Trim(ddlProduct.SelectedValue)) > 0 Then
                    sdsAdmin.SelectCommand = sdsAdmin.SelectCommand & " AND PRODUCTID=" & ddlProduct.SelectedValue & " AND AREAID=" & ddlArea.SelectedValue
                End If
            End If
            gvData.DataBind()
            If gvData.Rows.Count > 0 Then
                SetValidation()
            End If
        Catch ex As Exception
            lblError.Visible = True
            lblError.Text = "ERROR SEARCH FRONT END ADMIN: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        End Try
    End Sub

    Protected Sub gvData_RowCreated(sender As Object, e As GridViewRowEventArgs)
        If (e.Row.RowType = DataControlRowType.Header) Then

            Dim objGridView As GridView = DirectCast(sender, GridView)
            Dim objgridviewrow As New GridViewRow(1, 0, DataControlRowType.Header, DataControlRowState.Insert)
            Dim objtablecell As New TableCell()
            AddMergedCells(objgridviewrow, objtablecell, 2, String.Empty)
            AddMergedCells(objgridviewrow, objtablecell, 4, "TENOR (MONTHS(S))")
            AddMergedCells(objgridviewrow, objtablecell, 4, "PRINCIPAL(TOTAL EXPOSURE)")
            AddMergedCells(objgridviewrow, objtablecell, 1, "ADMIN FEE (Rp)")
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

    Protected Sub btnInsert_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        Dim objDB As New DBX
        Dim intRetVal As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try
            hidAction.Value = "NEW"
            oOprFromTenor = DirectCast(gvData.FooterRow.FindControl("ddlNewOprFrTenor"), DropDownList)
            oTenorFrom = DirectCast(gvData.FooterRow.FindControl("txtNewTenorFrom"), TextBox)
            oOprToTenor = DirectCast(gvData.FooterRow.FindControl("ddlNewOprToTenor"), DropDownList)
            oTenorTo = DirectCast(gvData.FooterRow.FindControl("txtNewTenorTo"), TextBox)
            oOprFromPrincipal = DirectCast(gvData.FooterRow.FindControl("ddlNewOprFromPrcipal"), DropDownList)
            oPrincipalFrom = DirectCast(gvData.FooterRow.FindControl("txtNewPrincipalFrom"), TextBox)
            oOprToPrincipal = DirectCast(gvData.FooterRow.FindControl("ddlNewOprToPrcipal"), DropDownList)
            oPrincipalTo = DirectCast(gvData.FooterRow.FindControl("txtNewPrincipalTo"), TextBox)
            oAdminFee = DirectCast(gvData.FooterRow.FindControl("txtNewAdminFee"), TextBox)
            oDescription = DirectCast(gvData.FooterRow.FindControl("txtNewDescription"), TextBox)

            oSQLParam = objDB.ExecSPReturnParam("FNADMINadd", _
                     objDB.MP("@DEALERID", Data.SqlDbType.Int, hidDealer.Value, 10), _
                     objDB.MP("@AREAID", Data.SqlDbType.Int, ddlArea.SelectedValue, 3), _
                     objDB.MP("@PRODUCTID", Data.SqlDbType.Int, ddlProduct.SelectedValue, 4), _
                     objDB.MP("@TENOROPR1", Data.SqlDbType.VarChar, oOprFromTenor.Text.ToString, 2), _
                     objDB.MP("@TENORFROM", Data.SqlDbType.Int, oTenorFrom.Text.ToString, 2), _
                     objDB.MP("@TENOROPR2", Data.SqlDbType.VarChar, oOprToTenor.Text.ToString, 2), _
                     objDB.MP("@TENORTO", Data.SqlDbType.Int, oTenorTo.Text.ToString, 8), _
                     objDB.MP("@PRINCIPALOPR1", Data.SqlDbType.VarChar, oOprFromPrincipal.Text.ToString, 20), _
                     objDB.MP("@PRINCIPALFROM", Data.SqlDbType.Money, oPrincipalFrom.Text.ToString, 20), _
                     objDB.MP("@PRINCIPALOPR2", Data.SqlDbType.VarChar, oOprToPrincipal.Text.ToString, 2), _
                     objDB.MP("@PRINCIPALTO", Data.SqlDbType.Money, oPrincipalTo.Text.ToString, 20), _
                     objDB.MP("@ADMINFEE", Data.SqlDbType.Money, oAdminFee.Text.ToString, 20), _
                     objDB.MP("@REMARK", Data.SqlDbType.VarChar, oDescription.Text.ToString, 100), _
                     objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value, 20), _
                     objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 10, Data.ParameterDirection.Output) _
                      )
            intRetVal = oSQLParam("@RETVAL").Value.ToString()
            If intRetVal = -1 Then
                lblError.Visible = True
            Else
                lblError.Text = ""
                lblError.Visible = False
            End If
            gvData.EditIndex = -1
            gvData.ShowFooter = False
            gvData.DataSourceID = "sdsAdmin"
            BindData()
            hidAction.Value = "SEARCH"
        Catch ex As Exception
            hidAction.Value = "SEARCH"
            lblError.Visible = True
            lblError.Text = "ERROR INSERT FRONT END ADMIN: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Protected Sub gvData_PageIndexChanging(sender As Object, e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvData.PageIndexChanging
        gvData.PageIndex = e.NewPageIndex
        BindData()
        lblError.Visible = False
    End Sub

    Protected Sub gvData_RowCancelingEdit(sender As Object, e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles gvData.RowCancelingEdit
        gvData.EditIndex = -1
        BindData()
    End Sub

    Protected Sub gvData_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvData.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            oOprFromTenor = DirectCast(e.Row.FindControl("ddlOprFrTenor"), DropDownList)
            oOprToTenor = DirectCast(e.Row.FindControl("ddlOprToTenor"), DropDownList)
            oOprFromPrincipal = DirectCast(e.Row.FindControl("ddlOprFromPrcipal"), DropDownList)
            oOprToPrincipal = DirectCast(e.Row.FindControl("ddlOprToPrcipal"), DropDownList)
        End If
    End Sub
    Protected Sub gvData_RowEditing(sender As Object, e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles gvData.RowEditing
        gvData.EditIndex = e.NewEditIndex
        txtTmpSelectedIndex.Text = e.NewEditIndex
        Dim currentRowIndex As Integer = Convert.ToInt32(e.NewEditIndex).ToString
        chkEditPos.Checked = True
        hidAction.Value = "EDIT"
        BindData()
        hidFnFiduciaryID.Value = DirectCast(gvData.Rows(currentRowIndex).FindControl("lblAdminIdKey"), Label).Text
        SetObjectValidation(DirectCast(gvData.Rows(currentRowIndex).FindControl("txtPrincipalTo"), TextBox), False, "float", "[0-9.,]")
        SetObjectValidation(DirectCast(gvData.Rows(currentRowIndex).FindControl("txtAdminFee"), TextBox), False, "float", "[0-9.,]")
        SetObjectValidation(DirectCast(gvData.Rows(currentRowIndex).FindControl("txtPrincipalFrom"), TextBox), False, "float", "[0-9.,]")
        SetObjectValidation(DirectCast(gvData.Rows(currentRowIndex).FindControl("txtTenorFrom"), TextBox), False, "integer", "[0-9]")
        SetObjectValidation(DirectCast(gvData.Rows(currentRowIndex).FindControl("txtTenorTo"), TextBox), False, "integer", "[0-9]")
    End Sub
    Protected Sub gvData_DataBound(sender As Object, e As System.EventArgs) Handles gvData.DataBound
        Dim oTextBox As TextBox
        For Each row As GridViewRow In gvData.Rows
            oTextBox = CType(row.FindControl("txtPrincipalTo"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If
        Next
        For Each row As GridViewRow In gvData.Rows
            oTextBox = CType(row.FindControl("txtAdminFee"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If
        Next
        For Each row As GridViewRow In gvData.Rows
            oTextBox = CType(row.FindControl("txtPrincipalFrom"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If
        Next
        For Each row As GridViewRow In gvData.Rows
            oTextBox = CType(row.FindControl("txtTenorFrom"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "integer", "[0-9]")
            End If
        Next
        For Each row As GridViewRow In gvData.Rows
            oTextBox = CType(row.FindControl("txtTenorTo"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "integer", "[0-9]")
            End If
        Next
    End Sub
    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        gvData.DataSourceID = "sdsAdmin"
        hidAction.Value = "SEARCH"
        btnNew.Visible = False
        gvData.ShowFooter = False
        BindData()
        btnNew.Visible = True
        lblError.Visible = False
    End Sub

    Protected Sub btnNew_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        chkEditPos.Checked = False
        gvData.ShowFooter = True
        hidAction.Value = "NEW"
        BindData()
        If gvData.Rows.Count <= 0 Then
            SetInitialRow()
        End If
        RefreshDataGrid()
    End Sub

    Private Sub CheckFlag()
        rdbNonDealer.Attributes.Add("onclick", "SetCriteria(0);checkFlag();")
        rdbDealer.Attributes.Add("onclick", "SetCriteria(1);checkFlag();")
    End Sub

    Protected Sub gvData_RowUpdated(sender As Object, e As System.Web.UI.WebControls.GridViewUpdatedEventArgs) Handles gvData.RowUpdated
        gvData.DataSourceID = "sdsAdmin"
        BindData()
    End Sub

    Protected Sub gvData_RowDeleted(sender As Object, e As System.Web.UI.WebControls.GridViewDeletedEventArgs) Handles gvData.RowDeleted
        gvData.DataSourceID = "sdsAdmin"
        BindData()
    End Sub


    Protected Sub sdsAdmin_Updated(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsAdmin.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "ADMINID  : " & e.Command.Parameters("@ADMINID").Value & " already exists..!"
        Else
            lblError.Visible = False
            BindData()
        End If
    End Sub

    Protected Sub btnCancelNew_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs)
        gvData.ShowFooter = False
        BindData()
    End Sub
End Class
