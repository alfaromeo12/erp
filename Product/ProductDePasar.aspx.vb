Imports System.IO
Imports System.Data.SqlClient
Imports System.Data
Imports System.Drawing
Partial Class Product_Product
    Inherits System.Web.UI.Page
    Public strServiceTypeId As String
    Public strServiceType As String
    Public strServiceTypeDtlId As String
    Public strServiceTypeDtl As String
    Public strUserID As String
    Public strMitra As String
    Public strProvID As String
    Public strProvince As String
    Public Shared iError As Integer = 0
    Private iPrdId As Integer
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
            imgProduct.ImageUrl = "~/Product/DisplayImagesProduct.ashx?PRODUCTID=" & iPrdId
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
        Dim ohidMitra As HiddenField
        Dim ohidProv As HiddenField
        Dim oTextBox As TextBox
        oTextBox = CType(fvData.FindControl("txtProductCode"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase nospace")
            oTextBox.Focus()
        End If
        oTextBox = CType(fvData.FindControl("txtMitra"), TextBox)
        If oTextBox IsNot Nothing Then
            strMitra = oTextBox.ClientID
        End If
        oTextBox = CType(fvData.FindControl("txtServiceType"), TextBox)
        If oTextBox IsNot Nothing Then
            strServiceType = oTextBox.ClientID
        End If
        oTextBox = CType(fvData.FindControl("txtServDtl"), TextBox)
        If oTextBox IsNot Nothing Then
            strServiceTypeDtl = oTextBox.ClientID
        End If
        oTextBox = CType(fvData.FindControl("txtProv"), TextBox)
        If oTextBox IsNot Nothing Then
            strProvince = oTextBox.ClientID
        End If
        ohidService = CType(fvData.FindControl("hidService"), HiddenField)
        If ohidService IsNot Nothing Then
            strServiceTypeId = ohidService.ClientID
        End If
        ohidServDtl = CType(fvData.FindControl("hidServDtl"), HiddenField)
        If ohidServDtl IsNot Nothing Then
            strServiceTypeDtlId = ohidServDtl.ClientID
        End If
        ohidMitra = CType(fvData.FindControl("hidMitra"), HiddenField)
        If ohidMitra IsNot Nothing Then
            strUserID = ohidMitra.ClientID
        End If
        ohidProv = CType(fvData.FindControl("hidProv"), HiddenField)
        If ohidProv IsNot Nothing Then
            strProvID = ohidProv.ClientID
        End If
    End Sub
    Private Sub DataSearch()
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        pnlImg.Visible = False
        gvData.DataBind()
    End Sub
    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        lblError.Visible = False
    End Sub
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
        Dim olblProductID As Label = CType(fvData.FindControl("lblProductID"), Label)
        Dim otxtProductCode As TextBox = CType(fvData.FindControl("txtProductCode"), TextBox)
        Dim otxtProductName As TextBox = CType(fvData.FindControl("txtProductName"), TextBox)
        Dim otxtPrice As TextBox = CType(fvData.FindControl("txtPrice"), TextBox)
        Dim otxtDiscount As TextBox = CType(fvData.FindControl("txtDiscount"), TextBox)
        Dim otxtStore As TextBox = CType(fvData.FindControl("txtStore"), TextBox)
        Dim otxtDiscPrice As TextBox = CType(fvData.FindControl("txtDiscPrice"), TextBox)
        Dim otxtImageUrl As TextBox = CType(fvData.FindControl("txtImageUrl"), TextBox)
        Dim otxtAddress As TextBox = CType(fvData.FindControl("txtAddress"), TextBox)
        Dim otxtMinCap As TextBox = CType(fvData.FindControl("txtMinCap"), TextBox)
        Dim otxtInitial As TextBox = CType(fvData.FindControl("txtInitial"), TextBox)
        Dim otxtDes As TextBox = CType(fvData.FindControl("txtDes"), TextBox)
        Dim oddlEntity As DropDownList = CType(fvData.FindControl("ddlEntity"), DropDownList)
        Dim oddlMinCap As DropDownList = CType(fvData.FindControl("ddlMinCap"), DropDownList)
        Dim oddlStock As DropDownList = CType(fvData.FindControl("ddlStock"), DropDownList)
        Dim strFilePathSignImage As String = OArtwork.PostedFile.FileName
        Dim strfileNameSignImage As String = Path.GetFileName(strFilePathSignImage)
        Dim strExtSignImage As String = Path.GetExtension(strFilePathSignImage)
        Dim ohidMitra As HiddenField
        ohidMitra = CType(fvData.FindControl("hidMitra"), HiddenField)
        Dim ohidService As HiddenField
        ohidService = CType(fvData.FindControl("hidService"), HiddenField)
        Dim ohidServDtl As HiddenField
        ohidServDtl = CType(fvData.FindControl("hidServDtl"), HiddenField)
        Dim ohidProv As HiddenField
        ohidProv = CType(fvData.FindControl("hidProv"), HiddenField)
        Try
            Dim imgByte As Byte() = Nothing
            Dim img As FileUpload = CType(OArtwork, FileUpload)
            If img.HasFile AndAlso Not img.PostedFile Is Nothing Then
                Dim file As HttpPostedFile = OArtwork.PostedFile
                imgByte = New Byte(file.ContentLength - 1) {}
                file.InputStream.Read(imgByte, 0, file.ContentLength)
                oSQLParam = objDB.ExecSPReturnParam("MASTERPRODUCTUPDATEX",
                                                    objDB.MP("@PRODUCTID", Data.SqlDbType.Int, olblProductID.Text),
                                                    objDB.MP("@PRODUCTCODE", Data.SqlDbType.VarChar, otxtProductCode.Text),
                                                    objDB.MP("@PRODUCTNAME", Data.SqlDbType.VarChar, otxtProductName.Text),
                                                    objDB.MP("@ENTITYTYPEID", Data.SqlDbType.Int, oddlEntity.SelectedValue),
                                                    objDB.MP("@SERVICETYPEID", Data.SqlDbType.Int, ohidService.Value),
                                                    objDB.MP("@SERVICETYPEDTLID", Data.SqlDbType.Int, ohidServDtl.Value),
                                                    objDB.MP("@PRICE", Data.SqlDbType.Decimal, otxtPrice.Text),
                                                    objDB.MP("@DISCOUNT", Data.SqlDbType.Decimal, otxtDiscount.Text),
                                                    objDB.MP("@DISCOUNTPRICE", Data.SqlDbType.Decimal, otxtDiscPrice.Text),
                                                    objDB.MP("@CAPACITY", Data.SqlDbType.Text, otxtMinCap.Text),
                                                    objDB.MP("@UNITCAPACITY", Data.SqlDbType.Int, oddlMinCap.SelectedValue),
                                                    objDB.MP("@INITIALSTOCK", Data.SqlDbType.Text, otxtInitial.Text),
                                                    objDB.MP("@UNITSTOCK", Data.SqlDbType.Int, oddlStock.SelectedValue),
                                                    objDB.MPByte("@IMAGEDEPASAR", Data.SqlDbType.Image, imgByte),
                                                    objDB.MP("@IMAGEURL", Data.SqlDbType.VarChar, otxtImageUrl.Text),
                                                    objDB.MP("@DESCRIPTION", Data.SqlDbType.VarChar, otxtDes.Text),
                                                    objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, Data.ParameterDirection.Output))
                intRetVal = oSQLParam("@RETVAL").Value.ToString()
            Else
                oSQLParam = objDB.ExecSPReturnParam("MASTERPRODUCTUPDATE",
                                                   objDB.MP("@PRODUCTID", Data.SqlDbType.Int, olblProductID.Text),
                                                    objDB.MP("@PRODUCTCODE", Data.SqlDbType.VarChar, otxtProductCode.Text),
                                                    objDB.MP("@PRODUCTNAME", Data.SqlDbType.VarChar, otxtProductName.Text),
                                                    objDB.MP("@ENTITYTYPEID", Data.SqlDbType.Int, oddlEntity.SelectedValue),
                                                    objDB.MP("@SERVICETYPEID", Data.SqlDbType.Int, ohidService.Value),
                                                    objDB.MP("@SERVICETYPEDTLID", Data.SqlDbType.Int, ohidServDtl.Value),
                                                    objDB.MP("@PRICE", Data.SqlDbType.Decimal, otxtPrice.Text),
                                                    objDB.MP("@DISCOUNT", Data.SqlDbType.Decimal, otxtDiscount.Text),
                                                    objDB.MP("@DISCOUNTPRICE", Data.SqlDbType.Decimal, otxtDiscPrice.Text),
                                                    objDB.MP("@CAPACITY", Data.SqlDbType.Text, otxtMinCap.Text),
                                                    objDB.MP("@UNITCAPACITY", Data.SqlDbType.Int, oddlMinCap.SelectedValue),
                                                    objDB.MP("@INITIALSTOCK", Data.SqlDbType.Text, otxtInitial.Text),
                                                    objDB.MP("@UNITSTOCK", Data.SqlDbType.Int, oddlStock.SelectedValue),
                                                    objDB.MP("@IMAGEURL", Data.SqlDbType.VarChar, otxtImageUrl.Text),
                                                    objDB.MP("@DESCRIPTION", Data.SqlDbType.VarChar, otxtDes.Text),
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
        Dim otxtProductCode As TextBox = CType(fvData.FindControl("txtProductCode"), TextBox)
        Dim otxtProductName As TextBox = CType(fvData.FindControl("txtProductName"), TextBox)
        Dim otxtPrice As TextBox = CType(fvData.FindControl("txtPrice"), TextBox)
        Dim otxtDiscount As TextBox = CType(fvData.FindControl("txtDiscount"), TextBox)
        Dim otxtStore As TextBox = CType(fvData.FindControl("txtStore"), TextBox)
        Dim otxtDiscPrice As TextBox = CType(fvData.FindControl("txtDiscPrice"), TextBox)
        Dim otxtImageUrl As TextBox = CType(fvData.FindControl("txtImageUrl"), TextBox)
        Dim otxtAddress As TextBox = CType(fvData.FindControl("txtAddress"), TextBox)
        Dim otxtMinCap As TextBox = CType(fvData.FindControl("txtMinCap"), TextBox)
        Dim otxtInitial As TextBox = CType(fvData.FindControl("txtInitial"), TextBox)
        Dim otxtDes As TextBox = CType(fvData.FindControl("txtDes"), TextBox)
        Dim oddlEntity As DropDownList = CType(fvData.FindControl("ddlEntity"), DropDownList)
        Dim oddlMinCap As DropDownList = CType(fvData.FindControl("ddlMinCap"), DropDownList)
        Dim oddlStock As DropDownList = CType(fvData.FindControl("ddlStock"), DropDownList)
        Dim strFilePathSignImage As String = OArtwork.PostedFile.FileName
        Dim strfileNameSignImage As String = Path.GetFileName(strFilePathSignImage)
        Dim strExtSignImage As String = Path.GetExtension(strFilePathSignImage)
        Dim ohidMitra As HiddenField
        ohidMitra = CType(fvData.FindControl("hidMitra"), HiddenField)
        Dim ohidService As HiddenField
        ohidService = CType(fvData.FindControl("hidService"), HiddenField)
        Dim ohidServDtl As HiddenField
        ohidServDtl = CType(fvData.FindControl("hidServDtl"), HiddenField)
        Dim ohidProv As HiddenField
        ohidProv = CType(fvData.FindControl("hidProv"), HiddenField)
        Try
            Dim imgByte As Byte() = Nothing
            Dim img As FileUpload = CType(OArtwork, FileUpload)
            If img.HasFile AndAlso Not img.PostedFile Is Nothing Then
                Dim file As HttpPostedFile = OArtwork.PostedFile
                imgByte = New Byte(file.ContentLength - 1) {}
                file.InputStream.Read(imgByte, 0, file.ContentLength)
                oSQLParam = objDB.ExecSPReturnParam("MASTERPRODUCTADD",
                                                    objDB.MP("@PRODUCTCODE", Data.SqlDbType.VarChar, otxtProductCode.Text),
                                                    objDB.MP("@PRODUCTNAME", Data.SqlDbType.VarChar, otxtProductName.Text),
                                                    objDB.MP("@ENTITYTYPEID", Data.SqlDbType.Int, oddlEntity.SelectedValue),
                                                    objDB.MP("@SERVICETYPEID", Data.SqlDbType.Int, ohidService.Value),
                                                    objDB.MP("@SERVICETYPEDTLID", Data.SqlDbType.Int, ohidServDtl.Value),
                                                    objDB.MP("@PRICE", Data.SqlDbType.Decimal, otxtPrice.Text),
                                                    objDB.MP("@DISCOUNT", Data.SqlDbType.Decimal, otxtDiscount.Text),
                                                    objDB.MP("@DISCOUNTPRICE", Data.SqlDbType.Decimal, otxtDiscPrice.Text),
                                                    objDB.MP("@CAPACITY", Data.SqlDbType.Text, otxtMinCap.Text),
                                                    objDB.MP("@UNITCAPACITY", Data.SqlDbType.Int, oddlMinCap.SelectedValue),
                                                    objDB.MP("@INITIALSTOCK", Data.SqlDbType.Text, otxtInitial.Text),
                                                    objDB.MP("@UNITSTOCK", Data.SqlDbType.Int, oddlStock.SelectedValue),
                                                    objDB.MPByte("@IMAGEDEPASAR", Data.SqlDbType.Image, imgByte),
                                                    objDB.MP("@DESCRIPTION", Data.SqlDbType.VarChar, otxtDes.Text),
                                                    objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, Data.ParameterDirection.Output))
                intRetVal = oSQLParam("@RETVAL").Value.ToString()
            End If
            If intRetVal = 0 Then
                lblError.Visible = True
                lblError.Text = "Product Code : " & otxtProductCode.Text & " already exists..!"

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

