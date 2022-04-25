Imports System.IO
Imports ICSharpCode.SharpZipLib.Zip
Imports System
Imports System.Data
Imports System.Text
Partial Class Repl_UploaOtherVA

    Inherits System.Web.UI.Page
    Public strScript As String = ""

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            hidBANK.Value = Request.QueryString("BANK")
        End If
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnUpload_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpload.Click
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim strDir As String = ""
        Dim strDay, strMonth, strYear, strDirDate As String
        Dim strTableName As String = ""
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
                strDir = strDir & "\VATEXT" & strDirDate
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
            Dim strTextID As String = ""
            Dim objDBX As New DBX
            Dim SaveLocation As String = strDir & "\" & fn
            Try
                FileUploadRepl.PostedFile.SaveAs(SaveLocation)
                'Repl.UnZipFiles(SaveLocation, Replace(SaveLocation, ".zip", ""))
                'Dim NewLocation As String = Replace(SaveLocation, ".zip", "") + "\"
                'SaveLocation = Replace(SaveLocation, ".zip", "") + "\" + Replace(fn, ".zip", ".txt")


                Dim objRepl As New Repl
                'objRepl.ReplicateData(SaveLocation, dtAppDate, _
                ' Request.Cookies("UID").Value, strTableName)
                If hidBANK.Value = "BCA" Then
                    strTextID = "VABCAPAY"
                    strTableName = "VABCAPAY_" & Request.Cookies("UID").Value
                ElseIf hidBANK.Value = "PMT" Then
                    strTextID = "VAPERMATAPAY"
                    strTableName = "VAPERMATAPAY_" & Request.Cookies("UID").Value
                ElseIf hidBANK.Value = "POS" Then
                    strTextID = "VAPOSPAY"
                    strTableName = "VAPOSPAY_" & Request.Cookies("UID").Value
                ElseIf hidBANK.Value = "CSA" Then
                    strTextID = "VACSAPAY"
                    strTableName = "VACSAPAY_" & Request.Cookies("UID").Value
                Else
                    lblMessage.Text = "THERE IS NO PROGRAM FOR THIS VIRTUAL ACCOUNT..!"
                End If
                If Len(Trim(strTextID)) > 0 Then
                    objRepl.ReplicateDataWithTextID(strTextID, SaveLocation, dtAppDate, Request.Cookies("UID").Value, strTableName)
                    ''execute store procedure untk update locid dan accid
                    If hidBANK.Value = "BCA" Then
                        objDBX.ExecSP("VABCAUpdateAccount", objDBX.MP("@UserID", SqlDbType.Int, Request.Cookies("UID").Value))
                    ElseIf hidBANK.Value = "PMT" Then
                        objDBX.ExecSP("VAPERMATAUpdateAccount", objDBX.MP("@UserID", SqlDbType.Int, Request.Cookies("UID").Value))
                    ElseIf hidBANK.Value = "POS" Then
                        objDBX.ExecSP("VAPOSUpdateAccount", objDBX.MP("@UserID", SqlDbType.Int, Request.Cookies("UID").Value))
                    ElseIf hidBANK.Value = "CSA" Then
                        objDBX.ExecSP("VACSAUpdateAccount", objDBX.MP("@UserID", SqlDbType.Int, Request.Cookies("UID").Value))
                    End If
                End If
                objRepl = Nothing

                lblMessage.Text = "The file " + FileUploadRepl.PostedFile.FileName + "  has been uploaded and executed..!"
            Catch Exc As Exception
                'Response.Write("Error: " & Exc.Message)
                lblMessage.Text = "UPLOAD DATA TEXT Virtual Account Error: " & Exc.Message
                strScript = "<script type='text/javascript'>" & Chr(13)
                strScript = strScript & "ShowAlert();" & Chr(13)
                strScript = strScript & "</script>" & Chr(13)
            Finally
                objDBX.Close()
                objDBX = Nothing
            End Try
        Else
            'Response.Write("Please select a file to upload.")
            lblMessage.Text = "Please select a file payment (Text File) to upload."
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
