Imports System
Imports System.Threading
Imports System.Threading.Thread
Imports System.ComponentModel
Imports System.IO.Ports


Public Class SMSCOMMS
    Private WithEvents SMSPort As SerialPort

    Private SMSThread As Thread
    Private ReadThread As Thread
    Shared _Continue As Boolean = False
    Shared _ContSMS As Boolean = False
    Private _Wait As Boolean = False
    Shared _ReadPort As Boolean = False
    Public Event Sending(ByVal Done As Boolean)
    Public Event DataReceived(ByVal Message As String)



    Public Sub New(ByRef COMMPORT As String)
        SMSPort = New SerialPort
        With SMSPort
            .PortName = COMMPORT
            .BaudRate = 9600
            .Parity = Parity.None
            .DataBits = 8
            .StopBits = StopBits.One
            .Handshake = Handshake.RequestToSend
            .DtrEnable = True
            .RtsEnable = True
            .NewLine = vbCrLf
        End With
        ReadThread = New Thread(AddressOf ReadPort)
    End Sub

    Public Sub SendSMS(ByVal CellNumber As String, ByVal SMSMessage As String)
        Dim MyMessage As String = Nothing
        If SMSMessage.Length <= 160 Then
            MyMessage = SMSMessage
        Else
            MyMessage = Mid(SMSMessage, 1, 160)
        End If
        If IsOpen = True Then
            'SMSPort.WriteLine("AT" & vbCrLf)
            'SMSPort.WriteLine("AT+CMGF=1" & vbCrLf)
            'SMSPort.WriteLine("AT+CMGS=""" & CellNumber & """" & vbCrLf)
            'SMSPort.WriteLine("AT" & Chr(13))

            SMSPort.Write("AT" & Chr(13))
            Sleep(100)
            SMSPort.Write("AT+CMGF=1" & Chr(13))
            Sleep(300)
            SMSPort.Write("AT+CMGS=" & Chr(34) & CellNumber & Chr(34) & Chr(13))
            _ContSMS = False
            Sleep(300)
            SMSPort.Write(MyMessage & Chr(26))
            _Continue = False
            RaiseEvent Sending(False)
        End If
    End Sub

    Private Sub ReadPort()
        Dim SerialIn As String = Nothing
        Dim RXBuffer(SMSPort.ReadBufferSize) As Byte
        Dim SMSMessage As String = Nothing
        Dim Strpos As Integer = 0
        Dim TmpStr As String = Nothing

        While SMSPort.IsOpen = True

            If (SMSPort.BytesToRead <> 0) And (
                SMSPort.IsOpen = True) Then
                While SMSPort.BytesToRead <> 0
                    SMSPort.Read(RXBuffer, 0, SMSPort.ReadBufferSize)
                    SerialIn =
                        SerialIn & System.Text.Encoding.ASCII.GetString(
                        RXBuffer)
                    If SerialIn.Contains(">") = True Then
                        _ContSMS = True
                    End If
                    If SerialIn.Contains("+CMGS:") = True Then
                        _Continue = True
                        RaiseEvent Sending(True)
                        _Wait = False
                        SerialIn = String.Empty
                        ReDim RXBuffer(SMSPort.ReadBufferSize)
                    End If
                End While
                RaiseEvent DataReceived(SerialIn)
                SerialIn = String.Empty
                ReDim RXBuffer(SMSPort.ReadBufferSize)
            End If
        End While
    End Sub

    Public ReadOnly Property IsOpen() As Boolean
        Get
            If SMSPort.IsOpen = True Then
                IsOpen = True
            Else
                IsOpen = False
            End If
        End Get
    End Property

    Public Sub Open()
        If IsOpen = False Then
            SMSPort.Open()
            ReadThread.Start()
        End If
    End Sub

    Public Sub Close()
        If IsOpen = True Then
            SMSPort.Close()
        End If
    End Sub
End Class