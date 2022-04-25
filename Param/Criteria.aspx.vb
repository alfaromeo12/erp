
Partial Class Param_Reason


    Inherits System.Web.UI.Page
    Public Shared ostrMINCONTRACTENDTextBox As String
    Public Shared oStrreqContractEnd As String = ""
    Public Shared oStrddlEmpSts As String = ""
    Dim dblCRID As String
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ''SetObjectValidation(txtSearch, True)
        End If
        DataSearch()
    End Sub


    Protected Sub gvData_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        'lblError.Text = ""
        lblError.Visible = False
        If e.CommandName = "Select" Then
            fvData.ChangeMode(FormViewMode.Edit)
            fvData.Caption = "Edit Data"
        End If
    End Sub

    Protected Sub imgBtnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        fvData.ChangeMode(FormViewMode.Insert)
        fvData.Caption = "New Data"
    End Sub

    Protected Sub fvData_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvData.ItemCreated
        SetValidation()
    End Sub

    Private Sub SetValidation()
        Dim oTextBox As TextBox
        Dim oRequired As RequiredFieldValidator
        Dim oDropDownList As DropDownList

        oTextBox = CType(fvData.FindControl("CRCODETextBox"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase nospace")
            oTextBox.Focus()
        End If
        oTextBox = CType(fvData.FindControl("CRNAMETextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")

        oTextBox = CType(fvData.FindControl("MINAGETextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")

        oTextBox = CType(fvData.FindControl("MINAGETextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")

        oTextBox = CType(fvData.FindControl("MINWORKTextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
        oTextBox = CType(fvData.FindControl("MAXWORKTextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
        oTextBox = CType(fvData.FindControl("MINWORKTextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
        oTextBox = CType(fvData.FindControl("MINMARRIEDAGETextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
        oTextBox = CType(fvData.FindControl("MINMARRIEDAGETextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
        oTextBox = CType(fvData.FindControl("MINMARRIEDAGETextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
        oTextBox = CType(fvData.FindControl("DSRTextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
        oTextBox = CType(fvData.FindControl("txtStayLength"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
        oTextBox = CType(fvData.FindControl("MININCOMETextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
        oTextBox = CType(fvData.FindControl("txtMaxLoan"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
        oTextBox = CType(fvData.FindControl("txtMinInstDev"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
        oTextBox = CType(fvData.FindControl("txtMaxInstDev"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
        'UMUR, WORKING MAX YEAR, EMPLOYEE MAX YEAR, CONTRACT END

        oTextBox = CType(fvData.FindControl("MINAGETextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.]")
        oTextBox = CType(fvData.FindControl("MAXAGETextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.]")

        oTextBox = CType(fvData.FindControl("MINWORKTextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.]")

        oTextBox = CType(fvData.FindControl("MAXAGETextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.]")

        oTextBox = CType(fvData.FindControl("MINCONTRACTENDTextBox"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.]")

        oTextBox = CType(fvData.FindControl("MINCONTRACTENDTextBox"), TextBox)
        If oTextBox IsNot Nothing Then ostrMINCONTRACTENDTextBox = oTextBox.ClientID

        oRequired = CType(fvData.FindControl("reqContractEnd"), RequiredFieldValidator)
        If oRequired IsNot Nothing Then oStrreqContractEnd = oRequired.ClientID

        oDropDownList = CType(fvData.FindControl("ddlEmpSts"), DropDownList)
        If oDropDownList IsNot Nothing Then
            oStrddlEmpSts = oDropDownList.ClientID
            oDropDownList.Attributes.Add("onchange", "checkFlagEmpStatus()")
        End If
    End Sub

    Private Sub DataSearch()
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        If Len(Trim(ddlDPSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND VALIDCRITERIA.DPID=" & ddlDPSearch.SelectedValue
        End If
        If Len(Trim(ddlInterestSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND VALIDCRITERIA.INTERESTID=" & ddlInterestSearch.SelectedValue
        End If
        If Len(Trim(ddlTenorSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND VALIDCRITERIA.TENORID=" & ddlTenorSearch.SelectedValue
        End If
        gvData.DataBind()
    End Sub


    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        'DataSearch()
        'lblError.Text = ""
        lblError.Visible = False
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
            lblError.Text = "Criteria Code : " & e.Command.Parameters("@CRCODE").Value & " already exists..!"
        Else
            lblError.Visible = False
            fvData.Caption = ""
        End If
        dblCRID = e.Command.Parameters("@CRID").Value.ToString()
        SaveData(dblCRID)
        SetHOmeStatus()
        DataSearch()
    End Sub

    Protected Sub sdsForm_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Criteria Code : " & e.Command.Parameters("@CRCODE").Value & " already exists..!"
        End If

        dblCRID = gvData.SelectedDataKey.Value.ToString()
        SaveData(dblCRID)
        SetHOmeStatus()
        DataSearch()
    End Sub

    Protected Sub sdsForm_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Deleted
        fvData.Caption = ""
        DataSearch()
    End Sub

    Protected Sub gvData_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvData.SelectedIndexChanged

        If Not String.IsNullOrEmpty(gvData.SelectedDataKey.Value.ToString()) Then
            dblCRID = gvData.SelectedDataKey.Value.ToString()
        End If

    End Sub

    Protected Sub fvData_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvData.DataBound
        If Not String.IsNullOrEmpty(dblCRID) Then
            SetHOmeStatus()
        End If
    End Sub

    Private Sub SaveData(ByVal dblCRID As String)
        Dim objDB As New DBX
        Try
            Dim cboxlist As CheckBoxList = fvData.FindControl("ckListHomeSts")
            If cboxlist IsNot Nothing Then
                Dim item As ListItem
                For Each item In cboxlist.Items
                    If (item.Selected) Then
                        'Response.Write(item.Value & "<br>")
                        objDB.ExecSP("VALIDHOMESTSSave", _
                                objDB.MP("@CRID", Data.SqlDbType.Int, dblCRID, 10), _
                                objDB.MP("@HOMESTATUS", Data.SqlDbType.Int, item.Value, 10), _
                                objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 10) _
                                )
                    Else
                        objDB.ExecSP("VALIDHOMESTSDelete", _
                                objDB.MP("@CRID", Data.SqlDbType.Int, dblCRID, 10), _
                                objDB.MP("@HOMESTATUS", Data.SqlDbType.Int, item.Value, 10), _
                                objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 10) _
                                )
                    End If
                Next
            End If
            'Catch ex As Exception
        Finally
            objDB.Close()
            objDB = Nothing

        End Try

    End Sub



    Private Sub SetHOmeStatus()
        Dim objDB As New DBX
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            Dim cboxlist As CheckBoxList = fvData.FindControl("ckListHomeSts")
            If cboxlist IsNot Nothing Then
                Dim item As ListItem
                For Each item In cboxlist.Items

                    oSDR = objDB.CreateSDRFromSQLSelect("SELECT CRID FROM VALIDHOMESTS WHERE CRID=" & dblCRID & " AND DELETESTS=0 AND HOMESTATUS=" & item.Value)
                    If oSDR.Read() Then
                        item.Selected = True
                    Else
                        item.Selected = False
                    End If
                    oSDR.Close()
                    oSDR = Nothing

                Next
            End If
            'Catch ex As Exception
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub

End Class
