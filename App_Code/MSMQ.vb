Imports Microsoft.VisualBasic
Imports System.Messaging


Public Class MSMQClass

    Public Sub CreateQ(ByVal strPathQueue As String)
        If Not MessageQueue.Exists(strPathQueue) Then
            MessageQueue.Create(strPathQueue)
        End If
    End Sub

    Public Function GetQ(ByVal queueName As String, _
            Optional ByVal blnTransaction As Boolean = False) As MessageQueue
        Dim msgQ As MessageQueue
        'Create the queue if it does not already exist
        If Not MessageQueue.Exists(queueName) Then
            Try
                'Create the message queue and the MessageQueue object
                msgQ = MessageQueue.Create(queueName, blnTransaction)
            Catch CreateException As Exception
                'Error could occur creating queue if the code does
                'not have sufficient permissions to create queues.
                Throw New Exception("Error Creating Queue", CreateException)
            End Try
        Else
            Try
                msgQ = New MessageQueue(queueName)
            Catch GetException As Exception
                Throw New Exception("Error Getting Queue", GetException)
            End Try
        End If
        Return msgQ
    End Function


End Class
