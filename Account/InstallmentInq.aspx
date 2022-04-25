<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="InstallmentInq.aspx.vb" Inherits="Account_LoanDataInq" title="Installment Inquiry" %>
<%@ Register src="../UserControl/CollectibilityParamAccID.ascx" tagname="CollectibilityParamAccID" tagprefix="uc2" %>
<%@ Register src="../UserControl/LoanDataFromParamAccID.ascx" tagname="LoanDataFromParamAccID" tagprefix="uc1" %>
<%@ Register src="../UserControl/InstallmentDataAll.ascx" tagname="InstallmentDataAll" tagprefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:HiddenField ID="hiLocID" runat="server" />
    <asp:HiddenField ID="hiACCID" runat="server" />
    <asp:HiddenField ID="hiTXNDATE" runat="server" />
    <asp:Panel ID="pnlLoanShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgLoanData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblLoanData" runat="server" CssClass="required">(Show Loan Data...)</asp:Label>
        </div>
        <input id="Button5" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPELoanData" runat="server" CollapseControlID="pnlLoanShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Loan Data...)" Enabled="True"
        ExpandControlID="pnlLoanShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Loan Data...)"
        ImageControlID="imgLoanData" TargetControlID="pnlLoanData" TextLabelID="lblLoanData">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlLoanData" runat="server" Width="100%">
        <uc1:LoanDataFromParamAccID ID="ctlLoanDataFromParamAccID" runat="server" />
    </asp:Panel>
    <asp:Panel ID="pnlCollectShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgCollect" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblCollect" runat="server" CssClass="required">(Show Collectibility Data...)</asp:Label>
        </div>
        <input id="Button1" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPECollect" runat="server" CollapseControlID="pnlCollectShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Collectibility Data...)"
        Enabled="True" ExpandControlID="pnlCollectShow" ExpandedImage="~/images/collapse.jpg"
        ExpandedText="(Hide Collectibility Data...)" ImageControlID="imgCollect" TargetControlID="pnlCollectData"
        TextLabelID="lblCollect">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlCollectData" runat="server" Width="100%">
        <uc2:CollectibilityParamAccID ID="ctlCollectibilityParamAccID" runat="server" />
    </asp:Panel>
    <asp:Panel ID="pnlInstShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgInstData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblInstData" runat="server" CssClass="required">(Show Installment Data...)</asp:Label>
        </div>
        <input id="Button2" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" language="javascript" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEInst" runat="server" CollapseControlID="pnlInstShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Installment Data...)" Enabled="True"
        ExpandControlID="pnlInstShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Installment Data...)"
        ImageControlID="imgInstData" TargetControlID="pnlInstData" TextLabelID="lblInstData">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlInstData" runat="server"   Width="100%">
        <asp:Button ID="btnPrintLoan" runat="server" 
            OnClientClick="return PrintLoan();" 
            Style="background-position: right; background-image: url('../Images/print.jpg'); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
            Text="Print Installment Data" Width="150px" />
        <asp:Button ID="btnPrintInst" runat="server" 
            OnClientClick="return PrintInst();" 
            Style="background-position: right; background-image: url('../Images/print.jpg'); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
            Text="Print Installment History" Width="150px" />
        <uc3:InstallmentDataAll ID="ctlInstallmentDataAll" runat="server" />
    </asp:Panel>
<script type="text/javascript">
function PrintLoan() {
    var LOCID = GetValueTxtByClientID("<%=hiLoCID.ClientID%>");
    var ACCID = GetValueTxtByClientID("<%=hiACCID.ClientID%>");
    var TXNDATE = GetValueTxtByClientID("<%=hiTXNDATE.ClientID%>");
    var winref = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/InstallmentAccount&LOCID=" + LOCID + "&ACCID=" + ACCID + "&TXNDATE=" + TXNDATE, "PrintInstData", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
    winref.focus();
    return false;
}
function PrintInst() {
    var LOCID = GetValueTxtByClientID("<%=hiLoCID.ClientID%>");
    var ACCID = GetValueTxtByClientID("<%=hiACCID.ClientID%>");
    var winref = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/Installment_History&LOCID=" + LOCID + "&ACCID=" + ACCID, "PrintInstHist", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
    winref.focus();
    return false;
}

function GetValueTxtByClientID(ClientID) {
    var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
    if (oText)
        return (oText.value);
}


</script>
</asp:Content>

