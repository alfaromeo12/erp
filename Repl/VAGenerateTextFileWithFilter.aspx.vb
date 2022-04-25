
Partial Class Repl_GenerateTextFileATMWithFilter
    Inherits System.Web.UI.Page
    Private sFTPCode As String, sFTPServer As String = "", sFTPFolder As String = "", sFTPUSerID As String = "", sFTPPassword As String
    Private strFileName As String = ""
    Public Shared sPathFile As String = ""

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            txtDPD.Text = 20
            txtOverDue.Text = String.Format("{0:N}", 100000)
        End If
        SetObjectValidation(txtOverDue, False, "float", "[0-9.,]")
        SetObjectValidation(txtDPD, False, "integer", "[0-9]")
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnProcess_Click(sender As Object, e As System.EventArgs) Handles btnProcess.Click
        Dim objDB As New DBX
        Try
            Dim strUserId As String = Request.Cookies("UID").Value
            Dim intFileType As String = "", strTextId As String = "", strTableName As String = "", strDateFormat As String = ""
            Dim strDescriptionTextFile As String = "", strFileName As String = "", strTableType As String = "", strBankName As String = ""
            Dim strDay As String = "", strMonth As String = "", strYear As String = "", strDirDate As String = ""
            Dim strToday As Date
            Dim strWhere As String
            Dim sReturnFTP As Integer
            Dim objFTP As New FTP
            Dim strDir As String = "D:\DLEAS\WEBSITE\UPLOAD", strVirDir As String = "../DLEAS/UPLOAD"
            Dim strTextFileName As String = "", strTextFileNameVir As String = "", strTextFileNamePhysic As String = ""
            Dim oSDRTextVA As System.Data.SqlClient.SqlDataReader
            lblMessage.Text = ""
            lblMessage.Visible = False
            oSDRTextVA = objDB.CreateSDRFromSQLSelect("SELECT BK.FileDesc, BK.FileName,BK.FileType,BK.Sort,TS.TextID,TS.UseDelimiter," & _
                                              " TS.TableType,TS.TableName,TS.ProgramType,TS.IdentityExist,TS.Description, " & _
                                              " TS.Delimiter,TS.DateFormat, dbo.f_getAppdate() AppDate, " & _
                                              " dbo.f_getAppSetting('UPLOADDIR') UPLOADDIR, " & _
                                              " dbo.f_getAppSetting('UPLOADVIR') UPLOADVIR,BA.BANKNAME " & _
                                              " FROM dbo.MOSTextSettingBank BK WITH(NOLOCK) INNER JOIN " & _
                                              " dbo.MOSTextSetting TS WITH(NOLOCK) ON BK.TextID=TS.TextID " & _
                                              " INNER JOIN BANK BA WITH(NOLOCK) ON BA.BANKID=BK.BANKID " & _
                                              " WHERE BK.BANKID='" & ddlBank.SelectedValue & "' ORDER BY BK.SORT")
            While oSDRTextVA.Read()
                If oSDRTextVA.HasRows() Then
                    strDescriptionTextFile = oSDRTextVA("FileDesc")
                    strFileName = oSDRTextVA("FileName")
                    intFileType = oSDRTextVA("FileType")
                    strTextId = oSDRTextVA("TextID")
                    strTableName = oSDRTextVA("TableName")
                    strTableType = oSDRTextVA("TableType")
                    strDateFormat = oSDRTextVA("DateFormat")
                    strToday = oSDRTextVA("AppDate")
                    strBankName = oSDRTextVA("BANKNAME")
                    intFileType = oSDRTextVA("FileType").ToString()
                    strDay = Right("00" & Day(strToday), 2)
                    strMonth = Right("00" & Month(strToday), 2)
                    strYear = Year(strToday)
                    strDirDate = strYear & strMonth & strDay
                    'physical directory
                    strDir = oSDRTextVA("UPLOADDIR").ToString() & "\" & "VA_" & ddlBank.SelectedValue & "_" & strDirDate
                    'virtual directory
                    strVirDir = oSDRTextVA("UPLOADVIR").ToString() & "VA_" & ddlBank.SelectedValue & "_" & strDirDate
                Else
                    'Response.Write("Text Setting Must be setup first for this Join finance : (" & strJFCode & ") " & strJFName)
                    lblMessage.Text = "Text Setting Must be setup first for this Virtual Account : ( " & ddlBank.SelectedItem.Text & " )"
                End If

                If strTextId = "ATMCSA" Then ' jika CSA
                    If CheckFTP("CSA") = False Then
                        Exit Sub
                    End If
                End If

                If intFileType = "1" Then
                    strTextFileName = strFileName & "_" & strDirDate & "_" & strBankName & ".txt"
                ElseIf CStr(intFileType) = "4" Or CStr(intFileType) = "5" Or CStr(intFileType) = "6" Then
                    strTextFileName = strTableName & ".dbf"
                End If
                strTextFileNameVir = strVirDir & "/" & strTextFileName
                strTextFileNamePhysic = strDir & "\" & strTextFileName
                If strTableType = "SP" Then ' JIKA MENGGUNAKAN STORE PROCEDURE
                    strWhere = NoComma(txtDPD.Text) & "," & NoComma(txtOverDue.Text)
                Else
                    strWhere = ""
                End If

                Dim objTextFile As New Repl
                'CREATE TEXT FILE BY VIEW/SP
                If CStr(intFileType) = "1" Then
                    objTextFile.CreateTextFile(strToday, strUserId, strDir, _
                      strTextFileName, strTextId, strWhere, "", True)
                    'CREATE DBASE FILE
                ElseIf CStr(intFileType) = "4" Or CStr(intFileType) = "5" Or CStr(intFileType) = "6" Then
                End If
                If strTextId = "ATMCSA" Then ' jika CSA
                    If CheckFTP("CSA") = False Then
                        Exit Sub
                    Else
                        Dim objFTPUpload As New FTP
                        sReturnFTP = objFTPUpload.FTPUpload(sFTPServer, strTextFileName,
                                                         strTextFileNamePhysic, sFTPUSerID, sFTPPassword, sFTPFolder, True, "")
                        If sReturnFTP = 0 Then
                            lblMessage.Text = "<p align='left'> <b> THE FILE HAS BEEN UPLOADED FTP :  " & sFTPFolder & "/" & strTextFileName & "</b>"
                            lblMessage.Visible = True
                        ElseIf sReturnFTP = -1 Then 'Path Address
                            lblMessage.CssClass = "ShowDetail"
                            lblMessage.Text = "INVALID PATH ADDRESS FTP FOLDER " & sFTPFolder & "<BR>CANNOT GET FILE DOCUMENT FTP SERVER"
                        ElseIf sReturnFTP = -2 Then 'upload file
                            lblMessage.CssClass = "ShowDetail"
                            lblMessage.Text = "INVALID FTP USER NAME OR PASSWORD<BR>CANNOT GET FILE DOCUMENT FTP SERVER"
                        ElseIf sReturnFTP = -3 Then 'cannot access server
                            lblMessage.CssClass = "ShowDetail"
                            lblMessage.Text = "CANNOT ACCESS DATA FOLDER TO FTP SERVER<BR>CANNOT GET FILE DOCUMENT FTP SERVER"
                        End If
                        objFTPUpload = Nothing
                    End If
                End If
                objTextFile = Nothing
                lblMessage.Visible = True
                lblMessage.Text = lblMessage.Text & "<p align='left' class='ShowDetail'><b>" & strDescriptionTextFile & "</p>"
                lblMessage.Text = lblMessage.Text & "<p align='left' ><a href='" & strTextFileNameVir & "'>" & strTextFileNameVir & "</p></a></b>"
            End While
            oSDRTextVA.Close()
            oSDRTextVA = Nothing
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR GENERATE TEXT FILE VIRTUAL ACCOUNT : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE..!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Private Function CheckFTP(ByVal CodeFTP As String) As Boolean
        Dim objFTP As New FTP
        Dim strDescription As String = ""
        Dim sFolderName As String = ""
        Dim strFileNamePhysic As String = ""
        Dim objDB As New DBX
        Dim oSDRDOC As System.Data.SqlClient.SqlDataReader
        Dim FTP As New FTP
        Try
            CheckFTP = False
            lblMessage.Text = ""
            oSDRDOC = objDB.CreateSDRFromSQLSelect("SELECT TOP 1 dbo.f_getAppSetting('UPLOADDIR') UPLOADDIR,  dbo.f_getAppSetting('UPLOADVIR') UPLOADVIR, " & _
                            "FTPSERVER, FTPFOLDER, FTPUSERID, FTPPASSWORD FROM FTPDOC WITH(NOLOCK) WHERE FTPCODE = '" & CodeFTP & "'")
            If oSDRDOC.Read() Then
                sFTPServer = oSDRDOC("FTPSERVER").ToString
                sFTPFolder = oSDRDOC("FTPFOLDER").ToString
                sFTPUSerID = oSDRDOC("FTPUSERID").ToString
                sFTPPassword = RC4Engine.rc4(oSDRDOC("FTPPASSWORD").ToString())
                Dim serverName As String = sFTPServer
                Dim userName As String = sFTPUSerID
                Dim password As String = sFTPPassword
                Dim FolderName As String = sFTPFolder
                FTP.ServerName = serverName
                FTP.UserName = userName
                FTP.Password = password
                FTP.CurrentFtpPath = FolderName
                If FTP.FTPConnected() Then
                    CheckFTP = True
                Else
                    CheckFTP = False
                    lblMessage.Visible = True
                    lblMessage.Text = lblMessage.Text & "CANNOT ACCESS SERVER FTP " & CodeFTP & "<BR>PLEASE CHECK FTP SERVER SETTING..!"
                End If
            End If
            oSDRDOC.Close()
            oSDRDOC = Nothing
        Catch ex As Exception
            CheckFTP = False
            lblMessage.Visible = True
            lblMessage.Text = "ERROR FTP MAKE DIRECTORY: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objFTP = Nothing
        End Try
    End Function

    Private Function NoComma(ByVal strValue As String) As String
        If Len(Trim(strValue)) <= 0 Then
            NoComma = "0"
        Else
            NoComma = Replace(strValue, ",", "")
        End If
    End Function
End Class
