Imports System.IO
Imports System.Data.SqlClient
Imports System.Data
Imports System.Drawing
Partial Class Transportasi_Transportasi
    Inherits System.Web.UI.Page
    Public Shared iError As Integer = 0
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            ''SetObjectValidation(txtSearch, True)
        End If
        DataSearch()
        fvData.Visible = True
    End Sub
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Private Sub DataSearch()
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        gvData.DataBind()
    End Sub
    Protected Sub gvData_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        lblError.Visible = False
        If e.CommandName = "Select" Then
            fvData.ChangeMode(FormViewMode.Edit)
            fvData.Caption = "Edit Data"
        End If
        fvData.Visible = True
    End Sub
    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
        lblError.Text = ""
    End Sub
    Protected Sub gvData_PageIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub fvData_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvData.ItemCommand
        If e.CommandName = "Cancel" Then
            gvData.SelectedIndex = -1
            fvData.Caption = ""
        End If
    End Sub

    Protected Sub btnUpdate_Click(sender As Object, e As EventArgs)
        Dim objDB As New DBX
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Dim intRetVal As Integer
        Dim olblOrderID As Label = CType(fvData.FindControl("lblOrderID"), Label)
        Dim oddlStatus As DropDownList = CType(fvData.FindControl("ddlStatus"), DropDownList)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDESEWAUPDATE",
                                                    objDB.MP("@ORDERDESEWAID", Data.SqlDbType.Int, olblOrderID.Text),
                                                    objDB.MP("@STATUS", Data.SqlDbType.Int, oddlStatus.SelectedValue),
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
    End Sub
End Class
