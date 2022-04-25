Imports System.Data
Imports System.Data.SqlClient

Partial Class Param_DealerAccount
    Inherits System.Web.UI.Page

    Public strTxtDealer As String
    Public strbtnHidDealer As String
    Public Shared ostrRefundId As String
    Public Shared oStrtxtCompenAllocated, oStrTotaltxtCompenAllocated, ostrTitlePosition, oStrValueRefund As String
    Private TotalCompenAllocated As Decimal = 0.0

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            MultiView_Utama.SetActiveView(View_View)
            DataSearchDealer()
        End If
        setValidation()

    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Private Sub setValidation()
        Dim oTextBox As TextBox

        Dim oHidden As HiddenField
        oTextBox = CType(fvDealerAccBank.FindControl("txtSearchDealer"), TextBox)
        If oTextBox IsNot Nothing Then
            strTxtDealer = oTextBox.ClientID
        End If

        oHidden = CType(fvDealerAccBank.FindControl("hidDealer"), HiddenField)
        If oHidden IsNot Nothing Then
            strbtnHidDealer = oHidden.ClientID
        End If
        oTextBox = CType(fvDealerAccBank.FindControl("txtAccBankBranch"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase ")

        'oTextBox = CType(fvDealerAccBank.FindControl("txtAccNo"), TextBox)
        'If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "int", "[0-9]")

        oTextBox = CType(fvDealerAccBank.FindControl("txtAccName"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase ")

        oTextBox = CType(fvPersonACC.FindControl("txtBranchPersonACC"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase ")

        'oTextBox = CType(fvPersonACC.FindControl("txtAccNoPersonACC"), TextBox)
        'If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "int", "[0-9]")

        oTextBox = CType(fvPersonACC.FindControl("txtAccNamePersonACC"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase ")
        TotalCompenAllocated = 0
       
    End Sub

    Protected Sub ddlBranchSearch_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlBranchSearch.SelectedIndexChanged
        DataSearchDealer()
    End Sub
    Protected Sub ddlMainDealerSearch_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlMainDealerSearch.SelectedIndexChanged
        DataSearchDealer()
    End Sub

    Private Sub DataSearchDealer()
        If Not IsPostBack() Then
            Me.sdsDealer.SelectCommand = Me.sdsDealer.SelectCommand & " AND DEALER.DEALERID=-999"
        End If
        If Len(Trim(txtSearchDealer.Text)) > 0 Then
            Me.sdsDealer.SelectCommand = Me.sdsDealer.SelectCommand & " AND " + ddlCriteriaDealer.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearchDealer.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        If Len(Trim(ddlBranchSearch.SelectedValue)) > 0 Then
            Me.sdsDealer.SelectCommand = Me.sdsDealer.SelectCommand & " AND BRANCHID=" & ddlBranchSearch.SelectedValue
        End If
        If Len(Trim(ddlMainDealerSearch.SelectedValue)) > 0 Then
            Me.sdsDealer.SelectCommand = Me.sdsDealer.SelectCommand & " AND DEALERMAINID=" & ddlMainDealerSearch.SelectedValue
        End If

        GvDealer.DataBind()
    End Sub
    Protected Sub btnFunctionDealer_Click(sender As Object, e As System.EventArgs) Handles btnFunctionDealer.Click
        DataSearchDealer()
        lblError.Visible = False
    End Sub
    Protected Sub GvDealer_PageIndexChanged(sender As Object, e As System.EventArgs) Handles GvDealer.PageIndexChanged
        DataSearchDealer()
    End Sub


    Protected Sub gvData_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        lblError.Visible = False
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument).ToString
        If e.CommandName = "Select" Then
            fvDealerAccBank.ChangeMode(FormViewMode.Edit)
            fvDealerAccBank.Caption = "Edit Data"

            'HdnBranchId.Value = gvData.Rows(currentRowIndex).Cells(3).Text
        End If
    End Sub
    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        lblError.Visible = False
        fvDealerAccBank.ChangeMode(FormViewMode.Insert)
        fvDealerAccBank.Caption = "New Data"
        gvData.SelectedIndex = -1

    End Sub
    Private Sub DataSearch()
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        gvData.DataBind()
    End Sub
    Protected Sub fvDealerAccBank_ItemCreated(sender As Object, e As System.EventArgs) Handles fvDealerAccBank.ItemCreated
        setValidation()
    End Sub
    Protected Sub fvDealerAccBank_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewDeletedEventArgs) Handles fvDealerAccBank.ItemDeleted
        DataSearch()
    End Sub
    Protected Sub fvDealerAccBank_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles fvDealerAccBank.ItemInserted
        DataSearch()
    End Sub
    Protected Sub fvDealerAccBank_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewUpdatedEventArgs) Handles fvDealerAccBank.ItemUpdated
        DataSearch()
    End Sub
    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
        lblError.Visible = False
    End Sub
    Protected Sub fvDealerAccBank_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvDealerAccBank.ItemCommand
        If e.CommandName = "Cancel" Then
            gvData.SelectedIndex = -1
            fvDealerAccBank.Caption = ""
        End If
    End Sub

    Protected Sub btnViewDealerAcc_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        Dim currentCommand As String = e.CommandName
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument)
        Dim DealerId As String
        Try
            DealerId = GvDealer.DataKeys(currentRowIndex).Value
            lblCommand.Text = currentCommand
            lblIndex.Text = currentRowIndex.ToString
            lblKey.Text = DealerId
            GvDealer.SelectedIndex = currentRowIndex
            MultiView_Utama.SetActiveView(View_DealerAccount)
            fvDealerAccBank.ChangeMode(FormViewMode.ReadOnly)
            fvDealerAccBank.Caption = ""
            fvDealerInfo.DataBind()
            gvData.DataBind()
        Catch ex As Exception
            lblError.Text = Validation.ReplaceMessage(ex.Message.ToString)
        End Try
    End Sub

    Protected Sub sdsDealerAccBank_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsDealerAccBank.Inserted
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Dealer ACC ID : " & e.Command.Parameters("@DEALERACCOUNTID").Value & " already exists..!"
        Else
            lblError.Visible = False
            fvDealerAccBank.Caption = ""
            DataSearch()
        End If
    End Sub
    Protected Sub sdsDealerAccBank_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsDealerAccBank.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Dealer ACC ID : " & e.Command.Parameters("@DEALERACCOUNTID").Value & " already exists..!"
        Else
            lblError.Visible = False
            DataSearch()
        End If
    End Sub

    Protected Sub sdsDealerAccBank_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsDealerAccBank.Deleted
        fvDealerAccBank.Caption = ""
    End Sub

    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    'Protected Sub gvData_RowCreated(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvData.RowCreated
    '    If (e.Row.RowType = DataControlRowType.DataRow) Then
    '        e.Row.Attributes.Add("onclick", Page.ClientScript.GetPostBackEventReference(gvData, "Select$" + e.Row.RowIndex.ToString()))
    '    End If
    'End Sub

    Protected Sub btnViewDealerPerson_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        Dim currentCommand As String = e.CommandName
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument)
        Dim DealerId As String
        Try
            DealerId = GvDealer.DataKeys(currentRowIndex).Value

            lblCommand.Text = currentCommand
            lblIndex.Text = currentRowIndex.ToString
            lblKey.Text = DealerId
            GvDealer.SelectedIndex = currentRowIndex
            MultiView_Utama.SetActiveView(View_DealerPerson)
            fvDealerInfoPerson.DataBind()
            GvPerson.DataBind()
            fvDealerPerson.ChangeMode(FormViewMode.ReadOnly)
            fvDealerPerson.Caption = ""
        Catch ex As Exception
            lblError.Text = Validation.ReplaceMessage(ex.Message.ToString)
        End Try
    End Sub
    Protected Sub fvDealerPerson_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvDealerPerson.ItemCommand
        If e.CommandName = "Cancel" Then
            GvPerson.SelectedIndex = -1
            fvDealerPerson.Caption = ""
        End If
    End Sub
    Protected Sub fvDealerPerson_ItemDeleted(sender As Object, e As System.Web.UI.WebControls.FormViewDeletedEventArgs) Handles fvDealerPerson.ItemDeleted
        DataSearchPerson()
    End Sub
    Protected Sub imgBtnNewPerson_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNewPerson.Click
        lblErrorPerson.Visible = False
        fvDealerPerson.ChangeMode(FormViewMode.Insert)
        fvDealerPerson.Caption = "New Data"
        GvPerson.SelectedIndex = -1
    End Sub
    Protected Sub btnViewDealerAccPerson_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        Dim currentCommand As String = e.CommandName
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument)
        Dim PersonId As String
        Try
            PersonId = GvPerson.DataKeys(currentRowIndex).Value

            lblCommand.Text = currentCommand
            lblIndex.Text = currentRowIndex.ToString
            lblKey.Text = PersonId
            hidPersonACC.Value = PersonId
            MultiView_Utama.SetActiveView(ViewDealerPersonBank)
            setValidation()
        Catch ex As Exception
            lblError.Text = Validation.ReplaceMessage(ex.Message.ToString)
        End Try
    End Sub
    Private Sub DataSearchPerson()
        If Len(Trim(txtSearchPerson.Text)) > 0 Then
            Me.sdsGridPerson.SelectCommand = Me.sdsGridPerson.SelectCommand & " AND " + ddlCriteriaPerson.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearchPerson.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        GvPerson.DataBind()
    End Sub
    Protected Sub GvPerson_PageIndexChanged(sender As Object, e As System.EventArgs) Handles GvPerson.PageIndexChanged
        DataSearchPerson()
    End Sub
    Protected Sub sdsPerson_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsPerson.Inserted
        If e.Command.Parameters("@retval").Value = -1 Then
            lblErrorPerson.Visible = True
            ' lblError.Text = "PERSON ID : " & e.Command.Parameters("@DEALERACCOUNTID").Value & " already exists..!"
        Else
            lblErrorPerson.Visible = False
            fvDealerPerson.Caption = ""
            DataSearchPerson()
        End If
    End Sub
    Protected Sub sdsPerson_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsPerson.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblErrorPerson.Visible = True
            lblErrorPerson.Text = "PERSON ID : " & e.Command.Parameters("@PERSONID").Value & " already exists..!"
        Else
            lblErrorPerson.Visible = False
            DataSearchPerson()
        End If
    End Sub
    Protected Sub btnFunctionPerson_Click(sender As Object, e As System.EventArgs) Handles btnFunctionPerson.Click
        DataSearchPerson()
        lblErrorPerson.Visible = False
    End Sub

    Protected Sub GvPerson_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GvPerson.RowCommand

        'Response.Write("<br><br>" & e.CommandName)
        lblErrorPerson.Visible = False
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument).ToString
        If e.CommandName = "Select" Then
            fvDealerPerson.ChangeMode(FormViewMode.Edit)
            fvDealerPerson.Caption = "Edit Data"
        Else
            fvDealerPerson.ChangeMode(FormViewMode.ReadOnly)
            'HdnBranchId.Value = gvData.Rows(currentRowIndex).Cells(3).Text
        End If
    End Sub

    Protected Sub sdsPerson_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsPerson.Deleted
        fvDealerPerson.Caption = ""
    End Sub

    Protected Sub fvPersonACC_ItemCommand(sender As Object, e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvPersonACC.ItemCommand
        If e.CommandName = "Cancel" Then
            GvPersonACC.SelectedIndex = -1
            fvPersonACC.Caption = ""
        End If
    End Sub
    Protected Sub fvPersonACC_ItemCreated(sender As Object, e As System.EventArgs) Handles fvPersonACC.ItemCreated
        setValidation()
    End Sub
    Protected Sub fvPersonACC_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewDeletedEventArgs) Handles fvPersonACC.ItemDeleted
        DataSearchPersonACC()
    End Sub
    Protected Sub imgBtnNewPersonACC_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNewPersonACC.Click
        lblErrorPersonACC.Visible = False
        fvPersonACC.ChangeMode(FormViewMode.Insert)
        fvPersonACC.Caption = "New Data"
        GvPersonACC.SelectedIndex = -1
    End Sub
    Private Sub DataSearchPersonACC()
        If Len(Trim(txtCriteriaPersonACC.Text)) > 0 Then
            Me.sdsGridPersonACC.SelectCommand = Me.sdsGridPersonACC.SelectCommand & " AND " + ddlCriteriaPersonAcc.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtCriteriaPersonACC.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        GvPersonACC.DataBind()
    End Sub
    Protected Sub GvPersonACC_PageIndexChanged(sender As Object, e As System.EventArgs) Handles GvPersonACC.PageIndexChanged
        DataSearchPersonACC()
    End Sub
    Protected Sub sdsAccPersonBank_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsAccPersonBank.Inserted
        If e.Command.Parameters("@retval").Value = -1 Then
            lblErrorPersonACC.Visible = True
            ' lblError.Text = "PERSON ID : " & e.Command.Parameters("@DEALERACCOUNTID").Value & " already exists..!"
        Else
            lblErrorPersonACC.Visible = False
            fvPersonACC.Caption = ""
            DataSearchPersonACC()
        End If
    End Sub
    Protected Sub sdsAccPersonBank_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsAccPersonBank.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblErrorPersonACC.Visible = True
            lblErrorPerson.Text = "PERSON ACCOUNT ID : " & e.Command.Parameters("@PERSONACCOUNTID").Value & " already exists..!"
        Else
            lblErrorPersonACC.Visible = False
            DataSearchPersonACC()
        End If
    End Sub
    Protected Sub btnFunctionSearchPersonACC_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearchPersonACC.Click
        DataSearchPersonACC()
        lblErrorPersonACC.Visible = False
    End Sub
    Protected Sub GvPersonACC_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GvPersonACC.RowCommand
        lblErrorPersonACC.Visible = False
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument).ToString
        If e.CommandName = "Select" Then
            fvPersonACC.ChangeMode(FormViewMode.Edit)
            fvPersonACC.Caption = "Edit Data"
        End If
    End Sub
    Protected Sub sdsAccPersonBank_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsAccPersonBank.Deleted
        fvPersonACC.Caption = ""
    End Sub
    Protected Sub btnViewRefund_Command(sender As Object, e As System.Web.UI.WebControls.CommandEventArgs)
        Dim currentCommand As String = e.CommandName
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument)
        Dim DealerId As String
        Try
            lblMessageRefund.Visible = False
            lblMessageRefund.Text = ""
            DealerId = GvDealer.DataKeys(currentRowIndex).Value
            lblCommand.Text = currentCommand
            lblIndex.Text = currentRowIndex.ToString
            lblKey.Text = DealerId
            GvDealer.SelectedIndex = currentRowIndex
            MultiView_Utama.SetActiveView(ViewDealerRefund)
            fvDealerInfoRefund.DataBind()
            dlDealerProduct.DataBind()
            If dlDealerProduct.Items.Count = 0 Then
                lblMessageRefund.Visible = True
                lblMessageRefund.Text = "Please Set Dealer Product First..!"
                btnSaveRefund.Visible = False
            Else
                btnSaveRefund.Visible = True
            End If
          

        Catch ex As Exception
            lblError.Text = Validation.ReplaceMessage(ex.Message.ToString)
        End Try
    End Sub

    Protected Sub btnViewDealerProduct_Command(sender As Object, e As System.Web.UI.WebControls.CommandEventArgs)
        Dim currentCommand As String = e.CommandName
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument)
        Dim DealerId As String
        Try
            DealerId = GvDealer.DataKeys(currentRowIndex).Value

            lblCommand.Text = currentCommand
            lblIndex.Text = currentRowIndex.ToString
            lblKey.Text = DealerId
            GvDealer.SelectedIndex = currentRowIndex
            MultiView_Utama.SetActiveView(ViewDealerProduct)
            fvDealerInfoProduct.DataBind()
            lvProductSrc.DataBind()
            lblMessageProduct.Visible = False

        Catch ex As Exception
            lblError.Text = Validation.ReplaceMessage(ex.Message.ToString)
        End Try

    End Sub

    Protected Sub btnRight_Click(sender As Object, e As System.EventArgs) Handles btnRight.Click
        For i As Integer = lvProductSrc.Items.Count - 1 To 0 Step -1
            If lvProductSrc.Items(i).Selected Then
                lvbProductDest.Items.Add(lvProductSrc.Items(i))
                lvbProductDest.ClearSelection()
                lvProductSrc.Items.Remove(lvProductSrc.Items(i))
            End If
        Next
    End Sub

    Protected Sub btnLeft_Click(sender As Object, e As System.EventArgs) Handles btnLeft.Click
        For i As Integer = lvbProductDest.Items.Count - 1 To 0 Step -1
            If lvbProductDest.Items(i).Selected Then
                lvProductSrc.Items.Add(lvbProductDest.Items(i))
                lvProductSrc.ClearSelection()
                lvbProductDest.Items.Remove(lvbProductDest.Items(i))
            End If
        Next

    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As System.EventArgs) Handles btnCancel.Click
        MultiView_Utama.SetActiveView(View_View)
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSaveProduct.Click
        Dim objDB As New DBX
        Try
            'Response.Write("<BR><BR><BR>" & lblKey.Text)
            'UPDATE STATUS DULU
            objDB.ExecSQLWithParam("UPDATE DEALERPRODUCT SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID WHERE DEALERID=@DEALERID", _
                    objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value), _
                    objDB.MP("@DEALERID", Data.SqlDbType.BigInt, lblKey.Text))

            lblMessageProduct.Visible = False
            Dim iRows As Integer = 0
            iRows = lvbProductDest.Items.Count - 1

            'Response.Write("<br><br>" & iRows.ToString())

            For iRow = 0 To iRows
                objDB.ExecSP("DEALERPRODUCTSave", _
                    objDB.MP("@DEALERID", Data.SqlDbType.BigInt, lblKey.Text), _
                    objDB.MP("@PRODUCTID", Data.SqlDbType.BigInt, lvbProductDest.Items.Item(iRow).Value), _
                    objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value))

                'Response.Write("<br><br>" & iRow.ToString())
            Next

        Catch ex As Exception
            lblMessageProduct.Visible = True
            lblMessageProduct.Text = "ERROR SAVE DEALER PRODUCT..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE: " & ex.Message
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub

    Protected Sub btnSaveRefund_Click(sender As Object, e As System.EventArgs) Handles btnSaveRefund.Click
        Dim objDB As New DBX
        Try

            ' UPDATE STATUS DULU
            objDB.ExecSQLWithParam("UPDATE REFUND SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID WHERE DEALERID=@DEALERID", _
                    objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value), _
                    objDB.MP("@DEALERID", Data.SqlDbType.BigInt, lblKey.Text))

            lblMessageRefund.Visible = False
            lblMessageRefund.Text = ""
            Dim iRows As Integer = 0
            Dim iRefundType As Integer = 0
            For Each dl As DataListItem In dlDealerProduct.Items
                Dim Gvw As GridView = DirectCast(dl.FindControl("gvDealerProduct"), GridView)
                If Gvw.Rows.Count > 0 Then
                    iRows = Gvw.Rows.Count - 1
                    For iRow = 0 To iRows
                        If NoComma(CType(Gvw.Rows(iRow).FindControl("txtRefund"), TextBox).Text) > 0 Then
                            objDB.ExecSP("REFUNDSave", _
                            objDB.MP("@DEALERID", Data.SqlDbType.BigInt, lblKey.Text), _
                            objDB.MP("@PRODUCTID", Data.SqlDbType.Int, CType(dl.FindControl("hidProductID"), HiddenField).Value), _
                            objDB.MP("@REFUNDCATEGORY", Data.SqlDbType.TinyInt, CType(Gvw.Rows(iRow).FindControl("hidRefundCategory"), HiddenField).Value), _
                            objDB.MP("@REFUNDTYPE", Data.SqlDbType.TinyInt, IIf(CType(Gvw.Rows(iRow).FindControl("rbAmount"), RadioButton).Checked = True, 2, 1)), _
                            objDB.MP("@REFUND", Data.SqlDbType.Float, CType(Gvw.Rows(iRow).FindControl("txtRefund"), TextBox).Text), _
                            objDB.MP("@SHARESTS", Data.SqlDbType.Bit, IIf(CType(Gvw.Rows(iRow).FindControl("chShared"), CheckBox).Checked = True, True, False)), _
                            objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value))
                        End If
                    Next
                End If
            Next
            dlDealerProduct.DataBind()
            lblMessageRefund.Visible = True
            lblMessageRefund.Text = "UPDATE DEALER REFUND SUCCESFULLY..."
        Catch ex As Exception
            lblMessageRefund.Visible = True
            lblMessageRefund.Text = "ERROR SAVE DEALER REFUND..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE: " & ex.Message
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub
    Private Function NoComma(ByVal theValue As String) As String
        NoComma = Replace(theValue, ",", "")
    End Function

    Protected Sub dlDealerProduct_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.DataListItemEventArgs) Handles dlDealerProduct.ItemDataBound
        Dim oTextBox As TextBox
        For Each dl As DataListItem In dlDealerProduct.Items
            Dim Gvw As GridView = DirectCast(dl.FindControl("gvDealerProduct"), GridView)
            For Each row As GridViewRow In Gvw.Rows
                oTextBox = CType(row.FindControl("txtRefund"), TextBox)
                If oTextBox IsNot Nothing Then
                    '   strAmount = strAmount & oTextBox.ClientID & ","
                    SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
                End If
            Next
        Next
    End Sub
    Protected Sub btnViewRefundDtl_Command(sender As Object, e As System.Web.UI.WebControls.CommandEventArgs)
        Dim currentCommand As String = e.CommandName
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument)
        Try
            ClearString()
            lblMessageRefundDtl.Text = ""
            lblMessageRefundDtl.Visible = False
            MultiView_Utama.SetActiveView(ViewRefundDetail)
            fvDealerInfoRefundDtl.DataBind()
            hidVALUEREFUND.Value = CType(fvDealerInfoRefundDtl.FindControl("lblValue"), Label).Text
            hidREFUNDTYPE.Value = CType(fvDealerInfoRefundDtl.FindControl("lblTypeCompensation"), Label).Text
            GetData(hidREFUNDID.Value)

        Catch ex As Exception
            lblMessageRefundDtl.Text = Validation.ReplaceMessage(ex.Message.ToString)
        End Try
    End Sub

    Protected Sub btnBackRefundDtl_Click(sender As Object, e As System.EventArgs) Handles btnBackRefundDtl.Click
        If DirectCast(ViewState("VSREFUNDDTL"), DataTable) Is Nothing Then
        Else
            DirectCast(ViewState("VSREFUNDDTL"), DataTable).Rows.Clear()
            DirectCast(ViewState("VSREFUNDDTL"), DataTable).Dispose()
        End If
        MultiView_Utama.SetActiveView(ViewDealerRefund)
    End Sub
    Private Sub AddRowEmpty()
        Dim dt As New DataTable()
        Dim dr As DataRow = Nothing
        Dim oImageDel As ImageButton
        Try
            dt.Columns.Add(New DataColumn("REFUNDID", GetType(String)))
            dt.Columns.Add(New DataColumn("INCLUDEDISBURSE", GetType(String)))
            dt.Columns.Add(New DataColumn("REFUNDTYPE", GetType(String)))
            dt.Columns.Add(New DataColumn("PERSONTITLE", GetType(String)))
            dt.Columns.Add(New DataColumn("PERSONREFUND", GetType(String)))
            dr = dt.NewRow()
            dr("REFUNDID") = 0
            If hidREFUNDTYPE.Value = "1" Then
                dr("REFUNDTYPE") = "PERSENTAGE"
            Else
                dr("REFUNDTYPE") = "AMOUNT"
            End If
            dr("INCLUDEDISBURSE") = False
            dr("PERSONTITLE") = ""
            dr("PERSONREFUND") = 0
            dt.Rows.Add(dr)

            ViewState("VSREFUNDDTL") = dt

            '  gvDealerRefundDtl.DataSourceID = String.Empty
            gvDealerRefundDtl.DataSource = dt
            gvDealerRefundDtl.DataBind()

            oImageDel = DirectCast(gvDealerRefundDtl.Rows(0).FindControl("btnDelete"), ImageButton)
            oImageDel.Visible = False
        Catch ex As Exception
            lblMessageRefundDtl.Visible = True
            lblMessageRefundDtl.Text = "ERROR NEW EMPTY DATA REFUND DETAIL : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        End Try

    End Sub

    Protected Sub btnNewRefunddtl_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs)
        Try
            lblMessageRefundDtl.Text = ""
            lblMessageRefundDtl.Visible = False
            Dim dtRefundDtl As New System.Data.DataTable
            Dim drRefundDtl As System.Data.DataRow
            oStrtxtCompenAllocated = ""
            oStrTotaltxtCompenAllocated = ""

            dtRefundDtl = ViewState("VSREFUNDDTL")
            GetDataRefundDtl(dtRefundDtl)
            drRefundDtl = dtRefundDtl.NewRow()

            drRefundDtl("REFUNDID") = hidREFUNDID.Value
            drRefundDtl("INCLUDEDISBURSE") = False
            drRefundDtl("PERSONTITLE") = ""
            If hidREFUNDTYPE.Value = "1" Then
                drRefundDtl("REFUNDTYPE") = "PERSENTAGE"
            Else
                drRefundDtl("REFUNDTYPE") = "AMOUNT"
            End If

            drRefundDtl("PERSONREFUND") = "0"

            dtRefundDtl.Rows.Add(drRefundDtl)
            'gvDealerRefundDtl.DataSourceID = String.Empty
            gvDealerRefundDtl.DataSource = dtRefundDtl
            gvDealerRefundDtl.DataBind()
            ViewState("VSREFUNDDTL") = dtRefundDtl

        Catch ex As Exception
            lblMessageRefundDtl.Visible = True
            lblMessageRefundDtl.Text = "ERROR NEW REFUND DETAIL : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        End Try
    End Sub

    Private Sub GetDataRefundDtl(ByRef dtRefundDtl As System.Data.DataTable)
        dtRefundDtl.Clear()
        Dim oImageDel As ImageButton
        Dim iREFUNDID As String, dCOMPENALOCATED As Double
        Dim sPERSONTITLE As String, sDISBURSE As String, sREFUNDTYPE As String
        Dim drREFUNDDTL As System.Data.DataRow
        Dim oTextBox As TextBox
        Dim oLabel As Label
        Dim oCheckBox As CheckBox
        Dim oDropDownList As DropDownList
        Try
            sDISBURSE = "0"
            sPERSONTITLE = "0"
            iREFUNDID = 0
            sREFUNDTYPE = ""
            For Each gvRow As GridViewRow In gvDealerRefundDtl.Rows
                oCheckBox = CType(gvRow.FindControl("chkDisburse"), CheckBox)
                If oCheckBox IsNot Nothing Then
                    sDISBURSE = oCheckBox.Checked
                End If
                oDropDownList = CType(gvRow.FindControl("ddlPosition"), DropDownList)
                If oDropDownList IsNot Nothing Then
                    sPERSONTITLE = oDropDownList.SelectedValue
                End If
                oTextBox = CType(gvRow.FindControl("txtCompenAllocate"), TextBox)
                If oTextBox IsNot Nothing Then
                    dCOMPENALOCATED = Replace(oTextBox.Text, ",", "")
                    'dCOMPENALOCATED = oTextBox.Text
                End If
                oLabel = CType(gvRow.FindControl("lblTypeCompensation"), Label)
                If oLabel IsNot Nothing Then
                    sREFUNDTYPE = Replace(oLabel.Text, ",", "")
                End If

                drREFUNDDTL = dtRefundDtl.NewRow()
                drREFUNDDTL("REFUNDID") = hidREFUNDID.Value
                drREFUNDDTL("INCLUDEDISBURSE") = sDISBURSE
                drREFUNDDTL("PERSONTITLE") = sPERSONTITLE
                drREFUNDDTL("REFUNDTYPE") = sREFUNDTYPE
                drREFUNDDTL("PERSONREFUND") = String.Format("{0:N}", dCOMPENALOCATED)

                dtRefundDtl.Rows.Add(drREFUNDDTL)
                oImageDel = DirectCast(gvRow.FindControl("btnDelete"), ImageButton)
                oImageDel.Visible = False
                'End If
            Next
        Catch ex As Exception
            lblMessageRefundDtl.Visible = True
            lblMessageRefundDtl.Text = "ERROR GET DATA REFUND DETAIL : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        End Try

    End Sub

    Protected Sub gvDealerRefundDtl_DataBound(sender As Object, e As System.EventArgs) Handles gvDealerRefundDtl.DataBound
        Dim oTextBox As TextBox
        For Each row As GridViewRow In gvDealerRefundDtl.Rows
            oTextBox = CType(row.FindControl("txtCompenAllocate"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If
        Next
    End Sub

    Protected Sub gvDealerRefundDtl_RowDeleting(sender As Object, e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles gvDealerRefundDtl.RowDeleting

        Dim dtDealerRefundDtl As New System.Data.DataTable
        lblMessageRefundDtl.Text = ""
        lblMessageRefundDtl.Visible = False
        ClearString()
        dtDealerRefundDtl = ViewState("VSREFUNDDTL")
        GetDataRefundDtl(dtDealerRefundDtl)
        dtDealerRefundDtl = ViewState("VSREFUNDDTL")
        dtDealerRefundDtl.Rows.RemoveAt(e.RowIndex)
        dtDealerRefundDtl.AcceptChanges()

        ViewState("VSREFUNDDTL") = dtDealerRefundDtl
        If dtDealerRefundDtl.Rows.Count <= 0 Then
            AddRowEmpty()
        Else
            gvDealerRefundDtl.DataSource = dtDealerRefundDtl
            gvDealerRefundDtl.DataBind()
        End If

    End Sub

    Private Sub ClearString()
        oStrTotaltxtCompenAllocated = ""
        oStrtxtCompenAllocated = ""
        ostrTitlePosition = ""
        oStrValueRefund = ""
    End Sub

    Protected Sub gvDealerRefundDtl_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvDealerRefundDtl.RowDataBound
        Dim oTextBox As TextBox
        Dim oDropDownList As DropDownList

        If e.Row.RowType = DataControlRowType.DataRow Then
            TotalCompenAllocated += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PERSONREFUND"))
            oTextBox = CType(e.Row.FindControl("txtCompenAllocate"), TextBox)
            If oTextBox IsNot Nothing Then
                oStrtxtCompenAllocated = oStrtxtCompenAllocated & oTextBox.ClientID & ","
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
                oTextBox.Attributes.Add("onchange", "CalcTotalAllocated();")
                If Len(Trim(oTextBox.Text)) <= 0 Then
                    oTextBox.Text = "0.00"
                End If
            End If
            oDropDownList = CType(e.Row.FindControl("ddlPosition"), DropDownList)
            If oDropDownList IsNot Nothing Then
                ostrTitlePosition = ostrTitlePosition & oDropDownList.ClientID & ","
            End If

            oTextBox = CType(e.Row.FindControl("txtCompenAllocate"), TextBox)
            If oTextBox IsNot Nothing Then
                oStrValueRefund = oStrValueRefund & oTextBox.ClientID & ","
            End If
        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            Dim oLabel As TextBox
            oLabel = CType(e.Row.FindControl("txtTotalCompenAllocate"), TextBox)
            If oLabel IsNot Nothing Then
                oStrTotaltxtCompenAllocated = oLabel.ClientID
                oLabel.Text = String.Format("{0:n}", TotalCompenAllocated)
                SetObjectValidation(oLabel, False, "float", "[0-9.,]")
            End If
        End If

    End Sub

    Private Sub GetData(ByVal strKey As String)
        Dim objDB As New DBX
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT REFUNDID, PERSONTITLE, PERSONREFUND, INCLUDEDISBURSE, " & _
                                                " (dbo.f_getParamGlobalName('REFUNDTYPE',(SELECT REFUNDTYPE FROM REFUND WHERE REFUNDID=" & strKey & ")))AS REFUNDTYPE FROM REFUNDDTL WHERE (REFUNDID = " & strKey & ") AND (Deletests = 0)")
            If oSDR.HasRows Then
                Dim dtInsPrice As New System.Data.DataTable
                dtInsPrice.Load(oSDR)
                oSDR.Close()
                oSDR = Nothing

                If ViewState("VSREFUNDDTL") IsNot Nothing Then
                    ViewState("VSREFUNDDTL") = Nothing
                End If
                ViewState("VSREFUNDDTL") = dtInsPrice
                gvDealerRefundDtl.DataSource = dtInsPrice
                gvDealerRefundDtl.DataBind()
            Else
                AddRowEmpty()
            End If
        Catch ex As Exception
            lblMessageRefundDtl.Visible = True
            lblMessageRefundDtl.Text = "ERROR RETRIVE DATA (REFUND DETAIL) : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnSaveRefundDtl_Click(sender As Object, e As System.EventArgs) Handles btnSaveRefundDtl.Click
        Dim objDB As New DBX
        Try

            ' UPDATE STATUS DULU
            objDB.ExecSQLWithParam("UPDATE REFUNDDTL SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID WHERE REFUNDID=@REFUNDID", _
                    objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value), _
                    objDB.MP("@REFUNDID", Data.SqlDbType.BigInt, hidREFUNDID.Value))
            lblMessageRefundDtl.Text = ""
            lblMessageRefundDtl.Visible = False
            Dim iRows = gvDealerRefundDtl.Rows.Count - 1
            If gvDealerRefundDtl.Rows.Count > 0 Then
                For iRow = 0 To iRows
                    If NoComma(CType(gvDealerRefundDtl.Rows(iRow).FindControl("txtCompenAllocate"), TextBox).Text) > 0 Then
                        objDB.ExecSP("REFUNDDTLSave", _
                           objDB.MP("@REFUNDID", Data.SqlDbType.BigInt, hidREFUNDID.Value), _
                           objDB.MP("@PERSONTITLE", Data.SqlDbType.VarChar, CType(gvDealerRefundDtl.Rows(iRow).FindControl("ddlPosition"), DropDownList).SelectedValue), _
                           objDB.MP("@PERSONREFUND", Data.SqlDbType.Float, CType(gvDealerRefundDtl.Rows(iRow).FindControl("txtCompenAllocate"), TextBox).Text), _
                           objDB.MP("@INCLUDEDISBURSE", Data.SqlDbType.Bit, CType(gvDealerRefundDtl.Rows(iRow).FindControl("chkDisburse"), CheckBox).Checked), _
                           objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value))
                    End If
                Next
            End If
            ClearString()
            GetData(hidREFUNDID.Value)
            lblMessageRefundDtl.Visible = True
            lblMessageRefundDtl.Text = "UPDATE DEALER REFUND SUCCESFULLY..."
        Catch ex As Exception
            lblMessageRefundDtl.Visible = True
            lblMessageRefundDtl.Text = "ERROR SAVE DEALER REFUND DETAIL..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE: " & ex.Message
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Protected Sub BtnBackRefund_Click(sender As Object, e As System.EventArgs) Handles BtnBackRefund.Click
        MultiView_Utama.SetActiveView(View_View)
        GvDealer.SelectedIndex = -1
    End Sub

    Protected Sub BtnBackPersonACC_Click(sender As Object, e As System.EventArgs) Handles BtnBackPersonACC.Click
        MultiView_Utama.SetActiveView(View_DealerPerson)
    End Sub

    Protected Sub BtnBackPerson_Click(sender As Object, e As System.EventArgs) Handles BtnBackPerson.Click
        MultiView_Utama.SetActiveView(View_View)
    End Sub

    Protected Sub btnBackDealerAccount_Click(sender As Object, e As System.EventArgs) Handles btnBackDealerAccount.Click
        MultiView_Utama.SetActiveView(View_View)
    End Sub
    

    Protected Sub btnViewFinStructure_Command(sender As Object, e As System.Web.UI.WebControls.CommandEventArgs)
        Dim currentCommand As String = e.CommandName
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument)
        Try
            lblMessageRefundDtl.Text = ""
            lblMessageRefundDtl.Visible = False
            hidDealerID.Value = GvDealer.DataKeys(currentRowIndex).Value
            MultiView_Utama.SetActiveView(ViewDealerFinStructure)
            ajaxCDDProduct.SelectedValue = 0
            ajaxCDDCategory.SelectedValue = 0
            ajaxCDDObjectKind.SelectedValue = 0
            GetDataFinStructure(hidDealerID.Value)
           
        Catch ex As Exception
            lblMessageFinStructure.Text = Validation.ReplaceMessage(ex.Message.ToString)
        End Try
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
    Protected Sub btnNewFnStruc_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs)
        Try

            Dim dtDPMinimum As New System.Data.DataTable
            Dim drDPMinimum As System.Data.DataRow

            dtDPMinimum = ViewState("VW_DPMINIMUM")

            GetDataDPMinimum(dtDPMinimum)
            drDPMinimum = dtDPMinimum.NewRow()

            drDPMinimum("DEALERID") = "0"
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
            lblMessageFinStructure.Visible = True
            lblMessageFinStructure.Text = "ERROR NEW FINANCE STRUCTURE : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        End Try
    End Sub

    Private Sub GetDataDPMinimum(ByRef dtDPMinimum As System.Data.DataTable)

        dtDPMinimum.Clear()
        'Dim oImageDel As ImageButton
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
            
            drDPMinimum("DEALERID") = "0"
            drDPMinimum("PRODUCTID") = "0"
            drDPMinimum("PURPOSECATID") = "0"
            drDPMinimum("CATEGORYID") = "0"

            drDPMinimum("FINID") = iFinID
            drDPMinimum("YEARFROM") = sYEARFROM
            drDPMinimum("YEARTO") = sYEARTO
            drDPMinimum("CONDITION") = sCONDITION
            drDPMinimum("DP") = String.Format("{0:N}", sDP)
            drDPMinimum("REMARK") = sDESCRIPTION

            dtDPMinimum.Rows.Add(drDPMinimum)
            'oImageDel = CType(gvRow.FindControl("btnDelete"), ImageButton)
            'oImageDel.Visible = False
        Next
    End Sub

    Protected Sub btnSearch_Click(sender As Object, e As System.EventArgs) Handles btnSearch.Click
        GetDataFnStrucSearch()
    End Sub
    Private Sub GetDataFnStrucSearch()
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT DEALERID,PRODUCTID,PURPOSECATID,CATEGORYID,FINID,CAST(YEARFROM AS VARCHAR(10))YEARFROM,CAST(YEARTO AS VARCHAR(10))YEARTO, CAST(CONDITION AS VARCHAR(10)) CONDITION, DP,REMARK FROM FNFINSTRUCTURE WHERE (Deletests = 0)" & _
                                               " AND (DEALERID= " & hidDealerID.Value & ") AND (PRODUCTID=" & ddlProduct.SelectedValue & ") AND (CATEGORYID=" & ddlCategory.SelectedValue & ") AND (PURPOSECATID =" & ddlObjectKind.SelectedValue & ")")

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
        Catch ex As Exception
            lblMessageFinStructure.Visible = True
            lblMessageFinStructure.Text = "ERROR RETRIVE DATA (FINANCE STRUCTURE) ENTRY: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Private Sub AddRowEmptyDPMinimum()
        Dim dt As New DataTable()
        Dim dr As DataRow = Nothing
        ' Dim oImageDel As ImageButton

        dt.Columns.Add(New DataColumn("DEALERID", GetType(String)))
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
        dr("DEALERID") = 0
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
        lblMessageFinStructure.Visible = False
    End Sub
    Private Sub GetDataFinStructure(ByVal sDealerID As String)
        Dim objDB As New DBX
        Try

            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT  * " & _
            "  FROM dbo.FNFINSTRUCTURE WITH(NOLOCK) WHERE DEALERID=" & sDealerID)
            If oSDR.Read Then
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

                oSDR = objDB.CreateSDRFromSQLSelect("SELECT CAST(DEALERID AS VARCHAR(10)) AS DEALERID,PRODUCTID,PURPOSECATID,CATEGORYID,FINID,CAST(YEARFROM AS VARCHAR(10))YEARFROM,CAST(YEARTO AS VARCHAR(10))YEARTO, CAST(CONDITION AS VARCHAR(10))AS CONDITION, DP,REMARK FROM FNFINSTRUCTURE WHERE (Deletests = 0)" & _
                                                    " AND (DEALERID= " & sDealerID & ")")
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
                    gvDPMinimum.DataSource = Nothing
                    gvDPMinimum.DataBind()
                    ' AddRowEmptyDPMinimum()
                End If
            Else
                gvDPMinimum.DataSource = Nothing
                gvDPMinimum.DataBind()
            End If
        Catch ex As Exception
            lblMessageFinStructure.Visible = True
            lblMessageFinStructure.Text = "ERROR RETRIVE DATA (FINANCE STRUCTURE) ENTRY: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
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
        If gvDPMinimum.Rows.Count <= 0 Then
            AddRowEmptyDPMinimum()
        End If

    End Sub
    Protected Sub btnSaveFnStructure_Click(sender As Object, e As System.EventArgs) Handles btnSaveFnStructure.Click
        Dim objDB As New DBX
        Dim oSDR As Data.SqlClient.SqlDataReader
        lblMessageFinStructure.Text = ""
        lblMessageFinStructure.Visible = False

        If DirectCast(ViewState("VW_DPMINIMUM"), DataTable) IsNot Nothing Then
            oSDR = objDB.CreateSDRFromExecSQL("Update dbo.FNFINSTRUCTURE SET DeleteSTS=1, LASTUPDATE=GETDATE(), LASTUSERID=" & Request.Cookies("UID").Value & " WHERE DEALERID=" & hidDealerID.Value)
            If oSDR.Read() Then
            End If
            oSDR.Close()
            oSDR = Nothing
            Dim dtInsPricingSave As New System.Data.DataTable
            dtInsPricingSave = ViewState("VW_DPMINIMUM")
            GetDataDPMinimum(dtInsPricingSave)
            For Each row As System.Data.DataRow In dtInsPricingSave.Rows
                If row.Item("YEARFROM").ToString() > "0" Then
                    SaveFinanceStructure(hidDealerID.Value, ddlProduct.SelectedValue,
                                     ddlObjectKind.SelectedValue, ddlCategory.SelectedValue, row.Item("FINID").ToString(),
                                    row.Item("YEARFROM").ToString(),
                                    row.Item("YEARTO").ToString(),
                                    row.Item("CONDITION").ToString(),
                                    row.Item("DP").ToString(),
                                    row.Item("REMARK").ToString())
                End If
            Next
        End If

        If DirectCast(ViewState("VW_DPMINIMUM"), DataTable) Is Nothing Then
        Else
            DirectCast(ViewState("VW_DPMINIMUM"), DataTable).Rows.Clear()
            DirectCast(ViewState("VW_DPMINIMUM"), DataTable).Dispose()
        End If
        GetDataFinStructure(hidDealerID.Value)
        GetDataFnStrucSearch()
        ' MultiView_Utama.SetActiveView(View_View)
        'DataSearch()
    End Sub
    Private Sub SaveFinanceStructure(ByVal iDealerID As String, ByVal iProductID As Integer,
                                        ByVal iPurposeCatID As Integer, ByVal iCategoryID As Integer,
                                        ByVal iFinID As Integer, ByVal iYearFrom As Integer,
                                        ByVal iYearTo As Integer, ByVal iCondition As Integer,
                                        ByVal sDP As String, ByVal sRemark As String)

        Dim objDB As New DBX
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try

            oSQLParam = objDB.ExecSPReturnParam("FNFINSTRUCTURESave", _
                   objDB.MP("@FINID", Data.SqlDbType.BigInt, iFinID, 8), _
                   objDB.MP("@DEALERID", Data.SqlDbType.Int, iDealerID, 4), _
                   objDB.MP("@AREAID", Data.SqlDbType.Int, "", 4), _
                   objDB.MP("@BRANCHID", Data.SqlDbType.Int, "", 4), _
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
            lblMessageFinStructure.Visible = True
            lblMessageFinStructure.Text = "ERROR SAVE DATA FINANCING STRUCTURE : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnbackView_Click(sender As Object, e As System.EventArgs) Handles btnbackView.Click
        MultiView_Utama.SetActiveView(View_View)

        If DirectCast(ViewState("VW_DPMINIMUM"), DataTable) Is Nothing Then
        Else
            DirectCast(ViewState("VW_DPMINIMUM"), DataTable).Rows.Clear()
            DirectCast(ViewState("VW_DPMINIMUM"), DataTable).Dispose()
        End If
        lblMessageFinStructure.Visible = False
        hidDealerID.Value = ""
    End Sub
    Protected Sub btnFNDetail_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        Dim currentCommand As String = e.CommandName
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument)
        Try
            hidFinID.Value = CType(gvDPMinimum.Rows(currentRowIndex).FindControl("txtFINID"), TextBox).Text
            MultiView_Utama.SetActiveView(ViewFnStructureDtl)
            GetDataDetail(hidFinID.Value)
            pnlControlIntRate.Visible = True
        Catch ex As Exception
            lblMessageIntRate.Visible = True
            lblMessageIntRate.Text = "ERROR RETRIEVE DATA FINANCING STRUCTURE DETAIL : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        End Try

    End Sub
    Protected Sub gvEffRate_RowCreated(sender As Object, e As GridViewRowEventArgs)
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
        'Dim oImageDel As ImageButton

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

        
    End Sub

    Protected Sub btnBackIntRate_Click(sender As Object, e As System.EventArgs) Handles btnBackIntRate.Click
        MultiView_Utama.SetActiveView(ViewDealerFinStructure)
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
        Dim sTenorOPR1 As String, sTenorFrom As String, sTenorOPR2 As String, sTenorTo As String,
                sPrincipalOPR1 As String, sPrincipalFrom As Double, sPrincipalOPR2 As String
        Dim sPrincipalTo As Double, sRouteKind As String, sEffRate As Double
        Dim drEffectiveRate As System.Data.DataRow
        Dim oTextBox As TextBox
        Dim oLabel As Label
        'Dim oImageDel As ImageButton
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
            '  oImageDel = CType(gvRow.FindControl("btnDelete"), ImageButton)
            ' oImageDel.Visible = False
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
        Dim oSDR As Data.SqlClient.SqlDataReader
        Try

            If DirectCast(ViewState("VW_EFFECTIVERATE"), DataTable) IsNot Nothing Then
                oSDR = objDB.CreateSDRFromExecSQL("Update dbo.FNFINSTRUCTUREDTL SET DeleteSTS=1,LASTUPDATE=GETDATE() , LASTUSERID=" & Request.Cookies("UID").Value & " WHERE FINID=" & hidFinID.Value)

                If oSDR.Read() Then
                End If
                oSDR.Close()
                Dim dtIntRate As New System.Data.DataTable
                dtIntRate = ViewState("VW_EFFECTIVERATE")
                GetDataEffRate(dtIntRate)
                For Each row As System.Data.DataRow In dtIntRate.Rows
                    '     Response.Write(dtIntRate.Rows.Count)
                    If row.Item("TENOROPR1").ToString() <> "" Then
                        SaveFinanceStructureDtl(hidFinID.Value, row.Item("FINDTLID").ToString(), row.Item("TENOROPR1").ToString(), row.Item("TENORFROM").ToString(),
                                         row.Item("TENOROPR2").ToString(), row.Item("TENORTO").ToString(), row.Item("PRINCIPALOPR1").ToString(),
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
            ' MultiView_Utama.SetActiveView(ViewDealerFinStructure)
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
        If gvEffRate.Rows.Count <= 0 Then
            AddRowEmptyEffRate()
        End If


    End Sub

End Class
