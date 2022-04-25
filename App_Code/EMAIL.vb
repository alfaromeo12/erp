Imports Microsoft.VisualBasic
Imports System.Net.Mail

Public Class EMAIL
    Public Sub SendMailFromSetting(
            ByVal strMailSettingCode As String, _
            ByVal strMailTo As String, _
            ByVal strSubject As String, _
            ByVal strBody As String, _
            Optional ByVal strAttachment As String = "", _
            Optional ByVal blnBodyHTML As Boolean = False
            )

        Dim mail As New MailMessage()
        Dim objDB As New DBX

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromExecSQL("SELECT USERID, PASSWORD, SMTP, POP3, PORTSMTP, SSL FROM EMAILSETTING WHERE EMAILCODE='" & strMailSettingCode & "'")
            If oSDR.HasRows() Then
                If oSDR.Read() Then
                    Dim SmtpServer As New SmtpClient(oSDR("SMTP").ToString())
                    mail.From = New MailAddress(oSDR("USERID").ToString())
                    mail.[To].Add(strMailTo)
                    mail.Subject = strSubject
                    mail.Body = strBody
                    mail.IsBodyHtml = blnBodyHTML
                    If Len(Trim(strAttachment)) > 0 Then
                        Dim attachment As System.Net.Mail.Attachment
                        attachment = New System.Net.Mail.Attachment(strAttachment)
                        mail.Attachments.Add(attachment)
                    End If

                    SmtpServer.Port = oSDR("PORTSMTP").ToString()
                    Dim objRC4 As New RC4.RC4Program
                    SmtpServer.Credentials = New System.Net.NetworkCredential(oSDR("USERID").ToString(), objRC4.Encrypt(oSDR("PASSWORD").ToString()))
                    objRC4 = Nothing
                    SmtpServer.EnableSsl = oSDR("SSL")
                    SmtpServer.Send(mail)
                End If
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw ex
        Finally
            objDB.Close()
            objDB = Nothing
            mail.Dispose()
            mail = Nothing
        End Try

    End Sub
End Class
