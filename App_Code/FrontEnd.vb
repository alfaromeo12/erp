Imports Microsoft.VisualBasic

Public Class FrontEnd
    Public Sub CUSTOMERSave( _
     ByVal intLOCIDCUST As Integer, _
     ByVal dblCUSTID As Double, _
     ByVal intCUSTTYPE As String, _
     ByVal intBRANCHID As String, _
     ByVal strFULLNAME As String, _
     ByVal strCUSTNAME As String, _
     ByVal strTITLE As String, _
     ByVal strCUSTADDRESS As String, _
     ByVal strCUSTRT As String, _
     ByVal strCUSTRW As String, _
     ByVal strCUSTKEL As String, _
     ByVal strCUSTKEC As String, _
     ByVal strCUSTCITY As String, _
     ByVal strCUSTPROV As String, _
     ByVal strCUSTZIP As String, _
     ByVal intCUSTDATI As String, _
     ByVal intIDTYPE As String, _
     ByVal strIDNUMBER As String, _
     ByVal dtIDEXPIRED As String, _
     ByVal intGENDER As String, _
     ByVal intMARITALSTATUS As String, _
     ByVal dtBIRTHDATE As String, _
     ByVal strBIRTHPLACE As String, _
     ByVal intBIRTHDATI As String, _
     ByVal dtWORKSINCE As String, _
     ByVal intEMPLOYEESTS As String, _
     ByVal dtCONTRACTEND As String, _
     ByVal strLASTEDUCATION As String, _
     ByVal intECONOMYCODE As String, _
     ByVal intDEBITURCODE As String, _
     ByVal strMMN As String, _
     ByVal strNPWP As String, _
     ByVal intHOMESTATUS As String, _
     ByVal dtLIVEDSINCE As String, _
     ByVal strPHONEAREA As String, _
     ByVal strPHONENO As String, _
     ByVal strMOBILENO As String, _
     ByVal intDEPENDENT As String, _
     ByVal dblGROSSINCOME As String, _
     ByVal dblEXPENSES As String, _
     ByVal intJOBID As String, _
     ByVal intJOBTITLEID As String, _
     ByVal intRELIGION As String, _
     ByVal dblADDLINCOME As String, _
     ByVal strSOURCEADDINCOME As String, _
     ByVal strPHONEAREA2 As String, _
     ByVal strPHONENO2 As String, _
     ByVal strPHONEAREA3 As String, _
     ByVal strPHONENO3 As String, _
     ByVal strMOBILENO2 As String, _
     ByVal blnGUARANTOREXIST As String, _
     ByVal strGUARANTORTYPE As String, _
     ByVal strEMAIL As String, _
     ByVal dblOBJECTINCOME As String, _
     ByVal dblOBJECTEXPENSE As String, _
     ByVal dblOTHEREXPENSE As String, _
     ByVal intUSERID As String, _
     Optional ByRef dblNEWCUSTID As String = "0")



        Dim objDB As New DBX
        Try
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("CUSTOMERSave", _
             objDB.MP("@LOCIDCUST", Data.SqlDbType.Int, intLOCIDCUST), _
             objDB.MP("@CUSTID", Data.SqlDbType.BigInt, dblCUSTID), _
             objDB.MP("@CUSTTYPE", Data.SqlDbType.Int, intCUSTTYPE), _
             objDB.MP("@BRANCHID", Data.SqlDbType.Int, intBRANCHID), _
             objDB.MP("@FULLNAME", Data.SqlDbType.VarChar, strFULLNAME), _
             objDB.MP("@CUSTNAME", Data.SqlDbType.VarChar, strCUSTNAME), _
             objDB.MP("@TITLE", Data.SqlDbType.VarChar, strTITLE), _
             objDB.MP("@CUSTADDRESS", Data.SqlDbType.VarChar, strCUSTADDRESS), _
             objDB.MP("@CUSTRT", Data.SqlDbType.VarChar, strCUSTRT), _
             objDB.MP("@CUSTRW", Data.SqlDbType.VarChar, strCUSTRW), _
             objDB.MP("@CUSTKEL", Data.SqlDbType.VarChar, strCUSTKEL), _
             objDB.MP("@CUSTKEC", Data.SqlDbType.VarChar, strCUSTKEC), _
             objDB.MP("@CUSTCITY", Data.SqlDbType.VarChar, strCUSTCITY), _
             objDB.MP("@CUSTPROV", Data.SqlDbType.VarChar, strCUSTPROV), _
             objDB.MP("@CUSTZIP", Data.SqlDbType.VarChar, strCUSTZIP), _
             objDB.MP("@CUSTDATI", Data.SqlDbType.Int, intCUSTDATI), _
             objDB.MP("@IDTYPE", Data.SqlDbType.TinyInt, intIDTYPE), _
             objDB.MP("@IDNUMBER", Data.SqlDbType.VarChar, strIDNUMBER), _
             objDB.MP("@IDEXPIRED", Data.SqlDbType.DateTime, dtIDEXPIRED), _
             objDB.MP("@GENDER", Data.SqlDbType.TinyInt, intGENDER), _
             objDB.MP("@MARITALSTATUS", Data.SqlDbType.TinyInt, intMARITALSTATUS), _
             objDB.MP("@BIRTHDATE", Data.SqlDbType.DateTime, dtBIRTHDATE), _
             objDB.MP("@BIRTHPLACE", Data.SqlDbType.VarChar, strBIRTHPLACE), _
             objDB.MP("@BIRTHDATI", Data.SqlDbType.Int, intBIRTHDATI), _
             objDB.MP("@WORKSINCE", Data.SqlDbType.DateTime, dtWORKSINCE), _
             objDB.MP("@EMPLOYEESTS", Data.SqlDbType.TinyInt, intEMPLOYEESTS), _
             objDB.MP("@CONTRACTEND", Data.SqlDbType.DateTime, dtCONTRACTEND), _
             objDB.MP("@LASTEDUCATION", Data.SqlDbType.VarChar, strLASTEDUCATION), _
             objDB.MP("@ECONOMYCODE", Data.SqlDbType.Int, intECONOMYCODE), _
             objDB.MP("@DEBITURCODE", Data.SqlDbType.Int, intDEBITURCODE), _
             objDB.MP("@MMN", Data.SqlDbType.VarChar, strMMN), _
             objDB.MP("@NPWP", Data.SqlDbType.VarChar, strNPWP), _
             objDB.MP("@HOMESTATUS", Data.SqlDbType.TinyInt, intHOMESTATUS), _
             objDB.MP("@LIVEDSINCE", Data.SqlDbType.DateTime, dtLIVEDSINCE), _
             objDB.MP("@PHONEAREA", Data.SqlDbType.VarChar, strPHONEAREA), _
             objDB.MP("@PHONENO", Data.SqlDbType.VarChar, strPHONENO), _
             objDB.MP("@MOBILENO", Data.SqlDbType.VarChar, strMOBILENO), _
             objDB.MP("@DEPENDENT", Data.SqlDbType.Int, intDEPENDENT), _
             objDB.MP("@GROSSINCOME", Data.SqlDbType.Money, dblGROSSINCOME), _
             objDB.MP("@EXPENSES", Data.SqlDbType.Money, dblEXPENSES), _
             objDB.MP("@JOBID", Data.SqlDbType.Int, intJOBID), _
             objDB.MP("@JOBTITLEID", Data.SqlDbType.Int, intJOBTITLEID), _
             objDB.MP("@RELIGION", Data.SqlDbType.Int, intRELIGION), _
             objDB.MP("@ADDLINCOME", Data.SqlDbType.Money, dblADDLINCOME), _
             objDB.MP("@SOURCEADDINCOME", Data.SqlDbType.VarChar, strSOURCEADDINCOME), _
             objDB.MP("@PHONEAREA2", Data.SqlDbType.VarChar, strPHONEAREA2), _
             objDB.MP("@PHONENO2", Data.SqlDbType.VarChar, strPHONENO2), _
             objDB.MP("@PHONEAREA3", Data.SqlDbType.VarChar, strPHONEAREA3), _
             objDB.MP("@PHONENO3", Data.SqlDbType.VarChar, strPHONENO3), _
             objDB.MP("@MOBILENO2", Data.SqlDbType.VarChar, strMOBILENO2), _
             objDB.MP("@GUARANTOREXIST", Data.SqlDbType.Int, blnGUARANTOREXIST), _
             objDB.MP("@GUARANTORTYPE", Data.SqlDbType.VarChar, strGUARANTORTYPE), _
             objDB.MP("@EMAIL", Data.SqlDbType.VarChar, strEMAIL), _
             objDB.MP("@OBJECTINCOME", Data.SqlDbType.Money, dblOBJECTINCOME), _
             objDB.MP("@OBJECTEXPENSE", Data.SqlDbType.Money, dblOBJECTEXPENSE), _
             objDB.MP("@OTHEREXPENSE", Data.SqlDbType.Money, dblOTHEREXPENSE), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
             objDB.MP("@NEWCUSTID", Data.SqlDbType.BigInt, dblNEWCUSTID, Data.ParameterDirection.InputOutput))


            dblNEWCUSTID = oSQLParam("@NEWCUSTID").Value.ToString()

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    'Public Sub CUSTOMERDTLSave(ByVal intLOCIDCUST As Integer, _
    '    ByVal dblCUSTID As Double, _
    '    ByVal blnSAMEIDHOMEADDR As String, _
    '    ByVal strCUSTADDRESSHOME As String, _
    '    ByVal strCUSTRTHOME As String, _
    '    ByVal strCUSTRWHOME As String, _
    '    ByVal strCUSTKELHOME As String, _
    '    ByVal strCUSTKECHOME As String, _
    '    ByVal strCUSTCITYHOME As String, _
    '    ByVal strCUSTPROVHOME As String, _
    '    ByVal strCUSTZIPHOME As String, _
    '    ByVal intCUSTDATIHOME As String, _
    '    ByVal strSPOUSENAME As String, _
    '    ByVal dtSPOUSEBIRTHDATE As Date, _
    '    ByVal strSPOUSEBIRTHPLACE As String, _
    '    ByVal intSPOUSEIDTYPE As String, _
    '    ByVal strSPOUSEIDNUMBER As String, _
    '    ByVal strSPOUSEPHONENO As String, _
    '    ByVal strSPOUSEMOBILENO As String, _
    '    ByVal strSPOUSEOFFICE As String, _
    '    ByVal strSPOUSEOFFINEPHONE As String, _
    '    ByVal intRELATIVESTYPE As String, _
    '    ByVal strRELATIVESNAME As String, _
    '    ByVal strCUSTADDRESSREL As String, _
    '    ByVal strCUSTRTREL As String, _
    '    ByVal strCUSTRWREL As String, _
    '    ByVal strCUSTKELREL As String, _
    '    ByVal strCUSTKECREL As String, _
    '    ByVal strCUSTCITYREL As String, _
    '    ByVal strCUSTPROVREL As String, _
    '    ByVal strCUSTZIPREL As String, _
    '    ByVal strPHONENOREL As String, _
    '    ByVal strCOMPANYNAME As String, _
    '    ByVal strCOMPANYADDR As String, _
    '    ByVal strCOMPANYCITY As String, _
    '    ByVal strCOMPANYZIP As String, _
    '    ByVal strCOMPANYPHONE As String, _
    '    ByVal strCOMPANYPHONEEXT As String, _
    '    ByVal strDEPARTMENT As String, _
    '    ByVal strSUPERVISORNAME As String, _
    '    ByVal intUSERID As Integer)

    '    Dim objDB As New DBX
    '    Try
    '        objDB.ExecSP("CUSTOMERDTLSave", _
    '            objDB.MP("@LOCIDCUST", Data.SqlDbType.Int, intLOCIDCUST), _
    '            objDB.MP("@CUSTID", Data.SqlDbType.BigInt, dblCUSTID), _
    '            objDB.MP("@SAMEIDHOMEADDR", Data.SqlDbType.VarChar, blnSAMEIDHOMEADDR), _
    '            objDB.MP("@CUSTADDRESSHOME", Data.SqlDbType.VarChar, strCUSTADDRESSHOME), _
    '            objDB.MP("@CUSTRTHOME", Data.SqlDbType.VarChar, strCUSTRTHOME), _
    '            objDB.MP("@CUSTRWHOME", Data.SqlDbType.VarChar, strCUSTRWHOME), _
    '            objDB.MP("@CUSTKELHOME", Data.SqlDbType.VarChar, strCUSTKELHOME), _
    '            objDB.MP("@CUSTKECHOME", Data.SqlDbType.VarChar, strCUSTKECHOME), _
    '            objDB.MP("@CUSTCITYHOME", Data.SqlDbType.VarChar, strCUSTCITYHOME), _
    '            objDB.MP("@CUSTPROVHOME", Data.SqlDbType.VarChar, strCUSTPROVHOME), _
    '            objDB.MP("@CUSTZIPHOME", Data.SqlDbType.VarChar, strCUSTZIPHOME5), _
    '            objDB.MP("@CUSTDATIHOME", Data.SqlDbType.Int, intCUSTDATIHOME), _
    '            objDB.MP("@SPOUSENAME", Data.SqlDbType.VarChar, strSPOUSENAME), _
    '            objDB.MP("@SPOUSEBIRTHDATE", Data.SqlDbType.DateTime, dtSPOUSEBIRTHDATE), _
    '            objDB.MP("@SPOUSEBIRTHPLACE", Data.SqlDbType.VarChar, strSPOUSEBIRTHPLACE), _
    '            objDB.MP("@SPOUSEIDTYPE", Data.SqlDbType.TinyInt, intSPOUSEIDTYPE), _
    '            objDB.MP("@SPOUSEIDNUMBER", Data.SqlDbType.VarChar, strSPOUSEIDNUMBER), _
    '            objDB.MP("@SPOUSEPHONENO", Data.SqlDbType.VarChar, strSPOUSEPHONENO), _
    '            objDB.MP("@SPOUSEMOBILENO", Data.SqlDbType.VarChar, strSPOUSEMOBILENO), _
    '            objDB.MP("@SPOUSEOFFICE", Data.SqlDbType.VarChar, strSPOUSEOFFICE), _
    '            objDB.MP("@SPOUSEOFFINEPHONE", Data.SqlDbType.VarChar, strSPOUSEOFFINEPHONE), _
    '            objDB.MP("@RELATIVESTYPE", Data.SqlDbType.TinyInt, intRELATIVESTYPE), _
    '            objDB.MP("@RELATIVESNAME", Data.SqlDbType.VarChar, strRELATIVESNAME), _
    '            objDB.MP("@CUSTADDRESSREL", Data.SqlDbType.VarChar, strCUSTADDRESSREL), _
    '            objDB.MP("@CUSTRTREL", Data.SqlDbType.VarChar, strCUSTRTREL), _
    '            objDB.MP("@CUSTRWREL", Data.SqlDbType.VarChar, strCUSTRWREL), _
    '            objDB.MP("@CUSTKELREL", Data.SqlDbType.VarChar, strCUSTKELREL), _
    '            objDB.MP("@CUSTKECREL", Data.SqlDbType.VarChar, strCUSTKECREL), _
    '            objDB.MP("@CUSTCITYREL", Data.SqlDbType.VarChar, strCUSTCITYREL), _
    '            objDB.MP("@CUSTPROVREL", Data.SqlDbType.VarChar, strCUSTPROVREL), _
    '            objDB.MP("@CUSTZIPREL", Data.SqlDbType.VarChar, strCUSTZIPREL5), _
    '            objDB.MP("@PHONENOREL", Data.SqlDbType.VarChar, strPHONENOREL), _
    '            objDB.MP("@COMPANYNAME", Data.SqlDbType.VarChar, strCOMPANYNAME0), _
    '            objDB.MP("@COMPANYADDR", Data.SqlDbType.VarChar, strCOMPANYADDR), _
    '            objDB.MP("@COMPANYCITY", Data.SqlDbType.VarChar, strCOMPANYCITY), _
    '            objDB.MP("@COMPANYZIP", Data.SqlDbType.VarChar, strCOMPANYZIP), _
    '            objDB.MP("@COMPANYPHONE", Data.SqlDbType.VarChar, strCOMPANYPHONE), _
    '            objDB.MP("@COMPANYPHONEEXT", Data.SqlDbType.VarChar, strCOMPANYPHONEEXT, 5), _
    '            objDB.MP("@DEPARTMENT", Data.SqlDbType.VarChar, strDEPARTMENT), _
    '            objDB.MP("@SUPERVISORNAME", Data.SqlDbType.VarChar, strSUPERVISORNAME), _
    '            objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID))
    '    Catch ex As Exception
    '        Throw
    '    Finally
    '        objDB.Close()
    '        objDB = Nothing
    '    End Try
    'End Sub

    Public Sub CUSTOMERDTLSave(ByVal intLOCIDCUST As Integer, _
     ByVal dblCUSTID As Double, _
     ByVal blnSAMEIDHOMEADDR As String, _
     ByVal strCUSTADDRESSHOME As String, _
     ByVal strCUSTRTHOME As String, _
     ByVal strCUSTRWHOME As String, _
     ByVal strCUSTKELHOME As String, _
     ByVal strCUSTKECHOME As String, _
     ByVal strCUSTCITYHOME As String, _
     ByVal strCUSTPROVHOME As String, _
     ByVal strCUSTZIPHOME As String, _
     ByVal intCUSTDATIHOME As String, _
     ByVal strSPOUSENAME As String, _
     ByVal dtSPOUSEBIRTHDATE As Date, _
     ByVal strSPOUSEBIRTHPLACE As String, _
     ByVal intSPOUSEIDTYPE As String, _
     ByVal strSPOUSEIDNUMBER As String, _
     ByVal strSPOUSEPHONENO As String, _
     ByVal strSPOUSEMOBILENO As String, _
     ByVal strSPOUSEOFFICE As String, _
     ByVal strSPOUSEOFFINEPHONE As String, _
     ByVal intRELATIVESTYPE As String, _
     ByVal strRELATIVESNAME As String, _
     ByVal strCUSTADDRESSREL As String, _
     ByVal strCUSTRTREL As String, _
     ByVal strCUSTRWREL As String, _
     ByVal strCUSTKELREL As String, _
     ByVal strCUSTKECREL As String, _
     ByVal strCUSTCITYREL As String, _
     ByVal strCUSTPROVREL As String, _
     ByVal strCUSTZIPREL As String, _
     ByVal strPHONENOREL As String, _
     ByVal strCOMPANYNAME As String, _
     ByVal strCOMPANYADDR As String, _
     ByVal strCOMPANYCITY As String, _
     ByVal strCOMPANYZIP As String, _
     ByVal strCOMPANYPHONE As String, _
 ByVal dtSPOUSEWORKSINCED As Date, _
 ByVal intSPOUSEJOBID As String, _
 ByVal intSPOUSEJOBTITLEID As String, _
 ByVal intSPOUSEECONOMYCODE As String, _
 ByVal intSPOUSEDEBITURCODE As String, _
 ByVal dblSPOUSEINCOME As String, _
 ByVal intMAILADDRESSTO As String, _
 ByVal strCUSTADDRESSMAIL As String, _
 ByVal strCUSTRTMAIL As String, _
 ByVal strCUSTRWMAIL As String, _
 ByVal strCUSTKELMAIL As String, _
 ByVal strCUSTKECMAIL As String, _
 ByVal strCUSTCITYMAIL As String, _
 ByVal strCUSTPROVMAIL As String, _
 ByVal strCUSTZIPMAIL As String, _
 ByVal intCUSTDATIMAIL As String, _
 ByVal strPBBAN As String, _
 ByVal strPBBIDNUMBER As String, _
 ByVal strCOMPANYRT As String, _
 ByVal strCOMPANYRW As String,
 ByVal strCOMPANYKEL As String, _
 ByVal strCOMPANYKEC As String, _
 ByVal intASSETTYPE As String, _
 ByVal dblASSETPRICE As String, _
 ByVal strASSETDESC As String, _
 ByVal intMAINBANKID As String, _
 ByVal strMAINBANKBRANCH As String, _
 ByVal intMAINBANKMEMBERMM As String, _
 ByVal intMAINBANKMEMBERYYYY As String, _
 ByVal strMAINBANKACCNO As String, _
 ByVal intMAINBANKACCTYPE As String, _
 ByVal intOTHBANKID As String, _
 ByVal strOTHBANKBRANCH As String, _
 ByVal intOTHBANKMEMBERMM As String, _
 ByVal intOTHBANKMEMBERYYYY As String, _
 ByVal strOTHBANKACCNO As String, _
 ByVal intOTHBANKACCTYPE As String, _
 ByVal blnFACILITY As String, _
 ByVal strFACILITYFROM As String, _
 ByVal strFACILITYKIND As String, _
 ByVal dblFACILITYINST As String, _
        ByVal blnSPOUSESAMEADDR As String, _
        ByVal strSPOUSEADDRESS As String, _
        ByVal strSPOUSERT As String, _
        ByVal strSPOUSERW As String, _
        ByVal strSPOUSEKEL As String, _
        ByVal strSPOUSEKEC As String, _
        ByVal strSPOUSECITY As String, _
        ByVal strSPOUSEPROV As String, _
        ByVal strSPOUSEZIP As String, _
        ByVal intSPOUSEDATI As String, _
ByVal strCOMPANYBUSINESS As String, _
ByVal strSPOUSECOMPANYBUSINESS As String, _
ByVal intCOMPANYFAX As String, _
     ByVal intUSERID As Integer)



        'ByVal strCOMPANYPHONEEXT As String, _
        'ByVal strDEPARTMENT As String, _
        'ByVal strSUPERVISORNAME As String, _


        Dim objDB As New DBX
        Try
            objDB.ExecSP("CUSTOMERDTLSave", _
             objDB.MP("@LOCIDCUST", Data.SqlDbType.Int, intLOCIDCUST), _
             objDB.MP("@CUSTID", Data.SqlDbType.BigInt, dblCUSTID), _
             objDB.MP("@SAMEIDHOMEADDR", Data.SqlDbType.VarChar, blnSAMEIDHOMEADDR), _
             objDB.MP("@CUSTADDRESSHOME", Data.SqlDbType.VarChar, strCUSTADDRESSHOME), _
             objDB.MP("@CUSTRTHOME", Data.SqlDbType.VarChar, strCUSTRTHOME), _
             objDB.MP("@CUSTRWHOME", Data.SqlDbType.VarChar, strCUSTRWHOME), _
             objDB.MP("@CUSTKELHOME", Data.SqlDbType.VarChar, strCUSTKELHOME), _
             objDB.MP("@CUSTKECHOME", Data.SqlDbType.VarChar, strCUSTKECHOME), _
             objDB.MP("@CUSTCITYHOME", Data.SqlDbType.VarChar, strCUSTCITYHOME), _
             objDB.MP("@CUSTPROVHOME", Data.SqlDbType.VarChar, strCUSTPROVHOME), _
             objDB.MP("@CUSTZIPHOME", Data.SqlDbType.VarChar, strCUSTZIPHOME), _
             objDB.MP("@CUSTDATIHOME", Data.SqlDbType.Int, intCUSTDATIHOME), _
             objDB.MP("@SPOUSENAME", Data.SqlDbType.VarChar, strSPOUSENAME), _
             objDB.MP("@SPOUSEBIRTHDATE", Data.SqlDbType.DateTime, dtSPOUSEBIRTHDATE), _
             objDB.MP("@SPOUSEBIRTHPLACE", Data.SqlDbType.VarChar, strSPOUSEBIRTHPLACE), _
             objDB.MP("@SPOUSEIDTYPE", Data.SqlDbType.TinyInt, intSPOUSEIDTYPE), _
             objDB.MP("@SPOUSEIDNUMBER", Data.SqlDbType.VarChar, strSPOUSEIDNUMBER), _
             objDB.MP("@SPOUSEPHONENO", Data.SqlDbType.VarChar, strSPOUSEPHONENO), _
             objDB.MP("@SPOUSEMOBILENO", Data.SqlDbType.VarChar, strSPOUSEMOBILENO), _
             objDB.MP("@SPOUSEOFFICE", Data.SqlDbType.VarChar, strSPOUSEOFFICE), _
             objDB.MP("@SPOUSEOFFINEPHONE", Data.SqlDbType.VarChar, strSPOUSEOFFINEPHONE), _
             objDB.MP("@RELATIVESTYPE", Data.SqlDbType.TinyInt, intRELATIVESTYPE), _
             objDB.MP("@RELATIVESNAME", Data.SqlDbType.VarChar, strRELATIVESNAME), _
             objDB.MP("@CUSTADDRESSREL", Data.SqlDbType.VarChar, strCUSTADDRESSREL), _
             objDB.MP("@CUSTRTREL", Data.SqlDbType.VarChar, strCUSTRTREL), _
             objDB.MP("@CUSTRWREL", Data.SqlDbType.VarChar, strCUSTRWREL), _
             objDB.MP("@CUSTKELREL", Data.SqlDbType.VarChar, strCUSTKELREL), _
             objDB.MP("@CUSTKECREL", Data.SqlDbType.VarChar, strCUSTKECREL), _
             objDB.MP("@CUSTCITYREL", Data.SqlDbType.VarChar, strCUSTCITYREL), _
             objDB.MP("@CUSTPROVREL", Data.SqlDbType.VarChar, strCUSTPROVREL), _
             objDB.MP("@CUSTZIPREL", Data.SqlDbType.VarChar, strCUSTZIPREL), _
             objDB.MP("@PHONENOREL", Data.SqlDbType.VarChar, strPHONENOREL), _
             objDB.MP("@COMPANYNAME", Data.SqlDbType.VarChar, strCOMPANYNAME), _
             objDB.MP("@COMPANYADDR", Data.SqlDbType.VarChar, strCOMPANYADDR), _
             objDB.MP("@COMPANYCITY", Data.SqlDbType.VarChar, strCOMPANYCITY), _
             objDB.MP("@COMPANYZIP", Data.SqlDbType.VarChar, strCOMPANYZIP), _
             objDB.MP("@COMPANYPHONE", Data.SqlDbType.VarChar, strCOMPANYPHONE), _
 objDB.MP("@SPOUSEWORKSINCED", Data.SqlDbType.DateTime, dtSPOUSEWORKSINCED), _
 objDB.MP("@SPOUSEJOBID", Data.SqlDbType.Int, intSPOUSEJOBID), _
 objDB.MP("@SPOUSEJOBTITLEID", Data.SqlDbType.Int, intSPOUSEJOBTITLEID), _
 objDB.MP("@SPOUSEECONOMYCODE", Data.SqlDbType.Int, intSPOUSEECONOMYCODE), _
 objDB.MP("@SPOUSEDEBITURCODE", Data.SqlDbType.Int, intSPOUSEDEBITURCODE), _
 objDB.MP("@SPOUSEINCOME", Data.SqlDbType.Money, dblSPOUSEINCOME), _
 objDB.MP("@MAILADDRESSTO", Data.SqlDbType.Int, intMAILADDRESSTO), _
 objDB.MP("@CUSTADDRESSMAIL", Data.SqlDbType.VarChar, strCUSTADDRESSMAIL), _
 objDB.MP("@CUSTRTMAIL", Data.SqlDbType.VarChar, strCUSTRTMAIL), _
 objDB.MP("@CUSTRWMAIL", Data.SqlDbType.VarChar, strCUSTRWMAIL), _
 objDB.MP("@CUSTKELMAIL", Data.SqlDbType.VarChar, strCUSTKELMAIL), _
 objDB.MP("@CUSTKECMAIL", Data.SqlDbType.VarChar, strCUSTKECMAIL), _
 objDB.MP("@CUSTCITYMAIL", Data.SqlDbType.VarChar, strCUSTCITYMAIL), _
 objDB.MP("@CUSTPROVMAIL", Data.SqlDbType.VarChar, strCUSTPROVMAIL), _
 objDB.MP("@CUSTZIPMAIL", Data.SqlDbType.VarChar, strCUSTZIPMAIL), _
 objDB.MP("@CUSTDATIMAIL", Data.SqlDbType.Int, intCUSTDATIMAIL), _
 objDB.MP("@PBBAN", Data.SqlDbType.VarChar, strPBBAN), _
 objDB.MP("@PBBIDNUMBER", Data.SqlDbType.VarChar, strPBBIDNUMBER), _
 objDB.MP("@COMPANYRT", Data.SqlDbType.VarChar, strCOMPANYRT), _
 objDB.MP("@COMPANYRW", Data.SqlDbType.VarChar, strCOMPANYRW), _
 objDB.MP("@COMPANYKEL", Data.SqlDbType.VarChar, strCOMPANYKEL), _
 objDB.MP("@COMPANYKEC", Data.SqlDbType.VarChar, strCOMPANYKEC), _
 objDB.MP("@ASSETTYPE", Data.SqlDbType.Int, intASSETTYPE), _
 objDB.MP("@ASSETPRICE", Data.SqlDbType.Money, dblASSETPRICE), _
 objDB.MP("@ASSETDESC", Data.SqlDbType.VarChar, strASSETDESC), _
 objDB.MP("@MAINBANKID", Data.SqlDbType.Int, intMAINBANKID), _
 objDB.MP("@MAINBANKBRANCH", Data.SqlDbType.VarChar, strMAINBANKBRANCH), _
 objDB.MP("@MAINBANKMEMBERMM", Data.SqlDbType.Int, intMAINBANKMEMBERMM), _
 objDB.MP("@MAINBANKMEMBERYYYY", Data.SqlDbType.Int, intMAINBANKMEMBERYYYY), _
 objDB.MP("@MAINBANKACCNO", Data.SqlDbType.VarChar, strMAINBANKACCNO), _
 objDB.MP("@MAINBANKACCTYPE", Data.SqlDbType.Int, intMAINBANKACCTYPE), _
 objDB.MP("@OTHBANKID", Data.SqlDbType.Int, intOTHBANKID), _
 objDB.MP("@OTHBANKBRANCH", Data.SqlDbType.VarChar, strOTHBANKBRANCH), _
 objDB.MP("@OTHBANKMEMBERMM", Data.SqlDbType.Int, intOTHBANKMEMBERMM), _
 objDB.MP("@OTHBANKMEMBERYYYY", Data.SqlDbType.Int, intOTHBANKMEMBERYYYY), _
 objDB.MP("@OTHBANKACCNO", Data.SqlDbType.VarChar, strOTHBANKACCNO), _
 objDB.MP("@OTHBANKACCTYPE", Data.SqlDbType.Int, intOTHBANKACCTYPE), _
 objDB.MP("@FACILITY", Data.SqlDbType.Int, blnFACILITY), _
 objDB.MP("@FACILITYFROM", Data.SqlDbType.VarChar, strFACILITYFROM), _
 objDB.MP("@FACILITYKIND", Data.SqlDbType.VarChar, strFACILITYKIND), _
 objDB.MP("@FACILITYINST", Data.SqlDbType.Money, dblFACILITYINST), _
 objDB.MP("@SPOUSESAMEADDR", Data.SqlDbType.VarChar, blnSPOUSESAMEADDR), _
 objDB.MP("@SPOUSEADDRESS", Data.SqlDbType.VarChar, strSPOUSEADDRESS), _
 objDB.MP("@SPOUSERT", Data.SqlDbType.VarChar, strSPOUSERT), _
 objDB.MP("@SPOUSERW", Data.SqlDbType.VarChar, strSPOUSERW), _
 objDB.MP("@SPOUSEKEL", Data.SqlDbType.VarChar, strSPOUSEKEL), _
 objDB.MP("@SPOUSEKEC", Data.SqlDbType.VarChar, strSPOUSEKEC), _
 objDB.MP("@SPOUSECITY", Data.SqlDbType.VarChar, strSPOUSECITY), _
 objDB.MP("@SPOUSEPROV", Data.SqlDbType.VarChar, strSPOUSEPROV), _
 objDB.MP("@SPOUSEZIP", Data.SqlDbType.VarChar, strSPOUSEZIP), _
 objDB.MP("@SPOUSEDATI", Data.SqlDbType.Int, intSPOUSEDATI), _
 objDB.MP("@COMPANYBUSINESS", Data.SqlDbType.VarChar, strCOMPANYBUSINESS), _
 objDB.MP("@SPOUSECOMPANYBUSINESS", Data.SqlDbType.VarChar, strSPOUSECOMPANYBUSINESS), _
 objDB.MP("@COMPANYFAX", Data.SqlDbType.Int, intCOMPANYFAX), _
 objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID))

            'objDB.MP("@COMPANYPHONEEXT", Data.SqlDbType.VarChar, strCOMPANYPHONEEXT, 5), _
            'objDB.MP("@DEPARTMENT", Data.SqlDbType.VarChar, strDEPARTMENT), _
            'objDB.MP("@SUPERVISORNAME", Data.SqlDbType.VarChar, strSUPERVISORNAME), _

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Public Sub CUSTOMERCORPSave(ByVal intLOCIDCUST As Integer, _
             ByVal dblCUSTID As Double, _
             ByVal strDEEDNO As String, _
             ByVal dtDEEDATE As String, _
             ByVal strNOTARY As String, _
             ByVal strTPDNO As String, _
             ByVal dtTDPFROM As String, _
             ByVal dtTDPUNTIL As String, _
             ByVal strSIUPNO As String, _
             ByVal dtSIUPFROM As String, _
             ByVal dtSIUPUNTIL As String, _
             ByVal strDOMISILI As String, _
             ByVal dtDOMISILIFROM As String, _
             ByVal dtDOMISILIUNTIL As Date, _
             ByVal strBKPM As String, _
             ByVal dtBKPMFROM As String, _
             ByVal dtBKPMUNTIL As String, _
             ByVal dblSTOCKPRICE As String, _
             ByVal dblSTOCKAMOUNT As String, _
             ByVal dblNOMINALMODALDASAR As String, _
             ByVal intSAHAMDITEMPATKAN As String, _
             ByVal dblNOMINALSAHAMDITEMPATKAN As String, _
             ByVal intSAHAMDISETOR As String, _
             ByVal dblNOMINALSAHAMDISETOR As String, _
             ByVal strBUSINESS As String, _
             ByVal intCOTYPEID As String, _
             ByVal strOTHADDRESSDESC As String, _
             ByVal strOTHADDRESS As String, _
             ByVal strOTHRT As String, _
             ByVal strOTHRW As String, _
             ByVal strOTHKEL As String, _
             ByVal strOTHKEC As String, _
             ByVal strOTHCITY As String, _
             ByVal strOTHPROV As String, _
             ByVal strOTHZIP As String, _
             ByVal strOTHDATI As String, _
             ByVal strPERSONINCHARGE As String, _
             ByVal strPERSONPOSITION As String, _
             ByVal strPERSONADDRESS As String, _
             ByVal strPERSONRT As String, _
             ByVal strPERSONRW As String, _
             ByVal strPERSONKEL As String, _
             ByVal strPERSONKEC As String, _
             ByVal strPERSONCITY As String, _
             ByVal strPERSONPROV As String, _
             ByVal strPERSONZIP As String, _
             ByVal strPERSONDATI As String, _
             ByVal bitOTHEREXIST As String, _
             ByVal intUSERID As String)



        'ByVal strCOMPANYPHONEEXT As String, _
        'ByVal strDEPARTMENT As String, _
        'ByVal strSUPERVISORNAME As String, _


        Dim objDB As New DBX
        Try
            objDB.ExecSP("CUSTOMERCORPSave", _
             objDB.MP("@LOCIDCUST", Data.SqlDbType.Int, intLOCIDCUST), _
             objDB.MP("@CUSTID", Data.SqlDbType.BigInt, dblCUSTID), _
             objDB.MP("@DEEDNO", Data.SqlDbType.VarChar, strDEEDNO), _
             objDB.MP("@DEEDDATE", Data.SqlDbType.DateTime, dtDEEDATE), _
             objDB.MP("@NOTARY", Data.SqlDbType.VarChar, strNOTARY), _
             objDB.MP("@TPDNO", Data.SqlDbType.VarChar, strTPDNO), _
             objDB.MP("@TDPFROM", Data.SqlDbType.DateTime, dtTDPFROM), _
             objDB.MP("@TDPUNTIL", Data.SqlDbType.DateTime, dtTDPUNTIL), _
             objDB.MP("@SIUPNO", Data.SqlDbType.VarChar, strSIUPNO), _
             objDB.MP("@SIUPFROM", Data.SqlDbType.DateTime, dtSIUPFROM), _
             objDB.MP("@SIUPUNTIL", Data.SqlDbType.DateTime, dtSIUPUNTIL), _
             objDB.MP("@DOMISILI", Data.SqlDbType.VarChar, strDOMISILI), _
             objDB.MP("@DOMISILIFROM", Data.SqlDbType.DateTime, dtDOMISILIFROM), _
             objDB.MP("@DOMISILIUNTIL", Data.SqlDbType.DateTime, dtDOMISILIUNTIL), _
             objDB.MP("@BKPM", Data.SqlDbType.VarChar, strBKPM), _
             objDB.MP("@BKPMFROM", Data.SqlDbType.DateTime, dtBKPMFROM), _
             objDB.MP("@BKPMUNTIL", Data.SqlDbType.DateTime, dtBKPMUNTIL), _
             objDB.MP("@STOCKPRICE", Data.SqlDbType.Money, dblSTOCKPRICE), _
             objDB.MP("@STOCKAMOUNT", Data.SqlDbType.Int, dblSTOCKAMOUNT), _
             objDB.MP("@NOMINALMODALDASAR", Data.SqlDbType.Money, dblNOMINALMODALDASAR), _
             objDB.MP("@SAHAMDITEMPATKAN", Data.SqlDbType.Int, intSAHAMDITEMPATKAN), _
             objDB.MP("@NOMINALSAHAMDITEMPATKAN", Data.SqlDbType.Money, dblNOMINALSAHAMDITEMPATKAN), _
             objDB.MP("@SAHAMDISETOR", Data.SqlDbType.Int, intSAHAMDISETOR), _
             objDB.MP("@NOMINALSAHAMDISETOR", Data.SqlDbType.Money, dblNOMINALSAHAMDISETOR), _
             objDB.MP("@BUSINESS", Data.SqlDbType.VarChar, strBUSINESS), _
             objDB.MP("@COTYPEID", Data.SqlDbType.Int, intCOTYPEID, 5), _
             objDB.MP("@OTHADDRESSDESC", Data.SqlDbType.VarChar, strOTHADDRESSDESC), _
             objDB.MP("@OTHADDRESS", Data.SqlDbType.VarChar, strOTHADDRESS), _
             objDB.MP("@OTHRT", Data.SqlDbType.VarChar, strOTHRT), _
             objDB.MP("@OTHRW", Data.SqlDbType.VarChar, strOTHRW), _
             objDB.MP("@OTHKEL", Data.SqlDbType.VarChar, strOTHKEL), _
             objDB.MP("@OTHKEC", Data.SqlDbType.VarChar, strOTHKEC), _
             objDB.MP("@OTHCITY", Data.SqlDbType.VarChar, strOTHCITY), _
             objDB.MP("@OTHPROV", Data.SqlDbType.VarChar, strOTHPROV), _
             objDB.MP("@OTHZIP", Data.SqlDbType.VarChar, strOTHZIP), _
             objDB.MP("@OTHDATI", Data.SqlDbType.Int, strOTHDATI), _
             objDB.MP("@PERSONINCHARGE", Data.SqlDbType.VarChar, strPERSONINCHARGE), _
             objDB.MP("@PERSONPOSITION", Data.SqlDbType.VarChar, strPERSONPOSITION), _
             objDB.MP("@PERSONADDRESS", Data.SqlDbType.VarChar, strPERSONADDRESS), _
             objDB.MP("@PERSONRT", Data.SqlDbType.VarChar, strPERSONRT), _
             objDB.MP("@PERSONRW", Data.SqlDbType.VarChar, strPERSONRW), _
             objDB.MP("@PERSONKEL", Data.SqlDbType.VarChar, strPERSONKEL), _
             objDB.MP("@PERSONKEC", Data.SqlDbType.VarChar, strPERSONKEC), _
             objDB.MP("@PERSONCITY", Data.SqlDbType.VarChar, strPERSONCITY), _
             objDB.MP("@PERSONPROV", Data.SqlDbType.VarChar, strPERSONPROV), _
             objDB.MP("@PERSONZIP", Data.SqlDbType.VarChar, strPERSONZIP), _
             objDB.MP("@PERSONDATI", Data.SqlDbType.Int, strPERSONDATI), _
             objDB.MP("@OTHADDREXIST", Data.SqlDbType.Int, bitOTHEREXIST), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID))

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Public Sub CUSTOMERGUARANTORSave( _
        ByVal intLOCIDCUST As String, _
        ByVal dblCUSTID As String, _
        ByVal strNAME As String, _
        ByVal strBIRTHPLACE As String, _
        ByVal dtBIRTHDATE As String, _
        ByVal strTITLE As String, _
        ByVal intMARITALSTS As String, _
        ByVal intIDTYPE As String, _
        ByVal strIDNUMBER As String, _
        ByVal intGENDER As String, _
        ByVal intJOBID As String, _
        ByVal intRELATION As String, _
        ByVal intRELIGION As String, _
        ByVal strADDRESS As String, _
        ByVal strRT As String, _
        ByVal strRW As String, _
        ByVal strKELURAHAN As String, _
        ByVal strKECAMATAN As String, _
        ByVal strCITY As String, _
        ByVal strPROVINCE As String, _
        ByVal strZIP As String, _
        ByVal intCITYID As String, _
        ByVal strSPOUSETITLE As String, _
        ByVal strSPOUSENAME As String, _
        ByVal intSPOUSEIDTYPE As String, _
        ByVal strSPOUSEIDNUMBER As String, _
        ByVal dtSPOUSEBIRTHDATE As String, _
        ByVal strSPOUSEBIRTHPLACE As String, _
        ByVal strSPOUSEADDRESS As String, _
        ByVal intSPOUSEJOBID As String, _
        ByVal strSPOUSEKEL As String, _
        ByVal strSPOUSEKEC As String, _
        ByVal strSPOUSECITY As String, _
        ByVal strSPOUSEPROV As String, _
        ByVal strSPOUSEZIP As String, _
        ByVal strSPOUSERT As String, _
        ByVal strSPOUSERW As String, _
        ByVal intSPOUSEJOBTITLEID As String, _
        ByVal intJOBTITLEID As String, _
        ByVal dblINCOME As String, _
        ByVal intECONOMYCODE As String, _
        ByVal strSPOUSEECONOMYCODE As String, _
        ByVal blnSPOUSESAMEADDR As String, _
        ByVal intUserID As String)
        Dim objDB As New DBX
        Try
            objDB.ExecSP("CUSTOMERGUARANTORSave", _
            objDB.MP("@LOCIDCUST", Data.SqlDbType.Int, intLOCIDCUST), _
            objDB.MP("@CUSTID", Data.SqlDbType.BigInt, dblCUSTID), _
            objDB.MP("@NAME", Data.SqlDbType.VarChar, strNAME), _
            objDB.MP("@BIRTHPLACE", Data.SqlDbType.VarChar, strBIRTHPLACE), _
            objDB.MP("@BIRTHDATE", Data.SqlDbType.DateTime, dtBIRTHDATE), _
            objDB.MP("@TITLE", Data.SqlDbType.VarChar, strTITLE), _
            objDB.MP("@MARITALSTS", Data.SqlDbType.Int, intMARITALSTS), _
            objDB.MP("@IDTYPE", Data.SqlDbType.Int, intIDTYPE), _
            objDB.MP("@IDNUMBER", Data.SqlDbType.VarChar, strIDNUMBER), _
            objDB.MP("@GENDER", Data.SqlDbType.Int, intGENDER), _
            objDB.MP("@JOBID", Data.SqlDbType.Int, intJOBID), _
            objDB.MP("@RELATION", Data.SqlDbType.Int, intRELATION), _
            objDB.MP("@RELIGION", Data.SqlDbType.Int, intRELIGION), _
            objDB.MP("@ADDRESS", Data.SqlDbType.VarChar, strADDRESS), _
            objDB.MP("@RT", Data.SqlDbType.VarChar, strRT), _
            objDB.MP("@RW", Data.SqlDbType.VarChar, strRW), _
            objDB.MP("@KELURAHAN", Data.SqlDbType.VarChar, strKELURAHAN), _
            objDB.MP("@KECAMATAN", Data.SqlDbType.VarChar, strKECAMATAN), _
            objDB.MP("@CITY", Data.SqlDbType.VarChar, strCITY), _
            objDB.MP("@PROVINCE", Data.SqlDbType.VarChar, strPROVINCE), _
            objDB.MP("@ZIP", Data.SqlDbType.VarChar, strZIP), _
            objDB.MP("@CITYID", Data.SqlDbType.Int, intCITYID), _
            objDB.MP("@SPOUSETITLE", Data.SqlDbType.VarChar, strSPOUSETITLE), _
            objDB.MP("@SPOUSENAME", Data.SqlDbType.VarChar, strSPOUSENAME), _
            objDB.MP("@SPOUSEIDTYPE", Data.SqlDbType.Int, intSPOUSEIDTYPE), _
            objDB.MP("@SPOUSEIDNUMBER", Data.SqlDbType.VarChar, strSPOUSEIDNUMBER), _
            objDB.MP("@SPOUSEBIRTHDATE", Data.SqlDbType.DateTime, dtSPOUSEBIRTHDATE), _
            objDB.MP("@SPOUSEBIRTHPLACE", Data.SqlDbType.VarChar, strSPOUSEBIRTHPLACE), _
            objDB.MP("@SPOUSEADDRESS", Data.SqlDbType.VarChar, strSPOUSEADDRESS), _
            objDB.MP("@SPOUSEJOBID", Data.SqlDbType.Int, intSPOUSEJOBID), _
            objDB.MP("@SPOUSEKEL", Data.SqlDbType.VarChar, strSPOUSEKEL), _
            objDB.MP("@SPOUSEKEC", Data.SqlDbType.VarChar, strSPOUSEKEC), _
            objDB.MP("@SPOUSECITY", Data.SqlDbType.VarChar, strSPOUSECITY), _
            objDB.MP("@SPOUSEPROV", Data.SqlDbType.VarChar, strSPOUSEPROV), _
            objDB.MP("@SPOUSEZIP", Data.SqlDbType.VarChar, strSPOUSEZIP), _
            objDB.MP("@SPOUSERT", Data.SqlDbType.VarChar, strSPOUSERT), _
            objDB.MP("@SPOUSERW", Data.SqlDbType.VarChar, strSPOUSERW), _
            objDB.MP("@SPOUSEJOBTITLEID", Data.SqlDbType.Int, intSPOUSEJOBTITLEID), _
            objDB.MP("@JOBTITLEID", Data.SqlDbType.Int, intJOBTITLEID), _
            objDB.MP("@INCOME", Data.SqlDbType.Money, dblINCOME), _
            objDB.MP("@ECONOMYCODE", Data.SqlDbType.Int, intECONOMYCODE), _
            objDB.MP("@SPOUSEECONOMYCODE", Data.SqlDbType.VarChar, strSPOUSEECONOMYCODE), _
            objDB.MP("@SPOUSESAMEADDR", Data.SqlDbType.VarChar, blnSPOUSESAMEADDR), _
            objDB.MP("@USERID", Data.SqlDbType.VarChar, intUserID))
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub


    Public Sub CUSTOMERGUARANTORCORPSave( _
            ByVal intLOCIDCUST As String, _
            ByVal dblCUSTID As String, _
            ByVal strCOMPANYNAME As String, _
            ByVal intECONOMYCODE As String, _
            ByVal strDEEDNO As String, _
            ByVal dtDEEDATE As String, _
            ByVal strNPWP As String, _
            ByVal strADDRESS As String, _
            ByVal strRT As String, _
            ByVal strRW As String, _
            ByVal strKELURAHAN As String, _
            ByVal strKECAMATAN As String, _
            ByVal strCITY As String, _
            ByVal strPROVINCE As String, _
            ByVal strZIP As String, _
            ByVal intUserID As String)
        Dim objDB As New DBX
        Try
            objDB.ExecSP("CUSTOMERGUARANTORCORPSave", _
                objDB.MP("@LOCIDCUST", Data.SqlDbType.Int, intLOCIDCUST), _
                objDB.MP("@CUSTID", Data.SqlDbType.BigInt, dblCUSTID), _
                objDB.MP("@COMPANYNAME", Data.SqlDbType.VarChar, strCOMPANYNAME), _
                objDB.MP("@ECONOMYCODE", Data.SqlDbType.Int, intECONOMYCODE), _
                objDB.MP("@DEEDNO", Data.SqlDbType.VarChar, strDEEDNO), _
                objDB.MP("@DEEDDATE", Data.SqlDbType.DateTime, dtDEEDATE), _
                objDB.MP("@NPWP", Data.SqlDbType.VarChar, strNPWP, 90), _
                objDB.MP("@ADDRESS", Data.SqlDbType.VarChar, strADDRESS), _
                objDB.MP("@RT", Data.SqlDbType.VarChar, strRT), _
                objDB.MP("@RW", Data.SqlDbType.VarChar, strRW), _
                objDB.MP("@KELURAHAN", Data.SqlDbType.VarChar, strKELURAHAN), _
                objDB.MP("@KECAMATAN", Data.SqlDbType.VarChar, strKECAMATAN), _
                objDB.MP("@CITY", Data.SqlDbType.VarChar, strCITY), _
                objDB.MP("@PROVINCE", Data.SqlDbType.VarChar, strPROVINCE), _
                objDB.MP("@ZIP", Data.SqlDbType.VarChar, strZIP), _
                objDB.MP("@USERID", Data.SqlDbType.VarChar, intUserID))
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub


    Public Sub APPLICATIONSave(ByVal intLOCID As Integer, _
        ByVal dblAPPID As Double, _
        ByVal dtREQUESTDATE As String, _
        ByVal blnROWLOCK As Boolean, _
        ByVal dtSTATUSDATE As String, _
        ByVal intAPPSTATUS As String, _
        ByVal intAPPSTATE As Integer, _
        ByVal strDESCRIPTION As String, _
        ByVal intAPPTYPE As String, _
        ByVal intSALESOURCE As String, _
        ByVal intMARKETINGID As String, _
        ByVal intSURVEYORID As String, _
        ByVal intUSERID As Integer, _
        Optional ByRef dblNEWAPPID As String = "0" _
     )

        Dim objDB As New DBX
        Try
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("APPLICATIONSave", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID), _
             objDB.MP("@REQUESTDATE", Data.SqlDbType.DateTime, dtREQUESTDATE), _
             objDB.MP("@ROWLOCK", Data.SqlDbType.Bit, blnROWLOCK), _
             objDB.MP("@STATUSDATE", Data.SqlDbType.DateTime, dtSTATUSDATE), _
             objDB.MP("@APPSTATUS", Data.SqlDbType.TinyInt, intAPPSTATUS), _
             objDB.MP("@APPSTATE", Data.SqlDbType.Int, intAPPSTATE), _
             objDB.MP("@DESCRIPTION", Data.SqlDbType.VarChar, strDESCRIPTION), _
             objDB.MP("@APPTYPE", Data.SqlDbType.Int, intAPPTYPE), _
             objDB.MP("@SALESOURCE", Data.SqlDbType.Int, intSALESOURCE), _
             objDB.MP("@MARKETINGID", Data.SqlDbType.Int, intMARKETINGID), _
             objDB.MP("@SURVEYORID", Data.SqlDbType.Int, intSURVEYORID), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
             objDB.MP("@NEWAPPID", Data.SqlDbType.BigInt, dblNEWAPPID, Data.ParameterDirection.InputOutput) _
            )

            dblNEWAPPID = oSQLParam("@NEWAPPID").Value.ToString()
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub APPLICATIONSaveFromCust(ByVal intLOCID As Integer, _
        ByVal dblAPPID As Double, _
        ByVal dtREQUESTDATE As String, _
        ByVal blnROWLOCK As Boolean, _
        ByVal dtSTATUSDATE As String, _
        ByVal intAPPSTATUS As String, _
        ByVal intAPPSTATE As Integer, _
        ByVal intAPPTYPE As String, _
        ByVal intSALESOURCE As String, _
        ByVal intMARKETINGID As String, _
        ByVal intSURVEYORID As String, _
        ByVal strDESCRIPTION As String, _
        ByVal intUSERID As Integer, _
        Optional ByRef dblNEWAPPID As String = "0" _
    )
        Dim objDB As New DBX
        Try
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("APPLICATIONSaveFromCust", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID), _
             objDB.MP("@REQUESTDATE", Data.SqlDbType.DateTime, dtREQUESTDATE), _
             objDB.MP("@ROWLOCK", Data.SqlDbType.Bit, blnROWLOCK), _
             objDB.MP("@STATUSDATE", Data.SqlDbType.DateTime, dtSTATUSDATE), _
             objDB.MP("@APPSTATUS", Data.SqlDbType.TinyInt, intAPPSTATUS), _
             objDB.MP("@APPSTATE", Data.SqlDbType.Int, intAPPSTATE), _
             objDB.MP("@APPTYPE", Data.SqlDbType.Int, intAPPTYPE), _
             objDB.MP("@SALESOURCE", Data.SqlDbType.Int, intSALESOURCE), _
             objDB.MP("@MARKETINGID", Data.SqlDbType.Int, intMARKETINGID), _
             objDB.MP("@SURVEYORID", Data.SqlDbType.Int, intSURVEYORID), _
             objDB.MP("@DESCRIPTION", Data.SqlDbType.VarChar, strDESCRIPTION), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
             objDB.MP("@NEWAPPID", Data.SqlDbType.BigInt, dblNEWAPPID, Data.ParameterDirection.InputOutput) _
            )
            dblNEWAPPID = oSQLParam("@NEWAPPID").Value.ToString()
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub ACCOUNTSave(ByVal intLOCID As Integer, _
        ByVal dblACCID As Double, _
        ByVal dblAPPID As Double, _
        ByVal strACCOUNTNAME As String, _
        ByVal dtBOOKINGDATE As String, _
        ByVal intLOCIDCUST As Integer, _
        ByVal dblCUSTID As Double, _
        ByVal intBRANCHID As String, _
        ByVal intACCSTATUS As String, _
        ByVal dblPRINCIPALTOTAL As String, _
        ByVal intTENOR As String, _
        ByVal intLOANTYPE As String, _
        ByVal dblFLATRATE As String, _
        ByVal dblEFFECTIVERATE As String, _
        ByVal dblINSTALLMENT As String, _
        ByVal intINSTALLMENTDAY As String, _
        ByVal dblDEPOSIT As String, _
        ByVal strREfNo As String, _
        ByVal intUSERID As Integer, _
        Optional ByRef dblNEWACCID As String = "0" _
     )
        Dim objDB As New DBX
        Try
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("ACCOUNTSave", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID), _
             objDB.MP("@ACCOUNTNAME", Data.SqlDbType.VarChar, strACCOUNTNAME), _
             objDB.MP("@BOOKINGDATE", Data.SqlDbType.DateTime, dtBOOKINGDATE), _
             objDB.MP("@LOCIDCUST", Data.SqlDbType.Int, intLOCIDCUST), _
             objDB.MP("@CUSTID", Data.SqlDbType.BigInt, dblCUSTID), _
             objDB.MP("@BRANCHID", Data.SqlDbType.Int, intBRANCHID), _
             objDB.MP("@ACCSTATUS", Data.SqlDbType.SmallInt, intACCSTATUS), _
             objDB.MP("@PRINCIPALTOTAL", Data.SqlDbType.Money, dblPRINCIPALTOTAL), _
             objDB.MP("@TENOR", Data.SqlDbType.Int, intTENOR), _
             objDB.MP("@LOANTYPE", Data.SqlDbType.TinyInt, intLOANTYPE), _
             objDB.MP("@FLATRATE", Data.SqlDbType.Float, dblFLATRATE), _
             objDB.MP("@EFFECTIVERATE", Data.SqlDbType.Float, dblEFFECTIVERATE), _
             objDB.MP("@INSTALLMENT", Data.SqlDbType.Money, dblINSTALLMENT), _
             objDB.MP("@INSTALLMENTDAY", Data.SqlDbType.SmallInt, intINSTALLMENTDAY), _
             objDB.MP("@DEPOSIT", Data.SqlDbType.Money, dblDEPOSIT), _
             objDB.MP("@REFNO", Data.SqlDbType.VarChar, strREfNo), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
             objDB.MP("@NEWACCID", Data.SqlDbType.BigInt, dblNEWACCID, Data.ParameterDirection.InputOutput) _
            )
            dblNEWACCID = oSQLParam("@NEWACCID").Value.ToString()
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Public Sub ACCOUNTSaveFromLoan(ByVal intLOCID As Integer, _
        ByVal dblACCID As Double, _
        ByVal intACCSTATUS As String, _
        ByVal dblOBJECTVALUE As String, _
        ByVal dblDOWNPAYMENT As String, _
        ByVal dblPRINCIPALTOTAL As String, _
        ByVal dblINTERESTTOTAL As String, _
        ByVal intTENOR As String, _
        ByVal intLOANTYPE As String, _
        ByVal dblFLATRATE As String, _
        ByVal dblEFFECTIVERATE As String, _
        ByVal dblRESIDUALVALUE As String, _
        ByVal dblINSTALLMENT As String, _
        ByVal dblINSTALLMENTREAL As String, _
        ByVal dblDEPOSIT As String, _
        ByVal intINSPAIDBY As String, _
        ByVal intINSVALBASEON As String, _
        ByVal intUSERID As Integer, _
        Optional ByRef dblNEWACCID As String = "0", _
        Optional ByRef intPACKETID As String = "",
        Optional ByRef intINSTALLMENTTYPE As String = "1", _
        Optional ByRef intCURRENCYID As String = "1")

        Dim objDB As New DBX
        Try
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("ACCOUNTSaveFromLoan", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
             objDB.MP("@ACCSTATUS", Data.SqlDbType.SmallInt, intACCSTATUS), _
             objDB.MP("@OBJECTVALUE", Data.SqlDbType.Money, dblOBJECTVALUE), _
             objDB.MP("@DOWNPAYMENT", Data.SqlDbType.Money, dblDOWNPAYMENT), _
             objDB.MP("@PRINCIPALTOTAL", Data.SqlDbType.Money, dblPRINCIPALTOTAL), _
             objDB.MP("@INTERESTTOTAL", Data.SqlDbType.Money, dblINTERESTTOTAL), _
             objDB.MP("@TENOR", Data.SqlDbType.Int, intTENOR), _
             objDB.MP("@LOANTYPE", Data.SqlDbType.TinyInt, intLOANTYPE), _
             objDB.MP("@FLATRATE", Data.SqlDbType.Float, dblFLATRATE), _
             objDB.MP("@EFFECTIVERATE", Data.SqlDbType.Float, dblEFFECTIVERATE), _
             objDB.MP("@RESIDUALVALUE", Data.SqlDbType.Money, dblRESIDUALVALUE), _
             objDB.MP("@INSTALLMENT", Data.SqlDbType.Money, dblINSTALLMENT), _
             objDB.MP("@INSTALLMENTREAL", Data.SqlDbType.Money, dblINSTALLMENTREAL), _
             objDB.MP("@DEPOSIT", Data.SqlDbType.Money, dblDEPOSIT), _
             objDB.MP("@INSPAIDBY", Data.SqlDbType.Int, intINSPAIDBY), _
             objDB.MP("@INSVALBASEON", Data.SqlDbType.Int, intINSVALBASEON), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
             objDB.MP("@PACKETID", Data.SqlDbType.Int, intPACKETID), _
             objDB.MP("@INSTALLMENTTYPE", Data.SqlDbType.Int, intINSTALLMENTTYPE), _
             objDB.MP("@CURRENCYID", Data.SqlDbType.Int, intCURRENCYID), _
             objDB.MP("@NEWACCID", Data.SqlDbType.BigInt, dblNEWACCID, Data.ParameterDirection.InputOutput) _
            )
            dblNEWACCID = oSQLParam("@NEWACCID").Value.ToString()
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Public Sub ACCOUNTSaveFromCust(ByVal intLOCID As Integer, _
        ByVal dblACCID As Double, _
        ByVal dblAPPID As Double, _
        ByVal strACCOUNTNAME As String, _
        ByVal dtBOOKINGDATE As String, _
        ByVal intLOCIDCUST As Integer, _
        ByVal dblCUSTID As Double, _
        ByVal intBRANCHID As String, _
        ByVal intACCSTATUS As String, _
        ByVal intINSTALLMENTDAY As String, _
        ByVal dblDEPOSIT As String, _
        ByVal strREfNo As String, _
        ByVal intUSERID As Integer, _
        Optional ByRef dblNEWACCID As String = "0" _
        )
        Dim objDB As New DBX
        Try
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("ACCOUNTSaveFromCust", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID), _
             objDB.MP("@ACCOUNTNAME", Data.SqlDbType.VarChar, strACCOUNTNAME), _
             objDB.MP("@BOOKINGDATE", Data.SqlDbType.DateTime, dtBOOKINGDATE), _
             objDB.MP("@LOCIDCUST", Data.SqlDbType.Int, intLOCIDCUST), _
             objDB.MP("@CUSTID", Data.SqlDbType.BigInt, dblCUSTID), _
             objDB.MP("@BRANCHID", Data.SqlDbType.Int, intBRANCHID), _
             objDB.MP("@ACCSTATUS", Data.SqlDbType.SmallInt, intACCSTATUS), _
             objDB.MP("@INSTALLMENTDAY", Data.SqlDbType.SmallInt, intINSTALLMENTDAY), _
             objDB.MP("@DEPOSIT", Data.SqlDbType.Money, dblDEPOSIT), _
             objDB.MP("@REFNO", Data.SqlDbType.VarChar, strREfNo), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
             objDB.MP("@NEWACCID", Data.SqlDbType.BigInt, dblNEWACCID, Data.ParameterDirection.InputOutput) _
            )
            dblNEWACCID = oSQLParam("@NEWACCID").Value.ToString()
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub ACCOUNTDTLSave(ByVal intLOCID As Integer, _
         ByVal dblACCID As Double, _
         ByVal dblADMFEE As String, _
         ByVal intCOUNTRYID As String, _
         ByVal intTYPEOFUSEID As String, _
         ByVal intORIENTATIONOFUSEID As String, _
         ByVal intDEBITURCATID As String, _
         ByVal intPORTFOLIOCATID As String, _
         ByVal intCREDITTYPEID As String, _
         ByVal intCREDITATTRIBUTEID As String, _
         ByVal intCREDITCATID As String, _
         ByVal intUSERID As Integer)

        'ByVal intBINDTYPEID As String, _
        'ByVal intCOLLATERALTYPEID As String, _
        'ByVal intSBRANKID As String, _

        Dim objDB As New DBX
        Try
            objDB.ExecSP("ACCOUNTDTLSave", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
             objDB.MP("@ADMFEE", Data.SqlDbType.Money, dblADMFEE), _
             objDB.MP("@COUNTRYID", Data.SqlDbType.Int, intCOUNTRYID), _
             objDB.MP("@TYPEOFUSEID", Data.SqlDbType.Int, intTYPEOFUSEID), _
             objDB.MP("@ORIENTATIONOFUSEID", Data.SqlDbType.Int, intORIENTATIONOFUSEID), _
             objDB.MP("@DEBITURCATID", Data.SqlDbType.Int, intDEBITURCATID), _
             objDB.MP("@PORTFOLIOCATID", Data.SqlDbType.Int, intPORTFOLIOCATID), _
             objDB.MP("@CREDITTYPEID", Data.SqlDbType.Int, intCREDITTYPEID), _
             objDB.MP("@CREDITATTRIBUTEID", Data.SqlDbType.Int, intCREDITATTRIBUTEID), _
             objDB.MP("@CREDITCATID", Data.SqlDbType.Int, intCREDITCATID), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID))

            'objDB.MP("@COLLATERALTYPEID", Data.SqlDbType.Int, intCOLLATERALTYPEID), _
            'objDB.MP("@BINDTYPEID", Data.SqlDbType.Int, intBINDTYPEID), _
            'objDB.MP("@SBRANKID", Data.SqlDbType.Int, intSBRANKID), _
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub ACCOUNTDTLSaveFromLoan(ByVal intLOCID As Integer, _
        ByVal dblACCID As Double, _
        ByVal dblADMFEE As String, _
        ByVal dblFIDUCIAFEE As String, _
        ByVal dblCHECKDOCFEE As String, _
        ByVal dblSURVEYFEE As String, _
        ByVal dblSETOFFVALUE As String, _
        ByVal dblRECOMMENDOBJVALUE As String, _
        ByVal dblMINIMUMDP As String, _
        ByVal dblMAXFUNDING As String, _
        ByVal dblREALDP As String, _
        ByVal dblFNFIDUCIAFEE As String, _
        ByVal dblFNADMINFEE As String, _
        ByVal dblFNCHECKDOCFEE As String, _
        ByVal dblFLATRATEOTH As String, _
        ByVal dblEFFRATEOTH As String, _
        ByVal dblFLATRATEOTHParam As String, _
        ByVal dblEFFRATEOTHParam As String, _
        ByVal dblDEALERSUBSIDIES As String, _
        ByVal intUSERID As Integer)



        Dim objDB As New DBX
        Try
            objDB.ExecSP("ACCOUNTDTLSaveFromLoan", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
             objDB.MP("@ADMFEE", Data.SqlDbType.Money, dblADMFEE), _
             objDB.MP("@FIDUCIAFEE", Data.SqlDbType.Money, dblFIDUCIAFEE), _
             objDB.MP("@CHECKDOCFEE", Data.SqlDbType.Money, dblCHECKDOCFEE), _
             objDB.MP("@SURVEYFEE", Data.SqlDbType.Money, dblSURVEYFEE), _
             objDB.MP("@SETOFFVALUE", Data.SqlDbType.Money, dblSETOFFVALUE), _
             objDB.MP("@RECOMMENDOBJVALUE", Data.SqlDbType.Money, dblRECOMMENDOBJVALUE), _
             objDB.MP("@MINIMUMDP", Data.SqlDbType.Money, dblMINIMUMDP), _
             objDB.MP("@MAXFUNDING", Data.SqlDbType.Money, dblMAXFUNDING), _
             objDB.MP("@REALDP", Data.SqlDbType.Money, dblREALDP), _
             objDB.MP("@FNFIDUCIAFEE", Data.SqlDbType.Money, dblFNFIDUCIAFEE), _
             objDB.MP("@FNADMINFEE", Data.SqlDbType.Money, dblFNADMINFEE), _
             objDB.MP("@FNCHECKDOCFEE", Data.SqlDbType.Money, dblFNCHECKDOCFEE), _
             objDB.MP("@FLATRATEOTH", Data.SqlDbType.Float, dblFLATRATEOTH), _
             objDB.MP("@EFFRATEOTH", Data.SqlDbType.Float, dblEFFRATEOTH), _
             objDB.MP("@FLATRATEOTHPARAM", Data.SqlDbType.Float, dblFLATRATEOTHParam), _
             objDB.MP("@EFFRATEOTHPARAM", Data.SqlDbType.Float, dblEFFRATEOTHParam), _
             objDB.MP("@DEALERSUBSIDIES", Data.SqlDbType.Float, dblDEALERSUBSIDIES), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID))

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Public Sub ACCOUNTDTLSaveFromCust(ByVal intLOCID As Integer, _
         ByVal dblACCID As Double, _
         ByVal intCOUNTRYID As String, _
         ByVal intTYPEOFUSEID As String, _
         ByVal intORIENTATIONOFUSEID As String, _
         ByVal intDEBITURCATID As String, _
         ByVal intPORTFOLIOCATID As String, _
         ByVal intCREDITTYPEID As String, _
         ByVal intCREDITATTRIBUTEID As String, _
         ByVal intCREDITCATID As String, _
         ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("ACCOUNTDTLSaveFromCust", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
             objDB.MP("@COUNTRYID", Data.SqlDbType.Int, intCOUNTRYID), _
             objDB.MP("@TYPEOFUSEID", Data.SqlDbType.Int, intTYPEOFUSEID), _
             objDB.MP("@ORIENTATIONOFUSEID", Data.SqlDbType.Int, intORIENTATIONOFUSEID), _
             objDB.MP("@DEBITURCATID", Data.SqlDbType.Int, intDEBITURCATID), _
             objDB.MP("@PORTFOLIOCATID", Data.SqlDbType.Int, intPORTFOLIOCATID), _
             objDB.MP("@CREDITTYPEID", Data.SqlDbType.Int, intCREDITTYPEID), _
             objDB.MP("@CREDITATTRIBUTEID", Data.SqlDbType.Int, intCREDITATTRIBUTEID), _
             objDB.MP("@CREDITCATID", Data.SqlDbType.Int, intCREDITCATID), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID))

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub APPLICATIONMATCHUpdate(ByVal intLOCID As Integer, _
     ByVal dblAPPID As Double, _
     ByVal intLOCIDCUSTMATCH As String, _
     ByVal intCUSTIDMATCH As String, _
     ByVal intMATCHSTS As String, _
     ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("APPLICATIONMATCHUpdate", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID), _
             objDB.MP("@LOCIDCUSTMATCH", Data.SqlDbType.Int, intLOCIDCUSTMATCH), _
             objDB.MP("@CUSTIDMATCH", Data.SqlDbType.BigInt, intCUSTIDMATCH), _
             objDB.MP("@MATCHSTS", Data.SqlDbType.Int, intMATCHSTS), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Public Function APPLICATIONProceed(ByVal intLOCID As Integer, _
     ByVal dblAPPID As Double, _
     ByVal intUSERID As Integer) As Integer

        Dim objDB As New DBX
        Try
            APPLICATIONProceed = objDB.ExecSPWithRC("APPLICATIONProceed", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function APPLICATIONProceedBatch( _
     ByVal dtREQUESTDATE As Date, _
     ByVal dblBRANCHID As Double, _
     ByVal dblAPPSTATE As Double, _
     ByVal intUSERID As Integer) As Integer

        Dim objDB As New DBX
        Try
            APPLICATIONProceedBatch = objDB.ExecSPWithRC("APPLICATIONProceedBatch", _
             objDB.MP("@REQUESTDATE", Data.SqlDbType.DateTime, dtREQUESTDATE), _
             objDB.MP("@BRANCHID", Data.SqlDbType.Int, dblBRANCHID), _
             objDB.MP("@APPSTATE", Data.SqlDbType.Int, dblAPPSTATE), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function APPLICATIONProceedRequest( _
     ByVal dtREQUESTDATE As Date, _
     ByVal dblAPPSTATE As Double, _
     ByVal intUSERID As Integer) As Integer

        Dim objDB As New DBX
        Try
            APPLICATIONProceedRequest = objDB.ExecSPWithRC("APPLICATIONProceedRequest", _
             objDB.MP("@REQUESTDATE", Data.SqlDbType.DateTime, dtREQUESTDATE), _
             objDB.MP("@APPSTATE", Data.SqlDbType.Int, dblAPPSTATE), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Sub APPLICATIONReturn(ByVal intLOCID As Integer, _
     ByVal dblAPPID As Double, _
     ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("APPLICATIONReturn", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub APPLICATIONReturnBatch( _
     ByVal dtREQUESTDATE As Date, _
     ByVal dblBRANCHID As Double, _
     ByVal dblAPPSTATE As Double, _
     ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("APPLICATIONReturnBatch", _
             objDB.MP("@REQUESTDATE", Data.SqlDbType.DateTime, dtREQUESTDATE), _
             objDB.MP("@BRANCHID", Data.SqlDbType.Int, dblBRANCHID), _
             objDB.MP("@APPSTATE", Data.SqlDbType.Int, dblAPPSTATE), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub APPLICATIONReturnRequest( _
     ByVal dtREQUESTDATE As Date, _
     ByVal dblAPPSTATE As Double, _
     ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("APPLICATIONReturnRequest", _
             objDB.MP("@REQUESTDATE", Data.SqlDbType.DateTime, dtREQUESTDATE), _
             objDB.MP("@APPSTATE", Data.SqlDbType.Int, dblAPPSTATE), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub APPLICATIONRejectManual(ByVal intLOCID As Integer, _
     ByVal dblAPPID As Double, _
     ByVal intREASONID As Integer, _
     ByVal strREMARK As String, _
     ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("APPLICATIONRejectManual", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID), _
             objDB.MP("@REASONID", Data.SqlDbType.Int, intREASONID), _
             objDB.MP("@REMARK", Data.SqlDbType.VarChar, strREMARK), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Public Sub APPLICATIONRejectManualBatch( _
         ByVal dtREQUESTDATE As Date, _
         ByVal dblBRANCHID As Double, _
         ByVal dblAPPSTATE As Double, _
         ByVal intREASONID As Integer, _
         ByVal strREMARK As String, _
         ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("APPLICATIONRejectManualBatch", _
             objDB.MP("@REQUESTDATE", Data.SqlDbType.DateTime, dtREQUESTDATE), _
             objDB.MP("@BRANCHID", Data.SqlDbType.Int, dblBRANCHID), _
             objDB.MP("@APPSTATE", Data.SqlDbType.Int, dblAPPSTATE), _
             objDB.MP("@REASONID", Data.SqlDbType.Int, intREASONID), _
             objDB.MP("@REMARK", Data.SqlDbType.VarChar, strREMARK), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub APPLICATIONRejectManualRequest( _
         ByVal dtREQUESTDATE As Date, _
         ByVal dblAPPSTATE As Double, _
         ByVal intREASONID As Integer, _
         ByVal strREMARK As String, _
         ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("APPLICATIONRejectManualRequest", _
             objDB.MP("@REQUESTDATE", Data.SqlDbType.DateTime, dtREQUESTDATE), _
             objDB.MP("@APPSTATE", Data.SqlDbType.Int, dblAPPSTATE), _
             objDB.MP("@REASONID", Data.SqlDbType.Int, intREASONID), _
             objDB.MP("@REMARK", Data.SqlDbType.VarChar, strREMARK), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Public Sub APPLICATIONUpdateAppState(ByVal intLOCID As Integer, _
     ByVal dblAPPID As Double, _
     ByVal intAPPSTATE As Integer, _
     ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("APPLICATIONUpdateAppState", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID), _
             objDB.MP("@APPSTATE", Data.SqlDbType.Int, intAPPSTATE), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub APPLICATIONUpdateAppStatus(ByVal intLOCID As Integer, _
     ByVal dblAPPID As Double, _
     ByVal intAPPSTATUS As Integer, _
     ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("APPLICATIONUpdateAppStatus", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID), _
             objDB.MP("@APPSTATUS", Data.SqlDbType.Int, intAPPSTATUS), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub APPLICATIONBooking(ByVal intLOCID As Integer, _
     ByVal dblAPPID As Double, _
     ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("APPLICATIONBooking", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Public Sub APPROWLOCK(ByVal intLOCID As Integer, _
     ByVal dblAPPID As Double, _
     ByVal intUserID As Integer, _
     Optional ByVal intRowLock As Integer = 1)
        Dim objDB As New DBX
        Try
            objDB.ExecSQLNoTxn("UPDATE APPLICATION SET LASTUSERID=" + intUserID.ToString() + ", ROWLOCK=" + intRowLock.ToString() + " WHERE LOCID=" & intLOCID.ToString() & " AND APPID=" & dblAPPID.ToString())
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Function getFIRSTSTATE() As String
        getFIRSTSTATE = "10"
        Dim objDB As New DBX
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getFirstState() FIRSTSTATE")
            If oSDR.Read Then
                getFIRSTSTATE = oSDR("FIRSTSTATE").ToString()
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function getNextState(ByVal strCurState As String) As String
        getNextState = ""
        Dim objDB As New DBX
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getNextState(" & strCurState & ") NEXTSTATE")
            If oSDR.Read Then
                getNextState = oSDR("NEXTSTATE").ToString()
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function IsENDSTATE(ByVal strCurState As String) As Integer
        IsENDSTATE = 0
        Dim objDB As New DBX
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_IsEndState(" + strCurState + ") EndState")
            If oSDR.Read Then
                If oSDR("EndState") = "1" Then
                    IsENDSTATE = 1
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
    End Function

    Public Function isVALIDATIONSTATE(ByVal strCurState As String) As Integer
        isVALIDATIONSTATE = 0
        Dim objDB As New DBX
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_IsValidationState(" + strCurState + ") ValidState")
            If oSDR.Read Then
                If oSDR("ValidState") = 1 Then
                    isVALIDATIONSTATE = 1
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
    End Function

    Public Function APPLICATIONValidation(ByVal intLOCID As Integer, _
     ByVal dblAPPID As Double, _
     ByVal intUSERID As Integer) As Boolean

        Dim objDB As New DBX
        Try
            Dim blnValid As Boolean = True
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection

            oSQLParam = objDB.ExecSPReturnParam("APPLICATIONValidation", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
             objDB.MP("@bValid", Data.SqlDbType.Bit, blnValid, 8, Data.ParameterDirection.Output) _
            )
            blnValid = oSQLParam("@bValid").Value
            APPLICATIONValidation = blnValid

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Sub APPLICATIONReverseBooking(ByVal intLOCID As Integer, _
     ByVal dblAPPID As Double, _
     ByVal intUSERID As Integer)


        Dim objDB As New DBX
        Try

            objDB.ExecSP("APPLICATIONReverseBooking", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub

    Public Sub WORKSHEETXADD(ByVal intPoBuyerHdrID As Integer, _
     ByVal intCostingHdrID As Integer, ByVal intWSNumberX As String, _
     ByVal intUserid As Integer)
        Dim objDB As New DBX

        Try

            objDB.ExecSP("WORKSHEETXADD", _
             objDB.MP("@WORKSHEETNUMBERX", Data.SqlDbType.VarChar, intWSNumberX), _
             objDB.MP("@POBUYERHDRID", Data.SqlDbType.BigInt, intPoBuyerHdrID), _
             objDB.MP("@COSTINGHDRID", Data.SqlDbType.BigInt, intCostingHdrID), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUserid) _
            )

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub APPLICATIONReverseBookingBatch( _
     ByVal dtBOOKINGDATE As Date, _
     ByVal dblBRANCHID As Double, _
     ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("APPLICATIONReverseBookingBatch", _
             objDB.MP("@BOOKINGDATE", Data.SqlDbType.DateTime, dtBOOKINGDATE), _
             objDB.MP("@BRANCHID", Data.SqlDbType.Int, dblBRANCHID), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub APPLICATIONReverseBookingRequest( _
         ByVal dtBOOKINGDATE As Date, _
         ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("APPLICATIONReverseBookingRequest", _
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


    Public Function APPREJECTREASONManualSave(ByVal intLOCID As Integer, _
     ByVal dblAPPID As Double, _
     ByVal intREASONID As Integer, _
     ByVal strREMARK As String, _
     ByVal intUSERID As Integer) As Boolean

        Dim objDB As New DBX
        Try
            objDB.ExecSP("APPREJECTREASONManualSave", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID), _
             objDB.MP("@REASONID", Data.SqlDbType.BigInt, intREASONID), _
             objDB.MP("@REMARK", Data.SqlDbType.VarChar, strREMARK), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
            APPREJECTREASONManualSave = 0
        Catch ex As Exception
            APPREJECTREASONManualSave = -1
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function


    Public Function APPREJECTREASONDelete(ByVal intLOCID As Integer, _
     ByVal dblAPPID As Double, _
     ByVal intUSERID As Integer) As Boolean
        Dim objDB As New DBX
        Try
            objDB.ExecSP("APPREJECTREASONDelete", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
            APPREJECTREASONDelete = 0
        Catch ex As Exception
            APPREJECTREASONDelete = -1
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Function ACCUPLOADTransfer( _
     ByVal intUSERID As Integer) As Integer
        Dim objDB As New DBX
        Try
            ACCUPLOADTransfer = objDB.ExecSPReturnInteger("ACCUPLOADTransfer", _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function

    Public Sub ACCUPLOADDelete(ByVal intUSERID As Integer)
        Dim objDB As New DBX
        Try
            objDB.ExecSP("ACCUPLOADDelete", _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub ACCUPLOADDeleteByBranchID( _
      ByVal strBranchID As String, _
      ByVal intUSERID As Integer)
        Dim objDB As New DBX
        Try
            objDB.ExecSP("ACCUPLOADDeleteByBRANCHID", _
             objDB.MP("@BRANCHID", Data.SqlDbType.VarChar, strBranchID), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub COLLATERALSave(ByVal intLOCID As Integer, _
     ByVal dblACCID As Double, _
     ByVal dblDEALERID As String, _
     ByVal intProductID As String, _
     ByVal intMERKID As String, _
     ByVal intMODELID As String, _
     ByVal dblOBJECTTYPEID As String, _
     ByVal strBPKBNO As String, _
     ByVal dtBPKBDATE As Date, _
     ByVal strBPKBADDRESS As String, _
     ByVal strBPKBCITYID As String, _
     ByVal strBPKBNAME As String, _
     ByVal strBPKBOWNERID As String, _
     ByVal strBPKBCARTYPE As String, _
     ByVal strENGINENO As String, _
     ByVal strCHASSISNO As String, _
     ByVal intCARYEAR As String, _
     ByVal intBUILDYEAR As String, _
     ByVal intCONDITION As String, _
     ByVal strCOLOR As String, _
     ByVal strCATEGORYID As String, _
     ByVal strPURPOSEID As String, _
     ByVal strPOLICENO As String, _
     ByVal dtSTNKEXPIRED As Date, _
     ByVal dtSURVEYDATE As Date, _
     ByVal intUSERID As Integer, _
     ByVal intBINDTYPEID As String, _
     ByVal intCOLLATERALTYPEID As String, _
     ByVal intSBRANKID As String, _
     ByVal dblROUTEID As String, _
     ByVal dblCOLLATERALVALUE As String, _
     ByVal strFakturNo As String, _
     ByVal strFakturName As String, _
     ByVal dtKPExpired As String, _
     ByVal dtSKExpired As String, _
     ByVal intCC As String, _
     Optional ByRef dblOBJID As Double = 0)

        Dim objDB As New DBX
        Try
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("COLLATERALSave", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
             objDB.MP("@DEALERID", Data.SqlDbType.VarChar, dblDEALERID), _
             objDB.MP("@PRODUCTID", Data.SqlDbType.VarChar, intProductID), _
             objDB.MP("@MERKID", Data.SqlDbType.VarChar, intMERKID), _
             objDB.MP("@MODELID", Data.SqlDbType.VarChar, intMODELID), _
             objDB.MP("@OBJECTTYPEID", Data.SqlDbType.VarChar, dblOBJECTTYPEID), _
             objDB.MP("@BPKBNO", Data.SqlDbType.VarChar, strBPKBNO), _
             objDB.MP("@BPKBDATE", Data.SqlDbType.DateTime, dtBPKBDATE), _
             objDB.MP("@BPKBADDRESS", Data.SqlDbType.VarChar, strBPKBADDRESS), _
             objDB.MP("@BPKBCITYID", Data.SqlDbType.VarChar, strBPKBCITYID), _
             objDB.MP("@BPKBNAME", Data.SqlDbType.VarChar, strBPKBNAME), _
             objDB.MP("@BPKBOWNERID", Data.SqlDbType.VarChar, strBPKBOWNERID), _
             objDB.MP("@BPKBCARTYPE", Data.SqlDbType.VarChar, strBPKBCARTYPE), _
             objDB.MP("@ENGINENO", Data.SqlDbType.VarChar, strENGINENO), _
             objDB.MP("@CHASSISNO", Data.SqlDbType.VarChar, strCHASSISNO), _
             objDB.MP("@CARYEAR", Data.SqlDbType.VarChar, intCARYEAR), _
             objDB.MP("@BUILDYEAR", Data.SqlDbType.VarChar, intBUILDYEAR), _
             objDB.MP("@CONDITION", Data.SqlDbType.VarChar, intCONDITION), _
             objDB.MP("@COLOR", Data.SqlDbType.VarChar, strCOLOR), _
             objDB.MP("@CATEGORYID", Data.SqlDbType.VarChar, strCATEGORYID), _
             objDB.MP("@PURPOSEID", Data.SqlDbType.VarChar, strPURPOSEID), _
             objDB.MP("@POLICENO", Data.SqlDbType.VarChar, strPOLICENO), _
             objDB.MP("@STNKEXPIRED", Data.SqlDbType.DateTime, dtSTNKEXPIRED), _
             objDB.MP("@SURVEYDATE", Data.SqlDbType.DateTime, dtSURVEYDATE), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
             objDB.MP("@OBJID", Data.SqlDbType.BigInt, dblOBJID, 50, Data.ParameterDirection.InputOutput), _
             objDB.MP("@BINDTYPEID", Data.SqlDbType.Int, intBINDTYPEID), _
             objDB.MP("@COLLATERALTYPEID", Data.SqlDbType.Int, intCOLLATERALTYPEID), _
             objDB.MP("@SBRANKID", Data.SqlDbType.VarChar, intSBRANKID), _
             objDB.MP("@ROUTEID", Data.SqlDbType.VarChar, dblROUTEID), _
             objDB.MP("@COLATERALVALUE", Data.SqlDbType.VarChar, dblCOLLATERALVALUE), _
             objDB.MP("@FAKTURNO", Data.SqlDbType.VarChar, strFakturNo), _
             objDB.MP("@FAKTURNAME", Data.SqlDbType.VarChar, strFakturName), _
             objDB.MP("@KPEXPIRED", Data.SqlDbType.DateTime, dtKPExpired), _
             objDB.MP("@SKEXPIRED", Data.SqlDbType.DateTime, dtSKExpired), _
             objDB.MP("@CC", Data.SqlDbType.Int, intCC) _
            )
            dblOBJID = oSQLParam("@OBJID").Value.ToString()

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub



    Public Sub APPLICATIONInitilize( _
        ByVal intBRANCHID As String, _
        ByVal intAPPTYPE As String, _
        ByVal intCUSTTYPE As String, _
        ByVal strCUSTNAME As String, _
        ByVal dtBIRTDATE As String, _
        ByVal intMARITALSTATUS As String, _
        ByVal dtSPOUSEBIRTHDATE As String, _
        ByVal intMARKETINGID As String, _
        ByVal intSURVEYORID As String, _
        ByVal intSALESOURCE As String, _
        ByVal intPRODUCTID As String, _
        ByVal intCONDITION As String, _
        ByVal strCHASSISNO As String, _
        ByVal strPHONEAREA As String, _
        ByVal strPHONENO As String, _
        ByVal strNPWP As String, _
        ByVal intUSERID As Integer, _
        Optional ByRef dblLOCID As String = "0", _
        Optional ByRef dblAPPID As String = "0" _
     )

        Dim objDB As New DBX
        Try


            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("APPLICATIONInitilize", _
             objDB.MP("@BRANCHID", Data.SqlDbType.Int, intBRANCHID), _
             objDB.MP("@APPTYPE", Data.SqlDbType.Int, intAPPTYPE), _
             objDB.MP("@CUSTTYPE", Data.SqlDbType.Int, intCUSTTYPE), _
             objDB.MP("@CUSTNAME", Data.SqlDbType.VarChar, strCUSTNAME), _
             objDB.MP("@BIRTDATE", Data.SqlDbType.DateTime, dtBIRTDATE), _
             objDB.MP("@MARITALSTATUS", Data.SqlDbType.Int, intMARITALSTATUS), _
             objDB.MP("@SPOUSEBIRTHDATE", Data.SqlDbType.DateTime, dtSPOUSEBIRTHDATE), _
             objDB.MP("@MARKETINGID", Data.SqlDbType.Int, intMARKETINGID), _
             objDB.MP("@SURVEYORID", Data.SqlDbType.Int, intSURVEYORID), _
             objDB.MP("@SALESOURCE", Data.SqlDbType.Int, intSALESOURCE), _
             objDB.MP("@PRODUCTID", Data.SqlDbType.Int, intPRODUCTID), _
             objDB.MP("@CONDITION", Data.SqlDbType.Int, intCONDITION), _
             objDB.MP("@CHASSISNO", Data.SqlDbType.VarChar, strCHASSISNO), _
             objDB.MP("@PHONEAREA", Data.SqlDbType.VarChar, strPHONEAREA), _
             objDB.MP("@PHONENO", Data.SqlDbType.VarChar, strPHONENO), _
             objDB.MP("@NPWP", Data.SqlDbType.VarChar, strNPWP), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
             objDB.MP("@LOCID", Data.SqlDbType.BigInt, dblLOCID, Data.ParameterDirection.InputOutput), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID, Data.ParameterDirection.InputOutput) _
            )

            dblLOCID = oSQLParam("@LOCID").Value.ToString()
            dblAPPID = oSQLParam("@APPID").Value.ToString()
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Public Sub APPLICATIONInitilize2( _
        ByVal dtREQUESTDATE As String, _
        ByVal intBRANCHID As String, _
        ByVal intFINCATID As String, _
        ByVal intAPPTYPE As String, _
        ByVal intCUSTTYPE As String, _
        ByVal strCUSTNAME As String, _
        ByVal dtBIRTDATE As String, _
        ByVal intMARITALSTATUS As String, _
        ByVal dtSPOUSEBIRTHDATE As String, _
        ByVal intMARKETINGID As String, _
        ByVal strIDNUMBER As String, _
        ByVal intSALESOURCE As String, _
        ByVal intPRODUCTID As String, _
        ByVal intCONDITION As String, _
        ByVal strCHASSISNO As String, _
        ByVal strPHONEAREA As String, _
        ByVal strPHONENO As String, _
        ByVal strNPWP As String, _
        ByVal strADDRESS As String, _
        ByVal intUSERID As Integer, _
        Optional ByRef dblLOCID As String = "0", _
        Optional ByRef dblAPPID As String = "0" _
     )

        Dim objDB As New DBX
        Try


            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("APPLICATIONInitilizeData", _
             objDB.MP("@REQUESTDATE", Data.SqlDbType.DateTime, dtREQUESTDATE), _
             objDB.MP("@BRANCHID", Data.SqlDbType.Int, intBRANCHID), _
             objDB.MP("@FINCATID", Data.SqlDbType.Int, intFINCATID), _
             objDB.MP("@APPTYPE", Data.SqlDbType.Int, intAPPTYPE), _
             objDB.MP("@CUSTTYPE", Data.SqlDbType.Int, intCUSTTYPE), _
             objDB.MP("@CUSTNAME", Data.SqlDbType.VarChar, strCUSTNAME), _
             objDB.MP("@BIRTDATE", Data.SqlDbType.DateTime, dtBIRTDATE), _
             objDB.MP("@MARITALSTATUS", Data.SqlDbType.Int, intMARITALSTATUS), _
             objDB.MP("@SPOUSEBIRTHDATE", Data.SqlDbType.DateTime, dtSPOUSEBIRTHDATE), _
             objDB.MP("@MARKETINGID", Data.SqlDbType.Int, intMARKETINGID), _
             objDB.MP("@IDNUMBER", Data.SqlDbType.VarChar, strIDNUMBER), _
             objDB.MP("@SALESOURCE", Data.SqlDbType.Int, intSALESOURCE), _
             objDB.MP("@PRODUCTID", Data.SqlDbType.Int, intPRODUCTID), _
             objDB.MP("@CONDITION", Data.SqlDbType.Int, intCONDITION), _
             objDB.MP("@CHASSISNO", Data.SqlDbType.VarChar, strCHASSISNO), _
             objDB.MP("@PHONEAREA", Data.SqlDbType.VarChar, strPHONEAREA), _
             objDB.MP("@PHONENO", Data.SqlDbType.VarChar, strPHONENO), _
             objDB.MP("@NPWP", Data.SqlDbType.VarChar, strNPWP), _
             objDB.MP("@ADDRESS", Data.SqlDbType.VarChar, strADDRESS), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
             objDB.MP("@LOCID", Data.SqlDbType.BigInt, dblLOCID, Data.ParameterDirection.InputOutput), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID, Data.ParameterDirection.InputOutput) _
            )

            dblLOCID = oSQLParam("@LOCID").Value.ToString()
            dblAPPID = oSQLParam("@APPID").Value.ToString()
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Public Sub APPLICATIONInitilize2Update( _
        ByVal dtREQUESTDATE As String, _
        ByVal intBRANCHID As String, _
        ByVal intFINCATID As String,
        ByVal intAPPTYPE As String, _
        ByVal intCUSTTYPE As String, _
        ByVal strCUSTNAME As String, _
        ByVal dtBIRTDATE As String, _
        ByVal intMARITALSTATUS As String, _
        ByVal dtSPOUSEBIRTHDATE As String, _
        ByVal intMARKETINGID As String, _
        ByVal strIDNUMBER As String, _
        ByVal intSALESOURCE As String, _
        ByVal intPRODUCTID As String, _
        ByVal intCONDITION As String, _
        ByVal strCHASSISNO As String, _
        ByVal strPHONEAREA As String, _
        ByVal strPHONENO As String, _
        ByVal strNPWP As String, _
        ByVal strADDRESS As String, _
        ByVal intUSERID As Integer, _
        ByVal dblLOCID As Integer, _
        ByVal dblAPPID As Double, _
        ByVal dblLOCIDCUST As Integer, _
        ByVal dblCUSTID As Double, _
        ByVal dblACCID As Double, _
        ByVal dblOBJID As Double _
    )

        Dim objDB As New DBX
        Try


            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("APPLICATIONInitilizeDataUpdate", _
             objDB.MP("@REQUESTDATE", Data.SqlDbType.DateTime, dtREQUESTDATE), _
             objDB.MP("@BRANCHID", Data.SqlDbType.Int, intBRANCHID), _
             objDB.MP("@FINCATID", Data.SqlDbType.Int, intFINCATID), _
             objDB.MP("@APPTYPE", Data.SqlDbType.Int, intAPPTYPE), _
             objDB.MP("@CUSTTYPE", Data.SqlDbType.Int, intCUSTTYPE), _
             objDB.MP("@CUSTNAME", Data.SqlDbType.VarChar, strCUSTNAME), _
             objDB.MP("@BIRTDATE", Data.SqlDbType.DateTime, dtBIRTDATE), _
             objDB.MP("@MARITALSTATUS", Data.SqlDbType.Int, intMARITALSTATUS), _
             objDB.MP("@SPOUSEBIRTHDATE", Data.SqlDbType.DateTime, dtSPOUSEBIRTHDATE), _
             objDB.MP("@MARKETINGID", Data.SqlDbType.Int, intMARKETINGID), _
             objDB.MP("@IDNUMBER", Data.SqlDbType.VarChar, strIDNUMBER), _
             objDB.MP("@SALESOURCE", Data.SqlDbType.Int, intSALESOURCE), _
             objDB.MP("@PRODUCTID", Data.SqlDbType.Int, intPRODUCTID), _
             objDB.MP("@CONDITION", Data.SqlDbType.Int, intCONDITION), _
             objDB.MP("@CHASSISNO", Data.SqlDbType.VarChar, strCHASSISNO), _
             objDB.MP("@PHONEAREA", Data.SqlDbType.VarChar, strPHONEAREA), _
             objDB.MP("@PHONENO", Data.SqlDbType.VarChar, strPHONENO), _
             objDB.MP("@NPWP", Data.SqlDbType.VarChar, strNPWP), _
             objDB.MP("@ADDRESS", Data.SqlDbType.VarChar, strADDRESS), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
             objDB.MP("@LOCID", Data.SqlDbType.BigInt, dblLOCID), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID), _
             objDB.MP("@LOCIDCUST", Data.SqlDbType.BigInt, dblLOCIDCUST), _
             objDB.MP("@CUSTID", Data.SqlDbType.BigInt, dblCUSTID), _
             objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
             objDB.MP("@OBJID", Data.SqlDbType.BigInt, dblOBJID) _
            )

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Public Sub APPLICATIONProceed2(ByVal intLOCID As Integer, _
        ByVal dblAPPID As Double, _
        ByVal intUSERID As Integer)
        Dim objDB As New DBX
        Try
            objDB.ExecSP("APPLICATIONProceedInitilize", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Public Sub APPLICATIONRejectInitialize(ByVal intLOCID As Integer, _
      ByVal dblAPPID As Double, _
      ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("APPLICATIONRejectInitilize", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Public Sub APPLICATIONMatchProceed(ByVal intLOCID As Integer, _
     ByVal dblAPPID As Double, _
     ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("APPLICATIONProceedMatch", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Public Sub APPLICATIONReturnInitialize(ByVal intLOCID As Integer, _
   ByVal dblAPPID As Double, _
   ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("APPLICATIONReturnInitilize", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub ACCOUNTSaveWithoutLoan(ByVal intLOCID As Integer, _
           ByVal dblACCID As Double, _
           ByVal dblAPPID As Double, _
           ByVal dtBOOKINGDATE As String, _
           ByVal intINSTALLMENTDAY As String, _
           ByVal strACCOUNTNAME As String, _
           ByVal intLOCIDCUST As Integer, _
           ByVal dblCUSTID As Double, _
           ByVal intBRANCHID As String, _
           ByVal strREfNo As String, _
           ByVal intUSERID As Integer, _
           Optional ByRef dblNEWACCID As String = "0" _
        )
        Dim objDB As New DBX
        Try
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("ACCOUNTSaveWithoutLoan", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
             objDB.MP("@APPID", Data.SqlDbType.BigInt, dblAPPID), _
             objDB.MP("@BOOKINGDATE", Data.SqlDbType.DateTime, dtBOOKINGDATE), _
             objDB.MP("@INSTALLMENTDAY", Data.SqlDbType.Int, intINSTALLMENTDAY), _
             objDB.MP("@ACCOUNTNAME", Data.SqlDbType.VarChar, strACCOUNTNAME), _
             objDB.MP("@LOCIDCUST", Data.SqlDbType.Int, intLOCIDCUST), _
             objDB.MP("@CUSTID", Data.SqlDbType.BigInt, dblCUSTID), _
             objDB.MP("@BRANCHID", Data.SqlDbType.Int, intBRANCHID), _
             objDB.MP("@REFNO", Data.SqlDbType.VarChar, strREfNo), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
             objDB.MP("@NEWACCID", Data.SqlDbType.BigInt, dblNEWACCID, Data.ParameterDirection.InputOutput) _
            )
            dblNEWACCID = oSQLParam("@NEWACCID").Value.ToString()
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Public Sub CUSTOMERUpdateStatusNegatif(ByVal intLOCIDCUST As Integer, _
      ByVal dblCUSTID As Double, _
      ByVal strNEGATIFSTATUS As String, _
      ByVal strNEGATIFDESC As String, _
      ByVal intUSERID As Integer)

        Dim objDB As New DBX
        Try
            objDB.ExecSP("CUSTOMERUpdateStatusNegatif", _
             objDB.MP("@LOCIDCUST", Data.SqlDbType.Int, intLOCIDCUST), _
             objDB.MP("@CUSTID", Data.SqlDbType.BigInt, dblCUSTID), _
             objDB.MP("@NEGATIFSTS", Data.SqlDbType.Bit, strNEGATIFSTATUS), _
             objDB.MP("@NEGATIFDESC", Data.SqlDbType.VarChar, strNEGATIFDESC), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID) _
            )
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Sub CUSTOMERSaveSimple( _
    ByVal intLOCIDCUST As Integer, _
    ByVal dblCUSTID As Double, _
    ByVal intCUSTTYPE As String, _
    ByVal intBRANCHID As String, _
    ByVal strFULLNAME As String, _
    ByVal strCUSTNAME As String, _
    ByVal strTITLE As String, _
    ByVal strCUSTADDRESS As String, _
    ByVal strCUSTRT As String, _
    ByVal strCUSTRW As String, _
    ByVal strCUSTKEL As String, _
    ByVal strCUSTKEC As String, _
    ByVal strCUSTCITY As String, _
    ByVal strCUSTPROV As String, _
    ByVal strCUSTZIP As String, _
    ByVal intCUSTDATI As String, _
    ByVal intIDTYPE As String, _
    ByVal strIDNUMBER As String, _
    ByVal dtIDEXPIRED As String, _
    ByVal intGENDER As String, _
    ByVal intMARITALSTATUS As String, _
    ByVal dtBIRTHDATE As String, _
    ByVal strBIRTHPLACE As String, _
    ByVal intBIRTHDATI As String, _
    ByVal dtWORKSINCE As String, _
    ByVal intEMPLOYEESTS As String, _
    ByVal dtCONTRACTEND As String, _
    ByVal strLASTEDUCATION As String, _
    ByVal intECONOMYCODE As String, _
    ByVal intDEBITURCODE As String, _
    ByVal strMMN As String, _
    ByVal strNPWP As String, _
    ByVal intHOMESTATUS As String, _
    ByVal dtLIVEDSINCE As String, _
    ByVal strPHONEAREA As String, _
    ByVal strPHONENO As String, _
    ByVal strMOBILENO As String, _
    ByVal intDEPENDENT As String, _
    ByVal dblGROSSINCOME As String, _
    ByVal dblEXPENSES As String, _
    ByVal intJOBID As String, _
    ByVal intJOBTITLEID As String, _
    ByVal intRELIGION As String, _
    ByVal dblADDLINCOME As String, _
    ByVal strSOURCEADDINCOME As String, _
    ByVal strPHONEAREA2 As String, _
    ByVal strPHONENO2 As String, _
    ByVal strPHONEAREA3 As String, _
    ByVal strPHONENO3 As String, _
    ByVal strMOBILENO2 As String, _
    ByVal blnGUARANTOREXIST As String, _
    ByVal strGUARANTORTYPE As String, _
    ByVal strEMAIL As String, _
    ByVal intUSERID As String, _
    Optional ByRef dblNEWCUSTID As String = "0")



        Dim objDB As New DBX
        Try
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("CUSTOMERSave", _
             objDB.MP("@LOCIDCUST", Data.SqlDbType.Int, intLOCIDCUST), _
             objDB.MP("@CUSTID", Data.SqlDbType.BigInt, dblCUSTID), _
             objDB.MP("@CUSTTYPE", Data.SqlDbType.Int, intCUSTTYPE), _
             objDB.MP("@BRANCHID", Data.SqlDbType.Int, intBRANCHID), _
             objDB.MP("@FULLNAME", Data.SqlDbType.VarChar, strFULLNAME), _
             objDB.MP("@CUSTNAME", Data.SqlDbType.VarChar, strCUSTNAME), _
             objDB.MP("@TITLE", Data.SqlDbType.VarChar, strTITLE), _
             objDB.MP("@CUSTADDRESS", Data.SqlDbType.VarChar, strCUSTADDRESS), _
             objDB.MP("@CUSTRT", Data.SqlDbType.VarChar, strCUSTRT), _
             objDB.MP("@CUSTRW", Data.SqlDbType.VarChar, strCUSTRW), _
             objDB.MP("@CUSTKEL", Data.SqlDbType.VarChar, strCUSTKEL), _
             objDB.MP("@CUSTKEC", Data.SqlDbType.VarChar, strCUSTKEC), _
             objDB.MP("@CUSTCITY", Data.SqlDbType.VarChar, strCUSTCITY), _
             objDB.MP("@CUSTPROV", Data.SqlDbType.VarChar, strCUSTPROV), _
             objDB.MP("@CUSTZIP", Data.SqlDbType.VarChar, strCUSTZIP), _
             objDB.MP("@CUSTDATI", Data.SqlDbType.Int, intCUSTDATI), _
             objDB.MP("@IDTYPE", Data.SqlDbType.TinyInt, intIDTYPE), _
             objDB.MP("@IDNUMBER", Data.SqlDbType.VarChar, strIDNUMBER), _
             objDB.MP("@IDEXPIRED", Data.SqlDbType.DateTime, dtIDEXPIRED), _
             objDB.MP("@GENDER", Data.SqlDbType.TinyInt, intGENDER), _
             objDB.MP("@MARITALSTATUS", Data.SqlDbType.TinyInt, intMARITALSTATUS), _
             objDB.MP("@BIRTHDATE", Data.SqlDbType.DateTime, dtBIRTHDATE), _
             objDB.MP("@BIRTHPLACE", Data.SqlDbType.VarChar, strBIRTHPLACE), _
             objDB.MP("@BIRTHDATI", Data.SqlDbType.Int, intBIRTHDATI), _
             objDB.MP("@WORKSINCE", Data.SqlDbType.DateTime, dtWORKSINCE), _
             objDB.MP("@EMPLOYEESTS", Data.SqlDbType.TinyInt, intEMPLOYEESTS), _
             objDB.MP("@CONTRACTEND", Data.SqlDbType.DateTime, dtCONTRACTEND), _
             objDB.MP("@LASTEDUCATION", Data.SqlDbType.VarChar, strLASTEDUCATION), _
             objDB.MP("@ECONOMYCODE", Data.SqlDbType.Int, intECONOMYCODE), _
             objDB.MP("@DEBITURCODE", Data.SqlDbType.Int, intDEBITURCODE), _
             objDB.MP("@MMN", Data.SqlDbType.VarChar, strMMN), _
             objDB.MP("@NPWP", Data.SqlDbType.VarChar, strNPWP), _
             objDB.MP("@HOMESTATUS", Data.SqlDbType.TinyInt, intHOMESTATUS), _
             objDB.MP("@LIVEDSINCE", Data.SqlDbType.DateTime, dtLIVEDSINCE), _
             objDB.MP("@PHONEAREA", Data.SqlDbType.VarChar, strPHONEAREA), _
             objDB.MP("@PHONENO", Data.SqlDbType.VarChar, strPHONENO), _
             objDB.MP("@MOBILENO", Data.SqlDbType.VarChar, strMOBILENO), _
             objDB.MP("@DEPENDENT", Data.SqlDbType.Int, intDEPENDENT), _
             objDB.MP("@GROSSINCOME", Data.SqlDbType.Money, dblGROSSINCOME), _
             objDB.MP("@EXPENSES", Data.SqlDbType.Money, dblEXPENSES), _
             objDB.MP("@JOBID", Data.SqlDbType.Int, intJOBID), _
             objDB.MP("@JOBTITLEID", Data.SqlDbType.Int, intJOBTITLEID), _
             objDB.MP("@RELIGION", Data.SqlDbType.Int, intRELIGION), _
             objDB.MP("@ADDLINCOME", Data.SqlDbType.Money, dblADDLINCOME), _
             objDB.MP("@SOURCEADDINCOME", Data.SqlDbType.VarChar, strSOURCEADDINCOME), _
             objDB.MP("@PHONEAREA2", Data.SqlDbType.VarChar, strPHONEAREA2), _
             objDB.MP("@PHONENO2", Data.SqlDbType.VarChar, strPHONENO2), _
             objDB.MP("@PHONEAREA3", Data.SqlDbType.VarChar, strPHONEAREA3), _
             objDB.MP("@PHONENO3", Data.SqlDbType.VarChar, strPHONENO3), _
             objDB.MP("@MOBILENO2", Data.SqlDbType.VarChar, strMOBILENO2), _
             objDB.MP("@GUARANTOREXIST", Data.SqlDbType.Int, blnGUARANTOREXIST), _
             objDB.MP("@GUARANTORTYPE", Data.SqlDbType.VarChar, strGUARANTORTYPE), _
             objDB.MP("@EMAIL", Data.SqlDbType.VarChar, strEMAIL), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
             objDB.MP("@NEWCUSTID", Data.SqlDbType.BigInt, dblNEWCUSTID, Data.ParameterDirection.InputOutput))


            dblNEWCUSTID = oSQLParam("@NEWCUSTID").Value.ToString()

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Public Sub CUSTOMERDTLSaveSimple(ByVal intLOCIDCUST As Integer, _
     ByVal dblCUSTID As Double, _
     ByVal blnSAMEIDHOMEADDR As String, _
     ByVal strCUSTADDRESSHOME As String, _
     ByVal strCUSTRTHOME As String, _
     ByVal strCUSTRWHOME As String, _
     ByVal strCUSTKELHOME As String, _
     ByVal strCUSTKECHOME As String, _
     ByVal strCUSTCITYHOME As String, _
     ByVal strCUSTPROVHOME As String, _
     ByVal strCUSTZIPHOME As String, _
     ByVal intCUSTDATIHOME As String, _
     ByVal strSPOUSENAME As String, _
     ByVal dtSPOUSEBIRTHDATE As Date, _
     ByVal strSPOUSEBIRTHPLACE As String, _
     ByVal intSPOUSEIDTYPE As String, _
     ByVal strSPOUSEIDNUMBER As String, _
     ByVal strSPOUSEPHONENO As String, _
     ByVal strSPOUSEMOBILENO As String, _
     ByVal strSPOUSEOFFICE As String, _
     ByVal strSPOUSEOFFINEPHONE As String, _
     ByVal intRELATIVESTYPE As String, _
     ByVal strRELATIVESNAME As String, _
     ByVal strCUSTADDRESSREL As String, _
     ByVal strCUSTRTREL As String, _
     ByVal strCUSTRWREL As String, _
     ByVal strCUSTKELREL As String, _
     ByVal strCUSTKECREL As String, _
     ByVal strCUSTCITYREL As String, _
     ByVal strCUSTPROVREL As String, _
     ByVal strCUSTZIPREL As String, _
     ByVal strPHONENOREL As String, _
     ByVal strCOMPANYNAME As String, _
     ByVal strCOMPANYADDR As String, _
     ByVal strCOMPANYCITY As String, _
     ByVal strCOMPANYZIP As String, _
     ByVal strCOMPANYPHONE As String, _
     ByVal dtSPOUSEWORKSINCED As Date, _
     ByVal intSPOUSEJOBID As String, _
     ByVal intSPOUSEJOBTITLEID As String, _
     ByVal intSPOUSEECONOMYCODE As String, _
     ByVal intSPOUSEDEBITURCODE As String, _
     ByVal dblSPOUSEINCOME As String, _
     ByVal intMAILADDRESSTO As String, _
     ByVal strCUSTADDRESSMAIL As String, _
     ByVal strCUSTRTMAIL As String, _
     ByVal strCUSTRWMAIL As String, _
     ByVal strCUSTKELMAIL As String, _
     ByVal strCUSTKECMAIL As String, _
     ByVal strCUSTCITYMAIL As String, _
     ByVal strCUSTPROVMAIL As String, _
     ByVal strCUSTZIPMAIL As String, _
     ByVal intCUSTDATIMAIL As String, _
     ByVal strPBBAN As String, _
     ByVal strPBBIDNUMBER As String, _
     ByVal strCOMPANYRT As String, _
     ByVal strCOMPANYRW As String,
     ByVal strCOMPANYKEL As String, _
     ByVal strCOMPANYKEC As String, _
     ByVal intASSETTYPE As String, _
     ByVal dblASSETPRICE As String, _
     ByVal strASSETDESC As String, _
     ByVal intMAINBANKID As String, _
     ByVal strMAINBANKBRANCH As String, _
     ByVal intMAINBANKMEMBERMM As String, _
     ByVal intMAINBANKMEMBERYYYY As String, _
     ByVal strMAINBANKACCNO As String, _
     ByVal intMAINBANKACCTYPE As String, _
     ByVal intOTHBANKID As String, _
     ByVal strOTHBANKBRANCH As String, _
     ByVal intOTHBANKMEMBERMM As String, _
     ByVal intOTHBANKMEMBERYYYY As String, _
     ByVal strOTHBANKACCNO As String, _
     ByVal intOTHBANKACCTYPE As String, _
     ByVal blnFACILITY As String, _
     ByVal strFACILITYFROM As String, _
     ByVal strFACILITYKIND As String, _
     ByVal dblFACILITYINST As String, _
        ByVal blnSPOUSESAMEADDR As String, _
        ByVal strSPOUSEADDRESS As String, _
        ByVal strSPOUSERT As String, _
        ByVal strSPOUSERW As String, _
        ByVal strSPOUSEKEL As String, _
        ByVal strSPOUSEKEC As String, _
        ByVal strSPOUSECITY As String, _
        ByVal strSPOUSEPROV As String, _
        ByVal strSPOUSEZIP As String, _
        ByVal intSPOUSEDATI As String, _
     ByVal intUSERID As Integer)



        'ByVal strCOMPANYPHONEEXT As String, _
        'ByVal strDEPARTMENT As String, _
        'ByVal strSUPERVISORNAME As String, _


        Dim objDB As New DBX
        Try
            objDB.ExecSP("CUSTOMERDTLSaveSimple", _
             objDB.MP("@LOCIDCUST", Data.SqlDbType.Int, intLOCIDCUST), _
             objDB.MP("@CUSTID", Data.SqlDbType.BigInt, dblCUSTID), _
             objDB.MP("@SAMEIDHOMEADDR", Data.SqlDbType.VarChar, blnSAMEIDHOMEADDR), _
             objDB.MP("@CUSTADDRESSHOME", Data.SqlDbType.VarChar, strCUSTADDRESSHOME), _
             objDB.MP("@CUSTRTHOME", Data.SqlDbType.VarChar, strCUSTRTHOME), _
             objDB.MP("@CUSTRWHOME", Data.SqlDbType.VarChar, strCUSTRWHOME), _
             objDB.MP("@CUSTKELHOME", Data.SqlDbType.VarChar, strCUSTKELHOME), _
             objDB.MP("@CUSTKECHOME", Data.SqlDbType.VarChar, strCUSTKECHOME), _
             objDB.MP("@CUSTCITYHOME", Data.SqlDbType.VarChar, strCUSTCITYHOME), _
             objDB.MP("@CUSTPROVHOME", Data.SqlDbType.VarChar, strCUSTPROVHOME), _
             objDB.MP("@CUSTZIPHOME", Data.SqlDbType.VarChar, strCUSTZIPHOME), _
             objDB.MP("@CUSTDATIHOME", Data.SqlDbType.Int, intCUSTDATIHOME), _
             objDB.MP("@SPOUSENAME", Data.SqlDbType.VarChar, strSPOUSENAME), _
             objDB.MP("@SPOUSEBIRTHDATE", Data.SqlDbType.DateTime, dtSPOUSEBIRTHDATE), _
             objDB.MP("@SPOUSEBIRTHPLACE", Data.SqlDbType.VarChar, strSPOUSEBIRTHPLACE), _
             objDB.MP("@SPOUSEIDTYPE", Data.SqlDbType.TinyInt, intSPOUSEIDTYPE), _
             objDB.MP("@SPOUSEIDNUMBER", Data.SqlDbType.VarChar, strSPOUSEIDNUMBER), _
             objDB.MP("@SPOUSEPHONENO", Data.SqlDbType.VarChar, strSPOUSEPHONENO), _
             objDB.MP("@SPOUSEMOBILENO", Data.SqlDbType.VarChar, strSPOUSEMOBILENO), _
             objDB.MP("@SPOUSEOFFICE", Data.SqlDbType.VarChar, strSPOUSEOFFICE), _
             objDB.MP("@SPOUSEOFFINEPHONE", Data.SqlDbType.VarChar, strSPOUSEOFFINEPHONE), _
             objDB.MP("@RELATIVESTYPE", Data.SqlDbType.TinyInt, intRELATIVESTYPE), _
             objDB.MP("@RELATIVESNAME", Data.SqlDbType.VarChar, strRELATIVESNAME), _
             objDB.MP("@CUSTADDRESSREL", Data.SqlDbType.VarChar, strCUSTADDRESSREL), _
             objDB.MP("@CUSTRTREL", Data.SqlDbType.VarChar, strCUSTRTREL), _
             objDB.MP("@CUSTRWREL", Data.SqlDbType.VarChar, strCUSTRWREL), _
             objDB.MP("@CUSTKELREL", Data.SqlDbType.VarChar, strCUSTKELREL), _
             objDB.MP("@CUSTKECREL", Data.SqlDbType.VarChar, strCUSTKECREL), _
             objDB.MP("@CUSTCITYREL", Data.SqlDbType.VarChar, strCUSTCITYREL), _
             objDB.MP("@CUSTPROVREL", Data.SqlDbType.VarChar, strCUSTPROVREL), _
             objDB.MP("@CUSTZIPREL", Data.SqlDbType.VarChar, strCUSTZIPREL), _
             objDB.MP("@PHONENOREL", Data.SqlDbType.VarChar, strPHONENOREL), _
             objDB.MP("@COMPANYNAME", Data.SqlDbType.VarChar, strCOMPANYNAME), _
             objDB.MP("@COMPANYADDR", Data.SqlDbType.VarChar, strCOMPANYADDR), _
             objDB.MP("@COMPANYCITY", Data.SqlDbType.VarChar, strCOMPANYCITY), _
             objDB.MP("@COMPANYZIP", Data.SqlDbType.VarChar, strCOMPANYZIP), _
             objDB.MP("@COMPANYPHONE", Data.SqlDbType.VarChar, strCOMPANYPHONE), _
             objDB.MP("@SPOUSEWORKSINCED", Data.SqlDbType.DateTime, dtSPOUSEWORKSINCED), _
             objDB.MP("@SPOUSEJOBID", Data.SqlDbType.Int, intSPOUSEJOBID), _
             objDB.MP("@SPOUSEJOBTITLEID", Data.SqlDbType.Int, intSPOUSEJOBTITLEID), _
             objDB.MP("@SPOUSEECONOMYCODE", Data.SqlDbType.Int, intSPOUSEECONOMYCODE), _
             objDB.MP("@SPOUSEDEBITURCODE", Data.SqlDbType.Int, intSPOUSEDEBITURCODE), _
             objDB.MP("@SPOUSEINCOME", Data.SqlDbType.Money, dblSPOUSEINCOME), _
             objDB.MP("@MAILADDRESSTO", Data.SqlDbType.Int, intMAILADDRESSTO), _
             objDB.MP("@CUSTADDRESSMAIL", Data.SqlDbType.VarChar, strCUSTADDRESSMAIL), _
             objDB.MP("@CUSTRTMAIL", Data.SqlDbType.VarChar, strCUSTRTMAIL), _
             objDB.MP("@CUSTRWMAIL", Data.SqlDbType.VarChar, strCUSTRWMAIL), _
             objDB.MP("@CUSTKELMAIL", Data.SqlDbType.VarChar, strCUSTKELMAIL), _
             objDB.MP("@CUSTKECMAIL", Data.SqlDbType.VarChar, strCUSTKECMAIL), _
             objDB.MP("@CUSTCITYMAIL", Data.SqlDbType.VarChar, strCUSTCITYMAIL), _
             objDB.MP("@CUSTPROVMAIL", Data.SqlDbType.VarChar, strCUSTPROVMAIL), _
             objDB.MP("@CUSTZIPMAIL", Data.SqlDbType.VarChar, strCUSTZIPMAIL), _
             objDB.MP("@CUSTDATIMAIL", Data.SqlDbType.Int, intCUSTDATIMAIL), _
             objDB.MP("@PBBAN", Data.SqlDbType.VarChar, strPBBAN), _
             objDB.MP("@PBBIDNUMBER", Data.SqlDbType.VarChar, strPBBIDNUMBER), _
             objDB.MP("@COMPANYRT", Data.SqlDbType.VarChar, strCOMPANYRT), _
             objDB.MP("@COMPANYRW", Data.SqlDbType.VarChar, strCOMPANYRW), _
             objDB.MP("@COMPANYKEL", Data.SqlDbType.VarChar, strCOMPANYKEL), _
             objDB.MP("@COMPANYKEC", Data.SqlDbType.VarChar, strCOMPANYKEC), _
             objDB.MP("@ASSETTYPE", Data.SqlDbType.Int, intASSETTYPE), _
             objDB.MP("@ASSETPRICE", Data.SqlDbType.Money, dblASSETPRICE), _
             objDB.MP("@ASSETDESC", Data.SqlDbType.VarChar, strASSETDESC), _
             objDB.MP("@MAINBANKID", Data.SqlDbType.Int, intMAINBANKID), _
             objDB.MP("@MAINBANKBRANCH", Data.SqlDbType.VarChar, strMAINBANKBRANCH), _
             objDB.MP("@MAINBANKMEMBERMM", Data.SqlDbType.Int, intMAINBANKMEMBERMM), _
             objDB.MP("@MAINBANKMEMBERYYYY", Data.SqlDbType.Int, intMAINBANKMEMBERYYYY), _
             objDB.MP("@MAINBANKACCNO", Data.SqlDbType.VarChar, strMAINBANKACCNO), _
             objDB.MP("@MAINBANKACCTYPE", Data.SqlDbType.Int, intMAINBANKACCTYPE), _
             objDB.MP("@OTHBANKID", Data.SqlDbType.Int, intOTHBANKID), _
             objDB.MP("@OTHBANKBRANCH", Data.SqlDbType.VarChar, strOTHBANKBRANCH), _
             objDB.MP("@OTHBANKMEMBERMM", Data.SqlDbType.Int, intOTHBANKMEMBERMM), _
             objDB.MP("@OTHBANKMEMBERYYYY", Data.SqlDbType.Int, intOTHBANKMEMBERYYYY), _
             objDB.MP("@OTHBANKACCNO", Data.SqlDbType.VarChar, strOTHBANKACCNO), _
             objDB.MP("@OTHBANKACCTYPE", Data.SqlDbType.Int, intOTHBANKACCTYPE), _
             objDB.MP("@FACILITY", Data.SqlDbType.Int, blnFACILITY), _
             objDB.MP("@FACILITYFROM", Data.SqlDbType.VarChar, strFACILITYFROM), _
             objDB.MP("@FACILITYKIND", Data.SqlDbType.VarChar, strFACILITYKIND), _
             objDB.MP("@FACILITYINST", Data.SqlDbType.Money, dblFACILITYINST), _
             objDB.MP("@SPOUSESAMEADDR", Data.SqlDbType.VarChar, blnSPOUSESAMEADDR), _
             objDB.MP("@SPOUSEADDRESS", Data.SqlDbType.VarChar, strSPOUSEADDRESS), _
             objDB.MP("@SPOUSERT", Data.SqlDbType.VarChar, strSPOUSERT), _
             objDB.MP("@SPOUSERW", Data.SqlDbType.VarChar, strSPOUSERW), _
             objDB.MP("@SPOUSEKEL", Data.SqlDbType.VarChar, strSPOUSEKEL), _
             objDB.MP("@SPOUSEKEC", Data.SqlDbType.VarChar, strSPOUSEKEC), _
             objDB.MP("@SPOUSECITY", Data.SqlDbType.VarChar, strSPOUSECITY), _
             objDB.MP("@SPOUSEPROV", Data.SqlDbType.VarChar, strSPOUSEPROV), _
             objDB.MP("@SPOUSEZIP", Data.SqlDbType.VarChar, strSPOUSEZIP), _
             objDB.MP("@SPOUSEDATI", Data.SqlDbType.Int, intSPOUSEDATI), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID))

            'objDB.MP("@COMPANYPHONEEXT", Data.SqlDbType.VarChar, strCOMPANYPHONEEXT, 5), _
            'objDB.MP("@DEPARTMENT", Data.SqlDbType.VarChar, strDEPARTMENT), _
            'objDB.MP("@SUPERVISORNAME", Data.SqlDbType.VarChar, strSUPERVISORNAME), _

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Public Sub COLLATERALSaveSimple(ByVal intLOCID As Integer, _
   ByVal dblACCID As Double, _
   ByVal dblDEALERID As String, _
   ByVal intProductID As String, _
   ByVal intMERKID As String, _
   ByVal intMODELID As String, _
   ByVal dblOBJECTTYPEID As String, _
   ByVal strBPKBNO As String, _
   ByVal dtBPKBDATE As Date, _
   ByVal strBPKBADDRESS As String, _
   ByVal strBPKBCITYID As String, _
   ByVal strBPKBNAME As String, _
   ByVal strBPKBOWNERID As String, _
   ByVal strBPKBCARTYPE As String, _
   ByVal strENGINENO As String, _
   ByVal strCHASSISNO As String, _
   ByVal intCARYEAR As String, _
   ByVal intBUILDYEAR As String, _
   ByVal intCONDITION As String, _
   ByVal strCOLOR As String, _
   ByVal strCATEGORYID As String, _
   ByVal strPURPOSEID As String, _
   ByVal strPOLICENO As String, _
   ByVal dtSTNKEXPIRED As Date, _
   ByVal dtSURVEYDATE As Date, _
   ByVal intUSERID As Integer, _
   ByVal intBINDTYPEID As String, _
   ByVal intCOLLATERALTYPEID As String, _
   ByVal intSBRANKID As String, _
   ByVal dblROUTEID As String, _
   ByVal dblCOLLATERALVALUE As String, _
      Optional ByRef dblOBJID As Double = 0)

        Dim objDB As New DBX
        Try
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("COLLATERALSaveSimple", _
             objDB.MP("@LOCID", Data.SqlDbType.Int, intLOCID), _
             objDB.MP("@ACCID", Data.SqlDbType.BigInt, dblACCID), _
             objDB.MP("@DEALERID", Data.SqlDbType.VarChar, dblDEALERID), _
             objDB.MP("@PRODUCTID", Data.SqlDbType.VarChar, intProductID), _
             objDB.MP("@MERKID", Data.SqlDbType.VarChar, intMERKID), _
             objDB.MP("@MODELID", Data.SqlDbType.VarChar, intMODELID), _
             objDB.MP("@OBJECTTYPEID", Data.SqlDbType.VarChar, dblOBJECTTYPEID), _
             objDB.MP("@BPKBNO", Data.SqlDbType.VarChar, strBPKBNO), _
             objDB.MP("@BPKBDATE", Data.SqlDbType.DateTime, dtBPKBDATE), _
             objDB.MP("@BPKBADDRESS", Data.SqlDbType.VarChar, strBPKBADDRESS), _
             objDB.MP("@BPKBCITYID", Data.SqlDbType.VarChar, strBPKBCITYID), _
             objDB.MP("@BPKBNAME", Data.SqlDbType.VarChar, strBPKBNAME), _
             objDB.MP("@BPKBOWNERID", Data.SqlDbType.VarChar, strBPKBOWNERID), _
             objDB.MP("@BPKBCARTYPE", Data.SqlDbType.VarChar, strBPKBCARTYPE), _
             objDB.MP("@ENGINENO", Data.SqlDbType.VarChar, strENGINENO), _
             objDB.MP("@CHASSISNO", Data.SqlDbType.VarChar, strCHASSISNO), _
             objDB.MP("@CARYEAR", Data.SqlDbType.VarChar, intCARYEAR), _
             objDB.MP("@BUILDYEAR", Data.SqlDbType.VarChar, intBUILDYEAR), _
             objDB.MP("@CONDITION", Data.SqlDbType.VarChar, intCONDITION), _
             objDB.MP("@COLOR", Data.SqlDbType.VarChar, strCOLOR), _
             objDB.MP("@CATEGORYID", Data.SqlDbType.VarChar, strCATEGORYID), _
             objDB.MP("@PURPOSEID", Data.SqlDbType.VarChar, strPURPOSEID), _
             objDB.MP("@POLICENO", Data.SqlDbType.VarChar, strPOLICENO), _
             objDB.MP("@STNKEXPIRED", Data.SqlDbType.DateTime, dtSTNKEXPIRED), _
             objDB.MP("@SURVEYDATE", Data.SqlDbType.DateTime, dtSURVEYDATE), _
             objDB.MP("@USERID", Data.SqlDbType.Int, intUSERID), _
             objDB.MP("@OBJID", Data.SqlDbType.BigInt, dblOBJID, 50, Data.ParameterDirection.InputOutput), _
             objDB.MP("@BINDTYPEID", Data.SqlDbType.Int, intBINDTYPEID), _
             objDB.MP("@COLLATERALTYPEID", Data.SqlDbType.Int, intCOLLATERALTYPEID), _
             objDB.MP("@SBRANKID", Data.SqlDbType.VarChar, intSBRANKID), _
             objDB.MP("@ROUTEID", Data.SqlDbType.VarChar, dblROUTEID), _
             objDB.MP("@COLATERALVALUE", Data.SqlDbType.VarChar, dblCOLLATERALVALUE) _
           )
            dblOBJID = oSQLParam("@OBJID").Value.ToString()

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
End Class