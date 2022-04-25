
Partial Class Unknown_UnknownReceiveApprove
    Inherits System.Web.UI.Page
    Public Shared strAppDate As String

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim objDB As New DBX
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            Try
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT APPVALUE,CAST(dbo.f_IsUserBranch(" & Request.Cookies("UID").Value & ") as VARCHAR(10)) ISUSERBRANCH  FROM APPSETTING WITH(NOLOCK) WHERE APPCODE='APPDATE'")
                If oSDR.Read Then
                    strAppDate = oSDR("APPVALUE").ToString()
                    hidIsUserBranch.Value = oSDR("ISUSERBRANCH").ToString()
                End If
                oSDR.Close()
                oSDR = Nothing

                If Not IsPostBack() Then
                    If hidIsUserBranch.Value = "1" Then 'user cabang
                        oSDR = objDB.CreateSDRFromSQLSelect("SELECT BRANCH.BRANCHID, BRANCH.AREAID FROM APPUSER WITH(NOLOCK) INNER JOIN BRANCH ON APPUSER.BRANCHID=BRANCH.BRANCHID WHERE APPUSER.UID=" & Request.Cookies("UID").Value)
                        If oSDR.Read() Then
                            ajaxCDDArea.SelectedValue = oSDR("AREAID").ToString()
                            ajaxCDDBranch.SelectedValue = oSDR("BRANCHID").ToString()
                        End If
                        oSDR.Close()
                        oSDR = Nothing
                    End If
                End If

            Catch ex As Exception
                lblMessage.Visible = True
                lblMessage.Text = "ERROR LOADING ASSET PLEDGE ENTRY..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE : <BR>" & ex.Message
            Finally
                objDB.Close()
                objDB = Nothing
            End Try
            txtDateStart.Text = strAppDate
            txtDateEnd.Text = strAppDate

        End If
        SetObjectValidation(txtDateStart, True, "date", "[0-9/]")
        SetObjectValidation(txtDateEnd, True, "date", "[0-9/]")
        DataGrid()
    End Sub
    Protected Sub Page_PreInit(sender As Object, e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub
    Private Sub DataGrid()
        If Not IsPostBack Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand + " AND PAYUNKNOWN.LOCIDUN=0 AND PAYUNKNOWN.UNKNOWNID = 0"
        End If

        If Len(Trim(ddlCriteria.SelectedValue)) > 0 And txtSearch.Text <> "" Then
            If ddlCriteria.SelectedValue = "REFNO" Then
                If IsNumeric(txtSearch.Text) Then
                    Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " = " + txtSearch.Text
                End If
            ElseIf ddlCriteria.SelectedValue = "BANKNAME" Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
            End If

        ElseIf txtSearch.Text = "" Or txtSearch.Text = "%%" Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND " + ddlCriteria.SelectedItem.Value + " LIKE '" + Replace(Replace(Me.txtSearch.Text, ";", ""), "'", "''") + "%'"
        End If

        If Len(Trim(ddlAreaSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCH.AREAID=" & ddlAreaSearch.SelectedValue
        End If
        If Len(Trim(ddlBranchSearch.SelectedValue)) > 0 Then
            Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND BRANCH.BRANCHID=" & ddlBranchSearch.SelectedValue
        End If


        If rdbFromUnknownDate.Checked Then
            If Len(Trim(txtDateStart.Text)) > 0 And Len(Trim(txtDateEnd.Text)) > 0 Then
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (PAYUNKNOWN.TXNDATE BETWEEN CONVERT(DATETIME, '" + txtDateStart.Text + "', 103) AND CONVERT(DATETIME, '" + txtDateEnd.Text + "', 103))"
            Else
                Me.sdsGrid.SelectCommand = Me.sdsGrid.SelectCommand & " AND (PAYUNKNOWN.TXNDATE BETWEEN CONVERT(DATETIME, '" + strAppDate + "', 103) AND CONVERT(DATETIME, '" + strAppDate + "', 103))"
            End If
        End If



        gvData.DataBind()
    End Sub

    Protected Sub gvData_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        Dim currentRowIndex As Integer = Convert.ToInt32(e.CommandArgument).ToString
        lblMessage.Visible = False
        If e.CommandName = "Select" Then
            hidLocidUN.Value = CType(gvData.Rows(currentRowIndex).FindControl("lblKeyLocid"), Label).Text
            hidIDUnReceive.Value = gvData.DataKeys(currentRowIndex).Value
            pnlControl.Visible = True
        End If
    End Sub
    Protected Sub btnApprove_Click(sender As Object, e As System.EventArgs) Handles btnApprove.Click
        Dim objDB As New DBX
        Dim intRetVal As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try

            oSQLParam = objDB.ExecSPReturnParam("PAYUNKNOWNUpdateStatus", _
                  objDB.MP("@LOCIDUN", Data.SqlDbType.BigInt, hidLocidUN.Value, 8), _
                  objDB.MP("@UNKNOWNID", Data.SqlDbType.Int, hidIDUnReceive.Value, 8), _
                  objDB.MP("@UNKNOWNSTS", Data.SqlDbType.TinyInt, 1, 5), _
                  objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 8), _
                  objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 10, Data.ParameterDirection.Output) _
                   )
            intRetVal = oSQLParam("@RETVAL").Value.ToString()
            If intRetVal = -1 Then
                lblMessage.Visible = True
                lblMessage.Text = "UNKNOWN RECEIVE " & hidIDUnReceive.Value & " ALREADY APPROVED OR REJECTED" & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            Else
                lblMessage.Text = ""
                lblMessage.Visible = False
                hidLocidUN.Value = ""
                hidIDUnReceive.Value = ""
                DataGrid()
                pnlControl.Visible = False
            End If
           
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR APPROVAL DATA UNKNOWN RECEIVE: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

    Protected Sub btnReject_Click(sender As Object, e As System.EventArgs) Handles btnReject.Click
        Dim objDB As New DBX
        Dim intRetVal As Integer
        Dim oSQLParam As System.Data.SqlClient.SqlParameterCollection
        Try

            oSQLParam = objDB.ExecSPReturnParam("PAYUNKNOWNUpdateStatus", _
                  objDB.MP("@LOCIDUN", Data.SqlDbType.BigInt, hidLocidUN.Value, 8), _
                  objDB.MP("@UNKNOWNID", Data.SqlDbType.Int, hidIDUnReceive.Value, 8), _
                  objDB.MP("@UNKNOWNSTS", Data.SqlDbType.TinyInt, 9, 5), _
                  objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value, 8), _
                  objDB.MP("@RETVAL", Data.SqlDbType.Int, intRetVal, 10, Data.ParameterDirection.Output) _
                   )
            intRetVal = oSQLParam("@RETVAL").Value.ToString()
            If intRetVal = -1 Then
                lblMessage.Visible = True
                lblMessage.Text = "UNKNOWN RECEIVE " & hidIDUnReceive.Value & " ALREADY APPROVED OR REJECTED" & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            Else
                lblMessage.Text = ""
                lblMessage.Visible = False
                hidLocidUN.Value = ""
                hidIDUnReceive.Value = ""
                DataGrid()
                pnlControl.Visible = False
            End If
            
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR REJECTED DATA UNKNOWN RECEIVE: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
    End Sub

End Class
