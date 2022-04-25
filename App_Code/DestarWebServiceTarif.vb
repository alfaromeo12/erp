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
Public Class DestarWebServiceTarif
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
    Public Function GetDebarangTarif(ByVal strDistance As String, ByVal strArmadaId As Integer) As String
        'Public Function GetArmadaTypeDeantarBarang(ByVal strServiceTypeDtlId As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT MT.TARIFID,MT.TARIFCODE,MT.ARMADAID,ARM.ARMADACODE,ARM.ARMADANAME,ARM.TARIFMIN" & _
                                       " ,ARM.MINCAPACITY,ARM.UNITMINCAPACITY,ARM.MAXCAPACITY,ARM.UNITMAXCAPACITY,ARM.DISTANCEMIN" & _
                                        " ,ARM.UNITDISTANCEMIN,ARM.DISTANCEMAX,ARM.UNITMAXCAPACITY,ARM.SERVICETYPEDTLID" & _
                                        " ,STD.SERVICETYPEDTLNAME,STD.SERVICETYPEID,ST.SERVICETYPENAME,MU.MASTERUNITCODE AS UNITMINCAP" & _
                                        " ,MT.PARTNERTYPEID,PT.PARTNERTYPENAME,MT.TARIFPERKM,MU2.MASTERUNITCODE AS UNITMAXCAP" & _
                                        " ,MU3.MASTERUNITCODE AS UNITDISTMIN,MU4.MASTERUNITCODE AS UNITDISTMAX," & _
                                         "CONVERT(VARCHAR(MAX),CAST(ARM.TARIFMIN + (MT.TARIFPERKM * " & strDistance & ")  AS MONEY),1)TARIF" & _
                        " FROM MASTERTARIF MT" & _
                                " LEFT OUTER JOIN MASTERARMADA ARM ON MT.ARMADAID = ARM.ARMADAID" & _
                                " LEFT OUTER JOIN SERVICETYPEDTL STD ON ARM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID" & _
                                " LEFT OUTER JOIN SERVICETYPE ST ON STD.SERVICETYPEID = ST.SERVICETYPEID" & _
                                " LEFT OUTER JOIN MASTERUNIT MU ON ARM.UNITMINCAPACITY = MU.MASTERUNITID" & _
                                " LEFT OUTER JOIN MASTERUNIT MU2 ON ARM.UNITMAXCAPACITY = MU2.MASTERUNITID" & _
                                " LEFT OUTER JOIN MASTERUNIT MU3 ON ARM.UNITDISTANCEMIN = MU3.MASTERUNITID" & _
                                " LEFT OUTER JOIN MASTERUNIT MU4 ON ARM.UNITDISTANCEMAX = MU4.MASTERUNITID" & _
                                " LEFT OUTER JOIN PARTNERTYPE PT ON MT.PARTNERTYPEID = PT.PARTNERTYPEID" & _
                       " WHERE MT.DELETESTS = 0 AND MT.ARMADAID = " & strArmadaId & " "
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
    Public Function GetDeOjekTarif() As String
        'Public Function GetArmadaTypeDeantarBarang(ByVal strServiceTypeDtlId As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT MT.TARIFID,MT.TARIFCODE,MT.ARMADAID,ARM.ARMADACODE,ARM.ARMADANAME,ARM.TARIFMIN" & _
                                       " ,ARM.MINCAPACITY,ARM.UNITMINCAPACITY,ARM.MAXCAPACITY,ARM.UNITMAXCAPACITY,ARM.DISTANCEMIN" & _
                                        " ,ARM.UNITDISTANCEMIN,ARM.DISTANCEMAX,ARM.UNITMAXCAPACITY,ARM.SERVICETYPEDTLID" & _
                                        " ,STD.SERVICETYPEDTLNAME,STD.SERVICETYPEID,ST.SERVICETYPENAME,MU.MASTERUNITCODE AS UNITMINCAP" & _
                                        " ,MT.PARTNERTYPEID,PT.PARTNERTYPENAME,MT.TARIFPERKM,MU2.MASTERUNITCODE AS UNITMAXCAP" & _
                                        " ,MU3.MASTERUNITCODE AS UNITDISTMIN,MU4.MASTERUNITCODE AS UNITDISTMAX" & _
                        " FROM MASTERTARIF MT" & _
                                " LEFT OUTER JOIN MASTERARMADA ARM ON MT.ARMADAID = ARM.ARMADAID" & _
                                " LEFT OUTER JOIN SERVICETYPEDTL STD ON ARM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID" & _
                                " LEFT OUTER JOIN SERVICETYPE ST ON STD.SERVICETYPEID = ST.SERVICETYPEID" & _
                                " LEFT OUTER JOIN MASTERUNIT MU ON ARM.UNITMINCAPACITY = MU.MASTERUNITID" & _
                                " LEFT OUTER JOIN MASTERUNIT MU2 ON ARM.UNITMAXCAPACITY = MU2.MASTERUNITID" & _
                                " LEFT OUTER JOIN MASTERUNIT MU3 ON ARM.UNITDISTANCEMIN = MU3.MASTERUNITID" & _
                                " LEFT OUTER JOIN MASTERUNIT MU4 ON ARM.UNITDISTANCEMAX = MU4.MASTERUNITID" & _
                                " LEFT OUTER JOIN PARTNERTYPE PT ON MT.PARTNERTYPEID = PT.PARTNERTYPEID" & _
                       " WHERE MT.DELETESTS = 0 AND MT.ARMADAID = 12"
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
    Public Function GetDeCarTarif() As String
        'Public Function GetArmadaTypeDeantarBarang(ByVal strServiceTypeDtlId As Integer) As String
        Dim objDB As New DBX
        Dim strSQL As String = ""
        Dim dt As DataTable = New DataTable
        oSC.Open()
        strSQL = " SELECT MT.TARIFID,MT.TARIFCODE,MT.ARMADAID,ARM.ARMADACODE,ARM.ARMADANAME,ARM.TARIFMIN" & _
                                       " ,ARM.MINCAPACITY,ARM.UNITMINCAPACITY,ARM.MAXCAPACITY,ARM.UNITMAXCAPACITY,ARM.DISTANCEMIN" & _
                                        " ,ARM.UNITDISTANCEMIN,ARM.DISTANCEMAX,ARM.UNITMAXCAPACITY,ARM.SERVICETYPEDTLID" & _
                                        " ,STD.SERVICETYPEDTLNAME,STD.SERVICETYPEID,ST.SERVICETYPENAME,MU.MASTERUNITCODE AS UNITMINCAP" & _
                                        " ,MT.PARTNERTYPEID,PT.PARTNERTYPENAME,MT.TARIFPERKM,MU2.MASTERUNITCODE AS UNITMAXCAP" & _
                                        " ,MU3.MASTERUNITCODE AS UNITDISTMIN,MU4.MASTERUNITCODE AS UNITDISTMAX" & _
                        " FROM MASTERTARIF MT" & _
                                " LEFT OUTER JOIN MASTERARMADA ARM ON MT.ARMADAID = ARM.ARMADAID" & _
                                " LEFT OUTER JOIN SERVICETYPEDTL STD ON ARM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID" & _
                                " LEFT OUTER JOIN SERVICETYPE ST ON STD.SERVICETYPEID = ST.SERVICETYPEID" & _
                                " LEFT OUTER JOIN MASTERUNIT MU ON ARM.UNITMINCAPACITY = MU.MASTERUNITID" & _
                                " LEFT OUTER JOIN MASTERUNIT MU2 ON ARM.UNITMAXCAPACITY = MU2.MASTERUNITID" & _
                                " LEFT OUTER JOIN MASTERUNIT MU3 ON ARM.UNITDISTANCEMIN = MU3.MASTERUNITID" & _
                                " LEFT OUTER JOIN MASTERUNIT MU4 ON ARM.UNITDISTANCEMAX = MU4.MASTERUNITID" & _
                                " LEFT OUTER JOIN PARTNERTYPE PT ON MT.PARTNERTYPEID = PT.PARTNERTYPEID" & _
                       " WHERE MT.DELETESTS = 0 AND MT.ARMADAID = 10"
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