Imports System.Data
Imports System.Web
Imports System.Web.Script.Services
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Xml
Imports Newtonsoft.Json


<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
<System.Web.Script.Services.ScriptService()> _
Public Class GHWService
    Inherits System.Web.Services.WebService

    Dim oSC As New System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("connection").ConnectionString())

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
    Public Function DayAdd(ByVal strInterval As String,
            ByVal strNumber As String,
            ByVal strDate As String,
            ByVal strDateFormat As String) As String
        Dim strNewDate As String = ""
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("Select Convert(varchar(20), DateAdd(" & strInterval & " , " & strNumber & ", Convert(datetime, '" & strDate & "', " & strDateFormat & ")), " & strDateFormat & " ) NewDay")
            If oSDR.Read Then
                strNewDate = oSDR("NewDay").ToString
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception

        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return strNewDate
    End Function
    <WebMethod()>
    Public Function UserLogin(ByVal strUserID As String,
            ByVal strPwd As String) As String
        Dim strPassword As String
        strPassword = Replace(RC4Engine.rc4(strPwd), "'", "''")

        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        Dim oSC As New System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("connection").ConnectionString())
        oSC.Open()
        strSQL = "SELECT dbo.f_getAppSetting('USRTIMEOUT') TimeOut,  dbo.f_getAppDate()APPDate, UID, UserID, " &
                " UserName, Password, Counter, Active, NeverExpires, ValidFordays, PasswordDate, LastLogin, MenuStyle " &
                " FROM APPUser  WITH(NOLOCK) WHERE (UserID = '" + strUserID + "') AND (Password = '" + strPassword + "')"

        Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)
        Return strReturn
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UserRegisterClient(ByVal uid As String, ByVal strUserID As String,
            ByVal strUserName As String,
            ByVal strIdNumber As String,
            ByVal strFullName As String,
            ByVal strPassword As String,
            ByVal strEmail As String,
            ByVal strMobileNumber As String, ByVal strProvinceID As Integer, ByVal strCityId As Integer, ByVal strAddress As String) As String
        Dim strPwd As String
        strPwd = Replace(RC4Engine.rc4(strPassword), "'", "''")
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable

        oSC.Open()
        strSQL = "INSERT INTO dbo.APPUSERCLIENT " &
               "(UID, USERID, USERNAME,FULLNAME, PASSWORD, EMAIL, MOBILENO " &
               " ,PROVINSIID,CITYID,ADDRESS,ACTIVE,LASTUPDATE,Deletests) " &
         "VALUES " &
               " ('" & uid & "','" & strUserID & "','" & strUserName & "','" & strIdNumber & "','" & strFullName & "', '" & strPwd & "','" & strEmail & "', '" & strMobileNumber & "','" & strProvinceID & "','" & strCityId & "' " &
               ", '" & strAddress & "',0,GETDATE(),0)"

        Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)
        Return strReturn
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UserRegisterMember(ByVal uid As String, ByVal strUserID As String,
            ByVal strUserName As String,
            ByVal strFullName As String,
            ByVal strIdNumber As String,
            ByVal strTglLahir As DateTime,
            ByVal strPassword As String,
            ByVal strEmail As String,
            ByVal strMobileNumber As String, ByVal strProvinceID As Integer, ByVal strCityId As Integer, ByVal strAddress As String,
            ByVal strPatnerId As Integer, ByVal strBalance As String) As String
        Dim strPwd As String
        strPwd = Replace(RC4Engine.rc4(strPassword), "'", "''")
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable

        oSC.Open()
        strSQL = "INSERT INTO dbo.APPUSERPATNER " &
               "(UID, USERID, USERNAME,FULLNAME,IDNUMBER,TGLLAHIR, PASSWORD, EMAIL, MOBILENO " &
               " ,PROVINSIID,CITYID,ADDRESS,ACTIVE,PATNERID,BALANCE,LASTUPDATE,Deletests) " &
         "VALUES " &
               " ('" & uid & "','" & strUserID & "','" & strUserName & "','" & strFullName & "','" & strIdNumber & "','" & strTglLahir & "', '" & strPwd & "','" & strEmail & "', '" & strMobileNumber & "','" & strProvinceID & "','" & strCityId & "' " &
               ", '" & strAddress & "','" & strPatnerId & "','" & strBalance & "',0,GETDATE(),0)"

        Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)
        Return strReturn
    End Function
    <WebMethod()> _
    Public Function GetNextWorkingDay(ByVal strDate As String, _
             ByVal strInterval As String, _
             ByVal strDateFormat As String) As String
        Dim strNewDate As String = ""
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT CONVERT(VARCHAR(20), dbo.f_getNextWorkingDate(DATEADD(day, " & strInterval & ", CONVERT(DATETIME, '" & strDate & "', " & strDateFormat & "))), " & strDateFormat & ") NewDay")
            If oSDR.Read Then
                strNewDate = oSDR("NewDay").ToString()
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception

        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return strNewDate
    End Function

    <WebMethod()> _
    Public Function GetCustomerInfo(ByVal strLocCustID As String, ByVal strCustID As String) As String
        Dim strCustInfo As String = ""
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT CUSTNAME + '|' + ISNULL(BIRTHPLACE, '') + '|' + ISNULL(CONVERT(VARCHAR(20), BIRTHDATE, 103), '')  " & _
             " + '|' + ISNULL(CUSTADDR, '') + '|' + ISNULL(CUSTCITY, '')+ '|' + ISNULL(CUSTZIP, '') " & _
             " + '|' + '(' + ISNULL(CUSTPHONEAREA, '') + ') ' +  + ISNULL(CUSTPHONE, '') + '|' + ISNULL(PARAMGLOBAL.NAME, '') " & _
             " + '|' + ISNULL(IDNO, '') CUSTINFO " & _
                    " FROM CUSTOMER WITH(NOLOCK) LEFT OUTER JOIN PARAMGLOBAL " & _
                 " ON CUSTOMER.IDTYPE=PARAMGLOBAL.CODE AND PARAMGLOBAL.TYPE='IDTYPE'" & _
                " WHERE LOCCUSTID=" & strLocCustID & " AND CUSTID=" & strCustID)
            If oSDR.Read Then
                strCustInfo = oSDR("CUSTINFO").ToString
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception

        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return strCustInfo
    End Function


    <WebMethod()> _
    Public Function GetCompanyInfo(ByVal strCompID As String) As String
        Dim strCompInfo As String = ""
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT COMPNAME + '|' + ISNULL(COMPADDRESS, '')+ '|' + ISNULL(COMPCITY, '')+ '|' + ISNULL(COMPZIP, '')+ '|' + ISNULL(COMPPHONE, '') AS COMPINFO" & _
                " FROM COMPANY WITH(NOLOCK) " & _
                " WHERE COMPID=" & strCompID.ToString())
            If oSDR.Read Then
                strCompInfo = oSDR("COMPINFO").ToString
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception

        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return strCompInfo
    End Function

    <WebMethod()> _
    Public Function UserCheck(ByVal strUserID As String) As String
        Dim strLogin As String = "|"
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("Select APPSESSIONS.IP, " & _
             " CONVERT(VARCHAR(20), APPSESSIONS.TIMEOUT, 103) + ' ' + CONVERT(VARCHAR(20), APPSESSIONS.TIMEOUT, 108) TIMEOUT " & _
                    " FROM APPUSER, APPSESSIONS " & _
                " WHERE (APPUSER.UID = APPSESSIONS.UID) AND TIMEOUT>=GETDATE() AND APPUSER.USERID='" & strUserID & "'")
            If oSDR.Read Then
                strLogin = oSDR("IP").ToString + "|" & oSDR("TIMEOUT").ToString
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception

        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        UserCheck = strLogin
        Return strLogin
    End Function

    <WebMethod()> _
    Public Function UserTxnLockCheck(ByVal strLocationID As String, _
            ByVal strAppID As String) As String
        Dim strUserID As String = "|"
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT LASTUSERID, " & _
                    " (SELECT USERID FROM APPUSER WHERE APPUSER.UID=APPLICATION.LASTUSERID) LASTUSER" & _
                    " FROM APPLICATION WHERE LOCID=" & strLocationID & " AND APPID=" & strAppID & " AND ROWLOCK=1")
            If oSDR.Read Then
                strUserID = oSDR("LASTUSERID").ToString() & "|" & oSDR("LASTUSER").ToString()
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception

        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        UserTxnLockCheck = strUserID
        Return strUserID
    End Function

    <WebMethod()> _
    Public Function CalcEffectiveRate( _
            ByVal intTenor As Integer, ByVal dblInstallment As Double, _
            ByVal dblPrincipal As Double, ByVal dblResidualValue As Double, _
            ByVal intLoanType As Integer) As Double

        Dim dblGuessX, dblGuess As Double
        Dim dblERate As Double
        dblGuess = 0
        dblGuessX = 1
        On Error GoTo errorHandle
        Do While dblGuessX <= 20 Or dblERate <= 0
            dblERate = Rate(intTenor, dblInstallment, -1 * dblPrincipal, dblResidualValue, intLoanType, dblGuess) * 12.0 * 100.0
            If dblERate > 0 Then Exit Do
            dblGuess = dblGuess + 0.1
            dblGuessX = dblGuessX + 1
        Loop
        CalcEffectiveRate = dblERate
        Exit Function
errorHandle:
        dblGuess = dblGuess + 0.1
        dblGuessX = dblGuessX + 1
        If (dblGuessX > 20) Then
            Exit Function
        End If
        Resume
    End Function

    <WebMethod()> _
    Public Function PresentValue( _
            ByVal dblRate As Double, _
            ByVal intTenor As Integer, _
            ByVal dblInstallment As Double, _
            ByVal dblResidualValue As Double, _
            ByVal intLoanType As Integer) As Double
        '  Dim dblRate2 As Double
        '  dblRate2 = dblRate / 1200
        PresentValue = Math.Round(PV(dblRate, intTenor, -dblInstallment, dblResidualValue, intLoanType), 0)
    End Function

    '<WebMethod()> _
    'Public Function RoundUp(ByVal nValue As Double, ByVal nDigits As Integer) As Double
    '    RoundUp = Int(nValue * (10 ^ nDigits) + 0.9999999999) / (10 ^ nDigits)
    'End Function


    <WebMethod()> _
    Public Function CalcInstallment( _
        ByVal dblPrincipal As Double, _
        ByVal dblEffectiveRate As Double, _
        ByVal intJangkaWaktu As Integer, _
        ByVal intLoanType As Integer, _
        ByVal dblResidualValue As Double, _
        ByVal intRound As Integer) As Double

        'round ganti variant karena ismissing berfungsi jika optinal variant

        'Dim dblSukuBunga As Double ', dblRV As Double


        'dblSukuBunga = dblEffectiveRate / 100   ' convert percentage effective rate
        'Select Case intLoanType
        '    Case 0
        '        dblRV = dblResidualValue
        '    Case 1
        '        dblRV = dblResidualValue '* (1 + (dblSukuBunga / 12))
        '    Case Else
        '        CalcInstallment = 0
        '        Exit Function
        'End Select

        CalcInstallment = Math.Round(Pmt(dblEffectiveRate / 1200.0, intJangkaWaktu, -dblPrincipal, dblResidualValue, _
                intLoanType), intRound)
    End Function

    <WebMethod()> _
    Public Function CalcFlatRate( _
        ByVal dblPrincipal As Double, ByVal intTenor As Integer, _
        ByVal dblEffectiveRate As Double, _
        ByVal dblResidualValue As Double, _
        ByVal intLoanType As Integer, _
        ByVal intRound As Integer) As Double

        Dim dblInstallment As Double, dblTtlAR As Double, dblTtlInterest As Double
        Dim dblFlatRate As Double


        dblInstallment = CalcInstallment(dblPrincipal, dblEffectiveRate, intTenor, _
                dblResidualValue, intLoanType, intRound)
        dblTtlAR = (dblInstallment * intTenor) + dblResidualValue
        dblTtlInterest = dblTtlAR - dblPrincipal
        If dblPrincipal > 0 Then
            dblFlatRate = dblTtlInterest / (dblPrincipal * intTenor / 12.0)
        End If

        CalcFlatRate = dblFlatRate * 100.0      ' dijadikan percentage
    End Function

    <WebMethod()> _
    Public Function CalcEffRateFromFlatRate( _
        ByVal dblPrincipal As Double, ByVal intTenor As Integer, _
        ByVal dblFlatRate As Double, _
        ByVal dblResidualValue As Double, _
        ByVal intLoanType As Integer) As Double

        Dim dblTtlInterest As Double, dblTtlAR As Double, dblInstallment As Double
        Dim dblFRate As Double



        dblFRate = dblFlatRate / 100.0

        dblTtlInterest = dblFRate * (dblPrincipal * intTenor / 12.0)
        dblTtlAR = dblPrincipal + dblTtlInterest
        dblInstallment = (dblTtlAR - dblResidualValue) / CDbl(intTenor)
        CalcEffRateFromFlatRate = CalcEffectiveRate(intTenor, dblInstallment, dblPrincipal, dblResidualValue, intLoanType)
    End Function
    


    <WebMethod()> _
    Public Function GetMirrorStatus(ByVal strJFID As String) As String
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim blnJFMIRRORSTATUS As Boolean = False
        Dim intJFMIRRORSTATUS As Integer = 0
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT JFMIRRORSTATUS FROM JF WHERE JFID=" & strJFID)
            If oSDR.Read Then
                blnJFMIRRORSTATUS = oSDR("JFMIRRORSTATUS")
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception

        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        If blnJFMIRRORSTATUS Then
            GetMirrorStatus = 1
            intJFMIRRORSTATUS = 1
        Else
            GetMirrorStatus = 0
            intJFMIRRORSTATUS = 0
        End If
        Return intJFMIRRORSTATUS
    End Function

    <WebMethod()> _
    Public Function VerifyUserSPV(ByVal strUserID As String, strPassword As String) As Integer
        Dim oSDRLogin As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            VerifyUserSPV = 0
            strPassword = Replace(RC4Engine.rc4(strPassword), "'", "''")
            oSDRLogin = objDBX.CreateSDRFromSQLSelect("SELECT UID " & _
                " FROM APPUser  WITH(NOLOCK) WHERE (UserID = '" + strUserID + "') AND (Password = '" + strPassword + "') AND SUPERVISOR=1")
            If oSDRLogin.HasRows() Then
                VerifyUserSPV = 1
            End If
            oSDRLogin.Close()
            oSDRLogin = Nothing
        Catch ex As Exception
            VerifyUserSPV = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function

    <WebMethod()> _
    Public Function ObjectPurposeNeedRoute(ByVal strPurposeID As String) As Integer
        Dim oSDRPurpose As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            ObjectPurposeNeedRoute = 0
            If Len(Trim(strPurposeID)) > 0 Then
                oSDRPurpose = objDBX.CreateSDRFromSQLSelect("SELECT NEEDROUTE " & _
                    " FROM OBJECTPURPOSE WITH(NOLOCK) WHERE PURPOSEID=" & strPurposeID & " AND DELETESTS=0")
                If oSDRPurpose.Read() Then
                    If oSDRPurpose("NEEDROUTE") Then
                        ' ObjectPurposeNeedRoute = 1
                        ObjectPurposeNeedRoute = oSDRPurpose("NEEDROUTE")
                    End If
                End If
                oSDRPurpose.Close()
                oSDRPurpose = Nothing
            End If
        Catch ex As Exception
            ObjectPurposeNeedRoute = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function

    <WebMethod()> _
    Public Function IsSupervisor(ByVal strCollectID As String) As Integer
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            IsSupervisor = 0
            oSDR = objDBX.CreateSDRFromSQLSelect("SELECT SUPERVISOR FROM COLLECTORTITLE WHERE COLLECTORTITLEID=" & strCollectID)
            If oSDR.Read() Then
                If oSDR("SUPERVISOR") Then
                    IsSupervisor = 1
                End If
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            IsSupervisor = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function

    Public Function IsSupervisor2(ByVal strCollectID As String) As Integer
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            IsSupervisor2 = 0
            oSDR = objDBX.CreateSDRFromSQLSelect("SELECT SUPERVISOR FROM COLLECTORTITLE WHERE COLLECTORTITLEID=" & strCollectID)
            If oSDR.Read() Then
                If oSDR("SUPERVISOR") Then
                    IsSupervisor2 = 1
                End If
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            IsSupervisor2 = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function

    <WebMethod()> _
    Public Function RoundUp(ByVal nValue As Double, ByVal nDigits As Double) As Double
        'NILAI DEFAULT SAMA
        RoundUp = nValue
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            oSDR = objDBX.CreateSDRFromSQLSelect("SELECT [dbo].[f_RoundUp](" & nValue.ToString() & ", " & nDigits.ToString() & ") ROUNDUP")
            If oSDR.Read() Then
                RoundUp = oSDR("RoundUp")
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            RoundUp = nValue
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try

        'RoundUp = Int(nValue * 10 ^ nDigits + 0.999999999999) / (10 ^ nDigits)
    End Function


    <WebMethod()> _
    Public Function GetFNAdminFee(ByVal intProductId As String, ByVal intDealerID As String, _
            ByVal intTenor As String, ByVal dblPrincipal As String, ByVal intBranchID As String) As Double
        GetFNAdminFee = 0
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            oSDR = objDBX.CreateSDRFromSQLSelect("SELECT [dbo].[f_GetFNAdminFee] (" & intProductId & ", " & intDealerID & ", " & intTenor & ", " & dblPrincipal & ", " & intBranchID & ") ADMIN")
            If oSDR.Read() Then
                GetFNAdminFee = oSDR("ADMIN")
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            GetFNAdminFee = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function

    <WebMethod()> _
    Public Function GetFNFiduciaFee(ByVal intProductId As String, ByVal intDealerID As String, _
            ByVal intTenor As String, ByVal dblPrincipal As String, ByVal intBranchID As String) As Double
        'NILAI DEFAULT SAMA
        GetFNFiduciaFee = 0
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            oSDR = objDBX.CreateSDRFromSQLSelect("SELECT [dbo].[f_GetFNFiduciaFee] (" & intProductId & ", " & intDealerID & ", " & intTenor & ", " & dblPrincipal & ", " & intBranchID & ") FIDUCIA")
            If oSDR.Read() Then
                GetFNFiduciaFee = oSDR("FIDUCIA")
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            GetFNFiduciaFee = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function

    <WebMethod()> _
    Public Function GetFNMinimumDP(ByVal intProductId As String, ByVal intDealerID As String, _
            ByVal intBranchID As String, ByVal intPurposeCatId As String, ByVal intCategoryID As String, _
            ByVal intCarYear As String, ByVal intCondition As String) As Double
        GetFNMinimumDP = 0
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            oSDR = objDBX.CreateSDRFromSQLSelect("SELECT [dbo].[f_getFNMinimumDP] (" & intProductId & ", " & intDealerID & ", " & intBranchID & ", " & intPurposeCatId & ", " & intCategoryID & ", " & intCarYear & ", " & intCondition & ") MINDP")
            If oSDR.Read() Then
                GetFNMinimumDP = oSDR("MINDP")
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            GetFNMinimumDP = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function

    <WebMethod()> _
    Public Function GetFNObjectValue(ByVal intObjectTypeID As String, _
            ByVal intCarYear As String, ByVal intCondition As String) As Double
        GetFNObjectValue = 0
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            oSDR = objDBX.CreateSDRFromSQLSelect("SELECT [dbo].[f_getFNObjectValue] (" & intObjectTypeID & ", " & intCarYear & ", " & intCondition & ") OBJECTVALUE")
            If oSDR.Read() Then
                GetFNObjectValue = oSDR("OBJECTVALUE")
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            GetFNObjectValue = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function

    <WebMethod()> _
    Public Function GetFNMaximumFunding(ByVal intObjectTypeID As String, ByVal intCarYear As String, _
            ByVal intCondition As String, ByVal intWorkingDay As String, _
            ByVal intSetoran As String, ByVal intTenor As String, ByVal intFlatRate As String, _
            ByVal intPurposeCatId As String) As Double
        GetFNMaximumFunding = 0
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            oSDR = objDBX.CreateSDRFromSQLSelect("SELECT [dbo].[f_GetFNMaximumFunding] (" & intObjectTypeID & ", " & intCarYear & ", " & intCondition & ", " & intWorkingDay & ", " & intSetoran & ", " & intTenor & ", " & intFlatRate & "," & intPurposeCatId & ", DEFAULT) MAXFUNDING")
            If oSDR.Read() Then
                GetFNMaximumFunding = oSDR("MAXFUNDING")
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            GetFNMaximumFunding = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function

    <WebMethod()> _
    Public Function GetFNCheckDocFee(ByVal intProductID As String, _
            ByVal intAreaId As String, intBranchID As String) As Double
        GetFNCheckDocFee = 0
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            oSDR = objDBX.CreateSDRFromSQLSelect("SELECT [dbo].[f_getFNCHECKDOC] (" & intProductID & ", " & intAreaId & "," & intBranchID & ") CHECKDOC")
            If oSDR.Read() Then
                GetFNCheckDocFee = oSDR("CHECKDOC")
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            GetFNCheckDocFee = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function


    <WebMethod()> _
    Public Function getACCIDINTERESTTOTALFixPrincipalByACCID(ByVal intLOCID As String, _
            ByVal dblACCID As String) As Double

        getACCIDINTERESTTOTALFixPrincipalByACCID = 0
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            oSDR = objDBX.CreateSDRFromSQLSelect("SELECT [dbo].[f_getACCIDINTERESTTOTALFixPrincipalByACCID] (" & intLOCID & ", " & dblACCID & ") INTERESTFIXPRINCIPAL")
            If oSDR.Read() Then
                getACCIDINTERESTTOTALFixPrincipalByACCID = oSDR("INTERESTFIXPRINCIPAL")
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            getACCIDINTERESTTOTALFixPrincipalByACCID = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function
    <WebMethod()> _
    Public Function getINTERESTTOTALFixPrincipalSimulation(ByVal dblPrincipalTotal As String, _
            ByVal dblTenor As Integer, ByVal iloanType As Integer, ByVal dblEffRate As String) As Double

        getINTERESTTOTALFixPrincipalSimulation = 0
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            oSDR = objDBX.CreateSDRFromSQLSelect("SELECT [dbo].[f_getINTERESTTOTALFixPrincipalSimulation] (" & dblPrincipalTotal & ", " & dblTenor & ", " & iloanType & ", " & dblEffRate & "  ) INTERESTFIXPRINCIPAL")
            If oSDR.Read() Then
                getINTERESTTOTALFixPrincipalSimulation = oSDR("INTERESTFIXPRINCIPAL")
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            getINTERESTTOTALFixPrincipalSimulation = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function

    <WebMethod()> _
    Public Function GETACCUnposting(ByVal LOCID As String, ByVal ACCID As String, ByVal strBTID As String) As String
        Dim oSDRUnposting As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            GETACCUnposting = 0
            oSDRUnposting = objDBX.CreateSDRFromSQLSelect("SELECT CAST(CASE WHEN POSTINGSTS=1 THEN 1 ELSE 0 END AS VARCHAR(10)) + '|' + CAST(LOCIDUN AS VARCHAR(10)) + '|' " & _
                                                        " + CAST (UNKNOWNID AS VARCHAR(10)) + '|' + CAST(AMOUNTALLOCATE AS VARCHAR(20)) + '|' + CAST (ALLOCATEID AS VARCHAR(10)) AS PAYUNKNOWN  " & _
                                                        " FROM PAYUNKNOWNALLOCATE WHERE LOCID=" & LOCID & "AND ACCID = " & ACCID & " AND POSTINGSTS=0 AND BTID=" & strBTID)
            If oSDRUnposting.Read() Then
                GETACCUnposting = oSDRUnposting("PAYUNKNOWN")
            End If
            oSDRUnposting.Close()
            oSDRUnposting = Nothing
        Catch ex As Exception
            GETACCUnposting = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function

    <WebMethod()> _
    Public Function GETZIPDescription(ByVal ZIPCODE As String, ByVal sNo As String) As String
        Dim oSDRZIP As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            GETZIPDescription = 0
            oSDRZIP = objDBX.CreateSDRFromSQLSelect("SET CONCAT_NULL_YIELDS_NULL  OFF;SELECT TOP 1 ZIP.ZIPID, ZIP.ZIPCODE, ZIP.CITY + '|' + ZIP.PROVINCE + '|' + ZIP.KECAMATAN + '|' + ZIP.KELURAHAN + '|' + CAST(ZIP.CITYID AS VARCHAR(10)) + '|' + '(' + CITY.CITYCODE + ') ' + CITY.CITYNAME +'|' + '" & sNo & "' + '|1' AS ZIPDESC, " & _
                                                        " ZIP.CITYID, '(' + CITY.CITYCODE + ') ' + CITY.CITYNAME AS CITYNAME " & _
                                                        " FROM ZIP WITH(NOLOCK) INNER JOIN CITY WITH(NOLOCK) ON ZIP.CITYID = CITY.CITYID WHERE (CITY.DELETESTS = 0) AND ZIP.ZIPCODE=" & ZIPCODE)
            If oSDRZIP.Read() Then
                GETZIPDescription = oSDRZIP("ZIPDESC")
                'GETZIPDescription = sNo
            Else
                Dim oSDRZIPTemp As System.Data.SqlClient.SqlDataReader

                oSDRZIPTemp = objDBX.CreateSDRFromSQLSelect("SET CONCAT_NULL_YIELDS_NULL  OFF;SELECT TOP 1 0 ZIPID, '' ZIPCODE, '|' +  '|'  + '|' + '|' + '|' + '|' + '" & sNo & "' + '|0' AS ZIPDESC, " & _
                                                            " 0 CITYID, '' AS CITYNAME ")
                If oSDRZIPTemp.Read() Then
                    GETZIPDescription = oSDRZIPTemp("ZIPDESC")
                End If
                oSDRZIPTemp.Close()
                oSDRZIPTemp = Nothing
            End If
            oSDRZIP.Close()
            oSDRZIP = Nothing


        Catch ex As Exception
            GETZIPDescription = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function

    <WebMethod()> _
    Public Function GETCheckInvoice(ByVal INVOICENO As String, ByVal UID As String) As String
        Dim oSDRCheckInv As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            GETCheckInvoice = 0
            oSDRCheckInv = objDBX.CreateSDRFromSQLSelect("SELECT CAST(INVPAPERID AS VARCHAR(10))+ '|' + CAST(INVOICECHECK AS VARCHAR(10)) + '|' + REMARK AS INVOICE " & _
                                                        " from dbo.f_CheckInvoicePaper('" & INVOICENO & "' , " & UID & ") ")
            If oSDRCheckInv.Read() Then
                GETCheckInvoice = oSDRCheckInv("INVOICE")
            Else
                Dim oSDRCheckInvTemp As System.Data.SqlClient.SqlDataReader
                oSDRCheckInvTemp = objDBX.CreateSDRFromSQLSelect("SELECT '|' + '|' AS INVOICE ")
                If oSDRCheckInvTemp.Read() Then
                    GETCheckInvoice = oSDRCheckInvTemp("INVOICE")
                End If
                oSDRCheckInvTemp.Close()
                oSDRCheckInvTemp = Nothing
            End If
            oSDRCheckInv.Close()
            oSDRCheckInv = Nothing
        Catch ex As Exception
            GETCheckInvoice = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function

    <WebMethod()> _
    Public Function GetRefundPersonByCategory( _
            ByVal dblPersonID As String, _
            ByVal intRefundCategory As String, _
            ByVal intProductID As String) As Double

        GetRefundPersonByCategory = 0
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            oSDR = objDBX.CreateSDRFromSQLSelect("SELECT [dbo].[f_getRefundPersonByCategory] (" & dblPersonID & "," & intRefundCategory & "," & intProductID & ") REFUNDPERSON")
            If oSDR.Read() Then
                GetRefundPersonByCategory = oSDR("REFUNDPERSON")
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            GetRefundPersonByCategory = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function


    <WebMethod()> _
    Public Function GetRefundPersonTypeByCategory( _
            ByVal dblPersonID As String, _
            ByVal intRefundCategory As String, _
            ByVal intProductID As String) As Double

        GetRefundPersonTypeByCategory = 0
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            oSDR = objDBX.CreateSDRFromSQLSelect("SELECT [dbo].[f_getRefundPersonTypeByCategory] (" & dblPersonID & "," & intRefundCategory & "," & intProductID & ") REFUNDTYPE")
            If oSDR.Read() Then
                GetRefundPersonTypeByCategory = oSDR("REFUNDTYPE")
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            GetRefundPersonTypeByCategory = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function


    <WebMethod()> _
    Public Function GetINSPricingID( _
            ByVal strBranchID As String, _
            ByVal strProductID As String, _
            ByVal strCategoryID As String, _
            ByVal strPurposeID As String, _
            ByVal strInsuranceType As String,
            ByVal strInsuredValue As String) As Double

        GetINSPricingID = 0
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            oSDR = objDBX.CreateSDRFromExecSQL("SELECT dbo.f_getINSPricingID(" & strBranchID & "," & strProductID & ", " & strCategoryID & ", " & strPurposeID & ", " & strInsuranceType & "," & strInsuredValue & ") AS PRICINGID")
            If oSDR.Read() Then
                GetINSPricingID = oSDR("PRICINGID")
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            GetINSPricingID = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function

    <WebMethod()> _
    Public Function GetINSBaseRate( _
            ByVal strBranchID As String, _
            ByVal strProductID As String, _
            ByVal strCategoryID As String, _
            ByVal strPurposeID As String, _
            ByVal strInsuranceType As String, _
            ByVal strYear As String, _
            ByVal strInsurancedValue As String) As Double

        Dim strPricingID As String
        GetINSBaseRate = 0
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            oSDR = objDBX.CreateSDRFromExecSQL("SELECT dbo.f_getINSPricingID(" & strBranchID & "," & strProductID & ", " & strCategoryID & ", " & strPurposeID & ", " & strInsuranceType & "," & strInsurancedValue & ") AS PRICINGID")
            If oSDR.Read() Then
                strPricingID = oSDR("PRICINGID")
                Dim oSDRDtl As System.Data.SqlClient.SqlDataReader
                oSDRDtl = objDBX.CreateSDRFromSQLSelect("SELECT BASERATE FROM INSPRICINGDTL WITH(NOLOCK) WHERE INSPRICINGID=" & strPricingID & "  AND INSYEAR=" & strYear & " AND DELETESTS=0")
                If oSDRDtl.Read() Then
                    GetINSBaseRate = oSDRDtl("BASERATE")
                End If
                oSDRDtl.Close()
                oSDRDtl = Nothing
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            GetINSBaseRate = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function


    <WebMethod()> _
    Public Function GetINSBaseRateRSCC( _
            ByVal strBranchID As String, _
            ByVal strProductID As String, _
            ByVal strCategoryID As String, _
            ByVal strPurposeID As String, _
            ByVal strInsuranceType As String, _
            ByVal strYear As String, _
            ByVal strInsurancedValue As String) As Double

        Dim strPricingID As String
        GetINSBaseRateRSCC = 0
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            oSDR = objDBX.CreateSDRFromExecSQL("SELECT dbo.f_getINSPricingID(" & strBranchID & "," & strProductID & ", " & strCategoryID & ", " & strPurposeID & ", " & strInsuranceType & "," & strInsurancedValue & ") AS PRICINGID")
            If oSDR.Read() Then
                strPricingID = oSDR("PRICINGID")
                Dim oSDRDtl As System.Data.SqlClient.SqlDataReader
                oSDRDtl = objDBX.CreateSDRFromSQLSelect("SELECT BASERATERSCC FROM INSPRICINGDTL WITH(NOLOCK) WHERE INSPRICINGID=" & strPricingID & "  AND INSYEAR=" & strYear & " AND DELETESTS=0")
                If oSDRDtl.Read() Then
                    GetINSBaseRateRSCC = oSDRDtl("BASERATERSCC")
                End If
                oSDRDtl.Close()
                oSDRDtl = Nothing
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            GetINSBaseRateRSCC = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function

    <WebMethod()> _
    Public Function GetINSBaseRateRSMB( _
        ByVal strBranchID As String, _
        ByVal strProductID As String, _
        ByVal strCategoryID As String, _
        ByVal strPurposeID As String, _
        ByVal strInsuranceType As String, _
        ByVal strYear As String, _
        ByVal strInsurancedValue As String) As Double

        Dim strPricingID As String
        GetINSBaseRateRSMB = 0
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            oSDR = objDBX.CreateSDRFromExecSQL("SELECT dbo.f_getINSPricingID(" & strBranchID & "," & strProductID & ", " & strCategoryID & ", " & strPurposeID & ", " & strInsuranceType & "," & strInsurancedValue & ") AS PRICINGID")
            If oSDR.Read() Then
                strPricingID = oSDR("PRICINGID")
                Dim oSDRDtl As System.Data.SqlClient.SqlDataReader
                oSDRDtl = objDBX.CreateSDRFromSQLSelect("SELECT BASERATERSMB FROM INSPRICINGDTL WITH(NOLOCK) WHERE INSPRICINGID=" & strPricingID & "  AND INSYEAR=" & strYear & " AND DELETESTS=0")
                If oSDRDtl.Read() Then
                    GetINSBaseRateRSMB = oSDRDtl("BASERATERSMB")
                End If
                oSDRDtl.Close()
                oSDRDtl = Nothing
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            GetINSBaseRateRSMB = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function

    <WebMethod()> _
    Public Function GetINSBaseRateOTHER( _
        ByVal strBranchID As String, _
        ByVal strProductID As String, _
        ByVal strCategoryID As String, _
        ByVal strPurposeID As String, _
        ByVal strInsuranceType As String, _
        ByVal strYear As String, _
        ByVal strInsurancedValue As String) As Double

        Dim strPricingID As String
        GetINSBaseRateOTHER = 0
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            oSDR = objDBX.CreateSDRFromExecSQL("SELECT dbo.f_getINSPricingID(" & strBranchID & "," & strProductID & ", " & strCategoryID & ", " & strPurposeID & ", " & strInsuranceType & "," & strInsurancedValue & ") AS PRICINGID")
            If oSDR.Read() Then
                strPricingID = oSDR("PRICINGID")
                Dim oSDRDtl As System.Data.SqlClient.SqlDataReader
                oSDRDtl = objDBX.CreateSDRFromSQLSelect("SELECT BASERATEOTHER FROM INSPRICINGDTL WITH(NOLOCK) WHERE INSPRICINGID=" & strPricingID & "  AND INSYEAR=" & strYear & " AND DELETESTS=0")
                If oSDRDtl.Read() Then
                    GetINSBaseRateOTHER = oSDRDtl("BASERATEOTHER")
                End If
                oSDRDtl.Close()
                oSDRDtl = Nothing
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            GetINSBaseRateOTHER = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function

    <WebMethod()> _
    Public Function GetINSTJHCust( _
            ByVal strTJHID As String) As Double

        GetINSTJHCust = 0
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            oSDR = objDBX.CreateSDRFromExecSQL("SELECT dbo.f_getINSPricingTJHCust(" & strTJHID & ") AS TJH")
            If oSDR.Read() Then
                GetINSTJHCust = oSDR("TJH")
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            GetINSTJHCust = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function

    <WebMethod()> _
    Public Function GetINSTJHComp( _
            ByVal strTJHID As String) As Double

        GetINSTJHComp = 0
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            oSDR = objDBX.CreateSDRFromExecSQL("SELECT dbo.f_getINSPricingTJHComp(" & strTJHID & ") AS TJH")
            If oSDR.Read() Then
                GetINSTJHComp = oSDR("TJH")
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            GetINSTJHComp = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function

    <WebMethod()> _
    Public Function GetINSCalcRateCust( _
            ByVal strProductID As String, _
            ByVal strDealerID As String, _
            ByVal strRate As String) As Double

        GetINSCalcRateCust = 0
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            oSDR = objDBX.CreateSDRFromExecSQL("SELECT dbo.f_INSCalcRateCust(" & strProductID & ", " & strDealerID & ", " & strRate & ") AS RATECUST")
            If oSDR.Read() Then
                GetINSCalcRateCust = oSDR("RATECUST")
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            GetINSCalcRateCust = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function

    <WebMethod()> _
    Public Function GetFNFINSTRUCTUREDealerRate(ByVal intProductId As String, ByVal intDealerID As String, _
            ByVal intPurposeCatID As String, intCategoryID As String, intCarYear As String, intCondition As String, _
            ByVal intTenor As String, ByVal dblPrincipal As String, intTrayekID As String, ByVal intBranchID As String) As Double
        GetFNFINSTRUCTUREDealerRate = 0
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            oSDR = objDBX.CreateSDRFromSQLSelect("SELECT [dbo].[f_GetFNFINSTRUCTUREDealerRate] (" & intProductId & ", " & intDealerID & _
                    ", " & intPurposeCatID & ", " & intCategoryID & ", " & intCarYear & _
                    ", " & intCondition & ", " & intTenor & ", " & dblPrincipal & ", " & intTrayekID & "," & intBranchID & ") DEALERRATE")
            If oSDR.Read() Then
                GetFNFINSTRUCTUREDealerRate = oSDR("DEALERRATE")
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            GetFNFINSTRUCTUREDealerRate = 0
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function

    <WebMethod()> _
    Public Function GetBookCodeInfo(ByVal strBCID As String) As String
        Dim strBOOKINFO As String = ""
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT CAST(JOURNALTYPE AS VARCHAR(20)) + '|' +  CAST(TXNTYPE AS VARCHAR(20)) + '|' +  dbo.f_getParamGlobalName('JOURNALTYPE', JOURNALTYPE) + '|' + dbo.f_getParamGlobalName('JOURNALTXNTYPE', TXNTYPE) AS BOOKINFO" & _
                " FROM BOOKCODE WITH(NOLOCK) " & _
                " WHERE BCID=" & strBCID.ToString())
            If oSDR.Read Then
                strBOOKINFO = oSDR("BOOKINFO").ToString
            End If
            oSDR.Close()
            oSDR = Nothing
            'Catch ex As Exception

        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return strBOOKINFO
    End Function

    <WebMethod()> _
    Public Function HelloWorld(ByVal args As String) As String
        Return "Hello : " + args
    End Function
    <WebMethod()> _
    Public Function GetTermPrincipalInfo(ByVal strFINCATID As String) As String
        Dim strPRINCIPAL As String = ""
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getTermPrincipal(" & strFINCATID & ") AS NAME")
            If oSDR.Read Then
                strPRINCIPAL = oSDR("NAME").ToString
            End If
            oSDR.Close()
            oSDR = Nothing
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return strPRINCIPAL
    End Function
    <WebMethod()> _
    Public Function GetTermInterestInfo(ByVal strFINCATID As String) As String
        Dim strINTEREST As String = ""
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getTermInterest(" & strFINCATID & ") AS NAME")
            If oSDR.Read Then
                strINTEREST = oSDR("NAME").ToString
            End If
            oSDR.Close()
            oSDR = Nothing
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return strINTEREST
    End Function
    <WebMethod()> _
    Public Function GetTermARInfo(ByVal strFINCATID As String) As String
        Dim strAR As String = ""
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getTermAR(" & strFINCATID & ") AS NAME")
            If oSDR.Read Then
                strAR = oSDR("NAME").ToString
            End If
            oSDR.Close()
            oSDR = Nothing
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return strAR
    End Function

    <WebMethod()> _
    Public Function GetTermEffectiveRateInfo(ByVal strFINCATID As String) As String
        Dim strEffectiveRate As String = ""
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getTermEffective(" & strFINCATID & ") AS NAME")
            If oSDR.Read Then
                strEffectiveRate = oSDR("NAME").ToString
            End If
            oSDR.Close()
            oSDR = Nothing
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return strEffectiveRate
    End Function

    <WebMethod()> _
    Public Function GetCC(ByVal ModelID As String, ByVal ObjectTypeID As String) As String
        Dim strCCInfo As String = ""
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT CC" & _
                " FROM OBJECTTYPE WITH(NOLOCK) " & _
                " WHERE MODELID=" & ModelID.ToString() & " AND OBJECTTYPEID=" & ObjectTypeID.ToString())
            If oSDR.Read() Then
                strCCInfo = oSDR("CC").ToString
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception

        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return strCCInfo
    End Function

    <WebMethod()> _
    Public Function SendSMSCodeToUser(ByVal strUID As String) As Integer
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim oRC4 As New RC4.RC4Program
        Dim objQueue As New MSMQClass

        Try
            Dim intRandom As Integer
            intRandom = GetRandomNumber(1, 999999)


            objDB.ExecSPNoTxn("APPUSERDTLAppCode",
                objDB.MP("@UID", Data.SqlDbType.BigInt, strUID),
                objDB.MP("@APPCODE", Data.SqlDbType.VarChar, oRC4.Encrypt(intRandom.ToString()))
                )

            Dim QUEUE_NAME As String = ".\private$\sms"
            Dim msqQ As System.Messaging.MessageQueue
            Dim msgText As String = ""

            oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPUSER.MOBILENO, APPUSERDTL.APPCODE, dbo.f_getAppSetting('SMSPORT') SMSPORT FROM APPUSER WITH(NOLOCK) INNER JOIN APPUSERDTL WITH(NOLOCK) ON  APPUSER.UID=APPUSERDTL.UID WHERE APPUSER.UID=" & strUID & " AND APPUSER.MOBILENO IS NOT NULL")
            If oSDR.Read() Then
                msqQ = objQueue.GetQ(QUEUE_NAME, False)
                ' Send the message to the queue
                Dim strMessage As String = "", strMessageSend As String = ""
                strMessage = "Your Verification Code : " & oRC4.Encrypt(oSDR("APPCODE"))
                msgText = oSDR("SMSPORT") & "|" & oSDR("MOBILENO") & "|" & strMessage
                msqQ.Send(msgText, oSDR("MOBILENO"))
            End If

            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Return 0
        Finally
            objQueue = Nothing
            oRC4 = Nothing
            objDB.Close()
            objDB = Nothing
        End Try
        Return 1
    End Function

    <WebMethod()> _
    Public Function SendMailCodeToUser(ByVal strUID As String) As Integer
        Dim objMail As New EMAIL
        Dim objDB As New DBX
        Dim oRC4 As New RC4.RC4Program
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            Dim intRandom As Integer
            intRandom = GetRandomNumber(1, 999999)


            objDB.ExecSPNoTxn("APPUSERDTLAppCode",
                objDB.MP("@UID", Data.SqlDbType.BigInt, strUID),
                objDB.MP("@APPCODE", Data.SqlDbType.VarChar, oRC4.Encrypt(intRandom.ToString()))
                )
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPUSER.EMAIL, APPUSERDTL.APPCODE, dbo.f_getAppSetting('SMSPORT') SMSPORT FROM APPUSER WITH(NOLOCK) INNER JOIN APPUSERDTL WITH(NOLOCK) ON  APPUSER.UID=APPUSERDTL.UID WHERE APPUSER.UID=" & strUID & " AND APPUSER.EMAIL IS NOT NULL")
            If oSDR.Read() Then
                objMail.SendMailFromSetting("EMAILCOMP", oSDR("EMAIL"), "Verification Code", "Your Verification Code is " & oRC4.Encrypt(oSDR("APPCODE")) & ". Please input immediately before it expired.", "", False)
            End If

        Catch ex As Exception
            Return 0
        Finally
            objDB.Close()
            objDB = Nothing
            objMail = Nothing
            oRC4 = Nothing
        End Try
        Return 1
    End Function


    Private Function GetRandomNumber( _
          Optional ByVal Low As Integer = 1, _
          Optional ByVal High As Integer = 999999) As Integer
        ' Returns a random number,
        ' between the optional Low and High parameters
        Dim objRandom As New System.Random( _
      CType(System.DateTime.Now.Ticks Mod System.Int32.MaxValue, Integer))
        Return objRandom.Next(Low, High + 1)
    End Function


    <WebMethod()> _
    Public Function VerifyCodeUID(ByVal strUID As String, ByVal strCode As String) As String
        Dim objDB As New DBX
        Dim oRC4 As New RC4.RC4Program
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        VerifyCodeUID = 0 'default
        Dim iValid As Integer = 0 'DEFAULT NOT VALID
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPUSERDTL.APPCODE, CASE WHEN APPEXPIRED<=GETDATE() THEN 1 ELSE 0 END HASEXPIRED FROM APPUSERDTL WITH(NOLOCK) WHERE APPUSERDTL.UID=" & strUID)
            If oSDR.HasRows() Then
                If oSDR.Read() Then
                    If oRC4.Encrypt(oSDR("APPCODE")) <> strCode Then
                        iValid = 0 'INVALID VERIFICATION CODE
                    Else
                        If oSDR("HASEXPIRED") = 1 Then
                            iValid = 2 'HAS EXPIRED
                        Else
                            If oRC4.Encrypt(oSDR("APPCODE")) = strCode Then
                                iValid = 1 'VALID
                            End If
                        End If
                    End If

                End If
            Else
                iValid = 0 'INVALID VERIFICATION CODE
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            iValid = 3 'ERROR
        Finally
            objDB.Close()
            objDB = Nothing
            oRC4 = Nothing
        End Try
        Return iValid
    End Function

End Class

