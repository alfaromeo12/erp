Imports Microsoft.VisualBasic

Public Class Core
    Public Sub BODCustomer(ByVal dtDate As Date, _
        ByVal intUSERID As Integer)
        Dim objDB As New DBX
        Try
            objDB.ExecSP("BODCustomer", _
                    objDB.MP("@THEDATE", Data.SqlDbType.DateTime, dtDate, 10), _
                    objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID, 10) _
                    )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub BODJF(ByVal dtDate As Date, _
        ByVal intUSERID As Integer)
        Dim objDB As New DBX
        Try
            objDB.ExecSP("BODJF", _
                    objDB.MP("@THEDATE", Data.SqlDbType.DateTime, dtDate, 10), _
                    objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID, 10) _
                    )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub BODPaymentFromDeposit(ByVal intUSERID As Integer)
        Dim objDB As New DBX
        Try
            objDB.ExecSP("BODPaymentFromDeposit", _
                    objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID, 10) _
                    )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub EOD(ByVal dtDate As Date, _
        ByVal intUSERID As Integer)
        Dim objDB As New DBX
        Try
            objDB.ExecSP("EOD", _
                    objDB.MP("@THEDATE", Data.SqlDbType.DateTime, dtDate, 10), _
                    objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID, 10) _
                    )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Public Sub ASSETPLEDGEINSTALLBOD(ByVal dtDate As Date, _
        ByVal intUSERID As Integer)
        Dim intRetVal As Integer
        Dim objDB As New DBX
        Try
            intRetVal = objDB.ExecSPReturnInteger("ASSETPLEDGEINSTALLBOD", _
                    objDB.MP("@DueDate", Data.SqlDbType.DateTime, dtDate, 10), _
                    objDB.MP("@UserID", Data.SqlDbType.Int, intUSERID, 10) _
                     )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub EODCOLLECTSTSUpdate(ByVal dtDate As Date, _
        ByVal intUSERID As Integer)
        Dim objDB As New DBX
        Try
            objDB.ExecSP("EODCOLLECTSTSUpdate", _
                    objDB.MP("@APPDATE", Data.SqlDbType.DateTime, dtDate, 10), _
                    objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID, 10) _
                    )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub BODGenerateDueAndPayment(ByVal dtDate As Date, _
        ByVal intUSERID As Integer)
        Dim objDB As New DBX
        Try
            objDB.ExecSP("BODGenerateDueAndPayment", _
                    objDB.MP("@APPDATE", Data.SqlDbType.DateTime, dtDate, 10), _
                    objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID, 10) _
                    )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Public Function WOAdd( _
        ByVal intLOCID As Integer, _
        ByVal dblACCID As Double, _
        ByVal dtWODATE As Date, _
        ByVal intWOSTATUS As Integer, _
        ByVal dblOSPRINCIPAL As Double, _
        ByVal dblOSINTEREST As Double, _
        ByVal strWODESC As String, _
        ByVal intUSERID As Integer, _
        Optional ByRef intWOID As Integer = 0) As Integer


        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("WOAdd", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID, 4), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID, 12), _
                objDB.MP("@WODATE", Data.SqlDbType.DateTime, dtWODATE, 10), _
                objDB.MP("@WOSTATUS", Data.SqlDbType.Int, intWOSTATUS, 8), _
                objDB.MP("@OSPRINCIPAL", Data.SqlDbType.Money, dblOSPRINCIPAL, 20), _
                objDB.MP("@OSINTEREST", Data.SqlDbType.Money, dblOSINTEREST, 20), _
                objDB.MP("@WODESC", Data.SqlDbType.VarChar, strWODESC, 300), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID, 4), _
                objDB.MP("@WOID", Data.SqlDbType.Int, intWOID, 8, Data.ParameterDirection.Output), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            intWOID = oSQLParam("@WOID").Value
            WOAdd = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function WOApproval( _
        ByVal intLOCID As Integer, _
        ByVal dblACCID As Double, _
        ByVal intWOID As Integer, _
        ByVal intWOSTATUS As Integer, _
        ByVal strWODESC As String, _
        ByVal intUSERID As Integer) As Integer


        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("WOApproval", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID, 4), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID, 12), _
                objDB.MP("@WOID", Data.SqlDbType.Int, intWOID, 8), _
                objDB.MP("@WOSTATUS", Data.SqlDbType.Int, intWOSTATUS, 8), _
                objDB.MP("@WODESC", Data.SqlDbType.VarChar, strWODESC, 300), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID, 4), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            WOApproval = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function ACCOUNTDISBURSEPlanPaid( _
        ByVal intLOCID As Integer, _
        ByVal dblACCID As Double, _
        ByVal dtPLANPAIDDATE As Date, _
        ByVal intUSERID As Integer) As Integer


        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("ACCOUNTDISBURSEPlanPaid", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID, 4), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID, 12), _
                objDB.MP("@PLANPAIDDATE", Data.SqlDbType.DateTime, dtPLANPAIDDATE, 10), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID, 4), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            ACCOUNTDISBURSEPlanPaid = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function ACCOUNTDISBURSEApprove( _
         ByVal intLOCID As Integer, _
         ByVal dblACCID As Double, _
         ByVal intTXNTYPE As Integer, _
         ByVal intACCOUNTID As String, _
         ByVal dtPAIDDATE As String, _
         ByVal dblDEALERACCOUNTID As String, _
         ByVal intUSERID As Integer) As Integer


        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("ACCOUNTDISBURSEApprove", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID, 4), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID, 12), _
                objDB.MP("@TXNTYPE", Data.SqlDbType.Int, intTXNTYPE, 4), _
                objDB.MP("@ACCOUNTID", Data.SqlDbType.Int, intACCOUNTID, 4), _
                objDB.MP("@PAIDDATE", Data.SqlDbType.DateTime, dtPAIDDATE), _
                objDB.MP("@DEALERACCOUNTID", Data.SqlDbType.BigInt, dblDEALERACCOUNTID), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID, 4), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            ACCOUNTDISBURSEApprove = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function


    Public Function ACCOUNTDISBURSEReject( _
         ByVal intLOCID As Integer, _
         ByVal dblACCID As Double, _
         ByVal intUSERID As Integer) As Integer


        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("ACCOUNTDISBURSEReject", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID, 4), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID, 12), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID, 4), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            ACCOUNTDISBURSEReject = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Sub ACCOUNTDISBURSEPlanPaidBatch( _
        ByVal dtPLANPAIDDATE As Date, _
        ByVal dtBOOKINGFROM As Date, _
        ByVal dtBOOKINGTO As Date, _
        ByVal intBRANCHID As Integer, _
        ByVal intECEIVEONLY As Integer, _
        ByVal intUSERID As Integer)


        Dim objDB As New DBX
        Try
            objDB.ExecSP("ACCOUNTDISBURSEPlanPaidBatch", _
                objDB.MP("@PLANPAIDDATE", Data.SqlDbType.DateTime, dtPLANPAIDDATE, 10), _
                objDB.MP("@BOOKINGFROM", Data.SqlDbType.DateTime, dtBOOKINGFROM, 10), _
                objDB.MP("@BOOKINGTO", Data.SqlDbType.DateTime, dtBOOKINGTO, 10), _
                objDB.MP("@BRANCHID", Data.SqlDbType.Int, intBRANCHID, 4), _
                objDB.MP("@RECEIVEONLY", Data.SqlDbType.Int, intECEIVEONLY, 4), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID, 4) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Public Sub ACCOUNTDISBURSEApproveBatch( _
        ByVal dtPLANPAIDFROM As Date, _
        ByVal dtPLANPAIDTO As Date, _
        ByVal intBRANCHID As Integer, _
        ByVal intTXNTYPE As Integer, _
        ByVal intACCOUNTID As String, _
        ByVal dtPAIDDATE As String, _
        ByVal intUSERID As Integer)


        Dim objDB As New DBX
        Try
            objDB.ExecSP("ACCOUNTDISBURSEApproveBatch", _
                objDB.MP("@PLANPAIDFROM", Data.SqlDbType.DateTime, dtPLANPAIDFROM, 10), _
                objDB.MP("@PLANPAIDTO", Data.SqlDbType.DateTime, dtPLANPAIDTO, 10), _
                objDB.MP("@BRANCHID", Data.SqlDbType.Int, intBRANCHID, 4), _
                objDB.MP("@TXNTYPE", Data.SqlDbType.Int, intTXNTYPE, 4), _
                objDB.MP("@ACCOUNTID", Data.SqlDbType.Int, intACCOUNTID, 4), _
                objDB.MP("@PAIDDATE", Data.SqlDbType.DateTime, dtPAIDDATE), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID, 4) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub ACCOUNTDISBURSERejectBatch( _
        ByVal dtPLANPAIDFROM As Date, _
        ByVal dtPLANPAIDTO As Date, _
        ByVal intBRANCHID As Integer, _
        ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("ACCOUNTDISBURSERejectBatch", _
                objDB.MP("@PLANPAIDFROM", Data.SqlDbType.DateTime, dtPLANPAIDFROM, 10), _
                objDB.MP("@PLANPAIDTO", Data.SqlDbType.DateTime, dtPLANPAIDTO, 10), _
                objDB.MP("@BRANCHID", Data.SqlDbType.Int, intBRANCHID, 4), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID, 4) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Public Function JFREQUESTACCAdd( _
        ByVal dtREQUESTDATE As Date, _
        ByVal intJFID As Integer, _
        ByVal intLOCID As Integer, _
        ByVal dblACCID As Double, _
        ByVal intINSTALLMENTDAY As String, _
        ByVal intJFREQUESTTYPE As Integer, _
        ByVal intJFTENOR As String, _
        ByVal intJFLOANTYPE As String, _
        ByVal intUSERATE As String, _
        ByVal intUSERID As Integer) As Integer

        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("JFREQUESTACCAdd", _
                objDB.MP("@REQUESTDATE", Data.SqlDbType.DateTime, dtREQUESTDATE, 10), _
                objDB.MP("@JFID", Data.SqlDbType.Int, intJFID, 4), _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID, 4), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID, 8), _
                objDB.MP("@INSTALLMENTDAY", Data.SqlDbType.Int, intINSTALLMENTDAY, 4), _
                objDB.MP("@JFREQUESTTYPE", Data.SqlDbType.Int, intJFREQUESTTYPE, 4), _
                objDB.MP("@JFTENOR", Data.SqlDbType.Int, intJFTENOR, 4), _
                objDB.MP("@JFLOANTYPE", Data.SqlDbType.Int, intJFLOANTYPE, 4), _
                objDB.MP("@USERATE", Data.SqlDbType.Int, intUSERATE, 4), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID, 4), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            JFREQUESTACCAdd = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function



    Public Function JFREQUESTACCApproval( _
        ByVal intREQUESTIDACC As Integer, _
        ByVal intJFREQUESTSTATUS As String, _
        ByVal dtJFBOOKEDDATE As String, _
        ByVal intUSERID As Integer) As Integer
        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("JFREQUESTACCApproval", _
                objDB.MP("@REQUESTIDACC", Data.SqlDbType.BigInt, intREQUESTIDACC, 8), _
                objDB.MP("@JFREQUESTSTATUS", Data.SqlDbType.Int, intJFREQUESTSTATUS, 4), _
                objDB.MP("@JFBOOKEDDATE", Data.SqlDbType.DateTime, dtJFBOOKEDDATE, 10), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID, 4), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            JFREQUESTACCApproval = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function JFREQUESTACCApprovalbyRequestID( _
        ByVal dblREQUESTID As Double, _
        ByVal intJFREQUESTSTATUS As String, _
        ByVal dtJFBOOKEDDATE As String, _
        ByVal intUSERID As Integer) As Integer
        Dim objDB As New DBX
        Try
            objDB.ExecSP("JFREQUESTACCApprovalbyRequestID", _
                objDB.MP("@REQUESTID", Data.SqlDbType.BigInt, dblREQUESTID, 8), _
                objDB.MP("@JFREQUESTSTATUS", Data.SqlDbType.Int, intJFREQUESTSTATUS, 4), _
                objDB.MP("@JFBOOKEDDATE", Data.SqlDbType.DateTime, dtJFBOOKEDDATE, 10), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID, 4) _
            )
            JFREQUESTACCApprovalbyRequestID = 0
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function JFREQUESTACCInstDayUpdate( _
        ByVal intREQUESTIDACC As Double, _
        ByVal intINSTALLMENTDAY As String, _
        ByVal intUSERID As Integer) As Integer
        Dim objDB As New DBX
        Try
            objDB.ExecSP("JFREQUESTACCInstDayUpdate", _
                objDB.MP("@REQUESTIDACC", Data.SqlDbType.BigInt, intREQUESTIDACC, 8), _
                objDB.MP("@INSTALLMENTDAY", Data.SqlDbType.Int, intINSTALLMENTDAY, 4), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID, 4) _
            )
            JFREQUESTACCInstDayUpdate = 0
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function JFREQUESTACCJFBookedDateUpdate( _
        ByVal intREQUESTIDACC As Double, _
        ByVal dtJFBOOKEDDATE As Date, _
        ByVal intUSERID As Integer) As Integer
        Dim objDB As New DBX
        Try
            objDB.ExecSP("JFREQUESTACCJFBookedDateUpdate", _
                objDB.MP("@REQUESTIDACC", Data.SqlDbType.BigInt, intREQUESTIDACC, 8), _
                objDB.MP("@JFBOOKEDDATE", Data.SqlDbType.DateTime, dtJFBOOKEDDATE, 10), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID, 4) _
            )
            JFREQUESTACCJFBookedDateUpdate = 0
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

End Class
