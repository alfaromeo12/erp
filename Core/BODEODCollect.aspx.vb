
Partial Class AppSetting_BODAP
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            hidTYPE.Value = Request.QueryString("TYPE")
            Dim objDB As New DBX
            Try
                Dim oSDR As System.Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppDate() AppDate")
                If oSDR.Read() Then
                    txtAppDate.Text = String.Format("{0:dd/MM/yyyy}", oSDR("AppDate"))
                End If
                oSDR.Close()
                oSDR = Nothing

            Catch ex As Exception

                lblMessage.Visible = True
                lblMessage.Text = "ERROR LOADING BOD COLLECTION..!<BR>Please check detail error message: " & ex.Message
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        End If
    End Sub

    Protected Sub btnProcess_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcess.Click
        lblMessage.Visible = True
        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer
            If hidTYPE.Value = "DESK" Then
                'REMAINDER DESK
                intRetVal = objDB.ExecSPReturnInteger("BODDESKCollector", _
                        objDB.MP("@COLLECTORACTIVITYID", Data.SqlDbType.Int, 1), _
                        objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value), _
                        objDB.MP("@COLLECTORTYPE", Data.SqlDbType.Int, 1))
                'PAST DUE ACTIVITY DESK
                intRetVal = objDB.ExecSPReturnInteger("BODDESKCollector", _
                        objDB.MP("@COLLECTORACTIVITYID", Data.SqlDbType.Int, 2), _
                        objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value), _
                        objDB.MP("@COLLECTORTYPE", Data.SqlDbType.Int, 1))
                lblMessage.Text = "PROCESS BEGINING OF DAY DESK COLLECTOR COMPLETED...!"
            ElseIf hidTYPE.Value = "FIELD" Then
                intRetVal = objDB.ExecSPReturnInteger("BODFIELDCollector", _
                        objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value), _
                        objDB.MP("@COLLECTORIDMove", Data.SqlDbType.VarChar, ""), _
                        objDB.MP("@COLLECTORACTIVITYID", Data.SqlDbType.Int, 6))
                intRetVal = objDB.ExecSPReturnInteger("BODFIELDCollector", _
                        objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value), _
                        objDB.MP("@COLLECTORIDMove", Data.SqlDbType.VarChar, ""), _
                        objDB.MP("@COLLECTORACTIVITYID", Data.SqlDbType.Int, 9))
                lblMessage.Text = "PROCESS BEGINING OF DAY FIELD COLLECTOR COMPLETED...!"
            ElseIf hidTYPE.Value = "EOD" Then
                intRetVal = objDB.ExecSPReturnInteger("EODCollect", _
                        objDB.MP("@TXNDATE", Data.SqlDbType.DateTime, ConvertDate(txtAppDate.Text)), _
                        objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value))
                lblMessage.Text = "PROCESS END OF DAY COLLECTION COMPLETED...!"
            ElseIf hidTYPE.Value = "WARN" Then
                intRetVal = objDB.ExecSPReturnInteger("BODWarningLetter", _
                        objDB.MP("@TXNDATE", Data.SqlDbType.DateTime, ConvertDate(txtAppDate.Text)), _
                        objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value))
                lblMessage.Text = "PROCESS BEGINING OF DAY WARNING LETTER COMPLETED...!"
                Dim oSDR As System.Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT CODE FROM PARAMGLOBAL WHERE TYPE='WARNTYPE'")
                While oSDR.Read()
                    LiteralWarn.Text = LiteralWarn.Text + "<input type='button' value='Print Warn " & oSDR("CODE") & "' onclick='return PrintWarn(" & oSDR("CODE") & ") ' />"
                End While
                oSDR.Close()
                oSDR = Nothing
            End If

            btnProcess.Visible = False
        Catch ex As Exception
            lblMessage.Text = "ERROR BOD/EOD COLLECTION...!<br>PLEASE CHECK DETAIL ERROR MESSAGE : " & ex.Message
            lblMessage.Focus()
            'Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        'lblComplete.Visible = True
        btnProcess.Visible = False
    End Sub

    Private Sub CreateButton(ByVal oButton As Button, _
        ByVal strID As String, _
        ByVal strText As String)
        oButton.ID = strID
        oButton.Text = strText
        oButton.CausesValidation = False
    End Sub

End Class
