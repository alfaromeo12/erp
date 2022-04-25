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
Public Class DestarWebServiceDepasar
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
    Public Function GetServiceTypeDepasar() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT SERVICETYPEID, SERVICETYPECODE, SERVICETYPENAME,IMAGEURL FROM SERVICETYPE WHERE (DELETESTS = 0) AND SERVICETYPEID=2 "
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
    Public Function GetProductDetail(ByVal strServiceTypeDtlID As String, ByVal strEntityID As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT MP.PRODUCTID,MP.PRODUCTCODE,MP.PRODUCTNAME,MP.ENTITYTYPEID,ET.ENTITYTYPENAME, MP.SERVICETYPEID,ST.SERVICETYPENAME, " & _
                    " MP.SERVICETYPEDTLID, STD.SERVICETYPEDTLNAME, MP.PRICE, MP.DISCOUNT, MP.DISCOUNTPRICE" & _
                    "   ,CONCAT(MP.CAPACITY,MU.MASTERUNITCODE) AS CAPACITY,MP.UNITCAPACITY,MP.INITIALSTOCK,MP.UNITSTOCK " & _
                     "  ,MP.IMAGEURL,MP.DESCRIPTION  " & _
                  " FROM MASTERPRODUCT MP  " & _
                   "LEFT OUTER JOIN ENTITYTYPE ET ON MP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
                  " LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID   " & _
                  " LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID  " & _
                  " LEFT OUTER JOIN MASTERUNIT MU ON MP.UNITCAPACITY= MU.MASTERUNITID  " & _
                  " WHERE MP.SERVICETYPEDTLID = " & strServiceTypeDtlID & " AND MP.ENTITYTYPEID = " & strEntityID & ""
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
    Public Function GetServiceTypeDetail() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "  SELECT STD.SERVICETYPEDTLID,STD.SERVICETYPEDTLCODE,STD.SERVICETYPEDTLNAME  " & _
                           " ,STD.SERVICETYPEID,ST.SERVICETYPENAME,STD.IMAGEURL  " & _
                         " FROM SERVICETYPEDTL STD  " & _
                         " LEFT OUTER JOIN SERVICETYPE ST ON STD.SERVICETYPEID = ST.SERVICETYPEID  " & _
                         " WHERE (STD.DELETESTS = 0) AND STD.SERVICETYPEID = 2"
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
    Public Function AddOrderDePasar(ByVal strCustomerID As Integer, ByVal strEntityTypeId As Integer,
            ByVal strProductId As Integer, ByVal strArmadaid As Integer, ByVal strPaymentType As Integer,
            ByVal strAddressFrom As String, ByVal strAddressTo As String, ByVal strQtyOrder As String,
             ByVal strTotal As String, ByVal strLongAddFrom As String, ByVal strLatAddFrom As String,
             ByVal strLongAddTo As String, ByVal strLatAddTo As String, ByVal strDistance As String,
             ByVal strNotes As String) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDEPASARADD",
                                                        objDB.MP("@CUSTOMERID", Data.SqlDbType.Int, strCustomerID),
                                                        objDB.MP("@ENTITYTYPEID", Data.SqlDbType.Int, strEntityTypeId),
                                                        objDB.MP("@PRODUCTID", Data.SqlDbType.Int, strProductId),
                                                        objDB.MP("@ARMADAID", Data.SqlDbType.Int, strArmadaid),
                                                        objDB.MP("@PAYMENTTYPE", Data.SqlDbType.Int, strPaymentType),
                                                        objDB.MP("@ADDRESSFROM", Data.SqlDbType.VarChar, strAddressFrom),
                                                        objDB.MP("@ADDRESSTO", Data.SqlDbType.VarChar, strAddressTo),
                                                        objDB.MP("@QTYORDER", Data.SqlDbType.NVarChar, strQtyOrder),
                                                        objDB.MP("@TOTAL", Data.SqlDbType.Decimal, strTotal),
                                                        objDB.MP("@LONGITUDEADDFROM", Data.SqlDbType.VarChar, strLongAddFrom),
                                                        objDB.MP("@LATITUDEADDFROM", Data.SqlDbType.VarChar, strLatAddFrom),
                                                        objDB.MP("@LONGITUDEADDTO", Data.SqlDbType.VarChar, strLongAddTo),
                                                        objDB.MP("@LATITUDEADDTO", Data.SqlDbType.VarChar, strLatAddTo),
                                                        objDB.MP("@DISTANCE", Data.SqlDbType.VarChar, strDistance),
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
    Public Function UpdatePesananDePasarFinish(ByVal strOrdeId As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDEPASARUPDATE_FINISH",
                                                       objDB.MP("@ORDERDEPASARID", Data.SqlDbType.Int, strOrdeId),
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
    Public Function AddPesananDepasar(ByVal strCustomerId As Integer, ByVal stProductId As Integer,
                                       ByVal strQty As String, ByVal strTotal As String) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("PESANANDEPASARADD",
                                                        objDB.MP("@CUSTOMERID", Data.SqlDbType.Int, strCustomerId),
                                                        objDB.MP("@PRODUCTID", Data.SqlDbType.Int, stProductId),
                                                        objDB.MP("@QTY", Data.SqlDbType.NVarChar, strQty),
                                                        objDB.MP("@TOTALPRICE", Data.SqlDbType.NVarChar, strTotal),
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
    Public Function UpdatePesananDePasarKirim(ByVal strCustId As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("PESANANDEPASARUPDATE_KIRIM",
                                                       objDB.MP("@CUSTOMERID", Data.SqlDbType.Int, strCustId),
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
    Public Function UpdatePesananDePasarCheckOut(ByVal strCustId As Integer, ByVal strAddress As String,
                                                 ByVal strNotes As String, ByVal strServiceType As Integer,
                                                 ByVal strVendor As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("PESANANDEPASARUPDATE_CHECKOUT",
                                                       objDB.MP("@CUSTOMERID", Data.SqlDbType.Int, strCustId),
                                                       objDB.MP("@SHIPPINGADDRESS", Data.SqlDbType.VarChar, strAddress),
                                                       objDB.MP("@NOTESCUSTOMER", Data.SqlDbType.VarChar, strNotes),
                                                       objDB.MP("@SERVICETYPEID", Data.SqlDbType.Int, strServiceType),
                                                       objDB.MP("@VENDORID", Data.SqlDbType.Int, strVendor),
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
    Public Function UpdatePesananDePasarPembayaran(ByVal strCustId As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("PESANANDEPASARUPDATE_PEMBAYARAN",
                                                       objDB.MP("@CUSTOMERID", Data.SqlDbType.Int, strCustId),
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
    Public Function UpdatePesananDePasarPacking(ByVal strCustId As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("PESANANDEPASARUPDATE_PACKING",
                                                       objDB.MP("@CUSTOMERID", Data.SqlDbType.Int, strCustId),
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
    Public Function UpdatePesananDePasarBatal(ByVal strCustId As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("PESANANDEPASARUPDATE_BATAL",
                                                         objDB.MP("@CUSTOMERID", Data.SqlDbType.Int, strCustId),
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
    Public Function UpdatePesananDePasarPesan(ByVal strCustId As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("PESANANDEPASARUPDATE_PESAN",
                                                        objDB.MP("@CUSTOMERID", Data.SqlDbType.Int, strCustId),
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
    Public Function UpdatePesananDePasarBayar(ByVal strCustId As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("PESANANDEPASARUPDATE_BAYAR",
                                                       objDB.MP("@CUSTOMERID", Data.SqlDbType.Int, strCustId),
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
    Public Function UpdatePesananDePasarTerima(ByVal strCustId As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("PESANANDEPASARUPDATE_TERIMA",
                                                        objDB.MP("@CUSTOMERID", Data.SqlDbType.Int, strCustId),
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
    Public Function UpdateOrderDepasar(ByVal strOrderDepasarid As Integer, ByVal strStatus As Integer, ByVal strMitraid As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("ORDERDEPASARUPDATE",
                                                        objDB.MP("@ORDERDEPASARID", Data.SqlDbType.Int, strOrderDepasarid),
                                                        objDB.MP("@MITRAID", Data.SqlDbType.Int, strMitraid),
                                                        objDB.MP("@STATUS", Data.SqlDbType.Int, strStatus),
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
    Public Function GetKeranjangPesananCustomer(ByVal strCustId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT PD.PESANANDEPASARID,PD.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,PD.CUSTOMERID " & _
                      ",AUC.FULLNAME,PD.QTY,PD.TOTALPRICE,PD.SHIPPINGADDRESS,CONVERT(VARCHAR,CONVERT(date,PD.ORDERDATE,103),103)ORDERDATE " & _
                      ",PD.NOTESCUSTOMER,PD.SERVICETYPEID,ST.SERVICETYPENAME,PD.STATUS,PG.NAME " & _
                      ",PD.VENDORID,VD.VENDORNAME,MP.IMAGEURL  " & _
                  "FROM PESANANDEPASAR PD " & _
                        "LEFT OUTER JOIN MASTERPRODUCT MP ON PD.PRODUCTID =MP.PRODUCTID " & _
                        "LEFT OUTER JOIN APPUSERCLIENT AUC ON PD.CUSTOMERID = AUC.UID " & _
                        "LEFT OUTER JOIN SERVICETYPE ST ON PD.SERVICETYPEID = ST.SERVICETYPEID " & _
                        "RIGHT OUTER JOIN PARAMGLOBAL PG ON PD.STATUS = PG.CODE " & _
                        "LEFT OUTER JOIN VENDOR VD ON PD.VENDORID = VD.VENDORID " & _
                 "WHERE PD.CUSTOMERID = '" & strCustId & "' AND PG.TYPE='STATUSDPSR' AND PG.CODE=1"
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
    Public Function GetKeranjangCustomer(ByVal strCustId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT * FROM PESANANDEPASAR WHERE CUSTOMERID = '" & strCustId & "'"
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
    Public Function GetOrderDePasarPesananCustomer(ByVal strCustId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT TOP(3) ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME " & _
                              ",ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE " & _
                              ",PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL " & _
                              ",ODP.STATUS,PG2.NAME AS STATUSORDER " & _
                              ",CONVERT(VARCHAR,CONVERT(date,ODP.ORDERDATE,103),103)ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE " & _
                              ",ODP.NOTES " & _
                        "FROM ORDERDEPASAR ODP " & _
                            "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID " & _
                            "LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
                            "LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID " & _
                            "LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE " & _
                            "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE " & _
                            "LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID " & _
                         " WHERE PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND (PG2.CODE = 2 OR PG2.CODE=11 OR PG2.CODE=12) AND ODP.CUSTOMERID='" & strCustId & "' ORDER BY ORDERDATE"
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
    Public Function GetOrderDePasarDetail(ByVal strOrderId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME " & _
                              ",ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE " & _
                              ",PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL " & _
                              ",ODP.STATUS,PG2.NAME AS STATUSORDER " & _
                              ",CONVERT(VARCHAR,CONVERT(date,ODP.ORDERDATE,103),103)ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE " & _
                              ",ODP.NOTES " & _
                        "FROM ORDERDEPASAR ODP " & _
                            "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID " & _
                            "LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
                            "LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID " & _
                            "LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE " & _
                            "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE " & _
                            "LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID " & _
                         " WHERE PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND ODP.ORDERDEPASARID='" & strOrderId & "'"
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
    Public Function GetProductDePasarDetail(ByVal strProductId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT MP.PRODUCTID,MP.PRODUCTCODE,MP.PRODUCTNAME,MP.ENTITYTYPEID,ET.ENTITYTYPENAME " & _
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
                        " WHERE (MP.DELETESTS = 0) AND MP.PRODUCTID='" & strProductId & "'"
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
    Public Function GetHistoryOrderDePasarCust(ByVal strCustId As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT TOP(3) ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME " & _
                              ",ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE " & _
                              ",PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL " & _
                              ",ODP.STATUS,PG2.NAME AS STATUSORDER " & _
                              ",CONVERT(VARCHAR,CONVERT(date,ODP.ORDERDATE,103),103)ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE " & _
                              ",ODP.NOTES " & _
                        "FROM ORDERDEPASAR ODP " & _
                            "LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID " & _
                            "LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID " & _
                            "LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID " & _
                            "LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE " & _
                            "LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE " & _
                            "LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID " & _
                         " WHERE PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND PG2.CODE=1 AND ODP.CUSTOMERID='" & strCustId & "' ORDER BY ORDERDATE"
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
    <WebMethod()> _
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function
    <WebMethod()>
    Public Function AddStockProductDepasar(ByVal strProductId As String, ByVal strStockIn As String,
                                           ByVal strStockOut As String, ByVal strReadyStock As String) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("PRODUCTSTOCKADD",
                                                        objDB.MP("@PRODUCTID", Data.SqlDbType.Int, strProductId),
                                                        objDB.MP("@STOCKOUT", Data.SqlDbType.NVarChar, strStockIn),
                                                        objDB.MP("@STOCKIN", Data.SqlDbType.NVarChar, strStockOut),
                                                        objDB.MP("@READYSTOCK", Data.SqlDbType.NVarChar, strReadyStock),
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
    Public Function GetEntityType() As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = "  SELECT ENTITYTYPEID,ENTITYTYPECODE,ENTITYTYPENAME,IMAGEURL FROM ENTITYTYPE"
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