Imports System.IO
Imports System.Data.SqlClient
Imports System.Data
Imports System.Drawing
Imports CrystalDecisions.Shared.Json
Imports Ext.Net
Imports Microsoft.Ajax.Utilities
Partial Class Product_ViewMitra
    Inherits System.Web.UI.Page
    Public Shared iError As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ''SetObjectValidation(txtSearch, True)
        End If
        'gvData.DataBind()
        DataSearch()
    End Sub
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub
    'Protected Sub gvData_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand

    '    If e.CommandName = "Select" Then
    '        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument).ToString

    '    End If
    'End Sub
    Protected Sub imgBtnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        fvData.ChangeMode(FormViewMode.Insert)
        fvData.Caption = "New Data"
    End Sub
    'Protected Sub sdsForm_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Inserted
    '    If e.Command.Parameters("@retval").Value = -1 Then
    '        lblError.Visible = True
    '    Else
    '        lblError.Visible = False
    '        fvData.Caption = ""
    '    End If
    'End Sub
    Private Sub DataSearch()
        If rbReqAll.Checked Then
            If Len(Trim(txtSearch.Text)) > 0 Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
            End If
            gvData.DataBind()
            txtRequestForm.Text = ""
            txtRequestTo.Text = ""
        End If
        If rbReqDate.Checked Then
            If Len(Trim(txtRequestForm.Text)) > 0 And Len(Trim(txtRequestTo.Text)) > 0 Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (PS.STOCKDATE BETWEEN CONVERT(DATETIME, '" + txtRequestForm.Text + "', 103) AND CONVERT(DATETIME, '" + txtRequestTo.Text + "', 103))"
            End If
        End If

    End Sub
    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        lblError.Visible = False
        DataSearch()
    End Sub
    Protected Sub sdsForm_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Deleted
        fvData.Caption = ""
        DataSearch()
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs)
        Dim objDB As New DBX
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Dim intRetVal As Integer
        Dim oLabel3 As System.Web.UI.WebControls.Label = CType(dlAppData.FindControl("Label3"), System.Web.UI.WebControls.Label)
        Dim otxtTotal As TextBox = CType(fvData.FindControl("txtTotal"), TextBox)
        Dim otxtOut As TextBox = CType(fvData.FindControl("txtOut"), TextBox)
        Dim otxtReady As TextBox = CType(fvData.FindControl("txtReady"), TextBox)
        Dim otxtAwal As TextBox = CType(dlAppData.FindControl("txtAwal"), TextBox)
        Dim otxtIn As TextBox = CType(fvData.FindControl("txtIn"), TextBox)
        'If otxtAwal.Text = 0 Then
        '    lblError.Visible = True
        '    lblError.Text = "STOCK HABIS...!"
        '    iError = 1
        'Else

        Try
            oSQLParam = objDB.ExecSPReturnParam("PRODUCTSTOCKADD",
                                                    objDB.MP("@PRODUCTID", Data.SqlDbType.Int, oLabel3.Text),
                                                    objDB.MP("@STOCKOUT", Data.SqlDbType.NVarChar, otxtOut.Text),
                                                    objDB.MP("@STOCKIN", Data.SqlDbType.NVarChar, otxtIn.Text),
                                                    objDB.MP("@READYSTOCK", Data.SqlDbType.NVarChar, otxtReady.Text),
                                                    objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, Data.ParameterDirection.Output))
            intRetVal = oSQLParam("@RETVAL").Value.ToString()
        Catch ex As Exception
            If intRetVal = -1 Then
                lblError.Visible = True
                lblError.Text = "ERROR UPDATE DATA MITRA <BR> PLEASE CHECK DETAIL ERROR MESSAGE...!"
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
        dlAppData.DataBind()
        '        End If

    End Sub
    'Private Sub bindGrid()
    '    Dim constr As String = ConfigurationManager.ConnectionStrings("connection").ConnectionString
    '    Using con As New SqlConnection(constr)
    '        Using cmd As New SqlCommand("PRODUCTSTOCK")
    '            cmd.Parameters.AddWithValue("@monthfrom", ConvertDate(txtRequestForm.Text))
    '            cmd.Parameters.AddWithValue("@monthto", ConvertDate(txtRequestTo.Text))
    '            Using sda As New SqlDataAdapter()
    '                cmd.CommandType = CommandType.StoredProcedure
    '                cmd.Connection = con
    '                sda.SelectCommand = cmd
    '                Using dt As New DataTable()
    '                    sda.Fill(dt)
    '                End Using
    '            End Using
    '        End Using
    '    End Using
    'End Sub
    'Private Sub bindDashboard()
    '    Dim constr As String = ConfigurationManager.ConnectionStrings("connection").ConnectionString
    '    Using con As New SqlConnection(constr)
    '        Using cmd As New SqlCommand("PRODUCTSTOCK")
    '            cmd.Parameters.AddWithValue(ConvertDate("@monthfrom"), ConvertDate(txtRequestForm.Text))
    '            cmd.Parameters.AddWithValue(ConvertDate("@monthto"), ConvertDate(txtRequestTo.Text))
    '            Using sda As New SqlDataAdapter()
    '                cmd.CommandType = CommandType.StoredProcedure
    '                cmd.Connection = con
    '                sda.SelectCommand = cmd
    '                Using dt As New DataTable()
    '                    sda.Fill(dt)
    '                End Using
    '            End Using
    '        End Using
    '    End Using
    'End Sub
End Class

