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
Imports Microsoft.VisualBasic

Public Class PDFSign

    Public Sub signPdfFileOutputByte(
                    ByVal sourceDocument As Byte(),
                    ByVal privateKeyFilePath As String,
                    ByVal keyPassword As String,
                    ByVal reason As String,
                    ByVal location As String,
                    ByVal strPathSignImage As String,
                    ByVal SignUniqueID As String,
                    ByVal SignLocation As iTextSharp.text.Rectangle,
                    ByRef bytPDF As Byte())
        Try
            Dim privateKeyStream As System.IO.FileStream
            privateKeyStream = New FileStream(privateKeyFilePath, FileMode.Open)
            Dim pk12 As Pkcs12Store = New Pkcs12Store(privateKeyStream, keyPassword.ToCharArray())
            privateKeyStream.Dispose()
            privateKeyStream.Close()

            'then Iterate throught certificate entries to find the private key entry
            Dim Salias As String = Nothing
            For Each tAlias As String In pk12.Aliases
                If (pk12.IsKeyEntry(tAlias)) Then
                    Salias = tAlias
                    Exit For
                End If
            Next

            'Dim fout As FileStream = New FileStream(destinationDocument, FileMode.Create, FileAccess.ReadWrite)
            Dim reader As PdfReader = New PdfReader(sourceDocument)

            Dim fout As New MemoryStream()

            Try
                Dim stamper As PdfStamper = PdfStamper.CreateSignature(reader, fout, "\0")
                Dim pk = pk12.GetKey(Salias).Key
                Dim appearance As PdfSignatureAppearance = stamper.SignatureAppearance
                appearance.SignatureGraphic = Image.GetInstance(strPathSignImage)
                If Len(Trim(reason)) > 0 Then
                    appearance.Reason = reason
                End If
                If Len(Trim(location)) > 0 Then
                    appearance.Location = location
                End If
                appearance.SetVisibleSignature(SignLocation, 1, SignUniqueID)

                appearance.SignatureRenderingMode = PdfSignatureAppearance.RenderingMode.GRAPHIC_AND_DESCRIPTION
                ' digital signature
                Dim es As IExternalSignature = New PrivateKeySignature(pk, "SHA-256")
                MakeSignature.SignDetached(appearance, es, New X509Certificate() {pk12.GetCertificate(Salias).Certificate}, Nothing, Nothing, Nothing, 0, CryptoStandard.CMS)

                stamper.Close()
                stamper = Nothing

                bytPDF = fout.ToArray()
            Catch ex As Exception
                Throw
            Finally
                fout.Close()
                fout.Dispose()
                fout = Nothing

                reader.Close()
                reader = Nothing
            End Try
        Catch ex As Exception
            Throw
        Finally

        End Try

    End Sub

    Public Sub signPdfFileKeyStreamOutputByte(
                    ByVal sourceDocument As Byte(),
                    ByVal privateKeyStream As Stream,
                    ByVal keyPassword As String,
                    ByVal reason As String,
                    ByVal location As String,
                    ByVal bytePathSignImage As Byte(),
                    ByVal SignUniqueID As String,
                    ByVal SignLocation As iTextSharp.text.Rectangle,
                    ByRef bytPDF As Byte())
        Try
            'Dim privateKeyStream As System.IO.FileStream
            'privateKeyStream = New FileStream(privateKeyFilePath, FileMode.Open)
            Dim pk12 As Pkcs12Store = New Pkcs12Store(privateKeyStream, keyPassword.ToCharArray())
            privateKeyStream.Dispose()
            privateKeyStream.Close()

            'then Iterate throught certificate entries to find the private key entry
            Dim Salias As String = Nothing
            For Each tAlias As String In pk12.Aliases
                If (pk12.IsKeyEntry(tAlias)) Then
                    Salias = tAlias
                    Exit For
                End If
            Next

            'Dim fout As FileStream = New FileStream(destinationDocument, FileMode.Create, FileAccess.ReadWrite)
            Dim reader As PdfReader = New PdfReader(sourceDocument)

            Dim fout As New MemoryStream()

            Try
                Dim stamper As PdfStamper = PdfStamper.CreateSignature(reader, fout, "\0")
                Dim pk = pk12.GetKey(Salias).Key
                Dim appearance As PdfSignatureAppearance = stamper.SignatureAppearance
                appearance.SignatureGraphic = Image.GetInstance(bytePathSignImage)
                If Len(Trim(reason)) > 0 Then
                    appearance.Reason = reason
                End If
                If Len(Trim(location)) > 0 Then
                    appearance.Location = location
                End If

                appearance.SetVisibleSignature(SignLocation, 1, SignUniqueID)

                appearance.SignatureRenderingMode = PdfSignatureAppearance.RenderingMode.GRAPHIC_AND_DESCRIPTION
                ' digital signature
                Dim es As IExternalSignature = New PrivateKeySignature(pk, "SHA-256")
                MakeSignature.SignDetached(appearance, es, New X509Certificate() {pk12.GetCertificate(Salias).Certificate}, Nothing, Nothing, Nothing, 0, CryptoStandard.CMS)

                stamper.Close()
                stamper = Nothing

                bytPDF = fout.ToArray()
            Catch ex As Exception
                Throw
            Finally
                fout.Close()
                fout.Dispose()
                fout = Nothing

                reader.Close()
                reader = Nothing
            End Try
        Catch ex As Exception
            Throw
        Finally

        End Try

    End Sub


    Public Sub pdfEncrypt(ByVal sourceDocument As String,
            ByVal destinationPath As String,
            ByVal strPassword As String,
            ByVal intPermission As Integer)
        'encrypt
        Dim reader As PdfReader = New PdfReader(sourceDocument)

        Dim os_encrypt As System.IO.FileStream
        os_encrypt = New FileStream(destinationPath, FileMode.Create, FileAccess.Write, FileShare.None)

        Try
            PdfEncryptor.Encrypt(reader, os_encrypt, True, "", strPassword, PdfWriter.ALLOW_PRINTING Or PdfWriter.ALLOW_SCREENREADERS Or PdfWriter.ALLOW_COPY)

        Catch ex As Exception
            Throw
        Finally
            reader.Close()
            reader = Nothing
            os_encrypt.Close()
            os_encrypt.Dispose()
            os_encrypt = Nothing

        End Try
    End Sub

    Public Sub pdfEncryptByDocID(
            ByVal intDocID As Integer,
            ByVal bytSourceDocument As Byte(),
            ByVal strPassword As String,
            ByRef bytPDF As Byte())

        Dim reader As PdfReader = New PdfReader(bytSourceDocument)
        Dim objDB As New DBX
        Dim os_encrypt As New MemoryStream
        'Dim os_encrypt As System.IO.FileStream
        'os_encrypt = New FileStream(destinationPath, FileMode.Create, FileAccess.Write, FileShare.None)
        Dim intPermision As Integer = PdfWriter.ALLOW_SCREENREADERS
        'Dim intPermision As Integer = 0
        'Dim os_encrypt As MemoryStream

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT ALLOWPRINTING, ALLOWCONTENTMODI, ALLOWCOPYTEXT FROM DOCUPLOADTYPE WITH(NOLOCK) WHERE DOCID=" & intDocID)
            If oSDR.Read() Then
                If oSDR("ALLOWPRINTING") Then
                    intPermision = intPermision Or PdfWriter.ALLOW_PRINTING
                Else
                    'intPermision = intPermision Or Not (PdfWriter.ALLOW_PRINTING)
                End If

                If oSDR("ALLOWCONTENTMODI") Then
                    intPermision = intPermision Or PdfWriter.ALLOW_MODIFY_CONTENTS Or PdfWriter.ALLOW_MODIFY_ANNOTATIONS
                Else
                    '    intPermision = intPermision Or Not (PdfWriter.ALLOW_MODIFY_CONTENTS Or PdfWriter.ALLOW_MODIFY_ANNOTATIONS)
                End If

                If oSDR("ALLOWCOPYTEXT") Then
                    intPermision = intPermision Or PdfWriter.ALLOW_COPY
                Else
                    'intPermision = intPermision Or Not (PdfWriter.ALLOW_COPY)
                End If

                'cara encrypt 1 (simple)
                PdfEncryptor.Encrypt(reader, os_encrypt, True, Nothing, strPassword, intPermision)

                ' ''cara encrypt 1.1 (simple - pakai user byte)
                'Dim sPass As Byte() = System.Text.Encoding.ASCII.GetBytes(strPassword)
                'Dim sUser As Byte() = System.Text.Encoding.ASCII.GetBytes("")
                'PdfEncryptor.Encrypt(reader, os_encrypt, sPass, sUser, intPermision, True)

                ''cara encrypt 2
                'Dim sPass As Byte() = System.Text.Encoding.ASCII.GetBytes(strPassword)
                'Dim sUser As Byte() = System.Text.Encoding.ASCII.GetBytes(Nothing)
                'PdfEncryptor.Encrypt(reader, os_encrypt, sUser, sPass, intPermision, PdfWriter.STRENGTH128BITS)

                ''cara encrypt 3, pakai stampler
                'Dim stamper As PdfStamper = New PdfStamper(reader, os_encrypt)


                'Dim sPass As Byte() = System.Text.Encoding.ASCII.GetBytes(strPassword)
                'Dim sUser As Byte() = System.Text.Encoding.ASCII.GetBytes(Nothing)
                'stamper.FormFlattening = True
                'stamper.SetEncryption(sUser, sPass, intPermision, PdfWriter.STRENGTH128BITS)
                'stamper.Dispose()
                'stamper.Close()
                'stamper = Nothing

                bytPDF = os_encrypt.ToArray()

            End If
            oSDR.Close()
            oSDR = Nothing

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
            reader.Close()
            reader = Nothing
            os_encrypt.Close()
            os_encrypt.Dispose()
            os_encrypt = Nothing

        End Try

    End Sub

    Public Function signPdfVerifyPassword(
                ByVal privateKeyStream As Stream,
                ByVal keyPassword As String) As Boolean

        signPdfVerifyPassword = True
        Try
            Dim pk12 As Pkcs12Store = New Pkcs12Store(privateKeyStream, keyPassword.ToCharArray())
            privateKeyStream.Dispose()
            privateKeyStream.Close()

        Catch ex As Exception
            signPdfVerifyPassword = False
        End Try

    End Function
End Class
