<%@ WebHandler Language="VB" Class="DisplayImagesVB" %>

Imports System
Imports System.Configuration
Imports System.Web
Imports System.IO
Imports System.Data
Imports System.Data.SqlClient

Public Class DisplayImagesVB : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Dim qtnId As Int32
        If Not context.Request.QueryString("PRODUCTID") Is Nothing Then
            qtnId = Convert.ToInt32(context.Request.QueryString("PRODUCTID"))
        Else
            Throw New ArgumentException("No parameter specified")
        End If
        context.Response.ContentType = "image/jpeg"
        Dim strm As Stream = ShowEmpImage(qtnId)
        Dim buffer As Byte() = New Byte(4095) {}
        Dim byteSeq As Integer = strm.Read(buffer, 0, 4096)
 
        Do While byteSeq > 0
            context.Response.OutputStream.Write(buffer, 0, byteSeq)
            byteSeq = strm.Read(buffer, 0, 4096)
        Loop
        'context.Response.BinaryWrite(buffer);
    End Sub
    Public Function ShowEmpImage(ByVal qtnId As Integer) As Stream
        Dim conn As String = ConfigurationManager.ConnectionStrings("connection").ConnectionString
        Dim connection As SqlConnection = New SqlConnection(conn)
        Dim sql As String = "SELECT IMAGEDEPASAR FROM MASTERPRODUCT WHERE PRODUCTID = @PRODUCTID"
        Dim cmd As SqlCommand = New SqlCommand(sql, connection)
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@PRODUCTID", qtnId)
        connection.Open()
        Dim img As Object = cmd.ExecuteScalar()
        Try
            Return New MemoryStream(CType(img, Byte()))
        Catch
            Return Nothing
        Finally
            connection.Close()
        End Try
    End Function
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class