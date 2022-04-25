
Partial Class Param_SERVICEBIRO
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            MultiView_Utama.SetActiveView(View_View)
        End If
        SetValidation()
        DataSearch()
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub gvData_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        'lblError.Text = ""
        lblError.Visible = False
        If e.CommandName = "Select" Then
            gvData.SelectedIndex = e.CommandArgument
            lblCaption.Text = "Edit Data"
            hidSBID.Value = gvData.SelectedDataKey("SBID")
            chkAdd.Checked = False
            MultiView_Utama.SetActiveView(View_Form)
            GetData(hidSBID.Value)
            pnlControl.Visible = True
        End If
    End Sub

    Protected Sub imgBtnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        lblCaption.Text = "New Data"
        chkAdd.Checked = True
        SetValidation()

        pnlControl.Visible = True
        Validation.ClearPanelAplicationField(pnlFormSB)
        MultiView_Utama.SetActiveView(View_Form)
        hidAction.Value = "NEW"
     
    End Sub

    Private Sub SetValidation()
        SetObjectValidation(txtBJCode, False, "uppercase nospace")
        SetObjectValidation(txtBJName, False, "uppercase")
        SetObjectValidation(txtAccountNo, False, "integer", "[0-9]")
        SetObjectValidation(txtBJZip, False, "integer", "[0-9]")

    End Sub

    Private Sub DataSearch()
        If Not IsPostBack() Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND SERVICEBIRO.SBID=-999"
        End If
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        gvData.DataBind()
    End Sub


    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        lblError.Visible = False
    End Sub
    Private Sub GetData(ByVal strKey As String)
        Dim objDB As New DBX
        Try

            Dim oSDR As System.Data.SqlClient.SqlDataReader

            oSDR = objDB.CreateSDRFromSQLSelect("SELECT  * " & _
              "  FROM dbo.SERVICEBIRO WITH(NOLOCK) WHERE SBID=" & strKey)
            If oSDR.Read Then

                lblBJID.Text = oSDR("SBID")
                txtBJCode.Text = oSDR("SBCODE")
                txtBJName.Text = oSDR("SBNAME")
                txtBJAddress.Text = oSDR("SBADDRESS").ToString
                If Not String.IsNullOrEmpty(oSDR("SBZIP").ToString()) Then
                    txtBJZip.Text = oSDR("SBZIP").ToString()
                Else
                    txtBJZip.Text = ""
                End If
                If Not String.IsNullOrEmpty(oSDR("SBCITY").ToString()) Then
                    txtBJCity.Text = oSDR("SBCITY").ToString()
                Else
                    txtBJCity.Text = ""
                End If
                If Not String.IsNullOrEmpty(oSDR("SBFAX").ToString()) Then
                    txtBJFax.Text = oSDR("SBFAX").ToString()
                Else
                    txtBJFax.Text = ""
                End If
                If Not String.IsNullOrEmpty(oSDR("SBPHONE").ToString()) Then
                    txtBJPhone.Text = oSDR("SBPHONE").ToString()
                Else
                    txtBJPhone.Text = ""
                End If
                If Not String.IsNullOrEmpty(oSDR("SBBANKID").ToString()) Then
                    ddlbank.SelectedValue = oSDR("SBBANKID").ToString()
                Else
                    ddlbank.SelectedValue = 0
                End If
                txtAccountNo.Text = oSDR("SBACCOUNTNO").ToString
                txtAccountNm.Text = oSDR("SBACCOUNTNAME").ToString
                txtContactPerson.Text = oSDR("SBCONTACTPERSON").ToString
                Dim oSDRColl As System.Data.SqlClient.SqlDataReader
                oSDRColl = objDB.CreateSDRFromSQLSelect("SELECT COLLATERALACTIVITY.COLLACTID,COLLATERALACTIVITY.COLLACTNAME, ISNULL(SERVICEBIROFEE.SERVICEFEE,0)SERVICEBIROFEE " & _
                " FROM COLLATERALACTIVITY  WITH(NOLOCK) " & _
                " LEFT JOIN SERVICEBIROFEE ON SERVICEBIROFEE.COLLACTID = COLLATERALACTIVITY.COLLACTID " & _
                " WHERE SERVICEBIROFEE.SBID= " & strKey)
                If oSDRColl.HasRows Then
                    GvwFee.DataBind()
                End If

                oSDRColl.Close()
                oSDRColl = Nothing
            Else
                lblMessage.Visible = True
                lblMessage.Text = "SERVICE BIRO ID : " & strKey & " NOT ALREADY EXIST..!"
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RETRIVE DATA (SERVICE BIRO) ENTRY: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Private Sub SaveData(ByVal sSBCd As String,
                        ByVal sSBNm As String,
                        ByVal sSBAddress As String,
                        ByVal sSBZIP As String,
                        ByVal sSBCity As String,
                        ByVal sSBPhone As String,
                        ByVal sSBFax As String,
                        ByVal sSBBank As String,
                        ByVal sSBAccountNo As String,
                        ByVal sSBAccountNm As String,
                        ByVal sSBContactPerson As String,
                        ByVal sUserId As String)
        Dim objDB As New DBX
        Dim intRetVal As Integer
        Dim intSBID As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection

        Try

            oSQLParam = objDB.ExecSPReturnParam("SERVICEBIROAdd", _
                   objDB.MP("@SBCODE", Data.SqlDbType.VarChar, sSBCd, 10), _
                   objDB.MP("@SBNAME", Data.SqlDbType.VarChar, sSBNm, 50), _
                   objDB.MP("@SBADDRESS", Data.SqlDbType.VarChar, sSBAddress, 100), _
                   objDB.MP("@SBZIP", Data.SqlDbType.VarChar, sSBZIP, 5), _
                   objDB.MP("@SBCITY", Data.SqlDbType.VarChar, sSBCity, 50), _
                   objDB.MP("@SBPHONE", Data.SqlDbType.VarChar, sSBPhone, 50), _
                   objDB.MP("@SBFAX", Data.SqlDbType.VarChar, sSBFax, 50), _
                   objDB.MP("@SBBANKID", Data.SqlDbType.Int, sSBBank, 4), _
                   objDB.MP("@SBACCOUNTNO", Data.SqlDbType.VarChar, sSBAccountNo, 50), _
                   objDB.MP("@SBACCOUNTNAME", Data.SqlDbType.VarChar, sSBAccountNm, 80), _
                   objDB.MP("@SBCONTACTPERSON", Data.SqlDbType.VarChar, sSBContactPerson, 50), _
                   objDB.MP("@USERID", Data.SqlDbType.BigInt, sUserId, 20), _
                   objDB.MP("@SBID", Data.SqlDbType.Int, intSBID, 10, Data.ParameterDirection.Output), _
                   objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 10, Data.ParameterDirection.Output) _
                    )
            If Not IsDBNull(oSQLParam("@SBID").Value) Then
                intSBID = oSQLParam("@SBID").Value
            End If
            intRetVal = oSQLParam("@RETVAL").Value.ToString()
            hidSBID.Value = intSBID
            If intRetVal = -1 Then
                lblMessage.Visible = True
                lblMessage.Text = "SERVICE BIRO CODE : " & sSBCd & " ALREADY EXISTS..!"
            Else
                lblMessage.Text = ""
                lblMessage.Visible = False
            End If


        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE DATA SERVICE BIRO: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Private Sub EditData(ByVal sSBID As String,
                       ByVal sSBCd As String,
                       ByVal sSBNm As String,
                       ByVal sSBAddress As String,
                       ByVal sSBZIP As String,
                       ByVal sSBCity As String,
                       ByVal sSBPhone As String,
                       ByVal sSBFax As String,
                       ByVal sSBBank As String,
                       ByVal sSBAccountNo As String,
                       ByVal sSBAccountNm As String,
                       ByVal sSBContactPerson As String,
                       ByVal sUserId As String)
        Dim objDB As New DBX
        Dim intRetVal As Integer
        'Dim intSBID As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection

        Try

            oSQLParam = objDB.ExecSPReturnParam("SERVICEBIROUpdate", _
                   objDB.MP("@SBID", Data.SqlDbType.Int, sSBID, 4), _
                   objDB.MP("@SBCODE", Data.SqlDbType.VarChar, sSBCd, 10), _
                   objDB.MP("@SBNAME", Data.SqlDbType.VarChar, sSBNm, 50), _
                   objDB.MP("@SBADDRESS", Data.SqlDbType.VarChar, sSBAddress, 100), _
                   objDB.MP("@SBZIP", Data.SqlDbType.VarChar, sSBZIP, 5), _
                   objDB.MP("@SBCITY", Data.SqlDbType.VarChar, sSBCity, 50), _
                   objDB.MP("@SBPHONE", Data.SqlDbType.VarChar, sSBPhone, 50), _
                   objDB.MP("@SBFAX", Data.SqlDbType.VarChar, sSBFax, 50), _
                   objDB.MP("@SBBANKID", Data.SqlDbType.Int, sSBBank, 4), _
                   objDB.MP("@SBACCOUNTNO", Data.SqlDbType.VarChar, sSBAccountNo, 50), _
                   objDB.MP("@SBACCOUNTNAME", Data.SqlDbType.VarChar, sSBAccountNm, 80), _
                   objDB.MP("@SBCONTACTPERSON", Data.SqlDbType.VarChar, sSBContactPerson, 50), _
                   objDB.MP("@USERID", Data.SqlDbType.BigInt, sUserId, 20), _
                   objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 10, Data.ParameterDirection.Output) _
                    )
            intRetVal = oSQLParam("@RETVAL").Value.ToString()
            hidSBID.Value = sSBID
            If intRetVal = -1 Then
                lblMessage.Visible = True
                lblMessage.Text = "SERVICE BIRO CODE : " & sSBCd & " ALREADY EXISTS..!"
            Else
                lblMessage.Text = ""
                lblMessage.Visible = False
            End If


        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE DATA SERVICE BIRO: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Private Sub ServiceBiroFEE(ByVal iSBID As Integer,
                            ByVal iCollactID As Integer, ByVal mServiceFEE As Double)

        Dim objDB As New DBX
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try

            oSQLParam = objDB.ExecSPReturnParam("SERVICEBIROFEESave", _
                   objDB.MP("@SBID", Data.SqlDbType.BigInt, iSBID, 8), _
                   objDB.MP("@COLLACTID", Data.SqlDbType.Int, iCollactID, 4), _
                   objDB.MP("@SERVICEFEE", Data.SqlDbType.Money, mServiceFEE, 20), _
                   objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 20))
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE DATA SERVICE BIRO FEE: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            lblMessage.Visible = False
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        Dim objDB As New DBX
        Dim iRow As Integer
        Dim iRows As Integer
        If chkAdd.Checked Then
            SaveData(txtBJCode.Text,
                     txtBJName.Text, txtBJAddress.Text.ToString, txtBJZip.Text,
                     txtBJCity.Text, txtBJPhone.Text, txtBJFax.Text,
                     ddlbank.SelectedValue, txtAccountNo.Text, txtAccountNm.Text, txtContactPerson.Text, Request.Cookies("UID").Value)
        Else
            EditData(lblBJID.Text, txtBJCode.Text,
                     txtBJName.Text, txtBJAddress.Text.ToString, txtBJZip.Text,
                     txtBJCity.Text, txtBJPhone.Text, txtBJFax.Text,
                     ddlbank.SelectedValue, txtAccountNo.Text, txtAccountNm.Text, txtContactPerson.Text, Request.Cookies("UID").Value)
        End If
        Dim oSDR As Data.SqlClient.SqlDataReader
        oSDR = objDB.CreateSDRFromExecSQL("Update dbo.SERVICEBIROFEE SET DeleteSTS=1 WHERE SBID=" & hidSBID.Value)
        If oSDR.Read() Then
        End If
        oSDR.Close()
        iRows = GvwFee.Rows.Count - 1
        For iRow = 0 To iRows
            ServiceBiroFEE(hidSBID.Value, CType(GvwFee.Rows(iRow).FindControl("lblCollKey"), Label).Text, CType(GvwFee.Rows(iRow).FindControl("txtFee"), TextBox).Text)
        Next
        MultiView_Utama.SetActiveView(View_Form)
        'MultiView_Utama.SetActiveView(View_View)
        'DataSearch()
        'pnlControl.Visible = False
    End Sub

    Protected Sub GvwFee_DataBound(sender As Object, e As System.EventArgs) Handles GvwFee.DataBound
        Dim oTextBox As TextBox
        For Each row As GridViewRow In GvwFee.Rows
            oTextBox = CType(row.FindControl("txtFee"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
            End If
        Next
    End Sub
    Protected Sub GvwFee_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GvwFee.RowDataBound
        Dim oTextBox As TextBox
        For Each row As GridViewRow In GvwFee.Rows
            oTextBox = CType(row.FindControl("txtFee"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "float", "[0-9.,]")
                If Len(Trim(oTextBox.Text)) <= 0 Then
                    oTextBox.Text = "0"
                End If
            End If
        Next
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As System.EventArgs) Handles btnCancel.Click
        MultiView_Utama.SetActiveView(View_View)
        Validation.ClearPanelAplicationField(pnlFormSB)
        pnlControl.Visible = False
        DataSearch()
    End Sub

    Protected Sub btnDelete_Click(sender As Object, e As System.EventArgs) Handles btnDelete.Click
        Dim objDB As New DBX
        Dim oSDR As Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromExecSQL("Update dbo.SERVICEBIRO SET DeleteSTS=1 WHERE SBID=" & hidSBID.Value)
            If oSDR.Read() Then
                MultiView_Utama.SetActiveView(View_View)
                DataSearch()
                pnlControl.Visible = False
            Else
                lblMessage.Visible = True
                lblMessage.Text = "ERROR DELETE DATA SERVICE BIRO WITH ID :" & hidSBID.Value
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR DELETE DATA SERVICE BIRO: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            lblMessage.Visible = False
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
End Class
