Imports System.Data
Imports System.Data.SqlClient
Imports Microsoft.Reporting.WebForms
Imports System.Collections.Generic
Imports System.IO

Partial Class Repl_ReportSQL
    Inherits System.Web.UI.Page

    'Private m_dataSet As DataSet
    Private dataTable As DataTable
    Private m_rdl As MemoryStream

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReport.Click
        Try
            txtMessage.Visible = False
            Dim strSQL As String = txtSQL.Text
            Dim oSC As New System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("connection").ConnectionString())
            Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
            Dim dss As New System.Data.DataSet()

            da.Fill(dss)
            dataTable = dss.Tables(0)
            da.Dispose()
            Dim allFields As List(Of String) = GetAvailableFields()
            Dim selectedFields As List(Of String) = GetAvailableFields()
            m_rdl = GenerateRdl(allFields, selectedFields)
            If Not (m_rdl Is Nothing) Then
                m_rdl.Dispose()
            End If
            m_rdl = GenerateRdl(allFields, selectedFields)

            ShowReport()

        Catch ex As Exception
            txtMessage.Visible = True
            txtMessage.Text = "ERROR MESSAGE : " & ex.Message
        End Try

    End Sub


    Private Sub ShowReport()
        Me.ReportViewer1.Reset()
        Me.ReportViewer1.LocalReport.LoadReportDefinition(m_rdl)
        'Me.ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("MyData", m_dataSet.Tables(0)))
        Me.ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("MyData", dataTable))

        'Me.ReportViewer1.RefreshReport()
        Me.ReportViewer1.LocalReport.Refresh()
    End Sub

    Private Function GenerateRdl(ByVal allFields As List(Of String), ByVal selectedFields As List(Of String)) As MemoryStream
        Dim ms As New MemoryStream()
        Dim gen As New DynamicTable.RdlGenerator()
        gen.AllFields = allFields
        gen.SelectedFields = selectedFields
        gen.WriteXml(ms)
        ms.Position = 0
        Return ms
    End Function

    Private Function GetAvailableFields() As List(Of String)
        'Dim dataTable As DataTable = m_dataSet.Tables(0)
        Dim availableFields As New List(Of String)
        Dim i As Integer
        For i = 0 To dataTable.Columns.Count - 1
            availableFields.Add(dataTable.Columns(i).ColumnName)
        Next i
        Return availableFields
    End Function


    'Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    '    Dim strSQL As String
    '    strSQL = "SELECT * FROM DEBITURCODE"

    '    'Dim oSC As New System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("connection").ConnectionString())
    '    'Dim oSDA As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '    'Dim oDS As New System.Data.DataSet()

    '    Response.AddHeader("PRAGMA", "NO-CACHE")
    '    Response.ExpiresAbsolute = DateTime.Now.AddMinutes(-1)
    '    Response.Expires = 0
    '    Response.CacheControl = "no-cache"

    '    'oSDA.Fill(oDS, "SQL")
    '    If Not IsPostBack() Then
    '        rptGetDataset(strSQL, ConfigurationManager.ConnectionStrings("connection").ConnectionString())
    '        runRptViewer(strSQL)
    '    End If
    'End Sub

    'Private Function getData(ByVal strSQL As String) As DataTable
    '    Dim oSC As New System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("connection").ConnectionString())
    '    Dim da As New System.Data.SqlClient.SqlDataAdapter(strSQL, oSC)
    '    Dim dss As New System.Data.DataSet()

    '    da.Fill(dss)
    '    getData = dss.Tables(0)
    '    da.Dispose()
    'End Function

    ''    private DataTable getData()
    ''{
    ''    DataSet dss = new DataSet();
    ''    string sql = "";
    ''    sql = "SELECT ID, CLIENT_ID, AGENT_ID FROM TBLMAILDELETED";
    ''    OdbcDataAdapter da = new OdbcDataAdapter(sql, conn);
    ''    da.Fill(dss);
    ''    DataTable dt = dss.Tables[0];
    ''    return dt;
    ''}


    'Private Sub runRptViewer(ByVal strSQL As String)
    '    Me.ReportViewer1.Reset()
    '    Me.ReportViewer1.LocalReport.ReportPath = Server.MapPath("Report.rdlc")

    '    'ReportDataSource(rds = New ReportDataSource("dsNewDataSet_Table", getData()))
    '    Dim rds As New ReportDataSource("dsNewDataSet_Table", getData(strSQL))

    '    Me.ReportViewer1.LocalReport.DataSources.Clear()
    '    Me.ReportViewer1.LocalReport.DataSources.Add(rds)
    '    Me.ReportViewer1.DataBind()
    '    Me.ReportViewer1.LocalReport.Refresh()
    'End Sub


    ''private void runRptViewer()
    '' {
    ''     this.ReportViewer1.Reset();
    ''     this.ReportViewer1.LocalReport.ReportPath = Server.MapPath("Report.rdlc");
    ''     ReportDataSource rds = new ReportDataSource("dsNewDataSet_Table", getData());
    ''     this.ReportViewer1.LocalReport.DataSources.Clear();
    ''     this.ReportViewer1.LocalReport.DataSources.Add(rds);
    ''     this.ReportViewer1.DataBind();
    ''     this.ReportViewer1.LocalReport.Refresh();
    '' }


    'Private Sub rptGetDataset(ByVal strSQL As String, ByVal strConnection As String)
    '    Dim strPathInfo As String = Request.ServerVariables("PATH_INFO")
    '    Dim strWeb As String = Mid(strPathInfo, 1, InStr(2, strPathInfo, "/") - 1)
    '    'Response.Write(strWeb)
    '    'Response.End()

    '    Dim dss As New DataSet
    '    dss.DataSetName = "dsNewDataSet"
    '    Dim da As SqlDataAdapter = New SqlDataAdapter(strSQL, strConnection)
    '    dss.GetXmlSchema()
    '    da.Fill(dss)
    '    dss.WriteXmlSchema(Server.MapPath(strWeb & "/Repl/App_Code/Ds.xsd"))
    '    dss.WriteXml(Server.MapPath(strWeb & "/Repl/App_Code/Ds.xml"))
    'End Sub

    '    private void rptGetDataset()
    '{
    '    DataSet ds = new DataSet();
    '    ds.DataSetName = "dsNewDataSet";
    '    string sql = "";
    '    sql = "SELECT ID, CLIENT_ID, AGENT_ID FROM TBLMAILDELETED";
    '    OdbcDataAdapter da = new OdbcDataAdapter(sql, conn);
    '    ds.GetXmlSchema();
    '    da.Fill(ds);
    '    ds.WriteXmlSchema(_path + "/App_Code/Ds.xsd");
    '    ds.WriteXml(_path + "/App_Code/Ds.xml");
    '}

    'Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    '    'Set the processing mode for the ReportViewer to Local
    '    ReportViewer1.ProcessingMode = ProcessingMode.Local
    '    Dim rep As LocalReport = ReportViewer1.LocalReport
    '    rep.ReportPath = Server.MapPath("Report.rdlc")
    '    Dim ds As DataSet = GetSalesData()
    '    'Create a report data source for the sales order data
    '    Dim dsSalesOrder As New ReportDataSource()
    '    dsSalesOrder.Name = "SalesData_Data"
    '    dsSalesOrder.Value = ds.Tables("SalesData")
    '    rep.DataSources.Add(dsSalesOrder)
    'End Sub

    'Private Function GetSalesData()
    '    Dim ds As New DataSet
    '    Dim sqlSalesData As String = "SELECT * FROM   CITY "
    '    'Using connection As New SqlConnection( _
    '    '              "Data Source=(local)sql2k5; " & _
    '    '              "Initial Catalog=AdventureWorks; " & _
    '    '              "Integrated Security=SSPI")
    '    Dim connection As New System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("connection").ConnectionString())
    '    Dim command As New SqlCommand(sqlSalesData, connection)
    '    Dim salesOrderAdapter As New SqlDataAdapter(command)
    '    salesOrderAdapter.Fill(ds, "SalesData")
    '    salesOrderAdapter.Dispose()
    '    command.Dispose()
    '    Return ds
    'End Function

End Class
