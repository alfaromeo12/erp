
Partial Class Account_PayInfoDetail
    Inherits System.Web.UI.Page
    Public Shared strScript As String

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            hidINVOICECHECK.Value = "0"
            strScript = ""
            ctlLoanDataFromParamAccID.LOCID = Request.QueryString("LOCID")
            ctlLoanDataFromParamAccID.ACCID = Request.QueryString("ACCID")

            ctlDataAccountFromParamAccID.LOCID = Request.QueryString("LOCID")
            ctlDataAccountFromParamAccID.ACCID = Request.QueryString("ACCID")

            hidLOCIDPAY.Value = Request.QueryString("LOCIDPAY")
            hidPAYID.Value = Request.QueryString("PAYID")
            hidUID.Value = Request.Cookies("UID").Value
            hidACTION.Value = Request.QueryString("Action")
            ajaxCPEAccData.Collapsed = True
            ajaxCPELoanData.Collapsed = True
            lblMessage.Visible = False
            If hidACTION.Value = "Reverse" Then
                btnClose.Visible = False
                btnReverse.Visible = True
                btnBack.Visible = True
            ElseIf hidACTION.Value = "INQ" Then
                btnClose.Visible = False
                btnReverse.Visible = False
                btnBack.Visible = True
            ElseIf hidACTION.Value = "REPRINT" Then
                btnClose.Visible = False
                btnReverse.Visible = False
                btnBack.Visible = True
                btnPrint.Visible = True
                lblPrint.Visible = True
                txtInvoiceNo.Visible = True

                Dim objDB As New DBX

                Dim oSDR As System.Data.SqlClient.SqlDataReader
                Try
                    oSDR = objDB.CreateSDRFromSQLSelect("SELECT REVSTATUS FROM PAYMENT WITH(NOLOCK) WHERE LOCIDPAY=" & hidLOCIDPAY.Value & " AND PAYID=" & hidPAYID.Value)
                    If oSDR.Read() Then
                        If oSDR("REVSTATUS") Then
                            btnPrint.Visible = False
                            lblPrint.Visible = False
                            txtInvoiceNo.Visible = False
                        End If
                    End If
                    oSDR.Close()
                    oSDR = Nothing
                Catch ex As Exception
                    lblMessage.Visible = True
                    lblMessage.Text = "ERROR LOADING REPRINT INVOICE..!<BR>PLEASE CHECK DETAIL ERROR MESSAGE: " & ex.Message

                Finally
                    objDB.Close()
                    objDB = Nothing
                End Try

            End If

        End If

        txtInvoiceNo.Attributes.Add("onchange", "CheckInvoice();")

    End Sub

    Protected Sub btnReverse_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReverse.Click
        Dim objpay As New Payment
        Try
            lblMessage.Visible = True
            Dim intRetVal As Integer
            intRetVal = objpay.PAYMENTReversal(Request.QueryString("LOCIDPAY"), _
                    Request.QueryString("PAYID"), Request.Cookies("UID").Value)
            If intRetVal = -1 Then
                lblMessage.Text = "TRANSACTION ALREADY REVERSE...!<BR>PLEASE CHECK TRANSACTION IN TRANSACTION INQUIRY...!"
                btnReverse.Visible = False
                lblMessage.Focus()
            ElseIf intRetVal = -2 Then
                'lblMessage.Text = "THERE IS OLD TRANSACTION MUST BE REVERSE FIRST...!<BR>THIS TRANSACTION CANNOT BE REVERSED...!"
                lblMessage.Text = "THERE IS A NEWER TRANSACTION MUST BE REVERSE FIRST...!<BR>THIS TRANSACTION CANNOT BE REVERSED...!"
                btnReverse.Visible = False
                lblMessage.Focus()
            Else
                Response.Redirect("../Pay/PayReversalList.aspx")
            End If
        Catch ex As Exception
            lblMessage.Text = "REVERSE ERROR : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE....!"
            lblMessage.Focus()
        Finally
            objpay = Nothing
        End Try
    End Sub

    Protected Sub btnPrint_Click(sender As Object, e As System.EventArgs) Handles btnPrint.Click
        lblMessage.Visible = False
        Dim objdB As New DBX
        Try
            If hidINVOICECHECK.Value = "1" Then
                lblMessage.Visible = True
                lblMessage.Text = "INVOICE NUMBER MUST BE REGISTERED..!<BR>RE-PRINT INVOICE CAN NOT BE DONE..!"
            Else
                objdB.ExecSP("[INVOICEPAPERReprintInstallment]", _
                    objdB.MP("@INVPAPERID", Data.SqlDbType.BigInt, hidINVPAPERID.Value), _
                    objdB.MP("@LOCIDPAY", Data.SqlDbType.Int, hidLOCIDPAY.Value), _
                    objdB.MP("@PAYID", Data.SqlDbType.BigInt, hidPAYID.Value), _
                    objdB.MP("@USERID", Data.SqlDbType.VarChar, Request.Cookies("UID").Value) _
                )

                strScript = ""
                strScript = strScript & "var winref=window.open('" & "../Reports/ReportViewerCrystal.aspx?Report=/Printing/rptCshKuitansi.rpt&stsprn=1&Prompt1=" & hidLOCIDPAY.Value & "&Prompt2=" & hidPAYID.Value & "', 'RePrint', 'height=400,width=550,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes');" & Chr(13)
                strScript = strScript & "winref.focus();" & Chr(13)
                strScript = strScript & "window.location='../Pay/PayAccInqList.aspx?ACTION=" & hidACTION.Value & "';" & Chr(13)

            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR RE-PRINT INVOICE...!<BR>PLEASE CHECK DETAIL ERROR MESSAGE: <BR>" & ex.Message
        Finally
            objdB.Close()
            objdB = Nothing
        End Try
    End Sub
End Class
