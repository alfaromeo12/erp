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
Public Class DestarWebServicesCancelOrder
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
    Public Function GetMessageCancelOrder(ByVal strServiceTypeId As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT CANCELORDERID, CANCELORDERCODE, CANCELORDERNAME,CO.SERVICETYPEID FROM CANCELORDER CO" & _
                    " LEFT OUTER JOIN SERVICETYPE ST ON CO.SERVICETYPEID = ST.SERVICETYPEID " & _
                    "WHERE ST.SERVICETYPEID = " & strServiceTypeId & " AND (CO.DELETESTS=0) "
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
    Public Function CancelOrderDebarang(ByVal strOrderCode As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " UPDATE ORDERDEBARANG SET STATUS = 3 WHERE ORDERCODE = '" & strOrderCode & "'"
        Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)
        If da.Fill(dt) = 0 Then
            Return HttpStatusCode.OK
        Else
            Return strReturn
        End If
        oSC.Close()
    End Function
    <WebMethod()>
    Public Function CancelOrderDeCar(ByVal strOrderCode As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " UPDATE ORDERDECAR SET STATUS = 3 WHERE ORDERCODE = '" & strOrderCode & "'"
        Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)
        If da.Fill(dt) = 0 Then
            Return HttpStatusCode.OK
        Else
            Return strReturn
        End If
        oSC.Close()
    End Function
    <WebMethod()>
    Public Function CancelOrderDeJek(ByVal strOrderCode As String) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " UPDATE ORDERDEJEK SET STATUS = 3 WHERE ORDERCODE = '" & strOrderCode & "'"
        Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
        da.Fill(dt)
        Dim strReturn As String = GetJson(dt)
        If da.Fill(dt) = 0 Then
            Return HttpStatusCode.BadRequest
        Else
            Return strReturn
        End If
        oSC.Close()
    End Function
    <WebMethod()>
    Public Function CancelOrderListAdd(ByVal strOrderCode As String, ByVal strCancelOrderID As Integer,
                                       ByVal strServicetypId As Integer) As String
        Dim objDB As New DBX
        Dim intRetval As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        'Dim imgByte As Byte()
        'imgByte = Convert.FromBase64String(strImage)
        Try
            oSQLParam = objDB.ExecSPReturnParam("CANCELORDERLISTADD",
                                                        objDB.MP("@ORDERCODE", Data.SqlDbType.VarChar, strOrderCode),
                                                        objDB.MP("@CANCELORDERID", Data.SqlDbType.Int, strCancelOrderID),
                                                        objDB.MP("@SERVICETYPEID", Data.SqlDbType.Int, strServicetypId),
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