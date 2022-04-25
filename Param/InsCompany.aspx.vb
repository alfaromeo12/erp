
Partial Class Param_InsCompany
    Inherits System.Web.UI.Page
    Public strInsCompanyId As Integer
    Public strCity As String
    Public strCityID As String
    'Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
    '    DataSearch()
    'End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            DataSearch()
            Multi_View.SetActiveView(view_Main)
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
        oTextBox = CType(fvData.FindControl("txtInsuranceCode"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase nospace")
            oTextBox.Focus()
        End If
        oTextBox = CType(fvData.FindControl("txtInsuranceName"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase")
        End If
        oTextBox = CType(fvData.FindControl("txtInsuranceAddress"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase")
        End If
        oTextBox = CType(fvData.FindControl("txtCity"), TextBox)
        If oTextBox IsNot Nothing Then
            strCity = oTextBox.ClientID
        End If

        Dim oHidden As HiddenField
        oHidden = CType(fvData.FindControl("hidCity"), HiddenField)
        If oHidden IsNot Nothing Then
            strCityID = oHidden.ClientID
        End If
    End Sub

    Private Sub DataSearch()
        If Not IsPostBack() Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND INSCOMPANY.INSCOMPANYID=-999"
        End If
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlInsurance.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
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
            lblError.Text = "Insurance Code : " & e.Command.Parameters("@INSURANCECODE").Value & " already exists..!"
        Else
            strInsCompanyId = e.Command.Parameters("@INSCOMPANYID").Value
            lblError.Visible = False
            fvData.Caption = ""
            DataSearch()
        End If
    End Sub


    Protected Sub sdsForm_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Updated
        If e.Command.Parameters("@retval").Value = -1 Then
            lblError.Visible = True
            lblError.Text = "Insurance Code : " & e.Command.Parameters("@INSURANCECODE").Value & " already exists..!"
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
            ElseIf DataBinder.Eval(e.Row.DataItem, "BROKERFLAG") Then
                e.Row.Font.Bold = True
                e.Row.ForeColor = Drawing.Color.Blue
            End If
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

    Protected Sub imgbtnAgent_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        Dim currentCommand As String = e.CommandName
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument)
        Try
            Multi_View.SetActiveView(v_Agent)
            gvData.SelectedIndex = e.CommandArgument
            hidInsCompanyId.Value = gvData.SelectedDataKey("INSCOMPANYID")
            lvbDestinationAgent.DataBind()
            lvbSourceAgent.DataBind()
        Catch ex As Exception
            lblMessage.Text = "ERROR RETRIEVE INSURANCE COMPANY INFO"
            lblMessage.Visible = True
        End Try
    End Sub

    Protected Sub btnBackAgent_Click(sender As Object, e As System.EventArgs) Handles btnBackAgent.Click
        Multi_View.SetActiveView(view_Main)
        fvData.Caption = ""
    End Sub

    Protected Sub btnSaveAgent_Click(sender As Object, e As System.EventArgs) Handles btnSaveAgent.Click
        Dim objDB As New DBX
        Dim iRow As Integer
        Dim iRows As Integer
        Try
            Dim oSDR As Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromExecSQL("Update dbo.INSMEMBER SET DeleteSTS=1, LastUpdate=Getdate() , LastUserID= " & Request.Cookies("UID").Value & "  WHERE INSCOMPANYID=" & hidInsCompanyId.Value)
            If oSDR.Read() Then
            End If
            oSDR.Close()

            iRows = lvbDestinationAgent.Items.Count.ToString - 1
            For iRow = 0 To iRows
                SaveInsAgent(hidInsCompanyId.Value, lvbDestinationAgent.Items.Item(iRow).Value)
            Next
        Catch ex As Exception
            lblMessage.Text = "ERROR SAVE INSURANCE COMPANY INFO"
            lblMessage.Visible = True
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Protected Sub btnMove_Click(sender As Object, e As System.EventArgs) Handles btnMove.Click
        For i As Integer = lvbSourceAgent.Items.Count - 1 To 0 Step -1
            If lvbSourceAgent.Items(i).Selected Then
                lvbDestinationAgent.Items.Add(lvbSourceAgent.Items(i))
                lvbDestinationAgent.ClearSelection()
                lvbSourceAgent.Items.Remove(lvbSourceAgent.Items(i))
            End If
        Next
    End Sub

    Protected Sub btnBack_Click(sender As Object, e As System.EventArgs) Handles btnBack.Click
        For i As Integer = lvbDestinationAgent.Items.Count - 1 To 0 Step -1
            If lvbDestinationAgent.Items(i).Selected Then
                lvbSourceAgent.Items.Add(lvbDestinationAgent.Items(i))
                lvbSourceAgent.ClearSelection()
                lvbDestinationAgent.Items.Remove(lvbDestinationAgent.Items(i))
            End If
        Next
    End Sub
    Private Sub SaveInsAgent(ByVal iInsCompID As Integer,
                            ByVal iInsCompIDAgent As Integer)

        Dim objDB As New DBX
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try

            oSQLParam = objDB.ExecSPReturnParam("INSMEMBERSave", _
                   objDB.MP("@INSCOMPANYID", Data.SqlDbType.Int, iInsCompID, 8), _
                   objDB.MP("@INSCOMPANYIDAGENT", Data.SqlDbType.Int, iInsCompIDAgent, 8), _
                   objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 20))
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE DATA INSURANCE MEMBER : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            lblMessage.Visible = False
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub
End Class
