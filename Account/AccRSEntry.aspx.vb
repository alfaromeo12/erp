Partial Class Account_AccRSEntry
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
            SetObjectValidation(txtNewInstDay, False, "integer", "[0-9]")

            Dim strLocID As String = "", strAccID As String = ""
            'ajaxCPELoanData.Collapsed = True
            Dim objDB As New DBX
            Try
                Dim oSDR As Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT LOCID, ACCID, dbo.f_getAppDate() APPDATE FROM ACCOUNT WITH(NOLOCK) WHERE LOCID=" & Request.QueryString("LOCID") & " AND ACCID=" & Request.QueryString("ACCID"))
                If oSDR.Read() Then
                    strLocID = oSDR("LOCID")
                    strAccID = oSDR("ACCID")
                    hidLocID.Value = strLocID
                    hidAccID.Value = strAccID
                    hidTxnDate.Value = oSDR("APPDATE").ToString()

                    ctlDataAccountFromParamAccIDOS.LOCID = strLocID
                    ctlDataAccountFromParamAccIDOS.ACCID = strAccID

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
                '        txtEffRate.Text = String.Format("{0:N}", oSDR("PPAPValue"))
                '    Else
                '        txtEffRate.Text = "0"
                '    End If
                'End If
                'oSDR.Close()
                'oSDR = Nothing
                If hidRSType.Value = "2" Then
                    pnlTenor.Visible = True
                    txtNewTenor.Focus()
                ElseIf hidRSType.Value = "3" Then
                    pnlPrincipal.Visible = True
                    txtNewPrincipal.Focus()
                ElseIf hidRSType.Value = "4" Then
                    pnlInstDay.Visible = True
                    txtNewInstDay.Focus()
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
                oSQLParam = objDB.ExecSPReturnParam("RESCHEDULETenorAdd", _
                        objDB.MP("@LOCID", Data.SqlDbType.Int, hidLocID.Value), _
                        objDB.MP("@ACCID", Data.SqlDbType.BigInt, hidAccID.Value), _
                        objDB.MP("@NEWTENOR", Data.SqlDbType.Int, Replace(txtNewTenor.Text, ",", "")), _
                        objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 20, Data.ParameterDirection.InputOutput), _
                        objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value) _
                        )
                intRetVal = oSQLParam("@RETVAL").Value
            ElseIf hidRSType.Value = "3" Then
                oSQLParam = objDB.ExecSPReturnParam("RESCHEDULEPrincipalAdd", _
                        objDB.MP("@LOCID", Data.SqlDbType.Int, hidLocID.Value), _
                        objDB.MP("@ACCID", Data.SqlDbType.BigInt, hidAccID.Value), _
                        objDB.MP("@NEWPRINCIPAL", Data.SqlDbType.Money, Replace(txtNewPrincipal.Text, ",", "")), _
                        objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 20, Data.ParameterDirection.InputOutput), _
                        objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value) _
                        )
                intRetVal = oSQLParam("@RETVAL").Value
            ElseIf hidRSType.Value = "4" Then
                oSQLParam = objDB.ExecSPReturnParam("RESCHEDULEInstDayAdd", _
                        objDB.MP("@LOCID", Data.SqlDbType.Int, hidLocID.Value), _
                        objDB.MP("@ACCID", Data.SqlDbType.BigInt, hidAccID.Value), _
                        objDB.MP("@NEWINSTALLMENTDAY", Data.SqlDbType.Int, Replace(txtNewInstDay.Text, ",", "")), _
                        objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 20, Data.ParameterDirection.InputOutput), _
                        objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value) _
                        )
                intRetVal = oSQLParam("@RETVAL").Value
            Else
                oSQLParam = objDB.ExecSPReturnParam("RESCHEDULEAdd", _
                        objDB.MP("@LOCID", Data.SqlDbType.Int, hidLocID.Value), _
                        objDB.MP("@ACCID", Data.SqlDbType.BigInt, hidAccID.Value), _
                        objDB.MP("@NEWEFFRATE", Data.SqlDbType.Float, Replace(txtEffRate.Text, ",", "")), _
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
                lblMessage.Text = "MESSAGE : Previous Reschedule data ALREADY EXIST..! Previous Reschedule data must be approved or rejected first..!<br>PLEASE CHECK ACCOUNT IN RESCHEDULE INQUIRY...!"
            ElseIf intRetVal = -2 Then
                lblMessage.Text = "MESSAGE : Please Input Non Zero Values..! PLEASE CHECK INPUT VALUE...!"
            ElseIf intRetVal = -3 Then
                lblMessage.Text = "MESSAGE : ACCOUNT ALREADY CLOSED OR ACCOUNT NOT EXIST..! CANNOT BE RESCHEDULE..!<BR>PLEASE CHECK IN ACCOUNT INQUIRY..!"
            ElseIf intRetVal = -4 Then
                lblMessage.Text = "MESSAGE : Invalid New Tenor...! New Tenor must be greater than Period Due..!<BR>PLEASE CHECK ACCOUNT INSTALLMENT SCHEDULE IN ACCOUNT INQUIRY...!"
            ElseIf intRetVal = -5 Then
                lblMessage.Text = "MESSAGE : Invalid New Total Principal...! New Total Principal must be greater than Principal Due..!<BR>PLEASE CHECK ACCOUNT INSTALLMENT SCHEDULE IN ACCOUNT INQUIRY...!"
            ElseIf intRetVal = -6 Then
                lblMessage.Text = "MESSAGE : New Effective rate must different with Current Effective Rate Account"
            ElseIf intRetVal = -7 Then
                lblMessage.Text = "MESSAGE : New Tenor must different with Current Tenor Account"
            ElseIf intRetVal = -8 Then
                lblMessage.Text = "MESSAGE : New Principal must different with Current Principal Account"
            ElseIf intRetVal = -9 Then
                lblMessage.Text = "MESSAGE : New Installment Day must different with Current Instalment Day Account"
            ElseIf intRetVal = -10 Then
                lblMessage.Text = "MESSAGE : OS Principal Current is 0 (zero)..!Reschedule cannot be done..!"
            Else
                lblMessage.Text = "MESSAGE : Reschedule data SAVED Completed..!CONTINUE TO RESCHEDULE APPROVAL...!"
            End If
            lblMessage.Focus()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RESCHEDULE SAVE : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
            'Throw
        Finally
            btnSave.Visible = False
            objDB.Close()
            objDB = Nothing

        End Try
    End Sub


End Class
