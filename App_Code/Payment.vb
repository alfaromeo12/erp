Imports Microsoft.VisualBasic

Public Class Payment

    Public Sub PAYMENTAccount(ByVal intLOCID As Integer, _
        ByVal dblACCID As Double, _
        ByVal dtTXNDATE As Date, _
        ByVal dtVALUEDATE As Date, _
        ByVal dblAMOUNT As Double, _
        ByVal intTXNTYPE As Integer, _
        ByVal intACCOUNTID As String, _
        ByVal strINVOICENO As String, _
        ByVal intBYDUEDATE As Integer, _
        ByVal dtDUEDATEFILTER As Date, _
        ByVal intUSERID As Integer, _
        Optional ByRef intLOCPAYID As Integer = 0, _
        Optional ByRef dblPAYID As Double = 0, _
        Optional ByRef intCURRENCYIDPAY As Integer = 1, _
        Optional ByRef dblCOLLECTIONFEE As Double = 0, _
        Optional ByRef dblADDITIONALFEE As Double = 0 _
        )



        Dim objDB As New DBX
        Try
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("PAYMENTAccount", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
                objDB.MP("@TXNDATE", Data.SqlDbType.DateTime, dtTXNDATE), _
                objDB.MP("@VALUEDATE", Data.SqlDbType.DateTime, dtVALUEDATE), _
                objDB.MP("@AMOUNT", Data.SqlDbType.Money, dblAMOUNT), _
                objDB.MP("@TXNTYPE", Data.SqlDbType.Int, intTXNTYPE), _
                objDB.MP("@ACCOUNTID", Data.SqlDbType.Int, intACCOUNTID), _
                objDB.MP("@INVOICENO", Data.SqlDbType.VarChar, strINVOICENO), _
                objDB.MP("@BYDUEDATE", Data.SqlDbType.TinyInt, intBYDUEDATE), _
                objDB.MP("@DUEDATEFILTER", Data.SqlDbType.DateTime, dtDUEDATEFILTER), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@LOCIDPAY", Data.SqlDbType.Int, intLOCPAYID, 4, Data.ParameterDirection.Output), _
                objDB.MP("@PAYID", Data.SqlDbType.BigInt, dblPAYID, 20, Data.ParameterDirection.Output), _
                objDB.MP("@CURRENCYIDPAY", Data.SqlDbType.Int, intCURRENCYIDPAY), _
                objDB.MP("@COLLECTIONFEE", Data.SqlDbType.Money, dblCOLLECTIONFEE), _
                objDB.MP("@ADDITIONALFEE", Data.SqlDbType.Money, dblADDITIONALFEE) _
            )
            intLOCPAYID = oSQLParam("@LOCIDPAY").Value
            dblPAYID = oSQLParam("@PAYID").Value


        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub PAYMENTAccountWithInvoice(ByVal intLOCID As Integer, _
        ByVal dblACCID As Double, _
        ByVal dtTXNDATE As Date, _
        ByVal dtVALUEDATE As Date, _
        ByVal dblAMOUNT As Double, _
        ByVal intTXNTYPE As Integer, _
        ByVal intACCOUNTID As String, _
        ByVal strINVOICENO As String, _
        ByVal intBYDUEDATE As Integer, _
        ByVal dtDUEDATEFILTER As Date, _
        ByVal dblINVPAPERID As String, _
        ByVal intUSERID As Integer, _
        Optional ByRef intLOCPAYID As Integer = 0, _
        Optional ByRef dblPAYID As Double = 0, _
        Optional ByRef intCURRENCYIDPAY As Integer = 1, _
        Optional ByRef dblCOLLECTIONFEE As Double = 0, _
        Optional ByRef dblADDITIONALFEE As Double = 0 _
        )


        Dim objDB As New DBX
        Try
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("[PAYMENTAccountWithInvoice]", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
                objDB.MP("@TXNDATE", Data.SqlDbType.DateTime, dtTXNDATE), _
                objDB.MP("@VALUEDATE", Data.SqlDbType.DateTime, dtVALUEDATE), _
                objDB.MP("@AMOUNT", Data.SqlDbType.Money, dblAMOUNT), _
                objDB.MP("@TXNTYPE", Data.SqlDbType.Int, intTXNTYPE), _
                objDB.MP("@ACCOUNTID", Data.SqlDbType.Int, intACCOUNTID), _
                objDB.MP("@INVOICENO", Data.SqlDbType.VarChar, strINVOICENO), _
                objDB.MP("@BYDUEDATE", Data.SqlDbType.TinyInt, intBYDUEDATE), _
                objDB.MP("@DUEDATEFILTER", Data.SqlDbType.DateTime, dtDUEDATEFILTER), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@INVPAPERID", Data.SqlDbType.VarChar, dblINVPAPERID), _
                objDB.MP("@LOCIDPAY", Data.SqlDbType.Int, intLOCPAYID, 4, Data.ParameterDirection.Output), _
                objDB.MP("@PAYID", Data.SqlDbType.BigInt, dblPAYID, 20, Data.ParameterDirection.Output), _
                objDB.MP("@CURRENCYIDPAY", Data.SqlDbType.Int, intCURRENCYIDPAY), _
                objDB.MP("@COLLECTIONFEE", Data.SqlDbType.Money, dblCOLLECTIONFEE), _
                objDB.MP("@ADDITIONALFEE", Data.SqlDbType.Money, dblADDITIONALFEE) _
            )
            intLOCPAYID = oSQLParam("@LOCIDPAY").Value
            dblPAYID = oSQLParam("@PAYID").Value

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Function PaymentACCUnknown(ByVal intLOCIDUN As String, _
        ByVal IntUNKNOWNID As String, _
        ByVal IntALLOCATEID As String, _
        ByVal invPAPERID As String, _
        ByVal intUSERID As Integer) As Integer
        Dim objDB As New DBX
        Dim intRetVal As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try
            oSQLParam = objDB.ExecSPReturnParam("PAYUNKNOWNALLOCATEPosting", _
                     objDB.MP("@LOCIDUN", Data.SqlDbType.Int, intLOCIDUN), _
                     objDB.MP("@UNKNOWNID", Data.SqlDbType.BigInt, IntUNKNOWNID), _
                     objDB.MP("@ALLOCATEID", Data.SqlDbType.Int, IntALLOCATEID), _
                     objDB.MP("@INVPAPERID", Data.SqlDbType.VarChar, invPAPERID), _
                     objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                     objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 10, Data.ParameterDirection.Output) _
                     )

            PaymentACCUnknown = oSQLParam("@RETVAL").Value.ToString()
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Sub PaymentFromCard(ByVal intLOCID As String, _
            ByVal intACCID As String, _
            ByVal dtTXNDATE As String, _
            ByVal dtVALUEDATE As String, _
            ByVal mnAMOUNT As String, _
            ByVal intTXNTYPE As String, _
            ByVal intACCOUNTID As String, _
            ByVal strINVOICENO As String, _
            ByVal intBYDUEDT As String, _
            ByVal dtDUEDATEFILTER As String, _
            ByVal strCARDHOLDER As String, _
            ByVal intCARDTYPE As String, _
            ByVal intBANKID As String, _
            ByVal strCARDNO As String, _
            ByVal dtCARDEXPIRED As String, _
            ByVal mnADDTIONALFEE As String, _
            ByVal dblINVPAPERID As String, _
            ByVal intUSERID As String, _
            Optional ByRef intLOCPAYID As Integer = 0, _
            Optional ByRef dblPAYID As Double = 0, _
            Optional ByRef intCURRENCYIDPAY As Integer = 1, _
            Optional ByRef dblCOLLECTIONFEE As Double = 0 _
            )


        Dim objDB As New DBX
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try
            oSQLParam = objDB.ExecSPReturnParam("PAYMENTAccountFromCard", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, intACCID), _
                objDB.MP("@TXNDATE", Data.SqlDbType.DateTime, dtTXNDATE), _
                objDB.MP("@VALUEDATE", Data.SqlDbType.DateTime, dtVALUEDATE), _
                objDB.MP("@AMOUNT", Data.SqlDbType.Money, mnAMOUNT), _
                objDB.MP("@TXNTYPE", Data.SqlDbType.Int, intTXNTYPE), _
                objDB.MP("@ACCOUNTID", Data.SqlDbType.Int, intACCOUNTID), _
                objDB.MP("@INVOICENO", Data.SqlDbType.VarChar, strINVOICENO), _
                objDB.MP("@BYDUEDATE", Data.SqlDbType.TinyInt, intBYDUEDT), _
                objDB.MP("@DUEDATEFILTER", Data.SqlDbType.DateTime, dtDUEDATEFILTER), _
                objDB.MP("@CARDHOLDER", Data.SqlDbType.VarChar, strCARDHOLDER), _
                objDB.MP("@CARDTYPE", Data.SqlDbType.Int, intCARDTYPE), _
                objDB.MP("@BANKID", Data.SqlDbType.Int, intBANKID), _
                objDB.MP("@CARDNO", Data.SqlDbType.VarChar, strCARDNO), _
                objDB.MP("@CARDEXPIRED", Data.SqlDbType.DateTime, dtCARDEXPIRED), _
                objDB.MP("@ADDTIONALFEE", Data.SqlDbType.Money, mnADDTIONALFEE), _
                objDB.MP("@INVPAPERID", Data.SqlDbType.VarChar, dblINVPAPERID), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@LOCIDPAY", Data.SqlDbType.Int, intLOCPAYID, 4, Data.ParameterDirection.Output), _
                objDB.MP("@PAYID", Data.SqlDbType.BigInt, dblPAYID, 15, Data.ParameterDirection.Output), _
                objDB.MP("@CURRENCYIDPAY", Data.SqlDbType.Int, intCURRENCYIDPAY), _
                objDB.MP("@COLLECTIONFEE", Data.SqlDbType.Money, dblCOLLECTIONFEE) _
                )
            intLOCPAYID = oSQLParam("@LOCIDPAY").Value
            dblPAYID = oSQLParam("@PAYID").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Function PAYMENTFromCollector(ByVal intLOCIDCOLL As String, _
        ByVal intCOLLECTID As String, _
        ByVal intTXNTYPE As String, _
        ByVal dtVALUEDATE As String, _
        ByVal mnAMOUNT As String, _
        ByVal intACCOUNTID As String, _
        ByVal strINVOICENO As String, _
        ByVal mnCOLLECTIONFEE As String, _
        ByVal strCARDHOLDER As String, _
        ByVal intCARDTYPE As String, _
        ByVal intBANKID As String, _
        ByVal strCARDNO As String, _
        ByVal dtCARDEXPIRED As String, _
        ByVal mnADDITIONALFEE As String, _
        ByVal dblINVPAPERID As String, _
        ByVal intUSERID As String, _
        Optional ByRef intLOCPAYID As Integer = 0, _
        Optional ByRef dblPAYID As Integer = 0, _
        Optional ByRef intCURRENCYPAYID As Integer = 1 _
       ) As Integer

        Dim objDB As New DBX
        Dim intRetVal As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try
            oSQLParam = objDB.ExecSPReturnParam("PAYMENTFromCollector", _
                        objDB.MP("@LOCIDCOLL", Data.SqlDbType.Int, intLOCIDCOLL), _
                        objDB.MP("@COLLECTID", Data.SqlDbType.BigInt, intCOLLECTID), _
                        objDB.MP("@TXNTYPE", Data.SqlDbType.Int, intTXNTYPE), _
                        objDB.MP("@VALUEDATE", Data.SqlDbType.DateTime, dtVALUEDATE), _
                        objDB.MP("@AMOUNT", Data.SqlDbType.Money, mnAMOUNT), _
                        objDB.MP("@ACCOUNTID", Data.SqlDbType.Int, intACCOUNTID), _
                        objDB.MP("@INVOICENO", Data.SqlDbType.VarChar, strINVOICENO), _
                        objDB.MP("@COLLECTIONFEE", Data.SqlDbType.Money, mnCOLLECTIONFEE), _
                        objDB.MP("@CARDHOLDER", Data.SqlDbType.VarChar, strCARDHOLDER), _
                        objDB.MP("@CARDTYPE", Data.SqlDbType.TinyInt, intCARDTYPE), _
                        objDB.MP("@BANKID", Data.SqlDbType.Int, intBANKID), _
                        objDB.MP("@CARDNO", Data.SqlDbType.VarChar, strCARDNO), _
                        objDB.MP("@CARDEXPIRED", Data.SqlDbType.VarChar, dtCARDEXPIRED), _
                        objDB.MP("@ADDITONALFEE", Data.SqlDbType.Money, mnADDITIONALFEE), _
                        objDB.MP("@INVPAPERID", Data.SqlDbType.VarChar, dblINVPAPERID), _
                        objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                        objDB.MP("@LOCIDPAY", Data.SqlDbType.Int, intLOCPAYID, 8, Data.ParameterDirection.Output), _
                        objDB.MP("@PAYID", Data.SqlDbType.BigInt, dblPAYID, 12, Data.ParameterDirection.Output), _
                        objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output), _
                        objDB.MP("@CURRENCYPAYID", Data.SqlDbType.Int, intCURRENCYPAYID) _
                     )
            intLOCPAYID = oSQLParam("@LOCIDPAY").Value
            dblPAYID = oSQLParam("@PAYID").Value
            PAYMENTFromCollector = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function PAYMENTReversal(ByVal intLOCIDPAY As Integer, _
        ByVal dblPAYID As Double, _
        ByVal intUSERID As Integer) As String
        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("PAYMENTReversal", _
                objDB.MP("@LOCIDPAY", Data.SqlDbType.Int, intLOCIDPAY), _
                objDB.MP("@PAYID", Data.SqlDbType.BigInt, dblPAYID), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            PAYMENTReversal = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Sub PAYMENTReversalPerCompany( _
        ByVal intBRANCHID As Integer, _
        ByVal dtTXNDATE As Date, _
        ByVal intPAYMENTTYPE As Integer, _
        ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            'objDB.ExecSP("PAYMENTReversalPerCompany", _
            objDB.ExecSPNoTxn("PAYMENTReversalPerCompany", _
                objDB.MP("@BRANCHID", Data.SqlDbType.Int, intBRANCHID), _
                objDB.MP("@TXNDATE", Data.SqlDbType.DateTime, dtTXNDATE), _
                objDB.MP("@PAYMENTTYPE", Data.SqlDbType.Int, intPAYMENTTYPE), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub PAYMENTAccPlanPaid(ByVal intLOCID As Integer, _
        ByVal dblACCID As Double, _
        ByVal intPLANPAID As Integer, _
        ByVal intUSERID As Integer)


        Dim objDB As New DBX
        Try

            objDB.ExecSP("PAYMENTAccPlanPaid", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
                objDB.MP("@PLAINPAID", Data.SqlDbType.Int, intPLANPAID), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub PAYMENTCompany(ByVal intBRANCHID As Integer, _
        ByVal dtTXNDATE As Date, _
        ByVal dtVALUEDATE As Date, _
        ByVal dtDUEDATE As Date, _
        ByVal intTXNTYPE As Integer, _
        ByVal intACCOUNTID As String, _
        ByVal intUSERID As Integer, _
        Optional ByRef intCURRENCYIDPAY As Integer = 1 _
        )

        Dim objDB As New DBX
        Try
            'objDB.ExecSP("PAYMENTCompany", _
            objDB.ExecSPNoTxn("PAYMENTCompany", _
                objDB.MP("@BRANCHID", Data.SqlDbType.Int, intBRANCHID), _
                objDB.MP("@TXNDATE", Data.SqlDbType.DateTime, dtTXNDATE), _
                objDB.MP("@VALUEDATE", Data.SqlDbType.DateTime, dtVALUEDATE), _
                objDB.MP("@DUEDATE", Data.SqlDbType.DateTime, dtDUEDATE), _
                objDB.MP("@TXNTYPE", Data.SqlDbType.Int, intTXNTYPE), _
                objDB.MP("@ACCOUNTID", Data.SqlDbType.Int, intACCOUNTID), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@CURRENCYIDPAY", Data.SqlDbType.Int, intCURRENCYIDPAY) _
            )

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub



    Public Function WAIVEAdd(ByVal intLOCID As Integer, _
        ByVal dblACCID As Double, _
        ByVal dtWAIVEDATE As Date, _
        ByVal dtDUEDATE As Date, _
        ByVal dblWAIVEAMOUNT As Double, _
        ByVal intWAIVESTATUS As Integer, _
        ByVal strREMARK As String, _
        ByVal intUSERID As Integer, _
        Optional ByRef intWAIVEID As Integer = 0) As Integer


        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("WAIVEAdd", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
                objDB.MP("@WAIVEDATE", Data.SqlDbType.DateTime, dtWAIVEDATE), _
                objDB.MP("@DUEDATE", Data.SqlDbType.DateTime, dtDUEDATE), _
                objDB.MP("@WAIVEAMOUNT", Data.SqlDbType.Money, dblWAIVEAMOUNT), _
                objDB.MP("@WAIVESTATUS", Data.SqlDbType.Int, intWAIVESTATUS), _
                objDB.MP("@REMARK", Data.SqlDbType.VarChar, strREMARK), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@WAIVEID", Data.SqlDbType.Int, intWAIVEID, 8, Data.ParameterDirection.Output), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            intWAIVEID = oSQLParam("@WAIVEID").Value
            WAIVEAdd = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function


    Public Sub WAIVECompanyAdd( _
        ByVal intBRANCHID As Integer, _
        ByVal dtBOOKINGDATE As Date, _
        ByVal dblAMOUNT As Double, _
        ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("WAIVECompanyAdd", _
                objDB.MP("@BRANCHID", Data.SqlDbType.Int, intBRANCHID), _
                objDB.MP("@BOOKINGDATE", Data.SqlDbType.DateTime, dtBOOKINGDATE), _
                objDB.MP("@AMOUNT", Data.SqlDbType.Money, dblAMOUNT), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Function WAIVEApprove( _
        ByVal intLOCID As Integer, _
        ByVal dblACCID As Double, _
        ByVal intWAIVEID As Integer, _
        ByVal strREMARK As String, _
        ByVal intUSERID As Integer) As Integer

        Dim objDB As New DBX
        Try
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            Dim intRetVal As Integer = 0
            oSQLParam = objDB.ExecSPReturnParam("WAIVEApprove", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
                objDB.MP("@WAIVEID", Data.SqlDbType.Int, intWAIVEID), _
                objDB.MP("@REMARK", Data.SqlDbType.VarChar, strREMARK), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            WAIVEApprove = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function WAIVEReject( _
        ByVal intLOCID As Integer, _
        ByVal dblACCID As Double, _
        ByVal intWAIVEID As Integer, _
        ByVal strREMARK As String, _
        ByVal intUSERID As Integer) As Integer

        Dim objDB As New DBX
        Try
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            Dim intRetVal As Integer = 0
            oSQLParam = objDB.ExecSPReturnParam("WAIVEReject", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
                objDB.MP("@WAIVEID", Data.SqlDbType.Int, intWAIVEID), _
                objDB.MP("@REMARK", Data.SqlDbType.VarChar, strREMARK), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            WAIVEReject = oSQLParam("@RETVAL").Value

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Sub WAIVECompanyApprove( _
        ByVal intBRANCHID As Integer, _
        ByVal dtBOOKINGDATE As Date, _
        ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("WAIVECompanyApprove", _
                objDB.MP("@BRANCHID", Data.SqlDbType.Int, intBRANCHID), _
                objDB.MP("@BOOKINGDATE", Data.SqlDbType.DateTime, dtBOOKINGDATE), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub WAIVECompanyReject( _
        ByVal intBRANCHID As Integer, _
        ByVal dtBOOKINGDATE As Date, _
        ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("WAIVECompanyReject", _
                objDB.MP("@BRANCHID", Data.SqlDbType.Int, intBRANCHID), _
                objDB.MP("@BOOKINGDATE", Data.SqlDbType.DateTime, dtBOOKINGDATE), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Function ETAdd( _
        ByVal intLOCID As Integer, _
        ByVal dblACCID As Double, _
        ByVal dtETDATE As Date, _
        ByVal dtETTXNDATE As Date, _
        ByVal intETSTATUS As Integer, _
        ByVal dblETPENALTY As Double, _
        ByVal dblETADMIN As Double, _
        ByVal dblOSPRINCIPAL As Double, _
        ByVal dblOSINTEREST As Double, _
        ByVal dblETINTEREST As Double, _
        ByVal dblETOTHERFEE As Double, _
        ByVal dtNEXTDUEDATE As Date, _
        ByVal strETDESC As String, _
        ByVal intUSERID As Integer, _
        Optional ByRef intETID As Integer = 0, _
        Optional ByVal intETCACLTYPE As Integer = 1 _
        ) As Integer

        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("ETAdd", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
                objDB.MP("@ETDATE", Data.SqlDbType.DateTime, dtETDATE), _
                objDB.MP("@ETTXNDATE", Data.SqlDbType.DateTime, dtETTXNDATE), _
                objDB.MP("@ETSTATUS", Data.SqlDbType.Int, intETSTATUS), _
                objDB.MP("@ETPENALTY", Data.SqlDbType.Money, dblETPENALTY), _
                objDB.MP("@ETADMIN", Data.SqlDbType.Money, dblETADMIN), _
                objDB.MP("@OSPRINCIPAL", Data.SqlDbType.Money, dblOSPRINCIPAL), _
                objDB.MP("@OSINTEREST", Data.SqlDbType.Money, dblOSINTEREST), _
                objDB.MP("@ETINTEREST", Data.SqlDbType.Money, dblETINTEREST), _
                objDB.MP("@ETOTHERFEE", Data.SqlDbType.Money, dblETOTHERFEE), _
                objDB.MP("@NEXTDUEDATE", Data.SqlDbType.DateTime, dtNEXTDUEDATE), _
                objDB.MP("@ETDESC", Data.SqlDbType.VarChar, strETDESC), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@ETID", Data.SqlDbType.Int, intETID, 8, Data.ParameterDirection.Output), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output), _
                objDB.MP("@ETCACLTYPE", Data.SqlDbType.Int, intETCACLTYPE) _
            )
            intETID = oSQLParam("@ETID").Value
            ETAdd = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function ETApproval( _
        ByVal intLOCID As Integer, _
        ByVal dblACCID As Double, _
        ByVal intETID As Integer, _
        ByVal intETSTATUS As Integer, _
        ByVal intUSERID As Integer) As Integer


        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("ETApproval", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
                objDB.MP("@ETID", Data.SqlDbType.Int, intETID), _
                objDB.MP("@ETSTATUS", Data.SqlDbType.Int, intETSTATUS), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            ETApproval = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function ETWaiveUpdate( _
        ByVal intLOCID As Integer, _
        ByVal dblACCID As Double, _
        ByVal intETID As Integer, _
        ByVal dblETPENALTYWAIVE As Double, _
        ByVal dblETADMINWAIVE As Double, _
        ByVal dblETINTERESTWAIVE As Double, _
        ByVal dblOSPRINCIPALWAIVE As Double, _
        ByVal dblPRINCIPALDUEWAIVE As Double, _
        ByVal dblINTERESTDUEWAIVE As Double, _
        ByVal dblPENALTYDUEWAIVE As Double, _
        ByVal dblINSTDIFFDUEWAIVE As Double, _
        ByVal dblOSINTERESTWAIVE As Double, _
        ByVal intUSERID As Integer) As Integer


        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("ETWaiveUpdate", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
                objDB.MP("@ETID", Data.SqlDbType.Int, intETID), _
                objDB.MP("@ETPENALTYWAIVE", Data.SqlDbType.Money, dblETPENALTYWAIVE), _
                objDB.MP("@ETADMINWAIVE", Data.SqlDbType.Money, dblETADMINWAIVE), _
                objDB.MP("@ETINTERESTWAIVE", Data.SqlDbType.Money, dblETINTERESTWAIVE), _
                objDB.MP("@OSPRINCIPALWAIVE", Data.SqlDbType.Money, dblOSPRINCIPALWAIVE), _
                objDB.MP("@PRINCIPALDUEWAIVE", Data.SqlDbType.Money, dblPRINCIPALDUEWAIVE), _
                objDB.MP("@INTERESTDUEWAIVE", Data.SqlDbType.Money, dblINTERESTDUEWAIVE), _
                objDB.MP("@PENALTYDUEWAIVE", Data.SqlDbType.Money, dblPENALTYDUEWAIVE), _
                objDB.MP("@INSTDIFFDUEWAIVE", Data.SqlDbType.Money, dblINSTDIFFDUEWAIVE), _
                objDB.MP("@OSINTERESTWAIVE", Data.SqlDbType.Money, dblOSINTERESTWAIVE), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            ETWaiveUpdate = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function ETRejectAfterApp( _
        ByVal intLOCID As Integer, _
        ByVal dblACCID As Double, _
        ByVal intETID As Integer, _
        ByVal intUSERID As Integer) As Integer

        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("ETRejectAfterApp", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
                objDB.MP("@ETID", Data.SqlDbType.Int, intETID), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            ETRejectAfterApp = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function ETPayment(ByVal intLOCID As Integer, _
        ByVal dblACCID As Double, _
        ByVal intETID As Integer, _
        ByVal dblAMOUNT As Double, _
        ByVal intTXNTYPE As Integer, _
        ByVal intACCOUNTID As String, _
        ByVal strINVOICENO As String, _
        ByVal intUSERID As Integer, _
        Optional ByRef intLOCPAYID As Integer = 0, _
        Optional ByRef dblPAYID As Double = 0, _
        Optional ByRef strCARDHOLDER As String = "", _
        Optional ByRef intCARDTYPE As String = "", _
        Optional ByRef intBANKID As String = "", _
        Optional ByRef strCARDNO As String = "", _
        Optional ByRef dtCARDEXPIRED As String = "", _
        Optional ByRef mnADDTIONALFEE As String = "0", _
        Optional ByRef dblINVPAPERID As String = "", _
        Optional ByRef intCURRENCYIDPAY As String = "1", _
        Optional ByRef mnCOLLECTIONFEE As String = "0", _
        Optional ByRef dtPaidDate As String = "" _
        ) As Integer



        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("ETPayment", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
                objDB.MP("@ETID", Data.SqlDbType.Int, intETID), _
                objDB.MP("@AMOUNT", Data.SqlDbType.Money, dblAMOUNT), _
                objDB.MP("@TXNTYPE", Data.SqlDbType.Int, intTXNTYPE), _
                objDB.MP("@ACCOUNTID", Data.SqlDbType.Int, intACCOUNTID), _
                objDB.MP("@INVOICENO", Data.SqlDbType.VarChar, strINVOICENO), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output), _
                objDB.MP("@LOCIDPAY", Data.SqlDbType.Int, intLOCPAYID, 4, Data.ParameterDirection.Output), _
                objDB.MP("@PAYID", Data.SqlDbType.BigInt, dblPAYID, 20, Data.ParameterDirection.Output), _
                objDB.MP("@CARDHOLDER", Data.SqlDbType.VarChar, strCARDHOLDER), _
                objDB.MP("@CARDTYPE", Data.SqlDbType.Int, intCARDTYPE), _
                objDB.MP("@BANKID", Data.SqlDbType.Int, intBANKID), _
                objDB.MP("@CARDNO", Data.SqlDbType.VarChar, strCARDNO), _
                objDB.MP("@CARDEXPIRED", Data.SqlDbType.DateTime, dtCARDEXPIRED), _
                objDB.MP("@ADDTIONALFEE", Data.SqlDbType.Money, mnADDTIONALFEE), _
                objDB.MP("@INVPAPERID", Data.SqlDbType.VarChar, dblINVPAPERID), _
                objDB.MP("@CURRENCYIDPAY", Data.SqlDbType.Int, intCURRENCYIDPAY), _
                objDB.MP("@COLLECTIONFEE", Data.SqlDbType.Money, mnCOLLECTIONFEE), _
                objDB.MP("@PAIDDATE", Data.SqlDbType.DateTime, dtPaidDate) _
            )


            intLOCID = oSQLParam("@LOCIDPAY").Value
            dblPAYID = oSQLParam("@PAYID").Value
            ETPayment = oSQLParam("@RETVAL").Value

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function


    Public Sub PAYMENTTPPaid( _
        ByVal intTPID As Integer, _
        ByVal intJFID As Integer, _
        ByVal intACCPAIDONLY As Integer, _
        ByVal dtDUEDATE As Date, _
        ByVal intPAYMENTTYPETP As Integer, _
        ByVal intTXNTYPETP As Integer, _
        ByVal intACCOUNTIDTP As String, _
        ByVal dtPAIDDATETP As Date, _
        ByVal intUSERID As Integer)


        Dim objDB As New DBX
        Try

            objDB.ExecSP("PAYMENTTPPaid", _
                objDB.MP("@TPID", Data.SqlDbType.Int, intTPID), _
                objDB.MP("@JFID", Data.SqlDbType.Int, intJFID), _
                objDB.MP("@ACCPAIDONLY", Data.SqlDbType.Int, intACCPAIDONLY), _
                objDB.MP("@DUEDATE", Data.SqlDbType.DateTime, dtDUEDATE), _
                objDB.MP("@PAYMENTTYPETP", Data.SqlDbType.Int, intPAYMENTTYPETP), _
                objDB.MP("@TXNTYPETP", Data.SqlDbType.Int, intTXNTYPETP), _
                objDB.MP("@ACCOUNTIDTP", Data.SqlDbType.Int, intACCOUNTIDTP), _
                objDB.MP("@PAIDDATETP", Data.SqlDbType.DateTime, dtPAIDDATETP), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Public Function PAYMENTTPReverse( _
        ByVal intPAYIDTP As Integer, _
        ByVal intUSERID As Integer) As Integer


        Dim objDB As New DBX
        Try

            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("PAYMENTTPReverse", _
                objDB.MP("@PAYIDTP", Data.SqlDbType.Int, intPAYIDTP), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            PAYMENTTPReverse = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function


    Public Sub PAYMENTJFInput( _
        ByVal dtValueDate As Date, _
        ByVal intJFID As Integer, _
        ByVal intDUE As Integer, _
        ByVal dtUNTILDUEDATE As Date, _
        ByVal intCUSTPAID As Integer, _
        ByVal intUSERID As Integer)
        Dim objDB As New DBX
        Try
            objDB.ExecSP("PAYMENTJFInput", _
                objDB.MP("@ValueDate", Data.SqlDbType.DateTime, dtValueDate), _
                objDB.MP("@JFID", Data.SqlDbType.Int, intJFID), _
                objDB.MP("@DUE", Data.SqlDbType.Int, intDUE), _
                objDB.MP("@UNTILDUEDATE", Data.SqlDbType.DateTime, dtUNTILDUEDATE), _
                objDB.MP("@CUSTPAID", Data.SqlDbType.TinyInt, intCUSTPAID), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub PAYMENTJFRejectByJFID( _
        ByVal intJFID As Integer, _
        ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("PAYMENTJFRejectByJFID", _
                objDB.MP("@JFID", Data.SqlDbType.Int, intJFID), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Public Sub PAYMENTJFApproveByJFID( _
        ByVal intJFID As Integer, _
        ByVal dtVALUEDATE As Date, _
        ByVal intACCOUNTID As Integer, _
        ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            'objDB.ExecSP("PAYMENTJFApproveByJFID", _
            objDB.ExecSPNoTxn("PAYMENTJFApproveByJFID", _
                objDB.MP("@JFID", Data.SqlDbType.Int, intJFID), _
                objDB.MP("@VALUEDATE", Data.SqlDbType.DateTime, dtVALUEDATE), _
                objDB.MP("@ACCOUNTID", Data.SqlDbType.Int, intACCOUNTID), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Function PAYMENTJFReversal( _
        ByVal dblPAYIDJF As Double, _
        ByVal intUSERID As Integer) As String
        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("PAYMENTJFReversal", _
                objDB.MP("@PAYIDJF", Data.SqlDbType.BigInt, dblPAYIDJF), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            PAYMENTJFReversal = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function


    Public Function ETJFAdd( _
        ByVal dblACCIDJF As Double, _
        ByVal dtJFETDATE As Date, _
        ByVal dtJFETTXNDATE As Date, _
        ByVal intJFETSTATUS As Integer, _
        ByVal dblJFETPENALTY As Double, _
        ByVal dblJFETADMIN As Double, _
        ByVal dblJFOSPRINCIPAL As Double, _
        ByVal dblJFOSINTEREST As Double, _
        ByVal dblJFETINTEREST As Double, _
        ByVal dblJFETOTHERFEE As Double, _
        ByVal dtJFNEXTDUEDATE As Date, _
        ByVal strJFETDESC As String, _
        ByVal intUSERID As Integer, _
        Optional ByRef intJFETID As Integer = 0) As Integer


        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("ETJFAdd", _
                objDB.MP("@ACCIDJF", Data.SqlDbType.BigInt, dblACCIDJF), _
                objDB.MP("@JFETDATE", Data.SqlDbType.DateTime, dtJFETDATE), _
                objDB.MP("@JFETTXNDATE", Data.SqlDbType.DateTime, dtJFETTXNDATE), _
                objDB.MP("@JFETSTATUS", Data.SqlDbType.Int, intJFETSTATUS), _
                objDB.MP("@JFETPENALTY", Data.SqlDbType.Money, dblJFETPENALTY), _
                objDB.MP("@JFETADMIN", Data.SqlDbType.Money, dblJFETADMIN), _
                objDB.MP("@JFOSPRINCIPAL", Data.SqlDbType.Money, dblJFOSPRINCIPAL), _
                objDB.MP("@JFOSINTEREST", Data.SqlDbType.Money, dblJFOSINTEREST), _
                objDB.MP("@JFETINTEREST", Data.SqlDbType.Money, dblJFETINTEREST), _
                objDB.MP("@JFETOTHERFEE", Data.SqlDbType.Money, dblJFETOTHERFEE), _
                objDB.MP("@JFNEXTDUEDATE", Data.SqlDbType.DateTime, dtJFNEXTDUEDATE), _
                objDB.MP("@JFETDESC", Data.SqlDbType.VarChar, strJFETDESC), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@JFETID", Data.SqlDbType.Int, intJFETID, 8, Data.ParameterDirection.Output), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            intJFETID = oSQLParam("@JFETID").Value
            ETJFAdd = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function ETJFApproval( _
        ByVal dblACCIDJF As Double, _
        ByVal intJFETID As Integer, _
        ByVal intJFETSTATUS As Integer, _
        ByVal intUSERID As Integer) As Integer


        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("ETJFApproval", _
                objDB.MP("@ACCIDJF", Data.SqlDbType.BigInt, dblACCIDJF), _
                objDB.MP("@JFETID", Data.SqlDbType.Int, intJFETID), _
                objDB.MP("@JFETSTATUS", Data.SqlDbType.Int, intJFETSTATUS), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            ETJFApproval = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function ETJFPayment(ByVal dblACCIDJF As Double, _
          ByVal intJFETID As Integer, _
          ByVal intJFACCOUNTID As String, _
          ByVal intUSERID As Integer) As Integer


        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("ETJFPayment", _
                objDB.MP("@ACCIDJF", Data.SqlDbType.BigInt, dblACCIDJF), _
                objDB.MP("@JFETID", Data.SqlDbType.Int, intJFETID), _
                objDB.MP("@JFACCOUNTID", Data.SqlDbType.Int, intJFACCOUNTID), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            ETJFPayment = oSQLParam("@RETVAL").Value

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function


    Public Function ETJFWaiveUpdate( _
        ByVal dblACCIDJF As Double, _
        ByVal intJFETID As Integer, _
        ByVal dblJFETPENALTYWAIVE As Double, _
        ByVal dblJFETADMINWAIVE As Double, _
        ByVal intUSERID As Integer) As Integer


        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("ETJFWaiveUpdate", _
                objDB.MP("@ACCIDJF", Data.SqlDbType.BigInt, dblACCIDJF), _
                objDB.MP("@JFETID", Data.SqlDbType.Int, intJFETID), _
                objDB.MP("@JFETPENALTYWAIVE", Data.SqlDbType.Money, dblJFETPENALTYWAIVE), _
                objDB.MP("@JFETADMINWAIVE", Data.SqlDbType.Money, dblJFETADMINWAIVE), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            ETJFWaiveUpdate = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function


    Public Function ETJFRejectAfterApp( _
        ByVal dblACCIDJF As Double, _
        ByVal intJFETID As Integer, _
        ByVal intUSERID As Integer) As Integer

        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("ETJFRejectAfterApp", _
                objDB.MP("@ACCIDJF", Data.SqlDbType.BigInt, dblACCIDJF), _
                objDB.MP("@JFETID", Data.SqlDbType.Int, intJFETID), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            ETJFRejectAfterApp = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function


    Public Sub PAYMENTUPLOADProcess( _
        ByVal intTXNTYPE As String, _
        ByVal intACCOUNTID As String, _
        ByVal intUSERID As Integer)


        Dim objDB As New DBX
        Try
            'objDB.ExecSP("PAYMENTUPLOADProcess", _
            objDB.ExecSPNoTxn("PAYMENTUPLOADProcess", _
                objDB.MP("@TXNTYPE", Data.SqlDbType.Int, intTXNTYPE), _
                objDB.MP("@ACCOUNTID", Data.SqlDbType.Int, intACCOUNTID), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub PAYMENTUPLOADApproval( _
        ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("PAYMENTUPLOADApproval", _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Function PaymentFromPDC(ByVal intLOCIDPDC As String, _
         ByVal intPDCID As String, _
         ByVal iPDCDTLID As String, _
         ByVal iUSERID As String) As Integer
        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("PAYMENTFromPDCDtl", _
               objDB.MP("@LOCIDPDC", Data.SqlDbType.Int, intLOCIDPDC), _
               objDB.MP("@PDCID", Data.SqlDbType.BigInt, intPDCID), _
               objDB.MP("@PDCDTLID", Data.SqlDbType.Int, iPDCDTLID), _
               objDB.MP("@USERID", Data.SqlDbType.Int, iUSERID), _
               objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            PaymentFromPDC = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function PaymentMGM(ByVal intLOCID As String, _
             ByVal intACCID As String, _
             ByVal intLOCIDCUST As String, _
             ByVal intCUSTID As String, _
             ByVal intACCOUNTID As String, _
             ByVal dPAIDDATE As String, _
             ByVal intTXNTYPE As String, _
             ByVal iUSERID As String) As Integer
        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("MGMPaid", _
               objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
               objDB.MP("@ACCID", Data.SqlDbType.BigInt, intACCID), _
               objDB.MP("@LOCIDCUST", Data.SqlDbType.Int, intLOCIDCUST), _
               objDB.MP("@CUSTID", Data.SqlDbType.Int, intCUSTID), _
               objDB.MP("@MGMACCOUNTID", Data.SqlDbType.Int, intACCOUNTID), _
               objDB.MP("@MGMPAIDDATE", Data.SqlDbType.DateTime, dPAIDDATE), _
               objDB.MP("@MGMTXNTYPE", Data.SqlDbType.Int, intTXNTYPE), _
               objDB.MP("@USERID", Data.SqlDbType.Int, iUSERID), _
               objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            PaymentMGM = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function WaiveODAdd( _
      ByVal intLOCID As Integer, _
      ByVal dblACCID As Double, _
      ByVal dblPRINCIPALWAIVE As Double, _
      ByVal dblINTERESTWAIVE As Double, _
      ByVal dblPENALTYWAIVE As Double, _
      ByVal dtTXNDATE As Date, _
      ByVal sREMARK As String, _
      ByVal intUSERID As Integer, _
      Optional ByVal dblINSTDIFFWAIVE As Double = 0) As Integer


        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("WAIVEODAdd", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
                objDB.MP("@PRINCIPALWAIVE", Data.SqlDbType.Money, dblPRINCIPALWAIVE), _
                objDB.MP("@INTERESTWAIVE", Data.SqlDbType.Money, dblINTERESTWAIVE), _
                objDB.MP("@PENALTYWAIVE", Data.SqlDbType.Money, dblPENALTYWAIVE), _
                objDB.MP("@TXNDATE", Data.SqlDbType.DateTime, dtTXNDATE), _
                objDB.MP("@REMARK", Data.SqlDbType.VarChar, sREMARK), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output), _
                objDB.MP("@WAIVEINSTDIFF", Data.SqlDbType.Money, dblINSTDIFFWAIVE)
            )
            WaiveODAdd = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function WaiveODAddSPV( _
      ByVal intLOCID As Integer, _
      ByVal dblACCID As Double, _
      ByVal dblAMOUNTWAIVE As Double, _
      ByVal dtTXNDATE As Date, _
      ByVal sREMARK As String, _
      ByVal intUSERID As Integer) As Integer


        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("WAIVEODAddForSPV", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
                objDB.MP("@AMOUNTWAIVE", Data.SqlDbType.Money, dblAMOUNTWAIVE), _
                objDB.MP("@TXNDATE", Data.SqlDbType.DateTime, dtTXNDATE), _
                objDB.MP("@REMARK", Data.SqlDbType.VarChar, sREMARK), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            WaiveODAddSPV = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function WaiveODApproval( _
      ByVal intLOCID As Integer, _
      ByVal dblACCID As Double, _
      ByVal intWAIVEODID As Integer, _
      ByVal intUSERID As Integer) As Integer


        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("WAIVEODApprove", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
                objDB.MP("@WAIVEODID", Data.SqlDbType.Int, intWAIVEODID), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            WaiveODApproval = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function WaiveODApprovalForSPV( _
     ByVal intLOCID As Integer, _
     ByVal dblACCID As Double, _
     ByVal intWAIVEODID As Integer, _
     ByVal dblAMOUNTWAIVE As Double, _
     ByVal dtTXNDATE As Date, _
     ByVal intUSERID As Integer) As Integer


        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("WAIVEODApproveSPV", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
                objDB.MP("@WAIVEODID", Data.SqlDbType.Int, intWAIVEODID), _
                objDB.MP("@AMOUNTWAIVE", Data.SqlDbType.Money, dblAMOUNTWAIVE), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@TXNDATE", Data.SqlDbType.Date, dtTXNDATE), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            WaiveODApprovalForSPV = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function WaiveODReject( _
        ByVal intLOCID As Integer, _
        ByVal dblACCID As Double, _
        ByVal intWAIVEODID As Integer, _
        ByVal dtTXNDATE As Date, _
        ByVal intUSERID As Integer) As Integer


        Dim objDB As New DBX
        Try
            Dim intRetVal As Integer = 0
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("WAIVEODReject", _
                objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
                objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
                objDB.MP("@WAIVEODID", Data.SqlDbType.Int, intWAIVEODID), _
                objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 8, Data.ParameterDirection.Output) _
            )
            WaiveODReject = oSQLParam("@RETVAL").Value
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function
End Class

