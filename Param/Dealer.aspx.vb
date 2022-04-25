
Partial Class Param_Dealer
    Inherits System.Web.UI.Page
    Public strBranchId As String

    'Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
    '    DataSearch()
    'End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ''SetObjectValidation(txtSearch, True)
            DataSearch()
        End If
    End Sub

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

    Protected Sub imgBtnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click

        lblError.Visible = False
        fvData.ChangeMode(FormViewMode.Insert)
        fvData.Caption = "New Data"
        gvData.SelectedIndex = -1
    End Sub



    Protected Sub fvData_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvData.ItemCreated
        SetValidation()
    End Sub

    Private Sub SetValidation()
        Dim oTextBox As TextBox
        oTextBox = CType(fvData.FindControl("txtDealerCode"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase")
            oTextBox.Focus()
        End If
        oTextBox = CType(fvData.FindControl("txtDealerName"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")
        oTextBox = CType(fvData.FindControl("txtDealerAlias"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")
        oTextBox = CType(fvData.FindControl("txtAddress"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")
        oTextBox = CType(fvData.FindControl("txtHeadDealer"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")
        oTextBox = CType(fvData.FindControl("txtProvince"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")

        oTextBox = CType(fvData.FindControl("txtPhoneArea1"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "int", "[0-9]")
        oTextBox = CType(fvData.FindControl("txtPhoneArea2"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "int", "[0-9]")
        oTextBox = CType(fvData.FindControl("txtPhoneArea3"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "int", "[0-9]")

        oTextBox = CType(fvData.FindControl("txtPhone1"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "int", "[0-9]")
        oTextBox = CType(fvData.FindControl("txtPhone2"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "int", "[0-9]")
        oTextBox = CType(fvData.FindControl("txtPhone3"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "int", "[0-9]")

        oTextBox = CType(fvData.FindControl("txtDateStart"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "date", "[0-9/]")

        oTextBox = CType(fvData.FindControl("txtDaysToDisb"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "int", "[0-9]")
    End Sub

    Private Sub DataSearch()
        If Not IsPostBack() Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND DEALER.DEALERID=-999"
        End If
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        If Len(Trim(ddlBranchSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCHID=" & ddlBranchSearch.SelectedValue
        End If
        If Len(Trim(ddlMainDealerSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND DEALERMAINID=" & ddlMainDealerSearch.SelectedValue
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
        End If
    End Sub

    Protected Sub sdsForm_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Inserted
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Dealer Code : " & e.Command.Parameters("@DEALERCODE").Value & " already exists..!"
        Else
            strBranchId = e.Command.Parameters("@DEALERID").Value
            lblError.Visible = False
            fvData.Caption = ""
            DataSearch()
        End If
    End Sub


    Protected Sub sdsForm_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Dealer Code : " & e.Command.Parameters("@DEALERCODE").Value & " already exists..!"
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
            If DataBinder.Eval(e.Row.DataItem, "NEW") Then
                e.Row.ForeColor = Drawing.Color.White
                e.Row.BackColor = Drawing.Color.Black
                e.Row.Font.Bold = True
                e.Row.Font.Italic = True
            ElseIf DataBinder.Eval(e.Row.DataItem, "UPD") Then
                e.Row.ForeColor = Drawing.Color.Yellow
                e.Row.BackColor = Drawing.Color.Gray
                e.Row.Font.Bold = True
                e.Row.Font.Italic = True
            End If
        End If

    End Sub

    Protected Sub sdsForm_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Deleted
        fvData.Caption = ""
    End Sub

    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub ddlBranchSearch_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlBranchSearch.SelectedIndexChanged
        DataSearch()
    End Sub

    Protected Sub ddlMainDealerSearch_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlMainDealerSearch.SelectedIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub
End Class
