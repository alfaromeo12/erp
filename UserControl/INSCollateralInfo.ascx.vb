
Partial Class UserControl_INSCollateralInfo
    Inherits System.Web.UI.UserControl

    Public Property LOCID() As String
        Get
            'Return txtLOCID.Value
            Return 0
        End Get
        Set(value As String)
            'txtLOCID.Value = value
            sdsCollateralInfo.SelectParameters("LOCID").DefaultValue = value
        End Set
    End Property
    Public Property ACCID() As String
        Get
            'Return txtACCID.Value
            Return 0
        End Get
        Set(value As String)
            'txtACCID.Value = value
            sdsCollateralInfo.SelectParameters("ACCID").DefaultValue = value
        End Set
    End Property
End Class
