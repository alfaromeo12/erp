Imports System.Data.SqlClient

Partial Class FTPUser
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            Dim objDB As New DBX
            Try
                Dim oSDR As System.Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT FTPUSERNAME, FTPPASSWORD, dbo.f_getAppSetting('PSAKSERVER') AS PSAKSERVER, dbo.f_getAppSetting('PSAKSERVERDIR') AS PSAKSERVERDIR FROM APPUSER WHERE UID=" & Request.Cookies("UID").Value)
                If oSDR.Read() Then
                    txtUser.Text = oSDR("FTPUSERNAME").ToString()
                    txtPassword.Text = RC4Engine.rc4(oSDR("FTPPASSWORD").ToString())
                    hidPSAKSERVER.Value = oSDR("PSAKSERVER").ToString()
                    hidPSAKDIR.Value = oSDR("PSAKSERVERDIR").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing
            Catch ex As Exception
                lblMessage.Visible = True
                lblMessage.Text = "ERROR LOADING PSAK SERVER SETTING...!<BR>PLEASE CHECK DETAIL ERROR MESSAGE:<BR>" & ex.Message
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        End If
        txtUser.Focus()
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objDB As New DBX
        Try
            lblMessage.Text = ""
            lblMessage.Visible = False
            Dim oFTP As New FTP
            Try
                oFTP.ServerName = hidPSAKSERVER.Value
                oFTP.UserName = txtUser.Text
                oFTP.Password = txtPassword.Text
                oFTP.CurrentFtpPath = hidPSAKDIR.Value
                If oFTP.FTPConnected() Then
                    objDB.ExecSP("APPUSERFTPUpdate", _
                             objDB.MP("@UID", Data.SqlDbType.VarChar, Request.Cookies("UID").Value), _
                             objDB.MP("@FTPUSERNAME", Data.SqlDbType.VarChar, txtUser.Text, 100), _
                             objDB.MP("@FTPPASSWORD", Data.SqlDbType.VarChar, RC4Engine.rc4(txtPassword.Text), 100) _
                         )
                    lblMessage.Visible = True
                    lblMessage.Text = "FTP USER HAS BEEN SET SUCCEFULLY..!"
                Else
                    lblMessage.Visible = True
                    lblMessage.Text = lblMessage.Text & "CANNOT ACCESS SERVER FTP " & hidPSAKSERVER.Value & "<BR>PLEASE CHECK FTP SERVER SETTING..!"
                End If

            Catch ex As Exception
                lblMessage.Visible = True
                lblMessage.Text = "ERROR SAVE PSAK FTP SETTING...!<BR>PLEASE CHECK DETAIL ERROR MESSAGE:<BR>" & ex.Message
            Finally
                oFTP = Nothing
            End Try
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

        'Dim objDB As New DBX
        'Try
        '    Dim oSDR As SqlDataReader
        '    'oSDR = objDB.CreateSDRFromSQLSelect("SELECT UserID from APPUser Where UID='" & Request.Cookies("UID").Value & "' and Password='" & oRC4.Encrypt(txtOldPassword.Text) & "'")
        '    oSDR = objDB.CreateSDRFromSQLSelect("SELECT UserID from APPUser Where UID='" & Request.Cookies("UID").Value & "' and Password='" & RC4Engine.rc4(txtOldPassword.Text) & "'")
        '    If Not oSDR.Read Then
        '        lblMessage.Visible = True
        '        lblMessage.Text = "WARNING : Old Password does not match"
        '        txtOldPassword.Focus()
        '    Else
        '        If txtNewPassword.Text <> txtRetype.Text Then
        '            lblMessage.Visible = True
        '            lblMessage.Text = "WARNING : Retype password doest not match ! Try Again !"
        '            txtRetype.Focus()
        '        Else

        '            Dim strQueryHistPass As String = "SELECT Password FROM APPUserPass WHERE (UID = " + Request.Cookies("UID").Value + ") AND (Password = '" + RC4Engine.rc4(txtNewPassword.Text) + "') AND (PasswordDate between dateadd(yyyy, -1, dbo.f_getappdate()) and dateadd(day, 7, dbo.f_getAppDate()))"
        '            Dim cekHistReader As SqlDataReader = objDB.CreateSDRFromSQLSelect(strQueryHistPass)
        '            If cekHistReader.HasRows() Then
        '                lblMessage.Visible = True
        '                lblMessage.Text = "WARNING : New Password Has Been Used! Try another password...!!"
        '                txtNewPassword.Focus()
        '            Else
        '                objDB.ExecSQLWithParamNoTxn("Update APPUser Set Password=@Password, LastUpdate=getdate(), PasswordDate=getdate() Where UID=@UID", _
        '                    objDB.MP("@Password", Data.SqlDbType.VarChar, RC4Engine.rc4(txtNewPassword.Text)), _
        '                    objDB.MP("@UID", Data.SqlDbType.VarChar, Request.Cookies("UID").Value) _
        '                )

        '                objDB.ExecSQLWithParamNoTxn("INSERT APPUserPass(UID, Password, PasswordDate, LastUpdate) " & _
        '                            "VALUES(@UID, @Password, getdate(), getdate())", _
        '                    objDB.MP("@UID", Data.SqlDbType.VarChar, Request.Cookies("UID").Value), _
        '                    objDB.MP("@Password", Data.SqlDbType.VarChar, RC4Engine.rc4(txtOldPassword.Text)) _
        '                )
        '                lblMessage.Visible = True
        '                removeCookies()
        '                Dim strQuery As String = "DELETE FROM APPSessions WHERE (UID=@UID)"
        '                objDB.ExecSQLWithParamNoTxn(strQuery, _
        '                    objDB.MP("@UID", Data.SqlDbType.VarChar, Request.Cookies("UID").Value)
        '                    )
        '                btnSave.Visible = False
        '                btnLogin.Visible = True
        '                lblMessage.Text = "Password has changed...!<br>User must logout and Re-Login..!"

        '            End If
        '            cekHistReader.Close()
        '            cekHistReader = Nothing

        '        End If
        '    End If
        '    oSDR.Close()
        '    oSDR = Nothing
        'Catch ex As Exception
        '    lblMessage.Text = ex.Message
        'Finally
        '    objDB.Close()
        '    objDB = Nothing
        '    'oRC4 = Nothing
        'End Try

    End Sub

    Public Sub removeCookies()
        Dim strPath As String = Left(Request.ServerVariables("PATH_INFO"), InStr(2, Request.ServerVariables("PATH_INFO"), "/") - 1)

        Response.Cookies("UID").Path = strPath
        Response.Cookies("UID").Expires = DateTime.Now

        'Response.Cookies("BranchID").Path = strPath
        'Response.Cookies("BranchID").Expires = DateTime.Now

        Response.Cookies("AppDate").Path = strPath
        Response.Cookies("AppDate").Expires = DateTime.Now

        Response.Cookies("SessionID").Path = strPath
        Response.Cookies("SessionID").Expires = DateTime.Now

        Response.Cookies("UserID").Path = strPath
        Response.Cookies("UserID").Expires = DateTime.Now

        'Response.Cookies("ChangePass").Path = strPath
        'Response.Cookies("ChangePass").Expires = DateTime.Now
        Session("SessionID") = ""
        Session.Clear()
        Session.Abandon()

    End Sub

    'Protected Sub btnLogin_Click(sender As Object, e As System.EventArgs) Handles btnLogin.Click
    '    Response.Redirect("./login.aspx")
    'End Sub
End Class
