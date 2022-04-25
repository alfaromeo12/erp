
Partial Class Param_DocumentReq
    Inherits System.Web.UI.Page
    Public Shared oStrChkDocReq As String
    Public Shared oStrChk As String
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
        End If
        SetValidation()
    End Sub
    Private Sub SetValidation()
        ddlDocGroup.Attributes.Add("onchange", "checkEntryCustType();")

    End Sub
    Protected Sub Page_PreInit(sender As Object, e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub ddlDocGroup_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlDocGroup.SelectedIndexChanged
        gvData.DataBind()
        hidAction.Value = "LOAD"
        lblMessage.Visible = False
    End Sub
    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        Dim objDB As New DBX
        Dim cbterpilih As Boolean = False
        Dim cb As CheckBox = Nothing
        Dim n As Integer = 0
        Dim intRetVal As Integer
        Dim oHidden As HiddenField
        'Dim lRows As Integer
        Try
            'Dim oSDR As Data.SqlClient.SqlDataReader
            For Each row As GridViewRow In gvData.Rows
                oHidden = CType(row.FindControl("hidDOCREQID"), HiddenField)
                'If oHidden IsNot Nothing Then
                '    Response.Write("nort nothing<br>")
                '    Response.Write(oHidden.Value & "<br>")
                'Else
                '    Response.Write("nothing<br>")
                'End If

                'Response.End()
                If oHidden IsNot Nothing Then
                    If Len(Trim(oHidden.Value)) > 0 Then
                        objDB.ExecSQL("Update dbo.DOCUMENTREQUIRED SET DeleteSTS=1 WHERE DOCREQID=" & oHidden.Value & " And CUSTTYPE= " & ddlDocGroup.SelectedItem.Value)
                    End If
                End If
            Next
            'Response.End()

            For Each row As GridViewRow In gvData.Rows
                cb = CType(row.FindControl("chk"), CheckBox)
                If cb IsNot Nothing AndAlso cb.Checked Then
                    oHidden = CType(row.FindControl("hidDOCREQID"), HiddenField)
                    If oHidden IsNot Nothing Then
                        intRetVal = objDB.ExecSPReturnInteger("DOCUMENTREQSave", _
                            objDB.MP("@DOCREQID", Data.SqlDbType.Int, oHidden.Value), _
                                objDB.MP("@DOCID", Data.SqlDbType.Int, CType(row.FindControl("hidDOCID"), HiddenField).Value, 10), _
                                objDB.MP("@PRODUCTID", Data.SqlDbType.Int, ddlProduct.SelectedItem.Value, 10), _
                                objDB.MP("@CUSTTYPE", Data.SqlDbType.Int, ddlDocGroup.SelectedItem.Value, 10), _
                                objDB.MP("@MARITALSTATUS", Data.SqlDbType.Int, ddlMarital.SelectedItem.Value, 10), _
                                objDB.MP("@MANDATORY", Data.SqlDbType.Bit, CType(row.FindControl("chkmandatory"), CheckBox).Checked, 1), _
                                objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value, 20) _
                                )
                    End If
                End If
            Next
            lblMessage.Visible = True
            If intRetVal = -1 Then
                lblMessage.Text = "SAVE DOCUMENT REQUIRED FAILED...!<BR>DOCUMENT APPLICATION DETAIL ALREADY ENTRY...!"
                btnSave.Visible = False
            Else
                gvData.DataBind()
                hidAction.Value = "LOAD"
                lblMessage.Text = "SAVE DOCUMENT REQUIRED DETAIL COMPLETED......!"
            End If
            'Catch ex As Exception
            '    lblMessage.Visible = True
            '    lblMessage.Text = "ERROR DOCUMENT REQUIRED DETAIL: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing

        End Try
    End Sub

    Protected Sub gvData_DataBound(sender As Object, e As System.EventArgs) Handles gvData.DataBound
        Dim oCheckBox As CheckBox
        For Each row As GridViewRow In gvData.Rows
            oCheckBox = CType(row.FindControl("chk"), CheckBox)
            If oCheckBox.Checked = True Then
                row.BackColor = Drawing.Color.YellowGreen
            End If
            If oCheckBox IsNot Nothing Then
                oStrChk = oCheckBox.ClientID
            End If
        Next
        For Each row As GridViewRow In gvData.Rows
            oCheckBox = CType(row.FindControl("chkmandatory"), CheckBox)
            If oCheckBox IsNot Nothing Then
                oStrChkDocReq = oCheckBox.ClientID
            End If
        Next

    End Sub

    Protected Sub ddlProduct_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlProduct.SelectedIndexChanged
        gvData.DataBind()
        hidAction.Value = "LOAD"
        lblMessage.Visible = False
    End Sub

    Protected Sub gvData_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvData.RowDataBound
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            DirectCast(e.Row.FindControl("chk"), CheckBox).Attributes.Add("onclick", "javascript:StatusMandatory('" & DirectCast(e.Row.FindControl("chkmandatory"), CheckBox).ClientID & "');javascript:HighlightRow(this)")

            Dim ChkMdt As New CheckBox()
            Dim Chk As New CheckBox()
            ChkMdt = DirectCast(e.Row.FindControl("chkmandatory"), CheckBox)
            Chk = DirectCast(e.Row.FindControl("chk"), CheckBox)

            If Chk.Checked = True Then
                ChkMdt.Enabled = True
            Else
                ChkMdt.Enabled = False
            End If
        End If
   
    End Sub
End Class
