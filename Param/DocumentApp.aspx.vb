
Partial Class Param_DocumentApp
    Inherits System.Web.UI.Page
    Public Shared oStrreqOrderNumber As String
    Public Shared oStrtxtOrderNumber As String
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

        End If
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
        Try
            Dim oSDR As Data.SqlClient.SqlDataReader
            Do Until n = gvData.Rows.Count
                oSDR = objDB.CreateSDRFromExecSQL("Update dbo.DOCUMENTAPP SET DeleteSTS=1 WHERE DOCID=" & CType(gvData.Rows(n).FindControl("lblDOCID"), Label).Text)
                oSDR.Close()
                n += 1
            Loop
            n = 0
            Do Until n = gvData.Rows.Count
                cb = gvData.Rows.Item(n).FindControl("chk")
                If cb IsNot Nothing AndAlso cb.Checked Then

                    intRetVal = objDB.ExecSPReturnInteger("DOCUMENTAPPSave", _
                        objDB.MP("@DOCID", Data.SqlDbType.Int, CType(gvData.Rows(n).FindControl("lblDOCID"), Label).Text, 10), _
                        objDB.MP("@DOCAPPTYPE", Data.SqlDbType.Int, ddlDocGroup.SelectedItem.Value, 10), _
                        objDB.MP("@REMARK", Data.SqlDbType.VarChar, CType(gvData.Rows(n).FindControl("txtRemark"), TextBox).Text, 50), _
                        objDB.MP("@ORDERNUMBER", Data.SqlDbType.Int, CType(gvData.Rows(n).FindControl("txtOrderNumber"), TextBox).Text, 50), _
                       objDB.MP("@USERID", Data.SqlDbType.BigInt, Request.Cookies("UID").Value, 20) _
                        )
                End If
                n += 1
            Loop
            lblMessage.Visible = True
            If intRetVal = -1 Then
                lblMessage.Text = "SAVE DOCUMENT APPLICATION FAILED...!<BR>DOCUMENT APPLICATION DETAIL ALREADY ENTRY...!"
                btnSave.Visible = False
            Else
                gvData.DataBind()
                hidAction.Value = "LOAD"
                lblMessage.Text = "SAVE DOCUMENT APPLICATION DETAIL COMPLETED......!"
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR DOCUMENT APPLICATION DETAIL: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing

        End Try
    End Sub

    Protected Sub gvData_DataBound(sender As Object, e As System.EventArgs) Handles gvData.DataBound
        Dim oTextBox As TextBox
        Dim oCheckBox As CheckBox
        'Dim oRequired As RequiredFieldValidator
        For Each row As GridViewRow In gvData.Rows
            oTextBox = CType(row.FindControl("txtOrderNumber"), TextBox)
            If oTextBox IsNot Nothing Then
                SetObjectValidation(oTextBox, False, "integer", "[0-9]")
                If Len(Trim(oTextBox.Text)) <= 0 Then
                    oTextBox.Text = "0"
                End If
            End If
        Next

        For Each row As GridViewRow In gvData.Rows
            oCheckBox = CType(row.FindControl("chk"), CheckBox)
            If oCheckBox.Checked = True Then
                row.BackColor = Drawing.Color.YellowGreen
            End If
        Next

        'For Each row As GridViewRow In gvData.Rows
        '    oRequired = CType(row.FindControl("reqOrderNumber"), RequiredFieldValidator)
        '    If oRequired IsNot Nothing Then
        '        oStrreqOrderNumber = oRequired.ClientID
        '    End If
        'Next
        'For Each row As GridViewRow In gvData.Rows
        '    oTextBox = CType(row.FindControl("txtOrderNumber"), TextBox)
        '    If oTextBox IsNot Nothing Then
        '        oStrtxtOrderNumber = oTextBox.ClientID
        '    End If
        'Next
      
    End Sub


End Class
