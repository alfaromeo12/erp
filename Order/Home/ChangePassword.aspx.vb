Imports System.Data.SqlClient

Partial Class ChangePassword
    Inherits System.Web.UI.Page

    'Protected Sub txtOldPass_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtOldPass.TextChanged
    '    Dim oSDROldPass As SqlDataReader
    '    Dim objRC As New RC4.RC4Program
    '    Dim objDBX As New DBX
    '    Dim strUId As String = Request.Cookies.Item("UID").Value
    '    Dim strQuery As String = "SELECT Password FROM APPUser WHERE (UID = " + strUId + ") AND (Password = '" + objRC.Encrypt(txtOldPass.Text) + "')"

    '    Try
    '        oSDROldPass = objDBX.CreateSDRFromSQLSelect(strQuery)
    '        If oSDROldPass.HasRows Then
    '            lblStsOld.ForeColor = Drawing.Color.DarkGreen
    '            lblStsOld.Text = "Success!"
    '            txtOldPass.Enabled = False
    '            Panel1.Visible = True
    '        Else
    '            lblStsOld.ForeColor = Drawing.Color.DarkRed
    '            lblStsOld.Text = "Fail!"
    '            Panel1.Visible = False
    '        End If
    '    Catch ex As Exception
    '        Throw
    '    Finally
    '        objDBX.Close()
    '        objDBX = Nothing
    '        objRC = Nothing
    '    End Try

    'End Sub

    'Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
    '    Dim strUId As String = Request.Cookies.Item("UID").Value
    '    Dim strPath As String = Left(Request.ServerVariables("PATH_INFO"), InStr(2, Request.ServerVariables("PATH_INFO"), "/") - 1)
    '    Dim objRC As New RC4.RC4Program
    '    Dim objDBX As New DBX

    '    Try
    '        If txtNewPass.Text = txtConfPass.Text Then
    '            Dim strQueryHistPass As String = "SELECT Password FROM APPUserPass WHERE (UID = " + strUId + ") AND (Password = '" + objRC.Encrypt(txtConfPass.Text) + "')"
    '            Dim cekHistReader As SqlDataReader = objDBX.CreateSDRFromSQLSelect(strQueryHistPass)
    '            If cekHistReader.HasRows Then
    '                lblError.ForeColor = Drawing.Color.DarkRed
    '                lblError.Text = "New Password Has Been Used! Try Again!"
    '            Else
    '                Dim strQueryUpdatePass As String = "UPDATE APPUser SET Password = '" + objRC.Encrypt(txtConfPass.Text) + "', ValidForDays = 50, NeverExpires = 0 WHERE (UID = " + strUId + ")"
    '                objDBX.ExecSQLNoTxn(strQueryUpdatePass)
    '                Dim strQueryInsertPass As String = "INSERT INTO APPUserPass (UID, Password, PasswordDate, LastUpdate) VALUES (" + strUId + ", '" + objRC.Encrypt(txtConfPass.Text) + "', getdate(), getdate())"
    '                objDBX.ExecSQLNoTxn(strQueryInsertPass)

    '                Response.Cookies("ChangePass").Value = ""
    '                Response.Cookies("ChangePass").Path = strPath
    '                lblError.ForeColor = Drawing.Color.DarkGreen
    '                Response.Redirect("../Logout.aspx")
    '            End If
    '        Else
    '            lblError.ForeColor = Drawing.Color.DarkRed
    '            lblError.Text = "New Password didn't Match!"
    '        End If
    '    Catch ex As Exception
    '        Throw
    '    Finally
    '        objDBX.Close()
    '        objDBX = Nothing
    '        objRC = Nothing
    '    End Try

    'End Sub

    'Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    '    txtOldPass.Focus()
    '    If Not IsPostBack Then
    '        SetFormValidation(ChangePassForm)
    '        SetObjectValidation(txtNewPass, True)
    '        SetObjectValidation(txtConfPass, True)
    '    End If
    'End Sub


    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'If Not IsPostBack Then
        '    SetFormValidation(form1)
        '    SetObjectValidation(txtNewPassword, True, "nospace uppercase")
        '    SetObjectValidation(txtOldPassword, True, "nospace uppercase")
        '    SetObjectValidation(txtRetype, True, "nospace uppercase")

        'End If
        txtOldPassword.Focus()
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objDB As New DBX
        'Dim oRC4 As New RC4.RC4Program
        'Response.Write(RC4Engine.rc4(RC4Engine.rc4(txtNewPassword.Text)))
        'Response.End()
        Try
            Dim oSDR As SqlDataReader
            'oSDR = objDB.CreateSDRFromSQLSelect("SELECT UserID from APPUser Where UID='" & Request.Cookies("UID").Value & "' and Password='" & oRC4.Encrypt(txtOldPassword.Text) & "'")
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT UserID from APPUser Where UID='" & Request.Cookies("UID").Value & "' and Password='" & RC4Engine.rc4(txtOldPassword.Text) & "'")
            If Not oSDR.Read Then
                lblMessage.Visible = True
                lblMessage.Text = "WARNING : Old Password does not match"
                txtOldPassword.Focus()
            Else
                If txtNewPassword.Text <> txtRetype.Text Then
                    lblMessage.Visible = True
                    lblMessage.Text = "WARNING : Retype password doest not match ! Try Again !"
                    txtRetype.Focus()
                Else

                    Dim strQueryHistPass As String = "SELECT Password FROM APPUserPass WHERE (UID = " + Request.Cookies("UID").Value + ") AND (Password = '" + RC4Engine.rc4(txtNewPassword.Text) + "') AND (PasswordDate between dateadd(yyyy, -1, dbo.f_getappdate()) and dateadd(day, 7, dbo.f_getAppDate()))"
                    Dim cekHistReader As SqlDataReader = objDB.CreateSDRFromSQLSelect(strQueryHistPass)
                    If cekHistReader.HasRows() Then
                        lblMessage.Visible = True
                        lblMessage.Text = "WARNING : New Password Has Been Used! Try another password...!!"
                        txtNewPassword.Focus()
                    Else
                        'objDB.ExecSQLWithParamNoTxn("Update APPUser Set Password=@Password, LastUpdate=getdate(), PasswordDate=getdate() Where UID=@UID", _
                        '    objDB.MP("@Password", Data.SqlDbType.VarChar, oRC4.Encrypt(txtNewPassword.Text)), _
                        '    objDB.MP("@UID", Data.SqlDbType.VarChar, Request.Cookies("UID").Value) _
                        ')
                        objDB.ExecSQLWithParamNoTxn("Update APPUser Set Password=@Password, LastUpdate=getdate(), PasswordDate=getdate() Where UID=@UID", _
                            objDB.MP("@Password", Data.SqlDbType.VarChar, RC4Engine.rc4(txtNewPassword.Text)), _
                            objDB.MP("@UID", Data.SqlDbType.VarChar, Request.Cookies("UID").Value) _
                        )

                        'objDB.ExecSQLWithParamNoTxn("INSERT APPUserPass(UID, Password, PasswordDate, LastUpdate) " & _
                        '            "VALUES(@UID, @Password, getdate(), getdate())", _
                        '    objDB.MP("@UID", Data.SqlDbType.VarChar, Request.Cookies("UID").Value), _
                        '    objDB.MP("@Password", Data.SqlDbType.VarChar, oRC4.Encrypt(txtNewPassword.Text)) _
                        ')

                        objDB.ExecSQLWithParamNoTxn("INSERT APPUserPass(UID, Password, PasswordDate, LastUpdate) " & _
                                    "VALUES(@UID, @Password, getdate(), getdate())", _
                            objDB.MP("@UID", Data.SqlDbType.VarChar, Request.Cookies("UID").Value), _
                            objDB.MP("@Password", Data.SqlDbType.VarChar, RC4Engine.rc4(txtOldPassword.Text)) _
                        )
                        lblMessage.Visible = True
                        removeCookies()
                        Dim strQuery As String = "DELETE FROM APPSessions WHERE (UID=@UID)"
                        objDB.ExecSQLWithParamNoTxn(strQuery, _
                            objDB.MP("@UID", Data.SqlDbType.VarChar, Request.Cookies("UID").Value)
                            )
                        btnSave.Visible = False
                        btnLogin.Visible = True
                        lblMessage.Text = "Password has changed...!<br>User must logout and Re-Login..!"

                    End If
                    cekHistReader.Close()
                    cekHistReader = Nothing

                End If
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            lblMessage.Text = ex.Message
        Finally
            objDB.Close()
            objDB = Nothing
            'oRC4 = Nothing
        End Try

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

    Protected Sub btnLogin_Click(sender As Object, e As System.EventArgs) Handles btnLogin.Click
        Response.Redirect("./login.aspx")
    End Sub
End Class
