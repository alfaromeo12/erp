Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Data
Imports System.Data.SqlClient
Partial Class Param_Collector
    Inherits System.Web.UI.Page
    Public Shared strCollTitleType As String
    Public Shared strOptLoginUser As String
    Public Shared strRowLogin As String
    Public Shared strddlCollUser As String
    Public Shared strtxtCollCodeUser As String
    Public Shared strRbUserYes As String
    Public Shared strRbUserNo As String
    Public Shared strddlColTitleType As String
    Public Shared iError As Integer = 0
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            pnlCollectorData.Visible = False
            pnlCollectorShow.Visible = False
            hidAction.Value = "LOAD"
            DataSearch("1")

        End If
        SetValidation()
    End Sub
    Private Sub SetValidation()
        'rbUseLogin_no.Attributes.Add("onchange", "CheckType()")
        ddlCollType.Attributes.Add("onchange", "CheckCoverageArea(),checkType(1)")
        ddlColTitleType.Attributes.Add("onchange", "CheckCoverageArea()")
        SetObjectValidation(txtAddress, False, "uppercase")
        SetObjectValidation(txtCollCodeUser, False, "uppercase nospace")
        SetObjectValidation(txtCollTitleName, False, "uppercase")
        SetObjectValidation(txtMobile, False, "uppercase")
        SetObjectValidation(txtPhone, False, "uppercase")
        SetObjectValidation(txtZip, False, "uppercase")
        rbUseLogin_yes.Attributes.Add("onchange", "checkFlag()")
        rbUseLogin_no.Attributes.Add("onchange", "checkFlag()")

    End Sub
    Protected Sub Page_PreInit(sender As Object, e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub
    Protected Sub btnNew_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        hidAction.Value = "NEW"
        lblError.Visible = False
        btnDelete.Visible = False
        pnlCollectorData.Visible = True
        pnlCollectorShow.Visible = True
        gvData.SelectedIndex = -1
        pnlControl.Visible = True
        chkAdd.Checked = True
        btnSave.Text = "Save"
        Validation.ClearPanelAplicationField(pnlCollectorData)
        Validation.ClearPanelAplicationField(pnlHandlesData)
        lvbGroupDtl.Items.Clear()
        ajaxCCDType.SelectedValue = -1
        ajaxCDDTitleType.SelectedValue = -1
        SetValidation()
        ddlCollType.Focus()
    End Sub


    Protected Sub gvData_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvData.PageIndexChanged
        DataSearch()
    End Sub

    Protected Sub gvData_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        lblError.Visible = False
        If e.CommandName = "Select" Then
            gvData.SelectedIndex = e.CommandArgument
            lblCollectID.Value = gvData.SelectedDataKey("COLLECTORID")
            GetData(lblCollectID.Value)
            hidAction.Value = "EDIT"
            pnlControl.Visible = True
            chkAdd.Checked = False
            btnSave.Text = "Update"
            pnlCollectorData.Visible = True
            pnlCollectorShow.Visible = True

            btnDelete.Visible = True
        End If
    End Sub
    Private Sub GetData(ByVal strKey As String)
        Dim objDB As New DBX
        Try

            Dim oSDR As System.Data.SqlClient.SqlDataReader
            Dim oSDRCheck As System.Data.SqlClient.SqlDataReader

            ''REFRESH DULU DATA
            ddlCollHead.DataBind()
            ddlCollUser.DataBind()
            ddlCollGroup.DataBind()
            ddlCollDPD.DataBind()

            oSDR = objDB.CreateSDRFromSQLSelect("SELECT  * " & _
              "  FROM dbo.COLLECTOR WITH(NOLOCK) WHERE COLLECTORID=" & strKey)
            If oSDR.Read() Then

                lblCollectorID.Text = oSDR("COLLECTORID")
                ajaxCCDType.SelectedValue = oSDR("COLLECTORTYPE").ToString()
                ajaxCDDTitleType.SelectedValue = oSDR("COLLECTORTITLEID").ToString()
                hidCollectorType.Value = ajaxCCDType.SelectedValue

                If oSDR("USERLOGIN") = True Then
                    rbUseLogin_yes.Checked = True
                    rbUseLogin_no.Checked = False

                    If Not String.IsNullOrEmpty(oSDR("COLLECTORCODE").ToString()) Then
                        oSDRCheck = objDB.CreateSDRFromSQLSelect("SELECT USERID FROM APPUSER WITH(NOLOCK) WHERE USERID='" & oSDR("COLLECTORCODE") & "' AND APPUSER.DELETESTS=0")
                        If oSDRCheck.HasRows() Then
                            ddlCollUser.SelectedValue = oSDR("COLLECTORCODE")
                        End If
                        oSDRCheck.Close()
                        oSDRCheck = Nothing
                    End If
                Else
                    rbUseLogin_yes.Checked = False
                    rbUseLogin_no.Checked = True
                    txtCollCodeUser.Text = oSDR("COLLECTORCODE").ToString()
                End If

                txtCollTitleName.Text = oSDR("COLLECTORNAME").ToString()


                If Not String.IsNullOrEmpty(oSDR("HEADID").ToString()) Then
                    oSDRCheck = objDB.CreateSDRFromSQLSelect("SELECT COLLECTOR.COLLECTORID FROM COLLECTOR WITH(NOLOCK) INNER JOIN COLLECTORTITLE ON COLLECTOR.COLLECTORTITLEID=COLLECTORTITLE.COLLECTORTITLEID WHERE COLLECTOR.DELETESTS=0 AND COLLECTORTITLE.SUPERVISOR=1 AND COLLECTOR.COLLECTORID=" & oSDR("HEADID").ToString())
                    If oSDRCheck.HasRows() Then
                        ddlCollHead.SelectedValue = oSDR("HEADID").ToString()
                    End If
                    oSDRCheck.Close()
                    oSDRCheck = Nothing
                End If

                If Not String.IsNullOrEmpty(oSDR("COLLGROUPID").ToString()) Then
                    oSDRCheck = objDB.CreateSDRFromSQLSelect("SELECT COLLGROUPID FROM COLLECTORGROUP WITH(NOLOCK) WHERE COLLGROUPID='" & oSDR("COLLGROUPID") & "' AND DELETESTS=0")
                    If oSDRCheck.HasRows() Then
                        ddlCollGroup.SelectedValue = oSDR("COLLGROUPID").ToString()
                    End If
                    oSDRCheck.Close()
                    oSDRCheck = Nothing
                End If


                If Not String.IsNullOrEmpty(oSDR("COLLECTORDPDID").ToString()) Then
                    oSDRCheck = objDB.CreateSDRFromSQLSelect("SELECT COLLECTORDPDID FROM COLLECTORDPD WITH(NOLOCK) WHERE COLLECTORDPDID='" & oSDR("COLLECTORDPDID") & "' AND DELETESTS=0")
                    If oSDRCheck.HasRows() Then
                        ddlCollDPD.SelectedValue = oSDR("COLLECTORDPDID").ToString()
                    End If
                    oSDRCheck.Close()
                    oSDRCheck = Nothing
                End If

                txtAddress.Text = oSDR("ADDRESS").ToString()
                If Not String.IsNullOrEmpty(oSDR("CITYID").ToString()) Then
                    oSDRCheck = objDB.CreateSDRFromSQLSelect("SELECT CITYID FROM CITY WITH(NOLOCK) WHERE CITYID='" & oSDR("CITYID") & "' AND DELETESTS=0")
                    If oSDRCheck.HasRows() Then
                        ddlCity.SelectedValue = oSDR("CITYID").ToString()
                    End If
                    oSDRCheck.Close()
                    oSDRCheck = Nothing
                End If

                txtZip.Text = oSDR("ZIP").ToString()
                txtPhone.Text = oSDR("PHONENO").ToString()
                txtMobile.Text = oSDR("MOBILENO").ToString()
                txtEmail.Text = oSDR("EMAIL").ToString()

                Dim oSDRColl As System.Data.SqlClient.SqlDataReader
                oSDRColl = objDB.CreateSDRFromSQLSelect("SELECT  * " & _
                " FROM COLLECTORCOVERAGE CV WITH(NOLOCK) " & _
                "INNER JOIN COLLECTORAREA CR WITH(NOLOCK) ON CR.COLLECTORAREAID=CV.COLLECTORAREAID " & _
                "WHERE CV.COLLECTORID= " & strKey & " AND CR.Deletests=0")
                If oSDRColl.Read Then
                    pnlCoverageShow.Visible = True
                    pnlCollectorData.Visible = True
                    pnlCoverageAreaData.Visible = True
                    pnlCollectorShow.Visible = True
                    lvbGroupDtl.DataBind()
                End If
                oSDRColl.Close()
                oSDRColl = Nothing

                oSDRColl = objDB.CreateSDRFromSQLSelect("SELECT  * " & _
                "  FROM dbo.COLLECTORMAXHANDLE WITH(NOLOCK) WHERE COLLECTORID=" & strKey & " AND Deletests=0")
                If oSDRColl.Read Then
                    pnlHandlesShow.Visible = True
                    pnlHandlesData.Visible = True
                    GvwHandles.DataBind()
                End If
                oSDRColl.Close()
                oSDRColl = Nothing
            Else
                lblMessage.Visible = True
                lblMessage.Text = "COLLECTOR " & strKey & " DOEST NOT EXIST..!"
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RETRIVE DATA (COLLECTOR) ENTRY: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub


    Protected Sub btnFunctionSearch_Click(sender As Object, e As System.EventArgs) Handles btnFunctionSearch.Click
        DataSearch()
        hidAction.Value = "SEARCH"
        lblError.Visible = False
    End Sub

    Private Sub DataSearch(Optional ByVal sOpt As String = "0")
        If Not IsPostBack() Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND CT.COLLECTORID=-999"
        End If
        If sOpt = "1" Or txtSearch.Text = "" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand
        End If
        If Len(Trim(txtSearch.Text)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''"), "'", "''") + "%'" & ""
        End If
        If Len(Trim(ddlCollectType.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND CT.COLLECTORTYPE=" & ddlCollectType.SelectedValue
        End If
        If Len(Trim(ddlCollectorTitleSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND CT.COLLECTORTITLEID=" & ddlCollectorTitleSearch.SelectedValue
        End If
        gvData.DataBind()
    End Sub

    Private Sub EditData(ByVal iCollectorID As String,
                         ByVal iUserLogin As Boolean,
                         ByVal sCollectorCd As String,
                         ByVal sCollectorNm As String,
                         ByVal iCollectorType As String,
                         ByVal iCollectorTitleId As String,
                         ByVal iHeadId As String,
                         ByVal iCollectGrpId As String,
                         ByVal iCollectDpdId As String,
                         ByVal sAddress As String,
                         ByVal iCityId As String,
                         ByVal sZip As String,
                         ByVal sPhone As String,
                         ByVal sMobile As String,
                         ByVal sEmail As String,
                         ByVal sUserId As String)
        Dim objDB As New DBX
        Dim intRetVal As Integer
        Dim intCollectID As Integer = iCollectorID
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try
            oSQLParam = objDB.ExecSPReturnParam("COLLECTORUpdate", _
                      objDB.MP("@COLLECTORID", Data.SqlDbType.Int, intCollectID), _
                      objDB.MP("@USERLOGIN", Data.SqlDbType.Bit, iUserLogin), _
                      objDB.MP("@COLLECTORCODE", Data.SqlDbType.VarChar, sCollectorCd), _
                      objDB.MP("@COLLECTORNAME", Data.SqlDbType.VarChar, sCollectorNm), _
                      objDB.MP("@COLLECTORTYPE", Data.SqlDbType.TinyInt, iCollectorType), _
                      objDB.MP("@COLLECTORTITLEID", Data.SqlDbType.Int, iCollectorTitleId), _
                      objDB.MP("@HEADID", Data.SqlDbType.BigInt, iHeadId), _
                      objDB.MP("@COLLGROUPID", Data.SqlDbType.Int, iCollectGrpId), _
                      objDB.MP("@COLLECTORDPDID", Data.SqlDbType.Int, iCollectDpdId), _
                      objDB.MP("@ADDRESS", Data.SqlDbType.VarChar, sAddress), _
                      objDB.MP("@CITYID", Data.SqlDbType.Int, iCityId), _
                      objDB.MP("@ZIP", Data.SqlDbType.VarChar, sZip), _
                      objDB.MP("@PHONENO", Data.SqlDbType.VarChar, sPhone), _
                      objDB.MP("@MOBILENO", Data.SqlDbType.VarChar, sMobile), _
                      objDB.MP("@EMAIL", Data.SqlDbType.VarChar, sEmail), _
                      objDB.MP("@USERID", Data.SqlDbType.BigInt, sUserId), _
                      objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 10, Data.ParameterDirection.Output) _
                       )
            intRetVal = oSQLParam("@RETVAL").Value.ToString()
            lblCollectID.Value = intCollectID
            If intRetVal = -1 Then
                lblMessage.Visible = True
                lblMessage.Text = "COLLECTOR CODE " & sCollectorCd & " ALREADY EXIST..!"
                iError = 1
            Else
                lblMessage.Text = ""
                lblMessage.Visible = False
                iError = 0

            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR UPDATE COLLECTOR: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub
    Private Sub SaveData(ByVal iUserLogin As Boolean,
                         ByVal sCollectorCd As String,
                         ByVal sCollectorNm As String,
                         ByVal iCollectorType As String,
                         ByVal iCollectorTitleId As String,
                         ByVal iHeadId As String,
                         ByVal iCollectGrpId As String,
                         ByVal iCollectDpdId As String,
                         ByVal sAddress As String,
                         ByVal iCityId As String,
                         ByVal sZip As String,
                         ByVal sPhone As String,
                         ByVal sMobile As String,
                         ByVal sEmail As String,
                         ByVal sUserId As String)
        Dim objDB As New DBX
        Dim intRetVal As Integer
        Dim intCollectID As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection

        Try

            oSQLParam = objDB.ExecSPReturnParam("COLLECTORAdd", _
                   objDB.MP("@USERLOGIN", Data.SqlDbType.Bit, iUserLogin), _
                   objDB.MP("@COLLECTORCODE", Data.SqlDbType.VarChar, sCollectorCd), _
                   objDB.MP("@COLLECTORNAME", Data.SqlDbType.VarChar, sCollectorNm), _
                   objDB.MP("@COLLECTORTYPE", Data.SqlDbType.TinyInt, iCollectorType), _
                   objDB.MP("@COLLECTORTITLEID", Data.SqlDbType.Int, iCollectorTitleId), _
                   objDB.MP("@HEADID", Data.SqlDbType.BigInt, iHeadId), _
                   objDB.MP("@COLLGROUPID", Data.SqlDbType.Int, iCollectGrpId), _
                   objDB.MP("@COLLECTORDPDID", Data.SqlDbType.Int, iCollectDpdId), _
                   objDB.MP("@ADDRESS", Data.SqlDbType.VarChar, sAddress), _
                   objDB.MP("@CITYID", Data.SqlDbType.Int, iCityId), _
                   objDB.MP("@ZIP", Data.SqlDbType.VarChar, sZip), _
                   objDB.MP("@PHONENO", Data.SqlDbType.VarChar, sPhone), _
                   objDB.MP("@MOBILENO", Data.SqlDbType.VarChar, sMobile), _
                   objDB.MP("@EMAIL", Data.SqlDbType.VarChar, sEmail), _
                   objDB.MP("@USERID", Data.SqlDbType.BigInt, sUserId), _
                   objDB.MP("@COLLECTORID", Data.SqlDbType.Int, intCollectID, 10, Data.ParameterDirection.Output), _
                   objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 10, Data.ParameterDirection.Output) _
                    )
            If Not IsDBNull(oSQLParam("@COLLECTORID").Value) Then
                intCollectID = oSQLParam("@COLLECTORID").Value
            End If
            intRetVal = oSQLParam("@RETVAL").Value.ToString()
            lblCollectID.Value = intCollectID
            If intRetVal = -1 Then
                lblMessage.Visible = True
                lblMessage.Text = "COLLECTOR " & sCollectorCd & " ALREADY ALREADY EXIST..!"
                iError = 1
            Else
                lblMessage.Text = ""
                lblMessage.Visible = False
                iError = 0
                hidAction.Value = "SAVE"
            End If


        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE DATA COLLECTOR: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnMove_Click(sender As Object, e As System.EventArgs) Handles btnMove.Click
        For i As Integer = lvbGroup.Items.Count - 1 To 0 Step -1
            If lvbGroup.Items(i).Selected Then
                lvbGroupDtl.Items.Add(lvbGroup.Items(i))
                lvbGroupDtl.ClearSelection()
                lvbGroup.Items.Remove(lvbGroup.Items(i))
            End If
        Next
        hidCollectorType.Value = ddlCollType.SelectedValue
        '  Response.Write("Coll type =" + hidCollectorType.Value)
    End Sub

    Protected Sub btnBack_Click(sender As Object, e As System.EventArgs) Handles btnBack.Click
        For i As Integer = lvbGroupDtl.Items.Count - 1 To 0 Step -1
            If lvbGroupDtl.Items(i).Selected Then
                lvbGroup.Items.Add(lvbGroupDtl.Items(i))
                lvbGroup.ClearSelection()
                lvbGroupDtl.Items.Remove(lvbGroupDtl.Items(i))
            End If
        Next
        hidCollectorType.Value = ddlCollType.SelectedValue
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        lblMessage.Text = ""
        lblMessage.Visible = False
        Dim bLogin As Boolean
        Dim objDB As New DBX
        Dim iRow As Integer
        Dim iRows As Integer
        Dim sCollCode As String = ""

        'If rbUseLogin_yes.Checked Then
        '    sCollCode = ddlCollUser.SelectedValue
        '    bLogin = 1
        'Else
        '    sCollCode = txtCollCodeUser.Text.Trim
        '    bLogin = 0
        'End If
        Try
            If Len(Trim(ddlCollUser.SelectedValue)) > 0 Then
                bLogin = 1
                sCollCode = ddlCollUser.SelectedValue
            Else
                bLogin = 0
                sCollCode = txtCollCodeUser.Text.Trim
            End If

            If chkAdd.Checked Then
                SaveData(bLogin,
                          sCollCode, txtCollTitleName.Text.ToString, ddlCollType.SelectedValue.ToString,
                         ddlColTitleType.SelectedValue.ToString, ddlCollHead.SelectedValue.ToString, ddlCollGroup.SelectedValue.ToString,
                         ddlCollDPD.SelectedValue.ToString, txtAddress.Text.Trim, ddlCity.SelectedValue.ToString, txtZip.Text.Trim,
                         txtPhone.Text.Trim, txtMobile.Text.Trim, txtEmail.Text.Trim, Request.Cookies("UID").Value)
            Else

                EditData(lblCollectID.Value, bLogin,
                        sCollCode, txtCollTitleName.Text.ToString, ddlCollType.SelectedValue,
                        ddlColTitleType.SelectedValue, ddlCollHead.SelectedValue, ddlCollGroup.SelectedValue,
                        ddlCollDPD.SelectedValue, txtAddress.Text.Trim, ddlCity.SelectedValue, txtZip.Text.Trim,
                        txtPhone.Text.Trim, txtMobile.Text.Trim, txtEmail.Text.Trim, Request.Cookies("UID").Value)
            End If
            If iError = 0 Then
                objDB.ExecSQLWithParam("Update dbo.COLLECTORCOVERAGE SET DeleteSTS=1 WHERE COLLECTORID=@COLLECTORID",
                            objDB.MP("@COLLECTORID", SqlDbType.Int, lblCollectID.Value))

                If pnlCoverageAreaData.Visible = True Then
                    iRows = lvbGroupDtl.Items.Count.ToString - 1
                    For iRow = 0 To iRows
                        SaveCoverageArea(lblCollectID.Value, lvbGroupDtl.Items.Item(iRow).Value)
                    Next
                End If

                objDB.ExecSQLWithParam("Update dbo.COLLECTORMAXHANDLE SET DeleteSTS=1 WHERE COLLECTORID=@COLLECTORID",
                            objDB.MP("@COLLECTORID", SqlDbType.Int, lblCollectID.Value))
                iRows = GvwHandles.Rows.Count - 1
                If iRows >= 0 Then
                    iRows = GvwHandles.Rows.Count - 1
                    For iRow = 0 To iRows
                        Dim iMaxHandled As Integer = DirectCast(GvwHandles.Rows(iRow).FindControl("txtMaxHandled"), TextBox).Text
                        Dim iMaxTarget As Integer = DirectCast(GvwHandles.Rows(iRow).FindControl("txtMaxTarget"), TextBox).Text
                        SaveMaxHandles(lblCollectID.Value, (CType(GvwHandles.Rows(iRow).FindControl("lblCollKey"), Label).Text),
                                      iMaxHandled, iMaxTarget)
                    Next
                End If
                hidAction.Value = "SAVE"
            Else
                hidAction.Value = "ERROR"
            End If
            hidCollectorType.Value = ddlCollType.SelectedValue
            DataSearch()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE COLLECTOR..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE : " & ex.Message
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Private Sub SaveCoverageArea(ByVal iCollectorId As Integer,
                             ByVal iCollectorAreaId As Integer)

        Dim objDB As New DBX
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try

            oSQLParam = objDB.ExecSPReturnParam("COLLECTORCOVERAGESave", _
                   objDB.MP("@COLLECTORID", Data.SqlDbType.BigInt, iCollectorId), _
                   objDB.MP("@COLLECTORAREAID", Data.SqlDbType.Int, iCollectorAreaId), _
                   objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value))
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE DATA COVERAGE AREA: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            lblMessage.Visible = False
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Private Sub SaveMaxHandles(ByVal iCollectorId As Integer,
                               ByVal iCollectorActivityId As Integer,
                               ByVal iMaxHandle As String,
                               ByVal iTarget As String)
        Dim objDB As New DBX
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try

            oSQLParam = objDB.ExecSPReturnParam("COLLECTORMAXHANDLESave", _
                   objDB.MP("@COLLECTORID", Data.SqlDbType.BigInt, iCollectorId), _
                   objDB.MP("@COLLECTORACTIVITYID", Data.SqlDbType.TinyInt, iCollectorActivityId), _
                   objDB.MP("@MAXHANDLE", Data.SqlDbType.Int, iMaxHandle), _
                   objDB.MP("@TARGET", Data.SqlDbType.Int, iTarget), _
                   objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value))
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR SAVE DATA MAX HANDLES: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            lblMessage.Visible = False
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub


    Protected Sub ddlCollType_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlCollType.SelectedIndexChanged
        hidCollectorType.Value = ddlCollType.SelectedValue

        If gvData.SelectedIndex = -1 Then
            sdsCollArea.SelectParameters("COLLECTORID").DefaultValue = 0
        Else
            sdsCollArea.SelectParameters("COLLECTORID").DefaultValue = gvData.DataKeys.Item(1).Value
        End If
        If chkAdd.Checked Then
            hidAction.Value = "NEW"
        Else
            hidAction.Value = "EDIT"
        End If

        lvbGroup.DataBind()
        GvwHandles.DataBind()
    End Sub

    Protected Sub btnDelete_Click(sender As Object, e As System.EventArgs) Handles btnDelete.Click
        lblMessage.Text = ""
        lblMessage.Visible = False
        Dim objDB As New DBX
        Try
            hidAction.Value = "DELETE"
            objDB.ExecSQLWithParam("Update dbo.COLLECTOR SET DeleteSTS=1, lastupdate=getdate(), lastuserID=@USERID WHERE COLLECTORID=@COLLECTORID",
                objDB.MP("@USERID", SqlDbType.Int, Request.Cookies("UI").Value),
                objDB.MP("@COLLECTORID", SqlDbType.Int, lblCollectID.Value)
                )
            pnlControl.Visible = False
            DataSearch()
            pnlData.Visible = True
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR DELETE DATA COLLECTOR: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            lblMessage.Focus()
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As System.EventArgs) Handles btnCancel.Click
        lblCollectID.Value = ""
        hidAction.Value = "LOAD"
    End Sub

    Protected Sub GvwHandles_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GvwHandles.RowDataBound
        Dim oTextBox As TextBox
        For Each row As GridViewRow In GvwHandles.Rows
            oTextBox = CType(row.FindControl("txtMaxHandled"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "integer", "[0-9]")
                If Len(Trim(oTextBox.Text)) <= 0 Then
                    oTextBox.Text = "0"
                End If
            End If
            oTextBox = CType(row.FindControl("txtMaxTarget"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "integer", "[0-9]")
                If Len(Trim(oTextBox.Text)) <= 0 Then
                    oTextBox.Text = "0"
                End If
            End If
        Next
    End Sub

  
    Protected Sub gvData_Sorted(sender As Object, e As System.EventArgs) Handles gvData.Sorted
        DataSearch()
    End Sub

    Protected Sub ddlCollectType_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlCollectType.SelectedIndexChanged
        DataSearch()
    End Sub

    Protected Sub ddlCollectorTitleSearch_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlCollectorTitleSearch.SelectedIndexChanged
        DataSearch()
    End Sub
End Class
