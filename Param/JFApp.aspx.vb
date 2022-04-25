
Partial Class Param_JFApp

    Inherits System.Web.UI.Page
    Public strDDLCriteria As String

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
            fvData.ChangeMode(FormViewMode.ReadOnly)
            fvData.Caption = "Approval Data"
        End If
    End Sub


    Protected Sub fvData_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvData.ItemCreated
        Dim oDropDow As DropDownList
        oDropDow = CType(fvData.FindControl("ddlValidCriteria"), DropDownList)
        If oDropDow IsNot Nothing Then strDDLCriteria = oDropDow.ClientID

        'SetValidation()
    End Sub

    'Private Sub SetValidation()
    '    Dim oTextBox As TextBox
    '    oTextBox = CType(fvData.FindControl("JFCODETextBox"), TextBox)
    '    If oTextBox IsNot Nothing Then
    '        SetObjectValidation(oTextBox, False, "uppercase nospace")
    '        oTextBox.Focus()
    '    End If
    '    oTextBox = CType(fvData.FindControl("JFNAMETextBox"), TextBox)
    '    If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")

    '    oTextBox = CType(fvData.FindControl("JFADDRESSTextBox"), TextBox)
    '    If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")
    '    oTextBox = CType(fvData.FindControl("JFCITYTextBox"), TextBox)
    '    If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")

    '    oTextBox = CType(fvData.FindControl("JFZIPTextBox"), TextBox)
    '    If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "", "[0-9]")
    '    oTextBox = CType(fvData.FindControl("JFPKSDATETextBox"), TextBox)
    '    If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "date", "[0-9/]")

    '    oTextBox = CType(fvData.FindControl("JFNOTARYTextBox"), TextBox)
    '    If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")

    '    oTextBox = CType(fvData.FindControl("JFPORTIONTextBox"), TextBox)
    '    If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
    '    oTextBox = CType(fvData.FindControl("JFEFFRATEDEFAULTTextBox"), TextBox)
    '    If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
    '    oTextBox = CType(fvData.FindControl("JFPENALTYSHAREDTextBox"), TextBox)
    '    If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
    '    oTextBox = CType(fvData.FindControl("JFPENALTYRATETextBox"), TextBox)
    '    If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
    '    oTextBox = CType(fvData.FindControl("JFGRACEPERIODTextBox"), TextBox)
    '    If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "integer", "[0-9]")
    '    oTextBox = CType(fvData.FindControl("JFWORKINGDAYSTextBox"), TextBox)
    '    If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "integer", "[0-9]")

    '    oTextBox = CType(fvData.FindControl("JFETPENALTYTextBox"), TextBox)
    '    If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
    '    oTextBox = CType(fvData.FindControl("JFADMTERMINATETextBox"), TextBox)
    '    If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
    '    oTextBox = CType(fvData.FindControl("JFADMINTextBox"), TextBox)
    '    If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
    '    oTextBox = CType(fvData.FindControl("JFPROVISIONTextBox"), TextBox)
    '    If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
    '    oTextBox = CType(fvData.FindControl("txtCommitmentFee"), TextBox)
    '    If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
    '    oTextBox = CType(fvData.FindControl("txtPlafond"), TextBox)
    '    If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")

    'End Sub

    Private Sub DataSearch()
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        If Len(Trim(ddlMirrorStatusSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND JFMIRRORSTATUS=" & ddlMirrorStatusSearch.SelectedValue
        End If
        If Len(Trim(ddlJFGroupSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND JFX.JFGROUPID=" & ddlJFGroupSearch.SelectedValue
        End If
        If Len(Trim(ddlRevolvingSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND JFX.JFREVOLVING=" & ddlRevolvingSearch.SelectedValue
        End If
        If Len(Trim(ddlValidCriteriaSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND JFX.CRID=" & ddlValidCriteriaSearch.SelectedValue
        End If

        If Len(Trim(ddlDocReceived.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND JFX.JFDOCRECEIVED=" & ddlDocReceived.SelectedValue
        End If

        If Len(Trim(ddlBankSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND JFX.BANKID=" & ddlBankSearch.SelectedValue
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
        ElseIf e.CommandName = "Approve" Or e.CommandName = "Reject" Then
            Dim intStatus As Integer = 0
            If e.CommandName = "Approve" Then
                intStatus = 1
            End If
            Dim objDB As New DBX
            Try
                Dim intRetVal As Integer
                intRetVal = objDB.ExecSPReturnInteger("JFAPPROVAL", _
                    objDB.MP("@JFID", Data.SqlDbType.Int, fvData.DataKey.Item(0)), _
                    objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value), _
                    objDB.MP("@STATUS", Data.SqlDbType.Int, intStatus) _
                    )
                If intRetVal = -1 Then
                    lblError.Visible = True
                    lblError.Text = "DATA ALREADY APPROVE/REJECT...!<BR>PLEASE REFRESH DATA...!"
                Else

                End If
                gvData.DataBind()
            Catch ex As Exception
                lblError.Visible = True
                lblError.Text = "JF Reject/Approval Error: " & ex.Message & "<br>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        End If
    End Sub

    Protected Sub ddlHardCodeSearch_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlMirrorStatusSearch.SelectedIndexChanged
        DataSearch()
    End Sub



End Class
