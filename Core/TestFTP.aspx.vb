
Partial Class BI_TestFTP
    Inherits System.Web.UI.Page

    Protected Sub btnFTP_Click(sender As Object, e As System.EventArgs) Handles btnFTP.Click
        Dim objFTP As New FTP
        Try
            Dim strDescription As String = ""
            Dim intReturn As Integer
            Dim strFTPFile As String = txtFTPFile.Text
            If Len(Trim(strFTPFile)) <= 0 Then
                strFTPFile = "testftp.txt"
            End If
            intReturn = objFTP.FTPUpload(txtServer.Text, strFTPFile, txtFTPFile.Text, txtUser.Text, txtPassword.Text, txtFTPDirektory.Text, False, strDescription)
            lblMessage.Text = intReturn.ToString() & "-" & strDescription

        Catch ex As Exception
            Throw
        Finally
            objFTP = Nothing
        End Try
    End Sub
End Class
