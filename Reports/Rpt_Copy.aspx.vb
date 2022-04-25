
Partial Class Reports_Rpt
    Inherits System.Web.UI.Page
    Public strModulID As String, strParamID As String, strReportID As String
    Public strAction As String

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim strRSServer, strRSWeb As String
        Dim strURL As String = ""
        strModulID = Request.QueryString("ModulID")
        strParamID = Request.QueryString("ParamID")
        'ddlParameter.Attributes.Add("onchange", "ParamChange('" & strModulID & "','" & lbReport.SelectedValue & "')")
        strAction = Request.QueryString("Action")

        If Request.QueryString("Action") = "Report" Then
            strReportID = Request.QueryString("ReportID")
            Dim strParam As String = ""
            Dim objDB As New DBX
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            Dim strReportName As String
            'ReportParameter[] parm = new ReportParameter[1];
            oSDR = objDB.CreateSDRFromSQLSelect("select dbo.f_getAppSetting('RSSERVER') RSSERVER, dbo.f_getAppSetting('RSWEB') RSWEB")
            If oSDR.Read Then
                strRSServer = oSDR("RSSERVER")
                strRSWeb = oSDR("RSWEB")
            Else
                strRSServer = "localhost"
                strRSWeb = "ReportServer"
            End If
            oSDR.Close()
            oSDR = Nothing

            strReportName = "http://" & strRSServer & "/ReportServer" & strRSWeb
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT FileName FROM rptList WHERE ReportId=" & strReportID)
            If oSDR.Read Then
                strReportName = "http://" & strRSServer & "/" & strRSWeb & "?/" & oSDR("FileName").ToString
            End If
            oSDR.Close()
            oSDR = Nothing

            Try
                If Len(Trim(strParamID)) > 0 Then
                    oSDR = objDB.CreateSDRFromSQLSelect("SELECT FieldName, FieldDataType FROM rptParamDetail WHERE ParamID=" & strParamID)
                    While oSDR.Read
                        If oSDR("FieldDataType").ToString = "3" Then
                            strParam = strParam & "&" & oSDR("FieldName").ToString & "=" & ConvertDateToYMD(Request.Form("ctl00$cphMain$" & oSDR("FieldName").ToString))
                        Else
                            strParam = strParam & "&" & oSDR("FieldName").ToString & "=" & Request.Form("ctl00$cphMain$" & oSDR("FieldName").ToString)
                        End If
                        'Response.Write(Request.Form("ctl00$cphMain$" & oSDR("FieldName").ToString) & "<br>")
                    End While
                    oSDR.Close()
                    oSDR = Nothing

                End If
                strURL = strReportName & "&rs:Command=Render&rc:Parameters=false&rc:DocMap=true" & strParam
                'Response.Write(strURL)
                'Response.End()
                'Response.Redirect(strURL)
                Session("URLR") = strURL
                Response.Redirect("ReportView.aspx")

            Catch ex As Exception
                Throw
            Finally
                objDB.Close()
                objDB = Nothing
            End Try

        End If

    End Sub

    Protected Sub ddlParameter_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlParameter.SelectedIndexChanged
        SetInputParam()
    End Sub

    Public Sub SetInputParam()
        'Dim i As Integer = 0
        pnlParamDetail.Visible = True
        Dim oDropDown As DropDownList
        Dim oTextBox As TextBox
        Dim oLabel As Label
        Dim oLiteral As Literal
        Dim strParamID As String = ""
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


        'Dim oDataSet As System.Data.DataSet

        'oDropDown = CType(sender, DropDownList)
        'If oDropDown IsNot Nothing Then
        'strParamID = oDropDown.SelectedValue
        'End If
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
                    oLiteral = New Literal()
                    strValidation = ""
                    strFilter = ""

                    oLiteral = New Literal()
                    oLiteral.Text = "<tr><td style='width: 126px'>"
                    pnlParamDetail.Controls.Add(oLiteral)

                    oLabel = New Label()
                    oLabel.ID = "lbl" & oSDR("FieldName").ToString()
                    oLabel.Text = oSDR("PromptText").ToString
                    pnlParamDetail.Controls.Add(oLabel)

                    oLiteral = New Literal()
                    oLiteral.Text = "</td><td>"
                    pnlParamDetail.Controls.Add(oLiteral)

                    If oSDR("FieldInputType").ToString = "2" Then 'combobox
                        oDropDown = New DropDownList()
                        oDropDown.ID = oSDR("FieldName").ToString()

                        'strURL = oSDR("FieldName").ToString & "=" & oSDR("FieldName").ToString & ".value"
                        strWhere = "Select " & oSDR("FieldValue").ToString() & " as FieldValue, " & oSDR("FieldText").ToString() & " as FieldText from " & oSDR("Source").ToString
                        If Not String.IsNullOrEmpty(oSDR("FieldCondition").ToString()) Then
                            strWhere = strWhere & " WHERE " & oSDR("FieldCondition").ToString()
                        End If

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
                        oRequired.ErrorMessage = oSDR("PromptText").ToString & " must be entry..."
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
            oSDR = objDB.CreateSDRFromSQLSelect("Select count(*)JML from rptParam Where ReportId=" & lbReport.SelectedValue)
            If oSDR.Read Then
                If oSDR("JML") <= 0 Then
                    Dim oButton As Button
                    pnlParamDetail.Visible = True
                    oButton = New Button()
                    oButton.ID = "btnReport"
                    oButton.Text = "Report"
                    oButton.CommandName = "Report"
                    oButton.Style.Add("cursor", "hand")
                    oButton.PostBackUrl = "Rpt.aspx?Action=Report&ReportID=" & lbReport.SelectedValue & "&ParamID=" & ddlParameter.SelectedValue
                    'oButton.PostBackUrl = "RptDisplay.aspx?Action=Report&ReportID=" & lbReport.SelectedValue & "&ParamID=" & ddlParameter.SelectedValue
                    pnlSelectParam.Visible = False
                    pnlParamDetail.Controls.Add(oButton)
                Else
                    pnlSelectParam.Visible = True
                    pnlParamDetail.Visible = False
                End If
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

End Class
