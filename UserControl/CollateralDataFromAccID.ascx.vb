
Partial Class UserControl_CollateralDataFromAccID
    Inherits System.Web.UI.UserControl


    Public Property LOCID() As String
        Get
            Return 0
        End Get
        Set(value As String)
            sdsCollateralData.SelectParameters("LOCID").DefaultValue = value
        End Set
    End Property

    Public Property ACCID() As String
        Get
            Return 0
        End Get
        Set(value As String)
            sdsCollateralData.SelectParameters("ACCID").DefaultValue = value
        End Set
    End Property
End Class
