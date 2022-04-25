
Partial Class Account_AccForJFText
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim strLiteral As String = ""
        Dim strUserId As String = Request.Cookies("UID").Value
        Dim lngErrNo As Long = 0
        Dim objDB As New DBX
        Try
            Dim strRequestID As String = Request.QueryString("REQUESTID")
            Dim strJFCode As String, strJFName As String
            Dim intUsedFor As String = Request.QueryString("USEDFOR")
            Dim strJFID As String = "0"
            Dim oSDRText As System.Data.SqlClient.SqlDataReader
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            'Response.Write("<table cellspacing=1 cellpadding=0 id=tbList border=0 width='100%'>")
            strLiteral = strLiteral + "<table cellspacing=1 cellpadding=0 id=tbList border=0 width='100%'>"
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT JFID FROM JFREQUEST WITH(NOLOCK) WHERE REQUESTID=" & strRequestID)
            If oSDR.Read() Then
                strJFID = oSDR("JFID").ToString()
            End If
            oSDR.Close()
            oSDR = Nothing

            oSDR = objDB.CreateSDRFromSQLSelect("SELECT JFID, JFCODE, JFNAME FROM JF WITH(NOLOCK) WHERE JFID=" & strJFID)
            If oSDR.Read() Then
                strJFCode = oSDR("JFCODE")
                strJFName = Replace(oSDR("JFNAME"), " ", "_")
                'Response.Write("<tr><th>")
                strLiteral = strLiteral + "<tr><th class='ShowDetail'>"
                'Response.Write("<B>Join Finance (JF/BANK) : (" & strJFCode & ") " & strJFName & "<br>")
                strLiteral = strLiteral + "<B>Join Finance (JF/BANK) : (" & strJFCode & ") " & strJFName & "<br>"
                'Response.Write("</th></tr>")
                strLiteral = strLiteral + "</th></tr>"
                Dim intFileType As String = "", strTextId As String = "", strFileName As String = ""
                Dim strDay As String = "", strMonth As String = "", strYear As String = "", strDirDate As String = ""
                Dim strToday As Date
                Dim strWhere As String
                Dim strDir As String = "D:\DLEAS\WEBSITE\UPLOAD", strVirDir As String = "../DLEAS/UPLOAD"
                Dim strTextFileName As String = "", strTextFileNameVir As String = "", strTextFileNamePhysic As String = ""
                oSDRText = objDB.CreateSDRFromSQLSelect("SELECT FileType, dbo.f_getAppdate() AppDate, " & _
                    " dbo.f_getAppSetting('UPLOADDIR') UPLOADDIR, " & _
                    " dbo.f_getAppSetting('UPLOADVIR') UPLOADVIR FROM MOSTextSettingJF WITH(NOLOCK)  WHERE JoinFinanceId='" & strJFID & "' and DeleteSts=0 and UsedFor=" & intUsedFor & " ORDER BY SORT")
                If oSDRText.Read() Then
                    strToday = oSDRText("AppDate")
                    intFileType = oSDRText("FileType").ToString()
                    strDay = Right("00" & Day(strToday), 2)
                    strMonth = Right("00" & Month(strToday), 2)
                    strYear = Year(strToday)
                    strDirDate = strYear & strMonth & strDay
                    'physical directory
                    strDir = oSDRText("UPLOADDIR").ToString() & "\" & "JF_" & strJFName & "_" & strDirDate
                    'virtual directory
                    strVirDir = oSDRText("UPLOADVIR").ToString() & "JF_" & strJFName & "_" & strDirDate

                Else
                    'Response.Write("<tr><td>")
                    strLiteral = strLiteral + "<tr><td class='ErrHighLight'>"
                    'Response.Write("Text Setting Must be setup first for this Join finance : (" & strJFCode & ") " & strJFName)
                    strLiteral = strLiteral + "Text Setting Must be setup first for this Join finance : (" & strJFCode & ") " & strJFName
                    'Response.Write("</td></tr>")
                    strLiteral = strLiteral + "</td></tr>"
                End If
                oSDRText.Close()
                oSDRText = Nothing

                ''jika generate text file
                oSDRText = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppdate() AppDate, TextId, FileName, FileDesc, FileType FROM MOSTextSettingJF WITH(NOLOCK) WHERE JoinFinanceId='" & strJFID & "' and DeleteSts=0 and UsedFor=" & intUsedFor & " ORDER BY SORT")
                'If oSDRText("FileType").ToString() <> "2" Then
                Dim oSDRTypeType As System.Data.SqlClient.SqlDataReader

                While oSDRText.Read()
                    'Response.Write("<tr><td class=cellheaderin>")
                    strLiteral = strLiteral + "<tr><td class='HeaderStyle'>"
                    'Response.Write("<B>FILE TO DOWNLOAD : </B>")
                    strLiteral = strLiteral + "<B>FILE TO DOWNLOAD : </B>"
                    'Response.Write("</td></tr>")
                    strLiteral = strLiteral + "</td></tr>"
                    strTextId = oSDRText("TextId")
                    strFileName = oSDRText("FileName")
                    strWhere = ""
                    If intFileType = "1" Then
                        strTextFileName = strFileName & "_" & strDirDate & "_" & strJFName & ".txt"
                    ElseIf CStr(intFileType) = "4" Or CStr(intFileType) = "5" Or CStr(intFileType) = "6" Then
                        strTextFileName = strFileName & ".dbf"
                    End If

                    strTextFileNameVir = strVirDir & "/" & strTextFileName
                    strTextFileNamePhysic = strDir & "\" & strTextFileName
                    'Response.Write("strTextFileNameVir " & strTextFileNameVir & "<br>")
                    'Response.Write("strTextFileNamePhysic " & strTextFileNamePhysic & "<br>")

                    'rstTextSetting = objDBHelper.CreateRSfromView("MOSTextSetting", "TableType", "TextID='" & strTextId & "'")
                    oSDRTypeType = objDB.CreateSDRFromSQLSelect("SELECT TableType FROM MOSTextSetting WITH(NOLOCK) WHERE TEXTID='" & strTextId & "'")
                    If oSDRTypeType.Read() Then
                        If oSDRTypeType("TableType") <> "SP" Then
                            strWhere = "REQUESTID='" & strRequestID & "'"
                        Else
                            'JIKA dari SP, strWhere jadi Parameter
                            strWhere = "'" & strRequestID & "'"
                        End If
                    End If
                    oSDRTypeType.Close()
                    oSDRTypeType = Nothing
                    'Response.Write("strToday " & strToday.ToShortDateString() & "<br>")
                    'Response.Write("strUserId " & strUserId & "<br>")
                    'Response.Write("strDir " & strDir & "<br>")
                    'Response.Write("strTextFileName  " & strTextFileName & "<br>")
                    'Response.Write("strTextId : " & strTextId & "<br>")
                    'Response.Write("strWhere " & strWhere & "<br>")
                    'Response.End()
                    Dim objTextFile As New Repl
                    'CREATE TEXT FILE BY VIEW/SP
                    If CStr(intFileType) = "1" Then

                        objTextFile.CreateTextFile(strToday, strUserId, strDir, _
                          strTextFileName, strTextId, strWhere, "", True)
                        'CREATE DBASE FILE
                    ElseIf CStr(intFileType) = "4" Or CStr(intFileType) = "5" Or CStr(intFileType) = "6" Then
                        'oZip = Server.CreateObject("CGZipLibrary.CGZipFiles")

                        'lngErrNo = objDBase.MOSCreateDBaseFile(rstTextSettingJF("ApplDate"), strUserId, strDir, _
                        '  strTextFileName, strTextId, strWhere, intFileType, "", True, False)
                        'strZipFile = Replace(strTextFileNamePhysic, ".dbf", ".zip")
                        ''Response.Write strZipFile & "<br>"
                        ''Response.Write strTextFileNamePhysic & "<br>"

                        'oZip.ZipFileName = strZipFile
                        'oZip.UpdatingZip = 0 ' ensures a new zip is created
                        'oZip.AddFile(strTextFileNamePhysic)
                        'If oZip.MakeZipFile <> 0 Then
                        '    Response.Write(oZip.GetLastMessage()) ' any errors
                        'End If
                        'strTextFileNameVir = Replace(strTextFileNameVir, ".dbf", ".zip")
                        'oZip = Nothing
                    End If
                    objTextFile = Nothing

                    'Response.Write strTextFileName
                    'Response.Write("<tr><td>")
                    strLiteral = strLiteral + "<tr><td class='RowStyle'>"
                    'Response.Write("<p align='left'><b>" & oSDRText("FileDesc") & ":<br><a href='" & strTextFileNameVir & "'>" & strTextFileNameVir & "</a></b>")
                    strLiteral = strLiteral + "<p align='left'><b>" & oSDRText("FileDesc") & ":<br><a href='" & strTextFileNameVir & "'>" & strTextFileNameVir & "</a></b>"
                    'Response.Write("</td></tr>")
                    strLiteral = strLiteral + "</td></tr>"
                End While
                oSDRText.Close()
                oSDRText = Nothing
                LiteralJF.Text = strLiteral
                'jika generate DBF File FOR UIB ONLY
            Else
                'Response.Redirect("corAccountJoinResellTextFileUIB.asp?BatchId=" & strRequestID & "&UsedFor=" & intUsedFor)
            End If
            'End If
            'Response.Write("</table>")
            strLiteral = strLiteral + "</table>"

            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR GENERATE TEXT FILE : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE..!"
        Finally
            objDB.Close()
            objDB = Nothing

        End Try

    End Sub


End Class
