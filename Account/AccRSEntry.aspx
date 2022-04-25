<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccRSEntry.aspx.vb" Inherits="Account_AccRSEntry" title="Account Reschedule Entry" MaintainScrollPositionOnPostback="true"%>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<%@ Register src="../UserControl/DataAccountFromParamAccIDOS.ascx" tagname="DataAccountFromParamAccIDOS" tagprefix="uc2" %>
<%@ Register src="../UserControl/CollectibilityParamAccID.ascx" tagname="CollectibilityParamAccID" tagprefix="uc3" %>
<%@ Register src="../UserControl/LoanDataFromParamAccID.ascx" tagname="loandatafromparamaccid" tagprefix="uc1" %>
<%@ Register src="../UserControl/InstallmentDataAll.ascx" tagname="InstallmentDataAll" tagprefix="uc4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">

    <asp:HiddenField ID="txtAction" runat="server" />
    <asp:HiddenField ID="hidLocID" runat="server" />
    <asp:HiddenField ID="hidAccID" runat="server" />
    <asp:HiddenField ID="hidTxnDate" runat="server" />
    <asp:HiddenField ID="hidRSType" runat="server" />
    <uc2:DataAccountFromParamAccIDOS ID="ctlDataAccountFromParamAccIDOS" 
        runat="server" />
    <asp:Panel ID="pnlLoanShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgLoanData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblLoanData" runat="server" CssClass="required">(Show Loan Data...)</asp:Label>
        </div>
        <input id="Button5" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <asp:Panel ID="pnlLoanData" runat="server" Width="100%">
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
    <asp:Panel ID="pnlCollectData" runat="server" Width="100%">
        <uc3:CollectibilityParamAccID ID="ctlCollectibilityParamAccID" runat="server" />
    </asp:Panel>
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="RowStyle">
    <asp:Panel ID="pnlInstShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgInstData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblInstData" runat="server" CssClass="required">(Show Installment Data...)</asp:Label>
        </div>
        <input id="Button2" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" language="javascript" /></asp:Panel>
    <asp:Panel ID="pnlInstData" runat="server"  Width="100%">
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
                <asp:FormView ID="fvAccRSInfo" runat="server" Caption="Account Reschedule Info" DataSourceID="sdsRSInfo"
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
                                    Installment Type</td>
                                <td>
                                    (<asp:Label ID="Label20" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("INSTALLMENTTYPE") %>'></asp:Label>)
                                    <asp:Label ID="Label21" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("INSTALLMENTTYPENAME") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="ErrHighLight">
                                    <asp:Label ID="lblPrincipal" runat="server" Text='<%# Eval("CATPRINCIPAL") %>'></asp:Label>
                                    &nbsp;Total</td>
                                <td class="ErrHighLight">
                                    <asp:Label ID="PRINCIPALTOTALLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Eval("PRINCIPALTOTAL", "{0:N}") %>'></asp:Label></td>
                                <td>
                                    <asp:Label ID="lblInterest" runat="server" Text='<%# Eval("CATINTEREST") %>'></asp:Label>
                                    &nbsp;Total</td>
                                <td>
                                    <asp:Label ID="INTERESTTOTALLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Eval("INTERESTTOTAL", "{0:N}") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td class="ErrHighLight">
                                    Tenor</td>
                                <td class="ErrHighLight">
                                    <asp:Label ID="Label18" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("TENOR") %>'></asp:Label>
                                </td>
                                <td>
                                    Residual Value</td>
                                <td>
                                    <asp:Label ID="Label19" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("RESIDUALVALUE", "{0:N}") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="FooterStyle">
                                    OS
                                    <asp:Label ID="lblPrincipalCurrent" runat="server" 
                                        Text='<%# Eval("CATPRINCIPAL") %>'></asp:Label>
                                    &nbsp;Current</td>
                                <td class="FooterStyle">
                                    <asp:Label ID="OSPRINCIPALLabel" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("OSPRINCIPAL", "{0:N}") %>'></asp:Label>
                                </td>
                                <td class="FooterStyle">
                                    OS
                                    <asp:Label ID="lblOSInterest" runat="server" Text='<%# Eval("CATINTEREST") %>'></asp:Label>
                                    &nbsp;Current</td>
                                <td class="FooterStyle">
                                    <asp:Label ID="OSINTERESTLabel" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("OSINTEREST", "{0:N}") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="FooterStyle">
                                    OS Tenor Current</td>
                                <td class="FooterStyle">
                                    <asp:Label ID="OSTENORLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Eval("OSTENOR") %>'></asp:Label></td>
                                <td class="FooterStyle">
                                    Installment Day</td>
                                <td class="FooterStyle">
                                    <asp:Label ID="Label22" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("INSTALLMENTDAY") %>'></asp:Label>
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
                                <td class="ErrHighLight">
                                    <asp:Label ID="lblEffective" runat="server" Text='<%# Eval("CATEFFECTIVE") %>'></asp:Label>
                                </td>
                                <td class="ErrHighLight">
                                    <asp:Label ID="Label17" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("EFFECTIVERATE") %>'></asp:Label>
                                    %</td>
                                <td class="ErrHighLight">
                                    Flat Rate</td>
                                <td class="ErrHighLight">
                                    <asp:Label ID="FLATRATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Eval("FLATRATE") %>'></asp:Label>
                                    %</td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="sdsRSInfo" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    
                    
                    
                    
                    
                    SelectCommand="SELECT BOOKINGDATE, INSTALLMENTREAL, FLATRATE, PRINCIPALTOTAL - (SELECT ISNULL(SUM(PRINCIPAL), 0) AS Expr1 FROM INSTALLMENT WITH (NOLOCK) WHERE (ACCOUNT.LOCID = LOCID) AND (ACCOUNT.ACCID = ACCID) AND (DUEDATE &lt;= dbo.f_getAppDate())) AS OSPRINCIPAL, TENOR - (SELECT COUNT(*) AS Expr1 FROM INSTALLMENT AS INSTALLMENT_2 WITH (NOLOCK) WHERE (ACCOUNT.LOCID = LOCID) AND (ACCOUNT.ACCID = ACCID) AND (DUEDATE &lt;= dbo.f_getAppDate())) AS OSTENOR, INTERESTTOTAL - (SELECT ISNULL(SUM(INTEREST), 0) AS Expr1 FROM INSTALLMENT AS INSTALLMENT_1 WITH (NOLOCK) WHERE (ACCOUNT.LOCID = LOCID) AND (ACCOUNT.ACCID = ACCID) AND (DUEDATE &lt;= dbo.f_getAppDate())) AS OSINTEREST, PRINCIPALTOTAL, INTERESTTOTAL, EFFECTIVERATE, TENOR, RESIDUALVALUE, INSTALLMENTTYPE, dbo.f_getParamGlobalName('INSTALLMENTTYPE', INSTALLMENTTYPE) AS INSTALLMENTTYPENAME, dbo.f_getTermPrincipal(FINCATID) AS CATPRINCIPAL, dbo.f_getTermInterest(FINCATID) AS CATINTEREST, dbo.f_getTermEffective(FINCATID) AS CATEFFECTIVE, INSTALLMENTDAY FROM ACCOUNT WITH (NOLOCK) WHERE (LOCID = @LOCID) AND (ACCID = @ACCID)">
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
    <asp:Panel ID="pnlEffRate" runat="server" Visible="False">
        <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="RowStyle" colspan="4">
                <hr />
            </td>
        </tr>
        <tr>
            <td class="ShowDetail" style="width: 263px">
                New Effective Rate</td>
            <td class="ShowDetail" colspan="3">
                <asp:TextBox ID="txtEffRate" runat="server" CssClass="required" Style="text-align: right" Width="71px"></asp:TextBox>
                %<asp:RequiredFieldValidator ID="reqEffRate" runat="server" ControlToValidate="txtEffRate"
                    Display="None" ErrorMessage="NEW EFFECTIVE RATE must be entry...!" SetFocusOnError="True"
                    ValidationGroup="ValSave"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                        ID="ajaxVCEEffRate" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqEffRate">
                    </ajaxToolkit:ValidatorCalloutExtender>
            </td>
        </tr>
        <tr>
            <td class="RowStyle" colspan="4">
                <hr />
            </td>
        </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="pnlTenor" runat="server" Visible="False">
        <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="RowStyle" colspan="4">
                <hr />
            </td>
        </tr>
        <tr>
            <td class="ShowDetail" style="width: 263px">
                New Tenor</td>
            <td class="ShowDetail" colspan="3">
                <asp:TextBox ID="txtNewTenor" runat="server" CssClass="required" Width="30px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqNewTenor" runat="server" ControlToValidate="txtNewTenor"
                    Display="None" ErrorMessage="NEW TENOR must be entry...!" SetFocusOnError="True"
                    ValidationGroup="ValSave"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                        ID="ajaxVCENewTenor" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqNewTenor">
                    </ajaxToolkit:ValidatorCalloutExtender>
            </td>
        </tr>
        <tr>
            <td class="RowStyle" colspan="4">
                <hr />
            </td>
        </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="pnlPrincipal" runat="server" Visible="False">
        <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="RowStyle" colspan="4">
                <hr />
            </td>
        </tr>
        <tr>
            <td class="ShowDetail" style="width: 263px">
                New Principal Total</td>
            <td class="ShowDetail" colspan="3">
                <asp:TextBox ID="txtNewPrincipal" runat="server" CssClass="required" Style="text-align: right"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqNewPrincipal" runat="server" ControlToValidate="txtNewPrincipal"
                    Display="None" ErrorMessage="NEW PRINCIPAL TOTAL must be entry...!" SetFocusOnError="True"
                    ValidationGroup="ValSave"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                        ID="ajaxVCENewPrincipal" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqNewPrincipal">
                    </ajaxToolkit:ValidatorCalloutExtender>
            </td>
        </tr>
        <tr>
            <td class="RowStyle" colspan="4">
                <hr />
            </td>
        </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="pnlInstDay" runat="server" Visible="False">
        <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="RowStyle" colspan="4">
                <hr />
            </td>
        </tr>
        <tr>
            <td class="ShowDetail" style="width: 263px">
                New Installment Day</td>
            <td class="ShowDetail" colspan="3">
                <asp:TextBox ID="txtNewInstDay" runat="server" CssClass="required" Width="30px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqNewInstDay" runat="server" ControlToValidate="txtNewInstDay"
                    Display="None" ErrorMessage="NEW INSTALLMENT DAY must be entry...!" SetFocusOnError="True"
                    ValidationGroup="ValSave"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                        ID="ajaxVCENewTenor0" runat="server" HighlightCssClass="ErrHighLight" 
                    TargetControlID="reqNewTenor">
                    </ajaxToolkit:ValidatorCalloutExtender>
            </td>
        </tr>
        <tr>
            <td class="RowStyle" colspan="4">
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

     function getObjectbyClientID(ClientID) {
        var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        return(oObject)
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
    //if ((GetValueTxtByClientID("<%=txtAction.ClientID%>")=="INQ") || (GetValueTxtByClientID("<%=txtAction.ClientID%>")=="PAY")){
        //window.history.back(-1);
        var RSType = GetValueTxtByClientID("<%=hidRSType.ClientID%>");
        window.location = "AccRSList.aspx?RSType=" + RSType;
        return false;
    //}
    return true;
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