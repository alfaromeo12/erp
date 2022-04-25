Imports System.IO.Ports
Imports System.Threading.Thread

Imports SMSCOMMS



Partial Class SMS
    Inherits System.Web.UI.Page

    'Dim az As String
    'Dim sib As Integer
    'Dim msn(1000) As String
    'Dim smsPuertoSerial As New System.IO.Ports.SerialPort
    Private Tunda As Integer
    Private WithEvents COMport As New SerialPort

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            getNombrePuertoSerial()
        End If
        'Validate()
    End Sub

    ''PREPARE SERIAL PORT
    'Sub Setup_Puerto_Serie()

    '    Try

    '        With smsPuertoSerial

    '            If .IsOpen Then
    '                .Close()
    '            End If

    '            .PortName = puertos.SelectedValue
    '            .BaudRate = 19200                   '// 19200 baud rate
    '            .DataBits = 8                       '// 8 data bits
    '            .StopBits = IO.Ports.StopBits.One   '// 1 Stop bit
    '            .Parity = IO.Ports.Parity.None      '
    '            .DtrEnable = False
    '            .Handshake = IO.Ports.Handshake.None
    '            .ReadBufferSize = 2048
    '            .WriteBufferSize = 1024
    '            '.ReceivedBytesThreshold = 1
    '            .ReadTimeout = 10000
    '            .WriteTimeout = 10000
    '            .Encoding = System.Text.Encoding.Default
    '            .Open()                              '  ABRE EL PUERTO SERIE
    '            '.Dispose()

    '        End With

    '    Catch ex As Exception
    '        'MsgBox("Error al abrir el puerto serial: " & ex.Message, MsgBoxStyle.Critical)
    '        lblMessage.Visible = True
    '        lblMessage.Text = "Error Setup_Puerto_Serie(): " & ex.Message
    '    End Try
    'End Sub

    'GET PORT NAME
    Sub getNombrePuertoSerial()
        ' muestra COM ports disponibles.
        Dim l As Integer
        Dim ncom As String
        Try

            puertos.Items.Clear()
            For Each sp As String In System.IO.Ports.SerialPort.GetPortNames
                l = sp.Length
                If ((sp(l - 1) >= "0") And (sp(l - 1) <= "9")) Then
                    puertos.Items.Add(sp)

                Else
                    'hay una letra al final del COM
                    ncom = sp.Substring(0, l - 1)
                    puertos.Items.Add(ncom)
                End If
            Next
            If puertos.Items.Count >= 1 Then
                puertos.Text = puertos.SelectedValue(0)
            Else
                puertos.Text = ""
            End If

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "Error getNombrePuertoSerial: " & ex.Message

        End Try
    End Sub

    ''CONNECT PORT
    'Protected Sub btConectar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btConectar.Click
    '    lblMessage.Visible = False
    '    Try
    '        If btConectar.Text = "Connect" Then
    '            btConectar.Text = "Disconnect"
    '            Setup_Puerto_Serie()
    '        Else

    '            If smsPuertoSerial.IsOpen Then
    '                smsPuertoSerial.Close()
    '                smsPuertoSerial.Dispose()
    '            End If
    '            btConectar.Text = "Connect"
    '        End If
    '    Catch ex As Exception
    '        lblMessage.Visible = True
    '        lblMessage.Text = "Error btConectar_Click: " & ex.Message

    '    End Try
    'End Sub

    ''AT TEST
    'Protected Sub btAT_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btAT.Click
    '    lblMessage.Visible = False
    '    sib = 0
    '    Try
    '        smsPuertoSerial.Write("AT" & Chr(13))
    '        respuesta.Text = ""
    '    Catch ex As Exception
    '        lblMessage.Visible = True
    '        lblMessage.Text = "Error btAT_Click: " & ex.Message
    '    End Try
    'End Sub

    ''SERIAL PORT DATA RECEIVED

    'Private Sub smsPuertoSerialRecepcion(ByVal sender As Object, ByVal e As System.IO.Ports.SerialDataReceivedEventArgs)
    '    lblMessage.Visible = False
    '    AddHandler smsPuertoSerial.DataReceived, AddressOf smsPuertoSerialRecepcion


    '    Try

    '        az = smsPuertoSerial.ReadExisting.Trim
    '        msn(sib) = az
    '        Me.respuesta.Text += msn(sib) + "   "

    '        sib = sib + 1

    '    Catch ex As Exception
    '        lblMessage.Visible = True
    '        lblMessage.Text = "Error smsPuertoSerialRecepcion: " & ex.Message

    '    End Try
    'End Sub

    ''DEVICE ID
    'Protected Sub btID_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btID.Click
    '    lblMessage.Visible = False
    '    sib = 0
    '    Try
    '        smsPuertoSerial.Write("AT+CGSN" & Chr(13))
    '        respuesta.Text = ""
    '    Catch ex As Exception
    '        lblMessage.Visible = True
    '        lblMessage.Text = "Error btID_Click: " & ex.Message
    '    End Try
    'End Sub

    ''SET THE PORT FOR SMS MODE
    'Protected Sub btModoSMS_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btModoSMS.Click
    '    lblMessage.Visible = False
    '    sib = 0
    '    Try
    '        smsPuertoSerial.Write("AT+CMGF=1" & Chr(13))
    '        respuesta.Text = ""
    '    Catch ex As Exception
    '        lblMessage.Visible = True
    '        lblMessage.Text = "Error btModoSMS_Click: " & ex.Message
    '    End Try
    'End Sub

    ''TAKE SMS RECIPIENT
    'Protected Sub btEstablNum_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btEstablNum.Click
    '    lblMessage.Visible = False
    '    sib = 0
    '    Try
    '        smsPuertoSerial.Write("AT+CMGS=" & Chr(34) & (Me.numero.Text) & Chr(34) & Chr(13))
    '        Me.respuesta.Text = ""
    '    Catch ex As Exception
    '        lblMessage.Visible = True
    '        lblMessage.Text = "Error btEstablNum_Click: " & ex.Message
    '    End Try
    'End Sub

    ''SEND SMS
    'Protected Sub btenviaSMS_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btenviaSMS.Click
    '    lblMessage.Visible = False
    '    sib = 0
    '    Try
    '        smsPuertoSerial.Write(Me.mensaje.Text & Chr(26))
    '        Me.respuesta.Text = ""
    '        'MsgBox("Pesan dikirim berhasil!")
    '        lblMessage.Visible = True
    '        lblMessage.Text = "Pesan dikirim berhasil!"
    '    Catch ex As Exception
    '        lblMessage.Visible = True
    '        lblMessage.Text = "Error btenviaSMS_Click: " & ex.Message
    '    End Try
    'End Sub

    ''SUB TO CHECK READ SMS
    'Protected Sub btLeidos_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btLeidos.Click
    '    lblMessage.Visible = False
    '    sib = 0
    '    Try
    '        smsPuertoSerial.Write("ATE0" & Chr(13))
    '        smsPuertoSerial.Write("AT+CMGF=1" & Chr(13))
    '        smsPuertoSerial.Write("AT+CMGL=" & Chr(34) & "REC READ" & Chr(34) & Chr(13))
    '        Me.respuesta.Text = ""
    '        'Me.Timer1.Enabled = True
    '        ' MsgBox(sib)
    '    Catch ex As Exception
    '        lblMessage.Visible = True
    '        lblMessage.Text = "Error btLeidos_Click: " & ex.Message
    '    End Try
    'End Sub

    ''SUB TO CHECK UNREAD SMS
    'Protected Sub BtNoLeidos_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtNoLeidos.Click
    '    lblMessage.Visible = False
    '    sib = 0
    '    Try
    '        smsPuertoSerial.Write("ATE0" & Chr(13))
    '        smsPuertoSerial.Write("AT+CMGF=1" & Chr(13))
    '        smsPuertoSerial.Write("AT+CMGL=" & Chr(34) & "REC UNREAD" & Chr(34) & Chr(13))
    '        respuesta.Text = ""
    '    Catch ex As Exception
    '        lblMessage.Visible = True
    '        lblMessage.Text = "Error BtNoLeidos_Click: " & ex.Message
    '    End Try
    'End Sub

    Protected Sub btnSend_Click(sender As Object, e As System.EventArgs) Handles btnSend.Click
        Dim objSMS As SMSCOMMS
        Dim strMessage As String = "", strMessageSend As String = ""

        Try
            strMessage = mensaje.Text
            While strMessage.Length > 0
                If strMessage.Length <= 160 Then
                    strMessageSend = strMessage
                    strMessage = ""
                Else
                    strMessageSend = Mid(strMessage, 1, 160)
                    strMessage = Mid(strMessage, 161, Len(strMessage))
                End If
                objSMS = New SMSCOMMS(puertos.SelectedValue)
                objSMS.Open()
                objSMS.SendSMS(numero.Text, strMessageSend)
                objSMS.Close()
                objSMS = Nothing
            End While
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR : " & ex.Message
        End Try

    End Sub

    'Protected Sub btnSend2_Click(sender As Object, e As System.EventArgs) Handles btnSend2.Click
    '    If COMport.IsOpen Then
    '        COMport.Close()
    '    End If

    '    COMport.PortName = puertos.SelectedValue
    '    COMport.BaudRate = 19200
    '    COMport.WriteTimeout = 2000

    '    Try
    '        COMport.Open()
    '    Catch ex As Exception
    '        lblMessage.Visible = True
    '        lblMessage.Text = "ERROR OPEN PORT : " & ex.Message
    '    End Try

    '    Sleep(300)   '....tunggu 0.3 second 
    '    Tunda = 300
    '    Sleep(Tunda)

    '    'Application.DoEvents()

    '    If COMport.IsOpen Then
    '        Try
    '            Dim x As String = "AT+CMGF=1" & Chr(13)
    '            COMport.Write(x)
    '            Sleep(Tunda)
    '            Dim y As String = "AT+CMGS=" & Chr(34) & numero.Text & Chr(34) & Chr(13)
    '            COMport.Write(y)
    '            Sleep(Tunda)
    '            Dim z As String = mensaje.Text & Chr(26)
    '            COMport.Write(z)
    '            Sleep(Tunda)

    '        Catch ex As Exception
    '            lblMessage.Visible = True
    '            lblMessage.Text = "ERROR SENDING MESSAGE : " & ex.Message
    '        End Try
    '    Else
    '        lblMessage.Visible = True
    '        lblMessage.Text = "PORT CLOSED...!"
    '    End If
    'End Sub

    Protected Sub btnSendQueue_Click(sender As Object, e As System.EventArgs) Handles btnSendQueue.Click

        'INI SEND PAKAI MSMQ
        Dim QUEUE_NAME As String = ".\private$\sms"
        Dim objQueue As New MSMQClass
        Dim msqQ As Messaging.MessageQueue
        Dim msgText As String
        ' Prepare a text message
        'msgText = String.Format("Sample Message Sent At {0}", DateTime.Now())
        Try
            ' Get a MessageQueue object for the queue
            msqQ = objQueue.GetQ(QUEUE_NAME)
            ' Send the message to the queue
            Dim strMessage As String = "", strMessageSend As String = ""
            strMessage = mensaje.Text

            While strMessage.Length > 0
                If strMessage.Length <= 160 Then
                    strMessageSend = strMessage
                    strMessage = ""
                Else
                    strMessageSend = Mid(strMessage, 1, 160)
                    strMessage = Mid(strMessage, 161, Len(strMessage))
                End If
                msgText = puertos.SelectedValue & "|" & numero.Text & "|" & strMessageSend
                msqQ.Send(msgText, numero.Text)
            End While

        Catch eX As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SEND SMS QUEUE : " & eX.Message
        Finally
            objQueue = Nothing
            msqQ = Nothing
        End Try
    End Sub
End Class
