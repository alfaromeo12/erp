Imports System.IO
Imports ICSharpCode.SharpZipLib.Zip
Imports System
Imports System.Data
Imports System.Text
Partial Class Repl_UploaMandiri

    Inherits System.Web.UI.Page
    Public strScript As String = ""

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnUpload_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpload.Click
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim strDir As String = ""
        Dim strDay, strMonth, strYear, strDirDate As String
        Dim strTableName As String
        Dim dtAppDate As Date
        Try

            oSDR = objDB.CreateSDRFromSQLSelect("Select dbo.f_getAppDate() APPDate, dbo.f_getAppSetting('UPLOADDIR') UPLOADDIR")
            If oSDR.Read Then
                strDir = oSDR("UPLOADDIR")
                dtAppDate = oSDR("APPDATE")
                strDay = Right("00" & Day(oSDR("APPDATE")), 2)
                strMonth = Right("00" & Month(oSDR("APPDATE")), 2)
                strYear = Year(oSDR("APPDATE"))
                strDirDate = strYear & strMonth & strDay
                strDir = strDir & "\VAMANDIRI" & strDirDate
            End If
            oSDR.Close()
            oSDR = Nothing

        Catch ex As Exception
            lblMessage.Text = "Error : " & ex.Message
        Finally
            objDB.Close()
            objDB = Nothing
        End Try



        lblMessage.Visible = True
        If Not FileUploadRepl.PostedFile Is Nothing And FileUploadRepl.PostedFile.ContentLength > 0 Then
            Dim fn As String = System.IO.Path.GetFileName(FileUploadRepl.PostedFile.FileName)
            'Dim MyZip As FastZip
            If Not Directory.Exists(strDir) Then
                Directory.CreateDirectory(strDir)
            End If
            Dim objDBX As New DBX
            Dim SaveLocation As String = strDir & "\" & fn
            Try
                FileUploadRepl.PostedFile.SaveAs(SaveLocation)
                'Repl.UnZipFiles(SaveLocation, Replace(SaveLocation, ".zip", ""))
                'Dim NewLocation As String = Replace(SaveLocation, ".zip", "") + "\"
                'SaveLocation = Replace(SaveLocation, ".zip", "") + "\" + Replace(fn, ".zip", ".txt")

                strTableName = "VAMANDIRI_" & Request.Cookies("UID").Value

                Dim objRepl As New Repl
                'objRepl.ReplicateData(SaveLocation, dtAppDate, _
                ' Request.Cookies("UID").Value, strTableName)
                'MoveFile(strDir + "\", NewLocation, fn)
                objRepl.UploadCreateTable(strTableName)
                objRepl.UploadTextToDB(SaveLocation, strTableName)
                objDBX.ExecSP("VAMANDIRIAdd", _
                             objDBX.MP("@TableSource", SqlDbType.VarChar, strTableName), _
                             objDBX.MP("@USERID", SqlDbType.Int, Request.Cookies("UID").Value) _
                             )
                objRepl.UploadDropTable(strTableName)
                objRepl = Nothing

                lblMessage.Text = "The file " + FileUploadRepl.PostedFile.FileName + "  has been uploaded"
            Catch Exc As Exception
                'Response.Write("Error: " & Exc.Message)
                lblMessage.Text = "UPLOAD DATA VA MANDIRI Error: " & Exc.Message
                strScript = "<script type='text/javascript'>" & Chr(13)
                strScript = strScript & "ShowAlert();" & Chr(13)
                strScript = strScript & "</script>" & Chr(13)                'Throw
            Finally
                objDBX.Close()
                objDBX = Nothing
            End Try
        Else
            'Response.Write("Please select a file to upload.")
            lblMessage.Text = "Please select a file payment VA MANDIRI (Text File) to upload."
        End If


    End Sub

    'Public Sub MoveFile(ByVal sPathOld As String, ByVal sPathNew As String, ByVal sFileName As String)
    '    Dim dir1 As New DirectoryInfo(sPathNew)
    '    Dim dir2 As New DirectoryInfo(sPathOld)

    '    Dim Folder1Files As FileInfo() = dir1.GetFiles()
    '    If Folder1Files.Length > 0 Then
    '        For Each aFile As FileInfo In Folder1Files
    '            If File.Exists(sPathNew + aFile.Name) Then
    '                File.Delete(sPathOld + aFile.Name)
    '            End If
    '            aFile.MoveTo(sPathOld + aFile.Name)
    '        Next
    '    End If
    '    Directory.Delete(sPathNew)
    'End Sub
End Class
