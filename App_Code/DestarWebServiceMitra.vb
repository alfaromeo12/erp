Imports System.Data
Imports System.Web
Imports System.Web.Script.Services
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Xml
Imports Newtonsoft.Json
Imports System.Data.SqlClient
Imports System.ServiceModel.Web
Imports System.Net

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
<ScriptService()>
Public Class DestarWebServiceMitra
    Inherits System.Web.Services.WebService
    Dim oSC As New System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("connection").ConnectionString())
    <WebMethod()> _
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function
    Public Shared Function GetJson(ByVal dt As DataTable) As String
        Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer()
        serializer.MaxJsonLength = Integer.MaxValue

        Dim rows As New List(Of Dictionary(Of String, Object))()
        Dim row As Dictionary(Of String, Object) = Nothing
        For Each dr As DataRow In dt.Rows
            row = New Dictionary(Of String, Object)()
            For Each dc As DataColumn In dt.Columns

                row.Add(dc.ColumnName.Trim(), dr(dc))

            Next
            rows.Add(row)
        Next
        Return serializer.Serialize(rows)
    End Function
    <WebMethod()>
    Public Function MitrasLogin(ByVal strUserName As String,
         ByVal strPwd As String, ByVal strHardwareID As String) As String
        Dim strPassword As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        ' Dim oSDR As System.Data.SqlClient.SqlDataReader
        strPassword = Replace(RC4Engine.rc4(strPwd), "'", "''")
        oSC.Open()
        strSQL = " SELECT AUP.USERID, AUP.USERNAME, AUP.PASSWORD,IDNUMBER,AUP.ACTIVE,AUP.SERVICETYPEID,ST.SERVICETYPENAME,AUP.SERVICETYPEDTLID,STD.SERVICETYPEDTLNAME,AUP.PARTNERTYPEID,PT.PARTNERTYPENAME,AUP.HARDWAREID,AUP.STATUSMITRA FROM APPUSERPARTNER AUP  " & _
                                           " LEFT OUTER JOIN PARTNERTYPE PT ON AUP.PARTNERTYPEID = PT.PARTNERTYPEID  " & _
                                           " LEFT OUTER JOIN SERVICETYPE ST ON AUP.SERVICETYPEID = ST.SERVICETYPEID" & _
                                           " LEFT OUTER JOIN SERVICETYPEDTL STD ON AUP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                                             "WHERE AUP.DELETESTS = 0 And AUP.ACTIVE = 1 And AUP.USERNAME = '" & strUserName & "' AND AUP.PASSWORD = '" & strPassword & "'"

        Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)
        If da.Fill(dt) = 0 Then
            Return HttpStatusCode.NotFound
            oSC.Close()
        Else
            oSC.Close()

            Dim strSQL1 As String = ""
            Dim dt1 As DataTable = New DataTable
            Dim dt2 As DataTable = New DataTable
            Dim oSC1 As New System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("connection").ConnectionString())
            Dim oSC2 As New System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("connection").ConnectionString())
            oSC1.Open()

            strSQL1 = " UPDATE APPUSERPARTNER " & _
                        " SET HARDWAREID = '-'" & _
                      " WHERE HARDWAREID = '" & strHardwareID & "'"
            Dim da1 As New System.Data.SqlClient.SqlDataAdapter(strSQL1, oSC1)
            da1.Fill(dt1)
            oSC1.Close()

            oSC2.Open()
            strSQL1 = " UPDATE APPUSERPARTNER " & _
                        " SET HARDWAREID = '" & strHardwareID & "'" & _
                      " WHERE USERNAME = '" & strUserName & "'"
            Dim da2 As New System.Data.SqlClient.SqlDataAdapter(strSQL1, oSC2)
            da2.Fill(dt2)
            oSC2.Close()
            Return strReturn
        End If
    End Function
    <WebMethod()>
    Public Function MitrasLogOut(ByVal strHardwareID As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " UPDATE APPUSERPARTNER " & _
                    " SET HARDWAREID = '-'" & _
                  " WHERE HARDWAREID = '" & strHardwareID & "'"
        Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)
        If da.Fill(dt) = 0 Then
            Return HttpStatusCode.NotFound
        Else
            Return HttpStatusCode.OK
        End If
        oSC.Close()
    End Function
    <WebMethod()>
    Public Function MitraRegister(ByVal strUserName As String, ByVal strPwd As String,
                                  ByVal strEmail As String, ByVal strMobile As String,
                                  ByVal strGender As Integer, ByVal strHrdwareID As String) As String


        Dim strPassword As String
        Dim objDB As New DBX
        strPassword = Replace(RC4Engine.rc4(strPwd), "'", "''")
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByteProfile As Byte() = Nothing
        'Dim imgByteKtp As Byte() = Nothing
        'Dim imgByteSkck As Byte() = Nothing
        'Dim imgByteSim As Byte() = Nothing
        'Dim imgByteStnk As Byte() = Nothing

        'imgByteProfile = Convert.FromBase64String(strImageProfile)
        'imgByteKtp = Convert.FromBase64String(strImageKtp)
        'imgByteSkck = Convert.FromBase64String(strImageSkck)
        'imgByteSim = Convert.FromBase64String(strImageSim)
        'imgByteStnk = Convert.FromBase64String(strImageStnk)
        Try
            oSQLParam = objDB.ExecSPReturnParam("APPUSERPARTNERADDX",
                                                        objDB.MP("@USERNAME", Data.SqlDbType.VarChar, strUserName),
                                                        objDB.MP("@PASSWORD", Data.SqlDbType.VarChar, strPassword),
                                                        objDB.MP("@EMAIL", Data.SqlDbType.VarChar, strEmail),
                                                        objDB.MP("@MOBILENO", Data.SqlDbType.NVarChar, strMobile),
                                                        objDB.MP("@GENDER", Data.SqlDbType.Int, strGender),
                                                        objDB.MP("@HARDWAREID", Data.SqlDbType.VarChar, strHrdwareID),
                                                        objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetval, 10, Data.ParameterDirection.Output))
            intRetval = oSQLParam("@RETVAL").Value.ToString()

            ' objDB.MPByte("@IMAGE", Data.SqlDbType.Image, imgByte)
        Catch ex As Exception
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        If intRetval = -1 Then
            Return HttpStatusCode.BadRequest
        Else
            Return HttpStatusCode.OK
        End If
    End Function
    <WebMethod()>
    Public Function CekHardwareIDMitra(ByVal strHardwareID As String, ByVal strUserName As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT AUP.USERNAME, AUP.PASSWORD,AUP.ACTIVE,AUP.PARTNERTYPEID,PT.PARTNERTYPENAME,AUP.HARDWAREID FROM APPUSERPARTNER AUP  " & _
                                           " LEFT OUTER JOIN PARTNERTYPE PT ON AUP.PARTNERTYPEID = PT.PARTNERTYPEID " & _
                                            " WHERE HARDWAREID = '" & strHardwareID & "' AND USERNAME = '" & strUserName & "' "
        Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)

        If da.Fill(dt) = 0 Then
            Return HttpStatusCode.NotFound
        Else
            Return strReturn
        End If
        oSC.Close()
    End Function
    <WebMethod()>
    Public Function UpdateHardwareIDMitra(ByVal strHardwareID As String, ByVal strUserName As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " UPDATE APPUSERCLIENT " & _
                    " SET HARDWAREID = '" & strHardwareID & "'" & _
                  " WHERE USERNAME = '" & strUserName & "'"
        Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)
        If da.Fill(dt) = 0 Then
            Return HttpStatusCode.NotFound
        Else
            Return HttpStatusCode.OK
        End If
        oSC.Close()
    End Function
    '<WebMethod()>
    'Public Function GetddlMitraType() As String
    '    Dim objDB As New DBX
    '    Dim strSQL As String = ""
    '    Dim dt As DataTable = New DataTable
    '    oSC.Open()
    '    strSQL = " SELECT NULL AS PARTNERTYPEID, '[Mitra type]' AS PARTNERTYPENAME UNION ALL " & _
    '             "SELECT PARTNERTYPEID, PARTNERTYPENAME FROM PARTNERTYPE WHERE (DELETESTS= 0) ORDER BY PARTNERTYPENAME "
    '    Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '    da.Fill(dt)
    '    Dim strReturn As String = GetJson(dt)
    '    If da.Fill(dt) = 0 Then
    '        Return HttpStatusCode.NotFound
    '    Else
    '        Return strReturn
    '    End If
    '    oSC.Close()
    'End Function
    '<WebMethod()>
    'Public Function GetddlServiceType() As String
    '    Dim objDB As New DBX
    '    Dim strSQL As String = ""
    '    Dim dt As DataTable = New DataTable
    '    oSC.Open()
    '    strSQL = " SELECT NULL AS SERVICETYPEID, '[Service Type]' AS SERVICETYPENAME UNION ALL" & _
    '             " SELECT SERVICETYPEID, SERVICETYPENAME FROM SERVICETYPE WHERE (DELETESTS= 0) ORDER BY SERVICETYPENAME "
    '    Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '    da.Fill(dt)
    '    Dim strReturn As String = GetJson(dt)
    '    If da.Fill(dt) = 0 Then
    '        Return HttpStatusCode.NotFound
    '    Else
    '        Return strReturn
    '    End If
    '    oSC.Close()
    'End Function
    '<WebMethod()>
    'Public Function GetddlServiceTypeDdl() As String
    '    Dim objDB As New DBX
    '    Dim strSQL As String = ""
    '    Dim dt As DataTable = New DataTable
    '    oSC.Open()
    '    strSQL = " SELECT NULL AS SERVICETYPEDTLID, '[Service Type Detail]' AS SERVICETYPEDTLNAME UNION ALL" & _
    '             " SELECT SERVICETYPEDTLID, SERVICETYPEDTLNAME FROM SERVICETYPEDTL WHERE (DELETESTS= 0) ORDER BY SERVICETYPEDTLNAME "
    '    Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '    da.Fill(dt)
    '    Dim strReturn As String = GetJson(dt)
    '    If da.Fill(dt) = 0 Then
    '        Return HttpStatusCode.NotFound
    '    Else
    '        Return strReturn
    '    End If
    '    oSC.Close()
    'End Function
    '<WebMethod()>
    'Public Function GetddlArmada() As String
    '    Dim objDB As New DBX
    '    Dim strSQL As String = ""
    '    Dim dt As DataTable = New DataTable
    '    oSC.Open()
    '    strSQL = " SELECT NULL AS ARMADAID,NULL AS ARMADACODE, '[Armada]' AS ARMADANAME UNION ALL SELECT ARMADAID" & _
    '             " ,STD.SERVICETYPEDTLNAME ,STD.SERVICETYPEDTLNAME + ' - ' + ARMADANAME AS COA " & _
    '             " FROM MASTERARMADA MA " & _
    '             " INNER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID" & _
    '             " WHERE(MA.DELETESTS = 0) ORDER BY ARMADANAME"
    '    Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '    da.Fill(dt)
    '    Dim strReturn As String = GetJson(dt)
    '    If da.Fill(dt) = 0 Then
    '        Return HttpStatusCode.NotFound
    '    Else
    '        Return strReturn
    '    End If
    '    oSC.Close()
    'End Function
    '<WebMethod()>
    'Public Function GetddlGender() As String
    '    Dim objDB As New DBX
    '    Dim strSQL As String = ""
    '    Dim dt As DataTable = New DataTable
    '    oSC.Open()
    '    strSQL = " SELECT NULL AS CODE, '[GENDER]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'GENDER') ORDER BY CODE"
    '    Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '    da.Fill(dt)
    '    Dim strReturn As String = GetJson(dt)
    '    If da.Fill(dt) = 0 Then
    '        Return HttpStatusCode.NotFound
    '    Else
    '        Return strReturn
    '    End If
    '    oSC.Close()
    'End Function
    <WebMethod()>
    Public Function ProductMitraAdd(ByVal strMitraCode As String, ByVal strMitra As Integer,
                                    ByVal strService As Integer, ByVal strServDtl As Integer,
                                    ByVal strArmadaType As Integer, ByVal strBrandPro As String,
                                    ByVal strPrice As String, ByVal strUnitPrice As Integer,
                                    ByVal strImageProduct As String, ByVal strQty As String,
                                    ByVal strDesc As String) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection

        Dim imgByteproduct As Byte() = Nothing

        imgByteproduct = Convert.FromBase64String(strImageProduct)
        Try
            oSQLParam = objDB.ExecSPReturnParam("PRODUCTMITRAADD",
                                                            objDB.MP("@PRODUCTMITRACODE", Data.SqlDbType.VarChar, strMitraCode),
                                                            objDB.MP("@MITRAID", Data.SqlDbType.Int, strMitra),
                                                            objDB.MP("@SERVICETYPEID", Data.SqlDbType.Int, strService),
                                                            objDB.MP("@SERVICETYPEDTLID", Data.SqlDbType.Int, strServDtl),
                                                            objDB.MP("@ARMADATYPEID", Data.SqlDbType.VarChar, strArmadaType),
                                                            objDB.MP("@PRODUCTBRAND", Data.SqlDbType.VarChar, strBrandPro),
                                                            objDB.MP("@PRICE", Data.SqlDbType.Decimal, strPrice),
                                                            objDB.MP("@UNITPRICE", Data.SqlDbType.Int, strUnitPrice),
                                                            objDB.MPByte("@IMAGEPRODUCT", Data.SqlDbType.Image, imgByteproduct),
                                                            objDB.MP("@QTY", Data.SqlDbType.Decimal, strQty),
                                                            objDB.MP("@DESCRIPTION", Data.SqlDbType.VarChar, strDesc),
                                                            objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetval, Data.ParameterDirection.Output))
            intRetval = oSQLParam("@RETVAL").Value.ToString()

            ' objDB.MPByte("@IMAGE", Data.SqlDbType.Image, imgByte)
        Catch ex As Exception
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        If intRetval = -1 Then
            Return HttpStatusCode.OK
        Else
            Return HttpStatusCode.BadRequest
        End If
    End Function
    <WebMethod()>
    Public Function UpdateLastLocMitra(ByVal strUserName As String, ByVal strServiceDtlId As String,
                                                ByVal strLongLat As String) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("PATNERLASTLOCADD",
                                                        objDB.MP("@USERNAME", Data.SqlDbType.VarChar, strUserName),
                                                        objDB.MP("@SERVICETYPEDTLID", Data.SqlDbType.Int, strServiceDtlId),
                                                        objDB.MP("@LONGLAT", Data.SqlDbType.NVarChar, strLongLat),
                                                        objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetval, 10, Data.ParameterDirection.Output))
            intRetval = oSQLParam("@RETVAL").Value.ToString()
        Catch ex As Exception
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        If intRetval = -1 Then
            Return HttpStatusCode.BadRequest
        Else
            Return HttpStatusCode.OK
        End If
    End Function
    <WebMethod()>
    Public Function UpdateStatusMitraBusy(ByVal strUserID As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("UPDATESTATUSMITRA_BUSY",
                                                        objDB.MP("@USERID", Data.SqlDbType.Int, strUserID),
                                                        objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetval, 10, Data.ParameterDirection.Output))
            intRetval = oSQLParam("@RETVAL").Value.ToString()
        Catch ex As Exception
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        If intRetval = -1 Then
            Return HttpStatusCode.OK
        Else
            Return HttpStatusCode.BadRequest

        End If
    End Function
    <WebMethod()>
    Public Function UpdateStatusMitraIdle(ByVal strUserID As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("UPDATESTATUSMITRA_IDLE",
                                                        objDB.MP("@USERID", Data.SqlDbType.Int, strUserID),
                                                        objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetval, 10, Data.ParameterDirection.Output))
            intRetval = oSQLParam("@RETVAL").Value.ToString()
        Catch ex As Exception
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        If intRetval = -1 Then
            Return HttpStatusCode.OK
        Else
            Return HttpStatusCode.BadRequest

        End If
    End Function
    <WebMethod()>
    Public Function UpdateStatusMitraSignOut(ByVal strUserID As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("UPDATESTATUSMITRA_SIGNOUT",
                                                        objDB.MP("@USERID", Data.SqlDbType.Int, strUserID),
                                                        objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetval, 10, Data.ParameterDirection.Output))
            intRetval = oSQLParam("@RETVAL").Value.ToString()
        Catch ex As Exception
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        If intRetval = -1 Then
            Return HttpStatusCode.OK
        Else
            Return HttpStatusCode.BadRequest

        End If
    End Function
    <WebMethod()>
    Public Function UpdateStatusActiveMitraOn(ByVal strUserID As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("UPDATESTATUSACTIVE_ON",
                                                        objDB.MP("@USERID", Data.SqlDbType.Int, strUserID),
                                                        objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetval, 10, Data.ParameterDirection.Output))
            intRetval = oSQLParam("@RETVAL").Value.ToString()
        Catch ex As Exception
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        If intRetval = -1 Then
            Return HttpStatusCode.OK
        Else
            Return HttpStatusCode.BadRequest

        End If
    End Function
    <WebMethod()>
    Public Function UpdateStatusActiveMitraOff(ByVal strUserID As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("UPDATESTATUSACTIVE_OFF",
                                                        objDB.MP("@USERID", Data.SqlDbType.Int, strUserID),
                                                        objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetval, 10, Data.ParameterDirection.Output))
            intRetval = oSQLParam("@RETVAL").Value.ToString()
        Catch ex As Exception
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        If intRetval = -1 Then
            Return HttpStatusCode.OK
        Else
            Return HttpStatusCode.BadRequest

        End If
    End Function
    <WebMethod()>
    Public Function AddTempDeBarang(ByVal strUserID As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()

        Dim Command As New SqlCommand("GETRANDOMDERDEBARANG", oSC)
        Command.CommandType = CommandType.StoredProcedure

        Command.Parameters.AddWithValue("@USERID", strUserID)

        Command.ExecuteNonQuery()

        Dim da As New System.Data.SqlClient.SqlDataAdapter(Command)

        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)
        If da.Fill(dt) = 0 Then
            Return HttpStatusCode.NotFound
        Else
            Return strReturn
        End If
        oSC.Close()
    End Function
    <WebMethod()>
    Public Function AddTempDeCar(ByVal strUserID As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()

        Dim Command As New SqlCommand("GETRANDOMDERDECAR", oSC)
        Command.CommandType = CommandType.StoredProcedure

        Command.Parameters.AddWithValue("@USERID", strUserID)

        Command.ExecuteNonQuery()

        Dim da As New System.Data.SqlClient.SqlDataAdapter(Command)

        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)
        If da.Fill(dt) = 0 Then
            Return HttpStatusCode.NotFound
        Else
            Return strReturn
        End If
        oSC.Close()
    End Function
    <WebMethod()>
    Public Function AddTempDeJek(ByVal strUserID As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()

        Dim Command As New SqlCommand("GETRANDOMDERDEJEK", oSC)
        Command.CommandType = CommandType.StoredProcedure

        Command.Parameters.AddWithValue("@USERID", strUserID)

        Command.ExecuteNonQuery()

        Dim da As New System.Data.SqlClient.SqlDataAdapter(Command)

        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)
        If da.Fill(dt) = 0 Then
            Return HttpStatusCode.NotFound
        Else
            Return strReturn
        End If
        oSC.Close()
    End Function

    <WebMethod()>
    Public Function GetCurrentLocationMitra() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT USERID,USERNAME, LONGITUDE,LATITUDE " & _
                " FROM APPUSERPARTNER "
        Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)
        If da.Fill(dt) = 0 Then
            Return HttpStatusCode.NotFound
        Else
            Return strReturn
        End If
        oSC.Close()
    End Function
    <WebMethod()>
    Public Function GetMitraDetailStatusOn() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT AUP.USERID,AUP.USERNAME,AUP.IDNUMBER,AUP.FULLNAME,AUP.PASSWORD " & _
                          ",CONVERT(VARCHAR,CONVERT(date,AUP.BIRTHDAY,103),103)BIRTHDAY,AUP.GENDER,PG.NAME,AUP.PARTNERTYPEID,PT.PARTNERTYPENAME " & _
                          ",AUP.SERVICETYPEID,ST.SERVICETYPENAME,AUP.SERVICETYPEDTLID,AUP.SERVICETYPEDETLNAME " & _
                          ",AUP.EMAIL,AUP.MOBILENO,AUP.PROVINCEID,P.PROVINCENAME " & _
                          ",AUP.KABUPATENID,KAB.KABUPATENNAME,AUP.KECAMATANID,KEC.KECAMATANNAME " & _
                          ",AUP.ADDRESS,AUP.ACTIVE,AUP.BALANCE,CONVERT(VARCHAR,CONVERT(date,AUP.REGISTERDATE,103),103)REGISTERDATE,AUP.IMAGEURL " & _
                          ",AUP.HARDWAREID,AUP.LONGITUDE,AUP.LATITUDE,AUP.STATUSMITRA,PG2.NAME AS STSMITRA,AUP.NUMBERPLATE,AUP.STATUSACTIVE,PG3.NAME AS STSACTIVEONOFF " & _
                      "FROM APPUSERPARTNER AUP " & _
                        "LEFT OUTER JOIN PROVINCE P ON AUP.PROVINCEID=P.PROVINCEID " & _
                        "LEFT OUTER JOIN PARTNERTYPE PT ON AUP.PARTNERTYPEID=PT.PARTNERTYPEID " & _
                        "LEFT OUTER JOIN PARAMGLOBAL PG ON AUP.GENDER=PG.CODE " & _
                        "LEFT OUTER JOIN KECAMATAN KEC ON AUP.KECAMATANID=KEC.KECAMATANID " & _
                        "LEFT OUTER JOIN KABUPATEN KAB ON AUP.KABUPATENID=KAB.KABUPATENID " & _
                        "LEFT OUTER JOIN SERVICETYPE ST ON AUP.SERVICETYPEID = ST.SERVICETYPEID " & _
                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON AUP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON AUP.STATUSMITRA = PG2.CODE " & _
                        "LEFT OUTER JOIN PARAMGLOBAL PG3 ON AUP.STATUSACTIVE = PG3.CODE " & _
                     "WHERE PG.TYPE = 'GENDER' AND PG2.TYPE='MITRASTATUS' AND PG2.CODE = 0 AND PG3.TYPE='STATUSONOFFMITRA' AND PG3.CODE=1"
        Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)
        If da.Fill(dt) = 0 Then
            Return HttpStatusCode.NotFound
        Else
            Return strReturn
        End If
        oSC.Close()
    End Function
    <WebMethod()>
    Public Function GetMitraDetailStatusOff() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT AUP.USERID,AUP.USERNAME,AUP.IDNUMBER,AUP.FULLNAME,AUP.PASSWORD " & _
                          ",CONVERT(VARCHAR,CONVERT(date,AUP.BIRTHDAY,103),103)BIRTHDAY,AUP.GENDER,PG.NAME,AUP.PARTNERTYPEID,PT.PARTNERTYPENAME " & _
                          ",AUP.SERVICETYPEID,ST.SERVICETYPENAME,AUP.SERVICETYPEDTLID,AUP.SERVICETYPEDETLNAME " & _
                          ",AUP.EMAIL,AUP.MOBILENO,AUP.PROVINCEID,P.PROVINCENAME " & _
                          ",AUP.KABUPATENID,KAB.KABUPATENNAME,AUP.KECAMATANID,KEC.KECAMATANNAME " & _
                          ",AUP.ADDRESS,AUP.ACTIVE,AUP.BALANCE,CONVERT(VARCHAR,CONVERT(date,AUP.REGISTERDATE,103),103)REGISTERDATE,AUP.IMAGEURL " & _
                          ",AUP.HARDWAREID,AUP.LONGITUDE,AUP.LATITUDE,AUP.STATUSMITRA,PG2.NAME AS STSMITRA,AUP.NUMBERPLATE,AUP.STATUSACTIVE,PG3.NAME AS STSACTIVEONOFF " & _
                      "FROM APPUSERPARTNER AUP " & _
                        "LEFT OUTER JOIN PROVINCE P ON AUP.PROVINCEID=P.PROVINCEID " & _
                        "LEFT OUTER JOIN PARTNERTYPE PT ON AUP.PARTNERTYPEID=PT.PARTNERTYPEID " & _
                        "LEFT OUTER JOIN PARAMGLOBAL PG ON AUP.GENDER=PG.CODE " & _
                        "LEFT OUTER JOIN KECAMATAN KEC ON AUP.KECAMATANID=KEC.KECAMATANID " & _
                        "LEFT OUTER JOIN KABUPATEN KAB ON AUP.KABUPATENID=KAB.KABUPATENID " & _
                        "LEFT OUTER JOIN SERVICETYPE ST ON AUP.SERVICETYPEID = ST.SERVICETYPEID " & _
                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON AUP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON AUP.STATUSMITRA = PG2.CODE " & _
                        "LEFT OUTER JOIN PARAMGLOBAL PG3 ON AUP.STATUSACTIVE = PG3.CODE " & _
                     "WHERE PG.TYPE = 'GENDER' AND PG2.TYPE='MITRASTATUS' AND PG2.CODE = 0 AND PG3.TYPE='STATUSONOFFMITRA' AND PG3.CODE=0"
        Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)
        If da.Fill(dt) = 0 Then
            Return HttpStatusCode.NotFound
        Else
            Return strReturn
        End If
        oSC.Close()
    End Function
    <WebMethod()>
    Public Function GetMitraDetailStatusIdleBusy(ByVal strUserID As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT AUP.USERID,AUP.USERNAME,AUP.IDNUMBER,AUP.FULLNAME,AUP.PASSWORD " & _
                          ",CONVERT(VARCHAR,CONVERT(date,AUP.BIRTHDAY,103),103)BIRTHDAY,AUP.GENDER,PG.NAME,AUP.PARTNERTYPEID,PT.PARTNERTYPENAME " & _
                          ",AUP.SERVICETYPEID,ST.SERVICETYPENAME,AUP.SERVICETYPEDTLID,STD.SERVICETYPEDTLNAME " & _
                          ",AUP.EMAIL,AUP.MOBILENO,AUP.PROVINCEID,P.PROVINCENAME " & _
                          ",AUP.KABUPATENID,KAB.KABUPATENNAME,AUP.KECAMATANID,KEC.KECAMATANNAME " & _
                          ",AUP.ADDRESS,AUP.ACTIVE,AUP.BALANCE,CONVERT(VARCHAR,CONVERT(date,AUP.REGISTERDATE,103),103)REGISTERDATE,AUP.IMAGEURL " & _
                          ",AUP.HARDWAREID,AUP.LONGITUDE,AUP.LATITUDE,AUP.STATUSMITRA,PG2.NAME AS STSMITRA,AUP.NUMBERPLATE " & _
                      "FROM APPUSERPARTNER AUP " & _
                        "LEFT OUTER JOIN PROVINCE P ON AUP.PROVINCEID=P.PROVINCEID " & _
                        "LEFT OUTER JOIN PARTNERTYPE PT ON AUP.PARTNERTYPEID=PT.PARTNERTYPEID " & _
                        "LEFT OUTER JOIN PARAMGLOBAL PG ON AUP.GENDER=PG.CODE " & _
                        "LEFT OUTER JOIN KECAMATAN KEC ON AUP.KECAMATANID=KEC.KECAMATANID " & _
                        "LEFT OUTER JOIN KABUPATEN KAB ON AUP.KABUPATENID=KAB.KABUPATENID " & _
                        "LEFT OUTER JOIN SERVICETYPE ST ON AUP.SERVICETYPEID = ST.SERVICETYPEID " & _
                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON AUP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON AUP.STATUSMITRA = PG2.CODE " & _
                     "WHERE AUP.USERID='" & strUserID & "' AND PG.TYPE = 'GENDER' AND PG2.TYPE='MITRASTATUS'  "
        Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)
        If da.Fill(dt) = 0 Then
            Return HttpStatusCode.NotFound
        Else
            Return strReturn
        End If
        oSC.Close()
    End Function
    <WebMethod()>
    Public Function GetOrderCountMitra(ByVal strMitraId As Integer, ByVal strServiceTypeId As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT COUNT(ORDERID) AS ORDERCOUNT FROM " & _
                    "(SELECT OB.ORDERID , OB.MITRAID, AUP.SERVICETYPEID FROM ORDERDEBARANG OB " & _
                        "LEFT OUTER JOIN APPUSERPARTNER AUP ON OB.MITRAID = AUP.USERID " & _
                        "LEFT OUTER JOIN PARAMGLOBAL PG ON OB.STATUS = PG.CODE " & _
                        "WHERE PG.TYPE='ORDERSTATUS' AND PG.CODE = 1 " & _
                        "UNION ALL " & _
                        "SELECT OC.ORDERID , OC.MITRAID, AUP.SERVICETYPEID FROM ORDERDECAR OC " & _
                        "LEFT OUTER JOIN APPUSERPARTNER AUP ON OC.MITRAID = AUP.USERID " & _
                        "LEFT OUTER JOIN PARAMGLOBAL PG ON OC.STATUS = PG.CODE " & _
                        "WHERE PG.TYPE='ORDERSTATUS' AND PG.CODE = 1 " & _
                        "UNION ALL " & _
                        "SELECT OJ.ORDERID , OJ.MITRAID, AUP.SERVICETYPEID FROM ORDERDEJEK OJ " & _
                        "LEFT OUTER JOIN APPUSERPARTNER AUP ON OJ.MITRAID = AUP.USERID " & _
                        "LEFT OUTER JOIN PARAMGLOBAL PG ON OJ.STATUS = PG.CODE " & _
                        "WHERE PG.TYPE='ORDERSTATUS' AND PG.CODE = 1 " & _
                        "UNION ALL " & _
                        "SELECT OS.ORDERDESEWAID , PM.MITRAID, AUP.SERVICETYPEID FROM ORDERDESEWA OS " & _
                        "LEFT OUTER JOIN PRODUCTMITRA PM ON OS.PRODUCTMITRAID = PM.PRODUCTMITRAID " & _
                        "LEFT OUTER JOIN APPUSERPARTNER AUP ON PM.MITRAID = AUP.USERID " & _
                        "LEFT OUTER JOIN PARAMGLOBAL PG ON OS.STATUS = PG.CODE " & _
                        "WHERE PG.TYPE='ORDERSTATUS' AND PG.CODE = 1 ) DATA " & _
                        "WHERE MITRAID = 6 and SERVICETYPEID=1 "
        Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)
        If da.Fill(dt) = 0 Then
            Return HttpStatusCode.NotFound
        Else
            Return strReturn
        End If
        oSC.Close()
    End Function
    <WebMethod()>
    Public Function GetDetailMitra(ByVal strMitraId As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT AUP.USERID,AUP.USERNAME,AUP.IDNUMBER,AUP.FULLNAME " & _
                          ",CONVERT(VARCHAR,CONVERT(date,AUP.BIRTHDAY,103),103)BIRTHDAY,AUP.GENDER,PG.NAME,AUP.PARTNERTYPEID,PT.PARTNERTYPENAME " & _
                          ",AUP.SERVICETYPEID,ST.SERVICETYPENAME,AUP.SERVICETYPEDTLID, STD.SERVICETYPEDTLNAME " & _
                          ",AUP.EMAIL,AUP.MOBILENO,AUP.BALANCE,AUP.IMAGEURL,AUP.NUMBERPLATE " & _
                      "FROM APPUSERPARTNER AUP " & _
                        "LEFT OUTER JOIN PROVINCE P ON AUP.PROVINCEID=P.PROVINCEID " & _
                        "LEFT OUTER JOIN PARTNERTYPE PT ON AUP.PARTNERTYPEID=PT.PARTNERTYPEID " & _
                        "LEFT OUTER JOIN PARAMGLOBAL PG ON AUP.GENDER=PG.CODE " & _
                        "LEFT OUTER JOIN KECAMATAN KEC ON AUP.KECAMATANID=KEC.KECAMATANID " & _
                        "LEFT OUTER JOIN KABUPATEN KAB ON AUP.KABUPATENID=KAB.KABUPATENID " & _
                        "LEFT OUTER JOIN SERVICETYPE ST ON AUP.SERVICETYPEID = ST.SERVICETYPEID " & _
                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON AUP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON AUP.STATUSMITRA = PG2.CODE " & _
                     "WHERE AUP.USERID='" & strMitraId & "' AND PG.TYPE = 'GENDER' AND PG2.TYPE='MITRASTATUS'"
        Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)
        If da.Fill(dt) = 0 Then
            Return HttpStatusCode.NotFound
        Else
            Return strReturn
        End If
        oSC.Close()
    End Function
    <WebMethod()>
    Public Function GetMitraDetailDeantarDeCar(ByVal strIdNumber As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT AUP.USERID,AUP.USERNAME,AUP.IDNUMBER,AUP.FULLNAME,AUP.PASSWORD " & _
                          ",AUP.BIRTHDAY,AUP.GENDER,PG.NAME,AUP.PARTNERTYPEID,PT.PARTNERTYPENAME " & _
                          ",AUP.SERVICETYPEID,ST.SERVICETYPENAME,AUP.SERVICETYPEDTLID,AUP.SERVICETYPEDETLNAME " & _
                          ",AUP.EMAIL,AUP.MOBILENO,AUP.PROVINCEID,P.PROVINCENAME " & _
                          ",AUP.KABUPATENID,KAB.KABUPATENNAME,AUP.KECAMATANID,KEC.KECAMATANNAME " & _
                          ",AUP.ADDRESS,AUP.ACTIVE,AUP.BALANCE,AUP.REGISTERDATE,AUP.IMAGEURL " & _
                          ",AUP.HARDWAREID,AUP.LONGITUDE,AUP.LATITUDE,AUP.STATUSMITRA,PG2.NAME AS STSMITRA " & _
                      "FROM APPUSERPARTNER AUP " & _
                        "LEFT OUTER JOIN PROVINCE P ON AUP.PROVINCEID=P.PROVINCEID " & _
                        "LEFT OUTER JOIN PARTNERTYPE PT ON AUP.PARTNERTYPEID=PT.PARTNERTYPEID " & _
                        "LEFT OUTER JOIN PARAMGLOBAL PG ON AUP.GENDER=PG.CODE " & _
                        "LEFT OUTER JOIN KECAMATAN KEC ON AUP.KECAMATANID=KEC.KECAMATANID " & _
                        "LEFT OUTER JOIN KABUPATEN KAB ON AUP.KABUPATENID=KAB.KABUPATENID " & _
                        "LEFT OUTER JOIN SERVICETYPE ST ON AUP.SERVICETYPEID = ST.SERVICETYPEID " & _
                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON AUP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON AUP.STATUSMITRA = PG2.CODE " & _
                     "WHERE AUP.IDNUMBER='" & strIdNumber & "' AND AUP.SERVICETYPEID = 1 AND PG.TYPE = 'GENDER' AND PG2.TYPE='MITRASTATUS' AND PG2.CODE = 0"
        Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)
        If da.Fill(dt) = 0 Then
            Return HttpStatusCode.NotFound
        Else
            Return strReturn
        End If
        oSC.Close()
    End Function
    <WebMethod()>
    Public Function GetOrderDeBarang(ByVal strOrderId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT ODB.ORDERID,ODB.ORDERCODE,ODB.CUSTOMERID,AUC.FULLNAME,ODB.MITRAID,AUP.FULLNAME AS MITRANAME " & _
                              ",ODB.ARMADAID,MA.ARMADANAME,AUP.NUMBERPLATE,ODB.PICKUPLOC,ODB.DESTINATIONLOC,ODB.PRICE,ODB.DISTANCE " & _
                              ",ODB.DURATION,ODB.ORDERDATE,ODB.NOTES,ODB.STATUS,PG.NAME,ODB.ORDERTIME " & _
                       "FROM ORDERDEBARANG ODB " & _
                          "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODB.CUSTOMERID = AUC.UID " & _
                          "LEFT OUTER JOIN APPUSERPARTNER AUP ON ODB.MITRAID = AUP.USERID " & _
                          "LEFT OUTER JOIN MASTERARMADA MA ON ODB.ARMADAID = MA.ARMADAID " & _
                          "LEFT OUTER JOIN PARAMGLOBAL PG ON ODB.STATUS = PG.CODE " & _
                      "WHERE ODB.ORDERID=" & strOrderId & " AND PG.TYPE = 'ORDERSTATUS'"
        Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)
        If da.Fill(dt) = 0 Then
            Return HttpStatusCode.NotFound
        Else
            Return strReturn
        End If
        oSC.Close()
    End Function

    '<WebMethod()>
    'Public Function getPesananProsesDeAntarDeBarang(ByVal strMitraId As String) As String
    '    Dim objDB As New DBX
    '    Dim strSQL As String = ""
    '    Dim dt As DataTable = New DataTable
    '    oSC.Open()
    '    strSQL = " SELECT ODB.ORDERID,ODB.ORDERCODE,ODB.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODB.MITRAID,AUP.FULLNAME " & _
    '                          ",STD.SERVICETYPEDTLNAME,ODB.ARMADAID,MA.ARMADANAME,ODB.PICKUPLOC,ODB.DESTINATIONLOC,ODB.PRICE,ODB.DISTANCE " & _
    '                          ",ODB.DURATION,ODB.ORDERDATE,ODB.NOTES,ODB.STATUS,PG.NAME " & _
    '                   "FROM ORDERDEBARANG ODB " & _
    '                     "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODB.CUSTOMERID = AUC.UID " & _
    '                    "LEFT OUTER JOIN APPUSERPARTNER AUP ON ODB.MITRAID = AUP.USERID " & _
    '                     "LEFT OUTER JOIN MASTERARMADA MA ON ODB.ARMADAID = MA.ARMADAID " & _
    '                     "LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '                     "LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = STD.SERVICETYPEID " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG ON ODB.STATUS = PG.CODE " & _
    '    "WHERE ST.SERVICETYPEID=1 AND STD.SERVICETYPEDTLID=1 AND ODB.STATUS=2 AND PG.TYPE='ORDERSTATUS' AND ODB.MITRAID= '" & strMitraId & "'"
    '    Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '    da.Fill(dt)
    '    Dim strReturn As String = GetJson(dt)
    '    If da.Fill(dt) = 0 Then
    '        Return HttpStatusCode.NotFound
    '    Else
    '        Return strReturn
    '    End If
    '    oSC.Close()
    'End Function
    ' <WebMethod()>
    ' Public Function getPesananProsesDeAntarDeCar(ByVal strMitraId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT OC.ORDERID,OC.ORDERCODE,OC.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,OC.MITRAID,AUP.FULLNAME " & _
    '                           ",STD.SERVICETYPEDTLNAME,OC.ARMADAID,MA.ARMADANAME,OC.PICKUPLOC,OC.DESTINATIONLOC,OC.PRICE,OC.DISTANCE " & _
    '                           ",OC.DURATION,OC.ORDERDATE,OC.NOTES,OC.STATUS,PG.NAME " & _
    '                    "FROM ORDERDECAR OC " & _
    '                      "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODB.CUSTOMERID = AUC.UID " & _
    '                     "LEFT OUTER JOIN APPUSERPARTNER AUP ON ODB.MITRAID = AUP.USERID " & _
    '                      "LEFT OUTER JOIN MASTERARMADA MA ON ODB.ARMADAID = MA.ARMADAID " & _
    '                      "LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '                      "LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = STD.SERVICETYPEID " & _
    '                      "LEFT OUTER JOIN PARAMGLOBAL PG ON ODB.STATUS = PG.CODE " & _
    '     "WHERE ST.SERVICETYPEID=1 AND STD.SERVICETYPEDTLID=3 AND ODB.STATUS=2 AND PG.TYPE='ORDERSTATUS' AND ODB.MITRAID= '" & strMitraId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    '<WebMethod()>
    ' Public Function getPesananProsesDeAntarLainnya(ByVal strMitraId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODB.ORDERID,ODB.ORDERCODE,ODB.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODB.MITRAID,AUP.FULLNAME " & _
    '                           ",STD.SERVICETYPEDTLNAME,ODB.ARMADAID,MA.ARMADANAME,ODB.PICKUPLOC,ODB.DESTINATIONLOC,ODB.PRICE,ODB.DISTANCE " & _
    '                           ",ODB.DURATION,ODB.ORDERDATE,ODB.NOTES,ODB.STATUS,PG.NAME " & _
    '                    "FROM ORDERDEBARANG ODB " & _
    '                      "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODB.CUSTOMERID = AUC.UID " & _
    '                     "LEFT OUTER JOIN APPUSERPARTNER AUP ON ODB.MITRAID = AUP.USERID " & _
    '                      "LEFT OUTER JOIN MASTERARMADA MA ON ODB.ARMADAID = MA.ARMADAID " & _
    '                      "LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '                      "LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = STD.SERVICETYPEID " & _
    '                      "LEFT OUTER JOIN PARAMGLOBAL PG ON ODB.STATUS = PG.CODE " & _
    '     "WHERE ST.SERVICETYPEID=1 AND STD.SERVICETYPEDTLID=8 AND ODB.STATUS=2 AND PG.TYPE='ORDERSTATUS' AND ODB.MITRAID= '" & strMitraId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananProsesDeSewaKendaraan(ByVal strMitraId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODS.ORDERDESEWAID,ODS.ORDERDESEWACODE,ODS.PRODUCTMITRAID,PM.PRODUCTBRAND " & _
    '                     ",ODS.CUSTOMERID,AUC.FULLNAME,ODS.MITRAID,AUP.FULLNAME  AS MITRANAME,ODS.ORDERDATE,ST.SERVICETYPENAME,STD.SERVICETYPEDTLNAME " & _
    '                     ",ODS.STARTDATE,ODS.ENDDATE,ODS.QTYORDER,ODS.TAKINGTYPE,PG.NAME AS TAKING " & _
    '                     ",ODS.ADDRESSCUSTOMER,ODS.PRICE,ODS.PAYMENTTYPE,PG2.NAME AS PAYMENTSEWA " & _
    '                     ",ODS.TOTALPRICE,ODS.NOTES,ODS.STATUS,PG3.NAME AS STATUSSEWA,ODS.IMAGEURL " & _
    '             "FROM ORDERDESEWA ODS " & _
    '                     "LEFT OUTER JOIN PRODUCTMITRA PM ON ODS.PRODUCTMITRAID = PM.PRODUCTMITRAID " & _
    '                     "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODS.CUSTOMERID = AUC.UID " & _
    '                     "LEFT OUTER JOIN APPUSERPARTNER AUP ON ODS.MITRAID = AUP.USERID " & _
    '                     "LEFT OUTER JOIN SERVICETYPE ST ON PM.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                     "LEFT OUTER JOIN SERVICETYPEDTL STD ON PM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG ON ODS.TAKINGTYPE = PG.CODE " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODS.PAYMENTTYPE = PG2.CODE " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG3 ON ODS.STATUS = PG3.CODE " & _
    '             "WHERE ST.SERVICETYPEID=3 AND STD.SERVICETYPEDTLID=4 AND PG.TYPE ='TAKINGTYPE' AND PG2.TYPE='PAYMENT' AND ODS.STATUS=2 AND PG3.TYPE='ORDERSTATUS' AND ODS.MITRAID= '" & strMitraId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananProsesDeSewaPertanian(ByVal strMitraId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODS.ORDERDESEWAID,ODS.ORDERDESEWACODE,ODS.PRODUCTMITRAID,PM.PRODUCTBRAND " & _
    '                     ",ODS.CUSTOMERID,AUC.FULLNAME,ODS.MITRAID,AUP.FULLNAME  AS MITRANAME,ODS.ORDERDATE,ST.SERVICETYPENAME,STD.SERVICETYPEDTLNAME " & _
    '                     ",ODS.STARTDATE,ODS.ENDDATE,ODS.QTYORDER,ODS.TAKINGTYPE,PG.NAME AS TAKING " & _
    '                     ",ODS.ADDRESSCUSTOMER,ODS.PRICE,ODS.PAYMENTTYPE,PG2.NAME AS PAYMENTSEWA " & _
    '                     ",ODS.TOTALPRICE,ODS.NOTES,ODS.STATUS,PG3.NAME AS STATUSSEWA,ODS.IMAGEURL " & _
    '             "FROM ORDERDESEWA ODS " & _
    '                     "LEFT OUTER JOIN PRODUCTMITRA PM ON ODS.PRODUCTMITRAID = PM.PRODUCTMITRAID " & _
    '                     "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODS.CUSTOMERID = AUC.UID " & _
    '                     "LEFT OUTER JOIN APPUSERPARTNER AUP ON ODS.MITRAID = AUP.USERID " & _
    '                     "LEFT OUTER JOIN SERVICETYPE ST ON PM.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                     "LEFT OUTER JOIN SERVICETYPEDTL STD ON PM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG ON ODS.TAKINGTYPE = PG.CODE " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODS.PAYMENTTYPE = PG2.CODE " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG3 ON ODS.STATUS = PG3.CODE " & _
    '             "WHERE ST.SERVICETYPEID=3 AND STD.SERVICETYPEDTLID=5 AND PG.TYPE ='TAKINGTYPE' AND PG2.TYPE='PAYMENT' AND ODS.STATUS=2 AND PG3.TYPE='ORDERSTATUS' AND ODS.MITRAID= '" & strMitraId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananProsesDeSewaMedis(ByVal strMitraId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODS.ORDERDESEWAID,ODS.ORDERDESEWACODE,ODS.PRODUCTMITRAID,PM.PRODUCTBRAND " & _
    '                     ",ODS.CUSTOMERID,AUC.FULLNAME,ODS.MITRAID,AUP.FULLNAME  AS MITRANAME,ODS.ORDERDATE,ST.SERVICETYPENAME,STD.SERVICETYPEDTLNAME " & _
    '                     ",ODS.STARTDATE,ODS.ENDDATE,ODS.QTYORDER,ODS.TAKINGTYPE,PG.NAME AS TAKING " & _
    '                     ",ODS.ADDRESSCUSTOMER,ODS.PRICE,ODS.PAYMENTTYPE,PG2.NAME AS PAYMENTSEWA " & _
    '                     ",ODS.TOTALPRICE,ODS.NOTES,ODS.STATUS,PG3.NAME AS STATUSSEWA,ODS.IMAGEURL " & _
    '             "FROM ORDERDESEWA ODS " & _
    '                     "LEFT OUTER JOIN PRODUCTMITRA PM ON ODS.PRODUCTMITRAID = PM.PRODUCTMITRAID " & _
    '                     "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODS.CUSTOMERID = AUC.UID " & _
    '                     "LEFT OUTER JOIN APPUSERPARTNER AUP ON ODS.MITRAID = AUP.USERID " & _
    '                     "LEFT OUTER JOIN SERVICETYPE ST ON PM.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                     "LEFT OUTER JOIN SERVICETYPEDTL STD ON PM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG ON ODS.TAKINGTYPE = PG.CODE " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODS.PAYMENTTYPE = PG2.CODE " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG3 ON ODS.STATUS = PG3.CODE " & _
    '             "WHERE ST.SERVICETYPEID=3 AND STD.SERVICETYPEDTLID=6 AND PG.TYPE ='TAKINGTYPE' AND PG2.TYPE='PAYMENT' AND ODS.STATUS=2 AND PG3.TYPE='ORDERSTATUS' AND ODS.MITRAID= '" & strMitraId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananProsesDeSewaLainnya(ByVal strMitraId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODS.ORDERDESEWAID,ODS.ORDERDESEWACODE,ODS.PRODUCTMITRAID,PM.PRODUCTBRAND " & _
    '                     ",ODS.CUSTOMERID,AUC.FULLNAME,ODS.MITRAID,AUP.FULLNAME  AS MITRANAME,ODS.ORDERDATE,ST.SERVICETYPENAME,STD.SERVICETYPEDTLNAME " & _
    '                     ",ODS.STARTDATE,ODS.ENDDATE,ODS.QTYORDER,ODS.TAKINGTYPE,PG.NAME AS TAKING " & _
    '                     ",ODS.ADDRESSCUSTOMER,ODS.PRICE,ODS.PAYMENTTYPE,PG2.NAME AS PAYMENTSEWA " & _
    '                     ",ODS.TOTALPRICE,ODS.NOTES,ODS.STATUS,PG3.NAME AS STATUSSEWA,ODS.IMAGEURL " & _
    '             "FROM ORDERDESEWA ODS " & _
    '                     "LEFT OUTER JOIN PRODUCTMITRA PM ON ODS.PRODUCTMITRAID = PM.PRODUCTMITRAID " & _
    '                     "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODS.CUSTOMERID = AUC.UID " & _
    '                     "LEFT OUTER JOIN APPUSERPARTNER AUP ON ODS.MITRAID = AUP.USERID " & _
    '                     "LEFT OUTER JOIN SERVICETYPE ST ON PM.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                     "LEFT OUTER JOIN SERVICETYPEDTL STD ON PM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG ON ODS.TAKINGTYPE = PG.CODE " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODS.PAYMENTTYPE = PG2.CODE " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG3 ON ODS.STATUS = PG3.CODE " & _
    '             "WHERE ST.SERVICETYPEID=3 AND STD.SERVICETYPEDTLID=9 AND PG.TYPE ='TAKINGTYPE' AND PG2.TYPE='PAYMENT' AND ODS.STATUS=2 AND PG3.TYPE='ORDERSTATUS' AND ODS.MITRAID= '" & strMitraId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananProsesDePasarSembako(ByVal strEntityTypeId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
    '                           ",ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE " & _
    '                           ",PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL " & _
    '                           ",ODP.STATUS,PG2.NAME AS STATUSORDER " & _
    '                           ",ODP.ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE " & _
    '                           ",ODP.NOTES " & _
    '                     "FROM ORDERDEPASAR ODP " & _
    '                        "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID " & _
    '                        "LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
    '                        "LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE " & _
    '                        "LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID " & _
    '                        "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '             "WHERE ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=7 AND ODP.STATUS=2 AND PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND ODP.ENTITYTYPEID='" & strEntityTypeId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananProsesDePasarMakanan(ByVal strEntityTypeId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
    '                           ",ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE " & _
    '                           ",PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL " & _
    '                           ",ODP.STATUS,PG2.NAME AS STATUSORDER " & _
    '                           ",ODP.ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE " & _
    '                           ",ODP.NOTES " & _
    '                     "FROM ORDERDEPASAR ODP " & _
    '                        "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID " & _
    '                        "LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
    '                        "LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE " & _
    '                        "LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID " & _
    '                        "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '             "WHERE ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=10 AND ODP.STATUS=2 AND PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND ODP.ENTITYTYPEID='" & strEntityTypeId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananProsesDePasarPertanian(ByVal strEntityTypeId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
    '                           ",ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE " & _
    '                           ",PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL " & _
    '                           ",ODP.STATUS,PG2.NAME AS STATUSORDER " & _
    '                           ",ODP.ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE " & _
    '                           ",ODP.NOTES " & _
    '                     "FROM ORDERDEPASAR ODP " & _
    '                        "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID " & _
    '                        "LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
    '                        "LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE " & _
    '                        "LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID " & _
    '                        "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '             "WHERE ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=11 AND ODP.STATUS=2 AND PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND ODP.ENTITYTYPEID='" & strEntityTypeId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananProsesDePasarKesehatan(ByVal strEntityTypeId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
    '                           ",ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE " & _
    '                           ",PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL " & _
    '                           ",ODP.STATUS,PG2.NAME AS STATUSORDER " & _
    '                           ",ODP.ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE " & _
    '                           ",ODP.NOTES " & _
    '                     "FROM ORDERDEPASAR ODP " & _
    '                        "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID " & _
    '                        "LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
    '                        "LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE " & _
    '                        "LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID " & _
    '                        "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '             "WHERE ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=12 AND ODP.STATUS=2 AND PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND ODP.ENTITYTYPEID='" & strEntityTypeId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananProsesDePasarPRT(ByVal strEntityTypeId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
    '                           ",ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE " & _
    '                           ",PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL " & _
    '                           ",ODP.STATUS,PG2.NAME AS STATUSORDER " & _
    '                           ",ODP.ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE " & _
    '                           ",ODP.NOTES " & _
    '                     "FROM ORDERDEPASAR ODP " & _
    '                        "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID " & _
    '                        "LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
    '                        "LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE " & _
    '                        "LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID " & _
    '                        "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '             "WHERE ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=13 AND ODP.STATUS=2 AND PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND ODP.ENTITYTYPEID='" & strEntityTypeId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananProsesDePasarElekTronik(ByVal strEntityTypeId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
    '                           ",ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE " & _
    '                           ",PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL " & _
    '                           ",ODP.STATUS,PG2.NAME AS STATUSORDER " & _
    '                           ",ODP.ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE " & _
    '                           ",ODP.NOTES " & _
    '                     "FROM ORDERDEPASAR ODP " & _
    '                        "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID " & _
    '                        "LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
    '                        "LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE " & _
    '                        "LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID " & _
    '                        "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '             "WHERE ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=14 AND ODP.STATUS=2 AND PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND ODP.ENTITYTYPEID='" & strEntityTypeId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananProsesDePasarPerkakas(ByVal strEntityTypeId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
    '                           ",ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE " & _
    '                           ",PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL " & _
    '                           ",ODP.STATUS,PG2.NAME AS STATUSORDER " & _
    '                           ",ODP.ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE " & _
    '                           ",ODP.NOTES " & _
    '                     "FROM ORDERDEPASAR ODP " & _
    '                        "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID " & _
    '                        "LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
    '                        "LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE " & _
    '                        "LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID " & _
    '                        "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '             "WHERE ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=15 AND ODP.STATUS=2 AND PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND ODP.ENTITYTYPEID='" & strEntityTypeId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananProsesDePasarOlahraga(ByVal strEntityTypeId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
    '                           ",ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE " & _
    '                           ",PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL " & _
    '                           ",ODP.STATUS,PG2.NAME AS STATUSORDER " & _
    '                           ",ODP.ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE " & _
    '                           ",ODP.NOTES " & _
    '                     "FROM ORDERDEPASAR ODP " & _
    '                        "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID " & _
    '                        "LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
    '                        "LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE " & _
    '                        "LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID " & _
    '                        "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '             "WHERE ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=16 AND ODP.STATUS=2 AND PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND ODP.ENTITYTYPEID='" & strEntityTypeId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananProsesDePasarOtomotif(ByVal strEntityTypeId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
    '                           ",ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE " & _
    '                           ",PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL " & _
    '                           ",ODP.STATUS,PG2.NAME AS STATUSORDER " & _
    '                           ",ODP.ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE " & _
    '                           ",ODP.NOTES " & _
    '                     "FROM ORDERDEPASAR ODP " & _
    '                        "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID " & _
    '                        "LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
    '                        "LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE " & _
    '                        "LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID " & _
    '                        "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '             "WHERE ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=17 AND ODP.STATUS=2 AND PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND ODP.ENTITYTYPEID='" & strEntityTypeId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananFinishDeAntarBarang(ByVal strMitraId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = "SELECT ODB.ORDERID,ODB.ORDERCODE,ODB.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODB.MITRAID,AUP.FULLNAME " & _
    '                          ",STD.SERVICETYPEDTLNAME,ODB.ARMADAID,MA.ARMADANAME,ODB.PICKUPLOC,ODB.DESTINATIONLOC,ODB.PRICE,ODB.DISTANCE " & _
    '                          ",ODB.DURATION,ODB.ORDERDATE,ODB.NOTES,ODB.STATUS,PG.NAME " & _
    '              "FROM ORDERDEBARANG ODB " & _
    '                     "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODB.CUSTOMERID = AUC.UID " & _
    '                     "LEFT OUTER JOIN APPUSERPARTNER AUP ON ODB.MITRAID = AUP.USERID " & _
    '                     "LEFT OUTER JOIN MASTERARMADA MA ON ODB.ARMADAID = MA.ARMADAID " & _
    '                     "LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '                     "LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = STD.SERVICETYPEID " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG ON ODB.STATUS = PG.CODE " & _
    '             "WHERE ST.SERVICETYPEID=1 AND STD.SERVICETYPEDTLID=1 AND ODB.STATUS=1 AND PG.TYPE='ORDERSTATUS' AND ODB.MITRAID= '" & strMitraId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananFinishDeAntarDeOjek(ByVal strMitraId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = "SELECT ODB.ORDERID,ODB.ORDERCODE,ODB.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODB.MITRAID,AUP.FULLNAME " & _
    '                          ",STD.SERVICETYPEDTLNAME,ODB.ARMADAID,MA.ARMADANAME,ODB.PICKUPLOC,ODB.DESTINATIONLOC,ODB.PRICE,ODB.DISTANCE " & _
    '                          ",ODB.DURATION,ODB.ORDERDATE,ODB.NOTES,ODB.STATUS,PG.NAME " & _
    '              "FROM ORDERDEBARANG ODB " & _
    '                     "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODB.CUSTOMERID = AUC.UID " & _
    '                     "LEFT OUTER JOIN APPUSERPARTNER AUP ON ODB.MITRAID = AUP.USERID " & _
    '                     "LEFT OUTER JOIN MASTERARMADA MA ON ODB.ARMADAID = MA.ARMADAID " & _
    '                     "LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '                     "LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = STD.SERVICETYPEID " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG ON ODB.STATUS = PG.CODE " & _
    '             "WHERE ST.SERVICETYPEID=1 AND STD.SERVICETYPEDTLID=2 AND ODB.STATUS=1 AND PG.TYPE='ORDERSTATUS' AND ODB.MITRAID= '" & strMitraId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananFinishDeAntarDeCar(ByVal strMitraId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = "SELECT ODB.ORDERID,ODB.ORDERCODE,ODB.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODB.MITRAID,AUP.FULLNAME " & _
    '                          ",STD.SERVICETYPEDTLNAME,ODB.ARMADAID,MA.ARMADANAME,ODB.PICKUPLOC,ODB.DESTINATIONLOC,ODB.PRICE,ODB.DISTANCE " & _
    '                          ",ODB.DURATION,ODB.ORDERDATE,ODB.NOTES,ODB.STATUS,PG.NAME " & _
    '              "FROM ORDERDEBARANG ODB " & _
    '                     "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODB.CUSTOMERID = AUC.UID " & _
    '                     "LEFT OUTER JOIN APPUSERPARTNER AUP ON ODB.MITRAID = AUP.USERID " & _
    '                     "LEFT OUTER JOIN MASTERARMADA MA ON ODB.ARMADAID = MA.ARMADAID " & _
    '                     "LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '                     "LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = STD.SERVICETYPEID " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG ON ODB.STATUS = PG.CODE " & _
    '             "WHERE ST.SERVICETYPEID=1 AND STD.SERVICETYPEDTLID=3 AND ODB.STATUS=1 AND PG.TYPE='ORDERSTATUS' AND ODB.MITRAID= '" & strMitraId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananFinishDeAntarLainnya(ByVal strMitraId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODB.ORDERID,ODB.ORDERCODE,ODB.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODB.MITRAID,AUP.FULLNAME " & _
    '                           ",STD.SERVICETYPEDTLNAME,ODB.ARMADAID,MA.ARMADANAME,ODB.PICKUPLOC,ODB.DESTINATIONLOC,ODB.PRICE,ODB.DISTANCE " & _
    '                           ",ODB.DURATION,ODB.ORDERDATE,ODB.NOTES,ODB.STATUS,PG.NAME " & _
    '                    "FROM ORDERDEBARANG ODB " & _
    '                      "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODB.CUSTOMERID = AUC.UID " & _
    '                     "LEFT OUTER JOIN APPUSERPARTNER AUP ON ODB.MITRAID = AUP.USERID " & _
    '                      "LEFT OUTER JOIN MASTERARMADA MA ON ODB.ARMADAID = MA.ARMADAID " & _
    '                      "LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '                      "LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = STD.SERVICETYPEID " & _
    '                      "LEFT OUTER JOIN PARAMGLOBAL PG ON ODB.STATUS = PG.CODE " & _
    '     "WHERE ST.SERVICETYPEID=1 AND STD.SERVICETYPEDTLID=8 AND ODB.STATUS=1 AND PG.TYPE='ORDERSTATUS' AND ODB.MITRAID= '" & strMitraId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananFinishDeSewaKendaraan(ByVal strMitraId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODS.ORDERDESEWAID,ODS.ORDERDESEWACODE,ODS.PRODUCTMITRAID,PM.PRODUCTBRAND " & _
    '                     ",ODS.CUSTOMERID,AUC.FULLNAME,ODS.MITRAID,AUP.FULLNAME  AS MITRANAME,ODS.ORDERDATE,ST.SERVICETYPENAME,STD.SERVICETYPEDTLNAME " & _
    '                     ",ODS.STARTDATE,ODS.ENDDATE,ODS.QTYORDER,ODS.TAKINGTYPE,PG.NAME AS TAKING " & _
    '                     ",ODS.ADDRESSCUSTOMER,ODS.PRICE,ODS.PAYMENTTYPE,PG2.NAME AS PAYMENTSEWA " & _
    '                     ",ODS.TOTALPRICE,ODS.NOTES,ODS.STATUS,PG3.NAME AS STATUSSEWA,ODS.IMAGEURL " & _
    '             "FROM ORDERDESEWA ODS " & _
    '                     "LEFT OUTER JOIN PRODUCTMITRA PM ON ODS.PRODUCTMITRAID = PM.PRODUCTMITRAID " & _
    '                     "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODS.CUSTOMERID = AUC.UID " & _
    '                     "LEFT OUTER JOIN APPUSERPARTNER AUP ON ODS.MITRAID = AUP.USERID " & _
    '                     "LEFT OUTER JOIN SERVICETYPE ST ON PM.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                     "LEFT OUTER JOIN SERVICETYPEDTL STD ON PM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG ON ODS.TAKINGTYPE = PG.CODE " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODS.PAYMENTTYPE = PG2.CODE " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG3 ON ODS.STATUS = PG3.CODE " & _
    '             "WHERE ST.SERVICETYPEID=3 AND STD.SERVICETYPEDTLID=4 AND PG.TYPE ='TAKINGTYPE' AND PG2.TYPE='PAYMENT' AND ODS.STATUS=1 AND PG3.TYPE='ORDERSTATUS' AND ODS.MITRAID= '" & strMitraId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananFinishDeSewaPertanian(ByVal strMitraId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODS.ORDERDESEWAID,ODS.ORDERDESEWACODE,ODS.PRODUCTMITRAID,PM.PRODUCTBRAND " & _
    '                     ",ODS.CUSTOMERID,AUC.FULLNAME,ODS.MITRAID,AUP.FULLNAME  AS MITRANAME,ODS.ORDERDATE,ST.SERVICETYPENAME,STD.SERVICETYPEDTLNAME " & _
    '                     ",ODS.STARTDATE,ODS.ENDDATE,ODS.QTYORDER,ODS.TAKINGTYPE,PG.NAME AS TAKING " & _
    '                     ",ODS.ADDRESSCUSTOMER,ODS.PRICE,ODS.PAYMENTTYPE,PG2.NAME AS PAYMENTSEWA " & _
    '                     ",ODS.TOTALPRICE,ODS.NOTES,ODS.STATUS,PG3.NAME AS STATUSSEWA,ODS.IMAGEURL " & _
    '             "FROM ORDERDESEWA ODS " & _
    '                     "LEFT OUTER JOIN PRODUCTMITRA PM ON ODS.PRODUCTMITRAID = PM.PRODUCTMITRAID " & _
    '                     "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODS.CUSTOMERID = AUC.UID " & _
    '                     "LEFT OUTER JOIN APPUSERPARTNER AUP ON ODS.MITRAID = AUP.USERID " & _
    '                     "LEFT OUTER JOIN SERVICETYPE ST ON PM.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                     "LEFT OUTER JOIN SERVICETYPEDTL STD ON PM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG ON ODS.TAKINGTYPE = PG.CODE " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODS.PAYMENTTYPE = PG2.CODE " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG3 ON ODS.STATUS = PG3.CODE " & _
    '             "WHERE ST.SERVICETYPEID=3 AND STD.SERVICETYPEDTLID=5 AND PG.TYPE ='TAKINGTYPE' AND PG2.TYPE='PAYMENT' AND ODS.STATUS=1 AND PG3.TYPE='ORDERSTATUS' AND ODS.MITRAID= '" & strMitraId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananFinishDeSewaMedis(ByVal strMitraId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODS.ORDERDESEWAID,ODS.ORDERDESEWACODE,ODS.PRODUCTMITRAID,PM.PRODUCTBRAND " & _
    '                     ",ODS.CUSTOMERID,AUC.FULLNAME,ODS.MITRAID,AUP.FULLNAME  AS MITRANAME,ODS.ORDERDATE,ST.SERVICETYPENAME,STD.SERVICETYPEDTLNAME " & _
    '                     ",ODS.STARTDATE,ODS.ENDDATE,ODS.QTYORDER,ODS.TAKINGTYPE,PG.NAME AS TAKING " & _
    '                     ",ODS.ADDRESSCUSTOMER,ODS.PRICE,ODS.PAYMENTTYPE,PG2.NAME AS PAYMENTSEWA " & _
    '                     ",ODS.TOTALPRICE,ODS.NOTES,ODS.STATUS,PG3.NAME AS STATUSSEWA,ODS.IMAGEURL " & _
    '             "FROM ORDERDESEWA ODS " & _
    '                     "LEFT OUTER JOIN PRODUCTMITRA PM ON ODS.PRODUCTMITRAID = PM.PRODUCTMITRAID " & _
    '                     "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODS.CUSTOMERID = AUC.UID " & _
    '                     "LEFT OUTER JOIN APPUSERPARTNER AUP ON ODS.MITRAID = AUP.USERID " & _
    '                     "LEFT OUTER JOIN SERVICETYPE ST ON PM.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                     "LEFT OUTER JOIN SERVICETYPEDTL STD ON PM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG ON ODS.TAKINGTYPE = PG.CODE " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODS.PAYMENTTYPE = PG2.CODE " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG3 ON ODS.STATUS = PG3.CODE " & _
    '             "WHERE ST.SERVICETYPEID=3 AND STD.SERVICETYPEDTLID=6 AND PG.TYPE ='TAKINGTYPE' AND PG2.TYPE='PAYMENT' AND ODS.STATUS=1 AND PG3.TYPE='ORDERSTATUS' AND ODS.MITRAID= '" & strMitraId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananFinishDeSewaLainnya(ByVal strMitraId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODS.ORDERDESEWAID,ODS.ORDERDESEWACODE,ODS.PRODUCTMITRAID,PM.PRODUCTBRAND " & _
    '                     ",ODS.CUSTOMERID,AUC.FULLNAME,ODS.MITRAID,AUP.FULLNAME  AS MITRANAME,ODS.ORDERDATE,ST.SERVICETYPENAME,STD.SERVICETYPEDTLNAME " & _
    '                     ",ODS.STARTDATE,ODS.ENDDATE,ODS.QTYORDER,ODS.TAKINGTYPE,PG.NAME AS TAKING " & _
    '                     ",ODS.ADDRESSCUSTOMER,ODS.PRICE,ODS.PAYMENTTYPE,PG2.NAME AS PAYMENTSEWA " & _
    '                     ",ODS.TOTALPRICE,ODS.NOTES,ODS.STATUS,PG3.NAME AS STATUSSEWA,ODS.IMAGEURL " & _
    '             "FROM ORDERDESEWA ODS " & _
    '                     "LEFT OUTER JOIN PRODUCTMITRA PM ON ODS.PRODUCTMITRAID = PM.PRODUCTMITRAID " & _
    '                     "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODS.CUSTOMERID = AUC.UID " & _
    '                     "LEFT OUTER JOIN APPUSERPARTNER AUP ON ODS.MITRAID = AUP.USERID " & _
    '                     "LEFT OUTER JOIN SERVICETYPE ST ON PM.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                     "LEFT OUTER JOIN SERVICETYPEDTL STD ON PM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG ON ODS.TAKINGTYPE = PG.CODE " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODS.PAYMENTTYPE = PG2.CODE " & _
    '                     "LEFT OUTER JOIN PARAMGLOBAL PG3 ON ODS.STATUS = PG3.CODE " & _
    '             "WHERE ST.SERVICETYPEID=3 AND STD.SERVICETYPEDTLID=9 AND PG.TYPE ='TAKINGTYPE' AND PG2.TYPE='PAYMENT' AND ODS.STATUS=1 AND PG3.TYPE='ORDERSTATUS' AND ODS.MITRAID= '" & strMitraId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananFinishDePasarSembako(ByVal strEntityTypeId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
    '                           ",ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE " & _
    '                           ",PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL " & _
    '                           ",ODP.STATUS,PG2.NAME AS STATUSORDER " & _
    '                           ",ODP.ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE " & _
    '                           ",ODP.NOTES " & _
    '                     "FROM ORDERDEPASAR ODP " & _
    '                        "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID " & _
    '                        "LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
    '                        "LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE " & _
    '                        "LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID " & _
    '                        "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '             "WHERE ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=7 AND ODP.STATUS=1 AND PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND ODP.ENTITYTYPEID='" & strEntityTypeId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananFinishDePasarMakanan(ByVal strEntityTypeId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
    '                           ",ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE " & _
    '                           ",PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL " & _
    '                           ",ODP.STATUS,PG2.NAME AS STATUSORDER " & _
    '                           ",ODP.ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE " & _
    '                           ",ODP.NOTES " & _
    '                     "FROM ORDERDEPASAR ODP " & _
    '                        "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID " & _
    '                        "LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
    '                        "LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE " & _
    '                        "LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID " & _
    '                        "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '             "WHERE ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=10 AND ODP.STATUS=1 AND PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND ODP.ENTITYTYPEID='" & strEntityTypeId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananFinishDePasarPertanian(ByVal strEntityTypeId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
    '                           ",ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE " & _
    '                           ",PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL " & _
    '                           ",ODP.STATUS,PG2.NAME AS STATUSORDER " & _
    '                           ",ODP.ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE " & _
    '                           ",ODP.NOTES " & _
    '                     "FROM ORDERDEPASAR ODP " & _
    '                        "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID " & _
    '                        "LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
    '                        "LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE " & _
    '                        "LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID " & _
    '                        "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '             "WHERE ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=11 AND ODP.STATUS=1 AND PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND ODP.ENTITYTYPEID='" & strEntityTypeId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananFinishDePasarKesehatan(ByVal strEntityTypeId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
    '                           ",ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE " & _
    '                           ",PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL " & _
    '                           ",ODP.STATUS,PG2.NAME AS STATUSORDER " & _
    '                           ",ODP.ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE " & _
    '                           ",ODP.NOTES " & _
    '                     "FROM ORDERDEPASAR ODP " & _
    '                        "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID " & _
    '                        "LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
    '                        "LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE " & _
    '                        "LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID " & _
    '                        "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '             "WHERE ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=12 AND ODP.STATUS=1 AND PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND ODP.ENTITYTYPEID='" & strEntityTypeId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananFinishDePasarPRT(ByVal strEntityTypeId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
    '                           ",ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE " & _
    '                           ",PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL " & _
    '                           ",ODP.STATUS,PG2.NAME AS STATUSORDER " & _
    '                           ",ODP.ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE " & _
    '                           ",ODP.NOTES " & _
    '                     "FROM ORDERDEPASAR ODP " & _
    '                        "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID " & _
    '                        "LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
    '                        "LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE " & _
    '                        "LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID " & _
    '                        "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '             "WHERE ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=13 AND ODP.STATUS=1 AND PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND ODP.ENTITYTYPEID='" & strEntityTypeId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananFinishDePasarElekTronik(ByVal strEntityTypeId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
    '                           ",ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE " & _
    '                           ",PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL " & _
    '                           ",ODP.STATUS,PG2.NAME AS STATUSORDER " & _
    '                           ",ODP.ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE " & _
    '                           ",ODP.NOTES " & _
    '                     "FROM ORDERDEPASAR ODP " & _
    '                        "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID " & _
    '                        "LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
    '                        "LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE " & _
    '                        "LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID " & _
    '                        "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '             "WHERE ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=14 AND ODP.STATUS=1 AND PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND ODP.ENTITYTYPEID='" & strEntityTypeId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananFinishDePasarPerkakas(ByVal strEntityTypeId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
    '                           ",ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE " & _
    '                           ",PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL " & _
    '                           ",ODP.STATUS,PG2.NAME AS STATUSORDER " & _
    '                           ",ODP.ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE " & _
    '                           ",ODP.NOTES " & _
    '                     "FROM ORDERDEPASAR ODP " & _
    '                        "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID " & _
    '                        "LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
    '                        "LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE " & _
    '                        "LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID " & _
    '                        "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '             "WHERE ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=15 AND ODP.STATUS=1 AND PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND ODP.ENTITYTYPEID='" & strEntityTypeId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananFinishDePasarOlahraga(ByVal strEntityTypeId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
    '                           ",ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE " & _
    '                           ",PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL " & _
    '                           ",ODP.STATUS,PG2.NAME AS STATUSORDER " & _
    '                           ",ODP.ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE " & _
    '                           ",ODP.NOTES " & _
    '                     "FROM ORDERDEPASAR ODP " & _
    '                        "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID " & _
    '                        "LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
    '                        "LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE " & _
    '                        "LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID " & _
    '                        "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '             "WHERE ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=16 AND ODP.STATUS=1 AND PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND ODP.ENTITYTYPEID='" & strEntityTypeId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    ' <WebMethod()>
    ' Public Function getPesananFinishDePasarOtomotif(ByVal strEntityTypeId As String) As String
    '     Dim objDB As New DBX
    '     Dim strSQL As String = ""
    '     Dim dt As DataTable = New DataTable
    '     oSC.Open()
    '     strSQL = " SELECT ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
    '                           ",ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE " & _
    '                           ",PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL " & _
    '                           ",ODP.STATUS,PG2.NAME AS STATUSORDER " & _
    '                           ",ODP.ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE " & _
    '                           ",ODP.NOTES " & _
    '                     "FROM ORDERDEPASAR ODP " & _
    '                        "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID " & _
    '                        "LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
    '                        "LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE " & _
    '                        "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE " & _
    '                        "LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID " & _
    '                        "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                        "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '             "WHERE ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=17 AND ODP.STATUS=1 AND PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND ODP.ENTITYTYPEID='" & strEntityTypeId & "'"
    '     Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '     da.Fill(dt)
    '     Dim strReturn As String = GetJson(dt)
    '     If da.Fill(dt) = 0 Then
    '         Return HttpStatusCode.NotFound
    '     Else
    '         Return strReturn
    '     End If
    '     oSC.Close()
    ' End Function
    'Public Function GetUploadImage(ByVal strImageId As Integer) As String
    '    Dim objDB As New DBX
    '    Dim strSQL As String = ""
    '    Dim dt As DataTable = New DataTable
    '    oSC.Open()
    '    strSQL = " SELECT API.IMAGEID,API.USERID,API.IMAGENAME,API.IMAGEDESCRIPTION,API.IMAGE " & _
    '                        " FROM APPUSERPARTNERIMAGE API" & _
    '                        " INNER JOIN APPUSERPARTNER AP ON API.USERID=AP.USERID " & _
    '                    " WHERE API.USERID = " & strImageId & " AND (API.Deletests = 0) "
    '    Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '    da.Fill(dt)
    '    Dim strReturn As String = GetJson(dt)
    '    If da.Fill(dt) = 0 Then
    '        Return HttpStatusCode.NotFound
    '    Else
    '        Return strReturn
    '    End If
    '    oSC.Close()
    'End Function
End Class
