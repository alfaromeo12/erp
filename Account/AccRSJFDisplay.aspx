<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccRSJFDisplay.aspx.vb" Inherits="Account_AccRSJFDisplay" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<%@ Register src="../UserControl/AccountJFbyACCIDJF.ascx" tagname="AccountJFbyACCIDJF" tagprefix="uc2" %>
<%@ Register src="../UserControl/DataAccountFromParamAccIDOS.ascx" tagname="DataAccountFromParamAccIDOS" tagprefix="uc3" %>
<%@ Register src="../UserControl/JFInstallmentDataAll.ascx" tagname="JFInstallmentDataAll" tagprefix="uc4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:HiddenField ID="txtAction" runat="server" />
    <asp:HiddenField ID="hidLocID" runat="server" />
    <asp:HiddenField ID="hidAccIDJF" runat="server" />
    <asp:HiddenField ID="hidAccID" runat="server" /><asp:HiddenField ID="hidRSID" runat="server" />
      <asp:HiddenField ID="hidTxnDate" runat="server" />
    <uc3:DataAccountFromParamAccIDOS ID="ctlDataAccountFromParamAccIDOS" 
        runat="server" />
      <asp:Panel ID="pnlJFShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgJF" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblJF" runat="server" CssClass="required">(Show Join Finance Data...)</asp:Label>
        </div>
        <input id="Button3" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPECollect" runat="server" CollapseControlID="pnlJFShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Join Finance Data...)"
        Enabled="True" ExpandControlID="pnlJFShow" ExpandedImage="~/images/collapse.jpg"
        ExpandedText="(Hide Join Finance Data...)" ImageControlID="imgJF" TargetControlID="pnlJFData"
        TextLabelID="lblJF">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlJFData" runat="server" Width="100%">
        <uc2:AccountJFbyACCIDJF ID="ctlAccountJFbyACCIDJF" runat="server" />
    </asp:Panel>
    <asp:Panel ID="pnlInstShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgInstData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblInstData" runat="server" CssClass="required">(Show JF Installment Data...)</asp:Label>
        </div>
        <input id="Button2" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEInst" runat="server" CollapseControlID="pnlInstShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show JF/Bank Installment Data...)"
        Enabled="True" ExpandControlID="pnlInstShow" ExpandedImage="~/images/collapse.jpg"
        ExpandedText="(Hide JF/Bank Installment Data...)" 
        ImageControlID="imgInstData" TargetControlID="pnlInstData"
        TextLabelID="lblInstData">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlInstData" runat="server" Width="100%" >
        <uc4:JFInstallmentDataAll ID="ctlJFInstallmentDataAll" runat="server" />
    </asp:Panel>
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="RowStyle">
                <asp:FormView ID="fvRSInfo" runat="server" Caption="JF/Bank Reschedule Info" DataSourceID="sdsRSInfo"
                    Width="100%">
                    <EditItemTemplate>
                        RSTXNDATE:
                        <asp:TextBox ID="RSTXNDATETextBox" runat="server" Text='<%# Bind("RSTXNDATE") %>'>
                        </asp:TextBox><br />
                        OSPRINCIPALCURRENT:
                        <asp:TextBox ID="OSPRINCIPALCURRENTTextBox" runat="server" Text='<%# Bind("OSPRINCIPALCURRENT") %>'>
                        </asp:TextBox><br />
                        OSTENORCURRENT:
                        <asp:TextBox ID="OSTENORCURRENTTextBox" runat="server" Text='<%# Bind("OSTENORCURRENT") %>'>
                        </asp:TextBox><br />
                        OLDEFFRATE:
                        <asp:TextBox ID="OLDEFFRATETextBox" runat="server" Text='<%# Bind("OLDEFFRATE") %>'>
                        </asp:TextBox><br />
                        NEWEFFRATE:
                        <asp:TextBox ID="NEWEFFRATETextBox" runat="server" Text='<%# Bind("NEWEFFRATE") %>'>
                        </asp:TextBox><br />
                        OLDFLATRATE:
                        <asp:TextBox ID="OLDFLATRATETextBox" runat="server" Text='<%# Bind("OLDFLATRATE") %>'>
                        </asp:TextBox><br />
                        NEWFLATRATE:
                        <asp:TextBox ID="NEWFLATRATETextBox" runat="server" Text='<%# Bind("NEWFLATRATE") %>'>
                        </asp:TextBox><br />
                        OLDINSTALLMENT:
                        <asp:TextBox ID="OLDINSTALLMENTTextBox" runat="server" Text='<%# Bind("OLDINSTALLMENT") %>'>
                        </asp:TextBox><br />
                        NEWINSTALLMENT:
                        <asp:TextBox ID="NEWINSTALLMENTTextBox" runat="server" Text='<%# Bind("NEWINSTALLMENT") %>'>
                        </asp:TextBox><br />
                        OLDINTERESTTOTAL:
                        <asp:TextBox ID="OLDINTERESTTOTALTextBox" runat="server" Text='<%# Bind("OLDINTERESTTOTAL") %>'>
                        </asp:TextBox><br />
                        NEWINTERESTTOTAL:
                        <asp:TextBox ID="NEWINTERESTTOTALTextBox" runat="server" Text='<%# Bind("NEWINTERESTTOTAL") %>'>
                        </asp:TextBox><br />
                        RSSTATUS:
                        <asp:TextBox ID="RSSTATUSTextBox" runat="server" Text='<%# Bind("RSSTATUS") %>'>
                        </asp:TextBox><br />
                        RSSTATUSDATE:
                        <asp:TextBox ID="RSSTATUSDATETextBox" runat="server" Text='<%# Bind("RSSTATUSDATE") %>'>
                        </asp:TextBox><br />
                        RSSTATUSNAME:
                        <asp:TextBox ID="RSSTATUSNAMETextBox" runat="server" Text='<%# Bind("RSSTATUSNAME") %>'>
                        </asp:TextBox><br />
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                            Text="Update">
                        </asp:LinkButton>
                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                            Text="Cancel">
                        </asp:LinkButton>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        RSTXNDATE:
                        <asp:TextBox ID="RSTXNDATETextBox" runat="server" Text='<%# Bind("RSTXNDATE") %>'>
                        </asp:TextBox><br />
                        OSPRINCIPALCURRENT:
                        <asp:TextBox ID="OSPRINCIPALCURRENTTextBox" runat="server" Text='<%# Bind("OSPRINCIPALCURRENT") %>'>
                        </asp:TextBox><br />
                        OSTENORCURRENT:
                        <asp:TextBox ID="OSTENORCURRENTTextBox" runat="server" Text='<%# Bind("OSTENORCURRENT") %>'>
                        </asp:TextBox><br />
                        OLDEFFRATE:
                        <asp:TextBox ID="OLDEFFRATETextBox" runat="server" Text='<%# Bind("OLDEFFRATE") %>'>
                        </asp:TextBox><br />
                        NEWEFFRATE:
                        <asp:TextBox ID="NEWEFFRATETextBox" runat="server" Text='<%# Bind("NEWEFFRATE") %>'>
                        </asp:TextBox><br />
                        OLDFLATRATE:
                        <asp:TextBox ID="OLDFLATRATETextBox" runat="server" Text='<%# Bind("OLDFLATRATE") %>'>
                        </asp:TextBox><br />
                        NEWFLATRATE:
                        <asp:TextBox ID="NEWFLATRATETextBox" runat="server" Text='<%# Bind("NEWFLATRATE") %>'>
                        </asp:TextBox><br />
                        OLDINSTALLMENT:
                        <asp:TextBox ID="OLDINSTALLMENTTextBox" runat="server" Text='<%# Bind("OLDINSTALLMENT") %>'>
                        </asp:TextBox><br />
                        NEWINSTALLMENT:
                        <asp:TextBox ID="NEWINSTALLMENTTextBox" runat="server" Text='<%# Bind("NEWINSTALLMENT") %>'>
                        </asp:TextBox><br />
                        OLDINTERESTTOTAL:
                        <asp:TextBox ID="OLDINTERESTTOTALTextBox" runat="server" Text='<%# Bind("OLDINTERESTTOTAL") %>'>
                        </asp:TextBox><br />
                        NEWINTERESTTOTAL:
                        <asp:TextBox ID="NEWINTERESTTOTALTextBox" runat="server" Text='<%# Bind("NEWINTERESTTOTAL") %>'>
                        </asp:TextBox><br />
                        RSSTATUS:
                        <asp:TextBox ID="RSSTATUSTextBox" runat="server" Text='<%# Bind("RSSTATUS") %>'>
                        </asp:TextBox><br />
                        RSSTATUSDATE:
                        <asp:TextBox ID="RSSTATUSDATETextBox" runat="server" Text='<%# Bind("RSSTATUSDATE") %>'>
                        </asp:TextBox><br />
                        RSSTATUSNAME:
                        <asp:TextBox ID="RSSTATUSNAMETextBox" runat="server" Text='<%# Bind("RSSTATUSNAME") %>'>
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
                                <td class="ErrHighLight">
                                    Reschedule Type</td>
                                <td class="ErrHighLight">
                                    (<asp:Label ID="Label23" runat="server" 
                                        style="font-weight: 700; text-decoration: underline" 
                                        Text='<%# Eval("RSTYPE") %>'></asp:Label>)
                                    <asp:Label ID="Label18" runat="server" 
                                        style="font-weight: 700; text-decoration: underline" 
                                        Text='<%# Eval("RSTYPENAME") %>'></asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="required">
                                    RS Txn Date</td>
                                <td class="required">
                                    <asp:Label ID="RSTXNDATELabel" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Bind("RSTXNDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Status</td>
                                <td>
                                    (<asp:Label ID="RSSTATUSLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Bind("RSSTATUS") %>'></asp:Label>)
                                    <asp:Label ID="RSSTATUSNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Bind("RSSTATUSNAME") %>'></asp:Label></td>
                                <td>
                                    Status Date</td>
                                <td>
                                    <asp:Label ID="RSSTATUSDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Bind("RSSTATUSDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                    OS Principal Current</td>
                                <td>
                                    <asp:Label ID="OSPRINCIPALCURRENTLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Bind("OSPRINCIPALCURRENT", "{0:N}") %>'></asp:Label></td>
                                <td>
                                    OS Tenor Current</td>
                                <td>
                                    <asp:Label ID="OSTENORCURRENTLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Bind("OSTENORCURRENT") %>'></asp:Label></td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td class="ShowDetail">
                                    ITEM</td>
                                <td class="ShowDetail" style="text-align: right">
                                    OLD VALUE</td>
                                <td class="ShowDetail" style="text-align: right">
                                    NEW VALUE</td>
                            </tr>
                            <tr>
                                <td class="HeaderStyle">
                                    Effective Rate</td>
                                <td style="text-align: right">
                                    <asp:Label ID="OLDEFFRATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Bind("OLDEFFRATE") %>'></asp:Label>
                                    %</td>
                                <td class="FooterStyle" style="text-align: right">
                                    <asp:Label ID="NEWEFFRATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Bind("NEWEFFRATE") %>'></asp:Label>
                                    %</td>
                            </tr>
                            <tr>
                                <td class="HeaderStyle">
                                    Tenor</td>
                                <td style="text-align: right">
                                    <asp:Label ID="Label19" runat="server" 
                                        style="font-weight: 700; text-decoration: underline" 
                                        Text='<%# Eval("OLDTENOR") %>'></asp:Label>
                                </td>
                                <td class="FooterStyle" style="text-align: right">
                                    <asp:Label ID="Label20" runat="server" 
                                        style="font-weight: 700; text-decoration: underline" 
                                        Text='<%# Eval("NEWTENOR") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="HeaderStyle">
                                    Principal</td>
                                <td style="text-align: right">
                                    <asp:Label ID="Label21" runat="server" 
                                        style="font-weight: 700; text-decoration: underline" 
                                        Text='<%# Eval("OLDPRINCIPAL", "{0:N}") %>'></asp:Label>
                                </td>
                                <td class="FooterStyle" style="text-align: right">
                                    <asp:Label ID="Label22" runat="server" 
                                        style="font-weight: 700; text-decoration: underline" 
                                        Text='<%# Eval("NEWPRINCIPAL", "{0:N}") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="HeaderStyle">
                                    Installment</td>
                                <td style="text-align: right">
                                    <asp:Label ID="OLDINSTALLMENTLabel" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Bind("OLDINSTALLMENT", "{0:N}") %>'></asp:Label>
                                </td>
                                <td class="FooterStyle" style="text-align: right">
                                    <asp:Label ID="NEWINSTALLMENTLabel" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Bind("NEWINSTALLMENT", "{0:N}") %>'></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="sdsRSInfo" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    
                    
                    SelectCommand="SELECT RSTXNDATE, OSPRINCIPALCURRENT, OSTENORCURRENT, OLDEFFRATE, NEWEFFRATE, OLDINSTALLMENT, NEWINSTALLMENT, OLDINTERESTTOTAL, NEWINTERESTTOTAL, RSSTATUS, RSSTATUSDATE, dbo.f_getParamGlobalName('WOSTATUS', RSSTATUS) AS RSSTATUSNAME, OLDTENOR, NEWTENOR, OLDPRINCIPAL, NEWPRINCIPAL, RSTYPE, dbo.f_getParamGlobalName('RSTYPE', RSTYPE) AS RSTYPENAME FROM RESCHEDULEJF WHERE (ACCIDJF = @ACCIDJF) AND (RSID = @RSID)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="ACCIDJF" QueryStringField="ACCIDJF" />
                        <asp:QueryStringParameter Name="RSID" QueryStringField="RSID" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="RowStyle" style="height: 19px">
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
        <asp:Button ID="btnApprove" runat="server" OnClientClick='return(confirm("Are you sure want to APPROVE Reschedule Account..?"));' Style="background-position: right;
            background-image: url(../Images/ok.png); cursor: pointer; background-repeat: no-repeat;
             text-align: left" Text="Approve" ValidationGroup="ViewAcc"
            Visible="False" Width="88px" />&nbsp;<asp:Button ID="btnReject" runat="server" CausesValidation="False"
                Style="background-position: right; background-image: url(../Images/stop.png);
                cursor: pointer; background-repeat: no-repeat;  text-align: left"
                Text="Reject" ValidationGroup="ViewAcc" Visible="False" Width="88px" OnClientClick='return(confirm("Are you sure want to REJECT Reschedule Account..?"));' />
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
            var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
            return (oObject)
        }
        function GetValueTxtByClientID(ClientID) {
            var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
            if (oText)
                return (oText.value);
        }

        function ViewDetailAcc(LOCID, APPID) {
            var winref = window.open("AccInqFrame.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable");
            winref.focus();
        }
        function BackEdit() {
            //if ((GetValueTxtByClientID("<%=txtAction.ClientID%>")=="INQ") || (GetValueTxtByClientID("<%=txtAction.ClientID%>")=="PAY")){
            //window.history.back(-1);
            window.location = "AccRSJFInqList.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>")
            return false;
            //}
            return true;
        }
        function ViewJFInst(ACCIDJF) {
            var winref = window.open("../Account/JFInstallment.aspx?ACCIDJF=" + ACCIDJF, "JFInst", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable");
            winref.focus();
            return false;
        }
        function PrintLoanJF(ACCIDJF) {
            var TXNDATE = GetValueTxtByClientID("<%=hidTxnDate.ClientID%>");
            var winref = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/InstallmentAccountJF&ACCIDJF=" + ACCIDJF + "&TXNDATE=" + TXNDATE, "PrintInstJF", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
            winref.focus();
            return false;
        }
        function JFInfo(JFID) {
            var winref = window.open("../Account/JFInfo.aspx?JFID=" + JFID, "JFInfo", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable");
            winref.focus();
        }
    </script>
</asp:Content>

