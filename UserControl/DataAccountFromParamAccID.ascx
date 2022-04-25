<%@ Control Language="VB" AutoEventWireup="false" CodeFile="DataAccountFromParamAccID.ascx.vb" Inherits="UserControl_DataAccountFromParamAccID" %>
		    <asp:DataList ID="dlAppID" runat="server" Caption="ACCOUNT DATA" DataSourceID="sdsAccData" Width="100%">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="25%" class="ShowDetail">
                        APP ID</td>
                    <td width="25%" class="required">
                        <asp:Label ID="lblLocID" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("LOCID") %>'></asp:Label>
                        &nbsp;- 
                        <asp:Label ID="lblAppID" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("APPID") %>'></asp:Label>
                        (Application ID)</td>
                    <td width="25%" class="ShowDetail">
                        ACC ID</td>
                    <td style="width: 25%" class="required">
                        <asp:Label ID="lblLocID0" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("LOCID") %>'></asp:Label>
                        &nbsp;- 
                        <asp:Label ID="lblAccID" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("ACCID") %>'></asp:Label>
                        (Account ID)</td>
                </tr>
                <tr>
                    <td width="25%" class="ShowDetail">
                        CUST ID</td>
                    <td width="25%" class="required">
                        <asp:Label ID="Label21" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("LOCIDCUST") %>'></asp:Label>
                        &nbsp;- 
                        <asp:Label ID="lblCustID" runat="server" Font-Bold="True" 
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
                        Finance Category</td>
                    <td width="25%">
                        (<asp:Label ID="Label25" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("FINCATCODE") %>'></asp:Label>)
                        <asp:Label ID="Label26" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("FINCATNAME") %>'></asp:Label>
                    </td>
                    <td width="25%">
                        Account Currency</td>
                    <td style="width: 25%">
                        (<asp:Label ID="Label27" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CURRENCYCODE") %>'></asp:Label>)
                        <asp:Label ID="Label28" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CURRENCYNAME") %>'></asp:Label>
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
                            Text='<%# Eval("CUSTNOFORMAT") %>'></asp:Label></td>
                    <td width="25%" class="ErrHighLight">
                        Account No. (formated)</td>
                    <td style="width: 25%" class="ErrHighLight">
                        <a href="#" 
                            onclick='ViewDetailAcc(<%# eval("LOCID") %>, <%# eval("APPID") %>)'>
                        <asp:Label ID="lblAccountNo" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("ACCOUNTNOFORMAT") %>'></asp:Label></a></td>
                </tr>
                <tr>
                    <td width="25%">
                        Cust Type</td>
                    <td width="25%">
                        (<asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CUSTTYPE") %>'></asp:Label>)
                        <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CUSTYPENAME") %>'></asp:Label></td>
                    <td width="25%">
                        Booking Date</td>
                    <td style="width: 25%">
                        <asp:Label ID="Label16" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("BOOKINGDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td width="25%">
                        Cust Name</td>
                    <td>
                        <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CUSTNAME") %>'></asp:Label></td>
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
                    <td>
                        <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CUSTADDRESS") %>'></asp:Label>,
                        <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CUSTCITY") %>'></asp:Label>
                        <asp:Label ID="Label10" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CUSTZIP") %>'></asp:Label></td>
                    <td>
						Area</td>
					<td>
						(<asp:Label ID="Label12" runat="server" Font-Underline="True" 
                            Text='<%# Eval("AREACODE") %>' style="font-weight: 700"></asp:Label>)
						<asp:Label ID="Label14" runat="server" Font-Underline="True" 
                            Text='<%# Eval("AREANAME") %>' style="font-weight: 700"></asp:Label></td>
                </tr>
                <tr>
                    <td width="25%">
                        ID Number</td>
                    <td width="25%">
                        <asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("IDNUMBER") %>'></asp:Label></td>
                    <td>
					    Branch</td>
					<td>
						(<asp:Label ID="Label17" runat="server" Font-Underline="True" 
                            Text='<%# Eval("BRANCHCODE") %>' style="font-weight: 700"></asp:Label>)
						<asp:Label ID="Label19" runat="server" Font-Underline="True" 
                            Text='<%# Eval("BRANCHNAME") %>' style="font-weight: 700"></asp:Label></td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
            <asp:SqlDataSource ID="sdsAccData" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
			
            
                
                
                
    
    SelectCommand="SELECT APPLICATION.LOCID, APPLICATION.APPID, ACCOUNT.ACCID, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME, AREA.AREACODE, AREA.AREANAME, ACCOUNT.BOOKINGDATE, ACCOUNT.INSTALLMENTDAY, APPLICATION.APPSTATE, APPLICATION.REQUESTDATE, APPLICATION.STATUSDATE, ACCOUNT.CUSTID, ACCOUNT.CLOSEDATE, ACCOUNT.CLOSETXNDATE, ACCOUNT.ACCOUNTNAME, dbo.f_getParamGlobalName('ACCSTATUS', ACCOUNT.ACCSTATUS) AS ACCSTATUSNAME, ACCOUNT.ACCSTATUS, ACCOUNT.REFNO, ACCOUNT.ACCOUNTNO, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCOUNTNOFORMAT, ACCOUNT.LOCIDCUST, CUSTOMER.CUSTNO, dbo.f_FormatCustNoByID(CUSTOMER.BRANCHID, CUSTOMER.CUSTNO) AS CUSTNOFORMAT, CUSTOMER.CUSTTYPE, dbo.f_getParamGlobalName('CUSTTYPE', CUSTOMER.CUSTTYPE) AS CUSTYPENAME, CUSTOMER.CUSTADDRESS, CUSTOMER.CUSTCITY, CUSTOMER.CUSTZIP, CUSTOMER.IDNUMBER, CUSTOMER.CUSTNAME, CURRENCY.CURRENCYCODE, CURRENCY.CURRENCYNAME, FINANCECATEGORY.FINCATCODE, FINANCECATEGORY.FINCATNAME FROM APPLICATION WITH (NOLOCK) RIGHT OUTER JOIN ACCOUNT WITH (NOLOCK) LEFT OUTER JOIN AREA WITH (NOLOCK) INNER JOIN BRANCH WITH (NOLOCK) ON AREA.AREAID = BRANCH.AREAID ON ACCOUNT.BRANCHID = BRANCH.BRANCHID ON APPLICATION.LOCID = ACCOUNT.LOCID AND APPLICATION.APPID = ACCOUNT.APPID INNER JOIN CUSTOMER WITH (NOLOCK) ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID LEFT OUTER JOIN CURRENCY WITH (nolock) ON ACCOUNT.CURRENCYID = CURRENCY.CURRENCYID LEFT OUTER JOIN FINANCECATEGORY WITH (nolock) ON ACCOUNT.FINCATID = FINANCECATEGORY.FINCATID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.ACCID = @ACCID)">
			<SelectParameters>
                    <asp:Parameter Name="LOCID" />
                    <asp:Parameter Name="ACCID" />
                </SelectParameters>
            </asp:SqlDataSource>
		
		
	