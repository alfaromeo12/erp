
Partial Class Param_RouteApp
    Inherits System.Web.UI.Page
    Public strRouteId As Int64

    'Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
    '    DataSearch()
    'End Sub

    'Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    '    If Not IsPostBack Then
    '        ''SetObjectValidation(txtSearch, True)
    '    End If
    'End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub gvData_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        lblError.Visible = False
        If e.CommandName = "Select" Then
            fvData.ChangeMode(FormViewMode.Edit)
            fvData.Caption = "Edit Data"
        End If
    End Sub

    'Protected Sub imgBtnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
    '    lblError.Visible = False
    '    fvData.ChangeMode(FormViewMode.Insert)
    '    fvData.Caption = "New Data"
    '    gvData.SelectedIndex = -1
    'End Sub

    Protected Sub fvData_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvData.ItemCreated
        SetValidation()
    End Sub

    Private Sub SetValidation()
        'Dim oTextBox As TextBox
        'oTextBox = CType(fvData.FindControl("txtBranchCode"), TextBox)
        'If oTextBox IsNot Nothing Then
        '    SetObjectValidation(oTextBox, False, "uppercase nospace")
        '    oTextBox.Focus()
        'End If

        'oTextBox = CType(fvData.FindControl("txtUnitRLZ"), TextBox)
        'If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "int", "[0-9]")

        'oTextBox = CType(fvData.FindControl("txtRoutePrice"), TextBox)
        'If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")

        'oTextBox = CType(fvData.FindControl("txtSetoran"), TextBox)
        'If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.,]")

        'oTextBox = CType(fvData.FindControl("txtUnitALC"), TextBox)
        'If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "int", "[0-9]")

        'oTextBox = CType(fvData.FindControl("txtWorkDay"), TextBox)
        'If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "int", "[0-9]")

    End Sub

    Private Sub DataSearch()
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If

        gvData.DataBind()
    End Sub

    Protected Sub fvData_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewDeletedEventArgs) Handles fvData.ItemDeleted
        DataSearch()
    End Sub

    Protected Sub fvData_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles fvData.ItemInserted
        DataSearch()
    End Sub

    Protected Sub fvData_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewUpdatedEventArgs) Handles fvData.ItemUpdated
        DataSearch()
    End Sub

    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
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
                intRetVal = objDB.ExecSPReturnInteger("ROUTEAPPROVAL", _
                    objDB.MP("@ROUTEID", Data.SqlDbType.Int, fvData.DataKey.Item(0)), _
                    objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value), _
                    objDB.MP("@STATUS", Data.SqlDbType.Int, intStatus) _
                    )
                If intRetVal = -1 Then
                    lblError.Visible = True
                    lblError.Text = "DATA ALREADY APPROVE/REJECT...!<BR>PLEASE REFRESH DATA...!"
                ElseIf intRetVal = 0 Then
                    fvData.Caption = ""
                End If
                gvData.DataBind()
            Catch ex As Exception
                lblError.Visible = True
                lblError.Text = "DEALER Reject/Approval Error: " & ex.Message & "<br>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        End If
    End Sub

    Protected Sub sdsForm_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Inserted
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Route No : " & e.Command.Parameters("@RouteNo").Value & " already exists..!"
        Else
            strRouteId = e.Command.Parameters("@ROUTEID").Value
            lblError.Visible = False
            fvData.Caption = ""
            DataSearch()
        End If
    End Sub


    Protected Sub sdsForm_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Route No : " & e.Command.Parameters("@RouteNo").Value & " already exists..!"
        Else
            lblError.Visible = False
            DataSearch()
        End If
    End Sub

    Protected Sub gvData_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvData.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsBranchProduct"), SqlDataSource)
            If s IsNot Nothing Then
                s.SelectParameters(0).DefaultValue = gvData.DataKeys(e.Row.RowIndex).Value()
            End If
            'If DataBinder.Eval(e.Row.DataItem, "NEW") Then
            '    e.Row.ForeColor = Drawing.Color.White
            '    e.Row.BackColor = Drawing.Color.Black
            '    e.Row.Font.Bold = True
            '    e.Row.Font.Italic = True
            'ElseIf DataBinder.Eval(e.Row.DataItem, "UPD") Then
            '    e.Row.ForeColor = Drawing.Color.Yellow
            '    e.Row.BackColor = Drawing.Color.Gray
            '    e.Row.Font.Bold = True
            '    e.Row.Font.Italic = True
            'End If
        End If

    End Sub

    Protected Sub sdsForm_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Deleted
        fvData.Caption = ""
    End Sub

    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    'Public Sub Getdata()
    '    Dim objDB As New DBX
    'End Sub

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub
End Class
