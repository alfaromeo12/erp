Imports Microsoft.VisualBasic
Imports System.Net
Imports System.IO
Imports System.Data
Imports System.Text
Imports System.Collections.Generic
Public Class FTP
    Public Function FTPUpload(ByVal strFTPServerName As String, _
                          ByVal strFTPFileName As String, _
                          ByVal strFileName As String, _
                          ByVal strUserName As String, _
                          ByVal strPassword As String, _
                          Optional ByVal strDirektory As String = "", _
                          Optional ByRef blnBinary As Boolean = False, _
                          Optional ByRef strDescription As String = "") As Integer
        'On Error Resume Next
        Dim myFtpWebRequest As FtpWebRequest
        Dim myFtpWebResponse As FtpWebResponse
        Dim myStreamWriter As StreamWriter
        Try

            If Len(Trim(strDirektory)) > 0 And strDirektory <> "." Then
                myFtpWebRequest = WebRequest.Create("ftp://" & strFTPServerName & "/" & strDirektory & "/" & strFTPFileName)
            Else
                myFtpWebRequest = WebRequest.Create("ftp://" & strFTPServerName & "/" & strFileName)
            End If
            

        Catch ex As Exception
            FTPUpload = -3 'cannot access server
            myStreamWriter = Nothing
            myFtpWebRequest = Nothing
            myFtpWebResponse = Nothing
            Exit Function
        End Try

        Try
            myFtpWebRequest.Credentials = New NetworkCredential(strUserName, strPassword)

        Catch ex As Exception
            FTPUpload = -1 'cannot connect
            myStreamWriter = Nothing
            myFtpWebRequest = Nothing
            myFtpWebResponse = Nothing
            Exit Function
        End Try
        Dim sFileURL As String = ""
     
        sFileURL = "ftp://" & strFTPServerName & "/" & strDirektory & "/" & strFTPFileName
        If CheckIfFtpFileExists(sFileURL, strUserName, strPassword) Then
            myFtpWebRequest.Method = WebRequestMethods.Ftp.DeleteFile
            myFtpWebRequest.UseBinary = blnBinary
            myFtpWebRequest.Method = WebRequestMethods.Ftp.UploadFile
            myFtpWebRequest.KeepAlive = False
            myFtpWebRequest.UseBinary = blnBinary
        Else
            myFtpWebRequest.Method = WebRequestMethods.Ftp.UploadFile
            myFtpWebRequest.KeepAlive = False
            myFtpWebRequest.UseBinary = blnBinary
        End If
        Try

            'Load the file
            Dim stream As FileStream = File.OpenRead(strFileName)
            Dim buffer As Byte() = New Byte(stream.Length - 1) {}

            stream.Read(buffer, 0, buffer.Length)
            stream.Close()
            stream.Dispose()

            'Upload file
            Dim reqStream As Stream = myFtpWebRequest.GetRequestStream()
            reqStream.Write(buffer, 0, buffer.Length)
            reqStream.Close()
            reqStream.Dispose()
            FTPUpload = 0
        Catch ex As Exception
            FTPUpload = -2 'failed upload
            'Exit Function
        Finally

            myStreamWriter = Nothing
            myFtpWebResponse = myFtpWebRequest.GetResponse()
            strDescription = myFtpWebResponse.StatusDescription
            myFtpWebResponse.Close()
            myFtpWebResponse = Nothing
            myFtpWebRequest = Nothing
        End Try
    End Function

    Public Function FTPUploadFromByte(ByVal strFTPServerName As String, _
        ByVal strFTPFileName As String, _
        ByVal strUserName As String, _
        ByVal strPassword As String, _
        ByVal buffer As Byte(), _
        Optional ByVal strFTPDirektory As String = "", _
        Optional ByRef blnBinary As Boolean = False, _
        Optional ByRef strDescription As String = "") As Integer

        'On Error Resume Next
        Dim myFtpWebRequest As FtpWebRequest
        Dim myFtpWebResponse As FtpWebResponse
        Dim myStreamWriter As StreamWriter
        Try

            If Len(Trim(strFTPDirektory)) > 0 And strFTPDirektory <> "." Then
                myFtpWebRequest = WebRequest.Create("ftp://" & strFTPServerName & "/" & strFTPDirektory & "/" & strFTPFileName)
            Else
                myFtpWebRequest = WebRequest.Create("ftp://" & strFTPServerName & "/" & strFTPFileName)
            End If


        Catch ex As Exception
            FTPUploadFromByte = -3 'cannot access server
            myStreamWriter = Nothing
            myFtpWebRequest = Nothing
            myFtpWebResponse = Nothing
            Exit Function
        End Try

        Try
            myFtpWebRequest.Credentials = New NetworkCredential(strUserName, strPassword)

        Catch ex As Exception
            FTPUploadFromByte = -1 'cannot connect
            myStreamWriter = Nothing
            myFtpWebRequest = Nothing
            myFtpWebResponse = Nothing
            Exit Function
        End Try
        Dim sFileURL As String = ""

        sFileURL = "ftp://" & strFTPServerName & "/" & strFTPDirektory & "/" & strFTPFileName
        If CheckIfFtpFileExists(sFileURL, strUserName, strPassword) Then
            myFtpWebRequest.Method = WebRequestMethods.Ftp.DeleteFile
            myFtpWebRequest.UseBinary = blnBinary
            myFtpWebRequest.Method = WebRequestMethods.Ftp.UploadFile
            myFtpWebRequest.KeepAlive = False
            myFtpWebRequest.UseBinary = blnBinary
        Else
            myFtpWebRequest.Method = WebRequestMethods.Ftp.UploadFile
            myFtpWebRequest.KeepAlive = False
            myFtpWebRequest.UseBinary = blnBinary
        End If
        Try

            'Load the file
            'Dim stream As FileStream = File.OpenRead(strFileName)
            'Dim buffer As Byte() = New Byte(stream.Length - 1) {}

            'stream.Read(buffer, 0, buffer.Length)
            'stream.Close()
            'stream.Dispose()

            'Upload file
            Dim reqStream As Stream = myFtpWebRequest.GetRequestStream()
            reqStream.Write(buffer, 0, buffer.Length)
            reqStream.Close()
            reqStream.Dispose()
            FTPUploadFromByte = 0
        Catch ex As Exception
            FTPUploadFromByte = -2 'failed upload
            'Exit Function
        Finally

            myStreamWriter = Nothing
            myFtpWebResponse = myFtpWebRequest.GetResponse()
            strDescription = myFtpWebResponse.StatusDescription
            myFtpWebResponse.Close()
            myFtpWebResponse = Nothing
            myFtpWebRequest = Nothing
        End Try
    End Function


    Public Function FTPDownload(ByVal strFTPServerName As String, _
                         ByVal strFTPFileName As String, _
                         ByVal strFileName As String, _
                         ByVal strUserName As String, _
                         ByVal strPassword As String, _
                         Optional ByVal strDirektory As String = "", _
                         Optional ByRef blnBinary As Boolean = False, _
                         Optional ByRef strDescription As String = "") As Byte()
        Dim retBytes As Byte() = Nothing
        Try

            Dim outputStream As New FileStream(strFileName, FileMode.Create)
            Dim request As FtpWebRequest = DirectCast(FtpWebRequest.Create("ftp://" + strFTPServerName + "/" + strDirektory + "/" + strFTPFileName), FtpWebRequest)

            Try
                request.Credentials = New NetworkCredential(strUserName, strPassword)
            Catch ex As Exception
                FTPDownload = Nothing 'cannot connect
                outputStream = Nothing
                request = Nothing
                Exit Function
            End Try
            request.Method = WebRequestMethods.Ftp.DownloadFile
            request.UsePassive = True
            request.KeepAlive = False
            request.UseBinary = blnBinary

            Dim response As FtpWebResponse = TryCast(request.GetResponse(), FtpWebResponse)
            Dim reader As Stream = response.GetResponseStream()
            'Download to memory
            'Note: adjust the streams here to download directly to the hard drive
            Dim memStream As New MemoryStream()
            Dim buffer As Byte() = New Byte(1023) {}
            While True
                Dim bytesRead As Integer = reader.Read(buffer, 0, buffer.Length)
                If bytesRead = 0 Then
                    Exit While
                Else
                    memStream.Write(buffer, 0, bytesRead)
                End If
            End While

            retBytes = memStream.ToArray()
            reader.Dispose()
            reader.Close()

            memStream.Dispose()
            memStream.Close()

            response.Close()

            outputStream.Dispose()
            outputStream.Close()
            'Catch
        Finally
        End Try
        Return retBytes
    End Function

    Public Function FTPViewDirect(ByVal strFTPServerName As String, _
                     ByVal strFTPFileName As String, _
                     ByVal strUserName As String, _
                     ByVal strPassword As String, _
                     Optional ByVal strDirektory As String = "", _
                     Optional ByRef blnBinary As Boolean = False) As Byte()
        Dim retBytes As Byte() = Nothing
        Try

            Dim request As FtpWebRequest = DirectCast(FtpWebRequest.Create("ftp://" + strFTPServerName + "/" + strDirektory + "/" + strFTPFileName), FtpWebRequest)

            Try
                request.Credentials = New NetworkCredential(strUserName, strPassword)
            Catch ex As Exception
                FTPViewDirect = Nothing 'cannot connect
                request = Nothing
                Exit Function
            End Try
            request.Method = WebRequestMethods.Ftp.DownloadFile
            request.UsePassive = True
            request.KeepAlive = False
            request.UseBinary = blnBinary

            Dim response As FtpWebResponse = TryCast(request.GetResponse(), FtpWebResponse)
            Dim reader As Stream = response.GetResponseStream()
            'Download to memory
            'Note: adjust the streams here to download directly to the hard drive
            Dim memStream As New MemoryStream()
            Dim buffer As Byte() = New Byte(1023) {}
            While True
                Dim bytesRead As Integer = reader.Read(buffer, 0, buffer.Length)
                If bytesRead = 0 Then
                    Exit While
                Else
                    memStream.Write(buffer, 0, bytesRead)
                End If
            End While

            retBytes = memStream.ToArray()
            reader.Dispose()
            reader.Close()

            memStream.Dispose()
            memStream.Close()

            response.Close()

            'Catch
        Finally
        End Try
        Return retBytes
    End Function

    Public Function FTPDelete(ByVal strFTPServerName As String, _
                         ByVal strFileName As String, _
                         ByVal strUserName As String, _
                         ByVal strPassword As String, _
                         Optional ByRef strDescription As String = "") As Integer

        On Error Resume Next

        Dim myFtpWebRequest As FtpWebRequest
        Dim myFtpWebResponse As FtpWebResponse
        'myFtpWebRequest = WebRequest.Create("ftp://ftp_server_name/filename.ext")
        myFtpWebRequest = WebRequest.Create("ftp://" & strFTPServerName & "/" & strFileName)
        If Err.Number <> 0 Then
            FTPDelete = -3 'cannot access server
            Exit Function
        End If
        'myFtpWebRequest.Credentials = New NetworkCredential("username", "password")
        myFtpWebRequest.Credentials = New NetworkCredential(strUserName, strPassword)
        If Err.Number <> 0 Then
            FTPDelete = -1 'cannot connect
            Exit Function
        End If
        myFtpWebRequest.Method = WebRequestMethods.Ftp.DeleteFile
        If Err.Number <> 0 Then
            FTPDelete = -2 'cannot delete download
            Exit Function
        End If
        myFtpWebResponse = myFtpWebRequest.GetResponse()
        'litResponse.Text = myFtpWebResponse.StatusDescription
        strDescription = myFtpWebResponse.StatusDescription
        myFtpWebResponse.Close()
        myFtpWebResponse = Nothing

        myFtpWebRequest = Nothing
        FTPDelete = 0
    End Function

    Public Function FTPGetList(ByVal strFTPServerName As String, _
                             ByVal strFTPFolder As String, _
                             ByVal strUserName As String, _
                             ByVal strPassword As String, _
                             ByVal strDirektory As String, _
                             ByVal oGridview As System.Web.UI.WebControls.GridView,
                             Optional ByRef blnBinary As Boolean = False, _
                             Optional ByRef strDescription As String = "") As String

        Dim myFtpWebRequest As FtpWebRequest
        Dim myFtpWebResponse As FtpWebResponse
        Dim myStreamWriter As StreamWriter
        Try
            If Len(Trim(strDirektory)) > 0 And strDirektory <> "." Then
                myFtpWebRequest = WebRequest.Create("ftp://" & strFTPServerName & "/" & strFTPFolder & "/" & strDirektory)
            Else
                myFtpWebRequest = WebRequest.Create("ftp://" & strFTPServerName & "/" & strDirektory)

                'FTPGetList = -1 'failed Path FTP
            End If

        Catch ex As Exception
            FTPGetList = -1 'failed Path FTP
            myStreamWriter = Nothing
            myFtpWebRequest = Nothing
            myFtpWebResponse = Nothing
            Exit Function
        End Try


        Try
            myFtpWebRequest.Credentials = New NetworkCredential(strUserName, strPassword)
        Catch ex As Exception
            FTPGetList = "-2" 'cannot connect
            myStreamWriter = Nothing
            myFtpWebRequest = Nothing
            myFtpWebResponse = Nothing
            Exit Function
            ' Throw
        End Try

        Try
            myFtpWebRequest.Method = WebRequestMethods.Ftp.ListDirectoryDetails
            Dim response As FtpWebResponse = CType(myFtpWebRequest.GetResponse(), FtpWebResponse)
            Dim responseStream As Stream = response.GetResponseStream()
            Dim reader As New StreamReader(responseStream)
            Dim lsdirectory As String = reader.ReadLine()
            Dim lsnames As New StringBuilder()
            Dim directories As String()
            While lsdirectory IsNot Nothing
                lsnames.Append(lsdirectory)
                lsnames.Append("@")
                lsdirectory = reader.ReadLine()
            End While
            If lsnames.Length > 0 Then
                lsnames.Remove(lsnames.ToString().LastIndexOf("@"), 1)
                directories = lsnames.ToString().Split("@")
                Dim files As New List(Of Files)()
                files = GetFiles(directories)

                oGridview.DataSource = files
                oGridview.DataBind()
            Else
                oGridview.DataSource = Nothing
                oGridview.DataBind()
            End If
            'GetFiles(directories)
           
            FTPGetList = 0

            reader.Close()
            reader.Dispose()
            reader = Nothing

            responseStream.Close()
            responseStream.Dispose()
            responseStream = Nothing

            response.Close()
            response = Nothing

        Catch ex As Exception
            FTPGetList = -3 'failed Get List Data
            Exit Function
            ' Throw
        Finally
            myStreamWriter = Nothing
            myFtpWebResponse = myFtpWebRequest.GetResponse()
            strDescription = myFtpWebResponse.StatusDescription
            myFtpWebResponse.Close()
        End Try
    End Function
    
    Public Function FTPMakeDirectoryUpload(ByVal strFTPServerName As String, _
                             ByVal strFTPFileName As String, _
                             ByVal strFileName As String, _
                             ByVal strUserName As String, _
                             ByVal strPassword As String, _
                             Optional ByVal strDirektory As String = "", _
                             Optional ByRef blnBinary As Boolean = False, _
                             Optional ByRef strDescription As String = "", _
                             Optional ByVal strSubDirektory As String = "") As Integer
        'On Error Resume Next
        Dim filesTemp As String = ""
        Dim myFtpWebRequest As FtpWebRequest
        Dim myFtpWebResponse As FtpWebResponse
        Dim myStreamWriter As StreamWriter
        Dim ftpStream As Stream = Nothing
        Dim arrDirectories As New ArrayList()
        Dim Files As String()
        Dim result As Boolean
        Try
            If strSubDirektory = "" Then
                myFtpWebRequest = WebRequest.Create("ftp://" & strFTPServerName & "/" & strFTPFileName & "/" & strDirektory)
            Else
                myFtpWebRequest = WebRequest.Create("ftp://" & strFTPServerName & "/" & strFTPFileName & "/" & strDirektory & "/" & strSubDirektory)
            End If

        Catch ex As Exception
            FTPMakeDirectoryUpload = -3 'cannot access server
            myStreamWriter = Nothing
            myFtpWebRequest = Nothing
            myFtpWebResponse = Nothing
            Exit Function
        End Try

        Try
            myFtpWebRequest.Credentials = New NetworkCredential(strUserName, strPassword)

        Catch ex As Exception
            FTPMakeDirectoryUpload = -1 'cannot connect
            myStreamWriter = Nothing
            myFtpWebRequest = Nothing
            myFtpWebResponse = Nothing
            Exit Function
            '   Throw
        End Try
        If strSubDirektory = "" Then
            Files = GetFileList("ftp://" & strFTPServerName & "/" & strFTPFileName & "/" & strDirektory, strUserName, strPassword)
        Else
            Files = GetFileList("ftp://" & strFTPServerName & "/" & strFTPFileName & "/" & strDirektory & "/" & strSubDirektory, strUserName, strPassword)
        End If

        Try
            If Files IsNot Nothing Then
                For Each dir As String In Files
                    arrDirectories.Add(dir)
                Next
            End If
            If strSubDirektory = "" Then
                result = FtpDirectoryExists("ftp://" & strFTPServerName & "/" & strFTPFileName & "/" & strDirektory & "/", strUserName, strPassword)
            Else
                result = FtpDirectoryExists("ftp://" & strFTPServerName & "/" & strFTPFileName & "/" & strDirektory & "/" & strSubDirektory & "/", strUserName, strPassword)
            End If

            If result = False And Files Is Nothing Then
                myFtpWebRequest.Method = WebRequestMethods.Ftp.MakeDirectory
                myFtpWebRequest.KeepAlive = False
                myFtpWebRequest.UseBinary = True
                myFtpWebRequest.UseBinary = blnBinary
                myFtpWebResponse = DirectCast(myFtpWebRequest.GetResponse(), FtpWebResponse)
                ftpStream = myFtpWebResponse.GetResponseStream()
                ftpStream.Close()
                myFtpWebResponse.Close()
            End If
            FTPMakeDirectoryUpload = 0
        Catch ex As Exception
            FTPMakeDirectoryUpload = -2 'failed upload
            ' Throw
            'Exit Function
        Finally

            If result = False And Files Is Nothing Then
                myStreamWriter = Nothing
                myFtpWebResponse = myFtpWebRequest.GetResponse()
                strDescription = myFtpWebResponse.StatusDescription
                myFtpWebResponse.Close()
            Else
                myStreamWriter = Nothing
            End If

        End Try
    End Function

    Public Function GetFileList(directoryPath As String, ftpUser As String, ftpPassword As String) As String()
        Dim downloadFiles As String()
        Dim result As New StringBuilder()
        Dim response As WebResponse = Nothing
        Dim reader As StreamReader = Nothing
        Try
            Dim reqFTP As FtpWebRequest
            reqFTP = DirectCast(FtpWebRequest.Create(New Uri(directoryPath)), FtpWebRequest)
            reqFTP.UseBinary = True
            reqFTP.Credentials = New NetworkCredential(ftpUser, ftpPassword)
            reqFTP.Method = WebRequestMethods.Ftp.ListDirectory
            reqFTP.Proxy = Nothing
            reqFTP.KeepAlive = False
            reqFTP.UsePassive = False
            response = reqFTP.GetResponse()
            reader = New StreamReader(response.GetResponseStream())
            Dim line As String = reader.ReadLine()
            While line IsNot Nothing
                result.Append("\n")
                result.Append(line)
                line = reader.ReadLine()
            End While
            ' to remove the trailing '\n'
            result.Remove(result.ToString().LastIndexOf(ControlChars.Lf), 1)
            Return result.ToString().Split(ControlChars.Lf)
        Catch ex As Exception
            If reader IsNot Nothing Then
                reader.Close()
                reader = Nothing
            End If
            If response IsNot Nothing Then
                response.Close()
                response = Nothing
            End If
            result = Nothing
            downloadFiles = Nothing
            Return downloadFiles
        End Try
    End Function
    Public Function CheckIfFtpFileExists(ByVal fileUri As String, ftpUser As String, ftpPassword As String) As Boolean
        Dim request As FtpWebRequest = WebRequest.Create(fileUri)
        request.Credentials = New NetworkCredential(ftpUser, ftpPassword)
        request.Method = WebRequestMethods.Ftp.GetFileSize
        Try
            Dim response As FtpWebResponse = request.GetResponse()
            ' THE FILE EXISTS
        Catch ex As WebException
            Dim response As FtpWebResponse = ex.Response
            If FtpStatusCode.ActionNotTakenFileUnavailable = response.StatusCode Then
                ' THE FILE DOES NOT EXIST
                Return False
            End If
        Finally
            request = Nothing
        End Try
        Return True
    End Function
    Public Function FtpDirectoryExists(directoryPath As String, ftpUser As String, ftpPassword As String) As Boolean
        Dim IsExists As Boolean = True
        Dim myFtpWebRequest As FtpWebRequest
        Try
            myFtpWebRequest = WebRequest.Create(directoryPath)
            myFtpWebRequest.Credentials = New NetworkCredential(ftpUser, ftpPassword)
            myFtpWebRequest.Method = WebRequestMethods.Ftp.ListDirectory
            Dim response As FtpWebResponse = CType(myFtpWebRequest.GetResponse(), FtpWebResponse)

        Catch ex As WebException
            IsExists = False
        Finally
            myFtpWebRequest = Nothing
        End Try
        Return IsExists
       
    End Function
    
    Public Function FileSystemType(ByVal sNameFile As String) As String
        Dim extension = Path.GetExtension(sNameFile)

        If IsMatch(extension, ".txt") Then
            Return "txt"
        ElseIf IsMatch(extension, ".doc", ".docx") Then
            Return "docx"
        ElseIf IsMatch(extension, ".msg") Then
            Return "msg"
        ElseIf IsMatch(extension, ".rtf") Then
            Return "rtf"
        ElseIf IsMatch(extension, ".pdf") Then
            Return "pdf"
        ElseIf IsMatch(extension, ".xls", ".xlsx") Then
            Return "xlsx"
        ElseIf IsMatch(extension, ".zip") Then
            Return "zip"
        ElseIf IsMatch(extension, ".rar") Then
            Return "rar"
        ElseIf IsMatch(extension, ".ppt", ".pptx") Then
            Return "ppt"
        ElseIf IsMatch(extension, ".pps") Then
            Return "pps"
        ElseIf IsMatch(extension, ".xml") Then
            Return "xml"
        ElseIf IsMatch(extension, ".csv") Then
            Return "csv"
        ElseIf IsMatch(extension, ".dat") Then
            Return "dat"
        ElseIf IsMatch(extension, ".jpg", ".jpeg") Then
            Return "jpg"
        ElseIf IsMatch(extension, ".gif") Then
            Return "gif"
        ElseIf IsMatch(extension, ".png") Then
            Return "png"
        ElseIf IsMatch(extension, ".tif") Then
            Return "tif"
        ElseIf IsMatch(extension, ".bmp") Then
            Return "bmp"
        ElseIf IsMatch(extension, ".psd") Then
            Return "psd"
        ElseIf IsMatch(extension, ".exe") Then
            Return "exe"
        ElseIf IsMatch(extension, ".7z") Then
            Return "7z"
        Else
            Return "octet-stream"
        End If
    End Function
    Public Function FileSystemHeader(ByVal sNameFile As String) As String
        Dim extension = Path.GetExtension(sNameFile)

        If IsMatch(extension, ".txt") Then
            Return "inline;;"
        ElseIf IsMatch(extension, ".doc", ".docx") Then
            Return "inline;;"
        ElseIf IsMatch(extension, ".msg") Then
            Return "inline;;"
        ElseIf IsMatch(extension, ".rtf") Then
            Return "inline;;"
        ElseIf IsMatch(extension, ".pdf") Then
            Return "inline;"
        ElseIf IsMatch(extension, ".xls", ".xlsx") Then
            Return "inline;"
        ElseIf IsMatch(extension, ".zip") Then
            Return "attachment;"
        ElseIf IsMatch(extension, ".rar") Then
            Return "attachment;"
        ElseIf IsMatch(extension, ".ppt", ".pptx") Then
            Return "inline;"
        ElseIf IsMatch(extension, ".pps") Then
            Return "inline;"
        ElseIf IsMatch(extension, ".xml") Then
            Return "inline;"
        ElseIf IsMatch(extension, ".csv") Then
            Return "inline;"
        ElseIf IsMatch(extension, ".dat") Then
            Return "attachment;"
        ElseIf IsMatch(extension, ".jpg", ".jpeg") Then
            Return "inline;"
        ElseIf IsMatch(extension, ".gif") Then
            Return "inline;"
        ElseIf IsMatch(extension, ".png") Then
            Return "inline;"
        ElseIf IsMatch(extension, ".tif") Then
            Return "inline;"
        ElseIf IsMatch(extension, ".bmp") Then
            Return "inline;"
        ElseIf IsMatch(extension, ".psd") Then
            Return "inline;"
        ElseIf IsMatch(extension, ".exe") Then
            Return "attachment;"
        ElseIf IsMatch(extension, ".exe") Then
            Return "attachment;"
        Else
            Return "attachment;"
        End If

    End Function

    Private Function IsMatch(ByVal extension As String, ByVal ParamArray extensionsToCheck As String()) As Boolean
        For Each str As String In extensionsToCheck
            If String.CompareOrdinal(extension, str) = 0 Then
                Return True
            End If
        Next

        'If we reach here, no match
        Return False
    End Function

    Public Function FTPConnected() As Boolean
        Dim success As Boolean = False
        Dim request As FtpWebRequest = Nothing
        Dim response As FtpWebResponse = Nothing
        Dim reader As StreamReader = Nothing
        Try
            ' Get the object used to communicate with the server.
            If Not ServerName.Contains("ftp://") Then
                ServerName = "ftp://" + ServerName + "/" + CurrentFtpPath + "/"
            End If
            request = DirectCast(WebRequest.Create(ServerName), FtpWebRequest)
            request.Method = WebRequestMethods.Ftp.ListDirectory
            request.UsePassive = True
            request.UseBinary = True
            request.KeepAlive = False

            request.Credentials = New NetworkCredential(UserName, Password)
            response = DirectCast(request.GetResponse(), FtpWebResponse)

            Dim responseStream As Stream = response.GetResponseStream()
            reader = New StreamReader(responseStream)
            success = True
            reader.Close()
            response.Close()
        Catch
            If reader IsNot Nothing Then
                reader.Close()
            End If
            If response IsNot Nothing Then
                response.Close()
            End If
            success = False
        End Try
        Return success
    End Function
  
    Public Property ServerName() As String
        Get
            Return m_ServerName
        End Get
        Set(value As String)
            m_ServerName = value
        End Set
    End Property
    Private m_ServerName As String

    Public Property UserName() As String
        Get
            Return m_UserName
        End Get
        Set(value As String)
            m_UserName = value
        End Set
    End Property
    Private m_UserName As String

    Public Property Password() As String
        Get
            Return m_Password
        End Get
        Set(value As String)
            m_Password = value
        End Set
    End Property
    Private m_Password As String

    Public Property LocatFilePath() As String
        Get
            Return m_LocatFilePath
        End Get
        Set(value As String)
            m_LocatFilePath = value
        End Set
    End Property
    Private m_LocatFilePath As String

    Public Property CurrentFtpPath() As String
        Get
            Return m_CurrentFtpPath
        End Get
        Set(value As String)
            m_CurrentFtpPath = value
        End Set
    End Property
    Private m_CurrentFtpPath As String

    Public Property FileName() As String
        Get
            Return m_FileName
        End Get
        Set(value As String)
            m_FileName = value
        End Set
    End Property
    Private m_FileName As String

    Public Function GetFiles(directoryDetails As String()) As List(Of Files)
        'Dim files As String() = directoryDetails.Where(Function(s) s.StartsWith("n")).ToArray()
        Dim files As String() = directoryDetails.ToArray()
        Return (From file In files Let fileName = file.Substring(39) Let fileSize = LTrim(RTrim(file.Substring(23, 15))) Let midifyDate = LTrim(RTrim(file.Substring(0, 20))) Select New Files() With { _
         .FileName = fileName, _
         .LastModifiedDate = FormatDate(midifyDate),
         .Size = DisplaySize(fileSize) _
        }).ToList()
    End Function

    Protected Function FormatDate(ByVal ModifiedDate As Date) As String
        Return String.Format("{0:dd/MM/yyyy hh:mm:ss}", ModifiedDate)
    End Function

    Protected Function DisplaySize(ByVal size As Nullable(Of Long)) As String
        If size Is Nothing Then
            Return String.Empty
        Else
            'If size < 1024 Then
            '    Return String.Format("{0:N}", size.Value)
            'Else
            '    Return String.Format("{0:N}", size.Value / 1024)
            'End If
            Return String.Format("{0:N}", size.Value / 1024)
        End If
    End Function
End Class

Public Class Files
    Public Property FileName() As String
        Get
            Return m_FileName
        End Get
        Set(value As String)
            m_FileName = Value
        End Set
    End Property
    Private m_FileName As String

    Public Property Size() As Int64
        Get
            Return m_Size
        End Get
        Set(value As Int64)
            m_Size = Value
        End Set
    End Property
    Private m_Size As Int64

    Public Property ModifiedDate() As DateTime
        Get
            Return m_ModifiedDate
        End Get
        Set(value As DateTime)
            m_ModifiedDate = Value
        End Set
    End Property
    Private m_ModifiedDate As DateTime

    Public Property LastModifiedDate() As String
        Get
            Return m_LastModifiedDate
        End Get
        Set(value As String)
            m_LastModifiedDate = Value
        End Set
    End Property
    Private m_LastModifiedDate As String

End Class