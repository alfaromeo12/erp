
Partial Class UserControl_InstallmentDataDue
    Inherits System.Web.UI.UserControl

    Public Property LOCID() As String
        Get
            'Return txtLOCID.Value
            Return 0
        End Get
        Set(value As String)
            'txtLOCID.Value = value
            sdsInstallment.SelectParameters("LOCID").DefaultValue = value
        End Set
    End Property

    Public Property ACCID() As String
        Get
            'Return txtACCID.Value
            Return 0
        End Get
        Set(value As String)
            'txtACCID.Value = value
            sdsInstallment.SelectParameters("ACCID").DefaultValue = value
        End Set
    End Property


    Public Property TXNDATE() As String
        Get
            'Return txtAPPDATE.Value
            Return 0
        End Get
        Set(value As String)
            'txtAPPDATE.Value = value
            sdsInstallment.SelectParameters("APPDATE").DefaultValue = value
        End Set
    End Property

    Protected Sub gvInstallment_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvInstallment.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If DataBinder.Eval(e.Row.DataItem, "PAIDSTS") = False And _
                     DataBinder.Eval(e.Row.DataItem, "PENALTYDAY") > 0 Then
                e.Row.ForeColor = Drawing.Color.Red
            End If
        End If
    End Sub

    Protected Sub gvInstallment_Load(sender As Object, e As System.EventArgs) Handles gvInstallment.Load

    End Sub

    Protected Sub gvInstallment_DataBound(sender As Object, e As System.EventArgs) Handles gvInstallment.DataBound
        If Len(Trim(sdsInstallment.SelectParameters("ACCID").DefaultValue.ToString())) > 0 Then
            Dim objDB As New DBX
            Try
                Dim oSDR As System.Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT dbo.f_getTermPrincipal(FINCATID) PRINCIPALTERM, " & _
                                "dbo.f_getTermInterest(FINCATID) INTERESTTERM, " & _
                                "dbo.f_getTermPenalty(FINCATID) PENALTYTERM FROM ACCOUNT WITH(NOLOCK) WHERE LOCID=" & sdsInstallment.SelectParameters("LOCID").DefaultValue.ToString() & " AND ACCID=" & sdsInstallment.SelectParameters("ACCID").DefaultValue.ToString())
                If oSDR.Read() Then
                    gvInstallment.Columns(2).HeaderText = oSDR("PRINCIPALTERM")
                    gvInstallment.Columns(3).HeaderText = oSDR("INTERESTTERM")

                    gvInstallment.Columns(4).HeaderText = oSDR("PRINCIPALTERM") & "<br>Paid"
                    gvInstallment.Columns(5).HeaderText = oSDR("INTERESTTERM") & "<br>Paid"

                    gvInstallment.Columns(6).HeaderText = oSDR("PRINCIPALTERM") & "<br>Waive"
                    gvInstallment.Columns(7).HeaderText = oSDR("INTERESTTERM") & "<br>Waive"

                    gvInstallment.Columns(9).HeaderText = oSDR("PENALTYTERM")
                    gvInstallment.Columns(10).HeaderText = oSDR("PENALTYTERM") & "<br>Paid"
                    gvInstallment.Columns(11).HeaderText = oSDR("PENALTYTERM") & "<br>Waive"

                End If
                oSDR.Close()
                oSDR = Nothing
                'Catch ex As Exception
            Finally
                objDB.Close()
            End Try
        End If
    End Sub
End Class
