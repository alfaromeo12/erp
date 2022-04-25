
Partial Class Account_InsuranceInq
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("Action") = "InqAcc" Then
            ajaxCPELoanData.Collapsed = True
        End If
        If Not IsPostBack Then
            Dim objDB As New DBX
            Try
                Dim oSDR As System.Data.SqlClient.SqlDataReader
                oSDR = objDB.CreateSDRFromSQLSelect("SELECT LOCID, ACCID FROM ACCOUNT WITH(NOLOCK) WHERE LOCID=" & Request.QueryString("LOCID") & " AND APPID=" & Request.QueryString("APPID"))
                If oSDR.Read() Then
                    hidLOCID.Value = oSDR("LOCID")
                    hidACCID.Value = oSDR("ACCID")
                End If
                oSDR.Close()
                oSDR = Nothing

                oSDR = objDB.CreateSDRFromSQLSelect("SELECT POLISID FROM INSURANCE WITH(NOLOCK) WHERE LOCID=" & hidLOCID.Value & " AND ACCID=" & hidACCID.Value)
                If oSDR.Read() Then
                    pnlInsOld.Visible = False
                    pnlInsNew.Visible = True
                Else
                    pnlInsOld.Visible = True
                    pnlInsNew.Visible = False
                End If
                oSDR.Close()
                oSDR = Nothing

                ctlLoanDataFromParamAccID.LOCID = hidLOCID.Value
                ctlLoanDataFromParamAccID.ACCID = hidACCID.Value

                'Catch ex As Exception
            Finally
                objDB.Close()
                objDB = Nothing

            End Try
        End If
    End Sub


End Class
