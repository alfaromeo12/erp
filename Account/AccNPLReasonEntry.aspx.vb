
Partial Class Account_AccNPLEntry
    Inherits System.Web.UI.Page
    Private Shared prevPage As String = String.Empty

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            prevPage = Request.UrlReferrer.ToString()
            ddlNPLReason.Focus()
            txtAction.Value = Request.QueryString("Action")
            Dim strLocID As String = "", strAccID As String = ""
            'ajaxCPELoanData.Collapsed = True
            Dim objDB As New DBX
            Try
                Dim oSDR As Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT LOCID, ACCID FROM ACCOUNT WITH(NOLOCK) WHERE LOCID=" & Request.QueryString("LOCID") & " AND APPID=" & Request.QueryString("APPID"))
                If oSDR.Read() Then
                    strLocID = oSDR("LOCID")
                    strAccID = oSDR("ACCID")
                    hidLocID.Value = strLocID
                    hidAccID.Value = strAccID

                    ctlDataAccountFromParamAccID.LOCID = strLocID
                    ctlDataAccountFromParamAccID.ACCID = strAccID
                    ctlCollectibilityParamAccID.LOCID = strLocID
                    ctlCollectibilityParamAccID.ACCID = strAccID

                    sdsInstallment.SelectParameters("LOCID").DefaultValue = strLocID
                    sdsInstallment.SelectParameters("ACCID").DefaultValue = strAccID
                End If

                oSDR.Close()
                oSDR = Nothing
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT NPLREASONID, NPLREASONDESC " & _
                    " FROM ACCOUNTDTL WITH(NOLOCK) " & _
                    " WHERE ACCOUNTDTL.LOCID=" & strLocID & " AND ACCOUNTDTL.ACCID=" & strAccID)
                If oSDR.Read() Then
                    ddlNPLReason.SelectedValue = oSDR("NPLREASONID").ToString()
                    txtReasonDesc.Text = oSDR("NPLREASONDESC").ToString
                End If
                oSDR.Close()
                oSDR = Nothing
            Catch ex As Exception
                lblMessage.Visible = True
                lblMessage.Text = "ERROR LOADING NPL REASON ENTRY: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        lblMessage.Visible = False
        Dim objDB As New DBX
        Try
            objDB.ExecSP("ACCOUNTNPLREASONUpdate", _
                    objDB.MP("@LOCID", Data.SqlDbType.Int, hidLocID.Value, 10), _
                    objDB.MP("@ACCID", Data.SqlDbType.BigInt, hidAccID.Value, 20), _
                    objDB.MP("@NPLREASONID", Data.SqlDbType.Int, ddlNPLReason.SelectedValue, 20), _
                    objDB.MP("@NPLREASONDESC", Data.SqlDbType.VarChar, txtReasonDesc.Text, 500), _
                    objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value, 20) _
                    )
            lblMessage.Visible = True
            lblMessage.Text = "SAVE NPL REASON ENTRY SUCCESSFULLY..!"
            Response.Write("<script type='text/javascript'>")
            Response.Write("window.history.back(-2);")
            Response.Write("</script>")
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE NPL REASON ENTRY: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing

        End Try
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As System.EventArgs) Handles btnCancel.Click
        Response.Redirect(prevPage)
    End Sub
End Class
