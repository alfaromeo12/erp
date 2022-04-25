<%@ Control Language="VB" AutoEventWireup="false" CodeFile="AccountJFbyACCIDJF.ascx.vb" Inherits="UserControl_AccountJFbyACCIDJF" %>
         <asp:DataList ID="dlJF" runat="server" Caption="JOIN FINANCE (BANK)" DataKeyField="ACCIDJF"
        DataSourceID="sdsJF" Width="100%">
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
                        <asp:Label ID="JFIDLabel" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("JFID") %>'></asp:Label></td>
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
                        (<asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("JFCODE") %>'></asp:Label>)
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
                        <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("JFACCSTATUSNAME") %>'></asp:Label></td>
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
                    <td>
                        (<asp:Label ID="Label15" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("JFINSTALLMENTTYPE") %>'></asp:Label>)
                        <asp:Label ID="Label16" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("JFINSTALLMENTTYPEname") %>'></asp:Label>
                    </td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
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
                        <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("JFLOANTYPENAME") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        JF Installment</td>
                    <td>
                        <asp:Label ID="JFINSTALLMENTLabel" runat="server" 
                            Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("JFINSTALLMENT", "{0:N}") %>'></asp:Label>
                    </td>
                    <td>
                        </td>
                    <td>
                        <asp:Label ID="Label14" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("JFRESIDUALVALUE", "{0:N}") %>'></asp:Label>
                    </td>
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
                        <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("JFOSPRINCIPAL", "{0:N}") %>'></asp:Label></td>
                    <td class="AlternatingRowStyle">
                        OS Interest</td>
                    <td class="AlternatingRowStyle">
                        <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("JFOSINTEREST", "{0:N}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="4" class="ShowDetail">
                        <input id="btnInst" style="background-position: right; background-image: url(../Images/view.png); cursor: pointer; background-repeat: no-repeat; text-align: left; width:35%" type="button" value="View Installment (JF Code: <%# Eval("JFCODE") %>)" onclick="ViewJFInst(<%# Eval("ACCIDJF") %>)" />
                        <input id="btnPrintLoanJF" style="background-position: right; background-image: url(../Images/view.png); cursor: pointer; background-repeat: no-repeat; text-align: left; width:35%" type="button" value="Print Installment (JF Code: <%# Eval("JFCODE") %>)" onclick="PrintLoanJF(<%# Eval("ACCIDJF") %>)" /></td>
                </tr>
                <tr>
                    <td>
                        JF Installment Start</td>
                    <td>
                        <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("JFINSTALLMENTSTART", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                    <td>
                        JF Installment End</td>
                    <td>
                        <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("JFINSTALLMENTEND", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
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
                        <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("JFADMIN", "{0:N}") %>'></asp:Label></td>
                    <td>
                        JF Provision</td>
                    <td>
                        <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("JFPROVISION", "{0:N}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="FooterStyle" colspan="4">
                        <hr />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="sdsJF" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
             
    SelectCommand="SELECT ACCOUNTJF.ACCIDJF, ACCOUNTJF.JFID, JF.JFCODE, JF.JFNAME, JFGROUP.JFGROUPCODE, JFGROUP.JFGROUPNAME, ACCOUNTJF.JFBOOKINGDATE, ACCOUNTJF.JFACCSTATUS, dbo.f_getParamGlobalName('JFACCSTATUS', ACCOUNTJF.JFACCSTATUS) AS JFACCSTATUSNAME, ACCOUNTJF.JFPRINCIPALTOTAL, ACCOUNTJF.JFTENOR, ACCOUNTJF.JFLOANTYPE, dbo.f_getParamGlobalName('LOANTYPE', ACCOUNTJF.JFLOANTYPE) AS JFLOANTYPENAME, ACCOUNTJF.JFEFFECTIVERATE, ACCOUNTJF.JFINSTALLMENT, ACCOUNTJF.JFCLOSEDATE, ACCOUNTJF.JFCLOSETXNDATE, ACCOUNTJF.JFNEXTDUEDATE, ACCOUNTJF.JFINSTALLMENTDAY, ACCOUNTJF.REFNO, ACCOUNTJF.REQUESTIDACC, ACCOUNTJF.JFSTARTPERIOD, ACCOUNTJFDTL.JFADMIN, ACCOUNTJFDTL.JFPROVISION, ACCOUNTJFDTL.JFINSTALLMENTSTART, ACCOUNTJFDTL.JFINSTALLMENTEND, ACCOUNTJF.JFOSPRINCIPALREAL AS JFOSPRINCIPAL, ACCOUNTJF.JFOSINTERESTREAL AS JFOSINTEREST, ACCOUNTJF.JFRESIDUALVALUE, ACCOUNTJF.JFINSTALLMENTTYPE, dbo.f_getParamGlobalName('JFINSTALLMENTTYPE', ACCOUNTJF.JFINSTALLMENTTYPE) AS JFINSTALLMENTTYPEname FROM ACCOUNTJF WITH (NOLOCK) INNER JOIN JF WITH (NOLOCK) ON ACCOUNTJF.JFID = JF.JFID INNER JOIN JFGROUP WITH (NOLOCK) ON JF.JFGROUPID = JFGROUP.JFGROUPID LEFT OUTER JOIN ACCOUNTJFDTL WITH (NOLOCK) ON ACCOUNTJF.ACCIDJF = ACCOUNTJFDTL.ACCIDJF WHERE (ACCOUNTJF.ACCIDJF = @ACCIDJF)">
        <SelectParameters>
            <asp:Parameter Name="ACCIDJF" />
        </SelectParameters>
    </asp:SqlDataSource>
      
