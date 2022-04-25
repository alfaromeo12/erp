<%@ Control Language="VB" AutoEventWireup="false" CodeFile="DataCustomerInfoFromAppID.ascx.vb" Inherits="UserControl_DataCustomerInfoFromAppID" %>
	        <asp:DataList ID="dlCustomer" runat="server" Caption="CUSTOMER INFO" 
        DataSourceID="sdsCustInfo" Width="100%">
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0" style="width:100%;">
                        <tr>
                            <td class="HeaderStyle">
                                APP ID</td>
                            <td class="required">
                                <asp:Label ID="LOCIDLabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("LOCID") %>' />
                                -<asp:Label ID="APPIDLabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("APPID") %>' />
                            </td>
                            <td class="HeaderStyle">
                                CUST ID</td>
                            <td class="required">
                                <asp:Label ID="LOCIDCUSTLabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("LOCIDCUST") %>' />
                                -<asp:Label ID="CUSTIDLabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("CUSTID") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                ACC ID</td>
                            <td>
                                <asp:Label ID="LOCIDLabel0" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("LOCID") %>' />
                                -<asp:Label ID="ACCIDLabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("ACCID") %>' />
                            </td>
                            <td>
                                App. Type</td>
                            <td>
                                (<asp:Label ID="APPTYPELabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("APPTYPE") %>' />)
                                <asp:Label ID="APPTYPENAMELabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("APPTYPENAME") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td class="ShowDetail">
                                Finance Category</td>
                            <td class="ShowDetail">
                                (<asp:Label ID="Label18" runat="server" 
                                    style="font-weight: 700; text-decoration: underline" 
                                    Text='<%# Eval("FINCATCODE") %>'></asp:Label>)
                                <asp:Label ID="Label19" runat="server" 
                                    style="font-weight: 700; text-decoration: underline" 
                                    Text='<%# Eval("FINCATNAME") %>'></asp:Label>
                            </td>
                            <td>
                                Sale Source</td>
                            <td>
                                (<asp:Label ID="Label20" runat="server" 
                                    style="font-weight: 700; text-decoration: underline" 
                                    Text='<%# Eval("SALESOURCE") %>' />)
                                <asp:Label ID="Label21" runat="server" 
                                    style="font-weight: 700; text-decoration: underline" 
                                    Text='<%# Eval("SALESOURCENAME") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="FooterStyle">
                                Area</td>
                            <td class="FooterStyle">
                                (<asp:Label ID="Label6" runat="server" 
                                    style="font-weight: 700; text-decoration: underline" 
                                    Text='<%# Eval("AREACODE") %>'></asp:Label>)
                                <asp:Label ID="Label7" runat="server" 
                                    style="font-weight: 700; text-decoration: underline" 
                                    Text='<%# Eval("AREANAME") %>'></asp:Label>
                            </td>
                            <td class="FooterStyle">
                                Branch</td>
                            <td class="FooterStyle">
                                (<asp:Label ID="Label8" runat="server" 
                                    style="font-weight: 700; text-decoration: underline" 
                                    Text='<%# Eval("BRANCHCODE") %>'></asp:Label>)&nbsp;
                                <asp:Label ID="Label9" runat="server" 
                                    style="font-weight: 700; text-decoration: underline" 
                                    Text='<%# Eval("BRANCHNAME") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="ErrHighLight">
                                Cust Name</td>
                            <td class="ErrHighLight" colspan="3">
                                <asp:Label ID="CUSTNAMELabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("CUSTNAME") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Cust Type</td>
                            <td>
                                (<asp:Label ID="CUSTTYPELabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("CUSTTYPE") %>' />)
                                <asp:Label ID="CUSTTYPENAMELabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("CUSTTYPENAME") %>' />
                                &nbsp;</td>
                            <td>
                                &nbsp;Request Date&nbsp;</td>
                            <td>
                                <asp:Label ID="REQUESTDATELabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("REQUESTDATE", "{0:dd/MM/yyyy}") %>' />
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
            <asp:SqlDataSource ID="sdsCustInfo" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
    SelectCommand="SELECT APPLICATION.REQUESTDATE, APPLICATION.LOCID, APPLICATION.APPID, ACCOUNT.ACCID, CUSTOMER.LOCIDCUST, CUSTOMER.CUSTID, CUSTOMER.CUSTNAME, CUSTOMER.CUSTTYPE, dbo.f_getParamGlobalName('CUSTTYPE', CUSTOMER.CUSTTYPE) AS CUSTTYPENAME, APPLICATION.APPTYPE, dbo.f_getParamGlobalName('APPTYPE', APPLICATION.APPTYPE) AS APPTYPENAME, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME, AREA.AREACODE, AREA.AREANAME, FINANCECATEGORY.FINCATCODE, FINANCECATEGORY.FINCATNAME, ACCOUNT.ACCOUNTNAME, APPLICATION.SALESOURCE, dbo.f_getParamGlobalName('SALESOURCE', APPLICATION.SALESOURCE) AS SALESOURCENAME FROM FINANCECATEGORY WITH (NOLOCK) RIGHT OUTER JOIN CUSTOMER WITH (NOLOCK) INNER JOIN ACCOUNT WITH (NOLOCK) ON CUSTOMER.LOCIDCUST = ACCOUNT.LOCIDCUST AND CUSTOMER.CUSTID = ACCOUNT.CUSTID INNER JOIN APPLICATION WITH (NOLOCK) ON ACCOUNT.LOCID = APPLICATION.LOCID AND ACCOUNT.APPID = APPLICATION.APPID ON FINANCECATEGORY.FINCATID = ACCOUNT.FINCATID LEFT OUTER JOIN AREA WITH (NOLOCK) INNER JOIN BRANCH WITH (NOLOCK) ON AREA.AREAID = BRANCH.AREAID ON ACCOUNT.BRANCHID = BRANCH.BRANCHID WHERE (APPLICATION.LOCID = @LOCID) AND (APPLICATION.APPID = @APPID)">
                <SelectParameters>
                    <asp:Parameter Name="LOCID" />
                    <asp:Parameter Name="APPID" />
                </SelectParameters>
            </asp:SqlDataSource>
        
