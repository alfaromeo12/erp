
Partial Class UserControl_MenuInq
    Inherits System.Web.UI.Page
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim strLocID As String = Request.QueryString("LOCID")
        Dim strAppID As String = Request.QueryString("APPID")
        lnkCust.NavigateUrl = "~/FrontEnd/AppInq.aspx?Action=InqAcc&LOCID=" + strLocID & "&APPID=" & strAppID
        lnkCust.Target = "AccInq"
        lnkCust.Attributes.Add("onclick", "LinkClick();")
        'lnkCust.ImageUrl = "~/Images/icon_customer.gif"
        'lnkCust.Width = "40"
        'lnkCust.Height = "40"

        lnkLoan.NavigateUrl = "~/Account/LoanDataInq.aspx?Action=InqAcc&LOCID=" + strLocID & "&APPID=" & strAppID
        lnkLoan.Target = "AccInq"
        lnkLoan.Attributes.Add("onclick", "LinkClick();")
        'lnkLoan.ImageUrl = "~/Images/icon_pinjaman.gif"
        'lnkLoan.Width = "40"
        'lnkLoan.Height = "40"


        lnkInstallment.NavigateUrl = "~/Account/InstallmentInq.aspx?Action=InqAcc&LOCID=" + strLocID & "&APPID=" & strAppID
        lnkInstallment.Target = "AccInq"
        lnkInstallment.Attributes.Add("onclick", "LinkClick();")
        'lnkInstallment.ImageUrl = "~/Images/icon_Angsuran.gif"
        'lnkInstallment.Width = "40"
        'lnkInstallment.Height = "40"

        lnkColl.NavigateUrl = "~/Account/CollateralInq.aspx?Action=InqAcc&LOCID=" + strLocID & "&APPID=" & strAppID
        lnkColl.Target = "AccInq"
        lnkColl.Attributes.Add("onclick", "LinkClick();")
        'lnkTP.ImageUrl = "~/Images/icon_over_kredit.gif"
        'lnkTP.Width = "40"
        'lnkTP.Height = "40"

        lnkActivity.NavigateUrl = "~/Account/ActHistoryInq.aspx?Action=InqAcc&LOCID=" + strLocID & "&APPID=" & strAppID
        lnkActivity.Target = "AccInq"
        lnkActivity.Attributes.Add("onclick", "LinkClick();")

        lnkJF.NavigateUrl = "~/Account/JFInq.aspx?Action=InqAcc&LOCID=" + strLocID & "&APPID=" & strAppID
        lnkJF.Target = "AccInq"
        lnkJF.Attributes.Add("onclick", "LinkClick();")

        lnkCollector.NavigateUrl = "~/Account/AccInqCollection.aspx?Action=InqAcc&LOCID=" + strLocID & "&APPID=" & strAppID
        lnkCollector.Target = "AccInq"
        lnkCollector.Attributes.Add("onclick", "LinkClick();")
        
        lnkInsurance.NavigateUrl = "~/Account/InsuranceInq.aspx?Action=InqAcc&LOCID=" + strLocID & "&APPID=" & strAppID
        lnkInsurance.Target = "AccInq"
        lnkInsurance.Attributes.Add("onclick", "LinkClick();")

    End Sub
End Class
