
Partial Class UserControl_CollectibilityParamAccID
    Inherits System.Web.UI.UserControl
    'sdsAccData.SelectParameters("LOCID").DefaultValue = strLocID
    'sdsAccData.SelectParameters("ACCID").DefaultValue = strAccID

    Public Property LOCID() As String
        Get
            'Return txtLOCID.Value
            Return 0
        End Get
        Set(value As String)
            'txtLOCID.Value = value
            sdsCollect.SelectParameters("LOCID").DefaultValue = value
        End Set
    End Property
    Public Property ACCID() As String
        Get
            'Return txtACCID.Value
            Return 0
        End Get
        Set(value As String)
            'txtACCID.Value = value
            sdsCollect.SelectParameters("ACCID").DefaultValue = value
        End Set
    End Property
End Class
