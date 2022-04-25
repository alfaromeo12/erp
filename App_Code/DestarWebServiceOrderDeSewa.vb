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


<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
<System.Web.Script.Services.ScriptService()> _
Public Class DestarWebOrder
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
    Public Function AddOrderDesewa(ByVal strCustomerID As Integer,
                                        ByVal strProductmitraId As Integer,
                                        ByVal strStartDate As DateTime,
                                        ByVal strEndDate As DateTime,
                                        ByVal strDuration As String,
                                        ByVal strQtyOrder As String,
                                        ByVal strAddressCustomer As String,
                                        ByVal strPaymentType As Integer,
                                        ByVal strTotalPrice As String,
                                        ByVal strNotes As String) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDESEWAADD",
                                                        objDB.MP("@CUSTOMERID", Data.SqlDbType.Int, strCustomerID),
                                                        objDB.MP("@PRODUCTMITRAID", Data.SqlDbType.Int, strProductmitraId),
                                                        objDB.MP("@STARTDATE", Data.SqlDbType.DateTime, strStartDate),
                                                        objDB.MP("@ENDDATE", Data.SqlDbType.DateTime, strEndDate),
                                                        objDB.MP("@DURATION", Data.SqlDbType.NVarChar, strDuration),
                                                        objDB.MP("@QTYORDER", Data.SqlDbType.VarChar, strQtyOrder),
                                                        objDB.MP("@ADDRESSCUSTOMER", Data.SqlDbType.VarChar, strAddressCustomer),
                                                        objDB.MP("@PAYMENTTYPE", Data.SqlDbType.Int, strPaymentType),
                                                        objDB.MP("@TOTALPRICE", Data.SqlDbType.Decimal, strTotalPrice),
                                                        objDB.MP("@NOTES", Data.SqlDbType.VarChar, strNotes),
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
    Public Function UpdateOrderDesewaDeliver(ByVal strOrderDesewaid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDESEWAUPDATE_DELIVER",
                                                        objDB.MP("@ORDERDESEWAID", Data.SqlDbType.Int, strOrderDesewaid),
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
    Public Function UpdateOrderDesewaFinish(ByVal strOrderDesewaid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDESEWAUPDATE_FINISH",
                                                        objDB.MP("@ORDERDESEWAID", Data.SqlDbType.Int, strOrderDesewaid),
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
    Public Function UpdateOrderDesewaProcess(ByVal strOrderDesewaid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDESEWAUPDATE_PROCESS",
                                                        objDB.MP("@ORDERDESEWAID", Data.SqlDbType.Int, strOrderDesewaid),
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
    Public Function UpdateOrderDesewaReject(ByVal strOrderDesewaid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDESEWAUPDATE_REJECT",
                                                        objDB.MP("@ORDERDESEWAID", Data.SqlDbType.Int, strOrderDesewaid),
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
    Public Function UpdateOrderDesewaReceive(ByVal strOrderDesewaid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDESEWAUPDATE_RECEIVE",
                                                        objDB.MP("@ORDERDESEWAID", Data.SqlDbType.Int, strOrderDesewaid),
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
    Public Function UpdateStatusProductBusy(ByVal strProductid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("PRODUCTMITRAUPDATE_BUSY]",
                                                        objDB.MP("@PRODUCTMITRAID", Data.SqlDbType.Int, strProductid),
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
    Public Function UpdateStatusProductIdle(ByVal strProductid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("PRODUCTMITRAUPDATE_IDLE]",
                                                        objDB.MP("@PRODUCTMITRAID", Data.SqlDbType.Int, strProductid),
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
    Public Function UpdateStatusProductActiveNo(ByVal strProductid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("PRODUCTMITRAUPDATEACTIVE_NO]",
                                                        objDB.MP("@PRODUCTMITRAID", Data.SqlDbType.Int, strProductid),
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
    Public Function UpdateStatusOrderDeSewaRejectCust(ByVal strOrderid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDESEWAUPDATECUST_REJECT",
                                                        objDB.MP("@ORDERDESEWAID", Data.SqlDbType.Int, strOrderid),
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
    Public Function UpdateStatusProductActiveYes(ByVal strProductid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("PRODUCTMITRAUPDATEACTIVE_YES]",
                                                        objDB.MP("@PRODUCTMITRAID", Data.SqlDbType.Int, strProductid),
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
    Public Function GetOrderDesewaDetailPesananCust(ByVal strCustomerId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT ODS.ORDERDESEWAID,ODS.ORDERDESEWACODE,ODS.PRODUCTMITRAID,PM.PRODUCTBRAND,ODS.CUSTOMERID " & _
                          " ,AUC.FULLNAME,PM.MITRAID,ISNULL (AUP.FULLNAME, '-') AS MITRANAME,AUP.IMAGEURL,AUP.MOBILENO,AUP.ADDRESS,CONVERT(VARCHAR,CONVERT(date,ODS.ORDERDATE,103),103)ORDERDATE " & _
                          "  ,CONVERT(VARCHAR,CONVERT(date,ODS.STARTDATE,103),103)STARTDATE ,CONVERT(VARCHAR,CONVERT(date,ODS.ENDDATE,103),103)ENDDATE,ODS.QTYORDER " & _
                          " ,ODS.ADDRESSCUSTOMER,ODS.PAYMENTTYPE,PG2.NAME AS PAYMENTTYPE,ODS.TOTALPRICE " & _
                          " ,ODS.NOTES,ODS.STATUS,PG3.NAME AS STATUSSEWA,PM.IMAGEURL,ODS.DURATION " & _
                      " FROM ORDERDESEWA ODS " & _
                      " LEFT OUTER JOIN PRODUCTMITRA PM ON ODS.PRODUCTMITRAID = PM.PRODUCTMITRAID " & _
                      " LEFT OUTER JOIN APPUSERCLIENT AUC ON ODS.CUSTOMERID = AUC.UID " & _
                      " LEFT OUTER JOIN APPUSERPARTNER AUP ON PM.MITRAID = AUP.USERID " & _
                      " LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODS.PAYMENTTYPE = PG2.CODE " & _
                      " LEFT OUTER JOIN PARAMGLOBAL PG3 ON ODS.STATUS = PG3.CODE " & _
                      " WHERE PG2.TYPE='PAYMENT' AND PG3.TYPE='ORDERSTATUS' AND (PG3.CODE=11 OR PG3.CODE =12) AND ODS.CUSTOMERID= '" & strCustomerId & "' AND PM.MITRAID IS NOT NULL"
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
    Public Function GetOrderPesananMaxDeSewa(ByVal strCustId As Integer, ByVal strProductId As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "SELECT MAX(ORDERDESEWAID) AS ORDERDESEWAID FROM ORDERDESEWA " & _
                    "WHERE CUSTOMERID = '" & strCustId & "' AND PRODUCTMITRAID='" & strProductId & "'"
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
    Public Function GetOrderDetailDesewa() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT ODS.ORDERDESEWAID,ODS.ORDERDESEWACODE,ODS.PRODUCTMITRAID,PM.PRODUCTBRAND,ODS.CUSTOMERID " & _
                          " ,AUC.FULLNAME,AUP.USERID,ISNULL (AUP.FULLNAME, '-') AS MITRANAME,AUP.IMAGEURL,AUP.MOBILENO,AUP.ADDRESS,CONVERT(VARCHAR,CONVERT(date,ODS.ORDERDATE,103),103)ORDERDATE " & _
                          "  ,CONVERT(VARCHAR,CONVERT(date,ODS.STARTDATE,103),103)STARTDATE ,CONVERT(VARCHAR,CONVERT(date,ODS.ENDDATE,103),103)ENDDATE,ODS.QTYORDER " & _
                          " ,ODS.ADDRESSCUSTOMER,ODS.PAYMENTTYPE,PG2.NAME AS PAYMENTTYPE,ODS.TOTALPRICE " & _
                          " ,ODS.NOTES,ODS.STATUS,PG3.NAME AS STATUSSEWA,PM.IMAGEURL,ODS.DURATION " & _
                      " FROM ORDERDESEWA ODS " & _
                      " LEFT OUTER JOIN PRODUCTMITRA PM ON ODS.PRODUCTMITRAID = PM.PRODUCTMITRAID " & _
                      " LEFT OUTER JOIN APPUSERCLIENT AUC ON ODS.CUSTOMERID = AUC.UID " & _
                      " LEFT OUTER JOIN APPUSERPARTNER AUP ON PM.MITRAID = AUP.USERID " & _
                      " LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODS.PAYMENTTYPE = PG2.CODE " & _
                      " LEFT OUTER JOIN PARAMGLOBAL PG3 ON ODS.STATUS = PG3.CODE " & _
                      " WHERE PG2.TYPE='PAYMENT' AND PG3.TYPE='ORDERSTATUS' AND PG3.CODE=2 AND AUP.USERID IS NOT NULL"
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
    Public Function GetOrderDesewaDetail(ByVal strOderId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT ODS.ORDERDESEWAID,ODS.ORDERDESEWACODE,ODS.PRODUCTMITRAID,PM.PRODUCTBRAND,ODS.CUSTOMERID " & _
                          " ,AUC.FULLNAME,AUP.USERID,ISNULL (AUP.FULLNAME, '-') AS MITRANAME,AUP.ADDRESS,AUP.IMAGEURL,AUP.MOBILENO,CONVERT(VARCHAR,CONVERT(date,ODS.ORDERDATE,103),103)ORDERDATE " & _
                          "  ,CONVERT(VARCHAR,CONVERT(date,ODS.STARTDATE,103),103)STARTDATE ,CONVERT(VARCHAR,CONVERT(date,ODS.ENDDATE,103),103)ENDDATE,ODS.QTYORDER " & _
                          " ,ODS.ADDRESSCUSTOMER,ODS.PAYMENTTYPE,PG2.NAME AS PAYMENTTYPE,ODS.TOTALPRICE " & _
                          " ,ODS.NOTES,ODS.STATUS,PG3.NAME AS STATUSSEWA,PM.IMAGEURL " & _
                      " FROM ORDERDESEWA ODS " & _
                      " LEFT OUTER JOIN PRODUCTMITRA PM ON ODS.PRODUCTMITRAID = PM.PRODUCTMITRAID " & _
                      " LEFT OUTER JOIN APPUSERCLIENT AUC ON ODS.CUSTOMERID = AUC.UID " & _
                      " LEFT OUTER JOIN APPUSERPARTNER AUP ON PM.MITRAID = AUP.USERID " & _
                      " LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODS.PAYMENTTYPE = PG2.CODE " & _
                      " LEFT OUTER JOIN PARAMGLOBAL PG3 ON ODS.STATUS = PG3.CODE " & _
                      " WHERE PG2.TYPE='PAYMENT' AND PG3.TYPE='ORDERSTATUS' AND ODS.ORDERDESEWAID= '" & strOderId & "'"
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
    Public Function GetOrderDesewaDetailPesananMitra(ByVal strMitraID As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT ODS.ORDERDESEWAID,ODS.ORDERDESEWACODE,ODS.PRODUCTMITRAID,PM.PRODUCTBRAND,ODS.CUSTOMERID " & _
                          " ,AUC.FULLNAME,AUP.USERID,ISNULL (AUP.FULLNAME, '-') AS MITRANAME,AUP.ADDRESS,AUP.IMAGEURL,AUP.MOBILENO,CONVERT(VARCHAR,CONVERT(date,ODS.ORDERDATE,103),103)ORDERDATE " & _
                          "  ,CONVERT(VARCHAR,CONVERT(date,ODS.STARTDATE,103),103)STARTDATE ,CONVERT(VARCHAR,CONVERT(date,ODS.ENDDATE,103),103)ENDDATE,ODS.QTYORDER " & _
                          " ,ODS.ADDRESSCUSTOMER,ODS.PAYMENTTYPE,PG2.NAME AS PAYMENTTYPE,ODS.TOTALPRICE " & _
                          " ,ODS.NOTES,ODS.STATUS,PG3.NAME AS STATUSSEWA,PM.IMAGEURL " & _
                      " FROM ORDERDESEWA ODS " & _
                      " LEFT OUTER JOIN PRODUCTMITRA PM ON ODS.PRODUCTMITRAID = PM.PRODUCTMITRAID " & _
                      " LEFT OUTER JOIN APPUSERCLIENT AUC ON ODS.CUSTOMERID = AUC.UID " & _
                      " LEFT OUTER JOIN APPUSERPARTNER AUP ON PM.MITRAID = AUP.USERID " & _
                      " LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODS.PAYMENTTYPE = PG2.CODE " & _
                      " LEFT OUTER JOIN PARAMGLOBAL PG3 ON ODS.STATUS = PG3.CODE " & _
                      " WHERE PG2.TYPE='PAYMENT' AND PG3.TYPE='ORDERSTATUS' AND PG3.CODE=0 AND PM.MITRAID='" & strMitraID & "'"
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
    Public Function GetOrderDesewaHistoryMitra(ByVal strMitraID As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT ODS.ORDERDESEWAID,ODS.ORDERDESEWACODE,ODS.PRODUCTMITRAID,PM.PRODUCTBRAND,ODS.CUSTOMERID " & _
                          " ,AUC.FULLNAME,AUP.USERID,ISNULL (AUP.FULLNAME, '-') AS MITRANAME,AUP.ADDRESS,AUP.IMAGEURL,AUP.MOBILENO,CONVERT(VARCHAR,CONVERT(date,ODS.ORDERDATE,103),103)ORDERDATE " & _
                          "  ,CONVERT(VARCHAR,CONVERT(date,ODS.STARTDATE,103),103)STARTDATE ,CONVERT(VARCHAR,CONVERT(date,ODS.ENDDATE,103),103)ENDDATE,ODS.QTYORDER " & _
                          " ,ODS.ADDRESSCUSTOMER,ODS.PAYMENTTYPE,PG2.NAME AS PAYMENTTYPE,ODS.TOTALPRICE " & _
                          " ,ODS.NOTES,ODS.STATUS,PG3.NAME AS STATUSSEWA,PM.IMAGEURL " & _
                      " FROM ORDERDESEWA ODS " & _
                      " LEFT OUTER JOIN PRODUCTMITRA PM ON ODS.PRODUCTMITRAID = PM.PRODUCTMITRAID " & _
                      " LEFT OUTER JOIN APPUSERCLIENT AUC ON ODS.CUSTOMERID = AUC.UID " & _
                      " LEFT OUTER JOIN APPUSERPARTNER AUP ON PM.MITRAID = AUP.USERID " & _
                      " LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODS.PAYMENTTYPE = PG2.CODE " & _
                      " LEFT OUTER JOIN PARAMGLOBAL PG3 ON ODS.STATUS = PG3.CODE " & _
                      " WHERE PG2.TYPE='PAYMENT' AND PG3.TYPE='ORDERSTATUS' AND PG3.CODE<>0 AND PM.MITRAID='" & strMitraID & "'"
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
    Public Function GetOrderDesewaHistoryFinishMitra(ByVal strMitraID As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT TOP (10) ODS.ORDERDESEWAID,ODS.ORDERDESEWACODE,ODS.PRODUCTMITRAID,PM.PRODUCTBRAND,ODS.CUSTOMERID " & _
                          " ,AUC.FULLNAME,AUP.USERID,ISNULL (AUP.FULLNAME, '-') AS MITRANAME,AUP.ADDRESS,AUP.IMAGEURL,AUP.MOBILENO,CONVERT(VARCHAR,CONVERT(date,ODS.ORDERDATE,103),103)ORDERDATE " & _
                          "  ,CONVERT(VARCHAR,CONVERT(date,ODS.STARTDATE,103),103)STARTDATE ,CONVERT(VARCHAR,CONVERT(date,ODS.ENDDATE,103),103)ENDDATE,ODS.QTYORDER " & _
                          " ,ODS.ADDRESSCUSTOMER,ODS.PAYMENTTYPE,PG2.NAME AS PAYMENTTYPE,ODS.TOTALPRICE " & _
                          " ,ODS.NOTES,ODS.STATUS,PG3.NAME AS STATUSSEWA,PM.IMAGEURL " & _
                      " FROM ORDERDESEWA ODS " & _
                      " LEFT OUTER JOIN PRODUCTMITRA PM ON ODS.PRODUCTMITRAID = PM.PRODUCTMITRAID " & _
                      " LEFT OUTER JOIN APPUSERCLIENT AUC ON ODS.CUSTOMERID = AUC.UID " & _
                      " LEFT OUTER JOIN APPUSERPARTNER AUP ON PM.MITRAID = AUP.USERID " & _
                      " LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODS.PAYMENTTYPE = PG2.CODE " & _
                      " LEFT OUTER JOIN PARAMGLOBAL PG3 ON ODS.STATUS = PG3.CODE " & _
                      " WHERE PG2.TYPE='PAYMENT' AND PG3.TYPE='ORDERSTATUS' AND PG3.CODE=1 AND PM.MITRAID='" & strMitraID & "' ORDER BY ORDERDATE DESC"
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
    Public Function GetOrderDesewaHistoryCust(ByVal strCustID As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT TOP (3) ODS.ORDERDESEWAID,ODS.ORDERDESEWACODE,ODS.PRODUCTMITRAID,PM.PRODUCTBRAND,ODS.CUSTOMERID " & _
                          " ,AUC.FULLNAME,AUP.USERID,ISNULL (AUP.FULLNAME, '-') AS MITRANAME,AUP.ADDRESS,AUP.IMAGEURL,AUP.MOBILENO,CONVERT(VARCHAR,CONVERT(date,ODS.ORDERDATE,103),103)ORDERDATE " & _
                          "  ,CONVERT(VARCHAR,CONVERT(date,ODS.STARTDATE,103),103)STARTDATE ,CONVERT(VARCHAR,CONVERT(date,ODS.ENDDATE,103),103)ENDDATE,ODS.QTYORDER " & _
                          " ,ODS.ADDRESSCUSTOMER,ODS.PAYMENTTYPE,PG2.NAME AS PAYMENTTYPE,ODS.TOTALPRICE " & _
                          " ,ODS.NOTES,ODS.STATUS,PG3.NAME AS STATUSSEWA,PM.IMAGEURL " & _
                      " FROM ORDERDESEWA ODS " & _
                      " LEFT OUTER JOIN PRODUCTMITRA PM ON ODS.PRODUCTMITRAID = PM.PRODUCTMITRAID " & _
                      " LEFT OUTER JOIN APPUSERCLIENT AUC ON ODS.CUSTOMERID = AUC.UID " & _
                      " LEFT OUTER JOIN APPUSERPARTNER AUP ON PM.MITRAID = AUP.USERID " & _
                      " LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODS.PAYMENTTYPE = PG2.CODE " & _
                      " LEFT OUTER JOIN PARAMGLOBAL PG3 ON ODS.STATUS = PG3.CODE " & _
                      " WHERE PG2.TYPE='PAYMENT' AND PG3.TYPE='ORDERSTATUS' AND PG3.CODE=1 AND CUSTOMERID='" & strCustID & "' ORDER BY ORDERDATE,ENDDATE DESC"
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
    Public Function GetCountOrderDesewaMitra(ByVal strMitraID As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT COUNT(*) AS ORDERCOUNT " & _
                      " FROM ORDERDESEWA ODS " & _
                      " LEFT OUTER JOIN PRODUCTMITRA PM ON ODS.PRODUCTMITRAID = PM.PRODUCTMITRAID " & _
                      " LEFT OUTER JOIN APPUSERCLIENT AUC ON ODS.CUSTOMERID = AUC.UID " & _
                      " LEFT OUTER JOIN APPUSERPARTNER AUP ON PM.MITRAID = AUP.USERID " & _
                      " LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODS.PAYMENTTYPE = PG2.CODE " & _
                      " LEFT OUTER JOIN PARAMGLOBAL PG3 ON ODS.STATUS = PG3.CODE " & _
                      " WHERE PG2.TYPE='PAYMENT' AND PG3.TYPE='ORDERSTATUS' AND PG3.CODE=0 AND PM.MITRAID='" & strMitraID & "'"
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
    'Public Function GetCountOrderDesewaFinishMitra(ByVal strMitraID As String) As String
    '    Dim objDB As New DBX
    '    Dim strSQL As String = ""
    '    Dim dt As DataTable = New DataTable
    '    oSC.Open()
    '    strSQL = " SELECT COUNT(*) AS ORDERCOUNT " & _
    '                  " FROM ORDERDESEWA ODS " & _
    '                  " LEFT OUTER JOIN PRODUCTMITRA PM ON ODS.PRODUCTMITRAID = PM.PRODUCTMITRAID " & _
    '                  " LEFT OUTER JOIN APPUSERCLIENT AUC ON ODS.CUSTOMERID = AUC.UID " & _
    '                  " LEFT OUTER JOIN APPUSERPARTNER AUP ON PM.MITRAID = AUP.USERID " & _
    '                  " LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODS.PAYMENTTYPE = PG2.CODE " & _
    '                  " LEFT OUTER JOIN PARAMGLOBAL PG3 ON ODS.STATUS = PG3.CODE " & _
    '                  " WHERE PG2.TYPE='PAYMENT' AND PG3.TYPE='ORDERSTATUS' AND PG3.CODE=1 AND PM.MITRAID='" & strMitraID & "'"
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
    Public Function GetProductListDesewaKendaraan() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT PM.PRODUCTMITRAID " & _
                 " ,PM.PRODUCTMITRACODE " & _
                 " ,PM.MITRAID,AUP.LATITUDE,AUP.LONGITUDE " & _
                 " ,AUP.FULLNAME AS MITRANAME " & _
                 " ,AUP.ADDRESS " & _
                 " ,PM.SERVICETYPEID " & _
                 " ,PM.SERVICETYPEDTLID " & _
                 " ,PM.ARMADATYPEID " & _
                 " ,PM.PRODUCTBRAND " & _
                 " ,PM.PRICE " & _
                 " ,PM.UNITPRICE " & _
                 " ,MU3.MASTERUNITCODE AS UNITPRICEMI " & _
                 " ,MA.MINCAPACITY " & _
                 " ,MU.MASTERUNITCODE " & _
                 " ,MA.MAXCAPACITY " & _
                 " ,MU2.MASTERUNITCODE " & _
                 " ,PM.IMAGEURL,PM.STATUSPRODUCT,PM.STATUSACTIVE,PM.DESCRIPTION " & _
                " ,PM.QTY,(SELECT ISNULL(ODS.QTYORDER,0))QTYORDERSEWA " & _
                ",(PM.QTY-(select ISNULL( (SELECT(ISNULL( ODS.QTYORDER,0)) WHERE ODS.STATUS=11 OR ODS.STATUS=12),0))) AS QTYIDLE " & _
           " FROM PRODUCTMITRA PM " & _
           " INNER JOIN APPUSERPARTNER AUP ON PM.MITRAID = AUP.USERID " & _
           " INNER JOIN SERVICETYPE ST ON PM.SERVICETYPEID = ST.SERVICETYPEID " & _
           " INNER JOIN SERVICETYPEDTL STD ON PM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
           " INNER JOIN MASTERARMADATYPE MAT ON PM.ARMADATYPEID = MAT.ARMADATYPEID " & _
           " INNER JOIN MASTERARMADA MA ON MAT.ARMADATYPEID = MA.ARMADATYPEID " & _
           " INNER JOIN MASTERUNIT MU ON MA.UNITMINCAPACITY = MU.MASTERUNITID " & _
           " INNER JOIN MASTERUNIT MU2 ON MA.UNITMAXCAPACITY = MU2.MASTERUNITID " & _
           " LEFT OUTER JOIN MASTERUNIT MU3 ON PM.UNITPRICE = MU3.MASTERUNITID " & _
           " LEFT OUTER JOIN PARAMGLOBAL PG ON PM.STATUSPRODUCT = PG.CODE " & _
           " LEFT OUTER JOIN ORDERDESEWA ODS ON PM.PRODUCTMITRAID = ODS.PRODUCTMITRAID " & _
           " WHERE PM.DELETESTS=0 AND ST.SERVICETYPEID=3 AND STD.SERVICETYPEDTLID=4 AND PG.TYPE = 'PRODUCTSTATUS'"
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
    Public Function GetProductListDesewaPertanian() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT PM.PRODUCTMITRAID " & _
                 " ,PM.PRODUCTMITRACODE " & _
                 " ,PM.MITRAID,AUP.LATITUDE,AUP.LONGITUDE " & _
                 " ,AUP.USERNAME AS MITRANAME " & _
                 " ,AUP.ADDRESS " & _
                 " ,PM.SERVICETYPEID " & _
                 " ,PM.SERVICETYPEDTLID " & _
                 " ,PM.ARMADATYPEID " & _
                 " ,PM.PRODUCTBRAND " & _
                 " ,PM.PRICE " & _
                 " ,PM.UNITPRICE " & _
                 " ,MU3.MASTERUNITCODE AS UNITPRICEMI " & _
                 " ,MA.MINCAPACITY " & _
                 " ,MU.MASTERUNITCODE " & _
                 " ,MA.MAXCAPACITY " & _
                 " ,MU2.MASTERUNITCODE " & _
                 " ,PM.IMAGEURL,PM.STATUSPRODUCT,PM.STATUSACTIVE,PM.DESCRIPTION " & _
                 " ,PM.QTY,(SELECT ISNULL(ODS.QTYORDER,0))QTYORDERSEWA " & _
                ",(PM.QTY-(select ISNULL( (SELECT(ISNULL( ODS.QTYORDER,0)) WHERE ODS.STATUS=11 OR ODS.STATUS=12),0))) AS QTYIDLE " & _
           " FROM PRODUCTMITRA PM " & _
           " LEFT OUTER JOIN APPUSERPARTNER AUP ON PM.MITRAID = AUP.USERID " & _
           " LEFT OUTER JOIN SERVICETYPE ST ON PM.SERVICETYPEID = ST.SERVICETYPEID " & _
           " LEFT OUTER JOIN SERVICETYPEDTL STD ON PM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
           " LEFT OUTER JOIN MASTERARMADATYPE MAT ON PM.ARMADATYPEID = MAT.ARMADATYPEID " & _
           " LEFT OUTER JOIN MASTERARMADA MA ON MAT.ARMADATYPEID = MA.ARMADATYPEID " & _
           " LEFT OUTER JOIN MASTERUNIT MU ON MA.UNITMINCAPACITY = MU.MASTERUNITID " & _
           " LEFT OUTER JOIN MASTERUNIT MU2 ON MA.UNITMAXCAPACITY = MU2.MASTERUNITID " & _
           " LEFT OUTER JOIN MASTERUNIT MU3 ON PM.UNITPRICE = MU3.MASTERUNITID " & _
           " LEFT OUTER JOIN PARAMGLOBAL PG ON PM.STATUSPRODUCT = PG.CODE " & _
           " LEFT OUTER JOIN ORDERDESEWA ODS ON PM.PRODUCTMITRAID = ODS.PRODUCTMITRAID " & _
           " WHERE PM.DELETESTS=0 AND ST.SERVICETYPEID=3 AND STD.SERVICETYPEDTLID=5 AND PG.TYPE = 'PRODUCTSTATUS'"
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
    Public Function GetProductListDesewaMedis() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT PM.PRODUCTMITRAID " & _
                 " ,PM.PRODUCTMITRACODE " & _
                 " ,PM.MITRAID,AUP.LATITUDE,AUP.LONGITUDE " & _
                 " ,AUP.USERNAME AS MITRANAME " & _
                 " ,AUP.ADDRESS " & _
                 " ,PM.SERVICETYPEID " & _
                 " ,PM.SERVICETYPEDTLID " & _
                 " ,PM.ARMADATYPEID " & _
                 " ,PM.PRODUCTBRAND " & _
                 " ,PM.PRICE " & _
                 " ,PM.UNITPRICE " & _
                 " ,MU3.MASTERUNITCODE AS UNITPRICEMI " & _
                 " ,MA.MINCAPACITY " & _
                 " ,MU.MASTERUNITCODE " & _
                 " ,MA.MAXCAPACITY " & _
                 " ,MU2.MASTERUNITCODE " & _
                 " ,PM.IMAGEURL,PM.STATUSPRODUCT,PM.STATUSACTIVE,PM.DESCRIPTION " & _
                 " ,PM.QTY,(SELECT ISNULL(ODS.QTYORDER,0))QTYORDERSEWA " & _
                ",(PM.QTY-(select ISNULL( (SELECT(ISNULL( ODS.QTYORDER,0)) WHERE ODS.STATUS=11 OR ODS.STATUS=12),0))) AS QTYIDLE " & _
           " FROM PRODUCTMITRA PM " & _
           " LEFT OUTER JOIN APPUSERPARTNER AUP ON PM.MITRAID = AUP.USERID " & _
           " LEFT OUTER JOIN SERVICETYPE ST ON PM.SERVICETYPEID = ST.SERVICETYPEID " & _
           " LEFT OUTER JOIN SERVICETYPEDTL STD ON PM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
           " LEFT OUTER JOIN MASTERARMADATYPE MAT ON PM.ARMADATYPEID = MAT.ARMADATYPEID " & _
           " LEFT OUTER JOIN MASTERARMADA MA ON MAT.ARMADATYPEID = MA.ARMADATYPEID " & _
           " LEFT OUTER JOIN MASTERUNIT MU ON MA.UNITMINCAPACITY = MU.MASTERUNITID " & _
           " LEFT OUTER JOIN MASTERUNIT MU2 ON MA.UNITMAXCAPACITY = MU2.MASTERUNITID " & _
           " LEFT OUTER JOIN MASTERUNIT MU3 ON PM.UNITPRICE = MU3.MASTERUNITID " & _
           " LEFT OUTER JOIN PARAMGLOBAL PG ON PM.STATUSPRODUCT = PG.CODE " & _
           " LEFT OUTER JOIN ORDERDESEWA ODS ON PM.PRODUCTMITRAID = ODS.PRODUCTMITRAID " & _
           " WHERE PM.DELETESTS=0 AND ST.SERVICETYPEID=3 AND STD.SERVICETYPEDTLID=6 AND PG.TYPE = 'PRODUCTSTATUS'"
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
    Public Function GetProductListDesewaLainnya() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT PM.PRODUCTMITRAID " & _
                 " ,PM.PRODUCTMITRACODE " & _
                 " ,PM.MITRAID,AUP.LATITUDE,AUP.LONGITUDE " & _
                 " ,AUP.USERNAME AS MITRANAME " & _
                 " ,AUP.ADDRESS " & _
                 " ,PM.SERVICETYPEID " & _
                 " ,PM.SERVICETYPEDTLID " & _
                 " ,PM.ARMADATYPEID " & _
                 " ,PM.PRODUCTBRAND " & _
                 " ,PM.PRICE " & _
                 " ,PM.UNITPRICE " & _
                 " ,MU3.MASTERUNITCODE AS UNITPRICEMI " & _
                 " ,MA.MINCAPACITY " & _
                 " ,MU.MASTERUNITCODE " & _
                 " ,MA.MAXCAPACITY " & _
                 " ,MU2.MASTERUNITCODE " & _
                 " ,PM.IMAGEURL,PM.STATUSPRODUCT,PM.STATUSACTIVE,PM.DESCRIPTION " & _
                 " ,PM.QTY,(SELECT ISNULL(ODS.QTYORDER,0))QTYORDERSEWA " & _
                ",(PM.QTY-(select ISNULL( (SELECT(ISNULL( ODS.QTYORDER,0)) WHERE ODS.STATUS=11 OR ODS.STATUS=12),0))) AS QTYIDLE " & _
           " FROM PRODUCTMITRA PM " & _
           " LEFT OUTER JOIN APPUSERPARTNER AUP ON PM.MITRAID = AUP.USERID " & _
           " LEFT OUTER JOIN SERVICETYPE ST ON PM.SERVICETYPEID = ST.SERVICETYPEID " & _
           " LEFT OUTER JOIN SERVICETYPEDTL STD ON PM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID " & _
           " LEFT OUTER JOIN MASTERARMADATYPE MAT ON PM.ARMADATYPEID = MAT.ARMADATYPEID " & _
           " LEFT OUTER JOIN MASTERARMADA MA ON MAT.ARMADATYPEID = MA.ARMADATYPEID " & _
           " LEFT OUTER JOIN MASTERUNIT MU ON MA.UNITMINCAPACITY = MU.MASTERUNITID " & _
           " LEFT OUTER JOIN MASTERUNIT MU2 ON MA.UNITMAXCAPACITY = MU2.MASTERUNITID " & _
           " LEFT OUTER JOIN MASTERUNIT MU3 ON PM.UNITPRICE = MU3.MASTERUNITID " & _
           " LEFT OUTER JOIN PARAMGLOBAL PG ON PM.STATUSPRODUCT = PG.CODE " & _
           " LEFT OUTER JOIN ORDERDESEWA ODS ON PM.PRODUCTMITRAID = ODS.PRODUCTMITRAID " & _
           " WHERE PM.DELETESTS=0 AND ST.SERVICETYPEID=3 AND STD.SERVICETYPEDTLID=9 AND PG.TYPE = 'PRODUCTSTATUS'"
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
    Public Function UpdateOrderDesewaKembali(ByVal strOrderDesewaid As Integer, ByVal strProductMitraid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDESEWAUPDATESTS_KEMBALI",
                                                        objDB.MP("@ORDERDESEWAID", Data.SqlDbType.Int, strOrderDesewaid),
                                                        objDB.MP("@PRODUCTMITRAID", Data.SqlDbType.Int, strProductMitraid),
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
End Class

