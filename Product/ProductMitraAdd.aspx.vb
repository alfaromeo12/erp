Imports System.IO
Imports System.Data.SqlClient
Imports System.Data
Imports System.Drawing
Partial Class Product_ProductMitraAdd
    Inherits System.Web.UI.Page
    Public Shared iError As Integer = 0
    Private iPrdId As Integer
    Public strServiceTypeId As String
    Public strServiceType As String
    Public strServiceTypeDtlId As String
    Public strServiceTypeDtl As String
    Public strArmadaTypeId As String
    Public strArmadaType As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ''SetObjectValidation(txtSearch, True)
        End If
        gvData.DataBind()
        fvData.Visible = True
        pnlImg.Visible = False
        DataSearch()
    End Sub
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub
    Public Function getStatus(ByVal STATUSACTIVE As Boolean) As String
        getStatus = "Yes"
        If Not STATUSACTIVE Then
            getStatus = "No"
        End If
    End Function
    Protected Sub gvData_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        'lblError.Text = ""
        lblError.Visible = False
        If e.CommandName = "Select" Then
            Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument).ToString
            fvData.ChangeMode(FormViewMode.Edit)
            fvData.Caption = "Edit Data"
            fvData.Visible = True
            pnlImg.Visible = True
            iPrdId = gvData.DataKeys(currentRowIndex).Value
            imgProduct.ImageUrl = "~/Product/DisplayImagesProductMitra.ashx?PRODUCTMITRAID=" & iPrdId
        End If
    End Sub
    Protected Sub imgBtnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        fvData.ChangeMode(FormViewMode.Insert)
        fvData.Caption = "New Data"
        imgProduct.Visible = False
    End Sub
    Protected Sub fvData_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvData.ItemCreated
        SetValidation()
    End Sub
    Private Sub SetValidation()
        Dim ohidService As HiddenField
        Dim ohidServDtl As HiddenField
        Dim ohidArmadaType As HiddenField
        Dim oTextBox As TextBox
        oTextBox = CType(fvData.FindControl("txtProductMitraCode"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase nospace")
            oTextBox.Focus()
        End If
        oTextBox = CType(fvData.FindControl("txtServiceType"), TextBox)
        If oTextBox IsNot Nothing Then
            strServiceType = oTextBox.ClientID
        End If
        oTextBox = CType(fvData.FindControl("txtServDtl"), TextBox)
        If oTextBox IsNot Nothing Then
            strServiceTypeDtl = oTextBox.ClientID
        End If
        oTextBox = CType(fvData.FindControl("txtArmadaType"), TextBox)
        If oTextBox IsNot Nothing Then
            strArmadaType = oTextBox.ClientID
        End If
        ohidService = CType(fvData.FindControl("hidService"), HiddenField)
        If ohidService IsNot Nothing Then
            strServiceTypeId = ohidService.ClientID
        End If
        ohidServDtl = CType(fvData.FindControl("hidServDtl"), HiddenField)
        If ohidServDtl IsNot Nothing Then
            strServiceTypeDtlId = ohidServDtl.ClientID
        End If
        ohidArmadaType = CType(fvData.FindControl("hidArmadaType"), HiddenField)
        If ohidArmadaType IsNot Nothing Then
            strArmadaTypeId = ohidArmadaType.ClientID
        End If
    End Sub
    Private Sub DataSearch()
        'If Len(Trim(txtSearch.Text)) > 0 Then
        '    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        'End If
        pnlImg.Visible = False
        gvData.DataBind()
    End Sub
    'Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
    '    lblError.Visible = False
    'End Sub
    Protected Sub fvData_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvData.ItemCommand
        If e.CommandName = "Cancel" Then
            gvData.SelectedIndex = -1
            fvData.Caption = ""
            imgProduct.Visible = False
            gvData.Visible = True
        End If
    End Sub
    Protected Sub sdsForm_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Deleted
        fvData.Caption = ""
        DataSearch()
    End Sub

    Protected Sub btnUpdate_Click(sender As Object, e As EventArgs)
        Dim objDB As New DBX
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Dim intRetVal As Integer
        Dim OArtwork As FileUpload = CType(fvData.FindControl("FileImageArtWork"), FileUpload)
        Dim olblProductMitraID As Label = CType(fvData.FindControl("lblProductMitraID"), Label)
        Dim otxtProductMitraCode As TextBox = CType(fvData.FindControl("txtProductMitraCode"), TextBox)
        Dim otxtBrand As TextBox = CType(fvData.FindControl("txtBrand"), TextBox)
        Dim otxtImageUrl As TextBox = CType(fvData.FindControl("txtImageUrl"), TextBox)
        Dim otxtPrice As TextBox = CType(fvData.FindControl("txtPrice"), TextBox)
        Dim otxtQty As TextBox = CType(fvData.FindControl("txtQty"), TextBox)
        Dim otxtDesc As TextBox = CType(fvData.FindControl("txtDesc"), TextBox)
        Dim oddlUnitPrice As DropDownList = CType(fvData.FindControl("ddlUnitPrice"), DropDownList)
        Dim oddlStatus As DropDownList = CType(fvData.FindControl("ddlStatus"), DropDownList)
        Dim oddlActive As DropDownList = CType(fvData.FindControl("ddlActive"), DropDownList)
        Dim strFilePathSignImage As String = OArtwork.PostedFile.FileName
        Dim strfileNameSignImage As String = Path.GetFileName(strFilePathSignImage)
        Dim strExtSignImage As String = Path.GetExtension(strFilePathSignImage)
        Dim ohidMitra As HiddenField
        ohidMitra = CType(fvData.FindControl("hidMitra"), HiddenField)
        Dim ohidService As HiddenField
        ohidService = CType(fvData.FindControl("hidService"), HiddenField)
        Dim ohidServDtl As HiddenField
        ohidServDtl = CType(fvData.FindControl("hidServDtl"), HiddenField)
        Dim ohidArmadaType As HiddenField
        ohidArmadaType = CType(fvData.FindControl("hidArmadaType"), HiddenField)

        Try
            Dim imgByte As Byte() = Nothing
            Dim img As FileUpload = CType(OArtwork, FileUpload)
            If img.HasFile AndAlso Not img.PostedFile Is Nothing Then
                Dim file As HttpPostedFile = OArtwork.PostedFile
                imgByte = New Byte(file.ContentLength - 1) {}
                file.InputStream.Read(imgByte, 0, file.ContentLength)
                oSQLParam = objDB.ExecSPReturnParam("PRODUCTMITRAUPDATE",
                                                            objDB.MP("@PRODUCTMITRAID", Data.SqlDbType.Int, olblProductMitraID.Text),
                                                            objDB.MP("@PRODUCTMITRACODE", Data.SqlDbType.VarChar, otxtProductMitraCode.Text),
                                                            objDB.MP("@SERVICETYPEID", Data.SqlDbType.Int, ohidService.Value),
                                                            objDB.MP("@SERVICETYPEDTLID", Data.SqlDbType.Int, ohidServDtl.Value),
                                                            objDB.MP("@ARMADATYPEID", Data.SqlDbType.Int, ohidArmadaType.Value),
                                                            objDB.MP("@PRODUCTBRAND", Data.SqlDbType.VarChar, otxtBrand.Text),
                                                            objDB.MP("@PRICE", Data.SqlDbType.Decimal, otxtPrice.Text),
                                                            objDB.MP("@UNITPRICE", Data.SqlDbType.Int, oddlUnitPrice.SelectedValue),
                                                            objDB.MP("@IMAGEURL", Data.SqlDbType.VarChar, otxtImageUrl.Text),
                                                            objDB.MPByte("@IMAGEPRODUCT", Data.SqlDbType.Image, imgByte),
                                                            objDB.MP("@STATUSPRODUCT", Data.SqlDbType.Int, oddlStatus.SelectedValue),
                                                            objDB.MP("@STATUSACTIVE", Data.SqlDbType.Bit, oddlActive.SelectedValue),
                                                            objDB.MP("@QTY", Data.SqlDbType.Decimal, otxtQty.Text),
                                                            objDB.MP("@DESCRIPTION", Data.SqlDbType.VarChar, otxtDesc.Text),
                                                            objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, Data.ParameterDirection.Output))
                intRetVal = oSQLParam("@RETVAL").Value.ToString()
            Else
                oSQLParam = objDB.ExecSPReturnParam("PRODUCTMITRAUPDATEX",
                                                            objDB.MP("@PRODUCTMITRAID", Data.SqlDbType.Int, olblProductMitraID.Text),
                                                            objDB.MP("@PRODUCTMITRACODE", Data.SqlDbType.VarChar, otxtProductMitraCode.Text),
                                                            objDB.MP("@SERVICETYPEID", Data.SqlDbType.Int, ohidService.Value),
                                                            objDB.MP("@SERVICETYPEDTLID", Data.SqlDbType.Int, ohidServDtl.Value),
                                                            objDB.MP("@ARMADATYPEID", Data.SqlDbType.Int, ohidArmadaType.Value),
                                                            objDB.MP("@PRODUCTBRAND", Data.SqlDbType.VarChar, otxtBrand.Text),
                                                            objDB.MP("@PRICE", Data.SqlDbType.Decimal, otxtPrice.Text),
                                                            objDB.MP("@UNITPRICE", Data.SqlDbType.Int, oddlUnitPrice.SelectedValue),
                                                            objDB.MP("@IMAGEURL", Data.SqlDbType.VarChar, otxtImageUrl.Text),
                                                            objDB.MP("@STATUSPRODUCT", Data.SqlDbType.Int, oddlStatus.SelectedValue),
                                                            objDB.MP("@STATUSACTIVE", Data.SqlDbType.Bit, oddlActive.SelectedValue),
                                                            objDB.MP("@QTY", Data.SqlDbType.Decimal, otxtQty.Text),
                                                            objDB.MP("@DESCRIPTION", Data.SqlDbType.VarChar, otxtDesc.Text),
                                                            objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, Data.ParameterDirection.Output))
                intRetVal = oSQLParam("@RETVAL").Value.ToString()
            End If
            Catch ex As Exception
            If intRetVal = -1 Then
                lblError.Visible = True
                lblError.Text = "ERROR UPDATE DATA <BR> PLEASE CHECK DETAIL ERROR MESSAGE...!"
                iError = 1
            Else
                lblError.Text = ""
                lblError.Visible = True
                lblError.Text = "ERROR SAVE DATA : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
                iError = 0
                gvData.DataBind()
            End If
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        gvData.DataBind()
        gvData.Visible = True
        DataSearch()
        fvData.Visible = True
        pnlImg.Visible = True
        imgProduct.Visible = True
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs)
        Dim objDB As New DBX
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Dim intRetVal As Integer
        Dim OArtwork As FileUpload = CType(fvData.FindControl("FileImageArtWork"), FileUpload)
        Dim oLabel21 As System.Web.UI.WebControls.Label = CType(dlAppData.FindControl("Label21"), System.Web.UI.WebControls.Label)
        Dim otxtProductMitraCode As TextBox = CType(fvData.FindControl("txtProductMitraCode"), TextBox)
        Dim otxtBrand As TextBox = CType(fvData.FindControl("txtBrand"), TextBox)
        Dim otxtPrice As TextBox = CType(fvData.FindControl("txtPrice"), TextBox)
        Dim otxtQty As TextBox = CType(fvData.FindControl("txtQty"), TextBox)
        Dim otxtDesc As TextBox = CType(fvData.FindControl("txtDesc"), TextBox)
        Dim oddlUnitPrice As DropDownList = CType(fvData.FindControl("ddlUnitPrice"), DropDownList)
        Dim oddlStatus As DropDownList = CType(fvData.FindControl("ddlStatus"), DropDownList)
        Dim oddlActive As DropDownList = CType(fvData.FindControl("ddlActive"), DropDownList)
        Dim strFilePathSignImage As String = OArtwork.PostedFile.FileName
        Dim strfileNameSignImage As String = Path.GetFileName(strFilePathSignImage)
        Dim strExtSignImage As String = Path.GetExtension(strFilePathSignImage)
        Dim ohidMitra As HiddenField
        ohidMitra = CType(fvData.FindControl("hidMitra"), HiddenField)
        Dim ohidService As HiddenField
        ohidService = CType(fvData.FindControl("hidService"), HiddenField)
        Dim ohidServDtl As HiddenField
        ohidServDtl = CType(fvData.FindControl("hidServDtl"), HiddenField)
        Dim ohidArmadaType As HiddenField
        ohidArmadaType = CType(fvData.FindControl("hidArmadaType"), HiddenField)
        Try
            Dim imgByte As Byte() = Nothing
            Dim img As FileUpload = CType(OArtwork, FileUpload)
            If img.HasFile AndAlso Not img.PostedFile Is Nothing Then
                Dim file As HttpPostedFile = OArtwork.PostedFile
                imgByte = New Byte(file.ContentLength - 1) {}
                file.InputStream.Read(imgByte, 0, file.ContentLength)
                oSQLParam = objDB.ExecSPReturnParam("PRODUCTMITRAADD",
                                                            objDB.MP("@PRODUCTMITRACODE", Data.SqlDbType.VarChar, otxtProductMitraCode.Text),
                                                            objDB.MP("@MITRAID", Data.SqlDbType.Int, oLabel21.Text),
                                                            objDB.MP("@SERVICETYPEID", Data.SqlDbType.Int, ohidService.Value),
                                                            objDB.MP("@SERVICETYPEDTLID", Data.SqlDbType.Int, ohidServDtl.Value),
                                                            objDB.MP("@ARMADATYPEID", Data.SqlDbType.Int, ohidArmadaType.Value),
                                                            objDB.MP("@PRODUCTBRAND", Data.SqlDbType.VarChar, otxtBrand.Text),
                                                            objDB.MP("@PRICE", Data.SqlDbType.Decimal, otxtPrice.Text),
                                                            objDB.MP("@UNITPRICE", Data.SqlDbType.Int, oddlUnitPrice.SelectedValue),
                                                            objDB.MPByte("@IMAGEPRODUCT", Data.SqlDbType.Image, imgByte),
                                                            objDB.MP("@QTY", Data.SqlDbType.Decimal, otxtQty.Text),
                                                            objDB.MP("@DESCRIPTION", Data.SqlDbType.VarChar, otxtDesc.Text),
                                                            objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, Data.ParameterDirection.Output))
                intRetVal = oSQLParam("@RETVAL").Value.ToString()
            End If
            If intRetVal = 0 Then
                lblError.Visible = True
                lblError.Text = "Product Code : " & otxtProductMitraCode.Text & " already exists..!"

            Else
                lblError.Visible = False
                fvData.Caption = ""
                lblError.Text = ""
                lblError.Visible = False
                gvData.DataBind()
                gvData.Visible = False
                fvData.Visible = False
                Dim message As String = "Data Successfully Saved"
                Dim sb As New System.Text.StringBuilder()
                sb.Append("<script type = 'text/javascript'>")
                sb.Append("window.onload=function(){")
                sb.Append("alert('")
                sb.Append(message)
                sb.Append("')};")
                sb.Append("</script>")
                ClientScript.RegisterClientScriptBlock(Me.GetType(), "alert", sb.ToString())
            End If
        Catch ex As Exception

            lblError.Visible = True
            lblError.Text = "ERROR SAVE DATA : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing

        End Try
        fvData.Visible = True
        fvData.DataBind()
        gvData.DataBind()
        gvData.Visible = True
        DataSearch()
        imgProduct.Visible = False
        pnlImg.Visible = False
    End Sub
End Class

