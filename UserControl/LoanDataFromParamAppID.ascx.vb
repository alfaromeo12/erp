
Partial Class UserControl_LoanDataFromParamAppID
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
            sdsLoanData.SelectParameters("LOCID").DefaultValue = value
        End Set
    End Property

    Public Property APPID() As String
        Get
            'Return txtAPPID.Value
            Return 0
        End Get
        Set(value As String)
            'txtAPPID.Value = value
            sdsLoanData.SelectParameters("APPID").DefaultValue = value
        End Set
    End Property

End Class
