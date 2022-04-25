Imports AjaxControlToolkit.CascadingDropDown
Partial Class Param_InsBranchAccBank
    Inherits System.Web.UI.Page
    
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub gvData_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        lblError.Visible = False
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument).ToString
        If e.CommandName = "Select" Then
            fvBranchAccBank.ChangeMode(FormViewMode.Edit)
            fvBranchAccBank.Caption = "Edit Data"
            HdnBranchId.Value = gvData.Rows(currentRowIndex).Cells(3).Text
        End If
    End Sub

    Protected Sub imgBtnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        lblError.Visible = False
        fvBranchAccBank.ChangeMode(FormViewMode.Insert)
        fvBranchAccBank.Caption = "New Data"
        gvData.SelectedIndex = -1
    End Sub
   
    Private Sub DataSearch()
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If

        If Len(Trim(ddlInsBranchSrc.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BA.INSBRANCHID=" & ddlInsBranchSrc.SelectedValue
        End If

        If Len(Trim(ddlInsCompanySrc.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND CP.INSCOMPANYID=" & ddlInsCompanySrc.SelectedValue
        End If
        gvData.DataBind()
    End Sub

 

    Protected Sub fvBranchAccBank_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewDeletedEventArgs) Handles fvBranchAccBank.ItemDeleted
        DataSearch()
    End Sub

    Protected Sub fvBranchAccBank_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles fvBranchAccBank.ItemInserted
        DataSearch()
    End Sub

    Protected Sub fvBranchAccBank_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewUpdatedEventArgs) Handles fvBranchAccBank.ItemUpdated
        DataSearch()
    End Sub

    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
        lblError.Visible = False
    End Sub

    Protected Sub fvBranchAccBank_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvBranchAccBank.ItemCommand
        If e.CommandName = "Cancel" Then
            gvData.SelectedIndex = -1
            fvBranchAccBank.Caption = ""
        End If
    End Sub

    Protected Sub sdsBranchAccBank_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsBranchAccBank.Inserted
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Insurance Branch ACC ID : " & e.Command.Parameters("@INSBRANCHACCID").Value & " already exists..!"
        Else
            lblError.Visible = False
            fvBranchAccBank.Caption = ""
            DataSearch()
        End If
    End Sub


    Protected Sub sdsBranchAccBank_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsBranchAccBank.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Insurance Branch ACC ID : " & e.Command.Parameters("@INSBRANCHACCID").Value & " already exists..!"
        Else
            lblError.Visible = False
            DataSearch()
        End If
    End Sub

    Protected Sub sdsBranchAccBank_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsBranchAccBank.Deleted
        fvBranchAccBank.Caption = ""
    End Sub

    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvData_RowCreated(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvData.RowCreated
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            e.Row.Attributes.Add("onclick", Page.ClientScript.GetPostBackEventReference(gvData, "Select$" + e.Row.RowIndex.ToString()))
        End If
    End Sub

    Protected Sub ddlInsCompanySrc_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlInsCompanySrc.SelectedIndexChanged
        DataSearch()
    End Sub

    Protected Sub ddlInsBranchSrc_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlInsBranchSrc.SelectedIndexChanged
        DataSearch()
    End Sub
End Class
