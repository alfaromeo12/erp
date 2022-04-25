
Partial Class Teller_TellerBalanceUserLog
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            hidTellerID.Value = Request.QueryString("TELLERID")
            If Len(Trim(hidTellerID.Value)) <= 0 Then
                hidTellerID.Value = Request.Cookies("UID").Value
            End If
            Dim strAppDate As String = ""
            Dim objDB As New DBX
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            Try
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE FROM APPSETTING WITH(NOLOCK) WHERE APPCODE='APPDATE'")
                If oSDR.Read Then
                    strAppDate = oSDR("APPVALUE").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing
            Catch ex As Exception
                Throw
            Finally
                objDB.Close()
                objDB = Nothing
            End Try

            If Not IsPostBack Then
                rbTxnAll.Checked = True
                hidAppDate.Value = strAppDate
                txtTxnFrom.Text = strAppDate
                txtTxnTo.Text = strAppDate

                ''SetObjectValidation(txtSearch, True)
                SetObjectValidation(txtTxnFrom, True, "date", "[0-9/]")
                SetObjectValidation(txtTxnTo, True, "date", "[0-9/]")

            End If

        End If


    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
    End Sub


    Private Sub DataSearch()
        If rbTxnDate.Checked Then
            If Len(Trim(txtTxnFrom.Text)) > 0 And Len(Trim(txtTxnTo.Text)) > 0 Then
                Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND (TELLERBALANCELOG.APPDATE BETWEEN CONVERT(DATETIME, '" + txtTxnFrom.Text + "', 103) AND CONVERT(DATETIME, '" + txtTxnTo.Text + "', 103))"
            Else
                Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND (TELLERBALANCELOG.APPDATE BETWEEN CONVERT(DATETIME, '" + hidAppDate.Value + "', 103) AND CONVERT(DATETIME, '" + hidAppDate.Value + "', 103))"
            End If
        End If
        If Len(Trim(ddlBTSearch.SelectedValue)) > 0 Then
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND BOOKTYPE.BTID=" & ddlBTSearch.SelectedValue
        End If
        If Len(Trim(ddlTxnTypeSearch.SelectedValue)) > 0 Then
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND TELLERBALANCELOG.TXNTYPE=" & ddlTxnTypeSearch.SelectedValue
        End If
        If Len(Trim(ddlCurrency.SelectedValue)) > 0 Then
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND CURRENCY.CURRENCYID=" & ddlCurrency.SelectedValue
        End If
        If Len(Trim(ddlInOut.SelectedValue)) > 0 Then
            Me.sdsData.SelectCommand = Me.sdsData.SelectCommand & " AND TELLERBALANCELOG.INOUT=" & ddlInOut.SelectedValue
        End If
        gvData.DataBind()
    End Sub

    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub
End Class
