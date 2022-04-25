Imports System.IO

Partial Class DataUpload_UploadPAY
    Inherits System.Web.UI.Page
    Public strScript As String = ""

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub btnUpload_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpload.Click
        UploadFile(FileBranch, lblMessagePay, "PAYJFUPLOAD", "FILE PAYMENT")

        Dim objDB As New DBX
        Try
            objDB.ExecSQLWithParam("update APPSSSIONS set [TimeOut]=DATEADD(MI, CAST(dbo.f_getAppSetting('USRTIMEOUT') AS INT), GETDATE()) where UID=@USERID",
                         objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value))
        Catch ex As Exception
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Private Sub UploadFile(ByVal oFileUpload As FileUpload, _
            ByVal oLabelMessage As Label, _
            ByVal strTextID As String, _
            ByVal strFileDesc As String)

        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim strDir As String = ""
        Dim strDay, strMonth, strYear, strDirDate As String
        Dim strTableName As String
        Dim dtAppDate As Date
        oLabelMessage.Text = ""
        Try

            oSDR = objDB.CreateSDRFromSQLSelect("Select dbo.f_getAppDate() APPDate, dbo.f_getAppSetting('UPLOADDIR') UPLOADDIR")
            If oSDR.Read Then
                strDir = oSDR("UPLOADDIR")
                dtAppDate = oSDR("APPDATE")
                strDay = Right("00" & Day(oSDR("APPDATE")), 2)
                strMonth = Right("00" & Month(oSDR("APPDATE")), 2)
                strYear = Year(oSDR("APPDATE"))
                strDirDate = strYear & strMonth & strDay
                strDir = strDir & "\UPLOAD" & strDirDate
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            oLabelMessage.Text = "ERROR : " & ex.Message
        Finally
            objDB.Close()
            objDB = Nothing
        End Try



        oLabelMessage.Visible = True
        If Not oFileUpload.PostedFile Is Nothing And oFileUpload.PostedFile.ContentLength > 0 Then
            Dim fn As String = System.IO.Path.GetFileName(oFileUpload.PostedFile.FileName)
            If Not Directory.Exists(strDir) Then
                Directory.CreateDirectory(strDir)
            End If
            Dim SaveLocation As String = strDir & "\" & fn
            Try
                oFileUpload.PostedFile.SaveAs(SaveLocation)

                strTableName = "MOSTempPayUpload_" & Request.Cookies("UID").Value
                Dim objRepl As New Repl
                Try
                    objRepl.ReplicateDataWithTextID(strTextID, SaveLocation, dtAppDate, _
                     Request.Cookies("UID").Value, strTableName)

                Catch ex As Exception
                    Throw
                Finally
                    objRepl = Nothing
                End Try
                oLabelMessage.CssClass = "ShowDetail"
                oLabelMessage.Text = "The file " + oFileUpload.PostedFile.FileName + "  has been uploaded"
            Catch Exc As Exception
                oLabelMessage.CssClass = "ErrHighLight"
                oLabelMessage.Text = "UPLOAD PAYMENT ERROR : " + strFileDesc + ": " & Exc.Message
                strScript = "<script type='text/javascript'>" & Chr(13)
                strScript = strScript & "ShowAlert();" & Chr(13)
                strScript = strScript & "</script>" & Chr(13)
                'Throw
            End Try
        Else
            'Response.Write("Please select a file to upload.")
            oLabelMessage.CssClass = "ErrHighLight"
            oLabelMessage.Text = "Please select a " + strFileDesc + " to upload."
        End If
        btnUpload.Visible = False
        btnBack.Visible = True
    End Sub
End Class
