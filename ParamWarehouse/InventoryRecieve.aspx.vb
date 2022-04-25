
Partial Class ParamWarehouse_InventoryRecieve
    Inherits System.Web.UI.Page
    Public strGroupID As String
    Public strGroup As String
    Public strItemID As String
    Public strItem As String
    Public strBuyerID As String
    Public strBuyer As String
    Public strSupplierID As String
    Public strSupplier As String
    Public strUnitID As String
    Public strUnit As String
    Public strWSID As String
    Public strWS As String
    Public strSO As String
    Public strSOID As String
    Public strRack As String
    Public strRackID As String


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ''SetObjectValidation(txtSearch, True)
        End If
        'pnlDataDtl.Visible = False
        ddlCriteriaDtl.Visible = False
        txtSearchDtl.Visible = False
        btnFunctionSearchDtl.Visible = False
        imgBtnNewDetail.Visible = False
        gvDataDtl.Visible = False

        'pnlShowDtl.Visible = False
        DataSearch()
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub gvData_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        'lblError.Text = ""
        lblError.Visible = False
        If e.CommandName = "Select" Then
            fvData.ChangeMode(FormViewMode.Edit)
            fvData.Caption = "Edit Data"
            'pnlDataDtl.Visible = True
            ddlCriteriaDtl.Visible = True
            txtSearchDtl.Visible = True
            btnFunctionSearchDtl.Visible = True
            imgBtnNewDetail.Visible = True
            gvDataDtl.Visible = True
            'pnlShowDtl.Visible = True
            'fvDataDtl.Visible = False
        End If
    End Sub
    Protected Sub gvDataDtl_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvDataDtl.RowCommand
        'lblError.Text = ""
        lblError.Visible = False
        If e.CommandName = "Select" Then
            'pnlDataDtl.Visible = True
            ddlCriteriaDtl.Visible = True
            txtSearchDtl.Visible = True
            btnFunctionSearchDtl.Visible = True
            imgBtnNewDetail.Visible = True
            'pnlShowDtl.Visible = True
            fvDataDtl.Caption = "Edit Data"
            'fvDataDtl.Visible = False
            'fvDataDtl.ChangeMode(FormViewMode.Edit)
            gvDataDtl.Visible = True
        End If
    End Sub
    Protected Sub imgBtnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        fvData.ChangeMode(FormViewMode.Insert)
        fvData.Caption = "New Data"
       
    End Sub

    Private Sub SetValidation()
        Dim oTextBox As TextBox
        oTextBox = CType(fvData.FindControl("txtInvRecvCode"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase nospace")
            oTextBox.Focus()
        End If
        oTextBox = CType(fvData.FindControl("txtInvRecvCode"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")

    End Sub

    Private Sub DataSearch()
        If Not IsPostBack() Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND IH.INVENTORYRECVID=-999"
        End If
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        gvData.DataBind()
        gvDataDtl.DataBind()
        'pnlDataDtl.Visible = True
    End Sub


    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        'DataSearch()
        'lblError.Text = ""
        lblError.Visible = False
    End Sub
    Protected Sub fvData_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvData.ItemCreated
        Dim oTextBox As TextBox
        oTextBox = CType(fvData.FindControl("txtGroup"), TextBox)
        If oTextBox IsNot Nothing Then
            strGroup = oTextBox.ClientID
        End If
        oTextBox = CType(fvData.FindControl("txtItemMaster"), TextBox)
        If oTextBox IsNot Nothing Then
            strItem = oTextBox.ClientID
        End If
        Dim oHidden As HiddenField
        Dim ohidItem As HiddenField
        oHidden = CType(fvData.FindControl("hidGroup"), HiddenField)
        If oHidden IsNot Nothing Then
            strGroupID = oHidden.ClientID
        End If
        ohidItem = CType(fvData.FindControl("hidItem"), HiddenField)
        If ohidItem IsNot Nothing Then
            strItemID = ohidItem.ClientID
        End If
        DataSearch()
       
    End Sub
    Protected Sub fvDataDtl_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvDataDtl.ItemCreated
        Dim oTextBox As TextBox
        oTextBox = CType(fvDataDtl.FindControl("txtSO"), TextBox)
        If oTextBox IsNot Nothing Then
            strSO = oTextBox.ClientID
        End If
        oTextBox = CType(fvDataDtl.FindControl("txtWS"), TextBox)
        If oTextBox IsNot Nothing Then
            strWS = oTextBox.ClientID
        End If
        oTextBox = CType(fvDataDtl.FindControl("txtBuyer"), TextBox)
        If oTextBox IsNot Nothing Then
            strBuyer = oTextBox.ClientID
        End If
        oTextBox = CType(fvDataDtl.FindControl("txtSupplier"), TextBox)
        If oTextBox IsNot Nothing Then
            strSupplier = oTextBox.ClientID
        End If
        oTextBox = CType(fvDataDtl.FindControl("txtRack"), TextBox)
        If oTextBox IsNot Nothing Then
            strRack = oTextBox.ClientID
        End If
        Dim ohidBuyer As HiddenField
        Dim ohidSupplier As HiddenField
        Dim ohidSO As HiddenField
        Dim ohidRack As HiddenField
        Dim ohidWS As HiddenField


        ohidSO = CType(fvDataDtl.FindControl("hidSO"), HiddenField)
        If ohidSO IsNot Nothing Then
            strSOID = ohidSO.ClientID
        End If
        ohidWS = CType(fvDataDtl.FindControl("hidWS"), HiddenField)
        If ohidWS IsNot Nothing Then
            strWSID = ohidWS.ClientID
        End If
        ohidBuyer = CType(fvDataDtl.FindControl("hidBuyer"), HiddenField)
        If ohidBuyer IsNot Nothing Then
            strBuyerID = ohidBuyer.ClientID
        End If
        ohidSupplier = CType(fvDataDtl.FindControl("hidSupplier"), HiddenField)
        If ohidSupplier IsNot Nothing Then
            strSupplierID = ohidSupplier.ClientID
        End If
        ohidRack = CType(fvDataDtl.FindControl("hidRack"), HiddenField)
        If ohidRack IsNot Nothing Then
            strRackID = ohidRack.ClientID
        End If
        
        DataSearch()

    End Sub

    Protected Sub fvData_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvData.ItemCommand
        If e.CommandName = "Cancel" Then
            gvData.SelectedIndex = -1
            fvData.Caption = ""
        End If
    End Sub

    Protected Sub sdsForm_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Inserted
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Code : " & e.Command.Parameters("@INVENTORYRECVCODE").Value & " already exists..!"
        Else
            lblError.Visible = False
            fvData.Caption = ""
        End If
        DataSearch()
    End Sub

    Protected Sub sdsFormDtl_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsFormDtl.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Code : " & e.Command.Parameters("@INVENTORYRECVDTLCODE").Value & " already exists..!"
        End If
        gvDataDtl.Visible = True
        'pnlDataDtl.Visible = True
        ddlCriteriaDtl.Visible = True
        txtSearchDtl.Visible = True
        btnFunctionSearchDtl.Visible = True
        imgBtnNewDetail.Visible = True
        'pnlShowDtl.Visible = True
        DataSearch()
    End Sub
    Protected Sub sdsForm_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Code : " & e.Command.Parameters("@INVENTORYRECVCODE").Value & " already exists..!"
        End If
        DataSearch()
    End Sub

    Protected Sub sdsForm_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Deleted
        fvData.Caption = ""
        DataSearch()
    End Sub

    Protected Sub btnApprove_Click(sender As Object, e As EventArgs)
        Dim objDB As New DBX
        Dim olblInventoryRecvID As Label
        olblInventoryRecvID = CType(fvData.FindControl("lblInventoryRecvID"), Label)
        Try
            objDB.ExecSQLWithParam("UPDATE INVENTORYRECV SET STATUS = 1 WHERE INVENTORYRECVID =@INVENTORYRECVID",
                                     objDB.MP("@INVENTORYRECVID", Data.SqlDbType.BigInt, olblInventoryRecvID.Text))
        Catch ex As Exception
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        DataSearch()
    End Sub
    Protected Sub btnApproveDtl_Click(sender As Object, e As EventArgs)
        Dim objDB As New DBX
        Dim olblInventoryRecvID As TextBox
        olblInventoryRecvID = CType(fvData.FindControl("lblInventoryRecvDtlID"), TextBox)
        Try
            objDB.ExecSQLWithParam("UPDATE INVENTORYRECVDTL SET STATUS = 1 WHERE INVENTORYRECVDTLID =@INVENTORYRECVDTLID",
                                     objDB.MP("@INVENTORYRECVDTLID", Data.SqlDbType.BigInt, olblInventoryRecvID.Text))
        Catch ex As Exception
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        gvDataDtl.Visible = True
        DataSearch()
    End Sub

    Protected Sub ddlPurchasingOrder_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim oddlPurchasingOrder As DropDownList
        Dim oTextBox2 As TextBox
        oddlPurchasingOrder = CType(fvData.FindControl("ddlPurchasingOrder"), DropDownList)
        oTextBox2 = CType(fvData.FindControl("TextBox2"), TextBox)
        If oddlPurchasingOrder.SelectedValue > 0 Then
            oTextBox2.Visible = True
        End If
    End Sub

    Protected Sub imgBtnNewDetail_Click(sender As Object, e As ImageClickEventArgs) Handles imgBtnNewDetail.Click
        fvDataDtl.ChangeMode(FormViewMode.Insert)
        fvDataDtl.Caption = "New Data"
        'pnlDataDtl.Visible = True
        ddlCriteriaDtl.Visible = True
        txtSearchDtl.Visible = True
        btnFunctionSearchDtl.Visible = True
        imgBtnNewDetail.Visible = True
        'pnlShowDtl.Visible = True
        fvDataDtl.Visible = True
    End Sub

    Protected Sub btnSaveInvDtl_Click(sender As Object, e As EventArgs)
        Dim objDB As New DBX
        Dim intRetVal As Integer
        Dim olblInventoryRecvHdrID As Label
        Dim otxtInvRecvCodeDtl As TextBox
        Dim otxtDetailUnit As TextBox
        Dim oddlUnitDetail As DropDownList
        Dim otxtSectionNo As TextBox
        Dim otxtLotNumber As TextBox
        Dim otxtPOBuyer As TextBox
        Dim ohidSO As HiddenField
        Dim ohidWS As HiddenField
        Dim ohidBuyer As HiddenField
        Dim ohidSupplier As HiddenField
        Dim ohidRack As HiddenField
        Dim otxtDescDtl As TextBox

        otxtInvRecvCodeDtl = CType(fvDataDtl.FindControl("txtInvRecvCodeDtl"), TextBox)
        olblInventoryRecvHdrID = CType(fvDataDtl.FindControl("lblInventoryRecvHdrID"), Label)
        otxtSectionNo = CType(fvDataDtl.FindControl("txtSectionNo"), TextBox)
        otxtDetailUnit = CType(fvDataDtl.FindControl("txtDetailUnit"), TextBox)
        oddlUnitDetail = CType(fvDataDtl.FindControl("ddlUnitDetail"), DropDownList)
        otxtLotNumber = CType(fvDataDtl.FindControl("txtLotNumber"), TextBox)
        otxtPOBuyer = CType(fvDataDtl.FindControl("txtPOBuyer"), TextBox)
        ohidSO = CType(fvDataDtl.FindControl("hidSO"), HiddenField)
        ohidWS = CType(fvDataDtl.FindControl("hidWS"), HiddenField)
        ohidBuyer = CType(fvDataDtl.FindControl("hidBuyer"), HiddenField)
        ohidSupplier = CType(fvDataDtl.FindControl("hidSupplier"), HiddenField)
        ohidRack = CType(fvDataDtl.FindControl("hidRack"), HiddenField)
        otxtDescDtl = CType(fvDataDtl.FindControl("txtDescDtl"), TextBox)

        Try
            intRetVal = objDB.ExecSPReturnInteger("INVENTORYRECVDTLADD", _
                                                 objDB.MP("@INVENTORYRECVDTLCODE", Data.SqlDbType.VarChar, otxtInvRecvCodeDtl.Text),
                                                 objDB.MP("@INVENTORYRECVID", Data.SqlDbType.Int, olblInventoryRecvHdrID.Text),
                                                 objDB.MP("@SECTIONNO", Data.SqlDbType.VarChar, otxtSectionNo.Text),
                                                 objDB.MP("@DETAILUNIT", Data.SqlDbType.Decimal, otxtDetailUnit.Text),
                                                 objDB.MP("@MASTERUNITID", Data.SqlDbType.VarChar, oddlUnitDetail.Text),
                                                 objDB.MP("@LOTNUMBER", Data.SqlDbType.VarChar, otxtLotNumber.Text),
                                                 objDB.MP("@POBUYER", Data.SqlDbType.VarChar, otxtPOBuyer.Text),
                                                 objDB.MP("@SALESORDERID", Data.SqlDbType.Int, ohidSO.Value),
                                                 objDB.MP("@WORKSHEETHDRID", Data.SqlDbType.Int, ohidWS.Value),
                                                 objDB.MP("@BUYERID", Data.SqlDbType.Int, ohidBuyer.Value),
                                                 objDB.MP("@SUPPLIERID", Data.SqlDbType.Int, ohidSupplier.Value),
                                                 objDB.MP("@MASTERRACKID", Data.SqlDbType.Int, ohidRack.Value),
                                                 objDB.MP("@NOTES", Data.SqlDbType.VarChar, otxtDescDtl.Text),
                                                 objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value))
        Catch ex As Exception
            lblError.Visible = True
            lblError.Text = "ERROR CREATE INVENTORY DETAIL: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        DataSearch()
        'pnlDataDtl.Visible = True
    End Sub
End Class