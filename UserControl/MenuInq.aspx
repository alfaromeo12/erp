<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MenuInq.aspx.vb" Inherits="UserControl_MenuInq" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Acc Inq</title>
</head>
<body style="margin-top:0;margin-left:0;" >
    <form id="form1" runat="server" >
    <ajaxToolkit:ToolkitScriptManager ID="ajaxSMInquiry" runat="server">
    </ajaxToolkit:ToolkitScriptManager>
    <div>
        <asp:DataList ID="dlAppData" runat="server"  
            Caption="ACCOUNT DATA" DataSourceID="sdsAccData" Font-Bold="True" Width="100%">
            <ItemTemplate>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td class="HeaderStyle">
                            Cust No.</td>
                        <td class="ErrHighLight">
                            <asp:Label ID="Label53" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTNO") %>'></asp:Label>
                        </td>
                        <td class="HeaderStyle">
                            Cust No (formated)</td>
                        <td class="ShowDetail">
                            <asp:Label ID="Label54" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTNOFORMATED") %>'></asp:Label>
                        </td>
                        <td class="HeaderStyle">
                            Account No.
                        </td>
                        <td class="ErrHighLight">
                            <asp:Label ID="Label6" runat="server" Font-Underline="True" Text='<%# Eval("ACCOUNTNO") %>'></asp:Label></td>
                        <td class="HeaderStyle">
                            Account No. (formated)</td>
                        <td class="ShowDetail">
                            <asp:Label ID="Label13" runat="server" Font-Underline="True" 
                                Text='<%# Eval("ACCCOUNTNOFORMATED") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Account Status</td>
                        <td class="required">
                            (<asp:Label ID="Label1" runat="server" Font-Underline="True" Text='<%# Eval("ACCSTATUS") %>'></asp:Label>)
                            <asp:Label ID="Label2" runat="server" Font-Underline="True" Text='<%# Eval("ACCSTATUSNAME") %>'></asp:Label></td>
                        <td>
                            Booking Date</td>
                        <td>
                            <asp:Label ID="Label10" runat="server" Font-Underline="True" Text='<%# Eval("BOOKINGDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                        <td>
                            Request Date</td>
                        <td>
                            <asp:Label ID="Label7" runat="server" Font-Underline="True" Text='<%# Eval("REQUESTDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                        <td>
                            Ref. No</td>
                        <td>
                            <asp:Label ID="Label14" runat="server" Font-Underline="True" Text='<%# Eval("REFNO") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            Acc ID</td>
                        <td class="FooterStyle">
                            <asp:Label ID="Label42" runat="server" Font-Underline="True" 
                                Text='<%# Eval("LOCID") %>'></asp:Label>
                            &nbsp;-&nbsp;<asp:Label ID="Label43" runat="server" Font-Underline="True" 
                                Text='<%# Eval("ACCID") %>'></asp:Label>
                        </td>
                        <td class="HeaderStyle">
                            Cust ID</td>
                        <td class="FooterStyle">
                            <asp:Label ID="Label51" runat="server" Font-Underline="True" 
                                Text='<%# Eval("LOCIDCUST") %>'></asp:Label>
                            &nbsp;-&nbsp;<asp:Label ID="Label52" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTID") %>'></asp:Label>
                        </td>
                        <td>
                            Close Date</td>
                        <td>
                            <asp:Label ID="Label4" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CLOSEDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </td>
                        <td>
                            Close Txn Date</td>
                        <td>
                            <asp:Label ID="Label5" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CLOSETXNDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="ErrHighLight">
                            Account Name</td>
                        <td colspan="3" class="required">
                            <asp:Label ID="Label3" runat="server" Font-Underline="True" 
                                Text='<%# Eval("ACCOUNTNAME") %>'></asp:Label>
                        </td>
                        <td class="ErrHighLight">
                            Customer Name</td>
                        <td class="required" colspan="3">
                            <asp:Label ID="Label48" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTNAME") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Area</td>
                        <td colspan="3">
                            (<asp:Label ID="Label8" runat="server" Font-Underline="True" Text='<%# Eval("AREACODE") %>'></asp:Label>)
                            <asp:Label ID="Label9" runat="server" Font-Underline="True" Text='<%# Eval("AREANAME") %>'></asp:Label></td>
                        <td>
                            Branch</td>
                        <td colspan="3">
                            (<asp:Label ID="Label16" runat="server" Font-Underline="True" Text='<%# Eval("BRANCHCODE") %>'></asp:Label>)
                            <asp:Label ID="Label17" runat="server" Font-Underline="True" Text='<%# Eval("BRANCHNAME") %>'></asp:Label><asp:LinkButton
                                ID="lbBranch" runat="server" Style="background-image: url(../images/detail.gif);
                                background-repeat: no-repeat; background-color: transparent" ToolTip="Detail Branch"
                                Visible='<%# Eval("BRANCHCHECK") %>'>___</asp:LinkButton><ajaxToolkit:ModalPopupExtender
                                    ID="ajaxMPEMFBranch" runat="server" CancelControlID="btnBranchClose" DropShadow="True"
                                    PopupControlID="pnlBranchInfo" PopupDragHandleControlID="pnlBranchInfo" TargetControlID="lbBranch">
                                </ajaxToolkit:ModalPopupExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="ShowDetail">
                            Finance Category</td>
                        <td class="ShowDetail" colspan="3">
                            (<asp:Label ID="Label46" runat="server" Font-Underline="True" 
                                Text='<%# Eval("FINCATCODE") %>'></asp:Label>)
                            <asp:Label ID="Label47" runat="server" Font-Underline="True" 
                                Text='<%# Eval("FINCATNAME") %>'></asp:Label>
                        </td>
                        <td class="ShowDetail">
                            Cust. Type</td>
                        <td class="ShowDetail" colspan="3">
                            (<asp:Label ID="Label49" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTTYPE") %>'></asp:Label>)
                            <asp:Label ID="Label50" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CUSTTYPENAME") %>'></asp:Label>
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="pnlBranchInfo" runat="server" Width="100%" 
                    CssClass="FooterStyle">
                    <asp:DataList ID="dlBranchInfo" runat="server" Caption="BRANCH INFO" DataKeyField="BRANCHID"
                        DataSourceID="sdsBranchInfo">
                        <ItemTemplate>
                            <table cellpadding="0" cellspacing="0" width="600">
                                <tr>
                                    <td>
                                        Branch Area</td>
                                    <td colspan="3">
                                        (<asp:Label ID="AREACODELabel" runat="server" Font-Underline="True" Text='<%# Eval("AREACODE") %>'></asp:Label>)
                                        <asp:Label ID="AREANAMELabel" runat="server" Font-Underline="True" Text='<%# Eval("AREANAME") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        Branch Code</td>
                                    <td>
                                        <asp:Label ID="BRANCHCODELabel" runat="server" Font-Underline="True" Text='<%# Eval("BRANCHCODE") %>'></asp:Label></td>
                                    <td>
                                        Branch ID</td>
                                    <td>
                                        <asp:Label ID="BRANCHIDLabel" runat="server" Font-Underline="True" Text='<%# Eval("BRANCHID") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td >
                                        Branch Name</td>
                                    <td colspan="3" >
                                        <asp:Label ID="BRANCHNAMELabel" runat="server" Font-Underline="True" Text='<%# Eval("BRANCHNAME") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        Branch Address</td>
                                    <td colspan="3">
                                        <asp:Label ID="BRANCHADDRESSLabel" runat="server" Font-Underline="True" Text='<%# Eval("BRANCHADDRESS") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        City</td>
                                    <td>
                                        <asp:Label ID="BRANCHCITYLabel" runat="server" Font-Underline="True" Text='<%# Eval("BRANCHCITY") %>'></asp:Label></td>
                                    <td>
                                        Zip</td>
                                    <td>
                                        <asp:Label ID="BRANCHZIPLabel" runat="server" Font-Underline="True" Text='<%# Eval("BRANCHZIP") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        Phone</td>
                                    <td>
                                        <asp:Label ID="BRANCHPHONELabel" runat="server" Font-Underline="True" Text='<%# Eval("BRANCHPHONE") %>'></asp:Label></td>
                                    <td>
                                        Fax</td>
                                    <td>
                                        <asp:Label ID="BRANCHFAXLabel" runat="server" Font-Underline="True" Text='<%# Eval("BRANCHFAX") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        Branch Head</td>
                                    <td colspan="3">
                                        <asp:Label ID="BRANCHHEADLabel" runat="server" Font-Underline="True" Text='<%# Eval("BRANCHHEAD") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        Branch Status Active</td>
                                    <td>
                                        <asp:Label ID="ACTIVELabel" runat="server" Text='<%# Eval("ACTIVE") %>'></asp:Label></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsBranchInfo" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        SelectCommand="SELECT BRANCH.BRANCHID, AREA.AREACODE, AREA.AREANAME, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME, BRANCH.BRANCHADDRESS, BRANCH.BRANCHCITY, BRANCH.BRANCHZIP, BRANCH.BRANCHPHONE, BRANCH.BRANCHFAX, BRANCH.BRANCHHEAD, BRANCH.ACTIVE FROM BRANCH WITH (NOLOCK) INNER JOIN ACCOUNT WITH (NOLOCK) ON BRANCH.BRANCHID = ACCOUNT.BRANCHID INNER JOIN AREA WITH (NOLOCK) ON BRANCH.AREAID = AREA.AREAID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.APPID = @APPID)" >
                        <SelectParameters>
                            <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
                            <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:Button ID="btnBranchClose" runat="server" CausesValidation="False" Style="cursor: pointer"
                        Text="Close Branch Info" /></asp:Panel>
            </ItemTemplate>
        </asp:DataList>
        <asp:SqlDataSource ID="sdsAccData" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            SelectCommand="SELECT APPLICATION.LOCID, APPLICATION.APPID, ACCOUNT.ACCID, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME, AREA.AREACODE, AREA.AREANAME, ACCOUNT.BOOKINGDATE, ACCOUNT.INSTALLMENTDAY, APPLICATION.APPSTATE, APPLICATION.REQUESTDATE, APPLICATION.STATUSDATE, ACCOUNT.CLOSEDATE, ACCOUNT.CLOSETXNDATE, ACCOUNT.ACCOUNTNAME, ACCOUNT.ACCSTATUS, ACCOUNT.REFNO, ACCOUNT.ACCOUNTNO, CUSTOMER.LOCIDCUST, dbo.f_FormatCustNoByID(CUSTOMER.BRANCHID, CUSTOMER.CUSTNO) AS CUSTNOFORMATED, CUSTOMER.CUSTNO, CAST(1 AS BIT) AS BRANCHCHECK, CAST(1 AS BIT) AS COMPANYCHECK, dbo.f_FormatAccNoByID(ACCOUNT.BRANCHID, ACCOUNT.ACCOUNTNO) AS ACCCOUNTNOFORMATED, BRANCH.BRANCHCAT, dbo.f_getParamGlobalName('BRANCHCAT', BRANCH.BRANCHCAT) AS BRANCHCATNAME, FINANCECATEGORY.FINCATCODE, FINANCECATEGORY.FINCATNAME, CUSTOMER.CUSTTYPE, dbo.f_getParamGlobalName('CUSTTYPE', CUSTOMER.CUSTTYPE) AS CUSTTYPENAME, CUSTOMER.CUSTNAME, CUSTOMER.CUSTID, dbo.f_getParamGlobalName('ACCSTATUS', ACCOUNT.ACCSTATUS) AS ACCSTATUSNAME FROM ACCOUNT WITH (NOLOCK) INNER JOIN CUSTOMER ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID LEFT OUTER JOIN FINANCECATEGORY ON ACCOUNT.FINCATID = FINANCECATEGORY.FINCATID LEFT OUTER JOIN AREA WITH (NOLOCK) INNER JOIN BRANCH WITH (NOLOCK) ON AREA.AREAID = BRANCH.AREAID ON ACCOUNT.BRANCHID = BRANCH.BRANCHID LEFT OUTER JOIN APPLICATION WITH (NOLOCK) ON ACCOUNT.APPID = APPLICATION.APPID WHERE (APPLICATION.LOCID = @LOCID) AND (APPLICATION.APPID = @APPID)">
            <SelectParameters>
                <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
                <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
            </SelectParameters>
        </asp:SqlDataSource>
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
        <td style="text-align: center; ">
            <asp:HyperLink ID="lnkCust" runat="server" Target="AccInq"
                NavigateUrl="~/FrontEnd/AppInq.aspx" ToolTip="Application Data"  style="border-right: thin outset; border-top: thin outset; border-left: thin outset; border-bottom: thin outset">Application Data</asp:HyperLink></td>
        <td style="text-align: center; ">
            <asp:HyperLink ID="lnkLoan" runat="server" NavigateUrl="~/FrontEnd/AppInq.aspx" Target="AccInq"
                ToolTip="Loan Data" style="border-right: thin outset; border-top: thin outset; border-left: thin outset; border-bottom: thin outset">Loan Data</asp:HyperLink></td>
        <td style="text-align: center; ">
            <asp:HyperLink ID="lnkInstallment" runat="server" NavigateUrl="~/FrontEnd/AppInq.aspx" Target="AccInq"
                ToolTip="Instalment" style="border-right: thin outset; border-top: thin outset; border-left: thin outset; border-bottom: thin outset">Installment</asp:HyperLink></td>
        <td style="text-align: center; border-top-width: thin; border-left-width: thin; border-bottom-width: thin; border-right-width: thin; ">
            <asp:HyperLink ID="lnkColl" runat="server" NavigateUrl="~/FrontEnd/AppInq.aspx" Target="AccInq"
                ToolTip="Collateral" style="border-right: thin outset; border-top: thin outset; border-left: thin outset; border-bottom: thin outset">Collateral</asp:HyperLink></td>
        <td style=" text-align: center">
            <asp:HyperLink ID="lnkInsurance" runat="server" NavigateUrl="~/FrontEnd/AppInq.aspx"
                Style="border-right: thin outset; border-top: thin outset; border-left: thin outset;
                border-bottom: thin outset" Target="AccInq" ToolTip="Insurance">Insurance</asp:HyperLink></td>
        <td style="text-align: center; ">
            <asp:HyperLink ID="lnkActivity" runat="server" NavigateUrl="~/FrontEnd/AppInq.aspx" Target="AccInq"
                Style="border-right: thin outset; border-top: thin outset; border-left: thin outset;
                border-bottom: thin outset"  ToolTip="Activity History">Activity History</asp:HyperLink></td>
        <td style="text-align: center; ">
            <asp:HyperLink ID="lnkCollector" runat="server" NavigateUrl="~/Account/AccInqCollection.aspx" Target="AccInq"
                ToolTip="Collector" style="border-right: thin outset; border-top: thin outset; border-left: thin outset; border-bottom: thin outset">Collection</asp:HyperLink></td>
        <td style="text-align: center; ">
            <asp:HyperLink ID="lnkJF" runat="server" NavigateUrl="~/FrontEnd/AppInq.aspx" Target="AccInq"
                ToolTip="Join Finance" style="border-right: thin outset; border-top: thin outset; border-left: thin outset; border-bottom: thin outset">Join Finance</asp:HyperLink></td>
        </tr>
        <tr>
            <td style="background-position: center top; background-image: url(../Images/icon_customer.png);
                background-repeat: no-repeat;  text-align: center; height:35px">
                &nbsp;</td>
            <td style="background-position: center top; background-image: url(../Images/icon_angsuran.png);
                background-repeat: no-repeat; text-align: center">
            </td>
            <td style="background-position: center top; background-image: url(../Images/icon_pinjaman.png);
                background-repeat: no-repeat; text-align: center">
            </td>
            <td style="border-top-width: thin; background-position: center top; border-left-width: thin;
                background-image: url(../Images/icon_collateral.gif); border-bottom-width: thin;
                background-repeat: no-repeat; text-align: center; border-right-width: thin">
            </td>
            <td style="background-position: center top; background-image: url(../Images/icon_asuransi.gif);
                background-repeat: no-repeat; text-align: center">
            </td>
            <td style="background-position: center top; background-image: url(../Images/icon_activity_history.png);
                background-repeat: no-repeat; text-align: center">
            </td>
            <td style="background-position: center top; background-image: url(../Images/icon_Collector.png);
                background-repeat: no-repeat; text-align: center">
            </td>
            <td style="background-position: center top; background-image: url(../Images/icon_join_finance.gif);
                background-repeat: no-repeat; text-align: center">
            </td>
        </tr>
    </table>

    </div>
    </form>
    <script type="text/javascript">
        var i = 0;
    function BackAcc(){
        if (parent) {
            for (j = 0; j <= i; j++) {
                parent.history.back();
            }
        }

    }
    function LinkClick(){
        i= i + 1;
    }
    
    function JFInfo(JFID){
        var winref = window.open("../Account/JFInfo.aspx?JFID=" + JFID, "JFInfo", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable");
        winref.focus();
    }
    </script>
    
</body>
</html>
