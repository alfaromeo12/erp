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
Public Class DestarWebService
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
    Public Function CustomersLogin(ByVal strUserName As String,
         ByVal strPwd As String, ByVal strHardwareID As String) As String
        Dim strPassword As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        ' Dim oSDR As System.Data.SqlClient.SqlDataReader
        strPassword = Replace(RC4Engine.rc4(strPwd), "'", "''")
        oSC.Open()
        strSQL = " SELECT AUC.UID, AUC.USERNAME, AUC.PASSWORD,AUC.ACTIVE,AUC.CUSTOMERTYPEID,CT.CUSTOMERTYPENAME ,AUC.HARDWAREID FROM APPUSERCLIENT AUC " & _
                                           " LEFT OUTER JOIN CUSTOMERTYPE CT ON AUC.CUSTOMERTYPEID = CT.CUSTOMERTYPEID " & _
                                           " WHERE AUC.DELETESTS = 0 And ACTIVE = 1 And USERNAME = '" & strUserName & "' AND PASSWORD = '" & strPassword & "' "
        Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)
        If da.Fill(dt) = 0 Then
            Return HttpStatusCode.NotFound
            oSC.Close()
        Else
            oSC.Close()
            ' Tambahan 
            ' 1. Update hardware id menjadi "-" untuk menghindari Double Row
            ' 2. Update  hardware id menjadi strHardwareID sesuai dengan username
            Dim strSQL1 As String = ""
            Dim dt1 As DataTable = New DataTable
            Dim dt2 As DataTable = New DataTable
            Dim oSC1 As New System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("connection").ConnectionString())
            Dim oSC2 As New System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("connection").ConnectionString())
            oSC1.Open()
            '1. =================================================== Update ID HArdware Jadi "-"
            strSQL1 = " UPDATE APPUSERCLIENT " & _
                        " SET HARDWAREID = '-'" & _
                      " WHERE HARDWAREID = '" & strHardwareID & "'"
            Dim da1 As New System.Data.SqlClient.SqlDataAdapter(strSQL1, oSC1)
            da1.Fill(dt1)
            oSC1.Close()

            '2. ===================================================== Update Idhardware jadi idhardware baru
            oSC2.Open()
            strSQL1 = " UPDATE APPUSERCLIENT " & _
                        " SET HARDWAREID = '" & strHardwareID & "'" & _
                      " WHERE USERNAME = '" & strUserName & "'"
            Dim da2 As New System.Data.SqlClient.SqlDataAdapter(strSQL1, oSC2)
            da2.Fill(dt2)
            oSC2.Close()
            Return strReturn
        End If
    End Function
    <WebMethod()>
    Public Function CustomersLogOut(ByVal strHardwareID As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " UPDATE APPUSERCLIENT " & _
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
    Public Function CustomersDetail(ByVal strUserName As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT AUC.UID,AUC.USERNAME,ISNULL(AUC.IDNUMBER,'-')IDNUMBER,AUC.FULLNAME,AUC.PASSWORD,AUC.EMAIL,AUC.MOBILENO,AUC.CUSTOMERTYPEID" & _
                     " ,ISNULL(AUC.PROVINCEID,'')PROVINCEID,ISNULL(P.PROVINCENAME,'-')PROVINCENAME, ISNULL(AUC.KABUPATENID,'')KABUPATENID,ISNULL(K.KABUPATENNAME,'-')KABUPATENNAME," & _
                      " ISNULL(AUC.KECAMATANID,'')KECAMATANID,ISNULL(KC.KECAMATANNAME ,'-')KECAMATANNAME,AUC.ADDRESS,AUC.ACTIVE " & _
                      " ,AUC.IMAGE,CONVERT(VARCHAR,CONVERT(date,AUC.REGISTERDATE,103),103)REGISTERDATE,AUC.HARDWAREID,CONVERT(VARCHAR,CONVERT(date,AUC.LASTUPDATE,103),103)LASTUPDATE,AUC.DELETESTS" & _
                  " FROM APPUSERCLIENT AUC WITH(NOLOCK)" & _
                  " LEFT OUTER JOIN CUSTOMERTYPE CT ON AUC.CUSTOMERTYPEID = CT.CUSTOMERTYPEID" & _
                  " LEFT OUTER JOIN PROVINCE P ON AUC.PROVINCEID = P.PROVINCEID" & _
                  " LEFT OUTER JOIN KABUPATEN K ON AUC.KABUPATENID = K.KABUPATENID" & _
                  " LEFT OUTER JOIN KECAMATAN KC ON AUC.KECAMATANID = KC.KECAMATANID" & _
                  " WHERE AUC.DELETESTS = 0 And AUC.ACTIVE = 1 And AUC.USERNAME = '" & strUserName & "'"
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
    Public Function CustomersDetailX(ByVal strUserid As String) As String
        Dim strPassword As String = ""
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        Dim objDBX As New DBX
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDBX.CreateSDRFromSQLSelect("Select Password from APPUSERCLIENT Where UID=" & strUserid & " ")
            If oSDR.Read Then
                'strPassword = objRC4.Encrypt(oSDR("Password"))
                strPassword = RC4Engine.rc4(oSDR("Password"))
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDBX.Close()
            objDBX = Nothing
            'objRC4 = Nothing
        End Try
        oSC.Open()
        strSQL = "SELECT UC.UID,UC.USERNAME,UC.IDNUMBER,UC.FULLNAME,'" & strPassword & "' AS PASSWORD,UC.EMAIL,UC.MOBILENO,UC.CUSTOMERTYPEID,CT.CUSTOMERTYPENAME " & _
                                               " ,UC.PROVINCEID,UC.KABUPATENID,KAB.KABUPATENNAME,UC.KECAMATANID,KEC.KECAMATANNAME " & _
                                               "  ,UC.ADDRESS,UC.ACTIVE,CONVERT(VARCHAR,CONVERT(date,UC.REGISTERDATE,103),103)REGISTERDATE,P.PROVINCENAME " & _
                        "FROM APPUSERCLIENT UC " & _
                                     " LEFT OUTER JOIN PROVINCE P ON UC.PROVINCEID=P.PROVINCEID " & _
                                   "   LEFT OUTER JOIN KABUPATEN KAB ON UC.KABUPATENID=KAB.KABUPATENID " & _
                                    "  LEFT OUTER JOIN KECAMATAN KEC ON UC.KECAMATANID=KEC.KECAMATANID " & _
                                   "   LEFT OUTER JOIN CUSTOMERTYPE CT ON UC.CUSTOMERTYPEID=CT.CUSTOMERTYPEID " & _
                        "WHERE (UC.Deletests = 0) AND UC.UID = " & strUserid & ""
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
    Public Function CustomersUpdateX(ByVal strIdNumber As String, ByVal strFullName As String, ByVal strEmail As String, ByVal strMobileNo As String, ByVal strUserid As String, ByVal strPassword As String) As String
        Dim objDB As New DBX
        Dim strPwd As String

        strPwd = Replace(RC4Engine.rc4(strPassword), "'", "''")
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("APPUSERCLIENTRUPDATEMBL",
                                                        objDB.MP("@IDNUMBER", Data.SqlDbType.VarChar, strIdNumber),
                                                        objDB.MP("@FULLNAME", Data.SqlDbType.VarChar, strFullName),
                                                        objDB.MP("@EMAIL", Data.SqlDbType.VarChar, strEmail),
                                                        objDB.MP("@MOBILENO", Data.SqlDbType.VarChar, strMobileNo),
                                                        objDB.MP("@PASSWORD", Data.SqlDbType.VarChar, strPwd),
                                                        objDB.MP("@USERID", Data.SqlDbType.Int, strUserid),
                                                        objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetval, 10, Data.ParameterDirection.Output))
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
    Public Function CustomerRegister(ByVal strUserName As String, ByVal strFullName As String,
            ByVal strEmail As String,
            ByVal strPwd As String,
            ByVal strMobileNumber As String, ByVal strCustomerType As Integer,
            ByVal strHrdwareID As String) As String
        Dim strPassword As String
        Dim objDB As New DBX
        strPassword = Replace(RC4Engine.rc4(strPwd), "'", "''")
        Dim intRetval As Integer
        Dim intUID As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("APPUserClientAdd",
                                                        objDB.MP("@USERNAME", Data.SqlDbType.VarChar, strUserName),
                                                        objDB.MP("@FULLNAME", Data.SqlDbType.VarChar, strFullName),
                                                        objDB.MP("@PASSWORD", Data.SqlDbType.VarChar, strPassword),
                                                        objDB.MP("@EMAIL", Data.SqlDbType.VarChar, strEmail),
                                                        objDB.MP("@MOBILENO", Data.SqlDbType.VarChar, strMobileNumber),
                                                        objDB.MP("@CUSTOMERTYPEID", Data.SqlDbType.Int, strCustomerType),
                                                        objDB.MP("@HARDWAREID", Data.SqlDbType.VarChar, strHrdwareID),
                                                        objDB.MP("@UID", Data.SqlDbType.Int, intUID, 10, Data.ParameterDirection.Output),
                                                        objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetval, 10, Data.ParameterDirection.Output))
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
    Public Function CustomerUpdatepassword(ByVal strUserId As String, ByVal strPwd As String) As String
        Dim strPassword As String
        Dim objDB As New DBX
        strPassword = Replace(RC4Engine.rc4(strPwd), "'", "''")
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("APPUserClientUpdatePassword",
                                                        objDB.MP("@PASSWORD", Data.SqlDbType.VarChar, strPassword),
                                                        objDB.MP("@UID", Data.SqlDbType.Int, strUserId),
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
    Public Function OrderDebarang(ByVal strCustomerID As Integer,
            ByVal strArmadaId As Integer, ByVal strPickUpLoc As String, ByVal strPickUpLocLat As String, ByVal strPickUpLocLong As String,
            ByVal strDestinationLoc As String, ByVal strDestinationLocLat As String, ByVal strDestinationLocLong As String,
            ByVal strPrice As String, ByVal strDistance As String,
            ByVal strDuration As String, ByVal strOrderDate As DateTime,
            ByVal strNotes As String, ByVal strLong As String, ByVal strLat As String,
            ByVal strOrderTime As String, ByVal strWeight As String, ByVal strType As String) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection

        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDEBARANGADD",
                                                        objDB.MP("@CUSTOMERID", Data.SqlDbType.Int, strCustomerID),
                                                        objDB.MP("@ARMADAID", Data.SqlDbType.Int, strArmadaId),
                                                        objDB.MP("@PICKUPLOC", Data.SqlDbType.VarChar, strPickUpLoc),
                                                        objDB.MP("@PICKUPLOCLAT", Data.SqlDbType.VarChar, strPickUpLocLat),
                                                        objDB.MP("@PICKUPLOCLONG", Data.SqlDbType.VarChar, strPickUpLocLong),
                                                        objDB.MP("@DESTINATIONLOC", Data.SqlDbType.VarChar, strDestinationLoc),
                                                        objDB.MP("@DESTINATIONLOCLAT", Data.SqlDbType.VarChar, strDestinationLocLat),
                                                        objDB.MP("@DESTINATIONLOCLONG", Data.SqlDbType.VarChar, strDestinationLocLong),
                                                        objDB.MP("@PRICE", Data.SqlDbType.VarChar, strPrice),
                                                        objDB.MP("@DISTANCE", Data.SqlDbType.VarChar, strDistance),
                                                        objDB.MP("@DURATION", Data.SqlDbType.VarChar, strDuration),
                                                        objDB.MP("@ORDERDATE", Data.SqlDbType.Date, strOrderDate),
                                                        objDB.MP("@WEIGHT", Data.SqlDbType.VarChar, strWeight),
                                                        objDB.MP("@TYPE", Data.SqlDbType.VarChar, strType),
                                                        objDB.MP("@NOTES", Data.SqlDbType.VarChar, strNotes),
                                                        objDB.MP("@LATITUDE", Data.SqlDbType.VarChar, strLat),
                                                        objDB.MP("@LONGITUDE", Data.SqlDbType.VarChar, strLong),
                                                        objDB.MP("@ORDERTIME", Data.SqlDbType.VarChar, strOrderTime),
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
    Public Function OrderDeJek(ByVal strCustomerID As Integer,
            ByVal strArmadaId As Integer, ByVal strPickUpLoc As String, ByVal strPickUpLocLat As String, ByVal strPickUpLocLong As String,
            ByVal strDestinationLoc As String, ByVal strDestinationLocLat As String, ByVal strDestinationLocLong As String,
            ByVal strPrice As String, ByVal strDistance As String,
            ByVal strDuration As String,
            ByVal strNotes As String, ByVal strLong As String, ByVal strLat As String) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        strArmadaId = 12
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDEJEKADD",
                                                        objDB.MP("@CUSTOMERID", Data.SqlDbType.Int, strCustomerID),
                                                        objDB.MP("@ARMADAID", Data.SqlDbType.Int, strArmadaId),
                                                        objDB.MP("@PICKUPLOC", Data.SqlDbType.VarChar, strPickUpLoc),
                                                        objDB.MP("@PICKUPLOCLAT", Data.SqlDbType.VarChar, strPickUpLocLat),
                                                        objDB.MP("@PICKUPLOCLONG", Data.SqlDbType.VarChar, strPickUpLocLong),
                                                        objDB.MP("@DESTINATIONLOC", Data.SqlDbType.VarChar, strDestinationLoc),
                                                        objDB.MP("@DESTINATIONLOCLAT", Data.SqlDbType.VarChar, strDestinationLocLat),
                                                        objDB.MP("@DESTINATIONLOCLONG", Data.SqlDbType.VarChar, strDestinationLocLong),
                                                        objDB.MP("@PRICE", Data.SqlDbType.VarChar, strPrice),
                                                        objDB.MP("@DISTANCE", Data.SqlDbType.VarChar, strDistance),
                                                        objDB.MP("@DURATION", Data.SqlDbType.VarChar, strDuration),
                                                        objDB.MP("@NOTES", Data.SqlDbType.VarChar, strNotes),
                                                        objDB.MP("@LATITUDE", Data.SqlDbType.VarChar, strLat),
                                                        objDB.MP("@LONGITUDE", Data.SqlDbType.VarChar, strLong),
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
    Public Function OrderDeCar(ByVal strCustomerID As Integer,
            ByVal strArmadaId As Integer, ByVal strPickUpLoc As String, ByVal strPickUpLocLat As String, ByVal strPickUpLocLong As String,
            ByVal strDestinationLoc As String, ByVal strDestinationLocLat As String, ByVal strDestinationLocLong As String,
            ByVal strPrice As String, ByVal strDistance As String,
            ByVal strDuration As String,
            ByVal strNotes As String, ByVal strLong As String, ByVal strLat As String) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        strArmadaId = 10
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDECARADD",
                                                        objDB.MP("@CUSTOMERID", Data.SqlDbType.Int, strCustomerID),
                                                        objDB.MP("@ARMADAID", Data.SqlDbType.Int, strArmadaId),
                                                        objDB.MP("@PICKUPLOC", Data.SqlDbType.VarChar, strPickUpLoc),
                                                        objDB.MP("@PICKUPLOCLAT", Data.SqlDbType.VarChar, strPickUpLocLat),
                                                        objDB.MP("@PICKUPLOCLONG", Data.SqlDbType.VarChar, strPickUpLocLong),
                                                        objDB.MP("@DESTINATIONLOC", Data.SqlDbType.VarChar, strDestinationLoc),
                                                        objDB.MP("@DESTINATIONLOCLAT", Data.SqlDbType.VarChar, strDestinationLocLat),
                                                        objDB.MP("@DESTINATIONLOCLONG", Data.SqlDbType.VarChar, strDestinationLocLong),
                                                        objDB.MP("@PRICE", Data.SqlDbType.VarChar, strPrice),
                                                        objDB.MP("@DISTANCE", Data.SqlDbType.VarChar, strDistance),
                                                        objDB.MP("@DURATION", Data.SqlDbType.VarChar, strDuration),
                                                        objDB.MP("@NOTES", Data.SqlDbType.VarChar, strNotes),
                                                        objDB.MP("@LATITUDE", Data.SqlDbType.VarChar, strLat),
                                                        objDB.MP("@LONGITUDE", Data.SqlDbType.VarChar, strLong),
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
    Public Function CekHardwareIDCustomer(ByVal strHardwareID As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT AUC.UID,AUC.USERNAME, AUC.PASSWORD,AUC.ACTIVE,AUC.CUSTOMERTYPEID,CT.CUSTOMERTYPENAME ,AUC.HARDWAREID FROM APPUSERCLIENT AUC " & _
                                           " LEFT OUTER JOIN CUSTOMERTYPE CT ON AUC.CUSTOMERTYPEID = CT.CUSTOMERTYPEID " & _
                                            " WHERE HARDWAREID = '" & strHardwareID & "' "
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
    Public Function UpdateHardwareIDCustomer(ByVal strHardwareID As String, ByVal strUserName As String) As String
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
    <WebMethod()>
    Public Function GetServiceType() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT SERVICETYPEID, SERVICETYPECODE, SERVICETYPENAME,IMAGEURL FROM SERVICETYPE WHERE (DELETESTS = 0) "
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
    Public Function GetServiceTypeDetail() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT STD.SERVICETYPEDTLID,STD.SERVICETYPEDTLCODE,STD.SERVICETYPEDTLNAME " & _
                            ",STD.SERVICETYPEID,ST.SERVICETYPENAME,STD.IMAGEURL " & _
                        " FROM SERVICETYPEDTL STD " & _
                        " LEFT OUTER JOIN SERVICETYPE ST ON STD.SERVICETYPEID = ST.SERVICETYPEID " & _
                        " WHERE (STD.DELETESTS = 0) "
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
    Public Function GetArmadaTypeDeantarBarang() As String
        'Public Function GetArmadaTypeDeantarBarang(ByVal strServiceTypeDtlId As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT ARM.ARMADAID,ARM.ARMADACODE,ARM.ARMADANAME,ARM.ARMADATYPEID,AMT.ARMADATYPENAME,STD.SERVICETYPEID " & _
                            ",ST.SERVICETYPENAME,ARM.SERVICETYPEDTLID,STD.SERVICETYPEDTLNAME,ARM.MINCAPACITY,ARM.UNITMINCAPACITY " & _
                             ",MU.MASTERUNITCODE AS UNITMINCAP,ARM.MAXCAPACITY,ARM.UNITMAXCAPACITY,MU2.MASTERUNITCODE AS UNITMAXCAP " & _
                             ",ARM.DISTANCEMIN,ARM.UNITDISTANCEMIN ,MU3.MASTERUNITCODE AS UNITDISTMIN,ARM.DISTANCEMAX,ARM.UNITDISTANCEMAX " & _
                             ",MU4.MASTERUNITCODE AS UNITDISTMAX,CONVERT(VARCHAR(MAX),CAST(ARM.TARIFMIN AS MONEY),1)TARIFMIN,ARM.IMAGEURL," & _
                             " CONVERT(VARCHAR(MAX),CAST( MT.TARIFPERKM AS MONEY),1) TARIFPERKM " & _
                        "FROM MASTERARMADA ARM" & _
                                " LEFT OUTER JOIN MASTERARMADATYPE AMT ON ARM.ARMADATYPEID = AMT.ARMADATYPEID " & _
                                " LEFT OUTER JOIN SERVICETYPEDTL STD ON ARM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                                " LEFT OUTER JOIN SERVICETYPE ST ON STD.SERVICETYPEID = ST.SERVICETYPEID " & _
                                " LEFT OUTER JOIN MASTERUNIT MU ON ARM.UNITMINCAPACITY = MU.MASTERUNITID " & _
                                " LEFT OUTER JOIN MASTERUNIT MU2 ON ARM.UNITMAXCAPACITY = MU2.MASTERUNITID " & _
                                " LEFT OUTER JOIN MASTERUNIT MU3 ON ARM.UNITDISTANCEMIN = MU3.MASTERUNITID " & _
                                " LEFT OUTER JOIN MASTERUNIT MU4 ON ARM.UNITDISTANCEMAX = MU4.MASTERUNITID " & _
                                " LEFT OUTER JOIN MASTERTARIF MT ON ARM.ARMADAID = MT.ARMADAID" & _
                        " WHERE ARM.SERVICETYPEDTLID = 1 AND (ARM.Deletests = 0) "
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
    Public Function GetArmadaTypeDeantarDeOjek() As String
        'Public Function GetArmadaTypeDeantarBarang(ByVal strServiceTypeDtlId As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT ARM.ARMADAID,ARM.ARMADACODE,ARM.ARMADANAME,ARM.ARMADATYPEID,AMT.ARMADATYPENAME,STD.SERVICETYPEID " & _
                            ",ST.SERVICETYPENAME,ARM.SERVICETYPEDTLID,STD.SERVICETYPEDTLNAME,ARM.MINCAPACITY,ARM.UNITMINCAPACITY " & _
                             ",MU.MASTERUNITCODE AS UNITMINCAP,ARM.MAXCAPACITY,ARM.UNITMAXCAPACITY,MU2.MASTERUNITCODE AS UNITMAXCAP " & _
                             ",ARM.DISTANCEMIN,ARM.UNITDISTANCEMIN ,MU3.MASTERUNITCODE AS UNITDISTMIN,ARM.DISTANCEMAX,ARM.UNITDISTANCEMAX " & _
                             ",MU4.MASTERUNITCODE AS UNITDISTMAX,CONVERT(VARCHAR(MAX),CAST(ARM.TARIFMIN AS MONEY),1)TARIFMIN,ARM.IMAGEURL " & _
                        "FROM MASTERARMADA ARM" & _
                                " LEFT OUTER JOIN MASTERARMADATYPE AMT ON ARM.ARMADATYPEID = AMT.ARMADATYPEID " & _
                                " LEFT OUTER JOIN SERVICETYPEDTL STD ON ARM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                                " LEFT OUTER JOIN SERVICETYPE ST ON STD.SERVICETYPEID = ST.SERVICETYPEID " & _
                                " LEFT OUTER JOIN MASTERUNIT MU ON ARM.UNITMINCAPACITY = MU.MASTERUNITID " & _
                                " LEFT OUTER JOIN MASTERUNIT MU2 ON ARM.UNITMAXCAPACITY = MU2.MASTERUNITID " & _
                                " LEFT OUTER JOIN MASTERUNIT MU3 ON ARM.UNITDISTANCEMIN = MU3.MASTERUNITID " & _
                                " LEFT OUTER JOIN MASTERUNIT MU4 ON ARM.UNITDISTANCEMAX = MU4.MASTERUNITID " & _
                        " WHERE ARM.SERVICETYPEDTLID = 2 AND (ARM.Deletests = 0) "
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
    Public Function GetArmadaTypeDeantarDeCar() As String
        'Public Function GetArmadaTypeDeantarBarang(ByVal strServiceTypeDtlId As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT ARM.ARMADAID,ARM.ARMADACODE,ARM.ARMADANAME,ARM.ARMADATYPEID,AMT.ARMADATYPENAME,STD.SERVICETYPEID " & _
                            ",ST.SERVICETYPENAME,ARM.SERVICETYPEDTLID,STD.SERVICETYPEDTLNAME,ARM.MINCAPACITY,ARM.UNITMINCAPACITY " & _
                             ",MU.MASTERUNITCODE AS UNITMINCAP,ARM.MAXCAPACITY,ARM.UNITMAXCAPACITY,MU2.MASTERUNITCODE AS UNITMAXCAP " & _
                             ",ARM.DISTANCEMIN,ARM.UNITDISTANCEMIN ,MU3.MASTERUNITCODE AS UNITDISTMIN,ARM.DISTANCEMAX,ARM.UNITDISTANCEMAX " & _
                             ",MU4.MASTERUNITCODE AS UNITDISTMAX,CONVERT(VARCHAR(MAX),CAST(ARM.TARIFMIN AS MONEY),1)TARIFMIN,ARM.IMAGEURL " & _
                        "FROM MASTERARMADA ARM" & _
                                " LEFT OUTER JOIN MASTERARMADATYPE AMT ON ARM.ARMADATYPEID = AMT.ARMADATYPEID " & _
                                " LEFT OUTER JOIN SERVICETYPEDTL STD ON ARM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                                " LEFT OUTER JOIN SERVICETYPE ST ON STD.SERVICETYPEID = ST.SERVICETYPEID " & _
                                " LEFT OUTER JOIN MASTERUNIT MU ON ARM.UNITMINCAPACITY = MU.MASTERUNITID " & _
                                " LEFT OUTER JOIN MASTERUNIT MU2 ON ARM.UNITMAXCAPACITY = MU2.MASTERUNITID " & _
                                " LEFT OUTER JOIN MASTERUNIT MU3 ON ARM.UNITDISTANCEMIN = MU3.MASTERUNITID " & _
                                " LEFT OUTER JOIN MASTERUNIT MU4 ON ARM.UNITDISTANCEMAX = MU4.MASTERUNITID " & _
                        " WHERE ARM.SERVICETYPEDTLID = 3 AND (ARM.Deletests = 0) "
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
    Public Function GetArmadaTypeDeantarLainnya() As String
        'Public Function GetArmadaTypeDeantarBarang(ByVal strServiceTypeDtlId As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT ARM.ARMADAID,ARM.ARMADACODE,ARM.ARMADANAME,ARM.ARMADATYPEID,AMT.ARMADATYPENAME,STD.SERVICETYPEID " & _
                            ",ST.SERVICETYPENAME,ARM.SERVICETYPEDTLID,STD.SERVICETYPEDTLNAME,ARM.MINCAPACITY,ARM.UNITMINCAPACITY " & _
                             ",MU.MASTERUNITCODE AS UNITMINCAP,ARM.MAXCAPACITY,ARM.UNITMAXCAPACITY,MU2.MASTERUNITCODE AS UNITMAXCAP " & _
                             ",ARM.DISTANCEMIN,ARM.UNITDISTANCEMIN ,MU3.MASTERUNITCODE AS UNITDISTMIN,ARM.DISTANCEMAX,ARM.UNITDISTANCEMAX " & _
                             ",MU4.MASTERUNITCODE AS UNITDISTMAX,CONVERT(VARCHAR(MAX),CAST(ARM.TARIFMIN AS MONEY),1)TARIFMIN,ARM.IMAGEURL " & _
                        "FROM MASTERARMADA ARM" & _
                                " LEFT OUTER JOIN MASTERARMADATYPE AMT ON ARM.ARMADATYPEID = AMT.ARMADATYPEID " & _
                                " LEFT OUTER JOIN SERVICETYPEDTL STD ON ARM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                                " LEFT OUTER JOIN SERVICETYPE ST ON STD.SERVICETYPEID = ST.SERVICETYPEID " & _
                                " LEFT OUTER JOIN MASTERUNIT MU ON ARM.UNITMINCAPACITY = MU.MASTERUNITID " & _
                                " LEFT OUTER JOIN MASTERUNIT MU2 ON ARM.UNITMAXCAPACITY = MU2.MASTERUNITID " & _
                                " LEFT OUTER JOIN MASTERUNIT MU3 ON ARM.UNITDISTANCEMIN = MU3.MASTERUNITID " & _
                                " LEFT OUTER JOIN MASTERUNIT MU4 ON ARM.UNITDISTANCEMAX = MU4.MASTERUNITID " & _
                        " WHERE ARM.SERVICETYPEDTLID = 8 AND (ARM.Deletests = 0) "
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
    Public Function GetServiceTypeDtlDesewa() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT STD.SERVICETYPEDTLID,STD.SERVICETYPEDTLCODE,STD.SERVICETYPEDTLNAME,STD.SERVICETYPEID " & _
                            ",ST.SERVICETYPENAME,STD.IMAGEURL " & _
                    " FROM SERVICETYPEDTL STD " & _
                                " LEFT OUTER JOIN SERVICETYPE ST ON STD.SERVICETYPEID = ST.SERVICETYPEID " & _
                    " WHERE STD.SERVICETYPEID =3 AND (STD.DELETESTS = 0) "
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
    Public Function GetProductListDepasarSembako() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT MP.PRODUCTID,MP.PRODUCTCODE,MP.PRODUCTNAME,MP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
                              ",MP.SERVICETYPEID,ST.SERVICETYPENAME,MP.SERVICETYPEDTLID,STD.SERVICETYPEDTLNAME " & _
                              ",MP.PRICE,MP.DISCOUNT,MP.DISCOUNTPRICE,MP.CAPACITY,MP.UNITCAPACITY " & _
                              ",MU.MASTERUNITCODE AS UNITCAP,MP.INITIALSTOCK,MP.UNITSTOCK,MU2.MASTERUNITCODE AS STOCKUNIT " & _
                              ",MP.IMAGEURL,MP.DESCRIPTION " & _
                          "FROM MASTERPRODUCT MP " & _
                            "LEFT OUTER JOIN ENTITYTYPE ET ON MP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
                            "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
                            "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                            "LEFT OUTER JOIN MASTERUNIT MU ON MP.UNITCAPACITY = MU.MASTERUNITID " & _
                            "LEFT OUTER JOIN MASTERUNIT MU2 ON MP.UNITSTOCK = MU2.MASTERUNITID " & _
           " WHERE MP.DELETESTS=0 AND ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=7"
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
    Public Function GetProductListDepasarMakanan() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT MP.PRODUCTID,MP.PRODUCTCODE,MP.PRODUCTNAME,MP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
                              ",MP.SERVICETYPEID,ST.SERVICETYPENAME,MP.SERVICETYPEDTLID,STD.SERVICETYPEDTLNAME " & _
                              ",MP.PRICE,MP.DISCOUNT,MP.DISCOUNTPRICE,MP.CAPACITY,MP.UNITCAPACITY " & _
                              ",MU.MASTERUNITCODE AS UNITCAP,MP.INITIALSTOCK,MP.UNITSTOCK,MU2.MASTERUNITCODE AS STOCKUNIT " & _
                              ",MP.IMAGEURL,MP.DESCRIPTION " & _
                          "FROM MASTERPRODUCT MP " & _
                            "LEFT OUTER JOIN ENTITYTYPE ET ON MP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
                            "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
                            "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                            "LEFT OUTER JOIN MASTERUNIT MU ON MP.UNITCAPACITY = MU.MASTERUNITID " & _
                            "LEFT OUTER JOIN MASTERUNIT MU2 ON MP.UNITSTOCK = MU2.MASTERUNITID " & _
           " WHERE MP.DELETESTS=0 AND ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=10"
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
    Public Function GetProductListDepasarKesehatan() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT MP.PRODUCTID,MP.PRODUCTCODE,MP.PRODUCTNAME,MP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
                              ",MP.SERVICETYPEID,ST.SERVICETYPENAME,MP.SERVICETYPEDTLID,STD.SERVICETYPEDTLNAME " & _
                              ",MP.PRICE,MP.DISCOUNT,MP.DISCOUNTPRICE,MP.CAPACITY,MP.UNITCAPACITY " & _
                              ",MU.MASTERUNITCODE AS UNITCAP,MP.INITIALSTOCK,MP.UNITSTOCK,MU2.MASTERUNITCODE AS STOCKUNIT " & _
                              ",MP.IMAGEURL,MP.DESCRIPTION " & _
                          "FROM MASTERPRODUCT MP " & _
                            "LEFT OUTER JOIN ENTITYTYPE ET ON MP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
                            "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
                            "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                            "LEFT OUTER JOIN MASTERUNIT MU ON MP.UNITCAPACITY = MU.MASTERUNITID " & _
                            "LEFT OUTER JOIN MASTERUNIT MU2 ON MP.UNITSTOCK = MU2.MASTERUNITID " & _
           " WHERE MP.DELETESTS=0 AND ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=12"
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
    Public Function GetProductListDepasarRumahtangga() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT MP.PRODUCTID,MP.PRODUCTCODE,MP.PRODUCTNAME,MP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
                              ",MP.SERVICETYPEID,ST.SERVICETYPENAME,MP.SERVICETYPEDTLID,STD.SERVICETYPEDTLNAME " & _
                              ",MP.PRICE,MP.DISCOUNT,MP.DISCOUNTPRICE,MP.CAPACITY,MP.UNITCAPACITY " & _
                              ",MU.MASTERUNITCODE AS UNITCAP,MP.INITIALSTOCK,MP.UNITSTOCK,MU2.MASTERUNITCODE AS STOCKUNIT " & _
                              ",MP.IMAGEURL,MP.DESCRIPTION " & _
                          "FROM MASTERPRODUCT MP " & _
                            "LEFT OUTER JOIN ENTITYTYPE ET ON MP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
                            "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
                            "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                            "LEFT OUTER JOIN MASTERUNIT MU ON MP.UNITCAPACITY = MU.MASTERUNITID " & _
                            "LEFT OUTER JOIN MASTERUNIT MU2 ON MP.UNITSTOCK = MU2.MASTERUNITID " & _
           " WHERE MP.DELETESTS=0 AND ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=13"
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
    Public Function GetProductListDepasarElektronik() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT MP.PRODUCTID,MP.PRODUCTCODE,MP.PRODUCTNAME,MP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
                              ",MP.SERVICETYPEID,ST.SERVICETYPENAME,MP.SERVICETYPEDTLID,STD.SERVICETYPEDTLNAME " & _
                              ",MP.PRICE,MP.DISCOUNT,MP.DISCOUNTPRICE,MP.CAPACITY,MP.UNITCAPACITY " & _
                              ",MU.MASTERUNITCODE AS UNITCAP,MP.INITIALSTOCK,MP.UNITSTOCK,MU2.MASTERUNITCODE AS STOCKUNIT " & _
                              ",MP.IMAGEURL,MP.DESCRIPTION " & _
                          "FROM MASTERPRODUCT MP " & _
                            "LEFT OUTER JOIN ENTITYTYPE ET ON MP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
                            "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
                            "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                            "LEFT OUTER JOIN MASTERUNIT MU ON MP.UNITCAPACITY = MU.MASTERUNITID " & _
                            "LEFT OUTER JOIN MASTERUNIT MU2 ON MP.UNITSTOCK = MU2.MASTERUNITID " & _
           " WHERE MP.DELETESTS=0 AND ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=14"
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
    Public Function GetProductListDepasarPerkakas() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT MP.PRODUCTID,MP.PRODUCTCODE,MP.PRODUCTNAME,MP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
                              ",MP.SERVICETYPEID,ST.SERVICETYPENAME,MP.SERVICETYPEDTLID,STD.SERVICETYPEDTLNAME " & _
                              ",MP.PRICE,MP.DISCOUNT,MP.DISCOUNTPRICE,MP.CAPACITY,MP.UNITCAPACITY " & _
                              ",MU.MASTERUNITCODE AS UNITCAP,MP.INITIALSTOCK,MP.UNITSTOCK,MU2.MASTERUNITCODE AS STOCKUNIT " & _
                              ",MP.IMAGEURL,MP.DESCRIPTION " & _
                          "FROM MASTERPRODUCT MP " & _
                            "LEFT OUTER JOIN ENTITYTYPE ET ON MP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
                            "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
                            "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                            "LEFT OUTER JOIN MASTERUNIT MU ON MP.UNITCAPACITY = MU.MASTERUNITID " & _
                            "LEFT OUTER JOIN MASTERUNIT MU2 ON MP.UNITSTOCK = MU2.MASTERUNITID " & _
           " WHERE MP.DELETESTS=0 AND ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=15"
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
    Public Function GetProductListDepasarOlahraga() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT MP.PRODUCTID,MP.PRODUCTCODE,MP.PRODUCTNAME,MP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
                              ",MP.SERVICETYPEID,ST.SERVICETYPENAME,MP.SERVICETYPEDTLID,STD.SERVICETYPEDTLNAME " & _
                              ",MP.PRICE,MP.DISCOUNT,MP.DISCOUNTPRICE,MP.CAPACITY,MP.UNITCAPACITY " & _
                              ",MU.MASTERUNITCODE AS UNITCAP,MP.INITIALSTOCK,MP.UNITSTOCK,MU2.MASTERUNITCODE AS STOCKUNIT " & _
                              ",MP.IMAGEURL,MP.DESCRIPTION " & _
                          "FROM MASTERPRODUCT MP " & _
                            "LEFT OUTER JOIN ENTITYTYPE ET ON MP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
                            "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
                            "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                            "LEFT OUTER JOIN MASTERUNIT MU ON MP.UNITCAPACITY = MU.MASTERUNITID " & _
                            "LEFT OUTER JOIN MASTERUNIT MU2 ON MP.UNITSTOCK = MU2.MASTERUNITID " & _
           " WHERE MP.DELETESTS=0 AND ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=16"
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
    Public Function GetProductListDepasarOtomotif() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT MP.PRODUCTID,MP.PRODUCTCODE,MP.PRODUCTNAME,MP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
                              ",MP.SERVICETYPEID,ST.SERVICETYPENAME,MP.SERVICETYPEDTLID,STD.SERVICETYPEDTLNAME " & _
                              ",MP.PRICE,MP.DISCOUNT,MP.DISCOUNTPRICE,MP.CAPACITY,MP.UNITCAPACITY " & _
                              ",MU.MASTERUNITCODE AS UNITCAP,MP.INITIALSTOCK,MP.UNITSTOCK,MU2.MASTERUNITCODE AS STOCKUNIT " & _
                              ",MP.IMAGEURL,MP.DESCRIPTION " & _
                          "FROM MASTERPRODUCT MP " & _
                            "LEFT OUTER JOIN ENTITYTYPE ET ON MP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
                            "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
                            "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                            "LEFT OUTER JOIN MASTERUNIT MU ON MP.UNITCAPACITY = MU.MASTERUNITID " & _
                            "LEFT OUTER JOIN MASTERUNIT MU2 ON MP.UNITSTOCK = MU2.MASTERUNITID " & _
           " WHERE MP.DELETESTS=0 AND ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=17"
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
    Public Function GetProductListDepasarPertanian() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT MP.PRODUCTID,MP.PRODUCTCODE,MP.PRODUCTNAME,MP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
                              ",MP.SERVICETYPEID,ST.SERVICETYPENAME,MP.SERVICETYPEDTLID,STD.SERVICETYPEDTLNAME " & _
                              ",MP.PRICE,MP.DISCOUNT,MP.DISCOUNTPRICE,MP.CAPACITY,MP.UNITCAPACITY " & _
                              ",MU.MASTERUNITCODE AS UNITCAP,MP.INITIALSTOCK,MP.UNITSTOCK,MU2.MASTERUNITCODE AS STOCKUNIT " & _
                              ",MP.IMAGEURL,MP.DESCRIPTION " & _
                          "FROM MASTERPRODUCT MP " & _
                            "LEFT OUTER JOIN ENTITYTYPE ET ON MP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
                            "LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID " & _
                            "LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                            "LEFT OUTER JOIN MASTERUNIT MU ON MP.UNITCAPACITY = MU.MASTERUNITID " & _
                            "LEFT OUTER JOIN MASTERUNIT MU2 ON MP.UNITSTOCK = MU2.MASTERUNITID " & _
           " WHERE MP.DELETESTS=0 AND ST.SERVICETYPEID=2 AND STD.SERVICETYPEDTLID=11"
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
    Public Function GetContentNews() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT TOP (4) CONTENTID,CONTENTCODE,CONTENTNAME,CONVERT(VARCHAR,CONVERT(date,CONTENTDATE,103),103)CONTENTDATE,CONTENTURL,DESCRIPTION,Active,IMAGEURL " & _
                     "FROM CONTENTNEWS " & _
                     "WHERE Active = 1 " & _
                     "ORDER BY CONTENTDATE DESC"
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
    Public Function ProductDePasarAdd(ByVal strProductCode As String, ByVal strProductName As String,
            ByVal strEntityTypeid As Integer, ByVal strServTypeId As Integer,
            ByVal strServTypeDtlId As Integer, ByVal strPrice As String,
            ByVal strDiscount As String, ByVal strDisPrice As String,
            ByVal strCapacity As String, ByVal strUnit As Integer,
            ByVal strIntialStock As String, ByVal strUnitStock As Integer, ByVal strDescription As String,
            ByVal strImagePasar As String) As String

        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Dim imgByteDepasar As Byte() = Nothing
        imgByteDepasar = Convert.FromBase64String(strImagePasar)
        Try
            oSQLParam = objDB.ExecSPReturnParam("MASTERPRODUCTADD",
                                                        objDB.MP("@PRODUCTCODE", Data.SqlDbType.VarChar, strProductCode),
                                                        objDB.MP("@PRODUCTNAME", Data.SqlDbType.VarChar, strProductName),
                                                        objDB.MP("@ENTITYTYPEID", Data.SqlDbType.Int, strEntityTypeid),
                                                        objDB.MP("@SERVICETYPEID", Data.SqlDbType.Int, strServTypeId),
                                                        objDB.MP("@SERVICETYPEDTLID", Data.SqlDbType.Int, strServTypeDtlId),
                                                        objDB.MP("@PRICE", Data.SqlDbType.Decimal, strPrice),
                                                        objDB.MP("@DISCOUNT", Data.SqlDbType.Decimal, strDiscount),
                                                        objDB.MP("@DISCOUNTPRICE", Data.SqlDbType.Decimal, strDisPrice),
                                                        objDB.MP("@CAPACITY", Data.SqlDbType.NVarChar, strCapacity),
                                                        objDB.MP("@UNITCAPACITY", Data.SqlDbType.Int, strUnit),
                                                        objDB.MP("@INITIALSTOCK", Data.SqlDbType.NVarChar, strIntialStock),
                                                        objDB.MP("@UNITSTOCK", Data.SqlDbType.Int, strUnitStock),
                                                        objDB.MPByte("@IMAGEDEPASAR", Data.SqlDbType.Image, imgByteDepasar),
                                                        objDB.MP("@DESCRIPTION", Data.SqlDbType.VarChar, strDescription),
                                                        objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetval, 10, Data.ParameterDirection.Output))
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
    Public Function GetCurrentLocationCustomer(ByVal strUserid As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT USERID " & _
                          " ,LONGLAT " & _
                         " ,LASTUPDATE " & _
                " FROM CUSTOMERLASTLOCATION " & _
                     " WHERE LASTUPDATE=(SELECT MAX(LASTUPDATE) FROM CUSTOMERLASTLOCATION " & _
                     " WHERE USERID=" & strUserid & ") "
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
   
End Class