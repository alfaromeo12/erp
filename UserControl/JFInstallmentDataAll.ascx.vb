
Partial Class UserControl_JFInstallmentDataAll
    Inherits System.Web.UI.UserControl

    Public Property ACCIDJF() As String
        Get
            Return 0
        End Get
        Set(value As String)
            sdsInstallment.SelectParameters("ACCIDJF").DefaultValue = value
        End Set
    End Property

    Public Property TXNDATE() As String
        Get
            Return 0
        End Get
        Set(value As String)
            sdsInstallment.SelectParameters("TXNDATE").DefaultValue = value
        End Set
    End Property

    Protected Sub gvInstallment_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvInstallment.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If DataBinder.Eval(e.Row.DataItem, "FLAGDUE") = "1" Then
                e.Row.ForeColor = Drawing.Color.Red
            End If
        End If
    End Sub
End Class
