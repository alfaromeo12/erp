
Partial Class Account_AccForTnC
    Inherits System.Web.UI.Page


    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            Dim objDB As New DBX
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            Try

                oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE FROM APPSETTING WITH(NOLOCK) WHERE APPCODE='APPDATE'")
                If oSDR.Read Then
                    txtRequestDate.Text = oSDR("APPVALUE").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing
            Catch ex As Exception
                lblMessage.Visible = True
                lblMessage.Text = "ERROR LOADING Account for JF TNC..!<br>Please check detail error message :<br>" & ex.Message
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
            rbJFRate.Checked = True
        End If
        ddlJFRequestType.Attributes.Add("onchange", "JFRequestChange();")
    End Sub

    Protected Sub btnProcess_Click(sender As Object, e As System.EventArgs) Handles btnProcess.Click
        lblMessage.Visible = False
        Dim objDB As New DBX
        Try

            If ddlJFRequestType.SelectedValue.ToString() = "1" Then 'new account
                Dim strUserRate As String
                If rbCustRate.Checked Then
                    strUserRate = "2"
                Else
                    strUserRate = "1"
                End If
                objDB.ExecSP("JFREQUESTTNCProcess",
                    objDB.MP("@JFID", Data.SqlDbType.Int, ddlJF.SelectedValue),
                    objDB.MP("@JFTNCID", Data.SqlDbType.Int, ddlJFTNC.SelectedValue),
                    objDB.MP("@INSTALLMENTDAY", Data.SqlDbType.VarChar, txtInstallmentDay.Text),
                    objDB.MP("@JFTENOR", Data.SqlDbType.VarChar, txtTenor.Text),
                    objDB.MP("@JFLOANTYPE", Data.SqlDbType.VarChar, ddlLoanType.SelectedValue),
                    objDB.MP("@USERATE", Data.SqlDbType.VarChar, strUserRate),
                    objDB.MP("@JFREQUESTTYPE", Data.SqlDbType.Int, ddlJFRequestType.SelectedValue),
                    objDB.MP("@REQUESTDATE", Data.SqlDbType.DateTime, ConvertDate(txtRequestDate.Text)),
                    objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value)
                    )
            ElseIf ddlJFRequestType.SelectedValue.ToString() = "2" Then 'RESELL
                objDB.ExecSP("JFREQUESTTNCProcess",
                    objDB.MP("@JFID", Data.SqlDbType.Int, ddlJF.SelectedValue),
                    objDB.MP("@JFTNCID", Data.SqlDbType.Int, ddlJFTNC.SelectedValue),
                    objDB.MP("@INSTALLMENTDAY", Data.SqlDbType.VarChar, txtInstallmentDay.Text),
                    objDB.MP("@JFTENOR", Data.SqlDbType.VarChar, ""),
                    objDB.MP("@JFLOANTYPE", Data.SqlDbType.VarChar, "0"),
                    objDB.MP("@USERATE", Data.SqlDbType.VarChar, "1"),
                    objDB.MP("@JFREQUESTTYPE", Data.SqlDbType.Int, ddlJFRequestType.SelectedValue),
                    objDB.MP("@REQUESTDATE", Data.SqlDbType.DateTime, ConvertDate(txtRequestDate.Text)),
                    objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value)
                    )
            End If
            lblMessage.Visible = True
            lblMessage.Text = "PROCESS Completed..!<br>Please Check in Account for JF - Approval menu."
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR Process JF TNC..!<br>Please check detail error message :<br>" & ex.Message
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub
End Class
