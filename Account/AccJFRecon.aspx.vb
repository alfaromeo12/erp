
Partial Class Acc_Recon
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            Dim objDB As New DBX
            Try
                Dim oSDR As System.Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE  FROM APPSETTING WITH(NOLOCK) WHERE APPCODE='APPDATE'")
                If oSDR.Read() Then
                    txtDate.Text = oSDR("APPVALUE").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing
            Catch ex As Exception
            Finally
                objDB.Close()
                objDB = Nothing

            End Try
        End If
    
    End Sub
  

    Protected Sub gvData_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        If e.CommandName = "Select" Then
            pnlDownload.Visible = False
            Dim objDB As New DBX
            Try

                gvData.SelectedIndex = e.CommandArgument

                Dim intUsedFor As String = Request.QueryString("USEDFOR")

                Dim strTextID As String = "", strFileName As String = "", strJFName As String = ""
                Dim strJFID As String = ""
                Dim dtToday As Date
                Dim strDay As String = "", strMonth As String = "", strYear As String = ""
                Dim strDirDate As String = "", strFileX As String = ""
                Dim strWhere As String = ""
                Dim strDir As String = "", strVirDir As String = ""
                Dim strFileNameOnly As String = "", strTextFileName As String = ""
                Dim oSDR As System.Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT TextId, FileName, JFID, JFNAME,  " & _
                    " dbo.f_getAppDate() TODAY, " & _
                    " dbo.f_getAppSetting('UPLOADVIR') UPLOADVIR, " & _
                    " dbo.f_getAppSetting('UPLOADDIR') UPLOADDIR FROM v_JFTextSetting WHERE JFID='" & gvData.SelectedDataKey("JFID") & "' and DeleteSts=0 and UsedFor=" & intUsedFor)
                If oSDR.Read() Then
                    strTextID = oSDR("TextId")
                    strFileName = oSDR("FileName")
                    strJFID = oSDR("JFID")
                    strJFName = oSDR("JFNAME")
                    strJFName = Replace(Replace(strJFName, " ", "_"), ".", "")
                    dtToday = oSDR("TODAY")
                    strDay = Right("00" & Day(dtToday), 2)
                    strMonth = Right("00" & Month(dtToday), 2)
                    strYear = Year(dtToday)
                    strDirDate = strYear & strMonth & strDay
                    strWhere = ""

                    If intUsedFor = "60" Then ''
                        strFileX = "RECONJF_"
                    End If
                    'physical directory
                    strDir = oSDR("UPLOADDIR") & "\" & strFileX & strDirDate
                    'virtual directory
                    strVirDir = oSDR("UPLOADVIR") & strFileX & strDirDate
                    strFileNameOnly = strFileName & strJFName & "_" & strDirDate & ".txt"
                    strTextFileName = strVirDir & "/" & strFileName & strJFName & "_" & strDirDate & ".txt"
                    Dim oSDRTextSetting As System.Data.SqlClient.SqlDataReader

                    oSDRTextSetting = objDB.CreateSDRFromSQLSelect("SELECT TableType FROM MOSTextSetting WHERE TextID='" & strTextID & "'")
                    If oSDRTextSetting.Read() Then
                        Dim strDate As String
                        strDate = ConvertDate(txtDate.Text)
                        If oSDRTextSetting("TableType") <> "SP" Then
                            If intUsedFor = "60" Then 'RECON
                                strWhere = "JFID='" & strJFID & "'"
                            End If
                        Else
                            strWhere = "'" & strDate & " 23:59','" & strJFID & "'"
                        End If

                        Dim objTextFile As New Repl
                        objTextFile.CreateTextFile(dtToday, _
                            Request.Cookies("UID").Value, strDir, strFileNameOnly, strTextID, strWhere, , True)
                        objTextFile = Nothing
                    End If
                    oSDRTextSetting.Close()
                    oSDRTextSetting = Nothing

                End If


                oSDR.Close()
                oSDR = Nothing

                pnlDownload.Visible = True
                lnkDownload.NavigateUrl = strTextFileName
                lnkDownload.Text = strTextFileName

            Finally
                objDB.Close()
                objDB = Nothing
                'Catch ex As Exception
            End Try
        End If
    End Sub
End Class
