
Partial Class Account_AccReSurvey
    Inherits System.Web.UI.Page
    Private Shared prevPage As String = String.Empty

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            prevPage = Request.UrlReferrer.ToString()
            txtAction.Value = Request.QueryString("Action")
            Dim strLocID As String = "", strAccID As String = "", strObjID As String = ""
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
                End If
                oSDR.Close()
                oSDR = Nothing
                'oSDR = objDB.CreateSDRFromSQLSelect("SELECT OBJID FROM COLLATERAL WITH(NOLOCK) WHERE LOCID=" & strLocID & " AND ACCID=" & strAccID)
                'If oSDR.Read() Then
                '    strObjID = oSDR("OBJID")
                '    hidObjID.Value = strObjID
                'End If
                'oSDR.Close()
                'oSDR = Nothing

                'oSDR = objDB.CreateSDRFromSQLSelect("SELECT RESURVEYDATE, RESURVEYVALUE " & _
                '    " FROM COLLATERAL WITH(NOLOCK)" & _
                '    " WHERE COLLATERAL.LOCID=" & strLocID & " AND COLLATERAL.OBJID=" & strObjID)
                'If oSDR.Read() Then
                '    If Not String.IsNullOrEmpty(oSDR("RESURVEYDATE").ToString()) Then
                '        txtSurveyDate.Text = String.Format("{0:dd/MM/yyyy}", oSDR("RESURVEYDATE"))
                '    Else
                '        txtSurveyDate.Text = ""
                '    End If

                '    If Not String.IsNullOrEmpty(oSDR("RESURVEYVALUE").ToString()) Then
                '        txtSurveyValue.Text = String.Format("{0:N}", oSDR("RESURVEYVALUE"))
                '    Else
                '        txtSurveyValue.Text = "0"
                '    End If

                'End If
                'oSDR.Close()
                'oSDR = Nothing
            Catch ex As Exception
                lblMessage.Visible = True
                lblMessage.Text = "ERROR LOADING RE-SURVEY ENTRY: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim oTextBox As TextBox
        oTextBox = CType(fvData.FindControl("txtSurveyDate"), TextBox)
        If oTextBox IsNot Nothing Then
            oTextBox.Text = ConvertDate(oTextBox.Text)
            'SetObjectValidation(oTextBox, False, "date", "[0-9/]")
            'oTextBox.Focus()
        End If
        fvData.UpdateItem(True)
        'Response.Write("<script type='text/javascript'>")
        'Response.Write("window.history.back(-2);")
        'Response.Write("</script>")
        'Dim objDB As New DBX
        'Try
        '    objDB.ExecSP("ACCOUNTRESURVEYUpdate", _
        '            objDB.MP("@LOCID", Data.SqlDbType.Int, hidLocID.Value, 10), _
        '            objDB.MP("@OBJID", Data.SqlDbType.BigInt, hidObjID.Value, 20), _
        '            objDB.MP("@RESURVEYDATE", Data.SqlDbType.DateTime, ConvertDate(txtSurveyDate.Text), 20), _
        '            objDB.MP("@RESURVEYVALUE", Data.SqlDbType.Money, Replace(txtSurveyValue.Text, ",", ""), 20), _
        '            objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value, 20) _
        '            )
        '    lblMessage.Visible = True
        '    lblMessage.Text = "SAVE RE-SURVEY ENTRY SUCCESSFULLY...!"
        '    Response.Write("<script type='text/javascript'>")
        '    Response.Write("window.history.back(-2);")
        '    Response.Write("</script>")
        'Catch ex As Exception
        '    lblMessage.Visible = True
        '    lblMessage.Text = "ERROR SAVE RE-SURVEY ENTRY: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        'Finally
        '    objDB.Close()
        '    objDB = Nothing

        'End Try
    End Sub

    Protected Sub fvData_ItemCreated(sender As Object, e As System.EventArgs) Handles fvData.ItemCreated
        Dim oTextBox As TextBox
        oTextBox = CType(fvData.FindControl("txtSurveyDate"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "date", "[0-9/]")
            oTextBox.Focus()
        End If
        oTextBox = CType(fvData.FindControl("txtSurveyValue"), TextBox)
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "float", "[0-9]")
        End If

    End Sub

    Protected Sub sdsAppID_Updating(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles sdsAppID.Updating
        'CultureInfo.CreateSpecificCulture(languageId)
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As System.EventArgs) Handles btnCancel.Click
        'Response.Redirect("../Account/AccEditList.aspx?Action=Survey")
        Response.Redirect(prevPage)
    End Sub
End Class
