
Partial Class Home_EmailSetting
    Inherits System.Web.UI.Page
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            pnlEmailSetting.Visible = False
        End If
        SetValidation()
    End Sub
    Private Sub SetValidation()
        Dim oTextBox As TextBox
        oTextBox = txtEmailCode
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase nospace")
            oTextBox.Focus()
        End If
        oTextBox = txtPortSMTP
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "integer", "[0-9]")
            oTextBox.Focus()
        End If
        oTextBox = txtPortPOP3
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "integer", "[0-9]")
            oTextBox.Focus()
        End If
    End Sub
    Private Sub saveData(ByVal sEmailCode As String,
        ByVal sUser As String, _
        ByVal sPass As String, _
        ByVal sSMTP As String, _
        ByVal sPOP3 As String, _
        ByVal iPortSMTP As Integer, _
        ByVal iPortPOP3 As Integer, _
        ByVal bSSL As Boolean, _
        ByVal intUSERID As Integer)
        Dim objDB As New DBX
        Try
            objDB.ExecSP("EmailSettingUpdate", _
                objDB.MP("@EMAILCODE", Data.SqlDbType.VarChar, sEmailCode), _
                objDB.MP("@USER", Data.SqlDbType.VarChar, sUser), _
                objDB.MP("@PASSWORD", Data.SqlDbType.VarChar, RC4Engine.rc4(sPass)), _
                objDB.MP("@SMTP", Data.SqlDbType.VarChar, sSMTP), _
                objDB.MP("@POP3", Data.SqlDbType.VarChar, sPOP3), _
                objDB.MP("@PORTSMTP", Data.SqlDbType.Int, iPortSMTP), _
                objDB.MP("@PORTPOP3", Data.SqlDbType.Int, iPortPOP3), _
                objDB.MP("@SSL", Data.SqlDbType.Bit, bSSL), _
                objDB.MP("@UserId", Data.SqlDbType.Int, intUSERID) _
            )

        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Private Sub DataSearch()
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " WHERE " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        gvData.DataBind()
    End Sub
    Protected Sub imgBtnNew_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        pnlEmailSetting.Visible = True
        txtEmailCode.Text = ""
        txtUserID.Text = ""
        txtPassword.Text = ""
        txtSMTP.Text = ""
        txtPop3.Text = ""
        txtEmailCode.CssClass = "required"
        txtEmailCode.ReadOnly = False
        lblMessage.Visible = False
    End Sub
    Protected Sub gvData_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        lblMessage.Text = ""
        If e.CommandName = "Select" Then
            gvData.SelectedIndex = e.CommandArgument
            pnlEmailSetting.Visible = True
            GetData(gvData.SelectedDataKey("EMAILCODE"))
        End If
    End Sub
    Private Sub GetData(ByVal sCodeEmail As String)
        Dim objDB As New DBX
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT EMAILCODE, USERID, PASSWORD, SMTP, POP3, PORTSMTP, PORTPOP3, SSL FROM EMAILSETTING WHERE EMAILCODE='" & sCodeEmail & "'")
            If oSDR.Read() Then
                txtEmailCode.Text = oSDR("EMAILCODE").ToString()
                txtUserID.Text = oSDR("USERID").ToString()
                txtPassword.Text = RC4Engine.rc4(oSDR("PASSWORD").ToString())
                txtSMTP.Text = oSDR("SMTP").ToString()
                txtPop3.Text = oSDR("POP3").ToString()
                txtPortSMTP.Text = oSDR("PORTSMTP").ToString()
                txtPortPOP3.Text = oSDR("PORTPOP3").ToString()
                If oSDR("SSL").ToString = True Then
                    rbYes.Checked = True
                    rbNo.Checked = False
                Else
                    rbYes.Checked = False
                    rbNo.Checked = True
                End If
            End If
            oSDR.Close()
            oSDR = Nothing
            txtEmailCode.ReadOnly = True
            txtEmailCode.CssClass = "disabled"
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR LOADING EMAIL DOCUMENT...!<BR>PLEASE CHECK DETAIL ERROR MESSAGE:<BR>" & ex.Message
            lblMessage.Focus()
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As System.EventArgs) Handles btnCancel.Click
        pnlEmailSetting.Visible = False
    End Sub

    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
        lblMessage.Visible = False
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        Dim objHm As New Home_EmailSetting
        Try
            Dim bSSL As Boolean
            If rbYes.Checked = True Then
                bSSL = True
            Else
                bSSL = False
            End If
            objHm.saveData(txtEmailCode.Text, txtUserID.Text, txtPassword.Text, txtSMTP.Text, txtPop3.Text,
                           txtPortSMTP.Text, txtPortPOP3.Text, bSSL, Request.Cookies("UID").Value)
            lblMessage.Visible = True
            lblMessage.Text = "EMAIL SETTING HAVE BEEN SAVE SUCCEFULLY..!"
            DataSearch()
            pnlEmailSetting.Visible = False
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = lblMessage.Text & "ERROR SAVE EMAIL SETTING..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE: " & ex.Message
        Finally
            objHm = Nothing
        End Try
    End Sub
End Class
