Imports Microsoft.VisualBasic

Public Module Calculate

    Public Function CalcRate( _
        ByVal intTenor As Integer, ByVal dblPayment As Double, _
        ByVal dblPokokPinjaman As Double, ByVal dblResidualValue As Double, _
        ByVal intType As Integer, ByVal dblGuess As Double) As Double

        Dim dblGuessX As Double
        Dim dblERate As Double

        dblGuessX = 1

        On Error GoTo errorHandle
        Do While dblGuessX <= 20 Or dblERate <= 0
            dblERate = Rate(intTenor, dblPayment, dblPokokPinjaman, dblResidualValue, intType, dblGuess)
            If dblERate > 0 Then Exit Do
            dblGuess = dblGuess + 0.1
            dblGuessX = dblGuessX + 1
        Loop
        CalcRate = dblERate
        Exit Function

errorHandle:
        dblGuess = dblGuess + 0.1
        dblGuessX = dblGuessX + 1
        If (dblGuessX > 20) Then
            Exit Function
        End If
        Resume
    End Function

    Public Sub SplitFormatedNumber(ByVal strAccNoX As String, _
        ByRef strBranchID As String, _
        ByRef strNumber As String)

        Dim arrAccNo() As String
        arrAccNo = Split(strAccNoX, ".")
        If UBound(arrAccNo) = 1 Then
            Dim objDB As New DBX
            Try
                Dim oSDR As Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT ISNULL((SELECT BRANCHID FROM BRANCH WHERE BRANCHCODE='" & arrAccNo(0) & "'), 0) BRANCHID")
                If oSDR.Read() Then
                    strBranchID = oSDR("BRANCHID").ToString()
                    If IsNumeric(arrAccNo(1)) Then
                        strNumber = arrAccNo(1)
                    Else
                        strNumber = "0"
                    End If
                End If
                oSDR.Close()
                oSDR = Nothing
            Catch ex As Exception
                Throw
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        Else
            strBranchID = "0"
            'strJFID = "0"
            strNumber = "0"
        End If
    End Sub




End Module
