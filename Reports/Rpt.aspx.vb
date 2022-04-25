Imports System.Linq
Partial Class Reports_Rpt
    Inherits System.Web.UI.Page
    Public strModulID As String, strParamID As String, strReportID As String, strExport As String, strReportType As String, strReportFileName As String
    Public strAction As String

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Dim strPathInfo As String = Request.ServerVariables("PATH_INFO")
        'Dim strFolderReport As String = Server.MapPath(Mid(strPathInfo, 1, InStr(2, strPathInfo, "/")))
        ''Response.Write(strFolderReport)
        ''Response.End()

        ''testing report export
        'Dim strfilexported As String = ""
        'Dim objExport As New CRExport
        'objExport.CRExport(strFolderReport & "\Printing\Welcoming_Letter_AccID.rpt", "0|18878", strFolderReport, Session.SessionID, "PDF", strfilexported)
        'objExport = Nothing
        'Response.Write(strfilexported)
        'Response.End()

        Dim strURL As String = ""
        strModulID = Request.QueryString("ModulID")
        strParamID = Request.QueryString("ParamID")
        strAction = Request.QueryString("Action")
        'strExport = Request.QueryString("EXPORT")


        If Request.QueryString("Action") = "Report" Then
            strReportID = Request.QueryString("ReportID")
            Dim strParam As String = ""
            Dim objDB As New DBX
            Dim oSDR As System.Data.SqlClient.SqlDataReader

            oSDR = objDB.CreateSDRFromSQLSelect("SELECT REPORTTYPE,FILENAME FROM rptList WITH(NOLOCK) WHERE ReportId=" & strReportID)
            If oSDR.Read Then
                strReportType = oSDR("REPORTTYPE").ToString
                strReportFileName = oSDR("FILENAME").ToString
            End If
            oSDR.Close()
            oSDR = Nothing

            If strReportType = "1" Then ' Reporting Services
                If Len(Trim(strParamID)) > 0 Then
                    oSDR = objDB.CreateSDRFromSQLSelect("SELECT FieldName, FieldDataType FROM rptParamDetail WITH(NOLOCK) WHERE ParamID=" & strParamID & " ORDER BY ID")
                    While oSDR.Read
                        If oSDR("FieldDataType").ToString = "3" Then
                            strParam = strParam & "&" & oSDR("FieldName").ToString & "=" & ConvertDateToYMD(Request.Form("ctl00$cphMain$" & oSDR("FieldName").ToString))
                        Else
                            strParam = strParam & "&" & oSDR("FieldName").ToString & "=" & Request.Form("ctl00$cphMain$" & oSDR("FieldName").ToString)
                        End If
                    End While
                    oSDR.Close()
                    oSDR = Nothing
                End If

                strExport = Request.Form("ctl00$cphMain$ddlExport")
                strURL = "ReportView.aspx?ReportID=" & strReportID & "&ParamID=" & strParamID & strParam & "&EXPORT=" & strExport
                Response.Redirect(strURL)
            Else ' Crystal Report
                If Len(Trim(strParamID)) > 0 Then
                    oSDR = objDB.CreateSDRFromSQLSelect("SELECT FieldName, FieldDataType FROM rptParamDetail WITH(NOLOCK) WHERE ParamID=" & strParamID & " ORDER BY ID")
                    While oSDR.Read
                        If oSDR("FieldDataType").ToString = "3" Then
                            strParam = strParam & "@" & oSDR("FieldName").ToString & "=" & Request.Form("ctl00$cphMain$" & oSDR("FieldName").ToString)
                        Else
                            strParam = strParam & "@" & oSDR("FieldName").ToString & "=" & Request.Form("ctl00$cphMain$" & oSDR("FieldName").ToString)
                        End If
                    End While
                    oSDR.Close()
                    oSDR = Nothing
                End If
                strURL = "ReportiFrameCR.aspx?Action=" & strReportType & "&Param=" & strParam & "&FileName=" & strReportFileName
                Response.Redirect(strURL)
            End If
            objDB.Close()
            objDB = Nothing
        End If

    End Sub

    Protected Sub ddlParameter_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlParameter.SelectedIndexChanged
        SetInputParam(sender.SelectedValue)
    End Sub

    Private Sub SetInputParam(ByVal strParamID As String)
        pnlParamDetail.Visible = True
        Dim oDropDown As DropDownList
        Dim oTextBox As TextBox
        Dim oLabel As Label
        Dim oLiteral As Literal
        'Dim strParamID As String = ""
        Dim strValidation As String = ""
        Dim strFilter As String = ""
        Dim oImage As Image
        Dim oRequired As RequiredFieldValidator
        Dim oAjaxCalendar As AjaxControlToolkit.CalendarExtender
        Dim oAjaxVCE As AjaxControlToolkit.ValidatorCalloutExtender
        Dim oAjaxMEE As AjaxControlToolkit.MaskedEditExtender
        Dim strURL As String = ""
        Dim oButton As Button
        Dim strWhere As String = ""

        pnlParamDetail.Controls.Clear()

        'Dim oDataSet As System.Data.DataSet

        'oDropDown = CType(sender, DropDownList)
        'If oDropDown IsNot Nothing Then
        'strParamID = oDropDown.SelectedValue
        'End If
        Dim i As Integer = 0
        Dim strCSSClass As String = ""
        strParamID = ddlParameter.SelectedValue
        If Len(Trim(strParamID)) > 0 Then

            Dim objDB As New DBX
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            Dim oSDRCombo As System.Data.SqlClient.SqlDataReader
            Try
                oLiteral = New Literal()
                oLiteral.Text = "<table class='RowStyle' cellpadding=0 cellspacing=0 width='100%'>"
                pnlParamDetail.Controls.Add(oLiteral)

                oSDR = objDB.CreateSDRFromSQLSelect("SELECT * FROM rptParamDetail WHERE ParamID=" & strParamID)
                While oSDR.Read
                    i = i + 1
                    If i Mod 2 = 0 Then
                        strCSSClass = "RowStyle"
                    Else
                        strCSSClass = "AlternatingRowStyle"
                    End If
                    oLiteral = New Literal()
                    strValidation = ""
                    strFilter = ""

                    oLiteral = New Literal()
                    oLiteral.Text = "<tr><td style='width: 126px' class='" & strCSSClass & "'>"
                    pnlParamDetail.Controls.Add(oLiteral)

                    oLabel = New Label()
                    oLabel.ID = "lbl" & oSDR("FieldName").ToString()
                    oLabel.Text = oSDR("PromptText").ToString
                    pnlParamDetail.Controls.Add(oLabel)

                    oLiteral = New Literal()
                    oLiteral.Text = "</td><td class='" & strCSSClass & "'>"
                    pnlParamDetail.Controls.Add(oLiteral)

                    If oSDR("FieldInputType").ToString = "2" Then 'combobox
                        Dim oSDRBrch As System.Data.SqlClient.SqlDataReader
                        oSDRBrch = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE, CAST(dbo.f_IsUserBranch(" & Request.Cookies("UID").Value & ") as VARCHAR(10)) ISUSERBRANCH FROM APPSETTING WITH(NOLOCK) WHERE APPCODE='APPDATE'")
                        If oSDRBrch.Read Then
                            hidIsUserBranch.Value = oSDRBrch("ISUSERBRANCH").ToString()
                        End If
                        oSDRBrch.Close()
                        oSDRBrch = Nothing

                        oDropDown = New DropDownList()
                        oDropDown.ID = oSDR("FieldName").ToString()
                        ' Jika Branch Filter 
                        ' Jika Field Value BranchID
                        ' Jika User Branch
                        If oSDR("BRANCHFILTER") = True _
                                And oSDR("FIELDVALUE").ToString().ToUpper() = "BRANCHID" _
                                And hidIsUserBranch.Value = "1" Then
                            strWhere = "Select APP." & oSDR("FieldValue").ToString() & " as FieldValue, " & oSDR("FieldText").ToString() & " as FieldText from v_ParamBranchWithAll BR "
                            strWhere = strWhere & " Inner Join dbo.f_GetAppUserBranchList(" & Request.Cookies("UID").Value & ") APP on APP.BRANCHID=BR.BRANCHID  ORDER BY BR.BRANCHCODE"

                            ' Jika FINANCE CATEGORY FILTER
                            ' Jika Field Value FINCATID
                            ' Jika User Branch
                        ElseIf oSDR("FINCATFILTER") = True _
                            And oSDR("FIELDVALUE").ToString().ToUpper() = "FINCATID" _
                            And hidIsUserBranch.Value = "1" Then
                            oSDRBrch = objDB.CreateSDRFromSQLSelect("SELECT FINCATID FROM APPUSERFINCAT WHERE UID=" & Request.Cookies("UID").Value)
                            If oSDR.HasRows() Then
                                strWhere = "Select APP." & oSDR("FieldValue").ToString() & " as FieldValue, " & oSDR("FieldText").ToString() & " as FieldText from v_ParamFinanceCategoryWithAll FC "
                                strWhere = strWhere & " Inner Join dbo.f_getAPPUSERFINCATList(" & Request.Cookies("UID").Value & ") APP on APP.FINCATID=FC.FINCATID"
                            Else
                                strWhere = "Select " & oSDR("FieldValue").ToString() & " as FieldValue, " & oSDR("FieldText").ToString() & " as FieldText from " & oSDR("Source").ToString
                                If Not String.IsNullOrEmpty(oSDR("FieldCondition").ToString()) Then
                                    strWhere = strWhere & " WHERE " & oSDR("FieldCondition").ToString()
                                End If
                            End If
                            oSDRBrch.Close()
                            oSDRBrch = Nothing


                        Else
                            strWhere = "Select " & oSDR("FieldValue").ToString() & " as FieldValue, " & oSDR("FieldText").ToString() & " as FieldText from " & oSDR("Source").ToString
                            If Not String.IsNullOrEmpty(oSDR("FieldCondition").ToString()) Then
                                strWhere = strWhere & " WHERE " & oSDR("FieldCondition").ToString()
                            End If
                        End If


                        'If oSDR("FINCATFILTER").ToString = True Then ' Jika Branch Filter 
                        '    If oSDR("FIELDVALUE").ToString().ToUpper() = "FINCATID" Then ' Jika Field Value BranchID
                        '        If hidIsUserBranch.Value = 1 Then ' Jika User Branch
                        '            oSDRBrch = objDB.CreateSDRFromSQLSelect("SELECT BRANCH.BRANCHID, BRANCH.AREAID FROM APPUSER WITH(NOLOCK) INNER JOIN BRANCH ON APPUSER.BRANCHID=BRANCH.BRANCHID WHERE APPUSER.UID=" & Request.Cookies("UID").Value)
                        '            If oSDRBrch.Read() Then
                        '                strWhere = "Select APP." & oSDR("FieldValue").ToString() & " as FieldValue, " & oSDR("FieldText").ToString() & " as FieldText from v_ParamBranchWithAll BR "
                        '                strWhere = strWhere & " Inner Join dbo.f_GetAppUserBranchList(" & Request.Cookies("UID").Value & ") APP on APP.BRANCHID=BR.BRANCHID "

                        '            End If
                        '            oSDRBrch.Close()
                        '            oSDRBrch = Nothing
                        '        Else
                        '            strWhere = "Select " & oSDR("FieldValue").ToString() & " as FieldValue, " & oSDR("FieldText").ToString() & " as FieldText from " & oSDR("Source").ToString
                        '            If Not String.IsNullOrEmpty(oSDR("FieldCondition").ToString()) Then
                        '                strWhere = strWhere & " WHERE " & oSDR("FieldCondition").ToString()
                        '            End If
                        '        End If
                        '    Else
                        '        strWhere = "Select " & oSDR("FieldValue").ToString() & " as FieldValue, " & oSDR("FieldText").ToString() & " as FieldText from " & oSDR("Source").ToString
                        '        If Not String.IsNullOrEmpty(oSDR("FieldCondition").ToString()) Then
                        '            strWhere = strWhere & " WHERE " & oSDR("FieldCondition").ToString()
                        '        End If
                        '    End If
                        'End If

                        oSDRCombo = objDB.CreateSDRFromSQLSelect(strWhere)
                        oDropDown.DataSource = oSDRCombo
                        oDropDown.DataTextField = "FieldText"
                        oDropDown.DataValueField = "FieldValue"
                        oDropDown.DataBind()
                        SetObjectValidation(oDropDown, oSDR("Required"))
                        pnlParamDetail.Controls.Add(oDropDown)
                        oSDRCombo.Close()
                        oSDRCombo = Nothing


                    Else 'textbox
                        oTextBox = New TextBox()
                        oTextBox.ID = oSDR("FieldName").ToString()
                        oTextBox.MaxLength = oSDR("FieldSize").ToString
                        If oSDR("FieldDataType") = "2" Then 'Numeric
                            strValidation = "integer"
                            strFilter = "[0-9]"
                        ElseIf oSDR("FieldDataType") = "3" Then  'date
                            strValidation = "date"
                            strFilter = "[0-9/]"
                        End If
                        'oTextBox.Width = CType(oSDR("FieldSize") * 10, String) & "px"
                        'oTextBox.Width = "20px"
                        oTextBox.Style.Add("width", CType(oSDR("FieldSize") * 6, String) & "px")
                        SetObjectValidation(oTextBox, oSDR("Required"), strValidation, strFilter)
                        pnlParamDetail.Controls.Add(oTextBox)
                        If oSDR("FieldDataType") = "3" Then  'date

                            oImage = New Image()
                            oImage.ID = "img" & oSDR("FieldName").ToString()
                            oImage.ImageUrl = "../images/grid.gif"
                            oImage.ToolTip = "calendar"
                            oImage.Style.Add("cursor", "hand")
                            pnlParamDetail.Controls.Add(oImage)

                            oAjaxCalendar = New AjaxControlToolkit.CalendarExtender()
                            oAjaxCalendar.ID = "ajaxCE" & oSDR("FieldName").ToString()
                            oAjaxCalendar.TargetControlID = oTextBox.ID
                            oAjaxCalendar.PopupButtonID = oImage.ID
                            oAjaxCalendar.Format = "dd/MM/yyyy"
                            pnlParamDetail.Controls.Add(oAjaxCalendar)

                            oAjaxMEE = New AjaxControlToolkit.MaskedEditExtender()
                            oAjaxMEE.ID = "ajaxMEE" & oSDR("FieldName").ToString()
                            oAjaxMEE.MaskType = AjaxControlToolkit.MaskedEditType.Date
                            oAjaxMEE.Mask = "99/99/9999"
                            oAjaxMEE.PromptCharacter = "_"
                            oAjaxMEE.TargetControlID = oTextBox.ID
                            pnlParamDetail.Controls.Add(oAjaxMEE)

                        End If
                    End If

        If oSDR("Required") Then
            oRequired = New RequiredFieldValidator
            oRequired.SetFocusOnError = True
            oRequired.Display = ValidatorDisplay.None
            oRequired.ID = "req" & oSDR("FieldName").ToString()
            oRequired.ErrorMessage = "[" + oSDR("PromptText").ToString & "]" & " must be entry..."
            oRequired.ControlToValidate = oSDR("FieldName").ToString()
            pnlParamDetail.Controls.Add(oRequired)

            oAjaxVCE = New AjaxControlToolkit.ValidatorCalloutExtender
            oAjaxVCE.ID = "ajaxVCE" & oSDR("FieldName").ToString()
            oAjaxVCE.TargetControlID = oRequired.ID
            oAjaxVCE.HighlightCssClass = "ErrHighLight"
            pnlParamDetail.Controls.Add(oAjaxVCE)

        End If

        oLiteral = New Literal()
        oLiteral.Text = "</td></tr>"
        pnlParamDetail.Controls.Add(oLiteral)

                End While
                oSDR.Close()
                oSDR = Nothing

                oLiteral = New Literal()
                oLiteral.Text = "</table>"

                'pnlParamDetail.Controls.Add(oLiteral)
                'oLiteral = New Literal()
                'oLiteral.Text = "<br/>"
                pnlParamDetail.Controls.Add(oLiteral)
                oButton = New Button()
                oButton.ID = "btnReport"
                oButton.Text = "Report"
                oButton.CommandName = "Report"
                oButton.Style.Add("cursor", "hand")
                oButton.PostBackUrl = "Rpt.aspx?Action=Report&ReportID=" & lbReport.SelectedValue & "&ParamID=" & ddlParameter.SelectedValue
                'oButton.PostBackUrl = "RptDisplay.aspx?Action=Report&ReportID=" & lbReport.SelectedValue & "&ParamID=" & ddlParameter.SelectedValue
                pnlParamDetail.Controls.Add(oButton)
                'Catch ex As Exception
                '    Throw
            Finally
                objDB.Close()
                objDB = Nothing

            End Try
        End If
    End Sub

    'Protected Sub dlReport_ItemCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles dlReport.ItemCreated
    '    Dim objDB As New DBX
    '    Dim oSDR As System.Data.SqlClient.SqlDataReader
    '    Try
    '        oSDR = objDB.CreateSDRFromSQLSelect("Select * from rptParam Where ReportId=" & lbReport.SelectedValue)
    '        If Not oSDR.Read Then
    '            pnlParamDetail.Visible = True
    '        End If
    '    Catch ex As Exception
    '        Throw
    '    Finally
    '        oSDR.Close()
    '        oSDR = Nothing
    '        objDB.Close()
    '        objDB = Nothing
    '    End Try
    'End Sub

    Protected Sub lbReport_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbReport.SelectedIndexChanged
        Dim objDB As New DBX
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Try
            pnlParamDetail.Controls.Clear()
            oSDR = objDB.CreateSDRFromSQLSelect("Select count(*)JML from rptParam Where ReportId=" & sender.SelectedValue)
            If oSDR.Read() Then
                If oSDR("JML") <= 0 Then
                    Dim oButton As Button
                    pnlParamDetail.Visible = True
                    oButton = New Button()

                    oButton.ID = "btnReport"
                    oButton.Text = "Report"
                    oButton.CommandName = "Report"
                    oButton.Style.Add("cursor", "hand")
                    oButton.PostBackUrl = "Rpt.aspx?Action=Report&ReportID=" & lbReport.SelectedValue & "&ParamID="
                    'Response.Write("Rpt.aspx?Action=Report&ReportID=" & lbReport.SelectedValue & "&ParamID=" & ddlParameter.SelectedValue)
                    'oButton.PostBackUrl = "RptDisplay.aspx?Action=Report&ReportID=" & lbReport.SelectedValue & "&ParamID=" & ddlParameter.SelectedValue
                    pnlSelectParam.Visible = False
                    reqParameter.Enabled = False
                    pnlParamDetail.Controls.Add(oButton)
                Else
                    reqParameter.Enabled = True
                    'ddlParameter.AutoPostBack = True
                    pnlSelectParam.Visible = True
                    pnlParamDetail.Visible = False
                End If
            End If
            oSDR.Close()
            oSDR = Nothing
            'ddlParameter.Attributes.Add("onchange", "ParamChange();")
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

End Class
