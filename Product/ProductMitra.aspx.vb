Imports System.IO
Imports System.Data.SqlClient
Imports System.Data
Imports System.Drawing
Partial Class Product_ProductMitra
    Inherits System.Web.UI.Page
    Public Shared iError As Integer = 0
    Private iPrdId As Integer
    Public strUserID As String
    Public strMitra As String
    Public strFullName As String
    Public strAddress As String
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
        Dim ohidMitra As HiddenField
        Dim oTextBox As TextBox
        oTextBox = CType(fvData.FindControl("txtProductMitraCode"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase nospace")
            oTextBox.Focus()
        End If
        oTextBox = CType(fvData.FindControl("txtMitra"), TextBox)
        If oTextBox IsNot Nothing Then
            strFullName = oTextBox.ClientID
        End If
        oTextBox = CType(fvData.FindControl("txtAddress"), TextBox)
        If oTextBox IsNot Nothing Then
            strAddress = oTextBox.ClientID
        End If
        ohidMitra = CType(fvData.FindControl("hidMitra"), HiddenField)
        If ohidMitra IsNot Nothing Then
            strUserID = ohidMitra.ClientID
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
        Dim olblProductMitraID As Label = CType(fvData.FindControl("lblProductMitraID"), Label)
        Dim otxtProductMitraCode As TextBox = CType(fvData.FindControl("txtProductMitraCode"), TextBox)
        Dim oddlService As DropDownList = CType(fvData.FindControl("ddlService"), DropDownList)
        Dim oddlServDtl As DropDownList = CType(fvData.FindControl("ddlServDtl"), DropDownList)
        Dim oddlArmadaType As DropDownList = CType(fvData.FindControl("ddlArmadaType"), DropDownList)
        Dim otxtBrand As TextBox = CType(fvData.FindControl("txtBrand"), TextBox)
        Dim otxtMinCap As TextBox = CType(fvData.FindControl("txtMinCap"), TextBox)
        Dim oddlMinCap As DropDownList = CType(fvData.FindControl("ddlMinCap"), DropDownList)
        Dim otxtMaxCap As TextBox = CType(fvData.FindControl("txtMaxCap"), TextBox)
        Dim oddlUnit As DropDownList = CType(fvData.FindControl("ddlUnit"), DropDownList)
        Dim strFilePathSignImage As String = OArtwork.PostedFile.FileName
        Dim strfileNameSignImage As String = Path.GetFileName(strFilePathSignImage)
        Dim strExtSignImage As String = Path.GetExtension(strFilePathSignImage)
        Dim ohidMitra As HiddenField
        ohidMitra = CType(fvData.FindControl("hidMitra"), HiddenField)
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
                            objDB.MP("@MITRAID", Data.SqlDbType.Int, ohidMitra.Value),
                            objDB.MP("@SERVICETYPEID", Data.SqlDbType.Int, oddlService.SelectedValue),
                            objDB.MP("@SERVICETYPEDTLID", Data.SqlDbType.Int, oddlServDtl.SelectedValue),
                            objDB.MP("@ARMADATYPEID", Data.SqlDbType.Int, oddlArmadaType.SelectedValue),
                            objDB.MP("@PRODUCTBRAND", Data.SqlDbType.VarChar, otxtBrand.Text),
                            objDB.MP("@MINCAPACITY", Data.SqlDbType.VarChar, otxtMinCap.Text),
                            objDB.MP("@UNITMAXCAPACITY", Data.SqlDbType.Int, oddlMinCap.Text),
                            objDB.MP("@MAXCAPACITY", Data.SqlDbType.VarChar, otxtMaxCap.Text),
                            objDB.MP("@UNITMINCAPACITY", Data.SqlDbType.Int, oddlUnit.Text),
                            objDB.MPByte("@IMAGEPRODUCT", Data.SqlDbType.Image, imgByte),
                            objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value),
                            objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, Data.ParameterDirection.Output))
                intRetVal = oSQLParam("@RETVAL").Value.ToString()
            Else
                oSQLParam = objDB.ExecSPReturnParam("PRODUCTMITRAUPDATEX",
                            objDB.MP("@PRODUCTMITRAID", Data.SqlDbType.Int, olblProductMitraID.Text),
                            objDB.MP("@PRODUCTMITRACODE", Data.SqlDbType.VarChar, otxtProductMitraCode.Text),
                            objDB.MP("@MITRAID", Data.SqlDbType.Int, ohidMitra.Value),
                            objDB.MP("@SERVICETYPEID", Data.SqlDbType.Int, oddlService.SelectedValue),
                            objDB.MP("@SERVICETYPEDTLID", Data.SqlDbType.Int, oddlServDtl.SelectedValue),
                            objDB.MP("@ARMADATYPEID", Data.SqlDbType.Int, oddlArmadaType.SelectedValue),
                            objDB.MP("@PRODUCTBRAND", Data.SqlDbType.VarChar, otxtBrand.Text),
                            objDB.MP("@MINCAPACITY", Data.SqlDbType.VarChar, otxtMinCap.Text),
                            objDB.MP("@UNITMINCAPACITY", Data.SqlDbType.Int, oddlMinCap.Text),
                            objDB.MP("@MAXCAPACITY", Data.SqlDbType.VarChar, otxtMaxCap.Text),
                            objDB.MP("@UNITMAXCAPACITY", Data.SqlDbType.Int, oddlUnit.Text),
                            objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value),
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
        Dim otxtProductMitraCode As TextBox = CType(fvData.FindControl("txtProductMitraCode"), TextBox)
        Dim oddlArmadaType As DropDownList = CType(fvData.FindControl("ddlArmadaType"), DropDownList)
        Dim oddlServDtl As DropDownList = CType(fvData.FindControl("ddlServDtl"), DropDownList)
        Dim oddlService As DropDownList = CType(fvData.FindControl("ddlService"), DropDownList)
        Dim otxtBrand As TextBox = CType(fvData.FindControl("txtBrand"), TextBox)
        Dim otxtMinCap As TextBox = CType(fvData.FindControl("txtMinCap"), TextBox)
        Dim oddlMinCap As DropDownList = CType(fvData.FindControl("ddlMinCap"), DropDownList)
        Dim otxtMaxCap As TextBox = CType(fvData.FindControl("txtMaxCap"), TextBox)
        Dim oddlUnit As DropDownList = CType(fvData.FindControl("ddlUnit"), DropDownList)
        Dim strFilePathSignImage As String = OArtwork.PostedFile.FileName
        Dim strfileNameSignImage As String = Path.GetFileName(strFilePathSignImage)
        Dim strExtSignImage As String = Path.GetExtension(strFilePathSignImage)
        Dim ohidMitra As HiddenField
        ohidMitra = CType(fvData.FindControl("hidMitra"), HiddenField)
        Try
            Dim imgByte As Byte() = Nothing
            Dim img As FileUpload = CType(OArtwork, FileUpload)
            If img.HasFile AndAlso Not img.PostedFile Is Nothing Then
                Dim file As HttpPostedFile = OArtwork.PostedFile
                imgByte = New Byte(file.ContentLength - 1) {}
                file.InputStream.Read(imgByte, 0, file.ContentLength)
                oSQLParam = objDB.ExecSPReturnParam("PRODUCTMITRAADD",
                            objDB.MP("@PRODUCTMITRACODE", Data.SqlDbType.VarChar, otxtProductMitraCode.Text),
                            objDB.MP("@MITRAID", Data.SqlDbType.Int, ohidMitra.Value),
                            objDB.MP("@SERVICETYPEID", Data.SqlDbType.Int, oddlService.SelectedValue),
                            objDB.MP("@SERVICETYPEDTLID", Data.SqlDbType.Int, oddlServDtl.SelectedValue),
                            objDB.MP("@ARMADATYPEID", Data.SqlDbType.VarChar, oddlArmadaType.SelectedValue),
                            objDB.MP("@PRODUCTBRAND", Data.SqlDbType.VarChar, otxtBrand.Text),
                            objDB.MP("@MINCAPACITY", Data.SqlDbType.VarChar, otxtMinCap.Text),
                            objDB.MP("@UNITMINCAPACITY", Data.SqlDbType.Int, oddlMinCap.Text),
                            objDB.MP("@MAXCAPACITY", Data.SqlDbType.VarChar, otxtMaxCap.Text),
                            objDB.MP("@UNITMAXCAPACITY", Data.SqlDbType.Int, oddlUnit.Text),
                            objDB.MPByte("@IMAGEPRODUCT", Data.SqlDbType.Image, imgByte),
                            objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value),
                            objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, Data.ParameterDirection.Output))
                intRetVal = oSQLParam("@RETVAL").Value.ToString()
            End If
        Catch ex As Exception
            If intRetVal = -1 Then
                lblError.Visible = True
                'lblError.Text = "ERROR UPDATE DATA MITRA <BR> PLEASE CHECK DETAIL ERROR MESSAGE...!"
                iError = 1
            Else
                lblError.Text = ""
                lblError.Visible = True
                'lblError.Text = "ERROR SAVE DATA : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
                iError = 0
                gvData.DataBind()
            End If
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

