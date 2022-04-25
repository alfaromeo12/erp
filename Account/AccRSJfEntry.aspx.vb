
Partial Class Account_AccRSJfEntry
    Inherits System.Web.UI.Page
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        SetObjectValidation(txtEffRate, False, "float", "[0-9.]")
        If Not IsPostBack() Then
            hidRSType.Value = Request.QueryString("RSType")
            txtEffRate.Focus()
            txtAction.Value = Request.QueryString("Action")
            SetObjectValidation(txtNewTenor, False, "integer", "[0-9]")
            SetObjectValidation(txtNewPrincipal, False, "float", "[0-9.,]")
            SetObjectValidation(txtEffRate, False, "float", "[0-9.,]")
            Dim strLocID As String = "", strAccID As String = ""
            'ajaxCPELoanData.Collapsed = True
            Dim objDB As New DBX
            Try
                Dim oSDR As Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppDate() APPDATE ")
                If oSDR.Read() Then
                    hidTxnDate.Value = oSDR("APPDATE").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing



                oSDR = objDB.CreateSDRFromSQLSelect("SELECT ACCOUNTJF.LOCID, ACCOUNTJF.ACCID, ACCOUNTJF.ACCIDJF FROM ACCOUNTJF WITH(NOLOCK) WHERE ACCOUNTJF.ACCIDJF=" & Request.QueryString("ACCIDJF"))
                If oSDR.Read() Then
                    strLocID = oSDR("LOCID")
                    strAccID = oSDR("ACCID")
                    hidLocID.Value = strLocID
                    hidAccID.Value = strAccID
                    hidAccIDJF.Value = oSDR("ACCIDJF")
                    'sdsInstallment.SelectParameters("LOCID").DefaultValue = strLocID
                    'sdsInstallment.SelectParameters("ACCID").DefaultValue = strAccID
                    ctlAccountJFbyACCIDJF.ACCIDJF = hidAccIDJF.Value

                    ctlDataAccountFromParamAccIDOS.LOCID = strLocID
                    ctlDataAccountFromParamAccIDOS.ACCID = strAccID

                    ctlJFInstallmentDataAll.ACCIDJF = hidAccIDJF.Value
                    ctlJFInstallmentDataAll.TXNDATE = hidTxnDate.Value


                End If

                oSDR.Close()
                oSDR = Nothing

                If hidRSType.Value = "2" Then
                    pnlTenor.Visible = True
                    txtNewTenor.Focus()
                ElseIf hidRSType.Value = "3" Then
                    pnlPrincipal.Visible = True
                    txtNewPrincipal.Focus()
                Else
                    pnlEffRate.Visible = True
                    txtEffRate.Focus()
                End If
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
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            If hidRSType.Value = "2" Then
                oSQLParam = objDB.ExecSPReturnParam("RESCHEDULEJFTenorAdd", _
                        objDB.MP("@ACCIDJF", Data.SqlDbType.BigInt, hidAccIDJF.Value), _
                        objDB.MP("@NEWTENOR", Data.SqlDbType.Int, Replace(txtNewTenor.Text, ",", "")), _
                        objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 20, Data.ParameterDirection.InputOutput), _
                        objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value) _
                        )
                intRetVal = oSQLParam("@RETVAL").Value
            ElseIf hidRSType.Value = "3" Then
                oSQLParam = objDB.ExecSPReturnParam("RESCHEDULEJFPrincipalAdd", _
                        objDB.MP("@ACCIDJF", Data.SqlDbType.BigInt, hidAccIDJF.Value), _
                        objDB.MP("@NEWPRINCIPAL", Data.SqlDbType.Money, Replace(txtNewPrincipal.Text, ",", "")), _
                        objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 20, Data.ParameterDirection.InputOutput), _
                        objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value) _
                        )
                intRetVal = oSQLParam("@RETVAL").Value
            Else
                oSQLParam = objDB.ExecSPReturnParam("RESCHEDULEJFAdd", _
                        objDB.MP("@ACCIDJF", Data.SqlDbType.BigInt, hidAccIDJF.Value), _
                        objDB.MP("@NEWEFFRATE", Data.SqlDbType.Float, Replace(txtEffRate.Text, ",", ""), 20, Data.ParameterDirection.Input), _
                        objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 20, Data.ParameterDirection.InputOutput), _
                        objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value) _
                        )
                intRetVal = oSQLParam("@RETVAL").Value


            End If
            'Response.Write("<script type='text/javascript'>")
            'Response.Write("window.history.back(-2);")
            'Response.Write("</script>")
            lblMessage.Visible = True
            If intRetVal = -1 Then
                lblMessage.Text = "MESSAGE : JF Reschedule data ALREADY EXIST..!<br>PLEASE CHECK ACCOUNT IN RESCHEDULE INQUIRY...!"
            ElseIf intRetVal = -2 Then
                lblMessage.Text = "MESSAGE : Please Input Non Zero Values..!<br>PLEASE CHECK INPUT VALUE...!"
            ElseIf intRetVal = -3 Then
                lblMessage.Text = "MESSAGE : ACCOUNT ALREADY CLOSED OR ACCOUNT NOT EXIST..! CANNOT BE JF RESCHEDULE..!<BR>PLEASE CHECK IN ACCOUNT INQUIRY..!"
            ElseIf intRetVal = -4 Then
                lblMessage.Text = "MESSAGE : Invalid New Tenor...!<BR>PLEASE CHECK ACCOUNT INSTALLMENT SCHEDULE IN ACCOUNT INQUIRY...!"
            ElseIf intRetVal = -5 Then
                lblMessage.Text = "MESSAGE : Invalid New Principal...!<BR>PLEASE CHECK ACCOUNT INSTALLMENT SCHEDULE IN ACCOUNT INQUIRY...!"
            Else
                lblMessage.Text = "MESSAGE : JF Reschedule data SAVED Completed..!<BR>CONTINUE TO RESCHEDULE APPROVAL...!"
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR JF RESCHEDULE SAVE : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
            'Throw
        Finally
            btnSave.Visible = False
            objDB.Close()
            objDB = Nothing

        End Try
    End Sub

End Class
