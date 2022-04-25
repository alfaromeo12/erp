Imports System.Data.SqlClient

Partial Class LoginX
    Inherits System.Web.UI.Page
    Public strCompany As String = ""
    Public strAppName As String = ""

    Protected Sub btnLogin_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLogin.Click
        'Response.End()
        Dim oSDRUser As SqlDataReader
        Dim oSDRLogin As SqlDataReader
        'Dim objRC As New RC4.RC4Program
        Dim objDBX As New DBX
        Dim objSession As New Sessions
        Dim strUserID, strPassword As String
        Dim strMenuStyle As String
        strUserID = Replace(Replace(txtUser.Text, ";", ""), "'", "''")
        strUserID = Replace(Replace(strUserID, "-", ""), "'", "''")


        'strPassword = objRC.Encrypt(txtPass.Text)
        'Response.Write(txtPass.Text)
        'Response.End()

        strPassword = Replace(RC4Engine.rc4(txtPass.Text), "'", "''")
        Try
            Dim intUID As Integer = 0

            oSDRUser = objDBX.CreateSDRFromSQLSelect("SELECT dbo.f_getAppSetting('USRPWLIM') USRPWLIM, UID, UserID, Counter, Active " & _
                    " FROM APPUser WITH(NOLOCK) WHERE (UserID = '" + strUserID + "')")
            oSDRLogin = objDBX.CreateSDRFromSQLSelect("SELECT dbo.f_getAppSetting('USRTIMEOUT') TimeOut,  dbo.f_getAppDate()APPDate, UID, UserID, " & _
                " UserName, Password, Counter, Active, NeverExpires, ValidFordays, PasswordDate, LastLogin, MenuStyle " & _
                " FROM APPUser  WITH(NOLOCK) WHERE (UserID = '" + strUserID + "') AND (Password = '" + strPassword + "')")

            Dim strPath As String
            Dim shrUserStatus As Short
            Dim strSessionID As String = ""

            'strPath = Left(Request.ServerVariables("PATH_INFO"), InStr(2, Request.ServerVariables("PATH_INFO"), "/") - 1)

            Response.Expires = 0
            Response.Cookies("UID").Value = ""
            Response.Cookies("UID").Path = strPath


            Response.Cookies("AppDate").Value = ""
            Response.Cookies("AppDate").Path = strPath

            Response.Cookies("SessionID").Value = ""
            Response.Cookies("SessionID").Path = strPath
            Session("SessionID") = ""

            Response.Cookies("UserID").Value = ""
            Response.Cookies("UserID").Path = strPath

            Response.Cookies("ChangePass").Value = ""
            Response.Cookies("ChangePass").Path = strPath

            Response.Cookies("cMenuID").Value = ""
            Response.Cookies("cMenuID").Path = strPath

            If oSDRUser.HasRows Then
                If oSDRLogin.HasRows Then
                    While oSDRLogin.Read()
                        intUID = oSDRLogin("UID")
                        If oSDRLogin("Active") Then

                            strMenuStyle = oSDRLogin("MenuStyle").ToString()
                            Response.Cookies("UID").Path = strPath
                            Response.Cookies("UID").Value = intUID

                            Response.Cookies("UserID").Path = strPath
                            Response.Cookies("UserID").Value = oSDRLogin("UserID")

                            Response.Cookies("AppDate").Path = strPath
                            Response.Cookies("AppDate").Value = oSDRLogin("AppDate")
                            shrUserStatus = 0

                            'JIka baru login pertama kali atau password baru diubah admin
                            If String.IsNullOrEmpty(oSDRLogin("LastLogin").ToString()) Then
                                objDBX.ExecSQLNoTxn("UPDATE APPUser SET Counter=0, LastLogin = getdate(), lastUpdate=getdate() WHERE UID = " + intUID.ToString())
                                oSDRLogin.Close()
                                oSDRLogin = Nothing
                                oSDRUser.Close()
                                oSDRUser = Nothing

                                objDBX.Close()
                                objDBX = Nothing

                                shrUserStatus = 1
                                Response.Redirect("./Home/ChangePassword.aspx")

                            End If
                            'Jika password bisa expired
                            If Not oSDRLogin("NeverExpires") Then
                                'Response.Write(DateAdd(DateInterval.Day, oSDRLogin("ValidForDays"), oSDRLogin("PasswordDate")))
                                'Response.Write("<br>")
                                'Response.Write(oSDRLogin("AppDate"))
                                'Response.End()
                                If DateAdd(DateInterval.Day, oSDRLogin("ValidForDays"), oSDRLogin("PasswordDate")) < oSDRLogin("AppDate") Then
                                    'password sudah expired, harus ganti password
                                    objDBX.ExecSQLNoTxn("UPDATE APPUser SET Counter=0, LastLogin = getdate(), lastUpdate=getdate() WHERE UID = " + intUID.ToString())
                                    oSDRLogin.Close()
                                    oSDRLogin = Nothing
                                    oSDRUser.Close()
                                    oSDRUser = Nothing

                                    objDBX.Close()
                                    objDBX = Nothing

                                    shrUserStatus = 1
                                    Response.Redirect("./Home/ChangePassword.aspx")
                                End If
                            End If

                            If shrUserStatus = 0 Then
                                objSession.SessionNew(oSDRLogin("UID").ToString(), _
                                    oSDRLogin("TimeOut"), Request.ServerVariables("REMOTE_ADDR"), strSessionID)
                            End If
                            Response.Cookies("SessionID").Path = strPath
                            Response.Cookies("SessionID").Value = strSessionID
                            Session.Timeout = oSDRLogin("TimeOut")
                            Session("SessionID") = strSessionID

                            objDBX.ExecSQLNoTxn("UPDATE APPUser SET Counter=0, LastLogin = getdate(), lastUpdate=getdate() WHERE UID = " + intUID.ToString())
                            If ddlTheme.SelectedValue <> "0" Then
                                objDBX.ExecSQLNoTxn("UPDATE APPUser SET Theme='" & ddlTheme.SelectedValue & "' WHERE UID = " + intUID.ToString())
                            End If
                            If ddlMenu.SelectedValue <> "0" Then
                                objDBX.ExecSQLNoTxn("UPDATE APPUser SET MenuStyle='" & ddlMenu.SelectedValue & "' WHERE UID = " + intUID.ToString())
                                strMenuStyle = ddlMenu.SelectedValue.ToString()
                            End If
                            oSDRLogin.Close()
                            oSDRLogin = Nothing
                            oSDRUser.Close()
                            oSDRUser = Nothing
                            objDBX.Close()
                            objDBX = Nothing

                            If strMenuStyle <> "3" Then
                                Response.Redirect("Default.aspx")
                            Else
                                Response.Redirect("DefaultDDM.aspx")
                            End If
                        Else
                            lblError.Visible = True
                            lblError.Text = "User is not active! Please contact Administrator...!"
                        End If
                    End While
                Else
                    If oSDRUser.Read() Then
                        intUID = oSDRUser("UID")
                        Dim intCounter As Integer = Convert.ToInt16(oSDRUser("Counter"))
                        'Response.Write(intCounter.ToString() & "<br>")
                        Dim intCounterNext As Short = intCounter + 1
                        If intCounterNext <= CInt(oSDRUser("USRPWLIM")) Then
                            lblError.Visible = True
                            lblError.Text = "Login failed : " & intCounterNext.ToString() & " time(s)/" & oSDRUser("USRPWLIM").ToString()
                            objDBX.ExecSQLNoTxn("UPDATE APPUser SET LastUpdate=getdate(), Counter = " + intCounterNext.ToString() + " WHERE UID = " + intUID.ToString())
                        Else
                            lblError.Visible = True
                            lblError.Text = "User is not active! Please contact Administrator...!"
                            objDBX.ExecSQLNoTxn("UPDATE APPUser SET LastUpdate=getdate(), Active = 0 WHERE UID = " + intUID.ToString())
                        End If
                    End If
                End If
            Else
                lblError.Visible = True
                lblError.Text = "Username does not exist or incorrect password !"
            End If
            oSDRLogin.Close()
            oSDRLogin = Nothing
            oSDRUser.Close()
            oSDRUser = Nothing
        Catch ex As Exception
            lblError.Visible = True
            lblError.Text = ex.Message.ToString()
            Throw
        Finally
            objSession = Nothing
            'objRC = Nothing
            If objDBX IsNot Nothing Then
                objDBX.Close()
            End If
            objDBX = Nothing
        End Try

    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'LoginForm.Attributes.Add("onsubmit", "return UserCheck();")
        ''btnLogin.Attributes.Add("onclick", "return UserCheck();")
        'If Not IsPostBack() Then
        '    SetFormValidation(LoginForm)
        '    SetObjectValidation(txtUser, False, "nospace uppercase")
        '    SetObjectValidation(txtPass, False, "nospace uppercase")
        'End If



        Dim strAction As String = Request.QueryString("Action")
        If strAction = "Login" Then
            Login()
        End If
        Dim objDB As New DBX
        Try
            SetFormValidation(LoginForm)
            SetObjectValidation(txtUser, False, "nospace uppercase")
            'SetObjectValidation(txtPass, True)
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("Select dbo.f_getAppSetting('COMPANY') Company, dbo.f_getAppSetting('APPNAME') AppName")
            If oSDR.Read() Then
                strCompany = oSDR("Company")
                strAppName = oSDR("AppName")
                Page.Title = "Welcome to " & strAppName
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

        txtUser.Focus()
        If Not IsPostBack() Then
            'SetFormValidation(LoginForm)
            'SetObjectValidation(txtUser, True, "uppercase")
            'SetObjectValidation(txtPass, True)
            CheckCLREnabled()
        End If
    End Sub

    Private Sub CheckCLREnabled()
        Dim objDB As New DBX
        Try
            Dim arrFields() As Data.SqlClient.SqlParameter
            ReDim arrFields(0)
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSP("GHWCLREnabled", objDB.MP("@ACT", Data.SqlDbType.Int, 1, 8))
            While oSDR.Read()
                'Response.Write(oSDR("name") & "<br>")
                If UCase(oSDR("name")) = "CLR ENABLED" Then
                    If oSDR("run_value").ToString = "0" Then
                        Dim objDBX As New DBX
                        objDBX.ExecSPNoTxn("GHWCLREnabled", objDB.MP("@ACT", Data.SqlDbType.Int, 0, 8))
                        objDBX.Close()
                        objDBX = Nothing
                    End If
                End If
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub Login()
        Dim oSDRUser, oSDRLogin As SqlDataReader
        'Dim objRC As New RC4.RC4Program
        Dim objDBX As New DBX
        Dim objSession As New Sessions
        Try
            Dim intUID As Integer = 0
            oSDRUser = objDBX.CreateSDRFromSQLSelect("SELECT dbo.f_getAppSetting('USRPWLIM') USRPWLIM, UID, UserID, Counter, Active " & _
                    " FROM APPUser  WITH(NOLOCK) WHERE (UserID = '" + txtUser.Text + "')")
            oSDRLogin = objDBX.CreateSDRFromSQLSelect("SELECT dbo.f_getAppSetting('USRTIMEOUT') TimeOut,  dbo.f_getAppDate()APPDate, UID, UserID, " & _
                " UserName, Password, Counter, Active, NeverExpires, ValidFordays, PasswordDate " & _
                " FROM APPUser  WITH(NOLOCK) WHERE (UserID = '" + txtUser.Text + "') AND (Password = '" + RC4Engine.rc4(txtPass.Text) + "')")

            Dim strPath As String
            Dim shrUserStatus As Short
            Dim strSessionID As String = ""

            strPath = Left(Request.ServerVariables("PATH_INFO"), InStr(2, Request.ServerVariables("PATH_INFO"), "/") - 1)

            Response.Expires = 0
            Response.Cookies("UID").Value = ""
            Response.Cookies("UID").Path = strPath


            Response.Cookies("AppDate").Value = ""
            Response.Cookies("AppDate").Path = strPath

            Response.Cookies("SessionID").Value = ""
            Response.Cookies("SessionID").Path = strPath

            Response.Cookies("UserID").Value = ""
            Response.Cookies("UserID").Path = strPath

            Response.Cookies("ChangePass").Value = ""
            Response.Cookies("ChangePass").Path = strPath

            Response.Cookies("cMenuID").Value = ""
            Response.Cookies("cMenuID").Path = strPath

            If oSDRUser.HasRows Then
                If oSDRLogin.HasRows Then
                    While oSDRLogin.Read()
                        intUID = oSDRLogin("UID")
                        If oSDRLogin("Active") Then

                            Response.Cookies("UID").Path = strPath
                            Response.Cookies("UID").Value = intUID

                            Response.Cookies("UserID").Path = strPath
                            Response.Cookies("UserID").Value = oSDRLogin("UserID")

                            Response.Cookies("AppDate").Path = strPath
                            Response.Cookies("AppDate").Value = oSDRLogin("AppDate")
                            shrUserStatus = 0
                            'Jika password bisa expired
                            If Not oSDRLogin("NeverExpires") Then
                                'Response.Write(DateAdd(DateInterval.Day, oSDRLogin("ValidForDays"), oSDRLogin("PasswordDate")))
                                'Response.Write("<br>")
                                'Response.Write(oSDRLogin("AppDate"))
                                'Response.End()
                                If DateAdd(DateInterval.Day, oSDRLogin("ValidForDays"), oSDRLogin("PasswordDate")) < oSDRLogin("AppDate") Then
                                    'password sudah expired, harus ganti password
                                    shrUserStatus = 1

                                    oSDRLogin.Close()
                                    oSDRLogin = Nothing
                                    oSDRUser.Close()
                                    oSDRUser = Nothing

                                    objDBX.Close()
                                    objDBX = Nothing


                                    Response.Redirect("./Home/ChangePassword.aspx")
                                End If
                            End If

                            If shrUserStatus = 0 Then
                                objSession.SessionNew(oSDRLogin("UID").ToString(), _
                                    oSDRLogin("TimeOut"), Request.ServerVariables("REMOTE_ADDR"), strSessionID)
                            End If
                            Response.Cookies("SessionID").Path = strPath
                            Response.Cookies("SessionID").Value = strSessionID

                            objDBX.ExecSQLNoTxn("UPDATE APPUser SET Counter=0, LastLogin = getdate(), lastUpdate=getdate() WHERE UID = " + intUID.ToString())
                            If ddlTheme.SelectedValue <> "0" Then
                                objDBX.ExecSQLNoTxn("UPDATE APPUser SET Theme='" & ddlTheme.SelectedValue & "' WHERE UID = " + intUID.ToString())
                            End If
                            If ddlMenu.SelectedValue <> "0" Then
                                objDBX.ExecSQLNoTxn("UPDATE APPUser SET MenuStyle='" & ddlMenu.SelectedValue & "' WHERE UID = " + intUID.ToString())
                            End If
                            oSDRLogin.Close()
                            oSDRLogin = Nothing
                            oSDRUser.Close()
                            oSDRUser = Nothing

                            objDBX.Close()
                            objDBX = Nothing

                            If ddlMenu.SelectedValue <> "3" Then
                                Response.Redirect("Default.aspx")
                            Else
                                Response.Redirect("DefaultDDM.aspx")
                            End If
                        Else
                            lblError.Visible = True
                            lblError.Text = "User is not active! Please contact Administrator...!"
                        End If
                    End While
                Else
                    If oSDRUser.Read() Then
                        intUID = oSDRUser("UID")
                        Dim intCounter As Integer = Convert.ToInt16(oSDRUser("Counter"))
                        'Response.Write(intCounter.ToString() & "<br>")
                        Dim intCounterNext As Short = intCounter + 1
                        If intCounterNext <= CInt(oSDRUser("USRPWLIM")) Then
                            lblError.Visible = True
                            lblError.Text = "Login failed : " & intCounterNext.ToString() & " time(s)/" & oSDRUser("USRPWLIM").ToString()
                            objDBX.ExecSQLNoTxn("UPDATE APPUser SET LastUpdate=getdate(), Counter = " + intCounterNext.ToString() + " WHERE UID = " + intUID.ToString())
                        Else
                            lblError.Visible = True
                            lblError.Text = "User is not active! Please contact Administrator...!"
                            objDBX.ExecSQLNoTxn("UPDATE APPUser SET LastUpdate=getdate(), Active = 0 WHERE UID = " + intUID.ToString())
                        End If
                    End If
                End If
            Else
                lblError.Visible = True
                lblError.Text = "Username does not exits or incorrect password !"
            End If
            oSDRLogin.Close()
            oSDRLogin = Nothing
            oSDRUser.Close()
            oSDRUser = Nothing

        Catch ex As Exception
            lblError.Visible = True
            lblError.Text = ex.Message.ToString()
            Throw
        Finally
            objSession = Nothing
            'objRC = Nothing
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Sub
End Class
