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
Public Class DestarWebserviceOrderDeantar
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
    '<WebMethod()>
    'Public Function OrderDebarang(ByVal strCustomerID As Integer,
    '        ByVal strArmadaId As Integer, ByVal strPickUpLoc As String, ByVal strDestinationLocLat As String, ByVal strDestinationLocLong As String,
    '        ByVal strPrice As String, ByVal strDistance As String,
    '        ByVal strDuration As String, ByVal strOrderDate As DateTime, ByVal strOrdertime As DateTime,
    '        ByVal strNotes As String) As String
    '    Dim objDB As New DBX
    '    Dim intRetval As Integer
    '    Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
    '    'Dim imgByte As Byte()
    '    'imgByte = Convert.FromBase64String(strImage)
    '    Try
    '        oSQLParam = objDB.ExecSPReturnParam("ORDERDEBARANGADD",
    '                                                    objDB.MP("@CUSTOMERID", Data.SqlDbType.Int, strCustomerID),
    '                                                    objDB.MP("@ARMADAID", Data.SqlDbType.Int, strArmadaId),
    '                                                    objDB.MP("@PICKUPLOC", Data.SqlDbType.VarChar, strPickUpLoc),
    '                                                    objDB.MP("@DESTINATIONLOCLONG", Data.SqlDbType.VarChar, strDestinationLocLat),
    '                                                    objDB.MP("@DESTINATIONLOCLAT", Data.SqlDbType.VarChar, strDestinationLocLong),
    '                                                    objDB.MP("@PRICE", Data.SqlDbType.VarChar, strPrice),
    '                                                    objDB.MP("@DISTANCE", Data.SqlDbType.VarChar, strDistance),
    '                                                    objDB.MP("@DURATION", Data.SqlDbType.VarChar, strDuration),
    '                                                    objDB.MP("@ORDERDATE", Data.SqlDbType.Date, strOrderDate),
    '                                                    objDB.MP("@NOTES", Data.SqlDbType.VarChar, strNotes),
    '                                                    objDB.MP("@ORDERTIME", Data.SqlDbType.Time, strOrdertime),
    '                                                    objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetval, 10, Data.ParameterDirection.Output))
    '        intRetval = oSQLParam("@RETVAL").Value.ToString()
    '    Catch ex As Exception
    '    Finally
    '        objDB.Close()
    '        objDB = Nothing
    '    End Try
    '    If intRetval = -1 Then
    '        Return HttpStatusCode.OK
    '    Else
    '        Return HttpStatusCode.BadRequest
    '    End If
    'End Function
    <WebMethod()>
    Public Function UpdateStatusOrderDebarangProcess(ByVal strMitraID As Integer, ByVal strOrderid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDEBARANGUPDATE_PROCESS",
                                                        objDB.MP("@ORDERID", Data.SqlDbType.Int, strOrderid),
                                                        objDB.MP("@MITRAID", Data.SqlDbType.Int, strMitraID),
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
    Public Function UpdateStatusOrderDebarangFinish(ByVal strMitraID As Integer, ByVal strOrderid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDEBARANGUPDATE_FINISH",
                                                        objDB.MP("@ORDERID", Data.SqlDbType.Int, strOrderid),
                                                        objDB.MP("@MITRAID", Data.SqlDbType.Int, strMitraID),
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
    Public Function UpdateStatusOrderDebarangReject(ByVal strMitraID As Integer, ByVal strOrderid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDEBARANGUPDATE_REJECT",
                                                        objDB.MP("@ORDERID", Data.SqlDbType.Int, strOrderid),
                                                        objDB.MP("@MITRAID", Data.SqlDbType.Int, strMitraID),
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
    Public Function UpdateStatusOrderDebarangRejectCust(ByVal strOrderid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDEBARANGUPDATECUST_REJECT",
                                                        objDB.MP("@ORDERID", Data.SqlDbType.Int, strOrderid),
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
    Public Function UpdateStatusOrderDebarangPickup(ByVal strMitraID As Integer, ByVal strOrderid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDEBARANGUPDATE_PICKUP",
                                                        objDB.MP("@ORDERID", Data.SqlDbType.Int, strOrderid),
                                                        objDB.MP("@MITRAID", Data.SqlDbType.Int, strMitraID),
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
    Public Function UpdateStatusOrderDeOjekProcess(ByVal strMitraID As Integer, ByVal strOrderid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDEJEKUPDATE_PROCESS",
                                                        objDB.MP("@ORDERID", Data.SqlDbType.Int, strOrderid),
                                                        objDB.MP("@MITRAID", Data.SqlDbType.Int, strMitraID),
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
    Public Function UpdateStatusOrderDeOjekFinish(ByVal strMitraID As Integer, ByVal strOrderid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDEJEKUPDATE_FINISH",
                                                        objDB.MP("@ORDERID", Data.SqlDbType.Int, strOrderid),
                                                        objDB.MP("@MITRAID", Data.SqlDbType.Int, strMitraID),
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
    Public Function UpdateStatusOrderDeOjekReject(ByVal strMitraID As Integer, ByVal strOrderid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDEJEKUPDATE_REJECT",
                                                        objDB.MP("@ORDERID", Data.SqlDbType.Int, strOrderid),
                                                        objDB.MP("@MITRAID", Data.SqlDbType.Int, strMitraID),
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
    Public Function UpdateStatusOrderDeJekRejectCust(ByVal strOrderid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDEJEKUPDATECUST_REJECT",
                                                        objDB.MP("@ORDERID", Data.SqlDbType.Int, strOrderid),
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
    Public Function UpdateStatusOrderDeJekPickup(ByVal strMitraID As Integer, ByVal strOrderid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDEJEKGUPDATE_PUCKUP",
                                                        objDB.MP("@ORDERID", Data.SqlDbType.Int, strOrderid),
                                                        objDB.MP("@MITRAID", Data.SqlDbType.Int, strMitraID),
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
    Public Function UpdateOrderStatusDeCarProcess(ByVal strMitraID As Integer, ByVal strOrderid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDECARUPDATE_PROCESS",
                                                        objDB.MP("@ORDERID", Data.SqlDbType.Int, strOrderid),
                                                        objDB.MP("@MITRAID", Data.SqlDbType.Int, strMitraID),
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
    Public Function UpdateOrderStatusDeCarFinish(ByVal strMitraID As Integer, ByVal strOrderid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDECARUPDATE_FINISH",
                                                        objDB.MP("@ORDERID", Data.SqlDbType.Int, strOrderid),
                                                        objDB.MP("@MITRAID", Data.SqlDbType.Int, strMitraID),
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
    Public Function UpdateOrderStatusDeCarReject(ByVal strMitraID As Integer, ByVal strOrderid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDECARUPDATE_REJECT",
                                                        objDB.MP("@ORDERID", Data.SqlDbType.Int, strOrderid),
                                                        objDB.MP("@MITRAID", Data.SqlDbType.Int, strMitraID),
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
    Public Function UpdateStatusOrderDeCarRejectCust(ByVal strOrderid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDECARUPDATECUST_REJECT",
                                                        objDB.MP("@ORDERID", Data.SqlDbType.Int, strOrderid),
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
    Public Function UpdateStatusOrderDeCarPickup(ByVal strMitraID As Integer, ByVal strOrderid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDECARUPDATE_PUCKUP",
                                                        objDB.MP("@ORDERID", Data.SqlDbType.Int, strOrderid),
                                                        objDB.MP("@MITRAID", Data.SqlDbType.Int, strMitraID),
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
    Public Function GetOrderDebarang() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT ODB.ORDERID,ODB.ORDERCODE,ODB.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODB.MITRAID,AUP.FULLNAME,AUP.IMAGEURL,AUP.MOBILENO " & _
                             " ,ODB.ARMADAID,MA.ARMADANAME,ODB.PICKUPLOC,ODB.PICKUPLOCLAT,ODB.PICKUPLOCLONG" & _
                            " ,ODB.DESTINATIONLOC,ODB.DESTINATIONLOCLAT,ODB.DESTINATIONLOCLONG,ODB.PRICE,ODB.DISTANCE " & _
                             " ,ODB.DURATION,CONVERT(VARCHAR,CONVERT(date,ODB.ORDERDATE,103),103)ORDERDATE,ODB.NOTES,ODB.STATUS,PG.NAME,ODB.ORDERTIME,STD.IMAGEURL " & _
                      " FROM ORDERDEBARANG ODB " & _
                        " LEFT OUTER JOIN APPUSERCLIENT AUC ON ODB.CUSTOMERID = AUC.UID " & _
                        " LEFT OUTER JOIN APPUSERPARTNER AUP ON ODB.MITRAID = AUP.USERID " & _
                        " LEFT OUTER JOIN MASTERARMADA MA ON ODB.ARMADAID = MA.ARMADAID " & _
                        " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID" & _
                        " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID" & _
                        " LEFT OUTER JOIN PARAMGLOBAL PG ON ODB.STATUS = PG.CODE " & _
                     " WHERE PG.TYPE = 'ORDERSTATUS' AND PG.CODE=0"
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
    Public Function GetOrderDebarangDetail(ByVal strOrderid As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT ODB.ORDERID,ODB.ORDERCODE,ODB.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODB.MITRAID,AUP.FULLNAME,AUP.NUMBERPLATE " & _
                             " ,ODB.ARMADAID,MA.ARMADANAME,ODB.PICKUPLOC,ODB.PICKUPLOCLAT,ODB.PICKUPLOCLONG" & _
                            " ,ODB.DESTINATIONLOC,ODB.DESTINATIONLOCLAT,ODB.DESTINATIONLOCLONG,ODB.PRICE,ODB.DISTANCE " & _
                             " ,ODB.DURATION,CONVERT(VARCHAR,CONVERT(date,ODB.ORDERDATE,103),103)ORDERDATE " & _
                            " ,ODB.NOTES,ODB.STATUS,PG.NAME,ODB.ORDERTIME,STD.IMAGEURL,AUP.IMAGEURL,AUP.MOBILENO,ODB.WEIGHT AS [BERATBARANG],ODB.TYPE [JENISBARANG] " & _
                      " FROM ORDERDEBARANG ODB " & _
                        " LEFT OUTER JOIN APPUSERCLIENT AUC ON ODB.CUSTOMERID = AUC.UID " & _
                        " LEFT OUTER JOIN APPUSERPARTNER AUP ON ODB.MITRAID = AUP.USERID " & _
                        " LEFT OUTER JOIN MASTERARMADA MA ON ODB.ARMADAID = MA.ARMADAID " & _
                        " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID" & _
                        " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID" & _
                        " LEFT OUTER JOIN PARAMGLOBAL PG ON ODB.STATUS = PG.CODE " & _
                     " WHERE ORDERID='" & strOrderid & "' AND PG.TYPE = 'ORDERSTATUS'"
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
    Public Function GetPesananDeantarBarang(ByVal strUid As Integer) As String
        'Public Function GetPesananDeantarBarang(ByVal strUid As Integer) As String
        'Public Function GetArmadaTypeDeantarBarang(ByVal strServiceTypeDtlId As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT OB.ORDERID ,OB.ORDERCODE,OB.CUSTOMERID,AUC.USERNAME, OB.MITRAID,AUP.USERNAME AS MITRANAME,AUP.IMAGEURL,AUP.MOBILENO,AUP.NUMBERPLATE, OB.ARMADAID, MA.ARMADANAME, " & _
                " OB.PICKUPLOC,OB.PICKUPLOCLAT, OB.PICKUPLOCLONG, OB.DESTINATIONLOC,OB.DESTINATIONLOCLAT, OB.DESTINATIONLOCLONG, MA.SERVICETYPEID, ST.SERVICETYPENAME, MA.SERVICETYPEDTLID, STD.SERVICETYPEDTLNAME,STD.IMAGEURL" & _
                 "  ,OB.PRICE,OB.DISTANCE,OB.DURATION,CONVERT(VARCHAR,CONVERT(date,OB.ORDERDATE,103),103)ORDERDATE,OB.NOTES,OB.STATUS,PG.NAME,OB.ORDERTIME " & _
                  " FROM ORDERDEBARANG OB" & _
                  " LEFT OUTER JOIN APPUSERCLIENT AUC ON OB.CUSTOMERID = AUC.UID" & _
                  " LEFT OUTER JOIN APPUSERPARTNER AUP ON OB.MITRAID = AUP.USERID" & _
                  " LEFT OUTER JOIN MASTERARMADA MA ON OB.ARMADAID = MA.ARMADAID" & _
                  " LEFT OUTER JOIN PARAMGLOBAL PG ON OB.STATUS = PG.CODE" & _
                  " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID" & _
                  " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID" & _
                  " WHERE CUSTOMERID = " & strUid & " AND PG.TYPE = 'ORDERSTATUS' AND (PG.CODE = 2 OR PG.CODE=8) AND OB.MITRAID IS NOT NULL "
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
    Public Function GetOrderPesananMaxDebarang(ByVal strCustId As Integer, ByVal strArmadaId As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT MAX(ORDERID) AS ORDERID FROM ORDERDEBARANG  " & _
                 "WHERE STATUS=8 AND CUSTOMERID = '" & strCustId & "'  AND ARMADAID= '" & strArmadaId & "' AND MITRAID IS NOT NULL"
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
    Public Function GetHistoryPesananDeBarangCust(ByVal strUid As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT TOP (3) OB.ORDERID ,OB.ORDERCODE,OB.CUSTOMERID,AUC.USERNAME, OB.MITRAID,AUP.USERNAME AS MITRANAME,AUP.IMAGEURL,AUP.MOBILENO,AUP.NUMBERPLATE, OB.ARMADAID, MA.ARMADANAME, " & _
                " OB.PICKUPLOC, OB.DESTINATIONLOC, MA.SERVICETYPEID, ST.SERVICETYPENAME, MA.SERVICETYPEDTLID, STD.SERVICETYPEDTLNAME,STD.IMAGEURL" & _
                 "  ,OB.PRICE,OB.DISTANCE,OB.DURATION,CONVERT(VARCHAR,CONVERT(date,OB.ORDERDATE,105),105)ORDERDATE,OB.NOTES,OB.STATUS,PG.NAME,OB.ORDERTIME " & _
                  " FROM ORDERDEBARANG OB" & _
                  " LEFT OUTER JOIN APPUSERCLIENT AUC ON OB.CUSTOMERID = AUC.UID" & _
                  " LEFT OUTER JOIN APPUSERPARTNER AUP ON OB.MITRAID = AUP.USERID" & _
                  " LEFT OUTER JOIN MASTERARMADA MA ON OB.ARMADAID = MA.ARMADAID" & _
                  " LEFT OUTER JOIN PARAMGLOBAL PG ON OB.STATUS = PG.CODE" & _
                  " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID" & _
                  " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID" & _
                  " WHERE CUSTOMERID = " & strUid & " AND PG.TYPE = 'ORDERSTATUS' AND PG.CODE=1 ORDER BY ORDERDATE,ORDERTIME DESC"
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
    Public Function GetHistoryPesananOrderDeBarang(ByVal strOrderid As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT TOP (10) OB.ORDERID ,OB.ORDERCODE,OB.CUSTOMERID,AUC.USERNAME, OB.MITRAID,AUP.USERNAME AS MITRANAME,AUP.IMAGEURL,AUP.MOBILENO,AUP.NUMBERPLATE, OB.ARMADAID, MA.ARMADANAME, " & _
                " OB.PICKUPLOC, OB.DESTINATIONLOC, MA.SERVICETYPEID, ST.SERVICETYPENAME, MA.SERVICETYPEDTLID, STD.SERVICETYPEDTLNAME,STD.IMAGEURL" & _
                 "  ,OB.PRICE,OB.DISTANCE,OB.DURATION,CONVERT(VARCHAR,CONVERT(date,OB.ORDERDATE,103),103)ORDERDATE,OB.NOTES,OB.STATUS,PG.NAME,OB.ORDERTIME " & _
                  " FROM ORDERDEBARANG OB" & _
                  " LEFT OUTER JOIN APPUSERCLIENT AUC ON OB.CUSTOMERID = AUC.UID" & _
                  " LEFT OUTER JOIN APPUSERPARTNER AUP ON OB.MITRAID = AUP.USERID" & _
                  " LEFT OUTER JOIN MASTERARMADA MA ON OB.ARMADAID = MA.ARMADAID" & _
                  " LEFT OUTER JOIN PARAMGLOBAL PG ON OB.STATUS = PG.CODE" & _
                  " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID" & _
                  " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID" & _
                  " WHERE ORDERID = " & strOrderid & " AND PG.TYPE = 'ORDERSTATUS' AND PG.CODE=1 ORDER BY ORDERDATE,ORDERTIME DESC"
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
    Public Function GetHistoryPesananDeBarangMitra(ByVal strMitraId As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT TOP (10) OB.ORDERID ,OB.ORDERCODE,OB.CUSTOMERID,AUC.USERNAME, OB.MITRAID,AUP.USERNAME AS MITRANAME,AUP.IMAGEURL,AUP.MOBILENO,AUP.NUMBERPLATE, OB.ARMADAID, MA.ARMADANAME, " & _
                " OB.PICKUPLOC, OB.DESTINATIONLOC, MA.SERVICETYPEID, ST.SERVICETYPENAME, MA.SERVICETYPEDTLID, STD.SERVICETYPEDTLNAME,STD.IMAGEURL" & _
                 "  ,OB.PRICE,OB.DISTANCE,OB.DURATION,CONVERT(VARCHAR,CONVERT(date,OB.ORDERDATE,103),103)ORDERDATE,OB.NOTES,OB.STATUS,PG.NAME,OB.ORDERTIME " & _
                  " FROM ORDERDEBARANG OB" & _
                  " LEFT OUTER JOIN APPUSERCLIENT AUC ON OB.CUSTOMERID = AUC.UID" & _
                  " LEFT OUTER JOIN APPUSERPARTNER AUP ON OB.MITRAID = AUP.USERID" & _
                  " LEFT OUTER JOIN MASTERARMADA MA ON OB.ARMADAID = MA.ARMADAID" & _
                  " LEFT OUTER JOIN PARAMGLOBAL PG ON OB.STATUS = PG.CODE" & _
                  " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID" & _
                  " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID" & _
                  " WHERE MITRAID = " & strMitraId & " AND PG.TYPE = 'ORDERSTATUS' AND PG.CODE=1 ORDER BY ORDERDATE,ORDERTIME DESC"
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
    Public Function GetOrderDebarangDetailMitra(ByVal strMitraid As String, ByVal strStatus As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT ODB.ORDERID,ODB.ORDERCODE,ODB.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODB.MITRAID,AUP.FULLNAME,AUP.NUMBERPLATE " & _
                             " ,ODB.ARMADAID,MA.ARMADANAME,ODB.PICKUPLOC,ODB.PICKUPLOCLAT,ODB.PICKUPLOCLONG" & _
                            " ,ODB.DESTINATIONLOC,ODB.DESTINATIONLOCLAT,ODB.DESTINATIONLOCLONG,ODB.PRICE,ODB.DISTANCE " & _
                             " ,ODB.DURATION,CONVERT(VARCHAR,CONVERT(date,ODB.ORDERDATE,103),103)ORDERDATE " & _
                            " ,ODB.NOTES,ODB.STATUS,PG.NAME,ODB.ORDERTIME,STD.IMAGEURL,AUP.IMAGEURL,AUP.MOBILENO,ODB.WEIGHT AS [BERATBARANG],ODB.TYPE [JENISBARANG] " & _
                      " FROM ORDERDEBARANG ODB " & _
                        " LEFT OUTER JOIN APPUSERCLIENT AUC ON ODB.CUSTOMERID = AUC.UID " & _
                        " LEFT OUTER JOIN APPUSERPARTNER AUP ON ODB.MITRAID = AUP.USERID " & _
                        " LEFT OUTER JOIN MASTERARMADA MA ON ODB.ARMADAID = MA.ARMADAID " & _
                        " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID" & _
                        " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID" & _
                        " LEFT OUTER JOIN PARAMGLOBAL PG ON ODB.STATUS = PG.CODE " & _
                     " WHERE MITRAID='" & strMitraid & "' AND PG.TYPE = 'ORDERSTATUS' AND PG.CODE='" & strStatus & "'"
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
    'Public Function GetOrderCountDeBarangMitra(ByVal strMitraId As String) As String
    '    Dim objDB As New DBX
    '    Dim strSQL As String = ""
    '    Dim dt As DataTable = New DataTable
    '    oSC.Open()
    '    strSQL = "SELECT COUNT(*) AS ORDERCOUNT " & _
    '                    "FROM ORDERDEBARANG OC " & _
    '                                  "LEFT OUTER JOIN APPUSERCLIENT AUC ON OC.CUSTOMERID = AUC.UID " & _
    '                                  "LEFT OUTER JOIN APPUSERPARTNER AUP ON OC.MITRAID = AUP.USERID " & _
    '                                  "LEFT OUTER JOIN MASTERARMADA MA ON OC.ARMADAID = MA.ARMADAID " & _
    '                                  " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                                  " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '                                  "LEFT OUTER JOIN PARAMGLOBAL PG ON OC.STATUS = PG.CODE " & _
    '         " WHERE MITRAID = " & strMitraId & " AND PG.TYPE = 'ORDERSTATUS' AND PG.CODE=1 "
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
    Public Function GetDetailPesananDeJek(ByVal strCustId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT ORDERID,ORDERCODE,CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,MITRAID,AUP.FULLNAME AS MITRANAME,AUP.NUMBERPLATE " & _
                               ",OC.ARMADAID,MA.ARMADANAME,MA.SERVICETYPEID,ST.SERVICETYPENAME,OC.PICKUPLOC,OC.PICKUPLOCLAT,OC.PICKUPLOCLONG " & _
                               ",OC.DESTINATIONLOC,OC.DESTINATIONLOCLAT,OC.DESTINATIONLOCLONG " & _
                               ",OC.PRICE,CONVERT(VARCHAR,CONVERT(date,OC.ORDERDATE,103),103)ORDERDATE,OC.NOTES " & _
                               ",OC.STATUS,PG.NAME,OC.DISTANCE,OC.DURATION,STD.IMAGEURL,AUP.IMAGEURL,AUP.MOBILENO " & _
                        "FROM ORDERDEJEK OC " & _
                                      "LEFT OUTER JOIN APPUSERCLIENT AUC ON OC.CUSTOMERID = AUC.UID " & _
                                      "LEFT OUTER JOIN APPUSERPARTNER AUP ON OC.MITRAID = AUP.USERID " & _
                                      "LEFT OUTER JOIN MASTERARMADA MA ON OC.ARMADAID = MA.ARMADAID " & _
                                      " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID " & _
                                      " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                                      "LEFT OUTER JOIN PARAMGLOBAL PG ON OC.STATUS = PG.CODE " & _
             " WHERE CUSTOMERID = " & strCustId & " AND PG.TYPE = 'ORDERSTATUS' AND (PG.CODE = 2 OR PG.CODE=8) AND OC.MITRAID IS NOT NULL"
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
    Public Function GetOrderPesananMaxDejek(ByVal strCustId As Integer, ByVal strArmadaId As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT MAX(ORDERID) AS ORDERID FROM ORDERDEJEK " & _
                "WHERE STATUS =8 AND CUSTOMERID = '" & strCustId & "'  AND ARMADAID= '" & strArmadaId & "' AND MITRAID IS NOT NULL"
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
    Public Function GetHistoryPesnanDeJekCust(ByVal strCustId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT TOP(3) ORDERID,ORDERCODE,CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,MITRAID,AUP.FULLNAME AS MITRANAME,AUP.NUMBERPLATE " & _
                               ",OC.ARMADAID,MA.ARMADANAME,OC.PICKUPLOC,OC.PICKUPLOCLAT,OC.PICKUPLOCLONG " & _
                               ",OC.DESTINATIONLOC,OC.DESTINATIONLOCLAT,OC.DESTINATIONLOCLONG " & _
                               ",OC.PRICE,CONVERT(VARCHAR,CONVERT(date,OC.ORDERDATE,103),103)ORDERDATE,OC.NOTES " & _
                               ",OC.STATUS,PG.NAME,OC.DISTANCE,OC.DURATION,STD.IMAGEURL,AUP.IMAGEURL,AUP.MOBILENO " & _
                        "FROM ORDERDEJEK OC " & _
                                      "LEFT OUTER JOIN APPUSERCLIENT AUC ON OC.CUSTOMERID = AUC.UID " & _
                                      "LEFT OUTER JOIN APPUSERPARTNER AUP ON OC.MITRAID = AUP.USERID " & _
                                      "LEFT OUTER JOIN MASTERARMADA MA ON OC.ARMADAID = MA.ARMADAID " & _
                                      " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID " & _
                                      " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                                      "LEFT OUTER JOIN PARAMGLOBAL PG ON OC.STATUS = PG.CODE " & _
             " WHERE CUSTOMERID = " & strCustId & " AND PG.TYPE = 'ORDERSTATUS' AND PG.CODE=1 ORDER BY ORDERCODE DESC"
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
    Public Function GetHistoryPesnanOrderDeJek(ByVal strOrderId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT TOP(10) ORDERID,ORDERCODE,CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,MITRAID,AUP.FULLNAME AS MITRANAME,AUP.NUMBERPLATE " & _
                               ",OC.ARMADAID,MA.ARMADANAME,OC.PICKUPLOC,OC.PICKUPLOCLAT,OC.PICKUPLOCLONG " & _
                               ",OC.DESTINATIONLOC,OC.DESTINATIONLOCLAT,OC.DESTINATIONLOCLONG " & _
                               ",OC.PRICE,CONVERT(VARCHAR,CONVERT(date,OC.ORDERDATE,103),103)ORDERDATE,OC.NOTES " & _
                               ",OC.STATUS,PG.NAME,OC.DISTANCE,OC.DURATION,STD.IMAGEURL,AUP.IMAGEURL,AUP.MOBILENO " & _
                        "FROM ORDERDEJEK OC " & _
                                      "LEFT OUTER JOIN APPUSERCLIENT AUC ON OC.CUSTOMERID = AUC.UID " & _
                                      "LEFT OUTER JOIN APPUSERPARTNER AUP ON OC.MITRAID = AUP.USERID " & _
                                      "LEFT OUTER JOIN MASTERARMADA MA ON OC.ARMADAID = MA.ARMADAID " & _
                                      " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID " & _
                                      " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                                      "LEFT OUTER JOIN PARAMGLOBAL PG ON OC.STATUS = PG.CODE " & _
             " WHERE ORDERID = " & strOrderId & " AND PG.TYPE = 'ORDERSTATUS' AND PG.CODE=1 ORDER BY ORDERDATE DESC"
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
    Public Function GetHistoryPesnanDeJekMitra(ByVal strMitraId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT TOP(10) ORDERID,ORDERCODE,CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,MITRAID,AUP.FULLNAME AS MITRANAME,AUP.NUMBERPLATE " & _
                               ",OC.ARMADAID,MA.ARMADANAME,OC.PICKUPLOC,OC.PICKUPLOCLAT,OC.PICKUPLOCLONG " & _
                               ",OC.DESTINATIONLOC,OC.DESTINATIONLOCLAT,OC.DESTINATIONLOCLONG " & _
                               ",OC.PRICE,CONVERT(VARCHAR,CONVERT(date,OC.ORDERDATE,103),103)ORDERDATE,OC.NOTES " & _
                               ",OC.STATUS,PG.NAME,OC.DISTANCE,OC.DURATION,STD.IMAGEURL,AUP.IMAGEURL,AUP.MOBILENO " & _
                        "FROM ORDERDEJEK OC " & _
                                      "LEFT OUTER JOIN APPUSERCLIENT AUC ON OC.CUSTOMERID = AUC.UID " & _
                                      "LEFT OUTER JOIN APPUSERPARTNER AUP ON OC.MITRAID = AUP.USERID " & _
                                      "LEFT OUTER JOIN MASTERARMADA MA ON OC.ARMADAID = MA.ARMADAID " & _
                                      " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID " & _
                                      " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                                      "LEFT OUTER JOIN PARAMGLOBAL PG ON OC.STATUS = PG.CODE " & _
             " WHERE MITRAID = " & strMitraId & " AND PG.TYPE = 'ORDERSTATUS' AND PG.CODE=1 ORDER BY ORDERDATE DESC"
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
    Public Function GetOrderDeJekDetailMitra(ByVal strMitraId As String, ByVal strStatus As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT ORDERID,ORDERCODE,CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,MITRAID,AUP.FULLNAME AS MITRANAME,AUP.NUMBERPLATE " & _
                               ",OC.ARMADAID,MA.ARMADANAME,OC.PICKUPLOC,OC.PICKUPLOCLAT,OC.PICKUPLOCLONG " & _
                               ",OC.DESTINATIONLOC,OC.DESTINATIONLOCLAT,OC.DESTINATIONLOCLONG " & _
                               ",OC.PRICE,CONVERT(VARCHAR,CONVERT(date,OC.ORDERDATE,103),103)ORDERDATE,OC.NOTES " & _
                               ",OC.STATUS,PG.NAME,OC.DISTANCE,OC.DURATION,STD.IMAGEURL,AUP.IMAGEURL,AUP.MOBILENO " & _
                        "FROM ORDERDEJEK OC " & _
                                      "LEFT OUTER JOIN APPUSERCLIENT AUC ON OC.CUSTOMERID = AUC.UID " & _
                                      "LEFT OUTER JOIN APPUSERPARTNER AUP ON OC.MITRAID = AUP.USERID " & _
                                      "LEFT OUTER JOIN MASTERARMADA MA ON OC.ARMADAID = MA.ARMADAID " & _
                                      " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID " & _
                                      " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                                      "LEFT OUTER JOIN PARAMGLOBAL PG ON OC.STATUS = PG.CODE " & _
             " WHERE MITRAID = " & strMitraId & " AND PG.TYPE = 'ORDERSTATUS' AND PG.CODE='" & strStatus & "'"
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
    Public Function GetDetailOrderDeJek(ByVal strOrderId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT ORDERID,ORDERCODE,CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,MITRAID,AUP.FULLNAME AS MITRANAME,AUP.NUMBERPLATE " & _
                               ",OC.ARMADAID,MA.ARMADANAME,OC.PICKUPLOC,OC.PICKUPLOCLAT,OC.PICKUPLOCLONG " & _
                               ",OC.DESTINATIONLOC,OC.DESTINATIONLOCLAT,OC.DESTINATIONLOCLONG " & _
                            ",OC.PRICE,CONVERT(VARCHAR,CONVERT(date,OC.ORDERDATE,103),103)ORDERDATE,OC.NOTES " & _
                               ",OC.STATUS,PG.NAME,OC.DISTANCE,OC.DURATION,STD.IMAGEURL,AUP.IMAGEURL,AUP.MOBILENO " & _
                        "FROM ORDERDEJEK OC " & _
                                      "LEFT OUTER JOIN APPUSERCLIENT AUC ON OC.CUSTOMERID = AUC.UID " & _
                                      "LEFT OUTER JOIN APPUSERPARTNER AUP ON OC.MITRAID = AUP.USERID " & _
                                      "LEFT OUTER JOIN MASTERARMADA MA ON OC.ARMADAID = MA.ARMADAID " & _
                                      " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID " & _
                                      " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                                      "LEFT OUTER JOIN PARAMGLOBAL PG ON OC.STATUS = PG.CODE " & _
             " WHERE ORDERID = " & strOrderId & "AND PG.TYPE = 'ORDERSTATUS'"
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
    Public Function GetMapOrderDeBarang(ByVal strOrderId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT ODB.ORDERID,MA.SERVICETYPEID,ODB.ORDERCODE,ODB.MITRAID,AUP.FULLNAME,AUP.NUMBERPLATE,ODB.PICKUPLOC,ODB.PICKUPLOCLAT,ODB.PICKUPLOCLONG " & _
                             ",ODB.DESTINATIONLOC,ODB.DESTINATIONLOCLAT,ODB.DESTINATIONLOCLONG,ODB.PRICE,ODB.DISTANCE,ODB.DURATION " & _
                              ",ODB.STATUS,PG.NAME,AUP.IMAGEURL,AUP.MOBILENO,ODB.WEIGHT AS [BERATBARANG],ODB.TYPE [JENISBARANG] " & _
                       "FROM ORDERDEBARANG ODB " & _
                         "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODB.CUSTOMERID = AUC.UID " & _
                         "LEFT OUTER JOIN APPUSERPARTNER AUP ON ODB.MITRAID = AUP.USERID " & _
                         "LEFT OUTER JOIN MASTERARMADA MA ON ODB.ARMADAID = MA.ARMADAID " & _
                         "LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID " & _
                         "LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                         "INNER JOIN PARAMGLOBAL PG ON ODB.STATUS = PG.CODE  " & _
                 "WHERE ORDERID='" & strOrderId & "' AND PG.TYPE='ORDERSTATUS' "
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
    Public Function GetMapOrderDeJek(ByVal strOrderId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT OJ.ORDERID,OJ.ORDERCODE,OJ.MITRAID,AUP.FULLNAME,AUP.NUMBERPLATE,OJ.PICKUPLOC,OJ.PICKUPLOCLAT,OJ.PICKUPLOCLONG " & _
                             ",OJ.DESTINATIONLOC,OJ.DESTINATIONLOCLAT,OJ.DESTINATIONLOCLONG,OJ.PRICE,OJ.DISTANCE,OJ.DURATION " & _
                              ",OJ.STATUS,PG.NAME,AUP.IMAGEURL,AUP.MOBILENO " & _
                       "FROM ORDERDEJEK OJ " & _
                         "LEFT OUTER JOIN APPUSERPARTNER AUP ON OJ.MITRAID = AUP.USERID " & _
                         "LEFT OUTER JOIN MASTERARMADA MA ON OJ.ARMADAID = MA.ARMADAID " & _
                         "LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID " & _
                         "LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                         "INNER JOIN PARAMGLOBAL PG ON OJ.STATUS = PG.CODE  " & _
                 "WHERE ORDERID='" & strOrderId & "' AND PG.TYPE='ORDERSTATUS'"
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
    Public Function GetPesananDeOjek() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT ORDERID,ORDERCODE,CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,MITRAID,AUP.FULLNAME AS MITRANAME " & _
                               ",OC.ARMADAID,MA.ARMADANAME,OC.PICKUPLOC,OC.PICKUPLOCLAT,OC.PICKUPLOCLONG " & _
                               ",OC.DESTINATIONLOC,OC.DESTINATIONLOCLAT,OC.DESTINATIONLOCLONG " & _
                            ",OC.PRICE,CONVERT(VARCHAR,CONVERT(date,OC.ORDERDATE,103),103)ORDERDATE,OC.NOTES " & _
                               ",OC.STATUS,PG.NAME,OC.DISTANCE,OC.DURATION,STD.IMAGEURL,AUP.IMAGEURL,AUP.MOBILENO " & _
                        "FROM ORDERDEJEK OC " & _
                                      "LEFT OUTER JOIN APPUSERCLIENT AUC ON OC.CUSTOMERID = AUC.UID " & _
                                      "LEFT OUTER JOIN APPUSERPARTNER AUP ON OC.MITRAID = AUP.USERID " & _
                                      "LEFT OUTER JOIN MASTERARMADA MA ON OC.ARMADAID = MA.ARMADAID " & _
                                      " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID " & _
                                      " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                                      "LEFT OUTER JOIN PARAMGLOBAL PG ON OC.STATUS = PG.CODE " & _
             " WHERE PG.TYPE = 'ORDERSTATUS' AND PG.CODE=0"
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
    Public Function GetDetailPesananDeCar(ByVal strCustId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT TOP(1) ORDERID,ORDERCODE,CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,MITRAID,AUP.FULLNAME AS MITRANAME,AUP.MOBILENO,AUP.NUMBERPLATE " & _
                                ",OC.ARMADAID,MA.ARMADANAME,MA.SERVICETYPEID,ST.SERVICETYPENAME,OC.PICKUPLOC,OC.PICKUPLOCLAT,OC.PICKUPLOCLONG " & _
                               ",OC.DESTINATIONLOC,OC.DESTINATIONLOCLAT,OC.DESTINATIONLOCLONG " & _
                            ",OC.PRICE,CONVERT(VARCHAR,CONVERT(date,OC.ORDERDATE,103),103)ORDERDATE,OC.NOTES " & _
                               ",OC.STATUS,PG.NAME,OC.DISTANCE,OC.DURATION,STD.IMAGEURL,AUP.IMAGEURL,AUP.MOBILENO " & _
                        "FROM ORDERDECAR OC " & _
                                      "LEFT OUTER JOIN APPUSERCLIENT AUC ON OC.CUSTOMERID = AUC.UID " & _
                                      "LEFT OUTER JOIN APPUSERPARTNER AUP ON OC.MITRAID = AUP.USERID " & _
                                      "LEFT OUTER JOIN MASTERARMADA MA ON OC.ARMADAID = MA.ARMADAID " & _
                                      " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID " & _
                                      " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                                      "LEFT OUTER JOIN PARAMGLOBAL PG ON OC.STATUS = PG.CODE " & _
             " WHERE CUSTOMERID = " & strCustId & " AND PG.TYPE = 'ORDERSTATUS' AND (PG.CODE = 2 OR PG.CODE=8) AND OC.MITRAID IS NOT NULL"
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
    Public Function GetOrderPesananMaxDecar(ByVal strCustId As Integer, ByVal strArmadaId As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT MAX(ORDERID) AS ORDERID FROM ORDERDECAR" & _
                 "WHERE STATUS =8 AND CUSTOMERID = '" & strCustId & "'  AND ARMADAID= '" & strArmadaId & "' AND MITRAID IS NOT NULL"
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
    Public Function GetHistoryPesananDeCarCust(ByVal strCustId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT TOP(3) ORDERID,ORDERCODE,CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,MITRAID,AUP.FULLNAME AS MITRANAME,AUP.MOBILENO,AUP.NUMBERPLATE " & _
                                ",OC.ARMADAID,MA.ARMADANAME,OC.PICKUPLOC,OC.PICKUPLOCLAT,OC.PICKUPLOCLONG " & _
                               ",OC.DESTINATIONLOC,OC.DESTINATIONLOCLAT,OC.DESTINATIONLOCLONG " & _
                            ",OC.PRICE,CONVERT(VARCHAR,CONVERT(date,OC.ORDERDATE,103),103)ORDERDATE,OC.NOTES " & _
                               ",OC.STATUS,PG.NAME,OC.DISTANCE,OC.DURATION,STD.IMAGEURL,AUP.IMAGEURL,AUP.MOBILENO " & _
                        "FROM ORDERDECAR OC " & _
                                      "LEFT OUTER JOIN APPUSERCLIENT AUC ON OC.CUSTOMERID = AUC.UID " & _
                                      "LEFT OUTER JOIN APPUSERPARTNER AUP ON OC.MITRAID = AUP.USERID " & _
                                      "LEFT OUTER JOIN MASTERARMADA MA ON OC.ARMADAID = MA.ARMADAID " & _
                                      " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID " & _
                                      " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                                      "LEFT OUTER JOIN PARAMGLOBAL PG ON OC.STATUS = PG.CODE " & _
             " WHERE CUSTOMERID = " & strCustId & " AND PG.TYPE = 'ORDERSTATUS' AND PG.CODE=1 ORDER BY ORDERCODE DESC"
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
    Public Function GetHistoryPesananOrderDeCar(ByVal strOrderId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT TOP(10) ORDERID,ORDERCODE,CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,MITRAID,AUP.FULLNAME AS MITRANAME,AUP.MOBILENO,AUP.NUMBERPLATE " & _
                                ",OC.ARMADAID,MA.ARMADANAME,OC.PICKUPLOC,OC.PICKUPLOCLAT,OC.PICKUPLOCLONG " & _
                               ",OC.DESTINATIONLOC,OC.DESTINATIONLOCLAT,OC.DESTINATIONLOCLONG " & _
                            ",OC.PRICE,CONVERT(VARCHAR,CONVERT(date,OC.ORDERDATE,103),103)ORDERDATE,OC.NOTES " & _
                               ",OC.STATUS,PG.NAME,OC.DISTANCE,OC.DURATION,STD.IMAGEURL,AUP.IMAGEURL,AUP.MOBILENO " & _
                        "FROM ORDERDECAR OC " & _
                                      "LEFT OUTER JOIN APPUSERCLIENT AUC ON OC.CUSTOMERID = AUC.UID " & _
                                      "LEFT OUTER JOIN APPUSERPARTNER AUP ON OC.MITRAID = AUP.USERID " & _
                                      "LEFT OUTER JOIN MASTERARMADA MA ON OC.ARMADAID = MA.ARMADAID " & _
                                      " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID " & _
                                      " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                                      "LEFT OUTER JOIN PARAMGLOBAL PG ON OC.STATUS = PG.CODE " & _
             " WHERE ORDERID = " & strOrderId & " AND PG.TYPE = 'ORDERSTATUS' AND PG.CODE=1 ORDER BY ORDERDATE,ORDERTIME DESC"
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
    Public Function GetMapOrderDeCar(ByVal strOrderId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT OC.ORDERID,OC.ORDERCODE,OC.MITRAID,AUP.FULLNAME,AUP.NUMBERPLATE,OC.PICKUPLOC,OC.PICKUPLOCLAT,OC.PICKUPLOCLONG " & _
                            " ,OC.DESTINATIONLOC,OC.DESTINATIONLOCLAT,OC.DESTINATIONLOCLONG,OC.PRICE,OC.DISTANCE,OC.DURATION " & _
                             " ,OC.STATUS,PG.NAME,AUP.IMAGEURL,AUP.MOBILENO " & _
                      " FROM ORDERDECAR OC " & _
                        " LEFT OUTER JOIN APPUSERPARTNER AUP ON OC.MITRAID = AUP.USERID " & _
                        " LEFT OUTER JOIN MASTERARMADA MA ON OC.ARMADAID = MA.ARMADAID " & _
                        " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID " & _
                        " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                        " INNER JOIN PARAMGLOBAL PG ON OC.STATUS = PG.CODE " & _
                 "WHERE ORDERID='" & strOrderId & "' AND PG.TYPE='ORDERSTATUS' "
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
    Public Function GetHistoryPesananDeCarMitra(ByVal strMitraId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT TOP(10) ORDERID,ORDERCODE,CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,MITRAID,AUP.FULLNAME AS MITRANAME,AUP.MOBILENO,AUP.NUMBERPLATE " & _
                                ",OC.ARMADAID,MA.ARMADANAME,OC.PICKUPLOC,OC.PICKUPLOCLAT,OC.PICKUPLOCLONG " & _
                               ",OC.DESTINATIONLOC,OC.DESTINATIONLOCLAT,OC.DESTINATIONLOCLONG " & _
                            ",OC.PRICE,CONVERT(VARCHAR,CONVERT(date,OC.ORDERDATE,103),103)ORDERDATE,OC.NOTES " & _
                               ",OC.STATUS,PG.NAME,OC.DISTANCE,OC.DURATION,STD.IMAGEURL,AUP.IMAGEURL,AUP.MOBILENO " & _
                        "FROM ORDERDECAR OC " & _
                                      "LEFT OUTER JOIN APPUSERCLIENT AUC ON OC.CUSTOMERID = AUC.UID " & _
                                      "LEFT OUTER JOIN APPUSERPARTNER AUP ON OC.MITRAID = AUP.USERID " & _
                                      "LEFT OUTER JOIN MASTERARMADA MA ON OC.ARMADAID = MA.ARMADAID " & _
                                      " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID " & _
                                      " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                                      "LEFT OUTER JOIN PARAMGLOBAL PG ON OC.STATUS = PG.CODE " & _
             " WHERE MITRAID = " & strMitraId & " AND PG.TYPE = 'ORDERSTATUS' AND PG.CODE=1 ORDER BY ORDERDATE,ORDERTIME DESC"
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
    'Public Function GetOrderCountDeCarMitra(ByVal strMitraId As String) As String
    '    Dim objDB As New DBX
    '    Dim strSQL As String = ""
    '    Dim dt As DataTable = New DataTable
    '    oSC.Open()
    '    strSQL = "SELECT COUNT(*) AS ORDERCOUNT " & _
    '                    "FROM ORDERDECAR OC " & _
    '                                  "LEFT OUTER JOIN APPUSERCLIENT AUC ON OC.CUSTOMERID = AUC.UID " & _
    '                                  "LEFT OUTER JOIN APPUSERPARTNER AUP ON OC.MITRAID = AUP.USERID " & _
    '                                  "LEFT OUTER JOIN MASTERARMADA MA ON OC.ARMADAID = MA.ARMADAID " & _
    '                                  " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID " & _
    '                                  " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
    '                                  "LEFT OUTER JOIN PARAMGLOBAL PG ON OC.STATUS = PG.CODE " & _
    '         " WHERE MITRAID = " & strMitraId & " AND PG.TYPE = 'ORDERSTATUS' AND PG.CODE=1 "
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
    Public Function GetOrderDeCarDetailMitra(ByVal strMitraId As String, ByVal strStatus As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT ORDERID,ORDERCODE,CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,MITRAID,AUP.FULLNAME AS MITRANAME,AUP.MOBILENO,AUP.NUMBERPLATE " & _
                                ",OC.ARMADAID,MA.ARMADANAME,OC.PICKUPLOC,OC.PICKUPLOCLAT,OC.PICKUPLOCLONG " & _
                               ",OC.DESTINATIONLOC,OC.DESTINATIONLOCLAT,OC.DESTINATIONLOCLONG " & _
                            ",OC.PRICE,CONVERT(VARCHAR,CONVERT(date,OC.ORDERDATE,103),103)ORDERDATE,OC.NOTES " & _
                               ",OC.STATUS,PG.NAME,OC.DISTANCE,OC.DURATION,STD.IMAGEURL,AUP.IMAGEURL,AUP.MOBILENO " & _
                        "FROM ORDERDECAR OC " & _
                                      "LEFT OUTER JOIN APPUSERCLIENT AUC ON OC.CUSTOMERID = AUC.UID " & _
                                      "LEFT OUTER JOIN APPUSERPARTNER AUP ON OC.MITRAID = AUP.USERID " & _
                                      "LEFT OUTER JOIN MASTERARMADA MA ON OC.ARMADAID = MA.ARMADAID " & _
                                      " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID " & _
                                      " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                                      "LEFT OUTER JOIN PARAMGLOBAL PG ON OC.STATUS = PG.CODE " & _
             " WHERE MITRAID = " & strMitraId & "AND PG.TYPE = 'ORDERSTATUS' AND PG.CODE='" & strStatus & "'"
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
    Public Function GetDetailOrderDeCar(ByVal strOrderId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT ORDERID,ORDERCODE,CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,MITRAID,AUP.FULLNAME AS MITRANAME,AUP.NUMBERPLATE " & _
                               ",OC.ARMADAID,MA.ARMADANAME,OC.PICKUPLOC,OC.PICKUPLOCLAT,OC.PICKUPLOCLONG " & _
                               ",OC.DESTINATIONLOC,OC.DESTINATIONLOCLAT,OC.DESTINATIONLOCLONG " & _
                                ",OC.PRICE,CONVERT(VARCHAR,CONVERT(date,OC.ORDERDATE,103),103)ORDERDATE,OC.NOTES " & _
                               ",OC.STATUS,PG.NAME,OC.DISTANCE,OC.DURATION,STD.IMAGEURL,AUP.IMAGEURL,AUP.MOBILENO " & _
                        "FROM ORDERDECAR OC " & _
                                      "LEFT OUTER JOIN APPUSERCLIENT AUC ON OC.CUSTOMERID = AUC.UID " & _
                                      "LEFT OUTER JOIN APPUSERPARTNER AUP ON OC.MITRAID = AUP.USERID " & _
                                      "LEFT OUTER JOIN MASTERARMADA MA ON OC.ARMADAID = MA.ARMADAID " & _
                                      " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID " & _
                                      " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                                      "LEFT OUTER JOIN PARAMGLOBAL PG ON OC.STATUS = PG.CODE " & _
             " WHERE ORDERID = " & strOrderId & "AND PG.TYPE = 'ORDERSTATUS'"
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
    Public Function GetPesananDeCar() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT ORDERID,ORDERCODE,CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,MITRAID,AUP.FULLNAME AS MITRANAME,AUP.IMAGEURL,AUP.MOBILENO " & _
                               ",OC.ARMADAID,MA.ARMADANAME,OC.PICKUPLOC,OC.PICKUPLOCLAT,OC.PICKUPLOCLONG " & _
                               ",OC.DESTINATIONLOC,OC.DESTINATIONLOCLAT,OC.DESTINATIONLOCLONG " & _
                                ",OC.PRICE,CONVERT(VARCHAR,CONVERT(date,OC.ORDERDATE,103),103)ORDERDATE,OC.NOTES " & _
                               ",OC.STATUS,PG.NAME,OC.DISTANCE,OC.DURATION,STD.IMAGEURL " & _
                        "FROM ORDERDECAR OC " & _
                                      "LEFT OUTER JOIN APPUSERCLIENT AUC ON OC.CUSTOMERID = AUC.UID " & _
                                      "LEFT OUTER JOIN APPUSERPARTNER AUP ON OC.MITRAID = AUP.USERID " & _
                                      "LEFT OUTER JOIN MASTERARMADA MA ON OC.ARMADAID = MA.ARMADAID " & _
                                      " LEFT OUTER JOIN SERVICETYPE ST ON MA.SERVICETYPEID = ST.SERVICETYPEID  " & _
                                      " LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
                                      "LEFT OUTER JOIN PARAMGLOBAL PG ON OC.STATUS = PG.CODE " & _
             " WHERE PG.TYPE = 'ORDERSTATUS' AND PG.CODE=0"
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
