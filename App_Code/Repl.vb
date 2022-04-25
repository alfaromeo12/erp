Imports Microsoft.VisualBasic
Imports System.IO
Imports ICSharpCode.SharpZipLib.Zip
Imports System
Imports System.Data
Imports System.Text
Public Class Repl
    '-->Add UnZipFile by Sendy 9 April 2012
    Public Shared Sub UnZipFiles(ByVal TempFileName As String, ByVal FilePathZip As String, Optional ByVal sPassword As String = "")
        Try
            Dim MyZip As New FastZip
            With MyZip
                If sPassword <> "" Then
                    .Password = sPassword
                End If
                .ExtractZip(TempFileName, FilePathZip, "")
                If File.Exists(TempFileName) Then
                    File.Delete(TempFileName)
                End If
            End With
        Catch
            Throw
        End Try
    End Sub
    '-->Add ZipFile by Sendy 9 April 2012
    Public Shared Sub ZipFiles(ByVal TempFileName As String, ByVal FilePathZip As String, ByVal FileNamezip As String, Optional ByVal sPassword As String = "")
        Try
            Dim FilePath = [String].Empty
            Dim FileName = [String].Empty
            Dim MyZip As ZipFile

            MyZip = ZipFile.Create(TempFileName)
            With MyZip
                ' iRows = FileNamezip.Count - 1
                ' For iRow = 0 To iRows
                FilePath = FilePathZip & "\" & FileNamezip.ToString
                FileName = FileNamezip.ToString
                If sPassword <> "" Then
                    .Password = sPassword
                End If
                .BeginUpdate()
                .Add(FilePath, FileName)
                .CommitUpdate()
                'Next
                If File.Exists(FilePathZip & "\" & FileNamezip) Then
                    File.Delete(FilePathZip & "\" & FileNamezip)
                End If
            End With
            MyZip.Close()
        Catch
            Throw
        End Try
    End Sub

    Public Sub CreateTextFileMain( _
        ByVal dblFileId As Double, _
        ByVal dtTxnDate As Date, _
        ByVal strUserId As String, _
        ByVal strDir As String, _
        ByVal strSQLWhere As String)

        'FreeFile()

        Dim objStreamWriter As StreamWriter
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim strCurBranch As String, strTextFileName As String = ""
        Dim strFileName As String
        Dim strViewName As String
        Dim strTextID As String
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("select dbo.f_getAppSetting('LOCID') CURBRANCH, * from MOSTextFile WITH(NOLOCK) WHERE FileId=" & dblFileId)
            If oSDR.Read Then
                strCurBranch = oSDR("CURBRANCH")
                strTextFileName = oSDR("FileName")
                strTextFileName = strTextFileName & strCurBranch & "_" & Year(dtTxnDate) & Right("00" & Month(dtTxnDate), 2) & Right("00" & Day(dtTxnDate), 2) & ".txt"

            End If

            If Not Directory.Exists(strDir) Then
                Directory.CreateDirectory(strDir)
            End If
            strFileName = strDir & "\" & strTextFileName

            If File.Exists(strFileName) Then
                File.Delete(strFileName)
            End If
            oSDR = objDB.CreateSDRFromSQLSelect("select * from MOSTextFileDtl WITH(NOLOCK) Where FileId='" & dblFileId & "' order by Sort")
            While oSDR.Read
                strViewName = oSDR("ViewName")
                strTextID = oSDR("TextId")
                objStreamWriter = File.AppendText(strFileName)
                objStreamWriter.WriteLine("[" & strTextID & "]")
                objStreamWriter.Close()
                CreateTextFile(dtTxnDate, strUserId, strDir, strTextFileName, _
                    strTextID, strSQLWhere, strViewName, False)
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            'Response.Write("ERROR CreateTextFileMain : " & ex.Message)
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub CreateTextFile( _
        ByVal dtTxnDate As Date, _
        ByVal strUserId As String, _
        ByVal strDir As String, _
        ByVal strTextFileName As String, _
        ByVal strTextID As String, _
        ByVal strSQLWhere As String, _
        Optional ByVal strViewName As String = "", _
        Optional ByVal blnDelete As Boolean = False)

        'FreeFile()
        Dim strFileName As String = ""
        Try
            If Not Directory.Exists(strDir) Then
                Directory.CreateDirectory(strDir)
            End If
            strFileName = strDir + "\" + strTextFileName

            If blnDelete Then
                If File.Exists(strFileName) Then
                    File.Delete(strFileName)
                End If
            End If
        Catch ex As Exception
            'Response.Write("ERROR CREATE DIREKTORY : " & ex.Message)
            Throw

        End Try

        Dim objStreamWriter As StreamWriter
        Dim objDB As New DBX
        Try
            Dim strTableType As String, strDateFormat As String, strDelimiter As String
            Dim rstTextSetting As System.Data.SqlClient.SqlDataReader
            strTableType = "V" 'Default From View
            strDateFormat = "103" 'Default Date Format
            strDelimiter = ""
            rstTextSetting = objDB.CreateSDRFromSQLSelect("SELECT TableName, TableType, DateFormat, UseDelimiter, Delimiter FROM MOSTextSetting WITH(NOLOCK) WHERE TextID='" & strTextID & "'")
            If rstTextSetting.Read() Then
                strTableType = rstTextSetting("TableType")
                strDateFormat = rstTextSetting("DateFormat")
                If rstTextSetting("UseDelimiter") Then
                    strDelimiter = rstTextSetting("Delimiter")
                End If
                If Len(Trim(strViewName)) <= 0 Then
                    strViewName = rstTextSetting("TableName")
                End If
            End If
            rstTextSetting.Close()
            rstTextSetting = Nothing


            Dim oSDR As System.Data.SqlClient.SqlDataReader

            If strTableType = "SP" Then
                Dim strSQL As String
                Dim arrFields(,) As Object
                Dim i As Integer = 0

                Dim oSDRTextSetting As System.Data.SqlClient.SqlDataReader
                oSDRTextSetting = objDB.CreateSDRFromSQLSelect("SELECT count(*) JMLRecord FROM MOSTextSettingDtl WITH(NOLOCK) WHERE TextID='" & strTextID & "'")
                If oSDRTextSetting.Read() Then
                    ReDim Preserve arrFields(oSDRTextSetting("JMLRecord"), 4)
                    oSDRTextSetting.Close()
                    oSDRTextSetting = Nothing

                    oSDRTextSetting = objDB.CreateSDRFromSQLSelect("SELECT ColumnHeader, ColumnName, Length, DataType, Alignment, cast(Updatable as varchar(5)) Updatable FROM MOSTextSettingDtl WITH(NOLOCK) WHERE TextID='" & strTextID & "' ORDER BY ColumnPosition")
                    While oSDRTextSetting.Read()
                        i = i + 1
                        arrFields(i, 0) = Trim(oSDRTextSetting("ColumnName"))
                        arrFields(i, 1) = oSDRTextSetting("Length")
                        arrFields(i, 2) = oSDRTextSetting("DataType")
                        arrFields(i, 3) = oSDRTextSetting("Alignment")
                        arrFields(i, 4) = oSDRTextSetting("Updatable")
                    End While
                    oSDRTextSetting.Close()
                    oSDRTextSetting = Nothing

                    strSQL = "EXEC " & strViewName & " " & strSQLWhere
                    oSDR = objDB.CreateSDRFromExecSQL(strSQL)

                    If oSDR.HasRows() Then
                        If Len(Trim(strDelimiter)) <= 0 Then
                            objStreamWriter = File.AppendText(strFileName)
                            Try
                                WriteToFile(objStreamWriter, strDateFormat, arrFields, oSDR)
                            Catch ex As Exception
                                Throw
                            Finally
                                objStreamWriter.Dispose()
                                objStreamWriter.Close()
                                objStreamWriter = Nothing
                                'oSDR.Close()
                                'oSDR = Nothing
                            End Try
                        Else
                            objStreamWriter = File.AppendText(strFileName)
                            Try
                                WriteToFileDelimiter(strDateFormat, objStreamWriter, arrFields, oSDR, strDelimiter)
                            Catch ex As Exception
                                Throw
                            Finally
                                objStreamWriter.Dispose()
                                objStreamWriter.Close()
                                objStreamWriter = Nothing
                                'oSDR.Close()
                                'oSDR = Nothing
                            End Try
                        End If
                    Else
                        objStreamWriter = File.CreateText(strFileName)
                        objStreamWriter.Dispose()
                        objStreamWriter.Close()
                        objStreamWriter = Nothing
                    End If

                    oSDR.Close()
                    oSDR = Nothing
                End If
            Else
                oSDR = objDB.CreateSDRFromSP("MOSCreateTextFile", _
                    objDB.MP("@TextId", Data.SqlDbType.VarChar, strTextID, 80), _
                    objDB.MP("@ViewName", Data.SqlDbType.VarChar, strViewName, 200), _
                    objDB.MP("@SQLWhere", Data.SqlDbType.VarChar, strSQLWhere, 8000) _
                    )
                objStreamWriter = File.AppendText(strFileName)
                Try
                    While oSDR.Read()
                        objStreamWriter.WriteLine(oSDR(0))
                    End While
                Catch ex As Exception
                    Throw
                Finally
                    objStreamWriter.Dispose()
                    objStreamWriter.Close()
                    objStreamWriter = Nothing
                    oSDR.Close()
                    oSDR = Nothing
                End Try
            End If



        Catch ex As Exception
            Throw
            'Response.Write("ERROR CreateTextFile : " & ex.Message)
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Private Sub WriteToFile( _
        ByVal objStreamer As StreamWriter, _
        ByVal strDateFormat As String, _
        ByRef arrFields As Object, _
        ByVal rst As System.Data.SqlClient.SqlDataReader)

        Try
            Dim strColumnName As String, intLenght As Integer, intL As Integer, i As Integer
            Dim strDataType As String, strAlignment As String, strFields As String, strWrite As String
            Dim strUpdatable As String
            Do While rst.Read()

                strWrite = ""
                For i = 1 To UBound(arrFields, 1) Step 1
                    strColumnName = arrFields(i, 0)
                    intLenght = arrFields(i, 1)
                    strDataType = arrFields(i, 2)
                    strAlignment = arrFields(i, 3)
                    strUpdatable = arrFields(i, 4)
                    strFields = ""
                    If strUpdatable = "1" Then
                        Select Case strDataType
                            Case "C"
                                If Not Convert.IsDBNull(rst(strColumnName)) Then
                                    If intLenght = "-1" Then
                                        strFields = RTrim(rst(strColumnName))
                                    Else
                                        strFields = RTrim(Left(rst(strColumnName), intLenght))
                                    End If
                                Else
                                    strFields = ""
                                End If
                                intL = Len(strFields)
                                If intL < intLenght Then
                                    If strAlignment = "L" Then
                                        strFields = strFields & Space(intLenght - intL)
                                    Else
                                        strFields = Space(intLenght - intL) & strFields
                                    End If
                                End If

                            Case "N"
                                strFields = RTrim(Left(rst(strColumnName), intLenght))
                                intL = Len(strFields)
                                If intL < intLenght Then
                                    If strAlignment = "L" Then
                                        strFields = strFields & Space(intLenght - intL)
                                    Else
                                        strFields = Space(intLenght - intL) & strFields
                                    End If
                                End If

                            Case "D"
                                If strDateFormat <> "103" Then
                                    strFields = RTrim(Left(Format(rst(strColumnName), "mm/dd/yyyy"), intLenght))
                                Else
                                    strFields = RTrim(Left(Format(rst(strColumnName), "dd/mm/yyyy"), intLenght))
                                End If


                                intL = Len(strFields)
                                If intL < intLenght Then
                                    If strAlignment = "L" Then
                                        strFields = strFields & Space(intLenght - intL)
                                    Else
                                        strFields = Space(intLenght - intL) & strFields
                                    End If
                                End If
                        End Select
                    Else
                        strFields = RTrim(Left(strColumnName, intLenght))
                        intL = Len(strFields)
                        If intL < intLenght Then
                            If strAlignment = "L" Then
                                strFields = strFields & Space(intLenght - intL)
                            Else
                                strFields = Space(intLenght - intL) & strFields
                            End If
                        End If
                    End If
                    strWrite = strWrite & strFields
                Next
                objStreamer.WriteLine(strWrite)
            Loop

        Catch ex As Exception
            Throw
        End Try
    End Sub

    Private Sub WriteToFileDelimiter(ByVal strDateFormat As String, _
    ByVal F As StreamWriter, _
    ByRef arrFields As Object, _
    ByVal rst As System.Data.SqlClient.SqlDataReader, _
    ByVal strDelimiter As String)

        Dim strColumnName As String, intLenght As Integer, i As Integer
        Dim strDataType As String, strAlignment As String, strFields As String, strWrite As String
        Dim strUpdatable As String

        Try
            Dim blnFirst As Boolean = True
            Do While rst.Read()
                strWrite = ""
                blnFirst = True
                For i = 1 To UBound(arrFields, 1) Step 1
                    strColumnName = arrFields(i, 0)
                    intLenght = arrFields(i, 1)
                    strDataType = arrFields(i, 2)
                    strAlignment = arrFields(i, 3)
                    strUpdatable = arrFields(i, 4)
                    strFields = ""
                    If strUpdatable = "1" Then
                        Select Case strDataType
                            Case "C"
                                'strFields = rst(strColumnName)
                                If Not Convert.IsDBNull(rst(strColumnName)) Then
                                    strFields = rst(strColumnName)
                                Else
                                    strFields = ""
                                End If

                            Case "N"
                                strFields = CStr(rst(strColumnName))
                            Case "D"
                                If strDateFormat = "103" Then
                                    strFields = RTrim(Left(Format(rst(strColumnName), "dd/mm/yyyy"), intLenght))
                                ElseIf strDateFormat = "112" Then
                                    strFields = RTrim(Left(Format(rst(strColumnName), "yyyy/mm/dd"), intLenght))
                                Else
                                    strFields = RTrim(Left(Format(rst(strColumnName), "mm/dd/yyyy"), intLenght))
                                End If
                        End Select
                    Else
                        strFields = strColumnName
                    End If
                    If Not blnFirst Then
                        strFields = strDelimiter & strFields
                    End If
                    strWrite = strWrite & strFields
                    blnFirst = False
                Next
                F.WriteLine(strWrite)
            Loop

        Catch ex As Exception
            Throw
            ' Finally
            'F.Flush()
            'F.Dispose()
            'F.Close()
        End Try

    End Sub



    Public Sub ReplicateData( _
        ByVal strFileName As String, _
        ByVal dtTxnDate As Date, _
        ByVal strUserId As String, _
        Optional ByVal strTableSource As String = "MOSTempUpload")

        UploadCreateTable(strTableSource)
        UploadTextToDB(strFileName, strTableSource)
        Dim objDB As New DBX
        Try


            objDB.ExecSPNoTxn("MOSReplicateData", _
                objDB.MP("@FileName", Data.SqlDbType.VarChar, strFileName), _
                objDB.MP("@TxnDate", Data.SqlDbType.DateTime, dtTxnDate), _
                objDB.MP("@TableSource", Data.SqlDbType.VarChar, strTableSource), _
                objDB.MP("@UserId", Data.SqlDbType.VarChar, strUserId) _
                )

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        UploadDropTable(strTableSource)
    End Sub

    Public Sub ReplicateDataWithTextID( _
        ByVal strTextID As String, _
        ByVal strFileName As String, _
        ByVal dtTxnDate As Date, _
        ByVal strUserId As String, _
        Optional ByVal strTableSource As String = "MOSTempUpload")

        UploadCreateTable(strTableSource)
        UploadTextToDB(strFileName, strTableSource)
        Dim objDB As New DBX
        Try
            objDB.ExecSPNoTxn("MOSReplicateDataWithTextID", _
                objDB.MP("@TextID", Data.SqlDbType.VarChar, strTextID), _
                objDB.MP("@FileName", Data.SqlDbType.VarChar, strFileName), _
                objDB.MP("@TxnDate", Data.SqlDbType.DateTime, dtTxnDate), _
                objDB.MP("@TableSource", Data.SqlDbType.VarChar, strTableSource), _
                objDB.MP("@UserId", Data.SqlDbType.VarChar, strUserId) _
                )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        UploadDropTable(strTableSource)
    End Sub

    Public Sub UploadTextToDB(ByVal strTextFile As String, _
             Optional ByVal strTableName As String = "MOSUploadTemp")
        Dim objStreamReader As StreamReader
        Dim strText As String
        Dim objDB As New DBX
        objStreamReader = File.OpenText(strTextFile)
        Try
            While objStreamReader.Peek() <> -1
                strText = objStreamReader.ReadLine()
                If Len(Trim(strText)) > 0 Then
                    objDB.ExecSQLNoTxn("Insert into " & strTableName & "(theText)Values('" & Replace(strText, "'", "''") & "')")
                End If
            End While
        Catch ex As Exception
            Throw
        Finally
            objStreamReader.Dispose()
            objStreamReader.Close()
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub

    Public Sub UploadCreateTable( _
        ByVal strTableName As String)
        Dim objDB As New DBX
        Try
            objDB.ExecSPNoTxn("MOSUploadCreateTable", _
                objDB.MP("@TableName", Data.SqlDbType.VarChar, strTableName, 200))
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub UploadDropTable( _
        ByVal strTableName As String)
        Dim objDB As New DBX
        Try
            objDB.ExecSPNoTxn("MOSUploadDropTable", _
                objDB.MP("@TableName", Data.SqlDbType.VarChar, strTableName, 200))
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Public Sub UpdateDBFromFile( _
        ByVal strFileName As String, _
        ByVal dtTxnDate As Date, _
        ByVal strUserId As String)

        Dim objStreamReader As StreamReader
        Dim strText As String = "", szTemp As String
        Dim objDB As New DBX
        objStreamReader = File.OpenText(strFileName)
        Try
            While objStreamReader.Peek() <> -1
                szTemp = Trim(objStreamReader.ReadLine())
                If szTemp <> "[EXECUTESQLBATCH]" Then
                    If Len(Trim(szTemp)) > 0 Then
                        strText = strText + szTemp + Chr(13) + Chr(10)
                    End If
                Else
                    If Len(Trim(strText)) > 0 Then
                        UpdateDBFromInputText(strText)
                    End If
                    strText = ""
                End If
            End While
            If Len(Trim(strText)) > 0 Then
                UpdateDBFromInputText(strText)
            End If
        Catch ex As Exception
            Throw
        Finally
            objStreamReader.Dispose()
            objStreamReader.Close()
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub UpdateDBFromInputText( _
        ByVal strText As String)

        Dim objDB As New DBX
        Try
            objDB.ExecSQL(strText)
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub UploadTextRange( _
        ByVal strTextID As String, _
        ByVal strFileName As String)

        Dim objDB As New DBX
        Dim objStreamReader As StreamReader
        objStreamReader = File.OpenText(strFileName)
        Try
            Dim arrFields(,) As Object
            Dim i As Integer
            Dim oSDRTextSetting As System.Data.SqlClient.SqlDataReader
            oSDRTextSetting = objDB.CreateSDRFromSQLSelect("SELECT count(*) JMLRecord FROM MOSTextSettingRange WITH(NOLOCK) WHERE TextID='" & strTextID & "'")
            If oSDRTextSetting.Read() Then
                ReDim Preserve arrFields(oSDRTextSetting("JMLRecord"), 4)
                oSDRTextSetting.Close()
                oSDRTextSetting = Nothing
                Dim strTableName As String = ""
                oSDRTextSetting = objDB.CreateSDRFromSQLSelect("SELECT TableName FROM MOSTextSetting WITH(NOLOCK) WHERE TextID='" & strTextID & "'")
                If oSDRTextSetting.Read() Then
                    strTableName = oSDRTextSetting("TableName")
                End If
                oSDRTextSetting.Close()
                oSDRTextSetting = Nothing


                oSDRTextSetting = objDB.CreateSDRFromSQLSelect("SELECT ColumnHeader, ColumnName, DataType, StartFrom, CharLength FROM MOSTextSettingRange WITH(NOLOCK) WHERE TextID='" & strTextID & "' ORDER BY ColumnPosition")
                While oSDRTextSetting.Read()
                    i = i + 1
                    arrFields(i, 0) = Trim(oSDRTextSetting("ColumnName"))
                    arrFields(i, 1) = Trim(oSDRTextSetting("ColumnHeader"))
                    arrFields(i, 2) = oSDRTextSetting("StartFrom")
                    arrFields(i, 3) = oSDRTextSetting("CharLength")
                    arrFields(i, 4) = oSDRTextSetting("DataType")
                End While
                oSDRTextSetting.Close()
                oSDRTextSetting = Nothing

                Dim strText As String
                Dim strValue As String
                Dim strValues As String = ""

                While objStreamReader.Peek() <> -1
                    strValues = ""
                    strText = objStreamReader.ReadLine()
                    If Len(Trim(strText)) > 0 Then
                        For i = 1 To UBound(arrFields, 1) Step 1
                            strValue = Mid(strText, arrFields(i, 2), arrFields(i, 3))
                            strValues = strValues & "'" & strValue & "',"
                        Next
                        strValues = Mid(strValues, 1, Len(strValues) - 1)
                        objDB.ExecSQLNoTxn("INSERT INTO " & strTableName & " VALUES (" & strValues & ")")
                    End If
                End While
            End If

        Catch ex As Exception
            Throw
        Finally
            objStreamReader.Dispose()
            objStreamReader.Close()
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

End Class
