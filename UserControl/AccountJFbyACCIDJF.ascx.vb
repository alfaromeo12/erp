
Partial Class UserControl_AccountJFbyACCIDJF
    Inherits System.Web.UI.UserControl

    Public Property ACCIDJF() As String
        Get
            Return 0
        End Get
        Set(value As String)
            sdsJF.SelectParameters("ACCIDJF").DefaultValue = value
        End Set
    End Property
End Class
