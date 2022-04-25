Imports Microsoft.VisualBasic
Imports AjaxControlToolkit
Public Module Validation

    Public Function ConvertDateToYMD(ByVal strDateDMY As String) As String
        If strDateDMY = String.Empty Then
            ConvertDateToYMD = String.Empty
        Else
            Dim arrDate() As String
            Dim m, d, y As String
            arrDate = Split(strDateDMY, "/")
            d = arrDate(0)
            m = arrDate(1)
            y = arrDate(2)
            ConvertDateToYMD = y & "-" & m & "-" & d
        End If
    End Function


    Public Function ConvertDate(ByVal strDateDMY As String) As Nullable(Of Date)
        If strDateDMY = String.Empty Or strDateDMY Is Nothing Or Len(Trim(strDateDMY)) <= 0 Then
            ConvertDate = "1900-01-01"
        Else
            Dim m, d, y As String
            Dim arrDate() As String
            arrDate = Split(strDateDMY, "/")
            d = arrDate(0)
            m = arrDate(1)
            y = arrDate(2)
            ConvertDate = y & "-" & m & "-" & d
        End If
    End Function


    Public Function FormatDate(ByVal strDate As String) As Nullable(Of Date)
        If strDate = String.Empty Or strDate Is Nothing Or Len(Trim(strDate)) <= 0 Then
            FormatDate = "01/01/1900"
        Else
            Dim m, d, y As String
            Dim arrDate() As String
            arrDate = Split(strDate, "/")
            d = arrDate(0)
            m = arrDate(1)
            y = arrDate(2)
            FormatDate = d & "/" & m & "/" & y
        End If
    End Function

    Public Sub SetFormValidation(ByVal oForm As Object)
        oForm.Attributes.Add("onreset", "this.lang='en';")
        oForm.Attributes.Add("onsubmit", "return true;")
        oForm.Attributes.Add("mark", "")
        oForm.Attributes.Add("year4", "")
        oForm.Attributes.Add("invalidColor", "yellow")
        oForm.Attributes.Add("validate", "onchange")
    End Sub

    Public Sub SetObjectValidation( _
        ByVal oObject As Object, _
        Optional ByVal blnRequired As Boolean = False, _
        Optional ByVal strValidation As String = "", _
        Optional ByVal strFilter As String = "")

        Dim arrValidation() As String

        If blnRequired Then
            oObject.Attributes.Add("required", "")
        End If


        If Len(Trim(strValidation)) > 0 Then
            arrValidation = Split(strValidation, ",")
            Dim i As Integer = 0, sVal As String = ""
            For i = 0 To UBound(arrValidation)
                sVal = arrValidation(i)
                If Len(Trim(sVal)) > 0 Then
                    oObject.Attributes.Add(sVal, "")
                End If
            Next
        End If

        If Len(Trim(strFilter)) > 0 Then
            oObject.Attributes.Add("filter", strFilter)
        End If


    End Sub
    Public Function ReplaceMessage(ByVal ErrMsg As String) As String
        Dim sTmpErrMsg As String
        sTmpErrMsg = ErrMsg.Replace(vbCrLf, " ")
        sTmpErrMsg = sTmpErrMsg.Replace("'", "")
        Return sTmpErrMsg
    End Function

    Public Sub ClearPanelAplicationField(ByVal oPanel As System.Web.UI.WebControls.Panel)
        Try
            Dim oCtl As Control
            Dim oTextBoxCtl As TextBox
            Dim oCheckBoxCtl As CheckBox
            Dim oCheckBoxListCtl As CheckBoxList
            Dim oRadioButtonCtl As RadioButton
            Dim oRadioButtonListCtl As RadioButtonList
            Dim oDropDownListCtl As DropDownList
            Dim oListBoxCtl As ListBox
            Dim oCascadingDropDownListCtl As CascadingDropDown
            '****"Form1" is the Id of the Form found in the HTML tab &lt;FORM language=javascript id=Form1
            For Each oCtl In oPanel.Controls
                Select Case oCtl.GetType.ToString
                    Case "System.Web.UI.WebControls.TextBox"
                        oTextBoxCtl = CType(oCtl, TextBox)
                        oTextBoxCtl.Text = String.Empty
                    Case "System.Web.UI.WebControls.DropDownList"
                        oDropDownListCtl = CType(oCtl, DropDownList)
                        oDropDownListCtl.ClearSelection()
                        oDropDownListCtl.SelectedIndex = -1
                    Case "System.Web.UI.WebControls.CheckBox"
                        oCheckBoxCtl = CType(oCtl, CheckBox)
                        If oCheckBoxCtl.ID = "" Then
                            oCheckBoxCtl.Checked = False
                        End If
                    Case "System.Web.UI.WebControls.CheckBoxList"
                        oCheckBoxListCtl = CType(oCtl, CheckBoxList)
                        oCheckBoxListCtl.Items.Clear()
                    Case "System.Web.UI.WebControls.RadioButton"
                        oRadioButtonCtl = CType(oCtl, RadioButton)
                        oRadioButtonCtl.Checked = False
                    Case "System.Web.UI.WebControls.RadioButtonList"
                        oRadioButtonListCtl = CType(oCtl, RadioButtonList)
                        oRadioButtonListCtl.Items.Clear()
                    Case "System.Web.UI.WebControls.listBox"
                        oListBoxCtl = CType(oCtl, ListBox)
                        oListBoxCtl.Items.Clear()
                    Case "System.Web.UI.WebControls.CascadingDropDown"
                        oCascadingDropDownListCtl = CType(oCtl, CascadingDropDown)
                        oCascadingDropDownListCtl.SelectedValue = -1
                End Select
            Next
        Catch
            Throw
        End Try
    End Sub

    Public Function RoundUp(nValue As Double, nDigits As Double) As Double
        'NILAI DEFAULT SAMA
        RoundUp = nValue
        Dim oSDR As System.Data.SqlClient.SqlDataReader
        Dim objDBX As New DBX
        Try
            oSDR = objDBX.CreateSDRFromSQLSelect("SELECT [dbo].[f_RoundUp](" & nValue.ToString() & ", " & nDigits.ToString() & ") ROUNDUP")
            If oSDR.Read() Then
                RoundUp = oSDR("RoundUp")
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            RoundUp = nValue
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try

        'RoundUp = Int(nValue * 10 ^ nDigits + 0.999999999999) / (10 ^ nDigits)
    End Function
    Public Sub ReadOnlyAplicationField(ByVal oView As System.Web.UI.WebControls.View)
        Try
            Dim oCtl As Control
            Dim oTextBoxCtl As TextBox
            Dim oCheckBoxCtl As CheckBox
            Dim oCheckBoxListCtl As CheckBoxList
            Dim oRadioButtonCtl As RadioButton
            Dim oRadioButtonListCtl As RadioButtonList
            Dim oDropDownListCtl As DropDownList

            If oView IsNot Nothing Then
                For Each oCtl In oView.Controls
                    Select Case oCtl.GetType.ToString
                        Case "System.Web.UI.WebControls.TextBox"
                            oTextBoxCtl = CType(oCtl, TextBox)
                            If InStr(1, oTextBoxCtl.ID.ToString.Trim, "_R_", CompareMethod.Text) > 0 Then
                                oTextBoxCtl.Attributes.Add("readonly", "readonly")
                            End If
                        Case "System.Web.UI.WebControls.CheckBox"
                            oCheckBoxCtl = CType(oCtl, CheckBox)
                            If InStr(1, oCheckBoxCtl.ID.ToString.Trim, "_R_", CompareMethod.Text) > 0 Then
                                oCheckBoxCtl.Attributes.Add("readonly", "readonly")
                            End If
                        Case "System.Web.UI.WebControls.CheckBoxList"
                            oCheckBoxListCtl = CType(oCtl, CheckBoxList)
                            If InStr(1, oCheckBoxListCtl.ID.ToString.Trim, "_R_", CompareMethod.Text) > 0 Then
                                oCheckBoxListCtl.Attributes.Add("readonly", "readonly")
                            End If
                        Case "System.Web.UI.WebControls.RadioButton"
                            oRadioButtonCtl = CType(oCtl, RadioButton)
                            If InStr(1, oRadioButtonCtl.ID.ToString.Trim, "_R_", CompareMethod.Text) > 0 Then
                                oRadioButtonCtl.Attributes.Add("readonly", "readonly")
                            End If
                        Case "System.Web.UI.WebControls.RadioButtonList"
                            oRadioButtonListCtl = CType(oCtl, RadioButtonList)
                            For iRow = 0 To oRadioButtonListCtl.Items.Count - 1
                                If InStr(1, oRadioButtonListCtl.ID.ToString.Trim, "_R_", CompareMethod.Text) > 0 Then
                                    oRadioButtonListCtl.Items(iRow).Attributes.Add("readonly", "readonly")
                                End If
                            Next
                        Case "System.Web.UI.WebControls.DropDownList"
                            oDropDownListCtl = CType(oCtl, DropDownList)
                            If InStr(1, oDropDownListCtl.ID.ToString.Trim, "_R_", CompareMethod.Text) > 0 Then
                                oDropDownListCtl.Attributes.Add("readonly", "readonly")
                            End If
                    End Select
                Next
            End If
        Catch
            Throw
        End Try
    End Sub
    Public Sub ClearViewAplicationField(ByVal oView As System.Web.UI.WebControls.View)
        Try
            Dim oCtl As Control
            Dim oTextBoxCtl As TextBox
            Dim oCheckBoxCtl As CheckBox
            Dim oCheckBoxListCtl As CheckBoxList
            Dim oRadioButtonCtl As RadioButton
            Dim oRadioButtonListCtl As RadioButtonList
            Dim oDropDownListCtl As DropDownList

            '****"Form1" is the Id of the Form found in the HTML tab &lt;FORM language=javascript id=Form1
            For Each oCtl In oView.Controls
                Select Case oCtl.GetType.ToString
                    Case "System.Web.UI.WebControls.TextBox"
                        oTextBoxCtl = CType(oCtl, TextBox)
                        oTextBoxCtl.Text = String.Empty
                    Case "System.Web.UI.WebControls.DropDownList"
                        oDropDownListCtl = CType(oCtl, DropDownList)
                        oDropDownListCtl.ClearSelection()
                        oDropDownListCtl.SelectedIndex = -1
                    Case "System.Web.UI.WebControls.CheckBox"
                        oCheckBoxCtl = CType(oCtl, CheckBox)
                        If oCheckBoxCtl.ID = "" Then
                            oCheckBoxCtl.Checked = False
                        End If
                    Case "System.Web.UI.WebControls.CheckBoxList"
                        oCheckBoxListCtl = CType(oCtl, CheckBoxList)
                        oCheckBoxListCtl.Items.Clear()
                    Case "System.Web.UI.WebControls.RadioButton"
                        oRadioButtonCtl = CType(oCtl, RadioButton)
                        oRadioButtonCtl.Checked = False
                    Case "System.Web.UI.WebControls.RadioButtonList"
                        oRadioButtonListCtl = CType(oCtl, RadioButtonList)
                        oRadioButtonListCtl.Items.Clear()
                End Select
            Next
        Catch
            Throw
        End Try
    End Sub
    Public Sub ReadOnlyAplicationGridView(ByVal oGridview As System.Web.UI.WebControls.GridView)
        Try
            Dim icol As Integer
            Dim oTextBoxCtl As TextBox
            Dim oDropDownListCtl As DropDownList

            If oGridview IsNot Nothing Then

                For Each row As GridViewRow In oGridview.Rows
                    For iCol = 0 To row.Cells.Count - 1
                        If row.Cells(icol).Controls.Count > 0 Then
                            If row.Cells(icol).Text = "" Then
                                Select Case row.Cells(icol).Controls(1).GetType.ToString
                                    Case "System.Web.UI.WebControls.TextBox"
                                        If Not IsNothing(CType(row.Cells(icol).Controls(1), TextBox)) Then
                                            oTextBoxCtl = CType(row.Cells(icol).Controls(1), TextBox)
                                            If InStr(1, oTextBoxCtl.ID.ToString.Trim, "_R_", CompareMethod.Text) > 0 Then
                                                oTextBoxCtl.Attributes.Add("readonly", "readonly")
                                            End If
                                        End If
                                    Case "System.Web.UI.WebControls.DropDownList"
                                        If Not IsNothing(CType(row.Cells(icol).Controls(1), DropDownList)) Then
                                            oDropDownListCtl = CType(row.Cells(icol).Controls(1), DropDownList)
                                            If InStr(1, oDropDownListCtl.ID.ToString.Trim, "_R_", CompareMethod.Text) > 0 Then
                                                oDropDownListCtl.Attributes.Add("readonly", "readonly")
                                            End If
                                        End If
                                End Select
                            End If
                        End If
                    Next
                Next
            End If
        Catch
            Throw
        End Try
    End Sub

End Module
