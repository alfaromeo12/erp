
Partial Class Param_JFTNC
    Inherits System.Web.UI.Page
    Public Shared strAction As String = ""
    
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            pnlTNC.Visible = False
        End If

    End Sub

    Private Sub SetValidation()
        Dim oTextBox As TextBox

        oTextBox = txtTNCCode
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase")
            oTextBox.Focus()
        End If
        oTextBox = txtTNCName
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "uppercase")
            oTextBox.Focus()
        End If

        oTextBox = txtBookFrom
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "date", "[0-9/]")
        oTextBox = txtBookTo
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, False, "date", "[0-9/]")


        oTextBox = txtTenorFrom
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "signed float", "[0-9,-]")
            oTextBox.Focus()
        End If
        oTextBox = txtTenorTo
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "signed float", "[0-9,-]")
            oTextBox.Focus()
        End If
        oTextBox = txtPrincipalFrom
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "signed float", "[0-9,-]")
            oTextBox.Focus()
        End If
        oTextBox = txtPrincipalTo
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "signed float", "[0-9,-]")
            oTextBox.Focus()
        End If
        oTextBox = txtDPMin
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "signed float", "[0-9,-]")
            oTextBox.Focus()
        End If
        oTextBox = txtDSR
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "signed float", "[0-9,-]")
            oTextBox.Focus()
        End If
        oTextBox = txtAge
        If oTextBox IsNot Nothing Then
            SetObjectValidation(oTextBox, False, "signed float", "[0-9,-]")
            oTextBox.Focus()
        End If
    End Sub

    Private Sub DataSearch()
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'"
        End If
        gvData.DataBind()
    End Sub

    Protected Sub gvData_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        'lblError.Text = ""
        lblError.Visible = False
        If e.CommandName = "Select" Then
            gvData.SelectedIndex = e.CommandArgument
            pnlTNC.Visible = True
            hidJFTNCID.Value = gvData.SelectedDataKey("JFTNCID")
            GetData(gvData.SelectedDataKey("JFTNCID"))
            sdsBranchSrc.SelectParameters("JFTNCID").DefaultValue = gvData.SelectedDataKey("JFTNCID")
            sdsBranchDest.SelectParameters("JFTNCID").DefaultValue = gvData.SelectedDataKey("JFTNCID")
            sdsFinCatSrc.SelectParameters("JFTNCID").DefaultValue = gvData.SelectedDataKey("JFTNCID")
            sdsFinCatDest.SelectParameters("JFTNCID").DefaultValue = gvData.SelectedDataKey("JFTNCID")
            sdsProductSrc.SelectParameters("JFTNCID").DefaultValue = gvData.SelectedDataKey("JFTNCID")
            sdsProductDest.SelectParameters("JFTNCID").DefaultValue = gvData.SelectedDataKey("JFTNCID")
            sdsPurposeSrc.SelectParameters("JFTNCID").DefaultValue = gvData.SelectedDataKey("JFTNCID")
            sdsPurposeDest.SelectParameters("JFTNCID").DefaultValue = gvData.SelectedDataKey("JFTNCID")
            SetValidation()
        End If
    End Sub

    Private Sub GetData(ByVal sJFTNCID As String)
        Dim objDB As New DBX
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT JFTNCID, JFTNCCODE, JFTNCNAME, DESCRIPTION, LOANTYPE, BOOKINGFROM, BOOKINGTO, INCLUDEPASTDUE, INCLUDENEWACCOUNT, " & _
                                                "OSTENORFROM, OSTENORTO, OSPRINCIPALFROM, OSPRINCIPALTO, DPMINIMUM, DSR, AGE, INSTALLMENTTYPE, CURRENCYID, IDEXPIREDCHECKING, " & _
                                                "CONDITION, BPKBSTATUS, INCLUDEEARLYPAY FROM JFTNC WHERE JFTNCID='" & sJFTNCID & "'")
            If oSDR.Read() Then
                txtTNCCode.Text = oSDR("JFTNCCODE").ToString()
                txtTNCName.Text = oSDR("JFTNCNAME").ToString()
                txtDescription.Text = oSDR("DESCRIPTION").ToString()
                If Not String.IsNullOrEmpty(oSDR("BOOKINGFROM").ToString()) Then
                    txtBookFrom.Text = String.Format("{0:dd/MM/yyyy}", oSDR("BOOKINGFROM"))
                Else
                    txtBookFrom.Text = ""
                End If
                If Not String.IsNullOrEmpty(oSDR("BOOKINGTO").ToString()) Then
                    txtBookTo.Text = String.Format("{0:dd/MM/yyyy}", oSDR("BOOKINGTO"))
                Else
                    txtBookTo.Text = ""
                End If
                If oSDR("INCLUDEPASTDUE").ToString = True Then
                    rbPastDueInclude.Checked = True
                    rbPastDueExclude.Checked = False
                Else
                    rbEarlyInclude.Checked = False
                    rbEarlyExclude.Checked = True
                End If
                If oSDR("INCLUDENEWACCOUNT").ToString = True Then
                    rbNewAccountInclude.Checked = True
                    rbNewAccountExclude.Checked = False
                Else
                    rbNewAccountInclude.Checked = False
                    rbNewAccountExclude.Checked = True
                End If
                ddlLoanTypeSearch.SelectedValue = oSDR("LOANTYPE").ToString()
                txtTenorFrom.Text = oSDR("OSTENORFROM").ToString()
                txtTenorTo.Text = oSDR("OSTENORTO").ToString()
                txtPrincipalFrom.Text = oSDR("OSPRINCIPALFROM").ToString()
                txtPrincipalTo.Text = oSDR("OSPRINCIPALTO").ToString()
                txtDPMin.Text = oSDR("DPMINIMUM").ToString()
                If oSDR("IDEXPIREDCHECKING").ToString = True Then
                    rbIDInclude.Checked = True
                    rbIDExclude.Checked = False
                Else
                    rbIDInclude.Checked = False
                    rbIDExclude.Checked = True
                End If
                txtDSR.Text = oSDR("DSR").ToString()
                txtAge.Text = oSDR("AGE").ToString()
                ddlInstallmentTypeSearch.SelectedValue = oSDR("INSTALLMENTTYPE").ToString()
                ddlCurrencySearch.SelectedValue = oSDR("CURRENCYID").ToString()
                ddlCondition.SelectedValue = oSDR("CONDITION").ToString()
                ddlBPKBStatus.SelectedValue = oSDR("BPKBSTATUS").ToString()
                If oSDR("INCLUDEEARLYPAY").ToString = True Then
                    rbEarlyInclude.Checked = True
                    rbEarlyExclude.Checked = False
                Else
                    rbEarlyInclude.Checked = False
                    rbEarlyExclude.Checked = True
                End If
            End If
            oSDR.Close()
            oSDR = Nothing

        Catch ex As Exception
            lblError.Visible = True
            lblError.Text = "ERROR LOADING TNC DATA...!<BR>PLEASE CHECK DETAIL ERROR MESSAGE:<BR>" & ex.Message
            lblError.Focus()
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Protected Sub imgBtnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click

        'Response.Write(hidJFTNCID.Value)
        hidJFTNCID.Value = "0"

        pnlTNC.Visible = True
        SetValidation()
        txtTNCCode.Text = ""
        txtTNCName.Text = ""
        txtDescription.Text = ""
        txtBookFrom.Text = ""
        txtBookTo.Text = ""
        txtTenorFrom.Text = ""
        txtTenorTo.Text = ""
        txtPrincipalFrom.Text = ""
        txtPrincipalTo.Text = ""
        txtDPMin.Text = ""
        txtDSR.Text = ""
        txtAge.Text = ""

        gvData.SelectedIndex = -1

        sdsBranchSrc.SelectParameters("JFTNCID").DefaultValue = hidJFTNCID.Value
        'sdsBranchDest.SelectParameters("JFTNCID").DefaultValue = hidJFTNCID.Value
        sdsFinCatSrc.SelectParameters("JFTNCID").DefaultValue = hidJFTNCID.Value
        'sdsFinCatDest.SelectParameters("JFTNCID").DefaultValue = hidJFTNCID.Value
        sdsProductSrc.SelectParameters("JFTNCID").DefaultValue = hidJFTNCID.Value
        'sdsProductDest.SelectParameters("JFTNCID").DefaultValue = hidJFTNCID.Value
        sdsPurposeSrc.SelectParameters("JFTNCID").DefaultValue = hidJFTNCID.Value
        'sdsPurposeDest.SelectParameters("JFTNCID").DefaultValue = hidJFTNCID.Value
        'lvbBrchSrc.DataBind()
        lvbBrchDest.Items.Clear()
        'lvbFinCatSrc.DataBind()
        lvbFinCatDest.Items.Clear()
        'lvbProductSrc.DataBind()
        lvbProductDest.Items.Clear()
        'lvbPurposeSrc.DataBind()
        lvbPurposeDest.Items.Clear()

        lblError.Visible = False

        'Response.End()
    End Sub

    Protected Sub btnFunctionSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
        lblError.Visible = False
    End Sub

    Protected Sub btnMove_Click(sender As Object, e As System.EventArgs) Handles btnMove.Click
        For i As Integer = lvbBrchSrc.Items.Count - 1 To 0 Step -1
            If lvbBrchSrc.Items(i).Selected Then
                lvbBrchDest.Items.Add(lvbBrchSrc.Items(i))
                lvbBrchDest.ClearSelection()
                lvbBrchSrc.Items.Remove(lvbBrchSrc.Items(i))
            End If
        Next
    End Sub

    Protected Sub btnBack_Click(sender As Object, e As System.EventArgs) Handles btnBack.Click
        For i As Integer = lvbBrchDest.Items.Count - 1 To 0 Step -1
            If lvbBrchDest.Items(i).Selected Then
                lvbBrchSrc.Items.Add(lvbBrchDest.Items(i))
                lvbBrchSrc.ClearSelection()
                lvbBrchDest.Items.Remove(lvbBrchDest.Items(i))
            End If
        Next
    End Sub

    Protected Sub btnMoveF_Click(sender As Object, e As System.EventArgs) Handles btnMoveF.Click
        For i As Integer = lvbFinCatSrc.Items.Count - 1 To 0 Step -1
            If lvbFinCatSrc.Items(i).Selected Then
                lvbFinCatDest.Items.Add(lvbFinCatSrc.Items(i))
                lvbFinCatDest.ClearSelection()
                lvbFinCatSrc.Items.Remove(lvbFinCatSrc.Items(i))
            End If
        Next
    End Sub

    Protected Sub btnBackF_Click(sender As Object, e As System.EventArgs) Handles btnBackF.Click
        For i As Integer = lvbFinCatDest.Items.Count - 1 To 0 Step -1
            If lvbFinCatDest.Items(i).Selected Then
                lvbFinCatSrc.Items.Add(lvbFinCatDest.Items(i))
                lvbFinCatSrc.ClearSelection()
                lvbFinCatDest.Items.Remove(lvbFinCatDest.Items(i))
            End If
        Next
    End Sub

    Protected Sub btnMoveP_Click(sender As Object, e As System.EventArgs) Handles btnMoveP.Click
        For i As Integer = lvbProductSrc.Items.Count - 1 To 0 Step -1
            If lvbProductSrc.Items(i).Selected Then
                lvbProductDest.Items.Add(lvbProductSrc.Items(i))
                lvbProductDest.ClearSelection()
                lvbProductSrc.Items.Remove(lvbProductSrc.Items(i))
            End If
        Next
    End Sub

    Protected Sub btnBackP_Click(sender As Object, e As System.EventArgs) Handles btnBackP.Click
        For i As Integer = lvbProductDest.Items.Count - 1 To 0 Step -1
            If lvbProductDest.Items(i).Selected Then
                lvbProductSrc.Items.Add(lvbProductDest.Items(i))
                lvbProductSrc.ClearSelection()
                lvbProductDest.Items.Remove(lvbProductDest.Items(i))
            End If
        Next
    End Sub

    Protected Sub btnMoveR_Click(sender As Object, e As System.EventArgs) Handles btnMoveR.Click
        For i As Integer = lvbPurposeSrc.Items.Count - 1 To 0 Step -1
            If lvbPurposeSrc.Items(i).Selected Then
                lvbPurposeDest.Items.Add(lvbPurposeSrc.Items(i))
                lvbPurposeDest.ClearSelection()
                lvbPurposeSrc.Items.Remove(lvbPurposeSrc.Items(i))
            End If
        Next
    End Sub

    Protected Sub btnBackR_Click(sender As Object, e As System.EventArgs) Handles btnBackR.Click
        For i As Integer = lvbPurposeDest.Items.Count - 1 To 0 Step -1
            If lvbPurposeDest.Items(i).Selected Then
                lvbPurposeSrc.Items.Add(lvbPurposeDest.Items(i))
                lvbPurposeSrc.ClearSelection()
                lvbPurposeDest.Items.Remove(lvbPurposeDest.Items(i))
            End If
        Next
    End Sub

    Private Sub saveData(ByVal iJFTNCID As Integer,
        ByVal sJFTNCCode As String, ByVal sJFTNCName As String, _
        ByVal sDescription As String, ByVal iLoanType As Integer, _
        ByVal dBookFrom As Date, ByVal dBookTo As Date, _
        ByVal bPastDue As Boolean, ByVal bNewAcc As Boolean, _
        ByVal iTenorFr As Integer, ByVal iTenorTo As Integer, _
        ByVal mPrincipalFr As String, ByVal mPrincipalTo As String, _
        ByVal mDPMin As String, ByVal fDSR As String, _
        ByVal iAge As Integer, ByVal iInsType As Integer, _
        ByVal iCurrencyID As Integer, _
        ByVal bIDExpCheck As Boolean, ByVal iCondition As Integer, _
        ByVal iBPKBSts As Integer, ByVal bEarlyPay As Boolean, _
        ByVal intUSERID As Integer, _
        ByRef dblNEWJFTNCID As String)
        'Optional ByRef dblNEWJFTNCID As String = "0"
        Dim objDB As New DBX
        Try
            Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
            oSQLParam = objDB.ExecSPReturnParam("JFTNCUpdate", _
                objDB.MP("@JFTNCID", Data.SqlDbType.Int, iJFTNCID), _
                objDB.MP("@JFTNCCODE", Data.SqlDbType.VarChar, sJFTNCCode), _
                objDB.MP("@JFTNCNAME", Data.SqlDbType.VarChar, sJFTNCName), _
                objDB.MP("@DESCRIPTION", Data.SqlDbType.VarChar, sDescription), _
                objDB.MP("@LOANTYPE", Data.SqlDbType.Int, iLoanType), _
                objDB.MP("@BOOKINGFROM", Data.SqlDbType.DateTime, dBookFrom), _
                objDB.MP("@BOOKINGTO", Data.SqlDbType.DateTime, dBookTo), _
                objDB.MP("@INCLUDEPASTDUE", Data.SqlDbType.Bit, bPastDue), _
                objDB.MP("@INCLUDENEWACCOUNT", Data.SqlDbType.Bit, bNewAcc), _
                objDB.MP("@OSTENORFROM", Data.SqlDbType.Int, iTenorFr), _
                objDB.MP("@OSTENORTO", Data.SqlDbType.Int, iTenorTo), _
                objDB.MP("@OSPRINCIPALFROM", Data.SqlDbType.Money, mPrincipalFr), _
                objDB.MP("@OSPRINCIPALTO", Data.SqlDbType.Money, mPrincipalTo), _
                objDB.MP("@DPMINIMUM", Data.SqlDbType.Money, mDPMin), _
                objDB.MP("@DSR", Data.SqlDbType.Float, fDSR), _
                objDB.MP("@AGE", Data.SqlDbType.Int, iAge), _
                objDB.MP("@INSTALLMENTTYPE", Data.SqlDbType.Int, iInsType), _
                objDB.MP("@CURRENCYID", Data.SqlDbType.Int, iCurrencyID), _
                objDB.MP("@IDEXPIREDCHECKING", Data.SqlDbType.Bit, bIDExpCheck), _
                objDB.MP("@CONDITION", Data.SqlDbType.Int, iCondition), _
                objDB.MP("@BPKBSTATUS", Data.SqlDbType.Int, iBPKBSts), _
                objDB.MP("@INCLUDEEARLYPAY", Data.SqlDbType.Bit, bEarlyPay), _
                objDB.MP("@UserId", Data.SqlDbType.Int, intUSERID), _
                objDB.MP("@NEWJFTNCID", Data.SqlDbType.Int, dblNEWJFTNCID, Data.ParameterDirection.InputOutput) _
            )
            dblNEWJFTNCID = oSQLParam("@NEWJFTNCID").Value.ToString()
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        Dim objParam As New Param_JFTNC
        Dim objDB As New DBX
        Dim strNewJFTNCID As String = hidJFTNCID.Value
        Try
            Dim bPastDue As Boolean
            If rbPastDueInclude.Checked = True Then
                bPastDue = True
            Else
                bPastDue = False
            End If

            Dim bNewAcc As Boolean
            If rbNewAccountInclude.Checked = True Then
                bNewAcc = True
            Else
                bNewAcc = False
            End If

            Dim bIDExpCheck As Boolean
            If rbIDInclude.Checked = True Then
                bIDExpCheck = True
            Else
                bIDExpCheck = False
            End If

            Dim bEarlyPay As Boolean
            If rbEarlyInclude.Checked = True Then
                bEarlyPay = True
            Else
                bEarlyPay = False
            End If


            objParam.saveData(hidJFTNCID.Value, txtTNCCode.Text, txtTNCName.Text, txtDescription.Text,
                              ddlLoanTypeSearch.SelectedValue, ConvertDate(txtBookFrom.Text), ConvertDate(txtBookTo.Text), bPastDue,
                              bNewAcc, txtTenorFrom.Text, txtTenorTo.Text, txtPrincipalFrom.Text, txtPrincipalTo.Text,
                              txtDPMin.Text, txtDSR.Text, txtAge.Text, ddlInstallmentTypeSearch.SelectedValue,
                              ddlCurrencySearch.SelectedValue, bIDExpCheck, ddlCondition.SelectedIndex, ddlBPKBStatus.SelectedValue,
                              bEarlyPay, Request.Cookies("UID").Value, strNewJFTNCID)


            Dim iRow As Integer
            Dim iRows As Integer

            'objDB.ExecSQLWithParam("Update dbo.JFTNCBRANCH SET LASTUSERID=@UID1, LASTUPDATE=GETDATE() WHERE JFTNCID=@UID2",
            '              objDB.MP("@UID1", Data.SqlDbType.Int, Request.Cookies("UID").Value),
            '              objDB.MP("@UID2", Data.SqlDbType.Int, hidJFTNCID.Value)
            '              )
            'iRows = lvbBrchDest.Items.Count - 1
            'For iRow = 0 To iRows
            '    SaveBranch(hidJFTNCID.Value, lvbBrchDest.Items.Item(iRow).Value)
            'Next

            'objDB.ExecSQLWithParam("Update dbo.JFTNCFINCAT SET LASTUSERID=@UID1, LASTUPDATE=GETDATE() WHERE JFTNCID=@UID2",
            '              objDB.MP("@UID1", Data.SqlDbType.Int, Request.Cookies("UID").Value),
            '              objDB.MP("@UID2", Data.SqlDbType.Int, hidJFTNCID.Value)
            '              )
            'iRows = lvbFinCatDest.Items.Count - 1
            'For iRow = 0 To iRows
            '    SaveFinCat(hidJFTNCID.Value, lvbFinCatDest.Items.Item(iRow).Value)
            'Next

            'objDB.ExecSQLWithParam("Update dbo.JFTNCPRODUCT SET LASTUSERID=@UID1, LASTUPDATE=GETDATE() WHERE JFTNCID=@UID2",
            '              objDB.MP("@UID1", Data.SqlDbType.Int, Request.Cookies("UID").Value),
            '              objDB.MP("@UID2", Data.SqlDbType.Int, hidJFTNCID.Value)
            '              )
            'iRows = lvbProductDest.Items.Count.ToString - 1
            'For iRow = 0 To iRows
            '    SaveProduct(hidJFTNCID.Value, lvbProductDest.Items.Item(iRow).Value)
            'Next

            'objDB.ExecSQLWithParam("Update dbo.JFTNCPURPOSECAT SET LASTUSERID=@UID1, LASTUPDATE=GETDATE() WHERE JFTNCID=@UID2",
            '              objDB.MP("@UID1", Data.SqlDbType.Int, Request.Cookies("UID").Value),
            '              objDB.MP("@UID2", Data.SqlDbType.Int, hidJFTNCID.Value)
            '              )
            'iRows = lvbPurposeDest.Items.Count.ToString - 1
            'For iRow = 0 To iRows
            '    SavePurposeCat(hidJFTNCID.Value, lvbPurposeDest.Items.Item(iRow).Value)
            'Next

            Dim intRetVal As Integer

            objDB.ExecSQLWithParam("DELETE dbo.JFTNCBRANCH WHERE JFTNCID=@JFTNCID",
                          objDB.MP("@JFTNCID", Data.SqlDbType.Int, hidJFTNCID.Value)
                          )
            iRows = lvbBrchDest.Items.Count.ToString - 1
            For iRow = 0 To iRows

                intRetVal = objDB.ExecSPReturnInteger("JFTNCBRANCHSave", _
                        objDB.MP("@JFTNCID", Data.SqlDbType.Int, hidJFTNCID.Value), _
                        objDB.MP("@BRANCHID", Data.SqlDbType.Int, lvbBrchDest.Items.Item(iRow).Value), _
                        objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value) _
                )
            Next

            objDB.ExecSQLWithParam("DELETE dbo.JFTNCFINCAT WHERE JFTNCID=@JFTNCID",
                           objDB.MP("@JFTNCID", Data.SqlDbType.Int, hidJFTNCID.Value)
                           )
            iRows = lvbFinCatDest.Items.Count - 1
            For iRow = 0 To iRows

                intRetVal = objDB.ExecSPReturnInteger("JFTNCFINCATSave", _
                        objDB.MP("@JFTNCID", Data.SqlDbType.Int, hidJFTNCID.Value), _
                        objDB.MP("@FINCATID", Data.SqlDbType.Int, lvbFinCatDest.Items.Item(iRow).Value), _
                        objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value) _
                )
            Next

            objDB.ExecSQLWithParam("DELETE dbo.JFTNCPRODUCT WHERE JFTNCID=@JFTNCID",
                           objDB.MP("@JFTNCID", Data.SqlDbType.Int, hidJFTNCID.Value)
                           )
            iRows = lvbProductDest.Items.Count.ToString - 1
            For iRow = 0 To iRows

                intRetVal = objDB.ExecSPReturnInteger("JFTNCPRODUCTSave", _
                        objDB.MP("@JFTNCID", Data.SqlDbType.Int, hidJFTNCID.Value), _
                        objDB.MP("@PRODUCTID", Data.SqlDbType.Int, lvbProductDest.Items.Item(iRow).Value), _
                        objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value) _
                )
            Next

            objDB.ExecSQLWithParam("DELETE dbo.JFTNCPURPOSECAT WHERE JFTNCID=@JFTNCID",
                           objDB.MP("@JFTNCID", Data.SqlDbType.Int, hidJFTNCID.Value)
                           )
            iRows = lvbPurposeDest.Items.Count.ToString - 1
            For iRow = 0 To iRows

                intRetVal = objDB.ExecSPReturnInteger("JFTNCPURPOSECATSave", _
                        objDB.MP("@JFTNCID", Data.SqlDbType.Int, hidJFTNCID.Value), _
                        objDB.MP("@PURPOSECATID", Data.SqlDbType.Int, lvbPurposeDest.Items.Item(iRow).Value), _
                        objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value) _
                )
            Next

            lblError.Visible = True
            If intRetVal = -1 Then
                lblError.Text = "SAVE TERM AND CONDITION FAILED...!<BR>COLLECTOR GROUP DETAIL ALREADY ENTRY...!"
                btnSave.Visible = False
            Else
                lblError.Text = "TERM And CONDITION HAVE BEEN SAVE SUCCEFULLY..!"

            End If

            DataSearch()
            pnlTNC.Visible = False

            DataSearch()
            lblError.Text = ""
            lblError.Visible = False
            gvData.SelectedIndex = -1

        Catch ex As Exception
            lblError.Visible = True
            lblError.Text = "ERROR Save Term and Condition..!<br>Please check detail error message : " & ex.Message
            lblError.Focus()
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As System.EventArgs) Handles btnCancel.Click
        pnlTNC.Visible = False
    End Sub
    Protected Sub btnDelete_Click(sender As Object, e As System.EventArgs) Handles btnDelete.Click
        Dim objDB As New DBX
        Dim oSDR As Data.SqlClient.SqlDataReader
        Try
            oSDR = objDB.CreateSDRFromExecSQL("Update dbo.JFTNC SET DeleteSTS=1 WHERE JFTNCID=" & hidJFTNCID.Value)
            If oSDR.Read() Then
            End If
            DataSearch()
            pnlTNC.Visible = False
        Catch ex As Exception
            lblError.Visible = True
            lblError.Text = "ERROR DELETE DATA TnC: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            lblError.Visible = False
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
End Class
