
Partial Class Param_Collect

    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ''SetObjectValidation(txtSearch, True)
        End If
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
            fvData.Caption = "Approval"
        End If
    End Sub

    Protected Sub fvData_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvData.ItemCreated
        SetValidation()
    End Sub

    Private Sub SetValidation()
        Dim oTextBox As TextBox
        oTextBox = CType(fvData.FindControl("txtDPDFrom"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "integer", "[0-9]")
        oTextBox = CType(fvData.FindControl("txtDPDTo"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "integer", "[0-9]")
        oTextBox = CType(fvData.FindControl("txtReserved"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "float", "[0-9.]")

    End Sub

    Private Sub DataSearch()
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        If InStr(sdsGrid.SelectCommand, "ORDER BY FROMDPD", CompareMethod.Text) <= 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " ORDER BY FROMDPD"
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
                intRetVal = objDB.ExecSPReturnInteger("COLLECTSTSAPPROVAL", _
                    objDB.MP("@COLLECTID", Data.SqlDbType.Int, fvData.DataKey.Item(0)), _
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
                lblError.Text = "BRANCH Reject/Approval Error: " & ex.Message & "<br>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        End If
    End Sub

    Protected Sub sdsForm_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Inserted
        If e.Command.Parameters("@RETVAL").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Code already exists..!"
        Else
            lblError.Visible = False
            fvData.Caption = ""
        End If
        fvData.Caption = ""
        'DataSearch()
    End Sub

    Protected Sub sdsForm_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Updated
        If e.Command.Parameters("@RETVAL").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Code already exists..!"
        End If
        fvData.Caption = ""
        'DataSearch()
    End Sub

    Protected Sub sdsForm_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Deleted
        fvData.Caption = ""
        'DataSearch()
    End Sub
End Class
