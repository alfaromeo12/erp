<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccOverEntry.aspx.vb" Inherits="Account_AccOverEntry" title="Account Over Credit Entry" MaintainScrollPositionOnPostback="true"%>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<%@ Register src="../UserControl/DataAccountFromParamAccID.ascx" tagname="DataAccountFromParamAccID" tagprefix="uc2" %>
<%@ Register src="../UserControl/CollectibilityParamAccID.ascx" tagname="CollectibilityParamAccID" tagprefix="uc3" %>
<%@ Register src="../UserControl/LoanDataFromParamAccID.ascx" tagname="loandatafromparamaccid" tagprefix="uc1" %>
<%@ Register src="../UserControl/InstallmentDataAll.ascx" tagname="InstallmentDataAll" tagprefix="uc4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:SqlDataSource ID="sdsAppID" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT ACCOUNT.LOCID, ACCOUNT.ACCID, APPLICATION.APPID, CUSTOMER.CUSTID, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCOUNTNOFORMAT, ACCOUNT.ACCOUNTNO, CUSTOMER.CUSTNO, APPLICATION.ROWLOCK, CUSTOMER.CUSTTYPE, dbo.f_getParamGlobalName('CUSTTYPE', CUSTOMER.CUSTTYPE) AS CUSTYPENAME, CUSTOMER.CUSTADDRESS, CUSTOMER.CUSTCITY, CUSTOMER.CUSTZIP, CUSTOMER.IDNUMBER, ACCOUNT.BOOKINGDATE, ACCOUNT.ACCOUNTNAME, ACCOUNT.REFNO, dbo.f_FormatCustNo(BRANCH.BRANCHCODE, CUSTOMER.CUSTNO) AS CUSTNOFORMAT, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME, FINANCECATEGORY.FINCATCODE, FINANCECATEGORY.FINCATNAME, ACCOUNT.LOCIDCUST, dbo.f_FormatCustNo(BRANCH.BRANCHCODE, CUSTOMER.CUSTNO) AS CUSTNOFORMAT, dbo.f_getParamGlobalName('CUSTTYPE', CUSTOMER.CUSTTYPE) AS CUSTYPENAME, CUSTOMER.CUSTNAME, BRANCH.BRANCHCODE AS Expr1, BRANCH.BRANCHNAME AS Expr2, AREA.AREACODE, AREA.AREANAME FROM ACCOUNT WITH (NOLOCK) INNER JOIN APPLICATION WITH (NOLOCK) ON ACCOUNT.LOCID = APPLICATION.LOCID AND ACCOUNT.APPID = APPLICATION.APPID INNER JOIN CUSTOMER WITH (NOLOCK) ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID LEFT OUTER JOIN FINANCECATEGORY ON ACCOUNT.FINCATID = FINANCECATEGORY.FINCATID LEFT OUTER JOIN BRANCH WITH (NOLOCK) ON ACCOUNT.BRANCHID = BRANCH.BRANCHID LEFT OUTER JOIN AREA WITH (NOLOCK) ON AREA.AREAID = BRANCH.AREAID WHERE (APPLICATION.LOCID = @LOCID) AND (APPLICATION.APPID = @APPID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
            <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
        </SelectParameters>
    </asp:SqlDataSource>    
    <asp:HiddenField ID="txtAction" runat="server" />
    <asp:HiddenField ID="hidLocID" runat="server" />
    <asp:HiddenField ID="hidAccID" runat="server" />
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
                <asp:FormView ID="fvAccOverInfo" runat="server" 
                    Caption="Account Over Credit Info" DataSourceID="sdsOverInfo"
                    Width="100%">
                    <EditItemTemplate>
                        BOOKINGDATE:
                        <asp:TextBox ID="BOOKINGDATETextBox" runat="server" Text='<%# Eval("BOOKINGDATE") %>'>
                        </asp:TextBox><br />
                        INSTALLMENTREAL:
                        <asp:TextBox ID="INSTALLMENTREALTextBox" runat="server" Text='<%# Eval("INSTALLMENTREAL") %>'>
                        </asp:TextBox><br />
                        CLOSEDATE:
                        <asp:TextBox ID="CLOSEDATETextBox" runat="server" Text='<%# Eval("CLOSEDATE") %>'>
                        </asp:TextBox><br />
                        FLATRATE:
                        <asp:TextBox ID="FLATRATETextBox" runat="server" Text='<%# Eval("FLATRATE") %>'>
                        </asp:TextBox><br />
                        OSPRINCIPAL:
                        <asp:TextBox ID="OSPRINCIPALTextBox" runat="server" Text='<%# Eval("OSPRINCIPAL") %>'>
                        </asp:TextBox><br />
                        OSTENOR:
                        <asp:TextBox ID="OSTENORTextBox" runat="server" Text='<%# Eval("OSTENOR") %>'>
                        </asp:TextBox><br />
                        OSINTEREST:
                        <asp:TextBox ID="OSINTERESTTextBox" runat="server" Text='<%# Eval("OSINTEREST") %>'>
                        </asp:TextBox><br />
                        PRINCIPALTOTAL:
                        <asp:TextBox ID="PRINCIPALTOTALTextBox" runat="server" Text='<%# Eval("PRINCIPALTOTAL") %>'>
                        </asp:TextBox><br />
                        INTERESTTOTAL:
                        <asp:TextBox ID="INTERESTTOTALTextBox" runat="server" Text='<%# Eval("INTERESTTOTAL") %>'>
                        </asp:TextBox><br />
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                            Text="Update">
                        </asp:LinkButton>
                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                            Text="Cancel">
                        </asp:LinkButton>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        BOOKINGDATE:
                        <asp:TextBox ID="BOOKINGDATETextBox" runat="server" Text='<%# Eval("BOOKINGDATE") %>'>
                        </asp:TextBox><br />
                        INSTALLMENTREAL:
                        <asp:TextBox ID="INSTALLMENTREALTextBox" runat="server" Text='<%# Eval("INSTALLMENTREAL") %>'>
                        </asp:TextBox><br />
                        CLOSEDATE:
                        <asp:TextBox ID="CLOSEDATETextBox" runat="server" Text='<%# Eval("CLOSEDATE") %>'>
                        </asp:TextBox><br />
                        FLATRATE:
                        <asp:TextBox ID="FLATRATETextBox" runat="server" Text='<%# Eval("FLATRATE") %>'>
                        </asp:TextBox><br />
                        OSPRINCIPAL:
                        <asp:TextBox ID="OSPRINCIPALTextBox" runat="server" Text='<%# Eval("OSPRINCIPAL") %>'>
                        </asp:TextBox><br />
                        OSTENOR:
                        <asp:TextBox ID="OSTENORTextBox" runat="server" Text='<%# Eval("OSTENOR") %>'>
                        </asp:TextBox><br />
                        OSINTEREST:
                        <asp:TextBox ID="OSINTERESTTextBox" runat="server" Text='<%# Eval("OSINTEREST") %>'>
                        </asp:TextBox><br />
                        PRINCIPALTOTAL:
                        <asp:TextBox ID="PRINCIPALTOTALTextBox" runat="server" Text='<%# Eval("PRINCIPALTOTAL") %>'>
                        </asp:TextBox><br />
                        INTERESTTOTAL:
                        <asp:TextBox ID="INTERESTTOTALTextBox" runat="server" Text='<%# Eval("INTERESTTOTAL") %>'>
                        </asp:TextBox><br />
                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                            Text="Insert">
                        </asp:LinkButton>
                        <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                            Text="Cancel">
                        </asp:LinkButton>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    Booking Date</td>
                                <td>
                                    <asp:Label ID="BOOKINGDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Eval("BOOKINGDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Installment Start</td>
                                <td>
                                    <asp:Label ID="label1" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("INSTALLMENTSTART", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </td>
                                <td>
                                    Installment End</td>
                                <td>
                                    <asp:Label ID="label19" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("INSTALLMENTEND", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblPrincipal" runat="server" Text='<%# Eval("CATPRINCIPAL") %>'></asp:Label>
                                    &nbsp;Total</td>
                                <td>
                                    <asp:Label ID="PRINCIPALTOTALLabel" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("PRINCIPALTOTAL", "{0:N}") %>'></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblInterestTotal" runat="server" 
                                        Text='<%# Eval("CATINTEREST") %>'></asp:Label>
                                    &nbsp;Total</td>
                                <td>
                                    <asp:Label ID="INTERESTTOTALLabel" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("INTERESTTOTAL", "{0:N}") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Tenor</td>
                                <td>
                                    <asp:Label ID="Label18" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("TENOR") %>'></asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="FooterStyle">
                                    OS
                                    <asp:Label ID="lblOSPrincipal" runat="server" 
                                        Text='<%# Eval("CATPRINCIPAL") %>'></asp:Label>
                                </td>
                                <td class="FooterStyle">
                                    <asp:Label ID="OSPRINCIPALLabel" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("OSPRINCIPAL", "{0:N}") %>'></asp:Label>
                                </td>
                                <td class="FooterStyle">
                                    OS
                                    <asp:Label ID="lblInterest" runat="server" Text='<%# Eval("CATINTEREST") %>'></asp:Label>
                                </td>
                                <td class="FooterStyle">
                                    <asp:Label ID="OSINTERESTLabel" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("OSINTEREST", "{0:N}") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="FooterStyle">
                                    OS Tenor</td>
                                <td class="FooterStyle">
                                    <asp:Label ID="OSTENORLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Eval("OSTENOR") %>'></asp:Label></td>
                                <td class="FooterStyle">
                                </td>
                                <td class="FooterStyle">
                                </td>
                            </tr>
                            <tr>
                                <td class="required">
                                    Installment</td>
                                <td class="required" colspan="3">
                                    <asp:Label ID="INSTALLMENTREALLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Eval("INSTALLMENTREAL", "{0:N}") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblEffectiveRate" runat="server" 
                                        Text='<%# Eval("CATEFFECTIVE") %>'></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label17" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("EFFECTIVERATE") %>'></asp:Label>
                                    %</td>
                                <td>
                                    Flat Rate</td>
                                <td>
                                    <asp:Label ID="FLATRATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Eval("FLATRATE") %>'></asp:Label>
                                    %</td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="sdsOverInfo" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    
                    
                    
                    
                    SelectCommand="SELECT ACCOUNT.BOOKINGDATE, ACCOUNT.INSTALLMENTREAL, ACCOUNT.FLATRATE, ACCOUNT.OSPRINCIPALREAL AS OSPRINCIPAL, ACCOUNT.TENOR - (SELECT COUNT(*) AS Expr1 FROM INSTALLMENT AS INSTALLMENT_2 WITH (NOLOCK) WHERE (ACCOUNT.LOCID = LOCID) AND (ACCOUNT.ACCID = ACCID) AND (DUEDATE &lt;= dbo.f_getAppDate())) AS OSTENOR, ACCOUNT.OSINTERESTREAL AS OSINTEREST, ACCOUNT.PRINCIPALTOTAL, ACCOUNT.INTERESTTOTAL, ACCOUNT.EFFECTIVERATE, ACCOUNT.TENOR, ACCOUNTDTL.INSTALLMENTSTART, ACCOUNTDTL.INSTALLMENTEND, dbo.f_getTermPrincipal(ACCOUNT.FINCATID) AS CATPRINCIPAL, dbo.f_getTermEffective(ACCOUNT.FINCATID) AS CATEFFECTIVE, dbo.f_getTermInterest(ACCOUNT.FINCATID) AS CATINTEREST FROM ACCOUNT WITH (NOLOCK) INNER JOIN ACCOUNTDTL WITH (NOLOCK) ON ACCOUNT.LOCID = ACCOUNTDTL.LOCID AND ACCOUNT.ACCID = ACCOUNTDTL.ACCID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.ACCID = @ACCID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hidLocID" Name="LOCID" PropertyName="Value" />
                        <asp:ControlParameter ControlID="hidAccID" Name="ACCID" PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="RowStyle">
                &nbsp;</td>
        </tr>
    </table>
    <asp:Panel ID="pnlEffRate" runat="server">
        <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="RowStyle" colspan="2">
                <hr />
            </td>
        </tr>
        <tr>
            <td class="ShowDetail" style="width: 263px">
                NEW CUSTOMER</td>
            <td class="ShowDetail">
                <asp:TextBox ID="txtCustName" runat="server" CssClass="disabled" 
                    Width="295px" ReadOnly="True"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqCustName" runat="server" ControlToValidate="txtCustName"
                    Display="None" ErrorMessage="NEW CUSTOMER must be entry...!" SetFocusOnError="True"
                    ValidationGroup="ValSave"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                        ID="ajaxVCEEffRate" runat="server" HighlightCssClass="ErrHighLight" 
                    TargetControlID="reqCustName">
                    </ajaxToolkit:ValidatorCalloutExtender>
                <asp:Button ID="btnSearch" runat="server" Text="Search Customer" 
                    onclientclick="return SearchCustomer();" />
            </td>
        </tr>
        <tr>
            <td class="ShowDetail" style="width: 263px">
                Remark</td>
            <td class="ShowDetail">
                <asp:TextBox ID="txtRemark" runat="server" Height="80px" TextMode="MultiLine" 
                    Width="258px"></asp:TextBox>
            </td>
        </tr>
            <tr>
                <td class="RowStyle" colspan="2">
                    <hr />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:HiddenField ID="hidLocIDCust" runat="server" />
    <asp:HiddenField ID="hidCustID" runat="server" />
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
        <asp:Button ID="btnSave" runat="server" Style="background-position: right; background-image: url(../Images/Save.gif);
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Save" ValidationGroup="ValSave" Width="64px" />
        <asp:Button ID="btnCancel" runat="server" CausesValidation="False" OnClientClick="return BackEdit();"
            Style="background-position: right; background-image: url(../Images/back.png);
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Back" Width="88px" />
        <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" Font-Bold="True"
            Visible="False"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblMessage">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>            
            </asp:Panel>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEBorrow" runat="server" TargetControlID="pnlSave"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
    <script type="text/javascript">
    function getObjectbyClientID(ClientID){
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
    function SearchCustomer() {
        var winref = window.open("../Cust/CustInqList.aspx?Edit=99", "SearchCust", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable");
        winref.focus();
        return (false);
        
    }

    function setCustomer(LOCIDUCST, CUSTID, CUSTNO, CUSTNAME) {
        SetValueTxtByClientID("<%=txtCustName.ClientID%>", "(" + CUSTNO + ") " + CUSTNAME);
        SetValueTxtByClientID("<%=hidLocIDCust.ClientID %>", LOCIDUCST);
        SetValueTxtByClientID("<%=hidCustID.ClientID %>", CUSTID);
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

