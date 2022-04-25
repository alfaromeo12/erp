

Partial Class Repl_GenerateZip

    Inherits System.Web.UI.Page
  
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            Dim objDB As New DBX
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            Try
                oSDR = objDB.CreateSDRFromSQLSelect("Select dbo.f_getAppDate() AppDate")
                If oSDR.Read Then
                    txtFrom.Text = String.Format("{0:dd/MM/yyyy}", oSDR("AppDate"))
                    txtTo.Text = String.Format("{0:dd/MM/yyyy}", oSDR("AppDate"))
                End If
                oSDR.Close()
                oSDR = Nothing
            Catch ex As Exception
                Throw
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
        End If
    End Sub
  
    Protected Sub btnProcess_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcess.Click
        Dim objDB As New DBX
        Dim objTextFile As New Repl
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim strDay, strMonth, strYear As String
        Dim strFileName As String = ""
        Dim strDirDate As String = ""
        Dim strWhere As String = ""
        Dim strDir As String = "", strVirDir As String = ""
        Dim strTextFileName As String = ""
        Dim strCurBranch As String = ""
        Dim sFileName As String = ""
        'Dim lngErrNo As Long
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppDate() APPDATE, " & _
                " dbo.f_getAppSetting('LOCID') CURBRANCH, " & _
                " dbo.f_getAppSetting('UPLOADVIR') UPLOADVIR, " & _
                " dbo.f_getAppSetting('UPLOADDIR') UPLOADDIR, FileName " & _
                " FROM MOSTEXTFILE WHERE FileId='" & ddlFile.SelectedValue & "'")
            If oSDR.Read Then
                strCurBranch = oSDR("CURBRANCH")
                strFileName = oSDR("Filename")

                strDay = Right("00" & Day(oSDR("APPDATE")), 2)
                strMonth = Right("00" & Month(oSDR("APPDATE")), 2)
                strYear = Year(oSDR("APPDATE"))
                strDirDate = strYear & strMonth & strDay
                strWhere = ""
                strDir = oSDR("UPLOADDIR") & "\REPL" & strDirDate
                'virtual directory
                strVirDir = oSDR("UPLOADVIR") & "REPL" & strDirDate
                strTextFileName = strVirDir & "/" & strFileName & strCurBranch & "_" & strDirDate & ".txt"
                sFileName = strFileName & strCurBranch & "_" & strDirDate & ".txt"
                If CStr(ddlType.SelectedValue) = "1" Then
                    strWhere = "LastUpdate between '" & ConvertDateToYMD(txtFrom.Text) & " 00:00' and '" & ConvertDateToYMD(txtTo.Text) & " 23:59'"
                Else
                    strWhere = ""
                End If
                objTextFile.CreateTextFileMain(ddlFile.SelectedValue, oSDR("APPDATE"), _
                   Request.Cookies("UID").Value, strDir, strWhere)
            End If
            oSDR.Close()
            oSDR = Nothing
            Repl.ZipFiles(strDir + "\" + sFileName.Replace(".txt", ".zip"), strDir, strFileName & strCurBranch & "_" & strDirDate & ".txt")
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
            objTextFile = Nothing
        End Try


        'Response.Write(strDir & "<br>")
        'Response.Write(strVirDir)
        'Response.End()

        'Remark by Sendy 9 April 2012
        'Dim oZip As Object
        'Dim strZipFile As String
        'oZip = Server.CreateObject("CGZipLibrary.CGZipFiles")
        'strZipFile = Replace(Server.MapPath(strTextFileName), ".txt", ".zip")
        'oZip.ZipFileName = strZipFile
        'oZip.UpdatingZip = 0 ' ensures a new zip is created
        'oZip.AddFile(Server.MapPath(strTextFileName))
        'If oZip.MakeZipFile <> 0 Then
        '    Response.Write(oZip.GetLastMessage()) ' any errors
        'End If
        'oZip = Nothing
        strTextFileName = Replace(strTextFileName, ".txt", ".zip")
        HyperLinkFile.Visible = True
        HyperLinkFile.Text = "Right click here to download file : " & strTextFileName
        HyperLinkFile.NavigateUrl = strTextFileName
        '>Remark by Sendy 9 April 2012

        'If Len(Trim(intReplType)) <= 0 Then intReplType = "1"
        'rstTextFileName = objTextSetting.MOSTextFileList("dbo.f_getParameter('CURBRANCH', '000') CURBRANCH, FileName", "FileId='" & intFileID & "'")
        'strCurBranch = rstTextFileName("CURBRANCH")
        'strFileName = rstTextFileName("Filename")
        'strToday = Convertdate(datApplDate)
        'strDay = Right("00" & Day(strToday), 2)
        'strMonth = Right("00" & Month(strToday), 2)
        'strYear = Year(strToday)
        'strDirDate = strYear & strMonth & strDay
        'strWhere = ""
        ''physical directory
        'strDir = objGenList.genParameterValueList("GENPHSDWNL") & "REPL" & strDirDate
        ''virtual directory
        'strVirDir = objGenList.genParameterValueList("GENVIRDWNL") & "REPL" & strDirDate
        'strTextFileName = strVirDir & "/" & strFileName & strCurBranch & "_" & strDirDate & ".txt"

        'If CStr(intReplType) = "1" Then
        '    'jika bukan tipe replikasi : sending OS to head ofice, boleh ada where tanggal
        '    If CStr(intFileID) <> "31" Then
        '        strWhere = "LastUpdate between '" & ConvertDate(dtFrom) & " 00:00' and '" & ConvertDate(dtTo) & " 23:59'"
        '    End If
        'Else
        '    strWhere = ""
        'End If
        ''Response.Write strWhere
        ''Response.End
        'lngErrNo = objTextFile.MOSCreateTextFileMain(intFileID, convertDate(datApplDate), _
        ' strUserId, strDir, strWhere, False)

        'Dim oZip
        'oZip = Server.CreateObject("CGZipLibrary.CGZipFiles")
        ''oZip.ZipFileName = "D:\MOSAPL\Web\core\DownLoad\ZIPTEST.ZIP"
        ''oZip.ZipFileName = "\ZIPTEST.ZIP"
        'strZipFile = Replace(Server.MapPath(strTextFileName), ".txt", ".zip")
        'oZip.ZipFileName = strZipFile

        ''Response.Write Server.MapPath(strTextFileName) 

        ''oZip.UpdatingZip = False ' ensures a new zip is created
        'oZip.UpdatingZip = 0 ' ensures a new zip is created
        'oZip.AddFile(Server.MapPath(strTextFileName))
        ''oZip.MakeZipFile()
        'If oZip.MakeZipFile <> 0 Then
        '    Response.Write(oZip.GetLastMessage()) ' any errors
        'End If
        'oZip = Nothing

    End Sub
End Class
