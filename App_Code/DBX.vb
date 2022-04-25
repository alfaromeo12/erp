Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Public Class DBX
    Private oCon As Data.SqlClient.SqlConnection
    Private _strQuery As String

    Sub New(strQuery As String)
        ' TODO: Complete member initialization 
        _strQuery = strQuery
    End Sub

    Property CommandType As CommandType

    Property Connection As SqlConnection

    Public Function getConnectionString() As String
        Return ConfigurationManager.ConnectionStrings("connection").ConnectionString
    End Function

    'mp: make parameter
    Public Function MP( _
        ByVal strName As String, ByVal oType As Data.SqlDbType, _
        ByVal strValue As String, _
        Optional ByVal intSize As Integer = 0, _
        Optional ByVal oDirec As Data.ParameterDirection = Data.ParameterDirection.Input) As Data.SqlClient.SqlParameter

        If Len(Trim(strValue)) <= 0 Then
            strValue = Nothing
        End If
        Dim oParam As New Data.SqlClient.SqlParameter
        With oParam
            .ParameterName = strName
            .SqlDbType = oType
            .Size = intSize
            .Value = strValue
            .Direction = oDirec
        End With
        Return oParam
    End Function

    Public Function MPByte( _
        ByVal strName As String, ByVal oType As Data.SqlDbType, _
        ByVal strValue As Byte(), _
        Optional ByVal intSize As Integer = 0, _
        Optional ByVal oDirec As Data.ParameterDirection = Data.ParameterDirection.Input) As Data.SqlClient.SqlParameter

        'If Len(Trim(strValue)) <= 0 Then
        '    strValue = Nothing
        'End If
        Dim oParam As New Data.SqlClient.SqlParameter
        With oParam
            .ParameterName = strName
            .SqlDbType = oType
            .Size = intSize
            .Value = strValue
            .Direction = oDirec
        End With
        Return oParam
    End Function

    Public Function CreateSDRFromSQLSelect(ByVal strSelect As String) As Data.SqlClient.SqlDataReader


        Dim oSDS As New SqlDataSource(getConnectionString(), strSelect)
        Try
            oSDS.DataSourceMode = SqlDataSourceMode.DataReader
            CreateSDRFromSQLSelect = oSDS.Select(New System.Web.UI.DataSourceSelectArguments)
        Catch ex As Exception
            Throw
        Finally
            oSDS.Dispose()
            oSDS = Nothing
            Close()
        End Try

    End Function

    Public Function CreateSDRFromSP(ByVal strSPName As String, _
            ByVal ParamArray arrFields() As Data.SqlClient.SqlParameter) As Data.SqlClient.SqlDataReader

        If oCon.State = Data.ConnectionState.Closed Then
            oCon.Open()
        End If
        Dim oCom As New Data.SqlClient.SqlCommand(strSPName, oCon)
        oCom.CommandTimeout = 0
        Try
            Dim byCtr As Byte
            oCom.CommandType = Data.CommandType.StoredProcedure
            For byCtr = 0 To arrFields.Length - 1
                oCom.Parameters.Add(arrFields(byCtr))
            Next
            CreateSDRFromSP = oCom.ExecuteReader()
        Catch ex As Exception
            Throw
        Finally
            oCom.Dispose()
        End Try
    End Function


    Public Function CreateSDRFromExecSQL(ByVal strSQL As String) As Data.SqlClient.SqlDataReader

        If oCon.State = Data.ConnectionState.Closed Then
            oCon.Open()
        End If
        Dim oCom As New Data.SqlClient.SqlCommand(strSQL, oCon)
        oCom.CommandTimeout = 0
        Try
            oCom.CommandType = Data.CommandType.Text
            CreateSDRFromExecSQL = oCom.ExecuteReader()
        Catch ex As Exception
            Throw
        Finally
            oCom.Dispose()
        End Try
    End Function

    Public Function ExecSPReturnParam(ByVal strSPName As String, _
            ByVal ParamArray arrFields() As System.Data.SqlClient.SqlParameter) As System.Data.SqlClient.SqlParameterCollection
        If oCon.State = System.Data.ConnectionState.Closed Then
            oCon.Open()
        End If
        Dim oST As System.Data.SqlClient.SqlTransaction
        oST = oCon.BeginTransaction(System.Data.IsolationLevel.ReadCommitted)
        Dim oCom As New Data.SqlClient.SqlCommand(strSPName, oCon)
        oCom.CommandTimeout = 0
        Try
            Dim byCtr As Byte
            oCom.Transaction = oST
            oCom.CommandType = Data.CommandType.StoredProcedure
            For byCtr = 0 To arrFields.Length - 1
                oCom.Parameters.Add(arrFields(byCtr))
            Next
            'oCom.Parameters.Add(MP("@retval", Data.SqlDbType.BigInt, 0, 30, System.Data.ParameterDirection.Output))

            oCom.ExecuteNonQuery()
            ExecSPReturnParam = oCom.Parameters
            oST.Commit()
        Catch ex As Exception
            oST.Rollback()
            Throw
        Finally
            oCom.Dispose()
            oST.Dispose()
            oCom = Nothing
            oST = Nothing
            Close()
        End Try

    End Function

    Public Function ExecSPReturnParamNoTxn(ByVal strSPName As String, _
        ByVal ParamArray arrFields() As System.Data.SqlClient.SqlParameter) As System.Data.SqlClient.SqlParameterCollection
        If oCon.State = System.Data.ConnectionState.Closed Then
            oCon.Open()
        End If
        Dim oCom As New Data.SqlClient.SqlCommand(strSPName, oCon)
        oCom.CommandTimeout = 0
        Try
            Dim byCtr As Byte
            oCom.CommandType = Data.CommandType.StoredProcedure
            For byCtr = 0 To arrFields.Length - 1
                oCom.Parameters.Add(arrFields(byCtr))
            Next
            'oCom.Parameters.Add(MP("@retval", Data.SqlDbType.BigInt, 0, 30, System.Data.ParameterDirection.Output))

            oCom.ExecuteNonQuery()
            ExecSPReturnParamNoTxn = oCom.Parameters
        Catch ex As Exception
            Throw
        Finally
            oCom.Dispose()
            oCom = Nothing
            Close()
        End Try
    End Function


    Public Function ExecSPReturnInteger(ByVal strSPName As String, _
            ByVal ParamArray arrFields() As Data.SqlClient.SqlParameter) As Integer
        If oCon.State = Data.ConnectionState.Closed Then
            oCon.Open()
        End If
        Dim oST As System.Data.SqlClient.SqlTransaction
        oST = oCon.BeginTransaction(System.Data.IsolationLevel.ReadCommitted)

        Dim oCom As New Data.SqlClient.SqlCommand(strSPName, oCon)
        oCom.CommandTimeout = 0
        Try

            Dim byCtr As Byte
            oCom.CommandType = Data.CommandType.StoredProcedure
            oCom.Transaction = oST
            For byCtr = 0 To arrFields.Length - 1
                oCom.Parameters.Add(arrFields(byCtr))
            Next
            oCom.Parameters.Add(MP("@retval", Data.SqlDbType.BigInt, 0, 30, Data.ParameterDirection.Output))
            oCom.ExecuteNonQuery()
            ExecSPReturnInteger = oCom.Parameters("@retval").Value
            oST.Commit()
        Catch ex As Exception
            oST.Rollback()
            Throw
        Finally
            oCom.Dispose()
            oST.Dispose()
            oCom = Nothing
            oST = Nothing
            Close()
        End Try
    End Function

    Public Function ExecSPRetIntegerNoTxn(ByVal strSPName As String, ByVal ParamArray arrFields() As Data.SqlClient.SqlParameter) As Integer
        If oCon.State = Data.ConnectionState.Closed Then
            oCon.Open()
        End If

        Dim oCom As New Data.SqlClient.SqlCommand(strSPName, oCon)
        oCom.CommandTimeout = 0
        Try

            Dim byCtr As Byte
            oCom.CommandType = Data.CommandType.StoredProcedure
            For byCtr = 0 To arrFields.Length - 1
                oCom.Parameters.Add(arrFields(byCtr))
            Next
            oCom.Parameters.Add(MP("@retval", Data.SqlDbType.BigInt, 0, 30, Data.ParameterDirection.Output))
            oCom.ExecuteNonQuery()
            ExecSPRetIntegerNoTxn = oCom.Parameters("@retval").Value
        Catch ex As Exception
            Throw
        Finally
            oCom.Dispose()
            oCom = Nothing
            Close()
        End Try
    End Function


    Public Sub ExecSP(ByVal strSPName As String, ByVal ParamArray arrFields() As Data.SqlClient.SqlParameter)
        Dim oCom As New Data.SqlClient.SqlCommand(strSPName, oCon)
        oCom.CommandTimeout = 0

        If oCon.State = Data.ConnectionState.Closed Then
            oCon.Open()
        End If

        Dim oST As System.Data.SqlClient.SqlTransaction
        oST = oCon.BeginTransaction(System.Data.IsolationLevel.ReadCommitted)

        Try

            Dim bybyCtr As Byte
            oCom.CommandType = Data.CommandType.StoredProcedure
            oCom.Transaction = oST
            For bybyCtr = 0 To arrFields.Length - 1
                oCom.Parameters.Add(arrFields(bybyCtr))
            Next

            oCom.ExecuteNonQuery()
            oST.Commit()
        Catch ex As Exception
            oST.Rollback()
            Throw
        Finally
            oST.Dispose()
            oCom.Dispose()
            oCom = Nothing
            oST = Nothing
            Close()
        End Try
    End Sub
    Public Function ExecSPWithRC(ByVal strSPName As String, ByVal ParamArray arrFields() As Data.SqlClient.SqlParameter) As Integer
        Dim oCom As New Data.SqlClient.SqlCommand(strSPName, oCon)
        oCom.CommandTimeout = 0

        If oCon.State = Data.ConnectionState.Closed Then
            oCon.Open()
        End If

        Dim oST As System.Data.SqlClient.SqlTransaction
        oST = oCon.BeginTransaction(System.Data.IsolationLevel.ReadCommitted)

        Try

            Dim bybyCtr As Byte
            oCom.CommandType = Data.CommandType.StoredProcedure
            oCom.Transaction = oST
            For bybyCtr = 0 To arrFields.Length - 1
                oCom.Parameters.Add(arrFields(bybyCtr))
            Next
            'oCom.Parameters.Add("RetValue", SqlDbType.Int, 0, 30, )
            oCom.Parameters.Add(MP("RetValue", Data.SqlDbType.BigInt, 0, 30, Data.ParameterDirection.ReturnValue))
            oCom.ExecuteNonQuery()
            ExecSPWithRC = oCom.Parameters("RetValue").Value
            oST.Commit()
        Catch ex As Exception
            oST.Rollback()
            Throw
        Finally
            oST.Dispose()
            oCom.Dispose()
            oCom = Nothing
            oST = Nothing
            Close()
        End Try
    End Function

    Public Sub ExecSPNoTxn(ByVal strSPName As String, ByVal ParamArray arrFields() As Data.SqlClient.SqlParameter)

        Dim oCom As New Data.SqlClient.SqlCommand(strSPName, oCon)
        oCom.CommandTimeout = 0

        If oCon.State = Data.ConnectionState.Closed Then
            oCon.Open()
        End If

        Try
            Dim byCtr As Byte
            oCom.CommandType = Data.CommandType.StoredProcedure
            For byCtr = 0 To arrFields.Length - 1
                oCom.Parameters.Add(arrFields(byCtr))
            Next

            oCom.ExecuteNonQuery()
        Catch ex As Exception
            Throw
        Finally
            oCom.Dispose()
            oCom = Nothing
            Close()
        End Try
    End Sub


    Public Function ExecSQL(ByVal strSQLSyntax As String) As Integer
        If oCon.State = Data.ConnectionState.Closed Then
            oCon.Open()
        End If
        Dim oST As System.Data.SqlClient.SqlTransaction
        oST = oCon.BeginTransaction(System.Data.IsolationLevel.ReadCommitted)
        Dim oCom As New Data.SqlClient.SqlCommand(strSQLSyntax, oCon)
        oCom.CommandTimeout = 0
        Try
            oCom.Transaction = oST
            oCom.CommandType = Data.CommandType.Text
            oCom.ExecuteNonQuery()
            oST.Commit()
            ExecSQL = 0
        Catch ex As Exception
            ExecSQL = -1
            oST.Rollback()
            Throw
        Finally
            oST.Dispose()
            oCom.Dispose()
            oCom = Nothing
            oST = Nothing
            Close()
        End Try
    End Function

    Public Function ExecSQLNoTxn(ByVal strSQLSyntax As String) As Integer
        If oCon.State = Data.ConnectionState.Closed Then
            oCon.Open()
        End If
        Dim oCom As New Data.SqlClient.SqlCommand(strSQLSyntax, oCon)
        oCom.CommandTimeout = 0
        Try
            oCom.CommandType = Data.CommandType.Text
            oCom.ExecuteNonQuery()
            ExecSQLNoTxn = 0
        Catch ex As Exception
            ExecSQLNoTxn = -1
            Throw
        Finally
            oCom.Dispose()
            oCom = Nothing
            Close()
        End Try
    End Function

    Public Function ExecSQLWithParam(ByVal strSQLSyntax As String, _
            ByVal ParamArray arrFields() As Data.SqlClient.SqlParameter) As Integer
        If oCon.State = Data.ConnectionState.Closed Then
            oCon.Open()
        End If
        Dim oST As System.Data.SqlClient.SqlTransaction
        oST = oCon.BeginTransaction(System.Data.IsolationLevel.ReadCommitted)
        Dim oCom As New Data.SqlClient.SqlCommand(strSQLSyntax, oCon)
        oCom.CommandTimeout = 0
        Try
            oCom.Transaction = oST
            oCom.CommandType = Data.CommandType.Text
            Dim byCtr As Byte
            For byCtr = 0 To arrFields.Length - 1
                oCom.Parameters.Add(arrFields(byCtr))
            Next

            oCom.ExecuteNonQuery()
            oST.Commit()
            ExecSQLWithParam = 0
        Catch ex As Exception
            ExecSQLWithParam = -1
            oST.Rollback()
            Throw
        Finally
            oST.Dispose()
            oCom.Dispose()
            oCom = Nothing
            oST = Nothing
            Close()
        End Try
    End Function

    Public Function ExecSQLWithParamNoTxn(ByVal strSQLSyntax As String, _
            ByVal ParamArray arrFields() As Data.SqlClient.SqlParameter) As Integer
        If oCon.State = Data.ConnectionState.Closed Then
            oCon.Open()
        End If
        Dim oCom As New Data.SqlClient.SqlCommand(strSQLSyntax, oCon)
        oCom.CommandTimeout = 0
        Try
            oCom.CommandType = Data.CommandType.Text
            Dim byCtr As Byte
            For byCtr = 0 To arrFields.Length - 1
                oCom.Parameters.Add(arrFields(byCtr))
            Next

            oCom.ExecuteNonQuery()
            ExecSQLWithParamNoTxn = 0
        Catch ex As Exception
            ExecSQLWithParamNoTxn = -1
            Throw
        Finally
            oCom.Dispose()
            oCom = Nothing
            Close()
        End Try
    End Function
    Public Shared Function ReadRecordsToDataTable(ByVal SQLText As String, ByVal ConString As String, Optional ByVal IsStoredProcedure As Boolean = False, Optional ByVal Params() As ParamSQL = Nothing) As DataTable

        Dim cnSQL As SqlConnection = Nothing
        Dim cmSQL As SqlCommand
        Dim daSQL As SqlDataAdapter
        Dim pParam As SqlParameter

        Dim dtSQL As New DataTable


        Dim JumlahParameter As Short

        If IsNothing(Params) Then
            JumlahParameter = -1
        Else
            JumlahParameter = Params.GetUpperBound(0)
        End If

        Try
            cnSQL = New SqlConnection
            cnSQL.ConnectionString = ConString
            cmSQL = New SqlCommand
            cmSQL.Connection = cnSQL
            cmSQL.CommandText = SQLText

            daSQL = New SqlDataAdapter
            If IsStoredProcedure Then
                cmSQL.CommandType = CommandType.StoredProcedure
            End If

            cnSQL.Open()

            Dim i As Short

            For i = 0 To JumlahParameter
                pParam = New SqlParameter(Params(i).ParameterName, Params(i).ParameterValue)
                pParam.Direction = ParameterDirection.Input
                cmSQL.Parameters.Add(pParam)
            Next
            daSQL.SelectCommand = cmSQL
            daSQL.Fill(dtSQL)

            cnSQL.Close()

        Catch
            dtSQL.Clear()
            If cnSQL.State = ConnectionState.Open Then cnSQL.Close()
            Throw
        End Try
        Return dtSQL
    End Function

    Private Function GetMidString( _
        ByVal strConnection As String, _
        ByVal intBeginPos As Integer) As String

        Dim intEndPos As Integer

        intBeginPos = InStr(intBeginPos, strConnection, "=", vbTextCompare)
        intBeginPos = intBeginPos + 1
        intEndPos = InStr(intBeginPos, strConnection, ";", vbTextCompare)
        If intEndPos < 0 Then intEndPos = Len(strConnection)
        GetMidString = Mid(strConnection, intBeginPos, intEndPos - intBeginPos)
    End Function

    Public Function GetParamConnection( _
        ByRef strConnection As String, _
        ByRef strServerName As String, _
        ByRef strDBName As String, _
        ByRef strUserName As String, _
        ByRef strPassword As String, _
        Optional ByRef strTrustedCon As String = "") As Long

        Dim intBeginPos As Integer
        'Dim intEndPos As Integer
        Dim lngErrNo As Long
        Dim strConnectionUpper As String
        lngErrNo = 0

        strConnectionUpper = UCase(getConnectionString())
        strConnection = getConnectionString()

        intBeginPos = InStr(1, strConnectionUpper, "DATA SOURCE", vbTextCompare)
        If intBeginPos > 0 Then
            strServerName = GetMidString(strConnection, intBeginPos)
        Else
            lngErrNo = -1
        End If

        intBeginPos = InStr(1, strConnectionUpper, "INITIAL CATALOG", vbTextCompare)
        If intBeginPos > 0 Then
            strDBName = GetMidString(strConnection, intBeginPos)
        Else
            lngErrNo = -2
        End If

        intBeginPos = InStr(1, strConnectionUpper, "USER ID", vbTextCompare)
        If intBeginPos > 0 Then
            strUserName = GetMidString(strConnection, intBeginPos)
        Else
            lngErrNo = -3
        End If

        intBeginPos = InStr(1, strConnectionUpper, "PASSWORD", vbTextCompare)
        If intBeginPos > 0 Then
            strPassword = GetMidString(strConnection, intBeginPos)
        Else
            lngErrNo = -4
        End If

        intBeginPos = InStr(1, strConnectionUpper, "TRUSTED_CONNECTION", vbTextCompare)
        If intBeginPos > 0 Then
            strTrustedCon = GetMidString(strConnection, intBeginPos)
        Else
            lngErrNo = -5
        End If

        GetParamConnection = lngErrNo
    End Function

    Public Class ParamSQL
#Region " Private Attributes "
        Private Nama As String
        Private Nilai As Object

#End Region
#Region " Constructors "
        Public Sub New()
            MyBase.New()
            Nama = ""
            Nilai = Nothing
        End Sub
        Public Sub New(ByVal ParameterName As String, ByVal ParameterValue As Object)
            MyBase.New()
            Nama = ParameterName
            Nilai = ParameterValue
        End Sub
#End Region
#Region " Properties "
        Public Property ParameterName() As String
            Get
                Return Nama
            End Get
            Set(ByVal Value As String)
                Nama = Value
            End Set
        End Property
        Public Property ParameterValue() As Object
            Get
                Return Nilai
            End Get
            Set(ByVal Value As Object)
                Nilai = Value
            End Set
        End Property
#End Region

    End Class
    Public Sub New()
        Dim strCon As String = getConnectionString()
        oCon = New Data.SqlClient.SqlConnection(strCon)
    End Sub

    Public Sub Close()
        If oCon.State = System.Data.ConnectionState.Open Then
            oCon.Close()
        End If
    End Sub

    Function MPByte(p1 As String, sqlDbType As SqlDbType, OArtwork As FileUpload, imgByte As Byte()) As Object
        Throw New NotImplementedException
    End Function




End Class
