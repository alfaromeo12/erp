'Imports System
'Imports System.Collections.Generic
'Imports System.Text


'Imports Org.BouncyCastle.Crypto
'Imports Org.BouncyCastle.X509
'Imports System.Collections
'Imports Org.BouncyCastle.Pkcs
'Imports iTextSharp.text.pdf
'Imports System.IO
'Imports iTextSharp.text.xml.xmp

Imports System
Imports System.Collections.Generic
Imports System.IO
Imports Org.BouncyCastle.Crypto
Imports Org.BouncyCastle.Crypto.Parameters
Imports Org.BouncyCastle.Pkcs
Imports Org.BouncyCastle.X509
Imports iTextSharp.text
Imports iTextSharp.text.pdf
Imports iTextSharp.text.pdf.security


Partial Class PDFSignature
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        'Dim reader As PdfReader
        'Dim stamper As PdfStamper
        'Dim os As System.IO.FileStream

        'reader = New PdfReader("d:\test.pdf")
        'os = New FileStream("testx.pdf", FileMode.CreateNew)
        'stamper = PdfStamper.CreateSignature(reader, os, "\0")
        ''Dim os As FileStream = New FileStream("d:\testx.pdf", FileAccess.ReadWrite)

        'Dim appearance As PdfSignatureAppearance = stamper.SignatureAppearance()

        'appearance.Reason = "Reason"
        'appearance.Location = "Location"
        'Dim kotak As iTextSharp.text.Rectangle
        'kotak = New iTextSharp.text.Rectangle(36, 748, 144, 780)

        'appearance.SetVisibleSignature(kotak, 1, "ttd")
        ''Dim digest As iTextSharp.text.pdf.security.IExternalSignature = New BouncyCastleDigest()
        'reader.Close()
        'reader = Nothing

        Dim strPassword As String = "123"
        Dim os As System.IO.FileStream
        os = New FileStream("D:\DLEAS\DocumentDLeas\kacab.pfx", FileMode.Open)

        signPdfFile("D:\DLEAS\DocumentDLeas\PDFSign.pdf", "D:\DLEAS\DocumentDLeas\PDFSignApp.pdf", os, strPassword, "Approved", "cabang")
        os.Close()
        os.Dispose()
        os = Nothing

        pdfEncrypt("D:\DLEAS\DocumentDLeas\PDFSignApp.pdf", "D:\DLEAS\DocumentDLeas\PDFSignAppEncrypt.pdf", strPassword)
        Dim intDiceRoll As Integer
        intDiceRoll = GetRandomNumber(1, 999999)
        Response.Write("<br>" & intDiceRoll.ToString())
    End Sub

    'Private Function IsPasswordValid(pdfFullName As String, password As Stream) As Boolean
    '    IsPasswordValid = True
    '    Try
    '        Dim ms As New MemoryStream()
    '        password.CopyTo(ms)
    '        Dim reader As PdfReader = New PdfReader(pdfFullName, ms.ToArray())
    '        ms.Close()
    '        ms.Dispose()
    '    Catch ex As Exception
    '        IsPasswordValid = False
    '    End Try
    'End Function

    Public Function GetRandomNumber( _
          Optional ByVal Low As Integer = 1, _
          Optional ByVal High As Integer = 999999) As Integer
        ' Returns a random number,
        ' between the optional Low and High parameters
        Dim objRandom As New System.Random( _
      CType(System.DateTime.Now.Ticks Mod System.Int32.MaxValue, Integer))
        Return objRandom.Next(Low, High + 1)
    End Function


    Private Sub signPdfFile(sourceDocument As String, destinationPath As String, privateKeyStream As Stream, keyPassword As String, reason As String, location As String)
        Try

            Dim pk12 As Pkcs12Store = New Pkcs12Store(privateKeyStream, keyPassword.ToCharArray())
            privateKeyStream.Dispose()
            'then Iterate throught certificate entries to find the private key entry
            Dim Salias As String = Nothing
            For Each tAlias As String In pk12.Aliases
                If (pk12.IsKeyEntry(tAlias)) Then
                    Salias = tAlias
                    Exit For
                End If
            Next

            Dim fout As FileStream = New FileStream(destinationPath, FileMode.Create, FileAccess.ReadWrite)
            Dim reader As PdfReader = New PdfReader(sourceDocument)


            Try
                Dim stamper As PdfStamper = PdfStamper.CreateSignature(reader, fout, "\0")
                Dim pk = pk12.GetKey(Salias).Key
                ' reader and stamper
                ' appearance
                Dim appearance As PdfSignatureAppearance = stamper.SignatureAppearance
                'appearance.Image = New iTextSharp.text.pdf.PdfImage()
                'appearance.Layer2Text = "This document Sign by XXXX"
                appearance.SignatureGraphic = Image.GetInstance("D:\DLEAS\DocumentDLeas\ttd.jpg")

                'appearance.Layer4Text = "document sign bx"
                appearance.Reason = reason
                appearance.Location = location
                'appearance.Contact = ""
                'appearance.SetVisibleSignature(New iTextSharp.text.Rectangle(20, 10, 170, 60), 1, "ghw")

                'stamper.SetEncryption(System.Text.Encoding.Unicode.GetBytes("UID"), keyPassword, pdf.PdfWriter.ALLOW_PRINTING)
                'Dim cb As New iTextSharp.text.Rectangle(80, 100, 180, 150) 'ttd1
                Dim cb As New iTextSharp.text.Rectangle(180, 100, 280, 150) 'ttd2


                'cb.BackgroundColor = iTextSharp.text.BaseColor.YELLOW
                'cb.Border = 2

                'cb.BorderColorBottom = iTextSharp.text.BaseColor.BLACK

                'appearance.SetVisibleSignature(cb, 1, "ghw")
                appearance.SetVisibleSignature(cb, 1, Session.SessionID + "uiD")

                appearance.SignatureRenderingMode = PdfSignatureAppearance.RenderingMode.GRAPHIC_AND_DESCRIPTION
                ' digital signature
                Dim es As IExternalSignature = New PrivateKeySignature(pk, "SHA-256")
                MakeSignature.SignDetached(appearance, es, New X509Certificate() {pk12.GetCertificate(Salias).Certificate}, Nothing, Nothing, Nothing, 0, CryptoStandard.CMS)

                stamper.Close()
                stamper = Nothing


            Catch ex As Exception
                Response.Write("<br>error 1 : " & ex.Message)
                Response.Write("<br>" & destinationPath)

            Finally
                fout.Close()
                fout.Dispose()
                fout = Nothing

                reader.Close()
                reader = Nothing


            End Try
            'Catch ex As Exception
            '    'Response.Write("Wrong password or corrupted file")

            '    Response.Write("<br>error 2 : " & ex.Message)
        Finally

        End Try

    End Sub


    Private Sub pdfEncrypt(sourceDocument As String, destinationPath As String, strPassword As String)
        'encrypt
        Dim reader As PdfReader = New PdfReader(sourceDocument)
        Dim os_encrpt As System.IO.FileStream
        'os_encrpt = New FileStream("D:\DLEAS\DocumentDLeas\PDFSignEncrypt.pdf", FileMode.Create, FileAccess.Write, FileShare.None)
        os_encrpt = New FileStream(destinationPath, FileMode.Create, FileAccess.Write, FileShare.None)

        Try
            'PdfEncryptor.Encrypt(reader, os_encrpt, True, "", strPassword, PdfWriter.ALLOW_PRINTING Or PdfWriter.ALLOW_SCREENREADERS Or PdfWriter.ALLOW_COPY)
            Dim intPermision As Integer
            intPermision = PdfWriter.ALLOW_MODIFY_CONTENTS Or PdfWriter.ALLOW_MODIFY_ANNOTATIONS Or PdfWriter.ALLOW_COPY
            PdfEncryptor.Encrypt(reader, os_encrpt, True, "", strPassword, intPermision)

        Catch ex As Exception
            Response.Write("<br>error encrypt : " & ex.Message)
        Finally
            reader.Close()
            reader = Nothing
            os_encrpt.Close()
            os_encrpt.Dispose()
            os_encrpt = Nothing

        End Try
    End Sub


    'Private Sub signPdfFile(sourceDocument As String, destinationPath As String, privateKeyStream As Stream, keyPassword As String, reason As String, location As String)
    '    Dim pk12 As Pkcs12Store = New Pkcs12Store(privateKeyStream, keyPassword.ToCharArray())
    '    privateKeyStream.Dispose()
    '    'then Iterate throught certificate entries to find the private key entry
    '    Dim Salias As String = Nothing
    '    For Each tAlias As String In pk12.Aliases

    '        If (pk12.IsKeyEntry(tAlias)) Then
    '            Salias = tAlias
    '            Exit For
    '        End If
    '    Next
    '    Dim pk = pk12.GetKey(Salias).Key
    '    ' reader and stamper
    '    Dim reader As PdfReader = New PdfReader(sourceDocument)
    '    Dim fout As FileStream = New FileStream(destinationPath, FileMode.Create, FileAccess.ReadWrite)
    '    Dim stamper As PdfStamper = PdfStamper.CreateSignature(reader, fout, "\0")
    '    ' appearance
    '    Dim appearance As PdfSignatureAppearance = stamper.SignatureAppearance
    '    'appearance.Image = new iTextSharp.text.pdf.PdfImage()
    '    appearance.Reason = reason
    '    appearance.Location = location
    '    appearance.SetVisibleSignature(New iTextSharp.text.Rectangle(20, 10, 170, 60), 1, "Icsi-Vendor")
    '    ' digital signature
    '    Dim es As IExternalSignature = New PrivateKeySignature(pk, "SHA-256")
    '    '     MakeSignature.SignDetached(appearance, es, new X509Certificate[] { pk12.GetCertificate(alias).Certificate }, null, null, null, 0, CryptoStandard.CMS);

    '    stamper.Close()
    'End Sub

End Class
