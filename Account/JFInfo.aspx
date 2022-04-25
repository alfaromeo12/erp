<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="JFInfo.aspx.vb" Inherits="Account_JFInfo" title="Join Finance (Bank) Info" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Panel ID="pnlJFInfo" runat="server" Width="100%">
        <asp:DataList ID="dlJFInfo" runat="server" Caption="JOIN FINANCE (BANK) INFO" DataKeyField="JFID"
            DataSourceID="sdsJFInfo" Width="100%">
            <ItemTemplate>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td class="HeaderStyle">
                            JF ID</td>
                        <td class="HeaderStyle">
                            <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFID") %>'></asp:Label></td>
                        <td class="FooterStyle" colspan="2">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td class="required">
                            JF Group</td>
                        <td class="required">
                            (<asp:Label ID="JFGROUPCODELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFGROUPCODE") %>'></asp:Label>)
                            <asp:Label ID="JFGROUPNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFGROUPNAME") %>'></asp:Label></td>
                        <td class="required">
                            JF</td>
                        <td class="required">
                            (<asp:Label ID="JFCODELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFCODE") %>'></asp:Label>)
                            <asp:Label ID="JFNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFNAME") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Address</td>
                        <td colspan="3">
                            <asp:Label ID="Label17" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFADDRESS") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            City</td>
                        <td>
                            <asp:Label ID="Label19" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFCITY") %>'></asp:Label></td>
                        <td>
                            Zip</td>
                        <td>
                            <asp:Label ID="Label18" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFZIP") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="ErrHighLight">
                            Portion</td>
                        <td class="ErrHighLight">
                            <asp:Label ID="JFPORTIONLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFPORTION", "{0:N}") %>'></asp:Label>
                            %</td>
                        <td class="ErrHighLight">
                            Mirror Status</td>
                        <td class="ErrHighLight">
                            <asp:Label ID="MIRRORSTATUSNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("MIRRORSTATUSNAME") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            PKS</td>
                        <td class="FooterStyle" colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            PKS No.</td>
                        <td>
                            <asp:Label ID="JFPKSNOLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFPKSNO") %>'></asp:Label></td>
                        <td>
                            PKS Date</td>
                        <td>
                            <asp:Label ID="JFPKSDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFPKSDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            PKS Ttile</td>
                        <td colspan="3">
                            <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFPKSTITLE") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            JF Letter No</td>
                        <td>
                            <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFLETTERNO") %>'></asp:Label></td>
                        <td>
                            Notary</td>
                        <td>
                            <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFNOTARY") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            JF FEE</td>
                        <td class="FooterStyle" colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Admin Type</td>
                        <td>
                            (<asp:Label ID="JFADMINTYPELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFADMINTYPE") %>'></asp:Label>)
                            <asp:Label ID="JFADMINTYPENAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFADMINTYPENAME") %>'></asp:Label></td>
                        <td>
                            Admin</td>
                        <td>
                            <asp:Label ID="JFADMINLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFADMIN") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Provison Type</td>
                        <td>
                            (<asp:Label ID="JFPROVISIONTYPELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFPROVISIONTYPE") %>'></asp:Label>)
                            <asp:Label ID="JFPROVISIONTYPENAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFPROVISIONTYPENAME") %>'></asp:Label></td>
                        <td>
                            Provision</td>
                        <td>
                            <asp:Label ID="JFPROVISIONLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("JFPROVISION") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="FooterStyle" colspan="4">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            First Payment Type</td>
                        <td>
                            (<asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFFIRSTPAYMENTTYPE") %>'></asp:Label>)
                            <asp:Label ID="Label12" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFFIRSTPAYMENTTYPENAME") %>'></asp:Label></td>
                        <td>
                            Installment Type</td>
                        <td>
                            (<asp:Label ID="Label32" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("JFINSTALLMENTTYPE") %>'></asp:Label>)
                            <asp:Label ID="Label33" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("JFINSTALLMENTTYPENAME") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            JF PENALTY</td>
                        <td class="FooterStyle" colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Penalty Rate</td>
                        <td>
                            <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFPENALTYRATE") %>'></asp:Label>
                            %</td>
                        <td>
                            Penalty Share Rate</td>
                        <td>
                            <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFPENALTYSHARED") %>'></asp:Label>
                            %</td>
                    </tr>
                    <tr>
                        <td>
                            Working Days</td>
                        <td>
                            <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFWORKINGDAYS") %>'></asp:Label>
                            day(s)</td>
                        <td>
                            Grace Period</td>
                        <td>
                            <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFGRACEPERIOD") %>'></asp:Label>
                            day(s)</td>
                    </tr>
                    <tr>
                        <td>
                            Payment Type</td>
                        <td>
                            (<asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFPAYMENTTYPE") %>'></asp:Label>)
                            <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFPAYMENTTYPENAME") %>'></asp:Label></td>
                        <td>
                            Early Payment</td>
                        <td>
                            <asp:Label ID="Label10" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFEARLYPAYMENTNAME") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            ET JF (BUY BACK)</td>
                        <td class="FooterStyle" colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            ET Penalty Type</td>
                        <td>
                            (<asp:Label ID="Label14" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFETPENALTYTYPE") %>'></asp:Label>)
                            <asp:Label ID="Label20" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFETPENALTYTYPENAME") %>'></asp:Label></td>
                        <td>
                            ET Penalty</td>
                        <td>
                            <asp:Label ID="Label15" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFETPENALTY") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            ET Admin</td>
                        <td>
                            <asp:Label ID="Label16" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFADMTERMINATE", "{0:N}") %>'></asp:Label></td>
                        <td>
                            Commitment Fee</td>
                        <td>
                            <asp:Label ID="Label25" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFCOMMITFEE", "{0:N}") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            PLAFOND</td>
                        <td class="FooterStyle" colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Revolving</td>
                        <td colspan="3">
                            (<asp:Label ID="Label23" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFREVOLVING") %>'></asp:Label>)
                            <asp:Label ID="Label24" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFREVOLVINGNAME") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Plafond</td>
                        <td>
                            <asp:Label ID="Label21" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFPLAFOND", "{0:N}") %>'></asp:Label></td>
                        <td>
                            Plafond Used</td>
                        <td>
                            <asp:Label ID="Label22" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFPLAFONDUSED", "{0:N}") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            Doc. Received</td>
                        <td>
                            (<asp:Label ID="Label28" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFDOCRECEIVED") %>'></asp:Label>)
                            <asp:Label ID="Label29" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFDOCRECEIVEDNAME") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            ET Deviation</td>
                        <td colspan="3">
                            <hr />
                            </td>
                    </tr>
                    <tr>
                        <td>
                            Min</td>
                        <td>
                            <asp:Label ID="Label30" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFMINETDEV", "{0:N}") %>'></asp:Label></td>
                        <td>
                            Max</td>
                        <td>
                            <asp:Label ID="Label31" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFMAXETDEV", "{0:N}") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <hr />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>&nbsp;
    </asp:Panel>
    <asp:SqlDataSource ID="sdsJFInfo" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT JF.JFCODE, JF.JFNAME, JFGROUP.JFGROUPCODE, JFGROUP.JFGROUPNAME, JF.JFPORTION, JF.JFMIRRORSTATUS, dbo.f_getParamGlobalName('JFMIRRORSTATUS', JF.JFMIRRORSTATUS) AS MIRRORSTATUSNAME, JF.JFPKSNO, JF.JFPKSDATE, JF.JFADMINTYPE, dbo.f_getParamGlobalName('JFADMINTYPE', JF.JFADMINTYPE) AS JFADMINTYPENAME, JF.JFADMIN, JF.JFPROVISIONTYPE, dbo.f_getParamGlobalName('JFPROVISIONTYPE', JF.JFPROVISIONTYPE) AS JFPROVISIONTYPENAME, JF.JFPROVISION, JF.JFADDRESS, JF.JFCITY, JF.JFZIP, JF.JFPENALTYSHARED, JF.JFPENALTYRATE, JF.JFGRACEPERIOD, JF.JFWORKINGDAYS, JF.JFETPENALTYTYPE, dbo.f_getParamGlobalName('JFETPENALTYTYPE', JF.JFETPENALTYTYPE) AS JFETPENALTYTYPENAME, JF.JFETPENALTY, JF.JFADMTERMINATE, JF.JFPAYMENTTYPE, dbo.f_getParamGlobalName('JFPAYMENTTYPE', JF.JFPAYMENTTYPE) AS JFPAYMENTTYPENAME, CAST(JF.JFEARLYPAYMENT AS INT) AS JFEARLYPAYMENT, dbo.f_getParamGlobalName('JFEARLYPAYMENT', JF.JFEARLYPAYMENT) AS JFEARLYPAYMENTNAME, JF.JFFIRSTPAYMENTTYPE, dbo.f_getParamGlobalName('JFFIRSTPAYMENTTYPE', JF.JFFIRSTPAYMENTTYPE) AS JFFIRSTPAYMENTTYPENAME, JF.JFPKSTITLE, JF.JFID, JF.JFLETTERNO, JF.JFNOTARY, JF.JFPLAFOND, JF.JFPLAFONDUSED, JF.JFREVOLVING, dbo.f_getParamGlobalName('REVOLVING', JF.JFREVOLVING) AS JFREVOLVINGNAME, JF.JFCOMMITFEE, JF.JFMINETDEV, JF.JFMAXETDEV, JF.JFDOCRECEIVED, dbo.f_getParamGlobalName('JFDOCRECEIVED', JF.JFDOCRECEIVED) AS JFDOCRECEIVEDNAME, JF.JFINSTALLMENTTYPE, dbo.f_getParamGlobalName('JFINSTALLMENTTYPE', JF.JFINSTALLMENTTYPE) AS JFINSTALLMENTTYPENAME FROM JF WITH (NOLOCK) INNER JOIN JFGROUP WITH (NOLOCK) ON JF.JFGROUPID = JFGROUP.JFGROUPID WHERE (JF.JFID = @JFID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="JFID" QueryStringField="JFID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

