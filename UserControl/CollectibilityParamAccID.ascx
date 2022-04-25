<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CollectibilityParamAccID.ascx.vb" Inherits="UserControl_CollectibilityParamAccID" %>
        <asp:DataList ID="dlCollect" runat="server" 
    Caption="COLLECTIBILITY STATUS" DataSourceID="sdsCollect"
            Width="100%">
            <ItemTemplate>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td >
                            Negative Customer</td>
                        <td >
                            <asp:Label ID="Label1" runat="server" 
                                style="font-weight: 700; text-decoration: underline" 
                                Text='<%# Eval("NEGATIVESTSNAME") %>'></asp:Label>
                        </td>
                        <td >
                            Negative Desc</td>
                        <td >
                            <asp:Label ID="Label2" runat="server" 
                                style="font-weight: 700; text-decoration: underline" 
                                Text='<%# Eval("NEGATIVEDESC") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            Collectibility BI</td>
                        <td >
                            <asp:Label ID="COLLECTNAMEBILabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("COLLECTNAMEBI") %>'></asp:Label>
                        </td>
                        <td >
                            Remark</td>
                        <td >
                            <asp:Label ID="COLLECTREMARKBILabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("COLLECTREMARKBI") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="ErrHighLight">
                            Collectibility Internal</td>
                        <td class="ErrHighLight">
                            <asp:Label ID="COLLECTNAMEINTLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("COLLECTNAMEINT") %>'></asp:Label></td>
                        <td class="ErrHighLight">
                            Remark</td>
                        <td class="ErrHighLight">
                            <asp:Label ID="COLLECTREMARKINTLabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("COLLECTREMARKINT") %>'></asp:Label></td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList><asp:SqlDataSource ID="sdsCollect" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            
            
    
    SelectCommand="SELECT ACCOUNT.COLLECTIDBI, ACCOUNT.COLLECTIDINT, COLLECTSTS.COLLECTNAME AS COLLECTNAMEINT, COLLECTSTS.REMARK AS COLLECTREMARKINT, COLLECTSTS_1.COLLECTNAME AS COLLECTNAMEBI, COLLECTSTS_1.REMARK AS COLLECTREMARKBI, CASE WHEN CUSTOMER.NEGATIVESTS = 1 THEN 'YES' ELSE 'NO' END AS NEGATIVESTSNAME, CUSTOMER.NEGATIVEDESC FROM ACCOUNT WITH (NOLOCK) INNER JOIN CUSTOMER WITH (NOLOCK) ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID LEFT OUTER JOIN COLLECTSTS WITH (NOLOCK) ON ACCOUNT.COLLECTIDINT = COLLECTSTS.COLLECTID LEFT OUTER JOIN COLLECTSTS AS COLLECTSTS_1 WITH (NOLOCK) ON ACCOUNT.COLLECTIDBI = COLLECTSTS_1.COLLECTID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.ACCID = @ACCID)">
            <SelectParameters>
                <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
                <asp:Parameter Name="ACCID" />
            </SelectParameters>
        </asp:SqlDataSource>
    
