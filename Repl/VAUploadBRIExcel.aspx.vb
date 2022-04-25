Imports System.IO
Imports ICSharpCode.SharpZipLib.Zip
Imports System
Imports System.Data
Imports System.Text
Partial Class Repl_VABRIExcel

    Inherits System.Web.UI.Page
    Public strScript As String = ""

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnUpload_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpload.Click
        lblMessage.Text = ""

        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim strDir As String = ""
        Dim strDay, strMonth, strYear, strDirDate As String
        'Dim strTableName As String
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
                strDir = strDir & "\VAPAYMENT" & strDirDate
            End If
            oSDR.Close()
            oSDR = Nothing


        Catch ex As Exception
            lblMessage.Text = "ERROR UPLOAD FILE VA BRI EXCEL : " & ex.Message
        Finally
            objDB.Close()
            objDB = Nothing
        End Try



        lblMessage.Visible = True
        If Not FileUploadRepl.PostedFile Is Nothing And FileUploadRepl.PostedFile.ContentLength > 0 Then
            Dim fn As String = System.IO.Path.GetFileName(FileUploadRepl.PostedFile.FileName)
            If Not Directory.Exists(strDir) Then
                Directory.CreateDirectory(strDir)
            End If
            Dim SaveLocation As String = strDir & "\" & fn
            Try
                FileUploadRepl.PostedFile.SaveAs(SaveLocation)

                Dim objCon As New OleDb.OleDbConnection

                Dim objDBX As New DBX
                Try
                    ''EXCEL UPLOAD
                    Dim objDR As OleDb.OleDbDataReader
                    objCon.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & SaveLocation & ";Extended Properties='Excel 8.0;HDR=Yes;IMEX=1';"
                    objCon.Open()
                    Dim objCom As New OleDb.OleDbCommand("SELECT * FROM [BRIVA$] WHERE DATE IS NOT NULL", objCon)
                    objDR = objCom.ExecuteReader()

                    If Not objDR.HasRows() Then
                        lblMessage.Text = lblMessage.Text & "EXCEL HAS NO RECORD...!"
                    End If

                    While (objDR.Read())
                        objDBX.ExecSP("VABRIAdd", _
                            objDBX.MP("@Date", SqlDbType.VarChar, objDR("Date").ToString()), _
                            objDBX.MP("@Debet", SqlDbType.VarChar, objDR("Debet").ToString()), _
                            objDBX.MP("@Credit", SqlDbType.VarChar, objDR("Credit").ToString()), _
                            objDBX.MP("@Remark", SqlDbType.VarChar, objDR("Remark").ToString()), _
                            objDBX.MP("@UserID", SqlDbType.Int, Request.Cookies("UID").Value) _
                            )
                    End While
                    objDR.Close()
                    objDR = Nothing
                    objCom.Dispose()
                    objCom = Nothing
                Catch ex As Exception
                    lblMessage.Text = lblMessage.Text & "READ VA BRI EXCEL ERROR...!<BR>PLEASE CHECK DETAIL ERROR MESSAGE:<BR>" & ex.Message
                    strScript = "<script type='text/javascript'>" & Chr(13)
                    strScript = strScript & "ShowAlert();" & Chr(13)
                    strScript = strScript & "</script>" & Chr(13)
                Finally
                    'objCom.Dispose()
                    'objCom = Nothing
                    objCon.Close()
                    objCon = Nothing
                    objDBX.Close()
                    objDBX = Nothing

                End Try


                lblMessage.Text = lblMessage.Text & "The file " + FileUploadRepl.PostedFile.FileName + "  has been uploaded and executed...!"


            Catch Exc As Exception
                'Response.Write("Error: " & Exc.Message)
                lblMessage.Text = "UPLOAD DATA Error: " & Exc.Message
                strScript = "<script type='text/javascript'>" & Chr(13)
                strScript = strScript & "ShowAlert();" & Chr(13)
                strScript = strScript & "</script>" & Chr(13)                'Throw
            Finally
            End Try
        Else
            'Response.Write("Please select a file to upload.")
            lblMessage.Text = "Please select a file payment VA BRI (Excel File) to upload."
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
