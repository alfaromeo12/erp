

Partial Public Class UserControl_DataAccountFromParamAccIDOS
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
            sdsAppID.SelectParameters("LOCID").DefaultValue = value
        End Set
    End Property
    Public Property ACCID() As String
        Get
            'Return txtACCID.Value
            Return 0
        End Get
        Set(value As String)
            'txtACCID.Value = value
            sdsAppID.SelectParameters("ACCID").DefaultValue = value
        End Set
    End Property
End Class
