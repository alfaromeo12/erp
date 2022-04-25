
Partial Class UserControl_CollateralDataFromOBJID
    Inherits System.Web.UI.UserControl


    Public Property LOCID() As String
        Get
            Return 0
        End Get
        Set(value As String)
            sdsCollateralData.SelectParameters("LOCID").DefaultValue = value
        End Set
    End Property

    Public Property OBJID() As String
        Get
            Return 0
        End Get
        Set(value As String)
            sdsCollateralData.SelectParameters("OBJID").DefaultValue = value
        End Set
    End Property
End Class
