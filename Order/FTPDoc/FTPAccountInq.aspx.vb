Imports System.Net
Imports System.IO
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class FTPDoc_FTPAccountInq
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txtLocID.Value = Request.QueryString("LOCID")
            txtAppID.Value = Request.QueryString("APPID")
            GetUploadList()
            If Request.QueryString("Action") = "View" Then
                GvDocExists.Columns(1).Visible = False
            End If
        End If
    End Sub


    Protected Sub GetUploadList()
        Dim sReturnFTP As String = ""
        Dim objFTP As New FTP
        Dim objDB As New DBX
        Dim strDescription As String = ""
        Dim sFTPServer As String = "", sFTPFolder As String = "", sFTPUSerID As String = "", sFTPPassword As String = ""
        'Dim sPathFile As String = ""
        Dim strBranchCode As String = "", strCreateDate As String = ""
        Dim strCreateYear As String = ""

        lblMessage.Text = ""
        Try
            Dim oSDRDOC As System.Data.SqlClient.SqlDataReader

            oSDRDOC = objDB.CreateSDRFromSQLSelect("SELECT TOP 1 ACCOUNT.BRANCHID, CONVERT(VARCHAR(20), ACCOUNT.CREATEDATE,112) CREATEDATE, YEAR(ACCOUNT.CREATEDATE) CREATEYEAR FROM ACCOUNT WITH(NOLOCK) WHERE ACCOUNT.LOCID=" & txtLocID.Value & " AND ACCOUNT.APPID=" & txtAppID.Value)
            If oSDRDOC.Read() Then
                strBranchCode = oSDRDOC("BRANCHID").ToString()
                strCreateDate = oSDRDOC("CREATEDATE")
                strCreateYear = oSDRDOC("CREATEYEAR")
            End If
            oSDRDOC.Close()
            oSDRDOC = Nothing

            oSDRDOC = objDB.CreateSDRFromSQLSelect("SELECT FTPSERVER, FTPFOLDER, FTPUSERID, FTPPASSWORD FROM FTPDOC WITH(NOLOCK) WHERE FTPCODE='DOC'")
            If oSDRDOC.Read() Then
                sFTPServer = oSDRDOC("FTPSERVER").ToString
                sFTPFolder = oSDRDOC("FTPFOLDER").ToString
                sFTPUSerID = oSDRDOC("FTPUSERID").ToString
                sFTPPassword = RC4Engine.rc4(oSDRDOC("FTPPASSWORD").ToString())
            End If
            oSDRDOC.Close()
            oSDRDOC = Nothing
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RETRIEVE DOCUMENT UPLOAD : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            'objDB.Close()
            'objDB = Nothing
        End Try

        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim oSDRParam As System.Data.SqlClient.SqlDataReader

        'sPathFile = "ftp://" & sFTPServer & "/" & sFTPFolder & "/" & txtLocID.Value & "_" & txtAppID.Value
        Try
            Dim serverName As String = sFTPServer
            Dim userName As String = sFTPUSerID
            Dim password As String = sFTPPassword
            Dim FolderName As String = sFTPFolder
            objFTP.ServerName = serverName
            objFTP.UserName = userName
            objFTP.Password = password
            objFTP.CurrentFtpPath = FolderName
            If objFTP.FTPConnected() Then
                Dim strDir As String = "/APP/" & strCreateYear & "/" & strBranchCode & "/" & strCreateDate & "/" & txtLocID.Value & "_" & txtAppID.Value
                'Response.Write(strDir)
                'Response.End()
                If objFTP.FtpDirectoryExists("ftp://" & sFTPServer & "/" & FolderName & strDir, sFTPUSerID, sFTPPassword) Then

                    sReturnFTP = objFTP.FTPGetList(sFTPServer, sFTPFolder, sFTPUSerID, sFTPPassword,
                                              strDir, GvDocExists, True, strDescription)
                    If Len(Trim(lblMessage.Text)) <= 0 Then
                        If sReturnFTP = -1 Then 'Path Address
                            lblMessage.Visible = True
                            lblMessage.Text = lblMessage.Text & "INVALID PATH ADDRESS FTP " & txtLocID.Value & "_" & txtAppID.Value & "<BR>CANNOT GET FILE DOCUMENT FTP SERVER"
                        ElseIf sReturnFTP = -2 Then 'upload file
                            lblMessage.Visible = True
                            lblMessage.Text = lblMessage.Text & "INVALID FTP USER NAME OR PASSWORD<BR>CANNOT GET FILE DOCUMENT FTP SERVER"
                        ElseIf sReturnFTP = -3 Then 'cannot access server
                            lblMessage.Visible = True
                            lblMessage.Text = lblMessage.Text & "CANNOT ACCESS DATA FOLDER TO FTP SERVER<BR>CANNOT GET FILE DOCUMENT FTP SERVER"
                        End If
                    End If
                End If

            Else
                lblMessage.Visible = True
                lblMessage.Text = lblMessage.Text & "CANNOT ACCESS SERVER FTP " & serverName & "<BR>PLEASE CHECK FTP SERVER"
            End If

            'Dim oImage As Image
            Dim oLabel As Label
            Dim strFileName As String
            For Each row As GridViewRow In GvDocExists.Rows
                oLabel = CType(row.FindControl("lblFileUpload"), Label)
                'oImage = CType(row.FindControl("imgBtnDelete"), Image)
                If oLabel IsNot Nothing Then
                    strFileName = oLabel.Text
                    If Len(Trim(strFileName)) > 0 Then
                        oSDR = objDB.CreateSDRFromSQLSelect("SELECT UPLOADFILETYPE, dbo.f_getParamGlobalName('UPLOADFILETYPE', UPLOADFILETYPE) UPLOADFILETYPENAME, REMARK" & _
                        " FROM APPFILEUPLOAD WITH(NOLOCK) WHERE LOCID=" & txtLocID.Value & " AND APPID=" & txtAppID.Value & " AND FILENAME='" & strFileName & "'")
                        If oSDR.HasRows() Then
                            If oSDR.Read() Then
                                oLabel = CType(row.FindControl("lblFileType"), Label)
                                oLabel.Text = oSDR("UPLOADFILETYPENAME")
                                oLabel = CType(row.FindControl("lblRemark"), Label)
                                oLabel.Text = oSDR("REMARK").ToString()
                                If oSDR("UPLOADFILETYPE").ToString() = "0" Then
                                    row.CssClass = "SelectedRowStyle"
                                    'If oImage IsNot Nothing Then
                                    '    oImage.Visible = False
                                    'Else
                                    '    oImage.Visible = True
                                    'End If

                                End If
                            End If
                        Else
                            oSDRParam = objDB.CreateSDRFromSQLSelect("SELECT NAME FROM PARAMGLOBAL WITH(NOLOCK) WHERE TYPE='UPLOADFILETYPE' AND CODE='999'")
                            If oSDRParam.Read() Then
                                oLabel = CType(row.FindControl("lblFileType"), Label)
                                oLabel.Text = oSDRParam("NAME")
                            End If
                            oSDRParam.Close()
                            oSDRParam = Nothing
                        End If
                        oSDR.Close()
                        oSDR = Nothing
                    End If
                End If
            Next
            'Catch ex As Exception
            '    lblMessage.Visible = True
            '    lblMessage.Text = "<span class='ErrHighLight'>ERROR FTP GET FILE FOR VIEW : " & ex.Message & "</span>"
        Finally
            objFTP = Nothing
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
End Class
