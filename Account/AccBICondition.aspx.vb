Partial Class Account_AccBICondition
    Inherits System.Web.UI.Page
    Private Shared prevPage As String = String.Empty

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim dtConditionDate As Date
        SetObjectValidation(txtConditionDate, False, "date", "[0-9.]")

        If Not IsPostBack() Then
            prevPage = Request.UrlReferrer.ToString()
            txtConditionDate.Focus()
            txtAction.Value = Request.QueryString("Action")
            Dim strLocID As String = "", strAccID As String = "", strObjID As String = ""
            'ajaxCPELoanData.Collapsed = True
            Dim objDB As New DBX
            Try
                Dim oSDR As Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppDate() APPDATE, LOCID, ACCID FROM ACCOUNT WITH(NOLOCK) WHERE LOCID=" & Request.QueryString("LOCID") & " AND APPID=" & Request.QueryString("APPID"))
                If oSDR.Read() Then
                    strLocID = oSDR("LOCID")
                    strAccID = oSDR("ACCID")
                    ctlDataAccountFromParamAccID.LOCID = strLocID
                    ctlDataAccountFromParamAccID.ACCID = strAccID
                    hidLocID.Value = strLocID
                    hidAccID.Value = strAccID
                    dtConditionDate = oSDR("APPDATE")
                End If
                oSDR.Close()
                oSDR = Nothing

                oSDR = objDB.CreateSDRFromSQLSelect("SELECT CONDITIONBIID, CONDITIONBIDATE " & _
                    " FROM ACCOUNTDTL WITH(NOLOCK)" & _
                    " WHERE ACCOUNTDTL.LOCID=" & strLocID & " AND ACCOUNTDTL.ACCID=" & strAccID)
                If oSDR.Read() Then
                    If Not String.IsNullOrEmpty(oSDR("CONDITIONBIDATE").ToString()) Then
                        txtConditionDate.Text = String.Format("{0:dd/MM/yyyy}", oSDR("CONDITIONBIDATE"))
                    Else
                        txtConditionDate.Text = ""
                    End If
                    ddlCondition.SelectedValue = oSDR("CONDITIONBIID").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing
                If Len(Trim(txtConditionDate.Text)) <= 0 Then
                    txtConditionDate.Text = String.Format("{0:dd/MM/yyyy}", dtConditionDate)
                End If
            Catch ex As Exception
                lblMessage.Visible = True
                lblMessage.Text = "ERROR LOADING EDIT BI CONDITION: " & ex.Message & "<br>PLEASE CHECK DETAIL ERROR MESSAGE...!"
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
            objDB.ExecSP("ACCOUNTCONDITIONBIUpdate", _
                    objDB.MP("@LOCID", Data.SqlDbType.Int, hidLocID.Value, 10), _
                    objDB.MP("@ACCID", Data.SqlDbType.BigInt, hidAccID.Value, 20), _
                    objDB.MP("@CONDITIONBIID", Data.SqlDbType.Int, ddlCondition.SelectedValue, 20), _
                    objDB.MP("@CONDITIONBIDATE", Data.SqlDbType.DateTime, ConvertDate(txtConditionDate.Text), 20), _
                    objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value, 20) _
                    )
            lblMessage.Visible = True
            lblMessage.Text = "SAVE ACCOUNT BI CONDITION COMPLETED...!"
            Response.Write("<script type='text/javascript'>")
            Response.Write("window.history.back(-2);")
            Response.Write("</script>")
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE ACCOUNT BI CONDITION: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing

        End Try
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As System.EventArgs) Handles btnCancel.Click
        Response.Redirect(prevPage)
    End Sub
End Class
