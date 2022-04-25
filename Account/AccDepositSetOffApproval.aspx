<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccDepositSetOffApproval.aspx.vb" Inherits="Account_AccDepositSetOffApp" title="Account Deposit Set Off Approval" MaintainScrollPositionOnPostback="true"%>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<%@ Register src="../UserControl/DataAccountFromParamAccID.ascx" tagname="DataAccountFromParamAccID" tagprefix="uc2" %>
<%@ Register src="../UserControl/CollectibilityParamAccID.ascx" tagname="CollectibilityParamAccID" tagprefix="uc3" %>
<%@ Register src="../UserControl/InstallmentDataDue.ascx" tagname="InstallmentDataDue" tagprefix="uc4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:HiddenField ID="txtAction" runat="server" />
    <asp:HiddenField ID="hidLocID" runat="server" />
    <asp:HiddenField ID="hidAccID" runat="server" />
    <asp:HiddenField ID="hidDepID" runat="server" />
    <uc2:DataAccountFromParamAccID ID="ctlDataAccountFromParamAccID" 
        runat="server" />
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
    <asp:Panel ID="pnlInstShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgInstData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblInstData" runat="server" CssClass="required">(Show Installment Due Data...)</asp:Label>
        </div>
        <input id="Button2" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEInst" runat="server" CollapseControlID="pnlInstShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Installment Due Data...)"
        Enabled="True" ExpandControlID="pnlInstShow" ExpandedImage="~/images/collapse.jpg"
        ExpandedText="(Hide Installment Due Data...)" ImageControlID="imgInstData" TargetControlID="pnlInstData"
        TextLabelID="lblInstData">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlInstData" runat="server"  Width="100%">
        <uc4:InstallmentDataDue ID="ctlInstallmentDataDue" runat="server" />
    </asp:Panel>
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="HeaderStyle" colspan="4" style="text-align: center">
                ACCOUNT Deposit Set Off Value Entry</td>
        </tr>
        <tr>
            <td class="RowStyle" style="width: 203px">
                Deposit Value</td>
            <td class="AlternatingRowStyle" colspan="3">
                <asp:TextBox ID="txtDeposit" runat="server" CssClass="disabled" 
                    Style="text-align: right" ReadOnly="True"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="RowStyle" style="width: 203px">
                Deposit Set Off</td>
            <td class="AlternatingRowStyle" colspan="3">
                <asp:TextBox ID="txtDepositSetOff" runat="server" CssClass="disabled" 
                    Style="text-align: right"></asp:TextBox><asp:RequiredFieldValidator
                    ID="reqDepositSetOff" runat="server" ControlToValidate="txtDepositSetOff" 
                    Display="None" ErrorMessage="DEPOSIT SET OFF VALUE must be entry...!"
                    SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                        ID="ajaxVCEPPAP" runat="server" HighlightCssClass="ErrHighLight" 
                    TargetControlID="reqDepositSetOff">
                    </ajaxToolkit:ValidatorCalloutExtender>
            </td>
        </tr>
        <tr>
            <td class="RowStyle" style="width: 203px">
                Deposit Remain</td>
            <td class="AlternatingRowStyle" colspan="3">
                <asp:TextBox ID="txtDepositRemain" runat="server" CssClass="disabled" 
                    Style="text-align: right" ReadOnly="True"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="ShowDetail" colspan="4">
                    <hr  />
                </td>
        </tr>
        <tr>
            <td class="RowStyle" style="width: 203px">
                Set Off Txn Date</td>
            <td class="AlternatingRowStyle" colspan="3">
                <asp:Label ID="lblTxnDate" runat="server" 
                    style="text-decoration: underline; font-weight: 700"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="RowStyle" style="width: 203px">
                Set Off Status</td>
            <td class="AlternatingRowStyle" colspan="3">
                <asp:Label ID="lblSetOffStatus" runat="server" 
                    style="font-weight: bold; text-decoration: underline"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="RowStyle" style="width: 203px">
                Txn Type</td>
            <td class="AlternatingRowStyle" colspan="3">
                <asp:Label ID="lblTxnType" runat="server" 
                    style="font-weight: bold; text-decoration: underline"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="RowStyle" style="width: 203px">
                Bank Account No.</td>
            <td class="AlternatingRowStyle" colspan="3">
                <asp:Label ID="lblBankAccNo" runat="server" 
                    style="font-weight: bold; text-decoration: underline"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="RowStyle" style="width: 203px">
                Remark</td>
            <td class="AlternatingRowStyle" colspan="3">
                <asp:Label ID="lblRemark" runat="server" 
                    style="font-weight: bold; text-decoration: underline"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 203px">
                &nbsp;&nbsp;</td>
            <td>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td style="width: 203px">
                &nbsp;&nbsp;</td>
            <td>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td style="width: 203px">
                &nbsp;&nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td style="width: 203px">
                &nbsp;&nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>

    <asp:Panel ID="pnlSave" runat="server" CssClass="FooterStyle" Width="100%">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td colspan="2">
                    <hr />
                </td>
            </tr>
        </table>
        <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" 
            Font-Bold="True" Font-Underline="True" Style="text-align: center" 
            Visible="False" Width="100%"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblMessage">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
        <asp:Button ID="btnApprove" runat="server" OnClientClick="return (confirm(&quot;Are you sure want to Approve Deposit Set Off..?&quot;));" 
            Style="background-position: right; background-image: url(../Images/ok.png); cursor: pointer; background-repeat: no-repeat; text-align: left; " 
            Text="Approve" ValidationGroup="ViewAcc" Visible="False" Width="88px" />
        <asp:Button ID="btnReject" runat="server" CausesValidation="False" 
            Style="background-position: right; background-image: url(../Images/stop.png); cursor: pointer; background-repeat: no-repeat; text-align: left; " 
            Text="Reject" ValidationGroup="ViewAcc" Visible="False" Width="88px" 
            onclientclick="return(confirm(&quot;Are you sure want to Reject Deposit Set Off...?&quot;));" />
        <asp:Button ID="btnCancel" runat="server" CausesValidation="False" OnClientClick="return BackEdit();"
            Style="background-position: right; background-image: url(../Images/back.png);
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Back" Width="88px" /></asp:Panel>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEBorrow" runat="server" TargetControlID="pnlSave"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
    <script type="text/javascript">
    function getObjectbyClientID(ClientID){
        var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        return(oObject)
    }
    function GetValueTxtByClientID(ClientID){
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
        if (oText)
            return(oText.value);
    }
    
    function ViewDetailAcc(LOCID, APPID){
        var winref=window.open("AccInqFrame.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable")
        winref.focus();
    }
    function BackEdit(){
        window.location = "AccDepositSetOffAppList.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>");
        return false;
    }

    </script>
    
</asp:Content>

