Imports System.Net
Imports System.IO
Imports System.Data
Imports System.Data.SqlClient
Partial Class FTPDoc_FTPAccountView
    Inherits System.Web.UI.Page
    'Private objDB As New DBX
    'Public strScript As String = ""
    'Private oSDRDOC As System.Data.SqlClient.SqlDataReader

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        'Dim sFolderName As String = ""
        Dim strFileNamePhysic As String = ""
        Dim objDB As New DBX
        Dim sFTPServer As String = "", sFTPFolder As String = "", sFTPUSerID As String = "", sFTPPassword As String = ""

        Try
            Dim oSDRDOC As System.Data.SqlClient.SqlDataReader
            lblMessage.Text = ""
            ' Response.Write(Request.QueryString("FILE").ToString)
            strFileNamePhysic = Request.QueryString("FILE")
            If Not IsPostBack() Then
                txtLocID.Value = Request.QueryString("LOCID")
                txtAppID.Value = Request.QueryString("APPID")
                hidAction.Value = Request.QueryString("Action")
                txtFileName.Value = Request.QueryString("FILE")

                oSDRDOC = objDB.CreateSDRFromSQLSelect("SELECT TOP 1 ACCOUNT.BRANCHID, CONVERT(VARCHAR(20), ACCOUNT.CREATEDATE,112) CREATEDATE, YEAR(ACCOUNT.CREATEDATE) CREATEYEAR FROM ACCOUNT WITH(NOLOCK) WHERE ACCOUNT.LOCID=" & txtLocID.Value & " AND ACCOUNT.APPID=" & txtAppID.Value)
                If oSDRDOC.Read() Then
                    hidBRANCHCODE.Value = oSDRDOC("BRANCHID").ToString()
                    hidCREATEDATE.Value = oSDRDOC("CREATEDATE")
                    hidCREATEYEAR.Value = oSDRDOC("CREATEYEAR")
                End If
                oSDRDOC.Close()
                oSDRDOC = Nothing

                oSDRDOC = objDB.CreateSDRFromSQLSelect("SELECT TOP 1 dbo.f_getAppSetting('UPLOADDIR') UPLOADDIR,  dbo.f_getAppSetting('UPLOADVIR') UPLOADVIR, " & _
                            "FTPSERVER, FTPFOLDER, FTPUSERID, FTPPASSWORD FROM FTPDOC WITH(NOLOCK) WHERE FTPCODE='DOC'")
                If oSDRDOC.Read() Then
                    sFTPServer = oSDRDOC("FTPSERVER")
                    sFTPFolder = oSDRDOC("FTPFOLDER")
                    sFTPUSerID = oSDRDOC("FTPUSERID")
                    sFTPPassword = RC4Engine.rc4(oSDRDOC("FTPPASSWORD"))
                End If
                oSDRDOC.Close()
                oSDRDOC = Nothing


                Try
                    If Len(Trim(strFileNamePhysic)) > 0 Then
                        'DownloadFile(txtFileName, lblMessage,
                        '             strFileNamePhysic, sFTPServer, sFTPFolder, sFTPUSerID, sFTPPassword)
                        ViewFile(txtFileName, sFTPServer, sFTPFolder, sFTPUSerID, sFTPPassword)
                    End If
                Catch ex As Exception
                    lblMessage.Visible = True
                    lblMessage.Text = "ERROR FTP VIEW FILE APPLICATION: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
                End Try
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR TRANSFER DOCUMENT FTP SERVER: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    'CARA LAMA.. DOWNLOAD DULU KE WEBSERVER DARI FTPSERVER, BARU DI VIEW
    Private Sub DownloadFile(ByVal oFileUpload As HiddenField, _
                         ByVal oLabelMessage As Label, _
                          ByRef SaveLocation As String, _
                         ByVal sFTPServer As String, _
                         ByVal sFTPFolder As String, _
                         ByVal sFTPUserID As String, _
                         ByVal sFTPPassword As String)
        Dim sFolderName As String = ""
        Dim objFTP As New FTP
        Dim objDB As New DBX
        Dim strDir As String = ""
        Dim strDay, strMonth, strYear, strDirDate As String
        Dim sReturnFTP As Byte()
        Dim dtAppDate As Date
        Dim strDescription As String = ""
        Dim sContentType As String = ""
        Dim sAddHeader As String = ""
        Try
            'sFolderName = txtLocID.Value & "_" & txtAppID.Value
            sFolderName = "APP/" & hidCREATEYEAR.Value & "/" & hidBRANCHCODE.Value & "/" & hidCREATEDATE.Value & "/" & txtLocID.Value & "_" & txtAppID.Value
            'Response.Write(sFolderName)
            'Response.End()
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("Select dbo.f_getAppDate() APPDate, dbo.f_getAppSetting('UPLOADDIR') UPLOADDIR")
            If oSDR.Read Then
                strDir = oSDR("UPLOADDIR")
                dtAppDate = oSDR("APPDATE")
                strDay = Right("00" & Day(oSDR("APPDATE")), 2)
                strMonth = Right("00" & Month(oSDR("APPDATE")), 2)
                strYear = Year(oSDR("APPDATE"))
                strDirDate = strYear & strMonth & strDay
                strDir = strDir & "\DOCUMENT" & strDirDate
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.CssClass = "ErrHighLight"
            lblMessage.Text = "ERROR LOADING DOWNLOAD : " & ex.Message
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        lblMessage.Visible = True
        If Len(Trim(oFileUpload.Value)) > 0 Then
            Dim fn As String = System.IO.Path.GetFileName(oFileUpload.Value)
            If Not Directory.Exists(strDir) Then
                Directory.CreateDirectory(strDir)
            End If
            SaveLocation = strDir & "\" & fn
            fn = Nothing
            Try
                sContentType = objFTP.FileSystemType(oFileUpload.Value)
                sAddHeader = objFTP.FileSystemHeader(oFileUpload.Value)
                Dim objFTPUpload As New FTP
                sReturnFTP = objFTPUpload.FTPDownload(sFTPServer & "/" & sFTPFolder, oFileUpload.Value,
                        SaveLocation, sFTPUserID, sFTPPassword, sFolderName, True, strDescription)
                objFTPUpload = Nothing

                If sReturnFTP IsNot Nothing Then
                    If hidAction.Value = "View" Then
                        Response.ContentType = "application/" & sContentType & ""
                        Response.AddHeader("Content-Disposition", "" & sAddHeader & " filename=" + oFileUpload.Value)
                        Response.BinaryWrite(sReturnFTP)
                        Response.End()
                    ElseIf hidAction.Value = "Download" Then
                        Response.ContentType = "application/" & sContentType & ""
                        Response.AddHeader("Content-Disposition", "attachment; filename=" + oFileUpload.Value)
                        Response.BinaryWrite(sReturnFTP)
                        Response.End()
                    End If
                Else
                    Response.Write("FILE TO DOWNLOAD IS 0 (ZERO) SIZE..!")
                    Response.End()
                End If

            Catch Exc As Exception
                lblMessage.CssClass = "ErrHighLight"
                lblMessage.Text = "ERROR DOWNLOAD FILE DOCUMENT " & Exc.Message
            Finally
                objFTP = Nothing
            End Try
        Else
            'Response.Write("Please select a file to upload.")
            lblMessage.CssClass = "ErrHighLight"
            lblMessage.Text = "PLEASE SELECT A DOCUMENT FILE TO DOWNLOAD."
        End If

    End Sub

    'CARA BARU, VIEW LANGSUNG DARI FTP SERVER
    Private Sub ViewFile(ByVal oFileUpload As HiddenField, _
                     ByVal sFTPServer As String, _
                     ByVal sFTPFolder As String, _
                     ByVal sFTPUserID As String, _
                     ByVal sFTPPassword As String)
        Dim sFolderName As String = ""
        Dim objFTP As New FTP
        Dim sReturnFTP As Byte()
        Dim sContentType As String = ""
        Dim sAddHeader As String = ""

        sFolderName = "APP/" & hidCREATEYEAR.Value & "/" & hidBRANCHCODE.Value & "/" & hidCREATEDATE.Value & "/" & txtLocID.Value & "_" & txtAppID.Value


        lblMessage.Visible = True
        If Len(Trim(oFileUpload.Value)) > 0 Then
            Try
                sContentType = objFTP.FileSystemType(oFileUpload.Value)
                sAddHeader = objFTP.FileSystemHeader(oFileUpload.Value)
                Dim objFTPUpload As New FTP
                sReturnFTP = objFTPUpload.FTPViewDirect(sFTPServer & "/" & sFTPFolder, oFileUpload.Value,
                        sFTPUserID, sFTPPassword, sFolderName, True)
                objFTPUpload = Nothing


                If sReturnFTP IsNot Nothing Then
                    If hidAction.Value = "View" Then

                        Response.OutputStream.Write(sReturnFTP, 0, sReturnFTP.Length)
                        Response.ContentType = "application/" & sContentType & ""
                        Response.End()
                    ElseIf hidAction.Value = "Download" Then
                        Response.AddHeader("Content-Disposition", "attachment; filename=" + oFileUpload.Value)
                        Response.BinaryWrite(sReturnFTP)
                        Response.End()
                    End If
                Else
                    Response.Write("FILE TO VIEW IS 0 (ZERO) SIZE..!")
                    Response.End()
                End If

            Catch Exc As Exception
                lblMessage.CssClass = "ErrHighLight"
                lblMessage.Text = "ERROR VIEW FILE DOCUMENT " & Exc.Message
            Finally
                objFTP = Nothing
            End Try
        Else
            lblMessage.Visible = True
            lblMessage.CssClass = "ErrHighLight"
            lblMessage.Text = "FILE TO VIEW NOT SPECIFIED...!"
        End If
    End Sub

End Class
