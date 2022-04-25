
Partial Class Param_BookJournal
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            SetObjectValidation(txtSort, False, "integer", "[0-9]")
            ddlFinanceCategory.DataBind()
            hidUseGenTran.Value = Request.QueryString("USEDTXN")
        End If
        If Request.QueryString("Action") = "CopyBookCode" Then
            Dim objDB As New DBX
            Try
                objDB.ExecSP("BookCodeCopy", _
                    objDB.MP("@BcId", Data.SqlDbType.Int, Request.QueryString("BCID")), _
                    objDB.MP("@CopyBcId", Data.SqlDbType.Int, Request.QueryString("BCIDCopy")), _
                    objDB.MP("@UserId", Data.SqlDbType.VarChar, Request.Cookies("UID").Value, 30) _
                        )
                DataSearch()
            Catch ex As Exception
                Throw
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        End If
    End Sub

    Protected Sub btnBack_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBack.Click
        Response.Redirect("BookCode.aspx")
    End Sub

    Protected Sub imgBtnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        pnlNew.Visible = True
        Validation.ClearPanelAplicationField(pnlNew)
        If hidUseGenTran.Value = "YES" Then
            Me.sdsBookValue.SelectCommand = Replace(Me.sdsBookValue.SelectCommand, "1 = 1", "BVID=1")
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        pnlNew.Visible = False
    End Sub

    Private Sub DataSearch()
        gvData.DataBind()
       
    End Sub

    Protected Sub btnInsert_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInsert.Click
        Dim objDB As New DBX
        Try
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            Dim dblRetval As Double
            oSQLParam = objDB.ExecSPReturnParam("BookJournalAdd", _
                objDB.MP("@BCID", Data.SqlDbType.Int, Request.QueryString("BCID")), _
                objDB.MP("@COAID", Data.SqlDbType.BigInt, ddlCOA.SelectedValue), _
                objDB.MP("@BVID", Data.SqlDbType.Int, ddlBookValue.SelectedValue), _
                objDB.MP("@DRCR", Data.SqlDbType.VarChar, ddlDrCr.SelectedValue, 20), _
                objDB.MP("@SORT", Data.SqlDbType.Int, txtSort.Text), _
                objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value), _
                objDB.MP("@BJID", Data.SqlDbType.Int, dblRetval, 30, Data.ParameterDirection.InputOutput), _
                objDB.MP("@FINCATID", Data.SqlDbType.SmallInt, ddlFinanceCategory.SelectedValue) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        pnlNew.Visible = False
        DataSearch()
        'gvData.DataBind()
    End Sub


    Protected Sub ddlBranchCat_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlFinanceCategory.SelectedIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvData_RowEditing(sender As Object, e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles gvData.RowEditing
        If hidUseGenTran.Value = "YES" Then
            Me.sdsBookValue.SelectCommand = Replace(Me.sdsBookValue.SelectCommand, "1 = 1", "BVID=1")
        End If
        Dim oDropDownList As DropDownList
        oDropDownList = CType(gvData.FindControl("ddlBookValue"), DropDownList)
        If oDropDownList IsNot Nothing Then
            oDropDownList.DataBind()
        End If
    End Sub
End Class
