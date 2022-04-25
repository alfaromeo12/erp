
Partial Class Account_AccEdit
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            ddlCountry.Focus()
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
                    ctlDataAccountFromParamAccID.LOCID = strLocID
                    ctlDataAccountFromParamAccID.ACCID = strAccID
                    hidLocID.Value = strLocID
                    hidAccID.Value = strAccID
                End If
                oSDR.Close()
                oSDR = Nothing
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT COUNTRYID, TYPEOFUSEID, ORIENTATIONOFUSEID, DEBITURCATID, PORTFOLIOCATID, CREDITTYPEID, CREDITATTRIBUTEID, CREDITCATID " & _
                    " FROM ACCOUNT WITH(NOLOCK) INNER JOIN ACCOUNTDTL WITH(NOLOCK) ON ACCOUNT.LOCID=ACCOUNTDTL.LOCID AND ACCOUNT.ACCID=ACCOUNTDTL.ACCID" & _
                    " WHERE ACCOUNT.LOCID=" & strLocID & " AND ACCOUNT.ACCID=" & strAccID)
                If oSDR.Read() Then
                    ddlCountry.SelectedValue = oSDR("COUNTRYID").ToString()
                    'ddlCollType.SelectedValue = oSDR("COLLATERALTYPEID").ToString()
                    ddlTOU.SelectedValue = oSDR("TYPEOFUSEID").ToString()
                    ddlOOU.SelectedValue = oSDR("ORIENTATIONOFUSEID").ToString()
                    'ddlBindType.SelectedValue = oSDR("BINDTYPEID").ToString()
                    'ddlSBRank.SelectedValue = oSDR("SBRANKID").ToString()
                    ddlDebiturCategory.SelectedValue = oSDR("DEBITURCATID").ToString()
                    ddlPortofolioCategory.SelectedValue = oSDR("PORTFOLIOCATID").ToString()
                    ddlCreditType.SelectedValue = oSDR("CREDITTYPEID").ToString()
                    ddlCreditAttribute.SelectedValue = oSDR("CREDITATTRIBUTEID").ToString()
                    ddlCreditCategory.SelectedValue = oSDR("CREDITCATID").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing
            Catch ex As Exception
                lblMessage.Visible = True
                lblMessage.Text = "ERROR LOADING ACCOUNG EDITING: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objDB As New DBX
        Try
            objDB.ExecSP("ACCOUNTEditUpdate", _
                    objDB.MP("@LOCID", Data.SqlDbType.Int, hidLocID.Value, 10), _
                    objDB.MP("@ACCID", Data.SqlDbType.BigInt, hidAccID.Value, 20), _
                    objDB.MP("@COUNTRYID", Data.SqlDbType.BigInt, ddlCountry.SelectedValue, 20), _
                    objDB.MP("@TYPEOFUSEID", Data.SqlDbType.BigInt, ddlTOU.SelectedValue, 20), _
                    objDB.MP("@ORIENTATIONOFUSEID", Data.SqlDbType.BigInt, ddlOOU.SelectedValue, 20), _
                    objDB.MP("@DEBITURCATID", Data.SqlDbType.BigInt, ddlDebiturCategory.SelectedValue, 20), _
                    objDB.MP("@PORTFOLIOCATID", Data.SqlDbType.BigInt, ddlPortofolioCategory.SelectedValue, 20), _
                    objDB.MP("@CREDITTYPEID", Data.SqlDbType.BigInt, ddlCreditType.SelectedValue, 20), _
                    objDB.MP("@CREDITATTRIBUTEID", Data.SqlDbType.BigInt, ddlCreditAttribute.SelectedValue, 20), _
                    objDB.MP("@CREDITCATID", Data.SqlDbType.BigInt, ddlCreditCategory.SelectedValue, 20), _
                    objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value, 20) _
                    )
            lblMessage.Visible = True
            lblMessage.Text = "SAVE ACCOUNG EDITING SUCCESSFULLY...!"


            Response.Write("<script type='text/javascript'>")
            Response.Write("window.history.back(-2);")
            Response.Write("</script>")
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE ACCOUNG EDITING: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing

        End Try
    End Sub
End Class
