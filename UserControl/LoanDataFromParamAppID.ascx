<%@ Control Language="VB" AutoEventWireup="false" CodeFile="LoanDataFromParamAppID.ascx.vb" Inherits="UserControl_LoanDataFromParamAppID" %>
	    <style type="text/css">
            .style1
            {
                font-weight: bold;
            }
        </style>
	    <asp:SqlDataSource ID="sdsLoanData" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
    
    
    
    SelectCommand="SELECT APPLICATION.LOCID, APPLICATION.APPID, ACCOUNT.ACCID, ACCOUNT.PRINCIPALTOTAL, ACCOUNT.TENOR, ACCOUNT.LOANTYPE, ACCOUNT.EFFECTIVERATE, ACCOUNT.INSTALLMENT, ACCOUNT.INSTALLMENTDAY, ACCOUNT.DEPOSIT, ACCOUNTDTL.ADMFEE, ACCOUNTDTL.INSTALLMENTSTART, ACCOUNTDTL.INSTALLMENTEND, dbo.f_getCurrentNextDueDateAcc(ACCOUNT.LOCID, ACCOUNT.ACCID, dbo.f_getAppDate()) AS NEXTDUEDATE, ACCOUNT.INTERESTTOTAL, dbo.f_getCurrentOSPrincipalAcc(ACCOUNT.LOCID, ACCOUNT.ACCID, dbo.f_getAppDate()) AS OSPRINCIPALCURRENT, ACCOUNT.OSPRINCIPALREAL, dbo.f_getCurrentOSInterestAcc(ACCOUNT.LOCID, ACCOUNT.ACCID, dbo.f_getAppDate()) AS OSINTERESTCURRENT, ACCOUNT.OSINTERESTREAL, dbo.f_getParamGlobalName('LOANTYPE', ACCOUNT.LOANTYPE) AS LOANTYPENAME, ACCOUNT.BOOKINGDATE, ACCOUNT.FLATRATE, dbo.f_getBranchPenaltyRate(ACCOUNT.BRANCHID, ACCOUNT.FINCATID, ACCOUNT.BOOKINGDATE) AS PENALTYRATE, dbo.f_getBranchGracePeriod(ACCOUNT.BRANCHID, ACCOUNT.FINCATID) AS GRACEPERIOD, dbo.f_getBranchPenaltyType(ACCOUNT.BRANCHID, ACCOUNT.FINCATID, ACCOUNT.BOOKINGDATE) AS PENALTYTYPE, dbo.f_getParamGlobalName('PENALTYTYPE', dbo.f_getBranchPenaltyType(ACCOUNT.BRANCHID, ACCOUNT.FINCATID, ACCOUNT.BOOKINGDATE)) AS PENALTYTYPENAME, dbo.f_getBranchWorkingDays(ACCOUNT.BRANCHID, ACCOUNT.FINCATID) AS WORKINGDAYS, dbo.f_getBranchPaymentType(ACCOUNT.BRANCHID, ACCOUNT.FINCATID) AS PAYMENTTYPE, CAST(dbo.f_getBranchEarlyPayment(ACCOUNT.BRANCHID, ACCOUNT.FINCATID) AS INT) AS EARLYPAYMENT, dbo.f_getParamGlobalName('JFPAYMENTTYPE', dbo.f_getBranchPaymentType(ACCOUNT.BRANCHID, ACCOUNT.FINCATID)) AS PAYMENTTYPENAME, dbo.f_getParamGlobalName('JFEARLYPAYMENT', dbo.f_getBranchEarlyPayment(ACCOUNT.BRANCHID, ACCOUNT.FINCATID)) AS EARLYPAYMENTNAME, ACCOUNT.INSTALLMENTTYPE, ACCOUNT.RESIDUALVALUE, dbo.f_getParamGlobalName('INSTALLMENTTYPE', ACCOUNT.INSTALLMENTTYPE) AS INSTALLMENTTYPENAME, ISNULL(PACKET.PACKETCODE, 'NO PACKET') AS PACKETCODE, PACKET.PACKETNAME, FINANCECATEGORY.FINCATCODE, FINANCECATEGORY.FINCATNAME, dbo.f_getTermPrincipal(ACCOUNT.FINCATID) AS CATPRINCIPAL, dbo.f_getTermEffective(ACCOUNT.FINCATID) AS CATEFFRATE, dbo.f_getTermInterest(ACCOUNT.FINCATID) AS CATINTEREST, CURRENCY.CURRENCYCODE, CURRENCY.CURRENCYNAME, dbo.f_getCurrencyDecPointForNet(ACCOUNT.CURRENCYID) AS DECPOINT, ACCOUNT.INSTALLMENTREAL, dbo.f_getTermPenalty(ACCOUNT.FINCATID) AS CATPENALTY FROM ACCOUNT WITH (NOLOCK) INNER JOIN APPLICATION WITH (NOLOCK) ON ACCOUNT.LOCID = APPLICATION.LOCID AND ACCOUNT.APPID = APPLICATION.APPID INNER JOIN ACCOUNTDTL WITH (NOLOCK) ON ACCOUNT.LOCID = ACCOUNTDTL.LOCID AND ACCOUNT.ACCID = ACCOUNTDTL.ACCID INNER JOIN BRANCH WITH (NOLOCK) ON ACCOUNT.BRANCHID = BRANCH.BRANCHID LEFT OUTER JOIN CURRENCY WITH (NOLOCK) ON ACCOUNT.CURRENCYID = CURRENCY.CURRENCYID LEFT OUTER JOIN FINANCECATEGORY WITH (NOLOCK) ON ACCOUNT.FINCATID = FINANCECATEGORY.FINCATID LEFT OUTER JOIN PACKET WITH (NOLOCK) ON ACCOUNT.PACKETID = PACKET.PACKETID WHERE (APPLICATION.LOCID = @LOCID) AND (APPLICATION.APPID = @APPID)">
            <SelectParameters>
                <asp:Parameter Name="LOCID" />
                <asp:Parameter Name="APPID" />
            </SelectParameters>
        </asp:SqlDataSource>
    

        <asp:DataList ID="dlLoanData" runat="server"  
            Caption="LOAN DATA" DataSourceID="sdsLoanData" Width="100%">
            <ItemTemplate>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td class="ShowDetail" >
                            Currency</td>
                        <td style="margin-left: 120px" class="required" colspan="3" >
                            (<asp:Label ID="Label50" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CURRENCYCODE") %>' CssClass="style1"></asp:Label>)
                            <asp:Label ID="Label51" runat="server" Font-Underline="True" 
                                Text='<%# Eval("CURRENCYNAME") %>' CssClass="style1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="ShowDetail">
                            Installment Type</td>
                        <td style="margin-left: 120px" class="ErrHighLight">
                            (<asp:Label ID="Label20" runat="server" Font-Underline="True" 
                                Text='<%# Eval("INSTALLMENTTYPE") %>' style="font-weight: 700"></asp:Label>)
                            <asp:Label ID="Label47" runat="server" Font-Underline="True" 
                                Text='<%# Eval("INSTALLMENTTYPENAME") %>' style="font-weight: 700"></asp:Label>
                        </td>
                        <td class="ShowDetail">
                            Financing Category</td>
                        <td class="ErrHighLight">
                            (<asp:Label ID="Label48" runat="server" Font-Underline="True" 
                                Text='<%# Eval("FINCATCODE") %>' style="font-weight: 700"></asp:Label>)
                            <asp:Label ID="Label49" runat="server" Font-Underline="True" 
                                Text='<%# Eval("FINCATNAME") %>' CssClass="style1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            Booking Date</td>
                        <td >
                            <asp:Label ID="Label1" runat="server" Font-Underline="True" 
                                Text='<%# Eval("BOOKINGDATE", "{0:dd/MM/yyyy}") %>' CssClass="style1"></asp:Label></td>
                        <td >Packet
                        </td>
                        <td >(<asp:Label ID="Label14" runat="server" Font-Underline="True" 
                                Text='<%# Eval("PACKETCODE") %>' CssClass="style1"></asp:Label>)
                            <asp:Label ID="Label46" runat="server" Font-Underline="True" 
                                Text='<%# Eval("PACKETNAME") %>' CssClass="style1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            Total 
                            <asp:Label ID="lblPrincipal" runat="server" 
                                Text='<%# Eval("CATPRINCIPAL") %>'></asp:Label>
                            </td>
                        <td>
                            <asp:Label ID="Label11" runat="server" Font-Underline="True" 
                                Text='<%# Eval("PRINCIPALTOTAL", Eval("DECPOINT")) %>' CssClass="style1"></asp:Label></td>
                        <td >
                            Total 
                            <asp:Label ID="lblInterest" runat="server" 
                                Text='<%# Eval("CATINTEREST") %>'></asp:Label></td>
                        <td >
                            <asp:Label ID="Label15" runat="server" Font-Underline="True" 
                                Text='<%# Eval("INTERESTTOTAL", Eval("DECPOINT")) %>' CssClass="style1"></asp:Label></td>
                    </tr>
                    <tr>
                        <td >
                            Tenor</td>
                        <td>
                            <asp:Label ID="Label18" runat="server" Font-Underline="True" 
                                Text='<%# Eval("TENOR") %>' CssClass="style1"></asp:Label></td>
                        <td >
                            Loan&nbsp; Type</td>
                        <td >
                            (<asp:Label ID="Label21" runat="server" Font-Underline="True" 
                                Text='<%# Eval("LOANTYPE") %>' CssClass="style1"></asp:Label>)
                            <asp:Label ID="Label34" runat="server" Font-Underline="True" 
                                Text='<%# Eval("LOANTYPENAME") %>' CssClass="style1"></asp:Label></td>
                    </tr>
                    <tr>
                        <td >
                            <asp:Label ID="lblEffRate" runat="server" Text='<%# Eval("CATEFFRATE") %>'></asp:Label>
                            &nbsp;Rate</td>
                        <td>
                            <asp:Label ID="Label22" runat="server" Font-Underline="True" 
                                Text='<%# Eval("EFFECTIVERATE") %>' CssClass="style1"></asp:Label>
                            %</td>
                        <td >
                            Flat Rate</td>
                        <td >
                            <asp:Label ID="Label3" runat="server" Font-Underline="True" 
                                Text='<%# Eval("FLATRATE") %>' CssClass="style1"></asp:Label>
                            %</td>
                    </tr>
                    <tr>
                        <td >
                            Installment</td>
                        <td>
                            <asp:Label ID="Label24" runat="server" Font-Underline="True" 
                                Text='<%# Eval("INSTALLMENT", Eval("DECPOINT")) %>' CssClass="style1"></asp:Label></td>
                        <td >Installment Real</td>
                        <td >
                            <asp:Label ID="Label52" runat="server" Font-Underline="True" 
                                Text='<%# Eval("INSTALLMENTREAL", Eval("DECPOINT")) %>' CssClass="style1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Residual Value
                        </td>
                        <td>
                            <asp:Label ID="Label29" runat="server" Font-Underline="True" 
                                Text='<%# Eval("RESIDUALVALUE", Eval("DECPOINT")) %>' CssClass="style1"></asp:Label>
                        </td>
                        <td>
                            Deposit</td>
                        <td>
                            <asp:Label ID="Label27" runat="server" Font-Underline="True" 
                                Text='<%# Eval("DEPOSIT", Eval("DECPOINT")) %>' CssClass="style1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            Installment Start</td>
                        <td>
                            <asp:Label ID="Label23" runat="server" Font-Underline="True" 
                                Text='<%# Eval("INSTALLMENTSTART", "{0:dd/MM/yyyy}") %>' CssClass="style1"></asp:Label></td>
                        <td >
                            Installment End</td>
                        <td >
                            <asp:Label ID="Label25" runat="server" Font-Underline="True" 
                                Text='<%# Eval("INSTALLMENTEND", "{0:dd/MM/yyyy}") %>' CssClass="style1"></asp:Label></td>
                    </tr>
                    <tr>
                        <td >
                            Installment Day</td>
                        <td>
                            <asp:Label ID="Label28" runat="server" Font-Underline="True" 
                                Text='<%# Eval("INSTALLMENTDAY") %>' CssClass="style1"></asp:Label></td>
                        <td >
                            Next Due Date</td>
                        <td >
                            <asp:Label ID="Label26" runat="server" Font-Underline="True" 
                                Text='<%# Eval("NEXTDUEDATE", "{0:dd/MM/yyyy}") %>' CssClass="style1"></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            Outstanding Current</td>
                        <td colspan="3" class="FooterStyle">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            OS
                            <asp:Label ID="lblOSPrin" runat="server" Text='<%# Eval("CATPRINCIPAL") %>'></asp:Label></td>
                        <td>
                            <asp:Label ID="Label30" runat="server" Font-Underline="True" 
                                Text='<%# Eval("OSPRINCIPALCURRENT", Eval("DECPOINT")) %>' 
                                CssClass="style1"></asp:Label></td>
                        <td>
                            OS
                            <asp:Label ID="lblOSInt" runat="server" Text='<%# Eval("CATINTEREST") %>'></asp:Label></td>
                        <td>
                            <asp:Label ID="Label33" runat="server" Font-Underline="True" 
                                Text='<%# Eval("OSINTERESTCURRENT",Eval("DECPOINT")) %>' CssClass="style1"></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            Outstanding Real</td>
                        <td colspan="3" class="FooterStyle">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td >
                            OS
                            <asp:Label ID="lblOSPrinc0" runat="server" Text='<%# Eval("CATPRINCIPAL") %>'></asp:Label></td>
                        <td >
                            <asp:Label ID="Label32" runat="server" Font-Underline="True" 
                                Text='<%# Eval("OSPRINCIPALREAL", Eval("DECPOINT")) %>' CssClass="style1"></asp:Label></td>
                        <td >
                            OS
                            <asp:Label ID="lblOSInt0" runat="server" Text='<%# Eval("CATINTEREST") %>'></asp:Label></td>
                        <td >
                            <asp:Label ID="Label31" runat="server" Font-Underline="True" 
                                Text='<%# Eval("OSINTERESTREAL", Eval("DECPOINT")) %>' CssClass="style1"></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            <asp:Label ID="lblPenalty" runat="server" Text='<%# Eval("CATPENALTY") %>'></asp:Label>
                            &nbsp;&amp; Payment Parameter</td>
                        <td colspan="3"  class="FooterStyle">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <asp:Label ID="lblPenalty0" runat="server" Text='<%# Eval("CATPENALTY") %>'></asp:Label>
                            &nbsp;Rate</td>
                        <td >
                            <asp:Label ID="Label37" runat="server" Font-Underline="True" 
                                Text='<%# Eval("PENALTYRATE") %>'></asp:Label>
                            </td>
                        <td >
                            <asp:Label ID="lblPenalty1" runat="server" Text='<%# Eval("CATPENALTY") %>'></asp:Label>
                            &nbsp;Type</td>
                        <td >
                            (<asp:Label ID="Label40" runat="server" Font-Underline="True" 
                                Text='<%# Eval("PENALTYTYPE") %>' CssClass="style1"></asp:Label>)
                            <asp:Label ID="Label41" runat="server" Font-Underline="True" 
                                Text='<%# Eval("PENALTYTYPENAME") %>' CssClass="style1"></asp:Label>
                            </td>
                    </tr>
                    <tr>
                        <td >
                            Working Days</td>
                        <td >
                            <asp:Label ID="Label38" runat="server" Font-Underline="True" 
                                Text='<%# Eval("WORKINGDAYS") %>'></asp:Label>
                            day(s)/week</td>
                        <td >
                            Grace Period</td>
                        <td >
                            <asp:Label ID="Label39" runat="server" Font-Underline="True" 
                                Text='<%# Eval("GRACEPERIOD") %>' CssClass="style1"></asp:Label>
                            day(s)</td>
                    </tr>
                    <tr>
                        <td >
                            Payment Type</td>
                        <td >
                            (<asp:Label ID="Label42" runat="server" Font-Underline="True" 
                                Text='<%# Eval("PAYMENTTYPE") %>'></asp:Label>)
                            <asp:Label ID="Label43" runat="server" Font-Underline="True" 
                                Text='<%# Eval("PAYMENTTYPENAME") %>'></asp:Label>
                        </td>
                        <td >
                            Early Payment</td>
                        <td >
                            (<asp:Label ID="Label44" runat="server" Font-Underline="True" 
                                Text='<%# Eval("EARLYPAYMENT") %>' CssClass="style1"></asp:Label>)
                            <asp:Label ID="Label45" runat="server" Font-Underline="True" 
                                Text='<%# Eval("EARLYPAYMENTNAME") %>' CssClass="style1"></asp:Label>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
        
