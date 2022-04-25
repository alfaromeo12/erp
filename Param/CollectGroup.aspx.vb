Imports System.Collections
Partial Class Param_CollectGroup
    Inherits System.Web.UI.Page
    Private sError As String
    'Public Shared strGroupCode As String
    'Public Shared strBranchList As String
    'Public Shared strBranchGroup As String
    Private oListBox As ListBox
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
        End If
    End Sub
    Protected Sub Page_PreInit(sender As Object, e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnNew_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click

        lblError.Visible = False
        fvCollectGroup.ChangeMode(FormViewMode.Insert)
        fvCollectGroup.Caption = "New Data"

        pnlGroupDtl.Visible = False
        fvCollectGroup.Visible = True
        lblMessage.Visible = False

        gvData.SelectedIndex = -1

    End Sub

    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvData_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        lblError.Visible = False
        If e.CommandName = "Select" Then
            fvCollectGroup.ChangeMode(FormViewMode.Edit)
            fvCollectGroup.Caption = "Edit Data"
            pnlGroupDtl.Visible = False
            fvCollectGroup.Visible = True
            lblMessage.Visible = False
        End If
    End Sub

    Protected Sub sdsCollectGroup_Deleted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCollectGroup.Deleted
        fvCollectGroup.Caption = ""
        DataSearch()
    End Sub

    Protected Sub sdsCollectGroup_Inserted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCollectGroup.Inserted
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Collector GROUP Code : " & e.Command.Parameters("@COLLGROUPCODE").Value & " already exists..!"
        Else
            lblError.Visible = False
            fvCollectGroup.Caption = ""
            DataSearch()
        End If
    End Sub

    Protected Sub sdsCollectGroup_Selected(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCollectGroup.Selected
        sdsCollectGroup.DataBind()
    End Sub

    Protected Sub sdsCollectGroup_Updated(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCollectGroup.Updated   
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Collector GROUP Code : " & e.Command.Parameters("@COLLGROUPCODE").Value & " already exists..!"
        Else
            lblError.Visible = False
            DataSearch()
        End If
    End Sub
    Private Sub SetValidation()
        Dim oTextBox As TextBox

        oTextBox = CType(fvCollectGroup.FindControl("txtCollCode"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase")
            oTextBox.Focus()
        End If
        oTextBox = CType(fvCollectGroup.FindControl("txtCollName"), TextBox)

        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")
        'oListBox = CType(fvCollectGroup.FindControl("lvbBranch"), ListBox)
        'If oListBox IsNot Nothing Then strBranchList = oListBox.ClientID

        'oListBox = CType(fvCollectGroup.FindControl("lvbGroupDtl"), ListBox)
        'If oListBox IsNot Nothing Then strBranchGroup = oListBox.ClientID
    End Sub

    Protected Sub fvCollectGroup_ItemCommand(sender As Object, e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvCollectGroup.ItemCommand
        If e.CommandName = "Cancel" Then
            gvData.SelectedIndex = -1
            fvCollectGroup.Caption = ""
        End If
    End Sub
    Protected Sub fvCollectGroup_ItemCreated(sender As Object, e As System.EventArgs) Handles fvCollectGroup.ItemCreated
        SetValidation()
    End Sub
    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
        lblError.Visible = False
    End Sub

    Private Sub DataSearch()
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        gvData.DataBind()
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        Dim objDB As New DBX
        Dim iRow As Integer
        Dim iRows As Integer
        Dim intRetVal As Integer
        Try
            Dim oSDR As Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromExecSQL("Update dbo.COLLECTORGROUPDTL SET DeleteSTS=1 WHERE COLLGROUPID=" & CType(fvCollectGrpDtl.FindControl("lblCollGrpId"), Label).Text)
            If oSDR.Read() Then

            End If        
            oSDR.Close()

            iRows = lvbGroupDtl.Items.Count.ToString - 1
            For iRow = 0 To iRows

                intRetVal = objDB.ExecSPReturnInteger("COLLECTORGROUPDTLSave", _
                        objDB.MP("@COLLGROUPID", Data.SqlDbType.Int, CType(fvCollectGrpDtl.FindControl("lblCollGrpId"), Label).Text, 10), _
                        objDB.MP("@BRANCHID", Data.SqlDbType.Int, lvbGroupDtl.Items.Item(iRow).Value, 10), _
                        objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value, 20) _
                )
            Next
            lblMessage.Visible = True
            If intRetVal = -1 Then
                lblMessage.Text = "SAVE COLLECTOR GROUP FAILED...!<BR>COLLECTOR GROUP DETAIL ALREADY ENTRY...!"
                btnSave.Visible = False
            Else
                lblMessage.Text = "SAVE COLLECTOR GROUP DETAIL COMPLETED......!"
                'btnSave.Visible = False
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR COLLECTOR GROUP DETAIL: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing

        End Try
    End Sub

    Protected Sub btnViewDtl_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        Dim currentCommand As String = e.CommandName
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument)
        Dim CollectID As String
        Try
            CollectID = gvData.DataKeys(currentRowIndex).Value

            lblCommand.Text = currentCommand
            lblIndex.Text = currentRowIndex.ToString
            lblKey.Text = CollectID
            gvData.SelectedIndex = currentRowIndex
            pnlGroupDtl.Visible = True
            fvCollectGroup.Visible = False
            lblMessage.Visible = False
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR COLLECTOR GROUP DETAIL: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        End Try
    End Sub

   
    Protected Sub btnCancel_Click(sender As Object, e As System.EventArgs) Handles btnCancel.Click
        Try
            pnlGroupDtl.Visible = False
            fvCollectGroup.Visible = True
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR COLLECTOR GROUP DETAIL: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"

        End Try
    End Sub

    'Protected Sub btnBack_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnBack.Click
    '    For i As Integer = lvbGroupDtl.Items.Count - 1 To 0 Step -1
    '        If lvbGroupDtl.Items(i).Selected Then
    '            lvbBranch.Items.Add(lvbGroupDtl.Items(i))
    '            lvbBranch.ClearSelection()
    '            lvbGroupDtl.Items.Remove(lvbGroupDtl.Items(i))
    '        End If
    '    Next
    'End Sub

    'Protected Sub btnMove_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnMove.Click
    '    For i As Integer = lvbBranch.Items.Count - 1 To 0 Step -1
    '        If lvbBranch.Items(i).Selected Then
    '            lvbGroupDtl.Items.Add(lvbBranch.Items(i))
    '            lvbGroupDtl.ClearSelection()
    '            lvbBranch.Items.Remove(lvbBranch.Items(i))
    '        End If
    '    Next
    'End Sub



    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub


    Protected Sub btnMove_Click(sender As Object, e As System.EventArgs) Handles btnMove.Click
        For i As Integer = lvbBranch.Items.Count - 1 To 0 Step -1
            If lvbBranch.Items(i).Selected Then
                lvbGroupDtl.Items.Add(lvbBranch.Items(i))
                lvbGroupDtl.ClearSelection()
                lvbBranch.Items.Remove(lvbBranch.Items(i))
            End If
        Next
    End Sub

    Protected Sub btnBack_Click(sender As Object, e As System.EventArgs) Handles btnBack.Click
        For i As Integer = lvbGroupDtl.Items.Count - 1 To 0 Step -1
            If lvbGroupDtl.Items(i).Selected Then
                lvbBranch.Items.Add(lvbGroupDtl.Items(i))
                lvbBranch.ClearSelection()
                lvbGroupDtl.Items.Remove(lvbGroupDtl.Items(i))
            End If
        Next
    End Sub
End Class
