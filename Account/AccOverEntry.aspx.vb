Partial Class Account_AccOverEntry
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'SetObjectValidation(txtCustName, False, "float", "[0-9.]")
        If Not IsPostBack() Then
            txtCustName.Focus()
            txtAction.Value = Request.QueryString("Action")
            'SetObjectValidation(txtNewTenor, False, "integer", "[0-9]")
            'SetObjectValidation(txtNewPrincipal, False, "float", "[0-9.,]")
            'SetObjectValidation(txtCustName, False, "float", "[0-9.,]")
            Dim strLocID As String = "", strAccID As String = ""
            'ajaxCPELoanData.Collapsed = True
            Dim objDB As New DBX
            Try
                Dim oSDR As Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT LOCID, ACCID,  dbo.f_getAppDate() APPDATE  FROM ACCOUNT WITH(NOLOCK) WHERE LOCID=" & Request.QueryString("LOCID") & " AND ACCID=" & Request.QueryString("ACCID"))
                If oSDR.Read() Then
                    strLocID = oSDR("LOCID")
                    strAccID = oSDR("ACCID")
                    hidTxnDate.Value = oSDR("APPDATE").ToString()

                    hidLocID.Value = strLocID
                    hidAccID.Value = strAccID

                    ctlDataAccountFromParamAccID.LOCID = strLocID
                    ctlDataAccountFromParamAccID.ACCID = strAccID

                    ctlLoanDataFromParamAccID.LOCID = strLocID
                    ctlLoanDataFromParamAccID.ACCID = strAccID

                    ctlCollectibilityParamAccID.LOCID = strLocID
                    ctlCollectibilityParamAccID.ACCID = strAccID

                    ctlInstallmentDataAll.LOCID = strLocID
                    ctlInstallmentDataAll.ACCID = strAccID

                End If

                oSDR.Close()
                oSDR = Nothing


                'oSDR = objDB.CreateSDRFromSQLSelect("SELECT PPAPValue " & _
                '    " FROM ACCOUNTDTL WITH(NOLOCK) " & _
                '    " WHERE ACCOUNTDTL.LOCID=" & strLocID & " AND ACCOUNTDTL.ACCID=" & strAccID)
                'If oSDR.Read() Then
                '    If Not String.IsNullOrEmpty(oSDR("PPAPValue").ToString()) Then
                '        txtCustName.Text = String.Format("{0:N}", oSDR("PPAPValue"))
                '    Else
                '        txtCustName.Text = "0"
                '    End If
                'End If
                'oSDR.Close()
                'oSDR = Nothing
            Catch ex As Exception
                lblMessage.Visible = True
                lblMessage.Text = "ERROR LOADING RESCHEDULE ENTRY: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objDB As New DBX
        Try
            lblMessage.Visible = True
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection

            oSQLParam = objDB.ExecSPReturnParam("OVERCREDITAdd", _
                    objDB.MP("@LOCID", Data.SqlDbType.Int, hidLocID.Value), _
                    objDB.MP("@ACCID", Data.SqlDbType.BigInt, hidAccID.Value), _
                    objDB.MP("@NEWLOCIDCUST", Data.SqlDbType.Int, hidLocIDCust.Value), _
                    objDB.MP("@NEWCUSTID", Data.SqlDbType.BigInt, hidCustID.Value), _
                    objDB.MP("@REMARK", Data.SqlDbType.VarChar, txtRemark.Text, 200), _
                    objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value), _
                    objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 20, Data.ParameterDirection.InputOutput) _
                    )
            intRetVal = oSQLParam("@RETVAL").Value

            If intRetVal = -1 Then
                lblMessage.Text = "MESSAGE : OVER CREDIT data ALREADY EXIST..!<br>PLEASE CHECK ACCOUNT IN OVER CREDIT INQUIRY...!"
            ElseIf intRetVal = -2 Then
                lblMessage.Text = "MESSAGE : ACCOUNT OVER CREDIT ALREADY CLOSED..!<br>PLEASE CHECK ACCOUNT IN ACCOUNT INQUIRY...!"
            ElseIf intRetVal = 0 Then
                Response.Redirect("AccOverList.aspx")
            End If

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR OVER CREDIT SAVE : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
            'Throw
        Finally
            btnSave.Visible = False
            objDB.Close()
            objDB = Nothing

        End Try
    End Sub

End Class
