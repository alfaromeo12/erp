Imports Microsoft.VisualBasic
Imports System.IO
Imports System.Data

Imports System.Configuration
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls



Public Class ReplDBF

    'Const m_modName As String = "MOSRepl_DB.UploadDTSToDB"
    'Private objDB As Connect_DB.DBHelper
    'Private objHelper As Connect_DB.PublicHelp
    Dim lngErrNo As Long



    'Public goPackageOld As New DTS.Package
    'Public goPackage As DTS.Package2

    Public Sub CreateDBaseFile( _
        ByVal dtTxnDate As Date, _
        ByVal strUserId As String, _
        ByVal strDir As String, _
        ByVal strDBaseFileName As String, _
        ByVal strTextID As String, _
        ByVal strSQLWhere As String, _
        Optional ByVal strFileType As String = "2", _
        Optional ByVal strViewName As String = "", _
        Optional ByVal blnDelete As Boolean = True, _
        Optional ByVal blnDebug As Boolean = False)

        Try
            Dim strFileName As String

            'Cek Directory, jika tidak ada buat Directory nya
            If Not Directory.Exists(strDir) Then
                Directory.CreateDirectory(strDir)
            End If

            strFileName = strDir + "\" + strDBaseFileName

            If blnDelete Then
                If File.Exists(strFileName) Then
                    File.Delete(strFileName)
                End If
            End If


        Catch ex As Exception
            HttpContext.Current.Response.Write("strDIR : " & strDir & "<br>")
            HttpContext.Current.Response.Write("strDBaseFileName  : " & strDBaseFileName & "<br>")
            HttpContext.Current.Response.Write("ERROR CreateDBaseFile : " & ex.Message & "<br>")


        End Try

        GenerateDBaseFile(strTextID, strDBaseFileName, strDir, strSQLWhere, strFileType)


    End Sub


    Private Sub GenerateDBaseFile( _
        ByVal strTextID As String, _
        ByVal strDBaseFileName As String, _
        ByVal strDir As String, _
        ByVal strSQLWhere As String, _
        Optional ByVal strFileType As String = "2")

        'Return

        Dim oOleDBConnection As New OleDb.OleDbConnection
        Dim strConnectionString As String = ""
        Dim strExtSource As String = ""
        Dim strUserID As String, strPassword As String = ""
        Dim strDebugDBF As String = "0"
        If strFileType = "2" Then
            strExtSource = "dBase III"
        ElseIf strFileType = "3" Then
            strExtSource = "dBase IV"
        ElseIf strFileType = "4" Then
            strExtSource = "dBase 5.0"
        End If
        'connect to DBF
        strUserID = "Admin"
        strPassword = ""
        strConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & strDir & ";Extended Properties=" & strExtSource & ";User ID=" & strUserID & ";Password=" & strPassword & ";Persist Security Info=False;"
        oOleDBConnection.ConnectionString = strConnectionString
        oOleDBConnection.Open()

        Dim strDBFInsertFinal As String = ""

        Dim oOleCommand As New OleDb.OleDbCommand

        Dim objDB As New DBX
        Try
            Dim i As Integer, iNumCol As Integer
            Dim arrTxtSetting(,) As String


            Dim rstTextSettingDtl As System.Data.SqlClient.SqlDataReader
            Dim strViewName As String = ""

            rstTextSettingDtl = objDB.CreateSDRFromSQLSelect("SELECT ISNULL(dbo.f_getAppSetting('DEBUGDBF'), '0') DEBUGDBF, TableName, (SELECT COUNT(*) FROM MOSTextSettingDtl WHERE MOSTextSetting.TextID=MOSTextSettingDtl.TextID) JmlCol FROM MOSTextSetting " & _
                " WHERE TextId='" & strTextID & "'")
            If rstTextSettingDtl.Read() Then
                strDebugDBF = rstTextSettingDtl("DEBUGDBF")
                strViewName = rstTextSettingDtl("TableName")
                iNumCol = rstTextSettingDtl("JmlCol")
            End If
            ReDim arrTxtSetting(3, iNumCol)
            rstTextSettingDtl.Close()
            rstTextSettingDtl = Nothing

            rstTextSettingDtl = objDB.CreateSDRFromSQLSelect("SELECT ColumnName, ColumnHeader, DataType, Length, IsNull(DecPoint, 0) DecPoint FROM MOSTextSettingDtl " & _
                " WHERE TextId='" & strTextID & "' ORDER BY ColumnPosition")

            Dim strEnter As String
            Dim strSQLDBFCreate As String, strSQL As String
            Dim strSQLDBFInsert As String
            'Create DBF File
            strSQLDBFCreate = "CREATE TABLE `" & strDBaseFileName & "` (" & vbCrLf
            strSQLDBFInsert = "INSERT INTO " & strDBaseFileName & "("
            'string select SQL
            strSQL = "SELECT "

            i = 1
            While rstTextSettingDtl.Read()
                arrTxtSetting(1, i) = rstTextSettingDtl("DataType")
                arrTxtSetting(2, i) = rstTextSettingDtl("Length")
                arrTxtSetting(3, i) = rstTextSettingDtl("DecPoint")
                If rstTextSettingDtl("DataType") = "C" Then
                    If rstTextSettingDtl("Length") > 1 Then
                        strSQL = strSQL & "SUBSTRING(" & rstTextSettingDtl("ColumnName") & ", 1," & rstTextSettingDtl("Length").ToString() & "), "
                    Else
                        strSQL = strSQL & rstTextSettingDtl("ColumnName") & ", "
                    End If
                Else
                    strSQL = strSQL & rstTextSettingDtl("ColumnName") & ", "
                End If

                strSQLDBFInsert = strSQLDBFInsert & rstTextSettingDtl("ColumnHeader") & ", "
                If i <> iNumCol Then
                    strEnter = ", " & vbCrLf
                Else
                    strEnter = vbCrLf
                End If
                If rstTextSettingDtl("DataType") = "C" Then
                    strSQLDBFCreate = strSQLDBFCreate & "`" & rstTextSettingDtl("ColumnHeader") & "` CHAR (" & rstTextSettingDtl("Length") & ")" & strEnter
                ElseIf rstTextSettingDtl("DataType") = "N" Then
                    If rstTextSettingDtl("DecPoint") <= 0 Then
                        strSQLDBFCreate = strSQLDBFCreate & "`" & rstTextSettingDtl("ColumnHeader") & "` NUMERIC(" & rstTextSettingDtl("Length") & ")" & strEnter
                    Else
                        strSQLDBFCreate = strSQLDBFCreate & "`" & rstTextSettingDtl("ColumnHeader") & "` NUMERIC(" & rstTextSettingDtl("Length") & "," & rstTextSettingDtl("DecPoint") & ")" & strEnter
                    End If
                ElseIf rstTextSettingDtl("DataType") = "D" Then
                    strSQLDBFCreate = strSQLDBFCreate & "`" & rstTextSettingDtl("ColumnHeader") & "` DATETIME" & strEnter
                Else
                    strSQLDBFCreate = strSQLDBFCreate & "`" & rstTextSettingDtl("ColumnHeader") & "` VARCHAR (" & rstTextSettingDtl("Length") & ")" & strEnter
                End If
                i = i + 1
            End While
            rstTextSettingDtl.Close()
            rstTextSettingDtl = Nothing

            'Create table DBF
            strSQLDBFCreate = strSQLDBFCreate & ")"
            oOleCommand = oOleDBConnection.CreateCommand()
            oOleCommand.CommandText = strSQLDBFCreate
            oOleCommand.ExecuteNonQuery()

            strSQL = RTrim(LTrim(strSQL))
            strSQL = Mid(strSQL, 1, Len(strSQL) - 1) & " FROM " & strViewName & " WHERE " & strSQLWhere


            strSQLDBFInsert = RTrim(LTrim(strSQLDBFInsert))
            strSQLDBFInsert = Mid(strSQLDBFInsert, 1, Len(strSQLDBFInsert) - 1)
            strSQLDBFInsert = strSQLDBFInsert & ") VALUES ("
            Dim rstDBF As System.Data.SqlClient.SqlDataReader
            rstDBF = objDB.CreateSDRFromSQLSelect(strSQL)

            If strDebugDBF = "1" Then HttpContext.Current.Response.Write("SQL : " & strSQL & "<br>")

            Dim strDBFValue As String = ""
            Dim strValue As String
            While rstDBF.Read()
                strDBFValue = ""
                For i = 1 To iNumCol
                    If strDebugDBF = "1" Then HttpContext.Current.Response.Write("rstDBF(i - 1) : " & rstDBF(i - 1) & "<br>")
                    If Not String.IsNullOrEmpty(rstDBF(i - 1).ToString()) Then
                        If arrTxtSetting(1, i) = "C" Then
                            strDBFValue = strDBFValue & "'" & Replace(rstDBF(i - 1), "'", "''") & "', "
                        ElseIf arrTxtSetting(1, i) = "N" Then
                            'strValue = Math.Round(rstDBF(i), CInt(arrTxtSetting(3, i))).ToString()
                            strValue = rstDBF(i - 1).ToString()
                            strDBFValue = strDBFValue & strValue & ", "
                        ElseIf arrTxtSetting(1, i) = "D" Then
                            strDBFValue = strDBFValue & "'" & rstDBF(i - 1).ToString() & "', "
                        End If
                    Else
                        strDBFValue = strDBFValue & "null, "
                    End If
                Next
                strDBFValue = RTrim(LTrim(strDBFValue))
                If strDebugDBF = "1" Then HttpContext.Current.Response.Write("Values : " & strDBFValue & "<br>")
                strDBFValue = Mid(strDBFValue, 1, Len(strDBFValue) - 1)
                strDBFInsertFinal = strSQLDBFInsert & strDBFValue & ")"
                oOleCommand = oOleDBConnection.CreateCommand()
                oOleCommand.CommandText = strDBFInsertFinal

                If strDebugDBF = "1" Then HttpContext.Current.Response.Write(strDBFInsertFinal & "<br>")
                oOleCommand.ExecuteNonQuery()
            End While
            rstDBF.Close()
            rstDBF = Nothing





        Catch ex As Exception
            HttpContext.Current.Response.Write("ERROR GenerateDBaseFile : " & ex.Message & "<br>")
            'Throw strDBFInsertFinal
        Finally
            objDB.Close()
            objDB = Nothing
            oOleCommand.Dispose()
            oOleCommand = Nothing
            oOleDBConnection.Close()
            oOleDBConnection = Nothing
        End Try
    End Sub


    'Private Sub GenerateDBaseFile( _
    '    ByVal strTextID As String, _
    '    ByVal strDBaseFileName As String, _
    '    ByVal strDir As String, _
    '    ByVal strSQLWhere As String, _
    '    Optional ByVal strFileType As String = "2")

    '    'Return

    '    Dim oOleDBConnection As New OleDb.OleDbConnection
    '    Dim strConnectionString As String = ""
    '    Dim strExtSource As String = ""
    '    Dim strUserID As String, strPassword As String = ""
    '    If strFileType = "2" Then
    '        strExtSource = "dBase III"
    '    ElseIf strFileType = "3" Then
    '        strExtSource = "dBase IV"
    '    ElseIf strFileType = "4" Then
    '        strExtSource = "dBase 5.0"
    '    End If
    '    'connect to DBF
    '    strUserID = "Admin"
    '    strPassword = ""
    '    strConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & strDir & ";Extended Properties=" & strExtSource & ";User ID=" & strUserID & ";Password=" & strPassword & ";Persist Security Info=False;"
    '    oOleDBConnection.ConnectionString = strConnectionString
    '    oOleDBConnection.Open()

    '    Dim oOleCommand As New OleDb.OleDbCommand
    '    Dim oOleInsertCommand As New OleDb.OleDbCommand

    '    Dim objDB As New DBX
    '    Try
    '        Dim i As Integer, iNumCol As Integer


    '        Dim rstTextSettingDtl As System.Data.SqlClient.SqlDataReader
    '        Dim strViewName As String = ""

    '        rstTextSettingDtl = objDB.CreateSDRFromSQLSelect("SELECT TableName, (SELECT COUNT(*) FROM MOSTextSettingDtl WHERE MOSTextSetting.TextID=MOSTextSettingDtl.TextID) JmlCol FROM MOSTextSetting " & _
    '            " WHERE TextId='" & strTextID & "'")
    '        If rstTextSettingDtl.Read() Then
    '            strViewName = rstTextSettingDtl("TableName")
    '            iNumCol = rstTextSettingDtl("JmlCol")
    '        End If
    '        rstTextSettingDtl.Close()
    '        rstTextSettingDtl = Nothing

    '        rstTextSettingDtl = objDB.CreateSDRFromSQLSelect("SELECT ColumnName, ColumnHeader, DataType, Length, IsNull(DecPoint, 0) DecPoint FROM MOSTextSettingDtl " & _
    '            " WHERE TextId='" & strTextID & "' ORDER BY ColumnPosition")

    '        Dim strEnter As String
    '        Dim strSQLDBFCreate As String, strSQL As String
    '        Dim strSQLDBFInsert As String, strSQLDBFSelect As String
    '        'Create DBF File
    '        strSQLDBFCreate = "CREATE TABLE `" & strDBaseFileName & "` (" & vbCrLf
    '        strSQLDBFInsert = "INSERT INTO " & strDBaseFileName & "("
    '        'string select SQL
    '        strSQL = "SELECT "
    '        strSQLDBFSelect = "SELECT "

    '        i = 1
    '        While rstTextSettingDtl.Read()
    '            strSQL = strSQL & rstTextSettingDtl("ColumnName") & ", "
    '            strSQLDBFSelect = strSQLDBFSelect & rstTextSettingDtl("ColumnHeader") & ", "
    '            strSQLDBFInsert = strSQLDBFInsert & rstTextSettingDtl("ColumnHeader") & ", "
    '            'oColumn = oTable.Columns.Add(rstTextSettingDtl("ColumnHeader"))
    '            If i <> iNumCol Then
    '                strEnter = ", " & vbCrLf
    '            Else
    '                strEnter = vbCrLf
    '            End If
    '            'strSQLDBFSelect = strSQLDBFSelect & rstTextSettingDtl("ColumnHeader") & strEnter
    '            'strSQLDBFInsert = strSQLDBFInsert & rstTextSettingDtl("ColumnHeader") & strEnter
    '            If rstTextSettingDtl("DataType") = "C" Then
    '                'oColumn.DataType = System.Type.GetType("System.String")
    '                strSQLDBFCreate = strSQLDBFCreate & "`" & rstTextSettingDtl("ColumnHeader") & "` CHAR (" & rstTextSettingDtl("Length") & ")" & strEnter
    '            ElseIf rstTextSettingDtl("DataType") = "N" Then
    '                'oColumn.DataType = System.Type.GetType("System.Double")
    '                If rstTextSettingDtl("DecPoint") <= 0 Then
    '                    strSQLDBFCreate = strSQLDBFCreate & "`" & rstTextSettingDtl("ColumnHeader") & "` NUMERIC(" & rstTextSettingDtl("Length") & ")" & strEnter
    '                Else
    '                    strSQLDBFCreate = strSQLDBFCreate & "`" & rstTextSettingDtl("ColumnHeader") & "` NUMERIC(" & rstTextSettingDtl("Length") & "," & rstTextSettingDtl("DecPoint") & ")" & strEnter
    '                End If
    '            ElseIf rstTextSettingDtl("DataType") = "D" Then
    '                'oColumn.DataType = System.Type.GetType("System.Date")
    '                strSQLDBFCreate = strSQLDBFCreate & "`" & rstTextSettingDtl("ColumnHeader") & "` DATETIME" & strEnter
    '            Else
    '                'oColumn.DataType = System.Type.GetType("System.String")
    '                strSQLDBFCreate = strSQLDBFCreate & "`" & rstTextSettingDtl("ColumnHeader") & "` VARCHAR (" & rstTextSettingDtl("Length") & ")" & strEnter
    '            End If
    '            i = i + 1
    '        End While
    '        rstTextSettingDtl.Close()
    '        rstTextSettingDtl = Nothing

    '        strSQLDBFInsert = RTrim(LTrim(strSQLDBFInsert))
    '        strSQLDBFInsert = Mid(strSQLDBFInsert, 1, Len(strSQLDBFInsert) - 1)
    '        strSQLDBFInsert = strSQLDBFInsert & ") VALUES ("
    '        For i = 1 To iNumCol
    '            strSQLDBFInsert = strSQLDBFInsert & "?, "
    '        Next
    '        strSQLDBFInsert = RTrim(LTrim(strSQLDBFInsert))
    '        strSQLDBFInsert = Mid(strSQLDBFInsert, 1, Len(strSQLDBFInsert) - 1) & ")"

    '        strSQL = RTrim(LTrim(strSQL))
    '        strSQL = Mid(strSQL, 1, Len(strSQL) - 1) & " FROM " & strViewName & " WHERE " & strSQLWhere

    '        strSQLDBFSelect = RTrim(LTrim(strSQLDBFSelect))
    '        strSQLDBFSelect = Mid(strSQLDBFSelect, 1, Len(strSQLDBFSelect) - 1) & " FROM " & strDBaseFileName


    '        'Create table DBF
    '        strSQLDBFCreate = strSQLDBFCreate & ")"
    '        oOleCommand = oOleDBConnection.CreateCommand()
    '        oOleCommand.CommandText = strSQLDBFCreate
    '        oOleCommand.ExecuteNonQuery()

    '        'Create Adapter
    '        'oOleCommand = oOleDBConnection.CreateCommand()
    '        oOleCommand.CommandText = strSQLDBFSelect
    '        Dim oOleAdapter As New OleDb.OleDbDataAdapter(oOleCommand)


    '        'Create the insert logic
    '        oOleInsertCommand = oOleDBConnection.CreateCommand()
    '        oOleAdapter.InsertCommand = oOleInsertCommand
    '        oOleInsertCommand.CommandText = strSQLDBFInsert
    '        rstTextSettingDtl = objDB.CreateSDRFromSQLSelect("SELECT ColumnHeader, DataType, Length FROM MOSTextSettingDtl " & _
    '            " WHERE TextId='" & strTextID & "' ORDER BY ColumnPosition")
    '        While rstTextSettingDtl.Read()
    '            If rstTextSettingDtl("DataType") = "C" Then
    '                oOleInsertCommand.Parameters.Add("p" & rstTextSettingDtl("ColumnHeader"), OleDb.OleDbType.VarChar, rstTextSettingDtl("length"), rstTextSettingDtl("ColumnHeader"))
    '            ElseIf rstTextSettingDtl("DataType") = "N" Then
    '                oOleInsertCommand.Parameters.Add("p" & rstTextSettingDtl("ColumnHeader"), OleDb.OleDbType.Double, rstTextSettingDtl("length"), rstTextSettingDtl("ColumnHeader"))
    '            ElseIf rstTextSettingDtl("DataType") = "D" Then
    '                oOleInsertCommand.Parameters.Add("p" & rstTextSettingDtl("ColumnHeader"), OleDb.OleDbType.DBDate, rstTextSettingDtl("length"), rstTextSettingDtl("ColumnHeader"))
    '            Else
    '                oOleInsertCommand.Parameters.Add("p" & rstTextSettingDtl("ColumnHeader"), OleDb.OleDbType.VarChar, rstTextSettingDtl("length"), rstTextSettingDtl("ColumnHeader"))
    '            End If
    '        End While
    '        rstTextSettingDtl.Close()
    '        rstTextSettingDtl = Nothing

    '        HttpContext.Current.Response.Write("strSQLDBFCreate : " & strSQLDBFCreate & "<br>")
    '        HttpContext.Current.Response.Write("strSQLDBFSelect : " & strSQLDBFSelect & "<br>")
    '        HttpContext.Current.Response.Write("strSQLDBFInsert : " & strSQLDBFInsert & "<br>")
    '        HttpContext.Current.Response.Write("strSQL : " & strSQL & "<br>")

    '        Dim rstDBF As System.Data.SqlClient.SqlDataReader
    '        Dim oTable As New DataTable()
    '        rstDBF = objDB.CreateSDRFromSQLSelect(strSQL)
    '        oTable.Load(rstDBF)
    '        oOleInsertCommand.UpdatedRowSource = UpdateRowSource.None
    '        oOleAdapter.Update(oTable)
    '        oTable.Clear()
    '        oTable = Nothing

    '        rstDBF.Close()
    '        rstDBF = Nothing


    '        'Catch ex As Exception
    '        '   Throw
    '    Finally
    '        objDB.Close()
    '        objDB = Nothing
    '        oOleCommand.Dispose()
    '        oOleCommand = Nothing
    '        oOleInsertCommand.Dispose()
    '        oOleInsertCommand = Nothing
    '        oOleDBConnection.Close()
    '        oOleDBConnection = Nothing
    '    End Try
    'End Sub


    '    Private Sub CreateDBaseFile( _
    '        ByVal strTextID As String, _
    '        ByVal strDBaseFileName As String, _
    '        ByVal strDir As String, _
    '        ByVal strSQLWhere As String, _
    '        Optional ByVal intFileType As Integer = 2, _
    '        Optional ByVal blnDebug As Boolean = False)

    '        On Error GoTo errorHandle

    '        goPackage = goPackageOld

    '        Const strProcess = "<br>CreateDBaseFile "



    '        goPackage.Name = "Export To dBase"
    '        goPackage.Description = "DTS package description"
    '        goPackage.WriteCompletionStatusToNTEventLog = False
    '        goPackage.FailOnError = False
    '        goPackage.PackagePriorityClass = 2
    '        goPackage.MaxConcurrentSteps = 4
    '        goPackage.LineageOptions = 0
    '        goPackage.UseTransaction = True
    '        goPackage.TransactionIsolationLevel = 4096
    '        goPackage.AutoCommitTransaction = True
    '        goPackage.RepositoryMetadataOptions = 0
    '        goPackage.UseOLEDBServiceComponents = True
    '        goPackage.LogToSQLServer = False
    '        goPackage.LogServerFlags = 0
    '        goPackage.FailPackageOnLogFailure = False
    '        goPackage.ExplicitGlobalVariables = False
    '        goPackage.PackageType = 0

    '        Dim oConnProperty As DTS.OleDBProperty

    '        '---------------------------------------------------------------------------
    '        ' create package connection information
    '        '---------------------------------------------------------------------------

    '        Dim oRpt As Report_DB.ReportParm
    '        oRpt = New Report_DB.ReportParm
    '        Dim strConnection As String, strServerName As String, _
    '            strDBName As String, strUserName As String, strPassword As String
    '        oRpt.rptGetConnection(strConnection, strServerName, strDBName, strUserName, strPassword)

    '        oRpt = Nothing

    '        If blnDebug Then objHelper.Writes(strProcess & "Connection to SQL")

    '        Dim oConnection As DTS.Connection2

    '        '------------- a new connection defined below.
    '        'For security purposes, the password is never scripted

    '        oConnection = goPackage.Connections.New("SQLOLEDB")
    '        If Len(Trim(strPassword)) > 0 Then
    '            oConnection.ConnectionProperties("Persist Security Info") = True
    '            oConnection.ConnectionProperties("Data Source") = strServerName
    '            oConnection.ConnectionProperties("Initial Catalog") = strDBName
    '            oConnection.ConnectionProperties("User ID") = strUserName
    '            oConnection.ConnectionProperties("Password") = strPassword
    '            oConnection.ConnectionProperties("Application Name") = "DTS  Import/Export Wizard"

    '            oConnection.Name = "Connection to SQL"
    '            oConnection.ID = 1
    '            oConnection.Reusable = True
    '            oConnection.ConnectImmediate = False
    '            oConnection.DataSource = strServerName
    '            oConnection.Catalog = strDBName
    '            oConnection.UserID = strUserName
    '            oConnection.Password = strPassword
    '            oConnection.ConnectionTimeout = 60
    '            oConnection.UseTrustedConnection = False
    '            oConnection.UseDSL = False
    '        Else
    '            If blnDebug Then objHelper.Writes(strProcess & "Connection to SQL, Using Integrated Security")
    '            oConnection.ConnectionProperties("Integrated Security") = "SSPI"
    '            oConnection.ConnectionProperties("Persist Security Info") = True
    '            oConnection.ConnectionProperties("Initial Catalog") = strDBName
    '            oConnection.ConnectionProperties("Data Source") = strServerName
    '            oConnection.ConnectionProperties("Application Name") = "DTS Designer"

    '            oConnection.Name = "Connection to SQL"
    '            oConnection.ID = 1
    '            oConnection.Reusable = True
    '            oConnection.ConnectImmediate = False
    '            oConnection.DataSource = strServerName
    '            oConnection.ConnectionTimeout = 60
    '            oConnection.Catalog = strDBName
    '            oConnection.UseTrustedConnection = True
    '            oConnection.UseDSL = False
    '        End If

    '        'If you have a password for this connection, please uncomment and add your password below.
    '        'oConnection.Password = "<put the password here>"

    '        goPackage.Connections.Add(oConnection)
    '        oConnection = Nothing

    '        '------------- a new connection defined below.
    '        'For security purposes, the password is never scripted

    '        If blnDebug Then objHelper.Writes(strProcess & "Connection to DBASE")

    '        oConnection = goPackage.Connections.New("Microsoft.Jet.OLEDB.4.0")
    '        oConnection.ConnectionProperties("User ID") = "Admin"
    '        oConnection.ConnectionProperties("Data Source") = strDir  '"C:\ADFS"
    '        If intFileType = 4 Then
    '            oConnection.ConnectionProperties("Extended Properties") = "dBase IV"
    '        ElseIf intFileType = 5 Then
    '            oConnection.ConnectionProperties("Extended Properties") = "dBase 5.0"
    '        Else
    '            oConnection.ConnectionProperties("Extended Properties") = "dBase III"
    '        End If

    '        oConnection.Name = "Connection to dBase"
    '        oConnection.ID = 2
    '        oConnection.Reusable = True
    '        oConnection.ConnectImmediate = False
    '        oConnection.DataSource = strDir '"C:\ADFS"
    '        oConnection.UserID = "Admin"
    '        oConnection.ConnectionTimeout = 60
    '        oConnection.UseTrustedConnection = False
    '        oConnection.UseDSL = False

    '        'If you have a password for this connection, please uncomment and add your password below.
    '        'oConnection.Password = "<put the password here>"

    '        goPackage.Connections.Add(oConnection)
    '        oConnection = Nothing

    '        '---------------------------------------------------------------------------
    '        ' create package steps information
    '        '---------------------------------------------------------------------------
    '        If blnDebug Then objHelper.Writes(strProcess & "STEP 1")

    '        Dim oStep As DTS.Step2
    '        Dim oPrecConstraint As DTS.PrecedenceConstraint

    '        '------------- a new step defined below

    '        oStep = goPackage.Steps.New

    '        oStep.Name = "Create DBF FILE Step"
    '        oStep.Description = "Create DBF FILE Task"

    '        oStep.ExecutionStatus = 1
    '        oStep.TaskName = "Create DBF FILE Task"
    '        oStep.CommitSuccess = False
    '        oStep.RollbackFailure = False
    '        oStep.ScriptLanguage = "VBScript"
    '        oStep.AddGlobalVariables = True
    '        oStep.RelativePriority = 3
    '        oStep.CloseConnection = False
    '        oStep.ExecuteInMainThread = False
    '        oStep.IsPackageDSORowset = False
    '        oStep.JoinTransactionIfPresent = False
    '        oStep.DisableStep = False
    '        oStep.FailPackageOnError = False

    '        goPackage.Steps.Add(oStep)
    '        oStep = Nothing

    '        '------------- a new step defined below
    '        If blnDebug Then objHelper.Writes(strProcess & "STEP 2")

    '        oStep = goPackage.Steps.New


    '        oStep.Name = "Copy Data from SQL into DBF step"
    '        oStep.Description = "Copy Data from SQL into DBF Task"

    '        oStep.ExecutionStatus = 1
    '        oStep.TaskName = "Copy Data from SQL into DBF Task"
    '        oStep.CommitSuccess = False
    '        oStep.RollbackFailure = False
    '        oStep.ScriptLanguage = "VBScript"
    '        oStep.AddGlobalVariables = True
    '        oStep.RelativePriority = 3
    '        oStep.CloseConnection = False
    '        oStep.ExecuteInMainThread = True
    '        oStep.IsPackageDSORowset = False
    '        oStep.JoinTransactionIfPresent = False
    '        oStep.DisableStep = False
    '        oStep.FailPackageOnError = False

    '        goPackage.Steps.Add(oStep)
    '        oStep = Nothing

    '        '------------- a precedence constraint for steps defined below
    '        If blnDebug Then objHelper.Writes(strProcess & "a precedence constraint for steps defined below")

    '        oStep = goPackage.Steps("Copy Data from SQL into DBF step")
    '        oPrecConstraint = oStep.PrecedenceConstraints.New("Create DBF FILE Step")
    '        oPrecConstraint.StepName = "Create DBF FILE Step"
    '        oPrecConstraint.PrecedenceBasis = 0
    '        oPrecConstraint.Value = 4

    '        oStep.PrecedenceConstraints.Add(oPrecConstraint)
    '        oPrecConstraint = Nothing

    '        '---------------------------------------------------------------------------
    '        ' create package tasks information
    '        '---------------------------------------------------------------------------

    '        If blnDebug Then objHelper.Writes(strProcess & "Call Task_Sub1")

    '        '------------- call Task_Sub1 for task Create Table strDBaseFileName Task (Create Table corCollector Task)
    '        Call Task_Sub1(goPackage, strTextID, strDBaseFileName, blnDebug)

    '        If blnDebug Then objHelper.Writes(strProcess & "Call Task_Sub2")
    '        '------------- call Task_Sub2 for task Copy Data from strDBaseFileName to corCollector Task (Copy Data from corCollector to corCollector Task)
    '        Call Task_Sub2(goPackage, strTextID, strDBaseFileName, strSQLWhere, blnDebug)

    '        '---------------------------------------------------------------------------
    '        ' Save or execute package
    '        '---------------------------------------------------------------------------

    '        If blnDebug Then objHelper.Writes(strProcess & "goPackage.Execute")
    '        goPackage.Execute()
    '        If blnDebug Then objHelper.Writes(strProcess & "tracePackageError")
    '        tracePackageError(goPackage)
    '        If blnDebug Then objHelper.Writes(strProcess & "goPackage.UnInitialize")
    '        goPackage.UnInitialize()

    '        If blnDebug Then objHelper.Writes(strProcess & "NOTHING")
    '        goPackage = Nothing

    '        goPackageOld = Nothing
    '        If blnDebug Then objHelper.Writes(strProcess & "END")
    '        Exit Sub
    'errorHandle:
    '        If blnDebug Then objHelper.Writes(strProcess & "Error " & Err.Number & "--" & Err.Description)
    '        goPackage = Nothing
    '        goPackageOld = Nothing
    '    End Sub


    '    '-----------------------------------------------------------------------------
    '    ' error reporting using step.GetExecutionErrorInfo after execution
    '    '-----------------------------------------------------------------------------
    '    Public Sub tracePackageError(ByVal oPackage As DTS.Package)
    '        Dim ErrorCode As Long
    '        Dim ErrorSource As String
    '        Dim ErrorDescription As String
    '        Dim ErrorHelpFile As String
    '        Dim ErrorHelpContext As Long
    '        Dim ErrorIDofInterfaceWithError As String
    '        Dim i As Integer

    '        For i = 1 To oPackage.Steps.Count
    '            If oPackage.Steps(i).ExecutionResult = DTSStepExecResult_Failure Then
    '                oPackage.Steps(i).GetExecutionErrorInfo(ErrorCode, ErrorSource, ErrorDescription, _
    '                                ErrorHelpFile, ErrorHelpContext, ErrorIDofInterfaceWithError)
    '                objHelper.Writes(oPackage.Steps(i).Name & " failed" & vbCrLf & ErrorSource & vbCrLf & ErrorDescription)
    '            End If
    '        Next i

    '    End Sub

    '    '------------- define Task_Sub1 for task Create Table corCollector Task (Create Table corCollector Task)
    '    Public Sub Task_Sub1(ByVal goPackage As Object, _
    '        ByVal strTextID As String, _
    '        ByVal strDBaseFileName As String, _
    '        Optional ByVal blnDebug As Boolean = False)

    '        Const strProcess = "<br>Task_Sub1 "
    '        Dim strEnter As String

    '        Dim i As Integer, iNumrow As Integer
    '        If blnDebug Then objHelper.Writes(strProcess & "BEGIN")

    '        Dim rstTextSettingDtl As ADODB.Recordset
    '        rstTextSettingDtl = objDB.CreateRSfromView("MOSTextSettingDtl", "ColumnHeader, DataType, Length, IsNull(DecPoint, 0) DecPoint", "TextId='" & strTextID & "'", , "ColumnPosition")

    '        Dim oTask As DTS.Task
    '        Dim oLookup As DTS.Lookup

    '        Dim oCustomTask1 As DTS.ExecuteSQLTask2
    '        oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
    '        If blnDebug Then objHelper.Writes(strProcess & "Create DBF FILE Task")
    '        oTask.Name = "Create DBF FILE Task"
    '        oCustomTask1 = oTask.CustomTask

    '        i = 1
    '        iNumrow = rstTextSettingDtl.RecordCount
    '        oCustomTask1.Name = "Create DBF FILE Task"
    '        oCustomTask1.Description = "Create DBF FILE Task"
    '        oCustomTask1.SQLStatement = "CREATE TABLE `" & strDBaseFileName & "` (" & vbCrLf
    '        Do While Not rstTextSettingDtl.EOF
    '            If i <> iNumrow Then
    '                strEnter = ", " & vbCrLf
    '            Else
    '                strEnter = vbCrLf
    '            End If
    '            If rstTextSettingDtl("DataType") = "C" Then
    '                oCustomTask1.SQLStatement = oCustomTask1.SQLStatement & "`" & rstTextSettingDtl("ColumnHeader") & "` CHAR (" & rstTextSettingDtl("Length") & ")" & strEnter
    '            ElseIf rstTextSettingDtl("DataType") = "N" Then
    '                If rstTextSettingDtl("DecPoint") <= 0 Then
    '                    oCustomTask1.SQLStatement = oCustomTask1.SQLStatement & "`" & rstTextSettingDtl("ColumnHeader") & "` NUMERIC(" & rstTextSettingDtl("Length") & ")" & strEnter
    '                Else
    '                    oCustomTask1.SQLStatement = oCustomTask1.SQLStatement & "`" & rstTextSettingDtl("ColumnHeader") & "` NUMERIC(" & rstTextSettingDtl("Length") & "," & rstTextSettingDtl("DecPoint") & ")" & strEnter
    '                End If
    '            ElseIf rstTextSettingDtl("DataType") = "D" Then
    '                oCustomTask1.SQLStatement = oCustomTask1.SQLStatement & "`" & rstTextSettingDtl("ColumnHeader") & "` DATETIME" & strEnter
    '            Else
    '                oCustomTask1.SQLStatement = oCustomTask1.SQLStatement & "`" & rstTextSettingDtl("ColumnHeader") & "` VARCHAR (" & rstTextSettingDtl("Length") & ")" & strEnter
    '            End If
    '            i = i + 1
    '            rstTextSettingDtl.MoveNext()
    '        Loop
    '        oCustomTask1.SQLStatement = oCustomTask1.SQLStatement & ")"
    '        If blnDebug Then objHelper.Writes(strProcess & oCustomTask1.SQLStatement)

    '        oCustomTask1.ConnectionID = 2
    '        oCustomTask1.CommandTimeout = 0
    '        oCustomTask1.OutputAsRecordset = False


    '        goPackage.Tasks.Add(oTask)
    '        oCustomTask1 = Nothing
    '        oTask = Nothing
    '        If blnDebug Then objHelper.Writes(strProcess & "END")
    '    End Sub

    '    Private Sub Task_Sub2(ByVal goPackage As Object, _
    '            ByVal strTextID As String, _
    '            ByVal strDBFileName As String, _
    '            ByVal strSQLWhere As String, _
    '            Optional ByVal blnDebug As Boolean = False)

    '        Const strProcess = "<BR>Task_Sub2 "


    '        If blnDebug Then objHelper.Writes(strProcess & "BEGIN")

    '        Dim oTask As DTS.Task
    '        Dim oLookup As DTS.Lookup
    '        Dim strColumn As String, strSQLStatement As String, strTable As String
    '        Dim rstTextSettingDtl As ADODB.Recordset
    '        Dim rstTextSetting As ADODB.Recordset

    '        rstTextSetting = objDB.CreateRSfromView("MOSTextSetting", "IsNull(TableName, TextId) TableName", "textId='" & strTextID & "'")
    '        If Not rstTextSetting.EOF Then strTable = rstTextSetting("TableName")

    '        rstTextSettingDtl = objDB.CreateRSfromView("MOSTextSettingDtl", "ColumnName, ColumnHeader", "TextId='" & strTextID & "'", , "ColumnPosition")
    '        Do While Not rstTextSettingDtl.EOF
    '            strColumn = strColumn & rstTextSettingDtl("ColumnName") & " AS " & rstTextSettingDtl("ColumnHeader") & ","
    '            rstTextSettingDtl.MoveNext()
    '        Loop
    '        strColumn = Left(strColumn, Len(strColumn) - 1)

    '        If Len(Trim(strSQLWhere)) > 0 Then
    '            strSQLStatement = "SELECT " & strColumn & " FROM " & strTable & " WHERE " & strSQLWhere
    '        Else
    '            strSQLStatement = "SELECT " & strColumn & " FROM " & strTable
    '        End If

    '        If blnDebug Then objHelper.Writes(strProcess & "Copy Data from SQL into DBF Task")
    '        Dim oCustomTask2 As DTS.DataPumpTask2
    '        oTask = goPackage.Tasks.New("DTSDataPumpTask")
    '        oTask.Name = "Copy Data from SQL into DBF Task"
    '        oCustomTask2 = oTask.CustomTask

    '        oCustomTask2.Name = "Copy Data from SQL into DBF Task"
    '        oCustomTask2.Description = "Copy Data from SQL into DBF Task"

    '        oCustomTask2.SourceConnectionID = 1
    '        oCustomTask2.SourceSQLStatement = strSQLStatement

    '        oCustomTask2.DestinationConnectionID = 2
    '        oCustomTask2.DestinationObjectName = strDBFileName
    '        oCustomTask2.ProgressRowCount = 1000
    '        oCustomTask2.MaximumErrorCount = 0
    '        oCustomTask2.FetchBufferSize = 1
    '        oCustomTask2.UseFastLoad = True
    '        oCustomTask2.InsertCommitSize = 0
    '        oCustomTask2.ExceptionFileColumnDelimiter = "|"
    '        oCustomTask2.ExceptionFileRowDelimiter = vbCrLf
    '        oCustomTask2.AllowIdentityInserts = False
    '        oCustomTask2.FirstRow = 0
    '        oCustomTask2.LastRow = 0
    '        oCustomTask2.FastLoadOptions = 2
    '        oCustomTask2.ExceptionFileOptions = 1
    '        oCustomTask2.DataPumpOptions = 0

    '        Call oCustomTask2_Trans_Sub1(oCustomTask2, strTextID)


    '        goPackage.Tasks.Add(oTask)
    '        oCustomTask2 = Nothing
    '        oTask = Nothing
    '        rstTextSetting.Close()
    '        rstTextSettingDtl.Close()
    '        rstTextSetting = Nothing
    '        rstTextSettingDtl = Nothing
    '        If blnDebug Then objHelper.Writes(strProcess & "END")

    '    End Sub

    '    Private Sub oCustomTask2_Trans_Sub1(ByVal oCustomTask2 As Object, _
    '        ByVal strTextID As String)

    '        Dim rstTextSettingDtl As ADODB.Recordset
    '        rstTextSettingDtl = objDB.CreateRSfromView("MOSTextSettingDtl", "ColumnHeader, " & _
    '            " DataType, Length, IsNull(DecPoint, 0) DecPoint", "TextId='" & strTextID & "'", , "ColumnPosition")
    '        Dim intOrdinal As Integer
    '        intOrdinal = 1
    '        Dim oTransformation As DTS.Transformation2
    '        Dim oTransProps As DTS.Properties
    '        Dim oColumn As DTS.Column
    '        oTransformation = oCustomTask2.Transformations.New("DTS.DataPumpTransformCopy")
    '        oTransformation.Name = "DTSTransformation__1"
    '        oTransformation.TransformFlags = 63
    '        oTransformation.ForceSourceBlobsBuffered = 0
    '        oTransformation.ForceBlobsInMemory = False
    '        oTransformation.InMemoryBlobSize = 1048576
    '        oTransformation.TransformPhases = 4
    '        Do While Not rstTextSettingDtl.EOF
    '            oColumn = oTransformation.SourceColumns.New(rstTextSettingDtl("ColumnHeader"), intOrdinal)
    '            oColumn.Name = rstTextSettingDtl("ColumnHeader")
    '            oColumn.Ordinal = intOrdinal
    '            If rstTextSettingDtl("DataType") = "C" Then
    '                oColumn.Flags = 8
    '                oColumn.DataType = 129
    '                oColumn.Size = rstTextSettingDtl("length")
    '                oColumn.Precision = 0
    '                oColumn.NumericScale = 0
    '            ElseIf rstTextSettingDtl("DataType") = "N" Then
    '                oColumn.Flags = 120
    '                oColumn.DataType = 131
    '                oColumn.Size = 0
    '                oColumn.Precision = rstTextSettingDtl("length")
    '                oColumn.NumericScale = rstTextSettingDtl("DecPoint")
    '            ElseIf rstTextSettingDtl("DataType") = "D" Then
    '                oColumn.Flags = 24
    '                oColumn.Size = 0
    '                oColumn.DataType = 135
    '                oColumn.Precision = 0
    '                oColumn.NumericScale = 0
    '            Else
    '                oColumn.Flags = 8
    '                oColumn.DataType = 129
    '                oColumn.Size = rstTextSettingDtl("length")
    '                oColumn.Precision = 0
    '                oColumn.NumericScale = 0
    '            End If
    '            oColumn.Nullable = True
    '            oTransformation.SourceColumns.Add(oColumn)
    '            oColumn = Nothing
    '            intOrdinal = intOrdinal + 1
    '            rstTextSettingDtl.MoveNext()
    '        Loop


    '        intOrdinal = 1
    '        rstTextSettingDtl.MoveFirst()
    '        Do While Not rstTextSettingDtl.EOF
    '            oColumn = oTransformation.DestinationColumns.New(rstTextSettingDtl("ColumnHeader"), intOrdinal)
    '            oColumn.Name = rstTextSettingDtl("ColumnHeader")
    '            oColumn.Ordinal = intOrdinal
    '            If rstTextSettingDtl("DataType") = "C" Then
    '                oColumn.Flags = 102
    '                oColumn.DataType = 130
    '                oColumn.Size = rstTextSettingDtl("length")
    '                oColumn.Precision = 0
    '                oColumn.NumericScale = 0
    '            ElseIf rstTextSettingDtl("DataType") = "N" Then
    '                oColumn.Flags = 120
    '                oColumn.DataType = 131
    '                oColumn.Size = 0
    '                oColumn.Precision = rstTextSettingDtl("length")
    '                oColumn.NumericScale = rstTextSettingDtl("DecPoint")
    '            ElseIf rstTextSettingDtl("DataType") = "D" Then
    '                oColumn.Flags = 24
    '                oColumn.DataType = 135
    '                oColumn.Size = 0
    '                oColumn.Precision = 0
    '                oColumn.NumericScale = 0
    '            Else
    '                oColumn.DataType = 129
    '                oColumn.Flags = 8
    '                oColumn.Size = rstTextSettingDtl("length")
    '                oColumn.Precision = 0
    '                oColumn.NumericScale = 0
    '            End If
    '            oColumn.Nullable = True
    '            oTransformation.DestinationColumns.Add(oColumn)
    '            oColumn = Nothing
    '            intOrdinal = intOrdinal + 1
    '            rstTextSettingDtl.MoveNext()
    '        Loop

    '        oTransProps = oTransformation.TransformServerProperties


    '        oTransProps = Nothing

    '        oCustomTask2.Transformations.Add(oTransformation)
    '        oTransformation = Nothing

    '    End Sub


    '    Private Sub Class_Initialize()
    '        objDB = New Connect_DB.DBHelper
    '        objHelper = New Connect_DB.PublicHelp
    '    End Sub

    '    Private Sub Class_Terminate()
    '        objDB = Nothing
    '        objHelper = Nothing
    '    End Sub


End Class
