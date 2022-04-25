Imports Microsoft.VisualBasic



Public Class Sessions

    Public Sub UpdateTimeOut(ByVal strUID As String)
        Dim objDB As New DBX
        Try
            Dim lngErr As Integer = objDB.ExecSPRetIntegerNoTxn("APPSessionsUpdateTimeOut", objDB.MP("@UID", Data.SqlDbType.VarChar, strUID))
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Function CheckSession(ByVal strUID As String, _
            ByVal strSessionID As String) As Byte
        Dim objDB As New DBX
        Try
            CheckSession = objDB.ExecSPRetIntegerNoTxn("APPSessionsCheckTimeOut", _
                objDB.MP("@UID", Data.SqlDbType.VarChar, strUID), _
                objDB.MP("@SessionID", Data.SqlDbType.VarChar, strSessionID))
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Function


    Private Function Random(ByVal intCharLength As Integer) As String
        Dim strReturn As String
        Dim i, intUpperBound, intLowerBound, intCharOrNum As Integer
        Randomize()
        strReturn = ""
        For i = 1 To intCharLength
            intUpperBound = 1
            intLowerBound = 0
            intCharOrNum = Int((intUpperBound - intLowerBound + 1) * Rnd() + intLowerBound)
            If intCharOrNum = 1 Then   '--- Char
                intUpperBound = 122      ' z
                intLowerBound = 97       ' a
            Else                    '--- Num
                intUpperBound = 57       ' 9
                intLowerBound = 48       ' 0
            End If
            strReturn = strReturn & Chr(Int((intUpperBound - intLowerBound + 1) * Rnd() + intLowerBound))
        Next
        Random = strReturn
    End Function

    Public Sub SessionNew( _
        ByVal strUID As String, _
        ByVal lngTimeOutMinute As Long, _
        ByVal strIPAddress As String, _
        Optional ByRef strSessionID As String = "")

        Dim objDB As New DBX

        Try
            objDB.ExecSQLNoTxn("Delete APPSessions Where UID='" & strUID & "'")
            strSessionID = Random(50)
            Dim datTimeoutminute As Date = DateAdd(DateInterval.Minute, lngTimeOutMinute, Now())

            objDB.ExecSQLWithParamNoTxn("INSERT INTO [dbo].[APPSessions]([UID], [SessionID], [TimeOut], [IP])" & _
                    " VALUES(@UID, @SessionID, @TimeOut, @IP)", _
                    objDB.MP("@UID", Data.SqlDbType.VarChar, strUID), _
                    objDB.MP("@SessionID", Data.SqlDbType.VarChar, strSessionID), _
                    objDB.MP("@TimeOut", Data.SqlDbType.DateTime, datTimeoutminute), _
                    objDB.MP("@IP", Data.SqlDbType.VarChar, strIPAddress))
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Public Function SessionRefresh(ByVal strIPAddress As String, _
        ByVal strUID As String, _
        ByVal strSessionID As String, _
        Optional ByVal lngTimeOut As Long = 15, _
        Optional ByRef strNewSessionID As String = "") As Short


        Dim lnResult As Long = 0
        'Dim lngErrNo As Long = 0



        If Val(lngTimeOut) = 0 Then
            lngTimeOut = 15 ' 15 menit
        End If

        If strUID = "" Or Len(Trim(strUID)) <= 0 Then
            lnResult = -10
            GoTo ErrorHandler
        End If

        If strSessionID = "" Or Len(Trim(strSessionID)) <= 0 Then
            lnResult = -20
            GoTo ErrorHandler
        End If



        '--- Cek whether session for UID is valid or not
        lnResult = IsValidSession(Trim(strUID), Trim(strSessionID))

        If lnResult = 0 Then
            'ResponseWrite("Valid<br>")
            'SessionNew(strUID, lngTimeOut, strIPAddress, strNewSessionID)
        Else
            'ResponseWrite("InValid<br>")
        End If
ErrorHandler:
        SessionRefresh = lnResult
    End Function


    Private Function IsValidSession(ByVal strUID As String, _
            ByVal strSessionID As String) As Long

        Dim objDB As New DBX
        Try

            Dim lngRetVal As Long = 0
            Dim strSQL As String = "Select 1 XXX, SessionID, TimeOut FROM APPSessions with(nolock) WHERE UID='" & strUID & "'"
            Dim oSDRSessions As System.Data.SqlClient.SqlDataReader
            oSDRSessions = objDB.CreateSDRFromSQLSelect(strSQL)


            If oSDRSessions.Read() Then
                'ResponseWrite(oSDRSessions("SessionID") & " - " & strSessionID & "<br>")
                If oSDRSessions("SessionID") <> strSessionID Then
                    'Return for SessionID is not valid
                    lngRetVal = -1
                ElseIf oSDRSessions("TimeOut") < Now() Then
                    'Return for session timout
                    lngRetVal = -2
                ElseIf oSDRSessions("SessionID") = strSessionID Then
                    'return for session valid
                    lngRetVal = 0
                End If
            Else
                'return for illegal sessions
                lngRetVal = -3
            End If
            IsValidSession = lngRetVal
            oSDRSessions.Close()
            oSDRSessions = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Function

    Public Function ValidationSessions() As Long
        Dim objDBX As New DBX
        Try
            'Dim objSession As New Sessions
            Dim intTimeOut As Integer = 0
            Dim lngStatus As Long = 0
            Dim strPath As String = ""
            Dim strUID As String = ""
            Dim strSessionID As String = ""
            Dim datAppDate As String = ""
            Dim strIPAddress As String = ""
            Dim strNewSessionID As String = ""
            Dim strSQL As String

            Dim oSDR As Data.SqlClient.SqlDataReader
            strPath = Left(System.Web.HttpContext.Current.Request.ServerVariables("PATH_INFO"), InStr(2, System.Web.HttpContext.Current.Request.ServerVariables("PATH_INFO"), "/") - 1)

            'GET USER TIME OUT (MINUTE)
            strSQL = "SELECT AppValue FROM APPSetting WHERE AppCode='USRTIMEOUT'"
            oSDR = objDBX.CreateSDRFromSQLSelect(strSQL)
            If oSDR.Read() Then
                intTimeOut = CType(oSDR("AppValue").ToString(), Integer)
            Else
                intTimeOut = 15
            End If
            oSDR.Close()
            oSDR = Nothing


            strUID = System.Web.HttpContext.Current.Request.Cookies("UID").Value
            strSessionID = System.Web.HttpContext.Current.Request.Cookies("SessionID").Value

            strIPAddress = System.Web.HttpContext.Current.Request.ServerVariables("REMOTE_ADDR")

            lngStatus = SessionRefresh(strIPAddress, strUID, strSessionID, intTimeOut, strNewSessionID)

            If lngStatus.ToString() = "0" Then
                System.Web.HttpContext.Current.Response.Cookies("SessionID").Path = strPath
                System.Web.HttpContext.Current.Response.Cookies("SessionID").Value = Trim(strNewSessionID)
            Else
                System.Web.HttpContext.Current.Session.Clear()
                System.Web.HttpContext.Current.Session.Abandon()
                System.Web.HttpContext.Current.Response.Redirect(strPath & "/Expired.aspx")
            End If
            ValidationSessions = 0
        Catch ex As Exception
            ValidationSessions = -1
            'lblError.Text = ex.Message
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Function


End Class

Public Module SessionsMod
    Public Function GetUserTheme(ByVal strUID As String) As String
        Dim strTheme As String = "Default"

        If Len(Trim(strUID)) > 0 Then
            Dim objDB As New DBX
            Try

                Dim oSDS As System.Data.SqlClient.SqlDataReader
                oSDS = objDB.CreateSDRFromSQLSelect("Select Theme from APPUser WITH(NOLOCK) Where UID=" & strUID)
                If oSDS.Read Then
                    If Len(Trim(oSDS("Theme").ToString())) > 0 Then
                        strTheme = oSDS("Theme")
                    End If
                End If
                oSDS.Close()
                oSDS = Nothing
            Catch ex As Exception
                Throw
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        End If
        GetUserTheme = strTheme
    End Function




    Public Sub ResponseWrite(ByVal strString As String)
        System.Web.HttpContext.Current.Response.Write(strString)
    End Sub
End Module

