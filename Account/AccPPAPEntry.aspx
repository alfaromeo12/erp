<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccPPAPEntry.aspx.vb" Inherits="Account_AccPPAPEntry" title="Account PPAP Value Entry" MaintainScrollPositionOnPostback="true"%>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<%@ Register src="../UserControl/DataAccountFromParamAccID.ascx" tagname="DataAccountFromParamAccID" tagprefix="uc2" %>
<%@ Register src="../UserControl/CollectibilityParamAccID.ascx" tagname="CollectibilityParamAccID" tagprefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:HiddenField ID="txtAction" runat="server" />
    <asp:HiddenField ID="hidLocID" runat="server" />
    <asp:HiddenField ID="hidAccID" runat="server" />
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
        <asp:GridView ID="gvInstallment" runat="server" AllowSorting="True" AutoGenerateColumns="False"
            Caption="INSTALLMENT DUE DATA" DataSourceID="sdsInstallment" Width="100%">
            <Columns>
                <asp:BoundField DataField="PERIOD" HeaderText="PER" SortExpression="PERIOD">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="DUEDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="DUE&lt;br&gt;DATE"
                    HtmlEncode="False" SortExpression="DUEDATE">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="PRINCIPAL" DataFormatString="{0:N}" HeaderText="PRINCIPAL"
                    HtmlEncode="False" SortExpression="PRINCIPAL">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="INTEREST" DataFormatString="{0:N}" HeaderText="INTEREST"
                    HtmlEncode="False" SortExpression="INTEREST">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:CheckBoxField DataField="PAIDSTS" HeaderText="PAID&lt;br&gt;STS" SortExpression="PAIDSTS">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:CheckBoxField>
                <asp:BoundField DataField="PRINCIPALPAID" DataFormatString="{0:N}" HeaderText="PRINCIPAL&lt;BR&gt;PAID"
                    HtmlEncode="False" SortExpression="PRINCIPALPAID">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="INTERESTPAID" DataFormatString="{0:N}" HeaderText="INTEREST&lt;BR&gt;PAID"
                    HtmlEncode="False" SortExpression="INTERESTPAID">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="PAIDDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="PAID&lt;br&gt;DATE"
                    HtmlEncode="False" SortExpression="PAIDDATE">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="PAIDTXNDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="PAID&lt;br&gt;TXNDATE"
                    HtmlEncode="False" SortExpression="PAIDTXNDATE">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="PENALTY" DataFormatString="{0:N}" HeaderText="PENALTY"
                    HtmlEncode="False" SortExpression="PENALTY">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="PENALTYDAY" HeaderText="DUE&lt;BR&gt;DAY" HtmlEncode="False"
                    SortExpression="PENALTYDAY">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="PENALTYPAID" DataFormatString="{0:N}" HeaderText="PENALTY&lt;br&gt;PAID"
                    HtmlEncode="False" SortExpression="PENALTYPAID">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="PENALTYWAIVE" DataFormatString="{0:N}" HeaderText="PENALTY&lt;br&gt;WAIVE"
                    HtmlEncode="False" SortExpression="PENALTYWAIVE">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
            </Columns>
            <EmptyDataTemplate>
                <uc1:nodatafound id="NoDataFound1" runat="server">
</uc1:nodatafound>
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsInstallment" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            
            SelectCommand="SELECT LOCID, ACCID, ACCOUNTNO, ACCOUNTNOFORM, BRANCHID,  DUEDATE, PERIOD, PRINCIPAL, INTEREST, PAIDSTS, PRINCIPALPAID, INTERESTPAID, PAIDDATE, PAIDTXNDATE, PENALTYDAY, PENALTYSTS, PENALTYREAL, PENALTY, PENALTYPAID, PENALTYWAIVE FROM dbo.f_AccInstalmentDueList(@LOCID, @ACCID, DEFAULT) WHERE (DUEDATE &lt;= dbo.f_getAppDate()) ORDER BY PERIOD">
            <SelectParameters>
                <asp:Parameter Name="LOCID" />
                <asp:Parameter Name="ACCID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="HeaderStyle" colspan="4" style="text-align: center">
                ACCOUNT PPAP Value Entry</td>
        </tr>
        <tr>
            <td class="RowStyle" style="width: 203px">
                PPAP Value</td>
            <td class="AlternatingRowStyle" colspan="3">
                <asp:TextBox ID="txtPPAP" runat="server" CssClass="required" Style="text-align: right"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="reqPPAP" runat="server" ControlToValidate="txtPPAP" Display="None" ErrorMessage="PPAP VALUE must be entry...!"
                    SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                        ID="ajaxVCEPPAP" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPPAP">
                    </ajaxToolkit:ValidatorCalloutExtender>
            </td>
        </tr>
        <tr>
            <td style="width: 203px">
                &nbsp;</td>
            <td>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td style="width: 203px">
                &nbsp;</td>
            <td>
            </td>
            <td>
            </td>
            <td>
            </td>
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
        <asp:Button ID="btnSave" runat="server" Style="background-position: right; background-image: url(../Images/Save.gif);
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Save" Width="64px" />
        <asp:Button ID="btnCancel" runat="server" CausesValidation="False"
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
    //if ((GetValueTxtByClientID("<%=txtAction.ClientID%>")=="INQ") || (GetValueTxtByClientID("<%=txtAction.ClientID%>")=="PAY")){
        window.history.back(-1);
        return false;
    //}
    return true;
}

    </script>
    
</asp:Content>

