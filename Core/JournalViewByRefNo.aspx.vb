
Partial Class Txn_JournalViewByRefNo
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    'Dim intCellDebet As Integer = 0, intCellCredit As Integer = 0
    Dim dblTotalDebet As Double = 0, dblTotalCredit As Double = 0
    Protected Sub gvJournal_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvJournal.RowCreated
        Select Case e.Row.RowType

            Case DataControlRowType.DataRow
                'e.Row.Cells(4).HorizontalAlign = HorizontalAlign.Right
                e.Row.Cells(6).HorizontalAlign = HorizontalAlign.Right

                dblTotalDebet += Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "AMOUNTDEBET"))
                dblTotalCredit += Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "AMOUNTCREDIT"))


            Case DataControlRowType.Footer
                e.Row.Font.Bold = True

                e.Row.Cells(4).HorizontalAlign = HorizontalAlign.Right
                e.Row.Cells(4).Text = "Total : "

                e.Row.Cells(6).HorizontalAlign = HorizontalAlign.Right
                e.Row.Cells(6).Text = dblTotalDebet.ToString("N2")

                e.Row.Cells(7).HorizontalAlign = HorizontalAlign.Right
                e.Row.Cells(7).Text = dblTotalCredit.ToString("N2")

        End Select

    End Sub

    Protected Sub gvJournal_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvJournal.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If DataBinder.Eval(e.Row.DataItem, "REVERSAL") Then
                e.Row.ForeColor = Drawing.Color.Red
                e.Row.Font.Bold = True
            End If
        End If
    End Sub
End Class
