Imports System.IO

Partial Class Repl_GenerateZipbyAcc
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        SetObjectValidation(txtLocID, True, "required integer", "[0-9]")
        SetObjectValidation(txtAccID, True, "required integer", "[0-9]")

        If Not IsPostBack() Then
            txtAccID.Focus()
            Dim objDB As New DBX
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            Try
                oSDR = objDB.CreateSDRFromSQLSelect("Select dbo.f_getAppSetting('LOCID') LOCID")
                If oSDR.Read Then
                    txtLocID.Text = oSDR("LOCID")
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
        Dim strWhere As String
        Dim strDir As String = "", strVirDir As String = ""
        Dim strTextFileName As String = ""
        Dim strNewFileName As String = ""
        Dim strCurBranch As String = ""
        Dim sFileName As String = ""
        Dim SFileNameZip As String = ""
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


                strWhere = "LOCID=" & txtLocID.Text & " AND ACCID=" & txtAccID.Text
                SFileNameZip = Replace(sFileName, ".txt", "_" & txtLocID.Text & txtAccID.Text & ".txt")
                objTextFile.CreateTextFileMain(ddlFile.SelectedValue, oSDR("APPDATE"), _
                   Request.Cookies("UID").Value, strDir, strWhere)

                'rename text file ditambahin locationid dan accid
                strNewFileName = Replace(strTextFileName, ".txt", "_" & txtLocID.Text & txtAccID.Text & ".txt")
                If File.Exists(Server.MapPath(strNewFileName)) Then
                    File.Delete(Server.MapPath(strNewFileName))
                End If
                File.Move(Server.MapPath(strTextFileName), Server.MapPath(strNewFileName))
                strTextFileName = strNewFileName

            End If
            oSDR.Close()
            oSDR = Nothing
            Repl.ZipFiles(Replace(Server.MapPath(strTextFileName), ".txt", ".zip"), strDir, SFileNameZip)
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


    End Sub
End Class
