
Partial Class Param_DocumentColl
    Inherits System.Web.UI.Page
    Public Shared oStrChkDocReq As String
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
        End If
    End Sub
    
    Protected Sub Page_PreInit(sender As Object, e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

   
    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        Dim objDB As New DBX
        Dim cbterpilih As Boolean = False
        Dim cb As CheckBox = Nothing
        Dim n As Integer = 0
        Dim intRetVal As Integer
        Dim lRow As Integer
        Dim lRows As Integer
        Try
            Dim oSDR As Data.SqlClient.SqlDataReader
            lRows = gvData.Rows.Count - 1
            For lRow = 0 To lRows
                '  cb = gvData.Rows.Item(lRow).FindControl("chk")
                '  If cb IsNot Nothing AndAlso cb.Checked Then
                If CType(gvData.Rows(lRow).FindControl("lblDOCCOLLID"), Label).Text <> "" Then
                    oSDR = objDB.CreateSDRFromExecSQL("Update dbo.DOCUMENTCOLLATERAL SET DeleteSTS=1 WHERE DOCCOLLID=" & CType(gvData.Rows(lRow).FindControl("lblDOCCOLLID"), Label).Text)
                    oSDR.Close()
                    'End If
                End If
            Next
            For lRow = 0 To lRows
                cb = gvData.Rows.Item(lRow).FindControl("chk")
                If cb IsNot Nothing AndAlso cb.Checked Then
                    intRetVal = objDB.ExecSPReturnInteger("DOCUMENTCOLLATERALSave", _
                        objDB.MP("@DOCCOLLID", Data.SqlDbType.Int, CType(gvData.Rows(lRow).FindControl("lblDOCCOLLID"), Label).Text, 10), _
                                objDB.MP("@DOCID", Data.SqlDbType.Int, CType(gvData.Rows(lRow).FindControl("hidDOCID"), HiddenField).Value, 10), _
                                objDB.MP("@PRODUCTID", Data.SqlDbType.Int, ddlProduct.SelectedItem.Value, 10), _
                                objDB.MP("@PURPOSEID", Data.SqlDbType.Int, ddlPurpose.SelectedItem.Value, 10), _
                                objDB.MP("@CONDITION", Data.SqlDbType.Int, ddlItemCondition.SelectedItem.Value, 10), _
                                objDB.MP("@MANDATORY", Data.SqlDbType.Bit, CType(gvData.Rows(lRow).FindControl("chkmandatory"), CheckBox).Checked, 1), _
                               objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value, 20) _
                                )
                End If
            Next
            lblMessage.Visible = True
            If intRetVal = -1 Then
                lblMessage.Text = "SAVE DOCUMENT COLLATERAL FAILED...!<BR>DOCUMENT APPLICATION DETAIL ALREADY ENTRY...!"
                btnSave.Visible = False
            Else
                gvData.DataBind()
                hidAction.Value = "LOAD"
                lblMessage.Text = "SAVE DOCUMENT COLLATERAL DETAIL COMPLETED......!"
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR DOCUMENT COLLATERAL DETAIL: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
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

    Protected Sub ddlItemCondition_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlItemCondition.SelectedIndexChanged
        gvData.DataBind()
        hidAction.Value = "LOAD"
        lblMessage.Visible = False
    End Sub

    Protected Sub ddlPurpose_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlPurpose.SelectedIndexChanged
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
