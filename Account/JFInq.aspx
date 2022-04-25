<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="JFInq.aspx.vb" Inherits="Account_JFInq" title="Join Finance Inquiry" %>

<%@ Register src="../UserControl/NoDataFound.ascx" tagname="NoDataFound" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:GridView ID="gvJFRequest" runat="server" AutoGenerateColumns="False" 
        Caption="JF/BANK REQUEST INFO" DataKeyNames="REQUESTID" DataSourceID="sdsJFRequest" 
        RowHeaderColumn="REQUESTID" Width="100%">
        <Columns>
            <asp:BoundField DataField="REQUESTID" HeaderText="Request&lt;BR&gt;ID" 
                HtmlEncode="False" ReadOnly="True" SortExpression="REQUESTID" />
            <asp:BoundField DataField="REQUESTDATE" DataFormatString="{0:dd/MM/yyyy}" 
                HeaderText="Request&lt;br&gt;Date" HtmlEncode="False" 
                SortExpression="REQUESTDATE">
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="JFNAAME" HeaderText="JF/Bank" ReadOnly="True" 
                SortExpression="JFNAAME" />
            <asp:BoundField DataField="OSPRINCIPAL" DataFormatString="{0:N}" 
                HeaderText="OS&lt;br&gt;Principal" HtmlEncode="False" 
                SortExpression="OSPRINCIPAL">
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="OSTENOR" HeaderText="OS&lt;br&gt;Ten" 
                HtmlEncode="False" SortExpression="OSTENOR">
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="JFREQUESTSTATUSNAME" 
                HeaderText="JF Request&lt;br&gt;Status" HtmlEncode="False" ReadOnly="True" 
                SortExpression="JFREQUESTSTATUSNAME" />
            <asp:BoundField DataField="JFSTATUSDATE" DataFormatString="{0:dd/MM/yyyy}" 
                HeaderText="Status&lt;br&gt;Date" HtmlEncode="False" 
                SortExpression="JFSTATUSDATE">
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="JFREQUESTTYPENAME" 
                HeaderText="Request&lt;br&gt;Type" HtmlEncode="False" ReadOnly="True" 
                SortExpression="JFREQUESTTYPENAME" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsJFRequest" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        SelectCommand="SELECT JFREQUEST.REQUESTID, JFREQUEST.REQUESTDATE, '(' + JF.JFCODE + ')' + JF.JFNAME AS JFNAAME, JFREQUESTACC.OSPRINCIPAL, '(' + CAST(JFREQUESTACC.JFREQUESTSTATUS AS VARCHAR(20)) + ')' + dbo.f_getParamGlobalName('JFREQUESTSTATUS', JFREQUESTACC.JFREQUESTSTATUS) AS JFREQUESTSTATUSNAME, JFREQUESTACC.JFSTATUSDATE, '(' + CAST(JFREQUESTACC.JFREQUESTTYPE AS VARCHAR(20)) + ')' + dbo.f_getParamGlobalName('JFREQUESTTYPE', JFREQUESTACC.JFREQUESTTYPE) AS JFREQUESTTYPENAME, JFREQUESTACC.OSTENOR FROM ACCOUNT WITH (NOLOCK) INNER JOIN JFREQUESTACC WITH (NOLOCK) ON ACCOUNT.LOCID = JFREQUESTACC.LOCID AND ACCOUNT.ACCID = JFREQUESTACC.ACCID INNER JOIN JFREQUEST WITH (NOLOCK) ON JFREQUESTACC.REQUESTID = JFREQUEST.REQUESTID INNER JOIN JF WITH (NOLOCK) ON JFREQUEST.JFID = JF.JFID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.APPID = @APPID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
            <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:DataList ID="dlJF" runat="server" Caption="JOIN FINANCE (BANK)" DataKeyField="ACCIDJF"
        DataSourceID="sdsJF" Width="100%">
        <FooterTemplate>
            <hr />
        </FooterTemplate>
        <HeaderTemplate>
            <hr />
        </HeaderTemplate>
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td class="HeaderStyle">
                        JF INFO (<asp:Label ID="Label10" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFCODE") %>'></asp:Label>)</td>
                    <td class="FooterStyle" colspan="3">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td class="required">
                        Acc ID JF</td>
                    <td class="required">
                        <asp:Label ID="ACCIDJFLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ACCIDJF") %>'></asp:Label></td>
                    <td class="required">
                        JF ID&nbsp;</td>
                    <td class="required">
                        <asp:Label ID="JFIDLabel" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="required">
                        JF Group</td>
                    <td class="required">
                        (<asp:Label ID="JFGROUPCODELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFGROUPCODE") %>'></asp:Label>)
                        <asp:Label ID="JFGROUPNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFGROUPNAME") %>'></asp:Label>&nbsp;</td>
                    <td class="required">
                        JF (Bank)</td>
                    <td class="required">
                        (<asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFCODE") %>'></asp:Label>)
                        <asp:Label ID="JFNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFNAME") %>'></asp:Label>
                        <img src="../Images/detail.gif" style="cursor: pointer" alt="JF Detail Info" onclick="JFInfo(<%# Eval("JFID") %>)" /></td>
                </tr>
                <tr>
                    <td>
                        JF Booking Date</td>
                    <td>
                        <asp:Label ID="JFBOOKINGDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFBOOKINGDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                    <td class="ErrHighLight">
                        JF Status</td>
                    <td class="ErrHighLight">
                        (<asp:Label ID="JFACCSTATUSLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFACCSTATUS") %>'></asp:Label>)
                        <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFACCSTATUSNAME") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        JF Closed Date</td>
                    <td>
                        <asp:Label ID="JFCLOSEDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFCLOSEDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                    <td>
                        JF Closed Txn Date</td>
                    <td>
                        <asp:Label ID="JFCLOSETXNDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFCLOSETXNDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="HeaderStyle">
                        JF LOAN DATA (<asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFCODE") %>'></asp:Label>)</td>
                    <td class="FooterStyle" colspan="3">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        JF Installment Type</td>
                    <td colspan="3">
                        (<asp:Label ID="Label14" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("JFINSTALLMENTTYPE") %>'></asp:Label>)
                        <asp:Label ID="Label15" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("JFINSTALLMENTTYPENAME") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        JF Principal</td>
                    <td>
                        <asp:Label ID="JFPRINCIPALTOTALLabel" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("JFPRINCIPALTOTAL", "{0:N}") %>'></asp:Label>
                    </td>
                    <td>
                        JF Tenor</td>
                    <td>
                        <asp:Label ID="JFTENORLabel" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("JFTENOR") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        JF Eff. Rate</td>
                    <td>
                        <asp:Label ID="JFEFFECTIVERATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFEFFECTIVERATE") %>'></asp:Label></td>
                    <td>
                        JF Loan Type</td>
                    <td>
                        (<asp:Label ID="JFLOANTYPELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFLOANTYPE") %>'></asp:Label>)
                        <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFLOANTYPENAME") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        JF Installment</td>
                    <td>
                        <asp:Label ID="JFINSTALLMENTLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFINSTALLMENT", "{0:N}") %>'></asp:Label></td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        JF Residual Value</td>
                    <td>
                        <asp:Label ID="JFINSTALLMENTLabel0" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("JFRESIDUALVALUE", "{0:N}") %>'></asp:Label>
                    </td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="HeaderStyle">
                        OUTSTANDING (<asp:Label ID="Label12" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFCODE") %>'></asp:Label>)</td>
                    <td class="FooterStyle" colspan="3">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        OS Principal</td>
                    <td class="AlternatingRowStyle">
                        <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFOSPRINCIPAL", "{0:N}") %>'></asp:Label></td>
                    <td class="AlternatingRowStyle">
                        OS Interest</td>
                    <td class="AlternatingRowStyle">
                        <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFOSINTEREST", "{0:N}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="4" class="ShowDetail">
                        <input id="btnInst" style="background-position: right; background-image: url('../Images/view.png');
                            cursor: pointer; background-repeat: no-repeat; text-align: left; font-weight: 700; width:30%" type="button" value="View JF Installment (<%# Eval("JFCODE") %>)" onclick="ViewJFInst(<%# Eval("ACCIDJF") %>)" />
                        <input id="btnPrintLoanJF" style="background-position: right; background-image: url('../Images/view.png');
                            cursor: pointer; background-repeat: no-repeat; text-align: left; font-weight: 700; width:30%" type="button" value="Print JF Installment (<%# Eval("JFCODE") %>)" onclick="PrintLoanJF(<%# Eval("ACCIDJF") %>)" />
                        <input 
                id="btnJournal" 
                style="background-position: right; background-image: url('../Images/Journal.gif');
                            cursor: pointer; background-repeat: no-repeat; text-align: left; font-weight: 700; width:30%" 
                type="button" value='Show Journal JF Booking (<%# Eval("JFCODE") %>)' 
                onclick="ShowJournal(<%# Eval("ACCIDJF") %>, '<%# Eval("BOOKCODE") %>')" />
                    </td>
                </tr>
                <tr>
                    <td>
                        JF Installment Start</td>
                    <td>
                        <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFINSTALLMENTSTART", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                    <td>
                        JF Installment End</td>
                    <td>
                        <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFINSTALLMENTEND", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        JF Installment Day</td>
                    <td>
                        <asp:Label ID="JFINSTALLMENTDAYLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFINSTALLMENTDAY") %>'></asp:Label></td>
                    <td>
                        JF Ref No</td>
                    <td>
                        <asp:Label ID="REFNOLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("REFNO") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        JF Start Period</td>
                    <td>
                        <asp:Label ID="JFSTARTPERIODLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFSTARTPERIOD") %>'></asp:Label></td>
                    <td>
                        JF Req. Acc ID.</td>
                    <td>
                        <asp:Label ID="REQUESTIDACCLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("REQUESTIDACC") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="HeaderStyle">
                        JF FEE (<asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFCODE") %>'></asp:Label>)</td>
                    <td class="FooterStyle" colspan="3">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        JF Admin Fee</td>
                    <td>
                        <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFADMIN", "{0:N}") %>'></asp:Label></td>
                    <td>
                        JF Provision</td>
                    <td>
                        <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFPROVISION", "{0:N}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="FooterStyle" colspan="4">
                        <hr />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
        <SeparatorTemplate>
            <hr style="HeaderStyle" />
        </SeparatorTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="sdsJF" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT ACCOUNTJF.ACCIDJF, ACCOUNTJF.JFID, JF.JFCODE, JF.JFNAME, JFGROUP.JFGROUPCODE, JFGROUP.JFGROUPNAME, ACCOUNTJF.JFBOOKINGDATE, ACCOUNTJF.JFACCSTATUS, dbo.f_getParamGlobalName('JFACCSTATUS', ACCOUNTJF.JFACCSTATUS) AS JFACCSTATUSNAME, ACCOUNTJF.JFPRINCIPALTOTAL, ACCOUNTJF.JFTENOR, ACCOUNTJF.JFLOANTYPE, dbo.f_getParamGlobalName('LOANTYPE', ACCOUNTJF.JFLOANTYPE) AS JFLOANTYPENAME, ACCOUNTJF.JFEFFECTIVERATE, ACCOUNTJF.JFINSTALLMENT, ACCOUNTJF.JFCLOSEDATE, ACCOUNTJF.JFCLOSETXNDATE, ACCOUNTJF.JFNEXTDUEDATE, ACCOUNTJF.JFINSTALLMENTDAY, ACCOUNTJF.REFNO, ACCOUNTJF.REQUESTIDACC, ACCOUNTJF.JFSTARTPERIOD, ACCOUNTJFDTL.JFADMIN, ACCOUNTJFDTL.JFPROVISION, ACCOUNTJFDTL.JFINSTALLMENTSTART, ACCOUNTJFDTL.JFINSTALLMENTEND, ACCOUNTJF.JFOSPRINCIPALREAL AS JFOSPRINCIPAL, ACCOUNTJF.JFOSINTERESTREAL AS JFOSINTEREST, ACCOUNTJF.JFINSTALLMENTTYPE, dbo.f_getParamGlobalName('JFINSTALLMENTTYPE', ACCOUNTJF.JFINSTALLMENTTYPE) AS JFINSTALLMENTTYPENAME, ACCOUNTJF.JFRESIDUALVALUE, CASE WHEN JFREQUESTACC.JFREQUESTTYPE = 1 THEN 'JFC' ELSE 'JFS' END AS BOOKCODE FROM ACCOUNT WITH (NOLOCK) INNER JOIN ACCOUNTJF WITH (NOLOCK) ON ACCOUNT.LOCID = ACCOUNTJF.LOCID AND ACCOUNT.ACCID = ACCOUNTJF.ACCID INNER JOIN JF WITH (NOLOCK) ON ACCOUNTJF.JFID = JF.JFID INNER JOIN JFGROUP WITH (NOLOCK) ON JF.JFGROUPID = JFGROUP.JFGROUPID LEFT OUTER JOIN JFREQUESTACC WITH (NOLOCK) ON ACCOUNTJF.REQUESTIDACC = JFREQUESTACC.REQUESTIDACC LEFT OUTER JOIN ACCOUNTJFDTL WITH (NOLOCK) ON ACCOUNTJF.ACCIDJF = ACCOUNTJFDTL.ACCIDJF WHERE (ACCOUNT.LOCID = @LOC) AND (ACCOUNT.APPID = @APPID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="LOC" QueryStringField="LOCID" />
            <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="hidTxnDate" runat="server" />
    <asp:GridView ID="gvAssetPledge" runat="server" AutoGenerateColumns="False" 
        Caption="ACCOUNT ASSET PLEDGE" DataKeyNames="PLEDGEID" DataSourceID="sdsAP" 
        RowHeaderColumn="PLEDGEID" Width="100%">
        <Columns>
            <asp:BoundField DataField="PLEDGEID" HeaderText="Pledge&lt;br&gt;ID" 
                HtmlEncode="False" ReadOnly="True" SortExpression="PLEDGEID" />
            <asp:BoundField DataField="PLEDGEDATE" DataFormatString="{0:dd/MM/yyyy}" 
                HeaderText="Pledge&lt;br&gt;Date" HtmlEncode="False" 
                SortExpression="PLEDGEDATE">
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="PLEDGEENDDATE" DataFormatString="{0:dd/MM/yyyy}" 
                HeaderText="Pledge&lt;br&gt;End Date" HtmlEncode="False" 
                SortExpression="PLEDGEENDDATE">
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="BANKCODE" HeaderText="Bank&lt;br&gt;Code" 
                HtmlEncode="False" SortExpression="BANKCODE" />
            <asp:BoundField DataField="BANKNAME" HeaderText="Bank&lt;br&gt;Name" 
                HtmlEncode="False" SortExpression="BANKNAME" />
            <asp:BoundField DataField="BANKBRANCH" HeaderText="Bank&lt;br&gt;Branch" 
                HtmlEncode="False" SortExpression="BANKBRANCH" />
            <asp:BoundField DataField="PLEDGEACCSTSNAME" 
                HeaderText="Pledge&lt;br&gt;Acc Status" HtmlEncode="False" 
                SortExpression="PLEDGEACCSTSNAME" />
        </Columns>
        <EmptyDataTemplate>
            <uc1:NoDataFound ID="NoDataFound1" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsAP" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        SelectCommand="SELECT ASSETPLEDGE.PLEDGEID, ASSETPLEDGE.PLEDGEDATE, ASSETPLEDGE.PLEDGEENDDATE, BANK.BANKCODE, BANK.BANKNAME, ASSETPLEDGE.BANKBRANCH, ASSETPLEDGEACC.PLEDGEACCSTS, dbo.f_getParamGlobalName('PLEDGEACCSTS', ASSETPLEDGEACC.PLEDGEACCSTS) AS PLEDGEACCSTSNAME FROM ACCOUNT WITH (NOLOCK) INNER JOIN ASSETPLEDGEACC WITH (NOLOCK) ON ACCOUNT.LOCID = ASSETPLEDGEACC.LOCID AND ACCOUNT.ACCID = ASSETPLEDGEACC.ACCID INNER JOIN ASSETPLEDGE WITH (NOLOCK) ON ASSETPLEDGEACC.PLEDGEID = ASSETPLEDGE.PLEDGEID INNER JOIN BANK ON ASSETPLEDGE.BANKID = BANK.BANKID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.APPID = @APPID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
            <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <script type="text/javascript" src="../include/TableHighLight.js"></script>

    <script type="text/javascript">
        FormatTable("<%=gvAssetPledge.ClientID%>");
        FormatTable("<%=gvJFRequest.ClientID%>");
        
    function JFInfo(JFID) {
        var winref=window.open("../Account/JFInfo.aspx?JFID=" + JFID,"JFInfo", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable");
        winref.focus();
    }
    function ViewJFInst(ACCIDJF){
        var winref=window.open("../Account/JFInstallment.aspx?ACCIDJF=" + ACCIDJF,"JFInst", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable");
        winref.focus();
        return false;
    }
    function GetValueTxtByClientID(ClientID) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            return (oText.value);
    }

    function PrintLoanJF(ACCIDJF) {
        var TXNDATE = GetValueTxtByClientID("<%=hidTxnDate.ClientID%>");
        var winref = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/InstallmentAccountJF&ACCIDJF=" + ACCIDJF + "&TXNDATE=" + TXNDATE, "PrintInstJF", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
        winref.focus();
        return false;
    }
    function ShowJournal(RefNo, BCCode) {
        var WinRef = window.open("../Core/JournalViewByRefNo.aspx?Action=View&RefNo=" + RefNo + "&BookCode=" + BCCode, "PayJournal", "height=400,width=600,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
        WinRef.focus();
        return (false);
    }


    </script>
</asp:Content>

