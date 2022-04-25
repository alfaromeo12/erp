Imports Microsoft.VisualBasic
Imports System
Imports System.Web
Imports System.Collections
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Collections.Generic
Imports System.Collections.Specialized

<WebService(Namespace:="http://techcream.net/", Description:="Web Service SignalBit")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
<System.Web.Script.Services.ScriptService()> _
Public Class GetCascadeDropDown

    Inherits System.Web.Services.WebService

    'Dim conString As String = System.Configuration.ConfigurationManager.ConnectionStrings("connection").ToString()

    Public Sub CascadingDataService()
        'Uncomment the following line if using designed components
        'InitializeComponent();
    End Sub


    <WebMethod()> _
    Public Function GetDropDownBank(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT BANKID, BANKCODE + ' - ' + BANKNAME BANKNAME FROM BANK WITH(nolock)  ORDER BY BANKCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("BANKNAME").ToString(), oSDR("BANKID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function
    <WebMethod()> _
    Public Function GetDropDownArea(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT AREAID, AREACODE+ ' - ' + AREANAME AREANAME FROM AREA WITH(nolock)  WHERE DELETESTS=0 ORDER BY AREACODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("AREANAME").ToString(), oSDR("AREAID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function


    <WebMethod()> _
    Public Function GetDropDownAreaWithAll(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT -1 AREAID, NULL AREACODE, '[ALL AREA]' AREANAME UNION ALL " & _
                "SELECT AREAID, AREACODE, AREACODE+ ' - ' + AREANAME AREANAME FROM AREA WITH(nolock)  WHERE DELETESTS=0 ORDER BY AREACODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("AREANAME").ToString(), oSDR("AREAID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownAreaWithNull(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT NULL AREAID, NULL AREACODE, '[ALL AREA]' AREANAME UNION ALL " & _
                "SELECT AREAID, AREACODE, AREACODE+ ' - ' + AREANAME AREANAME FROM AREA WITH(nolock)  WHERE DELETESTS=0 ORDER BY AREACODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("AREANAME").ToString(), oSDR("AREAID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownAreabyAppUserBranch(ByVal knownCategoryValues As String, ByVal category As String, ByVal contextKey As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strUID As String = contextKey
        ' Dim strUID As String = handler
        If Len(Trim(strUID)) <= 0 Then strUID = "-1"
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader

            'Dim strUserBranch As String = "1"
            'oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_IsUserBranch(" & strUID & ") ISBRANCH")
            'If oSDR.Read() Then
            '    strUserBranch = oSDR("ISBRANCH").ToString()
            'End If
            'oSDR.Close()
            'oSDR = Nothing

            'oSDR = objDB.CreateSDRFromSQLSelect("SELECT AREAID, '(' + AREACODE+ ') ' + AREANAME AREANAME  " & _
            '        "FROM AREA WITH(NOLOCK) WHERE DELETESTS=0 " & _
            '        "AND EXISTS (SELECT 'X' FROM APPUSERBRANCH INNER JOIN BRANCH  " & _
            '        "ON APPUSERBRANCH.BRANCHID=BRANCH.BRANCHID  " & _
            '        "WHERE(APPUSERBRANCH.Deletests = 0) " & _
            '        "AND BRANCH.AREAID=AREA.AREAID " & _
            '        "AND APPUSERBRANCH.UID=" & strUID & ") " & _
            '        "ORDER BY AREACODE")

            'If strUserBranch = "1" Then
            If strUID <> "-999" And Len(Trim(strUID)) > 0 Then
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT AREAID, AREACODE+ ' - ' + AREANAME AREANAME  " & _
                "FROM AREA WITH(NOLOCK) WHERE DELETESTS=0 " & _
                "AND EXISTS (SELECT 'X' FROM dbo.f_getAPPUSERBRANCHList(" & strUID & ") as APPUSERBRANCH INNER JOIN BRANCH WITH(NOLOCK)  " & _
                "ON APPUSERBRANCH.BRANCHID=BRANCH.BRANCHID  " & _
                "WHERE BRANCH.AREAID=AREA.AREAID OR 0=dbo.f_IsUserBranch(" & strUID & ")) " & _
                "ORDER BY case when ISNUMERIC(AREACODE)=1 then  cast(AREACODE as int) else AREACODE end")
            Else
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT AREAID, AREACODE + ' - ' + AREANAME AREANAME  FROM AREA WITH(NOLOCK) WHERE DELETESTS=0 ORDER BY AREACODE")
            End If

            'Else
            'oSDR = objDB.CreateSDRFromSQLSelect("SELECT AREAID, '(' + AREACODE+ ') ' + AREANAME AREANAME FROM AREA WITH(nolock)  WHERE DELETESTS=0 ORDER BY AREACODE")
            'End If

            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("AREANAME").ToString(), oSDR("AREAID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function


    <WebMethod()> _
    Public Function GetDropDownBranchByArea(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strAreaID As String = categoryValues("AREA")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT BRANCHID, AREAID, BRANCHCODE + ' - ' +  BRANCHNAME BRANCHNAME FROM BRANCH WITH(nolock)  WHERE AREAID=" & strAreaID & " AND DELETESTS=0 AND ACTIVE=1 ORDER BY BRANCHCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("BRANCHNAME").ToString(), oSDR("BRANCHID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownBranchByAreaByUserBranch(ByVal knownCategoryValues As String, ByVal category As String, ByVal contextKey As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strAreaID As String = "" '= categoryValues("AREA")
        Dim strBranchID As String = ""
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            Dim arrContext() As String
            If Not String.IsNullOrEmpty(contextKey) Then
                arrContext = Split(contextKey, ",")
                strAreaID = arrContext(0)
                strBranchID = arrContext(1)
            End If
            If Len(Trim(strBranchID)) > 0 Then
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT BRANCHID, AREAID, BRANCHCODE + ' - ' +  BRANCHNAME BRANCHNAME FROM BRANCH WITH(nolock)  WHERE AREAID=" & strAreaID & " AND BRANCHID=" & strBranchID & " AND DELETESTS=0 AND ACTIVE=1 ORDER BY BRANCHCODE")
            Else
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT BRANCHID, AREAID, BRANCHCODE + ' - ' +  BRANCHNAME BRANCHNAME FROM BRANCH WITH(nolock)  WHERE AREAID=" & strAreaID & " AND DELETESTS=0 AND ACTIVE=1 ORDER BY BRANCHCODE")

            End If
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("BRANCHNAME").ToString(), oSDR("BRANCHID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function


    <WebMethod()> _
    Public Function GetDropDownBranchByAppUserBranch(ByVal knownCategoryValues As String, ByVal category As String, ByVal contextKey As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strUID As String = ""
        Dim strAreaID As String = categoryValues("AREA")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            If Not String.IsNullOrEmpty(contextKey) Then
                strUID = contextKey
            Else
                strUID = "-999"
            End If

            'Dim strUserBranch As String = "1"
            'oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_IsUserBranch(" & strUID & ") ISBRANCH")
            'If oSDR.Read() Then
            '    strUserBranch = oSDR("ISBRANCH").ToString()
            'End If
            'oSDR.Close()
            'oSDR = Nothing


            'oSDR = objDB.CreateSDRFromSQLSelect("SELECT BRANCHID, AREAID, '(' + BRANCHCODE + ') ' +  BRANCHNAME BRANCHNAME FROM BRANCH WITH(nolock)  WHERE AREAID=" & strAreaID & " AND DELETESTS=0 AND ACTIVE=1 AND BRANCHID IN (SELECT BRANCHID FROM APPUSERBRANCH WHERE UID=" & strUID & "  AND DELETESTS=0) ORDER BY BRANCHCODE")
            'If strUserBranch = "1" Then
            If strUID <> "-999" And Len(Trim(strUID)) > 0 Then
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT BRANCHID, AREAID, BRANCHCODE + ' - ' +  BRANCHNAME BRANCHNAME FROM BRANCH WITH(nolock)  WHERE AREAID=" & strAreaID & " AND DELETESTS=0 AND ACTIVE=1 AND (BRANCHID IN (SELECT BRANCHID FROM dbo.f_getAPPUSERBRANCHList(" & strUID & " )) OR 0=dbo.f_IsUserBranch(" & strUID & ")) ORDER BY BRANCHCODE")
            Else
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT BRANCHID, AREAID, BRANCHCODE + ' - ' +  BRANCHNAME BRANCHNAME FROM BRANCH WITH(nolock)  WHERE AREAID=" & strAreaID & " AND DELETESTS=0 AND ACTIVE=1 ORDER BY BRANCHCODE")
            End If

            'Else
            'oSDR = objDB.CreateSDRFromSQLSelect("SELECT BRANCHID, AREAID, '(' + BRANCHCODE + ') ' +  BRANCHNAME BRANCHNAME FROM BRANCH WITH(nolock)  WHERE AREAID=" & strAreaID & " AND DELETESTS=0 AND ACTIVE=1 ORDER BY BRANCHCODE")
            'End If

            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("BRANCHNAME").ToString(), oSDR("BRANCHID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    '<System.Web.Services.WebMethod()> _
    'Public Shared Function GetDropDownListValues(ByVal knownCategoryValues As String, ByVal category As String, ByVal contextKey As String) As CascadingDropDownNameValue()

    '    Dim arrValues As String()
    '    If category = "Make" Then
    '        arrValues = New String() {"Ford", "Dodge"}
    '    ElseIf category = "Model" Then
    '        Dim kv As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
    '        Dim make As String = kv("Make")
    '        '**************************
    '        'Use the ContextKey
    '        'Then we can use the ContextKey as the dynamic parameter.
    '        If Not String.IsNullOrEmpty(contextKey) Then
    '            arrValues = New String() {"The ContextKey is " + contextKey}
    '            '**********************
    '        ElseIf make = "Ford" Then
    '            arrValues = New String() {"Explorer", "F150", "Mustang"}
    '        ElseIf make = "Dodge" Then
    '            arrValues = New String() {"Durango", "Dakota", "Viper"}
    '        Else
    '            Return Nothing
    '        End If
    '    Else
    '        Return Nothing
    '    End If
    '    Dim values As New List(Of CascadingDropDownNameValue)
    '    For Each itm As String In arrValues
    '        values.Add(New CascadingDropDownNameValue(itm, itm))
    '    Next
    '    Return values.ToArray()

    'End Function


    <WebMethod()> _
    Public Function GetDropDownBranchByAreaWithAll(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strAreaID As String = categoryValues("AREA")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            If strAreaID = "-1" Then
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT -1 BRANCHID, NULL BRANCHCODE, '[ALL BRANCH]' BRANCHNAME UNION ALL " & _
                    "SELECT BRANCHID, AREAID, BRANCHCODE + ' - ' +  BRANCHNAME BRANCHNAME FROM BRANCH WITH(nolock)  WHERE DELETESTS=0 AND ACTIVE=1")
            Else
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT -1 BRANCHID, BRANCHCODE, '[ALL BRANCH]' BRANCHNAME UNION ALL " & _
                    "SELECT BRANCHID, AREAID, BRANCHCODE + ' - ' +  BRANCHNAME BRANCHNAME FROM BRANCH WITH(nolock)  WHERE AREAID=" & strAreaID & " AND DELETESTS=0 AND ACTIVE=1 ORDER BY BRANCHCODE")
            End If
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("BRANCHNAME").ToString(), oSDR("BRANCHID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownBranch(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT BRANCHID, BRANCHCODE+ ' - ' + BRANCHNAME BRANCHNAME FROM BRANCH WITH(nolock)  WHERE DELETESTS=0 ORDER BY BRANCHCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("BRANCHNAME").ToString(), oSDR("BRANCHID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function


    <WebMethod()> _
    Public Function GetDropDownSource(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("select ID, NAME from sysobjects where XTYPE IN ('U', 'V') ORDER BY NAME")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("NAME").ToString(), oSDR("NAME").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownFieldBySource(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strSource As String = categoryValues("SOURCE")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("select NAME from syscolumns where id=object_id('" & strSource & "')")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("NAME").ToString(), oSDR("NAME").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function


    <WebMethod()> _
    Public Function GetDropDownCompGroup(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT COMPGROUPID, COMPGROUPCODE + ' - ' + COMPGROUPNAME COMPGROUPNAME FROM COMPANYGROUP WITH(nolock)  WHERE DELETESTS=0 ORDER BY COMPGROUPCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("COMPGROUPNAME").ToString(), oSDR("COMPGROUPID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownCompGroupWithAll(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT -1 COMPGROUPID, NULL COMPGROUPCODE, '[ALL COMPANY GROUP]' COMPGROUPNAME UNION ALL " & _
                "SELECT COMPGROUPID, COMPGROUPCODE, COMPGROUPCODE + ' - ' + COMPGROUPNAME COMPGROUPNAME FROM COMPANYGROUP WITH(nolock)  WHERE DELETESTS=0 ORDER BY COMPGROUPCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("COMPGROUPNAME").ToString(), oSDR("COMPGROUPID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function


    <WebMethod()> _
    Public Function GetDropDownCompany(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT COMPID, COMPCODE + ' - ' + COMPNAME COMPNAME FROM COMPANY WITH(nolock)  WHERE DELETESTS=0 ORDER BY COMPCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("COMPNAME").ToString(), oSDR("COMPID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function


    <WebMethod()> _
    Public Function GetDropDownCompanyByCompGroup(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strCompGroupID As String = categoryValues("COMPGROUP")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT COMPID, COMPCODE, COMPCODE + ' - ' +  COMPNAME COMPNAME FROM COMPANY WITH(nolock)  WHERE COMPGROUPID=" & strCompGroupID & " AND DELETESTS=0 ORDER BY COMPCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("COMPNAME").ToString(), oSDR("COMPID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function


    <WebMethod()> _
    Public Function GetDropDownMaterial(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT NULL AS MATERIALMASTERID, '[DISPLAY ALL]' AS MATERIALMASTERNAME UNION ALL SELECT MATERIALMASTERID, MATERIALMASTERNAME FROM MATERIALMASTER WHERE (DELETESTS= 0) ORDER BY MATERIALMASTERNAME")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("MATERIALMASTERNAME").ToString(), oSDR("MATERIALMASTERID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownBuyer(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT BUYERID, BUYERCODE  + ' - ' + BUYERNAME BUYERNAME FROM MASTERBUYER WITH(nolock)  WHERE DELETESTS=0 ORDER BY BUYERCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("BUYERNAME").ToString(), oSDR("BUYERID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function
    <WebMethod()> _
    Public Function GetDropDownStatus(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT CODE, CODE  + ' - ' + NAME NAME FROM PARAMGLOBAL WITH(nolock)  WHERE TYPE='USERSTATUS' ORDER BY CODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("NAME").ToString(), oSDR("CODE").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function
    <WebMethod()> _
    Public Function GetDropDownColour(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT COLOURID, COLOURCODE  + ' - ' + COLOURNAME COLOURNAME FROM MASTERCOLOUR WITH(nolock)  WHERE DELETESTS=0 ORDER BY COLOURCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("COLOURNAME").ToString(), oSDR("COLOURID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownItem(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT MATERIALMASTERID, MATERIALMASTERCODE  + ' - ' + MATERIALMASTERNAME MATERIALMASTERNAME FROM MATERIALMASTER WITH(nolock)  WHERE DELETESTS=0 ORDER BY MATERIALMASTERCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("MATERIALMASTERNAME").ToString(), oSDR("MATERIALMASTERID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function
    <WebMethod()> _
    Public Function GetDropDownAgent(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT AGENTID, AGENTCODE  + ' - ' + AGENTNAME AGENTNAME FROM MASTERAGENT WITH(nolock)  WHERE DELETESTS=0 ORDER BY AGENTCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("AGENTNAME").ToString(), oSDR("AGENTID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function
    <WebMethod()> _
    Public Function GetDropDownProductType(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT PRODUCTTYPEID, PRODUCTTYPECODE  + ' - ' + PRODUCTTYPENAME PRODUCTTYPENAME FROM PRODUCTTYPE WITH(nolock)  WHERE DELETESTS=0 ORDER BY PRODUCTTYPECODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("PRODUCTTYPENAME").ToString(), oSDR("PRODUCTTYPEID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function
    '<WebMethod()> _
    'Public Function GetDropDownCosting(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
    '    Dim objDB As New DBX
    '    Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
    '    Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

    '    Try
    '        Dim oSDR As System.Data.SqlClient.SqlDataReader
    '        oSDR = objDB.CreateSDRFromSQLSelect("SELECT COSTINGHDRID, COSTINGHDRNUMBER  + ' - ' + COSTINGHDRNUMBER COSTINGHDRNUMBER FROM COSTINGHDR WITH(nolock)  WHERE DELETESTS=0 AND STATUS =1 ORDER BY COSTINGHDRNUMBER")
    '        While oSDR.Read()
    '            cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("BUYERNAME").ToString(), oSDR("BUYERID").ToString()))
    '        End While
    '        oSDR.Close()
    '        oSDR = Nothing
    '    Catch ex As Exception
    '        Throw
    '    Finally
    '        objDB.Close()
    '        objDB = Nothing
    '    End Try
    '    Return cascadingValues.ToArray()
    'End Function
    <WebMethod()> _
    Public Function GetDropDownCosting(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT COSTINGHDRID , BUYERNAME   + ' - ' + COSTINGHDRNUMBER COSTINGHDRNUMBER FROM COSTINGHDR CHD WITH(nolock) INNER JOIN MASTERBUYER MB ON CHD.BUYERID = MB.BUYERID  WHERE CHD.DELETESTS=0 ORDER BY COSTINGHDRNUMBER")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("COSTINGHDRNUMBER").ToString(), oSDR("COSTINGHDRID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function
    <WebMethod()> _
    Public Function GetDropDownWSNumberPO(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT WORKSHEETHDRID , COSTINGHDRNUMBER   + ' - ' + WORKSHEETHDRNUMBER WORKSHEETHDRNUMBER FROM WORKSHEETHDR WS WITH(nolock) INNER JOIN COSTINGHDR CH ON WS.COSTINGHDRID = CH.COSTINGHDRID  WHERE WS.DELETESTS=0 AND WS.STATUS = 1 ORDER BY WORKSHEETHDRNUMBER")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("WORKSHEETHDRNUMBER").ToString(), oSDR("WORKSHEETHDRID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function
    <WebMethod()> _
    Public Function GetDropDownSupplierPO(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT SUPPLIERID, SUPPLIERCODE  + ' - ' +  SUPPLIERNAME SUPPLIERNAME FROM MASTERSUPPLIER WITH(nolock)  WHERE DELETESTS=0 ORDER BY SUPPLIERCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("SUPPLIERNAME").ToString(), oSDR("SUPPLIERID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownPR(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT BOMID , BUYERNAME   + ' - ' + BOMCODE BOMCODE FROM BOM B WITH(nolock) INNER JOIN MASTERBUYER MB ON B.BUYERID = MB.BUYERID  WHERE B.DELETESTS=0 AND B.STATUS = 1 ORDER BY BOMCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("BOMCODE").ToString(), oSDR("BOMID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function
    <WebMethod()> _
    Public Function GetDropDownPaymentType(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT NULL AS CODE, '[PAYMENT TYPE]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'MKTPAYMENTTYPE') ORDER BY CODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("NAME").ToString(), oSDR("CODE").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function
    <WebMethod()> _
    Public Function GetDropDownShipmentMode(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT NULL AS CODE, '[SHIPMENT MODE]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'SHIPMENT') ORDER BY CODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("NAME").ToString(), oSDR("CODE").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function
    <WebMethod()> _
    Public Function GetDropDownComplexity(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT NULL AS KOMPLEKSITIFAKTORDTLID, '[DISPLAY ALL]' AS KOMPLEKSITIFAKTORDTLNAME UNION ALL SELECT KOMPLEKSITIFAKTORDTLID, KOMPLEKSITIFAKTORDTLNAME FROM MASTERKOMPLEKSITIDTL WHERE (DELETESTS= 0) ORDER BY KOMPLEKSITIFAKTORDTLNAME")

            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("KOMPLEKSITIFAKTORDTLNAME").ToString(), oSDR("KOMPLEKSITIFAKTORDTLID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownProductItem(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT PRODUCTID, PRODUCTCODE  + ' - ' + PRODUCTNAME PRODUCTNAME FROM PRODUCT WITH(nolock)  WHERE DELETESTS=0 ORDER BY PRODUCTCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("PRODUCTNAME").ToString(), oSDR("PRODUCTID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownMaterialGroup(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("  SELECT MATERIALGROUPID, MATERIALGROUPCODE  + ' - ' + MATERIALGROUPNAME MATERIALGROUPNAME FROM MATERIALGROUP WITH(nolock)  WHERE DELETESTS=0 ORDER BY MATERIALGROUPCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("MATERIALGROUPNAME").ToString(), oSDR("MATERIALGROUPID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownMasterUnit(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT NULL AS MASTERUNITID, '[---]' AS MASTERUNITCODE UNION ALL SELECT MASTERUNITID, MASTERUNITCODE FROM MASTERUNIT WHERE (DELETESTS= 0) ORDER BY MASTERUNITCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("MASTERUNITCODE").ToString(), oSDR("MASTERUNITID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function
    <WebMethod()> _
    Public Function GetDropDownCurrency(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT CURRENCYID, CURRENCYCODE  + ' - ' + CURRENCYCODE CURRENCYCODE FROM CURRENCY WITH(nolock)  WHERE DELETESTS=0 ORDER BY CURRENCYCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("CURRENCYCODE").ToString(), oSDR("CURRENCYID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownJFByJFGroupWithAll(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strJFGroupID As String = categoryValues("JFGroup")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            If strJFGroupID = "-1" Then
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT -1 JFID, NULL JFCODE, '[ALL JF]' JFNAME UNION ALL " & _
                    "SELECT JFID, JFGroupID, JFCODE + ' - ' +  JFNAME JFNAME FROM JF WITH(nolock)  WHERE DELETESTS=0 ")
            Else
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT -1 JFID, JFCODE, '[ALL JF]' JFNAME UNION ALL " & _
                    "SELECT JFID, JFGroupID, JFCODE + ' - ' +  JFNAME JFNAME FROM JF WITH(nolock)  WHERE JFGroupID=" & strJFGroupID & " AND DELETESTS=0 ORDER BY JFCODE")
            End If
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("JFNAME").ToString(), oSDR("JFID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownJF(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT JFID, JFCODE+ ' - ' + JFNAME JFNAME FROM JF WITH(nolock)  WHERE DELETESTS=0 ORDER BY JFCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("JFNAME").ToString(), oSDR("JFID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownMerkByProduct(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strProductID As String = categoryValues("Product")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT MERKID, MERKCODE + ' - ' +  MERKNAME MERKNAME FROM MERK WITH(nolock)  WHERE PRODUCTID=" & strProductID & " AND DELETESTS=0  ORDER BY MERKCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("MERKNAME").ToString(), oSDR("MERKID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownProduct(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT PRODUCTID, PRODUCTCODE + ' - ' + PRODUCTNAME PRODUCTNAME FROM PRODUCT WITH(nolock)  WHERE DELETESTS=0 ORDER BY PRODUCTCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("PRODUCTNAME").ToString(), oSDR("PRODUCTID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownMerk(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT MERKID, MERKCODE + ' - ' + MERKNAME MERKNAME FROM MERK WITH(nolock)  WHERE DELETESTS=0 ORDER BY MERKCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("MERKNAME").ToString(), oSDR("MERKID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownModelByMerk(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strMerkID As String = categoryValues("Merk")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT MODELID, MERKID, MODELCODE + ' - ' +  MODELNAME MODELNAME FROM MODEL WITH(nolock)  WHERE MERKID=" & strMerkID & " AND DELETESTS=0  ORDER BY MODELCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("MODELNAME").ToString(), oSDR("MODELID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function


    <WebMethod()> _
    Public Function GetDropDownObjecTypeByModel(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strModelID As String = categoryValues("Model")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT OBJECTTYPEID, MODELID, TYPENAME FROM OBJECTTYPE WITH(nolock)  WHERE MODELID=" & strModelID & " AND DELETESTS=0  ORDER BY TYPENAME")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("TYPENAME").ToString(), oSDR("OBJECTTYPEID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownObjCategoryByObjectType(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strObjectTypeID As String = categoryValues("TYPE")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT  OBJECTTYPE.OBJECTTYPEID , OBJECTCATEGORY.CATEGORYID, CATEGORYCODE + ' - ' +  CATEGORYNAME CATEGORYNAME FROM OBJECTTYPE WITH(nolock) INNER JOIN OBJECTCATEGORY WITH(NOLOCK)ON OBJECTCATEGORY.CATEGORYID = OBJECTTYPE.CATEGORYID WHERE OBJECTTYPE.OBJECTTYPEID=" & strObjectTypeID & " AND OBJECTCATEGORY.DELETESTS=0  ORDER BY CATEGORYCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("CATEGORYNAME").ToString(), oSDR("CATEGORYID").ToString()))
            End While

            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function


    <WebMethod()> _
    Public Function GetDropDownProductByDealer(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strDealerID As String = categoryValues("Dealer")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT PRODUCT.PRODUCTID, PRODUCT.PRODUCTCODE, PRODUCTCODE + ' - ' + PRODUCTNAME  AS PRODUCTNAME FROM DEALERPRODUCT WITH(NOLOCK) INNER JOIN PRODUCT WITH(NOLOCK) ON DEALERPRODUCT.PRODUCTID = PRODUCT.PRODUCTID WHERE DEALERPRODUCT.DEALERIDD=" & strDealerID & " AND DEALERPRODUCT.DELETESTS=0  ORDER BY PRODUCT.PRODUCTCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("PRODUCTNAME").ToString(), oSDR("PRODUCTID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownObjPurposeByProduct(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strProductID As String = categoryValues("Product")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT PURPOSEID, PURPOSECODE + ' - ' +  PURPOSENAME PURPOSENAME FROM OBJECTPURPOSE WITH(nolock)  WHERE PRODUCTID=" & strProductID & " AND DELETESTS=0  ORDER BY PURPOSECODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("PURPOSENAME").ToString(), oSDR("PURPOSEID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownObjPurposeByProductWithAll(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strProductID As String = categoryValues("Product")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT -1 PURPOSEID, NULL PURPOSECODE, '[ALL PURPOSE]' PURPOSENAME UNION ALL SELECT PURPOSEID, PURPOSECODE, '(' + PURPOSECODE + ') ' +  PURPOSENAME PURPOSENAME FROM OBJECTPURPOSE WITH(nolock)  WHERE PRODUCTID=" & strProductID & " AND DELETESTS=0  ORDER BY PURPOSECODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("PURPOSENAME").ToString(), oSDR("PURPOSEID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function


    <WebMethod()> _
    Public Function GetDropDownObjCategoryByProduct(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strProductID As String = categoryValues("Product")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT CATEGORYID, CATEGORYCODE + ' - ' +  CATEGORYNAME CATEGORYNAME FROM OBJECTCATEGORY WITH(nolock)  WHERE PRODUCTID=" & strProductID & " AND DELETESTS=0  ORDER BY CATEGORYCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("CATEGORYNAME").ToString(), oSDR("CATEGORYID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownDocSafeByBranch(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strBranchID As String = categoryValues("BRANCH")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT DOCSAFEID, BRANCHID, DOCSAFECODE + ' - ' +  DOCSAFENAME DOCSAFENAME FROM DOCSAFE WITH(nolock)  WHERE BRANCHID=" & strBranchID & " AND DELETESTS=0 ORDER BY DOCSAFECODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("DOCSAFENAME").ToString(), oSDR("DOCSAFEID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownDocShelfByDocSafe(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strDocSafeID As String = categoryValues("DOCSAFE")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT DOCSHELFID, DOCSAFEID,  DOCSHELFCODE + ' - ' +  DOCSHELFNAME DOCSHELFNAME FROM DOCSHELF WITH(nolock)  WHERE DOCSHELFID=" & strDocSafeID & " AND DELETESTS=0 ORDER BY DOCSHELFCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("DOCSHELFNAME").ToString(), oSDR("DOCSHELFID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownTypeCollector(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT CODE, CODE + ' - ' + NAME AS TYPENAME FROM PARAMGLOBAL WITH (nolock) WHERE TYPE='COLLECTORTYPE' ORDER BY CODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("TYPENAME").ToString(), oSDR("CODE").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownTitleTypeByType(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strCollectorType As String = categoryValues("COLLECTORTYPE")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT COLLECTORTITLEID, COLLECTORTITLECODE, COLLECTORTITLECODE + ' - ' + COLLECTORTITLENAME AS COLLECTORTITLENAME  FROM COLLECTORTITLE WITH(NOLOCK) WHERE COLLECTORTYPE=" & strCollectorType & " ORDER BY COLLECTORTITLECODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("COLLECTORTITLENAME").ToString(), oSDR("COLLECTORTITLEID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownInsuranceCompany(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT INSCOMPANYID, INSURANCECODE , INSURANCECODE + ' - ' + INSURANCENAME AS  INSURANCENAME FROM INSCOMPANY WITH(NOLOCK) WHERE Deletests=0 ORDER BY INSURANCECODE ")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("INSURANCENAME").ToString(), oSDR("INSCOMPANYID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownBranchByInsCompany(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strInsCompanyID As String = categoryValues("INSCOMPANYID")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT INSBRANCHID, INSBRANCHCODE, INSBRANCHCODE + ' - ' + INSBRANCHNAME AS  INSBRANCHNAME FROM INSBRANCH WITH(NOLOCK) WHERE Deletests = 0 And INSCOMPANYID = " & strInsCompanyID & " ORDER BY INSBRANCHCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("INSBRANCHNAME").ToString(), oSDR("INSBRANCHID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function
    <WebMethod()> _
    Public Function GetDropDownSoNumber(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strCostingID As String = categoryValues("COSTINGHDRID")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT SOHDRID,POBUYER, SOHDRNUMBER AS SOHDRNUMBER FROM SOHDR WITH(NOLOCK) WHERE (DELETESTS = 0) AND COSTINGHDRID = " & strCostingID & "  ORDER BY SOHDRNUMBER")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("SOHDRNUMBER").ToString(), oSDR("SOHDRID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function
  
    <WebMethod()> _
    Public Function GetDropDownGroupBOM(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strCostingHdrID As String = categoryValues("COSTINGHDRID")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT DISTINCT CI.COSTINGHDRID ,CI.MATERIALGROUPID, MG.MATERIALGROUPCODE + ' - ' + MG.MATERIALGROUPNAME AS MATERIALGROUPNAME " & _
                                                 "FROM COSTINGHDR CH WITH(NOLOCK) " & _
                                                "LEFT OUTER JOIN COSTINGINPUT CI ON CH.COSTINGHDRID = CI.COSTINGHDRID " & _
                                                "LEFT OUTER JOIN MATERIALGROUP MG ON CI.MATERIALGROUPID = MG.MATERIALGROUPID " & _
                                                 "WHERE (CI.DELETESTS = 0) AND CI.COSTINGHDRID = " & strCostingHdrID & "   ORDER BY MATERIALGROUPNAME")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("MATERIALGROUPNAME").ToString(), oSDR("MATERIALGROUPID").ToString()))
                End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownMaterialByGroup(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strProductID As String = categoryValues("MATERIALGROUPID")
        Dim strCostingHdrID As String = categoryValues("COSTINGHDRID")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT CI.MATERIALMASTERID,MM.MATERIALMASTERCODE + '  -  ' + MIH.MATERIALITEMHDRNAME + '  -  ' + MGD.MATERIALGROUPDETAILNAME AS MATERIALMASTERNAME " & _
                                                " FROM COSTINGINPUT CI " & _
                                                " LEFT OUTER JOIN MATERIALMASTER MM ON CI.MATERIALMASTERID = MM.MATERIALMASTERID " & _
                                                " LEFT OUTER JOIN MATERIALITEMHDR MIH ON MM.MATERIALITEMHDRID = MIH.MATERIALITEMHDRID " & _
                                                " LEFT OUTER JOIN MATERIALGROUP MG ON CI.MATERIALGROUPID = MG.MATERIALGROUPID " & _
                                                " LEFT OUTER JOIN MATERIALGROUPDETAIL MGD ON MG.MATERIALGROUPID = MGD.MATERIALGROUPDETAILID " & _
                                                " WHERE CI.DELETESTS = 0 AND CI.COSTINGHDRID = " & strCostingHdrID & "")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("MATERIALMASTERNAME").ToString(), oSDR("MATERIALMASTERID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function
    <WebMethod()> _
    Public Function GetDropDownSizeSO(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strSizeID As String = categoryValues("SOHDRID")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT SR.SIZERANGEID, SR.SIZE FROM SIZEPOBUYER SPB LEFT OUTER JOIN SIZERANGE SR ON SPB.SIZERANGEID = SR.SIZERANGEID WHERE SPB.DELETESTS = 0 AND SPB.SOHDRID = " & strSizeID & "")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("SIZE").ToString(), oSDR("SIZERANGEID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownPurposeByCategory(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strProductID As String = categoryValues("ProductID")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT PURPOSEID, PURPOSECODE, PURPOSECODE + ' - ' + PURPOSENAME AS PURPOSENAME FROM OBJECTPURPOSE WITH(NOLOCK) WHERE (DELETESTS = 0) AND PRODUCTID =" & strProductID & " ORDER BY PURPOSECODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("PURPOSENAME").ToString(), oSDR("PURPOSEID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownBranchByArea1(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strAreaID As String = categoryValues("AREAID")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT NULL AS BRANCHID, NULL AS AREAID, '( ALL BRANCH ) ' AS BRANCHNAME UNION ALL SELECT BRANCHID, AREAID, BRANCHCODE + ' - ' +  BRANCHNAME BRANCHNAME FROM BRANCH WITH(nolock)  WHERE AREAID=" & strAreaID & " AND DELETESTS=0 AND ACTIVE=1")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("BRANCHNAME").ToString(), oSDR("BRANCHID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownObjectKindByProduct(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strProductID As String = categoryValues("ProductID")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT PURPOSECATID, PURPOSECATCODE, PURPOSECATCODE + ' - ' + PURPOSECATNAME AS PURPOSECATNAME FROM OBJECTPURPOSECAT WITH(NOLOCK) WHERE (DELETESTS = 0) AND PRODUCTID =" & strProductID & " ORDER BY PURPOSECATCODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("PURPOSECATNAME").ToString(), oSDR("PURPOSECATID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownNotaryByBranch(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strBranchID As String = categoryValues("BRANCH")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            'If Len(Trim(strBranchID)) = -999 Then
            '    oSDR = objDB.CreateSDRFromSQLSelect("SELECT NOTARY.NOTARYID,'(' + NOTARY.NOTARYCODE + ') ' + NOTARY.NOTARYNAME AS NOTARYNAME FROM NOTARY WITH (NOLOCK) WHERE Deletests=0")
            'Else
            '    oSDR = objDB.CreateSDRFromSQLSelect("SELECT NOTARY.NOTARYID,'(' + NOTARY.NOTARYCODE + ') ' + NOTARY.NOTARYNAME AS NOTARYNAME" & _
            '                                        " FROM NOTARY WITH (NOLOCK) WHERE Deletests=0 AND (EXISTS(SELECT 'X' FROM NOTARY AS NOTARY_1 WITH(NOLOCK)" & _
            '                                        "WHERE Deletests=0 AND NOTARY.BRANCHID=NOTARY_1.BRANCHID AND NOTARY.NOTARYID= NOTARY_1.NOTARYID AND NOTARY_1.BRANCHID=" & strBranchID & ")) ORDER BY NOTARYCODE")
            'End If
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT NOTARY.NOTARYID, NOTARY.NOTARYCODE + ' - ' + NOTARY.NOTARYNAME AS NOTARYNAME" & _
                                    " FROM NOTARY WITH (NOLOCK) WHERE Deletests=0 AND (EXISTS(SELECT 'X' FROM NOTARY AS NOTARY_1 WITH(NOLOCK)" & _
                                    "WHERE Deletests=0 AND NOTARY.BRANCHID=NOTARY_1.BRANCHID AND NOTARY.NOTARYID= NOTARY_1.NOTARYID AND NOTARY_1.BRANCHID=" & strBranchID & ")) ORDER BY NOTARYCODE")

            If Not oSDR.HasRows Then
                oSDR.Close()
                oSDR = Nothing
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT NOTARY.NOTARYID,'(' + NOTARY.NOTARYCODE + ') ' + NOTARY.NOTARYNAME AS NOTARYNAME FROM NOTARY WITH (NOLOCK) WHERE Deletests=0")
            End If

            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("NOTARYNAME").ToString(), oSDR("NOTARYID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownNotaryByBranchContextKey(ByVal knownCategoryValues As String, _
       ByVal category As String, _
       ByVal contextKey As String) As AjaxControlToolkit.CascadingDropDownNameValue()

        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strBranchID As String = contextKey

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            If Len(Trim(strBranchID)) > 0 Then
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT NOTARY.NOTARYID, NOTARY.NOTARYCODE + ' - ' + NOTARY.NOTARYNAME AS NOTARYNAME" & _
                                        " FROM NOTARY WITH (NOLOCK) WHERE Deletests=0 AND (EXISTS(SELECT 'X' FROM NOTARY AS NOTARY_1 WITH(NOLOCK)" & _
                                        "WHERE Deletests=0 AND NOTARY.BRANCHID=NOTARY_1.BRANCHID AND NOTARY.NOTARYID= NOTARY_1.NOTARYID AND NOTARY_1.BRANCHID=" & strBranchID & ")) ORDER BY NOTARYCODE")
            Else
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT NOTARY.NOTARYID, NOTARY.NOTARYCODE + ' - ' + NOTARY.NOTARYNAME AS NOTARYNAME FROM NOTARY WITH (NOLOCK) WHERE Deletests=0")
            End If


            If Not oSDR.HasRows Then
                oSDR.Close()
                oSDR = Nothing
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT NOTARY.NOTARYID, NOTARY.NOTARYCODE + ' - ' + NOTARY.NOTARYNAME AS NOTARYNAME FROM NOTARY WITH (NOLOCK) WHERE Deletests=0")
            End If

            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("NOTARYNAME").ToString(), oSDR("NOTARYID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function


    <WebMethod()> _
    Public Function GetDropDownAgentByInsCompany(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strInsCompanyID As String = categoryValues("INSCOMPANYID")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT INSCOMPANY.INSCOMPANYID, INSURANCECODE + ' - ' + INSURANCENAME AS INSURANCENAME FROM INSCOMPANY INNER JOIN INSMEMBER ON INSMEMBER.INSCOMPANYIDAGENT=INSCOMPANY.INSCOMPANYID WHERE (INSMEMBER.Deletests = 0) AND (INSMEMBER.INSCOMPANYID = " & strInsCompanyID & " ) AND (BROKERFLAG = 0) ORDER BY INSCOMPANY.INSURANCECODE")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("INSURANCENAME").ToString(), oSDR("INSCOMPANYID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownDealerDisburse(ByVal knownCategoryValues As String, ByVal category As String, ByVal contextKey As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strDisburseSts As String = contextKey
        If Len(Trim(strDisburseSts)) <= 0 Then strDisburseSts = "-1"
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader

            oSDR = objDB.CreateSDRFromSQLSelect("SELECT DEALERID, DEALERCODE, DEALERNAME + ' (' + DEALERCODE + ')' AS DEALERNAME " & _
            " FROM DEALER WITH (NOLOCK) " & _
            " WHERE EXISTS " & _
            "     (SELECT     'X' " & _
            "     FROM  ACCOUNT WITH (NOLOCK) INNER JOIN " & _
            "           COLLATERAL WITH (NOLOCK) ON ACCOUNT.LOCID = COLLATERAL.LOCID AND ACCOUNT.ACCID = COLLATERAL.ACCID " & _
            "     WHERE  (COLLATERAL.DEALERID = DEALER.DEALERID) AND (ACCOUNT.ACCSTATUS <> 0) AND (ACCOUNT.DISBURSESTS = " & strDisburseSts & ")) " & _
            " ORDER BY DEALERNAME")

            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("DEALERNAME").ToString(), oSDR("DEALERID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownDealerAccount(ByVal knownCategoryValues As String, ByVal category As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strDealerID As String = categoryValues("DEALER")
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader

            oSDR = objDB.CreateSDRFromSQLSelect("SELECT DEALERACCOUNT.DEALERACCOUNTID, BANK.BANKNAME + '- ' + DEALERACCOUNT.ACCNO + ' - ' + DEALERACCOUNT.ACCNAME AS DEALERACCOUNTNO " & _
                    " FROM DEALERACCOUNT WITH (NOLOCK) INNER JOIN " & _
                    "     BANK WITH (NOLOCK) ON DEALERACCOUNT.ACCBANKID = BANK.BANKID " & _
                    " WHERE (DEALERACCOUNT.DEALERID = " & strDealerID & ") AND (DEALERACCOUNT.Deletests = 0) " & _
                    " ORDER BY DEALERACCOUNT.BANKACCSTATUS DESC")
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("DEALERACCOUNTNO").ToString(), oSDR("DEALERACCOUNTID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownDealerDisbursePending(ByVal knownCategoryValues As String, ByVal category As String, ByVal contextKey As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strDisburseSts As String = contextKey
        If Len(Trim(strDisburseSts)) <= 0 Then strDisburseSts = "-1"
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader

            oSDR = objDB.CreateSDRFromSQLSelect("SELECT DEALERID, DEALERCODE, DEALERNAME + ' (' + DEALERCODE + ')' AS DEALERNAME " & _
            " FROM DEALER WITH (NOLOCK) " & _
            " WHERE EXISTS " & _
            "     (SELECT     'X' " & _
            "     FROM  ACCOUNT WITH (NOLOCK) INNER JOIN " & _
            "           COLLATERAL WITH (NOLOCK) ON ACCOUNT.LOCID = COLLATERAL.LOCID AND ACCOUNT.ACCID = COLLATERAL.ACCID " & _
            " INNER JOIN ACCOUNTDTL ON ACCOUNT.LOCID = ACCOUNTDTL.LOCID AND ACCOUNT.ACCID = ACCOUNTDTL.ACCID " & _
            "     WHERE  (COLLATERAL.DEALERID = DEALER.DEALERID) AND (ACCOUNT.ACCSTATUS <> 0) AND (ACCOUNTDTL.PENDINGDISBURSE>0 AND ACCOUNTDTL.PENDINGSTS = " & strDisburseSts & ")) " & _
            " ORDER BY DEALERNAME")

            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("DEALERNAME").ToString(), oSDR("DEALERID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownFinCatbyAppUserBranch(ByVal knownCategoryValues As String, ByVal category As String, ByVal contextKey As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strUID As String = contextKey
        ' Dim strUID As String = handler
        If Len(Trim(strUID)) <= 0 Then strUID = "-1"
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader

            If strUID <> "-999" And Len(Trim(strUID)) > 0 Then
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT FINCATID, FINCATCODE + ' - ' + FINCATNAME AS FINCATNAME " & _
                    " FROM FINANCECATEGORY " & _
                    " WHERE (Deletests = 0) " & _
                    " AND EXISTS (SELECT 'X' FROM dbo.f_getAPPUSERFINCATList(" & strUID & ") a " & _
                    " WHERE a.FINCATID=FINANCECATEGORY.FINCATID) " & _
                    " ORDER BY FINCATCODE")
            Else
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT FINCATID, FINCATCODE + ' - ' + FINCATNAME AS FINCATNAME FROM FINANCECATEGORY WHERE Deletests=0 ORDER BY FINCATCODE")
            End If

            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("FINCATNAME").ToString(), oSDR("FINCATID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

    <WebMethod()> _
    Public Function GetDropDownBankAccountByUIDAndFinCat(ByVal knownCategoryValues As String, ByVal category As String, ByVal contextKey As String) As AjaxControlToolkit.CascadingDropDownNameValue()
        Dim objDB As New DBX
        Dim cascadingValues As New List(Of AjaxControlToolkit.CascadingDropDownNameValue)()
        Dim categoryValues As StringDictionary = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues)
        Dim strContext As String = contextKey
        Dim arrContext As String() = strContext.Split(",")
        ' Dim strUID As String = handler
        Dim strUID As String = arrContext(0)
        Dim strFinCatID As String = arrContext(1)

        If Len(Trim(strUID)) <= 0 Then strUID = "-1"

        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader

            oSDR = objDB.CreateSDRFromSP("GETBankAccountByUIDAndFINCAT",
                        objDB.MP("@UID", Data.SqlDbType.VarChar, strUID),
                        objDB.MP("@FINCATID", Data.SqlDbType.VarChar, strFinCatID)
                        )
            While oSDR.Read()
                cascadingValues.Add(New AjaxControlToolkit.CascadingDropDownNameValue(oSDR("ACCOUNTNO").ToString(), oSDR("ACCOUNTID").ToString()))
            End While
            oSDR.Close()
            oSDR = Nothing
            'Catch ex As Exception
            '    Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        Return cascadingValues.ToArray()
    End Function

End Class

