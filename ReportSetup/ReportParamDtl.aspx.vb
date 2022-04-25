
Partial Class ReportSetup_ReportParamDtl
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            If Request.QueryString("Action") = "Copy" Then
                Dim objDB As New DBX
                Try
                    objDB.ExecSP("rptParamCopy", _
                        objDB.MP("@ParamId", Data.SqlDbType.Int, Request.QueryString("ParamID")), _
                        objDB.MP("@CopyParamId", Data.SqlDbType.Int, Request.QueryString("ParamIDCopy")), _
                        objDB.MP("@UserId", Data.SqlDbType.VarChar, Request.Cookies("UID").Value, 30) _
                            )
                    gvData.DataBind()
                Catch ex As Exception
                    Throw
                Finally
                    objDB.Close()
                    objDB = Nothing
                End Try
            End If
        End If
    End Sub


    Protected Sub imgBtnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnNew.Click
        fvData.ChangeMode(FormViewMode.Insert)
        fvData.Caption = "New Parameter Detail"
    End Sub

    Protected Sub fvData_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvData.ItemCreated

        Dim oDropDownDataType As DropDownList = CType(fvData.FindControl("ddlDataType"), DropDownList)
        Dim oTextBoxFieldSize As TextBox = CType(fvData.FindControl("txtFieldSize"), TextBox)
        Dim oDropDownInputType As DropDownList = CType(fvData.FindControl("ddlFieldInputType"), DropDownList)
        Dim strScript As String = ""

        If oDropDownDataType IsNot Nothing Then
            strScript = "DataTypeChange('" & oDropDownDataType.ClientID & "','" & oTextBoxFieldSize.ClientID & "')"
            oDropDownDataType.Attributes.Add("onchange", strScript)
            oDropDownDataType.Attributes.Add("onfocus", strScript)

        End If

        If oDropDownInputType IsNot Nothing Then
            Dim oDropDownSource As DropDownList = CType(fvData.FindControl("ddlSource"), DropDownList)
            Dim oDropDownFieldValue As DropDownList = CType(fvData.FindControl("ddlFieldValue"), DropDownList)
            Dim oDropDownFieldText As DropDownList = CType(fvData.FindControl("ddlFieldText"), DropDownList)
            Dim oTextBoxFieldDefault As TextBox = CType(fvData.FindControl("txtFieldDefaultValue"), TextBox)
            Dim oTextBoxFieldCondition As TextBox = CType(fvData.FindControl("txtFieldCondition"), TextBox)
            Dim oDropDownBranchFilter As DropDownList = CType(fvData.FindControl("ddlBranchFilter"), DropDownList)
            strScript = "InputTypeChange('" & oDropDownInputType.ClientID & "', '" & oDropDownSource.ClientID & "', '" & oDropDownFieldValue.ClientID & "', '" & oDropDownFieldText.ClientID & "', '" & oTextBoxFieldDefault.ClientID & "', '" & oTextBoxFieldCondition.ClientID & "', '" & oDropDownBranchFilter.ClientID & "');"
            oDropDownInputType.Attributes.Add("onchange", strScript)
            oDropDownInputType.Attributes.Add("onfocus", strScript)
            oDropDownFieldValue.Attributes.Add("onchange", strScript)
            'strScript = "<script language='javascript'>" & Chr(13) & strScript & "</script>" & Chr(13)
            'ClientScript.RegisterStartupScript(Page.GetType(), "InputChange", strScript)
        End If

        

        'Response.Write(gvData.DataKeys(0).Value)

        setValidation()

    End Sub

    Private Sub setValidation()
        Dim oTextBox As TextBox
        oTextBox = CType(fvData.FindControl("txtFieldName"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, True)
        oTextBox = CType(fvData.FindControl("txtPromptText"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, True)
        oTextBox = CType(fvData.FindControl("txtFieldSize"), TextBox)
        If oTextBox IsNot Nothing Then SetObjectValidation(oTextBox, True, "integer", "[0-9]")
    End Sub

    Protected Sub sdsForm_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Inserted
        fvData.Caption = ""
        gvData.DataBind()
    End Sub

    Protected Sub sdsForm_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Updated
        fvData.Caption = ""
        gvData.DataBind()
    End Sub

    Protected Sub sdsForm_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsForm.Deleted
        fvData.Caption = ""
        gvData.DataBind()
    End Sub

    Protected Sub gvData_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvData.RowCommand
        If e.CommandName = "Select" Then
            fvData.ChangeMode(FormViewMode.Edit)
            fvData.Caption = "Edit Parameter Detail"
        End If

    End Sub

    Protected Sub fvData_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles fvData.ItemCommand
        If e.CommandName = "Cancel" Then
            gvData.SelectedIndex = -1
            fvData.Caption = ""
        End If
    End Sub

    Protected Sub btnBack_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBack.Click
        Response.Redirect("ReportParam.aspx?ReportID=" & Request.QueryString("ReportID"))
    End Sub
End Class
