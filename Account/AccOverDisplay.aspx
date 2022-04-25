<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccOverDisplay.aspx.vb" Inherits="Account_AccOverApp" title="Account Over Credit Approval" MaintainScrollPositionOnPostback="true"%>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<%@ Register src="../UserControl/DataAccountFromParamAccID.ascx" tagname="DataAccountFromParamAccID" tagprefix="uc2" %>
<%@ Register src="../UserControl/CollectibilityParamAccID.ascx" tagname="CollectibilityParamAccID" tagprefix="uc3" %>
<%@ Register src="../UserControl/LoanDataFromParamAccID.ascx" tagname="loandatafromparamaccid" tagprefix="uc1" %>
<%@ Register src="../UserControl/InstallmentDataAll.ascx" tagname="InstallmentDataAll" tagprefix="uc4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:SqlDataSource ID="sdsAppID" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
    
        
        SelectCommand="SELECT ACCOUNT.LOCID, ACCOUNT.ACCID, APPLICATION.APPID, CUSTOMER.CUSTID, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCOUNTNOFORMAT, ACCOUNT.ACCOUNTNO, CUSTOMER.CUSTNO, APPLICATION.ROWLOCK, CUSTOMER.CUSTTYPE, dbo.f_getParamGlobalName('CUSTTYPE', CUSTOMER.CUSTTYPE) AS CUSTYPENAME, CUSTOMER.CUSTADDRESS, CUSTOMER.CUSTCITY, CUSTOMER.CUSTZIP, CUSTOMER.IDNUMBER, ACCOUNT.BOOKINGDATE, ACCOUNT.ACCOUNTNAME, ACCOUNT.REFNO, dbo.f_FormatCustNo(BRANCH.BRANCHCODE, CUSTOMER.CUSTNO) AS CUSTNOFORMAT, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME, FINANCECATEGORY.FINCATCODE, FINANCECATEGORY.FINCATNAME, ACCOUNT.LOCIDCUST, dbo.f_FormatCustNo(BRANCH.BRANCHCODE, CUSTOMER.CUSTNO) AS CUSTNOFORMAT, dbo.f_getParamGlobalName('CUSTTYPE', CUSTOMER.CUSTTYPE) AS CUSTYPENAME, CUSTOMER.CUSTNAME, AREA.AREACODE, AREA.AREANAME FROM ACCOUNT WITH (NOLOCK) INNER JOIN APPLICATION WITH (NOLOCK) ON ACCOUNT.LOCID = APPLICATION.LOCID AND ACCOUNT.APPID = APPLICATION.APPID INNER JOIN CUSTOMER WITH (NOLOCK) ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID LEFT OUTER JOIN FINANCECATEGORY ON ACCOUNT.FINCATID = FINANCECATEGORY.FINCATID LEFT OUTER JOIN BRANCH WITH (NOLOCK) ON ACCOUNT.BRANCHID = BRANCH.BRANCHID LEFT OUTER JOIN AREA WITH (NOLOCK) ON AREA.AREAID = BRANCH.AREAID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.ACCID = @ACCID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="hidLocID" Name="LOCID" PropertyName="Value" />
            <asp:ControlParameter ControlID="hidAccID" Name="ACCID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>    
    <asp:HiddenField ID="txtAction" runat="server" />
    <asp:HiddenField ID="hidLocID" runat="server" />
    <asp:HiddenField ID="hidAccID" runat="server" />
    <asp:HiddenField ID="hidOverID" runat="server" />
    <asp:HiddenField ID="hidTxnDate" runat="server" />
    <uc2:DataAccountFromParamAccID ID="ctlDataAccountFromParamAccID" 
        runat="server" />
    <asp:Panel ID="pnlLoanShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgLoanData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblLoanData" runat="server" CssClass="required">(Show Loan Data...)</asp:Label>
        </div>
        <input id="Button5" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <asp:Panel ID="pnlLoanData" runat="server"  
        Font-Bold="True" Width="100%">
        <uc1:LoanDataFromParamAccID ID="ctlLoanDataFromParamAccID" runat="server" />
    </asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPELoanData" runat="server" CollapseControlID="pnlLoanShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Loan Data...)" Enabled="True"
        ExpandControlID="pnlLoanShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Loan Data...)"
        ImageControlID="imgLoanData" TargetControlID="pnlLoanData" TextLabelID="lblLoanData">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlCollectShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgCollect" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblCollect" runat="server" CssClass="required">(Show Collectibility Data...)</asp:Label>
        </div>
        <input id="Button3" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPECollect" runat="server" CollapseControlID="pnlCollectShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Collectibility Data...)"
        Enabled="True" ExpandControlID="pnlCollectShow" ExpandedImage="~/images/collapse.jpg"
        ExpandedText="(Hide Collectibility Data...)" ImageControlID="imgCollect" TargetControlID="pnlCollectData"
        TextLabelID="lblCollect">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlCollectData" runat="server"  
        Font-Bold="True" Width="100%">
        <uc3:CollectibilityParamAccID ID="ctlCollectibilityParamAccID" runat="server" />
    </asp:Panel>
    <asp:Panel ID="pnlInstShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgInstData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblInstData" runat="server" CssClass="required">(Show Installment Data...)</asp:Label>
        </div>
        <input id="Button2" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" language="javascript" /></asp:Panel>
    <asp:Panel ID="pnlInstData" runat="server" Width="100%">
        <asp:Button ID="btnPrintLoan" runat="server" 
            OnClientClick="return PrintLoan();" 
            Style="background-position: right; background-image: url('../Images/print.jpg'); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
            Text="Print Installment Data" Width="150px" />
        <asp:Button ID="btnPrintInst" runat="server" 
            OnClientClick="return PrintInst();" 
            Style="background-position: right; background-image: url('../Images/print.jpg'); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
            Text="Print Installment History" Width="150px" />
        <uc4:InstallmentDataAll ID="ctlInstallmentDataAll" runat="server" />
    </asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEInst" runat="server" CollapseControlID="pnlInstShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Installment Data...)" Enabled="True"
        ExpandControlID="pnlInstShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Installment Data...)"
        ImageControlID="imgInstData" TargetControlID="pnlInstData" TextLabelID="lblInstData">
    </ajaxToolkit:CollapsiblePanelExtender>
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="RowStyle">
                &nbsp;</td>
        </tr>
    </table>
    <asp:Panel ID="pnlEffRate" runat="server">
        <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="RowStyle">
                <hr />
            </td>
        </tr>
        <tr>
            <td class="ShowDetail">
                <asp:DataList ID="dlOver" runat="server" Caption="OVER CREDIT INFO" 
                    DataKeyField="LOCID" DataSourceID="sdsOverCredit" Width="100%">
                    <ItemTemplate>
                        <table cellpadding="0" cellspacing="0" style="width: 100%;">
                            <tr>
                                <td>
                                    ID</td>
                                <td>
                                    <asp:Label ID="OVERIDLabel" runat="server" 
                                        style="font-weight: bold; text-decoration: underline" 
                                        Text='<%# Eval("OVERID") %>' />
                                </td>
                                <td>
                                    Over Credit Date</td>
                                <td>
                                    <asp:Label ID="OVERDATELabel" runat="server" 
                                        style="font-weight: bold; text-decoration: underline" 
                                        Text='<%# Eval("OVERDATE", "{0:dd/MM/yyyy}") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    OS Principal</td>
                                <td>
                                    <asp:Label ID="OSPRINCIPALLabel" runat="server" 
                                        style="font-weight: bold; text-decoration: underline" 
                                        Text='<%# Eval("OSPRINCIPAL", "{0:N}") %>' />
                                </td>
                                <td>
                                    OS Interest</td>
                                <td>
                                    <asp:Label ID="OSINTERESTLabel" runat="server" 
                                        style="font-weight: bold; text-decoration: underline" 
                                        Text='<%# Eval("OSINTEREST", "{0:N}") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    OS Tenor</td>
                                <td>
                                    <asp:Label ID="OSTENORLabel" runat="server" 
                                        style="font-weight: bold; text-decoration: underline" 
                                        Text='<%# Eval("OSTENOR") %>' />
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    Status</td>
                                <td>
                                    (<asp:Label ID="OVERSTATUSLabel" runat="server" 
                                        style="font-weight: bold; text-decoration: underline" 
                                        Text='<%# Eval("OVERSTATUS") %>' />)
                                        <asp:Label ID="OVERSTATUSNAMELabel" runat="server" 
                                        style="font-weight: bold; text-decoration: underline" 
                                        Text='<%# Eval("OVERSTATUSNAME") %>' />
                                </td>
                                <td>
                                    Status Date</td>
                                <td>
                                    <asp:Label ID="STATUSDATELabel" runat="server" 
                                        style="font-weight: bold; text-decoration: underline" 
                                        Text='<%# Eval("STATUSDATE", "{0:dd/MM/yyyy}") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td class="HeaderStyle">
                                    Old Customer</td>
                                <td class="ErrHighLight" colspan="3">
                                    &nbsp;<asp:Label ID="OLDLOCIDCUSTLabel" runat="server" 
                                        style="font-weight: bold; text-decoration: underline" 
                                        Text='<%# Eval("OLDLOCIDCUST") %>' />
                                    &nbsp;-
                                    <asp:Label ID="OLDCUSTIDLabel" runat="server" 
                                        style="font-weight: bold; text-decoration: underline" 
                                        Text='<%# Eval("OLDCUSTID") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td class="FooterStyle">
                                    Cust No</td>
                                <td class="FooterStyle" colspan="3">
                                    <asp:Label ID="OLDCUSTNOLabel" runat="server" 
                                        style="font-weight: 700; text-decoration: underline" 
                                        Text='<%# Eval("OLDCUSTNO") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td class="FooterStyle">
                                    Cust Name</td>
                                <td class="FooterStyle" colspan="3">
                                    <asp:Label ID="OLDCUSTNAMELabel" runat="server" style="font-weight: bold" 
                                        Text='<%# Eval("OLDCUSTNAME") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td class="HeaderStyle">
                                    New Customer</td>
                                <td class="ErrHighLight" colspan="3">
                                    <asp:Label ID="NEWLOCIDCUSTLabel" runat="server" 
                                        style="font-weight: bold; text-decoration: underline" 
                                        Text='<%# Eval("NEWLOCIDCUST") %>' />
                                    &nbsp;-
                                    <asp:Label ID="NEWCUSTIDLabel" runat="server" 
                                        style="font-weight: bold; text-decoration: underline" 
                                        Text='<%# Eval("NEWCUSTID") %>' />
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="FooterStyle">
                                    Cust No</td>
                                <td class="FooterStyle" colspan="3">
                                    <asp:Label ID="NEWCUSTNOLabel" runat="server" 
                                        style="font-weight: bold; text-decoration: underline" 
                                        Text='<%# Eval("NEWCUSTNO") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td class="FooterStyle">
                                    Cust Name</td>
                                <td class="FooterStyle" colspan="3">
                                    <asp:Label ID="NEWCUSTNAMELabel" runat="server" 
                                        style="font-weight: bold; text-decoration: underline" 
                                        Text='<%# Eval("NEWCUSTNAME") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Remark</td>
                                <td colspan="3">
                                    <asp:Label ID="REMARKLabel" runat="server" 
                                        style="font-weight: bold; text-decoration: underline" 
                                        Text='<%# Eval("REMARK") %>' />
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsOverCredit" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    SelectCommand="SELECT OVERCREDIT.LOCID, OVERCREDIT.ACCID, OVERCREDIT.OVERID, OVERCREDIT.OVERDATE, OVERCREDIT.OSPRINCIPAL, OVERCREDIT.OSINTEREST, OVERCREDIT.OSTENOR, OVERCREDIT.OVERSTATUS, dbo.f_getParamGlobalName('OVERSTATUS', OVERCREDIT.OVERSTATUS) AS OVERSTATUSNAME, OVERCREDIT.STATUSDATE, OVERCREDIT.REMARK, CUSTOMER_1.CUSTNAME AS OLDCUSTNAME, CUSTOMER.CUSTNAME AS NEWCUSTNAME, OVERCREDIT.OLDLOCIDCUST, OVERCREDIT.OLDCUSTID, OVERCREDIT.NEWLOCIDCUST, OVERCREDIT.NEWCUSTID, dbo.f_FormatCustNoByID(CUSTOMER_1.BRANCHID, CUSTOMER_1.CUSTNO) AS OLDCUSTNO, dbo.f_FormatCustNoByID(CUSTOMER.BRANCHID, CUSTOMER.CUSTNO) AS NEWCUSTNO FROM OVERCREDIT WITH (NOLOCK) INNER JOIN CUSTOMER AS CUSTOMER_1 WITH (NOLOCK) ON OVERCREDIT.OLDLOCIDCUST = CUSTOMER_1.LOCIDCUST AND OVERCREDIT.OLDCUSTID = CUSTOMER_1.CUSTID INNER JOIN CUSTOMER WITH (NOLOCK) ON OVERCREDIT.NEWLOCIDCUST = CUSTOMER.LOCIDCUST AND OVERCREDIT.NEWCUSTID = CUSTOMER.CUSTID WHERE (OVERCREDIT.LOCID = @LOCID) AND (OVERCREDIT.ACCID = @ACCID) AND (OVERCREDIT.OVERID = @OVERID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hidLocID" Name="LOCID" PropertyName="Value" />
                        <asp:ControlParameter ControlID="hidAccID" Name="ACCID" PropertyName="Value" />
                        <asp:ControlParameter ControlID="hidOverID" Name="OVERID" 
                            PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
            <tr>
                <td class="RowStyle">
                    <hr />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <br />
    <br />
    <asp:Panel ID="pnlSave" runat="server" CssClass="FooterStyle" Width="100%">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td colspan="2">
                    <hr />
                </td>
            </tr>
        </table>
        <asp:Button ID="btnApprove" runat="server" 
            OnClientClick="return(confirm(&quot;Are you sure want to APPROVE OVER CREDIT Account..?&quot;));" 
            Style="background-position: right; background-image: url(../Images/ok.png); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
            Text="Approve" ValidationGroup="ViewAcc" Visible="False" Width="88px" />
        <asp:Button ID="btnReject" runat="server" CausesValidation="False" 
            OnClientClick="return(confirm(&quot;Are you sure want to REJECT OVER CREDIT Account..?&quot;));" 
            Style="background-position: right; background-image: url(../Images/stop.png); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
            Text="Reject" ValidationGroup="ViewAcc" Visible="False" Width="88px" />
        <asp:Button ID="btnCancel" runat="server" CausesValidation="False" OnClientClick="return BackEdit();"
            Style="background-position: right; background-image: url(../Images/back.png);
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Back" Width="88px" />
        <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" Font-Bold="True"
            Visible="False"></asp:Label></asp:Panel>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblMessage">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEBorrow" runat="server" TargetControlID="pnlSave"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
    <script type="text/javascript">
    function getObjectbyClientID(ClientID) {
        var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        return(oObject)
    }
    function SetValueTxtByClientID(ClientID, sValue) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            oText.value = sValue;
    }
    function GetValueTxtByClientID(ClientID){
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
        if (oText)
            return(oText.value);
    }
    
    function ViewDetailAcc(LOCID, APPID){
        var winref = window.open("AccInqFrame.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable");
        winref.focus();
    }
    function BackEdit(){
        //window.location = "AccOverList.aspx";
        window.history.back(-1);
        return(false);
    }

    function PrintLoan() {
        var LOCID = GetValueTxtByClientID("<%=hidLocID.ClientID%>");
        var ACCID = GetValueTxtByClientID("<%=hidAccID.ClientID%>");
        var TXNDATE = GetValueTxtByClientID("<%=hidTxnDate.ClientID%>");
        var winref = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/InstallmentAccount&LOCID=" + LOCID + "&ACCID=" + ACCID + "&TXNDATE=" + TXNDATE, "PrintInstData", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
        winref.focus();
        return false;
    }
    function PrintInst() {
        var LOCID = GetValueTxtByClientID("<%=hidLocID.ClientID%>");
        var ACCID = GetValueTxtByClientID("<%=hidAccID.ClientID%>");
        var winref = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/Installment_History&LOCID=" + LOCID + "&ACCID=" + ACCID, "PrintInstHist", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
        winref.focus();
        return false;
    }

    </script>
    
</asp:Content>

