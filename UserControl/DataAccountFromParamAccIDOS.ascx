<%@ Control Language="VB" AutoEventWireup="false" CodeFile="DataAccountFromParamAccIDOS.ascx.vb" Inherits="UserControl_DataAccountFromParamAccIDOS" %>
	<asp:Panel ID="pnlAccData" runat="server" CssClass="FooterStyle" 
Width="100%">
        <asp:DataList ID="dlAppID" runat="server" BorderStyle="Double" 
        Caption="APP ID  - CUST ID - ACC ID" DataSourceID="sdsAppID" 
    Width="100%">
            <ItemTemplate>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td width="25%" class="ShowDetail">
                            APP ID</td>
                        <td width="25%" class="required">
                            <asp:Label ID="lblLocID" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("LOCID") %>'></asp:Label>
                            -<asp:Label ID="lblAppID" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("APPID") %>'></asp:Label>
                            (Application ID)</td>
                        <td width="25%" class="ShowDetail">
                            ACC ID</td>
                        <td style="width: 25%" class="required">
                            <asp:Label ID="lblLocID0" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("LOCID") %>'></asp:Label>
                            -<asp:Label ID="lblAccID" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("ACCID") %>'></asp:Label>
                            (Account ID)</td>
                    </tr>
                    <tr>
                        <td width="25%" class="ShowDetail">
                            CUST ID</td>
                        <td width="25%" class="required">
                            <asp:Label ID="Label21" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("LOCIDCUST") %>'></asp:Label>
                            -<asp:Label ID="lblCustID" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("CUSTID") %>'></asp:Label>
                            (Customer ID)</td>
                        <td width="25%">
                            Ref. No.</td>
                        <td style="width: 25%">
                            <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("REFNO") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%">
                            Cust No.</td>
                        <td width="25%">
                            <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CUSTNO") %>'></asp:Label>
                        </td>
                        <td width="25%">
                            Account No.</td>
                        <td style="width: 25%">
                            <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("ACCOUNTNO") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%" class="ErrHighLight">
                            Cust No. (formated)</td>
                        <td width="25%" class="ErrHighLight">
                            <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CUSTNOFORMAT") %>'></asp:Label>
                        </td>
                        <td width="25%" class="ErrHighLight">
                            Account No. (formated)</td>
                        <td style="width: 25%" class="ErrHighLight">
                            <a href="#" 
                            onclick='ViewDetailAcc(<%# eval("LOCID") %>, <%# eval("APPID") %>)'>
                            <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("ACCOUNTNOFORMAT") %>'></asp:Label>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%">
                            Cust Type</td>
                        <td width="25%">
                            (<asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CUSTTYPE") %>'></asp:Label>)
                            <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CUSTYPENAME") %>'></asp:Label>
                        </td>
                        <td width="25%">
                            Booking Date</td>
                        <td style="width: 25%">
                            <asp:Label ID="Label16" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("BOOKINGDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%">
                            Cust Name</td>
                        <td>
                            <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CUSTNAME") %>'></asp:Label>
                        </td>
                        <td>
                            Account Name</td>
                        <td>
                            <asp:Label ID="Label24" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("ACCOUNTNAME") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%">
                            Address</td>
                        <td colspan="3">
                            <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CUSTADDRESS") %>'></asp:Label>,
                            <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CUSTCITY") %>'></asp:Label>
                            <asp:Label ID="Label10" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CUSTZIP") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%">
                            ID Number</td>
                        <td width="25%" colspan="3">
                            <asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("IDNUMBER") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%">
                            Sale Source</td>
                        <td width="25%" style="width: -25%">
                            (<asp:Label ID="Label22" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("SALESOURCE") %>'></asp:Label>)
                            <asp:Label ID="Label23" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("SALESOURCENAME") %>'></asp:Label>
                        </td>
                        <td class="ShowDetail" width="25%">
                            Finance Category</td>
                        <td class="ShowDetail" width="25%">
                            (<asp:Label ID="Label19" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("FINCATCODE") %>'></asp:Label>)
                            <asp:Label ID="Label20" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("FINCATNAME") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="ShowDetail" width="25%">
                            Outstanding</td>
                        <td class="HeaderStyle" colspan="3" width="25%">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td class="ErrHighLight" width="25%">
                            OS
                            <asp:Label ID="lblPrincipal" runat="server" Text='<%# Eval("CATPRINCIPAL") %>'></asp:Label>
                        </td>
                        <td class="ErrHighLight" width="25%">
                            <asp:Label ID="Label17" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("OSPRINCIPAL", "{0:N}") %>'></asp:Label>
                        </td>
                        <td class="ErrHighLight" width="25%">
                            OS
                            <asp:Label ID="lblOSInterest" runat="server" Text='<%# Eval("CATINTEREST") %>'></asp:Label>
                        </td>
                        <td class="ErrHighLight" style="width: 25%">
                            <asp:Label ID="lblInterest" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("OSINTEREST", "{0:N}") %>'></asp:Label>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
        <asp:SqlDataSource ID="sdsAppID" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        
    
            
            
            SelectCommand="SELECT ACCOUNT.LOCID, ACCOUNT.ACCID, APPLICATION.APPID, CUSTOMER.CUSTID, dbo.f_FormatCustNoByID(CUSTOMER.BRANCHID, CUSTOMER.CUSTNO) AS CUSTNOFORMAT, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCOUNTNOFORMAT, ACCOUNT.ACCOUNTNO, CUSTOMER.CUSTNO, APPLICATION.ROWLOCK, CUSTOMER.CUSTTYPE, dbo.f_getParamGlobalName('CUSTTYPE', CUSTOMER.CUSTTYPE) AS CUSTYPENAME, CUSTOMER.CUSTADDRESS, CUSTOMER.CUSTCITY, CUSTOMER.CUSTZIP, CUSTOMER.IDNUMBER, ACCOUNT.BOOKINGDATE, ACCOUNT.ACCOUNTNAME, ACCOUNT.REFNO, ACCOUNT.OSINTERESTREAL AS OSINTEREST, ACCOUNT.OSPRINCIPALREAL AS OSPRINCIPAL, FINANCECATEGORY.FINCATCODE, FINANCECATEGORY.FINCATNAME, CUSTOMER.LOCIDCUST, CUSTOMER.CUSTNAME, APPLICATION.SALESOURCE, dbo.f_getParamGlobalName('SALESOURCE', APPLICATION.SALESOURCE) AS SALESOURCENAME, dbo.f_getTermPrincipal(ACCOUNT.FINCATID) AS CATPRINCIPAL, dbo.f_getTermInterest(ACCOUNT.FINCATID) AS CATINTEREST, dbo.f_getTermEffective(ACCOUNT.FINCATID) AS CATEFFECTIVE FROM ACCOUNT WITH (NOLOCK) INNER JOIN APPLICATION WITH (NOLOCK) ON ACCOUNT.LOCID = APPLICATION.LOCID AND ACCOUNT.APPID = APPLICATION.APPID INNER JOIN CUSTOMER WITH (NOLOCK) ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID LEFT OUTER JOIN FINANCECATEGORY WITH (NOLOCK) ON ACCOUNT.FINCATID = FINANCECATEGORY.FINCATID LEFT OUTER JOIN BRANCH WITH (NOLOCK) ON ACCOUNT.BRANCHID = BRANCH.BRANCHID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.ACCID = @ACCID)">
            <SelectParameters>
                <asp:Parameter Name="LOCID" />
                <asp:Parameter Name="ACCID" />
            </SelectParameters>
        </asp:SqlDataSource>
		</asp:Panel>
		
	