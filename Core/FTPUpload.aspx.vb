Imports System.IO

Partial Class Core_FTPUpload

    Inherits System.Web.UI.Page

    Public strScript As String = ""
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnFTP_Click(sender As Object, e As System.EventArgs) Handles btnFTP.Click
        UploadFile(FileUpload, lblMessageFile, "FTP UPLOAD FILE")

    End Sub

    Private Sub UploadFile(ByVal oFileUpload As FileUpload, _
        ByVal oLabelMessage As Label, _
        ByVal strFileDesc As String)

        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim strDir As String = ""
        Dim strDay, strMonth, strYear, strDirDate As String
        Dim dtAppDate As Date
        oLabelMessage.Text = ""
        Try

            oSDR = objDB.CreateSDRFromSQLSelect("Select dbo.f_getAppDate() APPDate, dbo.f_getAppSetting('UPLOADDIR') UPLOADDIR")
            If oSDR.Read Then
                strDir = oSDR("UPLOADDIR")
                dtAppDate = oSDR("APPDATE")
                strDay = Right("00" & Day(oSDR("APPDATE")), 2)
                strMonth = Right("00" & Month(oSDR("APPDATE")), 2)
                strYear = Year(oSDR("APPDATE"))
                strDirDate = strYear & strMonth & strDay
                strDir = strDir & "\UPLOAD" & strDirDate
            End If
            oSDR.Close()
            oSDR = Nothing

            Dim strFileName As String = ""

            oLabelMessage.Visible = True
            If Not oFileUpload.PostedFile Is Nothing And oFileUpload.PostedFile.ContentLength > 0 Then
                Dim fn As String = System.IO.Path.GetFileName(oFileUpload.PostedFile.FileName)
                If Not Directory.Exists(strDir) Then
                    Directory.CreateDirectory(strDir)
                End If
                Dim SaveLocation As String = strDir & "\" & fn
                Dim objFTP As New FTP

                Try
                    oFileUpload.PostedFile.SaveAs(SaveLocation)

                    oLabelMessage.CssClass = "ShowDetail"
                    oLabelMessage.Text = "The file " + oFileUpload.PostedFile.FileName + "  has been uploaded"

                    btnFTP.Visible = False

                    Dim strDescription As String = ""
                    Dim intReturn As Integer
                    Dim strFTPFile As String = txtFTPFile.Text
                    If Len(Trim(strFTPFile)) <= 0 Then
                        strFTPFile = fn
                    End If
                    Dim blnFileType As Boolean = False
                    If ddlFileType.SelectedValue = "2" Then
                        blnFileType = True
                    End If
                    lblMessage.Visible = True
                    intReturn = objFTP.FTPUpload(txtServer.Text, strFTPFile, SaveLocation, txtUser.Text, txtPassword.Text, txtFTPDirektory.Text, blnFileType, strDescription)
                    'lblMessage.Text = intReturn.ToString() & "-" & strDescription
                    If intReturn = -1 Then 'cannot connect
                        lblMessage.Text = lblMessage.Text & "<br>" & "INVALID FTP USER NAME OR PASSWORD<BR>CANNOT TRANSFER FILE TO PSAK SERVER<br>" & strDescription
                    ElseIf intReturn = -2 Then 'upload file
                        lblMessage.Text = lblMessage.Text & "<br>" & "FTP UPLOAD FAILED<BR>CANNOT TRANSFER FILE TO PSAK SERVER<br>" & strDescription
                    ElseIf intReturn = -3 Then 'cannot access server
                        lblMessage.Text = lblMessage.Text & "<br>" & "CANNOT ACCESS TO FTP SERVER<BR>CANNOT TRANSFER FILE TO PSAK SERVER<br>" & strDescription
                    Else
                        lblMessage.Text = lblMessage.Text & "<br>" & "TRANSFER FILE TO PSAK SERVER SUCCESSFULLY...!<br>" & strDescription
                    End If

                Catch Exc As Exception
                    oLabelMessage.CssClass = "ErrHighLight"
                    oLabelMessage.Text = "FTP UPLOAD  : " + strFileDesc + ": " & Exc.Message
                    strScript = "<script type='text/javascript'>" & Chr(13)
                    strScript = strScript & "ShowAlert();" & Chr(13)
                    strScript = strScript & "</script>" & Chr(13)
                    'Throw
                Finally
                    'objDB.Close()
                    'objDB = Nothing
                    objFTP = Nothing
                End Try
            Else
                'Response.Write("Please select a file to upload.")
                oLabelMessage.CssClass = "ErrHighLight"
                oLabelMessage.Text = "Please select a " + strFileDesc + " to upload."
            End If


            'objDB.ExecSQLNoTxn("exec DINUPLOADPROCESS")
        Catch ex As Exception
            oLabelMessage.CssClass = "ErrHighLight"
            oLabelMessage.Text = "ERROR : " & ex.Message
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub
End Class
