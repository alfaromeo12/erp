<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccRSJfEntry.aspx.vb" Inherits="Account_AccRSJfEntry" %>

<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<%@ Register src="../UserControl/DataAccountFromParamAccIDOS.ascx" tagname="DataAccountFromParamAccIDOS" tagprefix="uc2" %>
<%@ Register src="../UserControl/AccountJFbyACCIDJF.ascx" tagname="AccountJFbyACCIDJF" tagprefix="uc3" %>
<%@ Register src="../UserControl/JFInstallmentDataAll.ascx" tagname="JFInstallmentDataAll" tagprefix="uc4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
        
    <asp:HiddenField ID="txtAction" runat="server" />
    <asp:HiddenField ID="hidLocID" runat="server" />
    <asp:HiddenField ID="hidAccID" runat="server" />
    <asp:HiddenField ID="hidAccIDJF" runat="server" />
    <asp:HiddenField ID="hidRSType" runat="server" />
      <asp:HiddenField ID="hidTxnDate" runat="server" />
    <uc2:DataAccountFromParamAccIDOS ID="DataAccountFromParamAccIDOS1" 
        runat="server" />
    <uc2:DataAccountFromParamAccIDOS ID="ctlDataAccountFromParamAccIDOS" 
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
        <uc3:AccountJFbyACCIDJF ID="ctlAccountJFbyACCIDJF" runat="server" />
    </asp:Panel>
    <asp:Panel ID="pnlInstShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgInstData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblInstData" runat="server" CssClass="required">(Show Installment Data...)</asp:Label>
        </div>
        <input id="Button2" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEInst" runat="server" CollapseControlID="pnlInstShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show JF Installment Data...)"
        Enabled="True" ExpandControlID="pnlInstShow" ExpandedImage="~/images/collapse.jpg"
        ExpandedText="(Hide JF Installment Data...)" ImageControlID="imgInstData" TargetControlID="pnlInstData"
        TextLabelID="lblInstData">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlInstData" runat="server"  Width="100%">
        <uc4:JFInstallmentDataAll ID="ctlJFInstallmentDataAll" runat="server" />
    </asp:Panel>
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="RowStyle">
                <asp:FormView ID="fvAccRSInfo" runat="server" 
                    Caption="Account JF/Bank Reschedule Info" DataSourceID="sdsRSInfo"
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
                                    JF Booking Date</td>
                                <td>
                                    <asp:Label ID="BOOKINGDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Eval("JFBOOKINGDATE", " {0:dd/MM/yyyy}") %>'></asp:Label></td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td class="ErrHighLight">
                                    JF Principal Total</td>
                                <td class="ErrHighLight">
                                    <asp:Label ID="PRINCIPALTOTALLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Eval("JFPRINCIPALTOTAL", "{0:N}") %>'></asp:Label></td>
                                <td>
                                    JF Interest Total</td>
                                <td>
                                    <asp:Label ID="INTERESTTOTALLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Eval("JFINTERESTTOTAL", "{0:N}") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td class="ErrHighLight">
                                    JF Tenor</td>
                                <td class="ErrHighLight">
                                    <asp:Label ID="Label18" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("JFTENOR") %>'></asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="FooterStyle">
                                    JF OS Principal Current</td>
                                <td class="FooterStyle">
                                    <asp:Label ID="OSPRINCIPALLabel" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("JFOSPRINCIPAL", "{0:N}") %>'></asp:Label>
                                </td>
                                <td class="FooterStyle">
                                    JF OS Interest Current</td>
                                <td class="FooterStyle">
                                    <asp:Label ID="OSINTERESTLabel" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("JFOSINTEREST", "{0:N}") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="FooterStyle">
                                    JF OS Tenor Current</td>
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
                                    JF Installment</td>
                                <td class="required" colspan="3">
                                    <asp:Label ID="INSTALLMENTREALLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                        Text='<%# Eval("JFINSTALLMENT", "{0:N}") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td class="ErrHighLight">
                                    JF Effective Rate</td>
                                <td class="ErrHighLight">
                                    <asp:Label ID="Label17" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("JFEFFECTIVERATE") %>'></asp:Label>
                                    %</td>
                                <td class="ErrHighLight">
                                    &nbsp;</td>
                                <td class="ErrHighLight">
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="sdsRSInfo" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    
                    
                    SelectCommand="SELECT JFTENOR - (SELECT COUNT(*) AS Expr1 FROM INSTALLMENTJF WITH (NOLOCK) WHERE (ACCOUNTJF.ACCIDJF = ACCIDJF) AND (JFDUEDATE &lt;= dbo.f_getAppDate())) AS OSTENOR, JFPRINCIPALTOTAL, JFINTERESTTOTAL, JFEFFECTIVERATE, JFTENOR, JFBOOKINGDATE, JFPRINCIPALTOTAL - (SELECT ISNULL(SUM(JFPRINCIPAL), 0) AS Expr1 FROM INSTALLMENTJF AS INSTALLMENTJF_1 WITH (NOLOCK) WHERE (ACCOUNTJF.ACCIDJF = ACCIDJF) AND (JFDUEDATE &lt;= dbo.f_getAppDate())) AS JFOSPRINCIPAL, JFINTERESTTOTAL - (SELECT ISNULL(SUM(JFINTEREST), 0) AS Expr1 FROM INSTALLMENTJF AS INSTALLMENTJF_1 WITH (NOLOCK) WHERE (ACCOUNTJF.ACCIDJF = ACCIDJF) AND (JFDUEDATE &lt;= dbo.f_getAppDate())) AS JFOSINTEREST, JFINSTALLMENT FROM ACCOUNTJF WITH (NOLOCK) WHERE (ACCIDJF = @ACCIDJF)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hidAccIDJF" Name="ACCIDJF" 
                            PropertyName="Value" />
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
                New Principal</td>
            <td class="ShowDetail" colspan="3">
                <asp:TextBox ID="txtNewPrincipal" runat="server" CssClass="required" Style="text-align: right"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqNewPrincipal" runat="server" ControlToValidate="txtNewPrincipal"
                    Display="None" ErrorMessage="NEW PRINCIPAL must be entry...!" SetFocusOnError="True"
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
    <br />
    <br />
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
            var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
            return (oObject);
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
            var RSType = GetValueTxtByClientID("<%=hidRSType.ClientID%>");
            window.location = "AccRSJFList.aspx?RSType=" + RSType;
            return false;
            //}
            return true;
        }
        function JFInfo(JFID) {
            var winref = window.open("../Account/JFInfo.aspx?JFID=" + JFID, "JFInfo", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable");
            winref.focus();
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
    
    </script>
</asp:Content>

