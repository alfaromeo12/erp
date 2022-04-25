'Imports System.Data.SqlClient
Partial Class Home_FTPDoc
    Inherits System.Web.UI.Page
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            pnlFTPDocument.Visible = False

        End If
        SetValidation()
    End Sub
    Private Sub SetValidation()
        Dim oTextBox As TextBox
        oTextBox = txtCodeFTP
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase nospace")
            oTextBox.Focus()
        End If
        oTextBox = txtFolder
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")
        oTextBox = txtServer
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "uppercase")

    End Sub
    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objDB As New DBX
        Dim FTP As New FTP
        Try
            lblMessage.Text = ""
            Dim serverName As String = txtServer.Text.Trim()
            Dim userName As String = txtUser.Text.Trim()
            Dim password As String = txtPassword.Text.Trim()
            Dim FolderName As String = txtFolder.Text.Trim()
            FTP.ServerName = serverName
            FTP.UserName = userName
            FTP.Password = password
            FTP.CurrentFtpPath = FolderName
            If FTP.FTPConnected() Then
                objDB.ExecSP("FTPDocUpdate", _
                    objDB.MP("@FTPCODE", Data.SqlDbType.VarChar, txtCodeFTP.Text, 5), _
                    objDB.MP("@FTPUSERID", Data.SqlDbType.VarChar, txtUser.Text, 50), _
                    objDB.MP("@FTPPASSWORD", Data.SqlDbType.VarChar, RC4Engine.rc4(txtPassword.Text), 100), _
                    objDB.MP("@FTPSERVER", Data.SqlDbType.VarChar, txtServer.Text, 50), _
                    objDB.MP("@FTPFOLDER", Data.SqlDbType.VarChar, txtFolder.Text, 50) _
                )
                lblMessage.Visible = True
                lblMessage.Text = "FTP USER DOCUMENT HAVE BEEN SAVE SUCCEFULLY..!"
                DataSearch()
                pnlFTPDocument.Visible = False
            Else
                lblMessage.Visible = True
                lblMessage.Text = lblMessage.Text & "CANNOT ACCESS SERVER FTP " & serverName & ", PLEASE CHECK FTP SERVER SETTING..!"
                lblMessage.Text = lblMessage.Text & "<BR>FTP DOCUMENT CAN NOT BE SAVED..!"
            End If

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = lblMessage.Text & "ERROR SAVE FTP DOCUMENT..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE: " & ex.Message
        Finally
            objDB.Close()
            objDB = Nothing
            FTP = Nothing
        End Try
    End Sub

    Private Sub DataSearch()
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " WHERE " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        gvData.DataBind()
    End Sub
    Protected Sub imgBtnNew_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        pnlFTPDocument.Visible = True
        txtCodeFTP.Text = ""
        txtFolder.Text = ""
        txtPassword.Text = ""
        txtServer.Text = ""
        txtUser.Text = ""
        txtCodeFTP.CssClass = "required"
        txtCodeFTP.ReadOnly = False
    End Sub
    Protected Sub gvData_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        lblMessage.Text = ""
        If e.CommandName = "Select" Then
            gvData.SelectedIndex = e.CommandArgument
            pnlFTPDocument.Visible = True
            GetData(gvData.SelectedDataKey("FTPCODE"))
        End If
    End Sub
    Private Sub GetData(ByVal sCodeFTP As String)
        Dim objDB As New DBX
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT * FROM FTPDOC WHERE FTPCODE='" & sCodeFTP & "'")
            If oSDR.Read() Then
                txtCodeFTP.Text = oSDR("FTPCODE").ToString()
                txtFolder.Text = oSDR("FTPFOLDER").ToString()
                txtPassword.Text = RC4Engine.rc4(oSDR("FTPPASSWORD").ToString())
                txtServer.Text = oSDR("FTPSERVER").ToString()
                txtUser.Text = oSDR("FTPUSERID").ToString()
            End If
            oSDR.Close()
            oSDR = Nothing
            txtCodeFTP.ReadOnly = True
            txtCodeFTP.CssClass = "disabled"
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR LOADING FTP DOCUMENT...!<BR>PLEASE CHECK DETAIL ERROR MESSAGE:<BR>" & ex.Message
            lblMessage.Focus()
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As System.EventArgs) Handles btnCancel.Click
        pnlFTPDocument.Visible = False
    End Sub

    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
        lblMessage.Visible = False
    End Sub
End Class
