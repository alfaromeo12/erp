Imports System.IO

Partial Class AppSetting_DBBackup
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppSetting('BACKUPFILE') BACKUPFILE, dbo.f_getAppSetting('BACKUPDIR') BACKUPDIR")
            If oSDR.Read Then
                lblFile.Text = oSDR("BACKUPFILE").ToString()
                lblDir.Text = oSDR("BACKUPDIR").ToString()
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            lblComplete.Visible = True
            lblComplete.Text = "ERROR LOADING DB BACKUP: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnBackup_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBackup.Click
        Dim strDir As String = ""
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim strDirChild() As String
        Dim strFiles() As String
        Dim objDB As New DBX
        Dim i As Integer = 0, j As Integer = 0
        'Try
        On Error Resume Next
        If Request.QueryString("SPV") = "1" Then
            objDB.ExecSQLNoTxn("exec DBBackupSPV")
            If err.number <> 0 Then
                lblDirDelete.Text = lblDirDelete.Text & "WARNING : BACKUP FAILED, ERROR MESSAGE : " & err.Description & "<br>" & "PLEASE CONTRACT YOUR ADMINISTRTOR<br>"
            Else
                lblDirDelete.Text = lblDirDelete.Text & "BACKUP COMPLETED SUCCESSFULLY...!<BR>"
            End If

        Else
            objDB.ExecSQLNoTxn("exec DBBackup")
            If Err.Number <> 0 Then
                lblDirDelete.Text = lblDirDelete.Text & "WARNING : BACKUP FAILED, ERROR MESSAGE : " & Err.Description & "<br>" & "PLEASE CONTRACT YOUR ADMINISTRTOR<br>"
            Else
                lblDirDelete.Text = lblDirDelete.Text & "BACKUP COMPLETED SUCCESSFULLY...!<BR>"
            End If
        End If
        oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getAppSetting('BACKUPFILE') BACKUPFILE, dbo.f_getAppSetting('UPLOADDIR') UPLOADDIR")
        If oSDR.Read Then
            strDir = oSDR("UPLOADDIR").ToString()
            lblFile.Text = oSDR("BACKUPFILE").ToString()
        End If
        If Directory.Exists(strDir) Then
            lblDirDelete.Text = "<u>Deleting Temporary Files Uploaded in Server, direktory : " & strDir & " ...!</u><br>"
            strDirChild = Directory.GetDirectories(strDir)
            For i = 0 To UBound(strDirChild)
                strFiles = Directory.GetFiles(strDirChild(i))
                For j = 0 To UBound(strFiles)
                    lblDirDelete.Text = lblDirDelete.Text & "Deleting File : " & strFiles(j) & "<br>"

                    File.SetAttributes(strFiles(j), FileAttributes.Normal)
                    File.Delete(strFiles(j))
                    If Err.Number <> 0 Then
                        lblDirDelete.Text = lblDirDelete.Text & "Error Delete File : " & strFiles(j) & ", Error Message : " & Err.Description & "<br>"
                    End If
                Next
                lblDirDelete.Text = lblDirDelete.Text & "Deleting Direktory : " & strDirChild(i) & "<br>"
                Directory.Delete(strDirChild(i))
                If err.number <> 0 Then
                    lblDirDelete.Text = lblDirDelete.Text & "Error Delete Direktory : " & strDirChild(i) & ", Error Message : " & err.Description & "<br>"
                End If
            Next

            strFiles = Directory.GetFiles(strDir)
            For j = 0 To UBound(strFiles)
                lblDirDelete.Text = lblDirDelete.Text & "Deleting File : " & strFiles(j) & "<br>"
                'lblDirDelete.Text = lblDirDelete.Text & "strDirChild(i): " & strDir & "<br>"
                'File.SetAttributes(strDir, FileAttributes.Normal)
                'If File.GetAttributes(strDir) <> FileAttributes.ReadOnly Then

                'End If
                File.SetAttributes(strFiles(j), FileAttributes.Normal)
                File.Delete(strFiles(j))
                If Err.Number <> 0 Then
                    lblDirDelete.Text = lblDirDelete.Text & "Error Delete File : " & strFiles(j) & ", Error Message : " & Err.Description & "<br>"
                End If
            Next
        End If

        oSDR.Close()
        oSDR = Nothing

        'Catch ex As Exception
        'Throw
        'Finally
        objDB.Close()
        objDB = Nothing
        'End Try
        btnBackup.Visible = False
        lblComplete.Visible = True
        btnBack.Visible = True

    End Sub

    Protected Sub btnBack_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBack.Click
        btnBack.Visible = False
        btnBackup.Visible = True
        lblComplete.Visible = False
    End Sub
End Class
