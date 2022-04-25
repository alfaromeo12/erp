Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Partial Class Param_fnCheckDoc
    Inherits System.Web.UI.Page
    Private dt As New DataTable
    Private oBranch As DropDownList
    Private oDocFee As TextBox
    Private oDescription As TextBox
    Public Shared oStrreqtxtNewDocFee As String
    Public Shared oStrtxtNewDocFee As String
   
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            hidAction.Value = "LOAD"
            btnNew.Visible = False
            sdsCheckDoc.SelectCommand = sdsCheckDoc.SelectCommand & " AND CHECKDOCID=-1"
            gvData.DataBind()
        Else
            hidAction.Value = ""
        End If
        RefreshDataGrid()
    End Sub
    Private Sub RefreshDataGrid()
        If hidAction.Value = "NEW" Then
            SetObjectValidation(DirectCast(gvData.FooterRow.FindControl("txtNewDocFee"), TextBox), False, "float", "[0-9.,]")
        End If
    End Sub
    Protected Sub Page_PreInit(sender As Object, e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub
    Private Sub SetValidation()
        Dim oRequired As RequiredFieldValidator
        Dim oTextbox As TextBox
        oRequired = CType(gvData.FooterRow.FindControl("reqtxtNewDocFee"), RequiredFieldValidator)
        If oRequired IsNot Nothing Then oStrreqtxtNewDocFee = oRequired.ClientID

        oTextbox = CType(gvData.FooterRow.FindControl("txtNewDocFee"), TextBox)
        If oTextbox IsNot Nothing Then oStrtxtNewDocFee = oTextbox.ClientID
    End Sub
    Private Sub SetInitialRow()
        Dim dt As New DataTable()
        Dim dr As DataRow = Nothing
        Dim oImageDel As ImageButton
        dt.Columns.Add(New DataColumn("CHECKDOCID", GetType(String)))
        dt.Columns.Add(New DataColumn("BRANCHNAME", GetType(String)))
        dt.Columns.Add(New DataColumn("CHECKDOCFEE", GetType(String)))
        dt.Columns.Add(New DataColumn("REMARK", GetType(String)))
      
        dr = dt.NewRow()
        dr("CHECKDOCID") = String.Empty
        dr("BRANCHNAME") = String.Empty
        dr("CHECKDOCFEE") = String.Empty
        dr("REMARK") = String.Empty
        dt.Rows.Add(dr)
        ViewState("CurrentTable") = dt

        gvData.DataSourceID = String.Empty
        gvData.DataSource = dt
        gvData.DataBind()

        oImageDel = DirectCast(gvData.Rows(Convert.ToInt32(txtTmpSelectedIndex.Text)).FindControl("btnEdit"), ImageButton)
        oImageDel.Visible = False
        oImageDel = DirectCast(gvData.Rows(Convert.ToInt32(txtTmpSelectedIndex.Text)).FindControl("btnDelete"), ImageButton)
        oImageDel.Visible = False
    End Sub
    Private Sub BindData()
        Try
            sdsCheckDoc.SelectCommand = sdsCheckDoc.SelectCommand & " AND PRODUCTID=" & ddlProduct.SelectedValue & " AND CD.AREAID=" & ddlArea.SelectedValue
            gvData.DataBind()
            If gvData.Rows.Count > 0 Then
                SetValidation()
            End If
        Catch ex As Exception
            lblError.Visible = True
            lblError.Text = "ERROR SEARCH FRONT END CHECK DOC: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        End Try
    End Sub
 
    Protected Sub gvData_PageIndexChanging(sender As Object, e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvData.PageIndexChanging
        gvData.PageIndex = e.NewPageIndex
        BindData()
    End Sub

    Protected Sub gvData_RowCancelingEdit(sender As Object, e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles gvData.RowCancelingEdit
        gvData.EditIndex = -1
        BindData()
    End Sub


    Protected Sub gvData_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand

    End Sub
   
    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        gvData.DataSourceID = "sdsCheckDoc"
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
        hidAction.Value = "SEARCH"
    End Sub
    Protected Sub gvData_RowEditing(sender As Object, e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles gvData.RowEditing
        gvData.EditIndex = e.NewEditIndex
        txtTmpSelectedIndex.Text = e.NewEditIndex
        Dim currentRowIndex As Integer = Convert.ToInt32(e.NewEditIndex).ToString
        chkEditPos.Checked = True
        hidAction.Value = "EDIT"
        BindData()
        ' oBranch = DirectCast(gvData.Rows(currentRowIndex).FindControl("ddlBranch"), DropDownList)
        SetObjectValidation(DirectCast(gvData.Rows(currentRowIndex).FindControl("txtDocFee"), TextBox), False, "float", "[0-9.,]")
    End Sub
    Protected Sub gvData_DataBound(sender As Object, e As System.EventArgs) Handles gvData.DataBound
        Dim oTextBox As TextBox
        For Each row As GridViewRow In gvData.Rows
            oTextBox = CType(row.FindControl("txtDocFee"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If
        Next
    End Sub
    Protected Sub btnInsert_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        Dim objDB As New DBX
        Dim intRetVal As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try
            hidAction.Value = "NEW"
            oBranch = DirectCast(gvData.FooterRow.FindControl("ddlNewBranch"), DropDownList)
            oDocFee = DirectCast(gvData.FooterRow.FindControl("txtNewDocFee"), TextBox)
            oDescription = DirectCast(gvData.FooterRow.FindControl("txtNewDescription"), TextBox)

            oSQLParam = objDB.ExecSPReturnParam("FNCHECKDOCadd", _
                     objDB.MP("@AREAID", Data.SqlDbType.Int, ddlArea.SelectedValue, 3), _
                     objDB.MP("@PRODUCTID", Data.SqlDbType.Int, ddlProduct.SelectedValue, 4), _
                     objDB.MP("@BRANCHID", Data.SqlDbType.Int, oBranch.SelectedValue, 4), _
                     objDB.MP("@CHECKDOCFEE", Data.SqlDbType.Money, oDocFee.Text.ToString, 20), _
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
            gvData.DataSourceID = "sdsCheckDoc"
            BindData()
            hidAction.Value = "SEARCH"
        Catch ex As Exception
            hidAction.Value = "SEARCH"
            lblError.Visible = True
            lblError.Text = "ERROR INSERT CHECK DOC : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub gvData_RowUpdated(sender As Object, e As System.Web.UI.WebControls.GridViewUpdatedEventArgs) Handles gvData.RowUpdated
        gvData.DataSourceID = "sdsCheckDoc"
        BindData()
    End Sub
    Protected Sub gvData_RowDeleted(sender As Object, e As System.Web.UI.WebControls.GridViewDeletedEventArgs) Handles gvData.RowDeleted
        gvData.DataSourceID = "sdsCheckDoc"
        BindData()
    End Sub

    Protected Sub btnCancelNew_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs)
        gvData.ShowFooter = False
        BindData()
    End Sub
End Class
