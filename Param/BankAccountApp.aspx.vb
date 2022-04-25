
Partial Class Param_BankAccount
    Inherits System.Web.UI.Page

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
    '    fvData.ChangeMode(FormViewMode.Insert)
    '    fvData.Caption = "New Data"
    'End Sub

    Protected Sub fvData_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvData.ItemCreated
        SetValidation()
    End Sub

    Private Sub SetValidation()
        Dim oTextBox As TextBox
        oTextBox = CType(fvData.FindControl("txtAccountNo"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase nospace")
            oTextBox.Focus()
        End If
        'oTextBox = CType(fvData.FindControl("txtBankBranch"), TextBox)
        'If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, True)
        'oTextBox = CType(fvData.FindControl("txtCOANo"), TextBox)
        'If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, True)
    End Sub

    Private Sub DataSearch()
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        If Len(Trim(ddlBankSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BANKACCOUNT.BANKID=" & ddlBankSearch.SelectedValue
        End If
        gvData.DataBind()
    End Sub

    Protected Sub fvData_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewDeletedEventArgs) Handles fvData.ItemDeleted
        DataSearch()
    End Sub

    Protected Sub fvData_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles fvData.ItemInserted
        ddlBankSearch.DataBind()
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
                intRetVal = objDB.ExecSPReturnInteger("BANKACCOUNTAPPROVAL", _
                    objDB.MP("@ACCOUNTID", Data.SqlDbType.Int, fvData.DataKey.Item(0)), _
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
                lblError.Text = "BANKACCOUNT Reject/Approval Error: " & ex.Message & "<br>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        End If
    End Sub

    Protected Sub sdsForm_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Inserted
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Account No : " & e.Command.Parameters("@AccountNo").Value & " already exists..!"
        Else
            lblError.Visible = False
            fvData.Caption = ""
        End If
    End Sub

    Protected Sub sdsForm_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Deleted
        fvData.Caption = ""
    End Sub

    Protected Sub sdsForm_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Account No : " & e.Command.Parameters("@AccountNo").Value & " already exists..!"
        End If
    End Sub

    Protected Sub ddlBankSearch_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlBankSearch.SelectedIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub
End Class
