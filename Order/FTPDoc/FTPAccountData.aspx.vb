Imports System.Net
Imports System.IO
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class FTPDoc_FTPAccountData
    Inherits System.Web.UI.Page
    Public strScript As String = ""
    Private sFTPServer As String = "", sFTPFolder As String = "", sFTPUSerID As String = "", sFTPPassword As String
    Private strFileName As String = ""
    'Public Shared sPathFile As String = ""
    'Private objDB As New DBX
    'Private oSDRDOC As System.Data.SqlClient.SqlDataReader

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            txtNoCopy.Text = "1"
            txtLocID.Value = Request.QueryString("LOCID")
            txtAppID.Value = Request.QueryString("APPID")

            Dim oSDRDOC As System.Data.SqlClient.SqlDataReader
            Dim objDB As New DBX
            Try
                oSDRDOC = objDB.CreateSDRFromSQLSelect("SELECT TOP 1 ACCOUNT.BRANCHID, CONVERT(VARCHAR(20), ACCOUNT.CREATEDATE,112) CREATEDATE, YEAR(ACCOUNT.CREATEDATE) CREATEYEAR FROM ACCOUNT WITH(NOLOCK) WHERE ACCOUNT.LOCID=" & txtLocID.Value & " AND ACCOUNT.APPID=" & txtAppID.Value)
                If oSDRDOC.Read() Then
                    hidBRANCHCODE.Value = oSDRDOC("BRANCHID").ToString()
                    hidCREATEDATE.Value = oSDRDOC("CREATEDATE")
                    hidCREATEYEAR.Value = oSDRDOC("CREATEYEAR")
                End If
                oSDRDOC.Close()
                oSDRDOC = Nothing

            Catch ex As Exception
                lblMessage.Visible = True
                lblMessage.Text = "ERROR LOADING FTP APPLICATION DOCUMENT..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE: " & ex.Message
            Finally
                objDB.Close()
                objDB = Nothing
            End Try

            GetUploadList()
            AddRowEmptyAccount()
            SetObjectValidation(txtNoCopy, False, "integer", "[0-9]")
        End If
    End Sub


    Protected Sub GetUploadList()
        Dim sReturnFTP As String = ""
        Dim objFTP As New FTP
        Dim objDB As New DBX
        Dim strDescription As String = ""
        Dim oSDRDOC As System.Data.SqlClient.SqlDataReader
        lblMessage.Text = ""
        Try
            oSDRDOC = objDB.CreateSDRFromSQLSelect("SELECT FTPSERVER, FTPFOLDER, FTPUSERID, FTPPASSWORD FROM FTPDOC WITH(NOLOCK) WHERE FTPCODE='DOC'")
            If oSDRDOC.Read() Then
                sFTPServer = oSDRDOC("FTPSERVER")
                sFTPFolder = oSDRDOC("FTPFOLDER")
                sFTPUSerID = oSDRDOC("FTPUSERID")
                sFTPPassword = RC4Engine.rc4(oSDRDOC("FTPPASSWORD").ToString())
            End If
            oSDRDOC.Close()
            oSDRDOC = Nothing
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RETRIEVE DOCUMENT UPLOAD : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

        'sPathFile = "ftp://" & sFTPServer & "/" & sFTPFolder & "/" & txtLocID.Value & "_" & txtAppID.Value
        'sPathFile = "ftp://" & sFTPServer & "/" & sFTPFolder & "/APP/" & hidBRANCHCODE.Value & "/" & hidCREATEDATE.Value & "/" & txtLocID.Value & "_" & txtAppID.Value
        Dim objDBX As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim oSDRParam As System.Data.SqlClient.SqlDataReader
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
                Dim strDir As String = "/APP/" & hidCREATEYEAR.Value & "/" & hidBRANCHCODE.Value & "/" & hidCREATEDATE.Value & "/" & txtLocID.Value & "_" & txtAppID.Value

                'Response.Write("<br>")
                'Response.Write("<br>")
                'Response.Write("ftp://" & sFTPServer & "/" & FolderName & strDir)
                'Response.End()
                If objFTP.FtpDirectoryExists("ftp://" & sFTPServer & "/" & FolderName & strDir, sFTPUSerID, sFTPPassword) Then

                    sReturnFTP = objFTP.FTPGetList(sFTPServer, sFTPFolder, sFTPUSerID, sFTPPassword,
                                            strDir, GvDocExists, True, strDescription)
                    If Len(Trim(lblMessage.Text)) <= 0 Then
                        If sReturnFTP = -1 Then 'Path Address
                            lblMessage.Visible = True
                            lblMessage.Text = lblMessage.Text & "INVALID PATH ADDRESS FTP " & strDir & "<BR>CANNOT GET FILE DOCUMENT FTP SERVER"
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

            Dim oImage As Image
            Dim oLabel As Label
            Dim strFileName As String
            For Each row As GridViewRow In GvDocExists.Rows
                oLabel = CType(row.FindControl("lblFileUpload"), Label)
                oImage = CType(row.FindControl("imgBtnDelete"), Image)
                If oLabel IsNot Nothing Then
                    strFileName = oLabel.Text
                    If Len(Trim(strFileName)) > 0 Then
                        oSDR = objDBX.CreateSDRFromSQLSelect("SELECT UPLOADFILETYPE, " & _
                        " /*dbo.f_getParamGlobalName('UPLOADFILETYPE', UPLOADFILETYPE)*/ " & _
                        " (SELECT DOCNAME FROM DOCUPLOADTYPE WITH(NOLOCK) WHERE APPFILEUPLOAD.UPLOADFILETYPE=DOCUPLOADTYPE.DOCID) UPLOADFILETYPENAME, REMARK" & _
                        " FROM APPFILEUPLOAD WITH(NOLOCK) WHERE LOCID=" & txtLocID.Value & " AND APPID=" & txtAppID.Value & " AND FILENAME='" & strFileName & "'")
                        If oSDR.HasRows() Then
                            If oSDR.Read() Then
                                oLabel = CType(row.FindControl("lblRemark"), Label)
                                oLabel.Text = oSDR("REMARK").ToString()
                                oLabel = CType(row.FindControl("lblFileType"), Label)
                                oLabel.Text = oSDR("UPLOADFILETYPENAME")
                                If oSDR("UPLOADFILETYPE").ToString() = "0" Then
                                    row.CssClass = "SelectedRowStyle"
                                    If oImage IsNot Nothing Then
                                        oImage.Visible = False
                                    Else
                                        oImage.Visible = True
                                    End If

                                End If
                            End If
                        Else
                            'oSDRParam = objDBX.CreateSDRFromSQLSelect("SELECT NAME FROM PARAMGLOBAL WITH(NOLOCK) WHERE TYPE='UPLOADFILETYPE' AND CODE='999'")
                            oSDRParam = objDBX.CreateSDRFromSQLSelect("SELECT DOCNAME AS NAME FROM DOCUPLOADTYPE WITH(NOLOCK) WHERE DOCID=999")
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
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "<span class='ErrHighLight'>ERROR FTP GET LIST DOCUMENT : " & ex.Message & "</span>"
        Finally
            objFTP = Nothing
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Sub
  
   
    Protected Sub GvDocExists_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GvDocExists.RowDeleting
        Dim strDescription As String = ""
        Dim sReturnFTP As String = ""
        Dim objFTP As New FTP
        Dim objDB As New DBX
        Dim oSDRDOC As System.Data.SqlClient.SqlDataReader
        e.Cancel = True
        Try
            oSDRDOC = objDB.CreateSDRFromSQLSelect("SELECT FTPSERVER, FTPFOLDER, FTPUSERID, FTPPASSWORD FROM FTPDOC WHERE FTPCODE='DOC'")
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
            lblMessage.Text = "ERROR DELETE APPLICATION DOCUMENT UPLOAD : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            'objDB.Close()
            'objDB = Nothing
        End Try
        Dim fileName As String = (CType(GvDocExists.Rows(e.RowIndex).FindControl("lblFileUpload"), Label)).Text
        'Response.Write(fileName)
        'Response.End()
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
                'sReturnFTP = objFTP.FTPDelete(sFTPServer & "/" & sFTPFolder & "/" & txtLocID.Value & "_" & txtAppID.Value, fileName,
                '                      sFTPUSerID, sFTPPassword, strDescription)
                Dim strDir As String = sFTPServer & "/" & sFTPFolder & "/APP/" & hidCREATEYEAR.Value & "/" & hidBRANCHCODE.Value & "/" & hidCREATEDATE.Value & "/" & txtLocID.Value & "_" & txtAppID.Value
                sReturnFTP = objFTP.FTPDelete(strDir, fileName,
                                      sFTPUSerID, sFTPPassword, strDescription)

                If Len(Trim(lblMessage.Text)) <= 0 Then
                    If sReturnFTP = -1 Then 'Path Address
                        lblMessage.Visible = True
                        lblMessage.Text = lblMessage.Text & "INVALID PATH ADDRESS FTP " & strDir & "<BR>CANNOT GET FILE DOCUMENT FTP SERVER"
                    ElseIf sReturnFTP = -2 Then 'upload file
                        lblMessage.Visible = True
                        lblMessage.Text = lblMessage.Text & "INVALID FTP USER NAME OR PASSWORD<BR>CANNOT GET FILE DOCUMENT FTP SERVER"
                    ElseIf sReturnFTP = -3 Then 'cannot access server
                        lblMessage.Visible = True
                        lblMessage.Text = lblMessage.Text & "CANNOT ACCESS DATA FOLDER TO FTP SERVER<BR>CANNOT GET FILE DOCUMENT FTP SERVER"
                    Else
                        lblMessage.Text = ""
                        lblMessage.Visible = False
                        objDB.ExecSQLWithParam("DELETE APPFILEUPLOAD WHERE LOCID=@LOCID AND APPID=@APPID AND FILENAME=@FILENAME",
                            objDB.MP("@LOCID", SqlDbType.Int, txtLocID.Value),
                            objDB.MP("@APPID", SqlDbType.BigInt, txtAppID.Value),
                            objDB.MP("@FILENAME", SqlDbType.VarChar, fileName)
                            )
                        GetUploadList()
                    End If
                End If
            Else
                lblMessage.Visible = True
                lblMessage.Text = lblMessage.Text & "CANNOT ACCESS SERVER FTP " & serverName & "<BR>PLEASE CHECK FTP SERVER"
            End If
          
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR FTP DELETE REPOSES DOCUMENT : " & ex.Message & "</span>"
        Finally
            objFTP = Nothing
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub

    Protected Sub btnBack_Click(sender As Object, e As System.EventArgs) Handles btnBack.Click
        lblMessage.Visible = False
        lblMessage.Text = ""
        Response.Redirect("../FTPDoc/FTPAccountList.aspx")
    End Sub

    Private Sub AddRowEmptyAccount()
        Dim dt As New DataTable()
        Dim dr As DataRow = Nothing
        Try
            dt.Columns.Add(New DataColumn("NOROW", GetType(String)))
            dr = dt.NewRow()
            dr("NOROW") = 1
            dt.Rows.Add(dr)

            ViewState("VW_ACCOUNT") = dt

            gvUploadDoc.DataSource = dt
            gvUploadDoc.DataBind()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = lblMessage.Text & "ADD ROW DOCUMENT UPLOAD ERROR " & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            dt.Clear()
            dt = Nothing
            dr = Nothing
        End Try
        
    End Sub

    Private Sub GetDataNo(ByRef dtNo As System.Data.DataTable)
        dtNo.Clear()
        Dim sNO As String
        Dim drNo As System.Data.DataRow
        Dim oTextBox As TextBox
        For Each gvRow As GridViewRow In gvUploadDoc.Rows
            sNO = 0

            oTextBox = CType(gvRow.FindControl("lblNo"), TextBox)
            If oTextBox IsNot Nothing Then
                sNO = Replace(oTextBox.Text, ",", "")
            End If
            drNo = dtNo.NewRow()

            drNo("NOROW") = sNO
            dtNo.Rows.Add(drNo)
        Next
    End Sub

    Private Sub GetDataCopy()
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim dtNo As New System.Data.DataTable
        Dim objDB As New DBX
        Try
            oSDR = objDB.CreateSDRFromSP("FTPDOCNo", _
                objDB.MP("@pCOPYNO", Data.SqlDbType.Int, txtNoCopy.Text)
            )
            dtNo.Load(oSDR)
            oSDR.Close()
            oSDR = Nothing

            If ViewState("vw_Upload") IsNot Nothing Then
                ViewState("vw_Upload") = Nothing
            End If
            ViewState("vw_Upload") = dtNo
            gvUploadDoc.DataSource = dtNo
            gvUploadDoc.DataBind()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RETRIEVE NUMBER DOCUMENT UPLOAD : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
            dtNo = Nothing
        End Try
    End Sub

    Protected Sub imgBtnCopy_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imgBtnCopy.Click
        'Dim Upload As FileUpload = CType(gvUploadDoc.FindControl("fuDocUpload"), FileUpload)
        
        GetDataCopy()
        lblMessage.Visible = False
        lblMessage.Text = ""
    End Sub

    Protected Sub btnProcess_Click(sender As Object, e As System.EventArgs) Handles btnProcess.Click
        Dim sReturnFTP As Integer
        Dim objFTP As New FTP
        Dim strDescription As String = ""
        Dim sFolderName As String = ""
        Dim strFileNamePhysic As String = ""
        Dim iRow As Integer
        Dim iRows As Integer
        Dim objDB As New DBX
        Dim oSDRDOC As System.Data.SqlClient.SqlDataReader

        Try
            lblMessage.Text = ""
            oSDRDOC = objDB.CreateSDRFromSQLSelect("SELECT TOP 1 dbo.f_getAppSetting('UPLOADDIR') UPLOADDIR,  dbo.f_getAppSetting('UPLOADVIR') UPLOADVIR, " & _
                            "FTPSERVER, FTPFOLDER, FTPUSERID, FTPPASSWORD FROM FTPDOC WITH(NOLOCK) WHERE FTPCODE='DOC'")
            If oSDRDOC.Read() Then
                sFTPServer = oSDRDOC("FTPSERVER").ToString()
                sFTPFolder = oSDRDOC("FTPFOLDER").ToString()
                sFTPUSerID = oSDRDOC("FTPUSERID").ToString()
                sFTPPassword = RC4Engine.rc4(oSDRDOC("FTPPASSWORD").ToString())
            End If
            oSDRDOC.Close()
            oSDRDOC = Nothing

            'sFolderName = strBranchCode & "/" & strCreateDate & "/" & txtLocID.Value & "_" & txtAppID.Value
            'sFolderName = txtLocID.Value & "_" & txtAppID.Value
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
                    'buat folder APP
                    sFolderName = "APP"
                    sReturnFTP = objFTP.FTPMakeDirectoryUpload(sFTPServer, sFTPFolder, "", sFTPUSerID, sFTPPassword,
                                        sFolderName, False, strDescription)

                    'buat folder createyear
                    objFTP.CurrentFtpPath = FolderName & "/APP/"
                    If objFTP.FTPConnected() Then
                        sFolderName = "/APP/" & hidCREATEYEAR.Value
                        sReturnFTP = objFTP.FTPMakeDirectoryUpload(sFTPServer, sFTPFolder, "", sFTPUSerID, sFTPPassword,
                                            sFolderName, False, strDescription)
                        'buat folder cabang
                        objFTP.CurrentFtpPath = FolderName & "/APP/" & hidCREATEYEAR.Value
                        If objFTP.FTPConnected() Then
                            sFolderName = "/APP/" & hidCREATEYEAR.Value & "/" & hidBRANCHCODE.Value
                            sReturnFTP = objFTP.FTPMakeDirectoryUpload(sFTPServer, sFTPFolder, "", sFTPUSerID, sFTPPassword,
                                                sFolderName, False, strDescription)
                            'buat folder createdate
                            objFTP.CurrentFtpPath = FolderName & "/APP/" & hidCREATEYEAR.Value & "/" & hidBRANCHCODE.Value
                            If objFTP.FTPConnected() Then
                                sFolderName = "/APP/" & hidCREATEYEAR.Value & "/" & hidBRANCHCODE.Value & "/" & hidCREATEDATE.Value
                                sReturnFTP = objFTP.FTPMakeDirectoryUpload(sFTPServer, sFTPFolder, "", sFTPUSerID, sFTPPassword,
                                                    sFolderName, False, strDescription)
                                'buat folder APPID
                                objFTP.CurrentFtpPath = FolderName & "/APP/" & hidCREATEYEAR.Value & "/" & hidBRANCHCODE.Value & "/" & hidCREATEDATE.Value
                                If objFTP.FTPConnected() Then
                                    sFolderName = "/APP/" & hidCREATEYEAR.Value & "/" & hidBRANCHCODE.Value & "/" & hidCREATEDATE.Value & "/" & txtLocID.Value & "_" & txtAppID.Value
                                    sReturnFTP = objFTP.FTPMakeDirectoryUpload(sFTPServer, sFTPFolder, "", sFTPUSerID, sFTPPassword,
                                                        sFolderName, False, strDescription)
                                End If
                            End If
                        End If
                    End If

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
                        Else
                            iRows = gvUploadDoc.Rows.Count
                            Dim oFileUpload As FileUpload
                            Dim oLabelMessage As Label
                            Dim oFileType As DropDownList



                            For iRow = 0 To iRows - 1
                                strFileNamePhysic = ""
                                strFileNamePhysic = CType(gvUploadDoc.Rows(iRow).FindControl("fuDocUpload"), FileUpload).PostedFile.FileName
                                If Len(Trim(strFileNamePhysic)) > 0 Then
                                    oFileUpload = CType(gvUploadDoc.Rows(iRow).FindControl("fuDocUpload"), FileUpload)
                                    oLabelMessage = CType(gvUploadDoc.Rows(iRow).FindControl("lblMessageUpload"), Label)
                                    oFileType = CType(gvUploadDoc.Rows(iRow).FindControl("ddlFileType"), DropDownList)
                                    If oFileType.SelectedValue = "0" And (Not oFileUpload.PostedFile.ContentType.ToLower = "application/pdf") Then
                                        oLabelMessage.Visible = True
                                        oLabelMessage.Text = "Application document must be upload PDF file only..!<br>Upload for Application document failed..!"
                                        oLabelMessage.CssClass = "ErrHighLight"
                                    Else
                                        UploadFile(oFileUpload,
                                                    oLabelMessage,
                                                     strFileNamePhysic, sFTPServer, sFTPFolder, sFTPUSerID, sFTPPassword, sFolderName,
                                                     oFileType,
                                                     CType(gvUploadDoc.Rows(iRow).FindControl("txtRemark"), TextBox)
                                                     )

                                    End If
                                End If
                            Next
                            GetUploadList()
                        End If
                    End If
                Else
                    lblMessage.Visible = True
                    lblMessage.Text = lblMessage.Text & "CANNOT ACCESS SERVER FTP " & serverName & "<BR>PLEASE CHECK FTP SERVER"
                End If
            Catch ex As Exception
                lblMessage.Visible = True
                lblMessage.Text = lblMessage.Text & "ERROR FTP MAKE DIRECTORY: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            Finally

            End Try

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR TRANSFER DOCUMENT FTP SERVER: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
            objFTP = Nothing
        End Try
    End Sub

    Private Function UploadFile(ByVal oFileUpload As FileUpload, _
                            ByVal oLabelMessage As Label, _
                             ByRef SaveLocation As String, _
                            ByVal sFTPServer As String, _
                            ByVal sFTPFolder As String, _
                            ByVal sFTPUserID As String, _
                            ByVal sFTPPassword As String, _
                            ByVal sFolderName As String, _
                            ByVal oDropdownFileType As DropDownList,
                            ByVal oTextBoxRemark As TextBox) As Boolean
        UploadFile = True
        Dim objFTP As New FTP
        'Dim objDB As New DBX
        'Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim strDir As String = ""
        'Dim strDay, strMonth, strYear, strDirDate As String
        Dim sReturnFTP As Integer
        'Dim dtAppDate As Date
        Dim strDescription As String = ""
        oLabelMessage.Visible = True


        Dim strUploadFile As String = oFileUpload.FileName

        Dim objDBX As New DBX

        Dim objFTPUpload As New FTP
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader

            'jika application document yang di upload,  UPLOADFILETYPE=0, dihapus dulu data lamanya
            If oDropdownFileType.SelectedValue.ToString = "0" Then
                Dim dblAppState As Double
                'CEK DULU STATE APPLICATION
                oSDR = objDBX.CreateSDRFromSQLSelect("SELECT APPSTATE FROM APPLICATION WITH(NOLOCK) WHERE LOCID=" & txtLocID.Value & " AND APPID=" & txtAppID.Value)
                If oSDR.Read() Then
                    dblAppState = oSDR("APPSTATE")
                End If
                oSDR.Close()
                oSDR = Nothing

                If dblAppState >= 7001 Then 'SUDAH ADA DALAM APPROVAL PROSES, TIDAK BOLEH UPLOAD ULANG DOCUMENT APPLICATION
                    oLabelMessage.CssClass = "ErrHighLight"
                    oLabelMessage.Text = "DOCUMENT APPLICATION CANNOT BE UPLOAD, because application has reach APPROVAL PROCESS..!"
                    UploadFile = False
                    'objDBX.Close()
                    'objDBX = Nothing
                    objFTPUpload = Nothing
                    objFTP = Nothing
                    Exit Function
                End If
                objDBX.ExecSQLWithParam("DELETE APPFILEUPLOAD WHERE LOCID=@LOCID AND APPID=@APPID AND UPLOADFILETYPE=0",
                    objDBX.MP("@LOCID", SqlDbType.Int, txtLocID.Value),
                    objDBX.MP("@APPID", SqlDbType.BigInt, txtAppID.Value)
                    )
            Else
                'BUKAN DOCUMENT APLIKASI, CEK APAKAH NAMANYA SAMA DENGAN DOCUMENT APLIKASI
                'cek filename, apakah sama dengan filename aplikasi,jika dalam approval process
                oSDR = objDBX.CreateSDRFromSQLSelect("SELECT FILENAME FROM APPFILEUPLOAD WITH(NOLOCK) WHERE UPLOADFILETYPE=0 AND LOCID=" & txtLocID.Value & " AND APPID=" & txtAppID.Value)
                If oSDR.Read() Then
                    If oSDR("FILENAME").ToString().ToUpper() = strUploadFile.ToUpper() Then
                        oLabelMessage.CssClass = "ErrHighLight"
                        oLabelMessage.Text = "Document File Name uploaded, same with APPLICATION DOCUMENT..!<br>Upload document Failed..!"
                        UploadFile = False
                        'objDBX.Close()
                        'objDBX = Nothing
                        objFTPUpload = Nothing
                        objFTP = Nothing
                        Exit Function
                    End If
                End If
                oSDR.Close()
                oSDR = Nothing

            End If


            strDir = strDir & "\DOCAPP_" & txtLocID.Value & "_" & txtAppID.Value & "_" & Request.Cookies("UID").Value

            If Len(Trim(oDropdownFileType.SelectedValue)) <= 0 Then
                oLabelMessage.CssClass = "ErrHighLight"
                oLabelMessage.Text = "File Upload Type must be entry..!"
                UploadFile = False
                'objdbx di finallyze
                'objDBX.Close()
                'objDBX = Nothing
                objFTPUpload = Nothing
                objFTP = Nothing
                Exit Function
            End If
            oLabelMessage.Visible = True
            Dim fn As String = System.IO.Path.GetFileName(oFileUpload.PostedFile.FileName)
            If Not Directory.Exists(strDir) Then
                Directory.CreateDirectory(strDir)
            End If
            SaveLocation = strDir & "\" & fn
            oFileUpload.PostedFile.SaveAs(SaveLocation)

            'Response.Write(Server.MapPath(SaveLocation))
            'Response.Write(Replace(SaveLocation, ".pdf", "ER.pdf"))
            'Response.Write(oFileUpload.FileName)
            'Response.End()



            Dim serverName As String = sFTPServer
            Dim userName As String = sFTPUserID
            Dim password As String = sFTPPassword
            Dim FolderName As String = sFTPFolder
            objFTP.ServerName = serverName
            objFTP.UserName = userName
            objFTP.Password = password
            objFTP.CurrentFtpPath = FolderName

            If objFTP.FTPConnected() Then

                sReturnFTP = objFTPUpload.FTPUpload(sFTPServer & "/" & sFTPFolder, strUploadFile,
                                                     SaveLocation, sFTPUserID, sFTPPassword, sFolderName, True, strDescription)
                If sReturnFTP = 0 Then
                    oLabelMessage.CssClass = "ShowDetail"
                    oLabelMessage.Text = "The file " + oFileUpload.PostedFile.FileName + "  has been uploaded"
                    objDBX.ExecSP("APPFILEUPLOADSave",
                                  objDBX.MP("@LOCID", SqlDbType.Int, txtLocID.Value),
                                  objDBX.MP("@APPID", SqlDbType.BigInt, txtAppID.Value),
                                  objDBX.MP("@FILENAME", SqlDbType.VarChar, strUploadFile),
                                  objDBX.MP("@UPLOADFILETYPE", SqlDbType.Int, oDropdownFileType.SelectedValue),
                                  objDBX.MP("@REMARK", SqlDbType.VarChar, oTextBoxRemark.Text),
                                  objDBX.MP("@USERID", SqlDbType.Int, Request.Cookies("UID").Value)
                                  )
                    'delete temporay file upload
                    'string path = "E:\\sasi\\delt.doc";
                    Dim myfileinf As New FileInfo(SaveLocation)
                    myfileinf.Delete()
                    myfileinf = Nothing
                    'DELETE DIREKTORY
                    If Directory.Exists(strDir) Then
                        Directory.Delete(strDir)
                    End If

                    lblMessage.Visible = False
                ElseIf sReturnFTP = -1 Then 'Path Address
                    oLabelMessage.CssClass = "ErrHighLight"
                    oLabelMessage.Text = "INVALID PATH ADDRESS FTP FOLDER " & txtLocID.Value & "_" & txtAppID.Value & "<BR>CANNOT GET FILE DOCUMENT FTP SERVER"
                    UploadFile = False
                ElseIf sReturnFTP = -2 Then 'upload file
                    oLabelMessage.CssClass = "ErrHighLight"
                    oLabelMessage.Text = "INVALID FTP USER NAME OR PASSWORD<BR>CANNOT GET FILE DOCUMENT FTP SERVER"
                    UploadFile = False
                ElseIf sReturnFTP = -3 Then 'cannot access server
                    oLabelMessage.CssClass = "ErrHighLight"
                    oLabelMessage.Text = "CANNOT ACCESS DATA FOLDER TO FTP SERVER<BR>CANNOT GET FILE DOCUMENT FTP SERVER"
                    UploadFile = False
                End If
            Else
                lblMessage.Visible = True
                lblMessage.Text = lblMessage.Text & "CANNOT ACCESS SERVER FTP " & serverName & "<BR>PLEASE CHECK FTP SERVER"
                UploadFile = False
            End If


            'secure pdf document
            If oDropdownFileType.SelectedValue <> "0" And (oFileUpload.PostedFile.ContentType.ToLower = "application/pdf") Then

                Dim bytReturnFTP As Byte()
                bytReturnFTP = objFTP.FTPViewDirect(sFTPServer & "/" & sFTPFolder, strUploadFile, sFTPUserID, sFTPPassword, sFolderName, True)

                'stream untuk menampung hasil encrypt
                'Dim stream As New MemoryStream

                Dim objPDF As New PDFSign
                Try
                    Dim bytPDFEncrypt As Byte() = Nothing
                    'encrypt
                    'objPDF.pdfEncryptByDocID(oDropdownFileType.SelectedValue, bytReturnFTP, "ghw@777", stream, bytPDFEncrypt)
                    objPDF.pdfEncryptByDocID(oDropdownFileType.SelectedValue, bytReturnFTP, Nothing, bytPDFEncrypt)

                    ''upload byte lewat ftp
                    objFTP.FTPUploadFromByte(sFTPServer & "/" & sFTPFolder, strUploadFile, sFTPUserID, sFTPPassword, bytPDFEncrypt, sFolderName, True)


                    'Catch ex As Exception
                Finally
                    'stream.Dispose()
                    'stream.Close()
                    'stream = Nothing
                    objPDF = Nothing
                End Try

            End If

        Catch Exc As Exception
            UploadFile = False
            oLabelMessage.CssClass = "ErrHighLight"
            oLabelMessage.Text = "ERROR UPLOAD FILE DOCUMENT : " & Exc.Message
            strScript = "<script type='text/javascript'>" & Chr(13)
            strScript = strScript & "ShowAlert();" & Chr(13)
            strScript = strScript & "</script>" & Chr(13)
        Finally
            objFTPUpload = Nothing
            objFTP = Nothing
            objDBX.Close()
            objDBX = Nothing
        End Try

    End Function

End Class
